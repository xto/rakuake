module Rakuake
  def self.new_session(name, work_directory)
    add_session
    rename_session(last_session, name)
    run_command("cd #{work_directory}")
    lock_session(last_session)
  end

  def self.add_session
    `qdbus org.kde.yakuake /yakuake/sessions addSession > /dev/null`
  end

  def self.sessions_list
    `qdbus org.kde.yakuake /yakuake/sessions sessionIdList`.chomp.split(',')
  end

  def self.last_session
    sessions_list[-1]
  end

  def self.rename_session(session_id, new_name)
    `qdbus org.kde.yakuake /yakuake/tabs setTabTitle #{session_id} #{new_name}`
  end

  def self.run_command(command)
   `qdbus org.kde.yakuake /yakuake/sessions runCommand "#{command}"`
  end

  def self.lock_session(session_id)
   `qdbus org.kde.yakuake /yakuake/sessions setSessionClosable #{session_id} false`
  end
end


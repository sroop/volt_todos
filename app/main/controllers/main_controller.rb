# By default Volt generates this controller for your Main component
class MainController < Volt::ModelController
  model :store

  def index
    new
  end

  def new
    page._new_todo = _todos.buffer
  end

  def add_todo
    page._new_todo.save!.then do
      new
      flash._successes << "Your todo has been saved"
    end
  end

  def remove_todo(todo)
    _todos.delete(todo)
  end

  def current_todo
    _todos[params._index.or(0).to_i]
  end

  def check_all
    _todos.each { |todo| todo._completed = true }
  end

  def incomplete
    _todos.size - completed
  end

  def completed
    _todos.count { |todo| todo._completed }
  end

  private

  # The main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end

  # Determine if the current nav component is the active one by looking
  # at the first part of the url against the href attribute.
  def active_tab?
    url.path.split('/')[1] == attrs.href.split('/')[1]
  end
end

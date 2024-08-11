import mist
import gleam/erlang/process
import gleam/bytes_builder
import gleam/http/response.{Response}
import gleam/erlang/os
import gleam/int

pub fn get_port() -> Int {
  case os.get_env("PORT") {
    Ok(value) -> case int.parse(value) {
      Error(e) -> 8080
      Ok(i) -> i
    }
    Error(_) -> 8080  // If the environment variable is not set, fallback to 8080
  }
}

pub fn main() {
  let assert Ok(_) =
    web_service
    |> mist.new
    |> mist.port(get_port())
    |> mist.start_http
  process.sleep_forever()
}

fn web_service(_request) {
  let body =
    bytes_builder.from_string(
      "Hello! This is a web app built with Gleam and deployed on Zeabur!",
    )
  Response(200, [], mist.Bytes(body))
}

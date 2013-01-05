-- type definition

CREATE TYPE bson;

CREATE FUNCTION bson_in(cstring) RETURNS bson
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION bson_out(bson) RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE bson (
    input = bson_in,
    output = bson_out,
    alignment = int4,
    storage = main
);

-- other

CREATE FUNCTION pgbson_version() RETURNS text
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

------------------------------
-- deep object inspection functions
------------------------------

-- returns (dotted) field value converted to text. Works only on scalar types: string, numbers, Oid, date
-- returns null if no such field
-- fails if conversion is impossible
CREATE FUNCTION bson_get_text(bson, text) RETURNS text
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

-- returns (dotted) field as bson object.
-- scalars are returned as bson objects with single, anonymous field.
-- returns null if no such field
CREATE FUNCTION bson_get_as_bson(bson, text) RETURNS bson
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;


--------------------------
-- conversion to/from bson
--------------------------

-- converts row to bson, very much like row_to_json
CREATE FUNCTION row_to_bson(record) RETURNS bson
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

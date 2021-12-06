Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614574697E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbhLFOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbhLFOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315EC0611F7;
        Mon,  6 Dec 2021 06:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B298612CA;
        Mon,  6 Dec 2021 14:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE27CC341C1;
        Mon,  6 Dec 2021 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799561;
        bh=glnmWi0P2+TiWbTf168jLa41fS71yNheSSKlkdhXKzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buLAdUyojHfLQTX+QcmVvwojdSANWltNOVkAzIuOsotK7lu0UNH7YkCKKs6cFKIqi
         5yxSQgup8EoYh4EqskZOTK0BtmSx78X1O8V+mZPZCo0KhIsQUpGwAMdPUr2fuQqNEv
         hHtrTs+S2eVWRCp7TX4mw9evuVn1ldnMI/PduAHqqhL7Ffzw0djVCtMyOfPbXQhrph
         lBjBAMQlGzefOnp6+dU5W+bF7iegRiCB53jKkAYkbJAO98pUAY8/H2qhPu4MD5wh+0
         +QOB/pZW5sBEq4Kluxk+2InEf6I2FvNdg/S/DUWEzgU7LFVBtjpONx/T4X0wzZoIqd
         wCaGcIvJymI7Q==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>
Subject: [PATCH 12/19] scripts: add `generate_rust_analyzer.py`
Date:   Mon,  6 Dec 2021 15:03:06 +0100
Message-Id: <20211206140313.5653-13-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `generate_rust_analyzer.py` script generates the configuration
file (`rust-project.json`) for rust-analyzer.

rust-analyzer is a modular compiler frontend for the Rust language.
It provides an LSP server which can be used in editors such as
VS Code, Emacs or Vim.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/generate_rust_analyzer.py | 133 ++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100755 scripts/generate_rust_analyzer.py

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
new file mode 100755
index 000000000000..024f8b884c1b
--- /dev/null
+++ b/scripts/generate_rust_analyzer.py
@@ -0,0 +1,133 @@
+#!/usr/bin/env python3
+"""generate_rust_analyzer - Generates the `rust-project.json` file for `rust-analyzer`.
+"""
+
+import argparse
+import json
+import logging
+import pathlib
+import sys
+
+def generate_crates(srctree, objtree, sysroot_src):
+    # Generate the configuration list.
+    cfg = []
+    with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
+        for line in fd:
+            line = line.replace("--cfg=", "")
+            line = line.replace("\n", "")
+            cfg.append(line)
+
+    # Now fill the crates list -- dependencies need to come first.
+    #
+    # Avoid O(n^2) iterations by keeping a map of indexes.
+    crates = []
+    crates_indexes = {}
+
+    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
+        crates_indexes[display_name] = len(crates)
+        crates.append({
+            "display_name": display_name,
+            "root_module": str(root_module),
+            "is_workspace_member": is_workspace_member,
+            "is_proc_macro": is_proc_macro,
+            "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
+            "cfg": cfg,
+            "edition": "2021",
+            "env": {
+                "RUST_MODFILE": "This is only for rust-analyzer"
+            }
+        })
+
+    # First, the ones in `rust/` since they are a bit special.
+    append_crate(
+        "core",
+        sysroot_src / "core" / "src" / "lib.rs",
+        [],
+        is_workspace_member=False,
+    )
+
+    append_crate(
+        "compiler_builtins",
+        srctree / "rust" / "compiler_builtins.rs",
+        [],
+    )
+
+    append_crate(
+        "alloc",
+        srctree / "rust" / "alloc" / "lib.rs",
+        ["core", "compiler_builtins"],
+    )
+
+    append_crate(
+        "macros",
+        srctree / "rust" / "macros" / "lib.rs",
+        [],
+        is_proc_macro=True,
+    )
+    crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
+
+    append_crate(
+        "build_error",
+        srctree / "rust" / "build_error.rs",
+        ["core", "compiler_builtins"],
+    )
+
+    append_crate(
+        "kernel",
+        srctree / "rust" / "kernel" / "lib.rs",
+        ["core", "alloc", "macros", "build_error"],
+        cfg=cfg,
+    )
+    crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))
+    crates[-1]["source"] = {
+        "include_dirs": [
+            str(srctree / "rust" / "kernel"),
+            str(objtree / "rust")
+        ],
+        "exclude_dirs": [],
+    }
+
+    # Then, the rest outside of `rust/`.
+    #
+    # We explicitly mention the top-level folders we want to cover.
+    for folder in ("samples", "drivers"):
+        for path in (srctree / folder).rglob("*.rs"):
+            logging.info("Checking %s", path)
+            name = path.name.replace(".rs", "")
+
+            # Skip those that are not crate roots.
+            if f"{name}.o" not in open(path.parent / "Makefile").read():
+                continue
+
+            logging.info("Adding %s", name)
+            append_crate(
+                name,
+                path,
+                ["core", "alloc", "kernel"],
+                cfg=cfg,
+            )
+
+    return crates
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--verbose', '-v', action='store_true')
+    parser.add_argument("srctree", type=pathlib.Path)
+    parser.add_argument("objtree", type=pathlib.Path)
+    parser.add_argument("sysroot_src", type=pathlib.Path)
+    args = parser.parse_args()
+
+    logging.basicConfig(
+        format="[%(asctime)s] [%(levelname)s] %(message)s",
+        level=logging.INFO if args.verbose else logging.WARNING
+    )
+
+    rust_project = {
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
+        "sysroot_src": str(args.sysroot_src),
+    }
+
+    json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)
+
+if __name__ == "__main__":
+    main()
-- 
2.34.0


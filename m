Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FEF49017E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiAQFfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:35:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47350 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiAQFer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:34:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4CADB80DD8;
        Mon, 17 Jan 2022 05:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FD1C36B14;
        Mon, 17 Jan 2022 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642397684;
        bh=oa9FNB41676lfqsBRhlRDgcEEZCS+hdwRnGPIGNZSVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mq9M4QyYPBT92yC/5T5R7F2qJ+yB7MlCPhpVc2wgNpduiFz7+UZbMDOwWG7/eGkii
         sJWVmNsqVzecz7Y7yEl7oghR6kzwANouiDjzw0YUhncB7UkNBQgf6ruiCRmTK+vMXv
         Do6vlYJw+hvZGmAsR38KQKWNA+FSCJPpd2MaGTPZrA85nNkrs+7Tk3DpxuVrLiNCT8
         8PZVTy+mPu/++2yZRNipud541+ObeeUAcRv5fO6QA5EFiewNa5GxRaklTcZqgdi1M7
         DDccvmRcXX9EEh4NLiojk7sBxVKAaP4fmyGfcY3Z2ug7Nk47DMGd/hrGn2veY8xxlU
         JVKZI97hEit8A==
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
Subject: [PATCH v3 12/19] scripts: add `generate_rust_analyzer.py`
Date:   Mon, 17 Jan 2022 06:33:42 +0100
Message-Id: <20220117053349.6804-13-ojeda@kernel.org>
In-Reply-To: <20220117053349.6804-1-ojeda@kernel.org>
References: <20220117053349.6804-1-ojeda@kernel.org>
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
2.34.1


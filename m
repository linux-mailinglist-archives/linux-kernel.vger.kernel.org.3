Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545D51E466
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445694AbiEGFdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445704AbiEGFa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:30:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D9F69CC3;
        Fri,  6 May 2022 22:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAFEDB80CF3;
        Sat,  7 May 2022 05:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA39C385A9;
        Sat,  7 May 2022 05:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901226;
        bh=Sxln/TZwIGd1Pfm1OPudQottOOoYz8MkuziHWI4cAzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGq17qupT4D1XZJk+eUbhrl8Rth/mLC2MxbDa2uH8SRQP5fGpQGXvuP0yKiDdM7Q1
         dxiTOlJ9iAqUm1SW+aCvRxB6W8crXGGMpYQoOCrWoucC3RyBMylKXSFlo8J6DJ2yDl
         SLB+Kv7jRBgRFwZxOtRTl2OIjCann4rBjrSbgExFlSJtB8IU/eLoJ7VpUUZpwnQb8j
         TidH9TNZcAE90G7yq4wRw2WTLnNb1g/ZcwDA/1i0ggYQZ+eCf5OosMBAEq392kso83
         L+Bmv3/SYfDMBN9x9QIuhGDdFuDWe591VCyzblui63QeqqR1LC8m3+W9S1+0WOahuz
         ytlENzFoZQGLg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>
Subject: [PATCH v6 16/23] scripts: add `generate_rust_analyzer.py` scripts
Date:   Sat,  7 May 2022 07:24:14 +0200
Message-Id: <20220507052451.12890-17-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 scripts/generate_rust_analyzer.py | 134 ++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100755 scripts/generate_rust_analyzer.py

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
new file mode 100755
index 000000000000..37c049fb18f2
--- /dev/null
+++ b/scripts/generate_rust_analyzer.py
@@ -0,0 +1,134 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
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
2.35.3


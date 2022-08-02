Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C358754D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiHBBzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiHBByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677824B0F2;
        Mon,  1 Aug 2022 18:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C526100C;
        Tue,  2 Aug 2022 01:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85C8C433C1;
        Tue,  2 Aug 2022 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405195;
        bh=FpEaC+mpjmXCTqUwGTO4dvD+GmY7Ax86eHW6JUchkuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgfWrejjxZyvE1cJCuHWNbISTL9R8u34Bl+Bw31XyfJ5KjviTdhMyWGFE9QT9Et83
         Kr2iN4iQNYbZGB6WoRawZGLdhnLyuiLO0tBxbVBZmEVAcj5e37BxK/UW+9pJ5gSdJL
         aVIqE0vMShLxL4Emha+TBkQY07rdFNqRG1SwDzSm+bxelI/KXnlZCkvzzjt4iaeTSi
         hUSrspYNcOb/pp/EYtQH1VKPUnFckZVsrWOgsjpnqGoqbk+h7LdTtfxtPUW7cLsBya
         sRZFwiTnqT5bMlI/UjM/WUU7LYDQmz7P9qnyEwPh2ieUQKER7RCwz09UHez9AFrcsj
         cx9YAUuHEBOyA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v8 22/31] scripts: add `rustdoc_test_{builder,gen}.py` scripts
Date:   Tue,  2 Aug 2022 03:50:09 +0200
Message-Id: <20220802015052.10452-23-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust documentation tests are typically examples of usage of any
item (e.g. function, struct, module...). They are very convenient
because they are just written alongside the documentation, e.g.:

    /// Sums two numbers.
    ///
    /// # Examples
    ///
    /// ```
    /// assert_eq!(mymod::f(10, 20), 30);
    /// ```
    pub fn f(a: i32, b: i32) -> i32 {
        a + b
    }

These scripts are used to transform Rust documentation tests into
KUnit tests, so that they can be run in-kernel. In turn, this allows
us to run tests that use kernel APIs.

In particular, the test builder receives `rustdoc`-generated tests,
parses them and stores the result. Then, the test generator takes
the saved results and generates a KUnit suite where each original
documentation test is a test case.

For the moment, this is only done for the `kernel` crate, but
the plan is to generalize it for other crates and modules.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rustdoc_test_builder.py |  59 ++++++++++++
 scripts/rustdoc_test_gen.py     | 164 ++++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+)
 create mode 100755 scripts/rustdoc_test_builder.py
 create mode 100755 scripts/rustdoc_test_gen.py

diff --git a/scripts/rustdoc_test_builder.py b/scripts/rustdoc_test_builder.py
new file mode 100755
index 000000000000..d9b47a5c54fc
--- /dev/null
+++ b/scripts/rustdoc_test_builder.py
@@ -0,0 +1,59 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""rustdoc_test_builder - Test builder for `rustdoc`-generated tests.
+"""
+
+import json
+import pathlib
+import re
+import sys
+
+RUST_DIR = pathlib.Path("rust")
+TESTS_DIR = RUST_DIR / "test" / "doctests" / "kernel"
+
+# `[^\s]*` removes the prefix (e.g. `_doctest_main_`) plus any
+# leading path (for `O=` builds).
+MAIN_RE = re.compile(
+    r"^"
+    r"fn main\(\) { "
+    r"#\[allow\(non_snake_case\)\] "
+    r"fn ([^\s]*rust_kernel_([a-zA-Z0-9_]+))\(\) {"
+    r"$"
+)
+
+def main():
+    found_main = False
+    test_header = ""
+    test_body = ""
+    for line in sys.stdin.readlines():
+        main_match = MAIN_RE.match(line)
+        if main_match:
+            if found_main:
+                raise Exception("More than one `main` line found.")
+            found_main = True
+            function_name = main_match.group(1)
+            test_name = f"rust_kernel_doctest_{main_match.group(2)}"
+            continue
+
+        if found_main:
+            test_body += line
+        else:
+            test_header += line
+
+    if not found_main:
+        raise Exception("No `main` line found.")
+
+    call_line = f"}} {function_name}() }}"
+    if not test_body.endswith(call_line):
+        raise Exception("Unexpected end of test body.")
+    test_body = test_body[:-len(call_line)]
+
+    with open(TESTS_DIR / f"{test_name}.json", "w") as fd:
+        json.dump({
+            "name": test_name,
+            "header": test_header,
+            "body": test_body,
+        }, fd, sort_keys=True, indent=4)
+
+if __name__ == "__main__":
+    main()
diff --git a/scripts/rustdoc_test_gen.py b/scripts/rustdoc_test_gen.py
new file mode 100755
index 000000000000..ad9a94293ab5
--- /dev/null
+++ b/scripts/rustdoc_test_gen.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""rustdoc_test_gen - Generates KUnit tests from saved `rustdoc`-generated tests.
+"""
+
+import json
+import os
+import pathlib
+
+RUST_DIR = pathlib.Path("rust")
+TESTS_DIR = RUST_DIR / "test" / "doctests" / "kernel"
+
+RUST_FILE = RUST_DIR / "doctests_kernel_generated.rs"
+C_FILE = RUST_DIR / "doctests_kernel_generated_kunit.c"
+
+RUST_TEMPLATE_TEST = """
+/// Generated `{test_name}` KUnit test case from a Rust documentation test.
+#[no_mangle]
+pub fn {test_name}(__kunit_test: *mut kernel::bindings::kunit) {{
+    /// Provides mutual exclusion (see `# Implementation` notes).
+    static __KUNIT_TEST_MUTEX: kernel::sync::smutex::Mutex<()> =
+        kernel::sync::smutex::Mutex::new(());
+
+    /// Saved argument (see `# Implementation` notes).
+    static __KUNIT_TEST: core::sync::atomic::AtomicPtr<kernel::bindings::kunit> =
+        core::sync::atomic::AtomicPtr::new(core::ptr::null_mut());
+
+    let __kunit_test_mutex_guard = __KUNIT_TEST_MUTEX.lock();
+    __KUNIT_TEST.store(__kunit_test, core::sync::atomic::Ordering::SeqCst);
+
+    /// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
+    macro_rules! assert {{
+        ($cond:expr $(,)?) => {{{{
+            kernel::kunit_assert!(
+                __KUNIT_TEST.load(core::sync::atomic::Ordering::SeqCst),
+                $cond
+            );
+        }}}}
+    }}
+
+    /// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
+    macro_rules! assert_eq {{
+        ($left:expr, $right:expr $(,)?) => {{{{
+            kernel::kunit_assert_eq!(
+                __KUNIT_TEST.load(core::sync::atomic::Ordering::SeqCst),
+                $left,
+                $right
+            );
+        }}}}
+    }}
+
+    // Many tests need the prelude, so provide it by default.
+    use kernel::prelude::*;
+
+    {test_body}
+}}
+"""
+RUST_TEMPLATE = """// SPDX-License-Identifier: GPL-2.0
+
+//! `kernel` crate documentation tests.
+
+// # Implementation
+//
+// KUnit gives us a context in the form of the `kunit_test` parameter that one
+// needs to pass back to other KUnit functions and macros.
+//
+// However, we want to keep this as an implementation detail because:
+//
+//   - Test code should not care about the implementation.
+//
+//   - Documentation looks worse if it needs to carry extra details unrelated
+//     to the piece being described.
+//
+//   - Test code should be able to define functions and call them, without
+//     having to carry the context (since functions cannot capture dynamic
+//     environment).
+//
+//   - Later on, we may want to be able to test non-kernel code (e.g. `core`,
+//     `alloc` or external crates) which likely use the standard library
+//     `assert*!` macros.
+//
+// For this reason, `static`s are used in the generated code to save the
+// argument which then gets read by the asserting macros. These macros then
+// call back into KUnit, instead of panicking.
+//
+// To avoid depending on whether KUnit allows to run tests concurrently and/or
+// reentrantly, we ensure mutual exclusion on our end. To ensure a single test
+// being killed does not trigger failure of every other test (timing out),
+// we provide different `static`s per test (which also allow for concurrent
+// execution, though KUnit runs them sequentially).
+//
+// Furthermore, since test code may create threads and assert from them, we use
+// an `AtomicPtr` to hold the context (though each test only writes once before
+// threads may be created).
+
+{rust_header}
+
+const __LOG_PREFIX: &[u8] = b"rust_kernel_doctests\\0";
+
+{rust_tests}
+"""
+
+C_TEMPLATE_TEST_DECLARATION = "void {test_name}(struct kunit *);\n"
+C_TEMPLATE_TEST_CASE = "    KUNIT_CASE({test_name}),\n"
+C_TEMPLATE = """// SPDX-License-Identifier: GPL-2.0
+/*
+ * `kernel` crate documentation tests.
+ */
+
+#include <kunit/test.h>
+
+{c_test_declarations}
+
+static struct kunit_case test_cases[] = {{
+    {c_test_cases}
+    {{ }}
+}};
+
+static struct kunit_suite test_suite = {{
+    .name = "rust_kernel_doctests",
+    .test_cases = test_cases,
+}};
+
+kunit_test_suite(test_suite);
+
+MODULE_LICENSE("GPL");
+"""
+
+def main():
+    rust_header = set()
+    rust_tests = ""
+    c_test_declarations = ""
+    c_test_cases = ""
+    for filename in sorted(os.listdir(TESTS_DIR)):
+        with open(TESTS_DIR / filename, "r") as fd:
+            test = json.load(fd)
+            for line in test["header"].strip().split("\n"):
+                rust_header.add(line)
+            rust_tests += RUST_TEMPLATE_TEST.format(
+                test_name = test["name"],
+                test_body = test["body"]
+            )
+            c_test_declarations += C_TEMPLATE_TEST_DECLARATION.format(
+                test_name = test["name"]
+            )
+            c_test_cases += C_TEMPLATE_TEST_CASE.format(
+                test_name = test["name"]
+            )
+    rust_header = sorted(rust_header)
+
+    with open(RUST_FILE, "w") as fd:
+        fd.write(RUST_TEMPLATE.format(
+            rust_header = "\n".join(rust_header).strip(),
+            rust_tests = rust_tests.strip(),
+        ))
+
+    with open(C_FILE, "w") as fd:
+        fd.write(C_TEMPLATE.format(
+            c_test_declarations=c_test_declarations.strip(),
+            c_test_cases=c_test_cases.strip(),
+        ))
+
+if __name__ == "__main__":
+    main()
-- 
2.37.1


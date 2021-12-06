Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0A54697CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245281AbhLFOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbhLFOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39BC0613F8;
        Mon,  6 Dec 2021 06:05:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 945DEB810D6;
        Mon,  6 Dec 2021 14:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42EBC341C5;
        Mon,  6 Dec 2021 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799535;
        bh=oKmajA+opOe8Q0FBKNPvDjBwEU403TEXbD6mgeqDrSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fh2kugmcBJyQxPW9Y/L0sbtdRqui/AJvu5CDh0QqHqXcNKmuf6iJvEcnLFxoHZFSA
         y0KCC/zBQR1tsfFW+Ux6R3k6nsw8nmpUriNDEt7S/SXbqT1BCwgPJ4ebqUe9wXg4iz
         J7GFym4xXyv/mPKGPOFgnk0vLRzcqB/j1QXHg8GiY2Hl9XuB7zsPXGrk4dBG674o/l
         PGLamVIvoi6i/rbREbtMcSAExYeBXdY570Ck9dHA0w9DcqAQOQuiNiuHt56m+76fTZ
         Z7/TAyPFC7Ccpb2nLcJRECbANRpOEhQIfExhrJCqUpnvAs+F+wR6Kh+XJs3ZAGPfKH
         UIWSEirBq024A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>
Subject: [PATCH 05/19] rust: add `compiler_builtins` crate
Date:   Mon,  6 Dec 2021 15:02:59 +0100
Message-Id: <20211206140313.5653-6-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust provides `compiler_builtins` as a port of LLVM's `compiler-rt`.
Since we do not need the vast majority of them, we avoid the
dependency by providing our own crate.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/compiler_builtins.rs | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 rust/compiler_builtins.rs

diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
new file mode 100644
index 000000000000..a5a0be72591b
--- /dev/null
+++ b/rust/compiler_builtins.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Our own `compiler_builtins`.
+//!
+//! Rust provides [`compiler_builtins`] as a port of LLVM's [`compiler-rt`].
+//! Since we do not need the vast majority of them, we avoid the dependency
+//! by providing this file.
+//!
+//! At the moment, some builtins are required that should not be. For instance,
+//! [`core`] has floating-point functionality which we should not be compiling
+//! in. We will work with upstream [`core`] to provide feature flags to disable
+//! the parts we do not need. For the moment, we define them to [`panic!`] at
+//! runtime for simplicity to catch mistakes, instead of performing surgery
+//! on `core.o`.
+//!
+//! In any case, all these symbols are weakened to ensure we do not override
+//! those that may be provided by the rest of the kernel.
+//!
+//! [`compiler_builtins`]: https://github.com/rust-lang/compiler-builtins
+//! [`compiler-rt`]: https://compiler-rt.llvm.org/
+
+#![feature(compiler_builtins)]
+#![compiler_builtins]
+#![no_builtins]
+#![no_std]
+
+macro_rules! define_panicking_intrinsics(
+    ($reason: tt, { $($ident: ident, )* }) => {
+        $(
+            #[doc(hidden)]
+            #[no_mangle]
+            pub extern "C" fn $ident() {
+                panic!($reason);
+            }
+        )*
+    }
+);
+
+define_panicking_intrinsics!("`i128` should not be used", {
+    __ashrti3,
+    __muloti4,
+    __multi3,
+});
+
+define_panicking_intrinsics!("`u128` should not be used", {
+    __ashlti3,
+    __lshrti3,
+    __udivmodti4,
+    __udivti3,
+    __umodti3,
+});
+
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __aeabi_uldivmod,
+    __mulodi4,
+});
-- 
2.34.0


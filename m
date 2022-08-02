Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710E858753A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiHBBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiHBBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:52:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9964481C8;
        Mon,  1 Aug 2022 18:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77DBFB81910;
        Tue,  2 Aug 2022 01:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE7AC433D7;
        Tue,  2 Aug 2022 01:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405128;
        bh=83+vP03xffNc1asLJOUpvf/HaJj9CQbs0t4g75FXjqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHRMWJBKqbrDNLsUSIGjotB/msVb4rZnzitC6YAhd109uZy9jD3B70SdE+wWzUrIX
         yiIgCce2UBIFR6NtLmgJ9RTB69D1x25fNDugC+k5tpdqDNSDdd0Ux9q6ZOwAGmC5XW
         dEOSLd2qg00RMrEiRONUClUbrQn8/kTXy+FdlzxBu/JkOaXB1OKUP02G83UB/UNaSn
         TO4DzprFkaWUQyH7pqxp70WKepn2gqRAwQ3gJpyiR1vy+/vC+7FdP8yA1lr65DCdyi
         MCPf9Fo0VUelPMgyht+RQABmbSUQQyF3SEPjkurqNlX6g8PxFq5W9g0Fv+mfIuuq3Z
         VDk30n7OGv/+g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>
Subject: [PATCH v8 10/31] rust: add `compiler_builtins` crate
Date:   Tue,  2 Aug 2022 03:49:57 +0200
Message-Id: <20220802015052.10452-11-ojeda@kernel.org>
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
 rust/compiler_builtins.rs | 79 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 rust/compiler_builtins.rs

diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
new file mode 100644
index 000000000000..e57011b7c3da
--- /dev/null
+++ b/rust/compiler_builtins.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Our own `compiler_builtins`.
+//!
+//! Rust provides [`compiler_builtins`] as a port of LLVM's [`compiler-rt`].
+//! Since we do not need the vast majority of them, we avoid the dependency
+//! by providing this file.
+//!
+//! At the moment, some builtins are required that should not be. For instance,
+//! [`core`] has 128-bit integers functionality which we should not be compiling
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
+define_panicking_intrinsics!("`f32` should not be used", {
+    __eqsf2,
+    __gesf2,
+    __lesf2,
+    __nesf2,
+    __unordsf2,
+});
+
+define_panicking_intrinsics!("`f64` should not be used", {
+    __unorddf2,
+});
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
+define_panicking_intrinsics!("`f32` should not be used", {
+    __aeabi_fcmpeq,
+    __aeabi_fcmpun,
+});
+
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`f64` should not be used", {
+    __aeabi_dcmpun,
+});
+
+#[cfg(target_arch = "arm")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __aeabi_uldivmod,
+});
-- 
2.37.1


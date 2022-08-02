Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1729587542
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiHBBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiHBBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:53:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E6481FB;
        Mon,  1 Aug 2022 18:52:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8949DB81913;
        Tue,  2 Aug 2022 01:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D5BC433D6;
        Tue,  2 Aug 2022 01:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405154;
        bh=lhMljuujdVd5PTPW7PSgX+3MAMFgmyobkMe+iKIw06c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xc7BQytn42BuiFgqiLnoqOi0c1Bp+l1wyI3ucpODkPNlUsY3y55VcISDZVg019NVZ
         CyrNCUxBR6SMqXAfmKd6UEMMJ8DEGw6BdrldJ/uu9hzBghL39btt+Jflce+wKDnPGB
         5BFBcIb1CfY+yWfxj8twTScTNw7IxedN75rcvpBAklCWsAjPPBAWHrgPya+oO95q8g
         0R21cRPZjN1yA+fbH6FU+WIuFPpBWJgT6hlDKJmxUpEbYLUsn4lzrNjjChs3rze8Nu
         TLQSjv9bB0wzj5jMWleqFBJJzkB+jSf5/AhDXROYIobde2rHGxu3VAJsDB4WKGZ3yo
         s3bD577byoBKA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v8 15/31] rust: add `bindings` crate
Date:   Tue,  2 Aug 2022 03:50:02 +0200
Message-Id: <20220802015052.10452-16-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This crate contains the bindings to the C side of the kernel.

Calling C (in general, FFI) is assumed to be unsafe in Rust
and, in many cases, this is accurate. For instance, virtually
all C functions that take a pointer are unsafe since, typically,
it will be dereferenced at some point (and in most cases there
is no way for the callee to check its validity beforehand).

Since one of the goals of using Rust in the kernel is precisely
to avoid unsafe code in "leaf" kernel modules (e.g. drivers),
these bindings should not be used directly by them.

Instead, these bindings need to be wrapped into safe abstractions.
These abstractions provide a safe API that kernel modules can use.
In this way, unsafe code in kernel modules is minimized.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindings/bindings_helper.h | 49 ++++++++++++++++++++++++++++
 rust/bindings/lib.rs            | 57 +++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 rust/bindings/bindings_helper.h
 create mode 100644 rust/bindings/lib.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
new file mode 100644
index 000000000000..284793085d55
--- /dev/null
+++ b/rust/bindings/bindings_helper.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header that contains the code (mostly headers) for which Rust bindings
+ * will be automatically generated by `bindgen`.
+ *
+ * Sorted alphabetically.
+ */
+
+#include <kunit/test.h>
+#include <linux/amba/bus.h>
+#include <linux/cdev.h>
+#include <linux/clk.h>
+#include <linux/errname.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fs_parser.h>
+#include <linux/gpio/driver.h>
+#include <linux/hw_random.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/netfilter_arp.h>
+#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
+#include <linux/netfilter_ipv6.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/random.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <uapi/linux/android/binder.h>
+
+/* `bindgen` gets confused at certain things. */
+const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
+const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const __poll_t BINDINGS_EPOLLIN = EPOLLIN;
+const __poll_t BINDINGS_EPOLLOUT = EPOLLOUT;
+const __poll_t BINDINGS_EPOLLERR = EPOLLERR;
+const __poll_t BINDINGS_EPOLLHUP = EPOLLHUP;
+
+const loff_t BINDINGS_MAX_LFS_FILESIZE = MAX_LFS_FILESIZE;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
new file mode 100644
index 000000000000..7fdd74e68b60
--- /dev/null
+++ b/rust/bindings/lib.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings.
+//!
+//! Imports the generated bindings by `bindgen`.
+//!
+//! This crate may not be directly used. If you need a kernel C API that is
+//! not ported or wrapped in the `kernel` crate, then do so first instead of
+//! using this crate.
+
+#![no_std]
+#![feature(core_ffi_c)]
+// See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
+#![cfg_attr(test, allow(deref_nullptr))]
+#![cfg_attr(test, allow(unaligned_references))]
+#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
+#![allow(
+    clippy::all,
+    missing_docs,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+
+mod bindings_raw {
+    // Use glob import here to expose all helpers.
+    // Symbols defined within the module will take precedence to the glob import.
+    pub use super::bindings_helper::*;
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings/bindings_generated.rs"
+    ));
+}
+
+// When both a directly exposed symbol and a helper exists for the same function,
+// the directly exposed symbol is preferred and the helper becomes dead code, so
+// ignore the warning here.
+#[allow(dead_code)]
+mod bindings_helper {
+    // Import the generated bindings for types.
+    use super::bindings_raw::*;
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings/bindings_helpers_generated.rs"
+    ));
+}
+
+pub use bindings_raw::*;
+
+pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
+pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const __GFP_HIGHMEM: gfp_t = ___GFP_HIGHMEM;
+
+pub const MAX_LFS_FILESIZE: loff_t = BINDINGS_MAX_LFS_FILESIZE;
-- 
2.37.1


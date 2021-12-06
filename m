Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049E84697D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbhLFOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59606 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbhLFOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B7A612D3;
        Mon,  6 Dec 2021 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3294BC341C7;
        Mon,  6 Dec 2021 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799542;
        bh=djVvJq0SeChq//87siY+8qVZP1K+LepHsJVacGCfPbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ety92jmBBqUrhJ2o1pC64DiHcyHav5gdI5faDs1nd5lx6yfDY3t6HGdMTRxRdd/kD
         tyHmV8n6LF2QnAOjK446xQwmdIbjckmX1yTFmC11n0PUMKURSHee3qfKWDiE3QoPc7
         Mkaz3lgfN7F5WYdi6o7uIq6TSASXjyeyVbxxysx3j0AxfEslnpzk94WtuvRRESGvA4
         Y8EhKfLJUim7fL4saa/110xShX/PwFoJtjxyEczCRa9ZjDkO0H3JzPPbx9Kh61L5WS
         VAvMVoZLyEd2KRZsQnTdypiiNyg8QyFfiaMwstdbCphjwb01ksBKiNk8hEvIEzBlts
         zyRoP9oJCjBMw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 07/19] rust: add `build_error` crate
Date:   Mon,  6 Dec 2021 15:03:01 +0100
Message-Id: <20211206140313.5653-8-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Guo <gary@garyguo.net>

The `build_error` crate provides the `build_error` function which
is then used to provide the `build_error!` and the `build_assert!`
macros.

`build_assert!` is intended to be used when `static_assert!` cannot
be used, e.g. when the condition refers to generic parameters or
parameters of an inline function.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/build_error.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 rust/build_error.rs

diff --git a/rust/build_error.rs b/rust/build_error.rs
new file mode 100644
index 000000000000..34e589149d3e
--- /dev/null
+++ b/rust/build_error.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Build-time error.
+//!
+//! This crate provides a function `build_error`, which will panic in
+//! compile-time if executed in const context, and will cause a build error
+//! if not executed at compile time and the optimizer does not optimise away the
+//! call.
+//!
+//! It is used by `build_assert!` in the kernel crate, allowing checking of
+//! conditions that could be checked statically, but could not be enforced in
+//! Rust yet (e.g. perform some checks in const functions, but those
+//! functions could still be called in the runtime).
+
+#![no_std]
+
+/// Panics if executed in const context, or triggers a build error if not.
+#[inline(never)]
+#[cold]
+#[no_mangle]
+#[track_caller]
+pub const fn build_error(msg: &'static str) -> ! {
+    panic!("{}", msg);
+}
+
+#[cfg(CONFIG_RUST_BUILD_ASSERT_WARN)]
+#[link_section = ".gnu.warning.build_error"]
+#[used]
+static BUILD_ERROR_WARNING: [u8; 45] = *b"call to build_error present after compilation";
-- 
2.34.0


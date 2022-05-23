Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0C530773
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349549AbiEWCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352311AbiEWCDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE43982E;
        Sun, 22 May 2022 19:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A72E60FD7;
        Mon, 23 May 2022 02:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E455C34113;
        Mon, 23 May 2022 02:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653271410;
        bh=vbNh5V+If7BMOjgvnKPpE36qR1+NfFcgaQxIO6y+Mq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWzPuA+9psavWwLq35M/pqJIXrSIU2Fgq/Gv4WznPVO2b+fZ07cdFAaBhN/0q4BB3
         5TJKTq3eF9zw3bytBpdU1u4jGXXq3y1hjXq3/ppNykMkU1GKw5DmSYdD9zTUJflX5y
         hhGIbIeVBzCA+CvVRI0bdAHiMX66PHpNZbanitGGKp/BKIqDwtFTy94LfCNTwOZ4vY
         p5nXM7c85FzEJ6lLryTj5nXbicewYGquvuHGml1LN9+ojemV8jjXu99x4+3g5+45sE
         yRAzNEULjwggRK/V3CdXLoFOFQp8KoWysT/ZSdplp6SqUJNKR3jY/iXXCn7OJXju5q
         B7c/JA9qs294g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v7 09/25] rust: add `build_error` crate
Date:   Mon, 23 May 2022 04:01:22 +0200
Message-Id: <20220523020209.11810-10-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-1-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
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
2.36.1


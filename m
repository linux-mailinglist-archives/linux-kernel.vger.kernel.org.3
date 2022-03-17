Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE764DCD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiCQSNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiCQSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B121DF1F;
        Thu, 17 Mar 2022 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0EC961663;
        Thu, 17 Mar 2022 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA00C340EE;
        Thu, 17 Mar 2022 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540701;
        bh=ApspYmKimTsDaiKmY2HBxsKKPe+ifO/dur0fE3PhxaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwxwYQCpujUbn3iSxMbqq1IT3VjQDchj8PsKL7f1Gda6BxP1wQjgohMpTeASsXvZu
         DT/OcpPIbFK7PfWLSMcDcA4h3tw/iQBXq6/bBufdhjnML8Pu6b2W2a7if65KUEA2Qc
         d+tXlywh3msUCFgD0d+xcKNUzQleDukjCgZMgJXDrm5mmmMoQZp5zIQ3RtA4mwZ5u/
         V+2ysz9RHvVQdIEbZ8xpcg1gbib2QR7Xp35wEP6fNyM3sxyfND9bvO95AOELWDPN3h
         oMekcEVoFIwPBWlDbNS5+kTq7tT6A7qIXEesWzUZz15aKWk5ZdJCrIGL6tpQbP+okF
         4VtV4e0NPS8wA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v5 07/20] rust: add `build_error` crate
Date:   Thu, 17 Mar 2022 19:09:55 +0100
Message-Id: <20220317181032.15436-8-ojeda@kernel.org>
In-Reply-To: <20220317181032.15436-1-ojeda@kernel.org>
References: <20220317181032.15436-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.35.1


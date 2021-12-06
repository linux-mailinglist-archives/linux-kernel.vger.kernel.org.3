Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A04697EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbhLFOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34958 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245330AbhLFOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DDACB810E5;
        Mon,  6 Dec 2021 14:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A0C341CE;
        Mon,  6 Dec 2021 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799558;
        bh=7e+dsGsStGTvT0T98PNKEL4EBL+8U5ATUQvgV4Pm6RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/KXKvI7lgBT0Wvf3ltuP8F0o+pouD+Y8gZ5uKx2zydxv9pU9Tw5SBtc7aSzGimKf
         h86w25Hd9ZNu5Ke51H9ZoDDPUnK+F2AHyIpVhP7EHydUvCCCflgoyUBhYp8ieArnLJ
         bVzyoddTuTQV5h0h3yqgnfQ4yXbH7mnf4NgA7eEKVDWI8jrCaeEUBkY+3luCRQrWdd
         PNBlPIriq367xU7be0YNjNrXQu973NYm6UFwZTFgymY76avnZOsc7DS9Lvid+TDu0y
         8zypt13AU+DoUNCSKN21xhw4MpZ2uZDgHwiPr0qxoWFUTwz342WR3XpHHOwE0mOr9O
         C3Xd+QZJVqybA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 11/19] vsprintf: add new `%pA` format specifier
Date:   Mon,  6 Dec 2021 15:03:05 +0100
Message-Id: <20211206140313.5653-12-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Guo <gary@garyguo.net>

This patch adds a format specifier `%pA` to `vsprintf` which formats
a pointer as `core::fmt::Arguments`. Doing so allows us to directly
format to the internal buffer of `printf`, so we do not have to use
a temporary buffer on the stack to pre-assemble the message on
the Rust side.

This specifier is intended only to be used from Rust and not for C, so
`checkpatch.pl` is intentionally unchanged to catch any misuse.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 lib/vsprintf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 58d5e567f836..bc9c05427d9a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2233,6 +2233,10 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+#ifdef CONFIG_RUST
+char *rust_fmt_argument(char* buf, char* end, void *ptr);
+#endif
+
 /* Disable pointer hashing if requested */
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
@@ -2388,6 +2392,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  *
  * Note: The default behaviour (unadorned %p) is to hash the address,
  * rendering it useful as a unique identifier.
+ *
+ * There is also a '%pA' format specifier, but it is only intended to be used
+ * from Rust code to format core::fmt::Arguments. Do *not* use it from C.
+ * See rust/kernel/print.rs for details.
  */
 static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
@@ -2460,6 +2468,10 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'f':
 		return fwnode_string(buf, end, ptr, spec, fmt + 1);
+#ifdef CONFIG_RUST
+	case 'A':
+		return rust_fmt_argument(buf, end, ptr);
+#endif
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-- 
2.34.0


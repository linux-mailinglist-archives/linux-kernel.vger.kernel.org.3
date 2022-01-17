Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5A49017F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiAQFf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiAQFer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:34:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92249C061401;
        Sun, 16 Jan 2022 21:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C69260E0B;
        Mon, 17 Jan 2022 05:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FEBC36AEF;
        Mon, 17 Jan 2022 05:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642397681;
        bh=rJ31/fMDEOgeFnklAO6ZW6HptTNnZpSPCAN1xm598/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krvDzoHInj6I/uh6kmwfYBmDMCXwvvJtFUOsBi++HvIvtdlUr52LwgAYS3N91tCWw
         RSwhBKoIU40RoAuB0+RaMfC4YU7PPnfS28eL+7K+q4Ll/tuN9VxQgD78Llvwc/dtGa
         tWpeD/7PFFZ/eOdpzrJ1OUjTFmsLx2f3e7oCcCxVmlfvY4j1c/hYplVBcTyQjQcFeI
         Vmwo/buw4JHzEtIgrmENUbaOAK0ShGBdgU6vUNPpHqrJ3zQQ9H3r6Dp1JEbiiMRLiT
         1ofaE9Q6pTW73bF5c2s8EEwqCJimPJBEWchh+2lCNWRXoG+jfsRvQxkthn6gBFn+V5
         DRaP7u/zbMxWw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v3 11/19] vsprintf: add new `%pA` format specifier
Date:   Mon, 17 Jan 2022 06:33:41 +0100
Message-Id: <20220117053349.6804-12-ojeda@kernel.org>
In-Reply-To: <20220117053349.6804-1-ojeda@kernel.org>
References: <20220117053349.6804-1-ojeda@kernel.org>
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
 lib/rust.h     | 14 ++++++++++++++
 lib/vsprintf.c |  7 +++++++
 2 files changed, 21 insertions(+)
 create mode 100644 lib/rust.h

diff --git a/lib/rust.h b/lib/rust.h
new file mode 100644
index 000000000000..9cf0b102b496
--- /dev/null
+++ b/lib/rust.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LIB_RUST_H
+#define _LIB_RUST_H
+
+#ifdef CONFIG_RUST
+char *rust_fmt_argument(char* buf, char* end, void *ptr);
+#else
+static inline char *rust_fmt_argument(char* buf, char* end, void *ptr)
+{
+	return NULL;
+}
+#endif
+
+#endif /* _LIB_RUST_H */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 58d5e567f836..84a1c9496e6e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -52,6 +52,7 @@
 
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
+#include "rust.h"
 
 static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
 {
@@ -2388,6 +2389,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
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
@@ -2460,6 +2465,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'f':
 		return fwnode_string(buf, end, ptr, spec, fmt + 1);
+	case 'A':
+		return rust_fmt_argument(buf, end, ptr);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-- 
2.34.1


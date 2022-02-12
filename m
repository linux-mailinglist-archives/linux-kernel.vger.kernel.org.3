Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C4A4B352D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiBLNGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:06:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiBLNGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:06:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DF927157;
        Sat, 12 Feb 2022 05:06:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E98C9B8047E;
        Sat, 12 Feb 2022 13:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD686C340EB;
        Sat, 12 Feb 2022 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644671160;
        bh=BMlEDMQoYdmU2yQnqZ+p5mIOS0XWjQWV+K/PMwRTVc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOj7joDyq3ynSytZ/A3fPTrvjzA5YDTbJqC9qFHBpFEEMruFPDOfTGz4rtHlgufX6
         duGrRVQ8JJQGTMHw2LsfXlxVJTN5u3jVNtRg3uZZWlO5qZEPewX5F1K5gDaViOXxNO
         qThkuU7Ub+leThdZra//ta5S71DMWNxcF6aauNzLujcYnww1PZlYL/OsPvilBm/G2Y
         AeMb52XefuyKoNc4qryCIIr6UDd5X4QhdwKRQI7vsEhIx1MIEPeI2wkI/Wmm0tN3Rm
         S5JjlsQ5dJEz27rFEF/CPtfHsbU9Y+q1/Eq8ReQxHBpCdO6yHhM8xPJxFYOh91WLV3
         5OmdZR+CFIyig==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Date:   Sat, 12 Feb 2022 14:03:38 +0100
Message-Id: <20220212130410.6901-13-ojeda@kernel.org>
In-Reply-To: <20220212130410.6901-1-ojeda@kernel.org>
References: <20220212130410.6901-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 3b8129dd374c..61528094ec87 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -52,6 +52,7 @@
 
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
+#include "rust.h"
 
 static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
 {
@@ -2378,6 +2379,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
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
@@ -2450,6 +2455,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'f':
 		return fwnode_string(buf, end, ptr, spec, fmt + 1);
+	case 'A':
+		return rust_fmt_argument(buf, end, ptr);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5944DCD55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiCQSON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiCQSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736B21FF4C;
        Thu, 17 Mar 2022 11:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1DA761686;
        Thu, 17 Mar 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CABC36AE2;
        Thu, 17 Mar 2022 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540732;
        bh=MONFdng+YEgoSrYdaPFkWXax0hsmifCzL0A6RLvcm+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVt/2dLcRokncILwXtYrQQr4gbwT7NDlT81c5TT4WRbW7DH4XfrLKCPNPeHTsSnTL
         s9AML9o6irDb5KmMBUN/mlo5oRp+AQyxTPdWDAUlxMhLFeM7UadLvgCi483eQDzOrh
         PxwweT2Y7OvY3j56RjOZ9rhsdrLDSiHagAJmAbt8xUM4sWPIil662C55RtsvCnnzkb
         U+yzZ9GJh8WQ0bJKxEv/eEFgQMQ/RRcPyQhp+FL+qVT+DOizV/Ev36T+l5porbai04
         aviBw/sQKvB0xz378HS1YdynTlRDRXu+goLJdRYVZD0jgJLue8zxkLBwM7JFO5G/n/
         Hyj0OYP01jIiw==
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
Subject: [PATCH v5 12/20] vsprintf: add new `%pA` format specifier
Date:   Thu, 17 Mar 2022 19:10:00 +0100
Message-Id: <20220317181032.15436-13-ojeda@kernel.org>
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
 lib/vsprintf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..881f982897b8 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2252,6 +2252,9 @@ int __init no_hash_pointers_enable(char *str)
 }
 early_param("no_hash_pointers", no_hash_pointers_enable);
 
+/* Used for Rust formatting ('%pA'). */
+char *rust_fmt_argument(char* buf, char* end, void *ptr);
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2378,6 +2381,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
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
@@ -2450,6 +2457,12 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'f':
 		return fwnode_string(buf, end, ptr, spec, fmt + 1);
+	case 'A':
+		if (!IS_ENABLED(CONFIG_RUST)) {
+			WARN_ONCE(1, "Please remove %%pA from non-Rust code\n");
+			return error_string(buf, end, "(%pA?)", spec);
+		}
+		return rust_fmt_argument(buf, end, ptr);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-- 
2.35.1


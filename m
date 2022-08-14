Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732BD592693
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiHNVW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiHNVVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:00 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757621A9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7SfS9fDmJWHeAts1Kr/a4Ch5nXcHRwXnqSTTXS9KRA=;
        b=CPwdwjluVBXd7vT86TN9jScRHiduh5SS76dQz8wNZxEmf0kP4kR/yAyWiM+Nb9LTUbEYMH
        TWSrRhVkWEeUWsONnJyLzKpfkGLiJdTE5XPmVjEV+MRugxJjoYgZPMpHgl2pArJ1dGL0GN
        bxbR5J3M0AkAlrux3qCvM5VA1aw4mZ0=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 13/32] vsprintf: Refactor resource_string()
Date:   Sun, 14 Aug 2022 17:19:52 -0400
Message-Id: <20220814212011.1727798-14-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

Two changes:
 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes resource_string to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 51 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2b337e30c2..f8abeee393 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1032,7 +1032,7 @@ static const struct printf_spec default_dec_spec = {
 
 static noinline_for_stack
 void resource_string(struct printbuf *out, struct resource *res,
-		     struct printf_spec spec, const char *fmt)
+		     int decode)
 {
 #ifndef IO_RSRC_PRINTK_SIZE
 #define IO_RSRC_PRINTK_SIZE	6
@@ -1071,62 +1071,58 @@ void resource_string(struct printbuf *out, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym_buf[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
-	struct printbuf sym = PRINTBUF_EXTERN(sym_buf, sizeof(sym_buf));
-	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
-	if (check_pointer_spec(out, res, spec))
+	if (check_pointer(out, res))
 		return;
 
-	prt_char(&sym, '[');
+	prt_char(out, '[');
 	if (res->flags & IORESOURCE_IO) {
-		string_nocheck(&sym, "io  ", str_spec);
+		string_nocheck(out, "io  ", str_spec);
 		specp = &io_spec;
 	} else if (res->flags & IORESOURCE_MEM) {
-		string_nocheck(&sym, "mem ", str_spec);
+		string_nocheck(out, "mem ", str_spec);
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
-		string_nocheck(&sym, "irq ", str_spec);
+		string_nocheck(out, "irq ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
-		string_nocheck(&sym, "dma ", str_spec);
+		string_nocheck(out, "dma ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
-		string_nocheck(&sym, "bus ", str_spec);
+		string_nocheck(out, "bus ", str_spec);
 		specp = &bus_spec;
 	} else {
-		string_nocheck(&sym, "??? ", str_spec);
+		string_nocheck(out, "??? ", str_spec);
 		specp = &mem_spec;
 		decode = 0;
 	}
 	if (decode && res->flags & IORESOURCE_UNSET) {
-		string_nocheck(&sym, "size ", str_spec);
-		number(&sym, resource_size(res), *specp);
+		string_nocheck(out, "size ", str_spec);
+		number(out, resource_size(res), *specp);
 	} else {
-		number(&sym, res->start, *specp);
+		number(out, res->start, *specp);
 		if (res->start != res->end) {
-			prt_char(&sym, '-');
-			number(&sym, res->end, *specp);
+			prt_char(out, '-');
+			number(out, res->end, *specp);
 		}
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
-			string_nocheck(&sym, " 64bit", str_spec);
+			string_nocheck(out, " 64bit", str_spec);
 		if (res->flags & IORESOURCE_PREFETCH)
-			string_nocheck(&sym, " pref", str_spec);
+			string_nocheck(out, " pref", str_spec);
 		if (res->flags & IORESOURCE_WINDOW)
-			string_nocheck(&sym, " window", str_spec);
+			string_nocheck(out, " window", str_spec);
 		if (res->flags & IORESOURCE_DISABLED)
-			string_nocheck(&sym, " disabled", str_spec);
+			string_nocheck(out, " disabled", str_spec);
 	} else {
-		string_nocheck(&sym, " flags ", str_spec);
-		number(&sym, res->flags, default_flag_spec);
+		string_nocheck(out, " flags ", str_spec);
+		number(out, res->flags, default_flag_spec);
 	}
-	prt_char(&sym, ']');
+	prt_char(out, ']');
 
-	string_nocheck(out, sym_buf, spec);
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -2301,7 +2297,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		return do_width_precision(out, prev_pos, spec);
 	case 'R':
 	case 'r':
-		return resource_string(out, ptr, spec, fmt);
+		resource_string(out, ptr, fmt[0] == 'R');
+		return do_width_precision(out, prev_pos, spec);
 	case 'h':
 		return hex_string(out, ptr, spec, fmt);
 	case 'b':
-- 
2.36.1


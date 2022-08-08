Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B158C1CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiHHCnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbiHHCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C8121A8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RlavjRy9kvgaAWt9y6l0Gv7CjB4rdfzSfzo2twQl+yU=; b=KW2wt7jTWSA+RBXfBDJPAqxqKP
        i9j4reKMem5DlX6LwuZ6/MaZP62/SM9IQP+CXTPgOvmzWr8QiCWYKkltkP8nx1Ns2eRZWejlxqIXA
        OpmBc2mrKETeAstSEVuq5fbTimq4K0V/pW6F38SWM9VJixNL5H4mf4Vo45yYy7hpcfxtddhdiR2OR
        Ybr/YfTJoqrv+XHORCF5riSRJNSgwQOZ14ky8RaXjSULgDkMQ2UOSIj827HH8Rxb1ZrBK7irMSfi2
        XMsP1hkBE/bXk8eLA3ibnXxsEDU4e6DqE2J8pwPmIbNKVBGkAUncrA6bu5o+mq+VbmNiUW/yCXkCt
        rLYnUJPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRp-N2; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 13/32] vsprintf: Refactor resource_string()
Date:   Mon,  8 Aug 2022 03:41:09 +0100
Message-Id: <20220808024128.3219082-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index 5cc8337ada0c..2c5f10bc59e2 100644
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
2.35.1


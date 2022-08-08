Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AD58C1D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiHHCns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbiHHCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15A21AF
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D8UCvE42MAR+ZYM3si/CNIX4RG/qDGM3KKoxlZUxilc=; b=XsNu7EIebpiESnQvtSefLjOIGa
        kCD4DfmYmuM4c2J31kJyTvxn2hyJAs2HXeldH7iCoMzDtc75hUDC04RxzX3hOeOy1jiHV1J9Q7Ety
        SgHZgeZEQ5fuOcgHqujimflQFHSsT4ANiLhtwr00tCSIXfz9+F4Ol6ItThzVvAI0K4wrxY18G+qp0
        DAlyD+Eyo9DZCHkpB/YXjUw94f0tQ4HBlNrUCD1iKyrHMFL/spSkA/1mKtdpJyhWjjZ/nGZvo/SM7
        7KMuL4sFJ9TyPqTx0l1xLGv8q0nN95rwOX17SZ2urvmHZGPJipPVUr7HyiV1M5+xYE1a1+nZLxrNG
        zEL8rIrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRr-P6; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 14/32] vsprintf: Refactor fourcc_string()
Date:   Mon,  8 Aug 2022 03:41:10 +0100
Message-Id: <20220808024128.3219082-15-willy@infradead.org>
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

 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes fourcc_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2c5f10bc59e2..f47f10659737 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1701,17 +1701,15 @@ void netdev_bits(struct printbuf *out, const void *addr,
 
 static noinline_for_stack
 void fourcc_string(struct printbuf *out, const u32 *fourcc,
-		   struct printf_spec spec, const char *fmt)
+		   const char *fmt)
 {
-	char output_buf[sizeof("0123 little-endian (0x01234567)")];
-	struct printbuf output = PRINTBUF_EXTERN(output_buf, sizeof(output_buf));
 	unsigned int i;
 	u32 orig, val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
-		return error_string_spec(out, "(%p4?)", spec);
+		return error_string(out, "(%p4?)");
 
-	if (check_pointer_spec(out, fourcc, spec))
+	if (check_pointer(out, fourcc))
 		return;
 
 	orig = get_unaligned(fourcc);
@@ -1721,18 +1719,16 @@ void fourcc_string(struct printbuf *out, const u32 *fourcc,
 		unsigned char c = val >> (i * 8);
 
 		/* Print non-control ASCII characters as-is, dot otherwise */
-		prt_char(&output, isascii(c) && isprint(c) ? c : '.');
+		prt_char(out, isascii(c) && isprint(c) ? c : '.');
 	}
 
-	prt_char(&output, ' ');
-	prt_str(&output, orig & BIT(31) ? "big-endian" : "little-endian");
-
-	prt_char(&output, ' ');
-	prt_char(&output, '(');
-	special_hex_number(&output, orig, sizeof(u32));
-	prt_char(&output, ')');
+	prt_char(out, ' ');
+	prt_str(out, orig & BIT(31) ? "big-endian" : "little-endian");
 
-	string_spec(out, output_buf, spec);
+	prt_char(out, ' ');
+	prt_char(out, '(');
+	special_hex_number(out, orig, sizeof(u32));
+	prt_char(out, ')');
 }
 
 static noinline_for_stack
@@ -2336,7 +2332,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		netdev_bits(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
 	case '4':
-		return fourcc_string(out, ptr, spec, fmt);
+		fourcc_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'a':
 		address_val(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
-- 
2.35.1


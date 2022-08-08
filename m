Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9858C1B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiHHCln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiHHCli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD42183
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mymWwDkjjiHh/KYD2mfecqldcFEi+AVyZTL9MNt1bp8=; b=SIABDbFY5J2Gk7jbWFiO3p0ZNf
        KnDzFa4aGU9xZH59qz/GileVMl4Avij+19/5gDJ6lrrNv/sQjQRHWSLCIZ0WjOXOA3yH3AhtTLyKG
        ccuQ7CkkqScB3jIIIbsoITNIaXq2jb1/BUklPldKXS3rw4EKbUK86KlfxRAvfQk23SYDLO3tee9Sd
        hPTmWgrM1J+UkjXBA68Sv1oKotYUtRN/WCdHJelLGVvsai8pnxtL4wvwAjtBCiKCiRnrcWwM1FQpt
        QulsI4DSgAsSbmj5rhF9seHsZCehHE3Chl3qdUaEBo2Wva4w7ReuS72UaDg82PfrN6mstk+jgLfvd
        9U/Z8H7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRg-Bg; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 09/32] vsprintf: Improve number()
Date:   Mon,  8 Aug 2022 03:41:05 +0100
Message-Id: <20220808024128.3219082-10-willy@infradead.org>
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

This patch refactors number() to make it a bit clearer, and it also
changes it to call printbuf_make_room() only once at the start, instead
of in the printbuf output helpers.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 83 +++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 52dac8519a0a..87adc528c6c7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -457,93 +457,92 @@ void number(struct printbuf *out, unsigned long long num,
 {
 	/* put_dec requires 2-byte alignment of the buffer. */
 	char tmp[3 * sizeof(num)] __aligned(2);
-	char sign;
-	char locase;
+	char sign = 0;
+	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
+	 * produces same digits or (maybe lowercased) letters */
+	char locase = (spec.flags & SMALL);
 	int need_pfx = ((spec.flags & SPECIAL) && spec.base != 10);
-	int i;
 	bool is_zero = num == 0LL;
 	int field_width = spec.field_width;
 	int precision = spec.precision;
+	int nr_digits = 0;
+	int output_bytes = 0;
 
-	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
-	 * produces same digits or (maybe lowercased) letters */
-	locase = (spec.flags & SMALL);
 	if (spec.flags & LEFT)
 		spec.flags &= ~ZEROPAD;
-	sign = 0;
 	if (spec.flags & SIGN) {
 		if ((signed long long)num < 0) {
 			sign = '-';
 			num = -(signed long long)num;
-			field_width--;
+			output_bytes++;
 		} else if (spec.flags & PLUS) {
 			sign = '+';
-			field_width--;
+			output_bytes++;
 		} else if (spec.flags & SPACE) {
 			sign = ' ';
-			field_width--;
+			output_bytes++;
 		}
 	}
 	if (need_pfx) {
 		if (spec.base == 16)
-			field_width -= 2;
+			output_bytes += 2;
 		else if (!is_zero)
-			field_width--;
+			output_bytes++;
 	}
 
 	/* generate full string in tmp[], in reverse order */
-	i = 0;
-	if (num < spec.base)
-		tmp[i++] = hex_asc_upper[num] | locase;
-	else if (spec.base != 10) { /* 8 or 16 */
+	if (spec.base == 10) {
+		nr_digits = put_dec(tmp, num) - tmp;
+	} else { /* 8 or 16 */
 		int mask = spec.base - 1;
-		int shift = 3;
+		int shift = ilog2((unsigned) spec.base);
 
-		if (spec.base == 16)
-			shift = 4;
 		do {
-			tmp[i++] = (hex_asc_upper[((unsigned char)num) & mask] | locase);
+			tmp[nr_digits++] = (hex_asc_upper[((unsigned char)num) & mask] | locase);
 			num >>= shift;
 		} while (num);
-	} else { /* base 10 */
-		i = put_dec(tmp, num) - tmp;
 	}
 
 	/* printing 100 using %2d gives "100", not "00" */
-	if (i > precision)
-		precision = i;
+	precision = max(nr_digits, precision);
+	output_bytes += precision;
+	field_width = max(0, field_width - output_bytes);
+
+	printbuf_make_room(out, field_width + output_bytes);
+
 	/* leading space padding */
-	field_width = max(0, field_width - precision);
 	if (!(spec.flags & (ZEROPAD | LEFT)) && field_width) {
-		__prt_chars(out, ' ', field_width);
+		__prt_chars_reserved(out, ' ', field_width);
 		field_width = 0;
 	}
+
 	/* sign */
 	if (sign)
-		__prt_char(out, sign);
+		__prt_char_reserved(out, sign);
+
 	/* "0x" / "0" prefix */
 	if (need_pfx) {
 		if (spec.base == 16 || !is_zero)
-			__prt_char(out, '0');
+			__prt_char_reserved(out, '0');
 		if (spec.base == 16)
-			__prt_char(out, 'X' | locase);
+			__prt_char_reserved(out, 'X' | locase);
 	}
-	/* zero or space padding */
-	if (!(spec.flags & LEFT) && field_width) {
-		char c = ' ' + (spec.flags & ZEROPAD);
 
-		__prt_chars(out, c, field_width);
-		field_width = 0;
-	}
-	/* hmm even more zero padding? */
-	if (precision > i)
-		__prt_chars(out, '0', precision - i);
+	/* zero padding */
+	if (!(spec.flags & LEFT) && field_width)
+		__prt_chars_reserved(out, '0', field_width);
+
+	/* zero padding from precision */
+	if (precision > nr_digits)
+		__prt_chars_reserved(out, '0', precision - nr_digits);
+
 	/* actual digits of result */
-	while (--i >= 0)
-		__prt_char(out, tmp[i]);
+	while (--nr_digits >= 0)
+		__prt_char_reserved(out, tmp[nr_digits]);
+
 	/* trailing space padding */
-	if (field_width)
-		__prt_chars(out, ' ', field_width);
+	if ((spec.flags & LEFT) && field_width)
+		__prt_chars_reserved(out, ' ', field_width);
 
 	printbuf_nul_terminate(out);
 }
-- 
2.35.1


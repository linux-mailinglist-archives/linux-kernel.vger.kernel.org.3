Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56059268D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiHNVV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiHNVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:54 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466426435
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2b4/V+42uJKZ8rG7/53XrLIP4lCTcM8aG3HRwdnES4=;
        b=CbgOzMkpT8EXsrF5vqmyJk+ehe/3FCOR4IGLD+c35pOGf3rmmqB+g5nsbZgIVHL3bRVGEN
        dNeDs5Ghqh4wQLzQoTc7l152zF/GmJ26JZEOSsXinoGqdQfzUfOmjyMbErUDu5rVxH+cZJ
        SybA+XDpzh7LrGHkga/ve1eYa/+xgyw=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 09/32] vsprintf: Improve number()
Date:   Sun, 14 Aug 2022 17:19:48 -0400
Message-Id: <20220814212011.1727798-10-kent.overstreet@linux.dev>
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
index 52dac8519a..87adc528c6 100644
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
2.36.1


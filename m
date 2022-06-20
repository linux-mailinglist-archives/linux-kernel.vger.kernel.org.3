Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90948550E25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiFTAn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiFTAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69880B4B4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id p31so13998603qvp.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+doRSndIqb/FisTLPVe5Bh/ofBw5aQUkb0tO+s0zbQ=;
        b=WRsAgh5sLiSXnUWsFWUdKfv3snQ371BnO978e4fY372IVVti8PHQr4mdmPcHCoZIfl
         cWczSiCcC50anmfaWm5q+8+IS6sHDTgs3xufm0GoK1c6bn3oMXlKLNMszpjs0bDm7H9b
         VJm2O7Ylezs9ZcWjgYT74IdKN+FJ+ItstRUT58jSjskNJXfCspOSSunzLuskncp+UTom
         ETzU9mOWaaMZ0IN7+jLeqWPNOuFYTit5m4dagIJPviypEkq0hnRkrDJ4tK9AgOtHougZ
         o2L9q/1OmXm/Y7ZyrFN6uDiZMnY883rXN8+npJm2rHrMai7cWfip3CRSNksw6aBnugVH
         J6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+doRSndIqb/FisTLPVe5Bh/ofBw5aQUkb0tO+s0zbQ=;
        b=u4k/HewOLoewD/82d+CP7BMxlOunqfQi8GAi/xjRK/gA/uxs8u71Lvu3aofnjkMnNL
         e9uXIfV7V0Dn9cVJizoXo50kTznVYS/dqIa8yI7QEfMBJ61uCTfHZA+iuxLOKocX0BrY
         NqDqUnPt1Ohwv4ZuVHE48/KL7Say8O2Zyqw/ysv0OY8Qi4ufFp0FAM5qypbtqruR2lpQ
         BPbHqRyArJTcqKUseVwFRA0wKppw/Sv/XsEfzQZQvXpNTaRcHR40sI+XXD+4SjfAHfHP
         OPpk/q1v9S2AbbHLUmLV/8G5wdK3hT4N6SJubTVoLHUkAn0QR6EXuwSrNubxP+VfBwyi
         zhPA==
X-Gm-Message-State: AJIora/1i1qlXlaryHKk09+5vCrun/HmV69VKHhQFjWQhHHYz9TjRZ2W
        Xe6NXH/T/n3Roe3/0LysD61MiqzXk745HAY=
X-Google-Smtp-Source: AGRyM1vA0V9RjbIKZsYA7zZoD0L520hpVBmC/QV5Y4Fl5nCasrnrNz3TXtyGGqCBHjwmSFxKxKwLGQ==
X-Received: by 2002:a05:6214:c82:b0:46a:b677:e284 with SMTP id r2-20020a0562140c8200b0046ab677e284mr16988331qvr.28.1655685777230;
        Sun, 19 Jun 2022 17:42:57 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l16-20020a05620a28d000b006a6cadd89efsm11521487qkp.82.2022.06.19.17.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:55 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 11/34] vsprintf: Improve number()
Date:   Sun, 19 Jun 2022 20:42:10 -0400
Message-Id: <20220620004233.3805-12-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors number() to make it a bit clearer, and it also
changes it to call printbuf_make_room() only once at the start, instead
of in the printbuf output helpers.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 83 +++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 5afa74dda5..7d20406deb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -458,93 +458,92 @@ void number(struct printbuf *out, unsigned long long num,
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


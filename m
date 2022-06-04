Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC453D852
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiFDTbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiFDTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79C2251B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bi27so1809717qkb.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjOFseB6wD6vM7xhBXj0Pmypn2c4Grf0JVhbVnX37js=;
        b=DXIamAJIMgDpqyhDaU2sRWfbikhQ84Arj9tDbxtpCA8oTG6UL0BnpIAMcFInJbW591
         cFFlsukFXfgmpoxD/1fbvk/b7aDZPP4SU3y7iizkE0nzKbd/7O+1X4mhFdANtU8gFvyi
         uqjATvtehoqKwQ+HeUGzmnNxjx/df3XCBzEyQmCelm1uR+HB567XZ578TBaZDfpg5Bhl
         sW+oRCwaSOjuXWv0bU86XtdaHAR63/YzjzJ+hGWP8udpyBf9Fndc0Bq6xajDRfLoIVNt
         Ie7qddhqaNhgeXutZPmhQGL1kXNH/gpt3LGnQfus6ohjuKFWzMx4ehHlPPH+Z7d59dez
         p6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjOFseB6wD6vM7xhBXj0Pmypn2c4Grf0JVhbVnX37js=;
        b=SXXTk8unYwuM6NgQ1GqCv9wIpYznR5i9r14o2ZRLIU1G7JKSyHoLS7Fy0sRGoj/BPx
         PLdXw269WM2BiQ15L4AgpcUCf6PdgOTTN5CGSv8OZBhRoEcCgzOfPOgtqUjj+ZUarkXn
         /cunlOmTFWJXwmTk0yiMXiEYWkdsRXVuPnjILQEcoRq87Io3SE0b+pjwI7oxRA9ZcVHw
         dmj8fdgoDV9hqAPmM3gEPTTOXJ5ZX71pLss2Vgi4fo9WaYz4rPssemib9oHeOMBBa8Tg
         u/rO+tJ6Y778XGnUbZLuIt1/smWiPj59HJ1t2pRvfb0j8iBIJhcjotS3gIkv7h2ymTDK
         soMQ==
X-Gm-Message-State: AOAM531WREUpwq4JrEGr0NdZoY5vwkD7CG4zV1D/lX1w1RRCgI99cFnQ
        ZKZ/3ICj2nhIGa5hBCtcX/B4b9z2DjXC
X-Google-Smtp-Source: ABdhPJyyDLDNT2Eq92EPxIeXzkQF7IOVp3Joz59bjpeReg31EKn5ZozKfkcr0aLclx9Nelw3d05OXw==
X-Received: by 2002:a05:620a:bcb:b0:6a6:5830:6138 with SMTP id s11-20020a05620a0bcb00b006a658306138mr10800536qki.647.1654371066278;
        Sat, 04 Jun 2022 12:31:06 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:05 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 11/33] vsprintf: Improve number()
Date:   Sat,  4 Jun 2022 15:30:20 -0400
Message-Id: <20220604193042.1674951-12-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
 lib/vsprintf.c | 82 +++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 118d6f65c3..1c5ffc7f28 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -458,92 +458,92 @@ void number(struct printbuf *out, unsigned long long num,
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
 	if (!(spec.flags & (ZEROPAD | LEFT))) {
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
-	if (!(spec.flags & LEFT)) {
-		char c = ' ' + (spec.flags & ZEROPAD);
 
-		__prt_chars(out, c, field_width);
-		field_width = 0;
-	}
-	/* hmm even more zero padding? */
-	if (precision > i)
-		__prt_chars(out, '0', precision - i);
+	/* zero padding */
+	if (!(spec.flags & LEFT))
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
-	__prt_chars(out, ' ', field_width);
+	if (spec.flags & LEFT)
+		__prt_chars_reserved(out, ' ', field_width);
 
 	printbuf_nul_terminate(out);
 }
-- 
2.36.0


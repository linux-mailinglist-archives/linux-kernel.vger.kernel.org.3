Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913252DB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiESRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiESRY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059DA777E;
        Thu, 19 May 2022 10:24:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ds11so5942390pjb.0;
        Thu, 19 May 2022 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmKCBHh5NxpYnol0Ho2uBrT6Afu7PiBh/Bpj7m21S4k=;
        b=gFaR6gU1uMZeJeeoNbMzrqeNhoMaLQsGmQCLKLTP4rE0vEeKawniiuRp+ZWLn1Jw6D
         LBx3R8yU0CiRZBHrxDrFSl2PHVUacXE9GuglsO/CpI//aIXMA5gSGySRIN4oVorTeMJg
         5WKzTyDono1BJeHCgHKTCVyGUi8tvWgqOnleL+CFsKB5gvMIDs1Vfm9gdt2sC0Dmkn0K
         sDqI0muvLGzC25u1oAaS7fn92xWLIXW0ivI4ReeuAjmOPrpAVI6sRGzcmbugNru9VIua
         e5JP44R66OchdZnYepsoBjNQeCD/hw9yq4UvDYPoKG9dmvQ+jVas8h62i99LwgQS5I/O
         fJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmKCBHh5NxpYnol0Ho2uBrT6Afu7PiBh/Bpj7m21S4k=;
        b=r306ApMtGhrYYIPeN7L4oxOsMloUCvVUZVrLF3N+hpX1Upeh6KNdh9nxJTBovUmKxd
         8uT2S9/SOcwscDVbXBDqz9nAFuRSRqSoYQa77Z3tKuC3vbp1mHegjSSMEWTPXF/7UfKH
         i4/txpXlNa0DH55Mm3mUREn9313fvfEFdgiwPFbzpw20myCRWc/VdpllbYic66KI+gBo
         OQpuBqdVVw23VqV7kO9i61HRnxYIxnV2rcOufKRaWohWnUsHA9P+NPOdUEyILIQ+fjcR
         QxLNEBO93Z/7RY0TYvFvsD0SAvOPL022hkhGBBWgrNTFw787y7TKybzT5RgE3UDeu1v+
         wvGA==
X-Gm-Message-State: AOAM530/OHINd+JUjrEC6k8UxfO346NvdZOhgu6W5A83q/kjfCwWs5uf
        NJSXNv2vEcC1ocbAFvc9WPCDpwXFScyA
X-Google-Smtp-Source: ABdhPJxrKQV4yThEwK1aZau9KxCinawmnP2Nv/f6pXqjMKEeaQMJ/dYjTo12S2bWXcYke1p0ojuKgQ==
X-Received: by 2002:a17:90b:1d10:b0:1dc:dea8:d2ad with SMTP id on16-20020a17090b1d1000b001dcdea8d2admr6756875pjb.174.1652981095252;
        Thu, 19 May 2022 10:24:55 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:54 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 09/28] vsprintf: Improve number()
Date:   Thu, 19 May 2022 13:24:02 -0400
Message-Id: <20220519172421.162394-10-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
 lib/vsprintf.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7fbeaf50d1..d1372c0b37 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -453,92 +453,94 @@ void number(struct printbuf *out, unsigned long long num,
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
-		pr_chars(out, ' ', field_width);
+		__pr_chars_reserved(out, ' ', field_width);
 		field_width = 0;
 	}
+
 	/* sign */
 	if (sign)
-		__pr_char(out, sign);
+		__pr_char_reserved(out, sign);
+
 	/* "0x" / "0" prefix */
 	if (need_pfx) {
 		if (spec.base == 16 || !is_zero)
-			__pr_char(out, '0');
+			__pr_char_reserved(out, '0');
 		if (spec.base == 16)
-			__pr_char(out, 'X' | locase);
+			__pr_char_reserved(out, 'X' | locase);
 	}
-	/* zero or space padding */
-	if (!(spec.flags & LEFT)) {
-		char c = ' ' + (spec.flags & ZEROPAD);
 
-		pr_chars(out, c, field_width);
-		field_width = 0;
-	}
-	/* hmm even more zero padding? */
-	if (precision > i)
-		pr_chars(out, '0', precision - i);
+	/* zero padding */
+	if (!(spec.flags & LEFT))
+		__pr_chars_reserved(out, '0', field_width);
+
+	/* zero padding from precision */
+	if (precision > nr_digits)
+		__pr_chars_reserved(out, '0', precision - nr_digits);
+
 	/* actual digits of result */
-	while (--i >= 0)
-		__pr_char(out, tmp[i]);
+	while (--nr_digits >= 0)
+		__pr_char_reserved(out, tmp[nr_digits]);
+
 	/* trailing space padding */
-	pr_chars(out, ' ', field_width);
+	if (spec.flags & LEFT)
+		__pr_chars_reserved(out, ' ', field_width);
+
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
-- 
2.36.0


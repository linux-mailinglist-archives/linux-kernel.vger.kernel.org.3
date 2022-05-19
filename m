Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3C52DB39
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbiESR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242659AbiESRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A9A5018;
        Thu, 19 May 2022 10:25:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so5635312pgl.11;
        Thu, 19 May 2022 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HbBS6xmnZ/fOvGf3tPUK0KgU6ZNd4ATaXcG9E299js=;
        b=hu2Fl6JiyfeeMY+AFR65+MFrqea9eZOdmSto/bcEkiwl9CXd2SumnAeJsYDhkeubEa
         lIUJiSdeJVVxoxYkGUvnoXXV/9jKOvIw44mD4WXfRd6KaqbykvpQ979nceAX+HRtzXvY
         zyCw6OMJcDTIqfLjoBVoN8KSVFvfpfHz82kJbQQHS7ZnvAkIDdt/noG+q5+1AgqzmbK2
         Mgwf5IIfH1ZLiSRibfMI4efuAXBfbz/GGfsGypDP3wSMBJ94SmvppYaS0o5U3BwmXMrX
         uB2ic5TIUtUXMYWatshvn8JrQOBfhT0I28St6wg+jqIXAxjbgYd+ZMWE2XRWcMFzlBrG
         T4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HbBS6xmnZ/fOvGf3tPUK0KgU6ZNd4ATaXcG9E299js=;
        b=ZngCKlG7pSI6YGq5xFxtiKUqu6XlHo5hrNisL0d6YbSdkwXlCqbG76kjhGtoh36/ko
         PZdHJWRJ10ro0sGzMJcLq9KkDkWUxpa8OpqiN85//pWGKsXHQouMDz2hMKWeBgNlKKoL
         fB4sGT/eoh/Fe+Ba+DuPG3kfip6wW+5twefCaoX5F+4HhlG+K7rntvRtwfY+JoIrns92
         URXRM7b3Enjcl4E0AIPrnetVk0Uw8n08rGj4nbKLZTCIcPLe4Ryn90Gf8aPZxUt3vvwD
         ulRTNUZT0bjCOku8fEUzogMV+D23mBGGCu7yOdT/RI3aU521pTBZoXcjS9A6phpfHRNH
         zYkQ==
X-Gm-Message-State: AOAM5339B8A8rBHF4cuxApKUfIWBk6XQZWH5Bjl78ZXNBPCRbY7/bS+A
        ivly9Y5f/eD7krTV7en00a9+2K0wUVQR
X-Google-Smtp-Source: ABdhPJyXdzOnmsoW0cVnKRTdVC06xejnqiGQDIbIHyuHSH9ORmZRPLC4N+1pmHuFj3v8B9/YvIQumw==
X-Received: by 2002:a05:6a00:1a03:b0:510:a1d9:7de0 with SMTP id g3-20020a056a001a0300b00510a1d97de0mr5581474pfv.53.1652981123175;
        Thu, 19 May 2022 10:25:23 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:22 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 21/28] vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
Date:   Thu, 19 May 2022 13:24:14 -0400
Message-Id: <20220519172421.162394-22-kent.overstreet@gmail.com>
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

This patch cleans up printf_spec handling: these functions only use
spec.field_width and they do not interpret it in the normal way -
instead it's a number of bits/bytes passed in to print, so these
functions are changed to take that parameter directly.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index ef8b06a25a..be2fa6053c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1132,17 +1132,22 @@ void resource_string(struct printbuf *out, struct resource *res,
 
 static noinline_for_stack
 void hex_string(struct printbuf *out, const u8 *addr,
-		struct printf_spec spec, const char *fmt)
+		int len, const char *fmt)
 {
-	int len = 1;		/* if we pass '%ph[CDN]', field width remains
-				   negative value, fallback to the default */
 	char separator;
 
-	if (spec.field_width == 0)
-		/* nothing to print */
+	/* nothing to print */
+	if (len == 0)
 		return;
 
-	if (check_pointer_spec(out, addr, spec))
+	/* if we pass '%ph[CDN]', field width remains
+	   negative value, fallback to the default */
+	if (len < 0)
+		len = 1;
+
+	len = min(len, 64);
+
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1160,26 +1165,21 @@ void hex_string(struct printbuf *out, const u8 *addr,
 		break;
 	}
 
-	if (spec.field_width > 0)
-		len = min_t(int, spec.field_width, 64);
-
 	pr_hex_bytes(out, addr, len, separator);
 }
 
 static noinline_for_stack
-void bitmap_string(struct printbuf *out, unsigned long *bitmap,
-		   struct printf_spec spec, const char *fmt)
+void bitmap_string(struct printbuf *out, unsigned long *bitmap, int nr_bits)
 {
+	struct printf_spec spec = { .flags = SMALL | ZEROPAD, .base = 16 };
 	const int CHUNKSZ = 32;
-	int nr_bits = max_t(int, spec.field_width, 0);
 	int i, chunksz;
 	bool first = true;
 
-	if (check_pointer_spec(out, bitmap, spec))
-		return;
+	nr_bits = max(nr_bits, 0);
 
-	/* reused to print numbers */
-	spec = (struct printf_spec){ .flags = SMALL | ZEROPAD, .base = 16 };
+	if (check_pointer(out, bitmap))
+		return;
 
 	chunksz = nr_bits & (CHUNKSZ - 1);
 	if (chunksz == 0)
@@ -1208,13 +1208,14 @@ void bitmap_string(struct printbuf *out, unsigned long *bitmap,
 
 static noinline_for_stack
 void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
-			struct printf_spec spec, const char *fmt)
+			int nr_bits)
 {
-	int nr_bits = max_t(int, spec.field_width, 0);
 	bool first = true;
 	int rbot, rtop;
 
-	if (check_pointer_spec(out, bitmap, spec))
+	nr_bits = max(nr_bits, 0);
+
+	if (check_pointer(out, bitmap))
 		return ;
 
 	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
@@ -2235,13 +2236,15 @@ void pointer(struct printbuf *out, const char *fmt,
 		resource_string(out, ptr, fmt[0] == 'R');
 		return do_width_precision(out, prev_pos, spec);
 	case 'h':
-		return hex_string(out, ptr, spec, fmt);
+		/* Uses field_width but _not_ as field size */
+		return hex_string(out, ptr, spec.field_width, fmt);
 	case 'b':
+		/* Uses field_width but _not_ as field size */
 		switch (fmt[1]) {
 		case 'l':
-			return bitmap_list_string(out, ptr, spec, fmt);
+			return bitmap_list_string(out, ptr, spec.field_width);
 		default:
-			return bitmap_string(out, ptr, spec, fmt);
+			return bitmap_string(out, ptr, spec.field_width);
 		}
 	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
 	case 'm':			/* Contiguous: 000102030405 */
-- 
2.36.0


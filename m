Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED453D85A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiFDTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbiFDTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AA50040
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k6so5324321qkf.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n7xTWujhYMsquXrLDM3KnLZABLDfbSvZSUE+dtyzLjg=;
        b=j+dS3Sm7mCs9vz5MLK96Drd23NgqBEeJRajz2q6+z/CmZfZP79QLhdRJTt6Z4z3fav
         aqsEZHJPeZ7fMSSNqgiq0u/Rn60jK20Hnhi729Zq0LSNC75S+TMMa0hzraMd6P3p4QT7
         uPi+RBOEv0jSJ+r9jRg9zCMBdokH5ek9rJpQz2qtjoZE7Mw65/5PrBFMs3U5OsvdUDpi
         zcJnPVsfOK5pX0ZfFawZ+Bxvuqz+bjQanSuzSlt5vmZqvcb/bF6ps2beSZLVpZG/4L+P
         rVLLV42Yyzc769T0Rh4oNgxp57dIB8e+vGOcdKvMd4dapUQ97A0DpHOsMjKExnNyRjFK
         4rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7xTWujhYMsquXrLDM3KnLZABLDfbSvZSUE+dtyzLjg=;
        b=q/B84ni27Uu4xQ8KVk8Az7SFYUlzFkDa0kYlELW2K/cwqRlJ85ixNyBn3ZV4YrCtkb
         z3xLmwNLIYGsumtl2ZMvRDowRvKtI6B9SiD150rByDNqs4iv4UtITdKSpVeLf0y7pWgj
         VJplyQFlp5/vmE/G5tk1BTKiULjYUYOdumKWEPca2n0FJd8PlejfzN5eoNuHHFj5yns8
         aLTtKMJVgvOejpHyPoEdFUi55cs7WRIMlUqspQ3A3j2SnGWdSKdkeTLn5TS+oaXl6WEJ
         /5ZpdDDWML59I5anQpSQcB/HMauo6jJs3DVmmK1xKiMVI55sYMORdBoUidj//SCUpo9R
         kovw==
X-Gm-Message-State: AOAM533iFuWjRTc3Iku5TSxWTzxjafI2KM6VU9d7S4pNBeosM40T+SPC
        pmv6yJfu4Zn8NtmjPMgq1YIURuLKI2+h
X-Google-Smtp-Source: ABdhPJyppCrJhWA8B0jX1JiXHPJUTI3RdVRs5XLjOnpRkODmDCM9/4o0ImXLaDwEXp4jw/rJ2oOeDA==
X-Received: by 2002:a37:614a:0:b0:6a6:af3b:e9cb with SMTP id v71-20020a37614a000000b006a6af3be9cbmr2123015qkb.744.1654371083363;
        Sat, 04 Jun 2022 12:31:23 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:22 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 22/33] vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
Date:   Sat,  4 Jun 2022 15:30:31 -0400
Message-Id: <20220604193042.1674951-23-kent.overstreet@gmail.com>
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

This patch cleans up printf_spec handling: these functions only use
spec.field_width and they do not interpret it in the normal way -
instead it's a number of bits/bytes passed in to print, so these
functions are changed to take that parameter directly.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 60 +++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a0a17a2aac..f5c93c36fa 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,6 +53,7 @@
 #include <asm/unaligned.h>
 
 #include <linux/string_helpers.h>
+#include <linux/pretty-printers.h>
 #include "kstrtox.h"
 
 /* Disable pointer hashing if requested */
@@ -1151,18 +1152,23 @@ void resource_string(struct printbuf *out, struct resource *res,
 }
 
 static noinline_for_stack
-void hex_string(struct printbuf *out, u8 *addr,
-		struct printf_spec spec, const char *fmt)
+void hex_string(struct printbuf *out, const u8 *addr,
+		int len, const char *fmt)
 {
-	int i, len = 1;		/* if we pass '%ph[CDN]', field width remains
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
@@ -1180,34 +1186,21 @@ void hex_string(struct printbuf *out, u8 *addr,
 		break;
 	}
 
-	if (spec.field_width > 0)
-		len = min_t(int, spec.field_width, 64);
-
-	for (i = 0; i < len; ++i) {
-		__prt_char(out, hex_asc_hi(addr[i]));
-		__prt_char(out, hex_asc_lo(addr[i]));
-
-		if (separator && i != len - 1)
-			__prt_char(out, separator);
-	}
-
-	printbuf_nul_terminate(out);
+	prt_hex_bytes(out, addr, len, 1, separator);
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
@@ -1236,13 +1229,14 @@ void bitmap_string(struct printbuf *out, unsigned long *bitmap,
 
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
@@ -2257,13 +2251,15 @@ void pointer(struct printbuf *out, const char *fmt,
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


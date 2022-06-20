Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F64D550E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiFTAon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiFTAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559CAB7D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n15so10002237qvh.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+ZrKVYsWw5cNOUTh5FoAEVyiDPKL3entVW3ZPKBcpU=;
        b=OHgAtZQ6ySjldVX8pc24fFfTjF1EAs15UPJBeLpGxXUzTKVvwzSqiTAMWWCyezmzma
         LpF8Kk9CW5tO43zGl4/vNaPHh4F2mclGiGwK3o56ye7Zf97BNQibXKpPr5MRaPnuY9WQ
         /dGJQZUr1hqXx4FnlguF6bxSv9kXjJUexI0hs01sASvB9AT3LanNwaS+zPprVHzs8UNe
         kL/NLo1MZ/xoA+rKm9jXFvHwNBz6oMdZfiYID/39uymh7POHtj/Fww7LVD5zD4jasWs7
         ZMKSK7iYjrYHjuuSYMrhqXvTzuQa6mvVMGngb/914V3hrnHfHsNO2L+UoRa9DAuUCKCx
         Xsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+ZrKVYsWw5cNOUTh5FoAEVyiDPKL3entVW3ZPKBcpU=;
        b=y0maavtLmBiOWMDdmZtEnTVon+aFJLjvJsAcgyPHtw0mVSOUOd9FGwhBqVg38z1HDk
         4sQ1JD3nM089dH9PeNbVypQX2Of0dA2FxRIIT48WM3HUh99gmTENV4yLOr5g1d2Jrr9C
         y8s2ADsEPCWWBU034eDcKGNo6O0qbg8ZDwXro8RdlV4ZVad5N5lnIUgBkUHmeb57Q+md
         RFS1lEPeIGEHcjsJDAdGg+i1jEHgwaLQq69tk8kDqSJWVbwEyraNtyD2yBl9Gf1IOwLw
         Zhu0F/VEIWMfNG0sTFpB2qA/DlTCm6oJhp0rTvtnZo5cXnx36QCbVTQIYhx1Jaqj9P8C
         K+UA==
X-Gm-Message-State: AJIora/j3oV7O+F1acm6Rk+RMOm9R0++VBmEpVlnr67MJZ6NIhJSG+8K
        mCAbF7SwnG0C8clRCcTME4BPzq63BlGUQfY=
X-Google-Smtp-Source: AGRyM1uQlGT66NzFCddbaTYNbzmbaqITcI52TERSTBxYTP606LkGhInp1bFsIHt/1tjHVOrOlnCSww==
X-Received: by 2002:a0c:f5c1:0:b0:470:47b1:7ca8 with SMTP id q1-20020a0cf5c1000000b0047047b17ca8mr127311qvm.35.1655685805997;
        Sun, 19 Jun 2022 17:43:25 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j2-20020ac85c42000000b00304df6f73f0sm10699866qtj.0.2022.06.19.17.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:25 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 22/34] vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
Date:   Sun, 19 Jun 2022 20:42:21 -0400
Message-Id: <20220620004233.3805-23-kent.overstreet@gmail.com>
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

This patch cleans up printf_spec handling: these functions only use
spec.field_width and they do not interpret it in the normal way -
instead it's a number of bits/bytes passed in to print, so these
functions are changed to take that parameter directly.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 60 +++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7f47533ed8..fcdf187b21 100644
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
2.36.1


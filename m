Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD4550E10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiFTAoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiFTAn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:28 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD7B4B2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:17 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id t16so9021718qvh.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ts7V5k9ar980hnXI+/jYl6A3OMW+Txe0RmaID5nDbjU=;
        b=c4/Q7W5X+EjmJys3owsRTWii+P0aglll0Gr2oy623S3gzsOHRLzXVseBghxCBofAY4
         bSju/DjO3Hj+RUrvorRKDtZx4aIStaGIJe6TuxKU6H1ptG6rRgDIOb/cjeqQSwC6OpEG
         3dhtBbodhxXzjN7J9BnQmwDbFS+q+OoROzmbQnWpt6iugmrkW/ps0yVlaMxZUC9f2D8f
         Ej2h9h0xw/gog+GRFjrcwFCjxlzau0N4gwVmxa0XV+mJAvZmZqowTlEWJ4Kw+yp2hsMP
         HL5eWRol5yzVwYB/crpyUw651XMULnk8P5d0dtKsqbw763qemfxyyKt7x7gQKdR7tRoy
         Qvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ts7V5k9ar980hnXI+/jYl6A3OMW+Txe0RmaID5nDbjU=;
        b=Shm8UHv1XP/k3NRt/N796tvtw4QbMLC63T3onulnaM/MROB+Sj2aq9pLGT8ZK2tTM4
         VLFLB89AuNbNiNQwp+syz1S3VLB93MfHJAm8xt+TThnITM0y2t0d9VnTKzHvTazt89/D
         kngKIue7w317BQOanEvUojYijsU4YTwIN6yXLnvDlF0uFOMfOJfnwuy5g12MummLANFo
         Ar/bXG6SrhAXipgUdANzKF79/wdA/1keV0Q1a7x7K9O4EYhJbOaZ5BGsw4fExc/4I2eH
         x3YvoqDqkpzWifPWnt3TRiPdS/tux6HJG+5lbuSRYQxJ3AJ0uO+B/z/8hX88dvLc3BXC
         sQsg==
X-Gm-Message-State: AJIora+xru7/xuiOoH9sU0WusnVbSQttUe5grh3/BEk3/jy++NhtYB6e
        eol1bw8Np2l07bodHBK+HDdOnf6KGi/i+iM=
X-Google-Smtp-Source: AGRyM1vy+CGWiExOc4qKH9vFswZkD8+gTh0kn7nLEz2j5++2CQxb8nvp8M3iPA/mUyRpEL/aS71JyA==
X-Received: by 2002:a05:622a:1109:b0:305:20de:4d21 with SMTP id e9-20020a05622a110900b0030520de4d21mr17807588qty.197.1655685795836;
        Sun, 19 Jun 2022 17:43:15 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t10-20020a37ea0a000000b006a8b6848556sm10841259qkj.7.2022.06.19.17.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:15 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 18/34] vsprintf: Refactor mac_address_string()
Date:   Sun, 19 Jun 2022 20:42:17 -0400
Message-Id: <20220620004233.3805-19-kent.overstreet@gmail.com>
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

 - We're attempting to consolidate printf_spec and format string
   handling in the top level ptr_vprintf(), this changes
mac_address_string() to not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 5c9a529415..486c09b4ad 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1261,15 +1261,13 @@ void bitmap_list_string(struct printbuf *out, unsigned long *bitmap,
 
 static noinline_for_stack
 void mac_address_string(struct printbuf *out, u8 *addr,
-			struct printf_spec spec, const char *fmt)
+			const char *fmt)
 {
-	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
-	char *p = mac_addr;
 	int i;
 	char separator;
 	bool reversed = false;
 
-	if (check_pointer_spec(out, addr, spec))
+	if (check_pointer(out, addr))
 		return;
 
 	switch (fmt[1]) {
@@ -1288,16 +1286,13 @@ void mac_address_string(struct printbuf *out, u8 *addr,
 
 	for (i = 0; i < 6; i++) {
 		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+			prt_hex_byte(out, addr[5 - i]);
 		else
-			p = hex_byte_pack(p, addr[i]);
+			prt_hex_byte(out, addr[i]);
 
 		if (fmt[0] == 'M' && i != 5)
-			*p++ = separator;
+			prt_char(out, separator);
 	}
-	*p = '\0';
-
-	string_nocheck(out, mac_addr, spec);
 }
 
 static noinline_for_stack
@@ -2292,7 +2287,8 @@ void pointer(struct printbuf *out, const char *fmt,
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
 					/* [mM]R (Reverse order; Bluetooth) */
-		return mac_address_string(out, ptr, spec, fmt);
+		mac_address_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'I':			/* Formatted IP supported
 					 * 4:	1.2.3.4
 					 * 6:	0001:0203:...:0708
-- 
2.36.1


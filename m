Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D08756CF77
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJO2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGJO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:28:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527E56597
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:28:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f11so1893967pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Kqv0NaXAzodot31wDs9fWlsKOTwvlvAKb0cG1vQqm0=;
        b=ASwXIDiOFiON0FESB8DDrso/r7805axt7PbpWEiJXAMDgkDgQ66ysRTfsYWCp56ZC6
         UEj8Xv+taAeCTWPd37ri7/aDuOekUDlGrIBU+qrhNJAfNVhiU8NHC5Y4soY32IBK7XrJ
         j0RR9qKy0TKeuxa+xbDrFOpGl/gkPn8GfcTMhd68/qqr7j7BtOHeIP7RbqwCgNObCP+j
         SOMFlCbUDCG3X91LmealXDDDip729ecIYNM5T9BKTcQew9ChaMnJNLKDd55QOY6g1y0P
         mQK5Ctsl3nbewQQUpz/mGjo6RkYFAx2h7RZfW9RWjeBye7YWzMZi6toL/RGJ17D/uxde
         8PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Kqv0NaXAzodot31wDs9fWlsKOTwvlvAKb0cG1vQqm0=;
        b=nCONbt0JrswqnLWKxr/LCGrprXJ9kwMXLwJLG8xRRHGjjHipFB3SI7yB3pCMQJi01V
         96QB0FVKbcj0Yawd4hphJRsadW/X4wPMcsabD+fOmEm7XPfG003bHLKtSa0/HT6EmKvL
         1mOZP6Rtan5JyF929z4lQxx+VJAp9poO2hYSBcU3AgU8EzKniy2vcFf5RbiZB5sV/FY6
         Ip7sscoNRAEVB/H5LgA0aae6lnFICbxi2xC7OG3XrcCU4M/F8xujA2bSIl+/itO4MIzJ
         ElkRESRD71i8jt1odwp3umUzi3Yck/5UOd0nmP6OhCWt+N8mLIw8fYMZUlRpbDbOqnXD
         UI5A==
X-Gm-Message-State: AJIora8OOeCVG1O2pnEqci3kXvCnex/xb+8356fFjFoQNWDEH8X1Rgx1
        Z/jargRJTb5ZRmaOPC8wT0dQeyOIOsc=
X-Google-Smtp-Source: AGRyM1uyEUYfrX9ZZWS+37MtKjYuhuljbKKSr4HuJ8z4YDYDK5lNuG5TrqDhMakL8oHI24keAqBx9g==
X-Received: by 2002:a63:6d5:0:b0:412:ac9d:814e with SMTP id 204-20020a6306d5000000b00412ac9d814emr12358255pgg.90.1657463320782;
        Sun, 10 Jul 2022 07:28:40 -0700 (PDT)
Received: from localhost.localdomain ([101.12.54.120])
        by smtp.gmail.com with ESMTPSA id u28-20020a63471c000000b0040c644e82efsm2508555pga.43.2022.07.10.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 07:28:40 -0700 (PDT)
From:   Yu-Jen Chang <arthurchang09@gmail.com>
To:     andy@kernel.org, akinobu.mita@gmail.com
Cc:     jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 1/2] lib/string.c: Add a macro for memchr_inv()
Date:   Sun, 10 Jul 2022 22:28:21 +0800
Message-Id: <20220710142822.52539-2-arthurchang09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710142822.52539-1-arthurchang09@gmail.com>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a macro MEMCHR_MASK_GEN() so that both memchr_inv()
and memchr() can use it to generate a 8 bytes mask.

Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
---
 lib/string.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 485777c9d..80469e6c3 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -879,6 +879,29 @@ char *strnstr(const char *s1, const char *s2, size_t len)
 EXPORT_SYMBOL(strnstr);
 #endif
 
+#if defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER) && BITS_PER_LONG == 64
+
+#define MEMCHR_MASK_GEN(mask) (mask *= 0x0101010101010101ULL)
+
+#elif defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER)
+
+#define MEMCHR_MASK_GEN(mask)                                                  \
+	do {                                                                   \
+		mask *= 0x01010101;                                            \
+		mask |= mask << 32;                                            \
+	} while (0)
+
+#else
+
+#define MEMCHR_MASK_GEN(mask)                                                  \
+	do {                                                                   \
+		mask |= mask << 8;                                             \
+		mask |= mask << 16;                                            \
+		mask |= mask << 32;                                            \
+	} while (0)
+
+#endif
+
 #ifndef __HAVE_ARCH_MEMCHR
 /**
  * memchr - Find a character in an area of memory.
@@ -932,16 +955,7 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 		return check_bytes8(start, value, bytes);
 
 	value64 = value;
-#if defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER) && BITS_PER_LONG == 64
-	value64 *= 0x0101010101010101ULL;
-#elif defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER)
-	value64 *= 0x01010101;
-	value64 |= value64 << 32;
-#else
-	value64 |= value64 << 8;
-	value64 |= value64 << 16;
-	value64 |= value64 << 32;
-#endif
+	MEMCHR_MASK_GEN(value64);
 
 	prefix = (unsigned long)start % 8;
 	if (prefix) {
-- 
2.25.1


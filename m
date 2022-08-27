Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45B75A395C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiH0R6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiH0R61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:58:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553BF3262
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:12 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cv7so932172qvb.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lkk0aNtBdprK6/w6JDryUnYgq5tZfZLWxr5bNxCaRTc=;
        b=cUOpGrFUBGR9Oh8Uy8dOhTXuMqO7GQro/NIk/L2wTn/SFNLHyqY7tYM/U4U0pF4y3V
         /bSWlSe5YdkELLX8uy0kOAQeJus+ouMVDbavQPpQmypwnt9IQW7hWj3iOcQWWva4Dajh
         EGFDSCwk1AGfW2TvfDTBe4LYt7DSlznylUd5/y7KIU0xH/en7v31yCdp1ZbFC6JRg/+d
         F0PWA3wHwPih02wYhc2Z9VuSy2Hd3RBDFogoQ9qfzLoNBSJGv9eo7ukueKzxhZRMFRji
         +xbWy1uD0fWw8sVrN8F2SBPc/TAwltDs6jzd3RYhEIKLyiA3otxH9laugaEt0+rW1tJ+
         jnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lkk0aNtBdprK6/w6JDryUnYgq5tZfZLWxr5bNxCaRTc=;
        b=maLsXKO2dMsC+1NafOed0uLO74eWBkirZt6gomsQ58wmtN4IGU4XJrhVKZRnG6RpDJ
         WUPSFU03vk8nx/xNIMLMEiDNdaa0o4zfU/92Pa82fPS/NL6LA4B5L3FMJh0B8QAfvoDR
         2s0rXVqfZAZmey/NX4FoP4zwqkhMrni27SZpS0Kmq7AkrqTyNEPYY+KOv+Pzrkxd8YjR
         a8gr4gE6R/VWApL+sIgrvXiVThuQrvLPv333pxvpjsulanhEO1JF2TvjaLTdr5HWR1EK
         hrzszMtY3al939PfHiRiwdGgu9ZoPTgg1Efi3k4uCWDhz2/15T67GmhuLhg071J6OAYP
         S5fg==
X-Gm-Message-State: ACgBeo3HXz5AUDShwHRsi7AQTLJ246n6tQ+aSlVtzzlLkU/X4EqPchFR
        EyDXdZagCQhDIXpUeoI69CM=
X-Google-Smtp-Source: AA6agR7slLkZEQvL0YLebJFYcI/RfCWbweYpS1bnNyfegL53J7FIMntAv+UkUyP2stCiCr/bpIrBsA==
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id gc1-20020a056214230100b004989f6f028dmr4457995qvb.5.1661623090442;
        Sat, 27 Aug 2022 10:58:10 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2454:ae5e:5655:e298])
        by smtp.gmail.com with ESMTPSA id z23-20020ac81017000000b00338ae1f5421sm2053827qti.0.2022.08.27.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:58:10 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 1/4] lib/find_bit: introduce FIND_FIRST_BIT() macro
Date:   Sat, 27 Aug 2022 10:58:04 -0700
Message-Id: <20220827175807.4017673-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220827175807.4017673-1-yury.norov@gmail.com>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
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

Now that we have many flavors of find_first_bit(), and expect even more,
it's better to have one macro that generates optimal code for all and makes
maintaining of slightly different functions simpler.

The logic common to all versions is moved to the new macro, and all the
flavors are generated by providing an FETCH macro-parameter, like
in this example:

  #define FIND_FIRST_BIT(FETCH, MUNGE, size) ...

  find_first_ornot_and_bit(addr1, addr2, addr3, size)
  {
        return FIND_NEXT_BIT(addr1[idx] | ~addr2[idx] & addr3[idx], /* nop */, size);
  }

The FETCH may be of any complexity, as soon as it only refers
the bitmap(s) and an iterator idx.

MUNGE is here to support _le code generation for BE builds. May be
empty.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..894b656f6836 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -19,6 +19,27 @@
 #include <linux/minmax.h>
 #include <linux/swab.h>
 
+/*
+ * Common helper for find_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ */
+#define FIND_FIRST_BIT(FETCH, MUNGE, size)					\
+({										\
+	unsigned long idx, val, sz = (size);					\
+										\
+	for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {			\
+		val = (FETCH);							\
+		if (val) {							\
+			sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);	\
+			break;							\
+		}								\
+	}									\
+										\
+	sz;									\
+})
+
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
 	!defined(find_next_and_bit)
@@ -77,14 +98,7 @@ EXPORT_SYMBOL(_find_next_bit);
  */
 unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx])
-			return min(idx * BITS_PER_LONG + __ffs(addr[idx]), size);
-	}
-
-	return size;
+	return FIND_FIRST_BIT(addr[idx], /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_bit);
 #endif
@@ -97,15 +111,7 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 				  const unsigned long *addr2,
 				  unsigned long size)
 {
-	unsigned long idx, val;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		val = addr1[idx] & addr2[idx];
-		if (val)
-			return min(idx * BITS_PER_LONG + __ffs(val), size);
-	}
-
-	return size;
+	return FIND_FIRST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
@@ -116,14 +122,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
  */
 unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx] != ~0UL)
-			return min(idx * BITS_PER_LONG + ffz(addr[idx]), size);
-	}
-
-	return size;
+	return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888695690F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiGFRnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiGFRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322827B25;
        Wed,  6 Jul 2022 10:43:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id q16so19273019qtn.5;
        Wed, 06 Jul 2022 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zrDKrgWjWYoqhLNgKXCX7OnjR9UTrCEG+O0rRKPH50=;
        b=heIFXapJdEzowqiFB2mS/xtMJxdMxoc2ubC65bgzqOxHnqbym8ZEcyKW7PFMQuQ0FO
         U/VqAR1hkNcMHGaETyC9JqpX/Ak1kpp4auixjtWIsc3C0SYoaz0KLazSBI8jT6Iyb7j0
         AGFcrdV+9ut6Knb9YEtH1ef3hGVjZfE9lvsyC5b4/0aqs7MckkfzQdmG1rqbQBenK7LD
         3A5+KzBgFXm0ePeRRo+I8O8TOvleYFVDuD4YE8OE1YgKTuqjnpiADOVq/zkimux1xOjj
         DqqYwC8LabwWYX0gke3X5o7qzErBACQTn5tAb+kUmpApr8GPeEl9bWbYPJMxZDdXbSnZ
         Jtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zrDKrgWjWYoqhLNgKXCX7OnjR9UTrCEG+O0rRKPH50=;
        b=OxxsLUhxwFkolG3s5+Rzq/kqWIBJLxSw2gMChor0Vm9I7hjjBh4mI+QMVEHYlzXkkh
         M3t/h1t64v0w4cl3AnSrqGEA4akCg0rN2GvcWGBr30gLNfx8wU2dbQWkkcf52tCM4Fwm
         944rcwCeG6BEuH8MeyqKHAQzzmocIcG9X2UFWWnn5wUgRO8Ai3RkOJHCTIkcsnJIgJHq
         ucsTcNh5zmsbVmIjt9KS6tEJT3LRuYlrCVOo4pGXJP+eBg31oJoiIKn/Ld6j7p6MaYX3
         8HUQtKJR3EebabFycAd3+ACZQA9sx2xbCAG85HXDgA8mEn1iUU+BreYHkNbN6uzsIvPN
         lsDw==
X-Gm-Message-State: AJIora/qfoGnoHBYuLTKiE6udKIlJ0sSlMUm6Hbky4WGmQfWFUs7JngZ
        dD1j6qeSoc/ZXQvm434rkzND+bWnqmN7LQ==
X-Google-Smtp-Source: AGRyM1sgYG5ZA1Q43on9m/YHXkTTeIV7n/NLBKoToO6i4hQ4nI2FamaIV6GitTV1JyZvJs3oDAcsXQ==
X-Received: by 2002:a05:6214:2506:b0:470:2c9c:65fa with SMTP id gf6-20020a056214250600b004702c9c65famr37643155qvb.117.1657129379917;
        Wed, 06 Jul 2022 10:42:59 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id x2-20020ae9e902000000b006a6a6f148e6sm29882134qkf.17.2022.07.06.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:42:59 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 03/10] lib/bitmap: change type of bitmap_weight to unsigned long
Date:   Wed,  6 Jul 2022 10:42:46 -0700
Message-Id: <20220706174253.4175492-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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

bitmap_weight() doesn't return negative values, so change it's type
to unsigned long. It may help compiler to generate better code and
catch bugs.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h       | 5 +++--
 lib/bitmap.c                 | 5 ++---
 tools/include/linux/bitmap.h | 4 ++--
 tools/lib/bitmap.c           | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 85aace699b2b..a92149f415d2 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -163,7 +163,7 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
-int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
+unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -419,7 +419,8 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
-static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
+static __always_inline
+unsigned long bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 098fd9db2363..b580b381eca1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -333,10 +333,9 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
-int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
+unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
-	unsigned int k, lim = bits/BITS_PER_LONG;
-	int w = 0;
+	unsigned long k, w = 0, lim = bits/BITS_PER_LONG;
 
 	for (k = 0; k < lim; k++)
 		w += hweight_long(bitmap[k]);
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 2ae7ab8ed7d1..ae1852e39142 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -11,7 +11,7 @@
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
-int __bitmap_weight(const unsigned long *bitmap, int bits);
+unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int bits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
@@ -61,7 +61,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
-static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
+static inline unsigned long bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 2e351d63fdba..e1fafc131a49 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -5,9 +5,9 @@
  */
 #include <linux/bitmap.h>
 
-int __bitmap_weight(const unsigned long *bitmap, int bits)
+unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
-	int k, w = 0, lim = bits/BITS_PER_LONG;
+	unsigned long k, w = 0, lim = bits/BITS_PER_LONG;
 
 	for (k = 0; k < lim; k++)
 		w += hweight_long(bitmap[k]);
-- 
2.34.1


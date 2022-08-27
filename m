Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8655A395A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiH0R6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiH0R6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:58:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F654F32CF
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:14 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y15so163970qvn.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RHParwCR4cn2lNrRo0cT6xejtHubyBfMuzBqgRMrU1Q=;
        b=cN41ZCrUUkZBZsNunK77moSkD0r8wnOZSuV8R+gKUJNDSLDp1AGHLNZaVj2Rt6siyw
         wFw6vDBeLZHv4aBSYnGTo7D1ttN12d4KwTLrKUE0mwEVb7lkccJxmeSsOO5jmhDJaRra
         GOlONchvLOiGsOolwm+/QzxpVGIookkg//lcqZ/Z3GYNV2pW4KMVipAb4/FPeQm3OpMB
         81nhwBNrS9hHJ71GY2FHp+V+87TFcdigaqUGilZ4+txvCPBwuTdil4NLtkVIHymglDta
         HtdJty8zi+1zTiYj/nPOEJo9F9danv7NN7EONmRS2LawEcFp/3ymQibTgM0kzfSCk20+
         eK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RHParwCR4cn2lNrRo0cT6xejtHubyBfMuzBqgRMrU1Q=;
        b=eYSiZWHFP7a7MZg4C+BttATvahWWCnA6U13wbPhAa0gsUy8x8zBeReFbLxLOpRPjjq
         +fVlNjLtrEKQEwkvMsRExfc06Jw5hU1L4e0UYyNWNMCfMEdrw1dwU3MsOdatLf/zkPG2
         83rMKcaGY9dJ5BhZwRlZ6IVcBpEgl05p+sBcmnp8i1YgpEBihg8yx2peFpz+xKCgxZRn
         sBHyLwfx1x9i0AACgSaI/w9+Dp/ZR34C0rQv1Np4ocFgniPw1DvakEOWdHGL70s6S5W7
         6q2QfXVTKRRoxw+jp7DK8leHl5gfykzUF0+V9taF59nMHULbfxxMBsy/KJSTWlqAmZfT
         EoVA==
X-Gm-Message-State: ACgBeo2tXdLlIz7QSYiCFlsa+yMSlNENrvcHHx/AT3/KgsdGp2PUCh9/
        9ztXGbHpUhJWKwF0/l/ReYI=
X-Google-Smtp-Source: AA6agR59pQuOxMwKknXn0UqCatol5YBwGGUuDH5FplMfc09rpUXWlrNGv9qI5HyWDsHOJU5YSddITA==
X-Received: by 2002:a05:6214:4005:b0:472:be5a:810d with SMTP id kd5-20020a056214400500b00472be5a810dmr4399283qvb.36.1661623093380;
        Sat, 27 Aug 2022 10:58:13 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2454:ae5e:5655:e298])
        by smtp.gmail.com with ESMTPSA id k17-20020a05620a143100b006bb83e2e65fsm2190807qkj.42.2022.08.27.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:58:13 -0700 (PDT)
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
Subject: [PATCH v3 4/4] tools: sync find_bit() implementation
Date:   Sat, 27 Aug 2022 10:58:07 -0700
Message-Id: <20220827175807.4017673-5-yury.norov@gmail.com>
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

Sync find_first_bit() and find_next_bit() implementation with the
mother kernel.

Also, drop unused find_last_bit() and find_next_clump8().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/linux/find.h |  61 +++------------
 tools/lib/find_bit.c       | 149 +++++++++++++++++--------------------
 2 files changed, 81 insertions(+), 129 deletions(-)

diff --git a/tools/include/linux/find.h b/tools/include/linux/find.h
index 47e2bd6c5174..38c0a542b0e2 100644
--- a/tools/include/linux/find.h
+++ b/tools/include/linux/find.h
@@ -8,21 +8,23 @@
 
 #include <linux/bitops.h>
 
-extern unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
+				unsigned long start);
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
-extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
@@ -41,7 +43,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, size, offset);
 }
 #endif
 
@@ -50,8 +52,8 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
  * find_next_and_bit - find the next set bit in both memory regions
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
@@ -71,7 +73,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_and_bit(addr1, addr2, size, offset);
 }
 #endif
 
@@ -79,8 +81,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
@@ -99,7 +101,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_zero_bit(addr, size, offset);
 }
 #endif
 
@@ -172,43 +174,4 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
-#ifndef find_last_bit
-/**
- * find_last_bit - find the last set bit in a memory region
- * @addr: The address to start the search at
- * @size: The number of bits to search
- *
- * Returns the bit number of the last set bit, or size.
- */
-static inline
-unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
-{
-	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
-
-		return val ? __fls(val) : size;
-	}
-
-	return _find_last_bit(addr, size);
-}
-#endif
-
-/**
- * find_next_clump8 - find next 8-bit clump with set bits in a memory region
- * @clump: location to store copy of found clump
- * @addr: address to base the search on
- * @size: bitmap size in number of bits
- * @offset: bit offset at which to start searching
- *
- * Returns the bit offset for the next set clump; the found clump value is
- * copied to the location pointed by @clump. If no bits are set, returns @size.
- */
-extern unsigned long find_next_clump8(unsigned long *clump,
-				      const unsigned long *addr,
-				      unsigned long size, unsigned long offset);
-
-#define find_first_clump8(clump, bits, size) \
-	find_next_clump8((clump), (bits), (size), 0)
-
-
 #endif /*__LINUX_FIND_H_ */
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index ba4b8d94e004..709d312a94ca 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -18,66 +18,54 @@
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 
-#if !defined(find_next_bit) || !defined(find_next_zero_bit) || \
-		!defined(find_next_and_bit)
-
 /*
- * This is a common helper function for find_next_bit, find_next_zero_bit, and
- * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
- *  - The optional "addr2", which is anded with "addr1" if present.
+ * Common helper for find_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
  */
-unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
-{
-	unsigned long tmp, mask;
-	(void) le;
-
-	if (unlikely(start >= nbits))
-		return nbits;
-
-	tmp = addr1[start / BITS_PER_LONG];
-	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
-
-	/* Handle 1st word. */
-	mask = BITMAP_FIRST_WORD_MASK(start);
-
-	/*
-	 * Due to the lack of swab() in tools, and the fact that it doesn't
-	 * need little-endian support, just comment it out
-	 */
-#if (0)
-	if (le)
-		mask = swab(mask);
-#endif
-
-	tmp &= mask;
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
 
-	start = round_down(start, BITS_PER_LONG);
-
-	while (!tmp) {
-		start += BITS_PER_LONG;
-		if (start >= nbits)
-			return nbits;
-
-		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
-	}
-
-#if (0)
-	if (le)
-		tmp = swab(tmp);
-#endif
-
-	return min(start + __ffs(tmp), nbits);
-}
-#endif
+/*
+ * Common helper for find_next_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ */
+#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
+({										\
+	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
+										\
+	if (unlikely(__start >= sz))						\
+		goto out;							\
+										\
+	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
+		if (idx > sz / BITS_PER_LONG)					\
+			goto out;						\
+		idx++;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
+out:										\
+	sz;									\
+})
 
 #ifndef find_first_bit
 /*
@@ -85,14 +73,7 @@ unsigned long _find_next_bit(const unsigned long *addr1,
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
 #endif
 
@@ -104,15 +85,7 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
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
 #endif
 
@@ -122,13 +95,29 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
  */
 unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
+	return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
+}
+#endif
 
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx] != ~0UL)
-			return min(idx * BITS_PER_LONG + ffz(addr[idx]), size);
-	}
+#ifndef find_next_bit
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+}
+#endif
 
-	return size;
+#ifndef find_next_and_bit
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
+}
+#endif
+
+#ifndef find_next_zero_bit
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
 }
 #endif
-- 
2.34.1


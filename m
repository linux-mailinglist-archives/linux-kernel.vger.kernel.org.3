Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43E5A395B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH0R6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH0R6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:58:16 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF02AF327F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:13 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kh8so3480264qvb.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZEsSYrJvIW9CblQ4yml8Kvt67y6IrxJVfEY8E/20bB0=;
        b=gkAe713/vxeRJyussElZ2qGv68tGjwamhaPfgGOk1ML/UgIqP0GxairADaxFuC5jo7
         zFPQHzbfUKVjiuWsbD1pcudFMVXZ9QgW7Qi/ul1M0yo+MR+MVI5aXjh8ACwAb9caPs3V
         i2rWJu2T4ujoDSrYvTqzGuOddd+vdh3W8AmDgCgK8A/t4IioqlhnZWUzobiWUQfm3QO/
         FQjxdSyuHXDPMvmAtbkY4Himac5afTdlZQKcvieBnsMgCCzcP21cnjkRUadKfMZte6Um
         6mmmdKxnCE0SmQleBzdhA10wYXcR/PbqBKHPRmJrFrT/Z4Ae5vdUJkkqIsy4JPxG0RAM
         qavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZEsSYrJvIW9CblQ4yml8Kvt67y6IrxJVfEY8E/20bB0=;
        b=AI24zz8muRNe0DxHue6Ui4S72XklN5fhRrraZ/Jt4dFRH/a5msM7n416t7avl+vCVe
         4P2WmgduSACjxHrY0y5OLs5rk9RZhxkFoor9yVP5htEEDRKSphle5U+cTW5gex1GAP+3
         x+WaybME9KXorkEOx7SdXs5J65SkgZJAV3IA/Pm9KTUEt6CRvnAM181Rqa10/CMMnquw
         4lQPHaClxk2+PmNIVF3vjW/OapS0qsrXqb7nz9FtV0iqkYSFQycI5wGLvbkjWOVt4TYt
         N3lBuwH3uBLJDDm45qYhpolv65x06MQ3FHA4QAnUbrVuWG5SoUGpDrqkkEtDej05NbLj
         E2Rw==
X-Gm-Message-State: ACgBeo0eCmX1JYP1bxxnfSnRZKXNEb+TkXKzGQdrcOzylNjeBP/CLqnt
        ix2FRr0C7SD21uiXE+LM1is=
X-Google-Smtp-Source: AA6agR7YsAWRQye40+utTHKRooGzb6wddYdixmYNANvq+sf6QfpjDRlz5trEp/a3OAeMy1TzPLjPCA==
X-Received: by 2002:ad4:5aec:0:b0:498:f40a:dcc4 with SMTP id c12-20020ad45aec000000b00498f40adcc4mr3391970qvh.115.1661623092446;
        Sat, 27 Aug 2022 10:58:12 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2454:ae5e:5655:e298])
        by smtp.gmail.com with ESMTPSA id v13-20020a05620a440d00b006bb29d932e1sm2347739qkp.105.2022.08.27.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:58:12 -0700 (PDT)
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
Subject: [PATCH v3 3/4] lib/find_bit: optimize find_next_bit() functions
Date:   Sat, 27 Aug 2022 10:58:06 -0700
Message-Id: <20220827175807.4017673-4-yury.norov@gmail.com>
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

Over the past couple years, the function _find_next_bit() was extended
with parameters that modify its behavior to implement and- zero- and le-
flavors. The parameters are passed at compile time, but current design
prevents a compiler from optimizing out the conditionals.

As find_next_bit() API grows, I expect that more parameterss will be added.
Current design would require more conditional code in _find_next_bit(),
which would bloat the helper even more and make it barely readable.

This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
a set of wrappers, so that the compile-time optimizations become possible.

The common logic is moved to the new macro, and all flavors may be
generated by providing a FETCH macro parameter, like in this example:

  #define FIND_NEXT_BIT(FETCH, MUNGE, size, start) ...

  find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
  {
	return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx],
				/* nop */, size, start);
  }

The FETCH may be of any complexity, as soon as it only refers the bitmap(s)
and an iterator idx.

MUNGE is here to support _le code generation for BE builds. May be
empty.

I ran find_bit_benchmark 16 times on top of 6.0-rc2 and 16 times on top
of this series. The results for kvm/x86_64 are:

                      v6.0-rc2  Optimized       Difference  Z-score
Random dense bitmap         ns         ns        ns      %
find_next_bit:          787735     670546    117189   14.9     3.97
find_next_zero_bit:     777492     664208    113284   14.6    10.51
find_last_bit:          830925     687573    143352   17.3     2.35
find_first_bit:        3874366    3306635    567731   14.7     1.84
find_first_and_bit:   40677125   37739887   2937238    7.2     1.36
find_next_and_bit:      347865     304456     43409   12.5     1.35

Random sparse bitmap
find_next_bit:           19816      14021      5795   29.2     6.10
find_next_zero_bit:    1318901    1223794     95107    7.2     1.41
find_last_bit:           14573      13514      1059    7.3     6.92
find_first_bit:        1313321    1249024     64297    4.9     1.53
find_first_and_bit:       8921       8098       823    9.2     4.56
find_next_and_bit:        9796       7176      2620   26.7     5.39

Where the statistics is significant (z-score > 3), the improvement
is ~15%.

According to bloat-o-meter, the Image size is 10-11K less:

x86_64/defconfig:
add/remove: 32/14 grow/shrink: 61/782 up/down: 6344/-16521 (-10177)

arm64/defconfig:
add/remove: 3/2 grow/shrink: 50/714 up/down: 608/-11556 (-10948)

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h |  23 ++++++---
 lib/find_bit.c       | 119 +++++++++++++++++++++++++------------------
 2 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index a1861d0ba533..d3b360ba428f 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -8,9 +8,12 @@
 
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
@@ -19,6 +22,10 @@ extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long siz
 
 #ifdef __BIG_ENDIAN
 unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
+unsigned long _find_next_zero_bit_le(const  unsigned long *addr, unsigned
+					long size, unsigned long offset);
+unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
+				long size, unsigned long offset);
 #endif
 
 #ifndef find_next_bit
@@ -45,7 +52,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, size, offset);
 }
 #endif
 
@@ -75,7 +82,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_and_bit(addr1, addr2, size, offset);
 }
 #endif
 
@@ -103,7 +110,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_zero_bit(addr, size, offset);
 }
 #endif
 
@@ -251,7 +258,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_zero_bit_le(addr, size, offset);
 }
 #endif
 
@@ -284,7 +291,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit_le(addr, size, offset);
 }
 #endif
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index f4d9b9684811..ba119f69f5ff 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -40,57 +40,33 @@
 	sz;									\
 })
 
-#if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
-	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
 /*
- * This is a common helper function for find_next_bit, find_next_zero_bit, and
- * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
- *  - The optional "addr2", which is anded with "addr1" if present.
+ * Common helper for find_next_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
  */
-unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
-{
-	unsigned long tmp, mask;
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
-	if (le)
-		mask = swab(mask);
-
-	tmp &= mask;
-
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
-	if (le)
-		tmp = swab(tmp);
-
-	return min(start + __ffs(tmp), nbits);
-}
-EXPORT_SYMBOL(_find_next_bit);
-#endif
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
@@ -127,6 +103,32 @@ unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
 
+#ifndef find_next_bit
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_bit);
+#endif
+
+#ifndef find_next_and_bit
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_and_bit);
+#endif
+
+#ifndef find_next_zero_bit
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_zero_bit);
+#endif
+
 #ifndef find_last_bit
 unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
 {
@@ -173,4 +175,23 @@ unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long s
 EXPORT_SYMBOL(_find_first_zero_bit_le);
 #endif
 
+#ifndef find_next_zero_bit_le
+unsigned long _find_next_zero_bit_le(const unsigned long *addr, unsigned
+		long size, unsigned long offset)
+{
+	return FIND_NEXT_BIT(~addr[idx], swab, size, offset);
+}
+EXPORT_SYMBOL(_find_next_zero_bit_le);
+#endif
+
+#ifndef find_next_bit_le
+unsigned long _find_next_bit_le(const unsigned long  *addr, unsigned
+		long size, unsigned long offset)
+{
+	return FIND_NEXT_BIT(addr[idx], swab, size, offset);
+}
+EXPORT_SYMBOL(_find_next_bit_le);
+
+#endif
+
 #endif /* __BIG_ENDIAN */
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7459F0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiHXB0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiHXB0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:26:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D017FFBF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:30 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x5so11727867qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DPa5bMY5tURbOHdsYxwkpWe9Vc0eXQVyNRUAXaTm0RM=;
        b=ZYj4dDDa6VvWs7mJs5UJQKM+v4d+S4fVIjvqSEMAVEfzxpalof6ISFSmmhm5Uup3ai
         j94Hts1JXoH6GEj8JU03IaMV3G63QGFfr6/d25DkpiOAGqnS/uVZD6o77y7zO1NAKwAw
         V9sO0BUzKIvHN3UYLezuWgDbE/K9FiX/N0CRCHXQOXiOQvgRdE0/iziuGOc74CyUcUyM
         kAOpyYv8nLRjWnRD9EGNdM750XZBlmwNDmSIpeKXaIJCwf2OaX35pYOBeYUFdVE9wVFZ
         Lal1x/Le7HaQ7wkoFitnAJq75uQRsCOujwvOcoC5SD62GU66fqRaDe7fMCIHTWCS6SlG
         /SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DPa5bMY5tURbOHdsYxwkpWe9Vc0eXQVyNRUAXaTm0RM=;
        b=O7HTnJYAzKvfJvPtjT+Wv44m19YdCeiKAg4ROMvMT32g7Yjjef3tv3/Aq2uxAvNWZm
         Bf+VNGSvNfZuqImMY89cBS8VNqWjTVZFzqJwnCWd7OB0cacS5FY0t5JsbGjf1K4tboHO
         m1b8NF16djSHRADE8AW6gh3yWgooii7AWAb9pb75Y8nRrDp3xGOCQNT6QzSdVPaDPiHE
         DS1zWcGxnh0FWeMfzK/rGnqnjFc6ugCWqrp8Jtn+9fTOMxQ91W0zjCRuxAmYTV14SJX2
         2wz9qWDRwBFHi8jBD/F+jFmAr3SStdJlQvYYdZHrjwy1nOWc8FKeZUqqIPA7q4tk55Mj
         u7mQ==
X-Gm-Message-State: ACgBeo1RRAJsYOMOfmVzZvvpvmqW3fOMVYopGdNjlnH7XW0QsGAlbB+O
        tBNTI6W1P2QCL8AQpDaDcbg=
X-Google-Smtp-Source: AA6agR7qYAkbCCIbxTcFXuRqRjg2Ds3LNATPeCSOJdAxUxvlyl6Ztk2itsq2tsDhnXEp6sXBzpRriQ==
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr21758494qtw.217.1661304389925;
        Tue, 23 Aug 2022 18:26:29 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:9de8:f9bd:9f64:5017])
        by smtp.gmail.com with ESMTPSA id u3-20020a37ab03000000b006bac157ec19sm13554019qke.123.2022.08.23.18.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:26:29 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH v2 3/3] lib/find_bit: optimize find_next_bit() functions
Date:   Tue, 23 Aug 2022 18:26:24 -0700
Message-Id: <20220824012624.2826445-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220824012624.2826445-1-yury.norov@gmail.com>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
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
Current designs would require more conditional code in _find_next_bit(),
which would bloat the helper even more and make it barely readable.

This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
a set of wrappers, so that the compile-time optimization becomes possible.

The common logic is moved to the new macro, and all flavors may be
generated by providing an EXPRESSION macro parameter, like in this example:

  #define FIND_NEXT_BIT(EXPRESSION, size, start) ...
  
  find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
  {
  	return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx], size, start);
  }

The EXPRESSION may be of any complexity, as soon as it only refers
the bitmap(s) and an iterator idx.

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
Checkpatch warns that the FIND_NEXT_BIT() is a "Macros with flow
control statements", but in this case I think it's false positive
because the label is defined in the same code block as the 'goto'
statement, and control can't flow out of the block.

 include/linux/find.h | 23 ++++++++-----
 lib/find_bit.c       | 78 +++++++++++++++-----------------------------
 lib/find_bit.h       | 21 ++++++++++++
 lib/find_bit_be.c    | 19 +++++++++++
 4 files changed, 81 insertions(+), 60 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 2464bff5de04..dead6f53a97b 100644
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
index ccc4fb1dfc71..357750d25ff9 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -21,58 +21,6 @@
 
 #include "find_bit.h"
 
-#if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
-	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
-/*
- * This is a common helper function for find_next_bit, find_next_zero_bit, and
- * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
- *  - The optional "addr2", which is anded with "addr1" if present.
- */
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
-
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
@@ -108,6 +56,32 @@ unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
 
+#ifndef find_next_bit
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], nbits, start);
+}
+EXPORT_SYMBOL(_find_next_bit);
+#endif
+
+#ifndef find_next_and_bit
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], nbits, start);
+}
+EXPORT_SYMBOL(_find_next_and_bit);
+#endif
+
+#ifndef find_next_zero_bit
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], nbits, start);
+}
+EXPORT_SYMBOL(_find_next_zero_bit);
+#endif
+
 #ifndef find_last_bit
 unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
 {
diff --git a/lib/find_bit.h b/lib/find_bit.h
index b4b6245ddbf6..6b6312f93301 100644
--- a/lib/find_bit.h
+++ b/lib/find_bit.h
@@ -21,4 +21,25 @@
 	sz;									\
 })
 
+#define FIND_NEXT_BIT(EXPRESSION, size, start)					\
+({										\
+	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
+										\
+	if (unlikely(__start >= sz))						\
+		goto out;							\
+										\
+	mask = word_op(BITMAP_FIRST_WORD_MASK(__start));			\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (EXPRESSION) & mask; !tmp; tmp = (EXPRESSION)) {		\
+		if (idx > sz / BITS_PER_LONG)					\
+			goto out;						\
+		idx++;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + __ffs(word_op(tmp)), sz);		\
+out:										\
+	sz;									\
+})
+
 #endif /* _LIB_FIND_BIT_H */
diff --git a/lib/find_bit_be.c b/lib/find_bit_be.c
index 36173cb7e012..cbf669aaf3cb 100644
--- a/lib/find_bit_be.c
+++ b/lib/find_bit_be.c
@@ -21,3 +21,22 @@ unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long s
 }
 EXPORT_SYMBOL(_find_first_zero_bit_le);
 #endif
+
+#ifndef find_next_zero_bit_le
+unsigned long _find_next_zero_bit_le(const unsigned long *addr, unsigned
+		long size, unsigned long offset)
+{
+	return FIND_NEXT_BIT(~addr[idx], size, offset);
+}
+EXPORT_SYMBOL(_find_next_zero_bit_le);
+#endif
+
+#ifndef find_next_bit_le
+unsigned long _find_next_bit_le(const unsigned long  *addr, unsigned
+		long size, unsigned long offset)
+{
+	return FIND_NEXT_BIT(addr[idx], size, offset);
+}
+EXPORT_SYMBOL(_find_next_bit_le);
+
+#endif
-- 
2.34.1


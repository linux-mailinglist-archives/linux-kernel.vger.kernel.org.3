Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E589C5691A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGFSXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiGFSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:23:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51927275DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ck6so19426498qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcIiYRUAkK4hThsiTUmcop0uj0NkU+EnxuUcvjeiwcw=;
        b=PfDnBaOf9rzqGm8iXPrycR1x+cGtlYAYfxRqPqbkAACdi8hIvPUpaak9PRr3rtVpjt
         xiVVI5XpP1c+k7HKpSE1Ly079Dw5r4Z6MXuQ3FtGCOjtGzrKSZwYqJMDAoct76RQVyRR
         QsTyNK2RSXrnhSL4qPhI4P7M8ltqtOVar4UKYcxFkq69E1iMOe7wN5TIbOVdm3fuh+Si
         t1TAj++2+VfHxN3xoQXIK4o8Dah8jxheRulwm4bRXhUUfWA3wPLFnB+o7VU3AgP060gY
         LvjFxCpVzAwII+FV/G2obR3QZpeWQhv5PnyPtchaD63oCvH5u3yfFIKklHN1bHjftHlu
         fivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcIiYRUAkK4hThsiTUmcop0uj0NkU+EnxuUcvjeiwcw=;
        b=buZO0cIEAVB+0SDXvIeqlB6H/BL4/pBvg+ApEoba+kYaV4Re0hAr9ZO2hLydCVJfPe
         hr7iORO59BKbO0S+C7yOb3W4L6I04LsPeofyr/D1cxwcQquoBSxj1GpVFNK2BbwZ7gt9
         tT92SZ1tDKf7ZYOS1vlymZSsfDp53NjEC30mFnuYfkNM/DQCtVO57FKzcSHnG8lWTIrQ
         CMmy+dwv5eZQfVuL3h93HUtCmID6nhcoPnkSjij0qxs+450l9BoKBb/zv68IxNn6yPJN
         9SFeIA/QgsI03ydvU3O9m6QRBDpachD1MifDEl0wcAtJlDFe+cdns9PJUSI4ONLlvNvp
         wcyg==
X-Gm-Message-State: AJIora/KJ14kWyHz+NMh1pz1ld8BAeLoL54hCCk3Qq3FGDrf3HF0iFaD
        neJ8tr3Qs2T6PvvvVvMABhBibTOWfk2trQ==
X-Google-Smtp-Source: AGRyM1s4/Oompt0Y1loOAPg2Pry4nWKDsKMkqnqHtOmUpMzV0ZX2xJrG/qavihtlYy7V4KYIDq7D2w==
X-Received: by 2002:a05:622a:386:b0:31d:4c75:6f63 with SMTP id j6-20020a05622a038600b0031d4c756f63mr14466710qtx.404.1657131783280;
        Wed, 06 Jul 2022 11:23:03 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id b14-20020ac84f0e000000b00317c3ce1f4esm24299121qte.45.2022.07.06.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:23:03 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/5] lib: add find_nth(,and,andnot)_bit()
Date:   Wed,  6 Jul 2022 11:22:56 -0700
Message-Id: <20220706182300.70862-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706182300.70862-1-yury.norov@gmail.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
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

Kernel lacks for a function that searches for Nth bit in a bitmap.
Usually people do it like this:
	for_each_set_bit(bit, mask, size)
		if (--n == 0)
			return bit;

We can do it more efficiently, if we:
1. find a word containing Nth bit, using hweight(); and
2. find the bit, using a helper fns(), that works similarly to
   __ffs() and ffz().

fns() is implemented as a simple loop. For x86_64, there's PDEP instruction
to do that: ret = clz(pdep(1 << idx, num)). However, for large bitmaps the
most of improvement comes from using hweight(), so I kept fns() simple.

New find_nth_bit() is ~70 times faster on x86_64/kvm:
for_each_bit:                  7154190 ns,  16411 iterations
find_nth_bit:                505493126 ns,  16315 iterations

With all that, a family of 3 new functions is added, and used where
appropriate in the following patches.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h | 19 ++++++++++
 include/linux/find.h   | 79 ++++++++++++++++++++++++++++++++++++++++++
 lib/find_bit.c         | 20 +++++++++++
 3 files changed, 118 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 7aaed501f768..86072cfcbe17 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -196,6 +196,25 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+/**
+ * fns - find N'th set bit in a 64 bit word
+ * @word: The 64 bit word
+ * @n: Bit to find
+ */
+static inline unsigned long fns(unsigned long word, unsigned int n)
+{
+	unsigned int bit;
+
+	while (word) {
+		bit = __ffs(word);
+		if (--n == 0)
+			return bit;
+		__clear_bit(bit, &word);
+	}
+
+	return BITS_PER_LONG;
+}
+
 /**
  * assign_bit - Assign value to a bit in memory
  * @nr: the bit to set
diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..00a24bc596d0 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -12,6 +12,8 @@ extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+unsigned long _find_nth_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n, bool not);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -125,6 +127,83 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+/**
+ * find_nth_bit - find N'th set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
+{
+	if (n == 0 || n > size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return _find_nth_bit(addr, NULL, size, n, false);
+}
+
+/**
+ * find_nth_and_bit - find N'th set bit in 2 memory regions
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n == 0 || n > size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return _find_nth_bit(addr1, addr2, size, n, false);
+}
+
+/**
+ * find_nth_andnot_bit - find N'th set bit in 2 memory regions,
+ *			 flipping bits in 2nd region
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n == 0 || n > size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return _find_nth_bit(addr1, addr2, size, n, true);
+}
+
 #ifndef find_first_and_bit
 /**
  * find_first_and_bit - find the first set bit in both memory regions
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..7b8ad12c8cc7 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -89,6 +89,26 @@ unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 EXPORT_SYMBOL(_find_first_bit);
 #endif
 
+unsigned long _find_nth_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n, bool not)
+{
+	unsigned long val, idx, w;
+
+	for (idx = 0; idx * BITS_PER_LONG < size; idx++, n -= w) {
+		val = addr1[idx];
+		if (addr2)
+			val &= not ? ~addr2[idx] : addr2[idx];
+
+		w = hweight_long(val);
+		if (w >= n)
+			return min(idx * BITS_PER_LONG + fns(val, n), size);
+	}
+
+	return size;
+
+}
+EXPORT_SYMBOL(_find_nth_bit);
+
 #ifndef find_first_and_bit
 /*
  * Find the first set bit in two memory regions.
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D956D404
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiGKErW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGKErR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:47:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216C460CF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l2so2534980qtp.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZljeIHUIZz/AYIvotC3sgnaLGYxeJANre/U+XxdNdA=;
        b=P23YvmhWiMAPTJw+rKMkN2HA8Cesa0rn1BCnKhKzrDbh31j1Rf5QyHkjd711eEoK2o
         wRSZtUO/traXd1NgZ88DZmVpSsQwR0InKbTROHq4VdzAHyyEk6JD6EBGb6n/pUFLFlLD
         gONHelEW+PwrMmY1bDub5nLKSpBPTp7R4fr0y8AAftjjkcN/VeyqASAEMzaGojETax1X
         l3zXza+FC6KwebxLef3v2R7jMwGoZDtCW/CFGiePrt/MnMQ0CiG/4iGYK5ZcV2y1QkUR
         ZDzRVORYddWZzQpy3tpwfcoIcW3jcwSR1daipZlrNp5t59JCPGFxJDYckkJM21Qr+JNu
         5y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZljeIHUIZz/AYIvotC3sgnaLGYxeJANre/U+XxdNdA=;
        b=WMiEqFPSc2xK3J/Zwi8mptjhRFLlbirv777Vw/XqA/Tl/LMaDEnOlW7zcdrHmSKEar
         EOHN61Vcc0g+7pI7umN1JqmGql/7WkKcCwM3fI3ewjJbsiqfNRAPMa8FawIFqJHdkL6I
         PhJn5toJ4sooofMfZq24+qjwI4r/qDZQZ1exyIYb8d/ivVPMqEuukVdI7FA5eMwlK4za
         4/H1lNykZ7NxyXM2Yi4ofWHo06AgBdIhos2ZKgxkKVXBvbeuP8eOOBaXplkNldaTIX3h
         Ii0wyu4YrNNlBZFu+TL2TJM6tkLAy5x4v7JwH9Cdz9+7OQXJzDRaw+KuASux6/HFxhoK
         Weqw==
X-Gm-Message-State: AJIora/OOWMNAzsuncN9+A/rgWbAenXxGhp/vh/CBYlzNI7esTNXtLFK
        k64Xb+f1S+c3QaCLtYQ+criljAfpCIRdAw==
X-Google-Smtp-Source: AGRyM1sbgh3+9R+FabG7KyjNcVKDAoyQ0uthQPfVRjBogNTUJl4rQUZUIXtJ3RTvfC7WpcobPdskRA==
X-Received: by 2002:ac8:7e8d:0:b0:31e:b5cd:4cf2 with SMTP id w13-20020ac87e8d000000b0031eb5cd4cf2mr2006603qtj.37.1657514835006;
        Sun, 10 Jul 2022 21:47:15 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:a22e:180:f963:1eff])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006b58b806745sm1477941qkp.43.2022.07.10.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:47:14 -0700 (PDT)
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
Date:   Sun, 10 Jul 2022 21:47:07 -0700
Message-Id: <20220711044711.466822-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
References: <20220711044711.466822-1-yury.norov@gmail.com>
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
find_nth_bit:                  7154190 ns,  16411 iterations
for_each_bit:                505493126 ns,  16315 iterations

With all that, a family of 3 new functions is added, and used where
appropriate in the following patches.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h | 19 ++++++++++
 include/linux/find.h   | 83 ++++++++++++++++++++++++++++++++++++++++++
 lib/find_bit.c         | 20 ++++++++++
 3 files changed, 122 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf9bf65039f2..8b2189878afa 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -246,6 +246,25 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+/**
+ * fns - find N'th set bit in a word
+ * @word: The word to search
+ * @n: Bit to find
+ */
+static inline unsigned long fns(unsigned long word, unsigned int n)
+{
+	unsigned int bit;
+
+	while (word) {
+		bit = __ffs(word);
+		if (n-- == 0)
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
index 424ef67d4a42..4c7f82dcc38a 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -12,6 +12,8 @@ extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+unsigned long _find_nth_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n, unsigned long invert);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -125,6 +127,87 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+/**
+ * find_nth_bit - find N'th set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * The following is semantically equivalent:
+ *	 idx = find_nth_bit(addr, size, 0);
+ *	 idx = find_first_bit(addr, size);
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return _find_nth_bit(addr, NULL, size, n, 0UL);
+}
+
+/**
+ * find_nth_and_bit - find N'th set bit in 2 memory regions
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return _find_nth_bit(addr1, addr2, size, n, 0UL);
+}
+
+/**
+ * find_nth_andnot_bit - find N'th set bit in 2 memory regions,
+ *			 flipping bits in 2nd region
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return _find_nth_bit(addr1, addr2, size, n, ~0UL);
+}
+
 #ifndef find_first_and_bit
 /**
  * find_first_and_bit - find the first set bit in both memory regions
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..43cb1f781056 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -89,6 +89,26 @@ unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 EXPORT_SYMBOL(_find_first_bit);
 #endif
 
+unsigned long _find_nth_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n, unsigned long invert)
+{
+	unsigned long val, idx, w;
+
+	for (idx = 0; idx * BITS_PER_LONG < size; idx++, n -= w) {
+		val = addr1[idx];
+		if (addr2)
+			val &= addr2[idx] ^ invert;
+
+		w = hweight_long(val);
+		if (w > n)
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


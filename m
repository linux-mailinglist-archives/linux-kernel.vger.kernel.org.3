Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F568497497
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiAWSl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiAWSlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DAC061775
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so18254996pjj.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y8ExfgOcgrA4CHmSecZvjPn/xavwnyrvtMRh3tqxxrw=;
        b=l53CvIarxDvrY/yoGsTqTp5a0/SfJI+CVqIBS/RZYOF/qD3Ntc15R0IX4/lby6qtWI
         jGZa8A9L0I8+vAoOofqFnB5LaPUDcxF64aMCojsV+iFSNF4362teiDOo6tIAT0Rvjnow
         t7sB0r9MqGQs0HvbUzP0MbNsZgpBmifd+HOFVn8vKQSsRfhivO9XfdSlFSR/IPfiNVjB
         2Yf8wYUQMHYKkb+shQFMEl/YFTDS34zm8JwJbsaqX0s+LTs5ubgc66hFcRAXhzGdaGf1
         eGRoXaxS8D2LBVkMeNuoO97VtU07aOv3KJHWFG29eBjbxZ88z53HCatKTmbUa7BFnMG4
         OnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8ExfgOcgrA4CHmSecZvjPn/xavwnyrvtMRh3tqxxrw=;
        b=eGA6kSj7m94hZn1B/PkytgnjwEN5j+je56DAbzV2TueGnJitQbh/iaV6UOpYy4wGqL
         5gYVihziV8gESfbr/n6K+8bV4+iZN32RSzpkq2QGL9fM4G7HvI6Xq6GbSP4LR69z+49/
         2J/j2D26QMADe94z9igA9UitjR6am2mzbIb3ypUixLQF9/sH/fqRcQNXV3SNYORjcj68
         Awx2wezqEBEOhU0VzpJ5a4e0pt5O9QnKvK2VbjoPiPPm8nTH1kga5gvD4zTvP6B75iII
         ysqMgBJm2jBtQNMRHSU+Zu/22XU+TrHklbIYUfTP/jvijxByCHW3kQzpxEMIqCUO7D+e
         wq3w==
X-Gm-Message-State: AOAM530D9hSDsTbFhOFQ6n3OmOoOf1TO5Pc742JSBOc1EQ1ERIyM+5rI
        PsTEaffc+TPkMtg7ZxXOkss=
X-Google-Smtp-Source: ABdhPJz9SuBXgihhtCBKqzwQSz+uocSqzMEBrT3ksigclxhUAX3fZgY+2I3/rO0dTsOO9uFovRNhFQ==
X-Received: by 2002:a17:903:1250:b0:149:907d:afdc with SMTP id u16-20020a170903125000b00149907dafdcmr11769772plh.59.1642963273387;
        Sun, 23 Jan 2022 10:41:13 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id p18sm14538141pfh.98.2022.01.23.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:13 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions
Date:   Sun, 23 Jan 2022 10:38:58 -0800
Message-Id: <20220123183925.1052919-28-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many kernel users use bitmap_weight() to compare the result against
some number or expression:

	if (bitmap_weight(...) > 1)
		do_something();

It works OK, but may be significantly improved for large bitmaps: if
first few words count set bits to a number greater than given, we can
stop counting and immediately return.

The same idea would work in other direction: if we know that the number
of set bits that we counted so far is small enough, so that it would be
smaller than required number even if all bits of the rest of the bitmap
are set, we can stop counting earlier.

This patch adds new bitmap_weight_cmp() as suggested by Michał Mirosław
and a family of eq, gt, ge, lt and le wrappers to allow this optimization.
The following patches apply new functions where appropriate.

Suggested-by: "Michał Mirosław" <mirq-linux@rere.qmqm.pl> (for bitmap_weight_cmp)
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 80 ++++++++++++++++++++++++++++++++++++++++++
 lib/bitmap.c           | 21 +++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7dba0847510c..708e57b32362 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -51,6 +51,12 @@ struct device;
  *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
  *  bitmap_full(src, nbits)                     Are all bits set in *src?
  *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
+ *  bitmap_weight_cmp(src, nbits)               compare Hamming Weight with a number
+ *  bitmap_weight_eq(src, nbits, num)           Hamming Weight == num
+ *  bitmap_weight_gt(src, nbits, num)           Hamming Weight >  num
+ *  bitmap_weight_ge(src, nbits, num)           Hamming Weight >= num
+ *  bitmap_weight_lt(src, nbits, num)           Hamming Weight <  num
+ *  bitmap_weight_le(src, nbits, num)           Hamming Weight <= num
  *  bitmap_set(dst, pos, nbits)                 Set specified bit area
  *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
  *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
@@ -162,6 +168,7 @@ int __bitmap_intersects(const unsigned long *bitmap1,
 int __bitmap_subset(const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int nbits);
 int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
+int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int bits, int num);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -403,6 +410,79 @@ static __always_inline int bitmap_weight(const unsigned long *src, unsigned int
 	return __bitmap_weight(src, nbits);
 }
 
+/**
+ * bitmap_weight_cmp - compares number of set bits in @src with @num.
+ * @src:   source bitmap
+ * @nbits: length of bitmap in bits
+ * @num:   number to compare with
+ *
+ * As opposite to bitmap_weight() this function doesn't necessarily
+ * traverse full bitmap and may return earlier.
+ *
+ * Returns zero if weight of @src is equal to @num;
+ *	   negative number if weight of @src is less than @num;
+ *	   positive number if weight of @src is greater than @num;
+ *
+ * NOTES
+ *
+ * Because number of set bits cannot decrease while counting, when user
+ * wants to know if the number of set bits in the bitmap is less than
+ * @num, calling
+ *	bitmap_weight_cmp(..., @num) < 0
+ * is potentially less effective than
+ *	bitmap_weight_cmp(..., @num - 1) <= 0
+ *
+ * Consider an example:
+ * bitmap_weight_cmp(1000 0000 0000 0000, 1) < 0
+ *				    ^
+ *				    stop here
+ *
+ * bitmap_weight_cmp(1000 0000 0000 0000, 0) <= 0
+ *		     ^
+ *		     stop here
+ */
+static __always_inline
+int bitmap_weight_cmp(const unsigned long *src, unsigned int nbits, int num)
+{
+	if (num > (int)nbits || num < 0)
+		return -num;
+
+	if (small_const_nbits(nbits))
+		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits)) - num;
+
+	return __bitmap_weight_cmp(src, nbits, num);
+}
+
+static __always_inline
+bool bitmap_weight_eq(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num) == 0;
+}
+
+static __always_inline
+bool bitmap_weight_gt(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num) > 0;
+}
+
+static __always_inline
+bool bitmap_weight_ge(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num - 1) > 0;
+}
+
+static __always_inline
+bool bitmap_weight_lt(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num - 1) <= 0;
+}
+
+static __always_inline
+bool bitmap_weight_le(const unsigned long *src, unsigned int nbits, int num)
+{
+	return bitmap_weight_cmp(src, nbits, num) <= 0;
+}
+
 static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		unsigned int nbits)
 {
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 926408883456..fb84ca70c5d9 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -348,6 +348,27 @@ int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 }
 EXPORT_SYMBOL(__bitmap_weight);
 
+int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int bits, int num)
+{
+	unsigned int k, w, lim = bits / BITS_PER_LONG;
+
+	for (k = 0, w = 0; k < lim; k++) {
+		if (w + bits - k * BITS_PER_LONG < num)
+			goto out;
+
+		w += hweight_long(bitmap[k]);
+
+		if (w > num)
+			goto out;
+	}
+
+	if (bits % BITS_PER_LONG)
+		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
+out:
+	return w - num;
+}
+EXPORT_SYMBOL(__bitmap_weight_cmp);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
-- 
2.30.2


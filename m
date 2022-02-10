Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40EC4B19CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiBJXtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:49:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbiBJXtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:49:17 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBA2675
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:49:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h7so9487226iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2cLL6GgieOi8PSHYt1Oj179zJLe2EJ32f4QVxiwhrqo=;
        b=a5GbJPLgc4uajvB15v596nI+6UEwqRoTDFrUKemBv8TQBFWA5FTKz0vURTzG3bIQav
         6Uo3KwPYtPg9WM5SOfVnW1gZZEYGoJRfl4J9jja0X/H/LN6i3DZmvvVGXL0beOF1veWX
         XK54fNnfnjn3AlggVgBpbLlw/EBHNurXTE5XoFOsWykX9w6mOb+bme6S7hfp2gEdG2kb
         IkVrpF/bzjS7au4UF8Ylj1S/lrPOn8Uq2nrMOxiO8HmiG9CQzsJ+MSsTf/U8hzEaYy0i
         ZlwDE/tqw56A234JdLK4/CKgISg55ij+Ewz3sKPFrVUYb7FWbY4GfXi+CXaXL+ATnTLW
         t+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cLL6GgieOi8PSHYt1Oj179zJLe2EJ32f4QVxiwhrqo=;
        b=r2HK+6NivxxcjHh3Xu6Be0sBKLNKjfQLKRn4uDJ+55zPkHdiJF+YcgiCHUCWK7VbHI
         xTImXDo4t0ZpqdJs0taf+4z520iChWzo9qa6PmHqP7skwaNIMARWbSUWRtWj70E4taHu
         +H1jf5vf9CdyDWRFFymP2wNC6f/ATj4RiXFw2f+9/6Wd7s8Hmq+yc2I7Lv0ZNn6qONrY
         onbHtMnSk0XZK5RLeDwHtTb5SYMnc+aGQILDbZYt2dchKrMirr6la3W9D+Phvo+RSbTc
         0eMM+1SfTayvMd+uQ+vJzbQggbjFr2DZyHl1vg+ymiBV+afluExa3uXhAJuSeCSKvi4W
         RMgA==
X-Gm-Message-State: AOAM533P18xEgxjYhZYznWphADTZXsu+5ImVQJszdB5dsoftDkPF/keA
        CuGN278KWunAFMyWpzTx1bI=
X-Google-Smtp-Source: ABdhPJxIjSyathMj2m6V4TRCgp/Or81uA26s7EOPH7C4cGg8mcV+gXDI5+rYpe4/og7fG3sxY22MRQ==
X-Received: by 2002:a05:6638:38a3:: with SMTP id b35mr5392270jav.180.1644536957205;
        Thu, 10 Feb 2022 15:49:17 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id i3sm11859959ilu.28.2022.02.10.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:49:16 -0800 (PST)
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
Subject: [PATCH 26/49] bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions
Date:   Thu, 10 Feb 2022 14:49:10 -0800
Message-Id: <20220210224933.379149-27-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
and a family of eq, gt, ge, lt, and le wrappers to allow this optimization.
The following patches apply new functions where appropriate.

Suggested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl> (for bitmap_weight_cmp)
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/bitmap.h | 78 ++++++++++++++++++++++++++++++++++++++++++
 lib/bitmap.c           | 21 ++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7dba0847510c..a89b626d0fbe 100644
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
 
@@ -403,6 +410,77 @@ static __always_inline int bitmap_weight(const unsigned long *src, unsigned int
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
+ *
+ * Returns: zero if weight of @src is equal to @num;
+ *	   negative number if weight of @src is less than @num;
+ *	   positive number if weight of @src is greater than @num.
+ */
+static __always_inline
+int bitmap_weight_cmp(const unsigned long *src, unsigned int nbits, int num)
+{
+	if ((unsigned int)num > nbits)
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
2.32.0


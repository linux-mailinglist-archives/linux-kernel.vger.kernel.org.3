Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1559A573B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiGMQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGMQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:32:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284C2B604;
        Wed, 13 Jul 2022 09:32:21 -0700 (PDT)
Received: from localhost (dynamic-002-247-252-243.2.247.pool.telefonica.de [2.247.252.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B99A660191C;
        Wed, 13 Jul 2022 17:32:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657729940;
        bh=dIzwKmgbXSEkeJxn4p/FQB/B/V+b2M0cBePpVdA5mgE=;
        h=From:To:Cc:Subject:Date:From;
        b=iku7kOjHUvAD7+D/BODOjWHZslQRXb7UfbF1HSjv41HaCqGg0CpgjSenu50rlKn1d
         2db/FNN8L6TrGdl1rw5QfrLh5QN8SvdbKXlb0ZNDgN/R2qNvlAjcYwQhbWorgr2L7V
         ZL+LO4rmvAMh569pyL1jatslnrmQHdjfJigouTs310LHCdTrMBIdOn7m9Fj89T14r2
         xb3fbgJUNLVFvxo5zGGl6CREebx30q44PXVp87jJkxwE4M7//JVQxPnPPUesQqnrgI
         nxHhzY7gumtvkffVS6kgM3hHF/2/U0v6eIrFnwIphbwwzIYF86WuxCtvwDxXGSU5dk
         JNw8+9GWDK97A==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, knaerzche@gmail.com,
        kernel@collabora.com, bob.beckett@collabora.com,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        nicolas.dufresne@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/6] bitops: bitmap helper to set variable length values
Date:   Wed, 13 Jul 2022 18:31:59 +0200
Message-Id: <20220713163201.136202-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper to set variable length values within a bitmap, that can
overflow the borders of a single BITS_PER_LONG container.
This function makes it easier to write values to hardware memory blobs that
do not require alignment.

Add tests to the lib/test_bitmap.c kselftest module to verify proper function.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 include/linux/bitmap.h | 40 +++++++++++++++++++++++++++++++++++
 lib/test_bitmap.c      | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2e6cd5681040..9f8d635b70a9 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -76,6 +76,7 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_set_value(map, value, start, nbits)  Set a variable length value to map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -573,6 +574,45 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_set_value - set a variable length value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: the variable length value
+ * @start: bit offset of the value
+ * @length: Length of the value
+ */
+static inline void bitmap_set_value(unsigned long *map, unsigned long value,
+				    unsigned long start, unsigned char length)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	int diff_to_max = 0;
+
+	if (!length)
+		return;
+
+
+	if (length < BITS_PER_LONG)
+		value &= (BIT(length) - 1);
+
+	while (length > 0) {
+		diff_to_max = BITS_PER_LONG - offset;
+		map[index] &= ~((BIT(length) - 1) << offset);
+		if (length > diff_to_max) {
+			unsigned long tmp = value & (BIT(diff_to_max) - 1);
+
+			map[index] |= tmp << offset;
+			value >>= diff_to_max;
+			length -= diff_to_max;
+			index += 1;
+			offset = 0;
+		} else {
+			map[index] |= value << offset;
+			length = 0;
+		}
+	}
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index d5923a640457..509317ad2f72 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -869,6 +869,53 @@ static void __init test_bitmap_print_buf(void)
 	}
 }
 
+struct test_bitmap_set_value_sample {
+	unsigned long value[2];
+	unsigned char length[2];
+	unsigned int offset[2];
+	unsigned long expected[2][2];
+	int amount;
+};
+
+static const struct test_bitmap_set_value_sample test_set[] __initconst = {
+	/* Check that multiple values can be chained up */
+	{ {10, 20}, {4, 5}, {0, 4}, {{10, 330}}, 2 },
+	/* Check that a value can be set across two BITS_PER_LONG chunks */
+	{ {10, 6}, {4, 3}, {0, 63}, {{10, 10}, {0, 3}}, 2 },
+	/* Set a value with length shorter than the given length */
+	{ {3, 6}, {4, 10}, {0, 4}, {{3, 99}}, 1 },
+	/* Set a value with length longer than the given length */
+	{ {15}, {2}, {0}, {{3}}, 1 },
+	/* Check that values are properly overwritten */
+	{ {15, 12}, {4, 4}, {0, 2}, {{15, 51}}, 2 },
+	/* Check that a set without a length doesn't change anything */
+	{ {10}, {0}, {0}, {{0}}, 1 },
+};
+
+static void __init test_bitmap_set_value(void)
+{
+	int i, j, k;
+	int correct_tests = 0;
+
+	for (i = 0; i < ARRAY_SIZE(test_set); i++) {
+		const struct test_bitmap_set_value_sample *t = &test_set[i];
+		int test_correct = 1;
+		DECLARE_BITMAP(map, BITS_PER_LONG * 2);
+
+		bitmap_zero(map, BITS_PER_LONG * 2);
+		for (j = 0; j < t->amount; j++) {
+			bitmap_set_value(map, t->value[j], t->offset[j], t->length[j]);
+			for (k = 0; k < 2; k++) {
+				if (expect_eq_uint(map[k], t->expected[k][j]))
+					test_correct = 0;
+			}
+		}
+		if (test_correct)
+			correct_tests += 1;
+	}
+	pr_err("set_value: %d/%ld tests correct\n", correct_tests, ARRAY_SIZE(test_set));
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -884,6 +931,7 @@ static void __init selftest(void)
 	test_for_each_set_clump8();
 	test_bitmap_cut();
 	test_bitmap_print_buf();
+	test_bitmap_set_value();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.25.1


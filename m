Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05ED52F15C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352081AbiETROj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiETROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:14:37 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA217EC2F;
        Fri, 20 May 2022 10:14:33 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 3E1A05FD03;
        Fri, 20 May 2022 20:14:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653066870;
        bh=pCWkDncfsTciRddN3utkCe6O4gEiHr5b5mlVcFn2DAE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=jfCfh/rIkBGR3l83zkXb8iSl3QwiKQWUGy+Z73Qi50Tc4gVUyILIgnpZdxNS+wGe3
         vH9VgLxk6BhSw/nDlxTaaUrD+lAp1JqeTI7KXwoKPbBa4/y+Q3GyVMS6cdWQMW35sp
         evlVcrxVdniGw44YuX1o7b7lu0nY/liD52BR9jh0V4AB+fdKD87HevakN+vK7uxuYF
         j0D1sFmE8ncOTSp9cS5AJibFDsDbi6FZ77qzVObvu4swEMGW0HhyLJZB8B3qB5qPen
         Uy53syLjogSOILbwp002xbXnrSDz78gLBB9xn51fxdKPESzb+OInLBUdrYKtzPh9jq
         IZvbP0yRIiryw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 20 May 2022 20:14:19 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <senozhatsky@chromium.org>, <linux-block@vger.kernel.org>,
        <axboe@chromium.org>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <mnitenko@gmail.com>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1] zram: experimental patch with entropy calculation
Date:   Fri, 20 May 2022 20:13:09 +0300
Message-ID: <20220520171309.26768-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/20 11:51:00 #19507404
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option CONFIG_ZRAM_ENTROPY which calculates
the information entropy for each page. If the entropy is higher
than the CONFIG_ZRAM_ENTROPY_THRESHOLD parameter, then
the page is stored uncompressed.

This is some attempt to strike a balance between page processing
time and compression. This might be relevant for systems that can
lose a bit in compression and gain a lot in performance effort.

I did some experiments (writing different files directly to /dev/zram0)
and got this:

+---------+-----------+------------+--------+--------------+------------+
| entropy | orig_size | compr_size |  time  | instructions | branches   |
+---------+-----------+------------+--------+--------------+------------+
|    Y    | 407003136 | 406052541  | 0.572s | 4641658347   | 784918702  |
+---------+-----------+------------+--------+--------------+------------+
|    N    | 407003136 | 405371829  | 2.098s | 17187405320  | 2027130210 |
+---------+-----------+------------+--------+--------------+------------+

apk file (~430MB):

+---------+-----------+------------+--------+--------------+------------+
| entropy | orig_size | compr_size |  time  | instructions | branches   |
+---------+-----------+------------+--------+--------------+------------+
|    Y    | 431452160 | 335864766  | 1.632s | 13055231312  | 1747341252 |
+---------+-----------+------------+--------+--------------+------------+
|    N    | 431452160 | 289107700  | 3.196s | 24345720313  | 2846272508 |
+---------+-----------+------------+--------+--------------+------------+

folder with various files as .tar (but not compressed) (~5GB):

+---------+-----------+------------+--------+--------------+------------+
| entropy | orig_size | compr_size |  time  | instructions | branches   |
+---------+-----------+------------+--------+--------------+------------+
|    Y    | 5277380608| 4230903173 | 7.066s | 35039839769  | 5636707902 |
+---------+-----------+------------+--------+--------------+------------+
|    N    | 5277380608| 4216479361 | 11.955s| 76763123464  | 9497319788 |
+---------+-----------+------------+--------+--------------+------------+

Page processing time is noticeably accelerated, while compression loss
is not very critical.

I guess the CONFIG_ZRAM_ENTROPY_THRESHOLD setting should be
different for each of the compression algorithms. At the moment,
I have configured it only for the zstd algorithm, but in the future
I plan to configure and test it for all remaining compression algorithms.

Comments are welcome.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/block/zram/Kconfig    | 18 ++++++++++++++++
 drivers/block/zram/zram_drv.c | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 668c6bf25..d873d631a 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -77,3 +77,21 @@ config ZRAM_MEMORY_TRACKING
 	  /sys/kernel/debug/zram/zramX/block_state.
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
+
+config ZRAM_ENTROPY
+	bool "Use entropy optimization for zram"
+	depends on ZRAM && ZRAM_DEF_COMP_ZSTD
+	help
+	  With this feature, entropy will be calculated for each page.
+	  Pages above ZRAM_ENTROPY_THRESHOLD entropy will be
+	  stored uncompressed. Use this feature if you need a performance
+	  boost and a small loss in compression.
+
+config ZRAM_ENTROPY_THRESHOLD
+	int
+	depends on ZRAM && ZRAM_ENTROPY
+	default 100000 if ZRAM_DEF_COMP_ZSTD
+	help
+	  Pages with entropy above ZRAM_ENTROPY_THRESHOLD will be stored
+	  uncompressed. The default value was chosen as a result a lot of
+	  experiments. You can try set your own value.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cb253d80d..483b219a4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1350,6 +1350,35 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	return ret;
 }
 
+
+#ifdef CONFIG_ZRAM_ENTROPY
+static inline u32 ilog2_w(u64 n)
+{
+	return ilog2(n * n * n * n);
+}
+
+static inline s32 shannon_entropy(const u8 *src)
+{
+	s32 entropy_sum = 0;
+	u32 sz_base, i;
+	u16 entropy_count[256] = { 0 };
+
+	for (i = 0; i < PAGE_SIZE; ++i)
+		entropy_count[src[i]]++;
+
+	sz_base = ilog2_w(PAGE_SIZE);
+	for (i = 0; i < ARRAY_SIZE(entropy_count); ++i) {
+		if (entropy_count[i] > 0) {
+			s32 p = entropy_count[i];
+
+			entropy_sum += p * (sz_base - ilog2_w((u64)p));
+		}
+	}
+
+	return entropy_sum;
+}
+#endif
+
 static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 				u32 index, struct bio *bio)
 {
@@ -1376,7 +1405,17 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 compress_again:
 	zstrm = zcomp_stream_get(zram->comp);
 	src = kmap_atomic(page);
+
+#ifdef CONFIG_ZRAM_ENTROPY
+	/* Just save this page uncompressible */
+	if (shannon_entropy((const u8 *)src) > CONFIG_ZRAM_ENTROPY_THRESHOLD)
+		comp_len = PAGE_SIZE;
+	else
+		ret = zcomp_compress(zstrm, src, &comp_len);
+#else
 	ret = zcomp_compress(zstrm, src, &comp_len);
+#endif
+
 	kunmap_atomic(src);
 
 	if (unlikely(ret)) {
-- 
2.30.2


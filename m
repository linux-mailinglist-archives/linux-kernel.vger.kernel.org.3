Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF82C519D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbiEDLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348523AbiEDLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:08:40 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDDA245AF;
        Wed,  4 May 2022 04:05:00 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 02CF75FD03;
        Wed,  4 May 2022 14:04:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1651662296;
        bh=hp4dZx7e7B5x52z+YxyWS6SnKYtRvgq3EAaeLq15SDs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=X/t9SQjjkOtxRknL2/11yTGGnCdaQdeC3Rgdc4Cfz2kZbMdv0Fhw3K1njpK77wv4W
         2AQoNDg9pMVfi2xP6mPvTkexgH2spsvBfmkQXzGka+wc4emY56FlJZ8+5YnJo7c8zO
         jAQsSjhVlapJDRWuRWb102Y7x40zEuZi8DjCmTFaY/c4QSc2KGBrdC0OlMRBo2l200
         KQ0yRKfQh5fp1lhxCzwk910D9PTT/w5hJBBjhcOk/Q0CUVYaGubpb7r95CQYc/YhSQ
         zzrsdZsr/OcT8QaYNLSbweXAFbJ0Ijj9ljdeDpBCpSgzaLpyy5BGsumsLYggPNtrIw
         CfdSORLyHNHGw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  4 May 2022 14:04:54 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <senozhatsky@chromium.org>, <linux-block@vger.kernel.org>
CC:     <axboe@chromium.org>, <kernel@sberdevices.ru>,
        <linux-kernel@vger.kernel.org>, <mnitenko@gmail.com>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v3] zram: remove double compression logic
Date:   Wed, 4 May 2022 14:04:42 +0300
Message-ID: <20220504110442.59685-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/04 08:31:00 #19348425
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2nd trial allocation under per-cpu presumption has been
used to prevent regression of allocation failure. However, it
makes trouble for maintenance without significant benefit.
The slowpath branch is executed extremely rarely: getting
there is problematic. Therefore, we delete this branch.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c | 40 ++++++++---------------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cb253d80d72b..2eb614769d9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1153,9 +1153,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu %8llu\n",
+			"version: %d\n%8llu\n",
 			version,
-			(u64)atomic64_read(&zram->stats.writestall),
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
@@ -1373,7 +1372,6 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	}
 	kunmap_atomic(mem);
 
-compress_again:
 	zstrm = zcomp_stream_get(zram->comp);
 	src = kmap_atomic(page);
 	ret = zcomp_compress(zstrm, src, &comp_len);
@@ -1382,39 +1380,20 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comp);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
 		return ret;
 	}
 
 	if (comp_len >= huge_class_size)
 		comp_len = PAGE_SIZE;
-	/*
-	 * handle allocation has 2 paths:
-	 * a) fast path is executed with preemption disabled (for
-	 *  per-cpu streams) and has __GFP_DIRECT_RECLAIM bit clear,
-	 *  since we can't sleep;
-	 * b) slow path enables preemption and attempts to allocate
-	 *  the page with __GFP_DIRECT_RECLAIM bit set. we have to
-	 *  put per-cpu compression stream and, thus, to re-do
-	 *  the compression once handle is allocated.
-	 *
-	 * if we have a 'non-null' handle here then we are coming
-	 * from the slow path and handle has already been allocated.
-	 */
-	if (!handle)
-		handle = zs_malloc(zram->mem_pool, comp_len,
-				__GFP_KSWAPD_RECLAIM |
-				__GFP_NOWARN |
-				__GFP_HIGHMEM |
-				__GFP_MOVABLE);
-	if (!handle) {
+
+	handle = zs_malloc(zram->mem_pool, comp_len,
+			__GFP_KSWAPD_RECLAIM |
+			__GFP_NOWARN |
+			__GFP_HIGHMEM |
+			__GFP_MOVABLE);
+
+	if (unlikely(!handle)) {
 		zcomp_stream_put(zram->comp);
-		atomic64_inc(&zram->stats.writestall);
-		handle = zs_malloc(zram->mem_pool, comp_len,
-				GFP_NOIO | __GFP_HIGHMEM |
-				__GFP_MOVABLE);
-		if (handle)
-			goto compress_again;
 		return -ENOMEM;
 	}
 
@@ -1975,7 +1954,6 @@ static int zram_add(void)
 	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
-	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
 	ret = device_add_disk(NULL, zram->disk, zram_disk_groups);
 	if (ret)
 		goto out_cleanup_disk;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 80c3b43b4828..158c91e54850 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -81,7 +81,6 @@ struct zram_stats {
 	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
-	atomic64_t writestall;		/* no. of write slow paths */
 	atomic64_t miss_free;		/* no. of missed free */
 #ifdef	CONFIG_ZRAM_WRITEBACK
 	atomic64_t bd_count;		/* no. of pages in backing device */
-- 
2.30.1


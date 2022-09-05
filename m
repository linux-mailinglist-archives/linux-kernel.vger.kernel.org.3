Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669AC5ACD7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiIEIQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiIEIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827831210
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so6532699pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I2ruIR+eUek6TMRHPcruq5I+ZauP5l3LGhFsa5khFHo=;
        b=IM7kr5YyvZ1mL8tsdTY4PZheVIPX9onG/a+BHEfgT+AZ0ZaQhYPG/axEtxPIqNWc5Y
         i7sNmeZI0syhyrkIKiGcEtPmYK3F/DDSMA5WZdNYi89aTIPeIpqIeKD/SU1q9G2nmTRC
         zOpHpRflIVjx8TZLwC7X56XEbq1Nd7pPSjCJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I2ruIR+eUek6TMRHPcruq5I+ZauP5l3LGhFsa5khFHo=;
        b=5IhTvgo4fk68zcaOKcRT6fJ3ZNM816GQ97Q/g31YRerB9syAu1JNYDsEthouoUdMiv
         F2w/xvu0kyvaC+WiQEkTborRLUxDkUY5XMP5NzKnyqUUlwbcBWoGQx/mYzPeXFl3Uaa0
         gRF9Uulk+Kv7sLaTE8H2WIxm14/MTlQgkLPXL6U4a6OU9ZdwxaunswTqFN68FJcAmf7v
         iF8pOXAL9rSXYigRhCh64gbcNzFU5DBPrS7zg6vE5evNtPRxxtXYf80SOs4WtLDkD8RL
         +kKkU5Hj7jm3VeJLX6p0bMByhRUxeKOHwd80Pai835Wr/Qg6vOv8NwEVVwpwLbArL4cr
         g06w==
X-Gm-Message-State: ACgBeo1ELYR6KZssq5DRXrjP2xbDr7zRgIzcPbuXcPVsyTsk8x4i+aIr
        NP95VP9i413qDDECWuiNKyOvaFbD373pfA==
X-Google-Smtp-Source: AA6agR4hxH9sIyrvGKKZEBqs9Y5dd/0GdD0qq2iYOl3w/4eSiQr2vaHulEgHOTx/0yhuWdda5/EuHg==
X-Received: by 2002:a17:90b:3810:b0:1fd:d001:ed41 with SMTP id mq16-20020a17090b381000b001fdd001ed41mr17989056pjb.209.1662365768891;
        Mon, 05 Sep 2022 01:16:08 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:08 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 1/7] zram: Preparation for multi-zcomp support
Date:   Mon,  5 Sep 2022 17:15:44 +0900
Message-Id: <20220905081552.2740917-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220905081552.2740917-1-senozhatsky@chromium.org>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch turns compression streams and compressor algorithm
name struct zram members into arrays, so that we can have
multiple compression streams support (in the next patches).

The patch uses a rather explicit API for compressor selection:

- Get primary (default) compression stream
	zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP])
- Get secondary compression stream
	zcomp_stream_get(zram->comps[ZRAM_SECONDARY_ZCOMP])

We use similar API for compression streams put().

At this point we always have just one compression stream,
since CONFIG_ZRAM_MULTI_COMP is not yet defined.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    |  6 +--
 drivers/block/zram/zcomp.h    |  2 +-
 drivers/block/zram/zram_drv.c | 87 ++++++++++++++++++++++++-----------
 drivers/block/zram/zram_drv.h | 14 +++++-
 4 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 0916de952e09..55af4efd7983 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -206,7 +206,7 @@ void zcomp_destroy(struct zcomp *comp)
  * case of allocation error, or any other error potentially
  * returned by zcomp_init().
  */
-struct zcomp *zcomp_create(const char *compress)
+struct zcomp *zcomp_create(const char *alg)
 {
 	struct zcomp *comp;
 	int error;
@@ -216,14 +216,14 @@ struct zcomp *zcomp_create(const char *compress)
 	 * is not loaded yet. We must do it here, otherwise we are about to
 	 * call /sbin/modprobe under CPU hot-plug lock.
 	 */
-	if (!zcomp_available_algorithm(compress))
+	if (!zcomp_available_algorithm(alg))
 		return ERR_PTR(-EINVAL);
 
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
 
-	comp->name = compress;
+	comp->name = alg;
 	error = zcomp_init(comp);
 	if (error) {
 		kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420f4b2e..cdefdef93da8 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -27,7 +27,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
 bool zcomp_available_algorithm(const char *comp);
 
-struct zcomp *zcomp_create(const char *comp);
+struct zcomp *zcomp_create(const char *alg);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 607f4634c27d..4ad1daa1283e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1018,36 +1018,53 @@ static ssize_t comp_algorithm_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->compressor, buf);
+	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_ZCOMP], buf);
 	up_read(&zram->init_lock);
 
 	return sz;
 }
 
+static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
+{
+	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
+	if (zram->comp_algs[idx] != default_compressor)
+		kfree(zram->comp_algs[idx]);
+	zram->comp_algs[idx] = alg;
+}
+
 static ssize_t comp_algorithm_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	char compressor[ARRAY_SIZE(zram->compressor)];
+	char *compressor;
 	size_t sz;
 
-	strlcpy(compressor, buf, sizeof(compressor));
+	sz = strlen(buf);
+	if (sz >= CRYPTO_MAX_ALG_NAME)
+		return -E2BIG;
+
+	compressor = kstrdup(buf, GFP_KERNEL);
+	if (!compressor)
+		return -ENOMEM;
+
 	/* ignore trailing newline */
-	sz = strlen(compressor);
 	if (sz > 0 && compressor[sz - 1] == '\n')
 		compressor[sz - 1] = 0x00;
 
-	if (!zcomp_available_algorithm(compressor))
+	if (!zcomp_available_algorithm(compressor)) {
+		kfree(compressor);
 		return -EINVAL;
+	}
 
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
 		up_write(&zram->init_lock);
+		kfree(compressor);
 		pr_info("Can't change algorithm for initialized device\n");
 		return -EBUSY;
 	}
 
-	strcpy(zram->compressor, compressor);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, compressor);
 	up_write(&zram->init_lock);
 	return len;
 }
@@ -1292,7 +1309,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	size = zram_get_obj_size(zram, index);
 
 	if (size != PAGE_SIZE)
-		zstrm = zcomp_stream_get(zram->comp);
+		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
@@ -1304,7 +1321,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
 	zram_slot_unlock(zram, index);
@@ -1371,13 +1388,13 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	kunmap_atomic(mem);
 
 compress_again:
-	zstrm = zcomp_stream_get(zram->comp);
+	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 	src = kmap_atomic(page);
 	ret = zcomp_compress(zstrm, src, &comp_len);
 	kunmap_atomic(src);
 
 	if (unlikely(ret)) {
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 		pr_err("Compression failed! err=%d\n", ret);
 		zs_free(zram->mem_pool, handle);
 		return ret;
@@ -1405,7 +1422,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 				__GFP_HIGHMEM |
 				__GFP_MOVABLE);
 	if (IS_ERR((void *)handle)) {
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
@@ -1422,14 +1439,14 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		 * It is necessary that the dereferencing of the zstrm variable below
 		 * occurs correctly.
 		 */
-		zstrm = zcomp_stream_get(zram->comp);
+		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 	}
 
 	alloced_pages = zs_get_total_pages(zram->mem_pool);
 	update_used_max(zram, alloced_pages);
 
 	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
-		zcomp_stream_put(zram->comp);
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
@@ -1443,7 +1460,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	if (comp_len == PAGE_SIZE)
 		kunmap_atomic(src);
 
-	zcomp_stream_put(zram->comp);
+	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 out:
@@ -1718,6 +1735,20 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 
+static void zram_destroy_comps(struct zram *zram)
+{
+	u32 idx;
+
+	for (idx = 0; idx < ZRAM_MAX_ZCOMPS; idx++) {
+		struct zcomp *comp = zram->comps[idx];
+
+		zram->comps[idx] = NULL;
+		if (IS_ERR_OR_NULL(comp))
+			continue;
+		zcomp_destroy(comp);
+	}
+}
+
 static void zram_reset_device(struct zram *zram)
 {
 	down_write(&zram->init_lock);
@@ -1735,11 +1766,11 @@ static void zram_reset_device(struct zram *zram)
 	/* I/O operation under all of CPU are done so let's free */
 	zram_meta_free(zram, zram->disksize);
 	zram->disksize = 0;
+	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(zram->comp);
-	zram->comp = NULL;
 	reset_bdev(zram);
 
+	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, default_compressor);
 	up_write(&zram->init_lock);
 }
 
@@ -1750,6 +1781,7 @@ static ssize_t disksize_store(struct device *dev,
 	struct zcomp *comp;
 	struct zram *zram = dev_to_zram(dev);
 	int err;
+	u32 idx;
 
 	disksize = memparse(buf, NULL);
 	if (!disksize)
@@ -1768,22 +1800,25 @@ static ssize_t disksize_store(struct device *dev,
 		goto out_unlock;
 	}
 
-	comp = zcomp_create(zram->compressor);
-	if (IS_ERR(comp)) {
-		pr_err("Cannot initialise %s compressing backend\n",
-				zram->compressor);
-		err = PTR_ERR(comp);
-		goto out_free_meta;
-	}
+	for (idx = 0; idx < ZRAM_MAX_ZCOMPS; idx++) {
+		comp = zcomp_create(zram->comp_algs[idx]);
+		if (IS_ERR(comp)) {
+			pr_err("Cannot initialise %s compressing backend\n",
+			       zram->comp_algs[idx]);
+			err = PTR_ERR(comp);
+			goto out_free_comps;
+		}
 
-	zram->comp = comp;
+		zram->comps[idx] = comp;
+	}
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
 
 	return len;
 
-out_free_meta:
+out_free_comps:
+	zram_destroy_comps(zram);
 	zram_meta_free(zram, disksize);
 out_unlock:
 	up_write(&zram->init_lock);
@@ -1979,7 +2014,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] = default_compressor;
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 80c3b43b4828..af3d6f6bfcff 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -90,10 +90,20 @@ struct zram_stats {
 #endif
 };
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+#define ZRAM_PRIMARY_ZCOMP	0
+#define ZRAM_SECONDARY_ZCOMP	1
+#define ZRAM_MAX_ZCOMPS	2
+#else
+#define ZRAM_PRIMARY_ZCOMP	0
+#define ZRAM_SECONDARY_ZCOMP	0
+#define ZRAM_MAX_ZCOMPS	1
+#endif
+
 struct zram {
 	struct zram_table_entry *table;
 	struct zs_pool *mem_pool;
-	struct zcomp *comp;
+	struct zcomp *comps[ZRAM_MAX_ZCOMPS];
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
 	struct rw_semaphore init_lock;
@@ -108,7 +118,7 @@ struct zram {
 	 * we can store in a disk.
 	 */
 	u64 disksize;	/* bytes */
-	char compressor[CRYPTO_MAX_ALG_NAME];
+	const char *comp_algs[ZRAM_MAX_ZCOMPS];
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.37.2.789.g6183377224-goog


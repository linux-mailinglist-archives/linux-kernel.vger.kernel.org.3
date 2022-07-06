Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4E05688D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiGFM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiGFM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:59:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D5013CF4;
        Wed,  6 Jul 2022 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7aDyRZmkdehbwIBCE+bYJ93MBgETOZ67dlDDnmZJolg=; b=tauXaberCCsvn6Q2aA/dnj8vj7
        oDLbLfWW64tgH6OWFc3nVGAoJr8R9Qy7xlS6D05cwJczsOZJnu//KOegymLp5mMhe/GjUDR94YP1F
        snh4Silo/tP6XepF2o+eyS5nf1ahR7WVAqccUzOhbbgEWpopyYvXhgqKIjaAVPuhMKFsSvpY6foBR
        gCsCxYJ8FXWKjV75p0nhdlA5TZxb5jhjbXfVhsGP5MDX1jSu83XCRW5l2G9r+14aW0bmgLSYRatRm
        fPCQbzw85CkwRprXh8H0T9XArhP0yad2s3Tn3c3wJa7i2lsxmvUQpjxxqRPhpoM1P+iPxfE2q9dGy
        wzA9R9Ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o94cX-00A6tT-6v; Wed, 06 Jul 2022 12:59:09 +0000
Date:   Wed, 6 Jul 2022 05:59:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Message-ID: <YsWHHcCfSVFklh4M@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

thanks for picking up this work again.

I think we can simply the blk filter concept quite a bit:

 a) we only need one filter driver, at last for now
 b) we don't need an extra lock and can just rely on freezing
    the queue and a cmpxchg for attach/detach

The benefit is that there is basically no I/O path overhead now, and
the cod is so simple that we don't need a new config option.

This is untested, and actually breaks blksnap, although I've left
comments in there to fix it after adjusting it enough to at least
compile.  Let me know if this makes sense to you, and I'll try to
come up with comments on the blksnap code as well.

diff --git a/block/Kconfig b/block/Kconfig
index 83472a07822ab..444c5ab3b67e2 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -224,14 +224,6 @@ config BLK_MQ_RDMA
 config BLK_PM
 	def_bool PM
 
-config BLK_FILTER
-	bool "Enable block device filters"
-	default n
-	help
-	  Enabling this lets the block layer filters handle bio requests.
-	  Kernel modules can use this feature to extend the functionality
-	  of the block layer.
-
 # do not use in new code
 config BLOCK_HOLDER_DEPRECATED
 	bool
diff --git a/block/bdev.c b/block/bdev.c
index 4bcd9f4378e3b..2db19ed899baa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -12,6 +12,7 @@
 #include <linux/major.h>
 #include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
+#include <linux/blk-filter.h>
 #include <linux/blk-integrity.h>
 #include <linux/backing-dev.h>
 #include <linux/module.h>
@@ -426,15 +427,13 @@ static void init_once(void *data)
 	inode_init_once(&ei->vfs_inode);
 }
 
-#ifdef CONFIG_BLK_FILTER
-static void bdev_filter_cleanup(struct block_device *bdev);
-#endif
-
 static void bdev_evict_inode(struct inode *inode)
 {
-#ifdef CONFIG_BLK_FILTER
-	bdev_filter_cleanup(I_BDEV(inode));
-#endif
+	struct bdev_filter *flt = I_BDEV(inode)->bd_filter;
+
+	if (flt)
+		flt->ops->detach(flt);
+
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
@@ -510,11 +509,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
-
-#ifdef CONFIG_BLK_FILTER
-	memset(bdev->bd_filters, 0, sizeof(bdev->bd_filters));
-	spin_lock_init(&bdev->bd_filters_lock);
-#endif
 	return bdev;
 }
 
@@ -1084,119 +1078,45 @@ void sync_bdevs(bool wait)
 	iput(old_inode);
 }
 
-#ifdef CONFIG_BLK_FILTER
-static void bdev_filter_cleanup(struct block_device *bdev)
-{
-	int altitude;
-	struct bdev_filter *flt;
-
-	for (altitude = 0; altitude < bdev_filter_alt_end; altitude++) {
-		spin_lock(&bdev->bd_filters_lock);
-		flt = bdev->bd_filters[altitude];
-		bdev->bd_filters[altitude] = NULL;
-		spin_unlock(&bdev->bd_filters_lock);
-
-		bdev_filter_put(flt);
-	}
-}
-
 /**
- * bdev_filter_attach - Attach a filter to the original block device.
- * @bdev:
- *	Block device.
- * @name:
- *	Name of the block device filter.
- * @altitude:
- *	Altituda number of the block device filter.
- * @flt:
- *	Pointer to the filter structure.
- *
- * Before adding a filter, it is necessary to initialize &struct bdev_filter.
- *
- * The bdev_filter_detach() function allows to detach the filter from the block
- * device.
- *
- * Return:
- * 0 - OK
- * -EALREADY - a filter with this name already exists
+ * bdev_filter_attach - attach a filter to a block device
+ * @bdev:	block device to attach to
+ * @flt:	filter to attach
  */
-int bdev_filter_attach(struct block_device *bdev, const char *name,
-		       const enum bdev_filter_altitudes altitude,
-		       struct bdev_filter *flt)
+int bdev_filter_attach(struct block_device *bdev, struct bdev_filter *flt)
 {
-	int ret = 0;
+	struct bdev_filter *old;
 
-	spin_lock(&bdev->bd_filters_lock);
-	if (bdev->bd_filters[altitude])
-		ret = -EALREADY;
-	else
-		bdev->bd_filters[altitude] = flt;
-	spin_unlock(&bdev->bd_filters_lock);
+	blk_mq_freeze_queue(bdev_get_queue(bdev));
+	old = cmpxchg(&bdev->bd_filter, NULL, flt);
+	blk_mq_unfreeze_queue(bdev_get_queue(bdev));
 
-	if (!ret)
-		pr_info("block device filter '%s' has been attached to %d:%d",
-			name, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	if (old)
+		return -EALREADY;
 
-	return ret;
+	pr_info("block device filter '%s' has been attached to %pg",
+		flt->ops->name, bdev->bd_disk);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(bdev_filter_attach);
 
 /**
- * bdev_filter_detach - Detach a filter from the block device.
- * @bdev:
- *	Block device.
- * @name:
- *	Name of the block device filter.
- * @altitude:
- *	Altituda number of the block device filter.
- *
- * The filter should be added using the bdev_filter_attach() function.
- *
- * Return:
- * 0 - OK
- * -ENOENT - the filter was not found in the linked list
+ * bdev_filter_detach - detach a filter a the block device.
+ * @bdev:	block device to detach from
+ * @flt:	filter to detach
  */
-int bdev_filter_detach(struct block_device *bdev, const char *name,
-		       const enum bdev_filter_altitudes altitude)
+void bdev_filter_detach(struct block_device *bdev, struct bdev_filter *flt)
 {
-	struct bdev_filter *flt = NULL;
+	struct bdev_filter *old;
 
-	spin_lock(&bdev->bd_filters_lock);
-	flt = bdev->bd_filters[altitude];
-	bdev->bd_filters[altitude] = NULL;
-	spin_unlock(&bdev->bd_filters_lock);
+	blk_mq_freeze_queue(bdev_get_queue(bdev));
+	old = cmpxchg(&bdev->bd_filter, flt, NULL);
+	blk_mq_unfreeze_queue(bdev_get_queue(bdev));
 
-	if (!flt)
-		return -ENOENT;
+	if (old != flt)
+		return;
 
-	bdev_filter_put(flt);
-	pr_info("block device filter '%s' has been detached from %d:%d",
-		name, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
-	return 0;
+	pr_info("block device filter '%s' has been detached from %pg",
+		flt->ops->name, bdev->bd_disk);
 }
 EXPORT_SYMBOL_GPL(bdev_filter_detach);
-
-/**
- * bdev_filter_get_by_altitude - Get filter by altitude.
- * @bdev:
- *	Pointer to the block device structure.
- *
- * Return:
- * pointer - pointer to filters structure from &struct blk_filter
- * NULL - no filter has been set
- */
-struct bdev_filter *bdev_filter_get_by_altitude(struct block_device *bdev,
-				const enum bdev_filter_altitudes altitude)
-{
-	struct bdev_filter *flt;
-
-	spin_lock(&bdev->bd_filters_lock);
-	flt = bdev->bd_filters[altitude];
-	if (flt)
-		bdev_filter_get(flt);
-	spin_unlock(&bdev->bd_filters_lock);
-
-	return flt;
-}
-EXPORT_SYMBOL_GPL(bdev_filter_get_by_altitude);
-#endif
diff --git a/block/blk-core.c b/block/blk-core.c
index cbe004a2b8bdf..b2b55a26ad682 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/blk-filter.h>
 #include <linux/blk-pm.h>
 #include <linux/blk-integrity.h>
 #include <linux/highmem.h>
@@ -701,85 +702,31 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 		__submit_bio_noacct(bio);
 }
 
-#ifdef CONFIG_BLK_FILTER
-
-/**
- * __filter_bio() - Process bio by the block device filter.
- * @flt:
- *	Block device filter.
- * @bio:
- *	Original I/O unit.
- *
- * Return:
- * bdev_filter_pass - original bio should be submitted
- * bdev_filter_skip - do not submit original bio
- * bdev_filter_redirect - repeat bio processing for another block device
- */
-static inline enum bdev_filter_result __filter_bio(struct bdev_filter *flt,
-						   struct bio *bio)
+static bool bio_call_filter(struct bio *bio)
 {
+	struct block_device *bdev = bio->bi_bdev;
+	struct bdev_filter *flt = bdev->bd_filter;
 	enum bdev_filter_result result;
-	struct bio *new_bio;
-	struct bio_list bio_list[2] = { };
 
-	do {
-		bio_list_init(&bio_list[0]);
-		current->bio_list = bio_list;
+	if (bio_flagged(bio, BIO_FILTERED))
+		return true;
 
-		result = flt->fops->submit_bio_cb(bio, flt);
+	do {
+		struct bio_list bio_list[2] = { };
+		struct bio *new_bio;
 
+		current->bio_list = bio_list;
+		result = flt->ops->submit_bio(bio, flt);
 		current->bio_list = NULL;
 
 		while ((new_bio = bio_list_pop(&bio_list[0]))) {
 			bio_set_flag(new_bio, BIO_FILTERED);
 			submit_bio_noacct(new_bio);
 		};
-	} while (result == bdev_filter_repeat);
-
-	return result;
-}
-
-/**
- * filter_bio() - Pass bio to the block device filters.
- * @bio:
- *	Original I/O unit.
- *
- * Return:
- * true - original bio should be submitted
- * false - do not submit original bio
- */
-static bool filter_bio(struct bio *bio)
-{
-	enum bdev_filter_result result = bdev_filter_pass;
+	} while (result == BIO_FILTER_REPEAT);
 
-	if (bio_flagged(bio, BIO_FILTERED))
-		return true;
-	do {
-		struct block_device *bdev = bio->bi_bdev;
-		unsigned int altitude = 0;
-
-		while (altitude < bdev_filter_alt_end) {
-			struct bdev_filter *flt;
-
-			spin_lock(&bdev->bd_filters_lock);
-			flt = bdev->bd_filters[altitude];
-			if (flt)
-				bdev_filter_get(flt);
-			spin_unlock(&bdev->bd_filters_lock);
-
-			if (flt) {
-				result = __filter_bio(flt, bio);
-				bdev_filter_put(flt);
-				if (result != bdev_filter_pass)
-					break;
-			}
-			altitude++;
-		}
-	} while (result == bdev_filter_redirect);
-
-	return (result == bdev_filter_pass);
+	return result == BIO_FILTER_PASS;
 }
-#endif
 
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
@@ -814,14 +761,14 @@ void submit_bio_noacct(struct bio *bio)
 		goto end_io;
 	if (unlikely(bio_check_ro(bio)))
 		goto end_io;
-#ifdef CONFIG_BLK_FILTER
+
 	/*
-	 * It looks like should_fail_bio() and bio_check_ro() can be placed
-	 * in a separate block device filter for debugging.
+	 * Call the filter driver if there is one, and return if it consumed the
+	 * bio.
 	 */
-	if (!filter_bio(bio))
+	if (unlikely(bdev->bd_filter && !bio_call_filter(bio)))
 		goto end_io;
-#endif
+
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
index 8588a89e30ad3..6f5ead17d4fac 100644
--- a/drivers/block/blksnap/Kconfig
+++ b/drivers/block/blksnap/Kconfig
@@ -6,7 +6,6 @@
 
 config BLK_SNAP
 	tristate "Block device snapshot and change tracker module"
-	depends on BLK_FILTER
 	help
 	  Allow to create snapshots and track block changes for a block
 	  devices. Designed for creating backups for any block devices
diff --git a/drivers/block/blksnap/tracker.c b/drivers/block/blksnap/tracker.c
index 705e64321cb29..aefac9e369ef5 100644
--- a/drivers/block/blksnap/tracker.c
+++ b/drivers/block/blksnap/tracker.c
@@ -58,11 +58,18 @@ void tracker_free(struct tracker *tracker)
 	refcount_dec(&trackers_counter);
 }
 
+/*
+ * XXX: this API needs to go away, filter drivers need to keep track of their
+ * instances.  Even if blksnap wants to index by the dev_t it could trivially
+ * do thatwith e.g. an xarray.
+ */
+extern struct bdev_filter *bdev_filter_get_by_bdev(struct block_device *bdev);
+
 struct tracker *tracker_get_by_dev(struct block_device *bdev)
 {
 	struct bdev_filter *flt;
 
-	flt = bdev_filter_get_by_altitude(bdev, bdev_filter_alt_blksnap);
+	flt = bdev_filter_get_by_bdev(bdev);
 	if (IS_ERR(flt))
 		return ERR_PTR(PTR_ERR(flt));
 	if (!flt)
@@ -70,10 +77,10 @@ struct tracker *tracker_get_by_dev(struct block_device *bdev)
 	return container_of(flt, struct tracker, flt);
 }
 
-static enum bdev_filter_result tracker_submit_bio_cb(struct bio *bio,
+static enum bdev_filter_result tracker_submit_bio(struct bio *bio,
 		struct bdev_filter *flt)
 {
-	enum bdev_filter_result ret = bdev_filter_pass;
+	enum bdev_filter_result ret = BIO_FILTER_PASS;
 	struct tracker *tracker = container_of(flt, struct tracker, flt);
 	int err;
 	sector_t sector;
@@ -83,7 +90,7 @@ static enum bdev_filter_result tracker_submit_bio_cb(struct bio *bio,
 	if (bio->bi_opf & REQ_NOWAIT) {
 		if (!percpu_down_read_trylock(&tracker_submit_lock)) {
 			bio_wouldblock_error(bio);
-			return bdev_filter_skip;
+			return BIO_FILTER_SKIP;
 		}
 	} else
 		percpu_down_read(&tracker_submit_lock);
@@ -118,7 +125,7 @@ static enum bdev_filter_result tracker_submit_bio_cb(struct bio *bio,
 	if (unlikely(err)) {
 		if (err == -EAGAIN) {
 			bio_wouldblock_error(bio);
-			ret = bdev_filter_skip;
+			ret = BIO_FILTER_SKIP;
 		} else
 			pr_err("Failed to copy data to diff storage with error %d\n", abs(err));
 
@@ -131,7 +138,7 @@ static enum bdev_filter_result tracker_submit_bio_cb(struct bio *bio,
 	 * be sent and returned to complete the processing of the original bio.
 	 */
 	if (!bio_list_empty(current->bio_list) && (bio->bi_opf & REQ_SYNC))
-		ret = bdev_filter_repeat;
+		ret = BIO_FILTER_REPEAT;
 out:
 	percpu_up_read(&tracker_submit_lock);
 	return ret;
@@ -157,9 +164,8 @@ static void tracker_release_work(struct work_struct *work)
 	} while (tracker);
 }
 
-static void tracker_detach_cb(struct kref *kref)
+static void tracker_detach(struct bdev_filter *flt)
 {
-	struct bdev_filter *flt = container_of(kref, struct bdev_filter, kref);
 	struct tracker *tracker = container_of(flt, struct tracker, flt);
 
 	spin_lock(&tracker_release_worker.lock);
@@ -170,8 +176,9 @@ static void tracker_detach_cb(struct kref *kref)
 }
 
 static const struct bdev_filter_operations tracker_fops = {
-	.submit_bio_cb = tracker_submit_bio_cb,
-	.detach_cb = tracker_detach_cb
+	.name		= KBUILD_MODNAME,
+	.submit_bio	= tracker_submit_bio,
+	.detach		= tracker_detach
 };
 
 static int tracker_filter_attach(struct block_device *bdev,
@@ -191,8 +198,7 @@ static int tracker_filter_attach(struct block_device *bdev,
 			 MINOR(bdev->bd_dev));
 	}
 
-	ret = bdev_filter_attach(bdev, KBUILD_MODNAME, bdev_filter_alt_blksnap,
-				 &tracker->flt);
+	ret = bdev_filter_attach(bdev, &tracker->flt);
 	if (is_frozen) {
 		if (thaw_bdev(bdev))
 			pr_err("Failed to thaw device [%u:%u]\n",
@@ -209,9 +215,9 @@ static int tracker_filter_attach(struct block_device *bdev,
 	return ret;
 }
 
-static int tracker_filter_detach(struct block_device *bdev)
+static int tracker_filter_detach(struct block_device *bdev,
+				 struct tracker *tracker)
 {
-	int ret;
 	bool is_frozen = false;
 
 	pr_debug("Tracker delete filter\n");
@@ -224,7 +230,8 @@ static int tracker_filter_detach(struct block_device *bdev)
 			 MINOR(bdev->bd_dev));
 	}
 
-	ret = bdev_filter_detach(bdev, KBUILD_MODNAME, bdev_filter_alt_blksnap);
+	bdev_filter_detach(bdev, &tracker->flt);
+	// XXX: this now manually need to call ->detach
 
 	if (is_frozen) {
 		if (thaw_bdev(bdev))
@@ -235,10 +242,7 @@ static int tracker_filter_detach(struct block_device *bdev)
 				 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
 	}
 
-	if (ret)
-		pr_err("Failed to detach filter from device [%u:%u]\n",
-		       MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
-	return ret;
+	return 0;
 }
 
 static struct tracker *tracker_new(struct block_device *bdev)
@@ -257,7 +261,7 @@ static struct tracker *tracker_new(struct block_device *bdev)
 	memory_object_inc(memory_object_tracker);
 #endif
 	refcount_inc(&trackers_counter);
-	bdev_filter_init(&tracker->flt, &tracker_fops);
+	tracker->flt.ops = &tracker_fops;
 	INIT_LIST_HEAD(&tracker->link);
 	atomic_set(&tracker->snapshot_is_taken, false);
 	tracker->dev_id = bdev->bd_dev;
@@ -447,7 +451,8 @@ struct tracker *tracker_create_or_get(dev_t dev_id)
 		 * a ref counter value of 2. This allows not to detach
 		 * the filter when the snapshot is released.
 		 */
-		bdev_filter_get(&tracker->flt);
+//		XXX: do manual refcouting here
+//		bdev_filter_get(&tracker->flt);
 
 		spin_lock(&tracked_device_lock);
 		list_add_tail(&tr_dev->link, &tracked_device_list);
@@ -497,7 +502,7 @@ int tracker_remove(dev_t dev_id)
 		goto put_tracker;
 	}
 
-	ret = tracker_filter_detach(bdev);
+	ret = tracker_filter_detach(bdev, tracker);
 	if (ret)
 		pr_err("Failed to remove tracker from device [%u:%u]\n",
 		       MAJOR(dev_id), MINOR(dev_id));
diff --git a/drivers/block/blksnap/tracker.h b/drivers/block/blksnap/tracker.h
index a9b0bec7b6016..9567e06a646c6 100644
--- a/drivers/block/blksnap/tracker.h
+++ b/drivers/block/blksnap/tracker.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/rwsem.h>
 #include <linux/blkdev.h>
+#include <linux/blk-filter.h>
 #include <linux/fs.h>
 
 struct cbt_map;
@@ -48,8 +49,9 @@ void tracker_unlock(void);
 
 static inline void tracker_put(struct tracker *tracker)
 {
-	if (likely(tracker))
-		bdev_filter_put(&tracker->flt);
+//	XXX: do manual refcountig here
+//	if (likely(tracker))
+//		bdev_filter_put(&tracker->flt);
 };
 
 struct tracker *tracker_get_by_dev(struct block_device *bdev);
diff --git a/include/linux/blk-filter.h b/include/linux/blk-filter.h
new file mode 100644
index 0000000000000..868be7be0b789
--- /dev/null
+++ b/include/linux/blk-filter.h
@@ -0,0 +1,33 @@
+#ifndef _LINUX_BLK_FILTER_H
+#define _LINUX_BLK_FILTER_H
+
+struct bio;
+struct block_device;
+struct bdev_filter;
+
+enum bdev_filter_result {
+	/* Normal bio submission continues: */
+	BIO_FILTER_PASS,
+	/* Bio is consumed by the filter driver: */
+	BIO_FILTER_SKIP,
+	/* Call into the filter driver again: */
+	BIO_FILTER_REPEAT,
+};
+
+struct bdev_filter_operations {
+	const char *name;
+	/* called from submit_bio() */
+	enum bdev_filter_result (*submit_bio)(struct bio *bio,
+			struct bdev_filter *flt);
+	/* called when the block device goes away */
+	void (*detach)(struct bdev_filter *flt);
+};
+
+struct bdev_filter {
+	const struct bdev_filter_operations *ops;
+};
+
+int bdev_filter_attach(struct block_device *bdev, struct bdev_filter *flt);
+void bdev_filter_detach(struct block_device *bdev, struct bdev_filter *flt);
+
+#endif /* _LINUX_BLK_FILTER_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b88f506ea59e1..a8b3833dc1240 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -37,23 +37,6 @@ struct bio_crypt_ctx;
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
-#ifdef CONFIG_BLK_FILTER
-/**
- * enum bdev_filter_altitudes - Set of reserved altitudes for block device
- *	filters.
- *
- * @bdev_filter_alt_blksnap:
- *	An altitude for the blksnap module.
- * @bdev_filter_alt_end:
- *	Indicates the end of the altitude set.
- */
-enum bdev_filter_altitudes {
-	bdev_filter_alt_blksnap = 0,
-	bdev_filter_alt_end
-};
-struct bdev_filter;
-#endif
-
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
@@ -74,6 +57,7 @@ struct block_device {
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct request_queue *	bd_queue;
+	struct bdev_filter	*bd_filter;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
@@ -85,10 +69,6 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
-#ifdef CONFIG_BLK_FILTER
-	struct bdev_filter	*bd_filters[bdev_filter_alt_end];
-	spinlock_t		bd_filters_lock;
-#endif
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b3705b9a95167..b9a94c53c6cd3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1559,85 +1559,4 @@ struct io_comp_batch {
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
-#ifdef CONFIG_BLK_FILTER
-/**
- * enum bdev_filter_result - The result of bio processing by
- *	the block device filter.
- *
- * @bdev_filter_skip:
- *	Original bio does not need to be submitted.
- * @bdev_filter_pass:
- *	It is necessary to submit the original request.
- * @bdev_filter_repeat:
- *	Bio processing has not been completed, a second call is required.
- * @bdev_filter_redirect:
- *	Original bio was redirected to another block device. The set
- *	of filters on it is different, so processing must be repeated.
- */
-enum bdev_filter_result {
-	bdev_filter_skip = 0,
-	bdev_filter_pass,
-	bdev_filter_repeat,
-	bdev_filter_redirect
-};
-struct bdev_filter;
-/**
- * bdev_filter_operations - List of callback functions for the filter.
- *
- * @submit_bio_cb:
- *	A callback function for bio processing.
- * @detach_cb:
- *	A callback function to disable the filter when removing a block
- *	device from the system.
- */
-struct bdev_filter_operations {
-	enum bdev_filter_result (*submit_bio_cb)(struct bio *bio,
-						 struct bdev_filter *flt);
-	void (*detach_cb)(struct kref *kref);
-};
-/**
- * struct bdev_filter - Block device filter.
- *
- * @kref:
- *	Kernel reference counter.
- * @fops:
- *	The pointer to &struct bdev_filter_operations with callback
- *	functions for the filter.
- */
-struct bdev_filter {
-	struct kref kref;
-	const struct bdev_filter_operations *fops;
-};
-/**
- * bdev_filter_init - Initialization of the filter structure.
- * @flt:
- *	Pointer to the &struct bdev_filter to be initialized.
- * @fops:
- *	The callback functions for the filter.
- */
-static inline void bdev_filter_init(struct bdev_filter *flt,
-		const struct bdev_filter_operations *fops)
-{
-	kref_init(&flt->kref);
-	flt->fops = fops;
-};
-int bdev_filter_attach(struct block_device *bdev, const char *name,
-		       const enum bdev_filter_altitudes altitude,
-		       struct bdev_filter *flt);
-int bdev_filter_detach(struct block_device *bdev, const char *name,
-		       const enum bdev_filter_altitudes altitude);
-struct bdev_filter *bdev_filter_get_by_altitude(struct block_device *bdev,
-		       const enum bdev_filter_altitudes altitude);
-static inline void bdev_filter_get(struct bdev_filter *flt)
-{
-	kref_get(&flt->kref);
-}
-static inline void bdev_filter_put(struct bdev_filter *flt)
-{
-	if (flt)
-		kref_put(&flt->kref, flt->fops->detach_cb);
-};
-
-#endif
-
 #endif /* _LINUX_BLKDEV_H */

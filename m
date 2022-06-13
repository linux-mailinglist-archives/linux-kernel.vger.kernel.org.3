Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6D549C45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbiFMSzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiFMSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:20 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9DFC839;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 2AAB8CCE21;
        Mon, 13 Jun 2022 18:54:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1655135642;
        bh=7SqasGcsGPk7lF68LbZBSDsnkrJS5LAXkYNjoErasw8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=e5vrwEkyBCZCpd5m9rPnsZ3Z7+1uBaMBqA6PRKbfWwylOanZA7lsLZh7P0EfzCucN
         QNbA6jgV9819xiGh8aFj0dLAn436nCTG1QHikPbt4kpA6Ysjj6k7wjw19RxibkqiNL
         9xbDvwHkaiJB+KB1Jvg+/TLs182V4npLU00+DRJ2dgX0hvhh4D+cfi5vM7ysXLBrTu
         6fu4laij0Lr7sT1ZCFf3zO06GlPSLXDBJXuaVqKokfCsoEddLunlqQ/Dhh60FkzD6r
         U5/Yg7eUNkUUjoPQUDipY5hkQ3oJ6PODJbSid9zWOwoXJ7ATlURkOS8DLVL/MeHWUs
         LkFEuoxbCYmvw==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:53:59 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 01/20] block, blk_filter: enable block device filters
Date:   Mon, 13 Jun 2022 18:52:54 +0300
Message-ID: <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to attach block device filters to the block devices.
Kernel modules can use this functionality to extend the
capabilities of the block layer.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/Kconfig             |   8 +++
 block/bdev.c              | 129 ++++++++++++++++++++++++++++++++++++++
 block/blk-core.c          |  88 ++++++++++++++++++++++++++
 include/linux/blk_types.h |  22 +++++++
 include/linux/blkdev.h    |  81 ++++++++++++++++++++++++
 5 files changed, 328 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 50b17e260fa2..256483e00224 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -225,6 +225,14 @@ config BLK_MQ_RDMA
 config BLK_PM
 	def_bool PM
 
+config BLK_FILTER
+	bool "Enable block device filters"
+	default n
+	help
+	  Enabling this lets the block layer filters handle bio requests.
+	  Kernel modules can use this feature to extend the functionality
+	  of the block layer.
+
 # do not use in new code
 config BLOCK_HOLDER_DEPRECATED
 	bool
diff --git a/block/bdev.c b/block/bdev.c
index 5fe06c1f2def..4bcd9f4378e3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -426,8 +426,15 @@ static void init_once(void *data)
 	inode_init_once(&ei->vfs_inode);
 }
 
+#ifdef CONFIG_BLK_FILTER
+static void bdev_filter_cleanup(struct block_device *bdev);
+#endif
+
 static void bdev_evict_inode(struct inode *inode)
 {
+#ifdef CONFIG_BLK_FILTER
+	bdev_filter_cleanup(I_BDEV(inode));
+#endif
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
@@ -503,6 +510,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
+
+#ifdef CONFIG_BLK_FILTER
+	memset(bdev->bd_filters, 0, sizeof(bdev->bd_filters));
+	spin_lock_init(&bdev->bd_filters_lock);
+#endif
 	return bdev;
 }
 
@@ -1071,3 +1083,120 @@ void sync_bdevs(bool wait)
 	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 	iput(old_inode);
 }
+
+#ifdef CONFIG_BLK_FILTER
+static void bdev_filter_cleanup(struct block_device *bdev)
+{
+	int altitude;
+	struct bdev_filter *flt;
+
+	for (altitude = 0; altitude < bdev_filter_alt_end; altitude++) {
+		spin_lock(&bdev->bd_filters_lock);
+		flt = bdev->bd_filters[altitude];
+		bdev->bd_filters[altitude] = NULL;
+		spin_unlock(&bdev->bd_filters_lock);
+
+		bdev_filter_put(flt);
+	}
+}
+
+/**
+ * bdev_filter_attach - Attach a filter to the original block device.
+ * @bdev:
+ *	Block device.
+ * @name:
+ *	Name of the block device filter.
+ * @altitude:
+ *	Altituda number of the block device filter.
+ * @flt:
+ *	Pointer to the filter structure.
+ *
+ * Before adding a filter, it is necessary to initialize &struct bdev_filter.
+ *
+ * The bdev_filter_detach() function allows to detach the filter from the block
+ * device.
+ *
+ * Return:
+ * 0 - OK
+ * -EALREADY - a filter with this name already exists
+ */
+int bdev_filter_attach(struct block_device *bdev, const char *name,
+		       const enum bdev_filter_altitudes altitude,
+		       struct bdev_filter *flt)
+{
+	int ret = 0;
+
+	spin_lock(&bdev->bd_filters_lock);
+	if (bdev->bd_filters[altitude])
+		ret = -EALREADY;
+	else
+		bdev->bd_filters[altitude] = flt;
+	spin_unlock(&bdev->bd_filters_lock);
+
+	if (!ret)
+		pr_info("block device filter '%s' has been attached to %d:%d",
+			name, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bdev_filter_attach);
+
+/**
+ * bdev_filter_detach - Detach a filter from the block device.
+ * @bdev:
+ *	Block device.
+ * @name:
+ *	Name of the block device filter.
+ * @altitude:
+ *	Altituda number of the block device filter.
+ *
+ * The filter should be added using the bdev_filter_attach() function.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOENT - the filter was not found in the linked list
+ */
+int bdev_filter_detach(struct block_device *bdev, const char *name,
+		       const enum bdev_filter_altitudes altitude)
+{
+	struct bdev_filter *flt = NULL;
+
+	spin_lock(&bdev->bd_filters_lock);
+	flt = bdev->bd_filters[altitude];
+	bdev->bd_filters[altitude] = NULL;
+	spin_unlock(&bdev->bd_filters_lock);
+
+	if (!flt)
+		return -ENOENT;
+
+	bdev_filter_put(flt);
+	pr_info("block device filter '%s' has been detached from %d:%d",
+		name, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdev_filter_detach);
+
+/**
+ * bdev_filter_get_by_altitude - Get filter by altitude.
+ * @bdev:
+ *	Pointer to the block device structure.
+ *
+ * Return:
+ * pointer - pointer to filters structure from &struct blk_filter
+ * NULL - no filter has been set
+ */
+struct bdev_filter *bdev_filter_get_by_altitude(struct block_device *bdev,
+				const enum bdev_filter_altitudes altitude)
+{
+	struct bdev_filter *flt;
+
+	spin_lock(&bdev->bd_filters_lock);
+	flt = bdev->bd_filters[altitude];
+	if (flt)
+		bdev_filter_get(flt);
+	spin_unlock(&bdev->bd_filters_lock);
+
+	return flt;
+}
+EXPORT_SYMBOL_GPL(bdev_filter_get_by_altitude);
+#endif
diff --git a/block/blk-core.c b/block/blk-core.c
index 06ff5bbfe8f6..a44906fb08aa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -757,6 +757,86 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 		__submit_bio_noacct(bio);
 }
 
+#ifdef CONFIG_BLK_FILTER
+
+/**
+ * __filter_bio() - Process bio by the block device filter.
+ * @flt:
+ *	Block device filter.
+ * @bio:
+ *	Original I/O unit.
+ *
+ * Return:
+ * bdev_filter_pass - original bio should be submitted
+ * bdev_filter_skip - do not submit original bio
+ * bdev_filter_redirect - repeat bio processing for another block device
+ */
+static inline enum bdev_filter_result __filter_bio(struct bdev_filter *flt,
+						   struct bio *bio)
+{
+	enum bdev_filter_result result;
+	struct bio *new_bio;
+	struct bio_list bio_list[2] = { };
+
+	do {
+		bio_list_init(&bio_list[0]);
+		current->bio_list = bio_list;
+
+		result = flt->fops->submit_bio_cb(bio, flt);
+
+		current->bio_list = NULL;
+
+		while ((new_bio = bio_list_pop(&bio_list[0]))) {
+			bio_set_flag(new_bio, BIO_FILTERED);
+			submit_bio_noacct(new_bio);
+		};
+	} while (result == bdev_filter_repeat);
+
+	return result;
+}
+
+/**
+ * filter_bio() - Pass bio to the block device filters.
+ * @bio:
+ *	Original I/O unit.
+ *
+ * Return:
+ * true - original bio should be submitted
+ * false - do not submit original bio
+ */
+static bool filter_bio(struct bio *bio)
+{
+	enum bdev_filter_result result = bdev_filter_pass;
+
+	if (bio_flagged(bio, BIO_FILTERED))
+		return true;
+	do {
+		struct block_device *bdev = bio->bi_bdev;
+		unsigned int altitude = 0;
+
+		while (altitude < bdev_filter_alt_end) {
+			struct bdev_filter *flt;
+
+			spin_lock(&bdev->bd_filters_lock);
+			flt = bdev->bd_filters[altitude];
+			if (flt)
+				bdev_filter_get(flt);
+			spin_unlock(&bdev->bd_filters_lock);
+
+			if (flt) {
+				result = __filter_bio(flt, bio);
+				bdev_filter_put(flt);
+				if (result != bdev_filter_pass)
+					break;
+			}
+			altitude++;
+		}
+	} while (result == bdev_filter_redirect);
+
+	return (result == bdev_filter_pass);
+}
+#endif
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -790,6 +870,14 @@ void submit_bio_noacct(struct bio *bio)
 		goto end_io;
 	if (unlikely(bio_check_ro(bio)))
 		goto end_io;
+#ifdef CONFIG_BLK_FILTER
+	/*
+	 * It looks like should_fail_bio() and bio_check_ro() can be placed
+	 * in a separate block device filter for debugging.
+	 */
+	if (!filter_bio(bio))
+		goto end_io;
+#endif
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a24d4078fb21..b88f506ea59e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -37,6 +37,23 @@ struct bio_crypt_ctx;
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
+#ifdef CONFIG_BLK_FILTER
+/**
+ * enum bdev_filter_altitudes - Set of reserved altitudes for block device
+ *	filters.
+ *
+ * @bdev_filter_alt_blksnap:
+ *	An altitude for the blksnap module.
+ * @bdev_filter_alt_end:
+ *	Indicates the end of the altitude set.
+ */
+enum bdev_filter_altitudes {
+	bdev_filter_alt_blksnap = 0,
+	bdev_filter_alt_end
+};
+struct bdev_filter;
+#endif
+
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
@@ -68,6 +85,10 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+#ifdef CONFIG_BLK_FILTER
+	struct bdev_filter	*bd_filters[bdev_filter_alt_end];
+	spinlock_t		bd_filters_lock;
+#endif
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
@@ -332,6 +353,7 @@ enum {
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
+	BIO_FILTERED,		/* bio has already been filtered */
 	BIO_FLAG_LAST
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 608d577734c2..24cb5293897f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1573,4 +1573,85 @@ struct io_comp_batch {
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
+#ifdef CONFIG_BLK_FILTER
+/**
+ * enum bdev_filter_result - The result of bio processing by
+ *	the block device filter.
+ *
+ * @bdev_filter_skip:
+ *	Original bio does not need to be submitted.
+ * @bdev_filter_pass:
+ *	It is necessary to submit the original request.
+ * @bdev_filter_repeat:
+ *	Bio processing has not been completed, a second call is required.
+ * @bdev_filter_redirect:
+ *	Original bio was redirected to another block device. The set
+ *	of filters on it is different, so processing must be repeated.
+ */
+enum bdev_filter_result {
+	bdev_filter_skip = 0,
+	bdev_filter_pass,
+	bdev_filter_repeat,
+	bdev_filter_redirect
+};
+struct bdev_filter;
+/**
+ * bdev_filter_operations - List of callback functions for the filter.
+ *
+ * @submit_bio_cb:
+ *	A callback function for bio processing.
+ * @detach_cb:
+ *	A callback function to disable the filter when removing a block
+ *	device from the system.
+ */
+struct bdev_filter_operations {
+	enum bdev_filter_result (*submit_bio_cb)(struct bio *bio,
+						 struct bdev_filter *flt);
+	void (*detach_cb)(struct kref *kref);
+};
+/**
+ * struct bdev_filter - Block device filter.
+ *
+ * @kref:
+ *	Kernel reference counter.
+ * @fops:
+ *	The pointer to &struct bdev_filter_operations with callback
+ *	functions for the filter.
+ */
+struct bdev_filter {
+	struct kref kref;
+	const struct bdev_filter_operations *fops;
+};
+/**
+ * bdev_filter_init - Initialization of the filter structure.
+ * @flt:
+ *	Pointer to the &struct bdev_filter to be initialized.
+ * @fops:
+ *	The callback functions for the filter.
+ */
+static inline void bdev_filter_init(struct bdev_filter *flt,
+		const struct bdev_filter_operations *fops)
+{
+	kref_init(&flt->kref);
+	flt->fops = fops;
+};
+int bdev_filter_attach(struct block_device *bdev, const char *name,
+		       const enum bdev_filter_altitudes altitude,
+		       struct bdev_filter *flt);
+int bdev_filter_detach(struct block_device *bdev, const char *name,
+		       const enum bdev_filter_altitudes altitude);
+struct bdev_filter *bdev_filter_get_by_altitude(struct block_device *bdev,
+		       const enum bdev_filter_altitudes altitude);
+static inline void bdev_filter_get(struct bdev_filter *flt)
+{
+	kref_get(&flt->kref);
+}
+static inline void bdev_filter_put(struct bdev_filter *flt)
+{
+	if (flt)
+		kref_put(&flt->kref, flt->fops->detach_cb);
+};
+
+#endif
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.20.1


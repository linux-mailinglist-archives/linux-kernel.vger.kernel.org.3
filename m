Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A6549C57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiFMS42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbiFMSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:28 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8870FC83D;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 8A317431AE;
        Mon, 13 Jun 2022 11:54:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135660;
        bh=28Zc4rcK1LClOxfFYxDEvdcTa6rpmCMQgIVE7tmctSs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nbVETcKrClwdbNK47IOkIJwn1p7WFU2fGWfNV5V2vUEIhAllN8CAuOYzHNlF5Z8QC
         mf8MWrV82uHSfEh+Io/oRrbCmm01+H0niRQMUl1QTdrzgdorzNayDpuT+rmwwZMp/9
         HZx3LFzd/+sJDaFXzbEL/BVA3pOOtNV6U1a2KOuK8X8Ecx/mfKlu+yj89QRbdupbDu
         gQfhJnboKlDxPiVqBSenscXaGd3o86IEkK2PMPe37oSbRw6XZ5xHkGxNr7hKeE2Tj2
         YV0S9j16/lRGzeem6kpFDwLHCNs3afNVVaQdvamDrg+g3j9GunIby8iSuuR1sA0K1d
         zhroMoozX3jNQ==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:17 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 06/20] block, blksnap: attaching and detaching the filter and handling a bios
Date:   Mon, 13 Jun 2022 18:52:59 +0300
Message-ID: <1655135593-1900-7-git-send-email-sergei.shtepa@veeam.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct tracker contains callback functions for handling a I/O units
of a block device. When a write request is handled, the change block
tracking (CBT) map functions are called and initiates the process of
copying data from the original block device to the change store.
Attaching and detaching the tracker is provided by the functions
bdev_filter_*() of the kernel.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/tracker.c | 693 ++++++++++++++++++++++++++++++++
 drivers/block/blksnap/tracker.h |  71 ++++
 2 files changed, 764 insertions(+)
 create mode 100644 drivers/block/blksnap/tracker.c
 create mode 100644 drivers/block/blksnap/tracker.h

diff --git a/drivers/block/blksnap/tracker.c b/drivers/block/blksnap/tracker.c
new file mode 100644
index 000000000000..705e64321cb2
--- /dev/null
+++ b/drivers/block/blksnap/tracker.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-tracker: " fmt
+#include <linux/slab.h>
+#include <linux/blk-mq.h>
+#include <linux/sched/mm.h>
+#include <linux/blk_snap.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "params.h"
+#include "tracker.h"
+#include "cbt_map.h"
+#include "diff_area.h"
+
+struct tracked_device {
+	struct list_head link;
+	dev_t dev_id;
+};
+
+DEFINE_PERCPU_RWSEM(tracker_submit_lock);
+LIST_HEAD(tracked_device_list);
+DEFINE_SPINLOCK(tracked_device_lock);
+static refcount_t trackers_counter = REFCOUNT_INIT(1);
+
+struct tracker_release_worker {
+	struct work_struct work;
+	struct list_head list;
+	spinlock_t lock;
+};
+static struct tracker_release_worker tracker_release_worker;
+
+void tracker_lock(void)
+{
+	pr_info("Lock trackers\n");
+	percpu_down_write(&tracker_submit_lock);
+}
+
+void tracker_unlock(void)
+{
+	percpu_up_write(&tracker_submit_lock);
+	pr_info("Trackers have been unlocked\n");
+}
+
+void tracker_free(struct tracker *tracker)
+{
+	might_sleep();
+
+	pr_debug("Free tracker for device [%u:%u].\n", MAJOR(tracker->dev_id),
+		 MINOR(tracker->dev_id));
+
+	diff_area_put(tracker->diff_area);
+	cbt_map_put(tracker->cbt_map);
+
+	kfree(tracker);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_tracker);
+#endif
+	refcount_dec(&trackers_counter);
+}
+
+struct tracker *tracker_get_by_dev(struct block_device *bdev)
+{
+	struct bdev_filter *flt;
+
+	flt = bdev_filter_get_by_altitude(bdev, bdev_filter_alt_blksnap);
+	if (IS_ERR(flt))
+		return ERR_PTR(PTR_ERR(flt));
+	if (!flt)
+		return NULL;
+	return container_of(flt, struct tracker, flt);
+}
+
+static enum bdev_filter_result tracker_submit_bio_cb(struct bio *bio,
+		struct bdev_filter *flt)
+{
+	enum bdev_filter_result ret = bdev_filter_pass;
+	struct tracker *tracker = container_of(flt, struct tracker, flt);
+	int err;
+	sector_t sector;
+	sector_t count;
+	unsigned int current_flag;
+
+	if (bio->bi_opf & REQ_NOWAIT) {
+		if (!percpu_down_read_trylock(&tracker_submit_lock)) {
+			bio_wouldblock_error(bio);
+			return bdev_filter_skip;
+		}
+	} else
+		percpu_down_read(&tracker_submit_lock);
+
+	if (!op_is_write(bio_op(bio)))
+		goto out;
+
+	if (!bio->bi_iter.bi_size)
+		goto out;
+
+	sector = bio->bi_iter.bi_sector;
+	count = (sector_t)(round_up(bio->bi_iter.bi_size, SECTOR_SIZE) /
+			   SECTOR_SIZE);
+
+	current_flag = memalloc_noio_save();
+	err = cbt_map_set(tracker->cbt_map, sector, count);
+	memalloc_noio_restore(current_flag);
+	if (unlikely(err))
+		goto out;
+
+	if (!atomic_read(&tracker->snapshot_is_taken))
+		goto out;
+
+	if (diff_area_is_corrupted(tracker->diff_area))
+		goto out;
+
+	current_flag = memalloc_noio_save();
+	err = diff_area_copy(tracker->diff_area, sector, count,
+			     !!(bio->bi_opf & REQ_NOWAIT));
+	memalloc_noio_restore(current_flag);
+
+	if (unlikely(err)) {
+		if (err == -EAGAIN) {
+			bio_wouldblock_error(bio);
+			ret = bdev_filter_skip;
+		} else
+			pr_err("Failed to copy data to diff storage with error %d\n", abs(err));
+
+		goto out;
+	}
+
+	/*
+	 * If a new bio was created during the handling and the original bio
+	 * must be processed synchronously (flag REQ_SYNC), then new bios must
+	 * be sent and returned to complete the processing of the original bio.
+	 */
+	if (!bio_list_empty(current->bio_list) && (bio->bi_opf & REQ_SYNC))
+		ret = bdev_filter_repeat;
+out:
+	percpu_up_read(&tracker_submit_lock);
+	return ret;
+}
+
+
+static void tracker_release_work(struct work_struct *work)
+{
+	struct tracker *tracker = NULL;
+	struct tracker_release_worker *tracker_release =
+		container_of(work, struct tracker_release_worker, work);
+
+	do {
+		spin_lock(&tracker_release->lock);
+		tracker = list_first_entry_or_null(&tracker_release->list,
+						   struct tracker, link);
+		if (tracker)
+			list_del(&tracker->link);
+		spin_unlock(&tracker_release->lock);
+
+		if (tracker)
+			tracker_free(tracker);
+	} while (tracker);
+}
+
+static void tracker_detach_cb(struct kref *kref)
+{
+	struct bdev_filter *flt = container_of(kref, struct bdev_filter, kref);
+	struct tracker *tracker = container_of(flt, struct tracker, flt);
+
+	spin_lock(&tracker_release_worker.lock);
+	list_add_tail(&tracker->link, &tracker_release_worker.list);
+	spin_unlock(&tracker_release_worker.lock);
+
+	queue_work(system_wq, &tracker_release_worker.work);
+}
+
+static const struct bdev_filter_operations tracker_fops = {
+	.submit_bio_cb = tracker_submit_bio_cb,
+	.detach_cb = tracker_detach_cb
+};
+
+static int tracker_filter_attach(struct block_device *bdev,
+				 struct tracker *tracker)
+{
+	int ret;
+	bool is_frozen = false;
+
+	pr_debug("Tracker attach filter\n");
+
+	if (freeze_bdev(bdev))
+		pr_err("Failed to freeze device [%u:%u]\n", MAJOR(bdev->bd_dev),
+		       MINOR(bdev->bd_dev));
+	else {
+		is_frozen = true;
+		pr_debug("Device [%u:%u] was frozen\n", MAJOR(bdev->bd_dev),
+			 MINOR(bdev->bd_dev));
+	}
+
+	ret = bdev_filter_attach(bdev, KBUILD_MODNAME, bdev_filter_alt_blksnap,
+				 &tracker->flt);
+	if (is_frozen) {
+		if (thaw_bdev(bdev))
+			pr_err("Failed to thaw device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was unfrozen\n",
+				 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	}
+
+	if (ret)
+		pr_err("Failed to attach tracker to device [%u:%u]\n",
+		       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+
+	return ret;
+}
+
+static int tracker_filter_detach(struct block_device *bdev)
+{
+	int ret;
+	bool is_frozen = false;
+
+	pr_debug("Tracker delete filter\n");
+	if (freeze_bdev(bdev))
+		pr_err("Failed to freeze device [%u:%u]\n", MAJOR(bdev->bd_dev),
+		       MINOR(bdev->bd_dev));
+	else {
+		is_frozen = true;
+		pr_debug("Device [%u:%u] was frozen\n", MAJOR(bdev->bd_dev),
+			 MINOR(bdev->bd_dev));
+	}
+
+	ret = bdev_filter_detach(bdev, KBUILD_MODNAME, bdev_filter_alt_blksnap);
+
+	if (is_frozen) {
+		if (thaw_bdev(bdev))
+			pr_err("Failed to thaw device [%u:%u]\n",
+			       MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+		else
+			pr_debug("Device [%u:%u] was unfrozen\n",
+				 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	}
+
+	if (ret)
+		pr_err("Failed to detach filter from device [%u:%u]\n",
+		       MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	return ret;
+}
+
+static struct tracker *tracker_new(struct block_device *bdev)
+{
+	int ret;
+	struct tracker *tracker = NULL;
+	struct cbt_map *cbt_map;
+
+	pr_debug("Creating tracker for device [%u:%u].\n", MAJOR(bdev->bd_dev),
+		 MINOR(bdev->bd_dev));
+
+	tracker = kzalloc(sizeof(struct tracker), GFP_KERNEL);
+	if (tracker == NULL)
+		return ERR_PTR(-ENOMEM);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_tracker);
+#endif
+	refcount_inc(&trackers_counter);
+	bdev_filter_init(&tracker->flt, &tracker_fops);
+	INIT_LIST_HEAD(&tracker->link);
+	atomic_set(&tracker->snapshot_is_taken, false);
+	tracker->dev_id = bdev->bd_dev;
+
+	pr_info("Create tracker for device [%u:%u]. Capacity 0x%llx sectors\n",
+		MAJOR(tracker->dev_id), MINOR(tracker->dev_id),
+		(unsigned long long)bdev_nr_sectors(bdev));
+
+	cbt_map = cbt_map_create(bdev);
+	if (!cbt_map) {
+		pr_err("Failed to create tracker for device [%u:%u]\n",
+		       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		ret = -ENOMEM;
+		goto fail;
+	}
+	tracker->cbt_map = cbt_map;
+
+	ret = tracker_filter_attach(bdev, tracker);
+	if (ret) {
+		pr_err("Failed to attach tracker. errno=%d\n", abs(ret));
+		goto fail;
+	}
+	/*
+	 * The filter stores a pointer to the tracker.
+	 * The tracker will not be released until its filter is released.
+	 */
+
+	pr_debug("New tracker for device [%u:%u] was created.\n",
+		 MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+
+	return tracker;
+fail:
+	tracker_put(tracker);
+	return ERR_PTR(ret);
+}
+
+int tracker_take_snapshot(struct tracker *tracker)
+{
+	int ret = 0;
+	bool cbt_reset_needed = false;
+	sector_t capacity;
+
+	if (tracker->cbt_map->is_corrupted) {
+		cbt_reset_needed = true;
+		pr_warn("Corrupted CBT table detected. CBT fault\n");
+	}
+
+	capacity = bdev_nr_sectors(tracker->diff_area->orig_bdev);
+	if (tracker->cbt_map->device_capacity != capacity) {
+		cbt_reset_needed = true;
+		pr_warn("Device resize detected. CBT fault\n");
+	}
+
+	if (cbt_reset_needed) {
+		ret = cbt_map_reset(tracker->cbt_map, capacity);
+		if (ret) {
+			pr_err("Failed to create tracker. errno=%d\n",
+			       abs(ret));
+			return ret;
+		}
+	}
+
+	cbt_map_switch(tracker->cbt_map);
+	atomic_set(&tracker->snapshot_is_taken, true);
+
+	return 0;
+}
+
+void tracker_release_snapshot(struct tracker *tracker)
+{
+	if (!tracker)
+		return;
+
+	pr_debug("Tracker for device [%u:%u] release snapshot\n",
+		 MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+
+	atomic_set(&tracker->snapshot_is_taken, false);
+}
+
+int tracker_init(void)
+{
+	INIT_WORK(&tracker_release_worker.work, tracker_release_work);
+	INIT_LIST_HEAD(&tracker_release_worker.list);
+	spin_lock_init(&tracker_release_worker.lock);
+
+	return 0;
+}
+
+/**
+ * tracker_wait_for_release - Waiting for all trackers are released.
+ */
+static void tracker_wait_for_release(void)
+{
+	long inx = 0;
+	u64 start_waiting = jiffies_64;
+
+	while (refcount_read(&trackers_counter) > 1) {
+		schedule_timeout_interruptible(HZ);
+		if (jiffies_64 > (start_waiting + 10*HZ)) {
+			start_waiting = jiffies_64;
+			inx++;
+
+			if (inx <= 12)
+				pr_warn("Waiting for trackers release\n");
+
+			WARN_ONCE(inx > 12, "Failed to release trackers\n");
+		}
+	}
+}
+
+void tracker_done(void)
+{
+	struct tracked_device *tr_dev;
+
+	pr_debug("Cleanup trackers\n");
+	while (true) {
+		spin_lock(&tracked_device_lock);
+		tr_dev = list_first_entry_or_null(&tracked_device_list,
+						  struct tracked_device, link);
+		if (tr_dev)
+			list_del(&tr_dev->link);
+		spin_unlock(&tracked_device_lock);
+
+		if (!tr_dev)
+			break;
+
+		tracker_remove(tr_dev->dev_id);
+		kfree(tr_dev);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+		memory_object_dec(memory_object_tracked_device);
+#endif
+	}
+
+	tracker_wait_for_release();
+}
+
+struct tracker *tracker_create_or_get(dev_t dev_id)
+{
+	struct tracker *tracker;
+	struct block_device *bdev;
+	struct tracked_device *tr_dev;
+
+	bdev = blkdev_get_by_dev(dev_id, 0, NULL);
+	if (IS_ERR(bdev)) {
+		pr_info("Cannot open device [%u:%u]\n", MAJOR(dev_id),
+		       MINOR(dev_id));
+		return ERR_PTR(PTR_ERR(bdev));
+	}
+
+	tracker = tracker_get_by_dev(bdev);
+	if (IS_ERR(tracker)) {
+		int err = PTR_ERR(tracker);
+
+		pr_err("Cannot get tracker for device [%u:%u]. errno=%d\n",
+			 MAJOR(dev_id), MINOR(dev_id), abs(err));
+		goto put_bdev;
+	}
+	if (tracker) {
+		pr_debug("Device [%u:%u] is already under tracking\n",
+			 MAJOR(dev_id), MINOR(dev_id));
+		goto put_bdev;
+	}
+
+	tr_dev = kzalloc(sizeof(struct tracked_device), GFP_KERNEL);
+	if (!tr_dev) {
+		tracker = ERR_PTR(-ENOMEM);
+		goto put_bdev;
+	}
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_tracked_device);
+#endif
+	INIT_LIST_HEAD(&tr_dev->link);
+	tr_dev->dev_id = dev_id;
+
+	tracker = tracker_new(bdev);
+	if (IS_ERR(tracker)) {
+		int err = PTR_ERR(tracker);
+
+		pr_err("Failed to create tracker. errno=%d\n", abs(err));
+		kfree(tr_dev);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+		memory_object_dec(memory_object_tracked_device);
+#endif
+	} else {
+		/*
+		 * It is normal that the new trackers filter will have
+		 * a ref counter value of 2. This allows not to detach
+		 * the filter when the snapshot is released.
+		 */
+		bdev_filter_get(&tracker->flt);
+
+		spin_lock(&tracked_device_lock);
+		list_add_tail(&tr_dev->link, &tracked_device_list);
+		spin_unlock(&tracked_device_lock);
+	}
+put_bdev:
+	blkdev_put(bdev, 0);
+	return tracker;
+}
+
+int tracker_remove(dev_t dev_id)
+{
+	int ret;
+	struct tracker *tracker;
+	struct block_device *bdev;
+
+	pr_info("Removing device [%u:%u] from tracking\n", MAJOR(dev_id),
+		MINOR(dev_id));
+
+	bdev = blkdev_get_by_dev(dev_id, 0, NULL);
+	if (IS_ERR(bdev)) {
+		pr_info("Cannot open device [%u:%u]\n", MAJOR(dev_id),
+		       MINOR(dev_id));
+		return PTR_ERR(bdev);
+	}
+
+	tracker = tracker_get_by_dev(bdev);
+	if (IS_ERR(tracker)) {
+		ret = PTR_ERR(tracker);
+
+		pr_err("Failed to get tracker for device [%u:%u]. errno=%d\n",
+			 MAJOR(dev_id), MINOR(dev_id), abs(ret));
+		goto put_bdev;
+	}
+	if (!tracker) {
+		pr_info("Unable to remove device [%u:%u] from tracking: ",
+		       MAJOR(dev_id), MINOR(dev_id));
+		pr_info("tracker not found\n");
+		ret = -ENODATA;
+		goto put_bdev;
+	}
+
+	if (atomic_read(&tracker->snapshot_is_taken)) {
+		pr_err("Tracker for device [%u:%u] is busy with a snapshot\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+		ret = -EBUSY;
+		goto put_tracker;
+	}
+
+	ret = tracker_filter_detach(bdev);
+	if (ret)
+		pr_err("Failed to remove tracker from device [%u:%u]\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+	else {
+		struct tracked_device *tr_dev = NULL;
+		struct tracked_device *iter_tr_dev;
+
+		spin_lock(&tracked_device_lock);
+		list_for_each_entry(iter_tr_dev, &tracked_device_list, link) {
+			if (iter_tr_dev->dev_id == dev_id) {
+				list_del(&iter_tr_dev->link);
+				tr_dev = iter_tr_dev;
+				break;
+			}
+		}
+		spin_unlock(&tracked_device_lock);
+
+		kfree(tr_dev);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+		if (tr_dev)
+			memory_object_dec(memory_object_tracked_device);
+#endif
+	}
+put_tracker:
+	tracker_put(tracker);
+put_bdev:
+	blkdev_put(bdev, 0);
+	return ret;
+}
+
+int tracker_read_cbt_bitmap(dev_t dev_id, unsigned int offset, size_t length,
+			    char __user *user_buff)
+{
+	int ret;
+	struct tracker *tracker;
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_dev(dev_id, 0, NULL);
+	if (IS_ERR(bdev)) {
+		pr_info("Cannot open device [%u:%u]\n", MAJOR(dev_id),
+		       MINOR(dev_id));
+		return PTR_ERR(bdev);
+	}
+
+	tracker = tracker_get_by_dev(bdev);
+	if (IS_ERR(tracker)) {
+		pr_err("Cannot get tracker for device [%u:%u]\n",
+			 MAJOR(dev_id), MINOR(dev_id));
+		ret = PTR_ERR(tracker);
+		goto put_bdev;
+	}
+	if (!tracker) {
+		pr_info("Unable to read CBT bitmap for device [%u:%u]: ",
+		       MAJOR(dev_id), MINOR(dev_id));
+		pr_info("tracker not found\n");
+		ret = -ENODATA;
+		goto put_bdev;
+	}
+
+	if (atomic_read(&tracker->snapshot_is_taken)) {
+		ret = cbt_map_read_to_user(tracker->cbt_map, user_buff,
+					   offset, length);
+	} else {
+		pr_err("Unable to read CBT bitmap for device [%u:%u]: ",
+		       MAJOR(dev_id), MINOR(dev_id));
+		pr_err("device is not captured by snapshot\n");
+		ret = -EPERM;
+	}
+
+	tracker_put(tracker);
+put_bdev:
+	blkdev_put(bdev, 0);
+	return ret;
+}
+
+static inline void collect_cbt_info(dev_t dev_id,
+				    struct blk_snap_cbt_info *cbt_info)
+{
+	struct block_device *bdev;
+	struct tracker *tracker;
+
+	bdev = blkdev_get_by_dev(dev_id, 0, NULL);
+	if (IS_ERR(bdev)) {
+		pr_err("Cannot open device [%u:%u]\n", MAJOR(dev_id),
+		       MINOR(dev_id));
+		return;
+	}
+
+	tracker = tracker_get_by_dev(bdev);
+	if (IS_ERR_OR_NULL(tracker))
+		goto put_bdev;
+	if (!tracker->cbt_map)
+		goto put_tracker;
+
+	cbt_info->device_capacity =
+		(__u64)(tracker->cbt_map->device_capacity << SECTOR_SHIFT);
+	cbt_info->blk_size = (__u32)cbt_map_blk_size(tracker->cbt_map);
+	cbt_info->blk_count = (__u32)tracker->cbt_map->blk_count;
+	cbt_info->snap_number = (__u8)tracker->cbt_map->snap_number_previous;
+	uuid_copy(&cbt_info->generation_id, &tracker->cbt_map->generation_id);
+put_tracker:
+	tracker_put(tracker);
+put_bdev:
+	blkdev_put(bdev, 0);
+}
+
+int tracker_collect(int max_count, struct blk_snap_cbt_info *cbt_info,
+		    int *pcount)
+{
+	int ret = 0;
+	int count = 0;
+	int iter = 0;
+	struct tracked_device *tr_dev;
+
+	if (!cbt_info) {
+		/**
+		 * Just calculate trackers list length.
+		 */
+		spin_lock(&tracked_device_lock);
+		list_for_each_entry(tr_dev, &tracked_device_list, link)
+			++count;
+		spin_unlock(&tracked_device_lock);
+		goto out;
+	}
+
+	spin_lock(&tracked_device_lock);
+	list_for_each_entry(tr_dev, &tracked_device_list, link) {
+		if (count >= max_count) {
+			ret = -ENOBUFS;
+			break;
+		}
+
+		cbt_info[count].dev_id.mj = MAJOR(tr_dev->dev_id);
+		cbt_info[count].dev_id.mn = MINOR(tr_dev->dev_id);
+		++count;
+	}
+	spin_unlock(&tracked_device_lock);
+
+	if (ret)
+		return ret;
+
+	for (iter = 0; iter < count; iter++) {
+		dev_t dev_id = MKDEV(cbt_info[iter].dev_id.mj,
+				     cbt_info[iter].dev_id.mn);
+
+		collect_cbt_info(dev_id, &cbt_info[iter]);
+	}
+out:
+	*pcount = count;
+	return 0;
+}
+
+int tracker_mark_dirty_blocks(dev_t dev_id,
+			      struct blk_snap_block_range *block_ranges,
+			      unsigned int count)
+{
+	int ret = 0;
+	struct tracker *tracker;
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_dev(dev_id, 0, NULL);
+	if (IS_ERR(bdev)) {
+		pr_err("Cannot open device [%u:%u]\n", MAJOR(dev_id),
+		       MINOR(dev_id));
+		return PTR_ERR(bdev);
+	}
+
+	pr_debug("Marking [%d] dirty blocks for device [%u:%u]\n", count,
+		 MAJOR(dev_id), MINOR(dev_id));
+
+	tracker = tracker_get_by_dev(bdev);
+	if (IS_ERR(tracker)) {
+		pr_err("Failed to get tracker for device [%u:%u]\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+		ret = PTR_ERR(tracker);
+		goto put_bdev;
+	}
+	if (!tracker) {
+		pr_err("Cannot find tracker for device [%u:%u]\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+		ret = -ENODEV;
+		goto put_bdev;
+	}
+
+	ret = cbt_map_mark_dirty_blocks(tracker->cbt_map, block_ranges, count);
+	if (ret)
+		pr_err("Failed to set CBT table. errno=%d\n", abs(ret));
+
+	tracker_put(tracker);
+put_bdev:
+	blkdev_put(bdev, 0);
+	return ret;
+}
diff --git a/drivers/block/blksnap/tracker.h b/drivers/block/blksnap/tracker.h
new file mode 100644
index 000000000000..a9b0bec7b601
--- /dev/null
+++ b/drivers/block/blksnap/tracker.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/kref.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/rwsem.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+
+struct cbt_map;
+struct diff_area;
+
+/**
+ * struct tracker - Tracker for a block device.
+ *
+ * @kref:
+ *	Protects the structure from being released during processing of
+ *	an ioctl.
+ * @link:
+ *	List header.
+ * @dev_id:
+ *	Original block device ID.
+ * @snapshot_is_taken:
+ *	Indicates that a snapshot was taken for the device whose bios are
+ *	handled by this tracker.
+ * @cbt_map:
+ *	Pointer to a change block tracker map.
+ * @diff_area:
+ *	Pointer to a difference area.
+ *
+ * The main goal of the tracker is to handle bios. The tracker detectes
+ * the range of sectors that will change and transmits them to the CBT map
+ * and to the difference area.
+ */
+struct tracker {
+	struct bdev_filter flt;
+	struct list_head link;
+	dev_t dev_id;
+
+	atomic_t snapshot_is_taken;
+
+	struct cbt_map *cbt_map;
+	struct diff_area *diff_area;
+};
+
+void tracker_lock(void);
+void tracker_unlock(void);
+
+static inline void tracker_put(struct tracker *tracker)
+{
+	if (likely(tracker))
+		bdev_filter_put(&tracker->flt);
+};
+
+struct tracker *tracker_get_by_dev(struct block_device *bdev);
+
+int tracker_init(void);
+void tracker_done(void);
+
+struct tracker *tracker_create_or_get(dev_t dev_id);
+int tracker_remove(dev_t dev_id);
+int tracker_collect(int max_count, struct blk_snap_cbt_info *cbt_info,
+		    int *pcount);
+int tracker_read_cbt_bitmap(dev_t dev_id, unsigned int offset, size_t length,
+			    char __user *user_buff);
+int tracker_mark_dirty_blocks(dev_t dev_id,
+			      struct blk_snap_block_range *block_ranges,
+			      unsigned int count);
+
+int tracker_take_snapshot(struct tracker *tracker);
+void tracker_release_snapshot(struct tracker *tracker);
-- 
2.20.1


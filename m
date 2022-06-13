Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D412549C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbiFMSyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiFMSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:53:12 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6AF45CA;
        Mon, 13 Jun 2022 08:55:08 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 10A14431CB;
        Mon, 13 Jun 2022 11:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135704;
        bh=J6II4Dmn3qQVJe/t6k11phsdt0yI20fexOrwnohZmkg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OUHXDFRwYFOGkmRTTP9Xs0V3hgoTOmwRlczKXjhEn4ZOuE1XgK/eSBjA3i+AfQlVo
         AoLrE+HnUS/Dzd1k57whKmUA/l19WFLJ/gg41Jt2a5w79QPLg1NpL55HyOFIrsgCIl
         q3SzGjXdQeLmcSKEmM+/7wDkdoWgOoAAcSo3Hv9+qFr4xYkTbBlkN9HBvpSKIkRXSR
         bNVR/JZe0Av1fLnzuz6jjnEvlbn3VUtcPzySOB0NS0ILSrNYPoi9AbXEz5ldRUvdOR
         ET3wMWKXW81IQy3Rzs669i//r77tvcT8N9FfMGo8gR4XkaKh+mVlIeb7SimXjQExNK
         F+u7i1KclyVkA==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:47 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 15/20] block, blksnap: snapshot image block device
Date:   Mon, 13 Jun 2022 18:53:08 +0300
Message-ID: <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
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

Provides the operation of block devices of snapshot images. Read and
write operations are redirected to the regions of difference blocks for
block device (struct diff_area).

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/snapimage.c | 345 ++++++++++++++++++++++++++++++
 drivers/block/blksnap/snapimage.h |  65 ++++++
 2 files changed, 410 insertions(+)
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h

diff --git a/drivers/block/blksnap/snapimage.c b/drivers/block/blksnap/snapimage.c
new file mode 100644
index 000000000000..df69e989056f
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-snapimage: " fmt
+#include <linux/slab.h>
+#include <linux/cdrom.h>
+#include <linux/blk-mq.h>
+#include <linux/blk_snap.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "snapimage.h"
+#include "diff_area.h"
+#include "chunk.h"
+#include "cbt_map.h"
+
+#define SNAPIMAGE_MAX_DEVICES 2048
+
+static unsigned int _major;
+static DEFINE_IDR(_minor_idr);
+static DEFINE_SPINLOCK(_minor_lock);
+
+static void free_minor(int minor)
+{
+	spin_lock(&_minor_lock);
+	idr_remove(&_minor_idr, minor);
+	spin_unlock(&_minor_lock);
+}
+
+static int new_minor(int *minor, void *ptr)
+{
+	int ret;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&_minor_lock);
+
+	ret = idr_alloc(&_minor_idr, ptr, 0, 1 << MINORBITS, GFP_NOWAIT);
+
+	spin_unlock(&_minor_lock);
+	idr_preload_end();
+
+	if (ret < 0)
+		return ret;
+
+	*minor = ret;
+	return 0;
+}
+
+static inline void snapimage_unprepare_worker(struct snapimage *snapimage)
+{
+	kthread_flush_worker(&snapimage->worker);
+	kthread_stop(snapimage->worker_task);
+}
+
+static int snapimage_kthread_worker_fn(void *worker_ptr)
+{
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+	return kthread_worker_fn(worker_ptr);
+}
+
+static inline int snapimage_prepare_worker(struct snapimage *snapimage)
+{
+	struct task_struct *task;
+
+	kthread_init_worker(&snapimage->worker);
+
+	task = kthread_run(snapimage_kthread_worker_fn, &snapimage->worker,
+			   BLK_SNAP_IMAGE_NAME "%d",
+			   MINOR(snapimage->image_dev_id));
+	if (IS_ERR(task))
+		return -ENOMEM;
+
+	set_user_nice(task, MIN_NICE);
+
+	snapimage->worker_task = task;
+	return 0;
+}
+
+struct snapimage_cmd {
+	struct kthread_work work;
+};
+
+static void snapimage_queue_work(struct kthread_work *work)
+{
+	struct snapimage_cmd *cmd =
+		container_of(work, struct snapimage_cmd, work);
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct snapimage *snapimage = rq->q->queuedata;
+	blk_status_t status = BLK_STS_OK;
+	struct bio_vec bvec;
+	struct req_iterator iter;
+	struct diff_area_image_ctx io_ctx;
+	sector_t pos = blk_rq_pos(rq);
+
+	diff_area_throttling_io(snapimage->diff_area);
+	diff_area_image_ctx_init(&io_ctx, snapimage->diff_area,
+				 op_is_write(req_op(rq)));
+	rq_for_each_segment(bvec, rq, iter) {
+		status = diff_area_image_io(&io_ctx, &bvec, &pos);
+		if (unlikely(status != BLK_STS_OK))
+			break;
+	}
+	diff_area_image_ctx_done(&io_ctx);
+
+	blk_mq_end_request(rq, status);
+}
+
+static int snapimage_init_request(struct blk_mq_tag_set *set,
+				  struct request *rq, unsigned int hctx_idx,
+				  unsigned int numa_node)
+{
+	struct snapimage_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
+	kthread_init_work(&cmd->work, snapimage_queue_work);
+	return 0;
+}
+
+static blk_status_t snapimage_queue_rq(struct blk_mq_hw_ctx *hctx,
+				       const struct blk_mq_queue_data *bd)
+{
+	int ret;
+	struct request *rq = bd->rq;
+	struct snapimage *snapimage = rq->q->queuedata;
+	struct snapimage_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
+	/*
+	 * Cannot fall asleep in the context of this function,
+	 * as we are under rwsem lockdown.
+	 */
+
+	blk_mq_start_request(rq);
+
+	if (unlikely(!snapimage->is_ready)) {
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+		return BLK_STS_IOERR;
+	}
+
+	if (op_is_write(req_op(rq))) {
+		ret = cbt_map_set_both(snapimage->cbt_map, blk_rq_pos(rq),
+				       blk_rq_sectors(rq));
+		if (unlikely(ret)) {
+			blk_mq_end_request(rq, BLK_STS_IOERR);
+			return BLK_STS_IOERR;
+		}
+	}
+
+	kthread_queue_work(&snapimage->worker, &cmd->work);
+	return BLK_STS_OK;
+}
+
+static const struct blk_mq_ops mq_ops = {
+	.queue_rq = snapimage_queue_rq,
+	.init_request = snapimage_init_request,
+};
+
+const struct block_device_operations bd_ops = {
+	.owner = THIS_MODULE,
+	//.open = snapimage_open,
+	//.ioctl = snapimage_ioctl,
+	//.release = snapimage_close,
+};
+
+static inline int snapimage_alloc_tag_set(struct snapimage *snapimage)
+{
+	struct blk_mq_tag_set *set = &snapimage->tag_set;
+
+	set->ops = &mq_ops;
+	set->nr_hw_queues = 1;
+	set->nr_maps = 1;
+	set->queue_depth = 128;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
+
+	set->cmd_size = sizeof(struct snapimage_cmd);
+	set->driver_data = snapimage;
+
+	return blk_mq_alloc_tag_set(set);
+}
+
+void snapimage_free(struct snapimage *snapimage)
+{
+	pr_info("Snapshot image disk [%u:%u] delete\n",
+		MAJOR(snapimage->image_dev_id), MINOR(snapimage->image_dev_id));
+
+	blk_mq_freeze_queue(snapimage->disk->queue);
+	snapimage->is_ready = false;
+	blk_mq_unfreeze_queue(snapimage->disk->queue);
+
+	snapimage_unprepare_worker(snapimage);
+
+	del_gendisk(snapimage->disk);
+	blk_cleanup_disk(snapimage->disk);
+	blk_mq_free_tag_set(&snapimage->tag_set);
+
+	diff_area_put(snapimage->diff_area);
+	cbt_map_put(snapimage->cbt_map);
+
+	free_minor(MINOR(snapimage->image_dev_id));
+	kfree(snapimage);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_snapimage);
+#endif
+}
+
+struct snapimage *snapimage_create(struct diff_area *diff_area,
+				   struct cbt_map *cbt_map)
+{
+	int ret = 0;
+	int minor;
+	struct snapimage *snapimage = NULL;
+	struct gendisk *disk;
+
+	pr_info("Create snapshot image for device [%u:%u]\n",
+		MAJOR(diff_area->orig_bdev->bd_dev),
+		MINOR(diff_area->orig_bdev->bd_dev));
+
+	snapimage = kzalloc(sizeof(struct snapimage), GFP_KERNEL);
+	if (snapimage == NULL)
+		return ERR_PTR(-ENOMEM);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_snapimage);
+#endif
+	ret = new_minor(&minor, snapimage);
+	if (ret) {
+		pr_err("Failed to allocate minor for snapshot image device. errno=%d\n",
+		       abs(ret));
+		goto fail_free_image;
+	}
+
+	snapimage->is_ready = true;
+	snapimage->capacity = cbt_map->device_capacity;
+	snapimage->image_dev_id = MKDEV(_major, minor);
+	pr_info("Snapshot image device id [%u:%u]\n",
+		MAJOR(snapimage->image_dev_id), MINOR(snapimage->image_dev_id));
+
+	ret = snapimage_prepare_worker(snapimage);
+	if (ret) {
+		pr_err("Failed to prepare worker thread. errno=%d\n", abs(ret));
+		goto fail_free_minor;
+	}
+
+	ret = snapimage_alloc_tag_set(snapimage);
+	if (ret) {
+		pr_err("Failed to allocate tag set. errno=%d\n", abs(ret));
+		goto fail_free_worker;
+	}
+
+	disk = blk_mq_alloc_disk(&snapimage->tag_set, snapimage);
+	if (IS_ERR(disk)) {
+		ret = PTR_ERR(disk);
+		pr_err("Failed to allocate disk. errno=%d\n", abs(ret));
+		goto fail_free_tagset;
+	}
+
+	blk_queue_max_hw_sectors(disk->queue, BLK_DEF_MAX_SECTORS);
+	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, disk->queue);
+
+	if (snprintf(disk->disk_name, DISK_NAME_LEN, "%s%d",
+		     BLK_SNAP_IMAGE_NAME, minor) < 0) {
+		pr_err("Unable to set disk name for snapshot image device: invalid minor %u\n",
+		       minor);
+		ret = -EINVAL;
+		goto fail_cleanup_disk;
+	}
+	pr_info("Snapshot image disk name [%s]\n", disk->disk_name);
+
+	disk->flags = 0;
+	//disk->flags |= GENHD_FL_HIDDEN;
+	//disk->flags |= GENHD_FL_REMOVABLE;
+#ifdef GENHD_FL_NO_PART_SCAN
+	disk->flags |= GENHD_FL_NO_PART_SCAN;
+#else
+	disk->flags |= GENHD_FL_NO_PART;
+#endif
+
+
+	disk->major = _major;
+	disk->first_minor = minor;
+	disk->minors = 1; // One disk has only one partition.
+
+	disk->fops = &bd_ops;
+	disk->private_data = snapimage;
+	snapimage->disk = disk;
+
+	set_capacity(disk, snapimage->capacity);
+	pr_debug("Snapshot image device capacity %lld bytes\n",
+		 (u64)(snapimage->capacity << SECTOR_SHIFT));
+
+	diff_area_get(diff_area);
+	snapimage->diff_area = diff_area;
+	cbt_map_get(cbt_map);
+	snapimage->cbt_map = cbt_map;
+
+	ret = add_disk(disk);
+	if (ret) {
+		pr_err("Failed to add disk [%s] for snapshot image device\n",
+		       disk->disk_name);
+		goto fail_cleanup_disk;
+	}
+
+	return snapimage;
+
+fail_cleanup_disk:
+	blk_cleanup_disk(disk);
+fail_free_tagset:
+	blk_mq_free_tag_set(&snapimage->tag_set);
+fail_free_worker:
+	snapimage_unprepare_worker(snapimage);
+fail_free_minor:
+	free_minor(minor);
+fail_free_image:
+	kfree(snapimage);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_snapimage);
+#endif
+	return ERR_PTR(ret);
+}
+
+int snapimage_init(void)
+{
+	int mj = 0;
+
+	mj = register_blkdev(mj, BLK_SNAP_IMAGE_NAME);
+	if (mj < 0) {
+		pr_err("Failed to register snapshot image block device. errno=%d\n",
+		       abs(mj));
+		return mj;
+	}
+	_major = mj;
+	pr_info("Snapshot image block device major %d was registered\n",
+		_major);
+
+	return 0;
+}
+
+void snapimage_done(void)
+{
+	unregister_blkdev(_major, BLK_SNAP_IMAGE_NAME);
+	pr_info("Snapshot image block device [%d] was unregistered\n", _major);
+
+	idr_destroy(&_minor_idr);
+}
+
+int snapimage_major(void)
+{
+	return _major;
+}
diff --git a/drivers/block/blksnap/snapimage.h b/drivers/block/blksnap/snapimage.h
new file mode 100644
index 000000000000..e978711004f0
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/kthread.h>
+
+struct diff_area;
+struct cbt_map;
+
+/**
+ * struct snapimage - Snapshot image block device.
+ *
+ * @image_dev_id:
+ *	ID of the snapshot image block device.
+ * @capacity:
+ *	The size of the snapshot image in sectors must be equal to the size
+ *	of the original device at the time of taking the snapshot.
+ * @is_ready:
+ *	The flag means that the snapshot image is ready for processing
+ *	I/O requests.
+ * @worker:
+ *	The worker thread for processing I/O requests.
+ * @worker_task:
+ *	A pointer to the &struct task of the worker thread.
+ * @tag_set:
+ *	Area to keep a shared tag map.
+ * @disk:
+ *	A pointer to the &struct gendisk for the image block device.
+ * @diff_area:
+ *	A pointer to the owned &struct diff_area.
+ * @cbt_map:
+ *	A pointer to the owned &struct cbt_map.
+ *
+ * The snapshot image is presented in the system as a block device. But
+ * when reading or writing a snapshot image, the data is redirected to
+ * the original block device or to the block device of the difference storage.
+ *
+ * The module does not prohibit reading and writing data to the snapshot
+ * from different threads in parallel. To avoid the problem with simultaneous
+ * access, it is enough to open the snapshot image block device with the
+ * FMODE_EXCL parameter.
+ */
+struct snapimage {
+	dev_t image_dev_id;
+	sector_t capacity;
+	bool is_ready;
+
+	struct kthread_worker worker;
+	struct task_struct *worker_task;
+
+	struct blk_mq_tag_set tag_set;
+	struct gendisk *disk;
+
+	struct diff_area *diff_area;
+	struct cbt_map *cbt_map;
+};
+
+int snapimage_init(void);
+void snapimage_done(void);
+int snapimage_major(void);
+
+void snapimage_free(struct snapimage *snapimage);
+struct snapimage *snapimage_create(struct diff_area *diff_area,
+				   struct cbt_map *cbt_map);
-- 
2.20.1


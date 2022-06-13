Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB3549C59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiFMS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiFMSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:29 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7F19C10;
        Mon, 13 Jun 2022 08:59:55 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 31933431E5;
        Mon, 13 Jun 2022 11:54:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135691;
        bh=ak1tO0s8mN3mZtDkM8oxRcWU7JFKE992i39KI3uJF6g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=k1pU4DkCuGBVcEAkhBbu5ZGBQGrRfuf72on5OOLCSPwuy9uq3lS5RkBcpYA9VPxOa
         YtWVxk4enkrTRcHUxOeWe2zzcq2pncJw/v9VD1XmRInMJingBlIjezcAt+HNagW7hR
         fFwQkyHekqAcCkiPOGXhblBcXzRyoIaUsSThrYA5sFsR+zaL9Kb/D98RWyB4pZfYsW
         tTPpqbMq2XkgezMVbDBJ6IF38oXOEsoGPlX9wbFDjdDEGZ81QmAHu5851Dia1XyJCJ
         B6B93o3kjrlv5qo83hX/P6lJeeJ0EtDcM+OSwem6EypPjm9qHdrofmX+xAY5qG/sOR
         23J0Gfffci21w==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:34 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 11/20] block, blksnap: functions and structures for performing block I/O operations
Date:   Mon, 13 Jun 2022 18:53:04 +0300
Message-ID: <1655135593-1900-12-git-send-email-sergei.shtepa@veeam.com>
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

Provides synchronous and asynchronous block I/O operations for the
buffer of the minimum data storage block (struct diff_buffer).

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/diff_io.c | 204 ++++++++++++++++++++++++++++++++
 drivers/block/blksnap/diff_io.h | 122 +++++++++++++++++++
 2 files changed, 326 insertions(+)
 create mode 100644 drivers/block/blksnap/diff_io.c
 create mode 100644 drivers/block/blksnap/diff_io.h

diff --git a/drivers/block/blksnap/diff_io.c b/drivers/block/blksnap/diff_io.c
new file mode 100644
index 000000000000..0be179c461d9
--- /dev/null
+++ b/drivers/block/blksnap/diff_io.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-io: " fmt
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "diff_io.h"
+#include "diff_buffer.h"
+
+#define SECTORS_IN_PAGE (PAGE_SIZE / SECTOR_SIZE)
+
+struct bio_set diff_io_bioset = { 0 };
+
+int diff_io_init(void)
+{
+	return bioset_init(&diff_io_bioset, 64, 0,
+			   BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+}
+
+void diff_io_done(void)
+{
+	bioset_exit(&diff_io_bioset);
+}
+
+static void diff_io_notify_cb(struct work_struct *work)
+{
+	struct diff_io_async *async =
+		container_of(work, struct diff_io_async, work);
+
+	might_sleep();
+	async->notify_cb(async->ctx);
+}
+
+static void diff_io_endio(struct bio *bio)
+{
+	struct diff_io *diff_io = bio->bi_private;
+
+	if (bio->bi_status != BLK_STS_OK)
+		diff_io->error = -EIO;
+
+	if (atomic_dec_and_test(&diff_io->bio_count)) {
+		if (diff_io->is_sync_io)
+			complete(&diff_io->notify.sync.completion);
+		else
+			queue_work(system_wq, &diff_io->notify.async.work);
+	}
+
+	bio_put(bio);
+}
+
+static inline struct diff_io *diff_io_new(bool is_write, bool is_nowait)
+{
+	struct diff_io *diff_io;
+	gfp_t gfp_mask = is_nowait ? (GFP_NOIO | GFP_NOWAIT) : GFP_NOIO;
+
+	diff_io = kzalloc(sizeof(struct diff_io), gfp_mask);
+	if (unlikely(!diff_io))
+		return NULL;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_diff_io);
+#endif
+	diff_io->error = 0;
+	diff_io->is_write = is_write;
+	atomic_set(&diff_io->bio_count, 0);
+
+	return diff_io;
+}
+
+struct diff_io *diff_io_new_sync(bool is_write)
+{
+	struct diff_io *diff_io;
+
+	diff_io = diff_io_new(is_write, false);
+	if (unlikely(!diff_io))
+		return NULL;
+
+	diff_io->is_sync_io = true;
+	init_completion(&diff_io->notify.sync.completion);
+	return diff_io;
+}
+
+struct diff_io *diff_io_new_async(bool is_write, bool is_nowait,
+				  void (*notify_cb)(void *ctx), void *ctx)
+{
+	struct diff_io *diff_io;
+
+	diff_io = diff_io_new(is_write, is_nowait);
+	if (unlikely(!diff_io))
+		return NULL;
+
+	diff_io->is_sync_io = false;
+	INIT_WORK(&diff_io->notify.async.work, diff_io_notify_cb);
+	diff_io->notify.async.ctx = ctx;
+	diff_io->notify.async.notify_cb = notify_cb;
+	return diff_io;
+}
+
+static inline bool check_page_aligned(sector_t sector)
+{
+	return !(sector & ((1ULL << (PAGE_SHIFT - SECTOR_SHIFT)) - 1));
+}
+
+static inline unsigned short calc_page_count(sector_t sectors)
+{
+	return round_up(sectors, SECTOR_IN_PAGE) / SECTOR_IN_PAGE;
+}
+
+int diff_io_do(struct diff_io *diff_io, struct diff_region *diff_region,
+	       struct diff_buffer *diff_buffer, const bool is_nowait)
+{
+	int ret = 0;
+	struct bio *bio = NULL;
+	struct bio *flush_bio = NULL;
+	struct page **current_page_ptr;
+	unsigned int opf;
+	gfp_t gfp;
+	unsigned short nr_iovecs;
+	sector_t processed = 0;
+
+	if (unlikely(!check_page_aligned(diff_region->sector))) {
+		pr_err("Difference storage block should be aligned to PAGE_SIZE\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	nr_iovecs = calc_page_count(diff_region->count);
+	if (unlikely(nr_iovecs > diff_buffer->page_count)) {
+		pr_err("The difference storage block is larger than the buffer size\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	// Allocate both bios
+	opf = diff_io->is_write ? REQ_OP_WRITE : REQ_OP_READ;
+	gfp = GFP_NOIO | (is_nowait ? GFP_NOWAIT : 0);
+
+	bio = bio_alloc_bioset(diff_region->bdev, nr_iovecs,
+			       opf | REQ_SYNC | REQ_IDLE | REQ_FUA,
+			       gfp, &diff_io_bioset);
+	if (unlikely(!bio)) {
+		if (is_nowait)
+			ret = -EAGAIN;
+		else
+			ret = -ENOMEM;
+		goto fail;
+	}
+
+	flush_bio = bio_alloc_bioset(diff_region->bdev, 0,
+				     opf | REQ_SYNC | REQ_PREFLUSH,
+				     gfp, &diff_io_bioset);
+	if (unlikely(!flush_bio)) {
+		if (is_nowait)
+			ret = -EAGAIN;
+		else
+			ret = -ENOMEM;
+		goto fail;
+	}
+
+	atomic_set(&diff_io->bio_count, 2);
+
+	// Submit bio with datas
+	bio_set_flag(bio, BIO_FILTERED);
+	bio->bi_end_io = diff_io_endio;
+	bio->bi_private = diff_io;
+	bio->bi_iter.bi_sector = diff_region->sector;
+
+	current_page_ptr = diff_buffer->pages;
+	while (processed < diff_region->count) {
+		sector_t bvec_len_sect;
+		unsigned int bvec_len;
+
+		bvec_len_sect = min_t(sector_t, SECTORS_IN_PAGE,
+				      diff_region->count - processed);
+		bvec_len = (unsigned int)(bvec_len_sect << SECTOR_SHIFT);
+
+		if (bio_add_page(bio, *current_page_ptr, bvec_len, 0) == 0) {
+			bio_put(bio);
+			return -EFAULT;
+		}
+
+		current_page_ptr++;
+		processed += bvec_len_sect;
+	}
+	submit_bio_noacct(bio);
+
+	// Submit flush bio
+	bio_set_flag(flush_bio, BIO_FILTERED);
+	flush_bio->bi_end_io = diff_io_endio;
+	flush_bio->bi_private = diff_io;
+	flush_bio->bi_iter.bi_sector = 0;
+	submit_bio_noacct(flush_bio);
+
+	if (diff_io->is_sync_io)
+		wait_for_completion_io(&diff_io->notify.sync.completion);
+
+	return 0;
+fail:
+	if (bio)
+		bio_put(bio);
+	if (flush_bio)
+		bio_put(flush_bio);
+	return ret;
+}
diff --git a/drivers/block/blksnap/diff_io.h b/drivers/block/blksnap/diff_io.h
new file mode 100644
index 000000000000..40cd3d88c838
--- /dev/null
+++ b/drivers/block/blksnap/diff_io.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+
+struct diff_buffer;
+
+/**
+ * struct diff_region - Describes the location of the chunks data on
+ *	difference storage.
+ * @bdev:
+ *	The target block device.
+ * @sector:
+ *	The sector offset of the region's first sector.
+ * @count:
+ *	The count of sectors in the region.
+ */
+struct diff_region {
+	struct block_device *bdev;
+	sector_t sector;
+	sector_t count;
+};
+
+/**
+ * struct diff_io_sync - Structure for notification about completion of
+ *	synchronous I/O.
+ * @completion:
+ *	Indicates that the request has been processed.
+ *
+ * Allows to wait for completion of the I/O operation in the
+ * current thread.
+ */
+struct diff_io_sync {
+	struct completion completion;
+};
+
+/**
+ * struct diff_io_async - Structure for notification about completion of
+ *	asynchronous I/O.
+ * @work:
+ *	The &struct work_struct allows to schedule execution of an I/O operation
+ *	in a separate process.
+ * @notify_cb:
+ *	A pointer to the callback function that will be executed when
+ *	the I/O execution is completed.
+ * @ctx:
+ *	The context for the callback function &notify_cb.
+ *
+ * Allows to schedule execution of an I/O operation.
+ */
+struct diff_io_async {
+	struct work_struct work;
+	void (*notify_cb)(void *ctx);
+	void *ctx;
+};
+
+/**
+ * struct diff_io - Structure for I/O maintenance.
+ * @error:
+ *	Zero if the I/O operation is successful, or an error code if it fails.
+ * @bio_count:
+ *	The count of bio in the I/O request.
+ * @is_write:
+ *	Indicates that a write operation is being performed.
+ * @is_sync_io:
+ *	Indicates that the operation is being performed synchronously.
+ * @notify:
+ *	This union may contain the diff_io_sync or diff_io_async structure
+ *	for synchronous or asynchronous request.
+ *
+ * The request to perform an I/O operation is executed for a region of sectors.
+ * Such a region may contain several bios. It is necessary to notify about the
+ * completion of processing of all bios. The diff_io structure allows to do it.
+ */
+struct diff_io {
+	int error;
+	atomic_t bio_count;
+	bool is_write;
+	bool is_sync_io;
+	union {
+		struct diff_io_sync sync;
+		struct diff_io_async async;
+	} notify;
+};
+
+int diff_io_init(void);
+void diff_io_done(void);
+
+static inline void diff_io_free(struct diff_io *diff_io)
+{
+	kfree(diff_io);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	if (diff_io)
+		memory_object_dec(memory_object_diff_io);
+#endif
+}
+
+struct diff_io *diff_io_new_sync(bool is_write);
+static inline struct diff_io *diff_io_new_sync_read(void)
+{
+	return diff_io_new_sync(false);
+};
+static inline struct diff_io *diff_io_new_sync_write(void)
+{
+	return diff_io_new_sync(true);
+};
+
+struct diff_io *diff_io_new_async(bool is_write, bool is_nowait,
+				  void (*notify_cb)(void *ctx), void *ctx);
+static inline struct diff_io *
+diff_io_new_async_read(void (*notify_cb)(void *ctx), void *ctx, bool is_nowait)
+{
+	return diff_io_new_async(false, is_nowait, notify_cb, ctx);
+};
+static inline struct diff_io *
+diff_io_new_async_write(void (*notify_cb)(void *ctx), void *ctx, bool is_nowait)
+{
+	return diff_io_new_async(true, is_nowait, notify_cb, ctx);
+};
+
+int diff_io_do(struct diff_io *diff_io, struct diff_region *diff_region,
+	       struct diff_buffer *diff_buffer, const bool is_nowait);
-- 
2.20.1


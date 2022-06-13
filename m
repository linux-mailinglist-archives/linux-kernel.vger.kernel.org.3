Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302C549C56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiFMS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbiFMSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:28 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8651FC83B;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id E5A85431EC;
        Mon, 13 Jun 2022 11:54:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135676;
        bh=xM4PR7f6c8ANBA1RRnQ/kf05YihgPD+psyj5Vw5aPz4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=istrJzPCnbRGOnFkFnwyFdPWm/ovhJejZMP0To9MCw4k6GWApX7U0f9sgQKJ6QPKR
         vz7LoD6nA/joX5Z132M5EqL8vNDyV/R9114SUkbeTzoCaLp38dPeoKuTHsajOCqNJn
         pkfXcsi1ccDuDISGmmpHUmUPcNn6Dqcbjd6wDluErvv518TYYQokRGIkeqQeXdLVfF
         1WS6fPtPjZBL+Hk4haw9O45f0fvNWMlDHdybJd9ORl6LrMIH/Do2DnN/4nHbiaIH66
         dYySF3m6LtAUwsKQMhNXK0ZHzY6xUI536KTMYwHbALQzmasAbM7GQkydGIMd3TjOKi
         zfMwt/JiozwAg==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:27 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 09/20] block, blksnap: minimum data storage unit of the original block device
Date:   Mon, 13 Jun 2022 18:53:02 +0300
Message-ID: <1655135593-1900-10-git-send-email-sergei.shtepa@veeam.com>
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

The struct chunk describes the minimum data storage unit of the original
block device. Functions for working with these minimal blocks implement
algorithms for reading and writing blocks.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/chunk.c | 352 ++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/chunk.h | 129 +++++++++++++
 2 files changed, 481 insertions(+)
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h

diff --git a/drivers/block/blksnap/chunk.c b/drivers/block/blksnap/chunk.c
new file mode 100644
index 000000000000..d2bb41a9e9ea
--- /dev/null
+++ b/drivers/block/blksnap/chunk.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-chunk: " fmt
+#include <linux/slab.h>
+#include <linux/dm-io.h>
+#include <linux/sched/mm.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "params.h"
+#include "chunk.h"
+#include "diff_io.h"
+#include "diff_buffer.h"
+#include "diff_area.h"
+#include "diff_storage.h"
+
+void chunk_diff_buffer_release(struct chunk *chunk)
+{
+	if (unlikely(!chunk->diff_buffer))
+		return;
+
+	chunk_state_unset(chunk, CHUNK_ST_BUFFER_READY);
+	diff_buffer_release(chunk->diff_area, chunk->diff_buffer);
+	chunk->diff_buffer = NULL;
+}
+
+void chunk_store_failed(struct chunk *chunk, int error)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+
+	chunk_state_set(chunk, CHUNK_ST_FAILED);
+	chunk_diff_buffer_release(chunk);
+	diff_storage_free_region(chunk->diff_region);
+	chunk->diff_region = NULL;
+
+	up(&chunk->lock);
+	if (error)
+		diff_area_set_corrupted(diff_area, error);
+};
+
+int chunk_schedule_storing(struct chunk *chunk, bool is_nowait)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+
+	//pr_debug("Schedule storing chunk #%ld\n", chunk->number);
+	if (WARN(!list_is_first(&chunk->cache_link, &chunk->cache_link),
+		 "The chunk already in the cache"))
+		return -EINVAL;
+
+#ifdef CONFIG_BLK_SNAP_ALLOW_DIFF_STORAGE_IN_MEMORY
+	if (diff_area->in_memory) {
+		up(&chunk->lock);
+		return 0;
+	}
+#endif
+	if (!chunk->diff_region) {
+		struct diff_region *diff_region;
+
+		diff_region = diff_storage_new_region(
+			diff_area->diff_storage,
+			diff_area_chunk_sectors(diff_area));
+		if (IS_ERR(diff_region)) {
+			pr_debug("Cannot get store for chunk #%ld\n",
+				 chunk->number);
+			return PTR_ERR(diff_region);
+		}
+
+		chunk->diff_region = diff_region;
+	}
+
+	return chunk_async_store_diff(chunk, is_nowait);
+}
+
+void chunk_schedule_caching(struct chunk *chunk)
+{
+	int in_cache_count = 0;
+	struct diff_area *diff_area = chunk->diff_area;
+
+	might_sleep();
+
+	//pr_debug("Add chunk #%ld to cache\n", chunk->number);
+	spin_lock(&diff_area->caches_lock);
+	if (WARN(!list_is_first(&chunk->cache_link, &chunk->cache_link),
+		 "The chunk already in the cache")) {
+		spin_unlock(&diff_area->caches_lock);
+
+		chunk_store_failed(chunk, 0);
+		return;
+	}
+
+	if (chunk_state_check(chunk, CHUNK_ST_DIRTY)) {
+		list_add_tail(&chunk->cache_link,
+			      &diff_area->write_cache_queue);
+		in_cache_count =
+			atomic_inc_return(&diff_area->write_cache_count);
+	} else {
+		list_add_tail(&chunk->cache_link, &diff_area->read_cache_queue);
+		in_cache_count =
+			atomic_inc_return(&diff_area->read_cache_count);
+	}
+	spin_unlock(&diff_area->caches_lock);
+
+	up(&chunk->lock);
+
+	// Initiate the cache clearing process.
+	if ((in_cache_count > chunk_maximum_in_cache) &&
+	    !diff_area_is_corrupted(diff_area))
+		queue_work(system_wq, &diff_area->cache_release_work);
+}
+
+static void chunk_notify_load(void *ctx)
+{
+	struct chunk *chunk = ctx;
+	int error = chunk->diff_io->error;
+
+	diff_io_free(chunk->diff_io);
+	chunk->diff_io = NULL;
+
+	might_sleep();
+
+	if (unlikely(error)) {
+		chunk_store_failed(chunk, error);
+		goto out;
+	}
+
+	if (unlikely(chunk_state_check(chunk, CHUNK_ST_FAILED))) {
+		pr_err("Chunk in a failed state\n");
+		up(&chunk->lock);
+		goto out;
+	}
+
+	if (chunk_state_check(chunk, CHUNK_ST_LOADING)) {
+		int ret;
+		unsigned int current_flag;
+
+		chunk_state_unset(chunk, CHUNK_ST_LOADING);
+		chunk_state_set(chunk, CHUNK_ST_BUFFER_READY);
+
+		current_flag = memalloc_noio_save();
+		ret = chunk_schedule_storing(chunk, false);
+		memalloc_noio_restore(current_flag);
+		if (ret)
+			chunk_store_failed(chunk, ret);
+		goto out;
+	}
+
+	pr_err("invalid chunk state 0x%x\n", atomic_read(&chunk->state));
+	up(&chunk->lock);
+out:
+	atomic_dec(&chunk->diff_area->pending_io_count);
+}
+
+static void chunk_notify_store(void *ctx)
+{
+	struct chunk *chunk = ctx;
+	int error = chunk->diff_io->error;
+
+	diff_io_free(chunk->diff_io);
+	chunk->diff_io = NULL;
+
+	might_sleep();
+
+	if (unlikely(error)) {
+		chunk_store_failed(chunk, error);
+		goto out;
+	}
+
+	if (unlikely(chunk_state_check(chunk, CHUNK_ST_FAILED))) {
+		pr_err("Chunk in a failed state\n");
+		chunk_store_failed(chunk, 0);
+		goto out;
+	}
+	if (chunk_state_check(chunk, CHUNK_ST_STORING)) {
+		chunk_state_unset(chunk, CHUNK_ST_STORING);
+		chunk_state_set(chunk, CHUNK_ST_STORE_READY);
+
+		if (chunk_state_check(chunk, CHUNK_ST_DIRTY)) {
+			chunk_state_unset(chunk, CHUNK_ST_DIRTY);
+			chunk_diff_buffer_release(chunk);
+		} else {
+			unsigned int current_flag;
+
+			current_flag = memalloc_noio_save();
+			chunk_schedule_caching(chunk);
+			memalloc_noio_restore(current_flag);
+			goto out;
+		}
+	} else
+		pr_err("invalid chunk state 0x%x\n", atomic_read(&chunk->state));
+	up(&chunk->lock);
+out:
+	atomic_dec(&chunk->diff_area->pending_io_count);
+}
+
+struct chunk *chunk_alloc(struct diff_area *diff_area, unsigned long number)
+{
+	struct chunk *chunk;
+
+	chunk = kzalloc(sizeof(struct chunk), GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_chunk);
+#endif
+	INIT_LIST_HEAD(&chunk->cache_link);
+	sema_init(&chunk->lock, 1);
+	chunk->diff_area = diff_area;
+	chunk->number = number;
+	atomic_set(&chunk->state, 0);
+
+	return chunk;
+}
+
+void chunk_free(struct chunk *chunk)
+{
+	if (unlikely(!chunk))
+		return;
+
+	down(&chunk->lock);
+	chunk_diff_buffer_release(chunk);
+	diff_storage_free_region(chunk->diff_region);
+	chunk_state_set(chunk, CHUNK_ST_FAILED);
+	up(&chunk->lock);
+
+	kfree(chunk);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_chunk);
+#endif
+}
+
+/**
+ * chunk_async_store_diff() - Starts asynchronous storing of a chunk to the
+ *	difference storage.
+ *
+ */
+int chunk_async_store_diff(struct chunk *chunk, bool is_nowait)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region *region = chunk->diff_region;
+
+	if (WARN(!list_is_first(&chunk->cache_link, &chunk->cache_link),
+		 "The chunk already in the cache"))
+		return -EINVAL;
+
+	diff_io = diff_io_new_async_write(chunk_notify_store, chunk, is_nowait);
+	if (unlikely(!diff_io)) {
+		if (is_nowait)
+			return -EAGAIN;
+		else
+			return -ENOMEM;
+	}
+
+	WARN_ON(chunk->diff_io);
+	chunk->diff_io = diff_io;
+	chunk_state_set(chunk, CHUNK_ST_STORING);
+	atomic_inc(&chunk->diff_area->pending_io_count);
+
+	ret = diff_io_do(chunk->diff_io, region, chunk->diff_buffer, is_nowait);
+	if (ret) {
+		atomic_dec(&chunk->diff_area->pending_io_count);
+		diff_io_free(chunk->diff_io);
+		chunk->diff_io = NULL;
+	}
+
+	return ret;
+}
+
+/**
+ * chunk_async_load_orig() - Starts asynchronous loading of a chunk from
+ *	the original block device.
+ */
+int chunk_async_load_orig(struct chunk *chunk, const bool is_nowait)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region region = {
+		.bdev = chunk->diff_area->orig_bdev,
+		.sector = (sector_t)(chunk->number) *
+			  diff_area_chunk_sectors(chunk->diff_area),
+		.count = chunk->sector_count,
+	};
+
+	diff_io = diff_io_new_async_read(chunk_notify_load, chunk, is_nowait);
+	if (unlikely(!diff_io)) {
+		if (is_nowait)
+			return -EAGAIN;
+		else
+			return -ENOMEM;
+	}
+
+	WARN_ON(chunk->diff_io);
+	chunk->diff_io = diff_io;
+	chunk_state_set(chunk, CHUNK_ST_LOADING);
+	atomic_inc(&chunk->diff_area->pending_io_count);
+
+	ret = diff_io_do(chunk->diff_io, &region, chunk->diff_buffer, is_nowait);
+	if (ret) {
+		atomic_dec(&chunk->diff_area->pending_io_count);
+		diff_io_free(chunk->diff_io);
+		chunk->diff_io = NULL;
+	}
+	return ret;
+}
+
+/**
+ * chunk_load_orig() - Performs synchronous loading of a chunk from the
+ *	original block device.
+ */
+int chunk_load_orig(struct chunk *chunk)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region region = {
+		.bdev = chunk->diff_area->orig_bdev,
+		.sector = (sector_t)(chunk->number) *
+			  diff_area_chunk_sectors(chunk->diff_area),
+		.count = chunk->sector_count,
+	};
+
+	diff_io = diff_io_new_sync_read();
+	if (unlikely(!diff_io))
+		return -ENOMEM;
+
+	ret = diff_io_do(diff_io, &region, chunk->diff_buffer, false);
+	if (!ret)
+		ret = diff_io->error;
+
+	diff_io_free(diff_io);
+	return ret;
+}
+
+/**
+ * chunk_load_diff() - Performs synchronous loading of a chunk from the
+ *	difference storage.
+ */
+int chunk_load_diff(struct chunk *chunk)
+{
+	int ret;
+	struct diff_io *diff_io;
+	struct diff_region *region = chunk->diff_region;
+
+	diff_io = diff_io_new_sync_read();
+	if (unlikely(!diff_io))
+		return -ENOMEM;
+
+	ret = diff_io_do(diff_io, region, chunk->diff_buffer, false);
+	if (!ret)
+		ret = diff_io->error;
+
+	diff_io_free(diff_io);
+	return ret;
+}
diff --git a/drivers/block/blksnap/chunk.h b/drivers/block/blksnap/chunk.h
new file mode 100644
index 000000000000..7f4f321aceed
--- /dev/null
+++ b/drivers/block/blksnap/chunk.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+#include <linux/rwsem.h>
+#include <linux/atomic.h>
+
+struct diff_area;
+struct diff_region;
+struct diff_io;
+
+/**
+ * enum chunk_st - Possible states for a chunk.
+ *
+ * @CHUNK_ST_FAILED:
+ *	An error occurred while processing the chunk data.
+ * @CHUNK_ST_DIRTY:
+ *	The chunk is in the dirty state. The chunk is marked dirty in case
+ *	there was a write operation to the snapshot image.
+ * @CHUNK_ST_BUFFER_READY:
+ *	The data of the chunk is ready to be read from the RAM buffer.
+ * @CHUNK_ST_STORE_READY:
+ *	The data of the chunk has been written to the difference storage.
+ * @CHUNK_ST_LOADING:
+ *	The data is being read from the original block device.
+ * @CHUNK_ST_STORING:
+ *	The data is being saved to the difference storage.
+ *
+ * Chunks life circle.
+ * Copy-on-write when writing to original:
+ *	0 -> LOADING -> BUFFER_READY -> BUFFER_READY | STORING ->
+ *	BUFFER_READY | STORE_READY -> STORE_READY
+ * Write to snapshot image:
+ *	0 -> LOADING -> BUFFER_READY | DIRTY -> DIRTY | STORING ->
+ *	BUFFER_READY | STORE_READY -> STORE_READY
+ */
+enum chunk_st {
+	CHUNK_ST_FAILED = (1 << 0),
+	CHUNK_ST_DIRTY = (1 << 1),
+	CHUNK_ST_BUFFER_READY = (1 << 2),
+	CHUNK_ST_STORE_READY = (1 << 3),
+	CHUNK_ST_LOADING = (1 << 4),
+	CHUNK_ST_STORING = (1 << 5),
+};
+
+/**
+ * struct chunk - Minimum data storage unit.
+ *
+ * @cache_link:
+ *	The list header allows to create caches of chunks.
+ * @diff_area:
+ *	Pointer to the difference area - the storage of changes for a specific device.
+ * @number:
+ *	Sequential number of the chunk.
+ * @sector_count:
+ *	Number of sectors in the current chunk. This is especially true
+ *	for the	last chunk.
+ * @lock:
+ *	Binary semaphore. Syncs access to the chunks fields: state,
+ *	diff_buffer, diff_region and diff_io.
+ * @state:
+ *	Defines the state of a chunk. May contain CHUNK_ST_* bits.
+ * @diff_buffer:
+ *	Pointer to &struct diff_buffer. Describes a buffer in the memory
+ *	for storing the chunk data.
+ * @diff_region:
+ *	Pointer to &struct diff_region. Describes a copy of the chunk data
+ *	on the difference storage.
+ * @diff_io:
+ *	Provides I/O operations for a chunk.
+ *
+ * This structure describes the block of data that the module operates
+ * with when executing the copy-on-write algorithm and when performing I/O
+ * to snapshot images.
+ *
+ * If the data of the chunk has been changed or has just been read, then
+ * the chunk gets into cache.
+ *
+ * The semaphore is blocked for writing if there is no actual data in the
+ * buffer, since a block of data is being read from the original device or
+ * from a diff storage. If data is being read from or written to the
+ * diff_buffer, the semaphore must be locked.
+ */
+struct chunk {
+	struct list_head cache_link;
+	struct diff_area *diff_area;
+
+	unsigned long number;
+	sector_t sector_count;
+
+	struct semaphore lock;
+
+	atomic_t state;
+	struct diff_buffer *diff_buffer;
+	struct diff_region *diff_region;
+	struct diff_io *diff_io;
+};
+
+static inline void chunk_state_set(struct chunk *chunk, int st)
+{
+	atomic_or(st, &chunk->state);
+};
+
+static inline void chunk_state_unset(struct chunk *chunk, int st)
+{
+	atomic_and(~st, &chunk->state);
+};
+
+static inline bool chunk_state_check(struct chunk *chunk, int st)
+{
+	return !!(atomic_read(&chunk->state) & st);
+};
+
+struct chunk *chunk_alloc(struct diff_area *diff_area, unsigned long number);
+void chunk_free(struct chunk *chunk);
+
+int chunk_schedule_storing(struct chunk *chunk, bool is_nowait);
+void chunk_diff_buffer_release(struct chunk *chunk);
+void chunk_store_failed(struct chunk *chunk, int error);
+
+void chunk_schedule_caching(struct chunk *chunk);
+
+/* Asynchronous operations are used to implement the COW algorithm. */
+int chunk_async_store_diff(struct chunk *chunk, bool is_nowait);
+int chunk_async_load_orig(struct chunk *chunk, const bool is_nowait);
+
+/* Synchronous operations are used to implement reading and writing to the snapshot image. */
+int chunk_load_orig(struct chunk *chunk);
+int chunk_load_diff(struct chunk *chunk);
-- 
2.20.1


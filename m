Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3650549C58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbiFMS4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiFMSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:29 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E56FCEC6;
        Mon, 13 Jun 2022 08:59:55 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 3B72243153;
        Mon, 13 Jun 2022 11:54:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135668;
        bh=9X64ZceNM+IfAVNDWnAE8KoqwfjGPLkSJ8g/cxM3Qmg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aTeDJNsYhkOb10Gezsqilo9TBHWwFGte6QzsDiKvQRIk0LU6GMmEh23s0j95Dsv+W
         jIIcc+6tuFw6meb4YSQVHArt/IRMT5V0DI4/lRXg1aQFLm5J5IY+iE5+9OyJVA2o6r
         i3jjuTf+8R1hF/Ay5A1zofSgAyT3tZDyOy5v1aWWG+TowfilgPcU2i0c0V4o0AFZUv
         TcjruhgJb3V2uh+9kbDhA8Q7s658VnOzsOTitN5U8nsPpPMTmFYbCXn3DOOB81hE7l
         ASeyN4aMWP8Mdv17txGmLl0drnWUBonrjUTFBzEsOTNjFvujFBrppITLP6G2dkxtkI
         twh2k4ZiMXCKA==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:20 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 07/20] block, blksnap: map of change block tracking
Date:   Mon, 13 Jun 2022 18:53:00 +0300
Message-ID: <1655135593-1900-8-git-send-email-sergei.shtepa@veeam.com>
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

Description of the struct cbt_map for storing change map data and
functions for managing this map.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/cbt_map.c | 280 ++++++++++++++++++++++++++++++++
 drivers/block/blksnap/cbt_map.h | 112 +++++++++++++
 2 files changed, 392 insertions(+)
 create mode 100644 drivers/block/blksnap/cbt_map.c
 create mode 100644 drivers/block/blksnap/cbt_map.h

diff --git a/drivers/block/blksnap/cbt_map.c b/drivers/block/blksnap/cbt_map.c
new file mode 100644
index 000000000000..aac0f9236d1a
--- /dev/null
+++ b/drivers/block/blksnap/cbt_map.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-cbt_map: " fmt
+#include <linux/slab.h>
+#include <linux/blk_snap.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "cbt_map.h"
+#include "params.h"
+
+static inline unsigned long long count_by_shift(sector_t capacity,
+						unsigned long long shift)
+{
+	sector_t blk_size = 1ull << (shift - SECTOR_SHIFT);
+
+	return round_up(capacity, blk_size) / blk_size;
+}
+
+static void cbt_map_calculate_block_size(struct cbt_map *cbt_map)
+{
+	unsigned long long shift;
+	unsigned long long count;
+
+	/**
+	 * The size of the tracking block is calculated based on the size of the disk
+	 * so that the CBT table does not exceed a reasonable size.
+	 */
+	shift = tracking_block_minimum_shift;
+	count = count_by_shift(cbt_map->device_capacity, shift);
+
+	while (count > tracking_block_maximum_count) {
+		shift = shift << 1;
+		count = count_by_shift(cbt_map->device_capacity, shift);
+	}
+
+	cbt_map->blk_size_shift = shift;
+	cbt_map->blk_count = count;
+}
+
+static int cbt_map_allocate(struct cbt_map *cbt_map)
+{
+	pr_debug("Allocate CBT map of %zu blocks\n", cbt_map->blk_count);
+
+	cbt_map->read_map = big_buffer_alloc(cbt_map->blk_count, GFP_KERNEL);
+	if (cbt_map->read_map != NULL)
+		big_buffer_memset(cbt_map->read_map, 0);
+
+	cbt_map->write_map = big_buffer_alloc(cbt_map->blk_count, GFP_KERNEL);
+	if (cbt_map->write_map != NULL)
+		big_buffer_memset(cbt_map->write_map, 0);
+
+	if ((cbt_map->read_map == NULL) || (cbt_map->write_map == NULL)) {
+		pr_err("Cannot allocate CBT map. %zu blocks are required.\n",
+		       cbt_map->blk_count);
+		return -ENOMEM;
+	}
+
+	cbt_map->snap_number_previous = 0;
+	cbt_map->snap_number_active = 1;
+	generate_random_uuid(cbt_map->generation_id.b);
+	cbt_map->is_corrupted = false;
+
+	return 0;
+}
+
+static void cbt_map_deallocate(struct cbt_map *cbt_map)
+{
+	cbt_map->is_corrupted = false;
+
+	if (cbt_map->read_map != NULL) {
+		big_buffer_free(cbt_map->read_map);
+		cbt_map->read_map = NULL;
+	}
+
+	if (cbt_map->write_map != NULL) {
+		big_buffer_free(cbt_map->write_map);
+		cbt_map->write_map = NULL;
+	}
+}
+
+int cbt_map_reset(struct cbt_map *cbt_map, sector_t device_capacity)
+{
+	cbt_map_deallocate(cbt_map);
+
+	cbt_map->device_capacity = device_capacity;
+	cbt_map_calculate_block_size(cbt_map);
+	cbt_map->is_corrupted = false;
+
+	return cbt_map_allocate(cbt_map);
+}
+
+static inline void cbt_map_destroy(struct cbt_map *cbt_map)
+{
+	pr_debug("CBT map destroy\n");
+
+	cbt_map_deallocate(cbt_map);
+	kfree(cbt_map);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_cbt_map);
+#endif
+}
+
+struct cbt_map *cbt_map_create(struct block_device *bdev)
+{
+	struct cbt_map *cbt_map = NULL;
+
+	pr_debug("CBT map create\n");
+
+	cbt_map = kzalloc(sizeof(struct cbt_map), GFP_KERNEL);
+	if (cbt_map == NULL)
+		return NULL;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_cbt_map);
+#endif
+	cbt_map->device_capacity = bdev_nr_sectors(bdev);
+	cbt_map_calculate_block_size(cbt_map);
+
+	if (cbt_map_allocate(cbt_map)) {
+		cbt_map_destroy(cbt_map);
+		return NULL;
+	}
+
+	spin_lock_init(&cbt_map->locker);
+	kref_init(&cbt_map->kref);
+	cbt_map->is_corrupted = false;
+
+	return cbt_map;
+}
+
+void cbt_map_destroy_cb(struct kref *kref)
+{
+	cbt_map_destroy(container_of(kref, struct cbt_map, kref));
+}
+
+void cbt_map_switch(struct cbt_map *cbt_map)
+{
+	pr_debug("CBT map switch\n");
+	spin_lock(&cbt_map->locker);
+
+	big_buffer_memcpy(cbt_map->read_map, cbt_map->write_map);
+
+	cbt_map->snap_number_previous = cbt_map->snap_number_active;
+	++cbt_map->snap_number_active;
+	if (cbt_map->snap_number_active == 256) {
+		cbt_map->snap_number_active = 1;
+
+		big_buffer_memset(cbt_map->write_map, 0);
+
+		generate_random_uuid(cbt_map->generation_id.b);
+
+		pr_debug("CBT reset\n");
+	}
+	spin_unlock(&cbt_map->locker);
+}
+
+static inline int _cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start,
+			       sector_t sector_cnt, u8 snap_number,
+			       struct big_buffer *map)
+{
+	int res = 0;
+	u8 num;
+	size_t cbt_block;
+	size_t cbt_block_first = (size_t)(
+		sector_start >> (cbt_map->blk_size_shift - SECTOR_SHIFT));
+	size_t cbt_block_last =
+		(size_t)((sector_start + sector_cnt - 1) >>
+			 (cbt_map->blk_size_shift - SECTOR_SHIFT)); //inclusive
+
+	for (cbt_block = cbt_block_first; cbt_block <= cbt_block_last;
+	     ++cbt_block) {
+		if (unlikely(cbt_block >= cbt_map->blk_count)) {
+			pr_err("Block index is too large.\n");
+			pr_err("Block #%zu was demanded, map size %zu blocks.\n",
+			       cbt_block, cbt_map->blk_count);
+			res = -EINVAL;
+			break;
+		}
+
+		res = big_buffer_byte_get(map, cbt_block, &num);
+		if (unlikely(res)) {
+			pr_err("CBT table out of range\n");
+			break;
+		}
+
+		if (num < snap_number) {
+			res = big_buffer_byte_set(map, cbt_block, snap_number);
+			if (unlikely(res)) {
+				pr_err("CBT table out of range\n");
+				break;
+			}
+		}
+	}
+	return res;
+}
+
+int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start,
+		sector_t sector_cnt)
+{
+	int res;
+
+	spin_lock(&cbt_map->locker);
+	if (unlikely(cbt_map->is_corrupted)) {
+		spin_unlock(&cbt_map->locker);
+		return -EINVAL;
+	}
+	res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+			   (u8)cbt_map->snap_number_active, cbt_map->write_map);
+	if (unlikely(res))
+		cbt_map->is_corrupted = true;
+
+	spin_unlock(&cbt_map->locker);
+
+	return res;
+}
+
+int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start,
+		     sector_t sector_cnt)
+{
+	int res;
+
+	spin_lock(&cbt_map->locker);
+	if (unlikely(cbt_map->is_corrupted)) {
+		spin_unlock(&cbt_map->locker);
+		return -EINVAL;
+	}
+	res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+			   (u8)cbt_map->snap_number_active, cbt_map->write_map);
+	if (!res)
+		res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+				   (u8)cbt_map->snap_number_previous,
+				   cbt_map->read_map);
+	spin_unlock(&cbt_map->locker);
+
+	return res;
+}
+
+size_t cbt_map_read_to_user(struct cbt_map *cbt_map, char __user *user_buff,
+			    size_t offset, size_t size)
+{
+	size_t readed = 0;
+	size_t left_size;
+	size_t real_size = min((cbt_map->blk_count - offset), size);
+
+	if (unlikely(cbt_map->is_corrupted)) {
+		pr_err("CBT table was corrupted\n");
+		return -EFAULT;
+	}
+
+	left_size = real_size - big_buffer_copy_to_user(user_buff, offset,
+							cbt_map->read_map,
+							real_size);
+
+	if (left_size == 0)
+		readed = real_size;
+	else {
+		pr_err("Not all CBT data was read. Left [%zu] bytes\n",
+		       left_size);
+		readed = real_size - left_size;
+	}
+
+	return readed;
+}
+
+int cbt_map_mark_dirty_blocks(struct cbt_map *cbt_map,
+			      struct blk_snap_block_range *block_ranges,
+			      unsigned int count)
+{
+	int inx;
+	int ret = 0;
+
+	for (inx = 0; inx < count; inx++) {
+		ret = cbt_map_set_both(
+			cbt_map, (sector_t)block_ranges[inx].sector_offset,
+			(sector_t)block_ranges[inx].sector_count);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
diff --git a/drivers/block/blksnap/cbt_map.h b/drivers/block/blksnap/cbt_map.h
new file mode 100644
index 000000000000..934f417f7da7
--- /dev/null
+++ b/drivers/block/blksnap/cbt_map.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/uuid.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+
+#include "big_buffer.h"
+
+struct blk_snap_block_range;
+
+/**
+ * struct cbt_map - The table of changes for a block device.
+ *
+ * @kref:
+ *	Reference counter.
+ * @locker:
+ *	Locking for atomic modification of structure members.
+ * @blk_size_shift:
+ *	The power of 2 used to specify the change tracking block size.
+ * @blk_count:
+ *	The number of change tracking blocks.
+ * @device_capacity:
+ *	The actual capacity of the device.
+ * @read_map:
+ *	A table of changes available for reading. This is the table that can
+ *	be read after taking a snapshot.
+ * @write_map:
+ *	The current table for tracking changes.
+ * @snap_number_active:
+ *	The current sequential number of changes. This is the number that is written to
+ *	the current table when the block data changes.
+ * @snap_number_previous:
+ *	The previous sequential number of changes. This number is used to identify the
+ *	blocks that were changed between the penultimate snapshot and the last snapshot.
+ * @generation_id:
+ *	UUID of the generation of changes.
+ * @is_corrupted:
+ *	A flag that the change tracking data is no longer reliable.
+ *
+ * The change block tracking map is a byte table. Each byte stores the
+ * sequential number of changes for one block. To determine which blocks have changed
+ * since the previous snapshot with the change number 4, it is enough to
+ * find all bytes with the number more than 4.
+ *
+ * Since one byte is allocated to track changes in one block, the change
+ * table is created again at the 255th snapshot. At the same time, a new
+ * unique generation identifier is generated. Tracking changes is
+ * possible only for tables of the same generation.
+ *
+ * There are two tables on the change block tracking map. One is
+ * available for reading, and the other is available for writing. At the moment of taking
+ * a snapshot, the tables are synchronized. The user's process, when
+ * calling the corresponding ioctl, can read the readable table.
+ * At the same time, the change tracking mechanism continues to work with
+ * the writable table.
+ *
+ * To provide the ability to mount a snapshot image as writeable, it is
+ * possible to make changes to both of these tables simultaneously.
+ *
+ */
+struct cbt_map {
+	struct kref kref;
+
+	spinlock_t locker;
+
+	size_t blk_size_shift;
+	size_t blk_count;
+	sector_t device_capacity;
+
+	struct big_buffer *read_map;
+	struct big_buffer *write_map;
+
+	unsigned long snap_number_active;
+	unsigned long snap_number_previous;
+	uuid_t generation_id;
+
+	bool is_corrupted;
+};
+
+struct cbt_map *cbt_map_create(struct block_device *bdev);
+int cbt_map_reset(struct cbt_map *cbt_map, sector_t device_capacity);
+
+void cbt_map_destroy_cb(struct kref *kref);
+static inline void cbt_map_get(struct cbt_map *cbt_map)
+{
+	kref_get(&cbt_map->kref);
+};
+static inline void cbt_map_put(struct cbt_map *cbt_map)
+{
+	if (likely(cbt_map))
+		kref_put(&cbt_map->kref, cbt_map_destroy_cb);
+};
+
+void cbt_map_switch(struct cbt_map *cbt_map);
+int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start,
+		sector_t sector_cnt);
+int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start,
+		     sector_t sector_cnt);
+
+size_t cbt_map_read_to_user(struct cbt_map *cbt_map, char __user *user_buffer,
+			    size_t offset, size_t size);
+
+static inline size_t cbt_map_blk_size(struct cbt_map *cbt_map)
+{
+	return 1 << cbt_map->blk_size_shift;
+};
+
+int cbt_map_mark_dirty_blocks(struct cbt_map *cbt_map,
+			      struct blk_snap_block_range *block_ranges,
+			      unsigned int count);
-- 
2.20.1


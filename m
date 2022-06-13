Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1779549C52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbiFMSz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbiFMSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:27 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D94FC832;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 0DCA8CCE1D;
        Mon, 13 Jun 2022 18:54:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1655135648;
        bh=1CZu+NgUluLzuDOy8s0m30AZwSGa0Kwnz7+ACG3wGDQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=oNMQjnthcNyrdCzyxDrD9naBj2jK9qAc7n3bVgk9x/4LPgV90kmXGI8pQgStKFdtP
         JmcljKToa2ZyiYZSrs/ADqvTRTUGW818ToADfD3y9vTR8MI3MBMO8TqIiiNDIHPniG
         ntOlFX59+CTsJxOXJfaMExnw3jhmnzKr/M7kce+kDhpgdlswggVp80b3pu/3vHrCEk
         HIdJD5MQazYzwKFnzFZZEPLEvXo8ZcoKO4xo0xl4QTcwqPguhcVTf//zjIw0Wo8Aea
         x7lEX32IHnmSKufW5rtoq9EyfdPU4SkeRBo7LhIfp+lKCeYWCMbIMZrzybO76fO3Q2
         NmI1JFhT299Ag==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:03 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 02/20] block, blksnap: header file of the module interface
Date:   Mon, 13 Jun 2022 18:52:55 +0300
Message-ID: <1655135593-1900-3-git-send-email-sergei.shtepa@veeam.com>
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

The header file contains a set of declarations, structures and control
requests (ioctl) that allows to manage the module from the user space.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 include/linux/blk_snap.h | 460 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 460 insertions(+)
 create mode 100644 include/linux/blk_snap.h

diff --git a/include/linux/blk_snap.h b/include/linux/blk_snap.h
new file mode 100644
index 000000000000..a3753a6a9527
--- /dev/null
+++ b/include/linux/blk_snap.h
@@ -0,0 +1,460 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#define BLK_SNAP_MODULE_NAME "blksnap"
+#define BLK_SNAP_IMAGE_NAME "blksnap-image"
+#define BLK_SNAP 'V'
+
+enum blk_snap_ioctl {
+	/*
+	 * Service controls
+	 */
+	blk_snap_ioctl_version,
+	/*
+	 * Contols for tracking
+	 */
+	blk_snap_ioctl_tracker_remove,
+	blk_snap_ioctl_tracker_collect,
+	blk_snap_ioctl_tracker_read_cbt_map,
+	blk_snap_ioctl_tracker_mark_dirty_blocks,
+	/*
+	 * Snapshot contols
+	 */
+	blk_snap_ioctl_snapshot_create,
+	blk_snap_ioctl_snapshot_destroy,
+	blk_snap_ioctl_snapshot_append_storage,
+	blk_snap_ioctl_snapshot_take,
+	blk_snap_ioctl_snapshot_collect,
+	blk_snap_ioctl_snapshot_collect_images,
+	blk_snap_ioctl_snapshot_wait_event,
+	blk_snap_ioctl_end,
+};
+
+/**
+ * struct blk_snap_version - Result for the &IOCTL_BLK_SNAP_VERSION control.
+ * @major:
+ *	Version major part.
+ * @minor:
+ *	Version minor part.
+ * @revision:
+ *	Revision number.
+ * @build:
+ *	Build number. Should be zero.
+ */
+struct blk_snap_version {
+	__u16 major;
+	__u16 minor;
+	__u16 revision;
+	__u16 build;
+};
+/**
+ * IOCTL_BLK_SNAP_VERSION - Get version and compatibility flags.
+ *
+ * Linking the product behavior to the version code does not seem to be a very
+ * good idea. Version is only for logs.
+ */
+#define IOCTL_BLK_SNAP_VERSION                                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_version, struct blk_snap_version)
+
+/*
+ * The main functionality of the module is change block tracking (CBT).
+ * Next, a number of ioctls will describe the interface for the CBT mechanism.
+ */
+
+/**
+ * struct blk_snap_dev_t - Block device ID.
+ * @mj:
+ *	Device ID major part.
+ * @mn:
+ *	Device ID minor part.
+ *
+ * In user space and in kernel space, block devices are encoded differently.
+ * We need to enter our own type to guarantee the correct transmission of the
+ * major and minor parts.
+ */
+struct blk_snap_dev_t {
+	__u32 mj;
+	__u32 mn;
+};
+
+/**
+ * struct blk_snap_tracker_remove - Input argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_REMOVE control.
+ * @dev_id:
+ *	Device ID.
+ */
+struct blk_snap_tracker_remove {
+	struct blk_snap_dev_t dev_id;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_REMOVE - Remove a device from tracking.
+ *
+ * Removes the device from tracking changes.
+ * Adding a device for tracking is performed when creating a snapshot
+ * that includes this device.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_REMOVE                                          \
+	_IOW(BLK_SNAP, blk_snap_ioctl_tracker_remove,                          \
+	     struct blk_snap_tracker_remove)
+
+/**
+ * struct blk_snap_cbt_info - Information about change tracking for a block
+ *	device.
+ * @dev_id:
+ *	Device ID.
+ * @blk_size:
+ *	Block size in bytes.
+ * @device_capacity:
+ *	Device capacity in bytes.
+ * @blk_count:
+ *	Number of blocks.
+ * @generation_id:
+ *	Unique identification number of change tracking generation.
+ * @snap_number:
+ *	Current changes number.
+ */
+struct blk_snap_cbt_info {
+	struct blk_snap_dev_t dev_id;
+	__u32 blk_size;
+	__u64 device_capacity;
+	__u32 blk_count;
+	uuid_t generation_id;
+	__u8 snap_number;
+};
+/**
+ * struct blk_snap_tracker_collect - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_COLLECT control.
+ * @count:
+ *	Size of @cbt_info_array in the number of &struct blk_snap_cbt_info.
+ *	If @cbt_info_array has not enough space, it will contain the required
+ *	size of the array.
+ * @cbt_info_array:
+ *	Pointer to the array for output.
+ */
+struct blk_snap_tracker_collect {
+	__u32 count;
+	struct blk_snap_cbt_info *cbt_info_array;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_COLLECT - Collect all tracked devices.
+ *
+ * Getting information about all devices under tracking.
+ * This ioctl returns the same information that the module outputs
+ * to sysfs for each device under tracking.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_COLLECT                                         \
+	_IOW(BLK_SNAP, blk_snap_ioctl_tracker_collect,                         \
+	     struct blk_snap_tracker_collect)
+
+/**
+ * struct blk_snap_tracker_read_cbt_bitmap - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP control.
+ * @dev_id:
+ *	Device ID.
+ * @offset:
+ *	Offset from the beginning of the CBT bitmap in bytes.
+ * @length:
+ *	Size of @buff in bytes.
+ * @buff:
+ *	Pointer to the buffer for output.
+ */
+struct blk_snap_tracker_read_cbt_bitmap {
+	struct blk_snap_dev_t dev_id;
+	__u32 offset;
+	__u32 length;
+	__u8 *buff;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP - Read the CBT map.
+ *
+ * This ioctl allows to read the table of changes. Sysfs also has a file that
+ * allows to read this table.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_READ_CBT_MAP                                    \
+	_IOR(BLK_SNAP, blk_snap_ioctl_tracker_read_cbt_map,                    \
+	     struct blk_snap_tracker_read_cbt_bitmap)
+
+/**
+ * struct blk_snap_block_range - Element of array for
+ *	&struct blk_snap_tracker_mark_dirty_blocks.
+ * @sector_offset:
+ *	Offset from the beginning of the disk in sectors.
+ * @sector_count:
+ *	Number of sectors.
+ */
+struct blk_snap_block_range {
+	__u64 sector_offset;
+	__u64 sector_count;
+};
+/**
+ * struct blk_snap_tracker_mark_dirty_blocks - Argument for the
+ *	&IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS control.
+ * @dev_id:
+ *	Device ID.
+ * @count:
+ *	Size of @dirty_blocks_array in the number of
+ *	&struct blk_snap_block_range.
+ * @dirty_blocks_array:
+ *	Pointer to the array of &struct blk_snap_block_range.
+ */
+struct blk_snap_tracker_mark_dirty_blocks {
+	struct blk_snap_dev_t dev_id;
+	__u32 count;
+	struct blk_snap_block_range *dirty_blocks_array;
+};
+/**
+ * IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS - Set dirty blocks in the CBT map.
+ *
+ * There are cases when some blocks need to be marked as changed.
+ * This ioctl allows to do this.
+ */
+#define IOCTL_BLK_SNAP_TRACKER_MARK_DIRTY_BLOCKS                               \
+	_IOR(BLK_SNAP, blk_snap_ioctl_tracker_mark_dirty_blocks,               \
+	     struct blk_snap_tracker_mark_dirty_blocks)
+
+/*
+ * Next, there will be a description of the interface for working with
+ * snapshots.
+ */
+
+/**
+ * struct blk_snap_snapshot_create - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_CREATE control.
+ * @count:
+ *	Size of @dev_id_array in the number of &struct blk_snap_dev_t.
+ * @dev_id_array:
+ *	Pointer to the array of &struct blk_snap_dev_t.
+ * @id:
+ *	Return ID of the created snapshot.
+ */
+struct blk_snap_snapshot_create {
+	__u32 count;
+	struct blk_snap_dev_t *dev_id_array;
+	uuid_t id;
+};
+/**
+ * This ioctl creates a snapshot structure in the memory and allocates an
+ * identifier for it. Further interaction with the snapshot is possible by
+ * this identifier.
+ * Several snapshots can be created at the same time, but with the condition
+ * that one block device can only be included in one snapshot.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_CREATE                                         \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_create,                         \
+	     struct blk_snap_snapshot_create)
+
+/**
+ * struct blk_snap_snapshot_destroy - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_DESTROY control.
+ * @id:
+ *	Snapshot ID.
+ */
+struct blk_snap_snapshot_destroy {
+	uuid_t id;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_DESTROY - Release and destroy the snapshot.
+ *
+ * Destroys all snapshot structures and releases all its allocated resources.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_DESTROY                                        \
+	_IOR(BLK_SNAP, blk_snap_ioctl_snapshot_destroy,                        \
+	     struct blk_snap_snapshot_destroy)
+
+/**
+ * struct blk_snap_snapshot_append_storage - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE control.
+ * @id:
+ *	Snapshot ID.
+ * @dev_id:
+ *	Device ID.
+ * @count:
+ *	Size of @ranges in the number of &struct blk_snap_block_range.
+ * @ranges:
+ *	Pointer to the array of &struct blk_snap_block_range.
+ */
+struct blk_snap_snapshot_append_storage {
+	uuid_t id;
+	struct blk_snap_dev_t dev_id;
+	__u32 count;
+	struct blk_snap_block_range *ranges;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE - Append storage to the difference
+ *	storage of the snapshot.
+ *
+ * The snapshot difference storage can be set either before or after creating
+ * the snapshot images. This allows to dynamically expand the difference
+ * storage while holding the snapshot.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_APPEND_STORAGE                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_append_storage,                 \
+	     struct blk_snap_snapshot_append_storage)
+
+/**
+ * struct blk_snap_snapshot_take - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_TAKE control.
+ * @id:
+ *	Snapshot ID.
+ */
+struct blk_snap_snapshot_take {
+	uuid_t id;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_TAKE - Take snapshot.
+ *
+ * This ioctl creates snapshot images of block devices and switches CBT tables.
+ * The snapshot must be created before this call, and the areas of block
+ * devices should be added to the difference storage.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_TAKE                                           \
+	_IOR(BLK_SNAP, blk_snap_ioctl_snapshot_take,                           \
+	     struct blk_snap_snapshot_take)
+
+/**
+ * struct blk_snap_snapshot_collect - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_COLLECT control.
+ * @count:
+ *	Size of @ids in the number of &uuid_t.
+ *	If @ids has not enough space, it will contain the required
+ *      size of the array.
+ * @ids:
+ *	Pointer to the array with the snapshot ID for output. If the pointer is
+ *	zero, the ioctl returns the number of active snapshots in &count.
+ *
+ */
+struct blk_snap_snapshot_collect {
+	__u32 count;
+	uuid_t *ids;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_COLLECT - Get collection of created snapshots.
+ *
+ * This information can also be obtained from files from sysfs.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT                                        \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_collect,                        \
+	     struct blk_snap_snapshot_collect)
+/**
+ * struct blk_snap_image_info - Associates the original device in the snapshot
+ *	and the corresponding snapshot image.
+ * @orig_dev_id:
+ *	Device ID.
+ * @image_dev_id:
+ *	Image ID.
+ */
+struct blk_snap_image_info {
+	struct blk_snap_dev_t orig_dev_id;
+	struct blk_snap_dev_t image_dev_id;
+};
+/**
+ * struct blk_snap_snapshot_collect_images - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES control.
+ * @id:
+ *	Snapshot ID.
+ * @count:
+ *	Size of @image_info_array in the number of &struct blk_snap_image_info.
+ *	If @image_info_array has not enough space, it will contain the required
+ *      size of the array.
+ * @image_info_array:
+ *	Pointer to the array for output.
+ */
+struct blk_snap_snapshot_collect_images {
+	uuid_t id;
+	__u32 count;
+	struct blk_snap_image_info *image_info_array;
+};
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES - Get a collection of devices and
+ *	their snapshot images.
+ *
+ * While holding the snapshot, this ioctl allows you to get a table of
+ * correspondences of the original devices and their snapshot images.
+ * This information can also be obtained from files from sysfs.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_COLLECT_IMAGES                                 \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_collect_images,                 \
+	     struct blk_snap_snapshot_collect_images)
+
+enum blk_snap_event_codes {
+	/**
+	 * Low free space in difference storage event.
+	 *
+	 * If the free space in the difference storage is reduced to the
+	 * specified limit, the module generates this event.
+	 */
+	blk_snap_event_code_low_free_space,
+	/**
+	 * Snapshot image is corrupted event.
+	 *
+	 * If a chunk could not be allocated when trying to save data to the
+	 * difference storage, this event is generated.
+	 * However, this does not mean that the backup process was interrupted
+	 * with an error. If the snapshot image has been read to the end by
+	 * this time, the backup process is considered successful.
+	 */
+	blk_snap_event_code_corrupted,
+};
+
+/**
+ * struct blk_snap_snapshot_event - Argument for the
+ *	&IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT control.
+ * @id:
+ *	Snapshot ID.
+ * @timeout_ms:
+ *	Timeout for waiting in milliseconds.
+ * @time_label:
+ *	Timestamp of the received event.
+ * @code:
+ *	Code of the received event.
+ * @data:
+ *	The received event body.
+ */
+struct blk_snap_snapshot_event {
+	uuid_t id;
+	__u32 timeout_ms;
+	__u32 code;
+	__s64 time_label;
+	__u8 data[4096 - 32];
+};
+static_assert(
+	sizeof(struct blk_snap_snapshot_event) == 4096,
+	"The size struct blk_snap_snapshot_event should be equal to the size of the page.");
+
+/**
+ * IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT - Wait and get the event from the
+ *	snapshot.
+ *
+ * While holding the snapshot, the kernel module can transmit information about
+ * changes in its state in the form of events to the user level.
+ * It is very important to receive these events as quickly as possible, so the
+ * user's thread is in the state of interruptable sleep.
+ */
+#define IOCTL_BLK_SNAP_SNAPSHOT_WAIT_EVENT                                     \
+	_IOW(BLK_SNAP, blk_snap_ioctl_snapshot_wait_event,                     \
+	     struct blk_snap_snapshot_event)
+
+/**
+ * struct blk_snap_event_low_free_space - Data for the
+ *	&blk_snap_event_code_low_free_space event.
+ * @requested_nr_sect:
+ *	The required number of sectors.
+ */
+struct blk_snap_event_low_free_space {
+	__u64 requested_nr_sect;
+};
+
+/**
+ * struct blk_snap_event_corrupted - Data for the
+ *	&blk_snap_event_code_corrupted event.
+ * @orig_dev_id:
+ *	Device ID.
+ * @err_code:
+ *	Error code.
+ */
+struct blk_snap_event_corrupted {
+	struct blk_snap_dev_t orig_dev_id;
+	__s32 err_code;
+};
-- 
2.20.1


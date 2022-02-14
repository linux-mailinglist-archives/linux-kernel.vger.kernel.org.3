Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61274B4359
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiBNIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:12:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiBNIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:12:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8CCC6C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:12:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CAC61376
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B1C340EF;
        Mon, 14 Feb 2022 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644826337;
        bh=ZgEUv8gmKaoyd1kdV6ajoZHohPsWoJGOTKTgy/xXKZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMWdov/hT9YTPqhFWPFkrbQYfw3oPv6l4IVx904qPBuqRsjEzwzQv4oZjOhreXIqk
         PcPiL8Hpyz+f9KTzyPyBhzXlSNxzv+vTljFyUCbFApI56RXV+W4OGoPNhsk8vIfAuj
         d61Ev6XJL+9/lAk1p/7Edrg02ITl6t9ypnPlnIq24Ig8ghGDNl8g+WCid/wKP83mwh
         1wpcSxFMXEEcVvqRMr6/tI3G+5QAUsy8CqInceKBTI8JgVJM2f4qZUS7ipxMCHvhjx
         5MwvLzTRZ1svPtYtcPvGTl3Ge3+6lwmPxDTNirN6Hu2YxobaZ1yiJ7K4DlDs+lV+kA
         hiTitbo62358A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/2] habanalabs: allow user to set allocation page size
Date:   Mon, 14 Feb 2022 10:12:10 +0200
Message-Id: <20220214081210.3999831-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214081210.3999831-1-ogabbay@kernel.org>
References: <20220214081210.3999831-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In future ASICs the MMU will be able to work with multiple page sizes,
thus a new flag is added to allow the user to set the requested page
size.

This flag is added since the whole DRAM is allocated for the user and
the user also should be familiar with the memory usage use case.

As such, the user may choose to "over allocate" memory in favor of
performance (for instance- large page allocations covers more memory
in less TLB entries).

For example: say available page sizes are of 1MB and 32MB. If user
wants to allocate 40MB the user can either set page size to 1MB and
allocate the exact amount of memory (but will result in 40 TLB entries)
or the user can use 32MB pages, "waste" 8MB of physical memory but
occupy only 2 TLB entries.

Note that this feature will be available only to ASIC that supports
multiple DRAM page sizes.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |   5 +
 drivers/misc/habanalabs/common/memory.c     |  31 +++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   3 +-
 drivers/misc/habanalabs/goya/goya.c         |   1 +
 include/uapi/misc/habanalabs.h              | 116 ++++++++++----------
 5 files changed, 99 insertions(+), 57 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b5055ab528b8..677ae4ff922c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -563,6 +563,7 @@ struct hl_hints_range {
  *                              devices)
  * @configurable_stop_on_err: is stop-on-error option configurable via debugfs.
  * @set_max_power_on_device_init: true if need to set max power in F/W on device init.
+ * @supports_user_set_page_size: true if user can set the allocation page size.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -648,6 +649,7 @@ struct asic_fixed_properties {
 	u8				allow_inference_soft_reset;
 	u8				configurable_stop_on_err;
 	u8				set_max_power_on_device_init;
+	u8				supports_user_set_page_size;
 };
 
 /**
@@ -1311,6 +1313,8 @@ struct fw_load_mgr {
  * @get_sob_addr: get SOB base address offset.
  * @set_pci_memory_regions: setting properties of PCI memory regions
  * @get_stream_master_qid_arr: get pointer to stream masters QID array
+ * @is_valid_dram_page_size: return true if page size is supported in device
+ *                           memory allocation, otherwise false.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1436,6 +1440,7 @@ struct hl_asic_funcs {
 	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
 	void (*set_pci_memory_regions)(struct hl_device *hdev);
 	u32* (*get_stream_master_qid_arr)(void);
+	bool (*is_valid_dram_page_size)(u32 page_size);
 };
 
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 7bd4cae87a54..385bf3448c73 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -24,6 +24,31 @@ MODULE_IMPORT_NS(DMA_BUF);
 static int allocate_timestamps_buffers(struct hl_fpriv *hpriv,
 			struct hl_mem_in *args, u64 *handle);
 
+static int set_alloc_page_size(struct hl_device *hdev, struct hl_mem_in *args, u32 *page_size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 psize;
+
+	/*
+	 * for ASIC that supports setting the allocation page size by user we will address
+	 * user's choice only if it is not 0 (as 0 means taking the default page size)
+	 */
+	if (prop->supports_user_set_page_size && args->alloc.page_size) {
+		psize = args->alloc.page_size;
+
+		if (!hdev->asic_funcs->is_valid_dram_page_size(psize)) {
+			dev_err(hdev->dev, "user page size (%#x) is not valid\n", psize);
+			return -EINVAL;
+		}
+	} else {
+		psize = hdev->asic_prop.dram_page_size;
+	}
+
+	*page_size = psize;
+
+	return 0;
+}
+
 /*
  * The va ranges in context object contain a list with the available chunks of
  * device virtual memory.
@@ -69,7 +94,11 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	bool contiguous;
 
 	num_curr_pgs = 0;
-	page_size = hdev->asic_prop.dram_page_size;
+
+	rc = set_alloc_page_size(hdev, args, &page_size);
+	if (rc)
+		return rc;
+
 	num_pgs = DIV_ROUND_UP_ULL(args->alloc.mem_size, page_size);
 	total_size = num_pgs * page_size;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ad640a268a3c..a60c0e23d23c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9432,7 +9432,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.state_dump_init = gaudi_state_dump_init,
 	.get_sob_addr = gaudi_get_sob_addr,
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
-	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr
+	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
+	.is_valid_dram_page_size = NULL
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c08d96e43c9f..ec9358bcbf0b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5764,6 +5764,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
+	.is_valid_dram_page_size = NULL
 };
 
 /*
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index e21db03196ae..1d6b4f0c4159 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -1116,98 +1116,104 @@ union hl_wait_cs_args {
 #define HL_MEM_USERPTR		0x4
 #define HL_MEM_FORCE_HINT	0x8
 
+/**
+ * structure hl_mem_in - structure that handle input args for memory IOCTL
+ * @union arg: union of structures to be used based on the input operation
+ * @op: specify the requested memory operation (one of the HL_MEM_OP_* definitions).
+ * @flags: flags for the memory operation (one of the HL_MEM_* definitions).
+ *         For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the DMA-BUF file/FD flags.
+ * @ctx_id: context ID - currently not in use.
+ * @num_of_elements: number of timestamp elements used only with HL_MEM_OP_TS_ALLOC opcode.
+ */
 struct hl_mem_in {
 	union {
-		/* HL_MEM_OP_ALLOC- allocate device memory */
+		/**
+		 * structure for device memory allocation (used with the HL_MEM_OP_ALLOC op)
+		 * @mem_size: memory size to allocate
+		 * @page_size: page size to use on allocation. when the value is 0 the default page
+		 *             size will be taken.
+		 */
 		struct {
-			/* Size to alloc */
 			__u64 mem_size;
+			__u64 page_size;
 		} alloc;
 
-		/* HL_MEM_OP_FREE - free device memory */
+		/**
+		 * structure for free-ing device memory (used with the HL_MEM_OP_FREE op)
+		 * @handle: handle returned from HL_MEM_OP_ALLOC
+		 */
 		struct {
-			/* Handle returned from HL_MEM_OP_ALLOC */
 			__u64 handle;
 		} free;
 
-		/* HL_MEM_OP_MAP - map device memory */
+		/**
+		 * structure for mapping device memory (used with the HL_MEM_OP_MAP op)
+		 * @hint_addr: requested virtual address of mapped memory.
+		 *             the driver will try to map the requested region to this hint
+		 *             address, as long as the address is valid and not already mapped.
+		 *             the user should check the returned address of the IOCTL to make
+		 *             sure he got the hint address.
+		 *             passing 0 here means that the driver will choose the address itself.
+		 * @handle: handle returned from HL_MEM_OP_ALLOC.
+		 */
 		struct {
-			/*
-			 * Requested virtual address of mapped memory.
-			 * The driver will try to map the requested region to
-			 * this hint address, as long as the address is valid
-			 * and not already mapped. The user should check the
-			 * returned address of the IOCTL to make sure he got
-			 * the hint address. Passing 0 here means that the
-			 * driver will choose the address itself.
-			 */
 			__u64 hint_addr;
-			/* Handle returned from HL_MEM_OP_ALLOC */
 			__u64 handle;
 		} map_device;
 
-		/* HL_MEM_OP_MAP - map host memory */
+		/**
+		 * structure for mapping host memory (used with the HL_MEM_OP_MAP op)
+		 * @host_virt_addr: address of allocated host memory.
+		 * @hint_addr: requested virtual address of mapped memory.
+		 *             the driver will try to map the requested region to this hint
+		 *             address, as long as the address is valid and not already mapped.
+		 *             the user should check the returned address of the IOCTL to make
+		 *             sure he got the hint address.
+		 *             passing 0 here means that the driver will choose the address itself.
+		 * @size: size of allocated host memory.
+		 */
 		struct {
-			/* Address of allocated host memory */
 			__u64 host_virt_addr;
-			/*
-			 * Requested virtual address of mapped memory.
-			 * The driver will try to map the requested region to
-			 * this hint address, as long as the address is valid
-			 * and not already mapped. The user should check the
-			 * returned address of the IOCTL to make sure he got
-			 * the hint address. Passing 0 here means that the
-			 * driver will choose the address itself.
-			 */
 			__u64 hint_addr;
-			/* Size of allocated host memory */
 			__u64 mem_size;
 		} map_host;
 
-		/* HL_MEM_OP_MAP_BLOCK - map a hw block */
+		/**
+		 * structure for mapping hw block (used with the HL_MEM_OP_MAP_BLOCK op)
+		 * @block_addr:HW block address to map, a handle and size will be returned
+		 *             to the user and will be used to mmap the relevant block.
+		 *             only addresses from configuration space are allowed.
+		 */
 		struct {
-			/*
-			 * HW block address to map, a handle and size will be
-			 * returned to the user and will be used to mmap the
-			 * relevant block. Only addresses from configuration
-			 * space are allowed.
-			 */
 			__u64 block_addr;
 		} map_block;
 
-		/* HL_MEM_OP_UNMAP - unmap host memory */
+		/**
+		 * structure for unmapping host memory (used with the HL_MEM_OP_UNMAP op)
+		 * @device_virt_addr: virtual address returned from HL_MEM_OP_MAP
+		 */
 		struct {
-			/* Virtual address returned from HL_MEM_OP_MAP */
 			__u64 device_virt_addr;
 		} unmap;
 
-		/* HL_MEM_OP_EXPORT_DMABUF_FD */
+		/**
+		 * structure for exporting DMABUF object (used with
+		 * the HL_MEM_OP_EXPORT_DMABUF_FD op)
+		 * @handle: handle returned from HL_MEM_OP_ALLOC.
+		 *          in Gaudi, where we don't have MMU for the device memory, the
+		 *          driver expects a physical address (instead of a handle) in the
+		 *          device memory space.
+		 * @mem_size: size of memory allocation. Relevant only for GAUDI
+		 */
 		struct {
-			/* Handle returned from HL_MEM_OP_ALLOC. In Gaudi,
-			 * where we don't have MMU for the device memory, the
-			 * driver expects a physical address (instead of
-			 * a handle) in the device memory space.
-			 */
 			__u64 handle;
-			/* Size of memory allocation. Relevant only for GAUDI */
 			__u64 mem_size;
 		} export_dmabuf_fd;
 	};
 
-	/* HL_MEM_OP_* */
 	__u32 op;
-	/* HL_MEM_* flags.
-	 * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
-	 * DMA-BUF file/FD flags.
-	 */
 	__u32 flags;
-
-	/* Context ID - Currently not in use */
 	__u32 ctx_id;
-
-	/* number of timestamp elements
-	 * used only when HL_MEM_OP_TS_ALLOC opcode
-	 */
 	__u32 num_of_elements;
 };
 
-- 
2.25.1


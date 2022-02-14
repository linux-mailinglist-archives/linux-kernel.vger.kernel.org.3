Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D14B51A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353981AbiBNN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:27:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347310AbiBNN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:26:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6D4EA00
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2FB1B80EB9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40864C340E9;
        Mon, 14 Feb 2022 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644845208;
        bh=lIrfx2bjIVzBroorw8gWz1CV5zkUStBQnJFwuv5QWbY=;
        h=From:To:Cc:Subject:Date:From;
        b=iWubYAaco3rO+HmfxzeLMCCBfIfEPLpCbZCIFFSCw3iIm9FgFccls9Rg+u8Y+8+tO
         wIZInhHOJ6s3l3gR3N8V+2saKL8VzSSDIMKi+7157l6bHxBAptj0H9TiqUNvLWi2sp
         zSUDGdu+FjgFsYJK/ffZrormdbbrLrteuoSb1T7tYnowEG1XCaOCEEHW2RFMr7awgC
         noehj5XyYDFJ3NQN5bXScZZRHlKFFY2pbd0syiAkkzojFcYjhXFRuGrVJdcJPaeeeP
         lSFB1Heov1Appp8Objo0Hz14mLzGsnr0zmxzpdkbWKc4daD7aKMcz+rjbDASxsgJwJ
         zkwxPlNGNX3IQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     hdanton@sina.com, Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH v2 1/2] habanalabs: use kernel-doc for memory ioctl documentation
Date:   Mon, 14 Feb 2022 15:26:41 +0200
Message-Id: <20220214132642.4032856-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Re-format the comments for the memory ioctl structure to be in
kernel-doc style.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/misc/habanalabs.h | 111 +++++++++++++++++----------------
 1 file changed, 57 insertions(+), 54 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index e21db03196ae..a2a953a91b5e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1116,98 +1116,101 @@ union hl_wait_cs_args {
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
+		 */
 		struct {
-			/* Size to alloc */
 			__u64 mem_size;
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF855DF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbiF1LBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbiF1LAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:00:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28625C69
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8DC54CE1FB7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A68C3411D;
        Tue, 28 Jun 2022 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414018;
        bh=jDtzQqvutECVaIBrAA07eb0y0SH60iECdpTXFGnGgCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGheg5VG4+Mct08WeBRrEX7y5BLounyJsXzpHpMO6Pbex6+MLiOUv/epu89G1Qygl
         haP0e66PeNuzS8X0evd1fW2Trok1CT1D/v/T1hgvVeFdoipHXZgkNYbgHZ7yuVS5IX
         uxKiKNDU7lG79NzMHc1FcZNTMPVsMLnAux/xRH6nyGcv1RmIvFf4MxmtLrxlEdG5si
         v1mSOGJ2LFWF8+29rCV2DuOiCZeWXBX6LF0IBl5ZL3h+YrYY3XAjw8JCgkII2svtgl
         C7j3cef5ljCeROHb89ZY9Luno2WhN4Lod1lPD5ev9Qqc8kirXtyanJIZd5qWNgw8gu
         XU1M5gieAaJhw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH v2 07/12] habanalabs: add generic security module
Date:   Tue, 28 Jun 2022 13:59:53 +0300
Message-Id: <20220628105958.1254875-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628105958.1254875-1-ogabbay@kernel.org>
References: <20220628105958.1254875-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As the ASICs become more complex and have many more registers, we need
a better way to configure the security properties.

As a reminder, we have two dedicated mechanisms for security:
Range Registers and Protection bits. Those mechanisms protect sensitive
memory and configuration areas inside the device.

The generic module handles the low-level part of the configuration,
because the configuration mechanism is identical in all ASICs. The
difference is the address ranges and register names.

Any ASIC that use this block should first block all the register
blocks in the ASIC. Then, it should open only the registers that
need to be accessed by the user (This is opposed to Goya and Gaudi,
where we blocked only what should not be accesses by the user).

The module contains several functions, to unblock single register,
multiple registers, entire blocks, ranges, ranges with mask.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/Makefile     |   4 +-
 drivers/misc/habanalabs/common/habanalabs.h |  69 +++
 drivers/misc/habanalabs/common/security.c   | 600 ++++++++++++++++++++
 3 files changed, 671 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/security.c

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 2bc022552acf..e6abffea9f87 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -11,5 +11,5 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
 		common/command_submission.o common/firmware_if.o \
-		common/state_dump.o common/memory_mgr.o \
-		common/decoder.o
+		common/security.o common/state_dump.o \
+		common/memory_mgr.o common/decoder.o
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e91dd22e6855..62a228ce9775 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -173,7 +173,23 @@ enum hl_mmu_page_table_location {
  * Security
  */
 
+#define HL_PB_SHARED		1
+#define HL_PB_NA		0
+#define HL_PB_SINGLE_INSTANCE	1
 #define HL_BLOCK_SIZE		0x1000
+#define HL_BLOCK_GLBL_ERR_MASK	0xF40
+#define HL_BLOCK_GLBL_ERR_ADDR	0xF44
+#define HL_BLOCK_GLBL_ERR_CAUSE	0xF48
+#define HL_BLOCK_GLBL_SEC_OFFS	0xF80
+#define HL_BLOCK_GLBL_SEC_SIZE	(HL_BLOCK_SIZE - HL_BLOCK_GLBL_SEC_OFFS)
+#define HL_BLOCK_GLBL_SEC_LEN	(HL_BLOCK_GLBL_SEC_SIZE / sizeof(u32))
+#define UNSET_GLBL_SEC_BIT(array, b) ((array)[((b) / 32)] |= (1 << ((b) % 32)))
+
+enum hl_protection_levels {
+	SECURED_LVL,
+	PRIVILEGED_LVL,
+	NON_SECURED_LVL
+};
 
 /**
  * struct iterate_module_ctx - HW module iterator
@@ -194,6 +210,10 @@ struct iterate_module_ctx {
 	void *data;
 };
 
+struct hl_block_glbl_sec {
+	u32 sec_array[HL_BLOCK_GLBL_SEC_LEN];
+};
+
 #define HL_MAX_SOBS_PER_MONITOR	8
 
 /**
@@ -3664,6 +3684,55 @@ static inline void hl_debugfs_set_state_dump(struct hl_device *hdev,
 
 #endif
 
+/* Security */
+int hl_unsecure_register(struct hl_device *hdev, u32 mm_reg_addr, int offset,
+		const u32 pb_blocks[], struct hl_block_glbl_sec sgs_array[],
+		int array_size);
+int hl_unsecure_registers(struct hl_device *hdev, const u32 mm_reg_array[],
+		int mm_array_size, int offset, const u32 pb_blocks[],
+		struct hl_block_glbl_sec sgs_array[], int blocks_array_size);
+void hl_config_glbl_sec(struct hl_device *hdev, const u32 pb_blocks[],
+		struct hl_block_glbl_sec sgs_array[], u32 block_offset,
+		int array_size);
+void hl_secure_block(struct hl_device *hdev,
+		struct hl_block_glbl_sec sgs_array[], int array_size);
+int hl_init_pb_with_mask(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const u32 *regs_array, u32 regs_array_size, u64 mask);
+int hl_init_pb(struct hl_device *hdev, u32 num_dcores, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const u32 *regs_array, u32 regs_array_size);
+int hl_init_pb_ranges_with_mask(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const struct range *regs_range_array, u32 regs_range_array_size,
+		u64 mask);
+int hl_init_pb_ranges(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const struct range *regs_range_array,
+		u32 regs_range_array_size);
+int hl_init_pb_single_dcore(struct hl_device *hdev, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const u32 *regs_array, u32 regs_array_size);
+int hl_init_pb_ranges_single_dcore(struct hl_device *hdev, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const struct range *regs_range_array,
+		u32 regs_range_array_size);
+void hl_ack_pb(struct hl_device *hdev, u32 num_dcores, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size);
+void hl_ack_pb_with_mask(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size, u64 mask);
+void hl_ack_pb_single_dcore(struct hl_device *hdev, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size);
+
 /* IOCTLs */
 long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg);
diff --git a/drivers/misc/habanalabs/common/security.c b/drivers/misc/habanalabs/common/security.c
new file mode 100644
index 000000000000..b27ab097776b
--- /dev/null
+++ b/drivers/misc/habanalabs/common/security.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+/**
+ * hl_get_pb_block - return the relevant block within the block array
+ *
+ * @hdev: pointer to hl_device structure
+ * @mm_reg_addr: register address in the desired block
+ * @pb_blocks: blocks array
+ * @array_size: blocks array size
+ *
+ */
+static int hl_get_pb_block(struct hl_device *hdev, u32 mm_reg_addr,
+		const u32 pb_blocks[], int array_size)
+{
+	int i;
+	u32 start_addr, end_addr;
+
+	for (i = 0 ; i < array_size ; i++) {
+		start_addr = pb_blocks[i];
+		end_addr = start_addr + HL_BLOCK_SIZE;
+
+		if ((mm_reg_addr >= start_addr) && (mm_reg_addr < end_addr))
+			return i;
+	}
+
+	dev_err(hdev->dev, "No protection domain was found for 0x%x\n",
+			mm_reg_addr);
+	return -EDOM;
+}
+
+/**
+ * hl_unset_pb_in_block - clear a specific protection bit in a block
+ *
+ * @hdev: pointer to hl_device structure
+ * @reg_offset: register offset will be converted to bit offset in pb block
+ * @sgs_entry: pb array
+ *
+ */
+static int hl_unset_pb_in_block(struct hl_device *hdev, u32 reg_offset,
+		struct hl_block_glbl_sec *sgs_entry)
+{
+	if ((reg_offset >= HL_BLOCK_SIZE) || (reg_offset & 0x3)) {
+		dev_err(hdev->dev,
+			"Register offset(%d) is out of range(%d) or invalid\n",
+			reg_offset, HL_BLOCK_SIZE);
+		return -EINVAL;
+	}
+
+	UNSET_GLBL_SEC_BIT(sgs_entry->sec_array,
+			 (reg_offset & (HL_BLOCK_SIZE - 1)) >> 2);
+
+	return 0;
+}
+
+/**
+ * hl_unsecure_register - locate the relevant block for this register and
+ *                        remove corresponding protection bit
+ *
+ * @hdev: pointer to hl_device structure
+ * @mm_reg_addr: register address to unsecure
+ * @offset: additional offset to the register address
+ * @pb_blocks: blocks array
+ * @sgs_array: pb array
+ * @array_size: blocks array size
+ *
+ */
+int hl_unsecure_register(struct hl_device *hdev, u32 mm_reg_addr, int offset,
+		const u32 pb_blocks[], struct hl_block_glbl_sec sgs_array[],
+		int array_size)
+{
+	u32 reg_offset;
+	int block_num;
+
+	block_num = hl_get_pb_block(hdev, mm_reg_addr + offset, pb_blocks,
+			array_size);
+	if (block_num < 0)
+		return block_num;
+
+	reg_offset = (mm_reg_addr + offset) - pb_blocks[block_num];
+
+	return hl_unset_pb_in_block(hdev, reg_offset, &sgs_array[block_num]);
+}
+
+/**
+ * hl_unsecure_register_range - locate the relevant block for this register
+ *                              range and remove corresponding protection bit
+ *
+ * @hdev: pointer to hl_device structure
+ * @mm_reg_range: register address range to unsecure
+ * @offset: additional offset to the register address
+ * @pb_blocks: blocks array
+ * @sgs_array: pb array
+ * @array_size: blocks array size
+ *
+ */
+static int hl_unsecure_register_range(struct hl_device *hdev,
+		struct range mm_reg_range, int offset, const u32 pb_blocks[],
+		struct hl_block_glbl_sec sgs_array[],
+		int array_size)
+{
+	u32 reg_offset;
+	int i, block_num, rc = 0;
+
+	block_num = hl_get_pb_block(hdev,
+			mm_reg_range.start + offset, pb_blocks,
+			array_size);
+	if (block_num < 0)
+		return block_num;
+
+	for (i = mm_reg_range.start ; i <= mm_reg_range.end ; i += 4) {
+		reg_offset = (i + offset) - pb_blocks[block_num];
+		rc |= hl_unset_pb_in_block(hdev, reg_offset,
+					&sgs_array[block_num]);
+	}
+
+	return rc;
+}
+
+/**
+ * hl_unsecure_registers - locate the relevant block for all registers and
+ *                        remove corresponding protection bit
+ *
+ * @hdev: pointer to hl_device structure
+ * @mm_reg_array: register address array to unsecure
+ * @mm_array_size: register array size
+ * @offset: additional offset to the register address
+ * @pb_blocks: blocks array
+ * @sgs_array: pb array
+ * @blocks_array_size: blocks array size
+ *
+ */
+int hl_unsecure_registers(struct hl_device *hdev, const u32 mm_reg_array[],
+		int mm_array_size, int offset, const u32 pb_blocks[],
+		struct hl_block_glbl_sec sgs_array[], int blocks_array_size)
+{
+	int i, rc = 0;
+
+	for (i = 0 ; i < mm_array_size ; i++) {
+		rc = hl_unsecure_register(hdev, mm_reg_array[i], offset,
+				pb_blocks, sgs_array, blocks_array_size);
+
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
+
+/**
+ * hl_unsecure_registers_range - locate the relevant block for all register
+ *                        ranges and remove corresponding protection bit
+ *
+ * @hdev: pointer to hl_device structure
+ * @mm_reg_range_array: register address range array to unsecure
+ * @mm_array_size: register array size
+ * @offset: additional offset to the register address
+ * @pb_blocks: blocks array
+ * @sgs_array: pb array
+ * @blocks_array_size: blocks array size
+ *
+ */
+static int hl_unsecure_registers_range(struct hl_device *hdev,
+		const struct range mm_reg_range_array[], int mm_array_size,
+		int offset, const u32 pb_blocks[],
+		struct hl_block_glbl_sec sgs_array[], int blocks_array_size)
+{
+	int i, rc = 0;
+
+	for (i = 0 ; i < mm_array_size ; i++) {
+		rc = hl_unsecure_register_range(hdev, mm_reg_range_array[i],
+			offset, pb_blocks, sgs_array, blocks_array_size);
+
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
+
+/**
+ * hl_ack_pb_security_violations - Ack security violation
+ *
+ * @hdev: pointer to hl_device structure
+ * @pb_blocks: blocks array
+ * @block_offset: additional offset to the block
+ * @array_size: blocks array size
+ *
+ */
+static void hl_ack_pb_security_violations(struct hl_device *hdev,
+		const u32 pb_blocks[], u32 block_offset, int array_size)
+{
+	int i;
+	u32 cause, addr, block_base;
+
+	for (i = 0 ; i < array_size ; i++) {
+		block_base = pb_blocks[i] + block_offset;
+		cause = RREG32(block_base + HL_BLOCK_GLBL_ERR_CAUSE);
+		if (cause) {
+			addr = RREG32(block_base + HL_BLOCK_GLBL_ERR_ADDR);
+			hdev->asic_funcs->pb_print_security_errors(hdev,
+					block_base, cause, addr);
+			WREG32(block_base + HL_BLOCK_GLBL_ERR_CAUSE, cause);
+		}
+	}
+}
+
+/**
+ * hl_config_glbl_sec - set pb in HW according to given pb array
+ *
+ * @hdev: pointer to hl_device structure
+ * @pb_blocks: blocks array
+ * @sgs_array: pb array
+ * @block_offset: additional offset to the block
+ * @array_size: blocks array size
+ *
+ */
+void hl_config_glbl_sec(struct hl_device *hdev, const u32 pb_blocks[],
+		struct hl_block_glbl_sec sgs_array[], u32 block_offset,
+		int array_size)
+{
+	int i, j;
+	u32 sgs_base;
+
+	if (hdev->pldm)
+		usleep_range(100, 1000);
+
+	for (i = 0 ; i < array_size ; i++) {
+		sgs_base = block_offset + pb_blocks[i] +
+				HL_BLOCK_GLBL_SEC_OFFS;
+
+		for (j = 0 ; j < HL_BLOCK_GLBL_SEC_LEN ; j++)
+			WREG32(sgs_base + j * sizeof(u32),
+				sgs_array[i].sec_array[j]);
+	}
+}
+
+/**
+ * hl_secure_block - locally memsets a block to 0
+ *
+ * @hdev: pointer to hl_device structure
+ * @sgs_array: pb array to clear
+ * @array_size: blocks array size
+ *
+ */
+void hl_secure_block(struct hl_device *hdev,
+		struct hl_block_glbl_sec sgs_array[], int array_size)
+{
+	int i;
+
+	for (i = 0 ; i < array_size ; i++)
+		memset((char *)(sgs_array[i].sec_array), 0,
+			HL_BLOCK_GLBL_SEC_SIZE);
+}
+
+/**
+ * hl_init_pb_with_mask - set selected pb instances with mask in HW according
+ *                        to given configuration
+ *
+ * @hdev: pointer to hl_device structure
+ * @num_dcores: number of decores to apply configuration to
+ *              set to HL_PB_SHARED if need to apply only once
+ * @dcore_offset: offset between dcores
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @regs_array: register array
+ * @regs_array_size: register array size
+ * @mask: enabled instances mask: 1- enabled, 0- disabled
+ */
+int hl_init_pb_with_mask(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const u32 *regs_array, u32 regs_array_size, u64 mask)
+{
+	int i, j;
+	struct hl_block_glbl_sec *glbl_sec;
+
+	glbl_sec = kcalloc(blocks_array_size,
+			sizeof(struct hl_block_glbl_sec),
+			GFP_KERNEL);
+	if (!glbl_sec)
+		return -ENOMEM;
+
+	hl_secure_block(hdev, glbl_sec, blocks_array_size);
+	hl_unsecure_registers(hdev, regs_array, regs_array_size, 0, pb_blocks,
+			glbl_sec, blocks_array_size);
+
+	/* Fill all blocks with the same configuration */
+	for (i = 0 ; i < num_dcores ; i++) {
+		for (j = 0 ; j < num_instances ; j++) {
+			int seq = i * num_instances + j;
+
+			if (!(mask & BIT_ULL(seq)))
+				continue;
+
+			hl_config_glbl_sec(hdev, pb_blocks, glbl_sec,
+					i * dcore_offset + j * instance_offset,
+					blocks_array_size);
+		}
+	}
+
+	kfree(glbl_sec);
+
+	return 0;
+}
+
+/**
+ * hl_init_pb - set pb in HW according to given configuration
+ *
+ * @hdev: pointer to hl_device structure
+ * @num_dcores: number of decores to apply configuration to
+ *              set to HL_PB_SHARED if need to apply only once
+ * @dcore_offset: offset between dcores
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @regs_array: register array
+ * @regs_array_size: register array size
+ *
+ */
+int hl_init_pb(struct hl_device *hdev, u32 num_dcores, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const u32 *regs_array, u32 regs_array_size)
+{
+	return hl_init_pb_with_mask(hdev, num_dcores, dcore_offset,
+			num_instances, instance_offset, pb_blocks,
+			blocks_array_size, regs_array, regs_array_size,
+			ULLONG_MAX);
+}
+
+/**
+ * hl_init_pb_ranges_with_mask - set pb instances using mask in HW according to
+ *                               given configuration unsecurring registers
+ *                               ranges instead of specific registers
+ *
+ * @hdev: pointer to hl_device structure
+ * @num_dcores: number of decores to apply configuration to
+ *              set to HL_PB_SHARED if need to apply only once
+ * @dcore_offset: offset between dcores
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @regs_range_array: register range array
+ * @regs_range_array_size: register range array size
+ * @mask: enabled instances mask: 1- enabled, 0- disabled
+ */
+int hl_init_pb_ranges_with_mask(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const struct range *regs_range_array, u32 regs_range_array_size,
+		u64 mask)
+{
+	int i, j, rc = 0;
+	struct hl_block_glbl_sec *glbl_sec;
+
+	glbl_sec = kcalloc(blocks_array_size,
+			sizeof(struct hl_block_glbl_sec),
+			GFP_KERNEL);
+	if (!glbl_sec)
+		return -ENOMEM;
+
+	hl_secure_block(hdev, glbl_sec, blocks_array_size);
+	rc = hl_unsecure_registers_range(hdev, regs_range_array,
+			regs_range_array_size, 0, pb_blocks, glbl_sec,
+			blocks_array_size);
+	if (rc)
+		goto free_glbl_sec;
+
+	/* Fill all blocks with the same configuration */
+	for (i = 0 ; i < num_dcores ; i++) {
+		for (j = 0 ; j < num_instances ; j++) {
+			int seq = i * num_instances + j;
+
+			if (!(mask & BIT_ULL(seq)))
+				continue;
+
+			hl_config_glbl_sec(hdev, pb_blocks, glbl_sec,
+					i * dcore_offset + j * instance_offset,
+					blocks_array_size);
+		}
+	}
+
+free_glbl_sec:
+	kfree(glbl_sec);
+
+	return rc;
+}
+
+/**
+ * hl_init_pb_ranges - set pb in HW according to given configuration unsecurring
+ *                     registers ranges instead of specific registers
+ *
+ * @hdev: pointer to hl_device structure
+ * @num_dcores: number of decores to apply configuration to
+ *              set to HL_PB_SHARED if need to apply only once
+ * @dcore_offset: offset between dcores
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @regs_range_array: register range array
+ * @regs_range_array_size: register range array size
+ *
+ */
+int hl_init_pb_ranges(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const struct range *regs_range_array, u32 regs_range_array_size)
+{
+	return hl_init_pb_ranges_with_mask(hdev, num_dcores, dcore_offset,
+			num_instances, instance_offset, pb_blocks,
+			blocks_array_size, regs_range_array,
+			regs_range_array_size, ULLONG_MAX);
+}
+
+/**
+ * hl_init_pb_single_dcore - set pb for a single docre in HW
+ * according to given configuration
+ *
+ * @hdev: pointer to hl_device structure
+ * @dcore_offset: offset from the dcore0
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @regs_array: register array
+ * @regs_array_size: register array size
+ *
+ */
+int hl_init_pb_single_dcore(struct hl_device *hdev, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const u32 *regs_array, u32 regs_array_size)
+{
+	int i, rc = 0;
+	struct hl_block_glbl_sec *glbl_sec;
+
+	glbl_sec = kcalloc(blocks_array_size,
+			sizeof(struct hl_block_glbl_sec),
+			GFP_KERNEL);
+	if (!glbl_sec)
+		return -ENOMEM;
+
+	hl_secure_block(hdev, glbl_sec, blocks_array_size);
+	rc = hl_unsecure_registers(hdev, regs_array, regs_array_size, 0,
+			pb_blocks, glbl_sec, blocks_array_size);
+	if (rc)
+		goto free_glbl_sec;
+
+	/* Fill all blocks with the same configuration */
+	for (i = 0 ; i < num_instances ; i++)
+		hl_config_glbl_sec(hdev, pb_blocks, glbl_sec,
+				dcore_offset + i * instance_offset,
+				blocks_array_size);
+
+free_glbl_sec:
+	kfree(glbl_sec);
+
+	return rc;
+}
+
+/**
+ * hl_init_pb_ranges_single_dcore - set pb for a single docre in HW according
+ *                                  to given configuration unsecurring
+ *                                  registers ranges instead of specific
+ *                                  registers
+ *
+ * @hdev: pointer to hl_device structure
+ * @dcore_offset: offset from the dcore0
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @regs_range_array: register range array
+ * @regs_range_array_size: register range array size
+ *
+ */
+int hl_init_pb_ranges_single_dcore(struct hl_device *hdev, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size,
+		const struct range *regs_range_array, u32 regs_range_array_size)
+{
+	int i;
+	struct hl_block_glbl_sec *glbl_sec;
+
+	glbl_sec = kcalloc(blocks_array_size,
+			sizeof(struct hl_block_glbl_sec),
+			GFP_KERNEL);
+	if (!glbl_sec)
+		return -ENOMEM;
+
+	hl_secure_block(hdev, glbl_sec, blocks_array_size);
+	hl_unsecure_registers_range(hdev, regs_range_array,
+			regs_range_array_size, 0, pb_blocks, glbl_sec,
+			blocks_array_size);
+
+	/* Fill all blocks with the same configuration */
+	for (i = 0 ; i < num_instances ; i++)
+		hl_config_glbl_sec(hdev, pb_blocks, glbl_sec,
+				dcore_offset + i * instance_offset,
+				blocks_array_size);
+
+	kfree(glbl_sec);
+
+	return 0;
+}
+
+/**
+ * hl_ack_pb_with_mask - ack pb with mask in HW according to given configuration
+ *
+ * @hdev: pointer to hl_device structure
+ * @num_dcores: number of decores to apply configuration to
+ *              set to HL_PB_SHARED if need to apply only once
+ * @dcore_offset: offset between dcores
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ * @mask: enabled instances mask: 1- enabled, 0- disabled
+ *
+ */
+void hl_ack_pb_with_mask(struct hl_device *hdev, u32 num_dcores,
+		u32 dcore_offset, u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size, u64 mask)
+{
+	int i, j;
+
+	/* ack all blocks */
+	for (i = 0 ; i < num_dcores ; i++) {
+		for (j = 0 ; j < num_instances ; j++) {
+			int seq = i * num_instances + j;
+
+			if (!(mask & BIT_ULL(seq)))
+				continue;
+
+			hl_ack_pb_security_violations(hdev, pb_blocks,
+					i * dcore_offset + j * instance_offset,
+					blocks_array_size);
+		}
+	}
+}
+
+/**
+ * hl_ack_pb - ack pb in HW according to given configuration
+ *
+ * @hdev: pointer to hl_device structure
+ * @num_dcores: number of decores to apply configuration to
+ *              set to HL_PB_SHARED if need to apply only once
+ * @dcore_offset: offset between dcores
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ *
+ */
+void hl_ack_pb(struct hl_device *hdev, u32 num_dcores, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size)
+{
+	hl_ack_pb_with_mask(hdev, num_dcores, dcore_offset, num_instances,
+			instance_offset, pb_blocks, blocks_array_size,
+			ULLONG_MAX);
+}
+
+/**
+ * hl_ack_pb_single_dcore - ack pb for single docre in HW
+ * according to given configuration
+ *
+ * @hdev: pointer to hl_device structure
+ * @dcore_offset: offset from dcore0
+ * @num_instances: number of instances to apply configuration to
+ * @instance_offset: offset between instances
+ * @pb_blocks: blocks array
+ * @blocks_array_size: blocks array size
+ *
+ */
+void hl_ack_pb_single_dcore(struct hl_device *hdev, u32 dcore_offset,
+		u32 num_instances, u32 instance_offset,
+		const u32 pb_blocks[], u32 blocks_array_size)
+{
+	int i;
+
+	/* ack all blocks */
+	for (i = 0 ; i < num_instances ; i++)
+		hl_ack_pb_security_violations(hdev, pb_blocks,
+				dcore_offset + i * instance_offset,
+				blocks_array_size);
+
+}
-- 
2.25.1


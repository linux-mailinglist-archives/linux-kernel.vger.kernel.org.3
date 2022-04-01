Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5124EED04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbiDAMWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbiDAMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DEF27796E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD483B824BA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BABC2BBE4;
        Fri,  1 Apr 2022 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815622;
        bh=apif+R7Wwawm9VzQ7p6xY5S1wSTwdKfHPmreo78OKP0=;
        h=From:To:Cc:Subject:Date:From;
        b=fdlszdfUyvh17kE7W9GhUAic1AnEgU9vKRKZN7m41mMIf7verePvFjg3Up+zlirCK
         rLBuNIUPVNUCPVi/Fz+o7cymkSvW6roBqseiQSS3/PZsYAHn3EEdm6MziyxhDFLCMq
         x1ZQTm5M24vzgiMEOZBPj9xwcZIs1Z3FsRRjIETpptd40qtnlo7JtK0Kl00D2xWlaq
         V3M+UUINuvQeuwqxy3PaoLr5/XDU1XO24mmuJRq3y3V9xJLECiszZTsPwmT9sg+ZLr
         /3oWkvXD4lEHu/EXeeowUOA+1Rrfb7dnf8jNKs7aVNjV2THYjd8enly/t+iEw2625i
         uD1YUPMyjphJg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 1/7] habanalabs: add callback and field to be used for debugfs refactor
Date:   Fri,  1 Apr 2022 15:20:11 +0300
Message-Id: <20220401122017.116205-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

This is a preparation for unifying the code of accessing device memory
through debugfs. Add struct fields and callbacks that will later
be used in debugfs code and will reduce code duplication
among the different read{32,64}/write{32,64} callbacks of
every asic.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 127 ++++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h |  25 +++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   4 +
 drivers/misc/habanalabs/goya/goya.c         |   4 +
 4 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ef42646a9a3f..bd76a68d44be 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -15,6 +15,133 @@
 
 #define HL_RESET_DELAY_USEC		10000	/* 10ms */
 
+/*
+ * hl_set_dram_bar- sets the bar to allow later access to address
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @addr: the address the caller wants to access.
+ *
+ * @return: the old BAR base address on success, U64_MAX for failure.
+ *	    The caller should set it back to the old address after use.
+ *
+ * In case the bar space does not cover the whole address space,
+ * the bar base address should be set to allow access to a given address.
+ * This function can be called also if the bar doesn't need to be set,
+ * in that case it just won't change the base.
+ */
+static uint64_t hl_set_dram_bar(struct hl_device *hdev, u64 addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 bar_base_addr;
+
+	bar_base_addr = addr & ~(prop->dram_pci_bar_size - 0x1ull);
+
+	return hdev->asic_funcs->set_dram_bar_base(hdev, bar_base_addr);
+}
+
+
+static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val,
+	enum debugfs_access_type acc_type, enum pci_region region_type)
+{
+	struct pci_mem_region *region = &hdev->pci_mem_region[region_type];
+	u64 old_base, rc;
+
+	if (region_type == PCI_REGION_DRAM) {
+		old_base = hl_set_dram_bar(hdev, addr);
+		if (old_base == U64_MAX)
+			return -EIO;
+	}
+
+	switch (acc_type) {
+	case DEBUGFS_READ32:
+		*val = readl(hdev->pcie_bar[region->bar_id] +
+			addr - region->region_base + region->offset_in_bar);
+		break;
+	case DEBUGFS_WRITE32:
+		writel(*val, hdev->pcie_bar[region->bar_id] +
+			addr - region->region_base + region->offset_in_bar);
+		break;
+	case DEBUGFS_READ64:
+		*val = readq(hdev->pcie_bar[region->bar_id] +
+			addr - region->region_base + region->offset_in_bar);
+		break;
+	case DEBUGFS_WRITE64:
+		writeq(*val, hdev->pcie_bar[region->bar_id] +
+			addr - region->region_base + region->offset_in_bar);
+		break;
+	}
+
+	if (region_type == PCI_REGION_DRAM) {
+		rc = hl_set_dram_bar(hdev, old_base);
+		if (rc == U64_MAX)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * hl_access_cfg_region - access the config region
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @addr: the address to access
+ * @val: the value to write from or read to
+ * @acc_type: the type of access (read/write 64/32)
+ */
+int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
+	enum debugfs_access_type acc_type)
+{
+	struct pci_mem_region *cfg_region = &hdev->pci_mem_region[PCI_REGION_CFG];
+	u32 val_h, val_l;
+
+	switch (acc_type) {
+	case DEBUGFS_READ32:
+		*val = RREG32(addr - cfg_region->region_base);
+		break;
+	case DEBUGFS_WRITE32:
+		WREG32(addr - cfg_region->region_base, *val);
+		break;
+	case DEBUGFS_READ64:
+		val_l = RREG32(addr - cfg_region->region_base);
+		val_h = RREG32(addr + sizeof(u32) - cfg_region->region_base);
+
+		*val = (((u64) val_h) << 32) | val_l;
+		break;
+	case DEBUGFS_WRITE64:
+		WREG32(addr - cfg_region->region_base, lower_32_bits(*val));
+		WREG32(addr + sizeof(u32) - cfg_region->region_base, upper_32_bits(*val));
+		break;
+	}
+	return 0;
+}
+
+/*
+ * hl_access_dev_mem - access device memory
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @region: the memory region the address belongs to
+ * @region_type: the type of the region the address belongs to
+ * @addr: the address to access
+ * @val: the value to write from or read to
+ * @acc_type: the type of access (r/w, 32/64)
+ */
+int hl_access_dev_mem(struct hl_device *hdev, struct pci_mem_region *region,
+		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type)
+{
+	switch (region_type) {
+	case PCI_REGION_CFG:
+		return hl_access_cfg_region(hdev, addr, val, acc_type);
+	case PCI_REGION_SRAM:
+	case PCI_REGION_DRAM:
+		return hl_access_sram_dram_region(hdev, addr, val, acc_type,
+			region_type);
+	default:
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ece83b264b97..680e33694ca4 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -467,8 +467,10 @@ struct hl_hints_range {
  *                  the device's MMU.
  * @dram_hints_align_mask: dram va hint addresses alignment mask which is used
  *                  for hints validity check.
- * device_dma_offset_for_host_access: the offset to add to host DMA addresses
- *                                    to enable the device to access them.
+ * @device_dma_offset_for_host_access: the offset to add to host DMA addresses
+ *                                     to enable the device to access them.
+ * @host_base_address: host physical start address for host DMA from device
+ * @host_end_address: host physical end address for host DMA from device
  * @max_freq_value: current max clk frequency.
  * @clk_pll_index: clock PLL index that specify which PLL determines the clock
  *                 we display to the user
@@ -585,6 +587,8 @@ struct asic_fixed_properties {
 	u64				cb_va_end_addr;
 	u64				dram_hints_align_mask;
 	u64				device_dma_offset_for_host_access;
+	u64				host_base_address;
+	u64				host_end_address;
 	u64				max_freq_value;
 	u32				clk_pll_index;
 	u32				mmu_pgt_size;
@@ -1095,6 +1099,13 @@ enum div_select_defs {
 	DIV_SEL_DIVIDED_PLL = 3,
 };
 
+enum debugfs_access_type {
+	DEBUGFS_READ32,
+	DEBUGFS_WRITE32,
+	DEBUGFS_READ64,
+	DEBUGFS_WRITE64,
+};
+
 enum pci_region {
 	PCI_REGION_CFG,
 	PCI_REGION_SRAM,
@@ -1346,6 +1357,8 @@ struct fw_load_mgr {
  * @is_valid_dram_page_size: return true if page size is supported in device
  *                           memory allocation, otherwise false.
  * @get_valid_dram_page_orders: get valid device memory allocation page orders
+ * @access_dev_mem: access device memory
+ * @set_dram_bar_base: set the base of the DRAM BAR
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1476,6 +1489,9 @@ struct hl_asic_funcs {
 	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
 					u32 page_size, u32 *real_page_size, bool is_dram_addr);
 	void (*get_valid_dram_page_orders)(struct hl_info_dev_memalloc_page_sizes *info);
+	int (*access_dev_mem)(struct hl_device *hdev, struct pci_mem_region *region,
+		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type);
+	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 };
 
 
@@ -3006,6 +3022,11 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 	return ((address <= range_end_address) && (range_start_address <= end_address));
 }
 
+uint64_t hl_set_dram_bar_default(struct hl_device *hdev, u64 addr);
+int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
+	enum debugfs_access_type acc_type);
+int hl_access_dev_mem(struct hl_device *hdev, struct pci_mem_region *region,
+		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type);
 int hl_device_open(struct inode *inode, struct file *filp);
 int hl_device_open_ctrl(struct inode *inode, struct file *filp);
 bool hl_device_operational(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index fdcdf47087c8..7ceec28bdeef 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -557,6 +557,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	}
 
 	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE;
+	prop->host_base_address = HOST_PHYS_BASE;
+	prop->host_end_address = prop->host_base_address + HOST_PHYS_SIZE;
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 	prop->collective_first_sob = 0;
 	prop->collective_first_mon = 0;
@@ -9506,6 +9508,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.is_valid_dram_page_size = NULL,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.get_valid_dram_page_orders = gaudi_get_valid_dram_page_orders,
+	.access_dev_mem = hl_access_dev_mem,
+	.set_dram_bar_base = gaudi_set_hbm_bar_base,
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 36b3cf57aaae..a5cca984b357 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -390,6 +390,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	}
 
 	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE;
+	prop->host_base_address = HOST_PHYS_BASE;
+	prop->host_end_address = prop->host_base_address + HOST_PHYS_SIZE;
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 
 	prop->dram_base_address = DRAM_PHYS_BASE;
@@ -5781,6 +5783,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.is_valid_dram_page_size = NULL,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.get_valid_dram_page_orders = goya_get_valid_dram_page_orders,
+	.access_dev_mem = hl_access_dev_mem,
+	.set_dram_bar_base = goya_set_ddr_bar_base,
 };
 
 /*
-- 
2.25.1


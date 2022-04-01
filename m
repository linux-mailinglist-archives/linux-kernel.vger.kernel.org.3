Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7D4EED06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbiDAMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345824AbiDAMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DCC277950
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4471FB824BD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4CAC340EC;
        Fri,  1 Apr 2022 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815626;
        bh=5oUF+BRGPamy2QIOClqclRp6rk8FFYmOBLr3vd5rGD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lj6DC/BzN9+fJ0/c3Ir2W3HLAEEEoenUWeSHkSlt/5M/LKrmbyF/koiUZGRTC6Y+u
         4YVPj1o3L0161/4s8h0ikd/YxIFfIGmFMBm2NykVXUTqNrapaFd8XoezvsT1q0w6jq
         NCyVOuHhfw05FDqtQ4nqxskLGxfVscyMRhq7V8E7hPpMi84fNHsb5X/Fb7ihYMnc8F
         j7hPSeT1lcKSNYAD2czhZZQ50aDg4Mpjt05w5zMcD9ewIXDkMKWrdsmmhyAZPaqK/+
         C1/DXx3V7gqnTa02xrlBEEqzhuiDXqtSYQ9IbU8rNkUJLshBbzdeb3HvqpKNxuVB8/
         fPmO6Bam7nb1w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 4/7] habanalabs: remove debugfs read/write callbacks
Date:   Fri,  1 Apr 2022 15:20:14 +0300
Message-Id: <20220401122017.116205-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401122017.116205-1-ogabbay@kernel.org>
References: <20220401122017.116205-1-ogabbay@kernel.org>
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

The debugfs memory access now uses the callback 'access_dev_mem'
so there is no use of the callbacks
'debugfs_{read32,read64,write32,write6}'. Remove them.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  12 --
 drivers/misc/habanalabs/gaudi/gaudi.c       | 182 ----------------
 drivers/misc/habanalabs/goya/goya.c         | 222 +-------------------
 3 files changed, 1 insertion(+), 415 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 680e33694ca4..e9a64309e99f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1282,10 +1282,6 @@ struct fw_load_mgr {
  * @update_eq_ci: update event queue CI.
  * @context_switch: called upon ASID context switch.
  * @restore_phase_topology: clear all SOBs amd MONs.
- * @debugfs_read32: debug interface for reading u32 from DRAM/SRAM/Host memory.
- * @debugfs_write32: debug interface for writing u32 to DRAM/SRAM/Host memory.
- * @debugfs_read64: debug interface for reading u64 from DRAM/SRAM/Host memory.
- * @debugfs_write64: debug interface for writing u64 to DRAM/SRAM/Host memory.
  * @debugfs_read_dma: debug interface for reading up to 2MB from the device's
  *                    internal memory via DMA engine.
  * @add_device_attr: add ASIC specific device attributes.
@@ -1409,14 +1405,6 @@ struct hl_asic_funcs {
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
 	int (*context_switch)(struct hl_device *hdev, u32 asid);
 	void (*restore_phase_topology)(struct hl_device *hdev);
-	int (*debugfs_read32)(struct hl_device *hdev, u64 addr,
-				bool user_address, u32 *val);
-	int (*debugfs_write32)(struct hl_device *hdev, u64 addr,
-				bool user_address, u32 val);
-	int (*debugfs_read64)(struct hl_device *hdev, u64 addr,
-				bool user_address, u64 *val);
-	int (*debugfs_write64)(struct hl_device *hdev, u64 addr,
-				bool user_address, u64 val);
 	int (*debugfs_read_dma)(struct hl_device *hdev, u64 addr, u32 size,
 				void *blob_addr);
 	void (*add_device_attr)(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7ceec28bdeef..bacb2f1df81e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6104,184 +6104,6 @@ static void gaudi_restore_phase_topology(struct hl_device *hdev)
 
 }
 
-static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
-			bool user_address, u32 *val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 hbm_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
-
-		*val = RREG32(addr - CFG_BASE);
-
-	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
-
-		*val = readl(hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
-
-	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-
-		if (hbm_bar_addr != U64_MAX) {
-			*val = readl(hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
-		}
-
-		if (hbm_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-
-		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
-			bool user_address, u32 val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 hbm_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
-
-		WREG32(addr - CFG_BASE, val);
-
-	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
-
-		writel(val, hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
-
-	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-
-		if (hbm_bar_addr != U64_MAX) {
-			writel(val, hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
-		}
-
-		if (hbm_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-
-		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
-				bool user_address, u64 *val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 hbm_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
-
-		u32 val_l = RREG32(addr - CFG_BASE);
-		u32 val_h = RREG32(addr + sizeof(u32) - CFG_BASE);
-
-		*val = (((u64) val_h) << 32) | val_l;
-
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
-
-		*val = readq(hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
-
-	} else if (addr <= DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-
-		if (hbm_bar_addr != U64_MAX) {
-			*val = readq(hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
-		}
-
-		if (hbm_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-
-		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
-				bool user_address, u64 val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 hbm_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
-
-		WREG32(addr - CFG_BASE, lower_32_bits(val));
-		WREG32(addr + sizeof(u32) - CFG_BASE, upper_32_bits(val));
-
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
-
-		writeq(val, hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
-
-	} else if (addr <= DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-
-		if (hbm_bar_addr != U64_MAX) {
-			writeq(val, hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
-		}
-
-		if (hbm_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-
-		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
 static int gaudi_dma_core_transfer(struct hl_device *hdev, int dma_id, u64 addr,
 					u32 size_to_dma, dma_addr_t dma_addr)
 {
@@ -9450,10 +9272,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.update_eq_ci = gaudi_update_eq_ci,
 	.context_switch = gaudi_context_switch,
 	.restore_phase_topology = gaudi_restore_phase_topology,
-	.debugfs_read32 = gaudi_debugfs_read32,
-	.debugfs_write32 = gaudi_debugfs_write32,
-	.debugfs_read64 = gaudi_debugfs_read64,
-	.debugfs_write64 = gaudi_debugfs_write64,
 	.debugfs_read_dma = gaudi_debugfs_read_dma,
 	.add_device_attr = gaudi_add_device_attr,
 	.handle_eqe = gaudi_handle_eqe,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a5cca984b357..d75a180cf5bb 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4262,223 +4262,7 @@ static void goya_clear_sm_regs(struct hl_device *hdev)
 	i = RREG32(mmSYNC_MNGR_SOB_OBJ_0);
 }
 
-/*
- * goya_debugfs_read32 - read a 32bit value from a given device or a host mapped
- *                       address.
- *
- * @hdev:	pointer to hl_device structure
- * @addr:	device or host mapped address
- * @val:	returned value
- *
- * In case of DDR address that is not mapped into the default aperture that
- * the DDR bar exposes, the function will configure the iATU so that the DDR
- * bar will be positioned at a base address that allows reading from the
- * required address. Configuring the iATU during normal operation can
- * lead to undefined behavior and therefore, should be done with extreme care
- *
- */
-static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
-			bool user_address, u32 *val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
-		*val = RREG32(addr - CFG_BASE);
-
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
-
-		*val = readl(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
-				(addr - SRAM_BASE_ADDR));
-
-	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
-		if (ddr_bar_addr != U64_MAX) {
-			*val = readl(hdev->pcie_bar[DDR_BAR_ID] +
-						(addr - bar_base_addr));
-
-			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
-							ddr_bar_addr);
-		}
-		if (ddr_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-/*
- * goya_debugfs_write32 - write a 32bit value to a given device or a host mapped
- *                        address.
- *
- * @hdev:	pointer to hl_device structure
- * @addr:	device or host mapped address
- * @val:	returned value
- *
- * In case of DDR address that is not mapped into the default aperture that
- * the DDR bar exposes, the function will configure the iATU so that the DDR
- * bar will be positioned at a base address that allows writing to the
- * required address. Configuring the iATU during normal operation can
- * lead to undefined behavior and therefore, should be done with extreme care
- *
- */
-static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
-			bool user_address, u32 val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
-		WREG32(addr - CFG_BASE, val);
-
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
-
-		writel(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
-					(addr - SRAM_BASE_ADDR));
-
-	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
-		if (ddr_bar_addr != U64_MAX) {
-			writel(val, hdev->pcie_bar[DDR_BAR_ID] +
-						(addr - bar_base_addr));
-
-			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
-							ddr_bar_addr);
-		}
-		if (ddr_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
-			bool user_address, u64 *val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
-		u32 val_l = RREG32(addr - CFG_BASE);
-		u32 val_h = RREG32(addr + sizeof(u32) - CFG_BASE);
-
-		*val = (((u64) val_h) << 32) | val_l;
-
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
-
-		*val = readq(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
-				(addr - SRAM_BASE_ADDR));
-
-	} else if (addr <=
-		   DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
-		if (ddr_bar_addr != U64_MAX) {
-			*val = readq(hdev->pcie_bar[DDR_BAR_ID] +
-						(addr - bar_base_addr));
-
-			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
-							ddr_bar_addr);
-		}
-		if (ddr_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
-				bool user_address, u64 val)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr, host_phys_end;
-	int rc = 0;
-
-	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
-
-	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
-		WREG32(addr - CFG_BASE, lower_32_bits(val));
-		WREG32(addr + sizeof(u32) - CFG_BASE, upper_32_bits(val));
-
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
-
-		writeq(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
-					(addr - SRAM_BASE_ADDR));
-
-	} else if (addr <=
-		   DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
-
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
-
-		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
-		if (ddr_bar_addr != U64_MAX) {
-			writeq(val, hdev->pcie_bar[DDR_BAR_ID] +
-						(addr - bar_base_addr));
-
-			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
-							ddr_bar_addr);
-		}
-		if (ddr_bar_addr == U64_MAX)
-			rc = -EIO;
-
-	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
-		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
-
-	} else {
-		rc = -EFAULT;
-	}
-
-	return rc;
-}
-
-static int goya_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
+int goya_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 				void *blob_addr)
 {
 	dev_err(hdev->dev, "Reading via DMA is unimplemented yet\n");
@@ -5725,10 +5509,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.update_eq_ci = goya_update_eq_ci,
 	.context_switch = goya_context_switch,
 	.restore_phase_topology = goya_restore_phase_topology,
-	.debugfs_read32 = goya_debugfs_read32,
-	.debugfs_write32 = goya_debugfs_write32,
-	.debugfs_read64 = goya_debugfs_read64,
-	.debugfs_write64 = goya_debugfs_write64,
 	.debugfs_read_dma = goya_debugfs_read_dma,
 	.add_device_attr = goya_add_device_attr,
 	.handle_eqe = goya_handle_eqe,
-- 
2.25.1


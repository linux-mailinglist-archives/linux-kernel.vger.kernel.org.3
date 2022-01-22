Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B78496DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiAVT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:32992 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiAVT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D8060EB7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59124C340E4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881461;
        bh=wXVX7+DBBiJrsim7eAC9PpuNlWvA6p/Sv9sw/XlRESc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GUz0gqM60RPjp/ReCRWSuSgKRvSFLyvnq7+hCyCCZ4tltbAoTbUWp/4hJdPZ533SU
         UwxFhLuAJAqtTOZSZTDZbA9eqrQ+oU/e7Kk9SXlvX5EgIed7lpxaR+M3AA50UYBA51
         /B7QDlMLrHC+NcbIOAiS093tM22oiWsP17CWitbif4qjmGrfdikN5a6Wg1acXwbSI2
         t+XkSpddI+TpOIzk/OwNwI9S/A+rq/6UzK5+zK83/+oYJTRONJOcoC+qZoZnpc7oev
         XXwCR7DIjNhw6W/lzrTqxaJu93xB19JWOjK9VZdyiTM+ZcHbyVm4BvkzZ7iG8pcRvT
         RtKbE0zeEddeA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] habanalabs/gaudi: disable CGM permanently
Date:   Sat, 22 Jan 2022 21:57:05 +0200
Message-Id: <20220122195731.934494-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the need of SynapseAI to configure all TPC engines from a single
QMAN, the driver must disable CGM and never allow the user to enable
it. Otherwise, the configuration of the TPC engines will fail.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  19 +-
 drivers/misc/habanalabs/common/debugfs.c      |  32 +--
 drivers/misc/habanalabs/common/habanalabs.h   |   4 -
 .../misc/habanalabs/common/habanalabs_drv.c   |   1 -
 drivers/misc/habanalabs/gaudi/gaudi.c         | 230 +++++-------------
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   1 -
 6 files changed, 66 insertions(+), 221 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 2667cbf940f3..783001a574b3 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -12,24 +12,7 @@ What:           /sys/kernel/debug/habanalabs/hl<n>/clk_gate
 Date:           May 2020
 KernelVersion:  5.8
 Contact:        ogabbay@kernel.org
-Description:    Allow the root user to disable/enable in runtime the clock
-                gating mechanism in Gaudi. Due to how Gaudi is built, the
-                clock gating needs to be disabled in order to access the
-                registers of the TPC and MME engines. This is sometimes needed
-                during debug by the user and hence the user needs this option.
-                The user can supply a bitmask value, each bit represents
-                a different engine to disable/enable its clock gating feature.
-                The bitmask is composed of 20 bits:
-
-                =======   ============
-                0  -  7   DMA channels
-                8  - 11   MME engines
-                12 - 19   TPC engines
-                =======   ============
-
-                The bit's location of a specific engine can be determined
-                using (1 << GAUDI_ENGINE_ID_*). GAUDI_ENGINE_ID_* values
-                are defined in uapi habanalabs.h file in enum gaudi_engine_id
+Description:    This setting is now deprecated as clock gating is handled solely by the f/w
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/command_buffers
 Date:           Jan 2019
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index fc084ee5106e..e3ee5f45d20c 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1054,42 +1054,12 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
 static ssize_t hl_clk_gate_read(struct file *f, char __user *buf,
 					size_t count, loff_t *ppos)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
-	struct hl_device *hdev = entry->hdev;
-	char tmp_buf[200];
-	ssize_t rc;
-
-	if (*ppos)
-		return 0;
-
-	sprintf(tmp_buf, "0x%llx\n", hdev->clock_gating_mask);
-	rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
-
-	return rc;
+	return 0;
 }
 
 static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
 				     size_t count, loff_t *ppos)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
-	struct hl_device *hdev = entry->hdev;
-	u64 value;
-	ssize_t rc;
-
-	if (hdev->reset_info.in_reset) {
-		dev_warn_ratelimited(hdev->dev,
-				"Can't change clock gating during reset\n");
-		return 0;
-	}
-
-	rc = kstrtoull_from_user(buf, count, 16, &value);
-	if (rc)
-		return rc;
-
-	hdev->clock_gating_mask = value;
-	hdev->asic_funcs->set_clock_gating(hdev);
-
 	return count;
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index cb710fd478b6..27b9f24c4f75 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2569,9 +2569,6 @@ struct hl_reset_info {
  * @max_power: the max power of the device, as configured by the sysadmin. This
  *             value is saved so in case of hard-reset, the driver will restore
  *             this value and update the F/W after the re-initialization
- * @clock_gating_mask: is clock gating enabled. bitmask that represents the
- *                     different engines. See debugfs-driver-habanalabs for
- *                     details.
  * @boot_error_status_mask: contains a mask of the device boot error status.
  *                          Each bit represents a different error, according to
  *                          the defines in hl_boot_if.h. If the bit is cleared,
@@ -2710,7 +2707,6 @@ struct hl_device {
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
-	u64				clock_gating_mask;
 	u64				boot_error_status_mask;
 	u64				dram_pci_bar_start;
 	u64				last_successful_open_jif;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 690b763c7a95..017bfc4551da 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -256,7 +256,6 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->cpu_queues_enable = 1;
 	hdev->heartbeat = 1;
 	hdev->mmu_enable = 1;
-	hdev->clock_gating_mask = ULONG_MAX;
 	hdev->sram_scrambler_enable = 1;
 	hdev->dram_scrambler_enable = 1;
 	hdev->bmc_enable = 1;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 013c6da2e3ca..c20b781d4ada 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3740,74 +3740,10 @@ static void gaudi_tpc_stall(struct hl_device *hdev)
 
 static void gaudi_set_clock_gating(struct hl_device *hdev)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 qman_offset;
-	bool enable;
-	int i;
-
-	/* In case we are during debug session, don't enable the clock gate
-	 * as it may interfere
-	 */
-	if (hdev->in_debug)
-		return;
-
-	if (hdev->asic_prop.fw_security_enabled)
-		return;
-
-	for (i = GAUDI_PCI_DMA_1, qman_offset = 0 ; i < GAUDI_HBM_DMA_1 ; i++) {
-		enable = !!(hdev->clock_gating_mask &
-				(BIT_ULL(gaudi_dma_assignment[i])));
-
-		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
-		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset,
-				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
-		WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
-				enable ? QMAN_UPPER_CP_CGM_PWR_GATE_EN : 0);
-	}
-
-	for (i = GAUDI_HBM_DMA_1 ; i < GAUDI_DMA_MAX ; i++) {
-		enable = !!(hdev->clock_gating_mask &
-				(BIT_ULL(gaudi_dma_assignment[i])));
-
-		/* GC sends work to DMA engine through Upper CP in DMA5 so
-		 * we need to not enable clock gating in that DMA
-		 */
-		if (i == GAUDI_HBM_DMA_4)
-			enable = 0;
-
-		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
-		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset,
-				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
-		WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
-				enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
-	}
-
-	enable = !!(hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_0)));
-	WREG32(mmMME0_QM_CGM_CFG1, enable ? QMAN_CGM1_PWR_GATE_EN : 0);
-	WREG32(mmMME0_QM_CGM_CFG, enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
-
-	enable = !!(hdev->clock_gating_mask & (BIT_ULL(GAUDI_ENGINE_ID_MME_2)));
-	WREG32(mmMME2_QM_CGM_CFG1, enable ? QMAN_CGM1_PWR_GATE_EN : 0);
-	WREG32(mmMME2_QM_CGM_CFG, enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
-
-	for (i = 0, qman_offset = 0 ; i < TPC_NUMBER_OF_ENGINES ; i++) {
-		enable = !!(hdev->clock_gating_mask &
-				(BIT_ULL(GAUDI_ENGINE_ID_TPC_0 + i)));
-
-		WREG32(mmTPC0_QM_CGM_CFG1 + qman_offset,
-				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
-		WREG32(mmTPC0_QM_CGM_CFG + qman_offset,
-				enable ? QMAN_COMMON_CP_CGM_PWR_GATE_EN : 0);
-
-		qman_offset += TPC_QMAN_OFFSET;
-	}
-
-	gaudi->hw_cap_initialized |= HW_CAP_CLK_GATE;
 }
 
 static void gaudi_disable_clock_gating(struct hl_device *hdev)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 qman_offset;
 	int i;
 
@@ -3832,8 +3768,6 @@ static void gaudi_disable_clock_gating(struct hl_device *hdev)
 
 		qman_offset += (mmTPC1_QM_CGM_CFG - mmTPC0_QM_CGM_CFG);
 	}
-
-	gaudi->hw_cap_initialized &= ~(HW_CAP_CLK_GATE);
 }
 
 static void gaudi_enable_timestamp(struct hl_device *hdev)
@@ -4400,14 +4334,11 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset
 			status);
 
 	if (gaudi) {
-		gaudi->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
-				HW_CAP_HBM | HW_CAP_PCI_DMA |
-				HW_CAP_MME | HW_CAP_TPC_MASK |
-				HW_CAP_HBM_DMA | HW_CAP_PLL |
-				HW_CAP_NIC_MASK | HW_CAP_MMU |
-				HW_CAP_SRAM_SCRAMBLER |
-				HW_CAP_HBM_SCRAMBLER |
-				HW_CAP_CLK_GATE);
+		gaudi->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q | HW_CAP_HBM |
+						HW_CAP_PCI_DMA | HW_CAP_MME | HW_CAP_TPC_MASK |
+						HW_CAP_HBM_DMA | HW_CAP_PLL | HW_CAP_NIC_MASK |
+						HW_CAP_MMU | HW_CAP_SRAM_SCRAMBLER |
+						HW_CAP_HBM_SCRAMBLER);
 
 		memset(gaudi->events_stat, 0, sizeof(gaudi->events_stat));
 
@@ -6188,7 +6119,6 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
 			bool user_address, u32 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
@@ -6196,38 +6126,31 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
 
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
 
-		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
-				(hdev->clock_gating_mask &
-						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
+		*val = RREG32(addr - CFG_BASE);
 
-			dev_err_ratelimited(hdev->dev,
-				"Can't read register - clock gating is enabled!\n");
-			rc = -EFAULT;
-		} else {
-			*val = RREG32(addr - CFG_BASE);
-		}
+	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
+
+		*val = readl(hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
 
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
-		*val = readl(hdev->pcie_bar[SRAM_BAR_ID] +
-				(addr - SRAM_BASE_ADDR));
 	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+
+		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
 
 		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-		if (hbm_bar_addr != U64_MAX) {
-			*val = readl(hdev->pcie_bar[HBM_BAR_ID] +
-						(addr - bar_base_addr));
 
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev,
-						hbm_bar_addr);
+		if (hbm_bar_addr != U64_MAX) {
+			*val = readl(hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
+			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
 		}
+
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
 			user_address && !iommu_present(&pci_bus_type)) {
+
 		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
+
 	} else {
 		rc = -EFAULT;
 	}
@@ -6239,7 +6162,6 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
 			bool user_address, u32 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
@@ -6247,38 +6169,31 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
 
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
 
-		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
-				(hdev->clock_gating_mask &
-						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
+		WREG32(addr - CFG_BASE, val);
 
-			dev_err_ratelimited(hdev->dev,
-				"Can't write register - clock gating is enabled!\n");
-			rc = -EFAULT;
-		} else {
-			WREG32(addr - CFG_BASE, val);
-		}
+	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
+
+		writel(val, hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
 
-	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
-		writel(val, hdev->pcie_bar[SRAM_BAR_ID] +
-					(addr - SRAM_BASE_ADDR));
 	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+
+		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
 
 		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-		if (hbm_bar_addr != U64_MAX) {
-			writel(val, hdev->pcie_bar[HBM_BAR_ID] +
-						(addr - bar_base_addr));
 
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev,
-						hbm_bar_addr);
+		if (hbm_bar_addr != U64_MAX) {
+			writel(val, hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
+			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
 		}
+
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
 			user_address && !iommu_present(&pci_bus_type)) {
+
 		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
+
 	} else {
 		rc = -EFAULT;
 	}
@@ -6290,7 +6205,6 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
 				bool user_address, u64 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
@@ -6298,42 +6212,35 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
 
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
 
-		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
-				(hdev->clock_gating_mask &
-						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
-
-			dev_err_ratelimited(hdev->dev,
-				"Can't read register - clock gating is enabled!\n");
-			rc = -EFAULT;
-		} else {
-			u32 val_l = RREG32(addr - CFG_BASE);
-			u32 val_h = RREG32(addr + sizeof(u32) - CFG_BASE);
+		u32 val_l = RREG32(addr - CFG_BASE);
+		u32 val_h = RREG32(addr + sizeof(u32) - CFG_BASE);
 
-			*val = (((u64) val_h) << 32) | val_l;
-		}
+		*val = (((u64) val_h) << 32) | val_l;
 
 	} else if ((addr >= SRAM_BASE_ADDR) &&
-		   (addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
-		*val = readq(hdev->pcie_bar[SRAM_BAR_ID] +
-				(addr - SRAM_BASE_ADDR));
-	} else if (addr <=
-		    DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+			(addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
+
+		*val = readq(hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
+
+	} else if (addr <= DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
+
+		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
 
 		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-		if (hbm_bar_addr != U64_MAX) {
-			*val = readq(hdev->pcie_bar[HBM_BAR_ID] +
-						(addr - bar_base_addr));
 
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev,
-						hbm_bar_addr);
+		if (hbm_bar_addr != U64_MAX) {
+			*val = readq(hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
+			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
 		}
+
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
 			user_address && !iommu_present(&pci_bus_type)) {
+
 		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
+
 	} else {
 		rc = -EFAULT;
 	}
@@ -6345,7 +6252,6 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
 				bool user_address, u64 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
@@ -6353,41 +6259,33 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
 
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
 
-		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
-				(hdev->clock_gating_mask &
-						GAUDI_CLK_GATE_DEBUGFS_MASK)) {
-
-			dev_err_ratelimited(hdev->dev,
-				"Can't write register - clock gating is enabled!\n");
-			rc = -EFAULT;
-		} else {
-			WREG32(addr - CFG_BASE, lower_32_bits(val));
-			WREG32(addr + sizeof(u32) - CFG_BASE,
-				upper_32_bits(val));
-		}
+		WREG32(addr - CFG_BASE, lower_32_bits(val));
+		WREG32(addr + sizeof(u32) - CFG_BASE, upper_32_bits(val));
 
 	} else if ((addr >= SRAM_BASE_ADDR) &&
-		   (addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
-		writeq(val, hdev->pcie_bar[SRAM_BAR_ID] +
-					(addr - SRAM_BASE_ADDR));
-	} else if (addr <=
-		    DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
-		u64 bar_base_addr = DRAM_PHYS_BASE +
-				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+			(addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
+
+		writeq(val, hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
+
+	} else if (addr <= DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
+
+		u64 bar_base_addr = DRAM_PHYS_BASE + (addr & ~(prop->dram_pci_bar_size - 0x1ull));
 
 		hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, bar_base_addr);
-		if (hbm_bar_addr != U64_MAX) {
-			writeq(val, hdev->pcie_bar[HBM_BAR_ID] +
-						(addr - bar_base_addr));
 
-			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev,
-						hbm_bar_addr);
+		if (hbm_bar_addr != U64_MAX) {
+			writeq(val, hdev->pcie_bar[HBM_BAR_ID] + (addr - bar_base_addr));
+			hbm_bar_addr = gaudi_set_hbm_bar_base(hdev, hbm_bar_addr);
 		}
+
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
 			user_address && !iommu_present(&pci_bus_type)) {
+
 		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
+
 	} else {
 		rc = -EFAULT;
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 8ac16a9b7d15..caa858bf6edc 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -177,7 +177,6 @@
 #define HW_CAP_MSI		BIT(6)
 #define HW_CAP_CPU_Q		BIT(7)
 #define HW_CAP_HBM_DMA		BIT(8)
-#define HW_CAP_CLK_GATE		BIT(9)
 #define HW_CAP_SRAM_SCRAMBLER	BIT(10)
 #define HW_CAP_HBM_SCRAMBLER	BIT(11)
 
-- 
2.25.1


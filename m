Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4B496DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiAVT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiAVT5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14198C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E2F60EBB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B19C340E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881463;
        bh=/P1nLspSx64VhaTRlPrOh++mDgim24zo/Pz2USBJZUg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qouwSUjq539AOfhnLiLqx6hcqMAJ58z6cOfNsouQlwE/KoP4Wf7R/umELpQ2+Joto
         FTawqM63ENrrMvZAerpSJN7rUo4Xg8vXLoSOHGnHrVquOwtd/m12zd8qaBrryQj6H9
         nDq6MNqydmcYfOE2g5ZQrj2sPMlJHOYnrW0syKXlfYFGjW3V4HokAyJd/SWAWBXo/V
         2sUVoteN/3+FuV7XZd+G/BrkeJ6g03B+dqmwmvaS8eKnzRwdVGtunATM0qkesJTuTS
         dQ+akzL0Q555PHav/GcbZEQgryFYbfDHqAcfnF/7mlTLqHZuew8oddQd2Nah2ynm8D
         Enr86o0a4yhlw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] habanalabs: remove ASIC functions of clock gating
Date:   Sat, 22 Jan 2022 21:57:06 +0200
Message-Id: <20220122195731.934494-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clock gating is permanently disabled in GAUDI, no need for
the ASIC functions of setting and disabling clock gating, as this
was a unique scenario in GAUDI.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     |   4 -
 drivers/misc/habanalabs/common/habanalabs.h |   5 -
 drivers/misc/habanalabs/gaudi/gaudi.c       | 123 +-------------------
 drivers/misc/habanalabs/gaudi/gaudiP.h      |   3 -
 drivers/misc/habanalabs/goya/goya.c         |  12 --
 5 files changed, 5 insertions(+), 142 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 733338ab6f1d..9955e0d3502b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -644,9 +644,6 @@ int hl_device_set_debug_mode(struct hl_device *hdev, struct hl_ctx *ctx, bool en
 
 		hdev->in_debug = 0;
 
-		if (!hdev->reset_info.hard_reset_pending)
-			hdev->asic_funcs->set_clock_gating(hdev);
-
 		goto out;
 	}
 
@@ -657,7 +654,6 @@ int hl_device_set_debug_mode(struct hl_device *hdev, struct hl_ctx *ctx, bool en
 		goto out;
 	}
 
-	hdev->asic_funcs->disable_clock_gating(hdev);
 	hdev->in_debug = 1;
 
 out:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 27b9f24c4f75..24962807e2cf 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1164,9 +1164,6 @@ struct fw_load_mgr {
  * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
  *                              ASID-VA-size mask.
  * @send_heartbeat: send is-alive packet to CPU-CP and verify response.
- * @set_clock_gating: enable/disable clock gating per engine according to
- *                    clock gating mask in hdev
- * @disable_clock_gating: disable clock gating completely
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
  * @non_hard_reset_late_init: perform certain actions needed after a reset which is not hard-reset
@@ -1300,8 +1297,6 @@ struct hl_asic_funcs {
 	int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 				u32 flags, u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
-	void (*set_clock_gating)(struct hl_device *hdev);
-	void (*disable_clock_gating)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
 					u8 mask_len, struct seq_file *s);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c20b781d4ada..16637d629e67 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -458,7 +458,6 @@ struct ecc_info_extract_params {
 	u64 block_address;
 	u32 num_memories;
 	bool derr;
-	bool disable_clock_gating;
 };
 
 static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
@@ -1896,7 +1895,6 @@ static int gaudi_sw_init(struct hl_device *hdev)
 		goto free_cpu_accessible_dma_pool;
 
 	spin_lock_init(&gaudi->hw_queues_lock);
-	mutex_init(&gaudi->clk_gate_mutex);
 
 	hdev->supports_sync_stream = true;
 	hdev->supports_coresight = true;
@@ -1946,8 +1944,6 @@ static int gaudi_sw_fini(struct hl_device *hdev)
 
 	dma_pool_destroy(hdev->dma_pool);
 
-	mutex_destroy(&gaudi->clk_gate_mutex);
-
 	kfree(gaudi);
 
 	return 0;
@@ -3738,10 +3734,6 @@ static void gaudi_tpc_stall(struct hl_device *hdev)
 	WREG32(mmTPC7_CFG_TPC_STALL, 1 << TPC0_CFG_TPC_STALL_V_SHIFT);
 }
 
-static void gaudi_set_clock_gating(struct hl_device *hdev)
-{
-}
-
 static void gaudi_disable_clock_gating(struct hl_device *hdev)
 {
 	u32 qman_offset;
@@ -3810,8 +3802,6 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_
 	gaudi_stop_hbm_dma_qmans(hdev);
 	gaudi_stop_pci_dma_qmans(hdev);
 
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	msleep(wait_timeout_ms);
 
 	gaudi_pci_dma_stall(hdev);
@@ -4137,10 +4127,8 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	/* In case the clock gating was enabled in preboot we need to disable
 	 * it here before touching the MME/TPC registers.
-	 * There is no need to take clk gating mutex because when this function
-	 * runs, no other relevant code can run
 	 */
-	hdev->asic_funcs->disable_clock_gating(hdev);
+	gaudi_disable_clock_gating(hdev);
 
 	/* SRAM scrambler must be initialized after CPU is running from HBM */
 	gaudi_init_scrambler_sram(hdev);
@@ -4166,8 +4154,6 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	gaudi_init_nic_qmans(hdev);
 
-	hdev->asic_funcs->set_clock_gating(hdev);
-
 	gaudi_enable_timestamp(hdev);
 
 	/* MSI must be enabled before CPU queues and NIC are initialized */
@@ -4815,7 +4801,6 @@ static int gaudi_hbm_scrubbing(struct hl_device *hdev)
 static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	int rc = 0;
 	u64 val = 0;
 
@@ -4850,17 +4835,11 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
 			return rc;
 		}
 
-		mutex_lock(&gaudi->clk_gate_mutex);
-		hdev->asic_funcs->disable_clock_gating(hdev);
-
 		/* Scrub HBM using all DMA channels in parallel */
 		rc = gaudi_hbm_scrubbing(hdev);
 		if (rc)
 			dev_err(hdev->dev,
 				"Failed to clear HBM in mem scrub all\n");
-
-		hdev->asic_funcs->set_clock_gating(hdev);
-		mutex_unlock(&gaudi->clk_gate_mutex);
 	}
 
 	return rc;
@@ -6344,7 +6323,6 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 				void *blob_addr)
 {
 	u32 dma_core_sts0, err_cause, cfg1, size_left, pos, size_to_dma;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 qm_glbl_sts0, qm_cgm_sts;
 	u64 dma_offset, qm_offset;
 	dma_addr_t dma_addr;
@@ -6360,10 +6338,6 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 	if (!kernel_addr)
 		return -ENOMEM;
 
-	mutex_lock(&gaudi->clk_gate_mutex);
-
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	dma_id = gaudi_dma_assignment[GAUDI_PCI_DMA_1];
@@ -6448,10 +6422,6 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 out:
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
-	hdev->asic_funcs->set_clock_gating(hdev);
-
-	mutex_unlock(&gaudi->clk_gate_mutex);
-
 	hdev->asic_funcs->asic_dma_free_coherent(hdev, SZ_2M, kernel_addr,
 						dma_addr);
 
@@ -6499,10 +6469,6 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 		return;
 	}
 
-	mutex_lock(&gaudi->clk_gate_mutex);
-
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	gaudi_mmu_prepare_reg(hdev, mmDMA0_QM_GLBL_NON_SECURE_PROPS_0, asid);
 	gaudi_mmu_prepare_reg(hdev, mmDMA0_QM_GLBL_NON_SECURE_PROPS_1, asid);
 	gaudi_mmu_prepare_reg(hdev, mmDMA0_QM_GLBL_NON_SECURE_PROPS_2, asid);
@@ -6780,10 +6746,6 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 
 	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER, asid);
 	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER, asid);
-
-	hdev->asic_funcs->set_clock_gating(hdev);
-
-	mutex_unlock(&gaudi->clk_gate_mutex);
 }
 
 static int gaudi_send_job_on_qman0(struct hl_device *hdev,
@@ -7164,10 +7126,8 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
 		struct ecc_info_extract_params *params, u64 *ecc_address,
 		u64 *ecc_syndrom, u8 *memory_wrapper_idx)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 i, num_mem_regs, reg, err_bit;
 	u64 err_addr, err_word = 0;
-	int rc = 0;
 
 	num_mem_regs = params->num_memories / 32 +
 			((params->num_memories % 32) ? 1 : 0);
@@ -7180,11 +7140,6 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
 	else
 		err_addr = params->block_address + GAUDI_ECC_SERR0_OFFSET;
 
-	if (params->disable_clock_gating) {
-		mutex_lock(&gaudi->clk_gate_mutex);
-		hdev->asic_funcs->disable_clock_gating(hdev);
-	}
-
 	/* Set invalid wrapper index */
 	*memory_wrapper_idx = 0xFF;
 
@@ -7201,8 +7156,7 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
 
 	if (*memory_wrapper_idx == 0xFF) {
 		dev_err(hdev->dev, "ECC error information cannot be found\n");
-		rc = -EINVAL;
-		goto enable_clk_gate;
+		return -EINVAL;
 	}
 
 	WREG32(params->block_address + GAUDI_ECC_MEM_SEL_OFFSET,
@@ -7222,14 +7176,7 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
 
 	WREG32(params->block_address + GAUDI_ECC_MEM_INFO_CLR_OFFSET, reg);
 
-enable_clk_gate:
-	if (params->disable_clock_gating) {
-		hdev->asic_funcs->set_clock_gating(hdev);
-
-		mutex_unlock(&gaudi->clk_gate_mutex);
-	}
-
-	return rc;
+	return 0;
 }
 
 /*
@@ -7487,7 +7434,6 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		params.block_address = mmTPC0_CFG_BASE + index * TPC_CFG_OFFSET;
 		params.num_memories = 90;
 		params.derr = false;
-		params.disable_clock_gating = true;
 		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_TPC0_DERR ... GAUDI_EVENT_TPC7_DERR:
@@ -7496,7 +7442,6 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 			mmTPC0_CFG_BASE + index * TPC_CFG_OFFSET;
 		params.num_memories = 90;
 		params.derr = true;
-		params.disable_clock_gating = true;
 		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_ACC_SERR:
@@ -7507,7 +7452,6 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		params.block_address = mmMME0_ACC_BASE + index * MME_ACC_OFFSET;
 		params.num_memories = 128;
 		params.derr = false;
-		params.disable_clock_gating = true;
 		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_ACC_DERR:
@@ -7518,7 +7462,6 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		params.block_address = mmMME0_ACC_BASE + index * MME_ACC_OFFSET;
 		params.num_memories = 128;
 		params.derr = true;
-		params.disable_clock_gating = true;
 		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_SBAB_SERR:
@@ -7530,7 +7473,6 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 			mmMME0_SBAB_BASE + index * MME_ACC_OFFSET;
 		params.num_memories = 33;
 		params.derr = false;
-		params.disable_clock_gating = true;
 		extract_info_from_fw = false;
 		break;
 	case GAUDI_EVENT_MME0_SBAB_DERR:
@@ -7542,7 +7484,6 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 			mmMME0_SBAB_BASE + index * MME_ACC_OFFSET;
 		params.num_memories = 33;
 		params.derr = true;
-		params.disable_clock_gating = true;
 		extract_info_from_fw = false;
 		break;
 	default:
@@ -7864,19 +7805,9 @@ static int gaudi_hbm_event_to_dev(u16 hbm_event_type)
 static bool gaudi_tpc_read_interrupts(struct hl_device *hdev, u8 tpc_id,
 					char *interrupt_name)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 tpc_offset = tpc_id * TPC_CFG_OFFSET, tpc_interrupts_cause, i;
 	bool soft_reset_required = false;
 
-	/* Accessing the TPC_INTR_CAUSE registers requires disabling the clock
-	 * gating, and thus cannot be done in CPU-CP and should be done instead
-	 * by the driver.
-	 */
-
-	mutex_lock(&gaudi->clk_gate_mutex);
-
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	tpc_interrupts_cause = RREG32(mmTPC0_CFG_TPC_INTR_CAUSE + tpc_offset) &
 				TPC0_CFG_TPC_INTR_CAUSE_CAUSE_MASK;
 
@@ -7894,10 +7825,6 @@ static bool gaudi_tpc_read_interrupts(struct hl_device *hdev, u8 tpc_id,
 	/* Clear interrupts */
 	WREG32(mmTPC0_CFG_TPC_INTR_CAUSE + tpc_offset, 0);
 
-	hdev->asic_funcs->set_clock_gating(hdev);
-
-	mutex_unlock(&gaudi->clk_gate_mutex);
-
 	return soft_reset_required;
 }
 
@@ -8359,10 +8286,6 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	u64 offset;
 	int i, dma_id, port;
 
-	mutex_lock(&gaudi->clk_gate_mutex);
-
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	if (s)
 		seq_puts(s,
 			"\nDMA  is_idle  QM_GLBL_STS0  QM_CGM_STS  DMA_CORE_STS0\n"
@@ -8483,10 +8406,6 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	if (s)
 		seq_puts(s, "\n");
 
-	hdev->asic_funcs->set_clock_gating(hdev);
-
-	mutex_unlock(&gaudi->clk_gate_mutex);
-
 	return is_idle;
 }
 
@@ -8526,10 +8445,8 @@ static int gaudi_get_eeprom_data(struct hl_device *hdev, void *data,
  * this function should be used only during initialization and/or after reset,
  * when there are no active users.
  */
-static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
-				u32 tpc_id)
+static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,	u32 tpc_id)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 kernel_timeout;
 	u32 status, offset;
 	int rc;
@@ -8541,10 +8458,6 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 	else
 		kernel_timeout = HL_DEVICE_TIMEOUT_USEC;
 
-	mutex_lock(&gaudi->clk_gate_mutex);
-
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	WREG32(mmTPC0_CFG_QM_KERNEL_BASE_ADDRESS_LOW + offset,
 			lower_32_bits(tpc_kernel));
 	WREG32(mmTPC0_CFG_QM_KERNEL_BASE_ADDRESS_HIGH + offset,
@@ -8584,8 +8497,6 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 		dev_err(hdev->dev,
 			"Timeout while waiting for TPC%d icache prefetch\n",
 			tpc_id);
-		hdev->asic_funcs->set_clock_gating(hdev);
-		mutex_unlock(&gaudi->clk_gate_mutex);
 		return -EIO;
 	}
 
@@ -8609,8 +8520,6 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 		dev_err(hdev->dev,
 			"Timeout while waiting for TPC%d vector pipe\n",
 			tpc_id);
-		hdev->asic_funcs->set_clock_gating(hdev);
-		mutex_unlock(&gaudi->clk_gate_mutex);
 		return -EIO;
 	}
 
@@ -8622,9 +8531,6 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 		1000,
 		kernel_timeout);
 
-	hdev->asic_funcs->set_clock_gating(hdev);
-	mutex_unlock(&gaudi->clk_gate_mutex);
-
 	if (rc) {
 		dev_err(hdev->dev,
 			"Timeout while waiting for TPC%d kernel to execute\n",
@@ -9191,23 +9097,15 @@ static int gaudi_gen_sync_to_engine_map(struct hl_device *hdev,
 				struct hl_sync_to_engine_map *map)
 {
 	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	int i, j, rc;
 	u32 reg_value;
 
 	/* Iterate over TPC engines */
 	for (i = 0; i < sds->props[SP_NUM_OF_TPC_ENGINES]; ++i) {
-		/* TPC registered must be accessed with clock gating disabled */
-		mutex_lock(&gaudi->clk_gate_mutex);
-		hdev->asic_funcs->disable_clock_gating(hdev);
 
 		reg_value = RREG32(sds->props[SP_TPC0_CFG_SO] +
 					sds->props[SP_NEXT_TPC] * i);
 
-		/* We can reenable clock_gating */
-		hdev->asic_funcs->set_clock_gating(hdev);
-		mutex_unlock(&gaudi->clk_gate_mutex);
-
 		rc = gaudi_add_sync_to_engine_map_entry(map, reg_value,
 							ENGINE_TPC, i);
 		if (rc)
@@ -9217,20 +9115,11 @@ static int gaudi_gen_sync_to_engine_map(struct hl_device *hdev,
 	/* Iterate over MME engines */
 	for (i = 0; i < sds->props[SP_NUM_OF_MME_ENGINES]; ++i) {
 		for (j = 0; j < sds->props[SP_SUB_MME_ENG_NUM]; ++j) {
-			/* MME registered must be accessed with clock gating
-			 * disabled
-			 */
-			mutex_lock(&gaudi->clk_gate_mutex);
-			hdev->asic_funcs->disable_clock_gating(hdev);
 
 			reg_value = RREG32(sds->props[SP_MME_CFG_SO] +
 						sds->props[SP_NEXT_MME] * i +
 						j * sizeof(u32));
 
-			/* We can reenable clock_gating */
-			hdev->asic_funcs->set_clock_gating(hdev);
-			mutex_unlock(&gaudi->clk_gate_mutex);
-
 			rc = gaudi_add_sync_to_engine_map_entry(
 				map, reg_value, ENGINE_MME,
 				i * sds->props[SP_SUB_MME_ENG_NUM] + j);
@@ -9481,8 +9370,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.mmu_invalidate_cache = gaudi_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = gaudi_mmu_invalidate_cache_range,
 	.send_heartbeat = gaudi_send_heartbeat,
-	.set_clock_gating = gaudi_set_clock_gating,
-	.disable_clock_gating = gaudi_disable_clock_gating,
 	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
 	.non_hard_reset_late_init = gaudi_non_hard_reset_late_init,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index caa858bf6edc..fdadcbf3ef80 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -312,8 +312,6 @@ struct gaudi_internal_qman_info {
  * struct gaudi_device - ASIC specific manage structure.
  * @cpucp_info_get: get information on device from CPU-CP
  * @hw_queues_lock: protects the H/W queues from concurrent access.
- * @clk_gate_mutex: protects code areas that require clock gating to be disabled
- *                  temporarily
  * @internal_qmans: Internal QMANs information. The array size is larger than
  *                  the actual number of internal queues because they are not in
  *                  consecutive order.
@@ -336,7 +334,6 @@ struct gaudi_device {
 
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t			hw_queues_lock;
-	struct mutex			clk_gate_mutex;
 
 	struct gaudi_internal_qman_info	internal_qmans[GAUDI_QUEUE_ID_SIZE];
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index fbcc7bbf44b3..954ef4d7bbf7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5391,16 +5391,6 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static void goya_set_clock_gating(struct hl_device *hdev)
-{
-	/* clock gating not supported in Goya */
-}
-
-static void goya_disable_clock_gating(struct hl_device *hdev)
-{
-	/* clock gating not supported in Goya */
-}
-
 static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 					u8 mask_len, struct seq_file *s)
 {
@@ -5734,8 +5724,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
 	.send_heartbeat = goya_send_heartbeat,
-	.set_clock_gating = goya_set_clock_gating,
-	.disable_clock_gating = goya_disable_clock_gating,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
 	.non_hard_reset_late_init = goya_non_hard_reset_late_init,
-- 
2.25.1


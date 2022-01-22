Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C089E496DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiAVT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiAVT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 111A660EB3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC55FC340E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881470;
        bh=NR4YMBKeLcMncDs8ZrWUkujacLbIi7Ou0pAt08xNRJg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PykwrfZ7jdSAJVAuoc1sq7QQyRBl2G6nNZFrr+35ZyeF2IvnQaNFnF9YJkcnzcK9N
         Y3VE3wqTBumN8WNX+2+FZAmGL5pLV7R4mfdE7G1D4HD3wF3slnRX4RbKNFnQg1FfUG
         9g8/7iMCenS3xW7DuZ1MRZ11SIbLA5EBbN0uPpqSew25Ym1jqy2JIYArE3lnCy1peP
         dKDJWSY0FTsJwXMWejTgiuu6NPm5PrGjCuU4uY5qYtxhPsrgEFiMD+POSi9Zvv/rKa
         upsha6AW+aUwwSpRF/5U7Om/apsMuNByRpCMuJ24YxQ4L5nnaisydbORAwqp8By9i9
         Tu/5t4VWnONkw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/30] habanalabs: remove asic callback set_pll_profile()
Date:   Sat, 22 Jan 2022 21:57:12 +0200
Message-Id: <20220122195731.934494-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting PLL profile is the same for all ASICs, except for GOYA.
However, because this function is never called from common code, there
is no need to have an asic-specific callback function.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h  | 5 +----
 drivers/misc/habanalabs/gaudi/gaudi.c        | 3 +--
 drivers/misc/habanalabs/goya/goya.c          | 3 +--
 drivers/misc/habanalabs/goya/goya_hwmgr.c    | 3 +++
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 508ee349f4e4..93e9045461ae 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2683,7 +2683,7 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 			hl_fw_static_init_cpu(hdev, fw_loader);
 }
 
-void hl_fw_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
+void hl_fw_set_pll_profile(struct hl_device *hdev)
 {
 	hl_fw_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
 				hdev->asic_prop.max_freq_value);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2bf73e5ce47f..3dc155948730 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1161,7 +1161,6 @@ struct fw_load_mgr {
  *                    internal memory via DMA engine.
  * @add_device_attr: add ASIC specific device attributes.
  * @handle_eqe: handle event queue entry (IRQ) from CPU-CP.
- * @set_pll_profile: change PLL profile (manual/automatic).
  * @get_events_stat: retrieve event queue entries histogram.
  * @read_pte: read MMU page table entry from DRAM.
  * @write_pte: write MMU page table entry to DRAM.
@@ -1291,8 +1290,6 @@ struct hl_asic_funcs {
 				struct attribute_group *dev_attr_grp);
 	void (*handle_eqe)(struct hl_device *hdev,
 				struct hl_eq_entry *eq_entry);
-	void (*set_pll_profile)(struct hl_device *hdev,
-			enum hl_pll_frequency freq);
 	void* (*get_events_stat)(struct hl_device *hdev, bool aggregate,
 				u32 *size);
 	u64 (*read_pte)(struct hl_device *hdev, u64 addr);
@@ -3108,7 +3105,7 @@ int hl_set_current(struct hl_device *hdev, int sensor_index, u32 attr, long valu
 int hl_set_power(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 int hl_get_power(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
 int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
-void hl_fw_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
+void hl_fw_set_pll_profile(struct hl_device *hdev);
 void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp);
 
 void hw_sob_get(struct hl_hw_sob *hw_sob);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae86147dfde4..bb0b4ff3451d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1635,7 +1635,7 @@ static int gaudi_late_init(struct hl_device *hdev)
 	 */
 	gaudi_mmu_prepare(hdev, 1);
 
-	hdev->asic_funcs->set_pll_profile(hdev, PLL_LAST);
+	hl_fw_set_pll_profile(hdev);
 
 	return 0;
 
@@ -9363,7 +9363,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_read_dma = gaudi_debugfs_read_dma,
 	.add_device_attr = hl_sysfs_add_dev_clk_attr,
 	.handle_eqe = gaudi_handle_eqe,
-	.set_pll_profile = hl_fw_set_pll_profile,
 	.get_events_stat = gaudi_get_events_stat,
 	.read_pte = gaudi_read_pte,
 	.write_pte = gaudi_write_pte,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 318b97c53ed7..916a718dddac 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -893,7 +893,7 @@ int goya_late_init(struct hl_device *hdev)
 
 	goya->pm_mng_profile = PM_AUTO;
 
-	hdev->asic_funcs->set_pll_profile(hdev, PLL_LOW);
+	goya_set_pll_profile(hdev, PLL_LOW);
 
 	schedule_delayed_work(&goya->goya_work->work_freq,
 		usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
@@ -5717,7 +5717,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.debugfs_read_dma = goya_debugfs_read_dma,
 	.add_device_attr = goya_add_device_attr,
 	.handle_eqe = goya_handle_eqe,
-	.set_pll_profile = goya_set_pll_profile,
 	.get_events_stat = goya_get_events_stat,
 	.read_pte = goya_read_pte,
 	.write_pte = goya_write_pte,
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index f9f3afe94056..7d4f26c67d8e 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -11,6 +11,9 @@ void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
+	if (!hdev->pdev)
+		return;
+
 	switch (freq) {
 	case PLL_HIGH:
 		hl_fw_set_frequency(hdev, HL_GOYA_MME_PLL, hdev->high_pll);
-- 
2.25.1


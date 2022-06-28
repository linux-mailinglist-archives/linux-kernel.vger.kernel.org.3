Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1854855CCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbiF1LAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbiF1LAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:00:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA531DEA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAA5B81DD0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97985C3411D;
        Tue, 28 Jun 2022 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414015;
        bh=VtHdxkdeFFouqzO57eZX89z8B3ss7GqEAOxdkUJ3pWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYzr/4F5wFKzVD5uLgYhWflovCKTjoVoy08OFsvfpxCiSg/c0JFXWYy8n5MOqegL/
         Yyn96DR3P4Vw5VEkTn+Pvt0tWwIOQKnEgDyv+2MX/nhBZTN4FDa+tVqdkBU0g7gO7/
         yCQLY2rOeTxjv+7m8amtIQ0s+tDdd4OtbhukZ5j9tPqnzzeNKsjOLdreiY77Lcuypa
         BISrb0A6iJz3Hm1L3gkvWiWUk/BrRWssf3n1foJwpZkJK4lNgvsnPAVN7lYRiyTDJr
         ZeYC6AcxzT1N3Nuuyu6QuTdfogq4TfdFsR78wAwV1n0tds35YnMZutyghQikYiPuHS
         9cUW4xVpa1CfA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2 06/12] habanalabs: remove obsolete device variables used for testing
Date:   Tue, 28 Jun 2022 13:59:52 +0300
Message-Id: <20220628105958.1254875-7-ogabbay@kernel.org>
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

There are a couple of device variables that are used for testing
purposes and they are set to fixed values.

Remove the variables that are not relevant anymore and document the
remaining variables.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |   3 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  25 ++--
 .../misc/habanalabs/common/habanalabs_drv.c   |  14 +-
 drivers/misc/habanalabs/common/pci/pci.c      |  24 ----
 drivers/misc/habanalabs/gaudi/gaudi.c         | 131 +-----------------
 5 files changed, 24 insertions(+), 173 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 5b345fc3dcc1..4b6b6ba5b2fa 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -348,8 +348,7 @@ static void hpriv_release(struct kref *ref)
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
-	if ((hdev->reset_if_device_not_idle && !device_is_idle) ||
-		hdev->reset_upon_device_release) {
+	if (!device_is_idle || hdev->reset_upon_device_release) {
 		hl_device_reset(hdev, HL_DRV_RESET_DEV_RELEASE);
 	} else {
 		int rc = hdev->asic_funcs->scrub_device_mem(hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 803ce808ed2e..e91dd22e6855 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2968,7 +2968,6 @@ struct hl_reset_info {
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
- * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.
  * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
  *                   otherwise.
  * @dram_default_page_mapping: is DRAM default page mapping enabled.
@@ -3001,6 +3000,21 @@ struct hl_reset_info {
  * @is_compute_ctx_active: Whether there is an active compute context executing.
  * @compute_ctx_in_release: true if the current compute context is being released.
  * @supports_mmu_prefetch: true if prefetch is supported, otherwise false.
+ * @reset_upon_device_release: reset the device when the user closes the file descriptor of the
+ *                             device.
+ * @nic_ports_mask: Controls which NIC ports are enabled. Used only for testing.
+ * @fw_components: Controls which f/w components to load to the device. There are multiple f/w
+ *                 stages and sometimes we want to stop at a certain stage. Used only for testing.
+ * @mmu_enable: Whether to enable or disable the device MMU(s). Used only for testing.
+ * @cpu_queues_enable: Whether to enable queues communication vs. the f/w. Used only for testing.
+ * @pldm: Whether we are running in Palladium environment. Used only for testing.
+ * @hard_reset_on_fw_events: Whether to do device hard-reset when a fatal event is received from
+ *                           the f/w. Used only for testing.
+ * @bmc_enable: Whether we are running in a box with BMC. Used only for testing.
+ * @reset_on_preboot_fail: Whether to reset the device if preboot f/w fails to load.
+ *                         Used only for testing.
+ * @heartbeat: Controls if we want to enable the heartbeat mechanism vs. the f/w, which verifies
+ *             that the f/w is always alive. Used only for testing.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -3108,7 +3122,6 @@ struct hl_device {
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
-	u8				heartbeat;
 	u8				reset_on_lockup;
 	u8				dram_default_page_mapping;
 	u8				memory_scrub;
@@ -3132,22 +3145,18 @@ struct hl_device {
 	u8				is_compute_ctx_active;
 	u8				compute_ctx_in_release;
 	u8				supports_mmu_prefetch;
+	u8				reset_upon_device_release;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
 	u64				fw_components;
 	u8				mmu_enable;
-	u8				mmu_huge_page_opt;
-	u8				reset_pcilink;
 	u8				cpu_queues_enable;
 	u8				pldm;
-	u8				sram_scrambler_enable;
-	u8				dram_scrambler_enable;
 	u8				hard_reset_on_fw_events;
 	u8				bmc_enable;
 	u8				reset_on_preboot_fail;
-	u8				reset_upon_device_release;
-	u8				reset_if_device_not_idle;
+	u8				heartbeat;
 };
 
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 3a41dbef14f8..7362387bdd80 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -280,19 +280,15 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
-	hdev->pldm = 0;
+	hdev->nic_ports_mask = 0;
 	hdev->fw_components = FW_TYPE_ALL_TYPES;
-	hdev->cpu_queues_enable = 1;
-	hdev->heartbeat = 1;
 	hdev->mmu_enable = 1;
-	hdev->sram_scrambler_enable = 1;
-	hdev->dram_scrambler_enable = 1;
-	hdev->bmc_enable = 1;
+	hdev->cpu_queues_enable = 1;
+	hdev->pldm = 0;
 	hdev->hard_reset_on_fw_events = 1;
+	hdev->bmc_enable = 1;
 	hdev->reset_on_preboot_fail = 1;
-	hdev->reset_if_device_not_idle = 1;
-
-	hdev->reset_pcilink = 0;
+	hdev->heartbeat = 1;
 }
 
 static void copy_kernel_module_params_to_device(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index af0f58e75c9a..5fe3da5fba30 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -224,27 +224,6 @@ int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
 	return 0;
 }
 
-/**
- * hl_pci_reset_link_through_bridge() - Reset PCI link.
- * @hdev: Pointer to hl_device structure.
- */
-static void hl_pci_reset_link_through_bridge(struct hl_device *hdev)
-{
-	struct pci_dev *pdev = hdev->pdev;
-	struct pci_dev *parent_port;
-	u16 val;
-
-	parent_port = pdev->bus->self;
-	pci_read_config_word(parent_port, PCI_BRIDGE_CONTROL, &val);
-	val |= PCI_BRIDGE_CTL_BUS_RESET;
-	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
-	ssleep(1);
-
-	val &= ~(PCI_BRIDGE_CTL_BUS_RESET);
-	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
-	ssleep(3);
-}
-
 /**
  * hl_pci_set_inbound_region() - Configure inbound region
  * @hdev: Pointer to hl_device structure.
@@ -394,9 +373,6 @@ int hl_pci_init(struct hl_device *hdev)
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
 
-	if (hdev->reset_pcilink)
-		hl_pci_reset_link_through_bridge(hdev);
-
 	rc = pci_enable_device_mem(pdev);
 	if (rc) {
 		dev_err(hdev->dev, "can't enable PCI device\n");
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 834f8d5cdf84..dcda3ac94fbd 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2165,9 +2165,6 @@ static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 	if (gaudi->hw_cap_initialized & HW_CAP_SRAM_SCRAMBLER)
 		return;
 
-	if (!hdev->sram_scrambler_enable)
-		return;
-
 	WREG32(mmNIF_RTR_CTRL_0_SCRAM_SRAM_EN,
 			1 << IF_RTR_CTRL_SCRAM_SRAM_EN_VAL_SHIFT);
 	WREG32(mmNIF_RTR_CTRL_1_SCRAM_SRAM_EN,
@@ -2236,9 +2233,6 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 	if (gaudi->hw_cap_initialized & HW_CAP_HBM_SCRAMBLER)
 		return;
 
-	if (!hdev->dram_scrambler_enable)
-		return;
-
 	WREG32(mmNIF_RTR_CTRL_0_SCRAM_HBM_EN,
 			1 << IF_RTR_CTRL_SCRAM_HBM_EN_VAL_SHIFT);
 	WREG32(mmNIF_RTR_CTRL_1_SCRAM_HBM_EN,
@@ -2422,128 +2416,6 @@ static void gaudi_init_e2e(struct hl_device *hdev)
 	WREG32(mmDMA_IF_W_S_DOWN_CH1_E2E_PCI_WR_SIZE, 162);
 	WREG32(mmDMA_IF_W_S_DOWN_CH1_E2E_PCI_RD_SIZE, 338);
 
-	if (!hdev->dram_scrambler_enable) {
-		WREG32(mmSIF_RTR_CTRL_0_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_0_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_0_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_0_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_1_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_1_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_1_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_1_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_2_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_2_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_2_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_2_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_3_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_3_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_3_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_3_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_4_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_4_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_4_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_4_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_5_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_5_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_5_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_5_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_6_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_6_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_6_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_6_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmSIF_RTR_CTRL_7_NL_HBM_SEL_0, 0x21);
-		WREG32(mmSIF_RTR_CTRL_7_NL_HBM_SEL_1, 0x22);
-		WREG32(mmSIF_RTR_CTRL_7_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmSIF_RTR_CTRL_7_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_0_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_0_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_0_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_0_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_1_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_1_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_1_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_1_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_2_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_2_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_2_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_2_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_3_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_3_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_3_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_3_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_4_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_4_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_4_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_4_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_5_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_5_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_5_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_5_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_6_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_6_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_6_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_6_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmNIF_RTR_CTRL_7_NL_HBM_SEL_0, 0x21);
-		WREG32(mmNIF_RTR_CTRL_7_NL_HBM_SEL_1, 0x22);
-		WREG32(mmNIF_RTR_CTRL_7_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmNIF_RTR_CTRL_7_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_E_N_DOWN_CH0_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_E_N_DOWN_CH0_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_E_N_DOWN_CH0_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_E_N_DOWN_CH0_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_E_N_DOWN_CH1_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_E_N_DOWN_CH1_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_E_N_DOWN_CH1_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_E_N_DOWN_CH1_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_E_S_DOWN_CH0_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_E_S_DOWN_CH0_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_E_S_DOWN_CH0_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_E_S_DOWN_CH0_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_E_S_DOWN_CH1_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_E_S_DOWN_CH1_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_E_S_DOWN_CH1_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_E_S_DOWN_CH1_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_W_N_DOWN_CH0_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_W_N_DOWN_CH0_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_W_N_DOWN_CH0_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_W_N_DOWN_CH0_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_W_N_DOWN_CH1_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_W_N_DOWN_CH1_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_W_N_DOWN_CH1_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_W_N_DOWN_CH1_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_W_S_DOWN_CH0_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_W_S_DOWN_CH0_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_W_S_DOWN_CH0_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_W_S_DOWN_CH0_NL_HBM_PC_SEL_3, 0x20);
-
-		WREG32(mmDMA_IF_W_S_DOWN_CH1_NL_HBM_SEL_0, 0x21);
-		WREG32(mmDMA_IF_W_S_DOWN_CH1_NL_HBM_SEL_1, 0x22);
-		WREG32(mmDMA_IF_W_S_DOWN_CH1_NL_HBM_OFFSET_18, 0x1F);
-		WREG32(mmDMA_IF_W_S_DOWN_CH1_NL_HBM_PC_SEL_3, 0x20);
-	}
-
 	WREG32(mmSIF_RTR_CTRL_0_E2E_HBM_EN,
 			1 << IF_RTR_CTRL_E2E_HBM_EN_VAL_SHIFT);
 	WREG32(mmSIF_RTR_CTRL_0_E2E_PCI_EN,
@@ -3888,8 +3760,7 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	WREG32(mmMMU_UP_MMU_ENABLE, 1);
 	WREG32(mmMMU_UP_SPI_MASK, 0xF);
 
-	WREG32(mmSTLB_HOP_CONFIGURATION,
-			hdev->mmu_huge_page_opt ? 0x30440 : 0x40440);
+	WREG32(mmSTLB_HOP_CONFIGURATION, 0x30440);
 
 	/*
 	 * The H/W expects the first PI after init to be 1. After wraparound
-- 
2.25.1


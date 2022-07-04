Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF85650C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGDJaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiGDJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E041032
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C72E5B80909
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D84BC341CD;
        Mon,  4 Jul 2022 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926988;
        bh=AA8RT7gQB2RwEtdcK0MEMu3/nXeEyxFoTbfXkqYnj90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMVIemzvk+YHSZ4OkV9ysrJnZeK1AK8kzHcpEa7JXR6XcADUemialijkcA8qGBDow
         MXa4fDxJ7mMzz/0iX/B9kfPVFk/5D+VrJtcaPRpqpDr9hwu0v87eBxH6J65QM057oR
         XRdascKeYkoMejEoXfQ/+uEwqj4savpNPCRVFrNLvyhIe8TQUir8lh3NPyb4PmjqRY
         Q5wjw6lV1K1aZjaUIID1Ipa8l/b1xsYd80aFErOS1KYzaXxSh+Or5qGub/0ZU6/IW1
         igl1fxGaSXhQoUUM9bZZi0UrJMgpqnjG+xGjvc4EAnxRH+nRoD3rFdvNPLmQEPByQB
         HvpEexrHYV0NA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 02/12] habanalabs: wait for preboot ready after hard reset
Date:   Mon,  4 Jul 2022 12:29:31 +0300
Message-Id: <20220704092941.2237683-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Currently we are not waiting for preboot ready after hard reset.
This leads to a race in which COMMs protocol begins but will get no
response from the f/w.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 65 +++++++++++++-------
 drivers/misc/habanalabs/common/habanalabs.h  | 27 ++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c        | 19 ++++--
 drivers/misc/habanalabs/gaudi2/gaudi2.c      | 19 ++++--
 drivers/misc/habanalabs/goya/goya.c          | 19 ++++--
 5 files changed, 107 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 9f0a24ee5af4..64c5cdfc6dcf 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1245,15 +1245,10 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	}
 }
 
-static int hl_fw_read_preboot_caps(struct hl_device *hdev,
-					u32 cpu_boot_status_reg,
-					u32 sts_boot_dev_sts0_reg,
-					u32 sts_boot_dev_sts1_reg,
-					u32 boot_err0_reg, u32 boot_err1_reg,
-					u32 timeout)
+static int hl_fw_wait_preboot_ready(struct hl_device *hdev)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 status, reg_val;
+	struct pre_fw_load_props *pre_fw_load = &hdev->fw_loader.pre_fw_load;
+	u32 status;
 	int rc;
 
 	/* Need to check two possible scenarios:
@@ -1266,13 +1261,13 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 	 */
 	rc = hl_poll_timeout(
 		hdev,
-		cpu_boot_status_reg,
+		pre_fw_load->cpu_boot_status_reg,
 		status,
 		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT),
 		hdev->fw_poll_interval_usec,
-		timeout);
+		pre_fw_load->wait_for_preboot_timeout);
 
 	if (rc) {
 		dev_err(hdev->dev, "CPU boot ready status timeout\n");
@@ -1282,12 +1277,32 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		 * of reading specific errors
 		 */
 		if (status != -1)
-			fw_read_errors(hdev, boot_err0_reg, boot_err1_reg,
-							sts_boot_dev_sts0_reg,
-							sts_boot_dev_sts1_reg);
+			fw_read_errors(hdev, pre_fw_load->boot_err0_reg,
+						pre_fw_load->boot_err1_reg,
+						pre_fw_load->sts_boot_dev_sts0_reg,
+						pre_fw_load->sts_boot_dev_sts1_reg);
 		return -EIO;
 	}
 
+	hdev->fw_loader.fw_comp_loaded |= FW_TYPE_PREBOOT_CPU;
+
+	return 0;
+}
+
+static int hl_fw_read_preboot_caps(struct hl_device *hdev)
+{
+	struct pre_fw_load_props *pre_fw_load;
+	struct asic_fixed_properties *prop;
+	u32 reg_val;
+	int rc;
+
+	prop = &hdev->asic_prop;
+	pre_fw_load = &hdev->fw_loader.pre_fw_load;
+
+	rc = hl_fw_wait_preboot_ready(hdev);
+	if (rc)
+		return rc;
+
 	/*
 	 * the registers DEV_STS* contain FW capabilities/features.
 	 * We can rely on this registers only if bit CPU_BOOT_DEV_STS*_ENABLED
@@ -1298,13 +1313,13 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 	 * In case it is not enabled the stored value will be left 0- all
 	 * caps/features are off
 	 */
-	reg_val = RREG32(sts_boot_dev_sts0_reg);
+	reg_val = RREG32(pre_fw_load->sts_boot_dev_sts0_reg);
 	if (reg_val & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_cpu_boot_dev_sts0_valid = true;
 		prop->fw_preboot_cpu_boot_dev_sts0 = reg_val;
 	}
 
-	reg_val = RREG32(sts_boot_dev_sts1_reg);
+	reg_val = RREG32(pre_fw_load->sts_boot_dev_sts1_reg);
 	if (reg_val & CPU_BOOT_DEV_STS1_ENABLED) {
 		prop->fw_cpu_boot_dev_sts1_valid = true;
 		prop->fw_preboot_cpu_boot_dev_sts1 = reg_val;
@@ -1447,24 +1462,21 @@ static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
 	return 0;
 }
 
-int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
-				u32 sts_boot_dev_sts0_reg,
-				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
-				u32 boot_err1_reg, u32 timeout)
+int hl_fw_read_preboot_status(struct hl_device *hdev)
 {
 	int rc;
 
 	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU))
 		return 0;
 
+	/* get FW pre-load parameters  */
+	hdev->asic_funcs->init_firmware_preload_params(hdev);
+
 	/*
 	 * In order to determine boot method (static VS dymanic) we need to
 	 * read the boot caps register
 	 */
-	rc = hl_fw_read_preboot_caps(hdev, cpu_boot_status_reg,
-					sts_boot_dev_sts0_reg,
-					sts_boot_dev_sts1_reg, boot_err0_reg,
-					boot_err1_reg, timeout);
+	rc = hl_fw_read_preboot_caps(hdev);
 	if (rc)
 		return rc;
 
@@ -2454,6 +2466,13 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	 */
 	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 
+	/* if no preboot loaded indication- wait for preboot */
+	if (!(hdev->fw_loader.fw_comp_loaded & FW_TYPE_PREBOOT_CPU)) {
+		rc = hl_fw_wait_preboot_ready(hdev);
+		if (rc)
+			return -EIO;
+	}
+
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_RST_STATE,
 						0, true,
 						fw_loader->cpu_timeout);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6f92e3088375..8c38c2c1b1dc 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1307,6 +1307,24 @@ struct dynamic_fw_load_mgr {
 	bool fw_desc_valid;
 };
 
+/**
+ * struct pre_fw_load_props - needed properties for pre-FW load
+ * @cpu_boot_status_reg: cpu_boot_status register address
+ * @sts_boot_dev_sts0_reg: sts_boot_dev_sts0 register address
+ * @sts_boot_dev_sts1_reg: sts_boot_dev_sts1 register address
+ * @boot_err0_reg: boot_err0 register address
+ * @boot_err1_reg: boot_err1 register address
+ * @wait_for_preboot_timeout: timeout to poll for preboot ready
+ */
+struct pre_fw_load_props {
+	u32 cpu_boot_status_reg;
+	u32 sts_boot_dev_sts0_reg;
+	u32 sts_boot_dev_sts1_reg;
+	u32 boot_err0_reg;
+	u32 boot_err1_reg;
+	u32 wait_for_preboot_timeout;
+};
+
 /**
  * struct fw_image_props - properties of FW image
  * @image_name: name of the image
@@ -1323,6 +1341,7 @@ struct fw_image_props {
  * struct fw_load_mgr - manager FW loading process
  * @dynamic_loader: specific structure for dynamic load
  * @static_loader: specific structure for static load
+ * @pre_fw_load_props: parameter for pre FW load
  * @boot_fit_img: boot fit image properties
  * @linux_img: linux image properties
  * @cpu_timeout: CPU response timeout in usec
@@ -1338,6 +1357,7 @@ struct fw_load_mgr {
 		struct dynamic_fw_load_mgr dynamic_loader;
 		struct static_fw_load_mgr static_loader;
 	};
+	struct pre_fw_load_props pre_fw_load;
 	struct fw_image_props boot_fit_img;
 	struct fw_image_props linux_img;
 	u32 cpu_timeout;
@@ -1467,6 +1487,7 @@ struct hl_cs;
  * @get_msi_info: Retrieve asic-specific MSI ID of the f/w async event
  * @map_pll_idx_to_fw_idx: convert driver specific per asic PLL index to
  *                         generic f/w compatible PLL Indexes
+ * @init_firmware_preload_params: initialize pre FW-load parameters.
  * @init_firmware_loader: initialize data for FW loader.
  * @init_cpu_scrambler_dram: Enable CPU specific DRAM scrambling
  * @state_dump_init: initialize constants required for state dump
@@ -1599,6 +1620,7 @@ struct hl_asic_funcs {
 	int (*ack_mmu_errors)(struct hl_device *hdev, u64 mmu_cap_mask);
 	void (*get_msi_info)(__le32 *table);
 	int (*map_pll_idx_to_fw_idx)(u32 pll_idx);
+	void (*init_firmware_preload_params)(struct hl_device *hdev);
 	void (*init_firmware_loader)(struct hl_device *hdev);
 	void (*init_cpu_scrambler_dram)(struct hl_device *hdev);
 	void (*state_dump_init)(struct hl_device *hdev);
@@ -3577,10 +3599,7 @@ int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 void hl_fw_ask_hard_reset_without_linux(struct hl_device *hdev);
 void hl_fw_ask_halt_machine_without_linux(struct hl_device *hdev);
 int hl_fw_init_cpu(struct hl_device *hdev);
-int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
-				u32 sts_boot_dev_sts0_reg,
-				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
-				u32 boot_err1_reg, u32 timeout);
+int hl_fw_read_preboot_status(struct hl_device *hdev);
 int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 				struct fw_load_mgr *fw_loader,
 				enum comms_cmd cmd, unsigned int size,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index dcda3ac94fbd..31a2589929f2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -869,11 +869,7 @@ static int gaudi_early_init(struct hl_device *hdev)
 	/* Before continuing in the initialization, we need to read the preboot
 	 * version to determine whether we run with a security-enabled firmware
 	 */
-	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-					mmCPU_BOOT_DEV_STS0,
-					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
-					mmCPU_BOOT_ERR1,
-					GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
+	rc = hl_fw_read_preboot_status(hdev);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
 			hdev->asic_funcs->hw_fini(hdev, true, false);
@@ -3840,6 +3836,18 @@ static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
 			GAUDI_CPU_RESET_WAIT_MSEC;
 }
 
+static void gaudi_init_firmware_preload_params(struct hl_device *hdev)
+{
+	struct pre_fw_load_props *pre_fw_load = &hdev->fw_loader.pre_fw_load;
+
+	pre_fw_load->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	pre_fw_load->sts_boot_dev_sts0_reg = mmCPU_BOOT_DEV_STS0;
+	pre_fw_load->sts_boot_dev_sts1_reg = mmCPU_BOOT_DEV_STS1;
+	pre_fw_load->boot_err0_reg = mmCPU_BOOT_ERR0;
+	pre_fw_load->boot_err1_reg = mmCPU_BOOT_ERR1;
+	pre_fw_load->wait_for_preboot_timeout = GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC;
+}
+
 static void gaudi_init_firmware_loader(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -9231,6 +9239,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.enable_events_from_fw = gaudi_enable_events_from_fw,
 	.ack_mmu_errors = gaudi_ack_mmu_page_fault_or_access_error,
 	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx,
+	.init_firmware_preload_params = gaudi_init_firmware_preload_params,
 	.init_firmware_loader = gaudi_init_firmware_loader,
 	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm,
 	.state_dump_init = gaudi_state_dump_init,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index dbbd08600a56..5e6df7814fb1 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2531,11 +2531,7 @@ static int gaudi2_early_init(struct hl_device *hdev)
 	/* Before continuing in the initialization, we need to read the preboot
 	 * version to determine whether we run with a security-enabled firmware
 	 */
-	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-					mmCPU_BOOT_DEV_STS0,
-					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
-					mmCPU_BOOT_ERR1,
-					GAUDI2_PREBOOT_REQ_TIMEOUT_USEC);
+	rc = hl_fw_read_preboot_status(hdev);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
 			hdev->asic_funcs->hw_fini(hdev, true, false);
@@ -3832,6 +3828,18 @@ static void gaudi2_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw
 	gaudi2_sync_irqs(hdev);
 }
 
+static void gaudi2_init_firmware_preload_params(struct hl_device *hdev)
+{
+	struct pre_fw_load_props *pre_fw_load = &hdev->fw_loader.pre_fw_load;
+
+	pre_fw_load->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	pre_fw_load->sts_boot_dev_sts0_reg = mmCPU_BOOT_DEV_STS0;
+	pre_fw_load->sts_boot_dev_sts1_reg = mmCPU_BOOT_DEV_STS1;
+	pre_fw_load->boot_err0_reg = mmCPU_BOOT_ERR0;
+	pre_fw_load->boot_err1_reg = mmCPU_BOOT_ERR1;
+	pre_fw_load->wait_for_preboot_timeout = GAUDI2_PREBOOT_REQ_TIMEOUT_USEC;
+}
+
 static void gaudi2_init_firmware_loader(struct hl_device *hdev)
 {
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
@@ -9762,6 +9770,7 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.ack_mmu_errors = gaudi2_ack_mmu_page_fault_or_access_error,
 	.get_msi_info = gaudi2_get_msi_info,
 	.map_pll_idx_to_fw_idx = gaudi2_map_pll_idx_to_fw_idx,
+	.init_firmware_preload_params = gaudi2_init_firmware_preload_params,
 	.init_firmware_loader = gaudi2_init_firmware_loader,
 	.init_cpu_scrambler_dram = gaudi2_init_scrambler_hbm,
 	.state_dump_init = gaudi2_state_dump_init,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 988fafce2a3c..0c333b42225a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -665,11 +665,7 @@ static int goya_early_init(struct hl_device *hdev)
 	/* Before continuing in the initialization, we need to read the preboot
 	 * version to determine whether we run with a security-enabled firmware
 	 */
-	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-					mmCPU_BOOT_DEV_STS0,
-					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
-					mmCPU_BOOT_ERR1,
-					GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
+	rc = hl_fw_read_preboot_status(hdev);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
 			hdev->asic_funcs->hw_fini(hdev, true, false);
@@ -2580,6 +2576,18 @@ static void goya_init_static_firmware_loader(struct hl_device *hdev)
 	static_loader->sram_offset_mask = ~(lower_32_bits(SRAM_BASE_ADDR));
 }
 
+static void goya_init_firmware_preload_params(struct hl_device *hdev)
+{
+	struct pre_fw_load_props *pre_fw_load = &hdev->fw_loader.pre_fw_load;
+
+	pre_fw_load->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	pre_fw_load->sts_boot_dev_sts0_reg = mmCPU_BOOT_DEV_STS0;
+	pre_fw_load->sts_boot_dev_sts1_reg = mmCPU_BOOT_DEV_STS1;
+	pre_fw_load->boot_err0_reg = mmCPU_BOOT_ERR0;
+	pre_fw_load->boot_err1_reg = mmCPU_BOOT_ERR1;
+	pre_fw_load->wait_for_preboot_timeout = GOYA_BOOT_FIT_REQ_TIMEOUT_USEC;
+}
+
 static void goya_init_firmware_loader(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -5510,6 +5518,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.enable_events_from_fw = goya_enable_events_from_fw,
 	.ack_mmu_errors = goya_ack_mmu_page_fault_or_access_error,
 	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx,
+	.init_firmware_preload_params = goya_init_firmware_preload_params,
 	.init_firmware_loader = goya_init_firmware_loader,
 	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram,
 	.state_dump_init = goya_state_dump_init,
-- 
2.25.1


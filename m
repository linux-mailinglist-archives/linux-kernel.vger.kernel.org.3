Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8048855C5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiF0U13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiF0U0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B687A1A80D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C21B3CE1D8F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6966BC385A2;
        Mon, 27 Jun 2022 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361607;
        bh=AEyGfo7qB0JdcoEU1SEFjmckCi16kjksfsTnCckfglw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEB/jb8/wM8iH2mLKsSaXvLWtBQfAI/253KIxP4UqwOw2ehaclVwvB5fdNIgmgsRi
         bEItqHuqyAQ4kYP4Y7EzotbKhdJLedBjLbu2bO7sqNbjRN0ftgNldaOZXSRgq+Vs5v
         VuHwNzFf6EzK7uLa/145SapzPUSfEB1q9Ih6maioi2+KK5IQbbJkYrk2ndV59maYAq
         8PiHwBHCAIf7r0Gcj8GliiyeGFA3MxpbbMC2MLdFfuSa2/KkWmQUJld67gCX3KDLlU
         zrypRAdrMN4dEdiC2f8twIkUtnJ/gDCcYXd0jDqFDozQVTP0a0O9ukM2yJfg+GF0u6
         3riis8OxMerAA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 12/12] habanalabs: enable gaudi2 code in driver
Date:   Mon, 27 Jun 2022 23:26:20 +0300
Message-Id: <20220627202620.961350-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627202620.961350-1-ogabbay@kernel.org>
References: <20220627202620.961350-1-ogabbay@kernel.org>
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

Enable the Gaudi2 ASIC code in the pci probe callback of the driver so
the driver will handle Gaudi2 ASICs.

Add the PCI ID to the PCI table and add the ASIC enum value to all
relevant places.

Fixup the device parameters initialization for Gaudi2.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  8 +++
 drivers/misc/habanalabs/common/habanalabs.h   | 13 ++--
 .../misc/habanalabs/common/habanalabs_drv.c   | 67 +++++++++++++++----
 drivers/misc/habanalabs/common/sysfs.c        |  6 ++
 4 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 38cf2f1659ee..a4656eac495e 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -645,6 +645,14 @@ static int device_early_init(struct hl_device *hdev)
 		gaudi_set_asic_funcs(hdev);
 		strscpy(hdev->asic_name, "GAUDI SEC", sizeof(hdev->asic_name));
 		break;
+	case ASIC_GAUDI2:
+		gaudi2_set_asic_funcs(hdev);
+		strscpy(hdev->asic_name, "GAUDI2", sizeof(hdev->asic_name));
+		break;
+	case ASIC_GAUDI2_SEC:
+		gaudi2_set_asic_funcs(hdev);
+		strscpy(hdev->asic_name, "GAUDI2 SEC", sizeof(hdev->asic_name));
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 			hdev->asic_type);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4537845658f8..587b1c537115 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3033,7 +3033,6 @@ struct hl_reset_info {
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
- * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.
  * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
  *                   otherwise.
  * @dram_default_page_mapping: is DRAM default page mapping enabled.
@@ -3066,6 +3065,10 @@ struct hl_reset_info {
  * @is_compute_ctx_active: Whether there is an active compute context executing.
  * @compute_ctx_in_release: true if the current compute context is being released.
  * @supports_mmu_prefetch: true if prefetch is supported, otherwise false.
+ * @reset_upon_device_release: reset the device when the user closes the file descriptor of the
+ *                             device.
+ * @skip_iatu_for_unsecured_device: skip the device PCI controller initialization when working
+ *                                  with device that runs f/w that is not secured.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -3175,7 +3178,6 @@ struct hl_device {
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
-	u8				heartbeat;
 	u8				reset_on_lockup;
 	u8				dram_default_page_mapping;
 	u8				memory_scrub;
@@ -3199,6 +3201,8 @@ struct hl_device {
 	u8				is_compute_ctx_active;
 	u8				compute_ctx_in_release;
 	u8				supports_mmu_prefetch;
+	u8				reset_upon_device_release;
+	u8				skip_iatu_for_unsecured_device;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -3212,11 +3216,9 @@ struct hl_device {
 	u8				dram_scrambler_enable;
 	u8				hard_reset_on_fw_events;
 	u8				bmc_enable;
-	u8				rl_enable;
 	u8				reset_on_preboot_fail;
-	u8				reset_upon_device_release;
-	u8				skip_iatu_for_unsecured_device;
 	u8				reset_if_device_not_idle;
+	u8				heartbeat;
 };
 
 
@@ -3451,6 +3453,7 @@ void hl_multi_cs_completion_init(struct hl_device *hdev);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
+void gaudi2_set_asic_funcs(struct hl_device *hdev);
 
 int hl_vm_ctx_init(struct hl_ctx *ctx);
 void hl_vm_ctx_fini(struct hl_ctx *ctx);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 3a41dbef14f8..e7179c7d957c 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -54,10 +54,15 @@ MODULE_PARM_DESC(boot_error_status_mask,
 #define PCI_IDS_GAUDI			0x1000
 #define PCI_IDS_GAUDI_SEC		0x1010
 
+#define PCI_IDS_GAUDI2			0x1020
+#define PCI_IDS_GAUDI2_SEC		0x1030
+
 static const struct pci_device_id ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI_SEC), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI2), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI2_SEC), },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, ids);
@@ -84,6 +89,12 @@ static enum hl_asic_type get_asic_type(u16 device)
 	case PCI_IDS_GAUDI_SEC:
 		asic_type = ASIC_GAUDI_SEC;
 		break;
+	case PCI_IDS_GAUDI2:
+		asic_type = ASIC_GAUDI2;
+		break;
+	case PCI_IDS_GAUDI2_SEC:
+		asic_type = ASIC_GAUDI2_SEC;
+		break;
 	default:
 		asic_type = ASIC_INVALID;
 		break;
@@ -96,6 +107,7 @@ static bool is_asic_secured(enum hl_asic_type asic_type)
 {
 	switch (asic_type) {
 	case ASIC_GAUDI_SEC:
+	case ASIC_GAUDI2_SEC:
 		return true;
 	default:
 		return false;
@@ -280,42 +292,61 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
-	hdev->pldm = 0;
+	hdev->nic_ports_mask = 0;
 	hdev->fw_components = FW_TYPE_ALL_TYPES;
+	hdev->mmu_enable = MMU_EN_ALL;
+	hdev->mmu_huge_page_opt = 1;
+	hdev->reset_pcilink = 0;
 	hdev->cpu_queues_enable = 1;
-	hdev->heartbeat = 1;
-	hdev->mmu_enable = 1;
+	hdev->pldm = 0;
 	hdev->sram_scrambler_enable = 1;
 	hdev->dram_scrambler_enable = 1;
-	hdev->bmc_enable = 1;
 	hdev->hard_reset_on_fw_events = 1;
+	hdev->bmc_enable = 1;
 	hdev->reset_on_preboot_fail = 1;
 	hdev->reset_if_device_not_idle = 1;
-
-	hdev->reset_pcilink = 0;
+	hdev->heartbeat = 1;
 }
 
 static void copy_kernel_module_params_to_device(struct hl_device *hdev)
 {
+	hdev->asic_prop.fw_security_enabled = is_asic_secured(hdev->asic_type);
+
 	hdev->major = hl_major;
 	hdev->memory_scrub = memory_scrub;
 	hdev->reset_on_lockup = reset_on_lockup;
 	hdev->boot_error_status_mask = boot_error_status_mask;
+}
 
-	if (timeout_locked)
-		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
-	else
-		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+static void fixup_device_params_per_asic(struct hl_device *hdev)
+{
+	switch (hdev->asic_type) {
+	case ASIC_GOYA:
+	case ASIC_GAUDI:
+	case ASIC_GAUDI_SEC:
+		hdev->reset_upon_device_release = 0;
+		break;
 
+	default:
+		hdev->reset_upon_device_release = 1;
+		break;
+	}
 }
 
 static int fixup_device_params(struct hl_device *hdev)
 {
-	hdev->asic_prop.fw_security_enabled = is_asic_secured(hdev->asic_type);
+	int tmp_timeout;
+
+	tmp_timeout = timeout_locked;
 
 	hdev->fw_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 	hdev->fw_comms_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 
+	if (tmp_timeout)
+		hdev->timeout_jiffies = msecs_to_jiffies(tmp_timeout * 1000);
+	else
+		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+
 	hdev->stop_on_err = true;
 	hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 	hdev->reset_info.prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
@@ -323,6 +354,18 @@ static int fixup_device_params(struct hl_device *hdev)
 	/* Enable only after the initialization of the device */
 	hdev->disabled = true;
 
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU) &&
+			(hdev->fw_components & ~FW_TYPE_PREBOOT_CPU)) {
+		pr_err("Preboot must be set along with other components");
+		return -EINVAL;
+	}
+
+	/* If CPU queues not enabled, no way to do heartbeat */
+	if (!hdev->cpu_queues_enable)
+		hdev->heartbeat = 0;
+
+	fixup_device_params_per_asic(hdev);
+
 	return 0;
 }
 
@@ -347,7 +390,7 @@ static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
 	if (!hdev)
 		return -ENOMEM;
 
-	/* can be NULL in case of simulator device */
+	/* Will be NULL in case of simulator device */
 	hdev->pdev = pdev;
 
 	/* Assign status description string */
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index da8181068895..edebdf960785 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -245,6 +245,12 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GAUDI_SEC:
 		str = "GAUDI SEC";
 		break;
+	case ASIC_GAUDI2:
+		str = "GAUDI2";
+		break;
+	case ASIC_GAUDI2_SEC:
+		str = "GAUDI2 SEC";
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 				hdev->asic_type);
-- 
2.25.1


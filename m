Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E855DDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbiF1LBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbiF1LA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122A25C4C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1816198C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A37AC341CA;
        Tue, 28 Jun 2022 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414025;
        bh=a5ok+JRrl6sywArxu7OC27wPoJb4OHdhYE547A4RN60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cD++b3+aX7xdeEzg3ITNs8nTfMEPUWMzGyY1Q5zF2eUl3btOVfESuAemOS8S9zZCC
         z/XNvCv5+2BmLBe2eAFXsyM4Hf1dm2vVWMOJHBcBBtZqTsmITFD5FiDwG+hAFp3LbQ
         zmOlu4RrxtVw3GEVjk0PunudnGgCDTEx4/F17xj04jgFjUyu+asTsFaAYmA3B/WACS
         xkoso8vT7TTxsrIA/fAfL3UopEtnJw4RMvcmg8jZm+/bapabByvqVhot9ad81Mhc26
         EDD0vuzF++0VwB9/p6oyuXTIaVSY9uFRL39n+GnD8wR8DAOvrqP/KnG9dB+E0Ma6ay
         3UQZ92VB6/klg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2 12/12] habanalabs: enable gaudi2 code in driver
Date:   Tue, 28 Jun 2022 13:59:58 +0300
Message-Id: <20220628105958.1254875-13-ogabbay@kernel.org>
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

Enable the Gaudi2 ASIC code in the pci probe callback of the driver so
the driver will handle Gaudi2 ASICs.

Add the PCI ID to the PCI table and add the ASIC enum value to all
relevant places.

Fixup the device parameters initialization for Gaudi2.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  8 +++
 drivers/misc/habanalabs/common/habanalabs.h   |  1 +
 .../misc/habanalabs/common/habanalabs_drv.c   | 56 ++++++++++++++++---
 drivers/misc/habanalabs/common/sysfs.c        |  6 ++
 4 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ff7634d32282..9f3778c82e54 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -644,6 +644,14 @@ static int device_early_init(struct hl_device *hdev)
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
index 0bea03a116fa..6f92e3088375 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3457,6 +3457,7 @@ void hl_multi_cs_completion_init(struct hl_device *hdev);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 void gaudi_set_asic_funcs(struct hl_device *hdev);
+void gaudi2_set_asic_funcs(struct hl_device *hdev);
 
 int hl_vm_ctx_init(struct hl_ctx *ctx);
 void hl_vm_ctx_fini(struct hl_ctx *ctx);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 7362387bdd80..d900bae86168 100644
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
@@ -282,7 +294,7 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
 	hdev->nic_ports_mask = 0;
 	hdev->fw_components = FW_TYPE_ALL_TYPES;
-	hdev->mmu_enable = 1;
+	hdev->mmu_enable = MMU_EN_ALL;
 	hdev->cpu_queues_enable = 1;
 	hdev->pldm = 0;
 	hdev->hard_reset_on_fw_events = 1;
@@ -293,25 +305,43 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 
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
@@ -319,6 +349,18 @@ static int fixup_device_params(struct hl_device *hdev)
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
 
@@ -343,7 +385,7 @@ static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
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


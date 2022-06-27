Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8355DC92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbiF0U06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiF0U0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE041A3BA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E8CEB81B1A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4791DC341CB;
        Mon, 27 Jun 2022 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361593;
        bh=gVNqTciQ2l7kS7TV6c0kv/EVdz65+DohfpzsJo2IAsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GE+TD9/2h4guWatQ2vrS8m+lNCi5rS6t7rIeeGDPzOAYwqo3ZPw2CUfS5O6H+Xc59
         ixfW49aiOAATNCYcCnVHgIWtSxFHSdwaXIz0vnniSjFP7X3n6uln2pNxdZj4DhOGdc
         oKbydPAdvT0wbAlt4Wk29LOQFGjgrkD+3foj4JdeHr2QsiUKQehLsyJIVXbsaIyAq5
         QLw1BUC8IXnoYGoxy7w79dOVYd67mmQH+y3ty3xHcxxpu/pfmvs5KWiLoaHGcwgj3j
         MLt2POn8aqocOF32j4ZGmAlK7timf6pQwVzvonzQvOWlBBMErgXBQ4UuzKzhLta9G7
         pnb3MYBiG8dAw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 03/12] habanalabs: add gaudi2 asic-specific code
Date:   Mon, 27 Jun 2022 23:26:11 +0300
Message-Id: <20220627202620.961350-4-ogabbay@kernel.org>
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

Add the ASIC-specific code for Gaudi2. Supply (almost) all of the
function callbacks that the driver's common code need to initialize,
finalize and submit workloads to the Gaudi2 ASIC.

It also contains the code to initialize the F/W of the Gaudi2 ASIC
and to receive events from the F/W.

It contains new debugfs entry to dump razwi events. razwi is a case
where the device's engines create a transaction that reaches an
invalid destination.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |   11 +-
 drivers/misc/habanalabs/Makefile              |    3 +
 drivers/misc/habanalabs/common/Makefile       |    3 +-
 .../habanalabs/common/command_submission.c    |    5 +-
 drivers/misc/habanalabs/common/context.c      |    3 +
 drivers/misc/habanalabs/common/debugfs.c      |   22 +
 drivers/misc/habanalabs/common/decoder.c      |  133 +
 drivers/misc/habanalabs/common/device.c       |   10 +
 drivers/misc/habanalabs/common/firmware_if.c  |   26 +
 drivers/misc/habanalabs/common/habanalabs.h   |  246 +-
 .../misc/habanalabs/common/habanalabs_drv.c   |    1 -
 .../misc/habanalabs/common/habanalabs_ioctl.c |    2 +-
 drivers/misc/habanalabs/common/irq.c          |   45 +-
 drivers/misc/habanalabs/common/pci/pci.c      |   14 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |    2 +-
 drivers/misc/habanalabs/gaudi2/Makefile       |    3 +
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 9761 +++++++++++++++++
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      |  534 +
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h |  135 +
 drivers/misc/habanalabs/goya/goya.c           |    2 +-
 .../misc/habanalabs/include/common/cpucp_if.h |  294 +-
 .../habanalabs/include/common/hl_boot_if.h    |    7 +
 22 files changed, 11167 insertions(+), 95 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/decoder.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/Makefile
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2P.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index deb66944cd0c..d9580f5d08a0 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -101,6 +101,15 @@ Description:    Specify the size of the DMA transaction when using DMA to read
                 When the write is finished, the user can read the "data_dma"
                 blob
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/dump_razwi_events
+Date:           Aug 2022
+KernelVersion:  5.20
+Contact:        fkassabri@habana.ai
+Description:    Dumps all razwi events to dmesg if exist.
+                After reading the status register of an existing event
+                the routine will clear the status register.
+                Usage: cat dump_razwi_events
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/dump_security_violations
 Date:           Jan 2021
 KernelVersion:  5.12
@@ -278,7 +287,7 @@ Description:    Displays a list with information about the currently user
                 to DMA addresses
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/userptr_lookup
-Date:           Aug 2021
+Date:           Oct 2021
 KernelVersion:  5.15
 Contact:        ogabbay@kernel.org
 Description:    Allows to search for specific user pointers (user virtual
diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index a786c0a7de9a..b35d7000c86b 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -14,4 +14,7 @@ habanalabs-y += $(HL_GOYA_FILES)
 include $(src)/gaudi/Makefile
 habanalabs-y += $(HL_GAUDI_FILES)
 
+include $(src)/gaudi2/Makefile
+habanalabs-y += $(HL_GAUDI2_FILES)
+
 habanalabs-$(CONFIG_DEBUG_FS) += common/debugfs.o
diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 934a3a4aedc9..2bc022552acf 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -11,4 +11,5 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
 		common/command_submission.o common/firmware_if.o \
-		common/state_dump.o common/memory_mgr.o
+		common/state_dump.o common/memory_mgr.o \
+		common/decoder.o
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 5130a63e49cf..3805c6d6b65c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -3334,9 +3334,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	interrupt_id = FIELD_GET(HL_WAIT_CS_FLAGS_INTERRUPT_MASK, args->in.flags);
 
-	first_interrupt = prop->first_available_user_msix_interrupt;
-	last_interrupt = prop->first_available_user_msix_interrupt +
-						prop->user_interrupt_count - 1;
+	first_interrupt = prop->first_available_user_interrupt;
+	last_interrupt = prop->first_available_user_interrupt + prop->user_interrupt_count - 1;
 
 	if ((interrupt_id < first_interrupt || interrupt_id > last_interrupt) &&
 			interrupt_id != HL_COMMON_USER_INTERRUPT_ID) {
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index a69c14405f41..2f4620b7990c 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -102,6 +102,9 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 			hl_device_set_debug_mode(hdev, ctx, false);
 
 		hdev->asic_funcs->ctx_fini(ctx);
+
+		hl_dec_ctx_fini(ctx);
+
 		hl_cb_va_pool_fini(ctx);
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index aaf5235a58d5..831b050a1bf0 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1348,6 +1348,17 @@ static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_check_razwi_happened(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+
+	hdev->asic_funcs->check_if_razwi_happened(hdev);
+
+	return 0;
+}
+
 static const struct file_operations hl_mem_scrub_fops = {
 	.owner = THIS_MODULE,
 	.write = hl_memory_scrub,
@@ -1437,6 +1448,11 @@ static const struct file_operations hl_timeout_locked_fops = {
 	.write = hl_timeout_locked_write
 };
 
+static const struct file_operations hl_razwi_check_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_check_razwi_happened
+};
+
 static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_buffers", command_buffers_show, NULL},
 	{"command_submission", command_submission_show, NULL},
@@ -1614,6 +1630,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_security_violations_fops);
 
+	debugfs_create_file("dump_razwi_events",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_razwi_check_fops);
+
 	debugfs_create_file("dma_size",
 				0200,
 				dev_entry->root,
diff --git a/drivers/misc/habanalabs/common/decoder.c b/drivers/misc/habanalabs/common/decoder.c
new file mode 100644
index 000000000000..2aab14d74b53
--- /dev/null
+++ b/drivers/misc/habanalabs/common/decoder.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#define VCMD_CONTROL_OFFSET			0x40	/* SWREG16 */
+#define VCMD_IRQ_STATUS_OFFSET			0x44	/* SWREG17 */
+
+#define VCMD_IRQ_STATUS_ENDCMD_MASK		0x1
+#define VCMD_IRQ_STATUS_BUSERR_MASK		0x2
+#define VCMD_IRQ_STATUS_TIMEOUT_MASK		0x4
+#define VCMD_IRQ_STATUS_CMDERR_MASK		0x8
+#define VCMD_IRQ_STATUS_ABORT_MASK		0x10
+#define VCMD_IRQ_STATUS_RESET_MASK		0x20
+
+static void dec_print_abnrm_intr_source(struct hl_device *hdev, u32 irq_status)
+{
+	const char *format = "abnormal interrupt source:%s%s%s%s%s%s\n";
+	char *intr_source[6] = {"Unknown", "", "", "", "", ""};
+	int i = 0;
+
+	if (!irq_status)
+		return;
+
+	if (irq_status & VCMD_IRQ_STATUS_ENDCMD_MASK)
+		intr_source[i++] = " ENDCMD";
+	if (irq_status & VCMD_IRQ_STATUS_BUSERR_MASK)
+		intr_source[i++] = " BUSERR";
+	if (irq_status & VCMD_IRQ_STATUS_TIMEOUT_MASK)
+		intr_source[i++] = " TIMEOUT";
+	if (irq_status & VCMD_IRQ_STATUS_CMDERR_MASK)
+		intr_source[i++] = " CMDERR";
+	if (irq_status & VCMD_IRQ_STATUS_ABORT_MASK)
+		intr_source[i++] = " ABORT";
+	if (irq_status & VCMD_IRQ_STATUS_RESET_MASK)
+		intr_source[i++] = " RESET";
+
+	dev_err(hdev->dev, format, intr_source[0], intr_source[1],
+		intr_source[2], intr_source[3], intr_source[4], intr_source[5]);
+}
+
+static void dec_error_intr_work(struct hl_device *hdev, u32 base_addr, u32 core_id)
+{
+	bool reset_required = false;
+	u32 irq_status;
+
+	irq_status = RREG32(base_addr + VCMD_IRQ_STATUS_OFFSET);
+
+	dev_err(hdev->dev, "Decoder abnormal interrupt %#x, core %d\n", irq_status, core_id);
+
+	dec_print_abnrm_intr_source(hdev, irq_status);
+
+	if (irq_status & VCMD_IRQ_STATUS_TIMEOUT_MASK)
+		reset_required = true;
+
+	/* Clear the interrupt */
+	WREG32(base_addr + VCMD_IRQ_STATUS_OFFSET, irq_status);
+
+	/* Flush the interrupt clear */
+	RREG32(base_addr + VCMD_IRQ_STATUS_OFFSET);
+
+	if (reset_required)
+		hl_device_reset(hdev, HL_DRV_RESET_HARD);
+}
+
+static void dec_completion_abnrm(struct work_struct *work)
+{
+	struct hl_dec *dec = container_of(work, struct hl_dec, completion_abnrm_work);
+	struct hl_device *hdev = dec->hdev;
+
+	dec_error_intr_work(hdev, dec->base_addr, dec->core_id);
+}
+
+void hl_dec_fini(struct hl_device *hdev)
+{
+	kfree(hdev->dec);
+}
+
+int hl_dec_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_dec *dec;
+	int rc, j;
+
+	/* if max core is 0, nothing to do*/
+	if (!prop->max_dec)
+		return 0;
+
+	hdev->dec = kcalloc(prop->max_dec, sizeof(struct hl_dec), GFP_KERNEL);
+	if (!hdev->dec)
+		return -ENOMEM;
+
+	for (j = 0 ; j < prop->max_dec ; j++) {
+		dec = hdev->dec + j;
+
+		dec->hdev = hdev;
+		INIT_WORK(&dec->completion_abnrm_work, dec_completion_abnrm);
+		dec->core_id = j;
+		dec->base_addr = hdev->asic_funcs->get_dec_base_addr(hdev, j);
+		if (!dec->base_addr) {
+			dev_err(hdev->dev, "Invalid base address of decoder %d\n", j);
+			rc = -EINVAL;
+			goto err_dec_fini;
+		}
+	}
+
+	return 0;
+
+err_dec_fini:
+	hl_dec_fini(hdev);
+
+	return rc;
+}
+
+void hl_dec_ctx_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_dec *dec;
+	int j;
+
+	for (j = 0 ; j < prop->max_dec ; j++) {
+		if (!!(prop->decoder_enabled_mask & BIT(j))) {
+			dec = hdev->dec + j;
+			/* Stop the decoder */
+			WREG32(dec->base_addr + VCMD_CONTROL_OFFSET, 0);
+		}
+	}
+}
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index adf0ff26636c..5b345fc3dcc1 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1822,6 +1822,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto release_ctx;
 	}
 
+	rc = hl_dec_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize the decoder module\n");
+		goto cb_pool_fini;
+	}
+
 	/*
 	 * From this point, override rc (=0) in case of an error to allow
 	 * debugging (by adding char devices and create sysfs nodes as part of
@@ -1915,6 +1921,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	return 0;
 
+cb_pool_fini:
+	hl_cb_pool_fini(hdev);
 release_ctx:
 	if (hl_ctx_put(hdev->kernel_ctx) != 1)
 		dev_err(hdev->dev,
@@ -2065,6 +2073,8 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_debugfs_remove_device(hdev);
 
+	hl_dec_fini(hdev);
+
 	hl_vm_fini(hdev);
 
 	hl_mmu_fini(hdev);
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cb89d8423f9e..9f0a24ee5af4 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -15,6 +15,14 @@
 
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
+struct fw_binning_conf {
+	u64 tpc_binning;
+	u32 dec_binning;
+	u32 hbm_binning;
+	u32 edma_binning;
+	u32 mme_redundancy;
+};
+
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
 	char *str, *fw_ver, *whitespace;
@@ -523,6 +531,11 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		err_val &= ~CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL;
 	}
 
+	if (err_val & CPU_BOOT_ERR0_BINNING_FAIL) {
+		dev_err(hdev->dev, "Device boot error - binning failure\n");
+		err_exists = true;
+	}
+
 	if (sts_val & CPU_BOOT_DEV_STS0_ENABLED)
 		dev_dbg(hdev->dev, "Device status0 %#x\n", sts_val);
 
@@ -2359,6 +2372,19 @@ static int hl_fw_dynamic_send_msg(struct hl_device *hdev,
 	case HL_COMMS_RESET_CAUSE_TYPE:
 		msg.reset_cause = *(__u8 *) data;
 		break;
+
+	case HL_COMMS_BINNING_CONF_TYPE:
+	{
+		struct fw_binning_conf *binning_conf = (struct fw_binning_conf *) data;
+
+		msg.tpc_binning_conf = cpu_to_le64(binning_conf->tpc_binning);
+		msg.dec_binning_conf = cpu_to_le32(binning_conf->dec_binning);
+		msg.hbm_binning_conf = cpu_to_le32(binning_conf->hbm_binning);
+		msg.edma_binning_conf = cpu_to_le32(binning_conf->edma_binning);
+		msg.mme_redundancy_conf = cpu_to_le32(binning_conf->mme_redundancy);
+		break;
+	}
+
 	default:
 		dev_err(hdev->dev,
 			"Send COMMS message - invalid message type %u\n",
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c7401b524aed..0108cd3977fa 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -31,6 +31,9 @@
 
 #define HL_NAME				"habanalabs"
 
+struct hl_device;
+struct hl_fpriv;
+
 /* Use upper bits of mmap offset to store habana driver specific information.
  * bits[63:59] - Encode mmap type
  * bits[45:0]  - mmap offset value
@@ -69,7 +72,9 @@
 
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
-#define HL_SIM_MAX_TIMEOUT_US		10000000 /* 10s */
+#define HL_SIM_MAX_TIMEOUT_US		100000000 /* 100s */
+
+#define HL_INVALID_QUEUE		UINT_MAX
 
 #define HL_COMMON_USER_INTERRUPT_ID	0xFFF
 
@@ -118,7 +123,12 @@ enum hl_mmu_page_table_location {
 
 #define HL_PCI_NUM_BARS			6
 
-#define HL_MAX_DCORES			4
+/* Completion queue entry relates to completed job */
+#define HL_COMPLETION_MODE_JOB		0
+/* Completion queue entry relates to completed command submission */
+#define HL_COMPLETION_MODE_CS		1
+
+#define HL_MAX_DCORES			8
 
 /*
  * Reset Flags
@@ -159,6 +169,31 @@ enum hl_mmu_page_table_location {
 #define HL_DRV_RESET_FW_FATAL_ERR	(1 << 6)
 #define HL_DRV_RESET_DELAY		(1 << 7)
 
+/*
+ * Security
+ */
+
+#define HL_BLOCK_SIZE		0x1000
+
+/**
+ * struct iterate_module_ctx - HW module iterator
+ * @fn: function to apply to each HW module instance
+ * @data: optional internal data to the function iterator
+ */
+struct iterate_module_ctx {
+	/*
+	 * callback for the HW module iterator
+	 * @hdev: pointer to the habanalabs device structure
+	 * @block: block (ASIC specific definition can be dcore/hdcore)
+	 * @inst: HW module instance within the block
+	 * @offset: current HW module instance offset from the 1-st HW module instance
+	 *          in the 1-st block
+	 * @data: function specific data
+	 */
+	void (*fn)(struct hl_device *hdev, int block, int inst, u32 offset, void *data);
+	void *data;
+};
+
 #define HL_MAX_SOBS_PER_MONITOR	8
 
 /**
@@ -202,9 +237,6 @@ struct pgt_info {
 	int			num_of_ptes;
 };
 
-struct hl_device;
-struct hl_fpriv;
-
 /**
  * enum hl_pci_match_mode - pci match mode per region
  * @PCI_ADDRESS_MATCH_MODE: address match mode
@@ -337,21 +369,23 @@ enum hl_collective_mode {
 /**
  * struct hw_queue_properties - queue information.
  * @type: queue type.
- * @queue_cb_alloc_flags: bitmap which indicates if the hw queue supports CB
- *                        that allocated by the Kernel driver and therefore,
- *                        a CB handle can be provided for jobs on this queue.
- *                        Otherwise, a CB address must be provided.
+ * @cb_alloc_flags: bitmap which indicates if the hw queue supports CB
+ *                  that allocated by the Kernel driver and therefore,
+ *                  a CB handle can be provided for jobs on this queue.
+ *                  Otherwise, a CB address must be provided.
  * @collective_mode: collective mode of current queue
  * @driver_only: true if only the driver is allowed to send a job to this queue,
  *               false otherwise.
+ * @binned: True if the queue is binned out and should not be used
  * @supports_sync_stream: True if queue supports sync stream
  */
 struct hw_queue_properties {
-	enum hl_queue_type	type;
-	enum queue_cb_alloc_flags cb_alloc_flags;
-	enum hl_collective_mode	collective_mode;
-	u8			driver_only;
-	u8			supports_sync_stream;
+	enum hl_queue_type		type;
+	enum queue_cb_alloc_flags	cb_alloc_flags;
+	enum hl_collective_mode		collective_mode;
+	u8				driver_only;
+	u8				binned;
+	u8				supports_sync_stream;
 };
 
 /**
@@ -458,7 +492,7 @@ struct hl_hints_range {
  * @dram_user_base_address: DRAM physical start address for user access.
  * @dram_size: DRAM total size.
  * @dram_pci_bar_size: size of PCI bar towards DRAM.
- * @max_power_default: max power of the device after reset
+ * @max_power_default: max power of the device after reset.
  * @dc_power_default: power consumed by the device in mode idle.
  * @dram_size_for_default_page_mapping: DRAM size needed to map to avoid page
  *                                      fault.
@@ -466,12 +500,19 @@ struct hl_hints_range {
  * @pcie_aux_dbi_reg_addr: Address of the PCIE_AUX DBI register.
  * @mmu_pgt_addr: base physical address in DRAM of MMU page tables.
  * @mmu_dram_default_page_addr: DRAM default page physical address.
+ * @tpc_enabled_mask: which TPCs are enabled.
+ * @tpc_binning_mask: which TPCs are binned. 0 means usable and 1 means binned.
+ * @dram_enabled_mask: which DRAMs are enabled.
+ * @dram_binning_mask: which DRAMs are binned. 0 means usable, 1 means binned.
  * @cb_va_start_addr: virtual start address of command buffers which are mapped
  *                    to the device's MMU.
  * @cb_va_end_addr: virtual end address of command buffers which are mapped to
  *                  the device's MMU.
  * @dram_hints_align_mask: dram va hint addresses alignment mask which is used
  *                  for hints validity check.
+ * @cfg_base_address: config space base address.
+ * @mmu_cache_mng_addr: address of the MMU cache.
+ * @mmu_cache_mng_size: size of the MMU cache.
  * @device_dma_offset_for_host_access: the offset to add to host DMA addresses
  *                                     to enable the device to access them.
  * @host_base_address: host physical start address for host DMA from device
@@ -496,6 +537,12 @@ struct hl_hints_range {
  * @high_pll: high PLL frequency used by the device.
  * @cb_pool_cb_cnt: number of CBs in the CB pool.
  * @cb_pool_cb_size: size of each CB in the CB pool.
+ * @decoder_enabled_mask: which decoders are enabled.
+ * @decoder_binning_mask: which decoders are binned, 0 means usable and 1
+ *                        means binned (at most one binned decoder per dcore).
+ * @edma_enabled_mask: which EDMAs are enabled.
+ * @edma_binning_mask: which EDMAs are binned, 0 means usable and 1 means
+ *                     binned (at most one binned DMA).
  * @max_pending_cs: maximum of concurrent pending command submissions
  * @max_queues: maximum amount of queues in the system
  * @fw_preboot_cpu_boot_dev_sts0: bitmap representation of preboot cpu
@@ -516,6 +563,13 @@ struct hl_hints_range {
  * @fw_app_cpu_boot_dev_sts1: bitmap representation of application security
  *                            status reported by FW, bit description can be
  *                            found in CPU_BOOT_DEV_STS1
+ * @max_dec: maximum number of decoders
+ * @hmmu_hif_enabled_mask: mask of HMMUs/HIFs that are not isolated (enabled)
+ *                         1- enabled, 0- isolated.
+ * @faulty_dram_cluster_map: mask of faulty DRAM cluster.
+ *                         1- faulty cluster, 0- good cluster.
+ * @xbar_edge_enabled_mask: mask of XBAR_EDGEs that are not isolated (enabled)
+ *                          1- enabled, 0- isolated.
  * @device_mem_alloc_default_page_size: may be different than dram_page_size only for ASICs for
  *                                      which the property supports_user_set_page_size is true
  *                                      (i.e. the DRAM supports multiple page sizes), otherwise
@@ -526,14 +580,17 @@ struct hl_hints_range {
  * @sync_stream_first_mon: first monitor available for sync stream use
  * @first_available_user_sob: first sob available for the user
  * @first_available_user_mon: first monitor available for the user
- * @first_available_user_msix_interrupt: first available msix interrupt
- *                                       reserved for the user
+ * @first_available_user_interrupt: first available interrupt reserved for the user
  * @first_available_cq: first available CQ for the user.
  * @user_interrupt_count: number of user interrupts.
+ * @user_dec_intr_count: number of decoder interrupts exposed to user.
+ * @cache_line_size: device cache line size.
  * @server_type: Server type that the ASIC is currently installed in.
  *               The value is according to enum hl_server_type in uapi file.
- * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
+ * @completion_mode: 0 - job based completion, 1 - cs based completion
+ * @mme_master_slave_mode: 0 - Each MME works independently, 1 - MME works
+ *                         in Master/Slave mode
  * @fw_security_enabled: true if security measures are enabled in firmware,
  *                       false otherwise
  * @fw_cpu_boot_dev_sts0_valid: status bits are valid and can be fetched from
@@ -588,9 +645,16 @@ struct asic_fixed_properties {
 	u64				pcie_aux_dbi_reg_addr;
 	u64				mmu_pgt_addr;
 	u64				mmu_dram_default_page_addr;
+	u64				tpc_enabled_mask;
+	u64				tpc_binning_mask;
+	u64				dram_enabled_mask;
+	u64				dram_binning_mask;
 	u64				cb_va_start_addr;
 	u64				cb_va_end_addr;
 	u64				dram_hints_align_mask;
+	u64				cfg_base_address;
+	u64				mmu_cache_mng_addr;
+	u64				mmu_cache_mng_size;
 	u64				device_dma_offset_for_host_access;
 	u64				host_base_address;
 	u64				host_end_address;
@@ -613,6 +677,10 @@ struct asic_fixed_properties {
 	u32				high_pll;
 	u32				cb_pool_cb_cnt;
 	u32				cb_pool_cb_size;
+	u32				decoder_enabled_mask;
+	u32				decoder_binning_mask;
+	u32				edma_enabled_mask;
+	u32				edma_binning_mask;
 	u32				max_pending_cs;
 	u32				max_queues;
 	u32				fw_preboot_cpu_boot_dev_sts0;
@@ -621,6 +689,10 @@ struct asic_fixed_properties {
 	u32				fw_bootfit_cpu_boot_dev_sts1;
 	u32				fw_app_cpu_boot_dev_sts0;
 	u32				fw_app_cpu_boot_dev_sts1;
+	u32				max_dec;
+	u32				hmmu_hif_enabled_mask;
+	u32				faulty_dram_cluster_map;
+	u32				xbar_edge_enabled_mask;
 	u32				device_mem_alloc_default_page_size;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
@@ -628,12 +700,15 @@ struct asic_fixed_properties {
 	u16				sync_stream_first_mon;
 	u16				first_available_user_sob[HL_MAX_DCORES];
 	u16				first_available_user_mon[HL_MAX_DCORES];
-	u16				first_available_user_msix_interrupt;
+	u16				first_available_user_interrupt;
 	u16				first_available_cq[HL_MAX_DCORES];
 	u16				user_interrupt_count;
+	u16				user_dec_intr_count;
+	u16				cache_line_size;
 	u16				server_type;
-	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
+	u8				completion_mode;
+	u8				mme_master_slave_mode;
 	u8				fw_security_enabled;
 	u8				fw_cpu_boot_dev_sts0_valid;
 	u8				fw_cpu_boot_dev_sts1_valid;
@@ -814,7 +889,6 @@ struct hl_cb {
  * QUEUES
  */
 
-struct hl_cs;
 struct hl_cs_job;
 
 /* Queue length of external and HW queues */
@@ -937,12 +1011,14 @@ struct hl_cq {
  * @wait_list_head: head to the list of user threads pending on this interrupt
  * @wait_list_lock: protects wait_list_head
  * @interrupt_id: msix interrupt id
+ * @is_decoder: whether this entry represents a decoder interrupt
  */
 struct hl_user_interrupt {
 	struct hl_device	*hdev;
 	struct list_head	wait_list_head;
 	spinlock_t		wait_list_lock;
 	u32			interrupt_id;
+	bool			is_decoder;
 };
 
 /**
@@ -1028,23 +1104,36 @@ struct hl_eq {
 	bool			check_eqe_index;
 };
 
-
-/*
- * ASICs
+/**
+ * struct hl_dec - describes a decoder sw instance.
+ * @hdev: pointer to the device structure.
+ * @completion_abnrm_work: workqueue object to run when decoder generates an error interrupt
+ * @core_id: ID of the decoder.
+ * @base_addr: base address of the decoder.
  */
+struct hl_dec {
+	struct hl_device		*hdev;
+	struct work_struct		completion_abnrm_work;
+	u32				core_id;
+	u32				base_addr;
+};
 
 /**
  * enum hl_asic_type - supported ASIC types.
  * @ASIC_INVALID: Invalid ASIC type.
- * @ASIC_GOYA: Goya device.
- * @ASIC_GAUDI: Gaudi device.
+ * @ASIC_GOYA: Goya device (HL-1000).
+ * @ASIC_GAUDI: Gaudi device (HL-2000).
  * @ASIC_GAUDI_SEC: Gaudi secured device (HL-2000).
+ * @ASIC_GAUDI2: Gaudi2 device.
+ * @ASIC_GAUDI2_SEC: Gaudi2 secured device.
  */
 enum hl_asic_type {
 	ASIC_INVALID,
 	ASIC_GOYA,
 	ASIC_GAUDI,
-	ASIC_GAUDI_SEC
+	ASIC_GAUDI_SEC,
+	ASIC_GAUDI2,
+	ASIC_GAUDI2_SEC,
 };
 
 struct hl_cs_parser;
@@ -1220,6 +1309,8 @@ struct fw_load_mgr {
 	u8 fw_comp_loaded;
 };
 
+struct hl_cs;
+
 /**
  * struct hl_asic_funcs - ASIC specific functions that are can be called from
  *                        common code.
@@ -1260,6 +1351,8 @@ struct fw_load_mgr {
  * @asic_dma_pool_free: free small DMA allocation from pool.
  * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
  * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
+ * @asic_dma_unmap_single: unmap a single DMA buffer
+ * @asic_dma_map_single: map a single buffer to a DMA
  * @hl_dma_unmap_sgtable: DMA unmap scatter-gather table.
  * @cs_parser: parse Command Submission.
  * @asic_dma_map_sgtable: DMA map scatter-gather table.
@@ -1284,6 +1377,8 @@ struct fw_load_mgr {
  * @non_hard_reset_late_init: perform certain actions needed after a reset which is not hard-reset
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
+ * @kdma_lock: acquire H/W queues lock. Relevant from GRECO ASIC
+ * @kdma_unlock: release H/W queues lock. Relevant from GRECO ASIC
  * @get_pci_id: retrieve PCI ID.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @get_monitor_dump: retrieve monitor registers dump from F/W.
@@ -1300,6 +1395,7 @@ struct fw_load_mgr {
  * @halt_coresight: stop the ETF and ETR traces.
  * @ctx_init: context dependent initialization.
  * @ctx_fini: context dependent cleanup.
+ * @pre_schedule_cs: Perform pre-CS-scheduling operations.
  * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
  * @load_firmware_to_device: load the firmware to the device's memory
  * @load_boot_fit_to_device: load boot fit to device's memory
@@ -1310,9 +1406,11 @@ struct fw_load_mgr {
  * @reset_sob: Reset a SOB.
  * @reset_sob_group: Reset SOB group
  * @get_device_time: Get the device time.
+ * @pb_print_security_errors: print security errors according block and cause
  * @collective_wait_init_cs: Generate collective master/slave packets
  *                           and place them in the relevant cs jobs
  * @collective_wait_create_jobs: allocate collective wait cs jobs
+ * @get_dec_base_addr: get the base address of a given decoder.
  * @scramble_addr: Routine to scramble the address prior of mapping it
  *                 in the MMU.
  * @descramble_addr: Routine to de-scramble the address prior of
@@ -1326,6 +1424,7 @@ struct fw_load_mgr {
  *                         driver is ready to receive asynchronous events. This
  *                         function should be called during the first init and
  *                         after every hard-reset of the device
+ * @ack_mmu_errors: check and ack mmu errors, page fault, access violation.
  * @get_msi_info: Retrieve asic-specific MSI ID of the f/w async event
  * @map_pll_idx_to_fw_idx: convert driver specific per asic PLL index to
  *                         generic f/w compatible PLL Indexes
@@ -1335,6 +1434,7 @@ struct fw_load_mgr {
  * @get_sob_addr: get SOB base address offset.
  * @set_pci_memory_regions: setting properties of PCI memory regions
  * @get_stream_master_qid_arr: get pointer to stream masters QID array
+ * @check_if_razwi_happened: check if there was a razwi due to RR violation.
  * @access_dev_mem: access device memory
  * @set_dram_bar_base: set the base of the DRAM BAR
  */
@@ -1372,6 +1472,12 @@ struct hl_asic_funcs {
 				size_t size, dma_addr_t *dma_handle);
 	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
 				size_t size, void *vaddr);
+	void (*asic_dma_unmap_single)(struct hl_device *hdev,
+				dma_addr_t dma_addr, int len,
+				enum dma_data_direction dir);
+	dma_addr_t (*asic_dma_map_single)(struct hl_device *hdev,
+				void *addr, int len,
+				enum dma_data_direction dir);
 	void (*hl_dma_unmap_sgtable)(struct hl_device *hdev,
 				struct sg_table *sgt,
 				enum dma_data_direction dir);
@@ -1408,6 +1514,8 @@ struct hl_asic_funcs {
 	int (*non_hard_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
+	void (*kdma_lock)(struct hl_device *hdev, int dcore_id);
+	void (*kdma_unlock)(struct hl_device *hdev, int dcore_id);
 	u32 (*get_pci_id)(struct hl_device *hdev);
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data, size_t max_size);
 	int (*get_monitor_dump)(struct hl_device *hdev, void *data);
@@ -1420,6 +1528,7 @@ struct hl_asic_funcs {
 	void (*halt_coresight)(struct hl_device *hdev, struct hl_ctx *ctx);
 	int (*ctx_init)(struct hl_ctx *ctx);
 	void (*ctx_fini)(struct hl_ctx *ctx);
+	int (*pre_schedule_cs)(struct hl_cs *cs);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	int (*load_boot_fit_to_device)(struct hl_device *hdev);
@@ -1432,11 +1541,14 @@ struct hl_asic_funcs {
 	void (*reset_sob)(struct hl_device *hdev, void *data);
 	void (*reset_sob_group)(struct hl_device *hdev, u16 sob_group);
 	u64 (*get_device_time)(struct hl_device *hdev);
+	void (*pb_print_security_errors)(struct hl_device *hdev,
+			u32 block_addr, u32 cause, u32 offended_addr);
 	int (*collective_wait_init_cs)(struct hl_cs *cs);
 	int (*collective_wait_create_jobs)(struct hl_device *hdev,
 			struct hl_ctx *ctx, struct hl_cs *cs,
 			u32 wait_queue_id, u32 collective_engine_id,
 			u32 encaps_signal_offset);
+	u32 (*get_dec_base_addr)(struct hl_device *hdev, u32 core_id);
 	u64 (*scramble_addr)(struct hl_device *hdev, u64 addr);
 	u64 (*descramble_addr)(struct hl_device *hdev, u64 addr);
 	void (*ack_protection_bits_errors)(struct hl_device *hdev);
@@ -1445,6 +1557,7 @@ struct hl_asic_funcs {
 	int (*hw_block_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u32 block_id, u32 block_size);
 	void (*enable_events_from_fw)(struct hl_device *hdev);
+	int (*ack_mmu_errors)(struct hl_device *hdev, u64 mmu_cap_mask);
 	void (*get_msi_info)(__le32 *table);
 	int (*map_pll_idx_to_fw_idx)(u32 pll_idx);
 	void (*init_firmware_loader)(struct hl_device *hdev);
@@ -1453,6 +1566,7 @@ struct hl_asic_funcs {
 	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
 	void (*set_pci_memory_regions)(struct hl_device *hdev);
 	u32* (*get_stream_master_qid_arr)(void);
+	void (*check_if_razwi_happened)(struct hl_device *hdev);
 	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
 					u32 page_size, u32 *real_page_size, bool is_dram_addr);
 	int (*access_dev_mem)(struct hl_device *hdev, enum pci_region region_type,
@@ -1698,6 +1812,7 @@ struct hl_userptr {
  * @timeout_jiffies: cs timeout in jiffies.
  * @submission_time_jiffies: submission time of the cs
  * @type: CS_TYPE_*.
+ * @jobs_cnt: counter of submitted jobs on all queues.
  * @encaps_sig_hdl_id: encaps signals handle id, set for the first staged cs.
  * @sob_addr_offset: sob offset from the configuration base address.
  * @initial_sob_count: count of completed signals in SOB before current submission of signal or
@@ -1736,6 +1851,7 @@ struct hl_cs {
 	u64			timeout_jiffies;
 	u64			submission_time_jiffies;
 	enum hl_cs_type		type;
+	u32			jobs_cnt;
 	u32			encaps_sig_hdl_id;
 	u32			sob_addr_offset;
 	u16			initial_sob_count;
@@ -2333,7 +2449,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 		__timeout = ktime_add_us(ktime_get(), timeout_us); \
 	else \
 		__timeout = ktime_add_us(ktime_get(),\
-				min((u64)(timeout_us * 10), \
+				min((u64)(timeout_us * 100), \
 					(u64) HL_SIM_MAX_TIMEOUT_US)); \
 	might_sleep_if(sleep_us); \
 	for (;;) { \
@@ -2381,6 +2497,23 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	(cond) ? 0 : -ETIMEDOUT; \
 })
 
+#define HL_USR_MAPPED_BLK_INIT(blk, base, sz) \
+({ \
+	struct user_mapped_block *p = blk; \
+\
+	p->address = base; \
+	p->size = sz; \
+})
+
+#define HL_USR_INTR_STRUCT_INIT(usr_intr, hdev, intr_id, decoder) \
+({ \
+	usr_intr.hdev = hdev; \
+	usr_intr.interrupt_id = intr_id; \
+	usr_intr.is_decoder = decoder; \
+	INIT_LIST_HEAD(&usr_intr.wait_list_head); \
+	spin_lock_init(&usr_intr.wait_list_lock); \
+})
+
 struct hwmon_chip_info;
 
 /**
@@ -2397,28 +2530,16 @@ struct hl_device_reset_work {
 	u32				flags;
 };
 
-/**
- * struct hr_mmu_hop_addrs - used for holding per-device host-resident mmu hop
- * information.
- * @virt_addr: the virtual address of the hop.
- * @phys-addr: the physical address of the hop (used by the device-mmu).
- * @shadow_addr: The shadow of the hop used by the driver for walking the hops.
- */
-struct hr_mmu_hop_addrs {
-	u64 virt_addr;
-	u64 phys_addr;
-	u64 shadow_addr;
-};
-
 /**
  * struct hl_mmu_hr_pgt_priv - used for holding per-device mmu host-resident
  * page-table internal information.
- * @mmu_pgt_pool: pool of page tables used by MMU for allocating hops.
- * @mmu_shadow_hop0: shadow array of hop0 tables.
+ * @mmu_pgt_pool: pool of page tables used by a host-resident MMU for
+ *                allocating hops.
+ * @mmu_asid_hop0: per-ASID array of host-resident hop0 tables.
  */
 struct hl_mmu_hr_priv {
-	struct gen_pool *mmu_pgt_pool;
-	struct hr_mmu_hop_addrs *mmu_shadow_hop0;
+	struct gen_pool	*mmu_pgt_pool;
+	struct pgt_info	*mmu_asid_hop0;
 };
 
 /**
@@ -2601,6 +2722,16 @@ struct hl_clk_throttle {
 	u32		aggregated_reason;
 };
 
+/**
+ * struct user_mapped_block - describes a hw block allowed to be mmapped by user
+ * @address: physical HW block address
+ * @size: allowed size for mmap
+ */
+struct user_mapped_block {
+	u32 address;
+	u32 size;
+};
+
 /**
  * struct cs_timeout_info - info of last CS timeout occurred.
  * @timestamp: CS timeout timestamp.
@@ -2784,6 +2915,7 @@ struct hl_reset_info {
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
+ * @dec: list of decoder sw instance
  * @fw_loader: FW loader manager.
  * @pci_mem_region: array of memory regions in the PCI
  * @state_dump_specs: constants and dictionaries needed to dump system state.
@@ -2816,10 +2948,18 @@ struct hl_reset_info {
  *                         used for CPU boot status
  * @fw_comms_poll_interval_usec: FW comms/protocol poll interval in usec.
  *                                  used for COMMs protocols cmds(COMMS_STS_*)
+ * @dram_binning: contains mask of drams that is received from the f/w which indicates which
+ *                drams are binned-out
+ * @tpc_binning: contains mask of tpc engines that is received from the f/w which indicates which
+ *               tpc engines are binned-out
  * @card_type: Various ASICs have several card types. This indicates the card
  *             type of the current device.
  * @major: habanalabs kernel driver major.
  * @high_pll: high PLL profile frequency.
+ * @decoder_binning: contains mask of decoder engines that is received from the f/w which
+ *                   indicates which decoder engines are binned-out
+ * @edma_binning: contains mask of edma engines that is received from the f/w which
+ *                   indicates which edma engines are binned-out
  * @id: device minor.
  * @id_control: minor of the control device
  * @cpu_pci_msb_addr: 50-bit extension bits for the device CPU's 40-bit
@@ -2924,6 +3064,8 @@ struct hl_device {
 	struct hl_mmu_priv		mmu_priv;
 	struct hl_mmu_funcs		mmu_func[MMU_NUM_PGT_LOCATIONS];
 
+	struct hl_dec			*dec;
+
 	struct fw_load_mgr		fw_loader;
 
 	struct pci_mem_region		pci_mem_region[PCI_REGION_NUMBER];
@@ -2951,10 +3093,14 @@ struct hl_device {
 	u64				fw_poll_interval_usec;
 	ktime_t				last_successful_open_ktime;
 	u64				fw_comms_poll_interval_usec;
+	u64				dram_binning;
+	u64				tpc_binning;
 
 	enum cpucp_card_types		card_type;
 	u32				major;
 	u32				high_pll;
+	u32				decoder_binning;
+	u32				edma_binning;
 	u16				id;
 	u16				id_control;
 	u16				cpu_pci_msb_addr;
@@ -2995,7 +3141,6 @@ struct hl_device {
 	u8				reset_pcilink;
 	u8				cpu_queues_enable;
 	u8				pldm;
-	u8				axi_drain;
 	u8				sram_scrambler_enable;
 	u8				dram_scrambler_enable;
 	u8				hard_reset_on_fw_events;
@@ -3003,6 +3148,7 @@ struct hl_device {
 	u8				rl_enable;
 	u8				reset_on_preboot_fail;
 	u8				reset_upon_device_release;
+	u8				skip_iatu_for_unsecured_device;
 	u8				reset_if_device_not_idle;
 };
 
@@ -3164,7 +3310,8 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q);
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q);
 irqreturn_t hl_irq_handler_cq(int irq, void *arg);
 irqreturn_t hl_irq_handler_eq(int irq, void *arg);
-irqreturn_t hl_irq_handler_user_cq(int irq, void *arg);
+irqreturn_t hl_irq_handler_dec_abnrm(int irq, void *arg);
+irqreturn_t hl_irq_handler_user_interrupt(int irq, void *arg);
 irqreturn_t hl_irq_handler_default(int irq, void *arg);
 u32 hl_cq_inc_ptr(u32 ptr);
 
@@ -3377,6 +3524,11 @@ void hl_encaps_handle_do_release(struct kref *ref);
 void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
 			struct hl_cs *cs, struct hl_cs_job *job,
 			struct hl_cs_compl *cs_cmpl);
+
+int hl_dec_init(struct hl_device *hdev);
+void hl_dec_fini(struct hl_device *hdev);
+void hl_dec_ctx_fini(struct hl_ctx *ctx);
+
 void hl_release_pending_user_interrupts(struct hl_device *hdev);
 int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 			struct hl_hw_sob **hw_sob, u32 count, bool encaps_sig);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d02533666746..3a41dbef14f8 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -293,7 +293,6 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->reset_if_device_not_idle = 1;
 
 	hdev->reset_pcilink = 0;
-	hdev->axi_drain = 0;
 }
 
 static void copy_kernel_module_params_to_device(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index e66dec385ba6..1d80e0b1e718 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -93,7 +93,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
 	hw_ip.psoc_pci_pll_div_factor = prop->psoc_pci_pll_div_factor;
 
-	hw_ip.first_available_interrupt_id = prop->first_available_user_msix_interrupt;
+	hw_ip.first_available_interrupt_id = prop->first_available_user_interrupt;
 	hw_ip.number_of_user_interrupts = prop->user_interrupt_count;
 	hw_ip.server_type = prop->server_type;
 
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 898262b6734e..02c6faf9a10d 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -217,8 +217,7 @@ static int handle_registration_node(struct hl_device *hdev, struct hl_user_pendi
 	return 0;
 }
 
-static void handle_user_cq(struct hl_device *hdev,
-			struct hl_user_interrupt *user_cq)
+static void handle_user_cq(struct hl_device *hdev, struct hl_user_interrupt *user_cq)
 {
 	struct hl_user_pending_interrupt *pend, *temp_pend;
 	struct list_head *ts_reg_free_list_head = NULL;
@@ -271,22 +270,27 @@ static void handle_user_cq(struct hl_device *hdev,
 }
 
 /**
- * hl_irq_handler_user_cq - irq handler for user completion queues
+ * hl_irq_handler_user_interrupt - irq handler for user interrupts
  *
  * @irq: irq number
  * @arg: pointer to user interrupt structure
  *
  */
-irqreturn_t hl_irq_handler_user_cq(int irq, void *arg)
+irqreturn_t hl_irq_handler_user_interrupt(int irq, void *arg)
 {
-	struct hl_user_interrupt *user_cq = arg;
-	struct hl_device *hdev = user_cq->hdev;
+	struct hl_user_interrupt *user_int = arg;
+	struct hl_device *hdev = user_int->hdev;
 
-	/* Handle user cq interrupts registered on all interrupts */
-	handle_user_cq(hdev, &hdev->common_user_interrupt);
+	/* If the interrupt is not a decoder interrupt, it means the interrupt
+	 * belongs to a user cq. In that case, before handling it, we need to handle the common
+	 * user cq
+	 */
+	if (!user_int->is_decoder)
+		/* Handle user cq interrupts registered on all interrupts */
+		handle_user_cq(hdev, &hdev->common_user_interrupt);
 
-	/* Handle user cq interrupts registered on this specific interrupt */
-	handle_user_cq(hdev, user_cq);
+	/* Handle user cq or decoder interrupts registered on this specific irq */
+	handle_user_cq(hdev, user_int);
 
 	return IRQ_HANDLED;
 }
@@ -304,9 +308,7 @@ irqreturn_t hl_irq_handler_default(int irq, void *arg)
 	struct hl_device *hdev = user_interrupt->hdev;
 	u32 interrupt_id = user_interrupt->interrupt_id;
 
-	dev_err(hdev->dev,
-		"got invalid user interrupt %u",
-		interrupt_id);
+	dev_err(hdev->dev, "got invalid user interrupt %u", interrupt_id);
 
 	return IRQ_HANDLED;
 }
@@ -389,12 +391,27 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/**
+ * hl_irq_handler_dec_abnrm - Decoder error interrupt handler
+ * @irq: IRQ number
+ * @arg: pointer to decoder structure.
+ */
+irqreturn_t hl_irq_handler_dec_abnrm(int irq, void *arg)
+{
+	struct hl_dec *dec = arg;
+
+	schedule_work(&dec->completion_abnrm_work);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * hl_cq_init - main initialization function for an cq object
  *
  * @hdev: pointer to device structure
  * @q: pointer to cq structure
  * @hw_queue_id: The H/W queue ID this completion queue belongs to
+ *               HL_INVALID_QUEUE if cq is not attached to any specific queue
  *
  * Allocate dma-able memory for the completion queue and initialize fields
  * Returns 0 on success
diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index d2314157addd..af0f58e75c9a 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -280,21 +280,19 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 	}
 
 	/* Point to the specified address */
-	rc |= hl_pci_iatu_write(hdev, offset + 0x14,
-			lower_32_bits(pci_region->addr));
-	rc |= hl_pci_iatu_write(hdev, offset + 0x18,
-			upper_32_bits(pci_region->addr));
+	rc |= hl_pci_iatu_write(hdev, offset + 0x14, lower_32_bits(pci_region->addr));
+	rc |= hl_pci_iatu_write(hdev, offset + 0x18, upper_32_bits(pci_region->addr));
+
+	/* Set bar type as memory */
 	rc |= hl_pci_iatu_write(hdev, offset + 0x0, 0);
 
 	/* Enable + bar/address match + match enable + bar number */
 	ctrl_reg_val = FIELD_PREP(IATU_REGION_CTRL_REGION_EN_MASK, 1);
-	ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_MATCH_MODE_MASK,
-			pci_region->mode);
+	ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_MATCH_MODE_MASK, pci_region->mode);
 	ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_NUM_MATCH_EN_MASK, 1);
 
 	if (pci_region->mode == PCI_BAR_MATCH_MODE)
-		ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_BAR_NUM_MASK,
-				pci_region->bar);
+		ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_BAR_NUM_MASK, pci_region->bar);
 
 	rc |= hl_pci_iatu_write(hdev, offset + 0x4, ctrl_reg_val);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8fa0b86ccb6b..ae894335e9f8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -679,7 +679,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 			prop->sync_stream_first_mon +
 			(num_sync_stream_queues * HL_RSVD_MONS);
 
-	prop->first_available_user_msix_interrupt = USHRT_MAX;
+	prop->first_available_user_interrupt = USHRT_MAX;
 
 	for (i = 0 ; i < HL_MAX_DCORES ; i++)
 		prop->first_available_cq[i] = USHRT_MAX;
diff --git a/drivers/misc/habanalabs/gaudi2/Makefile b/drivers/misc/habanalabs/gaudi2/Makefile
new file mode 100644
index 000000000000..e4857daa1253
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi2/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+HL_GAUDI2_FILES := gaudi2/gaudi2.o
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
new file mode 100644
index 000000000000..78a1b115a459
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -0,0 +1,9761 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020-2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "gaudi2P.h"
+#include "gaudi2_masks.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
+#include "../include/hw_ip/mmu/mmu_v2_0.h"
+#include "../include/gaudi2/gaudi2_packets.h"
+#include "../include/gaudi2/gaudi2_reg_map.h"
+#include "../include/gaudi2/gaudi2_async_ids_map_extended.h"
+#include "../include/gaudi2/arc/gaudi2_arc_common_packets.h"
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/hwmon.h>
+#include <linux/iommu.h>
+
+#define GAUDI2_DMA_POOL_BLK_SIZE		SZ_256		/* 256 bytes */
+
+#define GAUDI2_RESET_TIMEOUT_MSEC		500		/* 500ms */
+#define GAUDI2_RESET_POLL_TIMEOUT_USEC		50000		/* 50ms */
+#define GAUDI2_PLDM_HRESET_TIMEOUT_MSEC		25000		/* 25s */
+#define GAUDI2_PLDM_SRESET_TIMEOUT_MSEC		25000		/* 25s */
+#define GAUDI2_PLDM_RESET_POLL_TIMEOUT_USEC	3000000		/* 3s */
+#define GAUDI2_RESET_POLL_CNT			3
+#define GAUDI2_RESET_WAIT_MSEC			1		/* 1ms */
+#define GAUDI2_CPU_RESET_WAIT_MSEC		100		/* 100ms */
+#define GAUDI2_PLDM_RESET_WAIT_MSEC		1000		/* 1s */
+#define GAUDI2_CB_POOL_CB_CNT			512
+#define GAUDI2_CB_POOL_CB_SIZE			SZ_128K		/* 128KB */
+#define GAUDI2_MSG_TO_CPU_TIMEOUT_USEC		4000000		/* 4s */
+#define GAUDI2_WAIT_FOR_BL_TIMEOUT_USEC		25000000	/* 25s */
+#define GAUDI2_TEST_QUEUE_WAIT_USEC		100000		/* 100ms */
+#define GAUDI2_PLDM_TEST_QUEUE_WAIT_USEC	1000000		/* 1s */
+
+#define GAUDI2_ALLOC_CPU_MEM_RETRY_CNT		3
+
+/*
+ * since the code already has built-in support for binning of up to MAX_FAULTY_TPCS TPCs
+ * and the code relies on that value (for array size etc..) we define another value
+ * for MAX faulty TPCs which reflects the cluster binning requirements
+ */
+#define MAX_CLUSTER_BINNING_FAULTY_TPCS		1
+#define MAX_FAULTY_XBARS			1
+#define MAX_FAULTY_EDMAS			1
+#define MAX_FAULTY_DECODERS			1
+
+#define GAUDI2_TPC_FULL_MASK			0x1FFFFFF
+#define GAUDI2_HIF_HMMU_FULL_MASK		0xFFFF
+#define GAUDI2_DECODER_FULL_MASK		0x3FF
+
+#define GAUDI2_NUM_OF_QM_ERR_CAUSE		18
+#define GAUDI2_NUM_OF_QM_LCP_ERR_CAUSE		25
+#define GAUDI2_NUM_OF_QM_ARB_ERR_CAUSE		3
+#define GAUDI2_NUM_OF_ARC_SEI_ERR_CAUSE		14
+#define GAUDI2_NUM_OF_CPU_SEI_ERR_CAUSE		3
+#define GAUDI2_NUM_OF_QM_SEI_ERR_CAUSE		2
+#define GAUDI2_NUM_OF_ROT_ERR_CAUSE		22
+#define GAUDI2_NUM_OF_TPC_INTR_CAUSE		30
+#define GAUDI2_NUM_OF_DEC_ERR_CAUSE		25
+#define GAUDI2_NUM_OF_MME_ERR_CAUSE		16
+#define GAUDI2_NUM_OF_MME_SBTE_ERR_CAUSE	5
+#define GAUDI2_NUM_OF_MME_WAP_ERR_CAUSE		7
+#define GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE	8
+#define GAUDI2_NUM_OF_MMU_SPI_SEI_CAUSE		19
+#define GAUDI2_NUM_OF_HBM_SEI_CAUSE		9
+#define GAUDI2_NUM_OF_SM_SEI_ERR_CAUSE		3
+#define GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE	3
+#define GAUDI2_NUM_OF_PMMU_FATAL_ERR_CAUSE	2
+#define GAUDI2_NUM_OF_HIF_FATAL_ERR_CAUSE	2
+#define GAUDI2_NUM_OF_AXI_DRAIN_ERR_CAUSE	2
+#define GAUDI2_NUM_OF_HBM_MC_SPI_CAUSE		5
+#define GAUDI2_NUM_OF_NIC_RXB_CORE_SEI_CAUSE	2
+#define GAUDI2_NUM_OF_NIC_RXB_CORE_SPI_CAUSE	6
+#define GAUDI2_NUM_OF_NIC_RXE_SEI_CAUSE		4
+#define GAUDI2_NUM_OF_NIC_RXE_SPI_CAUSE		24
+
+#define GAUDI2_MMU_CACHE_INV_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 10)
+#define GAUDI2_PLDM_MMU_TIMEOUT_USEC		(MMU_CONFIG_TIMEOUT_USEC * 200)
+#define GAUDI2_ARB_WDT_TIMEOUT			(0x1000000)
+
+#define GAUDI2_VDEC_TIMEOUT_USEC		10000		/* 10ms */
+#define GAUDI2_PLDM_VDEC_TIMEOUT_USEC		(GAUDI2_VDEC_TIMEOUT_USEC * 100)
+
+#define KDMA_TIMEOUT_USEC			USEC_PER_SEC
+
+#define IS_DMA_IDLE(dma_core_idle_ind_mask)	\
+	(!((dma_core_idle_ind_mask) &		\
+	((DCORE0_EDMA0_CORE_IDLE_IND_MASK_DESC_CNT_STS_MASK) | \
+	(DCORE0_EDMA0_CORE_IDLE_IND_MASK_COMP_MASK))))
+
+#define IS_MME_IDLE(mme_arch_sts) (((mme_arch_sts) & MME_ARCH_IDLE_MASK) == MME_ARCH_IDLE_MASK)
+
+#define IS_TPC_IDLE(tpc_cfg_sts) (((tpc_cfg_sts) & (TPC_IDLE_MASK)) == (TPC_IDLE_MASK))
+
+#define IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts) \
+	((((qm_glbl_sts0) & (QM_IDLE_MASK)) == (QM_IDLE_MASK)) && \
+	(((qm_glbl_sts1) & (QM_ARC_IDLE_MASK)) == (QM_ARC_IDLE_MASK)) && \
+	(((qm_cgm_sts) & (CGM_IDLE_MASK)) == (CGM_IDLE_MASK)))
+
+#define PCIE_DEC_EN_MASK			0x300
+#define DEC_WORK_STATE_IDLE			0
+#define DEC_WORK_STATE_PEND			3
+#define IS_DEC_IDLE(dec_swreg15) \
+	(((dec_swreg15) & DCORE0_DEC0_CMD_SWREG15_SW_WORK_STATE_MASK) == DEC_WORK_STATE_IDLE || \
+	((dec_swreg15) & DCORE0_DEC0_CMD_SWREG15_SW_WORK_STATE_MASK) ==  DEC_WORK_STATE_PEND)
+
+/* HBM MMU address scrambling parameters */
+#define GAUDI2_HBM_MMU_SCRM_MEM_SIZE		SZ_8M
+#define GAUDI2_HBM_MMU_SCRM_DIV_SHIFT		26
+#define GAUDI2_HBM_MMU_SCRM_MOD_SHIFT		0
+#define GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK	DRAM_VA_HINT_MASK
+#define GAUDI2_COMPENSATE_TLB_PAGE_SIZE_FACTOR	16
+#define MMU_RANGE_INV_VA_LSB_SHIFT		12
+#define MMU_RANGE_INV_VA_MSB_SHIFT		44
+#define MMU_RANGE_INV_EN_SHIFT			0
+#define MMU_RANGE_INV_ASID_EN_SHIFT		1
+#define MMU_RANGE_INV_ASID_SHIFT		2
+
+#define GAUDI2_MAX_STRING_LEN			64
+
+#define GAUDI2_VDEC_MSIX_ENTRIES		(GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM - \
+							GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM + 1)
+
+enum hl_pmmu_fatal_cause {
+	LATENCY_RD_OUT_FIFO_OVERRUN,
+	LATENCY_WR_OUT_FIFO_OVERRUN,
+};
+
+enum hl_pcie_drain_ind_cause {
+	LBW_AXI_DRAIN_IND,
+	HBW_AXI_DRAIN_IND
+};
+
+static const u32 cluster_hmmu_hif_enabled_mask[GAUDI2_HBM_NUM] = {
+	[HBM_ID0] = 0xFFFC,
+	[HBM_ID1] = 0xFFCF,
+	[HBM_ID2] = 0xF7F7,
+	[HBM_ID3] = 0x7F7F,
+	[HBM_ID4] = 0xFCFF,
+	[HBM_ID5] = 0xCFFF,
+};
+
+static const u8 xbar_edge_to_hbm_cluster[EDMA_ID_SIZE] = {
+	[0] = HBM_ID0,
+	[1] = HBM_ID1,
+	[2] = HBM_ID4,
+	[3] = HBM_ID5,
+};
+
+static const u8 edma_to_hbm_cluster[EDMA_ID_SIZE] = {
+	[EDMA_ID_DCORE0_INSTANCE0] = HBM_ID0,
+	[EDMA_ID_DCORE0_INSTANCE1] = HBM_ID2,
+	[EDMA_ID_DCORE1_INSTANCE0] = HBM_ID1,
+	[EDMA_ID_DCORE1_INSTANCE1] = HBM_ID3,
+	[EDMA_ID_DCORE2_INSTANCE0] = HBM_ID2,
+	[EDMA_ID_DCORE2_INSTANCE1] = HBM_ID4,
+	[EDMA_ID_DCORE3_INSTANCE0] = HBM_ID3,
+	[EDMA_ID_DCORE3_INSTANCE1] = HBM_ID5,
+};
+
+static const int gaudi2_qman_async_event_id[] = {
+	[GAUDI2_QUEUE_ID_PDMA_0_0] = GAUDI2_EVENT_PDMA0_QM,
+	[GAUDI2_QUEUE_ID_PDMA_0_1] = GAUDI2_EVENT_PDMA0_QM,
+	[GAUDI2_QUEUE_ID_PDMA_0_2] = GAUDI2_EVENT_PDMA0_QM,
+	[GAUDI2_QUEUE_ID_PDMA_0_3] = GAUDI2_EVENT_PDMA0_QM,
+	[GAUDI2_QUEUE_ID_PDMA_1_0] = GAUDI2_EVENT_PDMA1_QM,
+	[GAUDI2_QUEUE_ID_PDMA_1_1] = GAUDI2_EVENT_PDMA1_QM,
+	[GAUDI2_QUEUE_ID_PDMA_1_2] = GAUDI2_EVENT_PDMA1_QM,
+	[GAUDI2_QUEUE_ID_PDMA_1_3] = GAUDI2_EVENT_PDMA1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0] = GAUDI2_EVENT_HDMA0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_1] = GAUDI2_EVENT_HDMA0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_2] = GAUDI2_EVENT_HDMA0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_3] = GAUDI2_EVENT_HDMA0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0] = GAUDI2_EVENT_HDMA1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_1] = GAUDI2_EVENT_HDMA1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_2] = GAUDI2_EVENT_HDMA1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3] = GAUDI2_EVENT_HDMA1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_0] = GAUDI2_EVENT_MME0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_1] = GAUDI2_EVENT_MME0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_2] = GAUDI2_EVENT_MME0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_3] = GAUDI2_EVENT_MME0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_0] = GAUDI2_EVENT_TPC0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_1] = GAUDI2_EVENT_TPC0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_2] = GAUDI2_EVENT_TPC0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_3] = GAUDI2_EVENT_TPC0_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_0] = GAUDI2_EVENT_TPC1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_1] = GAUDI2_EVENT_TPC1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_2] = GAUDI2_EVENT_TPC1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_3] = GAUDI2_EVENT_TPC1_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_0] = GAUDI2_EVENT_TPC2_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_1] = GAUDI2_EVENT_TPC2_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_2] = GAUDI2_EVENT_TPC2_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_3] = GAUDI2_EVENT_TPC2_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_0] = GAUDI2_EVENT_TPC3_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_1] = GAUDI2_EVENT_TPC3_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_2] = GAUDI2_EVENT_TPC3_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_3] = GAUDI2_EVENT_TPC3_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_0] = GAUDI2_EVENT_TPC4_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_1] = GAUDI2_EVENT_TPC4_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_2] = GAUDI2_EVENT_TPC4_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_3] = GAUDI2_EVENT_TPC4_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_0] = GAUDI2_EVENT_TPC5_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_1] = GAUDI2_EVENT_TPC5_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_2] = GAUDI2_EVENT_TPC5_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_3] = GAUDI2_EVENT_TPC5_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_0] = GAUDI2_EVENT_TPC24_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_1] = GAUDI2_EVENT_TPC24_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_2] = GAUDI2_EVENT_TPC24_QM,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_3] = GAUDI2_EVENT_TPC24_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0] = GAUDI2_EVENT_HDMA2_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_1] = GAUDI2_EVENT_HDMA2_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_2] = GAUDI2_EVENT_HDMA2_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_3] = GAUDI2_EVENT_HDMA2_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0] = GAUDI2_EVENT_HDMA3_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_1] = GAUDI2_EVENT_HDMA3_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_2] = GAUDI2_EVENT_HDMA3_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_3] = GAUDI2_EVENT_HDMA3_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_0] = GAUDI2_EVENT_MME1_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_1] = GAUDI2_EVENT_MME1_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_2] = GAUDI2_EVENT_MME1_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_3] = GAUDI2_EVENT_MME1_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_0] = GAUDI2_EVENT_TPC6_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_1] = GAUDI2_EVENT_TPC6_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_2] = GAUDI2_EVENT_TPC6_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_3] = GAUDI2_EVENT_TPC6_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_0] = GAUDI2_EVENT_TPC7_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_1] = GAUDI2_EVENT_TPC7_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_2] = GAUDI2_EVENT_TPC7_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_3] = GAUDI2_EVENT_TPC7_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_0] = GAUDI2_EVENT_TPC8_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_1] = GAUDI2_EVENT_TPC8_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_2] = GAUDI2_EVENT_TPC8_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_3] = GAUDI2_EVENT_TPC8_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_0] = GAUDI2_EVENT_TPC9_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_1] = GAUDI2_EVENT_TPC9_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_2] = GAUDI2_EVENT_TPC9_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_3] = GAUDI2_EVENT_TPC9_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_0] = GAUDI2_EVENT_TPC10_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_1] = GAUDI2_EVENT_TPC10_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_2] = GAUDI2_EVENT_TPC10_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_3] = GAUDI2_EVENT_TPC10_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_0] = GAUDI2_EVENT_TPC11_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_1] = GAUDI2_EVENT_TPC11_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_2] = GAUDI2_EVENT_TPC11_QM,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_3] = GAUDI2_EVENT_TPC11_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0] = GAUDI2_EVENT_HDMA4_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_1] = GAUDI2_EVENT_HDMA4_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_2] = GAUDI2_EVENT_HDMA4_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_3] = GAUDI2_EVENT_HDMA4_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0] = GAUDI2_EVENT_HDMA5_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_1] = GAUDI2_EVENT_HDMA5_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_2] = GAUDI2_EVENT_HDMA5_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_3] = GAUDI2_EVENT_HDMA5_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_0] = GAUDI2_EVENT_MME2_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_1] = GAUDI2_EVENT_MME2_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_2] = GAUDI2_EVENT_MME2_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_3] = GAUDI2_EVENT_MME2_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_0] = GAUDI2_EVENT_TPC12_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_1] = GAUDI2_EVENT_TPC12_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_2] = GAUDI2_EVENT_TPC12_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_3] = GAUDI2_EVENT_TPC12_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_0] = GAUDI2_EVENT_TPC13_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_1] = GAUDI2_EVENT_TPC13_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_2] = GAUDI2_EVENT_TPC13_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_3] = GAUDI2_EVENT_TPC13_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_0] = GAUDI2_EVENT_TPC14_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_1] = GAUDI2_EVENT_TPC14_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_2] = GAUDI2_EVENT_TPC14_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_3] = GAUDI2_EVENT_TPC14_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_0] = GAUDI2_EVENT_TPC15_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_1] = GAUDI2_EVENT_TPC15_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_2] = GAUDI2_EVENT_TPC15_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_3] = GAUDI2_EVENT_TPC15_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_0] = GAUDI2_EVENT_TPC16_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_1] = GAUDI2_EVENT_TPC16_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_2] = GAUDI2_EVENT_TPC16_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_3] = GAUDI2_EVENT_TPC16_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_0] = GAUDI2_EVENT_TPC17_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_1] = GAUDI2_EVENT_TPC17_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_2] = GAUDI2_EVENT_TPC17_QM,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_3] = GAUDI2_EVENT_TPC17_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0] = GAUDI2_EVENT_HDMA6_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_1] = GAUDI2_EVENT_HDMA6_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_2] = GAUDI2_EVENT_HDMA6_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_3] = GAUDI2_EVENT_HDMA6_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0] = GAUDI2_EVENT_HDMA7_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_1] = GAUDI2_EVENT_HDMA7_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_2] = GAUDI2_EVENT_HDMA7_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3] = GAUDI2_EVENT_HDMA7_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_0] = GAUDI2_EVENT_MME3_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_1] = GAUDI2_EVENT_MME3_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_2] = GAUDI2_EVENT_MME3_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_3] = GAUDI2_EVENT_MME3_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_0] = GAUDI2_EVENT_TPC18_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_1] = GAUDI2_EVENT_TPC18_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_2] = GAUDI2_EVENT_TPC18_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_3] = GAUDI2_EVENT_TPC18_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_0] = GAUDI2_EVENT_TPC19_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_1] = GAUDI2_EVENT_TPC19_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_2] = GAUDI2_EVENT_TPC19_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_3] = GAUDI2_EVENT_TPC19_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_0] = GAUDI2_EVENT_TPC20_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_1] = GAUDI2_EVENT_TPC20_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_2] = GAUDI2_EVENT_TPC20_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_3] = GAUDI2_EVENT_TPC20_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_0] = GAUDI2_EVENT_TPC21_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_1] = GAUDI2_EVENT_TPC21_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_2] = GAUDI2_EVENT_TPC21_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_3] = GAUDI2_EVENT_TPC21_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_0] = GAUDI2_EVENT_TPC22_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_1] = GAUDI2_EVENT_TPC22_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_2] = GAUDI2_EVENT_TPC22_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_3] = GAUDI2_EVENT_TPC22_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_0] = GAUDI2_EVENT_TPC23_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_1] = GAUDI2_EVENT_TPC23_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_2] = GAUDI2_EVENT_TPC23_QM,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_3] = GAUDI2_EVENT_TPC23_QM,
+	[GAUDI2_QUEUE_ID_NIC_0_0] = GAUDI2_EVENT_NIC0_QM0,
+	[GAUDI2_QUEUE_ID_NIC_0_1] = GAUDI2_EVENT_NIC0_QM0,
+	[GAUDI2_QUEUE_ID_NIC_0_2] = GAUDI2_EVENT_NIC0_QM0,
+	[GAUDI2_QUEUE_ID_NIC_0_3] = GAUDI2_EVENT_NIC0_QM0,
+	[GAUDI2_QUEUE_ID_NIC_1_0] = GAUDI2_EVENT_NIC0_QM1,
+	[GAUDI2_QUEUE_ID_NIC_1_1] = GAUDI2_EVENT_NIC0_QM1,
+	[GAUDI2_QUEUE_ID_NIC_1_2] = GAUDI2_EVENT_NIC0_QM1,
+	[GAUDI2_QUEUE_ID_NIC_1_3] = GAUDI2_EVENT_NIC0_QM1,
+	[GAUDI2_QUEUE_ID_NIC_2_0] = GAUDI2_EVENT_NIC1_QM0,
+	[GAUDI2_QUEUE_ID_NIC_2_1] = GAUDI2_EVENT_NIC1_QM0,
+	[GAUDI2_QUEUE_ID_NIC_2_2] = GAUDI2_EVENT_NIC1_QM0,
+	[GAUDI2_QUEUE_ID_NIC_2_3] = GAUDI2_EVENT_NIC1_QM0,
+	[GAUDI2_QUEUE_ID_NIC_3_0] = GAUDI2_EVENT_NIC1_QM1,
+	[GAUDI2_QUEUE_ID_NIC_3_1] = GAUDI2_EVENT_NIC1_QM1,
+	[GAUDI2_QUEUE_ID_NIC_3_2] = GAUDI2_EVENT_NIC1_QM1,
+	[GAUDI2_QUEUE_ID_NIC_3_3] = GAUDI2_EVENT_NIC1_QM1,
+	[GAUDI2_QUEUE_ID_NIC_4_0] = GAUDI2_EVENT_NIC2_QM0,
+	[GAUDI2_QUEUE_ID_NIC_4_1] = GAUDI2_EVENT_NIC2_QM0,
+	[GAUDI2_QUEUE_ID_NIC_4_2] = GAUDI2_EVENT_NIC2_QM0,
+	[GAUDI2_QUEUE_ID_NIC_4_3] = GAUDI2_EVENT_NIC2_QM0,
+	[GAUDI2_QUEUE_ID_NIC_5_0] = GAUDI2_EVENT_NIC2_QM1,
+	[GAUDI2_QUEUE_ID_NIC_5_1] = GAUDI2_EVENT_NIC2_QM1,
+	[GAUDI2_QUEUE_ID_NIC_5_2] = GAUDI2_EVENT_NIC2_QM1,
+	[GAUDI2_QUEUE_ID_NIC_5_3] = GAUDI2_EVENT_NIC2_QM1,
+	[GAUDI2_QUEUE_ID_NIC_6_0] = GAUDI2_EVENT_NIC3_QM0,
+	[GAUDI2_QUEUE_ID_NIC_6_1] = GAUDI2_EVENT_NIC3_QM0,
+	[GAUDI2_QUEUE_ID_NIC_6_2] = GAUDI2_EVENT_NIC3_QM0,
+	[GAUDI2_QUEUE_ID_NIC_6_3] = GAUDI2_EVENT_NIC3_QM0,
+	[GAUDI2_QUEUE_ID_NIC_7_0] = GAUDI2_EVENT_NIC3_QM1,
+	[GAUDI2_QUEUE_ID_NIC_7_1] = GAUDI2_EVENT_NIC3_QM1,
+	[GAUDI2_QUEUE_ID_NIC_7_2] = GAUDI2_EVENT_NIC3_QM1,
+	[GAUDI2_QUEUE_ID_NIC_7_3] = GAUDI2_EVENT_NIC3_QM1,
+	[GAUDI2_QUEUE_ID_NIC_8_0] = GAUDI2_EVENT_NIC4_QM0,
+	[GAUDI2_QUEUE_ID_NIC_8_1] = GAUDI2_EVENT_NIC4_QM0,
+	[GAUDI2_QUEUE_ID_NIC_8_2] = GAUDI2_EVENT_NIC4_QM0,
+	[GAUDI2_QUEUE_ID_NIC_8_3] = GAUDI2_EVENT_NIC4_QM0,
+	[GAUDI2_QUEUE_ID_NIC_9_0] = GAUDI2_EVENT_NIC4_QM1,
+	[GAUDI2_QUEUE_ID_NIC_9_1] = GAUDI2_EVENT_NIC4_QM1,
+	[GAUDI2_QUEUE_ID_NIC_9_2] = GAUDI2_EVENT_NIC4_QM1,
+	[GAUDI2_QUEUE_ID_NIC_9_3] = GAUDI2_EVENT_NIC4_QM1,
+	[GAUDI2_QUEUE_ID_NIC_10_0] = GAUDI2_EVENT_NIC5_QM0,
+	[GAUDI2_QUEUE_ID_NIC_10_1] = GAUDI2_EVENT_NIC5_QM0,
+	[GAUDI2_QUEUE_ID_NIC_10_2] = GAUDI2_EVENT_NIC5_QM0,
+	[GAUDI2_QUEUE_ID_NIC_10_3] = GAUDI2_EVENT_NIC5_QM0,
+	[GAUDI2_QUEUE_ID_NIC_11_0] = GAUDI2_EVENT_NIC5_QM1,
+	[GAUDI2_QUEUE_ID_NIC_11_1] = GAUDI2_EVENT_NIC5_QM1,
+	[GAUDI2_QUEUE_ID_NIC_11_2] = GAUDI2_EVENT_NIC5_QM1,
+	[GAUDI2_QUEUE_ID_NIC_11_3] = GAUDI2_EVENT_NIC5_QM1,
+	[GAUDI2_QUEUE_ID_NIC_12_0] = GAUDI2_EVENT_NIC6_QM0,
+	[GAUDI2_QUEUE_ID_NIC_12_1] = GAUDI2_EVENT_NIC6_QM0,
+	[GAUDI2_QUEUE_ID_NIC_12_2] = GAUDI2_EVENT_NIC6_QM0,
+	[GAUDI2_QUEUE_ID_NIC_12_3] = GAUDI2_EVENT_NIC6_QM0,
+	[GAUDI2_QUEUE_ID_NIC_13_0] = GAUDI2_EVENT_NIC6_QM1,
+	[GAUDI2_QUEUE_ID_NIC_13_1] = GAUDI2_EVENT_NIC6_QM1,
+	[GAUDI2_QUEUE_ID_NIC_13_2] = GAUDI2_EVENT_NIC6_QM1,
+	[GAUDI2_QUEUE_ID_NIC_13_3] = GAUDI2_EVENT_NIC6_QM1,
+	[GAUDI2_QUEUE_ID_NIC_14_0] = GAUDI2_EVENT_NIC7_QM0,
+	[GAUDI2_QUEUE_ID_NIC_14_1] = GAUDI2_EVENT_NIC7_QM0,
+	[GAUDI2_QUEUE_ID_NIC_14_2] = GAUDI2_EVENT_NIC7_QM0,
+	[GAUDI2_QUEUE_ID_NIC_14_3] = GAUDI2_EVENT_NIC7_QM0,
+	[GAUDI2_QUEUE_ID_NIC_15_0] = GAUDI2_EVENT_NIC7_QM1,
+	[GAUDI2_QUEUE_ID_NIC_15_1] = GAUDI2_EVENT_NIC7_QM1,
+	[GAUDI2_QUEUE_ID_NIC_15_2] = GAUDI2_EVENT_NIC7_QM1,
+	[GAUDI2_QUEUE_ID_NIC_15_3] = GAUDI2_EVENT_NIC7_QM1,
+	[GAUDI2_QUEUE_ID_NIC_16_0] = GAUDI2_EVENT_NIC8_QM0,
+	[GAUDI2_QUEUE_ID_NIC_16_1] = GAUDI2_EVENT_NIC8_QM0,
+	[GAUDI2_QUEUE_ID_NIC_16_2] = GAUDI2_EVENT_NIC8_QM0,
+	[GAUDI2_QUEUE_ID_NIC_16_3] = GAUDI2_EVENT_NIC8_QM0,
+	[GAUDI2_QUEUE_ID_NIC_17_0] = GAUDI2_EVENT_NIC8_QM1,
+	[GAUDI2_QUEUE_ID_NIC_17_1] = GAUDI2_EVENT_NIC8_QM1,
+	[GAUDI2_QUEUE_ID_NIC_17_2] = GAUDI2_EVENT_NIC8_QM1,
+	[GAUDI2_QUEUE_ID_NIC_17_3] = GAUDI2_EVENT_NIC8_QM1,
+	[GAUDI2_QUEUE_ID_NIC_18_0] = GAUDI2_EVENT_NIC9_QM0,
+	[GAUDI2_QUEUE_ID_NIC_18_1] = GAUDI2_EVENT_NIC9_QM0,
+	[GAUDI2_QUEUE_ID_NIC_18_2] = GAUDI2_EVENT_NIC9_QM0,
+	[GAUDI2_QUEUE_ID_NIC_18_3] = GAUDI2_EVENT_NIC9_QM0,
+	[GAUDI2_QUEUE_ID_NIC_19_0] = GAUDI2_EVENT_NIC9_QM1,
+	[GAUDI2_QUEUE_ID_NIC_19_1] = GAUDI2_EVENT_NIC9_QM1,
+	[GAUDI2_QUEUE_ID_NIC_19_2] = GAUDI2_EVENT_NIC9_QM1,
+	[GAUDI2_QUEUE_ID_NIC_19_3] = GAUDI2_EVENT_NIC9_QM1,
+	[GAUDI2_QUEUE_ID_NIC_20_0] = GAUDI2_EVENT_NIC10_QM0,
+	[GAUDI2_QUEUE_ID_NIC_20_1] = GAUDI2_EVENT_NIC10_QM0,
+	[GAUDI2_QUEUE_ID_NIC_20_2] = GAUDI2_EVENT_NIC10_QM0,
+	[GAUDI2_QUEUE_ID_NIC_20_3] = GAUDI2_EVENT_NIC10_QM0,
+	[GAUDI2_QUEUE_ID_NIC_21_0] = GAUDI2_EVENT_NIC10_QM1,
+	[GAUDI2_QUEUE_ID_NIC_21_1] = GAUDI2_EVENT_NIC10_QM1,
+	[GAUDI2_QUEUE_ID_NIC_21_2] = GAUDI2_EVENT_NIC10_QM1,
+	[GAUDI2_QUEUE_ID_NIC_21_3] = GAUDI2_EVENT_NIC10_QM1,
+	[GAUDI2_QUEUE_ID_NIC_22_0] = GAUDI2_EVENT_NIC11_QM0,
+	[GAUDI2_QUEUE_ID_NIC_22_1] = GAUDI2_EVENT_NIC11_QM0,
+	[GAUDI2_QUEUE_ID_NIC_22_2] = GAUDI2_EVENT_NIC11_QM0,
+	[GAUDI2_QUEUE_ID_NIC_22_3] = GAUDI2_EVENT_NIC11_QM0,
+	[GAUDI2_QUEUE_ID_NIC_23_0] = GAUDI2_EVENT_NIC11_QM1,
+	[GAUDI2_QUEUE_ID_NIC_23_1] = GAUDI2_EVENT_NIC11_QM1,
+	[GAUDI2_QUEUE_ID_NIC_23_2] = GAUDI2_EVENT_NIC11_QM1,
+	[GAUDI2_QUEUE_ID_NIC_23_3] = GAUDI2_EVENT_NIC11_QM1,
+	[GAUDI2_QUEUE_ID_ROT_0_0] = GAUDI2_EVENT_ROTATOR0_ROT0_QM,
+	[GAUDI2_QUEUE_ID_ROT_0_1] = GAUDI2_EVENT_ROTATOR0_ROT0_QM,
+	[GAUDI2_QUEUE_ID_ROT_0_2] = GAUDI2_EVENT_ROTATOR0_ROT0_QM,
+	[GAUDI2_QUEUE_ID_ROT_0_3] = GAUDI2_EVENT_ROTATOR0_ROT0_QM,
+	[GAUDI2_QUEUE_ID_ROT_1_0] = GAUDI2_EVENT_ROTATOR1_ROT1_QM,
+	[GAUDI2_QUEUE_ID_ROT_1_1] = GAUDI2_EVENT_ROTATOR1_ROT1_QM,
+	[GAUDI2_QUEUE_ID_ROT_1_2] = GAUDI2_EVENT_ROTATOR1_ROT1_QM,
+	[GAUDI2_QUEUE_ID_ROT_1_3] = GAUDI2_EVENT_ROTATOR1_ROT1_QM
+};
+
+static const int gaudi2_dma_core_async_event_id[] = {
+	[DMA_CORE_ID_EDMA0] = GAUDI2_EVENT_HDMA0_CORE,
+	[DMA_CORE_ID_EDMA1] = GAUDI2_EVENT_HDMA1_CORE,
+	[DMA_CORE_ID_EDMA2] = GAUDI2_EVENT_HDMA2_CORE,
+	[DMA_CORE_ID_EDMA3] = GAUDI2_EVENT_HDMA3_CORE,
+	[DMA_CORE_ID_EDMA4] = GAUDI2_EVENT_HDMA4_CORE,
+	[DMA_CORE_ID_EDMA5] = GAUDI2_EVENT_HDMA5_CORE,
+	[DMA_CORE_ID_EDMA6] = GAUDI2_EVENT_HDMA6_CORE,
+	[DMA_CORE_ID_EDMA7] = GAUDI2_EVENT_HDMA7_CORE,
+	[DMA_CORE_ID_PDMA0] = GAUDI2_EVENT_PDMA0_CORE,
+	[DMA_CORE_ID_PDMA1] = GAUDI2_EVENT_PDMA1_CORE,
+	[DMA_CORE_ID_KDMA] = GAUDI2_EVENT_KDMA0_CORE,
+};
+
+static const char * const gaudi2_qm_sei_error_cause[GAUDI2_NUM_OF_QM_SEI_ERR_CAUSE] = {
+	"qman sei intr",
+	"arc sei intr"
+};
+
+static const char * const gaudi2_cpu_sei_error_cause[GAUDI2_NUM_OF_CPU_SEI_ERR_CAUSE] = {
+	"AXI_TERMINATOR WR",
+	"AXI_TERMINATOR RD",
+	"AXI SPLIT SEI Status"
+};
+
+static const char * const gaudi2_arc_sei_error_cause[GAUDI2_NUM_OF_ARC_SEI_ERR_CAUSE] = {
+	"cbu_bresp_sei_intr_cause",
+	"cbu_rresp_sei_intr_cause",
+	"lbu_bresp_sei_intr_cause",
+	"lbu_rresp_sei_intr_cause",
+	"cbu_axi_split_intr_cause",
+	"lbu_axi_split_intr_cause",
+	"arc_ip_excptn_sei_intr_cause",
+	"dmi_bresp_sei_intr_cause",
+	"aux2apb_err_sei_intr_cause",
+	"cfg_lbw_wr_terminated_intr_cause",
+	"cfg_lbw_rd_terminated_intr_cause",
+	"cfg_dccm_wr_terminated_intr_cause",
+	"cfg_dccm_rd_terminated_intr_cause",
+	"cfg_hbw_rd_terminated_intr_cause"
+};
+
+static const char * const gaudi2_dec_error_cause[GAUDI2_NUM_OF_DEC_ERR_CAUSE] = {
+	"msix_vcd_hbw_sei",
+	"msix_l2c_hbw_sei",
+	"msix_nrm_hbw_sei",
+	"msix_abnrm_hbw_sei",
+	"msix_vcd_lbw_sei",
+	"msix_l2c_lbw_sei",
+	"msix_nrm_lbw_sei",
+	"msix_abnrm_lbw_sei",
+	"apb_vcd_lbw_sei",
+	"apb_l2c_lbw_sei",
+	"apb_nrm_lbw_sei",
+	"apb_abnrm_lbw_sei",
+	"dec_sei",
+	"dec_apb_sei",
+	"trc_apb_sei",
+	"lbw_mstr_if_sei",
+	"axi_split_bresp_err_sei",
+	"hbw_axi_wr_viol_sei",
+	"hbw_axi_rd_viol_sei",
+	"lbw_axi_wr_viol_sei",
+	"lbw_axi_rd_viol_sei",
+	"vcd_spi",
+	"l2c_spi",
+	"nrm_spi",
+	"abnrm_spi",
+};
+
+static const char * const gaudi2_qman_error_cause[GAUDI2_NUM_OF_QM_ERR_CAUSE] = {
+	"PQ AXI HBW error",
+	"CQ AXI HBW error",
+	"CP AXI HBW error",
+	"CP error due to undefined OPCODE",
+	"CP encountered STOP OPCODE",
+	"CP AXI LBW error",
+	"CP WRREG32 or WRBULK returned error",
+	"N/A",
+	"FENCE 0 inc over max value and clipped",
+	"FENCE 1 inc over max value and clipped",
+	"FENCE 2 inc over max value and clipped",
+	"FENCE 3 inc over max value and clipped",
+	"FENCE 0 dec under min value and clipped",
+	"FENCE 1 dec under min value and clipped",
+	"FENCE 2 dec under min value and clipped",
+	"FENCE 3 dec under min value and clipped",
+	"CPDMA Up overflow",
+	"PQC L2H error"
+};
+
+static const char * const gaudi2_qman_lower_cp_error_cause[GAUDI2_NUM_OF_QM_LCP_ERR_CAUSE] = {
+	"RSVD0",
+	"CQ AXI HBW error",
+	"CP AXI HBW error",
+	"CP error due to undefined OPCODE",
+	"CP encountered STOP OPCODE",
+	"CP AXI LBW error",
+	"CP WRREG32 or WRBULK returned error",
+	"N/A",
+	"FENCE 0 inc over max value and clipped",
+	"FENCE 1 inc over max value and clipped",
+	"FENCE 2 inc over max value and clipped",
+	"FENCE 3 inc over max value and clipped",
+	"FENCE 0 dec under min value and clipped",
+	"FENCE 1 dec under min value and clipped",
+	"FENCE 2 dec under min value and clipped",
+	"FENCE 3 dec under min value and clipped",
+	"CPDMA Up overflow",
+	"RSVD17",
+	"CQ_WR_IFIFO_CI_ERR",
+	"CQ_WR_CTL_CI_ERR",
+	"ARC_CQF_RD_ERR",
+	"ARC_CQ_WR_IFIFO_CI_ERR",
+	"ARC_CQ_WR_CTL_CI_ERR",
+	"ARC_AXI_ERR",
+	"CP_SWITCH_WDT_ERR"
+};
+
+static const char * const gaudi2_qman_arb_error_cause[GAUDI2_NUM_OF_QM_ARB_ERR_CAUSE] = {
+	"Choice push while full error",
+	"Choice Q watchdog error",
+	"MSG AXI LBW returned with error"
+};
+
+static const char * const guadi2_rot_error_cause[GAUDI2_NUM_OF_ROT_ERR_CAUSE] = {
+	"qm_axi_err",
+	"qm_trace_fence_events",
+	"qm_sw_err",
+	"qm_cp_sw_stop",
+	"lbw_mstr_rresp_err",
+	"lbw_mstr_bresp_err",
+	"lbw_msg_slverr",
+	"hbw_msg_slverr",
+	"wbc_slverr",
+	"hbw_mstr_rresp_err",
+	"hbw_mstr_bresp_err",
+	"sb_resp_intr",
+	"mrsb_resp_intr",
+	"core_dw_status_0",
+	"core_dw_status_1",
+	"core_dw_status_2",
+	"core_dw_status_3",
+	"core_dw_status_4",
+	"core_dw_status_5",
+	"core_dw_status_6",
+	"core_dw_status_7",
+	"async_arc2cpu_sei_intr",
+};
+
+static const char * const gaudi2_tpc_interrupts_cause[GAUDI2_NUM_OF_TPC_INTR_CAUSE] = {
+	"tpc_address_exceed_slm",
+	"tpc_div_by_0",
+	"tpc_spu_mac_overflow",
+	"tpc_spu_addsub_overflow",
+	"tpc_spu_abs_overflow",
+	"tpc_spu_fma_fp_dst_nan",
+	"tpc_spu_fma_fp_dst_inf",
+	"tpc_spu_convert_fp_dst_nan",
+	"tpc_spu_convert_fp_dst_inf",
+	"tpc_spu_fp_dst_denorm",
+	"tpc_vpu_mac_overflow",
+	"tpc_vpu_addsub_overflow",
+	"tpc_vpu_abs_overflow",
+	"tpc_vpu_convert_fp_dst_nan",
+	"tpc_vpu_convert_fp_dst_inf",
+	"tpc_vpu_fma_fp_dst_nan",
+	"tpc_vpu_fma_fp_dst_inf",
+	"tpc_vpu_fp_dst_denorm",
+	"tpc_assertions",
+	"tpc_illegal_instruction",
+	"tpc_pc_wrap_around",
+	"tpc_qm_sw_err",
+	"tpc_hbw_rresp_err",
+	"tpc_hbw_bresp_err",
+	"tpc_lbw_rresp_err",
+	"tpc_lbw_bresp_err",
+	"st_unlock_already_locked",
+	"invalid_lock_access",
+	"LD_L protection violation",
+	"ST_L protection violation",
+};
+
+static const char * const guadi2_mme_error_cause[GAUDI2_NUM_OF_MME_ERR_CAUSE] = {
+	"agu_resp_intr",
+	"qman_axi_err",
+	"wap sei (wbc axi err)",
+	"arc sei",
+	"mme_cfg_unalign_addr",
+	"qm_sw_err",
+	"sbte_dbg_intr_0",
+	"sbte_dbg_intr_1",
+	"sbte_dbg_intr_2",
+	"sbte_dbg_intr_3",
+	"sbte_dbg_intr_4",
+	"sbte_prtn_intr_0",
+	"sbte_prtn_intr_1",
+	"sbte_prtn_intr_2",
+	"sbte_prtn_intr_3",
+	"sbte_prtn_intr_4",
+};
+
+static const char * const guadi2_mme_sbte_error_cause[GAUDI2_NUM_OF_MME_SBTE_ERR_CAUSE] = {
+	"i0",
+	"i1",
+	"i2",
+	"i3",
+	"i4",
+};
+
+static const char * const guadi2_mme_wap_error_cause[GAUDI2_NUM_OF_MME_WAP_ERR_CAUSE] = {
+	"WBC ERR RESP_0",
+	"WBC ERR RESP_1",
+	"AP SOURCE POS INF",
+	"AP SOURCE NEG INF",
+	"AP SOURCE NAN",
+	"AP RESULT POS INF",
+	"AP RESULT NEG INF",
+};
+
+static const char * const gaudi2_dma_core_interrupts_cause[GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE] = {
+	"HBW Read returned with error RRESP",
+	"HBW write returned with error BRESP",
+	"LBW write returned with error BRESP",
+	"descriptor_fifo_overflow",
+	"KDMA SB LBW Read returned with error",
+	"KDMA WBC LBW Write returned with error",
+	"TRANSPOSE ENGINE DESC FIFO OVERFLOW",
+	"WRONG CFG FOR COMMIT IN LIN DMA"
+};
+
+static const char * const gaudi2_kdma_core_interrupts_cause[GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE] = {
+	"HBW/LBW Read returned with error RRESP",
+	"HBW/LBW write returned with error BRESP",
+	"LBW write returned with error BRESP",
+	"descriptor_fifo_overflow",
+	"KDMA SB LBW Read returned with error",
+	"KDMA WBC LBW Write returned with error",
+	"TRANSPOSE ENGINE DESC FIFO OVERFLOW",
+	"WRONG CFG FOR COMMIT IN LIN DMA"
+};
+
+struct gaudi2_sm_sei_cause_data {
+	const char *cause_name;
+	const char *log_name;
+	u32 log_mask;
+};
+
+static const struct gaudi2_sm_sei_cause_data
+gaudi2_sm_sei_cause[GAUDI2_NUM_OF_SM_SEI_ERR_CAUSE] = {
+	{"calculated SO value overflow/underflow", "SOB group ID", 0x7FF},
+	{"payload address of monitor is not aligned to 4B", "monitor addr", 0xFFFF},
+	{"armed monitor write got BRESP (SLVERR or DECERR)", "AXI id", 0xFFFF},
+};
+
+static const char * const
+gaudi2_pmmu_fatal_interrupts_cause[GAUDI2_NUM_OF_PMMU_FATAL_ERR_CAUSE] = {
+	"LATENCY_RD_OUT_FIFO_OVERRUN",
+	"LATENCY_WR_OUT_FIFO_OVERRUN",
+};
+
+static const char * const
+gaudi2_hif_fatal_interrupts_cause[GAUDI2_NUM_OF_HIF_FATAL_ERR_CAUSE] = {
+	"LATENCY_RD_OUT_FIFO_OVERRUN",
+	"LATENCY_WR_OUT_FIFO_OVERRUN",
+};
+
+static const char * const
+gaudi2_psoc_axi_drain_interrupts_cause[GAUDI2_NUM_OF_AXI_DRAIN_ERR_CAUSE] = {
+	"AXI drain HBW",
+	"AXI drain LBW",
+};
+
+static const char * const
+gaudi2_pcie_addr_dec_error_cause[GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE] = {
+	"HBW error response",
+	"LBW error response",
+	"TLP is blocked by RR"
+};
+
+const u32 gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_SIZE] = {
+	[GAUDI2_QUEUE_ID_PDMA_0_0] = mmPDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_0_1] = mmPDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_0_2] = mmPDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_0_3] = mmPDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_1_0] = mmPDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_1_1] = mmPDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_1_2] = mmPDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_PDMA_1_3] = mmPDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0] = mmDCORE0_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_1] = mmDCORE0_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_2] = mmDCORE0_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_3] = mmDCORE0_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0] = mmDCORE0_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_1] = mmDCORE0_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_2] = mmDCORE0_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3] = mmDCORE0_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_0] = mmDCORE0_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_1] = mmDCORE0_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_2] = mmDCORE0_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_3] = mmDCORE0_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_0] = mmDCORE0_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_1] = mmDCORE0_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_2] = mmDCORE0_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_3] = mmDCORE0_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_0] = mmDCORE0_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_1] = mmDCORE0_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_2] = mmDCORE0_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_3] = mmDCORE0_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_0] = mmDCORE0_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_1] = mmDCORE0_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_2] = mmDCORE0_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_3] = mmDCORE0_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_0] = mmDCORE0_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_1] = mmDCORE0_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_2] = mmDCORE0_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_3] = mmDCORE0_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_0] = mmDCORE0_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_1] = mmDCORE0_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_2] = mmDCORE0_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_3] = mmDCORE0_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_0] = mmDCORE0_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_1] = mmDCORE0_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_2] = mmDCORE0_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_3] = mmDCORE0_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_0] = mmDCORE0_TPC6_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_1] = mmDCORE0_TPC6_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_2] = mmDCORE0_TPC6_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_3] = mmDCORE0_TPC6_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0] = mmDCORE1_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_1] = mmDCORE1_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_2] = mmDCORE1_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_3] = mmDCORE1_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0] = mmDCORE1_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_1] = mmDCORE1_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_2] = mmDCORE1_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_3] = mmDCORE1_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_0] = mmDCORE1_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_1] = mmDCORE1_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_2] = mmDCORE1_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_3] = mmDCORE1_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_0] = mmDCORE1_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_1] = mmDCORE1_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_2] = mmDCORE1_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_3] = mmDCORE1_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_0] = mmDCORE1_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_1] = mmDCORE1_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_2] = mmDCORE1_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_3] = mmDCORE1_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_0] = mmDCORE1_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_1] = mmDCORE1_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_2] = mmDCORE1_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_3] = mmDCORE1_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_0] = mmDCORE1_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_1] = mmDCORE1_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_2] = mmDCORE1_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_3] = mmDCORE1_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_0] = mmDCORE1_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_1] = mmDCORE1_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_2] = mmDCORE1_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_3] = mmDCORE1_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_0] = mmDCORE1_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_1] = mmDCORE1_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_2] = mmDCORE1_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_3] = mmDCORE1_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0] = mmDCORE2_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_1] = mmDCORE2_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_2] = mmDCORE2_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_3] = mmDCORE2_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0] = mmDCORE2_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_1] = mmDCORE2_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_2] = mmDCORE2_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_3] = mmDCORE2_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_0] = mmDCORE2_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_1] = mmDCORE2_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_2] = mmDCORE2_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_3] = mmDCORE2_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_0] = mmDCORE2_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_1] = mmDCORE2_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_2] = mmDCORE2_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_3] = mmDCORE2_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_0] = mmDCORE2_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_1] = mmDCORE2_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_2] = mmDCORE2_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_3] = mmDCORE2_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_0] = mmDCORE2_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_1] = mmDCORE2_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_2] = mmDCORE2_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_3] = mmDCORE2_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_0] = mmDCORE2_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_1] = mmDCORE2_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_2] = mmDCORE2_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_3] = mmDCORE2_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_0] = mmDCORE2_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_1] = mmDCORE2_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_2] = mmDCORE2_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_3] = mmDCORE2_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_0] = mmDCORE2_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_1] = mmDCORE2_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_2] = mmDCORE2_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_3] = mmDCORE2_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0] = mmDCORE3_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_1] = mmDCORE3_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_2] = mmDCORE3_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_3] = mmDCORE3_EDMA0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0] = mmDCORE3_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_1] = mmDCORE3_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_2] = mmDCORE3_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3] = mmDCORE3_EDMA1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_0] = mmDCORE3_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_1] = mmDCORE3_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_2] = mmDCORE3_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_3] = mmDCORE3_MME_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_0] = mmDCORE3_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_1] = mmDCORE3_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_2] = mmDCORE3_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_3] = mmDCORE3_TPC0_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_0] = mmDCORE3_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_1] = mmDCORE3_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_2] = mmDCORE3_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_3] = mmDCORE3_TPC1_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_0] = mmDCORE3_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_1] = mmDCORE3_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_2] = mmDCORE3_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_3] = mmDCORE3_TPC2_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_0] = mmDCORE3_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_1] = mmDCORE3_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_2] = mmDCORE3_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_3] = mmDCORE3_TPC3_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_0] = mmDCORE3_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_1] = mmDCORE3_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_2] = mmDCORE3_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_3] = mmDCORE3_TPC4_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_0] = mmDCORE3_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_1] = mmDCORE3_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_2] = mmDCORE3_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_3] = mmDCORE3_TPC5_QM_BASE,
+	[GAUDI2_QUEUE_ID_NIC_0_0] = mmNIC0_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_0_1] = mmNIC0_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_0_2] = mmNIC0_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_0_3] = mmNIC0_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_1_0] = mmNIC0_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_1_1] = mmNIC0_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_1_2] = mmNIC0_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_1_3] = mmNIC0_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_2_0] = mmNIC1_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_2_1] = mmNIC1_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_2_2] = mmNIC1_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_2_3] = mmNIC1_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_3_0] = mmNIC1_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_3_1] = mmNIC1_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_3_2] = mmNIC1_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_3_3] = mmNIC1_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_4_0] = mmNIC2_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_4_1] = mmNIC2_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_4_2] = mmNIC2_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_4_3] = mmNIC2_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_5_0] = mmNIC2_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_5_1] = mmNIC2_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_5_2] = mmNIC2_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_5_3] = mmNIC2_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_6_0] = mmNIC3_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_6_1] = mmNIC3_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_6_2] = mmNIC3_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_6_3] = mmNIC3_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_7_0] = mmNIC3_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_7_1] = mmNIC3_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_7_2] = mmNIC3_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_7_3] = mmNIC3_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_8_0] = mmNIC4_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_8_1] = mmNIC4_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_8_2] = mmNIC4_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_8_3] = mmNIC4_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_9_0] = mmNIC4_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_9_1] = mmNIC4_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_9_2] = mmNIC4_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_9_3] = mmNIC4_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_10_0] = mmNIC5_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_10_1] = mmNIC5_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_10_2] = mmNIC5_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_10_3] = mmNIC5_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_11_0] = mmNIC5_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_11_1] = mmNIC5_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_11_2] = mmNIC5_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_11_3] = mmNIC5_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_12_0] = mmNIC6_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_12_1] = mmNIC6_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_12_2] = mmNIC6_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_12_3] = mmNIC6_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_13_0] = mmNIC6_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_13_1] = mmNIC6_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_13_2] = mmNIC6_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_13_3] = mmNIC6_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_14_0] = mmNIC7_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_14_1] = mmNIC7_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_14_2] = mmNIC7_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_14_3] = mmNIC7_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_15_0] = mmNIC7_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_15_1] = mmNIC7_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_15_2] = mmNIC7_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_15_3] = mmNIC7_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_16_0] = mmNIC8_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_16_1] = mmNIC8_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_16_2] = mmNIC8_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_16_3] = mmNIC8_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_17_0] = mmNIC8_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_17_1] = mmNIC8_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_17_2] = mmNIC8_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_17_3] = mmNIC8_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_18_0] = mmNIC9_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_18_1] = mmNIC9_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_18_2] = mmNIC9_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_18_3] = mmNIC9_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_19_0] = mmNIC9_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_19_1] = mmNIC9_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_19_2] = mmNIC9_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_19_3] = mmNIC9_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_20_0] = mmNIC10_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_20_1] = mmNIC10_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_20_2] = mmNIC10_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_20_3] = mmNIC10_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_21_0] = mmNIC10_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_21_1] = mmNIC10_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_21_2] = mmNIC10_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_21_3] = mmNIC10_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_22_0] = mmNIC11_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_22_1] = mmNIC11_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_22_2] = mmNIC11_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_22_3] = mmNIC11_QM0_BASE,
+	[GAUDI2_QUEUE_ID_NIC_23_0] = mmNIC11_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_23_1] = mmNIC11_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_23_2] = mmNIC11_QM1_BASE,
+	[GAUDI2_QUEUE_ID_NIC_23_3] = mmNIC11_QM1_BASE,
+	[GAUDI2_QUEUE_ID_ROT_0_0] = mmROT0_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_0_1] = mmROT0_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_0_2] = mmROT0_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_0_3] = mmROT0_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_1_0] = mmROT1_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_1_1] = mmROT1_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_1_2] = mmROT1_QM_BASE,
+	[GAUDI2_QUEUE_ID_ROT_1_3] = mmROT1_QM_BASE
+};
+
+static const u32 gaudi2_arc_blocks_bases[NUM_ARC_CPUS] = {
+	[CPU_ID_SCHED_ARC0] = mmARC_FARM_ARC0_AUX_BASE,
+	[CPU_ID_SCHED_ARC1] = mmARC_FARM_ARC1_AUX_BASE,
+	[CPU_ID_SCHED_ARC2] = mmARC_FARM_ARC2_AUX_BASE,
+	[CPU_ID_SCHED_ARC3] = mmARC_FARM_ARC3_AUX_BASE,
+	[CPU_ID_SCHED_ARC4] = mmDCORE1_MME_QM_ARC_AUX_BASE,
+	[CPU_ID_SCHED_ARC5] = mmDCORE3_MME_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC0] = mmDCORE0_TPC0_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC1] = mmDCORE0_TPC1_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC2] = mmDCORE0_TPC2_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC3] = mmDCORE0_TPC3_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC4] = mmDCORE0_TPC4_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC5] = mmDCORE0_TPC5_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC6] = mmDCORE1_TPC0_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC7] = mmDCORE1_TPC1_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC8] = mmDCORE1_TPC2_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC9] = mmDCORE1_TPC3_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC10] = mmDCORE1_TPC4_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC11] = mmDCORE1_TPC5_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC12] = mmDCORE2_TPC0_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC13] = mmDCORE2_TPC1_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC14] = mmDCORE2_TPC2_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC15] = mmDCORE2_TPC3_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC16] = mmDCORE2_TPC4_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC17] = mmDCORE2_TPC5_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC18] = mmDCORE3_TPC0_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC19] = mmDCORE3_TPC1_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC20] = mmDCORE3_TPC2_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC21] = mmDCORE3_TPC3_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC22] = mmDCORE3_TPC4_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC23] = mmDCORE3_TPC5_QM_ARC_AUX_BASE,
+	[CPU_ID_TPC_QMAN_ARC24] = mmDCORE0_TPC6_QM_ARC_AUX_BASE,
+	[CPU_ID_MME_QMAN_ARC0] = mmDCORE0_MME_QM_ARC_AUX_BASE,
+	[CPU_ID_MME_QMAN_ARC1] = mmDCORE2_MME_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC0] = mmDCORE0_EDMA0_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC1] = mmDCORE0_EDMA1_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC2] = mmDCORE1_EDMA0_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC3] = mmDCORE1_EDMA1_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC4] = mmDCORE2_EDMA0_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC5] = mmDCORE2_EDMA1_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC6] = mmDCORE3_EDMA0_QM_ARC_AUX_BASE,
+	[CPU_ID_EDMA_QMAN_ARC7] = mmDCORE3_EDMA1_QM_ARC_AUX_BASE,
+	[CPU_ID_PDMA_QMAN_ARC0] = mmPDMA0_QM_ARC_AUX_BASE,
+	[CPU_ID_PDMA_QMAN_ARC1] = mmPDMA1_QM_ARC_AUX_BASE,
+	[CPU_ID_ROT_QMAN_ARC0] = mmROT0_QM_ARC_AUX_BASE,
+	[CPU_ID_ROT_QMAN_ARC1] = mmROT1_QM_ARC_AUX_BASE,
+	[CPU_ID_NIC_QMAN_ARC0] = mmNIC0_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC1] = mmNIC0_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC2] = mmNIC1_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC3] = mmNIC1_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC4] = mmNIC2_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC5] = mmNIC2_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC6] = mmNIC3_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC7] = mmNIC3_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC8] = mmNIC4_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC9] = mmNIC4_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC10] = mmNIC5_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC11] = mmNIC5_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC12] = mmNIC6_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC13] = mmNIC6_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC14] = mmNIC7_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC15] = mmNIC7_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC16] = mmNIC8_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC17] = mmNIC8_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC18] = mmNIC9_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC19] = mmNIC9_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC20] = mmNIC10_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC21] = mmNIC10_QM_ARC_AUX1_BASE,
+	[CPU_ID_NIC_QMAN_ARC22] = mmNIC11_QM_ARC_AUX0_BASE,
+	[CPU_ID_NIC_QMAN_ARC23] = mmNIC11_QM_ARC_AUX1_BASE,
+};
+
+static const u32 gaudi2_arc_dccm_bases[NUM_ARC_CPUS] = {
+	[CPU_ID_SCHED_ARC0] = mmARC_FARM_ARC0_DCCM0_BASE,
+	[CPU_ID_SCHED_ARC1] = mmARC_FARM_ARC1_DCCM0_BASE,
+	[CPU_ID_SCHED_ARC2] = mmARC_FARM_ARC2_DCCM0_BASE,
+	[CPU_ID_SCHED_ARC3] = mmARC_FARM_ARC3_DCCM0_BASE,
+	[CPU_ID_SCHED_ARC4] = mmDCORE1_MME_QM_ARC_DCCM_BASE,
+	[CPU_ID_SCHED_ARC5] = mmDCORE3_MME_QM_ARC_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC0] = mmDCORE0_TPC0_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC1] = mmDCORE0_TPC1_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC2] = mmDCORE0_TPC2_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC3] = mmDCORE0_TPC3_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC4] = mmDCORE0_TPC4_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC5] = mmDCORE0_TPC5_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC6] = mmDCORE1_TPC0_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC7] = mmDCORE1_TPC1_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC8] = mmDCORE1_TPC2_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC9] = mmDCORE1_TPC3_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC10] = mmDCORE1_TPC4_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC11] = mmDCORE1_TPC5_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC12] = mmDCORE2_TPC0_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC13] = mmDCORE2_TPC1_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC14] = mmDCORE2_TPC2_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC15] = mmDCORE2_TPC3_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC16] = mmDCORE2_TPC4_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC17] = mmDCORE2_TPC5_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC18] = mmDCORE3_TPC0_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC19] = mmDCORE3_TPC1_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC20] = mmDCORE3_TPC2_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC21] = mmDCORE3_TPC3_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC22] = mmDCORE3_TPC4_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC23] = mmDCORE3_TPC5_QM_DCCM_BASE,
+	[CPU_ID_TPC_QMAN_ARC24] = mmDCORE0_TPC6_QM_DCCM_BASE,
+	[CPU_ID_MME_QMAN_ARC0] = mmDCORE0_MME_QM_ARC_DCCM_BASE,
+	[CPU_ID_MME_QMAN_ARC1] = mmDCORE2_MME_QM_ARC_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC0] = mmDCORE0_EDMA0_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC1] = mmDCORE0_EDMA1_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC2] = mmDCORE1_EDMA0_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC3] = mmDCORE1_EDMA1_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC4] = mmDCORE2_EDMA0_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC5] = mmDCORE2_EDMA1_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC6] = mmDCORE3_EDMA0_QM_DCCM_BASE,
+	[CPU_ID_EDMA_QMAN_ARC7] = mmDCORE3_EDMA1_QM_DCCM_BASE,
+	[CPU_ID_PDMA_QMAN_ARC0] = mmPDMA0_QM_ARC_DCCM_BASE,
+	[CPU_ID_PDMA_QMAN_ARC1] = mmPDMA1_QM_ARC_DCCM_BASE,
+	[CPU_ID_ROT_QMAN_ARC0] = mmROT0_QM_ARC_DCCM_BASE,
+	[CPU_ID_ROT_QMAN_ARC1] = mmROT1_QM_ARC_DCCM_BASE,
+	[CPU_ID_NIC_QMAN_ARC0] = mmNIC0_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC1] = mmNIC0_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC2] = mmNIC1_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC3] = mmNIC1_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC4] = mmNIC2_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC5] = mmNIC2_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC6] = mmNIC3_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC7] = mmNIC3_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC8] = mmNIC4_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC9] = mmNIC4_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC10] = mmNIC5_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC11] = mmNIC5_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC12] = mmNIC6_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC13] = mmNIC6_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC14] = mmNIC7_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC15] = mmNIC7_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC16] = mmNIC8_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC17] = mmNIC8_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC18] = mmNIC9_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC19] = mmNIC9_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC20] = mmNIC10_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC21] = mmNIC10_QM_DCCM1_BASE,
+	[CPU_ID_NIC_QMAN_ARC22] = mmNIC11_QM_DCCM0_BASE,
+	[CPU_ID_NIC_QMAN_ARC23] = mmNIC11_QM_DCCM1_BASE,
+};
+
+const u32 gaudi2_mme_ctrl_lo_blocks_bases[MME_ID_SIZE] = {
+	[MME_ID_DCORE0] = mmDCORE0_MME_CTRL_LO_BASE,
+	[MME_ID_DCORE1] = mmDCORE1_MME_CTRL_LO_BASE,
+	[MME_ID_DCORE2] = mmDCORE2_MME_CTRL_LO_BASE,
+	[MME_ID_DCORE3] = mmDCORE3_MME_CTRL_LO_BASE,
+};
+
+static const u32 gaudi2_queue_id_to_arc_id[GAUDI2_QUEUE_ID_SIZE] = {
+	[GAUDI2_QUEUE_ID_PDMA_0_0] = CPU_ID_PDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_PDMA_0_1] = CPU_ID_PDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_PDMA_0_2] = CPU_ID_PDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_PDMA_0_3] = CPU_ID_PDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_PDMA_1_0] = CPU_ID_PDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_PDMA_1_1] = CPU_ID_PDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_PDMA_1_2] = CPU_ID_PDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_PDMA_1_3] = CPU_ID_PDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0] = CPU_ID_EDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_1] = CPU_ID_EDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_2] = CPU_ID_EDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_0_3] = CPU_ID_EDMA_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0] = CPU_ID_EDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_1] = CPU_ID_EDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_2] = CPU_ID_EDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3] = CPU_ID_EDMA_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_0] = CPU_ID_MME_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_1] = CPU_ID_MME_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_2] = CPU_ID_MME_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_MME_0_3] = CPU_ID_MME_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_0] = CPU_ID_TPC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_1] = CPU_ID_TPC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_2] = CPU_ID_TPC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_0_3] = CPU_ID_TPC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_0] = CPU_ID_TPC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_1] = CPU_ID_TPC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_2] = CPU_ID_TPC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_1_3] = CPU_ID_TPC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_0] = CPU_ID_TPC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_1] = CPU_ID_TPC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_2] = CPU_ID_TPC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_2_3] = CPU_ID_TPC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_0] = CPU_ID_TPC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_1] = CPU_ID_TPC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_2] = CPU_ID_TPC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_3_3] = CPU_ID_TPC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_0] = CPU_ID_TPC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_1] = CPU_ID_TPC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_2] = CPU_ID_TPC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_4_3] = CPU_ID_TPC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_0] = CPU_ID_TPC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_1] = CPU_ID_TPC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_2] = CPU_ID_TPC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_5_3] = CPU_ID_TPC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_0] = CPU_ID_TPC_QMAN_ARC24,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_1] = CPU_ID_TPC_QMAN_ARC24,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_2] = CPU_ID_TPC_QMAN_ARC24,
+	[GAUDI2_QUEUE_ID_DCORE0_TPC_6_3] = CPU_ID_TPC_QMAN_ARC24,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0] = CPU_ID_EDMA_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_1] = CPU_ID_EDMA_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_2] = CPU_ID_EDMA_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_0_3] = CPU_ID_EDMA_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0] = CPU_ID_EDMA_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_1] = CPU_ID_EDMA_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_2] = CPU_ID_EDMA_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE1_EDMA_1_3] = CPU_ID_EDMA_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_0] = CPU_ID_SCHED_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_1] = CPU_ID_SCHED_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_2] = CPU_ID_SCHED_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE1_MME_0_3] = CPU_ID_SCHED_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_0] = CPU_ID_TPC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_1] = CPU_ID_TPC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_2] = CPU_ID_TPC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_0_3] = CPU_ID_TPC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_0] = CPU_ID_TPC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_1] = CPU_ID_TPC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_2] = CPU_ID_TPC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_1_3] = CPU_ID_TPC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_0] = CPU_ID_TPC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_1] = CPU_ID_TPC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_2] = CPU_ID_TPC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_2_3] = CPU_ID_TPC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_0] = CPU_ID_TPC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_1] = CPU_ID_TPC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_2] = CPU_ID_TPC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_3_3] = CPU_ID_TPC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_0] = CPU_ID_TPC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_1] = CPU_ID_TPC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_2] = CPU_ID_TPC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_4_3] = CPU_ID_TPC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_0] = CPU_ID_TPC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_1] = CPU_ID_TPC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_2] = CPU_ID_TPC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_DCORE1_TPC_5_3] = CPU_ID_TPC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0] = CPU_ID_EDMA_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_1] = CPU_ID_EDMA_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_2] = CPU_ID_EDMA_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_0_3] = CPU_ID_EDMA_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0] = CPU_ID_EDMA_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_1] = CPU_ID_EDMA_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_2] = CPU_ID_EDMA_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE2_EDMA_1_3] = CPU_ID_EDMA_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_0] = CPU_ID_MME_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_1] = CPU_ID_MME_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_2] = CPU_ID_MME_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE2_MME_0_3] = CPU_ID_MME_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_0] = CPU_ID_TPC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_1] = CPU_ID_TPC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_2] = CPU_ID_TPC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_0_3] = CPU_ID_TPC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_0] = CPU_ID_TPC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_1] = CPU_ID_TPC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_2] = CPU_ID_TPC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_1_3] = CPU_ID_TPC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_0] = CPU_ID_TPC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_1] = CPU_ID_TPC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_2] = CPU_ID_TPC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_2_3] = CPU_ID_TPC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_0] = CPU_ID_TPC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_1] = CPU_ID_TPC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_2] = CPU_ID_TPC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_3_3] = CPU_ID_TPC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_0] = CPU_ID_TPC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_1] = CPU_ID_TPC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_2] = CPU_ID_TPC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_4_3] = CPU_ID_TPC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_0] = CPU_ID_TPC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_1] = CPU_ID_TPC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_2] = CPU_ID_TPC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_DCORE2_TPC_5_3] = CPU_ID_TPC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0] = CPU_ID_EDMA_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_1] = CPU_ID_EDMA_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_2] = CPU_ID_EDMA_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_0_3] = CPU_ID_EDMA_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0] = CPU_ID_EDMA_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_1] = CPU_ID_EDMA_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_2] = CPU_ID_EDMA_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3] = CPU_ID_EDMA_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_0] = CPU_ID_SCHED_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_1] = CPU_ID_SCHED_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_2] = CPU_ID_SCHED_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE3_MME_0_3] = CPU_ID_SCHED_ARC5,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_0] = CPU_ID_TPC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_1] = CPU_ID_TPC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_2] = CPU_ID_TPC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_0_3] = CPU_ID_TPC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_0] = CPU_ID_TPC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_1] = CPU_ID_TPC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_2] = CPU_ID_TPC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_1_3] = CPU_ID_TPC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_0] = CPU_ID_TPC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_1] = CPU_ID_TPC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_2] = CPU_ID_TPC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_2_3] = CPU_ID_TPC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_0] = CPU_ID_TPC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_1] = CPU_ID_TPC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_2] = CPU_ID_TPC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_3_3] = CPU_ID_TPC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_0] = CPU_ID_TPC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_1] = CPU_ID_TPC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_2] = CPU_ID_TPC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_4_3] = CPU_ID_TPC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_0] = CPU_ID_TPC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_1] = CPU_ID_TPC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_2] = CPU_ID_TPC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_DCORE3_TPC_5_3] = CPU_ID_TPC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_NIC_0_0] = CPU_ID_NIC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_NIC_0_1] = CPU_ID_NIC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_NIC_0_2] = CPU_ID_NIC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_NIC_0_3] = CPU_ID_NIC_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_NIC_1_0] = CPU_ID_NIC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_NIC_1_1] = CPU_ID_NIC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_NIC_1_2] = CPU_ID_NIC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_NIC_1_3] = CPU_ID_NIC_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_NIC_2_0] = CPU_ID_NIC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_NIC_2_1] = CPU_ID_NIC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_NIC_2_2] = CPU_ID_NIC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_NIC_2_3] = CPU_ID_NIC_QMAN_ARC2,
+	[GAUDI2_QUEUE_ID_NIC_3_0] = CPU_ID_NIC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_NIC_3_1] = CPU_ID_NIC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_NIC_3_2] = CPU_ID_NIC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_NIC_3_3] = CPU_ID_NIC_QMAN_ARC3,
+	[GAUDI2_QUEUE_ID_NIC_4_0] = CPU_ID_NIC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_NIC_4_1] = CPU_ID_NIC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_NIC_4_2] = CPU_ID_NIC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_NIC_4_3] = CPU_ID_NIC_QMAN_ARC4,
+	[GAUDI2_QUEUE_ID_NIC_5_0] = CPU_ID_NIC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_NIC_5_1] = CPU_ID_NIC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_NIC_5_2] = CPU_ID_NIC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_NIC_5_3] = CPU_ID_NIC_QMAN_ARC5,
+	[GAUDI2_QUEUE_ID_NIC_6_0] = CPU_ID_NIC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_NIC_6_1] = CPU_ID_NIC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_NIC_6_2] = CPU_ID_NIC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_NIC_6_3] = CPU_ID_NIC_QMAN_ARC6,
+	[GAUDI2_QUEUE_ID_NIC_7_0] = CPU_ID_NIC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_NIC_7_1] = CPU_ID_NIC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_NIC_7_2] = CPU_ID_NIC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_NIC_7_3] = CPU_ID_NIC_QMAN_ARC7,
+	[GAUDI2_QUEUE_ID_NIC_8_0] = CPU_ID_NIC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_NIC_8_1] = CPU_ID_NIC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_NIC_8_2] = CPU_ID_NIC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_NIC_8_3] = CPU_ID_NIC_QMAN_ARC8,
+	[GAUDI2_QUEUE_ID_NIC_9_0] = CPU_ID_NIC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_NIC_9_1] = CPU_ID_NIC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_NIC_9_2] = CPU_ID_NIC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_NIC_9_3] = CPU_ID_NIC_QMAN_ARC9,
+	[GAUDI2_QUEUE_ID_NIC_10_0] = CPU_ID_NIC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_NIC_10_1] = CPU_ID_NIC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_NIC_10_2] = CPU_ID_NIC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_NIC_10_3] = CPU_ID_NIC_QMAN_ARC10,
+	[GAUDI2_QUEUE_ID_NIC_11_0] = CPU_ID_NIC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_NIC_11_1] = CPU_ID_NIC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_NIC_11_2] = CPU_ID_NIC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_NIC_11_3] = CPU_ID_NIC_QMAN_ARC11,
+	[GAUDI2_QUEUE_ID_NIC_12_0] = CPU_ID_NIC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_NIC_12_1] = CPU_ID_NIC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_NIC_12_2] = CPU_ID_NIC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_NIC_12_3] = CPU_ID_NIC_QMAN_ARC12,
+	[GAUDI2_QUEUE_ID_NIC_13_0] = CPU_ID_NIC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_NIC_13_1] = CPU_ID_NIC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_NIC_13_2] = CPU_ID_NIC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_NIC_13_3] = CPU_ID_NIC_QMAN_ARC13,
+	[GAUDI2_QUEUE_ID_NIC_14_0] = CPU_ID_NIC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_NIC_14_1] = CPU_ID_NIC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_NIC_14_2] = CPU_ID_NIC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_NIC_14_3] = CPU_ID_NIC_QMAN_ARC14,
+	[GAUDI2_QUEUE_ID_NIC_15_0] = CPU_ID_NIC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_NIC_15_1] = CPU_ID_NIC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_NIC_15_2] = CPU_ID_NIC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_NIC_15_3] = CPU_ID_NIC_QMAN_ARC15,
+	[GAUDI2_QUEUE_ID_NIC_16_0] = CPU_ID_NIC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_NIC_16_1] = CPU_ID_NIC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_NIC_16_2] = CPU_ID_NIC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_NIC_16_3] = CPU_ID_NIC_QMAN_ARC16,
+	[GAUDI2_QUEUE_ID_NIC_17_0] = CPU_ID_NIC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_NIC_17_1] = CPU_ID_NIC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_NIC_17_2] = CPU_ID_NIC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_NIC_17_3] = CPU_ID_NIC_QMAN_ARC17,
+	[GAUDI2_QUEUE_ID_NIC_18_0] = CPU_ID_NIC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_NIC_18_1] = CPU_ID_NIC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_NIC_18_2] = CPU_ID_NIC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_NIC_18_3] = CPU_ID_NIC_QMAN_ARC18,
+	[GAUDI2_QUEUE_ID_NIC_19_0] = CPU_ID_NIC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_NIC_19_1] = CPU_ID_NIC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_NIC_19_2] = CPU_ID_NIC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_NIC_19_3] = CPU_ID_NIC_QMAN_ARC19,
+	[GAUDI2_QUEUE_ID_NIC_20_0] = CPU_ID_NIC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_NIC_20_1] = CPU_ID_NIC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_NIC_20_2] = CPU_ID_NIC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_NIC_20_3] = CPU_ID_NIC_QMAN_ARC20,
+	[GAUDI2_QUEUE_ID_NIC_21_0] = CPU_ID_NIC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_NIC_21_1] = CPU_ID_NIC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_NIC_21_2] = CPU_ID_NIC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_NIC_21_3] = CPU_ID_NIC_QMAN_ARC21,
+	[GAUDI2_QUEUE_ID_NIC_22_0] = CPU_ID_NIC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_NIC_22_1] = CPU_ID_NIC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_NIC_22_2] = CPU_ID_NIC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_NIC_22_3] = CPU_ID_NIC_QMAN_ARC22,
+	[GAUDI2_QUEUE_ID_NIC_23_0] = CPU_ID_NIC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_NIC_23_1] = CPU_ID_NIC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_NIC_23_2] = CPU_ID_NIC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_NIC_23_3] = CPU_ID_NIC_QMAN_ARC23,
+	[GAUDI2_QUEUE_ID_ROT_0_0] = CPU_ID_ROT_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_ROT_0_1] = CPU_ID_ROT_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_ROT_0_2] = CPU_ID_ROT_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_ROT_0_3] = CPU_ID_ROT_QMAN_ARC0,
+	[GAUDI2_QUEUE_ID_ROT_1_0] = CPU_ID_ROT_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_ROT_1_1] = CPU_ID_ROT_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_ROT_1_2] = CPU_ID_ROT_QMAN_ARC1,
+	[GAUDI2_QUEUE_ID_ROT_1_3] = CPU_ID_ROT_QMAN_ARC1
+};
+
+const u32 gaudi2_dma_core_blocks_bases[DMA_CORE_ID_SIZE] = {
+	[DMA_CORE_ID_PDMA0] = mmPDMA0_CORE_BASE,
+	[DMA_CORE_ID_PDMA1] = mmPDMA1_CORE_BASE,
+	[DMA_CORE_ID_EDMA0] = mmDCORE0_EDMA0_CORE_BASE,
+	[DMA_CORE_ID_EDMA1] = mmDCORE0_EDMA1_CORE_BASE,
+	[DMA_CORE_ID_EDMA2] = mmDCORE1_EDMA0_CORE_BASE,
+	[DMA_CORE_ID_EDMA3] = mmDCORE1_EDMA1_CORE_BASE,
+	[DMA_CORE_ID_EDMA4] = mmDCORE2_EDMA0_CORE_BASE,
+	[DMA_CORE_ID_EDMA5] = mmDCORE2_EDMA1_CORE_BASE,
+	[DMA_CORE_ID_EDMA6] = mmDCORE3_EDMA0_CORE_BASE,
+	[DMA_CORE_ID_EDMA7] = mmDCORE3_EDMA1_CORE_BASE,
+	[DMA_CORE_ID_KDMA] = mmARC_FARM_KDMA_BASE
+};
+
+const u32 gaudi2_mme_acc_blocks_bases[MME_ID_SIZE] = {
+	[MME_ID_DCORE0] = mmDCORE0_MME_ACC_BASE,
+	[MME_ID_DCORE1] = mmDCORE1_MME_ACC_BASE,
+	[MME_ID_DCORE2] = mmDCORE2_MME_ACC_BASE,
+	[MME_ID_DCORE3] = mmDCORE3_MME_ACC_BASE
+};
+
+static const u32 gaudi2_tpc_cfg_blocks_bases[TPC_ID_SIZE] = {
+	[TPC_ID_DCORE0_TPC0] = mmDCORE0_TPC0_CFG_BASE,
+	[TPC_ID_DCORE0_TPC1] = mmDCORE0_TPC1_CFG_BASE,
+	[TPC_ID_DCORE0_TPC2] = mmDCORE0_TPC2_CFG_BASE,
+	[TPC_ID_DCORE0_TPC3] = mmDCORE0_TPC3_CFG_BASE,
+	[TPC_ID_DCORE0_TPC4] = mmDCORE0_TPC4_CFG_BASE,
+	[TPC_ID_DCORE0_TPC5] = mmDCORE0_TPC5_CFG_BASE,
+	[TPC_ID_DCORE1_TPC0] = mmDCORE1_TPC0_CFG_BASE,
+	[TPC_ID_DCORE1_TPC1] = mmDCORE1_TPC1_CFG_BASE,
+	[TPC_ID_DCORE1_TPC2] = mmDCORE1_TPC2_CFG_BASE,
+	[TPC_ID_DCORE1_TPC3] = mmDCORE1_TPC3_CFG_BASE,
+	[TPC_ID_DCORE1_TPC4] = mmDCORE1_TPC4_CFG_BASE,
+	[TPC_ID_DCORE1_TPC5] = mmDCORE1_TPC5_CFG_BASE,
+	[TPC_ID_DCORE2_TPC0] = mmDCORE2_TPC0_CFG_BASE,
+	[TPC_ID_DCORE2_TPC1] = mmDCORE2_TPC1_CFG_BASE,
+	[TPC_ID_DCORE2_TPC2] = mmDCORE2_TPC2_CFG_BASE,
+	[TPC_ID_DCORE2_TPC3] = mmDCORE2_TPC3_CFG_BASE,
+	[TPC_ID_DCORE2_TPC4] = mmDCORE2_TPC4_CFG_BASE,
+	[TPC_ID_DCORE2_TPC5] = mmDCORE2_TPC5_CFG_BASE,
+	[TPC_ID_DCORE3_TPC0] = mmDCORE3_TPC0_CFG_BASE,
+	[TPC_ID_DCORE3_TPC1] = mmDCORE3_TPC1_CFG_BASE,
+	[TPC_ID_DCORE3_TPC2] = mmDCORE3_TPC2_CFG_BASE,
+	[TPC_ID_DCORE3_TPC3] = mmDCORE3_TPC3_CFG_BASE,
+	[TPC_ID_DCORE3_TPC4] = mmDCORE3_TPC4_CFG_BASE,
+	[TPC_ID_DCORE3_TPC5] = mmDCORE3_TPC5_CFG_BASE,
+	[TPC_ID_DCORE0_TPC6] = mmDCORE0_TPC6_CFG_BASE,
+};
+
+const u32 gaudi2_rot_blocks_bases[ROTATOR_ID_SIZE] = {
+	[ROTATOR_ID_0] = mmROT0_BASE,
+	[ROTATOR_ID_1] = mmROT1_BASE
+};
+
+static const u32 gaudi2_tpc_id_to_queue_id[TPC_ID_SIZE] = {
+	[TPC_ID_DCORE0_TPC0] = GAUDI2_QUEUE_ID_DCORE0_TPC_0_0,
+	[TPC_ID_DCORE0_TPC1] = GAUDI2_QUEUE_ID_DCORE0_TPC_1_0,
+	[TPC_ID_DCORE0_TPC2] = GAUDI2_QUEUE_ID_DCORE0_TPC_2_0,
+	[TPC_ID_DCORE0_TPC3] = GAUDI2_QUEUE_ID_DCORE0_TPC_3_0,
+	[TPC_ID_DCORE0_TPC4] = GAUDI2_QUEUE_ID_DCORE0_TPC_4_0,
+	[TPC_ID_DCORE0_TPC5] = GAUDI2_QUEUE_ID_DCORE0_TPC_5_0,
+	[TPC_ID_DCORE1_TPC0] = GAUDI2_QUEUE_ID_DCORE1_TPC_0_0,
+	[TPC_ID_DCORE1_TPC1] = GAUDI2_QUEUE_ID_DCORE1_TPC_1_0,
+	[TPC_ID_DCORE1_TPC2] = GAUDI2_QUEUE_ID_DCORE1_TPC_2_0,
+	[TPC_ID_DCORE1_TPC3] = GAUDI2_QUEUE_ID_DCORE1_TPC_3_0,
+	[TPC_ID_DCORE1_TPC4] = GAUDI2_QUEUE_ID_DCORE1_TPC_4_0,
+	[TPC_ID_DCORE1_TPC5] = GAUDI2_QUEUE_ID_DCORE1_TPC_5_0,
+	[TPC_ID_DCORE2_TPC0] = GAUDI2_QUEUE_ID_DCORE2_TPC_0_0,
+	[TPC_ID_DCORE2_TPC1] = GAUDI2_QUEUE_ID_DCORE2_TPC_1_0,
+	[TPC_ID_DCORE2_TPC2] = GAUDI2_QUEUE_ID_DCORE2_TPC_2_0,
+	[TPC_ID_DCORE2_TPC3] = GAUDI2_QUEUE_ID_DCORE2_TPC_3_0,
+	[TPC_ID_DCORE2_TPC4] = GAUDI2_QUEUE_ID_DCORE2_TPC_4_0,
+	[TPC_ID_DCORE2_TPC5] = GAUDI2_QUEUE_ID_DCORE2_TPC_5_0,
+	[TPC_ID_DCORE3_TPC0] = GAUDI2_QUEUE_ID_DCORE3_TPC_0_0,
+	[TPC_ID_DCORE3_TPC1] = GAUDI2_QUEUE_ID_DCORE3_TPC_1_0,
+	[TPC_ID_DCORE3_TPC2] = GAUDI2_QUEUE_ID_DCORE3_TPC_2_0,
+	[TPC_ID_DCORE3_TPC3] = GAUDI2_QUEUE_ID_DCORE3_TPC_3_0,
+	[TPC_ID_DCORE3_TPC4] = GAUDI2_QUEUE_ID_DCORE3_TPC_4_0,
+	[TPC_ID_DCORE3_TPC5] = GAUDI2_QUEUE_ID_DCORE3_TPC_5_0,
+	[TPC_ID_DCORE0_TPC6] = GAUDI2_QUEUE_ID_DCORE0_TPC_6_0,
+};
+
+static const u32 gaudi2_rot_id_to_queue_id[ROTATOR_ID_SIZE] = {
+	[ROTATOR_ID_0] = GAUDI2_QUEUE_ID_ROT_0_0,
+	[ROTATOR_ID_1] = GAUDI2_QUEUE_ID_ROT_1_0,
+};
+
+const u32 edma_stream_base[NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES] = {
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0,
+};
+
+static const char gaudi2_vdec_irq_name[GAUDI2_VDEC_MSIX_ENTRIES][GAUDI2_MAX_STRING_LEN] = {
+	"gaudi2 vdec 0_0", "gaudi2 vdec 0_0 abnormal",
+	"gaudi2 vdec 0_1", "gaudi2 vdec 0_1 abnormal",
+	"gaudi2 vdec 1_0", "gaudi2 vdec 1_0 abnormal",
+	"gaudi2 vdec 1_1", "gaudi2 vdec 1_1 abnormal",
+	"gaudi2 vdec 2_0", "gaudi2 vdec 2_0 abnormal",
+	"gaudi2 vdec 2_1", "gaudi2 vdec 2_1 abnormal",
+	"gaudi2 vdec 3_0", "gaudi2 vdec 3_0 abnormal",
+	"gaudi2 vdec 3_1", "gaudi2 vdec 3_1 abnormal",
+	"gaudi2 vdec s_0", "gaudi2 vdec s_0 abnormal",
+	"gaudi2 vdec s_1", "gaudi2 vdec s_1 abnormal"
+};
+
+static const u32 rtr_coordinates_to_rtr_id[NUM_OF_RTR_PER_DCORE * NUM_OF_DCORES] = {
+	RTR_ID_X_Y(2, 4),
+	RTR_ID_X_Y(3, 4),
+	RTR_ID_X_Y(4, 4),
+	RTR_ID_X_Y(5, 4),
+	RTR_ID_X_Y(6, 4),
+	RTR_ID_X_Y(7, 4),
+	RTR_ID_X_Y(8, 4),
+	RTR_ID_X_Y(9, 4),
+	RTR_ID_X_Y(10, 4),
+	RTR_ID_X_Y(11, 4),
+	RTR_ID_X_Y(12, 4),
+	RTR_ID_X_Y(13, 4),
+	RTR_ID_X_Y(14, 4),
+	RTR_ID_X_Y(15, 4),
+	RTR_ID_X_Y(16, 4),
+	RTR_ID_X_Y(17, 4),
+	RTR_ID_X_Y(2, 11),
+	RTR_ID_X_Y(3, 11),
+	RTR_ID_X_Y(4, 11),
+	RTR_ID_X_Y(5, 11),
+	RTR_ID_X_Y(6, 11),
+	RTR_ID_X_Y(7, 11),
+	RTR_ID_X_Y(8, 11),
+	RTR_ID_X_Y(9, 11),
+	RTR_ID_X_Y(0, 0),/* 24 no id */
+	RTR_ID_X_Y(0, 0),/* 25 no id */
+	RTR_ID_X_Y(0, 0),/* 26 no id */
+	RTR_ID_X_Y(0, 0),/* 27 no id */
+	RTR_ID_X_Y(14, 11),
+	RTR_ID_X_Y(15, 11),
+	RTR_ID_X_Y(16, 11),
+	RTR_ID_X_Y(17, 11)
+};
+
+static const u32 gaudi2_tpc_initiator_rtr_id[NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1] = {
+	1, 1, 2, 2, 3, 3, 14, 14, 13, 13, 12, 12, 19, 19, 18, 18, 17,
+	17, 28, 28, 29, 29, 30, 30, 0
+};
+
+static const u32 gaudi2_dec_initiator_rtr_id[NUMBER_OF_DEC] = {
+	0, 0, 15, 15, 16, 16, 31, 31, 0, 0
+};
+
+static const u32 gaudi2_nic_initiator_rtr_id[NIC_NUMBER_OF_MACROS] = {
+	15, 15, 15, 15, 15, 16, 16, 16, 16, 31, 31, 31
+};
+
+struct sft_info {
+	u8 interface_id;
+	u8 dcore_id;
+};
+
+static const struct sft_info gaudi2_edma_initiator_sft_id[NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES] = {
+	{0, 0},	{1, 0}, {0, 1}, {1, 1}, {1, 2}, {1, 3},	{0, 2},	{0, 3},
+};
+
+static const u32 gaudi2_pdma_initiator_rtr_id[NUM_OF_PDMA] = {
+	0, 0
+};
+
+static const u32 gaudi2_rot_initiator_rtr_id[NUM_OF_ROT] = {
+	16, 31
+};
+
+struct mme_initiators_rtr_id {
+	u32 wap0;
+	u32 wap1;
+	u32 write;
+	u32 read;
+	u32 sbte0;
+	u32 sbte1;
+	u32 sbte2;
+	u32 sbte3;
+	u32 sbte4;
+};
+
+enum mme_initiators {
+	MME_WAP0 = 0,
+	MME_WAP1,
+	MME_WRITE,
+	MME_READ,
+	MME_SBTE0,
+	MME_SBTE1,
+	MME_SBTE2,
+	MME_SBTE3,
+	MME_SBTE4,
+	MME_INITIATORS_MAX
+};
+
+static const struct mme_initiators_rtr_id
+gaudi2_mme_initiator_rtr_id[NUM_OF_MME_PER_DCORE * NUM_OF_DCORES] = {
+	{ .wap0 = 5, .wap1 = 7, .write = 6, .read = 7,
+	.sbte0 = 7, .sbte1 = 4, .sbte2 = 4, .sbte3 = 5, .sbte4 = 6},
+	{ .wap0 = 10, .wap1 = 8, .write = 9, .read = 8,
+	.sbte0 = 11, .sbte1 = 11, .sbte2 = 10, .sbte3 = 9, .sbte4 = 8},
+	{ .wap0 = 21, .wap1 = 23, .write = 22, .read = 23,
+	.sbte0 = 20, .sbte1 = 20, .sbte2 = 21, .sbte3 = 22, .sbte4 = 23},
+	{ .wap0 = 30, .wap1 = 28, .write = 29, .read = 30,
+	.sbte0 = 31, .sbte1 = 31, .sbte2 = 30, .sbte3 = 29, .sbte4 = 28},
+};
+
+enum razwi_event_sources {
+	RAZWI_TPC,
+	RAZWI_MME,
+	RAZWI_EDMA,
+	RAZWI_PDMA,
+	RAZWI_NIC,
+	RAZWI_DEC,
+	RAZWI_ROT
+};
+
+struct hbm_mc_error_causes {
+	u32 mask;
+	char cause[50];
+};
+
+static struct hbm_mc_error_causes hbm_mc_spi[GAUDI2_NUM_OF_HBM_MC_SPI_CAUSE] = {
+	{HBM_MC_SPI_TEMP_PIN_CHG_MASK, "temperature pins changed"},
+	{HBM_MC_SPI_THR_ENG_MASK, "temperature-based throttling engaged"},
+	{HBM_MC_SPI_THR_DIS_ENG_MASK, "temperature-based throttling disengaged"},
+	{HBM_MC_SPI_IEEE1500_COMP_MASK, "IEEE1500 op comp"},
+	{HBM_MC_SPI_IEEE1500_PAUSED_MASK, "IEEE1500 op paused"},
+};
+
+static const char * const hbm_mc_sei_cause[GAUDI2_NUM_OF_HBM_SEI_CAUSE] = {
+	[HBM_SEI_CMD_PARITY_EVEN] = "SEI C/A parity even",
+	[HBM_SEI_CMD_PARITY_ODD] = "SEI C/A parity odd",
+	[HBM_SEI_READ_ERR] = "SEI read data error",
+	[HBM_SEI_WRITE_DATA_PARITY_ERR] = "SEI write data parity error",
+	[HBM_SEI_CATTRIP] = "SEI CATTRIP asserted",
+	[HBM_SEI_MEM_BIST_FAIL] = "SEI memory BIST fail",
+	[HBM_SEI_DFI] = "SEI DFI error",
+	[HBM_SEI_INV_TEMP_READ_OUT] = "SEI invalid temp read",
+	[HBM_SEI_BIST_FAIL] = "SEI BIST fail"
+};
+
+struct mmu_spi_sei_cause {
+	char cause[50];
+	int clear_bit;
+};
+
+static const struct mmu_spi_sei_cause gaudi2_mmu_spi_sei[GAUDI2_NUM_OF_MMU_SPI_SEI_CAUSE] = {
+	{"page fault", 1},		/* INTERRUPT_CLR[1] */
+	{"page access", 1},		/* INTERRUPT_CLR[1] */
+	{"bypass ddr", 2},		/* INTERRUPT_CLR[2] */
+	{"multi hit", 2},		/* INTERRUPT_CLR[2] */
+	{"mmu rei0", -1},		/* no clear register bit */
+	{"mmu rei1", -1},		/* no clear register bit */
+	{"stlb rei0", -1},		/* no clear register bit */
+	{"stlb rei1", -1},		/* no clear register bit */
+	{"rr privileged write hit", 2},	/* INTERRUPT_CLR[2] */
+	{"rr privileged read hit", 2},	/* INTERRUPT_CLR[2] */
+	{"rr secure write hit", 2},	/* INTERRUPT_CLR[2] */
+	{"rr secure read hit", 2},	/* INTERRUPT_CLR[2] */
+	{"bist_fail no use", 2},	/* INTERRUPT_CLR[2] */
+	{"bist_fail no use", 2},	/* INTERRUPT_CLR[2] */
+	{"bist_fail no use", 2},	/* INTERRUPT_CLR[2] */
+	{"bist_fail no use", 2},	/* INTERRUPT_CLR[2] */
+	{"slave error", 16},		/* INTERRUPT_CLR[16] */
+	{"dec error", 17},		/* INTERRUPT_CLR[17] */
+	{"burst fifo full", 2}		/* INTERRUPT_CLR[2] */
+};
+
+struct gaudi2_cache_invld_params {
+	u64 start_va;
+	u64 end_va;
+	u32 inv_start_val;
+	u32 flags;
+	bool range_invalidation;
+};
+
+struct gaudi2_tpc_idle_data {
+	struct seq_file *s;
+	unsigned long *mask;
+	bool *is_idle;
+	const char *tpc_fmt;
+};
+
+struct gaudi2_tpc_mmu_data {
+	u32 rw_asid;
+};
+
+static s64 gaudi2_state_dump_specs_props[SP_MAX] = {0};
+
+static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val);
+static bool gaudi2_is_queue_enabled(struct hl_device *hdev, u32 hw_queue_id);
+static bool gaudi2_is_arc_enabled(struct hl_device *hdev, u64 arc_id);
+static void gaudi2_clr_arc_id_cap(struct hl_device *hdev, u64 arc_id);
+static void gaudi2_set_arc_id_cap(struct hl_device *hdev, u64 arc_id);
+static void gaudi2_memset_device_lbw(struct hl_device *hdev, u32 addr, u32 size, u32 val);
+static int gaudi2_send_job_to_kdma(struct hl_device *hdev, u64 src_addr, u64 dst_addr, u32 size,
+										bool is_memset);
+static u64 gaudi2_mmu_scramble_addr(struct hl_device *hdev, u64 raw_addr);
+
+static void gaudi2_init_scrambler_hbm(struct hl_device *hdev)
+{
+
+}
+
+static u32 gaudi2_get_signal_cb_size(struct hl_device *hdev)
+{
+	return sizeof(struct packet_msg_short);
+}
+
+static u32 gaudi2_get_wait_cb_size(struct hl_device *hdev)
+{
+	return sizeof(struct packet_msg_short) * 4 + sizeof(struct packet_fence);
+}
+
+void gaudi2_iterate_tpcs(struct hl_device *hdev, struct iterate_module_ctx *ctx)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int dcore, inst, tpc_seq;
+	u32 offset;
+
+	for (dcore = 0; dcore < NUM_OF_DCORES; dcore++) {
+		for (inst = 0; inst < NUM_OF_TPC_PER_DCORE; inst++) {
+			tpc_seq = dcore * NUM_OF_TPC_PER_DCORE + inst;
+
+			if (!(prop->tpc_enabled_mask & BIT(tpc_seq)))
+				continue;
+
+			offset = (DCORE_OFFSET * dcore) + (DCORE_TPC_OFFSET * inst);
+
+			ctx->fn(hdev, dcore, inst, offset, ctx->data);
+		}
+	}
+
+	if (!(prop->tpc_enabled_mask & BIT(TPC_ID_DCORE0_TPC6)))
+		return;
+
+	/* special check for PCI TPC (DCORE0_TPC6) */
+	offset = DCORE_TPC_OFFSET * (NUM_DCORE0_TPC - 1);
+	ctx->fn(hdev, 0, NUM_DCORE0_TPC - 1, offset, ctx->data);
+}
+
+static bool gaudi2_host_phys_addr_valid(u64 addr)
+{
+	if ((addr < HOST_PHYS_BASE_0 + HOST_PHYS_SIZE_0) || (addr >= HOST_PHYS_BASE_1))
+		return true;
+
+	return false;
+}
+
+static int set_number_of_functional_hbms(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u8 faulty_hbms = hweight64(hdev->dram_binning);
+
+	/* check if all HBMs should be used */
+	if (!faulty_hbms) {
+		dev_dbg(hdev->dev, "All HBM are in use (no binning)\n");
+		prop->num_functional_hbms = GAUDI2_HBM_NUM;
+		return 0;
+	}
+
+	/*
+	 * check for error condition in which number of binning
+	 * candidates is higher than the maximum supported by the
+	 * driver (in which case binning mask shall be ignored and driver will
+	 * set the default)
+	 */
+	if (faulty_hbms > MAX_FAULTY_HBMS) {
+		dev_err(hdev->dev,
+			"HBM binning supports max of %d faulty HBMs, supplied mask 0x%llx.\n",
+			MAX_FAULTY_HBMS, hdev->dram_binning);
+		return -EINVAL;
+	}
+
+	/*
+	 * by default, number of functional HBMs in Gaudi2 is always
+	 * GAUDI2_HBM_NUM - 1.
+	 */
+	prop->num_functional_hbms = GAUDI2_HBM_NUM - faulty_hbms;
+	return 0;
+}
+
+static int gaudi2_set_dram_properties(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 basic_hbm_page_size;
+	int rc;
+
+	rc = set_number_of_functional_hbms(hdev);
+	if (rc)
+		return -EINVAL;
+
+	/*
+	 * Due to HW bug in which TLB size is x16 smaller than expected we use a workaround
+	 * in which we are using x16 bigger page size to be able to populate the entire
+	 * HBM mappings in the TLB
+	 */
+	basic_hbm_page_size = prop->num_functional_hbms * SZ_8M;
+	prop->dram_page_size = GAUDI2_COMPENSATE_TLB_PAGE_SIZE_FACTOR * basic_hbm_page_size;
+	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
+	prop->dram_size = prop->num_functional_hbms * SZ_16G;
+	prop->dram_base_address = DRAM_PHYS_BASE;
+	prop->dram_end_address = prop->dram_base_address + prop->dram_size;
+	prop->dram_supports_virtual_memory = true;
+
+	prop->dram_user_base_address = DRAM_PHYS_BASE + prop->dram_page_size;
+	prop->dram_hints_align_mask = ~GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK;
+	prop->hints_dram_reserved_va_range.start_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_START;
+	prop->hints_dram_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_END;
+
+	/* since DRAM page size differs from dmmu page size we need to allocate
+	 * DRAM memory in units of dram_page size and mapping this memory in
+	 * units of DMMU page size. we overcome this size mismatch using a
+	 * scarmbling routine which takes a DRAM page and converts it to a DMMU
+	 * page.
+	 * We therefore:
+	 * 1. partition the virtual address space to DRAM-page (whole) pages.
+	 *    (suppose we get n such pages)
+	 * 2. limit the amount of virtual address space we got from 1 above to
+	 *    a multiple of 64M as we don't want the scrambled address to cross
+	 *    the DRAM virtual address space.
+	 *    ( m = (n * DRAM_page_size) / DMMU_page_size).
+	 * 3. determine the and address accordingly
+	 *    end_addr = start_addr + m * 48M
+	 *
+	 *    the DRAM address MSBs (63:48) are not part of the roundup calculation
+	 */
+	prop->dmmu.start_addr = prop->dram_base_address +
+			roundup(prop->dram_size, prop->dram_page_size);
+
+	prop->dmmu.end_addr = prop->dmmu.start_addr + prop->dram_page_size *
+			div_u64((VA_HBM_SPACE_END - prop->dmmu.start_addr), prop->dmmu.page_size);
+
+	return 0;
+}
+
+static int gaudi2_set_fixed_properties(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hw_queue_properties *q_props;
+	u32 num_sync_stream_queues = 0;
+	int i;
+
+	prop->max_queues = GAUDI2_QUEUE_ID_SIZE;
+	prop->hw_queues_props = kcalloc(prop->max_queues, sizeof(struct hw_queue_properties),
+					GFP_KERNEL);
+
+	if (!prop->hw_queues_props)
+		return -ENOMEM;
+
+	q_props = prop->hw_queues_props;
+
+	for (i = 0 ; i < GAUDI2_QUEUE_ID_CPU_PQ ; i++) {
+		q_props[i].type = QUEUE_TYPE_HW;
+		q_props[i].driver_only = 0;
+
+		if (i >= GAUDI2_QUEUE_ID_NIC_0_0 && i <= GAUDI2_QUEUE_ID_NIC_23_3) {
+			q_props[i].supports_sync_stream = 0;
+		} else {
+			q_props[i].supports_sync_stream = 1;
+			num_sync_stream_queues++;
+		}
+
+		q_props[i].cb_alloc_flags = CB_ALLOC_USER;
+	}
+
+	q_props[GAUDI2_QUEUE_ID_CPU_PQ].type = QUEUE_TYPE_CPU;
+	q_props[GAUDI2_QUEUE_ID_CPU_PQ].driver_only = 1;
+	q_props[GAUDI2_QUEUE_ID_CPU_PQ].cb_alloc_flags = CB_ALLOC_KERNEL;
+
+	prop->cache_line_size = DEVICE_CACHE_LINE_SIZE;
+	prop->cfg_base_address = CFG_BASE;
+	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE_0;
+	prop->host_base_address = HOST_PHYS_BASE_0;
+	prop->host_end_address = prop->host_base_address + HOST_PHYS_SIZE_0;
+	prop->max_pending_cs = GAUDI2_MAX_PENDING_CS;
+	prop->completion_queues_count = GAUDI2_RESERVED_CQ_NUMBER;
+	prop->user_dec_intr_count = NUMBER_OF_DEC;
+	prop->user_interrupt_count = GAUDI2_IRQ_NUM_USER_LAST - GAUDI2_IRQ_NUM_USER_FIRST + 1;
+	prop->completion_mode = HL_COMPLETION_MODE_CS;
+	prop->sync_stream_first_sob = GAUDI2_RESERVED_SOBS;
+	prop->sync_stream_first_mon = GAUDI2_RESERVED_MONITORS;
+
+	prop->sram_base_address = SRAM_BASE_ADDR;
+	prop->sram_size = SRAM_SIZE;
+	prop->sram_end_address = prop->sram_base_address + prop->sram_size;
+	prop->sram_user_base_address = prop->sram_base_address + SRAM_USER_BASE_OFFSET;
+
+	prop->hints_range_reservation = true;
+
+	if (hdev->pldm)
+		prop->mmu_pgt_size = 0x800000; /* 8MB */
+	else
+		prop->mmu_pgt_size = MMU_PAGE_TABLES_INITIAL_SIZE;
+
+	prop->mmu_pte_size = HL_PTE_SIZE;
+	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
+
+	prop->dmmu.hop_shifts[MMU_HOP0] = DHOP0_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP1] = DHOP1_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP2] = DHOP2_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP3] = DHOP3_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP4] = DHOP4_SHIFT;
+	prop->dmmu.hop_masks[MMU_HOP0] = DHOP0_MASK;
+	prop->dmmu.hop_masks[MMU_HOP1] = DHOP1_MASK;
+	prop->dmmu.hop_masks[MMU_HOP2] = DHOP2_MASK;
+	prop->dmmu.hop_masks[MMU_HOP3] = DHOP3_MASK;
+	prop->dmmu.hop_masks[MMU_HOP4] = DHOP4_MASK;
+	prop->dmmu.page_size = PAGE_SIZE_1GB;
+	prop->dmmu.num_hops = MMU_ARCH_6_HOPS;
+	prop->dmmu.last_mask = LAST_MASK;
+	prop->dmmu.host_resident = 1;
+	/* TODO: will be duplicated until implementing per-MMU props */
+	prop->dmmu.hop_table_size = prop->mmu_hop_table_size;
+	prop->dmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+
+	/*
+	 * this is done in order to be able to validate FW descriptor (i.e. validating that
+	 * the addresses and allocated space for FW image does not cross memory bounds).
+	 * for this reason we set the DRAM size to the minimum possible and later it will
+	 * be modified according to what reported in the cpucp info packet
+	 */
+	prop->dram_size = (GAUDI2_HBM_NUM - 1) * SZ_16G;
+
+	hdev->pmmu_huge_range = true;
+	prop->pmmu.host_resident = 1;
+	prop->pmmu.num_hops = MMU_ARCH_6_HOPS;
+	prop->pmmu.last_mask = LAST_MASK;
+	/* TODO: will be duplicated until implementing per-MMU props */
+	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
+	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+
+	prop->hints_host_reserved_va_range.start_addr =	RESERVED_VA_RANGE_FOR_ARC_ON_HOST_START;
+	prop->hints_host_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HOST_END;
+	prop->hints_host_hpage_reserved_va_range.start_addr =
+			RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_START;
+	prop->hints_host_hpage_reserved_va_range.end_addr =
+			RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_END;
+
+	if (PAGE_SIZE == SZ_64K) {
+		prop->pmmu.hop_shifts[MMU_HOP0] = HOP0_SHIFT_64K;
+		prop->pmmu.hop_shifts[MMU_HOP1] = HOP1_SHIFT_64K;
+		prop->pmmu.hop_shifts[MMU_HOP2] = HOP2_SHIFT_64K;
+		prop->pmmu.hop_shifts[MMU_HOP3] = HOP3_SHIFT_64K;
+		prop->pmmu.hop_shifts[MMU_HOP4] = HOP4_SHIFT_64K;
+		prop->pmmu.hop_shifts[MMU_HOP5] = HOP5_SHIFT_64K;
+		prop->pmmu.hop_masks[MMU_HOP0] = HOP0_MASK_64K;
+		prop->pmmu.hop_masks[MMU_HOP1] = HOP1_MASK_64K;
+		prop->pmmu.hop_masks[MMU_HOP2] = HOP2_MASK_64K;
+		prop->pmmu.hop_masks[MMU_HOP3] = HOP3_MASK_64K;
+		prop->pmmu.hop_masks[MMU_HOP4] = HOP4_MASK_64K;
+		prop->pmmu.hop_masks[MMU_HOP5] = HOP5_MASK_64K;
+		prop->pmmu.start_addr = VA_HOST_SPACE_PAGE_START;
+		prop->pmmu.end_addr = VA_HOST_SPACE_PAGE_END;
+		prop->pmmu.page_size = PAGE_SIZE_64KB;
+
+		/* shifts and masks are the same in PMMU and HPMMU */
+		memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
+		prop->pmmu_huge.page_size = PAGE_SIZE_16MB;
+		prop->pmmu_huge.start_addr = VA_HOST_SPACE_HPAGE_START;
+		prop->pmmu_huge.end_addr = VA_HOST_SPACE_HPAGE_END;
+	} else {
+		prop->pmmu.hop_shifts[MMU_HOP0] = HOP0_SHIFT_4K;
+		prop->pmmu.hop_shifts[MMU_HOP1] = HOP1_SHIFT_4K;
+		prop->pmmu.hop_shifts[MMU_HOP2] = HOP2_SHIFT_4K;
+		prop->pmmu.hop_shifts[MMU_HOP3] = HOP3_SHIFT_4K;
+		prop->pmmu.hop_shifts[MMU_HOP4] = HOP4_SHIFT_4K;
+		prop->pmmu.hop_shifts[MMU_HOP5] = HOP5_SHIFT_4K;
+		prop->pmmu.hop_masks[MMU_HOP0] = HOP0_MASK_4K;
+		prop->pmmu.hop_masks[MMU_HOP1] = HOP1_MASK_4K;
+		prop->pmmu.hop_masks[MMU_HOP2] = HOP2_MASK_4K;
+		prop->pmmu.hop_masks[MMU_HOP3] = HOP3_MASK_4K;
+		prop->pmmu.hop_masks[MMU_HOP4] = HOP4_MASK_4K;
+		prop->pmmu.hop_masks[MMU_HOP5] = HOP5_MASK_4K;
+		prop->pmmu.start_addr = VA_HOST_SPACE_PAGE_START;
+		prop->pmmu.end_addr = VA_HOST_SPACE_PAGE_END;
+		prop->pmmu.page_size = PAGE_SIZE_4KB;
+
+		/* shifts and masks are the same in PMMU and HPMMU */
+		memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
+		prop->pmmu_huge.page_size = PAGE_SIZE_2MB;
+		prop->pmmu_huge.start_addr = VA_HOST_SPACE_HPAGE_START;
+		prop->pmmu_huge.end_addr = VA_HOST_SPACE_HPAGE_END;
+	}
+
+	prop->cfg_size = CFG_SIZE;
+	prop->max_asid = MAX_ASID;
+	prop->num_of_events = GAUDI2_EVENT_SIZE;
+
+	prop->dc_power_default = DC_POWER_DEFAULT;
+
+	prop->cb_pool_cb_cnt = GAUDI2_CB_POOL_CB_CNT;
+	prop->cb_pool_cb_size = GAUDI2_CB_POOL_CB_SIZE;
+	prop->pcie_dbi_base_address = CFG_BASE + mmPCIE_DBI_BASE;
+	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
+
+	strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
+
+	prop->mme_master_slave_mode = 1;
+
+	prop->first_available_user_sob[0] = GAUDI2_RESERVED_SOBS +
+					(num_sync_stream_queues * HL_RSVD_SOBS);
+
+	prop->first_available_user_mon[0] = GAUDI2_RESERVED_MONITORS +
+					(num_sync_stream_queues * HL_RSVD_MONS);
+
+	prop->first_available_user_interrupt = GAUDI2_IRQ_NUM_USER_FIRST;
+
+	prop->first_available_cq[0] = GAUDI2_RESERVED_CQ_NUMBER;
+
+	prop->fw_cpu_boot_dev_sts0_valid = false;
+	prop->fw_cpu_boot_dev_sts1_valid = false;
+	prop->hard_reset_done_by_fw = false;
+	prop->gic_interrupts_enable = true;
+
+	prop->server_type = HL_SERVER_TYPE_UNKNOWN;
+
+	prop->cb_va_start_addr = VA_HOST_SPACE_USER_MAPPED_CB_START;
+	prop->cb_va_end_addr = VA_HOST_SPACE_USER_MAPPED_CB_END;
+
+	prop->max_dec = NUMBER_OF_DEC;
+
+	prop->clk_pll_index = HL_GAUDI2_MME_PLL;
+
+	prop->dma_mask = 64;
+
+	return 0;
+}
+
+static int gaudi2_pci_bars_map(struct hl_device *hdev)
+{
+	static const char * const name[] = {"CFG_SRAM", "MSIX", "DRAM"};
+	bool is_wc[3] = {false, false, true};
+	int rc;
+
+	rc = hl_pci_bars_map(hdev, name, is_wc);
+	if (rc)
+		return rc;
+
+	hdev->rmmio = hdev->pcie_bar[SRAM_CFG_BAR_ID] + (CFG_BASE - STM_FLASH_BASE_ADDR);
+
+	return 0;
+}
+
+static u64 gaudi2_set_hbm_bar_base(struct hl_device *hdev, u64 addr)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct hl_inbound_pci_region pci_region;
+	u64 old_addr = addr;
+	int rc;
+
+	if ((gaudi2) && (gaudi2->dram_bar_cur_addr == addr))
+		return old_addr;
+
+	if (hdev->asic_prop.iatu_done_by_fw)
+		return U64_MAX;
+
+	/* Inbound Region 2 - Bar 4 - Point to DRAM */
+	pci_region.mode = PCI_BAR_MATCH_MODE;
+	pci_region.bar = DRAM_BAR_ID;
+	pci_region.addr = addr;
+	rc = hl_pci_set_inbound_region(hdev, 2, &pci_region);
+	if (rc)
+		return U64_MAX;
+
+	if (gaudi2) {
+		old_addr = gaudi2->dram_bar_cur_addr;
+		gaudi2->dram_bar_cur_addr = addr;
+	}
+
+	return old_addr;
+}
+
+static int gaudi2_init_iatu(struct hl_device *hdev)
+{
+	struct hl_inbound_pci_region inbound_region;
+	struct hl_outbound_pci_region outbound_region;
+	u32 bar_addr_low, bar_addr_high;
+	int rc;
+
+	if (hdev->asic_prop.iatu_done_by_fw)
+		return 0;
+
+	/* Temporary inbound Region 0 - Bar 0 - Point to CFG
+	 * We must map this region in BAR match mode in order to
+	 * fetch BAR physical base address
+	 */
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = SRAM_CFG_BAR_ID;
+	/* Base address must be aligned to Bar size which is 256 MB */
+	inbound_region.addr = STM_FLASH_BASE_ADDR - STM_FLASH_ALIGNED_OFF;
+	rc = hl_pci_set_inbound_region(hdev, 0, &inbound_region);
+	if (rc)
+		return rc;
+
+	/* Fetch physical BAR address */
+	bar_addr_high = RREG32(mmPCIE_DBI_BAR1_REG + STM_FLASH_ALIGNED_OFF);
+	bar_addr_low = RREG32(mmPCIE_DBI_BAR0_REG + STM_FLASH_ALIGNED_OFF) & ~0xF;
+
+	hdev->pcie_bar_phys[SRAM_CFG_BAR_ID] = (u64)bar_addr_high << 32 | bar_addr_low;
+
+	/* Inbound Region 0 - Bar 0 - Point to CFG */
+	inbound_region.mode = PCI_ADDRESS_MATCH_MODE;
+	inbound_region.bar = SRAM_CFG_BAR_ID;
+	inbound_region.offset_in_bar = 0;
+	inbound_region.addr = STM_FLASH_BASE_ADDR;
+	inbound_region.size = CFG_REGION_SIZE;
+	rc = hl_pci_set_inbound_region(hdev, 0, &inbound_region);
+	if (rc)
+		return rc;
+
+	/* Inbound Region 1 - Bar 0 - Point to BAR0_RESERVED + SRAM */
+	inbound_region.mode = PCI_ADDRESS_MATCH_MODE;
+	inbound_region.bar = SRAM_CFG_BAR_ID;
+	inbound_region.offset_in_bar = CFG_REGION_SIZE;
+	inbound_region.addr = BAR0_RSRVD_BASE_ADDR;
+	inbound_region.size = BAR0_RSRVD_SIZE + SRAM_SIZE;
+	rc = hl_pci_set_inbound_region(hdev, 1, &inbound_region);
+	if (rc)
+		return rc;
+
+	/* Inbound Region 2 - Bar 4 - Point to DRAM */
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = DRAM_BAR_ID;
+	inbound_region.addr = DRAM_PHYS_BASE;
+	rc = hl_pci_set_inbound_region(hdev, 2, &inbound_region);
+	if (rc)
+		return rc;
+
+	/* Outbound Region 0 - Point to Host */
+	outbound_region.addr = HOST_PHYS_BASE_0;
+	outbound_region.size = HOST_PHYS_SIZE_0;
+	rc = hl_pci_set_outbound_region(hdev, &outbound_region);
+
+	return rc;
+}
+
+static enum hl_device_hw_state gaudi2_get_hw_state(struct hl_device *hdev)
+{
+	return RREG32(mmHW_STATE);
+}
+
+static int gaudi2_tpc_binning_init_prop(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/*
+	 * check for error condition in which number of binning candidates
+	 * is higher than the maximum supported by the driver
+	 */
+	if (hweight64(hdev->tpc_binning) > MAX_CLUSTER_BINNING_FAULTY_TPCS) {
+		dev_err(hdev->dev, "TPC binning is supported for max of %d faulty TPCs, provided mask 0x%llx\n",
+					MAX_CLUSTER_BINNING_FAULTY_TPCS,
+					hdev->tpc_binning);
+		return -EINVAL;
+	}
+
+	prop->tpc_binning_mask = hdev->tpc_binning;
+	prop->tpc_enabled_mask = GAUDI2_TPC_FULL_MASK;
+
+	return 0;
+}
+
+static int gaudi2_set_tpc_binning_masks(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hw_queue_properties *q_props = prop->hw_queues_props;
+	u64 tpc_binning_mask;
+	u8 subst_idx = 0;
+	int i, rc;
+
+	rc = gaudi2_tpc_binning_init_prop(hdev);
+	if (rc)
+		return rc;
+
+	tpc_binning_mask = prop->tpc_binning_mask;
+
+	for (i = 0 ; i < MAX_FAULTY_TPCS ; i++) {
+		u8 subst_seq, binned, qid_base;
+
+		if (tpc_binning_mask == 0)
+			break;
+
+		if (subst_idx == 0) {
+			subst_seq = TPC_ID_DCORE0_TPC6;
+			qid_base = GAUDI2_QUEUE_ID_DCORE0_TPC_6_0;
+		} else {
+			subst_seq = TPC_ID_DCORE3_TPC5;
+			qid_base = GAUDI2_QUEUE_ID_DCORE3_TPC_5_0;
+		}
+
+
+		/* clear bit from mask */
+		binned = __ffs(tpc_binning_mask);
+		/*
+		 * Coverity complains about possible out-of-bound access in
+		 * clear_bit
+		 */
+		if (binned >= TPC_ID_SIZE) {
+			dev_err(hdev->dev,
+				"Invalid binned TPC (binning mask: %llx)\n",
+				tpc_binning_mask);
+			return -EINVAL;
+		}
+		clear_bit(binned, (unsigned long *)&tpc_binning_mask);
+
+		/* also clear replacing TPC bit from enabled mask */
+		clear_bit(subst_seq, (unsigned long *)&prop->tpc_enabled_mask);
+
+		/* bin substite TPC's Qs */
+		q_props[qid_base].binned = 1;
+		q_props[qid_base + 1].binned = 1;
+		q_props[qid_base + 2].binned = 1;
+		q_props[qid_base + 3].binned = 1;
+
+		subst_idx++;
+	}
+
+	return 0;
+}
+
+static int gaudi2_set_dec_binning_masks(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u8 num_faulty;
+
+	num_faulty = hweight32(hdev->decoder_binning);
+
+	/*
+	 * check for error condition in which number of binning candidates
+	 * is higher than the maximum supported by the driver
+	 */
+	if (num_faulty > MAX_FAULTY_DECODERS) {
+		dev_err(hdev->dev, "decoder binning is supported for max of single faulty decoder, provided mask 0x%x\n",
+						hdev->decoder_binning);
+		return -EINVAL;
+	}
+
+	prop->decoder_binning_mask = (hdev->decoder_binning & GAUDI2_DECODER_FULL_MASK);
+
+	if (prop->decoder_binning_mask)
+		prop->decoder_enabled_mask = (GAUDI2_DECODER_FULL_MASK & ~BIT(DEC_ID_PCIE_VDEC1));
+	else
+		prop->decoder_enabled_mask = GAUDI2_DECODER_FULL_MASK;
+
+	return 0;
+}
+
+static void gaudi2_set_dram_binning_masks(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/* check if we should override default binning */
+	if (!hdev->dram_binning) {
+		prop->dram_binning_mask = 0;
+		prop->dram_enabled_mask = GAUDI2_DRAM_FULL_MASK;
+		return;
+	}
+
+	/* set DRAM binning constraints */
+	prop->faulty_dram_cluster_map |= hdev->dram_binning;
+	prop->dram_binning_mask = hdev->dram_binning;
+	prop->dram_enabled_mask = GAUDI2_DRAM_FULL_MASK & ~BIT(HBM_ID5);
+}
+
+static int gaudi2_set_edma_binning_masks(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hw_queue_properties *q_props;
+	u8 seq, num_faulty;
+
+	num_faulty = hweight32(hdev->edma_binning);
+
+	/*
+	 * check for error condition in which number of binning candidates
+	 * is higher than the maximum supported by the driver
+	 */
+	if (num_faulty > MAX_FAULTY_EDMAS) {
+		dev_err(hdev->dev,
+			"EDMA binning is supported for max of single faulty EDMA, provided mask 0x%x\n",
+			hdev->edma_binning);
+		return -EINVAL;
+	}
+
+	if (!hdev->edma_binning) {
+		prop->edma_binning_mask = 0;
+		prop->edma_enabled_mask = GAUDI2_EDMA_FULL_MASK;
+		return 0;
+	}
+
+	seq = __ffs((unsigned long)hdev->edma_binning);
+
+	/* set binning constraints */
+	prop->faulty_dram_cluster_map |= BIT(edma_to_hbm_cluster[seq]);
+	prop->edma_binning_mask = hdev->edma_binning;
+	prop->edma_enabled_mask = GAUDI2_EDMA_FULL_MASK & ~BIT(EDMA_ID_DCORE3_INSTANCE1);
+
+	/* bin substitute EDMA's queue */
+	q_props = prop->hw_queues_props;
+	q_props[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0].binned = 1;
+	q_props[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_1].binned = 1;
+	q_props[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_2].binned = 1;
+	q_props[GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3].binned = 1;
+
+	return 0;
+}
+
+static int gaudi2_set_xbar_edge_enable_mask(struct hl_device *hdev, u32 xbar_edge_iso_mask)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u8 num_faulty, seq;
+
+	/* check if we should override default binning */
+	if (!xbar_edge_iso_mask) {
+		prop->xbar_edge_enabled_mask = GAUDI2_XBAR_EDGE_FULL_MASK;
+		return 0;
+	}
+
+	/*
+	 * note that it can be set to value other than 0 only after cpucp packet (i.e.
+	 * only the FW can set a redundancy value). for user it'll always be 0.
+	 */
+	num_faulty = hweight32(xbar_edge_iso_mask);
+
+	/*
+	 * check for error condition in which number of binning candidates
+	 * is higher than the maximum supported by the driver
+	 */
+	if (num_faulty > MAX_FAULTY_XBARS) {
+		dev_err(hdev->dev, "we cannot have more than %d faulty XBAR EDGE\n",
+									MAX_FAULTY_XBARS);
+		return -EINVAL;
+	}
+
+	seq = __ffs((unsigned long)xbar_edge_iso_mask);
+
+	/* set binning constraints */
+	prop->faulty_dram_cluster_map |= BIT(xbar_edge_to_hbm_cluster[seq]);
+	prop->xbar_edge_enabled_mask = (~xbar_edge_iso_mask) & GAUDI2_XBAR_EDGE_FULL_MASK;
+
+	return 0;
+}
+
+static int gaudi2_set_cluster_binning_masks_common(struct hl_device *hdev, u8 xbar_edge_iso_mask)
+{
+	int rc;
+
+	/*
+	 * mark all clusters as good, each component will "fail" cluster
+	 * based on eFuse/user values.
+	 * If more than single cluster is faulty- the chip is unusable
+	 */
+	hdev->asic_prop.faulty_dram_cluster_map = 0;
+
+	gaudi2_set_dram_binning_masks(hdev);
+
+	rc = gaudi2_set_edma_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_set_xbar_edge_enable_mask(hdev, xbar_edge_iso_mask);
+	if (rc)
+		return rc;
+
+
+	/* always initially set to full mask */
+	hdev->asic_prop.hmmu_hif_enabled_mask = GAUDI2_HIF_HMMU_FULL_MASK;
+
+	return 0;
+}
+
+static int gaudi2_set_cluster_binning_masks(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int rc;
+
+	rc = gaudi2_set_cluster_binning_masks_common(hdev, prop->cpucp_info.xbar_binning_mask);
+	if (rc)
+		return rc;
+
+	/* if we have DRAM binning reported by FW we should perform cluster config  */
+	if (prop->faulty_dram_cluster_map) {
+		u8 cluster_seq = __ffs((unsigned long)prop->faulty_dram_cluster_map);
+
+		prop->hmmu_hif_enabled_mask = cluster_hmmu_hif_enabled_mask[cluster_seq];
+	}
+
+	return 0;
+}
+
+static int gaudi2_cpucp_info_get(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	long max_power;
+	u64 dram_size;
+	int rc;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	/* No point of asking this information again when not doing hard reset, as the device
+	 * CPU hasn't been reset
+	 */
+	if (hdev->reset_info.is_in_soft_reset)
+		return 0;
+
+	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
+										mmCPU_BOOT_ERR1);
+	if (rc)
+		return rc;
+
+	dram_size = le64_to_cpu(prop->cpucp_info.dram_size);
+	if (dram_size) {
+		/* we can have wither 5 or 6 HBMs. other values are invalid */
+
+		if ((dram_size != ((GAUDI2_HBM_NUM - 1) * SZ_16G)) &&
+					(dram_size != (GAUDI2_HBM_NUM  * SZ_16G))) {
+			dev_err(hdev->dev,
+				"F/W reported invalid DRAM size %llu. Trying to use default size %llu\n",
+				dram_size, prop->dram_size);
+			dram_size = prop->dram_size;
+		}
+
+		prop->dram_size = dram_size;
+		prop->dram_end_address = prop->dram_base_address + dram_size;
+	}
+
+	if (!strlen(prop->cpucp_info.card_name))
+		strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
+
+	/* Overwrite binning masks with the actual binning values from F/W */
+	hdev->dram_binning = prop->cpucp_info.dram_binning_mask;
+	hdev->edma_binning = prop->cpucp_info.edma_binning_mask;
+	hdev->tpc_binning = le64_to_cpu(prop->cpucp_info.tpc_binning_mask);
+	hdev->decoder_binning = lower_32_bits(le64_to_cpu(prop->cpucp_info.decoder_binning_mask));
+
+	/*
+	 * at this point the DRAM parameters need to be updated according to data obtained
+	 * from the FW
+	 */
+	rc = gaudi2_set_dram_properties(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_set_cluster_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_set_tpc_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_set_dec_binning_masks(hdev);
+	if (rc)
+		return rc;
+
+	max_power = hl_fw_get_max_power(hdev);
+	if (max_power < 0)
+		return max_power;
+
+	prop->max_power_default = (u64) max_power;
+
+	return 0;
+}
+
+static int gaudi2_fetch_psoc_frequency(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u16 pll_freq_arr[HL_PLL_NUM_OUTPUTS];
+	int rc;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	rc = hl_fw_cpucp_pll_info_get(hdev, HL_GAUDI2_CPU_PLL, pll_freq_arr);
+	if (rc)
+		return rc;
+
+	hdev->asic_prop.psoc_timestamp_frequency = pll_freq_arr[3];
+
+	return 0;
+}
+
+static int gaudi2_early_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct pci_dev *pdev = hdev->pdev;
+	resource_size_t pci_bar_size;
+	u32 fw_boot_status;
+	int rc;
+
+	rc = gaudi2_set_fixed_properties(hdev);
+	if (rc)
+		return rc;
+
+	/* Check BAR sizes */
+	pci_bar_size = pci_resource_len(pdev, SRAM_CFG_BAR_ID);
+
+	if (pci_bar_size != CFG_BAR_SIZE) {
+		dev_err(hdev->dev, "Not " HL_NAME "? BAR %d size %pa, expecting %llu\n",
+			SRAM_CFG_BAR_ID, &pci_bar_size, CFG_BAR_SIZE);
+		rc = -ENODEV;
+		goto free_queue_props;
+	}
+
+	pci_bar_size = pci_resource_len(pdev, MSIX_BAR_ID);
+	if (pci_bar_size != MSIX_BAR_SIZE) {
+		dev_err(hdev->dev, "Not " HL_NAME "? BAR %d size %pa, expecting %llu\n",
+			MSIX_BAR_ID, &pci_bar_size, MSIX_BAR_SIZE);
+		rc = -ENODEV;
+		goto free_queue_props;
+	}
+
+	prop->dram_pci_bar_size = pci_resource_len(pdev, DRAM_BAR_ID);
+	hdev->dram_pci_bar_start = pci_resource_start(pdev, DRAM_BAR_ID);
+
+	/* If FW security is enabled at this point it means no access to ELBI
+	 * Alternatively, the user is working with an unsecured device but
+	 * he wants us to skip the iATU initialization (e.g. ELBI is blocked
+	 * inside the VM)
+	 */
+	if (hdev->asic_prop.fw_security_enabled || hdev->skip_iatu_for_unsecured_device) {
+		hdev->asic_prop.iatu_done_by_fw = true;
+		goto pci_init;
+	}
+
+	rc = hl_pci_elbi_read(hdev, CFG_BASE + mmCPU_BOOT_DEV_STS0, &fw_boot_status);
+	if (rc)
+		goto free_queue_props;
+
+	/* Check whether FW is configuring iATU */
+	if ((fw_boot_status & CPU_BOOT_DEV_STS0_ENABLED) &&
+			(fw_boot_status & CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN))
+		hdev->asic_prop.iatu_done_by_fw = true;
+
+pci_init:
+	rc = hl_pci_init(hdev);
+	if (rc)
+		goto free_queue_props;
+
+	/* Before continuing in the initialization, we need to read the preboot
+	 * version to determine whether we run with a security-enabled firmware
+	 */
+	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
+					mmCPU_BOOT_DEV_STS0,
+					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
+					mmCPU_BOOT_ERR1,
+					GAUDI2_PREBOOT_REQ_TIMEOUT_USEC);
+	if (rc) {
+		if (hdev->reset_on_preboot_fail)
+			hdev->asic_funcs->hw_fini(hdev, true, false);
+		goto pci_fini;
+	}
+
+	if (gaudi2_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
+		dev_info(hdev->dev, "H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->hw_fini(hdev, true, false);
+	}
+
+	return 0;
+
+pci_fini:
+	hl_pci_fini(hdev);
+free_queue_props:
+	kfree(hdev->asic_prop.hw_queues_props);
+	return rc;
+}
+
+static int gaudi2_early_fini(struct hl_device *hdev)
+{
+	kfree(hdev->asic_prop.hw_queues_props);
+	hl_pci_fini(hdev);
+
+	return 0;
+}
+
+static bool gaudi2_is_arc_nic_owned(u64 arc_id)
+{
+	switch (arc_id) {
+	case CPU_ID_NIC_QMAN_ARC0...CPU_ID_NIC_QMAN_ARC23:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool gaudi2_is_arc_tpc_owned(u64 arc_id)
+{
+	switch (arc_id) {
+	case CPU_ID_TPC_QMAN_ARC0...CPU_ID_TPC_QMAN_ARC24:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void gaudi2_init_arcs(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u64 arc_id;
+	u32 i;
+
+	for (i = CPU_ID_SCHED_ARC0 ; i <= CPU_ID_SCHED_ARC3 ; i++) {
+		if (gaudi2_is_arc_enabled(hdev, i))
+			continue;
+
+		gaudi2_set_arc_id_cap(hdev, i);
+	}
+
+	for (i = GAUDI2_QUEUE_ID_PDMA_0_0 ; i < GAUDI2_QUEUE_ID_CPU_PQ ; i += 4) {
+		if (!gaudi2_is_queue_enabled(hdev, i))
+			continue;
+
+		arc_id = gaudi2_queue_id_to_arc_id[i];
+		if (gaudi2_is_arc_enabled(hdev, arc_id))
+			continue;
+
+		if (gaudi2_is_arc_nic_owned(arc_id) &&
+				!(hdev->nic_ports_mask & BIT_ULL(arc_id - CPU_ID_NIC_QMAN_ARC0)))
+			continue;
+
+		if (gaudi2_is_arc_tpc_owned(arc_id) && !(gaudi2->tpc_hw_cap_initialized &
+							BIT_ULL(arc_id - CPU_ID_TPC_QMAN_ARC0)))
+			continue;
+
+		gaudi2_set_arc_id_cap(hdev, arc_id);
+	}
+}
+
+static int gaudi2_scrub_arc_dccm(struct hl_device *hdev, u32 cpu_id)
+{
+	u32 reg_base, reg_val;
+	int rc;
+
+	switch (cpu_id) {
+	case CPU_ID_SCHED_ARC0 ... CPU_ID_SCHED_ARC3:
+		/* Each ARC scheduler has 2 consecutive DCCM blocks */
+		rc = gaudi2_send_job_to_kdma(hdev, 0, CFG_BASE + gaudi2_arc_dccm_bases[cpu_id],
+						ARC_DCCM_BLOCK_SIZE * 2, true);
+		if (rc)
+			return rc;
+		break;
+	case CPU_ID_SCHED_ARC4:
+	case CPU_ID_SCHED_ARC5:
+	case CPU_ID_MME_QMAN_ARC0:
+	case CPU_ID_MME_QMAN_ARC1:
+		reg_base = gaudi2_arc_blocks_bases[cpu_id];
+
+		/* Scrub lower DCCM block */
+		rc = gaudi2_send_job_to_kdma(hdev, 0, CFG_BASE + gaudi2_arc_dccm_bases[cpu_id],
+						ARC_DCCM_BLOCK_SIZE, true);
+		if (rc)
+			return rc;
+
+		/* Switch to upper DCCM block */
+		reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_MME_ARC_UPPER_DCCM_EN_VAL_MASK, 1);
+		WREG32(reg_base + ARC_DCCM_UPPER_EN_OFFSET, reg_val);
+
+		/* Scrub upper DCCM block */
+		rc = gaudi2_send_job_to_kdma(hdev, 0, CFG_BASE + gaudi2_arc_dccm_bases[cpu_id],
+						ARC_DCCM_BLOCK_SIZE, true);
+		if (rc)
+			return rc;
+
+		/* Switch to lower DCCM block */
+		reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_MME_ARC_UPPER_DCCM_EN_VAL_MASK, 0);
+		WREG32(reg_base + ARC_DCCM_UPPER_EN_OFFSET, reg_val);
+		break;
+	default:
+		rc = gaudi2_send_job_to_kdma(hdev, 0, CFG_BASE + gaudi2_arc_dccm_bases[cpu_id],
+						ARC_DCCM_BLOCK_SIZE, true);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static void gaudi2_scrub_arcs_dccm(struct hl_device *hdev)
+{
+	u16 arc_id;
+
+	for (arc_id = CPU_ID_SCHED_ARC0 ; arc_id < CPU_ID_MAX ; arc_id++) {
+		if (!gaudi2_is_arc_enabled(hdev, arc_id))
+			continue;
+
+		gaudi2_scrub_arc_dccm(hdev, arc_id);
+	}
+}
+
+static int gaudi2_late_init(struct hl_device *hdev)
+{
+	int rc;
+
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
+		return rc;
+	}
+
+	rc = gaudi2_fetch_psoc_frequency(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to fetch psoc frequency\n");
+		goto disable_pci_access;
+	}
+
+	gaudi2_init_arcs(hdev);
+	gaudi2_scrub_arcs_dccm(hdev);
+
+	return 0;
+
+disable_pci_access:
+	hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+
+	return rc;
+}
+
+static void gaudi2_late_fini(struct hl_device *hdev)
+{
+	const struct hwmon_channel_info **channel_info_arr;
+	int i = 0;
+
+	if (!hdev->hl_chip_info->info)
+		return;
+
+	channel_info_arr = hdev->hl_chip_info->info;
+
+	while (channel_info_arr[i]) {
+		kfree(channel_info_arr[i]->config);
+		kfree(channel_info_arr[i]);
+		i++;
+	}
+
+	kfree(channel_info_arr);
+
+	hdev->hl_chip_info->info = NULL;
+}
+
+static void gaudi2_user_mapped_dec_init(struct gaudi2_device *gaudi2, u32 start_idx)
+{
+	struct user_mapped_block *blocks = gaudi2->mapped_blocks;
+
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE0_DEC0_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE0_DEC1_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE1_DEC0_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE1_DEC1_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE2_DEC0_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE2_DEC1_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE3_DEC0_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmDCORE3_DEC1_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx++], mmPCIE_DEC0_CMD_BASE, HL_BLOCK_SIZE);
+	HL_USR_MAPPED_BLK_INIT(&blocks[start_idx], mmPCIE_DEC1_CMD_BASE, HL_BLOCK_SIZE);
+}
+
+static void gaudi2_user_mapped_blocks_init(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct user_mapped_block *blocks = gaudi2->mapped_blocks;
+	u32 block_size, umr_start_idx, num_umr_blocks;
+	int i;
+
+	for (i = 0 ; i < NUM_ARC_CPUS ; i++) {
+		if (i >= CPU_ID_SCHED_ARC0 && i <= CPU_ID_SCHED_ARC3)
+			block_size = ARC_DCCM_BLOCK_SIZE * 2;
+		else
+			block_size = ARC_DCCM_BLOCK_SIZE;
+
+		blocks[i].address = gaudi2_arc_dccm_bases[i];
+		blocks[i].size = block_size;
+	}
+
+	blocks[NUM_ARC_CPUS].address = mmARC_FARM_ARC0_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 1].address = mmARC_FARM_ARC1_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 1].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 2].address = mmARC_FARM_ARC2_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 2].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 3].address = mmARC_FARM_ARC3_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 3].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 4].address = mmDCORE0_MME_QM_ARC_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 4].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 5].address = mmDCORE1_MME_QM_ARC_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 5].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 6].address = mmDCORE2_MME_QM_ARC_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 6].size = HL_BLOCK_SIZE;
+
+	blocks[NUM_ARC_CPUS + 7].address = mmDCORE3_MME_QM_ARC_ACP_ENG_BASE;
+	blocks[NUM_ARC_CPUS + 7].size = HL_BLOCK_SIZE;
+
+	umr_start_idx = NUM_ARC_CPUS + NUM_OF_USER_ACP_BLOCKS;
+	num_umr_blocks = NIC_NUMBER_OF_ENGINES * NUM_OF_USER_NIC_UMR_BLOCKS;
+	for (i = 0 ; i < num_umr_blocks ; i++) {
+		u8 nic_id, umr_block_id;
+
+		nic_id = i / NUM_OF_USER_NIC_UMR_BLOCKS;
+		umr_block_id = i % NUM_OF_USER_NIC_UMR_BLOCKS;
+
+		blocks[umr_start_idx + i].address =
+			mmNIC0_UMR0_0_UNSECURE_DOORBELL0_BASE +
+			(nic_id / NIC_NUMBER_OF_QM_PER_MACRO) * NIC_OFFSET +
+			(nic_id % NIC_NUMBER_OF_QM_PER_MACRO) * NIC_QM_OFFSET +
+			umr_block_id * NIC_UMR_OFFSET;
+		blocks[umr_start_idx + i].size = HL_BLOCK_SIZE;
+	}
+
+	/* Expose decoder HW configuration block to user */
+	gaudi2_user_mapped_dec_init(gaudi2, USR_MAPPED_BLK_DEC_START_IDX);
+
+	for (i = 1; i < NUM_OF_DCORES; ++i) {
+		blocks[USR_MAPPED_BLK_SM_START_IDX + 2 * (i - 1)].size = SM_OBJS_BLOCK_SIZE;
+		blocks[USR_MAPPED_BLK_SM_START_IDX + 2 * (i - 1) + 1].size = HL_BLOCK_SIZE;
+
+		blocks[USR_MAPPED_BLK_SM_START_IDX + 2 * (i - 1)].address =
+						mmDCORE0_SYNC_MNGR_OBJS_BASE + i * DCORE_OFFSET;
+
+		blocks[USR_MAPPED_BLK_SM_START_IDX + 2 * (i - 1) + 1].address =
+						mmDCORE0_SYNC_MNGR_GLBL_BASE + i * DCORE_OFFSET;
+	}
+}
+
+static int gaudi2_alloc_cpu_accessible_dma_mem(struct hl_device *hdev)
+{
+	dma_addr_t dma_addr_arr[GAUDI2_ALLOC_CPU_MEM_RETRY_CNT] = {}, end_addr;
+	void *virt_addr_arr[GAUDI2_ALLOC_CPU_MEM_RETRY_CNT] = {};
+	int i, j, rc = 0;
+
+	/* The device ARC works with 32-bits addresses, and because there is a single HW register
+	 * that holds the extension bits (49..28), these bits must be identical in all the allocated
+	 * range.
+	 */
+
+	for (i = 0 ; i < GAUDI2_ALLOC_CPU_MEM_RETRY_CNT ; i++) {
+		virt_addr_arr[i] = hl_asic_dma_alloc_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
+							&dma_addr_arr[i], GFP_KERNEL | __GFP_ZERO);
+		if (!virt_addr_arr[i]) {
+			rc = -ENOMEM;
+			goto free_dma_mem_arr;
+		}
+
+		end_addr = dma_addr_arr[i] + HL_CPU_ACCESSIBLE_MEM_SIZE - 1;
+		if (GAUDI2_ARC_PCI_MSB_ADDR(dma_addr_arr[i]) == GAUDI2_ARC_PCI_MSB_ADDR(end_addr))
+			break;
+	}
+
+	if (i == GAUDI2_ALLOC_CPU_MEM_RETRY_CNT) {
+		dev_err(hdev->dev,
+			"MSB of ARC accessible DMA memory are not identical in all range\n");
+		rc = -EFAULT;
+		goto free_dma_mem_arr;
+	}
+
+	hdev->cpu_accessible_dma_mem = virt_addr_arr[i];
+	hdev->cpu_accessible_dma_address = dma_addr_arr[i];
+
+free_dma_mem_arr:
+	for (j = 0 ; j < i ; j++)
+		hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, virt_addr_arr[j],
+						dma_addr_arr[j]);
+
+	return rc;
+}
+
+static void gaudi2_set_pci_memory_regions(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct pci_mem_region *region;
+
+	/* CFG */
+	region = &hdev->pci_mem_region[PCI_REGION_CFG];
+	region->region_base = CFG_BASE;
+	region->region_size = CFG_SIZE;
+	region->offset_in_bar = CFG_BASE - STM_FLASH_BASE_ADDR;
+	region->bar_size = CFG_BAR_SIZE;
+	region->bar_id = SRAM_CFG_BAR_ID;
+	region->used = 1;
+
+	/* SRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_SRAM];
+	region->region_base = SRAM_BASE_ADDR;
+	region->region_size = SRAM_SIZE;
+	region->offset_in_bar = CFG_REGION_SIZE + BAR0_RSRVD_SIZE;
+	region->bar_size = CFG_BAR_SIZE;
+	region->bar_id = SRAM_CFG_BAR_ID;
+	region->used = 1;
+
+	/* DRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_DRAM];
+	region->region_base = DRAM_PHYS_BASE;
+	region->region_size = hdev->asic_prop.dram_size;
+	region->offset_in_bar = 0;
+	region->bar_size = prop->dram_pci_bar_size;
+	region->bar_id = DRAM_BAR_ID;
+	region->used = 1;
+}
+
+static void gaudi2_user_interrupt_setup(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int i, j, k;
+
+	/* Initialize common user interrupt */
+	HL_USR_INTR_STRUCT_INIT(hdev->common_user_interrupt, hdev, HL_COMMON_USER_INTERRUPT_ID,
+				false);
+
+	/* User interrupts structure holds both decoder and user interrupts from various engines.
+	 * We first initialize the decoder interrupts and then we add the user interrupts.
+	 * The only limitation is that the last decoder interrupt id must be smaller
+	 * then GAUDI2_IRQ_NUM_USER_FIRST. This is checked at compilation time.
+	 */
+
+	/* Initialize decoder interrupts, expose only normal interrupts,
+	 * error interrupts to be handled by driver
+	 */
+	for (i = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM, j = 0 ; i <= GAUDI2_IRQ_NUM_SHARED_DEC1_NRM;
+										i += 2, j++)
+		HL_USR_INTR_STRUCT_INIT(hdev->user_interrupt[j], hdev, i, true);
+
+	for (i = GAUDI2_IRQ_NUM_USER_FIRST, k = 0 ; k < prop->user_interrupt_count; i++, j++, k++)
+		HL_USR_INTR_STRUCT_INIT(hdev->user_interrupt[j], hdev, i, false);
+}
+
+static inline int gaudi2_get_non_zero_random_int(void)
+{
+	int rand = get_random_int();
+
+	return rand ? rand : 1;
+}
+
+static int gaudi2_sw_init(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2;
+	int i, rc;
+
+	/* Allocate device structure */
+	gaudi2 = kzalloc(sizeof(*gaudi2), GFP_KERNEL);
+	if (!gaudi2)
+		return -ENOMEM;
+
+	for (i = 0 ; i < ARRAY_SIZE(gaudi2_irq_map_table) ; i++) {
+		if (gaudi2_irq_map_table[i].msg || !gaudi2_irq_map_table[i].valid)
+			continue;
+
+		if (gaudi2->num_of_valid_hw_events == GAUDI2_EVENT_SIZE) {
+			dev_err(hdev->dev, "H/W events array exceeds the limit of %u events\n",
+				GAUDI2_EVENT_SIZE);
+			rc = -EINVAL;
+			goto free_gaudi2_device;
+		}
+
+		gaudi2->hw_events[gaudi2->num_of_valid_hw_events++] = gaudi2_irq_map_table[i].fc_id;
+	}
+
+	for (i = 0 ; i < MME_NUM_OF_LFSR_SEEDS ; i++)
+		gaudi2->lfsr_rand_seeds[i] = gaudi2_get_non_zero_random_int();
+
+	gaudi2->cpucp_info_get = gaudi2_cpucp_info_get;
+
+	hdev->asic_specific = gaudi2;
+
+	/* Create DMA pool for small allocations.
+	 * Use DEVICE_CACHE_LINE_SIZE for alignment since the NIC memory-mapped
+	 * PI/CI registers allocated from this pool have this restriction
+	 */
+	hdev->dma_pool = dma_pool_create(dev_name(hdev->dev), &hdev->pdev->dev,
+					GAUDI2_DMA_POOL_BLK_SIZE, DEVICE_CACHE_LINE_SIZE, 0);
+	if (!hdev->dma_pool) {
+		dev_err(hdev->dev, "failed to create DMA pool\n");
+		rc = -ENOMEM;
+		goto free_gaudi2_device;
+	}
+
+	rc = gaudi2_alloc_cpu_accessible_dma_mem(hdev);
+	if (rc)
+		goto free_dma_pool;
+
+	hdev->cpu_accessible_dma_pool = gen_pool_create(ilog2(32), -1);
+	if (!hdev->cpu_accessible_dma_pool) {
+		dev_err(hdev->dev, "Failed to create CPU accessible DMA pool\n");
+		rc = -ENOMEM;
+		goto free_cpu_dma_mem;
+	}
+
+	rc = gen_pool_add(hdev->cpu_accessible_dma_pool, (uintptr_t) hdev->cpu_accessible_dma_mem,
+				HL_CPU_ACCESSIBLE_MEM_SIZE, -1);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to add memory to CPU accessible DMA pool\n");
+		rc = -EFAULT;
+		goto free_cpu_accessible_dma_pool;
+	}
+
+	spin_lock_init(&gaudi2->hw_queues_lock);
+	spin_lock_init(&gaudi2->kdma_lock);
+
+	gaudi2->scratchpad_kernel_address = hl_asic_dma_alloc_coherent(hdev, PAGE_SIZE,
+							&gaudi2->scratchpad_bus_address,
+							GFP_KERNEL | __GFP_ZERO);
+	if (!gaudi2->scratchpad_kernel_address) {
+		rc = -ENOMEM;
+		goto free_cpu_accessible_dma_pool;
+	}
+
+	gaudi2_user_mapped_blocks_init(hdev);
+
+	/* Initialize user interrupts */
+	gaudi2_user_interrupt_setup(hdev);
+
+	hdev->supports_coresight = true;
+	hdev->asic_prop.supports_soft_reset = true;
+	hdev->supports_sync_stream = true;
+	hdev->supports_cb_mapping = true;
+	hdev->supports_wait_for_multi_cs = false;
+
+	hdev->asic_funcs->set_pci_memory_regions(hdev);
+
+	return 0;
+
+free_cpu_accessible_dma_pool:
+	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
+free_cpu_dma_mem:
+	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
+					hdev->cpu_accessible_dma_address);
+free_dma_pool:
+	dma_pool_destroy(hdev->dma_pool);
+free_gaudi2_device:
+	kfree(gaudi2);
+	return rc;
+}
+
+static int gaudi2_sw_fini(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
+
+	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
+						hdev->cpu_accessible_dma_address);
+
+	hl_asic_dma_free_coherent(hdev, PAGE_SIZE, gaudi2->scratchpad_kernel_address,
+					gaudi2->scratchpad_bus_address);
+
+	dma_pool_destroy(hdev->dma_pool);
+
+	kfree(gaudi2);
+
+	return 0;
+}
+
+static void gaudi2_stop_qman_common(struct hl_device *hdev, u32 reg_base)
+{
+	WREG32(reg_base + QM_GLBL_CFG1_OFFSET, QM_GLBL_CFG1_PQF_STOP |
+						QM_GLBL_CFG1_CQF_STOP |
+						QM_GLBL_CFG1_CP_STOP);
+
+	/* stop also the ARC */
+	WREG32(reg_base + QM_GLBL_CFG2_OFFSET, QM_GLBL_CFG2_ARC_CQF_STOP);
+}
+
+static void gaudi2_flush_qman_common(struct hl_device *hdev, u32 reg_base)
+{
+	WREG32(reg_base + QM_GLBL_CFG1_OFFSET, QM_GLBL_CFG1_PQF_FLUSH |
+						QM_GLBL_CFG1_CQF_FLUSH |
+						QM_GLBL_CFG1_CP_FLUSH);
+}
+
+static void gaudi2_flush_qman_arc_common(struct hl_device *hdev, u32 reg_base)
+{
+	WREG32(reg_base + QM_GLBL_CFG2_OFFSET, QM_GLBL_CFG2_ARC_CQF_FLUSH);
+}
+
+/**
+ * gaudi2_clear_qm_fence_counters_common - clear QM's fence counters
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @queue_id: queue to clear fence counters to
+ * @skip_fence: if true set maximum fence value to all fence counters to avoid
+ *              getting stuck on any fence value. otherwise set all fence
+ *              counters to 0 (standard clear of fence counters)
+ */
+static void gaudi2_clear_qm_fence_counters_common(struct hl_device *hdev, u32 queue_id,
+						bool skip_fence)
+{
+	u32 size, reg_base;
+	u32 addr, val;
+
+	reg_base = gaudi2_qm_blocks_bases[queue_id];
+
+	addr = reg_base + QM_CP_FENCE0_CNT_0_OFFSET;
+	size = mmPDMA0_QM_CP_BARRIER_CFG - mmPDMA0_QM_CP_FENCE0_CNT_0;
+
+	/*
+	 * in case we want to make sure that QM that is stuck on a fence will
+	 * be released we should set the fence counter to a higher value that
+	 * the value the QM waiting for. to comply with any fence counter of
+	 * any value we set maximum fence value to all counters
+	 */
+	val = skip_fence ? U32_MAX : 0;
+	gaudi2_memset_device_lbw(hdev, addr, size, val);
+}
+
+static void gaudi2_qman_manual_flush_common(struct hl_device *hdev, u32 queue_id)
+{
+	u32 reg_base = gaudi2_qm_blocks_bases[queue_id];
+
+	gaudi2_clear_qm_fence_counters_common(hdev, queue_id, true);
+	gaudi2_flush_qman_common(hdev, reg_base);
+	gaudi2_flush_qman_arc_common(hdev, reg_base);
+}
+
+static void gaudi2_stop_dma_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int dcore, inst;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_PDMA_MASK))
+		goto stop_edma_qmans;
+
+	/* Stop CPs of PDMA QMANs */
+	gaudi2_stop_qman_common(hdev, mmPDMA0_QM_BASE);
+	gaudi2_stop_qman_common(hdev, mmPDMA1_QM_BASE);
+
+stop_edma_qmans:
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_EDMA_MASK))
+		return;
+
+	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+		for (inst = 0 ; inst < NUM_OF_EDMA_PER_DCORE ; inst++) {
+			u8 seq = dcore * NUM_OF_EDMA_PER_DCORE + inst;
+			u32 qm_base;
+
+			if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_EDMA_SHIFT + seq)))
+				continue;
+
+			qm_base = mmDCORE0_EDMA0_QM_BASE + dcore * DCORE_OFFSET +
+					inst * DCORE_EDMA_OFFSET;
+
+			/* Stop CPs of EDMA QMANs */
+			gaudi2_stop_qman_common(hdev, qm_base);
+		}
+	}
+}
+
+static void gaudi2_stop_mme_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 offset, i;
+
+	offset = mmDCORE1_MME_QM_BASE - mmDCORE0_MME_QM_BASE;
+
+	for (i = 0 ; i < NUM_OF_DCORES ; i++) {
+		if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_MME_SHIFT + i)))
+			continue;
+
+		gaudi2_stop_qman_common(hdev, mmDCORE0_MME_QM_BASE + (i * offset));
+	}
+}
+
+static void gaudi2_stop_tpc_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+	int i;
+
+	if (!(gaudi2->tpc_hw_cap_initialized & HW_CAP_TPC_MASK))
+		return;
+
+	for (i = 0 ; i < TPC_ID_SIZE ; i++) {
+		if (!(gaudi2->tpc_hw_cap_initialized & BIT_ULL(HW_CAP_TPC_SHIFT + i)))
+			continue;
+
+		reg_base = gaudi2_qm_blocks_bases[gaudi2_tpc_id_to_queue_id[i]];
+		gaudi2_stop_qman_common(hdev, reg_base);
+	}
+}
+
+static void gaudi2_stop_rot_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+	int i;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_ROT_MASK))
+		return;
+
+	for (i = 0 ; i < ROTATOR_ID_SIZE ; i++) {
+		if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_ROT_SHIFT + i)))
+			continue;
+
+		reg_base = gaudi2_qm_blocks_bases[gaudi2_rot_id_to_queue_id[i]];
+		gaudi2_stop_qman_common(hdev, reg_base);
+	}
+}
+
+static void gaudi2_stop_nic_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base, queue_id;
+	int i;
+
+	if (!(gaudi2->nic_hw_cap_initialized & HW_CAP_NIC_MASK))
+		return;
+
+	queue_id = GAUDI2_QUEUE_ID_NIC_0_0;
+
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++, queue_id += NUM_OF_PQ_PER_QMAN) {
+		if (!(hdev->nic_ports_mask & BIT(i)))
+			continue;
+
+		reg_base = gaudi2_qm_blocks_bases[queue_id];
+		gaudi2_stop_qman_common(hdev, reg_base);
+	}
+}
+
+static void gaudi2_stall_dma_common(struct hl_device *hdev, u32 reg_base)
+{
+	u32 reg_val;
+
+	reg_val = FIELD_PREP(PDMA0_CORE_CFG_1_HALT_MASK, 0x1);
+	WREG32(reg_base + DMA_CORE_CFG_1_OFFSET, reg_val);
+}
+
+static void gaudi2_dma_stall(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int dcore, inst;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_PDMA_MASK))
+		goto stall_edma;
+
+	gaudi2_stall_dma_common(hdev, mmPDMA0_CORE_BASE);
+	gaudi2_stall_dma_common(hdev, mmPDMA1_CORE_BASE);
+
+stall_edma:
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_EDMA_MASK))
+		return;
+
+	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+		for (inst = 0 ; inst < NUM_OF_EDMA_PER_DCORE ; inst++) {
+			u8 seq = dcore * NUM_OF_EDMA_PER_DCORE + inst;
+			u32 core_base;
+
+			if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_EDMA_SHIFT + seq)))
+				continue;
+
+			core_base = mmDCORE0_EDMA0_CORE_BASE + dcore * DCORE_OFFSET +
+					inst * DCORE_EDMA_OFFSET;
+
+			/* Stall CPs of EDMA QMANs */
+			gaudi2_stall_dma_common(hdev, core_base);
+		}
+	}
+}
+
+static void gaudi2_mme_stall(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 offset, i;
+
+	offset = mmDCORE1_MME_CTRL_LO_QM_STALL - mmDCORE0_MME_CTRL_LO_QM_STALL;
+
+	for (i = 0 ; i < NUM_OF_DCORES ; i++)
+		if (gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_MME_SHIFT + i))
+			WREG32(mmDCORE0_MME_CTRL_LO_QM_STALL + (i * offset), 1);
+}
+
+static void gaudi2_tpc_stall(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+	int i;
+
+	if (!(gaudi2->tpc_hw_cap_initialized & HW_CAP_TPC_MASK))
+		return;
+
+	for (i = 0 ; i < TPC_ID_SIZE ; i++) {
+		if (!(gaudi2->tpc_hw_cap_initialized & BIT_ULL(HW_CAP_TPC_SHIFT + i)))
+			continue;
+
+		reg_base = gaudi2_tpc_cfg_blocks_bases[i];
+		WREG32(reg_base + TPC_CFG_STALL_OFFSET, 1);
+	}
+}
+
+static void gaudi2_rotator_stall(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_val;
+	int i;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_ROT_MASK))
+		return;
+
+	reg_val = FIELD_PREP(ROT_MSS_HALT_WBC_MASK, 0x1) |
+			FIELD_PREP(ROT_MSS_HALT_RSB_MASK, 0x1) |
+			FIELD_PREP(ROT_MSS_HALT_MRSB_MASK, 0x1);
+
+	for (i = 0 ; i < ROTATOR_ID_SIZE ; i++) {
+		if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_ROT_SHIFT + i)))
+			continue;
+
+		WREG32(mmROT0_MSS_HALT + i * ROT_OFFSET, reg_val);
+	}
+}
+
+static void gaudi2_disable_qman_common(struct hl_device *hdev, u32 reg_base)
+{
+	WREG32(reg_base + QM_GLBL_CFG0_OFFSET, 0);
+}
+
+static void gaudi2_disable_dma_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int dcore, inst;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_PDMA_MASK))
+		goto stop_edma_qmans;
+
+	gaudi2_disable_qman_common(hdev, mmPDMA0_QM_BASE);
+	gaudi2_disable_qman_common(hdev, mmPDMA1_QM_BASE);
+
+stop_edma_qmans:
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_EDMA_MASK))
+		return;
+
+	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+		for (inst = 0 ; inst < NUM_OF_EDMA_PER_DCORE ; inst++) {
+			u8 seq = dcore * NUM_OF_EDMA_PER_DCORE + inst;
+			u32 qm_base;
+
+			if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_EDMA_SHIFT + seq)))
+				continue;
+
+			qm_base = mmDCORE0_EDMA0_QM_BASE + dcore * DCORE_OFFSET +
+					inst * DCORE_EDMA_OFFSET;
+
+			/* Disable CPs of EDMA QMANs */
+			gaudi2_disable_qman_common(hdev, qm_base);
+		}
+	}
+}
+
+static void gaudi2_disable_mme_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 offset, i;
+
+	offset = mmDCORE1_MME_QM_BASE - mmDCORE0_MME_QM_BASE;
+
+	for (i = 0 ; i < NUM_OF_DCORES ; i++)
+		if (gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_MME_SHIFT + i))
+			gaudi2_disable_qman_common(hdev, mmDCORE0_MME_QM_BASE + (i * offset));
+}
+
+static void gaudi2_disable_tpc_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+	int i;
+
+	if (!(gaudi2->tpc_hw_cap_initialized & HW_CAP_TPC_MASK))
+		return;
+
+	for (i = 0 ; i < TPC_ID_SIZE ; i++) {
+		if (!(gaudi2->tpc_hw_cap_initialized & BIT_ULL(HW_CAP_TPC_SHIFT + i)))
+			continue;
+
+		reg_base = gaudi2_qm_blocks_bases[gaudi2_tpc_id_to_queue_id[i]];
+		gaudi2_disable_qman_common(hdev, reg_base);
+	}
+}
+
+static void gaudi2_disable_rot_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+	int i;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_ROT_MASK))
+		return;
+
+	for (i = 0 ; i < ROTATOR_ID_SIZE ; i++) {
+		if (!(gaudi2->hw_cap_initialized & BIT_ULL(HW_CAP_ROT_SHIFT + i)))
+			continue;
+
+		reg_base = gaudi2_qm_blocks_bases[gaudi2_rot_id_to_queue_id[i]];
+		gaudi2_disable_qman_common(hdev, reg_base);
+	}
+}
+
+static void gaudi2_disable_nic_qmans(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base, queue_id;
+	int i;
+
+	if (!(gaudi2->nic_hw_cap_initialized & HW_CAP_NIC_MASK))
+		return;
+
+	queue_id = GAUDI2_QUEUE_ID_NIC_0_0;
+
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++, queue_id += NUM_OF_PQ_PER_QMAN) {
+		if (!(hdev->nic_ports_mask & BIT(i)))
+			continue;
+
+		reg_base = gaudi2_qm_blocks_bases[queue_id];
+		gaudi2_disable_qman_common(hdev, reg_base);
+	}
+}
+
+static void gaudi2_enable_timestamp(struct hl_device *hdev)
+{
+	/* Disable the timestamp counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE, 0);
+
+	/* Zero the lower/upper parts of the 64-bit counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE + 0xC, 0);
+	WREG32(mmPSOC_TIMESTAMP_BASE + 0x8, 0);
+
+	/* Enable the counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE, 1);
+}
+
+static void gaudi2_disable_timestamp(struct hl_device *hdev)
+{
+	/* Disable the timestamp counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE, 0);
+}
+
+static const char *gaudi2_irq_name(u16 irq_number)
+{
+	switch (irq_number) {
+	case GAUDI2_IRQ_NUM_EVENT_QUEUE:
+		return "gaudi2 cpu eq";
+	case GAUDI2_IRQ_NUM_COMPLETION:
+		return "gaudi2 completion";
+	case GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM ... GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM:
+		return gaudi2_vdec_irq_name[irq_number - GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM];
+	case GAUDI2_IRQ_NUM_USER_FIRST ... GAUDI2_IRQ_NUM_USER_LAST:
+		return "gaudi2 user completion";
+	default:
+		return "invalid";
+	}
+}
+
+static void gaudi2_dec_disable_msix(struct hl_device *hdev, u32 max_irq_num)
+{
+	int i, irq, relative_idx;
+	struct hl_dec *dec;
+
+	for (i = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM ; i < max_irq_num ; i++) {
+		irq = pci_irq_vector(hdev->pdev, i);
+		relative_idx = i - GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM;
+
+		dec = hdev->dec + relative_idx / 2;
+
+		/* We pass different structures depending on the irq handler. For the abnormal
+		 * interrupt we pass hl_dec and for the regular interrupt we pass the relevant
+		 * user_interrupt entry
+		 */
+		free_irq(irq, ((relative_idx % 2) ?
+				(void *) dec :
+				(void *) &hdev->user_interrupt[dec->core_id]));
+	}
+}
+
+static int gaudi2_dec_enable_msix(struct hl_device *hdev)
+{
+	int rc, i, irq_init_cnt, irq, relative_idx;
+	irq_handler_t irq_handler;
+	struct hl_dec *dec;
+
+	for (i = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM, irq_init_cnt = 0;
+			i <= GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM;
+			i++, irq_init_cnt++) {
+
+		irq = pci_irq_vector(hdev->pdev, i);
+		relative_idx = i - GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM;
+
+		irq_handler = (relative_idx % 2) ?
+				hl_irq_handler_dec_abnrm :
+				hl_irq_handler_user_interrupt;
+
+		dec = hdev->dec + relative_idx / 2;
+
+		/* We pass different structures depending on the irq handler. For the abnormal
+		 * interrupt we pass hl_dec and for the regular interrupt we pass the relevant
+		 * user_interrupt entry
+		 */
+		rc = request_irq(irq, irq_handler, 0, gaudi2_irq_name(i),
+				((relative_idx % 2) ?
+				(void *) dec :
+				(void *) &hdev->user_interrupt[dec->core_id]));
+		if (rc) {
+			dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+			goto free_dec_irqs;
+		}
+	}
+
+	return 0;
+
+free_dec_irqs:
+	gaudi2_dec_disable_msix(hdev, (GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM + irq_init_cnt));
+	return rc;
+}
+
+static int gaudi2_enable_msix(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int rc, irq, i, j, user_irq_init_cnt;
+	irq_handler_t irq_handler;
+	struct hl_cq *cq;
+
+	if (gaudi2->hw_cap_initialized & HW_CAP_MSIX)
+		return 0;
+
+	rc = pci_alloc_irq_vectors(hdev->pdev, GAUDI2_MSIX_ENTRIES, GAUDI2_MSIX_ENTRIES,
+					PCI_IRQ_MSIX);
+	if (rc < 0) {
+		dev_err(hdev->dev, "MSI-X: Failed to enable support -- %d/%d\n",
+			GAUDI2_MSIX_ENTRIES, rc);
+		return rc;
+	}
+
+	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
+	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_COMPLETION];
+	rc = request_irq(irq, hl_irq_handler_cq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+		goto free_irq_vectors;
+	}
+
+	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
+	rc = request_irq(irq, hl_irq_handler_eq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
+			&hdev->event_queue);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+		goto free_completion_irq;
+	}
+
+	rc = gaudi2_dec_enable_msix(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to enable decoder IRQ");
+		goto free_completion_irq;
+	}
+
+	for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count, user_irq_init_cnt = 0;
+			user_irq_init_cnt < prop->user_interrupt_count;
+			i++, j++, user_irq_init_cnt++) {
+
+		irq = pci_irq_vector(hdev->pdev, i);
+		irq_handler = hl_irq_handler_user_interrupt;
+
+		rc = request_irq(irq, irq_handler, 0, gaudi2_irq_name(i), &hdev->user_interrupt[j]);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+			goto free_user_irq;
+		}
+	}
+
+	gaudi2->hw_cap_initialized |= HW_CAP_MSIX;
+
+	return 0;
+
+free_user_irq:
+	for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count;
+			i < GAUDI2_IRQ_NUM_USER_FIRST + user_irq_init_cnt ; i++, j++) {
+
+		irq = pci_irq_vector(hdev->pdev, i);
+		free_irq(irq, &hdev->user_interrupt[j]);
+	}
+
+	gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM + 1);
+
+free_completion_irq:
+	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
+	free_irq(irq, cq);
+
+free_irq_vectors:
+	pci_free_irq_vectors(hdev->pdev);
+
+	return rc;
+}
+
+static void gaudi2_sync_irqs(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int i, j;
+	int irq;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_MSIX))
+		return;
+
+	/* Wait for all pending IRQs to be finished */
+	synchronize_irq(pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION));
+
+	for (i = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM ; i <= GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM ; i++) {
+		irq = pci_irq_vector(hdev->pdev, i);
+		synchronize_irq(irq);
+	}
+
+	for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = 0 ; j < hdev->asic_prop.user_interrupt_count;
+										i++, j++) {
+		irq = pci_irq_vector(hdev->pdev, i);
+		synchronize_irq(irq);
+	}
+
+	synchronize_irq(pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE));
+}
+
+static void gaudi2_disable_msix(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct hl_cq *cq;
+	int irq, i, j, k;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_MSIX))
+		return;
+
+	gaudi2_sync_irqs(hdev);
+
+	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
+	free_irq(irq, &hdev->event_queue);
+
+	gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM + 1);
+
+	for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count, k = 0;
+			k < hdev->asic_prop.user_interrupt_count ; i++, j++, k++) {
+
+		irq = pci_irq_vector(hdev->pdev, i);
+		free_irq(irq, &hdev->user_interrupt[j]);
+	}
+
+	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
+	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_COMPLETION];
+	free_irq(irq, cq);
+
+	pci_free_irq_vectors(hdev->pdev);
+
+	gaudi2->hw_cap_initialized &= ~HW_CAP_MSIX;
+}
+
+static void gaudi2_stop_dcore_dec(struct hl_device *hdev, int dcore_id)
+{
+	u32 reg_val = FIELD_PREP(DCORE0_VDEC0_BRDG_CTRL_GRACEFUL_STOP_MASK, 0x1);
+	u32 graceful_pend_mask = DCORE0_VDEC0_BRDG_CTRL_GRACEFUL_PEND_MASK;
+	u32 timeout_usec, dec_id, dec_bit, offset, graceful;
+	int rc;
+
+	if (hdev->pldm)
+		timeout_usec = GAUDI2_PLDM_VDEC_TIMEOUT_USEC;
+	else
+		timeout_usec = GAUDI2_VDEC_TIMEOUT_USEC;
+
+	for (dec_id = 0 ; dec_id < NUM_OF_DEC_PER_DCORE ; dec_id++) {
+		dec_bit = dcore_id * NUM_OF_DEC_PER_DCORE + dec_id;
+		if (!(hdev->asic_prop.decoder_enabled_mask & BIT(dec_bit)))
+			continue;
+
+		offset = dcore_id * DCORE_OFFSET + dec_id * DCORE_VDEC_OFFSET;
+
+		WREG32(mmDCORE0_DEC0_CMD_SWREG16 + offset, 0);
+
+		WREG32(mmDCORE0_VDEC0_BRDG_CTRL_GRACEFUL + offset, reg_val);
+
+		/* Wait till all traffic from decoder stops
+		 * before apply core reset.
+		 */
+		rc = hl_poll_timeout(
+				hdev,
+				mmDCORE0_VDEC0_BRDG_CTRL_GRACEFUL + offset,
+				graceful,
+				(graceful & graceful_pend_mask),
+				100,
+				timeout_usec);
+		if (rc)
+			dev_err(hdev->dev,
+				"Failed to stop traffic from DCORE%d Decoder %d\n",
+				dcore_id, dec_id);
+	}
+}
+
+static void gaudi2_stop_pcie_dec(struct hl_device *hdev)
+{
+	u32 reg_val = FIELD_PREP(DCORE0_VDEC0_BRDG_CTRL_GRACEFUL_STOP_MASK, 0x1);
+	u32 graceful_pend_mask = PCIE_VDEC0_BRDG_CTRL_GRACEFUL_PEND_MASK;
+	u32 timeout_usec, dec_id, dec_bit, offset, graceful;
+	int rc;
+
+	if (hdev->pldm)
+		timeout_usec = GAUDI2_PLDM_VDEC_TIMEOUT_USEC;
+	else
+		timeout_usec = GAUDI2_VDEC_TIMEOUT_USEC;
+
+	for (dec_id = 0 ; dec_id < NUM_OF_DEC_PER_DCORE ; dec_id++) {
+		dec_bit = PCIE_DEC_SHIFT + dec_id;
+		if (!(hdev->asic_prop.decoder_enabled_mask & BIT(dec_bit)))
+			continue;
+
+		offset = dec_id * PCIE_VDEC_OFFSET;
+
+		WREG32(mmPCIE_DEC0_CMD_SWREG16 + offset, 0);
+
+		WREG32(mmPCIE_VDEC0_BRDG_CTRL_GRACEFUL + offset, reg_val);
+
+		/* Wait till all traffic from decoder stops
+		 * before apply core reset.
+		 */
+		rc = hl_poll_timeout(
+				hdev,
+				mmPCIE_VDEC0_BRDG_CTRL_GRACEFUL + offset,
+				graceful,
+				(graceful & graceful_pend_mask),
+				100,
+				timeout_usec);
+		if (rc)
+			dev_err(hdev->dev,
+				"Failed to stop traffic from PCIe Decoder %d\n",
+				dec_id);
+	}
+}
+
+static void gaudi2_stop_dec(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int dcore_id;
+
+	if ((gaudi2->dec_hw_cap_initialized & HW_CAP_DEC_MASK) == 0)
+		return;
+
+	for (dcore_id = 0 ; dcore_id < NUM_OF_DCORES ; dcore_id++)
+		gaudi2_stop_dcore_dec(hdev, dcore_id);
+
+	gaudi2_stop_pcie_dec(hdev);
+}
+
+static void gaudi2_halt_arc(struct hl_device *hdev, u32 cpu_id)
+{
+	u32 reg_base, reg_val;
+
+	reg_base = gaudi2_arc_blocks_bases[cpu_id];
+
+	/* Halt ARC */
+	reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_RUN_HALT_REQ_HALT_REQ_MASK, 1);
+	WREG32(reg_base + ARC_HALT_REQ_OFFSET, reg_val);
+}
+
+static void gaudi2_halt_arcs(struct hl_device *hdev)
+{
+	u16 arc_id;
+
+	for (arc_id = CPU_ID_SCHED_ARC0; arc_id < CPU_ID_MAX; arc_id++) {
+		if (gaudi2_is_arc_enabled(hdev, arc_id))
+			gaudi2_halt_arc(hdev, arc_id);
+	}
+}
+
+static void gaudi2_reset_arcs(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u16 arc_id;
+
+	if (!gaudi2)
+		return;
+
+	for (arc_id = CPU_ID_SCHED_ARC0; arc_id < CPU_ID_MAX; arc_id++)
+		if (gaudi2_is_arc_enabled(hdev, arc_id))
+			gaudi2_clr_arc_id_cap(hdev, arc_id);
+}
+
+static void gaudi2_nic_qmans_manual_flush(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 queue_id;
+	int i;
+
+	if (!(gaudi2->nic_hw_cap_initialized & HW_CAP_NIC_MASK))
+		return;
+
+	queue_id = GAUDI2_QUEUE_ID_NIC_0_0;
+
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++, queue_id += NUM_OF_PQ_PER_QMAN)
+		gaudi2_qman_manual_flush_common(hdev, queue_id);
+}
+
+static void gaudi2_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_reset)
+{
+	u32 wait_timeout_ms;
+
+	if (hdev->pldm)
+		wait_timeout_ms = GAUDI2_PLDM_RESET_WAIT_MSEC;
+	else
+		wait_timeout_ms = GAUDI2_RESET_WAIT_MSEC;
+
+	if (fw_reset)
+		goto skip_engines;
+
+	gaudi2_stop_dma_qmans(hdev);
+	gaudi2_stop_mme_qmans(hdev);
+	gaudi2_stop_tpc_qmans(hdev);
+	gaudi2_stop_rot_qmans(hdev);
+	gaudi2_stop_nic_qmans(hdev);
+	msleep(wait_timeout_ms);
+
+	gaudi2_halt_arcs(hdev);
+	gaudi2_dma_stall(hdev);
+	gaudi2_mme_stall(hdev);
+	gaudi2_tpc_stall(hdev);
+	gaudi2_rotator_stall(hdev);
+
+	msleep(wait_timeout_ms);
+
+	gaudi2_stop_dec(hdev);
+
+	/*
+	 * in case of soft reset do a manual flush for QMANs (currently called
+	 * only for NIC QMANs
+	 */
+	if (!hard_reset)
+		gaudi2_nic_qmans_manual_flush(hdev);
+
+	gaudi2_disable_dma_qmans(hdev);
+	gaudi2_disable_mme_qmans(hdev);
+	gaudi2_disable_tpc_qmans(hdev);
+	gaudi2_disable_rot_qmans(hdev);
+	gaudi2_disable_nic_qmans(hdev);
+	gaudi2_disable_timestamp(hdev);
+
+skip_engines:
+	if (hard_reset) {
+		gaudi2_disable_msix(hdev);
+		return;
+	}
+
+	gaudi2_sync_irqs(hdev);
+}
+
+static void gaudi2_init_firmware_loader(struct hl_device *hdev)
+{
+	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
+	struct dynamic_fw_load_mgr *dynamic_loader;
+	struct cpu_dyn_regs *dyn_regs;
+
+	/* fill common fields */
+	fw_loader->fw_comp_loaded = FW_TYPE_NONE;
+	fw_loader->boot_fit_img.image_name = GAUDI2_BOOT_FIT_FILE;
+	fw_loader->linux_img.image_name = GAUDI2_LINUX_FW_FILE;
+	fw_loader->boot_fit_timeout = GAUDI2_BOOT_FIT_REQ_TIMEOUT_USEC;
+	fw_loader->skip_bmc = false;
+	fw_loader->sram_bar_id = SRAM_CFG_BAR_ID;
+	fw_loader->dram_bar_id = DRAM_BAR_ID;
+
+	if (hdev->asic_type == ASIC_GAUDI2 || hdev->asic_type == ASIC_GAUDI2_SEC)
+		fw_loader->cpu_timeout = GAUDI2_CPU_TIMEOUT_USEC;
+	else /* ASIC_GAUDI2_FPGA */
+		fw_loader->cpu_timeout = GAUDI2_FPGA_CPU_TIMEOUT;
+
+	/* here we update initial values for few specific dynamic regs (as
+	 * before reading the first descriptor from FW those value has to be
+	 * hard-coded). in later stages of the protocol those values will be
+	 * updated automatically by reading the FW descriptor so data there
+	 * will always be up-to-date
+	 */
+	dynamic_loader = &hdev->fw_loader.dynamic_loader;
+	dyn_regs = &dynamic_loader->comm_desc.cpu_dyn_regs;
+	dyn_regs->kmd_msg_to_cpu = cpu_to_le32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU);
+	dyn_regs->cpu_cmd_status_to_host = cpu_to_le32(mmCPU_CMD_STATUS_TO_HOST);
+	dynamic_loader->wait_for_bl_timeout = GAUDI2_WAIT_FOR_BL_TIMEOUT_USEC;
+}
+
+static int gaudi2_init_cpu(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int rc;
+
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU))
+		return 0;
+
+	if (gaudi2->hw_cap_initialized & HW_CAP_CPU)
+		return 0;
+
+	rc = hl_fw_init_cpu(hdev);
+	if (rc)
+		return rc;
+
+	gaudi2->hw_cap_initialized |= HW_CAP_CPU;
+
+	return 0;
+}
+
+static int gaudi2_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
+{
+	struct hl_hw_queue *cpu_pq = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct cpu_dyn_regs *dyn_regs;
+	struct hl_eq *eq;
+	u32 status;
+	int err;
+
+	if (!hdev->cpu_queues_enable)
+		return 0;
+
+	if (gaudi2->hw_cap_initialized & HW_CAP_CPU_Q)
+		return 0;
+
+	eq = &hdev->event_queue;
+
+	dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+
+	WREG32(mmCPU_IF_PQ_BASE_ADDR_LOW, lower_32_bits(cpu_pq->bus_address));
+	WREG32(mmCPU_IF_PQ_BASE_ADDR_HIGH, upper_32_bits(cpu_pq->bus_address));
+
+	WREG32(mmCPU_IF_EQ_BASE_ADDR_LOW, lower_32_bits(eq->bus_address));
+	WREG32(mmCPU_IF_EQ_BASE_ADDR_HIGH, upper_32_bits(eq->bus_address));
+
+	WREG32(mmCPU_IF_CQ_BASE_ADDR_LOW, lower_32_bits(hdev->cpu_accessible_dma_address));
+	WREG32(mmCPU_IF_CQ_BASE_ADDR_HIGH, upper_32_bits(hdev->cpu_accessible_dma_address));
+
+	WREG32(mmCPU_IF_PQ_LENGTH, HL_QUEUE_SIZE_IN_BYTES);
+	WREG32(mmCPU_IF_EQ_LENGTH, HL_EQ_SIZE_IN_BYTES);
+	WREG32(mmCPU_IF_CQ_LENGTH, HL_CPU_ACCESSIBLE_MEM_SIZE);
+
+	/* Used for EQ CI */
+	WREG32(mmCPU_IF_EQ_RD_OFFS, 0);
+
+	WREG32(mmCPU_IF_PF_PQ_PI, 0);
+
+	WREG32(mmCPU_IF_QUEUE_INIT, PQ_INIT_STATUS_READY_FOR_CP);
+
+	/* Let the ARC know we are ready as it is now handling those queues  */
+
+	WREG32(le32_to_cpu(dyn_regs->gic_host_pi_upd_irq),
+		gaudi2_irq_map_table[GAUDI2_EVENT_CPU_PI_UPDATE].cpu_id);
+
+	err = hl_poll_timeout(
+		hdev,
+		mmCPU_IF_QUEUE_INIT,
+		status,
+		(status == PQ_INIT_STATUS_READY_FOR_HOST),
+		1000,
+		cpu_timeout);
+
+	if (err) {
+		dev_err(hdev->dev, "Failed to communicate with device CPU (timeout)\n");
+		return -EIO;
+	}
+
+	/* update FW application security bits */
+	if (prop->fw_cpu_boot_dev_sts0_valid)
+		prop->fw_app_cpu_boot_dev_sts0 = RREG32(mmCPU_BOOT_DEV_STS0);
+
+	if (prop->fw_cpu_boot_dev_sts1_valid)
+		prop->fw_app_cpu_boot_dev_sts1 = RREG32(mmCPU_BOOT_DEV_STS1);
+
+	gaudi2->hw_cap_initialized |= HW_CAP_CPU_Q;
+	return 0;
+}
+
+static void gaudi2_init_qman_pq(struct hl_device *hdev, u32 reg_base,
+				u32 queue_id_base)
+{
+	struct hl_hw_queue *q;
+	u32 pq_id, pq_offset;
+
+	for (pq_id = 0 ; pq_id < NUM_OF_PQ_PER_QMAN ; pq_id++) {
+		q = &hdev->kernel_queues[queue_id_base + pq_id];
+		pq_offset = pq_id * 4;
+
+		WREG32(reg_base + QM_PQ_BASE_LO_0_OFFSET + pq_offset,
+				lower_32_bits(q->bus_address));
+		WREG32(reg_base + QM_PQ_BASE_HI_0_OFFSET + pq_offset,
+				upper_32_bits(q->bus_address));
+		WREG32(reg_base + QM_PQ_SIZE_0_OFFSET + pq_offset, ilog2(HL_QUEUE_LENGTH));
+		WREG32(reg_base + QM_PQ_PI_0_OFFSET + pq_offset, 0);
+		WREG32(reg_base + QM_PQ_CI_0_OFFSET + pq_offset, 0);
+	}
+}
+
+static void gaudi2_init_qman_cp(struct hl_device *hdev, u32 reg_base)
+{
+	u32 cp_id, cp_offset, mtr_base_lo, mtr_base_hi, so_base_lo, so_base_hi;
+
+	mtr_base_lo = lower_32_bits(CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0);
+
+	for (cp_id = 0 ; cp_id < NUM_OF_CP_PER_QMAN; cp_id++) {
+		cp_offset = cp_id * 4;
+
+		WREG32(reg_base + QM_CP_MSG_BASE0_ADDR_LO_0_OFFSET + cp_offset, mtr_base_lo);
+		WREG32(reg_base + QM_CP_MSG_BASE0_ADDR_HI_0_OFFSET + cp_offset,	mtr_base_hi);
+		WREG32(reg_base + QM_CP_MSG_BASE1_ADDR_LO_0_OFFSET + cp_offset,	so_base_lo);
+		WREG32(reg_base + QM_CP_MSG_BASE1_ADDR_HI_0_OFFSET + cp_offset,	so_base_hi);
+	}
+
+	/* allow QMANs to accept work from ARC CQF */
+	WREG32(reg_base + QM_CP_CFG_OFFSET, FIELD_PREP(PDMA0_QM_CP_CFG_SWITCH_EN_MASK, 0x1));
+}
+
+static void gaudi2_init_qman_pqc(struct hl_device *hdev, u32 reg_base,
+				u32 queue_id_base)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 pq_id, pq_offset, so_base_lo, so_base_hi;
+
+	so_base_lo = lower_32_bits(CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0);
+
+	for (pq_id = 0 ; pq_id < NUM_OF_PQ_PER_QMAN ; pq_id++) {
+		pq_offset = pq_id * 4;
+
+		/* Configure QMAN HBW to scratchpad as it is not needed */
+		WREG32(reg_base + QM_PQC_HBW_BASE_LO_0_OFFSET + pq_offset,
+				lower_32_bits(gaudi2->scratchpad_bus_address));
+		WREG32(reg_base + QM_PQC_HBW_BASE_HI_0_OFFSET + pq_offset,
+				upper_32_bits(gaudi2->scratchpad_bus_address));
+		WREG32(reg_base + QM_PQC_SIZE_0_OFFSET + pq_offset,
+				ilog2(PAGE_SIZE / sizeof(struct hl_cq_entry)));
+
+		WREG32(reg_base + QM_PQC_PI_0_OFFSET + pq_offset, 0);
+		WREG32(reg_base + QM_PQC_LBW_WDATA_0_OFFSET + pq_offset, QM_PQC_LBW_WDATA);
+		WREG32(reg_base + QM_PQC_LBW_BASE_LO_0_OFFSET + pq_offset, so_base_lo);
+		WREG32(reg_base + QM_PQC_LBW_BASE_HI_0_OFFSET + pq_offset, so_base_hi);
+	}
+
+	/* Enable QMAN H/W completion */
+	WREG32(reg_base + QM_PQC_CFG_OFFSET, 1 << PDMA0_QM_PQC_CFG_EN_SHIFT);
+}
+
+static u32 gaudi2_get_dyn_sp_reg(struct hl_device *hdev, u32 queue_id_base)
+{
+	struct cpu_dyn_regs *dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+	u32 sp_reg_addr;
+
+	switch (queue_id_base) {
+	case GAUDI2_QUEUE_ID_PDMA_0_0...GAUDI2_QUEUE_ID_PDMA_1_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE1_EDMA_1_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE2_EDMA_1_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3:
+		sp_reg_addr = le32_to_cpu(dyn_regs->gic_dma_qm_irq_ctrl);
+		break;
+	case GAUDI2_QUEUE_ID_DCORE0_MME_0_0...GAUDI2_QUEUE_ID_DCORE0_MME_0_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE1_MME_0_0...GAUDI2_QUEUE_ID_DCORE1_MME_0_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE2_MME_0_0...GAUDI2_QUEUE_ID_DCORE2_MME_0_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE3_MME_0_0...GAUDI2_QUEUE_ID_DCORE3_MME_0_3:
+		sp_reg_addr = le32_to_cpu(dyn_regs->gic_mme_qm_irq_ctrl);
+		break;
+	case GAUDI2_QUEUE_ID_DCORE0_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE0_TPC_6_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE1_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE1_TPC_5_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE2_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE2_TPC_5_3:
+		fallthrough;
+	case GAUDI2_QUEUE_ID_DCORE3_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE3_TPC_5_3:
+		sp_reg_addr = le32_to_cpu(dyn_regs->gic_tpc_qm_irq_ctrl);
+		break;
+	case GAUDI2_QUEUE_ID_ROT_0_0...GAUDI2_QUEUE_ID_ROT_1_3:
+		sp_reg_addr = le32_to_cpu(dyn_regs->gic_rot_qm_irq_ctrl);
+		break;
+	case GAUDI2_QUEUE_ID_NIC_0_0...GAUDI2_QUEUE_ID_NIC_23_3:
+		sp_reg_addr = le32_to_cpu(dyn_regs->gic_nic_qm_irq_ctrl);
+		break;
+	default:
+		dev_err(hdev->dev, "Unexpected h/w queue %d\n", queue_id_base);
+		return 0;
+	}
+
+	return sp_reg_addr;
+}
+
+static void gaudi2_init_qman_common(struct hl_device *hdev, u32 reg_base,
+					u32 queue_id_base)
+{
+	u32 glbl_prot = QMAN_MAKE_TRUSTED, irq_handler_offset;
+	int map_table_entry;
+
+	WREG32(reg_base + QM_GLBL_PROT_OFFSET, glbl_prot);
+
+	irq_handler_offset = gaudi2_get_dyn_sp_reg(hdev, queue_id_base);
+	WREG32(reg_base + QM_GLBL_ERR_ADDR_LO_OFFSET, lower_32_bits(CFG_BASE + irq_handler_offset));
+	WREG32(reg_base + QM_GLBL_ERR_ADDR_HI_OFFSET, upper_32_bits(CFG_BASE + irq_handler_offset));
+
+	map_table_entry = gaudi2_qman_async_event_id[queue_id_base];
+	WREG32(reg_base + QM_GLBL_ERR_WDATA_OFFSET,
+		gaudi2_irq_map_table[map_table_entry].cpu_id);
+
+	WREG32(reg_base + QM_ARB_ERR_MSG_EN_OFFSET, QM_ARB_ERR_MSG_EN_MASK);
+
+	WREG32(reg_base + QM_ARB_SLV_CHOISE_WDT_OFFSET, GAUDI2_ARB_WDT_TIMEOUT);
+	WREG32(reg_base + QM_GLBL_CFG1_OFFSET, 0);
+	WREG32(reg_base + QM_GLBL_CFG2_OFFSET, 0);
+
+	/* Enable the QMAN channel.
+	 * PDMA1 QMAN configuration is different, as we do not allow user to
+	 * access CP2/3, it is reserved for the ARC usage.
+	 */
+	if (reg_base == gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_PDMA_1_0])
+		WREG32(reg_base + QM_GLBL_CFG0_OFFSET, PDMA1_QMAN_ENABLE);
+	else
+		WREG32(reg_base + QM_GLBL_CFG0_OFFSET, QMAN_ENABLE);
+}
+
+static void gaudi2_init_qman(struct hl_device *hdev, u32 reg_base,
+		u32 queue_id_base)
+{
+	u32 pq_id;
+
+	for (pq_id = 0 ; pq_id < NUM_OF_PQ_PER_QMAN ; pq_id++)
+		hdev->kernel_queues[queue_id_base + pq_id].cq_id = GAUDI2_RESERVED_CQ_COMPLETION;
+
+	gaudi2_init_qman_pq(hdev, reg_base, queue_id_base);
+	gaudi2_init_qman_cp(hdev, reg_base);
+	gaudi2_init_qman_pqc(hdev, reg_base, queue_id_base);
+	gaudi2_init_qman_common(hdev, reg_base, queue_id_base);
+}
+
+static void gaudi2_init_dma_core(struct hl_device *hdev, u32 reg_base,
+				u32 dma_core_id, bool is_secure)
+{
+	u32 prot, irq_handler_offset;
+	struct cpu_dyn_regs *dyn_regs;
+	int map_table_entry;
+
+	prot = 1 << ARC_FARM_KDMA_PROT_ERR_VAL_SHIFT;
+	if (is_secure)
+		prot |= 1 << ARC_FARM_KDMA_PROT_VAL_SHIFT;
+
+	WREG32(reg_base + DMA_CORE_PROT_OFFSET, prot);
+
+	dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+	irq_handler_offset = le32_to_cpu(dyn_regs->gic_dma_core_irq_ctrl);
+
+	WREG32(reg_base + DMA_CORE_ERRMSG_ADDR_LO_OFFSET,
+			lower_32_bits(CFG_BASE + irq_handler_offset));
+
+	WREG32(reg_base + DMA_CORE_ERRMSG_ADDR_HI_OFFSET,
+			upper_32_bits(CFG_BASE + irq_handler_offset));
+
+	map_table_entry = gaudi2_dma_core_async_event_id[dma_core_id];
+	WREG32(reg_base + DMA_CORE_ERRMSG_WDATA_OFFSET,
+		gaudi2_irq_map_table[map_table_entry].cpu_id);
+
+	/* Enable the DMA channel */
+	WREG32(reg_base + DMA_CORE_CFG_0_OFFSET, 1 << ARC_FARM_KDMA_CFG_0_EN_SHIFT);
+}
+
+static void gaudi2_init_kdma(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+
+	if ((gaudi2->hw_cap_initialized & HW_CAP_KDMA) == HW_CAP_KDMA)
+		return;
+
+	reg_base = gaudi2_dma_core_blocks_bases[DMA_CORE_ID_KDMA];
+
+	gaudi2_init_dma_core(hdev, reg_base, DMA_CORE_ID_KDMA, true);
+
+	gaudi2->hw_cap_initialized |= HW_CAP_KDMA;
+}
+
+static void gaudi2_init_pdma(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_base;
+
+	if ((gaudi2->hw_cap_initialized & HW_CAP_PDMA_MASK) == HW_CAP_PDMA_MASK)
+		return;
+
+	reg_base = gaudi2_dma_core_blocks_bases[DMA_CORE_ID_PDMA0];
+	gaudi2_init_dma_core(hdev, reg_base, DMA_CORE_ID_PDMA0, false);
+
+	reg_base = gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_PDMA_0_0];
+	gaudi2_init_qman(hdev, reg_base, GAUDI2_QUEUE_ID_PDMA_0_0);
+
+	reg_base = gaudi2_dma_core_blocks_bases[DMA_CORE_ID_PDMA1];
+	gaudi2_init_dma_core(hdev, reg_base, DMA_CORE_ID_PDMA1, false);
+
+	reg_base = gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_PDMA_1_0];
+	gaudi2_init_qman(hdev, reg_base, GAUDI2_QUEUE_ID_PDMA_1_0);
+
+	gaudi2->hw_cap_initialized |= HW_CAP_PDMA_MASK;
+}
+
+static void gaudi2_init_edma_instance(struct hl_device *hdev, u8 seq)
+{
+	u32 reg_base, base_edma_core_id, base_edma_qman_id;
+
+	base_edma_core_id = DMA_CORE_ID_EDMA0 + seq;
+	base_edma_qman_id = edma_stream_base[seq];
+
+	reg_base = gaudi2_dma_core_blocks_bases[base_edma_core_id];
+	gaudi2_init_dma_core(hdev, reg_base, base_edma_core_id, false);
+
+	reg_base = gaudi2_qm_blocks_bases[base_edma_qman_id];
+	gaudi2_init_qman(hdev, reg_base, base_edma_qman_id);
+}
+
+static void gaudi2_init_edma(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int dcore, inst;
+
+	if ((gaudi2->hw_cap_initialized & HW_CAP_EDMA_MASK) == HW_CAP_EDMA_MASK)
+		return;
+
+	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+		for (inst = 0 ; inst < NUM_OF_EDMA_PER_DCORE ; inst++) {
+			u8 seq = dcore * NUM_OF_EDMA_PER_DCORE + inst;
+
+			if (!(prop->edma_enabled_mask & BIT(seq)))
+				continue;
+
+			gaudi2_init_edma_instance(hdev, seq);
+
+			gaudi2->hw_cap_initialized |= BIT_ULL(HW_CAP_EDMA_SHIFT + seq);
+		}
+	}
+}
+
+static void gaudi2_init_sm(struct hl_device *hdev)
+{
+	u64 msix_db_reg = CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF;
+	u64 cq_address;
+	u32 reg_val;
+	int i;
+
+	/* Enable HBW/LBW CQ for completion monitors */
+	reg_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_CONFIG_CQ_EN_MASK, 1);
+	reg_val |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_CONFIG_LBW_EN_MASK, 1);
+
+	for (i = 0 ; i < GAUDI2_MAX_PENDING_CS ; i++)
+		WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_CONFIG_0 + (4 * i), reg_val);
+
+	/* Enable only HBW CQ for KDMA completion monitor */
+	reg_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_CONFIG_CQ_EN_MASK, 1);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_CONFIG_0 + (4 * i), reg_val);
+
+	/* Init CQ0 DB */
+	/* Configure the monitor to trigger MSI-X interrupt */
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0, lower_32_bits(msix_db_reg));
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0, upper_32_bits(msix_db_reg));
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_DATA_0, GAUDI2_IRQ_NUM_COMPLETION);
+
+	for (i = 0 ; i < GAUDI2_RESERVED_CQ_NUMBER ; i++) {
+		cq_address =
+			hdev->completion_queue[i].bus_address;
+
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_CQ_BASE_ADDR_L_0 + (4 * i),
+							lower_32_bits(cq_address));
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_CQ_BASE_ADDR_H_0 + (4 * i),
+							upper_32_bits(cq_address));
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_CQ_SIZE_LOG2_0 + (4 * i),
+							ilog2(HL_CQ_SIZE_IN_BYTES));
+	}
+
+	/* Configure kernel ASID and MMU BP*/
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_ASID_SEC, 0x10000);
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_ASID_NONE_SEC_PRIV, 0);
+}
+
+static void gaudi2_init_mme_acc(struct hl_device *hdev, u32 reg_base)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 reg_val;
+	int i;
+
+	reg_val = FIELD_PREP(MME_ACC_INTR_MASK_WBC_ERR_RESP_MASK, 0);
+	reg_val |= FIELD_PREP(MME_ACC_INTR_MASK_AP_SRC_POS_INF_MASK, 1);
+	reg_val |= FIELD_PREP(MME_ACC_INTR_MASK_AP_SRC_NEG_INF_MASK, 1);
+	reg_val |= FIELD_PREP(MME_ACC_INTR_MASK_AP_SRC_NAN_MASK, 1);
+	reg_val |= FIELD_PREP(MME_ACC_INTR_MASK_AP_RESULT_POS_INF_MASK, 1);
+	reg_val |= FIELD_PREP(MME_ACC_INTR_MASK_AP_RESULT_NEG_INF_MASK, 1);
+
+	WREG32(reg_base + MME_ACC_INTR_MASK_OFFSET, reg_val);
+	WREG32(reg_base + MME_ACC_AP_LFSR_POLY_OFFSET, 0x80DEADAF);
+
+	for (i = 0 ; i < MME_NUM_OF_LFSR_SEEDS ; i++) {
+		WREG32(reg_base + MME_ACC_AP_LFSR_SEED_SEL_OFFSET, i);
+		WREG32(reg_base + MME_ACC_AP_LFSR_SEED_WDATA_OFFSET, gaudi2->lfsr_rand_seeds[i]);
+	}
+}
+
+static void gaudi2_init_dcore_mme(struct hl_device *hdev, int dcore_id,
+							bool config_qman_only)
+{
+	u32 queue_id_base, reg_base, clk_en_addr = 0;
+
+	switch (dcore_id) {
+	case 0:
+		queue_id_base = GAUDI2_QUEUE_ID_DCORE0_MME_0_0;
+		break;
+	case 1:
+		queue_id_base = GAUDI2_QUEUE_ID_DCORE1_MME_0_0;
+		clk_en_addr = mmDCORE1_MME_CTRL_LO_QM_SLV_CLK_EN;
+		break;
+	case 2:
+		queue_id_base = GAUDI2_QUEUE_ID_DCORE2_MME_0_0;
+		break;
+	case 3:
+		queue_id_base = GAUDI2_QUEUE_ID_DCORE3_MME_0_0;
+		clk_en_addr = mmDCORE3_MME_CTRL_LO_QM_SLV_CLK_EN;
+		break;
+	default:
+		dev_err(hdev->dev, "Invalid dcore id %u\n", dcore_id);
+		return;
+	}
+
+	if (clk_en_addr && !(hdev->fw_components & FW_TYPE_BOOT_CPU))
+		WREG32(clk_en_addr, 0x1);
+
+	if (!config_qman_only) {
+		reg_base = gaudi2_mme_acc_blocks_bases[dcore_id];
+		gaudi2_init_mme_acc(hdev, reg_base);
+	}
+
+	reg_base = gaudi2_qm_blocks_bases[queue_id_base];
+	gaudi2_init_qman(hdev, reg_base, queue_id_base);
+}
+
+static void gaudi2_init_mme(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int i;
+
+	if ((gaudi2->hw_cap_initialized & HW_CAP_MME_MASK) == HW_CAP_MME_MASK)
+		return;
+
+	for (i = 0 ; i < NUM_OF_DCORES ; i++) {
+		gaudi2_init_dcore_mme(hdev, i, false);
+
+		gaudi2->hw_cap_initialized |= BIT_ULL(HW_CAP_MME_SHIFT + i);
+	}
+}
+
+static void gaudi2_init_tpc_cfg(struct hl_device *hdev, u32 reg_base)
+{
+	/* Mask arithmetic and QM interrupts in TPC */
+	WREG32(reg_base + TPC_CFG_TPC_INTR_MASK_OFFSET, 0x23FFFE);
+
+	/* Set 16 cache lines */
+	WREG32(reg_base + TPC_CFG_MSS_CONFIG_OFFSET,
+			2 << DCORE0_TPC0_CFG_MSS_CONFIG_ICACHE_FETCH_LINE_NUM_SHIFT);
+}
+
+struct gaudi2_tpc_init_cfg_data {
+	enum gaudi2_queue_id dcore_tpc_qid_base[NUM_OF_DCORES];
+};
+
+static void gaudi2_init_tpc_config(struct hl_device *hdev, int dcore, int inst,
+							u32 offset, void *data)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct gaudi2_tpc_init_cfg_data *cfg_data = data;
+	u32 queue_id_base;
+	u8 seq;
+
+	queue_id_base = cfg_data->dcore_tpc_qid_base[dcore] + (inst * NUM_OF_PQ_PER_QMAN);
+
+	if (dcore == 0 && inst == (NUM_DCORE0_TPC - 1))
+		/* gets last sequence number */
+		seq = NUM_OF_DCORES * NUM_OF_TPC_PER_DCORE;
+	else
+		seq = dcore * NUM_OF_TPC_PER_DCORE + inst;
+
+	gaudi2_init_tpc_cfg(hdev, mmDCORE0_TPC0_CFG_BASE + offset);
+	gaudi2_init_qman(hdev, mmDCORE0_TPC0_QM_BASE + offset, queue_id_base);
+
+	gaudi2->tpc_hw_cap_initialized |= BIT_ULL(HW_CAP_TPC_SHIFT + seq);
+}
+
+static void gaudi2_init_tpc(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct gaudi2_tpc_init_cfg_data init_cfg_data;
+	struct iterate_module_ctx tpc_iter;
+
+	if (!hdev->asic_prop.tpc_enabled_mask)
+		return;
+
+	if ((gaudi2->tpc_hw_cap_initialized & HW_CAP_TPC_MASK) == HW_CAP_TPC_MASK)
+		return;
+
+	init_cfg_data.dcore_tpc_qid_base[0] = GAUDI2_QUEUE_ID_DCORE0_TPC_0_0;
+	init_cfg_data.dcore_tpc_qid_base[1] = GAUDI2_QUEUE_ID_DCORE1_TPC_0_0;
+	init_cfg_data.dcore_tpc_qid_base[2] = GAUDI2_QUEUE_ID_DCORE2_TPC_0_0;
+	init_cfg_data.dcore_tpc_qid_base[3] = GAUDI2_QUEUE_ID_DCORE3_TPC_0_0;
+	tpc_iter.fn = &gaudi2_init_tpc_config;
+	tpc_iter.data = &init_cfg_data;
+	gaudi2_iterate_tpcs(hdev, &tpc_iter);
+}
+
+static void gaudi2_init_rotator(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 i, reg_base, queue_id;
+
+	queue_id = GAUDI2_QUEUE_ID_ROT_0_0;
+
+	for (i = 0 ; i < NUM_OF_ROT ; i++, queue_id += NUM_OF_PQ_PER_QMAN) {
+		reg_base = gaudi2_qm_blocks_bases[queue_id];
+		gaudi2_init_qman(hdev, reg_base, queue_id);
+
+		gaudi2->hw_cap_initialized |= BIT_ULL(HW_CAP_ROT_SHIFT + i);
+	}
+}
+
+static void gaudi2_init_vdec_brdg_ctrl(struct hl_device *hdev, u64 base_addr, u32 msix_id)
+{
+	WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_WDATA, msix_id);
+	WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_WDATA, msix_id + 1);
+}
+
+static void gaudi2_init_dec(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 dcore_id, dec_id, dec_bit, msix_id;
+	u64 base_addr;
+
+	if (!hdev->asic_prop.decoder_enabled_mask)
+		return;
+
+	if ((gaudi2->dec_hw_cap_initialized & HW_CAP_DEC_MASK) == HW_CAP_DEC_MASK)
+		return;
+
+	for (dcore_id = 0 ; dcore_id < NUM_OF_DCORES ; dcore_id++)
+		for (dec_id = 0 ; dec_id < NUM_OF_DEC_PER_DCORE ; dec_id++) {
+			dec_bit = dcore_id * NUM_OF_DEC_PER_DCORE + dec_id;
+
+			if (!(hdev->asic_prop.decoder_enabled_mask & BIT(dec_bit)))
+				continue;
+
+			base_addr =  mmDCORE0_DEC0_CMD_BASE +
+					BRDG_CTRL_BLOCK_OFFSET +
+					dcore_id * DCORE_OFFSET +
+					dec_id * DCORE_VDEC_OFFSET;
+
+			msix_id = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM +
+				(dcore_id * NUM_OF_DEC_PER_DCORE + dec_id) * 2;
+
+			gaudi2_init_vdec_brdg_ctrl(hdev, base_addr, msix_id);
+
+			gaudi2->dec_hw_cap_initialized |= BIT_ULL(HW_CAP_DEC_SHIFT + dec_bit);
+		}
+
+	for (dec_id = 0 ; dec_id < NUM_OF_PCIE_VDEC ; dec_id++) {
+		dec_bit = PCIE_DEC_SHIFT + dec_id;
+		if (!(hdev->asic_prop.decoder_enabled_mask & BIT(dec_bit)))
+			continue;
+
+		base_addr = mmPCIE_DEC0_CMD_BASE + BRDG_CTRL_BLOCK_OFFSET +
+				dec_id * DCORE_VDEC_OFFSET;
+
+		msix_id = GAUDI2_IRQ_NUM_SHARED_DEC0_NRM + (dec_id * 2);
+
+		gaudi2_init_vdec_brdg_ctrl(hdev, base_addr, msix_id);
+
+		gaudi2->dec_hw_cap_initialized |= BIT_ULL(HW_CAP_DEC_SHIFT + dec_bit);
+	}
+}
+
+static void gaudi2_init_msix_gw_table(struct hl_device *hdev)
+{
+	u32 first_reg_offset, last_reg_offset, msix_gw_table_base;
+	u8 first_bit, last_bit;
+	int i;
+
+	msix_gw_table_base = mmPCIE_WRAP_MSIX_GW_TABLE_0;
+	first_reg_offset = (GAUDI2_IRQ_NUM_USER_FIRST >> 5) << 2;
+	first_bit = GAUDI2_IRQ_NUM_USER_FIRST % 32;
+	last_reg_offset = (GAUDI2_IRQ_NUM_USER_LAST >> 5) << 2;
+	last_bit = GAUDI2_IRQ_NUM_USER_LAST % 32;
+
+	if (first_reg_offset == last_reg_offset) {
+		WREG32(msix_gw_table_base + first_reg_offset, GENMASK(last_bit, first_bit));
+		return;
+	}
+
+	WREG32(msix_gw_table_base + first_reg_offset, GENMASK(31, first_bit));
+	WREG32(msix_gw_table_base + last_reg_offset, GENMASK(last_bit, 0));
+
+	for (i = first_reg_offset + 4; i < last_reg_offset ; i += 4)
+		WREG32(msix_gw_table_base + i, 0xFFFFFFFF);
+}
+
+static int gaudi2_mmu_update_asid_hop0_addr(struct hl_device *hdev,
+					u32 stlb_base, u32 asid, u64 phys_addr)
+{
+	u32 status, timeout_usec;
+	int rc;
+
+	if (hdev->pldm || !hdev->pdev)
+		timeout_usec = GAUDI2_PLDM_MMU_TIMEOUT_USEC;
+	else
+		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
+
+	WREG32(stlb_base + STLB_ASID_OFFSET, asid);
+	WREG32(stlb_base + STLB_HOP0_PA43_12_OFFSET, phys_addr >> MMU_HOP0_PA43_12_SHIFT);
+	WREG32(stlb_base + STLB_HOP0_PA63_44_OFFSET, phys_addr >> MMU_HOP0_PA63_44_SHIFT);
+	WREG32(stlb_base + STLB_BUSY_OFFSET, 0x80000000);
+
+	rc = hl_poll_timeout(
+		hdev,
+		stlb_base + STLB_BUSY_OFFSET,
+		status,
+		!(status & 0x80000000),
+		1000,
+		timeout_usec);
+
+	if (rc) {
+		dev_err(hdev->dev, "Timeout during MMU hop0 config of asid %d\n", asid);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void gaudi2_mmu_send_invalidate_cache_cmd(struct hl_device *hdev, u32 stlb_base,
+					u32 start_offset, u32 inv_start_val,
+					u32 flags)
+{
+	/* clear PMMU mem line cache (only needed in mmu range invalidation) */
+	if (flags & MMU_OP_CLEAR_MEMCACHE)
+		WREG32(mmPMMU_HBW_STLB_MEM_CACHE_INVALIDATION, 0x1);
+
+	if (flags & MMU_OP_SKIP_LOW_CACHE_INV)
+		return;
+
+	WREG32(stlb_base + start_offset, inv_start_val);
+}
+
+static int gaudi2_mmu_invalidate_cache_status_poll(struct hl_device *hdev, u32 stlb_base,
+						struct gaudi2_cache_invld_params *inv_params)
+{
+	u32 status, timeout_usec, start_offset;
+	int rc;
+
+	timeout_usec = (hdev->pldm) ? GAUDI2_PLDM_MMU_TIMEOUT_USEC :
+					GAUDI2_MMU_CACHE_INV_TIMEOUT_USEC;
+
+	/* poll PMMU mem line cache (only needed in mmu range invalidation) */
+	if (inv_params->flags & MMU_OP_CLEAR_MEMCACHE) {
+		rc = hl_poll_timeout(
+			hdev,
+			mmPMMU_HBW_STLB_MEM_CACHE_INV_STATUS,
+			status,
+			status & 0x1,
+			1000,
+			timeout_usec);
+
+		if (rc)
+			return rc;
+
+		/* Need to manually reset the status to 0 */
+		WREG32(mmPMMU_HBW_STLB_MEM_CACHE_INV_STATUS, 0x0);
+	}
+
+	/* Lower cache does not work with cache lines, hence we can skip its
+	 * invalidation upon map and invalidate only upon unmap
+	 */
+	if (inv_params->flags & MMU_OP_SKIP_LOW_CACHE_INV)
+		return 0;
+
+	start_offset = inv_params->range_invalidation ?
+			STLB_RANGE_CACHE_INVALIDATION_OFFSET : STLB_INV_ALL_START_OFFSET;
+
+	rc = hl_poll_timeout(
+		hdev,
+		stlb_base + start_offset,
+		status,
+		!(status & 0x1),
+		1000,
+		timeout_usec);
+
+	return rc;
+}
+
+bool gaudi2_is_hmmu_enabled(struct hl_device *hdev, int dcore_id, int hmmu_id)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 hw_cap;
+
+	hw_cap = HW_CAP_DCORE0_DMMU0 << (NUM_OF_HMMU_PER_DCORE * dcore_id + hmmu_id);
+
+	if (gaudi2->hw_cap_initialized & hw_cap)
+		return true;
+
+	return false;
+}
+
+/* this function shall be called only for HMMUs for which capability bit is set */
+static inline u32 get_hmmu_stlb_base(int dcore_id, int hmmu_id)
+{
+	u32 offset;
+
+	offset =  (u32) (dcore_id * DCORE_OFFSET + hmmu_id * DCORE_HMMU_OFFSET);
+	return (u32)(mmDCORE0_HMMU0_STLB_BASE + offset);
+}
+
+static void gaudi2_mmu_invalidate_cache_trigger(struct hl_device *hdev, u32 stlb_base,
+						struct gaudi2_cache_invld_params *inv_params)
+{
+	u32 start_offset;
+
+	if (inv_params->range_invalidation) {
+		/* Set the addresses range
+		 * Note: that the start address we set in register, is not included in
+		 * the range of the invalidation, by design.
+		 * that's why we need to set lower address than the one we actually
+		 * want to be included in the range invalidation.
+		 */
+		u64 start = inv_params->start_va - 1;
+
+		start_offset = STLB_RANGE_CACHE_INVALIDATION_OFFSET;
+
+		WREG32(stlb_base + STLB_RANGE_INV_START_LSB_OFFSET,
+				start >> MMU_RANGE_INV_VA_LSB_SHIFT);
+
+		WREG32(stlb_base + STLB_RANGE_INV_START_MSB_OFFSET,
+				start >> MMU_RANGE_INV_VA_MSB_SHIFT);
+
+		WREG32(stlb_base + STLB_RANGE_INV_END_LSB_OFFSET,
+				inv_params->end_va >> MMU_RANGE_INV_VA_LSB_SHIFT);
+
+		WREG32(stlb_base + STLB_RANGE_INV_END_MSB_OFFSET,
+				inv_params->end_va >> MMU_RANGE_INV_VA_MSB_SHIFT);
+	} else {
+		start_offset = STLB_INV_ALL_START_OFFSET;
+	}
+
+	gaudi2_mmu_send_invalidate_cache_cmd(hdev, stlb_base, start_offset,
+						inv_params->inv_start_val, inv_params->flags);
+}
+
+static inline void gaudi2_hmmu_invalidate_cache_trigger(struct hl_device *hdev,
+						int dcore_id, int hmmu_id,
+						struct gaudi2_cache_invld_params *inv_params)
+{
+	u32 stlb_base = get_hmmu_stlb_base(dcore_id, hmmu_id);
+
+	gaudi2_mmu_invalidate_cache_trigger(hdev, stlb_base, inv_params);
+}
+
+static inline int gaudi2_hmmu_invalidate_cache_status_poll(struct hl_device *hdev,
+						int dcore_id, int hmmu_id,
+						struct gaudi2_cache_invld_params *inv_params)
+{
+	u32 stlb_base = get_hmmu_stlb_base(dcore_id, hmmu_id);
+
+	return gaudi2_mmu_invalidate_cache_status_poll(hdev, stlb_base, inv_params);
+}
+
+static int gaudi2_hmmus_invalidate_cache(struct hl_device *hdev,
+						struct gaudi2_cache_invld_params *inv_params)
+{
+	int dcore_id, hmmu_id;
+
+	/* first send all invalidation commands */
+	for (dcore_id = 0 ; dcore_id < NUM_OF_DCORES ; dcore_id++) {
+		for (hmmu_id = 0 ; hmmu_id < NUM_OF_HMMU_PER_DCORE ; hmmu_id++) {
+			if (!gaudi2_is_hmmu_enabled(hdev, dcore_id, hmmu_id))
+				continue;
+
+			gaudi2_hmmu_invalidate_cache_trigger(hdev, dcore_id, hmmu_id, inv_params);
+		}
+	}
+
+	/* next, poll all invalidations status */
+	for (dcore_id = 0 ; dcore_id < NUM_OF_DCORES ; dcore_id++) {
+		for (hmmu_id = 0 ; hmmu_id < NUM_OF_HMMU_PER_DCORE ; hmmu_id++) {
+			int rc;
+
+			if (!gaudi2_is_hmmu_enabled(hdev, dcore_id, hmmu_id))
+				continue;
+
+			rc = gaudi2_hmmu_invalidate_cache_status_poll(hdev, dcore_id, hmmu_id,
+										inv_params);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+static int gaudi2_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct gaudi2_cache_invld_params invld_params;
+	int rc = 0;
+
+	if (hdev->reset_info.hard_reset_pending)
+		return rc;
+
+	invld_params.range_invalidation = false;
+	invld_params.inv_start_val = 1;
+
+	if ((flags & MMU_OP_USERPTR) && (gaudi2->hw_cap_initialized & HW_CAP_PMMU)) {
+		invld_params.flags = flags;
+		gaudi2_mmu_invalidate_cache_trigger(hdev, mmPMMU_HBW_STLB_BASE, &invld_params);
+		rc = gaudi2_mmu_invalidate_cache_status_poll(hdev, mmPMMU_HBW_STLB_BASE,
+										&invld_params);
+	} else if (flags & MMU_OP_PHYS_PACK) {
+		invld_params.flags = 0;
+		rc = gaudi2_hmmus_invalidate_cache(hdev, &invld_params);
+	}
+
+	return rc;
+}
+
+static int gaudi2_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
+				u32 flags, u32 asid, u64 va, u64 size)
+{
+	struct gaudi2_cache_invld_params invld_params = {0};
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u64 start_va, end_va;
+	u32 inv_start_val;
+	int rc = 0;
+
+	if (hdev->reset_info.hard_reset_pending)
+		return 0;
+
+	inv_start_val = (1 << MMU_RANGE_INV_EN_SHIFT |
+			1 << MMU_RANGE_INV_ASID_EN_SHIFT |
+			asid << MMU_RANGE_INV_ASID_SHIFT);
+	start_va = va;
+	end_va = start_va + size;
+
+	if ((flags & MMU_OP_USERPTR) && (gaudi2->hw_cap_initialized & HW_CAP_PMMU)) {
+		/* As range invalidation does not support zero address we will
+		 * do full invalidation in this case
+		 */
+		if (start_va) {
+			invld_params.range_invalidation = true;
+			invld_params.start_va = start_va;
+			invld_params.end_va = end_va;
+			invld_params.inv_start_val = inv_start_val;
+			invld_params.flags = flags | MMU_OP_CLEAR_MEMCACHE;
+		} else {
+			invld_params.range_invalidation = false;
+			invld_params.inv_start_val = 1;
+			invld_params.flags = flags;
+		}
+
+
+		gaudi2_mmu_invalidate_cache_trigger(hdev, mmPMMU_HBW_STLB_BASE, &invld_params);
+		rc = gaudi2_mmu_invalidate_cache_status_poll(hdev, mmPMMU_HBW_STLB_BASE,
+										&invld_params);
+		if (rc)
+			return rc;
+
+	} else if (flags & MMU_OP_PHYS_PACK) {
+		invld_params.start_va = gaudi2_mmu_scramble_addr(hdev, start_va);
+		invld_params.end_va = gaudi2_mmu_scramble_addr(hdev, end_va);
+		invld_params.inv_start_val = inv_start_val;
+		invld_params.flags = flags;
+		rc = gaudi2_hmmus_invalidate_cache(hdev, &invld_params);
+	}
+
+	return rc;
+}
+
+static int gaudi2_mmu_update_hop0_addr(struct hl_device *hdev, u32 stlb_base)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 hop0_addr;
+	u32 asid, max_asid = prop->max_asid;
+	int rc;
+
+	/* it takes too much time to init all of the ASIDs on palladium */
+	if (hdev->pldm)
+		max_asid = min((u32) 8, max_asid);
+
+	for (asid = 0 ; asid < max_asid ; asid++) {
+		hop0_addr = hdev->mmu_priv.hr.mmu_asid_hop0[asid].phys_addr;
+		rc = gaudi2_mmu_update_asid_hop0_addr(hdev, stlb_base, asid, hop0_addr);
+		if (rc) {
+			dev_err(hdev->dev, "failed to set hop0 addr for asid %d\n", asid);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static int gaudi2_mmu_init_common(struct hl_device *hdev, u32 mmu_base,
+					u32 stlb_base)
+{
+	u32 status, timeout_usec;
+	int rc;
+
+	if (hdev->pldm || !hdev->pdev)
+		timeout_usec = GAUDI2_PLDM_MMU_TIMEOUT_USEC;
+	else
+		timeout_usec = GAUDI2_MMU_CACHE_INV_TIMEOUT_USEC;
+
+	WREG32(stlb_base + STLB_INV_ALL_START_OFFSET, 1);
+
+	rc = hl_poll_timeout(
+		hdev,
+		stlb_base + STLB_SRAM_INIT_OFFSET,
+		status,
+		!status,
+		1000,
+		timeout_usec);
+
+	if (rc)
+		dev_notice_ratelimited(hdev->dev, "Timeout when waiting for MMU SRAM init\n");
+
+	rc = gaudi2_mmu_update_hop0_addr(hdev, stlb_base);
+	if (rc)
+		return rc;
+
+	WREG32(mmu_base + MMU_BYPASS_OFFSET, 0);
+	WREG32(mmu_base + MMU_SPI_SEI_MASK_OFFSET, 0xF);
+
+	rc = hl_poll_timeout(
+		hdev,
+		stlb_base + STLB_INV_ALL_START_OFFSET,
+		status,
+		!status,
+		1000,
+		timeout_usec);
+
+	if (rc)
+		dev_notice_ratelimited(hdev->dev, "Timeout when waiting for MMU invalidate all\n");
+
+	WREG32(mmu_base + MMU_ENABLE_OFFSET, 1);
+
+	return rc;
+}
+
+static int gaudi2_pci_mmu_init(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 mmu_base, stlb_base;
+	int rc;
+
+	if (gaudi2->hw_cap_initialized & HW_CAP_PMMU)
+		return 0;
+
+	mmu_base = mmPMMU_HBW_MMU_BASE;
+	stlb_base = mmPMMU_HBW_STLB_BASE;
+
+	RMWREG32(stlb_base + STLB_HOP_CONFIGURATION_OFFSET,
+		(0 << PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_HOP_SHIFT) |
+		(5 << PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_SMALL_P_SHIFT) |
+		(4 << PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_LARGE_P_SHIFT) |
+		(5 << PMMU_HBW_STLB_HOP_CONFIGURATION_LAST_HOP_SHIFT) |
+		(5 << PMMU_HBW_STLB_HOP_CONFIGURATION_FOLLOWER_HOP_SHIFT),
+		PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_HOP_MASK |
+		PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_SMALL_P_MASK |
+		PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_LARGE_P_MASK |
+		PMMU_HBW_STLB_HOP_CONFIGURATION_LAST_HOP_MASK |
+		PMMU_HBW_STLB_HOP_CONFIGURATION_FOLLOWER_HOP_MASK);
+
+	WREG32(stlb_base + STLB_LL_LOOKUP_MASK_63_32_OFFSET, 0);
+
+	if (PAGE_SIZE == SZ_64K) {
+		/* Set page sizes to 64K on hop5 and 16M on hop4 + enable 8 bit hops */
+		RMWREG32(mmu_base + MMU_STATIC_MULTI_PAGE_SIZE_OFFSET,
+			FIELD_PREP(DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_HOP5_PAGE_SIZE_MASK, 4) |
+			FIELD_PREP(DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_HOP4_PAGE_SIZE_MASK, 3) |
+			FIELD_PREP(
+				DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_CFG_8_BITS_HOP_MODE_EN_MASK,
+				1),
+			DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_HOP5_PAGE_SIZE_MASK |
+			DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_HOP4_PAGE_SIZE_MASK |
+			DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_CFG_8_BITS_HOP_MODE_EN_MASK);
+	}
+
+	rc = gaudi2_mmu_init_common(hdev, mmu_base, stlb_base);
+	if (rc)
+		return rc;
+
+	gaudi2->hw_cap_initialized |= HW_CAP_PMMU;
+
+	return 0;
+}
+
+static int gaudi2_dcore_hmmu_init(struct hl_device *hdev, int dcore_id,
+				int hmmu_id)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 offset, mmu_base, stlb_base, hw_cap;
+	u8 dmmu_seq;
+	int rc;
+
+	dmmu_seq = NUM_OF_HMMU_PER_DCORE * dcore_id + hmmu_id;
+	hw_cap = HW_CAP_DCORE0_DMMU0 << dmmu_seq;
+
+	/*
+	 * return if DMMU is already initialized or if it's not out of
+	 * isolation (due to cluster binning)
+	 */
+	if ((gaudi2->hw_cap_initialized & hw_cap) || !(prop->hmmu_hif_enabled_mask & BIT(dmmu_seq)))
+		return 0;
+
+	offset = (u32) (dcore_id * DCORE_OFFSET + hmmu_id * DCORE_HMMU_OFFSET);
+	mmu_base = mmDCORE0_HMMU0_MMU_BASE + offset;
+	stlb_base = mmDCORE0_HMMU0_STLB_BASE + offset;
+
+	RMWREG32(mmu_base + MMU_STATIC_MULTI_PAGE_SIZE_OFFSET, 5 /* 64MB */,
+			MMU_STATIC_MULTI_PAGE_SIZE_HOP4_PAGE_SIZE_MASK);
+
+	RMWREG32(stlb_base + STLB_HOP_CONFIGURATION_OFFSET,
+		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_HOP_MASK, 0) |
+		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_SMALL_P_MASK, 3) |
+		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_LARGE_P_MASK, 3) |
+		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_LAST_HOP_MASK, 3) |
+		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FOLLOWER_HOP_MASK, 3),
+			DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_HOP_MASK |
+			DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_SMALL_P_MASK |
+			DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_LARGE_P_MASK |
+			DCORE0_HMMU0_STLB_HOP_CONFIGURATION_LAST_HOP_MASK |
+			DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FOLLOWER_HOP_MASK);
+
+	RMWREG32(stlb_base + STLB_HOP_CONFIGURATION_OFFSET, 1,
+			STLB_HOP_CONFIGURATION_ONLY_LARGE_PAGE_MASK);
+
+	rc = gaudi2_mmu_init_common(hdev, mmu_base, stlb_base);
+	if (rc)
+		return rc;
+
+	gaudi2->hw_cap_initialized |= hw_cap;
+
+	return 0;
+}
+
+static int gaudi2_hbm_mmu_init(struct hl_device *hdev)
+{
+	int rc, dcore_id, hmmu_id;
+
+	for (dcore_id = 0 ; dcore_id < NUM_OF_DCORES ; dcore_id++)
+		for (hmmu_id = 0 ; hmmu_id < NUM_OF_HMMU_PER_DCORE; hmmu_id++) {
+			rc = gaudi2_dcore_hmmu_init(hdev, dcore_id, hmmu_id);
+			if (rc)
+				return rc;
+		}
+
+	return 0;
+}
+
+static int gaudi2_mmu_init(struct hl_device *hdev)
+{
+	int rc;
+
+	rc = gaudi2_pci_mmu_init(hdev);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_hbm_mmu_init(hdev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int gaudi2_hw_init(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int rc;
+
+	/* Let's mark in the H/W that we have reached this point. We check
+	 * this value in the reset_before_init function to understand whether
+	 * we need to reset the chip before doing H/W init. This register is
+	 * cleared by the H/W upon H/W reset
+	 */
+	WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
+
+	/* Perform read from the device to make sure device is up */
+	RREG32(mmHW_STATE);
+
+	/* If iATU is done by FW, the HBM bar ALWAYS points to DRAM_PHYS_BASE.
+	 * So we set it here and if anyone tries to move it later to
+	 * a different address, there will be an error
+	 */
+	if (hdev->asic_prop.iatu_done_by_fw)
+		gaudi2->dram_bar_cur_addr = DRAM_PHYS_BASE;
+
+	/*
+	 * Before pushing u-boot/linux to device, need to set the hbm bar to
+	 * base address of dram
+	 */
+	if (gaudi2_set_hbm_bar_base(hdev, DRAM_PHYS_BASE) == U64_MAX) {
+		dev_err(hdev->dev, "failed to map HBM bar to DRAM base address\n");
+		return -EIO;
+	}
+
+	rc = gaudi2_init_cpu(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize CPU\n");
+		return rc;
+	}
+
+	gaudi2_init_msix_gw_table(hdev);
+
+	gaudi2_init_scrambler_hbm(hdev);
+	gaudi2_init_kdma(hdev);
+
+	rc = gaudi2_init_cpu_queues(hdev, GAUDI2_CPU_TIMEOUT_USEC);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize CPU H/W queues %d\n", rc);
+		return rc;
+	}
+
+	rc = gaudi2->cpucp_info_get(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to get cpucp info\n");
+		return rc;
+	}
+
+	rc = gaudi2_mmu_init(hdev);
+	if (rc)
+		return rc;
+
+	gaudi2_init_pdma(hdev);
+	gaudi2_init_edma(hdev);
+	gaudi2_init_sm(hdev);
+	gaudi2_init_tpc(hdev);
+	gaudi2_init_mme(hdev);
+	gaudi2_init_rotator(hdev);
+	gaudi2_init_dec(hdev);
+	gaudi2_enable_timestamp(hdev);
+
+	rc = gaudi2_enable_msix(hdev);
+	if (rc)
+		goto disable_queues;
+
+	/* Perform read from the device to flush all configuration */
+	RREG32(mmHW_STATE);
+
+	return 0;
+
+disable_queues:
+	gaudi2_disable_dma_qmans(hdev);
+	gaudi2_disable_mme_qmans(hdev);
+	gaudi2_disable_tpc_qmans(hdev);
+	gaudi2_disable_rot_qmans(hdev);
+	gaudi2_disable_nic_qmans(hdev);
+
+	gaudi2_disable_timestamp(hdev);
+
+	return rc;
+}
+
+/**
+ * gaudi2_send_hard_reset_cmd - common function to handle reset
+ *
+ * @hdev: pointer to the habanalabs device structure
+ *
+ * This function handles the various possible scenarios for reset.
+ * It considers if reset is handled by driver\FW and what FW components are loaded
+ */
+static void gaudi2_send_hard_reset_cmd(struct hl_device *hdev)
+{
+	struct cpu_dyn_regs *dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+	bool heartbeat_reset, preboot_only, cpu_initialized = false;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 cpu_boot_status;
+
+	preboot_only = (hdev->fw_loader.fw_comp_loaded == FW_TYPE_PREBOOT_CPU);
+	heartbeat_reset = (hdev->reset_info.curr_reset_cause == HL_RESET_CAUSE_HEARTBEAT);
+
+	/*
+	 * Handle corner case where failure was at cpu management app load,
+	 * and driver didn't detect any failure while loading the FW,
+	 * then at such scenario driver will send only HALT_MACHINE
+	 * and no one will respond to this request since FW already back to preboot
+	 * and it cannot handle such cmd.
+	 * In this case next time the management app loads it'll check on events register
+	 * which will still have the halt indication, and will reboot the device.
+	 * The solution is to let preboot clear all relevant registers before next boot
+	 * once driver send COMMS_RST_DEV.
+	 */
+	cpu_boot_status = RREG32(mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS);
+
+	if (gaudi2 && (gaudi2->hw_cap_initialized & HW_CAP_CPU) &&
+			(cpu_boot_status == CPU_BOOT_STATUS_SRAM_AVAIL))
+		cpu_initialized = true;
+
+	/*
+	 * when Linux/Bootfit exist this write to the SP can be interpreted in 2 ways:
+	 * 1. FW reset: FW initiate the reset sequence
+	 * 2. driver reset: FW will start HALT sequence (the preparations for the
+	 *                  reset but not the reset itself as it is not implemented
+	 *                  on their part) and LKD will wait to let FW complete the
+	 *                  sequence before issuing the reset
+	 */
+	if (!preboot_only && cpu_initialized) {
+		WREG32(le32_to_cpu(dyn_regs->gic_host_halt_irq),
+			gaudi2_irq_map_table[GAUDI2_EVENT_CPU_HALT_MACHINE].cpu_id);
+
+		msleep(GAUDI2_CPU_RESET_WAIT_MSEC);
+	}
+
+	/*
+	 * When working with preboot (without Linux/Boot fit) we can
+	 * communicate only using the COMMS commands to issue halt/reset.
+	 *
+	 * For the case in which we are working with Linux/Bootfit this is a hail-mary
+	 * attempt to revive the card in the small chance that the f/w has
+	 * experienced a watchdog event, which caused it to return back to preboot.
+	 * In that case, triggering reset through GIC won't help. We need to
+	 * trigger the reset as if Linux wasn't loaded.
+	 *
+	 * We do it only if the reset cause was HB, because that would be the
+	 * indication of such an event.
+	 *
+	 * In case watchdog hasn't expired but we still got HB, then this won't
+	 * do any damage.
+	 */
+
+	if (heartbeat_reset || preboot_only || !cpu_initialized) {
+		if (hdev->asic_prop.hard_reset_done_by_fw)
+			hl_fw_ask_hard_reset_without_linux(hdev);
+		else
+			hl_fw_ask_halt_machine_without_linux(hdev);
+	}
+}
+
+/**
+ * gaudi2_execute_hard_reset - execute hard reset by driver/FW
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @reset_sleep_ms: sleep time in msec after reset
+ *
+ * This function executes hard reset based on if driver/FW should do the reset
+ */
+static void gaudi2_execute_hard_reset(struct hl_device *hdev, u32 reset_sleep_ms)
+{
+	if (hdev->asic_prop.hard_reset_done_by_fw) {
+		gaudi2_send_hard_reset_cmd(hdev);
+		return;
+	}
+
+	/* Set device to handle FLR by H/W as we will put the device
+	 * CPU to halt mode
+	 */
+	WREG32(mmPCIE_AUX_FLR_CTRL,
+			(PCIE_AUX_FLR_CTRL_HW_CTRL_MASK | PCIE_AUX_FLR_CTRL_INT_MASK_MASK));
+
+	gaudi2_send_hard_reset_cmd(hdev);
+
+	WREG32(mmPSOC_RESET_CONF_SW_ALL_RST, 1);
+}
+
+/**
+ * gaudi2_execute_soft_reset - execute soft reset by driver/FW
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @reset_sleep_ms: sleep time in msec after reset
+ * @driver_performs_reset: true if driver should perform reset instead of f/w.
+ *
+ * This function executes soft reset based on if driver/FW should do the reset
+ */
+static void gaudi2_execute_soft_reset(struct hl_device *hdev, u32 reset_sleep_ms,
+						bool driver_performs_reset)
+{
+	struct cpu_dyn_regs *dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+
+	if (!driver_performs_reset) {
+		/* set SP to indicate reset request sent to FW */
+		WREG32(mmCPU_RST_STATUS_TO_HOST, CPU_RST_STATUS_NA);
+
+		WREG32(le32_to_cpu(dyn_regs->gic_host_soft_rst_irq),
+			gaudi2_irq_map_table[GAUDI2_EVENT_CPU_SOFT_RESET].cpu_id);
+		return;
+	}
+
+	WREG32(mmPSOC_RESET_CONF_SOFT_RST, 1);
+}
+
+static void gaudi2_poll_btm_indication(struct hl_device *hdev, u32 reset_sleep_ms,
+								u32 poll_timeout_us)
+{
+	int i, rc = 0;
+	u32 reg_val;
+
+	/* without this sleep reset will not work */
+	msleep(reset_sleep_ms);
+
+	/* We poll the BTM done indication multiple times after reset due to
+	 * a HW errata 'GAUDI2_0300'
+	 */
+	for (i = 0 ; i < GAUDI2_RESET_POLL_CNT ; i++)
+		rc = hl_poll_timeout(
+			hdev,
+			mmPSOC_GLOBAL_CONF_BTM_FSM,
+			reg_val,
+			reg_val == 0,
+			1000,
+			poll_timeout_us);
+
+	if (rc)
+		dev_err(hdev->dev, "Timeout while waiting for device to reset 0x%x\n", reg_val);
+}
+
+static void gaudi2_get_soft_rst_done_indication(struct hl_device *hdev, u32 poll_timeout_us)
+{
+	int i, rc = 0;
+	u32 reg_val;
+
+	for (i = 0 ; i < GAUDI2_RESET_POLL_CNT ; i++)
+		rc = hl_poll_timeout(
+			hdev,
+			mmCPU_RST_STATUS_TO_HOST,
+			reg_val,
+			reg_val == CPU_RST_STATUS_SOFT_RST_DONE,
+			1000,
+			poll_timeout_us);
+
+	if (rc)
+		dev_err(hdev->dev, "Timeout while waiting for FW to complete soft reset (0x%x)\n",
+				reg_val);
+}
+
+static void gaudi2_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 poll_timeout_us, reset_sleep_ms;
+	bool driver_performs_reset = false;
+
+	if (hdev->pldm) {
+		reset_sleep_ms = hard_reset ? GAUDI2_PLDM_HRESET_TIMEOUT_MSEC :
+						GAUDI2_PLDM_SRESET_TIMEOUT_MSEC;
+		poll_timeout_us = GAUDI2_PLDM_RESET_POLL_TIMEOUT_USEC;
+	} else {
+		reset_sleep_ms = GAUDI2_RESET_TIMEOUT_MSEC;
+		poll_timeout_us = GAUDI2_RESET_POLL_TIMEOUT_USEC;
+	}
+
+	if (fw_reset)
+		goto skip_reset;
+
+	gaudi2_reset_arcs(hdev);
+
+	if (hard_reset) {
+		driver_performs_reset = !hdev->asic_prop.hard_reset_done_by_fw;
+		gaudi2_execute_hard_reset(hdev, reset_sleep_ms);
+	} else {
+		/*
+		 * As we have to support also work with preboot only (which does not supports
+		 * soft reset) we have to make sure that security is disabled before letting driver
+		 * do the reset. user shall control the BFE flags to avoid asking soft reset in
+		 * secured device with preboot only.
+		 */
+		driver_performs_reset = (hdev->fw_components == FW_TYPE_PREBOOT_CPU &&
+							!hdev->asic_prop.fw_security_enabled);
+		gaudi2_execute_soft_reset(hdev, reset_sleep_ms, driver_performs_reset);
+	}
+
+skip_reset:
+	if (driver_performs_reset || hard_reset)
+		gaudi2_poll_btm_indication(hdev, reset_sleep_ms, poll_timeout_us);
+	else
+		gaudi2_get_soft_rst_done_indication(hdev, poll_timeout_us);
+
+	if (!gaudi2)
+		return;
+
+	gaudi2->dec_hw_cap_initialized &= ~(HW_CAP_DEC_MASK);
+	gaudi2->tpc_hw_cap_initialized &= ~(HW_CAP_TPC_MASK);
+
+	/*
+	 * Clear NIC capability mask in order for driver to re-configure
+	 * NIC QMANs. NIC ports will not be re-configured during soft
+	 * reset as we call gaudi2_nic_init only during hard reset
+	 */
+	gaudi2->nic_hw_cap_initialized &= ~(HW_CAP_NIC_MASK);
+
+	if (hard_reset) {
+		gaudi2->hw_cap_initialized &=
+			~(HW_CAP_DRAM | HW_CAP_CLK_GATE | HW_CAP_HBM_SCRAMBLER_MASK |
+			HW_CAP_PMMU | HW_CAP_CPU | HW_CAP_CPU_Q |
+			HW_CAP_SRAM_SCRAMBLER | HW_CAP_DMMU_MASK |
+			HW_CAP_PDMA_MASK | HW_CAP_EDMA_MASK | HW_CAP_KDMA |
+			HW_CAP_MME_MASK | HW_CAP_ROT_MASK);
+
+		memset(gaudi2->events_stat, 0, sizeof(gaudi2->events_stat));
+	} else {
+		gaudi2->hw_cap_initialized &=
+			~(HW_CAP_CLK_GATE | HW_CAP_HBM_SCRAMBLER_SW_RESET |
+			HW_CAP_PDMA_MASK | HW_CAP_EDMA_MASK | HW_CAP_MME_MASK |
+			HW_CAP_ROT_MASK);
+	}
+}
+
+static int gaudi2_suspend(struct hl_device *hdev)
+{
+	int rc;
+
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	if (rc)
+		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
+
+	return rc;
+}
+
+static int gaudi2_resume(struct hl_device *hdev)
+{
+	return gaudi2_init_iatu(hdev);
+}
+
+static int gaudi2_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+	int rc;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
+			VM_DONTCOPY | VM_NORESERVE;
+
+#ifdef _HAS_DMA_MMAP_COHERENT
+
+	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
+	if (rc)
+		dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
+
+#else
+
+	rc = remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(cpu_addr) >> PAGE_SHIFT,
+				size, vma->vm_page_prot);
+	if (rc)
+		dev_err(hdev->dev, "remap_pfn_range error %d", rc);
+
+#endif
+
+	return rc;
+}
+
+static bool gaudi2_is_queue_enabled(struct hl_device *hdev, u32 hw_queue_id)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u64 hw_cap_mask = 0;
+	u64 hw_tpc_cap_bit = 0;
+	u64 hw_nic_cap_bit = 0;
+	u64 hw_test_cap_bit = 0;
+
+	switch (hw_queue_id) {
+	case GAUDI2_QUEUE_ID_PDMA_0_0 ... GAUDI2_QUEUE_ID_PDMA_1_1:
+		hw_cap_mask = HW_CAP_PDMA_MASK;
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3:
+		hw_test_cap_bit = HW_CAP_EDMA_SHIFT +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0) >> 2);
+		break;
+	case GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE1_EDMA_1_3:
+		hw_test_cap_bit = HW_CAP_EDMA_SHIFT + NUM_OF_EDMA_PER_DCORE +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0) >> 2);
+		break;
+	case GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE2_EDMA_1_3:
+		hw_test_cap_bit = HW_CAP_EDMA_SHIFT + 2 * NUM_OF_EDMA_PER_DCORE +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0) >> 2);
+		break;
+	case GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3:
+		hw_test_cap_bit = HW_CAP_EDMA_SHIFT + 3 * NUM_OF_EDMA_PER_DCORE +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0) >> 2);
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE0_MME_0_0 ... GAUDI2_QUEUE_ID_DCORE0_MME_0_3:
+		hw_test_cap_bit = HW_CAP_MME_SHIFT;
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE1_MME_0_0 ... GAUDI2_QUEUE_ID_DCORE1_MME_0_3:
+		hw_test_cap_bit = HW_CAP_MME_SHIFT + 1;
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE2_MME_0_0 ... GAUDI2_QUEUE_ID_DCORE2_MME_0_3:
+		hw_test_cap_bit = HW_CAP_MME_SHIFT + 2;
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE3_MME_0_0 ... GAUDI2_QUEUE_ID_DCORE3_MME_0_3:
+		hw_test_cap_bit = HW_CAP_MME_SHIFT + 3;
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE0_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE0_TPC_5_3:
+		hw_tpc_cap_bit = HW_CAP_TPC_SHIFT +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE0_TPC_0_0) >> 2);
+
+		/* special case where cap bit refers to the first queue id */
+		if (!hw_tpc_cap_bit)
+			return !!(gaudi2->tpc_hw_cap_initialized & BIT_ULL(0));
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE1_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE1_TPC_5_3:
+		hw_tpc_cap_bit = HW_CAP_TPC_SHIFT + NUM_OF_TPC_PER_DCORE +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE1_TPC_0_0) >> 2);
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE2_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE2_TPC_5_3:
+		hw_tpc_cap_bit = HW_CAP_TPC_SHIFT + (2 * NUM_OF_TPC_PER_DCORE) +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE2_TPC_0_0) >> 2);
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE3_TPC_0_0 ... GAUDI2_QUEUE_ID_DCORE3_TPC_5_3:
+		hw_tpc_cap_bit = HW_CAP_TPC_SHIFT + (3 * NUM_OF_TPC_PER_DCORE) +
+			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE3_TPC_0_0) >> 2);
+		break;
+
+	case GAUDI2_QUEUE_ID_DCORE0_TPC_6_0 ... GAUDI2_QUEUE_ID_DCORE0_TPC_6_3:
+		hw_tpc_cap_bit = HW_CAP_TPC_SHIFT + (4 * NUM_OF_TPC_PER_DCORE);
+		break;
+
+	case GAUDI2_QUEUE_ID_ROT_0_0 ... GAUDI2_QUEUE_ID_ROT_1_3:
+		hw_test_cap_bit = HW_CAP_ROT_SHIFT + ((hw_queue_id - GAUDI2_QUEUE_ID_ROT_0_0) >> 2);
+		break;
+
+	case GAUDI2_QUEUE_ID_NIC_0_0 ... GAUDI2_QUEUE_ID_NIC_23_3:
+		hw_nic_cap_bit = HW_CAP_NIC_SHIFT + ((hw_queue_id - GAUDI2_QUEUE_ID_NIC_0_0) >> 2);
+
+		/* special case where cap bit refers to the first queue id */
+		if (!hw_nic_cap_bit)
+			return !!(gaudi2->nic_hw_cap_initialized & BIT_ULL(0));
+		break;
+
+	case GAUDI2_QUEUE_ID_CPU_PQ:
+		return !!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q);
+
+	default:
+		return false;
+	}
+
+	if (hw_tpc_cap_bit)
+		return  !!(gaudi2->tpc_hw_cap_initialized & BIT_ULL(hw_tpc_cap_bit));
+
+	if (hw_nic_cap_bit)
+		return  !!(gaudi2->nic_hw_cap_initialized & BIT_ULL(hw_nic_cap_bit));
+
+	if (hw_test_cap_bit)
+		hw_cap_mask = BIT_ULL(hw_test_cap_bit);
+
+	return !!(gaudi2->hw_cap_initialized & hw_cap_mask);
+}
+
+static bool gaudi2_is_arc_enabled(struct hl_device *hdev, u64 arc_id)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	switch (arc_id) {
+	case CPU_ID_SCHED_ARC0 ... CPU_ID_SCHED_ARC5:
+	case CPU_ID_MME_QMAN_ARC0...CPU_ID_ROT_QMAN_ARC1:
+		return !!(gaudi2->active_hw_arc & BIT_ULL(arc_id));
+
+	case CPU_ID_TPC_QMAN_ARC0...CPU_ID_TPC_QMAN_ARC24:
+		return !!(gaudi2->active_tpc_arc & BIT_ULL(arc_id - CPU_ID_TPC_QMAN_ARC0));
+
+	case CPU_ID_NIC_QMAN_ARC0...CPU_ID_NIC_QMAN_ARC23:
+		return !!(gaudi2->active_nic_arc & BIT_ULL(arc_id - CPU_ID_NIC_QMAN_ARC0));
+
+	default:
+		return false;
+	}
+}
+
+static void gaudi2_clr_arc_id_cap(struct hl_device *hdev, u64 arc_id)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	switch (arc_id) {
+	case CPU_ID_SCHED_ARC0 ... CPU_ID_SCHED_ARC5:
+	case CPU_ID_MME_QMAN_ARC0...CPU_ID_ROT_QMAN_ARC1:
+		gaudi2->active_hw_arc &= ~(BIT_ULL(arc_id));
+		break;
+
+	case CPU_ID_TPC_QMAN_ARC0...CPU_ID_TPC_QMAN_ARC24:
+		gaudi2->active_tpc_arc &= ~(BIT_ULL(arc_id - CPU_ID_TPC_QMAN_ARC0));
+		break;
+
+	case CPU_ID_NIC_QMAN_ARC0...CPU_ID_NIC_QMAN_ARC23:
+		gaudi2->active_nic_arc &= ~(BIT_ULL(arc_id - CPU_ID_NIC_QMAN_ARC0));
+		break;
+
+	default:
+		return;
+	}
+}
+
+static void gaudi2_set_arc_id_cap(struct hl_device *hdev, u64 arc_id)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	switch (arc_id) {
+	case CPU_ID_SCHED_ARC0 ... CPU_ID_SCHED_ARC5:
+	case CPU_ID_MME_QMAN_ARC0...CPU_ID_ROT_QMAN_ARC1:
+		gaudi2->active_hw_arc |= BIT_ULL(arc_id);
+		break;
+
+	case CPU_ID_TPC_QMAN_ARC0...CPU_ID_TPC_QMAN_ARC24:
+		gaudi2->active_tpc_arc |= BIT_ULL(arc_id - CPU_ID_TPC_QMAN_ARC0);
+		break;
+
+	case CPU_ID_NIC_QMAN_ARC0...CPU_ID_NIC_QMAN_ARC23:
+		gaudi2->active_nic_arc |= BIT_ULL(arc_id - CPU_ID_NIC_QMAN_ARC0);
+		break;
+
+	default:
+		return;
+	}
+}
+
+static void gaudi2_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
+{
+	struct cpu_dyn_regs *dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+	u32 pq_offset, reg_base, db_reg_offset, db_value;
+
+	if (hw_queue_id != GAUDI2_QUEUE_ID_CPU_PQ) {
+		/*
+		 * QMAN has 4 successive PQ_PI registers, 1 for each of the QMAN PQs.
+		 * Masking the H/W queue ID with 0x3 extracts the QMAN internal PQ
+		 * number.
+		 */
+		pq_offset = (hw_queue_id & 0x3) * 4;
+		reg_base = gaudi2_qm_blocks_bases[hw_queue_id];
+		db_reg_offset = reg_base + QM_PQ_PI_0_OFFSET + pq_offset;
+	} else {
+		db_reg_offset = mmCPU_IF_PF_PQ_PI;
+	}
+
+	db_value = pi;
+
+	/* ring the doorbell */
+	WREG32(db_reg_offset, db_value);
+
+	if (hw_queue_id == GAUDI2_QUEUE_ID_CPU_PQ) {
+		/* make sure device CPU will read latest data from host */
+		mb();
+		WREG32(le32_to_cpu(dyn_regs->gic_host_pi_upd_irq),
+			gaudi2_irq_map_table[GAUDI2_EVENT_CPU_PI_UPDATE].cpu_id);
+	}
+}
+
+static void gaudi2_pqe_write(struct hl_device *hdev, __le64 *pqe, struct hl_bd *bd)
+{
+	__le64 *pbd = (__le64 *) bd;
+
+	/* The QMANs are on the host memory so a simple copy suffice */
+	pqe[0] = pbd[0];
+	pqe[1] = pbd[1];
+}
+
+static void *gaudi2_dma_alloc_coherent(struct hl_device *hdev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flags)
+{
+	return dma_alloc_coherent(&hdev->pdev->dev, size, dma_handle, flags);
+}
+
+static void gaudi2_dma_free_coherent(struct hl_device *hdev, size_t size,
+				void *cpu_addr, dma_addr_t dma_handle)
+{
+	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
+}
+
+static int gaudi2_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
+				u32 timeout, u64 *result)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q)) {
+		if (result)
+			*result = 0;
+		return 0;
+	}
+
+	if (!timeout)
+		timeout = GAUDI2_MSG_TO_CPU_TIMEOUT_USEC;
+
+	return hl_fw_send_cpu_message(hdev, GAUDI2_QUEUE_ID_CPU_PQ, msg, len, timeout, result);
+}
+
+static void *gaudi2_dma_pool_zalloc(struct hl_device *hdev, size_t size,
+				gfp_t mem_flags, dma_addr_t *dma_handle)
+{
+	if (size > GAUDI2_DMA_POOL_BLK_SIZE)
+		return NULL;
+
+	return dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
+}
+
+static void gaudi2_dma_pool_free(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr)
+{
+	dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
+}
+
+static void *gaudi2_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
+						dma_addr_t *dma_handle)
+{
+	return hl_fw_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
+}
+
+static void gaudi2_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size, void *vaddr)
+{
+	hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
+}
+
+static dma_addr_t gaudi2_dma_map_single(struct hl_device *hdev, void *addr, int len,
+					enum dma_data_direction dir)
+{
+	dma_addr_t dma_addr;
+
+	dma_addr = dma_map_single(&hdev->pdev->dev, addr, len, dir);
+	if (unlikely(dma_mapping_error(&hdev->pdev->dev, dma_addr)))
+		return 0;
+
+	return dma_addr;
+}
+
+static void gaudi2_dma_unmap_single(struct hl_device *hdev, dma_addr_t addr, int len,
+					enum dma_data_direction dir)
+{
+	dma_unmap_single(&hdev->pdev->dev, addr, len, dir);
+}
+
+static int gaudi2_validate_cb_address(struct hl_device *hdev, struct hl_cs_parser *parser)
+{
+	struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!gaudi2_is_queue_enabled(hdev, parser->hw_queue_id)) {
+		dev_err(hdev->dev, "h/w queue %d is disabled\n", parser->hw_queue_id);
+		return -EINVAL;
+	}
+
+	/* Just check if CB address is valid */
+
+	if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
+					parser->user_cb_size,
+					asic_prop->sram_user_base_address,
+					asic_prop->sram_end_address))
+		return 0;
+
+	if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
+					parser->user_cb_size,
+					asic_prop->dram_user_base_address,
+					asic_prop->dram_end_address))
+		return 0;
+
+	if ((gaudi2->hw_cap_initialized & HW_CAP_DMMU_MASK) &&
+		hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
+						parser->user_cb_size,
+						asic_prop->dmmu.start_addr,
+						asic_prop->dmmu.end_addr))
+		return 0;
+
+	if (gaudi2->hw_cap_initialized & HW_CAP_PMMU) {
+		if (hl_mem_area_inside_range((u64) (uintptr_t) parser->user_cb,
+					parser->user_cb_size,
+					asic_prop->pmmu.start_addr,
+					asic_prop->pmmu.end_addr) ||
+			hl_mem_area_inside_range(
+					(u64) (uintptr_t) parser->user_cb,
+					parser->user_cb_size,
+					asic_prop->pmmu_huge.start_addr,
+					asic_prop->pmmu_huge.end_addr))
+			return 0;
+
+	} else if (gaudi2_host_phys_addr_valid((u64) (uintptr_t) parser->user_cb)) {
+		if (!hdev->pdev)
+			return 0;
+
+		if (!device_iommu_mapped(&hdev->pdev->dev))
+			return 0;
+	}
+
+	dev_err(hdev->dev, "CB address %p + 0x%x for internal QMAN is not valid\n",
+		parser->user_cb, parser->user_cb_size);
+
+	return -EFAULT;
+}
+
+static int gaudi2_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!parser->is_kernel_allocated_cb)
+		return gaudi2_validate_cb_address(hdev, parser);
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_PMMU)) {
+		dev_err(hdev->dev, "PMMU not initialized - Unsupported mode in Gaudi2\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gaudi2_send_heartbeat(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	return hl_fw_send_heartbeat(hdev);
+}
+
+/* This is an internal helper function, used to update the KDMA mmu props.
+ * Should be called with a proper kdma lock.
+ */
+static void gaudi2_kdma_set_mmbp_asid(struct hl_device *hdev,
+					   bool mmu_bypass, u32 asid)
+{
+	u32 rw_asid, rw_mmu_bp;
+
+	rw_asid = (asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_RD_SHIFT) |
+		      (asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_WR_SHIFT);
+
+	rw_mmu_bp = (!!mmu_bypass << ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_RD_SHIFT) |
+			(!!mmu_bypass << ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_WR_SHIFT);
+
+	WREG32(mmARC_FARM_KDMA_CTX_AXUSER_HB_ASID, rw_asid);
+	WREG32(mmARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP, rw_mmu_bp);
+}
+
+static void gaudi2_arm_cq_monitor(struct hl_device *hdev, u32 index, u32 cq_id,
+						u32 mon_payload, u32 sync_value)
+{
+	int offset = index * 4;
+	u32 sync_group_id, mask, mode, mon_arm;
+
+	/* Reset the SOB value */
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset, 0);
+
+	/* Configure this address with CQ_ID 0 because CQ_EN is set */
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + offset, cq_id);
+
+	/* Configure this address with CS index because CQ_EN is set */
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + offset, mon_payload);
+
+	sync_group_id = index / 8;
+	mask = ~(1 << (index & 0x7));
+	mode = 1; /* comparison mode is "equal to" */
+
+	mon_arm = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOD_MASK, sync_value);
+	mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOP_MASK, mode);
+	mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_MASK_MASK, mask);
+	mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SID_MASK, sync_group_id);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + offset, mon_arm);
+}
+
+/* This is an internal helper function used by gaudi2_send_job_to_kdma only */
+static int gaudi2_send_job_to_kdma(struct hl_device *hdev,
+					u64 src_addr, u64 dst_addr,
+					u32 size, bool is_memset)
+{
+	u32 comp_val, commit_mask, *polling_addr, timeout, status = 0;
+	struct hl_cq_entry *cq_base;
+	struct hl_cq *cq;
+	u64 comp_addr;
+	int rc;
+
+	gaudi2_arm_cq_monitor(hdev, GAUDI2_RESERVED_SOB_KDMA_COMP,
+				GAUDI2_RESERVED_CQ_KDMA_COMPLETION, 1, 1);
+
+	comp_addr = CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 +
+			(GAUDI2_RESERVED_SOB_KDMA_COMP * sizeof(u32));
+
+	comp_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1) |
+			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1);
+
+	WREG32(mmARC_FARM_KDMA_CTX_SRC_BASE_LO, lower_32_bits(src_addr));
+	WREG32(mmARC_FARM_KDMA_CTX_SRC_BASE_HI, upper_32_bits(src_addr));
+	WREG32(mmARC_FARM_KDMA_CTX_DST_BASE_LO, lower_32_bits(dst_addr));
+	WREG32(mmARC_FARM_KDMA_CTX_DST_BASE_HI, upper_32_bits(dst_addr));
+	WREG32(mmARC_FARM_KDMA_CTX_WR_COMP_ADDR_LO, lower_32_bits(comp_addr));
+	WREG32(mmARC_FARM_KDMA_CTX_WR_COMP_ADDR_HI, upper_32_bits(comp_addr));
+	WREG32(mmARC_FARM_KDMA_CTX_WR_COMP_WDATA, comp_val);
+	WREG32(mmARC_FARM_KDMA_CTX_DST_TSIZE_0, size);
+
+	commit_mask = FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_LIN_MASK, 1) |
+				FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_WR_COMP_EN_MASK, 1);
+
+	if (is_memset)
+		commit_mask |= FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_MEM_SET_MASK, 1);
+
+	WREG32(mmARC_FARM_KDMA_CTX_COMMIT, commit_mask);
+
+	/* Wait for completion */
+	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_KDMA_COMPLETION];
+	cq_base = cq->kernel_address;
+	polling_addr = (u32 *)&cq_base[cq->ci];
+
+	if (hdev->pldm)
+		/* for each 1MB 20 second of timeout */
+		timeout = ((size / SZ_1M) + 1) * USEC_PER_SEC * 20;
+	else
+		timeout = KDMA_TIMEOUT_USEC;
+
+	/* Polling */
+	rc = hl_poll_timeout_memory(
+			hdev,
+			polling_addr,
+			status,
+			(status == 1),
+			1000,
+			timeout,
+			true);
+
+	*polling_addr = 0;
+
+	if (rc) {
+		dev_err(hdev->dev, "Timeout while waiting for KDMA to be idle\n");
+		WREG32(mmARC_FARM_KDMA_CFG_1, 1 << ARC_FARM_KDMA_CFG_1_HALT_SHIFT);
+		return rc;
+	}
+
+	cq->ci = hl_cq_inc_ptr(cq->ci);
+
+	return 0;
+}
+
+static void gaudi2_memset_device_lbw(struct hl_device *hdev, u32 addr, u32 size, u32 val)
+{
+	u32 i;
+
+	for (i = 0 ; i < size ; i += sizeof(u32))
+		WREG32(addr + i, val);
+}
+
+static void gaudi2_qman_set_test_mode(struct hl_device *hdev, u32 hw_queue_id, bool enable)
+{
+	u32 reg_base = gaudi2_qm_blocks_bases[hw_queue_id];
+
+	if (enable) {
+		WREG32(reg_base + QM_GLBL_PROT_OFFSET, QMAN_MAKE_TRUSTED_TEST_MODE);
+		WREG32(reg_base + QM_PQC_CFG_OFFSET, 0);
+	} else {
+		WREG32(reg_base + QM_GLBL_PROT_OFFSET, QMAN_MAKE_TRUSTED);
+		WREG32(reg_base + QM_PQC_CFG_OFFSET, 1 << PDMA0_QM_PQC_CFG_EN_SHIFT);
+	}
+}
+
+static int gaudi2_test_queue(struct hl_device *hdev, u32 hw_queue_id)
+{
+	u32 sob_offset = hdev->asic_prop.first_available_user_sob[0] * 4;
+	u32 sob_addr = mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset;
+	u32 timeout_usec, tmp, sob_base = 1, sob_val = 0x5a5a;
+	struct packet_msg_short *msg_short_pkt;
+	dma_addr_t pkt_dma_addr;
+	size_t pkt_size;
+	int rc;
+
+	if (hdev->pldm)
+		timeout_usec = GAUDI2_PLDM_TEST_QUEUE_WAIT_USEC;
+	else
+		timeout_usec = GAUDI2_TEST_QUEUE_WAIT_USEC;
+
+	pkt_size = sizeof(*msg_short_pkt);
+	msg_short_pkt = hl_asic_dma_pool_zalloc(hdev, pkt_size, GFP_KERNEL, &pkt_dma_addr);
+	if (!msg_short_pkt) {
+		dev_err(hdev->dev, "Failed to allocate packet for H/W queue %d testing\n",
+			hw_queue_id);
+		return -ENOMEM;
+	}
+
+	tmp = (PACKET_MSG_SHORT << GAUDI2_PKT_CTL_OPCODE_SHIFT) |
+		(1 << GAUDI2_PKT_CTL_EB_SHIFT) |
+		(1 << GAUDI2_PKT_CTL_MB_SHIFT) |
+		(sob_base << GAUDI2_PKT_SHORT_CTL_BASE_SHIFT) |
+		(sob_offset << GAUDI2_PKT_SHORT_CTL_ADDR_SHIFT);
+
+	msg_short_pkt->value = cpu_to_le32(sob_val);
+	msg_short_pkt->ctl = cpu_to_le32(tmp);
+
+	/* Reset the SOB value */
+	WREG32(sob_addr, 0);
+
+	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id, pkt_size, pkt_dma_addr);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to send msg_short packet to H/W queue %d\n",
+			hw_queue_id);
+		goto free_pkt;
+	}
+
+	rc = hl_poll_timeout(
+			hdev,
+			sob_addr,
+			tmp,
+			(tmp == sob_val),
+			1000,
+			timeout_usec);
+
+	if (rc == -ETIMEDOUT) {
+		dev_err(hdev->dev, "H/W queue %d test failed (SOB_OBJ_0 == 0x%x)\n",
+			hw_queue_id, tmp);
+		rc = -EIO;
+	}
+
+	/* Reset the SOB value */
+	WREG32(sob_addr, 0);
+
+free_pkt:
+	hl_asic_dma_pool_free(hdev, (void *) msg_short_pkt, pkt_dma_addr);
+	return rc;
+}
+
+static int gaudi2_test_cpu_queue(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	/*
+	 * check capability here as send_cpu_message() won't update the result
+	 * value if no capability
+	 */
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	return hl_fw_test_cpu_queue(hdev);
+}
+
+static int gaudi2_test_queues(struct hl_device *hdev)
+{
+	int i, rc, ret_val = 0;
+
+	for (i = GAUDI2_QUEUE_ID_PDMA_0_0 ; i < GAUDI2_QUEUE_ID_CPU_PQ; i++) {
+		if (!gaudi2_is_queue_enabled(hdev, i))
+			continue;
+
+		gaudi2_qman_set_test_mode(hdev, i, true);
+		rc = gaudi2_test_queue(hdev, i);
+		gaudi2_qman_set_test_mode(hdev, i, false);
+
+		if (rc) {
+			ret_val = -EINVAL;
+			goto done;
+		}
+	}
+
+	rc = gaudi2_test_cpu_queue(hdev);
+	if (rc) {
+		ret_val = -EINVAL;
+		goto done;
+	}
+
+done:
+	return ret_val;
+}
+
+static int gaudi2_non_hard_reset_late_init(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	size_t irq_arr_size;
+
+	/* TODO: missing gaudi2_nic_resume.
+	 * Until implemented nic_hw_cap_initialized will remain zeroed
+	 */
+	gaudi2_init_arcs(hdev);
+	gaudi2_scrub_arcs_dccm(hdev);
+
+	/* Unmask all IRQs since some could have been received during the soft reset */
+	irq_arr_size = gaudi2->num_of_valid_hw_events * sizeof(gaudi2->hw_events[0]);
+	return hl_fw_unmask_irq_arr(hdev, gaudi2->hw_events, irq_arr_size);
+}
+
+static void gaudi2_is_tpc_engine_idle(struct hl_device *hdev, int dcore, int inst, u32 offset,
+					void *data)
+{
+	struct gaudi2_tpc_idle_data *idle_data = (struct gaudi2_tpc_idle_data *)data;
+	u32 tpc_cfg_sts, qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts;
+	bool is_eng_idle;
+	int engine_idx;
+
+	if ((dcore == 0) && (inst == (NUM_DCORE0_TPC - 1)))
+		engine_idx = GAUDI2_DCORE0_ENGINE_ID_TPC_6;
+	else
+		engine_idx = GAUDI2_DCORE0_ENGINE_ID_TPC_0 +
+				dcore * GAUDI2_ENGINE_ID_DCORE_OFFSET + inst;
+
+	tpc_cfg_sts = RREG32(mmDCORE0_TPC0_CFG_STATUS + offset);
+	qm_glbl_sts0 = RREG32(mmDCORE0_TPC0_QM_GLBL_STS0 + offset);
+	qm_glbl_sts1 = RREG32(mmDCORE0_TPC0_QM_GLBL_STS1 + offset);
+	qm_cgm_sts = RREG32(mmDCORE0_TPC0_QM_CGM_STS + offset);
+
+	is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts) &&
+						IS_TPC_IDLE(tpc_cfg_sts);
+	*(idle_data->is_idle) &= is_eng_idle;
+
+	if (idle_data->mask && !is_eng_idle)
+		set_bit(engine_idx, idle_data->mask);
+
+	if (idle_data->s)
+		seq_printf(idle_data->s, idle_data->tpc_fmt, dcore, inst,
+					is_eng_idle ? "Y" : "N",
+					qm_glbl_sts0, qm_cgm_sts, tpc_cfg_sts);
+}
+
+static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
+					u8 mask_len, struct seq_file *s)
+{
+	u32 qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts, dma_core_idle_ind_mask,
+		mme_arch_sts, dec_swreg15, dec_enabled_bit;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	const char *rot_fmt = "%-6d%-5d%-9s%#-14x%#-12x%s\n";
+	unsigned long *mask = (unsigned long *) mask_arr;
+	const char *edma_fmt = "%-6d%-6d%-9s%#-14x%#x\n";
+	const char *mme_fmt = "%-5d%-6s%-9s%#-14x%#x\n";
+	const char *nic_fmt = "%-5d%-9s%#-14x%#-12x\n";
+	const char *pdma_fmt = "%-6d%-9s%#-14x%#x\n";
+	const char *pcie_dec_fmt = "%-10d%-9s%#x\n";
+	const char *dec_fmt = "%-6d%-5d%-9s%#x\n";
+	bool is_idle = true, is_eng_idle;
+	u64 offset;
+
+	struct gaudi2_tpc_idle_data tpc_idle_data = {
+		.tpc_fmt = "%-6d%-5d%-9s%#-14x%#-12x%#x\n",
+		.s = s,
+		.mask = mask,
+		.is_idle = &is_idle,
+	};
+	struct iterate_module_ctx tpc_iter = {
+		.fn = &gaudi2_is_tpc_engine_idle,
+		.data = &tpc_idle_data,
+	};
+
+	int engine_idx, i, j;
+
+	/* EDMA, Two engines per Dcore */
+	if (s)
+		seq_puts(s,
+			"\nCORE  EDMA  is_idle  QM_GLBL_STS0  DMA_CORE_IDLE_IND_MASK\n"
+			"----  ----  -------  ------------  ----------------------\n");
+
+	for (i = 0; i < NUM_OF_DCORES; i++) {
+		for (j = 0 ; j < NUM_OF_EDMA_PER_DCORE ; j++) {
+			int seq = i * NUM_OF_EDMA_PER_DCORE + j;
+
+			if (!(prop->edma_enabled_mask & BIT(seq)))
+				continue;
+
+			engine_idx = GAUDI2_DCORE0_ENGINE_ID_EDMA_0 +
+					i * GAUDI2_ENGINE_ID_DCORE_OFFSET + j;
+			offset = i * DCORE_OFFSET + j * DCORE_EDMA_OFFSET;
+
+			dma_core_idle_ind_mask =
+			RREG32(mmDCORE0_EDMA0_CORE_IDLE_IND_MASK + offset);
+
+			qm_glbl_sts0 = RREG32(mmDCORE0_EDMA0_QM_GLBL_STS0 + offset);
+			qm_glbl_sts1 = RREG32(mmDCORE0_EDMA0_QM_GLBL_STS1 + offset);
+			qm_cgm_sts = RREG32(mmDCORE0_EDMA0_QM_CGM_STS + offset);
+
+			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts) &&
+					IS_DMA_IDLE(dma_core_idle_ind_mask);
+			is_idle &= is_eng_idle;
+
+			if (mask && !is_eng_idle)
+				set_bit(engine_idx, mask);
+
+			if (s)
+				seq_printf(s, edma_fmt, i, j,
+						is_eng_idle ? "Y" : "N",
+						qm_glbl_sts0,
+						dma_core_idle_ind_mask);
+		}
+	}
+
+	/* PDMA, Two engines in Full chip */
+	if (s)
+		seq_puts(s,
+			"\nPDMA  is_idle  QM_GLBL_STS0  DMA_CORE_IDLE_IND_MASK\n"
+			"----  -------  ------------  ----------------------\n");
+
+	for (i = 0 ; i < NUM_OF_PDMA ; i++) {
+		engine_idx = GAUDI2_ENGINE_ID_PDMA_0 + i;
+		offset = i * PDMA_OFFSET;
+		dma_core_idle_ind_mask = RREG32(mmPDMA0_CORE_IDLE_IND_MASK + offset);
+
+		qm_glbl_sts0 = RREG32(mmPDMA0_QM_GLBL_STS0 + offset);
+		qm_glbl_sts1 = RREG32(mmPDMA0_QM_GLBL_STS1 + offset);
+		qm_cgm_sts = RREG32(mmPDMA0_QM_CGM_STS + offset);
+
+		is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts) &&
+				IS_DMA_IDLE(dma_core_idle_ind_mask);
+		is_idle &= is_eng_idle;
+
+		if (mask && !is_eng_idle)
+			set_bit(engine_idx, mask);
+
+		if (s)
+			seq_printf(s, pdma_fmt, i, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
+					dma_core_idle_ind_mask);
+	}
+
+	/* NIC, twelve macros in Full chip */
+	if (s && hdev->nic_ports_mask)
+		seq_puts(s,
+			"\nNIC  is_idle  QM_GLBL_STS0  QM_CGM_STS\n"
+			"---  -------  ------------  ----------\n");
+
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++) {
+		if (!(i & 1))
+			offset = i / 2 * NIC_OFFSET;
+		else
+			offset += NIC_QM_OFFSET;
+
+		if (!(hdev->nic_ports_mask & BIT(i)))
+			continue;
+
+		engine_idx = GAUDI2_ENGINE_ID_NIC0_0 + i;
+
+
+		qm_glbl_sts0 = RREG32(mmNIC0_QM0_GLBL_STS0 + offset);
+		qm_glbl_sts1 = RREG32(mmNIC0_QM0_GLBL_STS1 + offset);
+		qm_cgm_sts = RREG32(mmNIC0_QM0_CGM_STS + offset);
+
+		is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts);
+		is_idle &= is_eng_idle;
+
+		if (mask && !is_eng_idle)
+			set_bit(engine_idx, mask);
+
+		if (s)
+			seq_printf(s, nic_fmt, i, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
+					qm_cgm_sts);
+	}
+
+	if (s)
+		seq_puts(s,
+			"\nMME  Stub  is_idle  QM_GLBL_STS0  MME_ARCH_STATUS\n"
+			"---  ----  -------  ------------  ---------------\n");
+	/* MME, one per Dcore */
+	for (i = 0 ; i < NUM_OF_DCORES ; i++) {
+		engine_idx = GAUDI2_DCORE0_ENGINE_ID_MME + i * GAUDI2_ENGINE_ID_DCORE_OFFSET;
+		offset = i * DCORE_OFFSET;
+
+		qm_glbl_sts0 = RREG32(mmDCORE0_MME_QM_GLBL_STS0 + offset);
+		qm_glbl_sts1 = RREG32(mmDCORE0_MME_QM_GLBL_STS1 + offset);
+		qm_cgm_sts = RREG32(mmDCORE0_MME_QM_CGM_STS + offset);
+
+		is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts);
+		is_idle &= is_eng_idle;
+
+		mme_arch_sts = RREG32(mmDCORE0_MME_CTRL_LO_ARCH_STATUS + offset);
+		is_eng_idle &= IS_MME_IDLE(mme_arch_sts);
+		is_idle &= is_eng_idle;
+
+		if (s)
+			seq_printf(s, mme_fmt, i, "N",
+				is_eng_idle ? "Y" : "N",
+				qm_glbl_sts0,
+				mme_arch_sts);
+
+		if (mask && !is_eng_idle)
+			set_bit(engine_idx, mask);
+	}
+
+	/*
+	 * TPC
+	 */
+	if (s && prop->tpc_enabled_mask)
+		seq_puts(s,
+			"\nCORE  TPC   is_idle  QM_GLBL_STS0  QM_CGM_STS  DMA_CORE_IDLE_IND_MASK\n"
+			"----  ---  --------  ------------  ----------  ----------------------\n");
+
+	gaudi2_iterate_tpcs(hdev, &tpc_iter);
+
+	/* Decoders, two each Dcore and two shared PCIe decoders */
+	if (s && (prop->decoder_enabled_mask & (~PCIE_DEC_EN_MASK)))
+		seq_puts(s,
+			"\nCORE  DEC  is_idle  VSI_CMD_SWREG15\n"
+			"----  ---  -------  ---------------\n");
+
+	for (i = 0 ; i < NUM_OF_DCORES ; i++) {
+		for (j = 0 ; j < NUM_OF_DEC_PER_DCORE ; j++) {
+			dec_enabled_bit = 1 << (i * NUM_OF_DEC_PER_DCORE + j);
+			if (!(prop->decoder_enabled_mask & dec_enabled_bit))
+				continue;
+
+			engine_idx = GAUDI2_DCORE0_ENGINE_ID_DEC_0 +
+					i * GAUDI2_ENGINE_ID_DCORE_OFFSET + j;
+			offset = i * DCORE_OFFSET + j * DCORE_DEC_OFFSET;
+
+			dec_swreg15 = RREG32(mmDCORE0_DEC0_CMD_SWREG15 + offset);
+			is_eng_idle = IS_DEC_IDLE(dec_swreg15);
+			is_idle &= is_eng_idle;
+
+			if (mask && !is_eng_idle)
+				set_bit(engine_idx, mask);
+
+			if (s)
+				seq_printf(s, dec_fmt, i, j, is_eng_idle ? "Y" : "N", dec_swreg15);
+		}
+	}
+
+	if (s && (prop->decoder_enabled_mask & PCIE_DEC_EN_MASK))
+		seq_puts(s,
+			"\nPCIe DEC  is_idle  VSI_CMD_SWREG15\n"
+			"--------  -------  ---------------\n");
+
+	/* Check shared(PCIe) decoders */
+	for (i = 0 ; i < NUM_OF_DEC_PER_DCORE ; i++) {
+		dec_enabled_bit = PCIE_DEC_SHIFT + i;
+		if (!(prop->decoder_enabled_mask & BIT(dec_enabled_bit)))
+			continue;
+
+		engine_idx = GAUDI2_PCIE_ENGINE_ID_DEC_0 + i;
+		offset = i * DCORE_DEC_OFFSET;
+		dec_swreg15 = RREG32(mmPCIE_DEC0_CMD_SWREG15 + offset);
+		is_eng_idle = IS_DEC_IDLE(dec_swreg15);
+		is_idle &= is_eng_idle;
+
+		if (mask && !is_eng_idle)
+			set_bit(engine_idx, mask);
+
+		if (s)
+			seq_printf(s, pcie_dec_fmt, i, is_eng_idle ? "Y" : "N", dec_swreg15);
+	}
+
+	if (s)
+		seq_puts(s,
+			"\nCORE  ROT  is_idle  QM_GLBL_STS0  QM_CGM_STS  DMA_CORE_STS0\n"
+			"----  ----  -------  ------------  ----------  -------------\n");
+
+	for (i = 0 ; i < NUM_OF_ROT ; i++) {
+		engine_idx = GAUDI2_ENGINE_ID_ROT_0 + i;
+
+		offset = i * ROT_OFFSET;
+
+		qm_glbl_sts0 = RREG32(mmROT0_QM_GLBL_STS0 + offset);
+		qm_glbl_sts1 = RREG32(mmROT0_QM_GLBL_STS1 + offset);
+		qm_cgm_sts = RREG32(mmROT0_QM_CGM_STS + offset);
+
+		is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts);
+		is_idle &= is_eng_idle;
+
+		if (mask && !is_eng_idle)
+			set_bit(engine_idx, mask);
+
+		if (s)
+			seq_printf(s, rot_fmt, i, 0, is_eng_idle ? "Y" : "N",
+					qm_glbl_sts0, qm_cgm_sts, "-");
+	}
+
+	return is_idle;
+}
+
+static void gaudi2_hw_queues_lock(struct hl_device *hdev)
+	__acquires(&gaudi2->hw_queues_lock)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	spin_lock(&gaudi2->hw_queues_lock);
+}
+
+static void gaudi2_hw_queues_unlock(struct hl_device *hdev)
+	__releases(&gaudi2->hw_queues_lock)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	spin_unlock(&gaudi2->hw_queues_lock);
+}
+
+static void gaudi2_kdma_lock(struct hl_device *hdev, int dcore_id)
+	__acquires(&gaudi2->kdma_lock)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	spin_lock(&gaudi2->kdma_lock);
+}
+
+static void gaudi2_kdma_unlock(struct hl_device *hdev, int dcore_id)
+	__releases(&gaudi2->kdma_lock)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	spin_unlock(&gaudi2->kdma_lock);
+}
+
+static u32 gaudi2_get_pci_id(struct hl_device *hdev)
+{
+	return hdev->pdev->device;
+}
+
+static int gaudi2_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	return hl_fw_get_eeprom_data(hdev, data, max_size);
+}
+
+static void gaudi2_update_eq_ci(struct hl_device *hdev, u32 val)
+{
+	WREG32(mmCPU_IF_EQ_RD_OFFS, val);
+}
+
+static void *gaudi2_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (aggregate) {
+		*size = (u32) sizeof(gaudi2->events_stat_aggregate);
+		return gaudi2->events_stat_aggregate;
+	}
+
+	*size = (u32) sizeof(gaudi2->events_stat);
+	return gaudi2->events_stat;
+}
+
+static void gaudi2_mmu_vdec_dcore_prepare(struct hl_device *hdev, int dcore_id,
+				int dcore_vdec_id, u32 rw_asid, u32 rw_mmu_bp)
+{
+	u32 offset = (mmDCORE0_VDEC1_BRDG_CTRL_BASE - mmDCORE0_VDEC0_BRDG_CTRL_BASE) *
+			dcore_vdec_id + DCORE_OFFSET * dcore_id;
+
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_DEC_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_DEC_HB_ASID + offset, rw_asid);
+
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_ABNRM_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_ABNRM_HB_ASID + offset, rw_asid);
+
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_L2C_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_L2C_HB_ASID + offset, rw_asid);
+
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_NRM_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_NRM_HB_ASID + offset, rw_asid);
+
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_VCD_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmDCORE0_VDEC0_BRDG_CTRL_AXUSER_MSIX_VCD_HB_ASID + offset, rw_asid);
+}
+
+static void gaudi2_mmu_dcore_prepare(struct hl_device *hdev, int dcore_id, u32 asid)
+{
+	u32 rw_asid = (asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_RD_SHIFT) |
+			(asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_WR_SHIFT);
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 dcore_offset = dcore_id * DCORE_OFFSET;
+	u32 vdec_id, i, ports_offset, reg_val;
+	u8 edma_seq_base;
+
+	/* EDMA */
+	edma_seq_base = dcore_id * NUM_OF_EDMA_PER_DCORE;
+	if (prop->edma_enabled_mask & BIT(edma_seq_base)) {
+		WREG32(mmDCORE0_EDMA0_QM_AXUSER_NONSECURED_HB_MMU_BP + dcore_offset, 0);
+		WREG32(mmDCORE0_EDMA0_QM_AXUSER_NONSECURED_HB_ASID + dcore_offset, rw_asid);
+		WREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP + dcore_offset, 0);
+		WREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_ASID + dcore_offset, rw_asid);
+	}
+
+	if (prop->edma_enabled_mask & BIT(edma_seq_base + 1)) {
+		WREG32(mmDCORE0_EDMA1_QM_AXUSER_NONSECURED_HB_MMU_BP + dcore_offset, 0);
+		WREG32(mmDCORE0_EDMA1_QM_AXUSER_NONSECURED_HB_ASID + dcore_offset, rw_asid);
+		WREG32(mmDCORE0_EDMA1_CORE_CTX_AXUSER_HB_ASID + dcore_offset, rw_asid);
+		WREG32(mmDCORE0_EDMA1_CORE_CTX_AXUSER_HB_MMU_BP + dcore_offset, 0);
+	}
+
+	/* Sync Mngr */
+	WREG32(mmDCORE0_SYNC_MNGR_GLBL_ASID_NONE_SEC_PRIV + dcore_offset, asid);
+	/*
+	 * Sync Mngrs on dcores 1 - 3 are exposed to user, so must use user ASID
+	 * for any access type
+	 */
+	if (dcore_id > 0) {
+		reg_val = (asid << DCORE0_SYNC_MNGR_MSTR_IF_AXUSER_HB_ASID_RD_SHIFT) |
+			  (asid << DCORE0_SYNC_MNGR_MSTR_IF_AXUSER_HB_ASID_WR_SHIFT);
+		WREG32(mmDCORE0_SYNC_MNGR_MSTR_IF_AXUSER_HB_ASID + dcore_offset, reg_val);
+		WREG32(mmDCORE0_SYNC_MNGR_MSTR_IF_AXUSER_HB_MMU_BP + dcore_offset, 0);
+	}
+
+	WREG32(mmDCORE0_MME_CTRL_LO_MME_AXUSER_HB_MMU_BP + dcore_offset, 0);
+	WREG32(mmDCORE0_MME_CTRL_LO_MME_AXUSER_HB_ASID + dcore_offset, rw_asid);
+
+	for (i = 0 ; i < NUM_OF_MME_SBTE_PORTS ; i++) {
+		ports_offset = i * DCORE_MME_SBTE_OFFSET;
+		WREG32(mmDCORE0_MME_SBTE0_MSTR_IF_AXUSER_HB_MMU_BP +
+				dcore_offset + ports_offset, 0);
+		WREG32(mmDCORE0_MME_SBTE0_MSTR_IF_AXUSER_HB_ASID +
+				dcore_offset + ports_offset, rw_asid);
+	}
+
+	for (i = 0 ; i < NUM_OF_MME_WB_PORTS ; i++) {
+		ports_offset = i * DCORE_MME_WB_OFFSET;
+		WREG32(mmDCORE0_MME_WB0_MSTR_IF_AXUSER_HB_MMU_BP +
+				dcore_offset + ports_offset, 0);
+		WREG32(mmDCORE0_MME_WB0_MSTR_IF_AXUSER_HB_ASID +
+				dcore_offset + ports_offset, rw_asid);
+	}
+
+	WREG32(mmDCORE0_MME_QM_AXUSER_NONSECURED_HB_MMU_BP + dcore_offset, 0);
+	WREG32(mmDCORE0_MME_QM_AXUSER_NONSECURED_HB_ASID + dcore_offset, rw_asid);
+
+	/*
+	 * Decoders
+	 */
+	for (vdec_id = 0 ; vdec_id < NUM_OF_DEC_PER_DCORE ; vdec_id++) {
+		if (prop->decoder_enabled_mask & BIT(dcore_id * NUM_OF_DEC_PER_DCORE + vdec_id))
+			gaudi2_mmu_vdec_dcore_prepare(hdev, dcore_id, vdec_id, rw_asid, 0);
+	}
+}
+
+static void gudi2_mmu_vdec_shared_prepare(struct hl_device *hdev,
+				int shared_vdec_id, u32 rw_asid, u32 rw_mmu_bp)
+{
+	u32 offset = (mmPCIE_VDEC1_BRDG_CTRL_BASE - mmPCIE_VDEC0_BRDG_CTRL_BASE) * shared_vdec_id;
+
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_DEC_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_DEC_HB_ASID + offset, rw_asid);
+
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_ABNRM_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_ABNRM_HB_ASID + offset, rw_asid);
+
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_L2C_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_L2C_HB_ASID + offset, rw_asid);
+
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_NRM_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_NRM_HB_ASID + offset, rw_asid);
+
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_VCD_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmPCIE_VDEC0_BRDG_CTRL_AXUSER_MSIX_VCD_HB_ASID + offset, rw_asid);
+}
+
+static void gudi2_mmu_arc_farm_arc_dup_eng_prepare(struct hl_device *hdev, int arc_farm_id,
+							u32 rw_asid, u32 rw_mmu_bp)
+{
+	u32 offset = (mmARC_FARM_ARC1_DUP_ENG_BASE - mmARC_FARM_ARC0_DUP_ENG_BASE) * arc_farm_id;
+
+	WREG32(mmARC_FARM_ARC0_DUP_ENG_AXUSER_HB_MMU_BP + offset, rw_mmu_bp);
+	WREG32(mmARC_FARM_ARC0_DUP_ENG_AXUSER_HB_ASID + offset, rw_asid);
+}
+
+static void gaudi2_arc_mmu_prepare(struct hl_device *hdev, u32 cpu_id, u32 asid)
+{
+	u32 reg_base, reg_offset, reg_val = 0;
+
+	reg_base = gaudi2_arc_blocks_bases[cpu_id];
+
+	/* Enable MMU and configure asid for all relevant ARC regions */
+	reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_ARC_REGION_CFG_MMU_BP_MASK, 0);
+	reg_val |= FIELD_PREP(ARC_FARM_ARC0_AUX_ARC_REGION_CFG_0_ASID_MASK, asid);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION3_GENERAL);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION4_HBM0_FW);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION5_HBM1_GC_DATA);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION6_HBM2_GC_DATA);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION7_HBM3_GC_DATA);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION9_PCIE);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION10_GENERAL);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION11_GENERAL);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION12_GENERAL);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION13_GENERAL);
+	WREG32(reg_base + reg_offset, reg_val);
+
+	reg_offset = ARC_REGION_CFG_OFFSET(ARC_REGION14_GENERAL);
+	WREG32(reg_base + reg_offset, reg_val);
+}
+
+static int gaudi2_arc_mmu_prepare_all(struct hl_device *hdev, u32 asid)
+{
+	int i;
+
+	if (hdev->fw_components & FW_TYPE_BOOT_CPU)
+		return hl_fw_cpucp_engine_core_asid_set(hdev, asid);
+
+	for (i = CPU_ID_SCHED_ARC0 ; i < NUM_OF_ARC_FARMS_ARC ; i++)
+		gaudi2_arc_mmu_prepare(hdev, i, asid);
+
+	for (i = GAUDI2_QUEUE_ID_PDMA_0_0 ; i < GAUDI2_QUEUE_ID_CPU_PQ ; i += 4) {
+		if (!gaudi2_is_queue_enabled(hdev, i))
+			continue;
+
+		gaudi2_arc_mmu_prepare(hdev, gaudi2_queue_id_to_arc_id[i], asid);
+	}
+
+	return 0;
+}
+
+static int gaudi2_mmu_shared_prepare(struct hl_device *hdev, u32 asid)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 rw_asid, offset;
+	int rc, i;
+
+	rw_asid = FIELD_PREP(ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_RD_MASK, asid) |
+			FIELD_PREP(ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_WR_MASK, asid);
+
+	WREG32(mmPDMA0_QM_AXUSER_NONSECURED_HB_ASID, rw_asid);
+	WREG32(mmPDMA0_QM_AXUSER_NONSECURED_HB_MMU_BP, 0);
+	WREG32(mmPDMA0_CORE_CTX_AXUSER_HB_ASID, rw_asid);
+	WREG32(mmPDMA0_CORE_CTX_AXUSER_HB_MMU_BP, 0);
+
+	WREG32(mmPDMA1_QM_AXUSER_NONSECURED_HB_ASID, rw_asid);
+	WREG32(mmPDMA1_QM_AXUSER_NONSECURED_HB_MMU_BP, 0);
+	WREG32(mmPDMA1_CORE_CTX_AXUSER_HB_ASID, rw_asid);
+	WREG32(mmPDMA1_CORE_CTX_AXUSER_HB_MMU_BP, 0);
+
+	/* ROT */
+	for (i = 0 ; i < NUM_OF_ROT ; i++) {
+		offset = i * ROT_OFFSET;
+		WREG32(mmROT0_QM_AXUSER_NONSECURED_HB_ASID + offset, rw_asid);
+		WREG32(mmROT0_QM_AXUSER_NONSECURED_HB_MMU_BP + offset, 0);
+		RMWREG32(mmROT0_CPL_QUEUE_AWUSER + offset, asid, MMUBP_ASID_MASK);
+		RMWREG32(mmROT0_DESC_HBW_ARUSER_LO + offset, asid, MMUBP_ASID_MASK);
+		RMWREG32(mmROT0_DESC_HBW_AWUSER_LO + offset, asid, MMUBP_ASID_MASK);
+	}
+
+	/* Shared Decoders are the last bits in the decoders mask */
+	if (prop->decoder_enabled_mask & BIT(NUM_OF_DCORES * NUM_OF_DEC_PER_DCORE + 0))
+		gudi2_mmu_vdec_shared_prepare(hdev, 0, rw_asid, 0);
+
+	if (prop->decoder_enabled_mask & BIT(NUM_OF_DCORES * NUM_OF_DEC_PER_DCORE + 1))
+		gudi2_mmu_vdec_shared_prepare(hdev, 1, rw_asid, 0);
+
+	/* arc farm arc dup eng */
+	for (i = 0 ; i < NUM_OF_ARC_FARMS_ARC ; i++)
+		gudi2_mmu_arc_farm_arc_dup_eng_prepare(hdev, i, rw_asid, 0);
+
+	rc = gaudi2_arc_mmu_prepare_all(hdev, asid);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void gaudi2_tpc_mmu_prepare(struct hl_device *hdev, int dcore, int inst,	u32 offset,
+					void *data)
+{
+	struct gaudi2_tpc_mmu_data *mmu_data = (struct gaudi2_tpc_mmu_data *)data;
+
+	WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_MMU_BP + offset, 0);
+	WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_ASID + offset, mmu_data->rw_asid);
+	WREG32(mmDCORE0_TPC0_QM_AXUSER_NONSECURED_HB_MMU_BP + offset, 0);
+	WREG32(mmDCORE0_TPC0_QM_AXUSER_NONSECURED_HB_ASID + offset, mmu_data->rw_asid);
+}
+
+/* zero the MMUBP and set the ASID */
+static int gaudi2_mmu_prepare(struct hl_device *hdev, u32 asid)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	struct gaudi2_tpc_mmu_data tpc_mmu_data;
+	struct iterate_module_ctx tpc_iter = {
+		.fn = &gaudi2_tpc_mmu_prepare,
+		.data = &tpc_mmu_data,
+	};
+	int rc, i;
+
+	if (asid & ~DCORE0_HMMU0_STLB_ASID_ASID_MASK) {
+		dev_crit(hdev->dev, "asid %u is too big\n", asid);
+		return -EINVAL;
+	}
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_MMU_MASK))
+		return 0;
+
+	rc = gaudi2_mmu_shared_prepare(hdev, asid);
+	if (rc)
+		return rc;
+
+	/* configure DCORE MMUs */
+	tpc_mmu_data.rw_asid = (asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_RD_SHIFT) |
+				(asid << ARC_FARM_KDMA_CTX_AXUSER_HB_ASID_WR_SHIFT);
+	gaudi2_iterate_tpcs(hdev, &tpc_iter);
+	for (i = 0 ; i < NUM_OF_DCORES ; i++)
+		gaudi2_mmu_dcore_prepare(hdev, i, asid);
+
+	return 0;
+}
+
+static inline bool is_info_event(u32 event)
+{
+	switch (event) {
+	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_CAUSE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void gaudi2_print_irq_info(struct hl_device *hdev, u16 event_type)
+{
+	char desc[64] = "";
+	bool event_valid = false;
+
+	/* return in case of NIC status event - these events are received periodically and not as
+	 * an indication to an error, thus not printed.
+	 */
+	if (event_type >= GAUDI2_EVENT_CPU0_STATUS_NIC0_ENG0 &&
+		event_type <= GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG1)
+		return;
+
+	if (gaudi2_irq_map_table[event_type].valid) {
+		snprintf(desc, sizeof(desc), gaudi2_irq_map_table[event_type].name);
+		event_valid = true;
+	}
+
+	if (!event_valid)
+		snprintf(desc, sizeof(desc), "N/A");
+
+	if (is_info_event(event_type))
+		dev_info_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
+								event_type, desc);
+	else
+		dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
+								event_type, desc);
+}
+
+static void gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
+		struct hl_eq_ecc_data *ecc_data)
+{
+	u64 ecc_address = 0, ecc_syndrom = 0;
+	u8 memory_wrapper_idx = 0;
+
+	ecc_address = le64_to_cpu(ecc_data->ecc_address);
+	ecc_syndrom = le64_to_cpu(ecc_data->ecc_syndrom);
+	memory_wrapper_idx = ecc_data->memory_wrapper_idx;
+
+	dev_err(hdev->dev, "ECC error detected. address: %#llx. Syndrom: %#llx. block id %u\n",
+		ecc_address, ecc_syndrom, memory_wrapper_idx);
+}
+
+/*
+ * gaudi2_queue_idx_dec - decrement queue index (pi/ci) and handle wrap
+ *
+ * @idx: the current pi/ci value
+ * @q_len: the queue length (power of 2)
+ *
+ * @return the cyclically decremented index
+ */
+static inline u32 gaudi2_queue_idx_dec(u32 idx, u32 q_len)
+{
+	u32 mask = q_len - 1;
+
+	/*
+	 * modular decrement is equivalent to adding (queue_size -1)
+	 * later we take LSBs to make sure the value is in the
+	 * range [0, queue_len - 1]
+	 */
+	return (idx + q_len - 1) & mask;
+}
+
+/**
+ * gaudi2_print_sw_config_stream_data - print SW config stream data
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @stream: the QMAN's stream
+ * @qman_base: base address of QMAN registers block
+ */
+static void gaudi2_print_sw_config_stream_data(struct hl_device *hdev,
+						u32 stream, u64 qman_base)
+{
+	u64 cq_ptr_lo, cq_ptr_hi, cq_tsize, cq_ptr;
+	u32 cq_ptr_lo_off, size;
+
+	cq_ptr_lo_off = mmDCORE0_TPC0_QM_CQ_PTR_LO_1 - mmDCORE0_TPC0_QM_CQ_PTR_LO_0;
+
+	cq_ptr_lo = qman_base + (mmDCORE0_TPC0_QM_CQ_PTR_LO_0 - mmDCORE0_TPC0_QM_BASE) +
+									stream * cq_ptr_lo_off;
+
+	cq_ptr_hi = cq_ptr_lo + (mmDCORE0_TPC0_QM_CQ_PTR_HI_0 - mmDCORE0_TPC0_QM_CQ_PTR_LO_0);
+
+	cq_tsize = cq_ptr_lo + (mmDCORE0_TPC0_QM_CQ_TSIZE_0 - mmDCORE0_TPC0_QM_CQ_PTR_LO_0);
+
+	cq_ptr = (((u64) RREG32(cq_ptr_hi)) << 32) | RREG32(cq_ptr_lo);
+	size = RREG32(cq_tsize);
+	dev_info(hdev->dev, "stop on err: stream: %u, addr: %#llx, size: %x\n",
+		stream, cq_ptr, size);
+}
+
+/**
+ * gaudi2_print_last_pqes_on_err - print last PQEs on error
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @qid_base: first QID of the QMAN (out of 4 streams)
+ * @stream: the QMAN's stream
+ * @qman_base: base address of QMAN registers block
+ * @pr_sw_conf: if true print the SW config stream data (CQ PTR and SIZE)
+ */
+static void gaudi2_print_last_pqes_on_err(struct hl_device *hdev, u32 qid_base, u32 stream,
+						u64 qman_base, bool pr_sw_conf)
+{
+	u32 ci, qm_ci_stream_off;
+	struct hl_hw_queue *q;
+	u64 pq_ci;
+	int i;
+
+	q = &hdev->kernel_queues[qid_base + stream];
+
+	qm_ci_stream_off = mmDCORE0_TPC0_QM_PQ_CI_1 - mmDCORE0_TPC0_QM_PQ_CI_0;
+	pq_ci = qman_base + (mmDCORE0_TPC0_QM_PQ_CI_0 - mmDCORE0_TPC0_QM_BASE) +
+						stream * qm_ci_stream_off;
+
+	hdev->asic_funcs->hw_queues_lock(hdev);
+
+	if (pr_sw_conf)
+		gaudi2_print_sw_config_stream_data(hdev, stream, qman_base);
+
+	ci = RREG32(pq_ci);
+
+	/* we should start printing form ci -1 */
+	ci = gaudi2_queue_idx_dec(ci, HL_QUEUE_LENGTH);
+
+	for (i = 0; i < PQ_FETCHER_CACHE_SIZE; i++) {
+		struct hl_bd *bd;
+		u64 addr;
+		u32 len;
+
+		bd = q->kernel_address;
+		bd += ci;
+
+		len = le32_to_cpu(bd->len);
+		/* len 0 means uninitialized entry- break */
+		if (!len)
+			break;
+
+		addr = le64_to_cpu(bd->ptr);
+
+		dev_info(hdev->dev, "stop on err PQE(stream %u): ci: %u, addr: %#llx, size: %x\n",
+			stream, ci, addr, len);
+
+		/* get previous ci, wrap if needed */
+		ci = gaudi2_queue_idx_dec(ci, HL_QUEUE_LENGTH);
+	}
+
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+}
+
+/**
+ * print_qman_data_on_err - extract QMAN data on error
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @qid_base: first QID of the QMAN (out of 4 streams)
+ * @stream: the QMAN's stream
+ * @qman_base: base address of QMAN registers block
+ *
+ * This function attempt to extract as much data as possible on QMAN error.
+ * On upper CP print the SW config stream data and last 8 PQEs.
+ * On lower CP print SW config data and last PQEs of ALL 4 upper CPs
+ */
+static void print_qman_data_on_err(struct hl_device *hdev, u32 qid_base, u32 stream, u64 qman_base)
+{
+	u32 i;
+
+	if (stream != QMAN_STREAMS) {
+		gaudi2_print_last_pqes_on_err(hdev, qid_base, stream, qman_base, true);
+		return;
+	}
+
+	gaudi2_print_sw_config_stream_data(hdev, stream, qman_base);
+
+	for (i = 0 ; i < QMAN_STREAMS ; i++)
+		gaudi2_print_last_pqes_on_err(hdev, qid_base, i, qman_base, false);
+}
+
+static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm_name,
+						u64 qman_base, u32 qid_base)
+{
+	u32 i, j, glbl_sts_val, arb_err_val, glbl_sts_clr_val, num_error_causes;
+	u64 glbl_sts_addr, arb_err_addr;
+	char reg_desc[32];
+
+	glbl_sts_addr = qman_base + (mmDCORE0_TPC0_QM_GLBL_ERR_STS_0 - mmDCORE0_TPC0_QM_BASE);
+	arb_err_addr = qman_base + (mmDCORE0_TPC0_QM_ARB_ERR_CAUSE - mmDCORE0_TPC0_QM_BASE);
+
+	/* Iterate through all stream GLBL_ERR_STS registers + Lower CP */
+	for (i = 0 ; i < QMAN_STREAMS + 1 ; i++) {
+		glbl_sts_clr_val = 0;
+		glbl_sts_val = RREG32(glbl_sts_addr + 4 * i);
+
+		if (!glbl_sts_val)
+			continue;
+
+		if (i == QMAN_STREAMS) {
+			snprintf(reg_desc, ARRAY_SIZE(reg_desc), "LowerCP");
+			num_error_causes = GAUDI2_NUM_OF_QM_LCP_ERR_CAUSE;
+		} else {
+			snprintf(reg_desc, ARRAY_SIZE(reg_desc), "stream%u", i);
+			num_error_causes = GAUDI2_NUM_OF_QM_ERR_CAUSE;
+		}
+
+		for (j = 0 ; j < num_error_causes ; j++) {
+			if (glbl_sts_val & BIT(j)) {
+				dev_err_ratelimited(hdev->dev, "%s %s. err cause: %s\n",
+						qm_name, reg_desc,
+						i == QMAN_STREAMS ?
+						gaudi2_qman_lower_cp_error_cause[j] :
+						gaudi2_qman_error_cause[j]);
+				glbl_sts_clr_val |= BIT(j);
+			}
+		}
+
+		print_qman_data_on_err(hdev, qid_base, i, qman_base);
+	}
+
+	arb_err_val = RREG32(arb_err_addr);
+
+	if (!arb_err_val)
+		return;
+
+	for (j = 0 ; j < GAUDI2_NUM_OF_QM_ARB_ERR_CAUSE ; j++) {
+		if (arb_err_val & BIT(j))
+			dev_err_ratelimited(hdev->dev, "%s ARB_ERR. err cause: %s\n",
+						qm_name, gaudi2_qman_arb_error_cause[j]);
+	}
+}
+
+static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
+			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
+			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info)
+{
+	u32 razwi_hi, razwi_lo, razwi_xy;
+
+	if (is_write) {
+		if (read_razwi_regs) {
+			razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HI);
+			razwi_lo = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_LO);
+			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_XY);
+		} else {
+			razwi_hi = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_hi_reg);
+			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_lo_reg);
+			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_id_reg);
+		}
+
+		dev_err_ratelimited(hdev->dev,
+			"%s-RAZWI SHARED RR HBW WR error, captured address HI 0x%x LO 0x%x, Initiator coordinates 0x%x\n",
+			name, razwi_hi, razwi_lo, razwi_xy);
+	} else {
+		if (read_razwi_regs) {
+			razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HI);
+			razwi_lo = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_LO);
+			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_XY);
+		} else {
+			razwi_hi = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_hi_reg);
+			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_lo_reg);
+			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_id_reg);
+		}
+
+		dev_err_ratelimited(hdev->dev,
+			"%s-RAZWI SHARED RR HBW AR error, captured address HI 0x%x LO 0x%x, Initiator coordinates 0x%x\n",
+			name, razwi_hi, razwi_lo, razwi_xy);
+	}
+}
+
+static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
+			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
+			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info)
+{
+	u32 razwi_addr, razwi_xy;
+
+	if (is_write) {
+		if (read_razwi_regs) {
+			razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI);
+			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_XY);
+		} else {
+			razwi_addr = le32_to_cpu(razwi_info->lbw.rr_aw_razwi_reg);
+			razwi_xy = le32_to_cpu(razwi_info->lbw.rr_aw_razwi_id_reg);
+		}
+
+		dev_err_ratelimited(hdev->dev,
+			"%s-RAZWI SHARED RR LBW WR error, mstr_if 0x%llx, captured address 0x%x, Initiator coordinates 0x%x\n",
+			name, rtr_mstr_if_base_addr, razwi_addr, razwi_xy);
+	} else {
+		if (read_razwi_regs) {
+			razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI);
+			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_XY);
+		} else {
+			razwi_addr = le32_to_cpu(razwi_info->lbw.rr_ar_razwi_reg);
+			razwi_xy = le32_to_cpu(razwi_info->lbw.rr_ar_razwi_id_reg);
+		}
+
+		dev_err_ratelimited(hdev->dev,
+			"%s-RAZWI SHARED RR LBW AR error, mstr_if 0x%llx, captured address 0x%x Initiator coordinates 0x%x\n",
+			name, rtr_mstr_if_base_addr, razwi_addr, razwi_xy);
+	}
+}
+
+/*
+ * This function handles RR(Range register) hit events.
+ * raised be initiators not PSOC RAZWI.
+ */
+static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
+				enum razwi_event_sources module, u8 module_idx,
+				u8 module_sub_idx, struct hl_eq_razwi_info *razwi_info)
+{
+	bool via_sft = false, read_razwi_regs = false;
+	u32 rtr_id, dcore_id, dcore_rtr_id, sft_id;
+	u64 rtr_mstr_if_base_addr;
+	u32 hbw_shrd_aw = 0, hbw_shrd_ar = 0;
+	u32 lbw_shrd_aw = 0, lbw_shrd_ar = 0;
+	char initiator_name[64];
+
+	if (hdev->pldm || !(hdev->fw_components & FW_TYPE_LINUX) || !razwi_info)
+		read_razwi_regs = true;
+
+	switch (module) {
+	case RAZWI_TPC:
+		rtr_id = gaudi2_tpc_initiator_rtr_id[module_idx];
+		sprintf(initiator_name, "TPC_%u", module_idx);
+		break;
+	case RAZWI_MME:
+		sprintf(initiator_name, "MME_%u", module_idx);
+		switch (module_sub_idx) {
+		case MME_WAP0:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap0;
+			break;
+		case MME_WAP1:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap1;
+			break;
+		case MME_WRITE:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].write;
+			break;
+		case MME_READ:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].read;
+			break;
+		case MME_SBTE0:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte0;
+			break;
+		case MME_SBTE1:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte1;
+			break;
+		case MME_SBTE2:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte2;
+			break;
+		case MME_SBTE3:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte3;
+			break;
+		case MME_SBTE4:
+			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte4;
+			break;
+		default:
+			return;
+		}
+		break;
+	case RAZWI_EDMA:
+		sft_id = gaudi2_edma_initiator_sft_id[module_idx].interface_id;
+		dcore_id = gaudi2_edma_initiator_sft_id[module_idx].dcore_id;
+		via_sft = true;
+		sprintf(initiator_name, "EDMA_%u", module_idx);
+		break;
+	case RAZWI_PDMA:
+		rtr_id = gaudi2_pdma_initiator_rtr_id[module_idx];
+		sprintf(initiator_name, "PDMA_%u", module_idx);
+		break;
+	case RAZWI_NIC:
+		rtr_id = gaudi2_nic_initiator_rtr_id[module_idx];
+		sprintf(initiator_name, "NIC_%u", module_idx);
+		break;
+	case RAZWI_DEC:
+		rtr_id = gaudi2_dec_initiator_rtr_id[module_idx];
+		sprintf(initiator_name, "DEC_%u", module_idx);
+		break;
+	case RAZWI_ROT:
+		rtr_id = gaudi2_rot_initiator_rtr_id[module_idx];
+		sprintf(initiator_name, "ROT_%u", module_idx);
+		break;
+	default:
+		return;
+	}
+
+	if (!read_razwi_regs) {
+		if (le32_to_cpu(razwi_info->razwi_happened_mask) & RAZWI_HAPPENED_HBW) {
+			hbw_shrd_aw = le32_to_cpu(razwi_info->razwi_happened_mask) &
+								RAZWI_HAPPENED_AW;
+			hbw_shrd_ar = le32_to_cpu(razwi_info->razwi_happened_mask) &
+								RAZWI_HAPPENED_AR;
+		} else if (le32_to_cpu(razwi_info->razwi_happened_mask) & RAZWI_HAPPENED_LBW) {
+			lbw_shrd_aw = le32_to_cpu(razwi_info->razwi_happened_mask) &
+								RAZWI_HAPPENED_AW;
+			lbw_shrd_ar = le32_to_cpu(razwi_info->razwi_happened_mask) &
+								RAZWI_HAPPENED_AR;
+		}
+		rtr_mstr_if_base_addr = 0;
+
+		goto dump_info;
+	}
+
+	/* Find router mstr_if register base */
+	if (via_sft) {
+		rtr_mstr_if_base_addr = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE +
+				dcore_id * SFT_DCORE_OFFSET +
+				sft_id * SFT_IF_OFFSET +
+				RTR_MSTR_IF_OFFSET;
+	} else {
+		dcore_id = rtr_id / NUM_OF_RTR_PER_DCORE;
+		dcore_rtr_id = rtr_id % NUM_OF_RTR_PER_DCORE;
+		rtr_mstr_if_base_addr = mmDCORE0_RTR0_CTRL_BASE +
+				dcore_id * DCORE_OFFSET +
+				dcore_rtr_id * DCORE_RTR_OFFSET +
+				RTR_MSTR_IF_OFFSET;
+	}
+
+	/* Find out event cause by reading "RAZWI_HAPPENED" registers */
+	hbw_shrd_aw = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED);
+
+	hbw_shrd_ar = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED);
+
+	if (via_sft) {
+		/* SFT has separate MSTR_IF for LBW, only there we can
+		 * read the LBW razwi related registers
+		 */
+		u64 base;
+
+		base = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE + dcore_id * SFT_DCORE_OFFSET +
+				RTR_LBW_MSTR_IF_OFFSET;
+
+		lbw_shrd_aw = RREG32(base + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
+
+		lbw_shrd_ar = RREG32(base + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
+	} else {
+		lbw_shrd_aw = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
+
+		lbw_shrd_ar = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
+	}
+
+dump_info:
+	/* check if there is no RR razwi indication at all */
+	if (!hbw_shrd_aw && !hbw_shrd_ar && !lbw_shrd_aw && !lbw_shrd_ar)
+		return;
+
+	if (hbw_shrd_aw) {
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
+						initiator_name, read_razwi_regs, razwi_info);
+
+		/* Clear event indication */
+		if (read_razwi_regs)
+			WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED, hbw_shrd_aw);
+	}
+
+	if (hbw_shrd_ar) {
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
+						initiator_name, read_razwi_regs, razwi_info);
+
+		/* Clear event indication */
+		if (read_razwi_regs)
+			WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED, hbw_shrd_ar);
+	}
+
+	if (lbw_shrd_aw) {
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
+						initiator_name, read_razwi_regs, razwi_info);
+
+		/* Clear event indication */
+		if (read_razwi_regs)
+			WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED, lbw_shrd_aw);
+	}
+
+	if (lbw_shrd_ar) {
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
+						initiator_name, read_razwi_regs, razwi_info);
+
+		/* Clear event indication */
+		if (read_razwi_regs)
+			WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED, lbw_shrd_ar);
+	}
+}
+
+static void gaudi2_check_if_razwi_happened(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u8 mod_idx, sub_mod;
+
+	/* check all TPCs */
+	for (mod_idx = 0 ; mod_idx < (NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1) ; mod_idx++) {
+		if (prop->tpc_enabled_mask & BIT(mod_idx))
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, mod_idx, 0, NULL);
+	}
+
+	/* check all MMEs */
+	for (mod_idx = 0 ; mod_idx < (NUM_OF_MME_PER_DCORE * NUM_OF_DCORES) ; mod_idx++)
+		for (sub_mod = MME_WAP0 ; sub_mod < MME_INITIATORS_MAX ; sub_mod++)
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mod_idx,
+								sub_mod, NULL);
+
+	/* check all EDMAs */
+	for (mod_idx = 0 ; mod_idx < (NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES) ; mod_idx++)
+		if (prop->edma_enabled_mask & BIT(mod_idx))
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, mod_idx, 0, NULL);
+
+	/* check all PDMAs */
+	for (mod_idx = 0 ; mod_idx < NUM_OF_PDMA ; mod_idx++)
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, mod_idx, 0, NULL);
+
+	/* check all NICs */
+	for (mod_idx = 0 ; mod_idx < NIC_NUMBER_OF_PORTS ; mod_idx++)
+		if (hdev->nic_ports_mask & BIT(mod_idx))
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_NIC, mod_idx >> 1, 0,
+								NULL);
+
+	/* check all DECs */
+	for (mod_idx = 0 ; mod_idx < NUMBER_OF_DEC ; mod_idx++)
+		if (prop->decoder_enabled_mask & BIT(mod_idx))
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, mod_idx, 0, NULL);
+
+	/* check all ROTs */
+	for (mod_idx = 0 ; mod_idx < NUM_OF_ROT ; mod_idx++)
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, mod_idx, 0, NULL);
+}
+
+static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev,
+							u64 rtr_ctrl_base_addr, bool is_write)
+{
+	u32 razwi_hi, razwi_lo;
+
+	if (is_write) {
+		razwi_hi = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_ADDR_HI);
+		razwi_lo = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_ADDR_LO);
+
+		dev_err_ratelimited(hdev->dev,
+			"RAZWI PSOC unmapped HBW WR error, ctr_base 0x%llx, captured address HI 0x%x, LO 0x%x\n",
+			rtr_ctrl_base_addr, razwi_hi, razwi_lo);
+
+		/* Clear set indication */
+		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_SET, 0x1);
+	} else {
+		razwi_hi = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_ADDR_HI);
+
+		razwi_lo = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_ADDR_LO);
+
+		dev_err_ratelimited(hdev->dev,
+			"RAZWI PSOC unmapped HBW AR error, ctr_base 0x%llx, captured address HI 0x%x, LO 0x%x\n",
+			rtr_ctrl_base_addr, razwi_hi, razwi_lo);
+
+		/* Clear set indication */
+		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_SET, 0x1);
+	}
+}
+
+static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev,
+					u64 rtr_ctrl_base_addr, bool is_write)
+{
+	u32 razwi_addr;
+
+	if (is_write) {
+		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_ADDR);
+
+		dev_err_ratelimited(hdev->dev,
+			"RAZWI PSOC unmapped LBW WR error, ctr_base 0x%llx, captured address 0x%x\n",
+			rtr_ctrl_base_addr, razwi_addr);
+
+		/* Clear set indication */
+		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_SET, 0x1);
+	} else {
+		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_ADDR);
+
+		dev_err_ratelimited(hdev->dev,
+			"RAZWI PSOC unmapped LBW AR error, ctr_base 0x%llx, captured address 0x%x\n",
+			rtr_ctrl_base_addr, razwi_addr);
+
+		/* Clear set indication */
+		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_SET, 0x1);
+	}
+}
+
+/* PSOC RAZWI interrupt occurs only when trying to access a bad address */
+static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev)
+{
+	u32 hbw_aw_set, hbw_ar_set, lbw_aw_set, lbw_ar_set, rtr_id, dcore_id, dcore_rtr_id, xy,
+								razwi_mask_info, razwi_intr = 0;
+	int rtr_map_arr_len = NUM_OF_RTR_PER_DCORE * NUM_OF_DCORES;
+	u64 rtr_ctrl_base_addr;
+
+	if (hdev->pldm || !(hdev->fw_components & FW_TYPE_LINUX)) {
+		razwi_intr = RREG32(mmPSOC_GLOBAL_CONF_RAZWI_INTERRUPT);
+		if (!razwi_intr)
+			return;
+	}
+
+	razwi_mask_info = RREG32(mmPSOC_GLOBAL_CONF_RAZWI_MASK_INFO);
+
+	xy = (razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_L_MASK)
+		>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_L_SHIFT;
+
+	dev_err_ratelimited(hdev->dev,
+		"PSOC RAZWI interrupt: Mask %d, WAS_AR %d, WAS_AW %d, AXUSER_L 0x%x AXUSER_H 0x%x\n",
+		(razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_MASK_MASK)
+			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_MASK_SHIFT,
+		(razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AR_MASK)
+			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AR_SHIFT,
+		(razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AW_MASK)
+			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AW_SHIFT, xy,
+		(razwi_mask_info &
+			PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_H_MASK)
+			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_H_SHIFT);
+	if (xy == 0) {
+		dev_err_ratelimited(hdev->dev,
+				"PSOC RAZWI interrupt: received event from 0 rtr coordinates\n");
+		goto clear;
+	}
+
+	/* Find router id by router coordinates */
+	for (rtr_id = 0 ; rtr_id < rtr_map_arr_len ; rtr_id++)
+		if (rtr_coordinates_to_rtr_id[rtr_id] == xy)
+			break;
+
+	if (rtr_id == rtr_map_arr_len) {
+		dev_err_ratelimited(hdev->dev,
+				"PSOC RAZWI interrupt: invalid rtr coordinates (0x%x)\n", xy);
+		goto clear;
+	}
+
+	/* Find router mstr_if register base */
+	dcore_id = rtr_id / NUM_OF_RTR_PER_DCORE;
+	dcore_rtr_id = rtr_id % NUM_OF_RTR_PER_DCORE;
+	rtr_ctrl_base_addr = mmDCORE0_RTR0_CTRL_BASE + dcore_id * DCORE_OFFSET +
+				dcore_rtr_id * DCORE_RTR_OFFSET;
+
+	hbw_aw_set = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_SET);
+	hbw_ar_set = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_SET);
+	lbw_aw_set = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_SET);
+	lbw_ar_set = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_SET);
+
+	if (hbw_aw_set)
+		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_ctrl_base_addr, true);
+
+	if (hbw_ar_set)
+		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_ctrl_base_addr, false);
+
+	if (lbw_aw_set)
+		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_ctrl_base_addr, true);
+
+	if (lbw_ar_set)
+		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_ctrl_base_addr, false);
+
+clear:
+	/* Clear Interrupts only on pldm or if f/w doesn't handle interrupts */
+	if (hdev->pldm || !(hdev->fw_components & FW_TYPE_LINUX))
+		WREG32(mmPSOC_GLOBAL_CONF_RAZWI_INTERRUPT, razwi_intr);
+}
+
+static void _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
+{
+	u32 i, sts_val, sts_clr_val = 0;
+
+	sts_val = RREG32(qman_base + QM_SEI_STATUS_OFFSET);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_QM_SEI_ERR_CAUSE ; i++) {
+		if (sts_val & BIT(i)) {
+			dev_err_ratelimited(hdev->dev, "QM SEI. err cause: %s\n",
+						gaudi2_qm_sei_error_cause[i]);
+			sts_clr_val |= BIT(i);
+		}
+	}
+
+	WREG32(qman_base + QM_SEI_STATUS_OFFSET, sts_clr_val);
+}
+
+static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
+					struct hl_eq_razwi_info *razwi_info)
+{
+	u64 qman_base;
+	u8 index;
+
+	switch (event_type) {
+	case GAUDI2_EVENT_TPC0_AXI_ERR_RSP ... GAUDI2_EVENT_TPC23_AXI_ERR_RSP:
+		index = event_type - GAUDI2_EVENT_TPC0_AXI_ERR_RSP;
+		qman_base = mmDCORE0_TPC0_QM_BASE +
+				(index / NUM_OF_TPC_PER_DCORE) * DCORE_OFFSET +
+				(index % NUM_OF_TPC_PER_DCORE) * DCORE_TPC_OFFSET;
+		break;
+	case GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
+		qman_base = mmDCORE0_TPC6_QM_BASE;
+		break;
+	case GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_MME2_CTRL_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_MME3_CTRL_AXI_ERROR_RESPONSE:
+		index = (event_type - GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE) /
+				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
+						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
+		qman_base = mmDCORE0_MME_QM_BASE + index * DCORE_OFFSET;
+		break;
+	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
+	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
+		index = event_type - GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP;
+		qman_base = mmPDMA0_QM_BASE + index * PDMA_OFFSET;
+		break;
+	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_ROTATOR1_AXI_ERROR_RESPONSE:
+		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
+		qman_base = mmROT0_QM_BASE + index * ROT_OFFSET;
+		break;
+	default:
+		return;
+	}
+
+	_gaudi2_handle_qm_sei_err(hdev, qman_base);
+
+	/* There is a single event per NIC macro, so should check its both QMAN blocks */
+	if (event_type >= GAUDI2_EVENT_NIC0_AXI_ERROR_RESPONSE &&
+			event_type <= GAUDI2_EVENT_NIC11_AXI_ERROR_RESPONSE)
+		_gaudi2_handle_qm_sei_err(hdev, qman_base + NIC_QM_OFFSET);
+
+	/* check if RAZWI happened */
+	if (razwi_info)
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, 0, 0, razwi_info);
+}
+
+static void gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
+{
+	u32 qid_base;
+	u64 qman_base;
+	char desc[32];
+	u8 index;
+
+	switch (event_type) {
+	case GAUDI2_EVENT_TPC0_QM ... GAUDI2_EVENT_TPC5_QM:
+		index = event_type - GAUDI2_EVENT_TPC0_QM;
+		qid_base = GAUDI2_QUEUE_ID_DCORE0_TPC_0_0 + index * QMAN_STREAMS;
+		qman_base = mmDCORE0_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_TPC%d_QM", index);
+		break;
+	case GAUDI2_EVENT_TPC6_QM ... GAUDI2_EVENT_TPC11_QM:
+		index = event_type - GAUDI2_EVENT_TPC6_QM;
+		qid_base = GAUDI2_QUEUE_ID_DCORE1_TPC_0_0 + index * QMAN_STREAMS;
+		qman_base = mmDCORE1_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_TPC%d_QM", index);
+		break;
+	case GAUDI2_EVENT_TPC12_QM ... GAUDI2_EVENT_TPC17_QM:
+		index = event_type - GAUDI2_EVENT_TPC12_QM;
+		qid_base = GAUDI2_QUEUE_ID_DCORE2_TPC_0_0 + index * QMAN_STREAMS;
+		qman_base = mmDCORE2_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_TPC%d_QM", index);
+		break;
+	case GAUDI2_EVENT_TPC18_QM ... GAUDI2_EVENT_TPC23_QM:
+		index = event_type - GAUDI2_EVENT_TPC18_QM;
+		qid_base = GAUDI2_QUEUE_ID_DCORE3_TPC_0_0 + index * QMAN_STREAMS;
+		qman_base = mmDCORE3_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_TPC%d_QM", index);
+		break;
+	case GAUDI2_EVENT_TPC24_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE0_TPC_6_0;
+		qman_base = mmDCORE0_TPC6_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_TPC6_QM");
+		break;
+	case GAUDI2_EVENT_MME0_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE0_MME_0_0;
+		qman_base = mmDCORE0_MME_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_MME_QM");
+		break;
+	case GAUDI2_EVENT_MME1_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE1_MME_0_0;
+		qman_base = mmDCORE1_MME_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_MME_QM");
+		break;
+	case GAUDI2_EVENT_MME2_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE2_MME_0_0;
+		qman_base = mmDCORE2_MME_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_MME_QM");
+		break;
+	case GAUDI2_EVENT_MME3_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE3_MME_0_0;
+		qman_base = mmDCORE3_MME_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_MME_QM");
+		break;
+	case GAUDI2_EVENT_HDMA0_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0;
+		qman_base = mmDCORE0_EDMA0_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_EDMA0_QM");
+		break;
+	case GAUDI2_EVENT_HDMA1_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0;
+		qman_base = mmDCORE0_EDMA1_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_EDMA1_QM");
+		break;
+	case GAUDI2_EVENT_HDMA2_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0;
+		qman_base = mmDCORE1_EDMA0_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_EDMA0_QM");
+		break;
+	case GAUDI2_EVENT_HDMA3_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0;
+		qman_base = mmDCORE1_EDMA1_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_EDMA1_QM");
+		break;
+	case GAUDI2_EVENT_HDMA4_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0;
+		qman_base = mmDCORE2_EDMA0_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_EDMA0_QM");
+		break;
+	case GAUDI2_EVENT_HDMA5_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0;
+		qman_base = mmDCORE2_EDMA1_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_EDMA1_QM");
+		break;
+	case GAUDI2_EVENT_HDMA6_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0;
+		qman_base = mmDCORE3_EDMA0_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_EDMA0_QM");
+		break;
+	case GAUDI2_EVENT_HDMA7_QM:
+		qid_base = GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0;
+		qman_base = mmDCORE3_EDMA1_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_EDMA1_QM");
+		break;
+	case GAUDI2_EVENT_PDMA0_QM:
+		qid_base = GAUDI2_QUEUE_ID_PDMA_0_0;
+		qman_base = mmPDMA0_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "PDMA0_QM");
+		break;
+	case GAUDI2_EVENT_PDMA1_QM:
+		qid_base = GAUDI2_QUEUE_ID_PDMA_1_0;
+		qman_base = mmPDMA1_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "PDMA1_QM");
+		break;
+	case GAUDI2_EVENT_ROTATOR0_ROT0_QM:
+		qid_base = GAUDI2_QUEUE_ID_ROT_0_0;
+		qman_base = mmROT0_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "ROTATOR0_QM");
+		break;
+	case GAUDI2_EVENT_ROTATOR1_ROT1_QM:
+		qid_base = GAUDI2_QUEUE_ID_ROT_1_0;
+		qman_base = mmROT1_QM_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "ROTATOR1_QM");
+		break;
+	default:
+		return;
+	}
+
+	gaudi2_handle_qman_err_generic(hdev, desc, qman_base, qid_base);
+
+	/* Handle EDMA QM SEI here because there is no AXI error response event for EDMA */
+	if (event_type >= GAUDI2_EVENT_HDMA2_QM && event_type <= GAUDI2_EVENT_HDMA5_QM)
+		_gaudi2_handle_qm_sei_err(hdev, qman_base);
+}
+
+static void gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
+{
+	u32 i, sts_val, sts_clr_val = 0;
+
+	sts_val = RREG32(mmARC_FARM_ARC0_AUX_ARC_SEI_INTR_STS);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_ARC_SEI_ERR_CAUSE ; i++) {
+		if (sts_val & BIT(i)) {
+			dev_err_ratelimited(hdev->dev, "ARC SEI. err cause: %s\n",
+						gaudi2_arc_sei_error_cause[i]);
+			sts_clr_val |= BIT(i);
+		}
+	}
+
+	WREG32(mmARC_FARM_ARC0_AUX_ARC_SEI_INTR_CLR, sts_clr_val);
+}
+
+static void gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
+{
+	u32 i, sts_val, sts_clr_val = 0;
+
+	sts_val = RREG32(mmCPU_IF_CPU_SEI_INTR_STS);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_CPU_SEI_ERR_CAUSE ; i++) {
+		if (sts_val & BIT(i)) {
+			dev_err_ratelimited(hdev->dev, "CPU SEI. err cause: %s\n",
+						gaudi2_cpu_sei_error_cause[i]);
+			sts_clr_val |= BIT(i);
+		}
+	}
+
+	WREG32(mmCPU_IF_CPU_SEI_INTR_CLR, sts_clr_val);
+}
+
+static void gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
+					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause)
+{
+	u64 intr_cause_data = le64_to_cpu(razwi_with_intr_cause->intr_cause.intr_cause_data);
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_ROT_ERR_CAUSE ; i++)
+		if (intr_cause_data & BIT(i))
+			dev_err_ratelimited(hdev->dev, "ROT%u. err cause: %s\n",
+						rot_index, guadi2_rot_error_cause[i]);
+
+	/* check if RAZWI happened */
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, rot_index, 0,
+						&razwi_with_intr_cause->razwi_info);
+}
+
+static void gaudi2_tpc_ack_interrupts(struct hl_device *hdev, u8 tpc_index, char *interrupt_name,
+					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause)
+{
+	u64 intr_cause_data = le64_to_cpu(razwi_with_intr_cause->intr_cause.intr_cause_data);
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_TPC_INTR_CAUSE ; i++)
+		if (intr_cause_data & BIT(i))
+			dev_err_ratelimited(hdev->dev, "TPC%d_%s interrupt cause: %s\n",
+					tpc_index, interrupt_name, gaudi2_tpc_interrupts_cause[i]);
+
+	/* check if RAZWI happened */
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, tpc_index, 0,
+						&razwi_with_intr_cause->razwi_info);
+}
+
+static void gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const char *interrupt_name,
+				struct hl_eq_razwi_info *razwi_info)
+{
+	u32 sts_addr, sts_val, sts_clr_val = 0;
+	int i;
+
+	if (dec_index < NUM_OF_VDEC_PER_DCORE * NUM_OF_DCORES)
+		/* DCORE DEC */
+		sts_addr = mmDCORE0_VDEC0_BRDG_CTRL_CAUSE_INTR +
+				DCORE_OFFSET * (dec_index / NUM_OF_DEC_PER_DCORE) +
+				DCORE_VDEC_OFFSET * (dec_index % NUM_OF_DEC_PER_DCORE);
+	else
+		/* PCIE DEC */
+		sts_addr = mmPCIE_VDEC0_BRDG_CTRL_CAUSE_INTR + PCIE_VDEC_OFFSET *
+				(dec_index - NUM_OF_VDEC_PER_DCORE * NUM_OF_DCORES);
+
+	sts_val = RREG32(sts_addr);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_DEC_ERR_CAUSE ; i++) {
+		if (sts_val & BIT(i)) {
+			dev_err_ratelimited(hdev->dev, "DEC%u_%s err cause: %s\n",
+					dec_index, interrupt_name, gaudi2_dec_error_cause[i]);
+			sts_clr_val |= BIT(i);
+		}
+	}
+
+	/* check if RAZWI happened */
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, dec_index, 0, razwi_info);
+
+	/* Write 1 clear errors */
+	WREG32(sts_addr, sts_clr_val);
+}
+
+static void gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const char *interrupt_name,
+				struct hl_eq_razwi_info *razwi_info)
+{
+	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0;
+	int i;
+
+	sts_addr = mmDCORE0_MME_CTRL_LO_INTR_CAUSE + DCORE_OFFSET * mme_index;
+	sts_clr_addr = mmDCORE0_MME_CTRL_LO_INTR_CLEAR + DCORE_OFFSET * mme_index;
+
+	sts_val = RREG32(sts_addr);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_MME_ERR_CAUSE ; i++) {
+		if (sts_val & BIT(i)) {
+			dev_err_ratelimited(hdev->dev, "MME%u_%s err cause: %s\n",
+					mme_index, interrupt_name, guadi2_mme_error_cause[i]);
+			sts_clr_val |= BIT(i);
+		}
+	}
+
+	/* check if RAZWI happened */
+	for (i = MME_WRITE ; i < MME_INITIATORS_MAX ; i++)
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, i, razwi_info);
+
+	WREG32(sts_clr_addr, sts_clr_val);
+}
+
+static void gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u8 mme_index, u8 sbte_index,
+					u64 intr_cause_data)
+{
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_MME_SBTE_ERR_CAUSE ; i++)
+		if (intr_cause_data & BIT(i))
+			dev_err_ratelimited(hdev->dev, "MME%uSBTE%u_AXI_ERR_RSP err cause: %s\n",
+					mme_index, sbte_index, guadi2_mme_sbte_error_cause[i]);
+}
+
+static void gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
+					struct hl_eq_razwi_info *razwi_info)
+{
+	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0;
+	int i;
+
+	sts_addr = mmDCORE0_MME_ACC_INTR_CAUSE + DCORE_OFFSET * mme_index;
+	sts_clr_addr = mmDCORE0_MME_ACC_INTR_CLEAR + DCORE_OFFSET * mme_index;
+
+	sts_val = RREG32(sts_addr);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_MME_WAP_ERR_CAUSE ; i++) {
+		if (sts_val & BIT(i)) {
+			dev_err_ratelimited(hdev->dev,
+					"MME%u_WAP_SOURCE_RESULT_INVALID err cause: %s\n",
+					mme_index, guadi2_mme_wap_error_cause[i]);
+			sts_clr_val |= BIT(i);
+		}
+	}
+
+	/* check if RAZWI happened on WAP0/1 */
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP0, razwi_info);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP1, razwi_info);
+
+	WREG32(sts_clr_addr, sts_clr_val);
+}
+
+static void gaudi2_handle_kdma_core_event(struct hl_device *hdev, u64 intr_cause_data)
+{
+	int i;
+
+	/* If an AXI read or write error is received, an error is reported and
+	 * interrupt message is sent. Due to an HW errata, when reading the cause
+	 * register of the KDMA engine, the reported error is always HBW even if
+	 * the actual error caused by a LBW KDMA transaction.
+	 */
+	for (i = 0 ; i < GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE ; i++)
+		if (intr_cause_data & BIT(i))
+			dev_err_ratelimited(hdev->dev, "kdma core err cause: %s\n",
+						gaudi2_kdma_core_interrupts_cause[i]);
+}
+
+static void gaudi2_handle_dma_core_event(struct hl_device *hdev, u64 intr_cause_data)
+{
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE ; i++)
+		if (intr_cause_data & BIT(i))
+			dev_err_ratelimited(hdev->dev, "dma core err cause: %s\n",
+						gaudi2_dma_core_interrupts_cause[i]);
+}
+
+static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data)
+{
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE; i++)
+		if (intr_cause_data & BIT_ULL(i))
+			dev_err_ratelimited(hdev->dev, "PCIE ADDR DEC Error: %s\n",
+						gaudi2_pcie_addr_dec_error_cause[i]);
+}
+
+static void gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
+
+{
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_PMMU_FATAL_ERR_CAUSE ; i++) {
+		if (intr_cause_data & BIT_ULL(i))
+			dev_err_ratelimited(hdev->dev, "PMMU PIF err cause: %s\n",
+					gaudi2_pmmu_fatal_interrupts_cause[i]);
+	}
+}
+
+static void gaudi2_handle_hif_fatal(struct hl_device *hdev, u16 event_type, u64 intr_cause_data)
+{
+	u32 dcore_id, hif_id;
+	int i;
+
+	dcore_id = (event_type - GAUDI2_EVENT_HIF0_FATAL) / 4;
+	hif_id = (event_type - GAUDI2_EVENT_HIF0_FATAL) % 4;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_HIF_FATAL_ERR_CAUSE ; i++) {
+		if (intr_cause_data & BIT_ULL(i))
+			dev_err_ratelimited(hdev->dev, "DCORE%u_HIF%u: %s\n", dcore_id, hif_id,
+					gaudi2_hif_fatal_interrupts_cause[i]);
+	}
+}
+
+static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool is_pmmu)
+{
+	u32 valid, val;
+	u64 addr;
+
+	valid = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_PAGE_ERROR_VALID));
+
+	if (!(valid & DCORE0_HMMU0_MMU_ACCESS_PAGE_ERROR_VALID_PAGE_ERR_VALID_ENTRY_MASK))
+		return;
+
+	val = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE));
+	addr = val & DCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE_VA_63_32_MASK;
+	addr <<= 32;
+	addr |= RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE_VA));
+
+	dev_err_ratelimited(hdev->dev, "%s page fault on va 0x%llx\n",
+				is_pmmu ? "PMMU" : "HMMU", addr);
+
+	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE), 0);
+}
+
+static void gaudi2_handle_access_error(struct hl_device *hdev, u64 mmu_base, bool is_pmmu)
+{
+	u32 valid, val;
+	u64 addr;
+
+	valid = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_PAGE_ERROR_VALID));
+
+	if (!(valid & DCORE0_HMMU0_MMU_ACCESS_PAGE_ERROR_VALID_ACCESS_ERR_VALID_ENTRY_MASK))
+		return;
+
+	val = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_ERROR_CAPTURE));
+	addr = val & DCORE0_HMMU0_MMU_ACCESS_ERROR_CAPTURE_VA_63_32_MASK;
+	addr <<= 32;
+	addr |= RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_ERROR_CAPTURE_VA));
+
+	dev_err_ratelimited(hdev->dev, "%s access error on va 0x%llx\n",
+				is_pmmu ? "PMMU" : "HMMU", addr);
+	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_ERROR_CAPTURE), 0);
+}
+
+static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char *mmu_name,
+						u64 mmu_base, bool is_pmmu)
+{
+	u32 spi_sei_cause, interrupt_clr = 0x0;
+	int i;
+
+	spi_sei_cause = RREG32(mmu_base + MMU_SPI_SEI_CAUSE_OFFSET);
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_MMU_SPI_SEI_CAUSE ; i++) {
+		if (spi_sei_cause & BIT(i)) {
+			dev_err_ratelimited(hdev->dev, "%s SPI_SEI ERR. err cause: %s\n",
+						mmu_name, gaudi2_mmu_spi_sei[i].cause);
+
+			if (i == 0)
+				gaudi2_handle_page_error(hdev, mmu_base, is_pmmu);
+			else if (i == 1)
+				gaudi2_handle_access_error(hdev, mmu_base, is_pmmu);
+
+			if (gaudi2_mmu_spi_sei[i].clear_bit >= 0)
+				interrupt_clr |= BIT(gaudi2_mmu_spi_sei[i].clear_bit);
+		}
+	}
+
+	/* Clear cause */
+	WREG32_AND(mmu_base + MMU_SPI_SEI_CAUSE_OFFSET, ~spi_sei_cause);
+
+	/* Clear interrupt */
+	WREG32(mmu_base + MMU_INTERRUPT_CLR_OFFSET, interrupt_clr);
+}
+
+static bool gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
+{
+	u32 sei_cause_addr, sei_cause_val, sei_cause_cause, sei_cause_log;
+	u32 cq_intr_addr, cq_intr_val, cq_intr_queue_index;
+	bool reset = true;
+	int i;
+
+	sei_cause_addr = mmDCORE0_SYNC_MNGR_GLBL_SM_SEI_CAUSE + DCORE_OFFSET * sm_index;
+	cq_intr_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_INTR + DCORE_OFFSET * sm_index;
+
+	sei_cause_val = RREG32(sei_cause_addr);
+	sei_cause_cause = FIELD_GET(DCORE0_SYNC_MNGR_GLBL_SM_SEI_CAUSE_CAUSE_MASK, sei_cause_val);
+	cq_intr_val = RREG32(cq_intr_addr);
+
+	/* SEI interrupt */
+	if (sei_cause_cause) {
+		/* There are corresponding SEI_CAUSE_log bits for every SEI_CAUSE_cause bit */
+		sei_cause_log = FIELD_GET(DCORE0_SYNC_MNGR_GLBL_SM_SEI_CAUSE_LOG_MASK,
+					sei_cause_val);
+
+		for (i = 0 ; i < GAUDI2_NUM_OF_SM_SEI_ERR_CAUSE ; i++) {
+			if (!(sei_cause_cause & BIT(i)))
+				continue;
+
+			dev_err_ratelimited(hdev->dev, "SM%u SEI ERR. err cause: %s. %s: 0x%X\n",
+					sm_index,
+					gaudi2_sm_sei_cause[i].cause_name,
+					gaudi2_sm_sei_cause[i].log_name,
+					sei_cause_log & gaudi2_sm_sei_cause[i].log_mask);
+
+			/* Due to a potential H/W issue, do not reset upon BRESP errors */
+			if (i == 2)
+				reset = false;
+			break;
+		}
+
+		/* Clear SM_SEI_CAUSE */
+		WREG32(sei_cause_addr, 0);
+	}
+
+	/* CQ interrupt */
+	if (cq_intr_val & DCORE0_SYNC_MNGR_GLBL_CQ_INTR_CQ_SEC_INTR_MASK) {
+		cq_intr_queue_index =
+				FIELD_GET(DCORE0_SYNC_MNGR_GLBL_CQ_INTR_CQ_INTR_QUEUE_INDEX_MASK,
+					cq_intr_val);
+
+		dev_err_ratelimited(hdev->dev, "SM%u err. err cause: CQ_INTR. queue index: %u\n",
+				sm_index, cq_intr_queue_index);
+
+		/* Clear CQ_INTR */
+		WREG32(cq_intr_addr, 0);
+	}
+
+	return reset;
+}
+
+static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type)
+{
+	bool is_pmmu = false;
+	char desc[32];
+	u64 mmu_base;
+	u8 index;
+
+	switch (event_type) {
+	case GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM ... GAUDI2_EVENT_HMMU3_SECURITY_ERROR:
+		index = (event_type - GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM) / 3;
+		mmu_base = mmDCORE0_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_3_AXI_ERR_RSP:
+		index = (event_type - GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP);
+		mmu_base = mmDCORE0_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU8_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_HMMU11_SECURITY_ERROR:
+		index = (event_type - GAUDI2_EVENT_HMMU8_PAGE_FAULT_WR_PERM) / 3;
+		mmu_base = mmDCORE1_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU_8_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_11_AXI_ERR_RSP:
+		index = (event_type - GAUDI2_EVENT_HMMU_8_AXI_ERR_RSP);
+		mmu_base = mmDCORE1_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU7_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_HMMU4_SECURITY_ERROR:
+		index = (event_type - GAUDI2_EVENT_HMMU7_PAGE_FAULT_WR_PERM) / 3;
+		mmu_base = mmDCORE2_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU_7_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_4_AXI_ERR_RSP:
+		index = (event_type - GAUDI2_EVENT_HMMU_7_AXI_ERR_RSP);
+		mmu_base = mmDCORE2_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU15_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_HMMU12_SECURITY_ERROR:
+		index = (event_type - GAUDI2_EVENT_HMMU15_PAGE_FAULT_WR_PERM) / 3;
+		mmu_base = mmDCORE3_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_HMMU_15_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
+		index = (event_type - GAUDI2_EVENT_HMMU_15_AXI_ERR_RSP);
+		mmu_base = mmDCORE3_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
+		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_HMMU%d", index);
+		break;
+	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
+	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
+		is_pmmu = true;
+		mmu_base = mmPMMU_HBW_MMU_BASE;
+		snprintf(desc, ARRAY_SIZE(desc), "PMMU");
+		break;
+	default:
+		return;
+	}
+
+	gaudi2_handle_mmu_spi_sei_generic(hdev, desc, mmu_base, is_pmmu);
+}
+
+
+/* returns true if hard reset is required (ECC DERR or Read parity), false otherwise (ECC SERR) */
+static bool gaudi2_hbm_sei_handle_read_err(struct hl_device *hdev,
+			struct hl_eq_hbm_sei_read_err_intr_info *rd_err_data, u32 err_cnt)
+{
+	u32 addr, beat, beat_shift;
+	bool rc = false;
+
+	dev_err_ratelimited(hdev->dev,
+			"READ ERROR count: ECC SERR: %d, ECC DERR: %d, RD_PARITY: %d\n",
+			FIELD_GET(HBM_ECC_SERR_CNTR_MASK, err_cnt),
+			FIELD_GET(HBM_ECC_DERR_CNTR_MASK, err_cnt),
+			FIELD_GET(HBM_RD_PARITY_CNTR_MASK, err_cnt));
+
+	addr = le32_to_cpu(rd_err_data->dbg_rd_err_addr.rd_addr_val);
+	dev_err_ratelimited(hdev->dev,
+			"READ ERROR address: sid(%u), bg(%u), ba(%u), col(%u), row(%u)\n",
+			FIELD_GET(HBM_RD_ADDR_SID_MASK, addr),
+			FIELD_GET(HBM_RD_ADDR_BG_MASK, addr),
+			FIELD_GET(HBM_RD_ADDR_BA_MASK, addr),
+			FIELD_GET(HBM_RD_ADDR_COL_MASK, addr),
+			FIELD_GET(HBM_RD_ADDR_ROW_MASK, addr));
+
+	/* For each beat (RDQS edge), look for possible errors and print relevant info */
+	for (beat = 0 ; beat < 4 ; beat++) {
+		if (le32_to_cpu(rd_err_data->dbg_rd_err_misc) &
+			(HBM_RD_ERR_SERR_BEAT0_MASK << beat))
+			dev_err_ratelimited(hdev->dev, "Beat%d ECC SERR: DM: %#x, Syndrome: %#x\n",
+						beat,
+						le32_to_cpu(rd_err_data->dbg_rd_err_dm),
+						le32_to_cpu(rd_err_data->dbg_rd_err_syndrome));
+
+		if (le32_to_cpu(rd_err_data->dbg_rd_err_misc) &
+			(HBM_RD_ERR_DERR_BEAT0_MASK << beat)) {
+			dev_err_ratelimited(hdev->dev, "Beat%d ECC DERR: DM: %#x, Syndrome: %#x\n",
+						beat,
+						le32_to_cpu(rd_err_data->dbg_rd_err_dm),
+						le32_to_cpu(rd_err_data->dbg_rd_err_syndrome));
+			rc |= true;
+		}
+
+		beat_shift = beat * HBM_RD_ERR_BEAT_SHIFT;
+		if (le32_to_cpu(rd_err_data->dbg_rd_err_misc) &
+			(HBM_RD_ERR_PAR_ERR_BEAT0_MASK << beat_shift)) {
+			dev_err_ratelimited(hdev->dev,
+					"Beat%d read PARITY: DM: %#x, PAR data: %#x\n",
+					beat,
+					le32_to_cpu(rd_err_data->dbg_rd_err_dm),
+					(le32_to_cpu(rd_err_data->dbg_rd_err_misc) &
+						(HBM_RD_ERR_PAR_DATA_BEAT0_MASK << beat_shift)) >>
+						(HBM_RD_ERR_PAR_DATA_BEAT0_SHIFT + beat_shift));
+			rc |= true;
+		}
+
+		dev_err_ratelimited(hdev->dev, "Beat%d DQ data:\n", beat);
+		dev_err_ratelimited(hdev->dev, "\t0x%08x\n",
+					le32_to_cpu(rd_err_data->dbg_rd_err_data[beat * 2]));
+		dev_err_ratelimited(hdev->dev, "\t0x%08x\n",
+					le32_to_cpu(rd_err_data->dbg_rd_err_data[beat * 2 + 1]));
+	}
+
+	return rc;
+}
+
+static void gaudi2_hbm_sei_print_wr_par_info(struct hl_device *hdev,
+			struct hl_eq_hbm_sei_wr_par_intr_info *wr_par_err_data, u32 err_cnt)
+{
+	struct hbm_sei_wr_cmd_address *wr_cmd_addr = wr_par_err_data->dbg_last_wr_cmds;
+	u32 i, curr_addr, derr = wr_par_err_data->dbg_derr;
+
+	dev_err_ratelimited(hdev->dev, "WRITE PARITY ERROR count: %d\n", err_cnt);
+
+	dev_err_ratelimited(hdev->dev, "CK-0 DERR: 0x%02x, CK-1 DERR: 0x%02x\n",
+				derr & 0x3, derr & 0xc);
+
+	/* JIRA H6-3286 - the following prints may not be valid */
+	dev_err_ratelimited(hdev->dev, "Last latched write commands addresses:\n");
+	for (i = 0 ; i < HBM_WR_PAR_CMD_LIFO_LEN ; i++) {
+		curr_addr = le32_to_cpu(wr_cmd_addr[i].dbg_wr_cmd_addr);
+		dev_err_ratelimited(hdev->dev,
+				"\twrite cmd[%u]: Address: SID(%u) BG(%u) BA(%u) COL(%u).\n",
+				i,
+				FIELD_GET(WR_PAR_LAST_CMD_SID_MASK, curr_addr),
+				FIELD_GET(WR_PAR_LAST_CMD_BG_MASK, curr_addr),
+				FIELD_GET(WR_PAR_LAST_CMD_BA_MASK, curr_addr),
+				FIELD_GET(WR_PAR_LAST_CMD_COL_MASK, curr_addr));
+	}
+}
+
+static void gaudi2_hbm_sei_print_ca_par_info(struct hl_device *hdev,
+		struct hl_eq_hbm_sei_ca_par_intr_info *ca_par_err_data, u32 err_cnt)
+{
+	__le32 *col_cmd = ca_par_err_data->dbg_col;
+	__le16 *row_cmd = ca_par_err_data->dbg_row;
+	u32 i;
+
+	dev_err_ratelimited(hdev->dev, "CA ERROR count: %d\n", err_cnt);
+
+	dev_err_ratelimited(hdev->dev, "Last latched C&R bus commands:\n");
+	for (i = 0 ; i < HBM_CA_ERR_CMD_LIFO_LEN ; i++)
+		dev_err_ratelimited(hdev->dev, "cmd%u: ROW(0x%04x) COL(0x%05x)\n", i,
+			le16_to_cpu(row_cmd[i]) & (u16)GENMASK(13, 0),
+			le32_to_cpu(col_cmd[i]) & (u32)GENMASK(17, 0));
+}
+
+/* Returns true if hard reset is needed or false otherwise */
+static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
+					struct hl_eq_hbm_sei_data *sei_data)
+{
+	bool require_hard_reset = false;
+	u32 hbm_id, mc_id, cause_idx;
+
+	hbm_id = (event_type - GAUDI2_EVENT_HBM0_MC0_SEI_SEVERE) / 4;
+	mc_id = ((event_type - GAUDI2_EVENT_HBM0_MC0_SEI_SEVERE) / 2) % 2;
+
+	cause_idx = sei_data->hdr.sei_cause;
+	if (cause_idx > GAUDI2_NUM_OF_HBM_SEI_CAUSE - 1) {
+		dev_err_ratelimited(hdev->dev, "Invalid HBM SEI event cause (%d) provided by FW\n",
+					cause_idx);
+		return true;
+	}
+
+	dev_err_ratelimited(hdev->dev,
+			"System Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
+			hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
+			hbm_mc_sei_cause[cause_idx]);
+
+	/* Print error-specific info */
+	switch (cause_idx) {
+	case HBM_SEI_CATTRIP:
+		require_hard_reset = true;
+		break;
+
+	case  HBM_SEI_CMD_PARITY_EVEN:
+		gaudi2_hbm_sei_print_ca_par_info(hdev, &sei_data->ca_parity_even_info,
+						le32_to_cpu(sei_data->hdr.cnt));
+		require_hard_reset = true;
+		break;
+
+	case  HBM_SEI_CMD_PARITY_ODD:
+		gaudi2_hbm_sei_print_ca_par_info(hdev, &sei_data->ca_parity_odd_info,
+						le32_to_cpu(sei_data->hdr.cnt));
+		require_hard_reset = true;
+		break;
+
+	case HBM_SEI_WRITE_DATA_PARITY_ERR:
+		gaudi2_hbm_sei_print_wr_par_info(hdev, &sei_data->wr_parity_info,
+						le32_to_cpu(sei_data->hdr.cnt));
+		require_hard_reset = true;
+		break;
+
+	case HBM_SEI_READ_ERR:
+		/* Unlike other SEI events, read error requires further processing of the
+		 * raw data in order to determine the root cause.
+		 */
+		require_hard_reset = gaudi2_hbm_sei_handle_read_err(hdev,
+								&sei_data->read_err_info,
+								le32_to_cpu(sei_data->hdr.cnt));
+		break;
+
+	default:
+		break;
+	};
+
+	return require_hard_reset;
+}
+
+static void gaudi2_handle_hbm_cattrip(struct hl_device *hdev, u64 intr_cause_data)
+{
+	dev_err(hdev->dev,
+		"HBM catastrophic temperature error (CATTRIP) cause %#llx\n",
+		intr_cause_data);
+}
+
+static void gaudi2_handle_hbm_mc_spi(struct hl_device *hdev, u64 intr_cause_data)
+{
+	u32 i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_HBM_MC_SPI_CAUSE ; i++)
+		if (intr_cause_data & hbm_mc_spi[i].mask)
+			dev_dbg(hdev->dev, "HBM spi event: notification cause(%s)\n",
+				hbm_mc_spi[i].cause);
+}
+
+static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type)
+{
+	ktime_t zero_time = ktime_set(0, 0);
+
+	mutex_lock(&hdev->clk_throttling.lock);
+
+	switch (event_type) {
+	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_S:
+		hdev->clk_throttling.current_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].start = ktime_get();
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = zero_time;
+		dev_info_ratelimited(hdev->dev, "Clock throttling due to power consumption\n");
+		break;
+
+	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_E:
+		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = ktime_get();
+		dev_info_ratelimited(hdev->dev, "Power envelop is safe, back to optimal clock\n");
+		break;
+
+	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_S:
+		hdev->clk_throttling.current_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].start = ktime_get();
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = zero_time;
+		dev_info_ratelimited(hdev->dev, "Clock throttling due to overheating\n");
+		break;
+
+	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
+		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = ktime_get();
+		dev_info_ratelimited(hdev->dev, "Thermal envelop is safe, back to optimal clock\n");
+		break;
+
+	default:
+		dev_err(hdev->dev, "Received invalid clock change event %d\n", event_type);
+		break;
+	}
+
+	mutex_unlock(&hdev->clk_throttling.lock);
+}
+
+static void gaudi2_print_out_of_sync_info(struct hl_device *hdev,
+					struct cpucp_pkt_sync_err *sync_err)
+{
+	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
+
+	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
+			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+}
+
+static void gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
+{
+	u32 p2p_intr, msix_gw_intr;
+
+	p2p_intr = RREG32(mmPCIE_WRAP_P2P_INTR);
+	msix_gw_intr = RREG32(mmPCIE_WRAP_MSIX_GW_INTR);
+
+	if (p2p_intr) {
+		dev_err_ratelimited(hdev->dev,
+			"pcie p2p transaction terminated due to security, req_id(0x%x)\n",
+			RREG32(mmPCIE_WRAP_P2P_REQ_ID));
+
+		WREG32(mmPCIE_WRAP_P2P_INTR, 0x1);
+	}
+
+	if (msix_gw_intr) {
+		dev_err_ratelimited(hdev->dev,
+			"pcie msi-x gen denied due to vector num check failure, vec(0x%X)\n",
+			RREG32(mmPCIE_WRAP_MSIX_GW_VEC));
+
+		WREG32(mmPCIE_WRAP_MSIX_GW_INTR, 0x1);
+	}
+}
+
+static void gaudi2_handle_pcie_drain(struct hl_device *hdev,
+			struct hl_eq_pcie_drain_ind_data *drain_data)
+{
+	u64 lbw_rd, lbw_wr, hbw_rd, hbw_wr, cause;
+
+	cause = le64_to_cpu(drain_data->intr_cause.intr_cause_data);
+	lbw_rd = le64_to_cpu(drain_data->drain_rd_addr_lbw);
+	lbw_wr = le64_to_cpu(drain_data->drain_wr_addr_lbw);
+	hbw_rd = le64_to_cpu(drain_data->drain_rd_addr_hbw);
+	hbw_wr = le64_to_cpu(drain_data->drain_wr_addr_hbw);
+
+	if (cause & BIT_ULL(0))
+		dev_err_ratelimited(hdev->dev,
+			"PCIE AXI drain LBW completed, read_err %u, write_err %u\n",
+			!!lbw_rd, !!lbw_wr);
+
+	if (cause & BIT_ULL(1))
+		dev_err_ratelimited(hdev->dev,
+			"PCIE AXI drain HBW completed, raddr %#llx, waddr %#llx\n",
+			hbw_rd, hbw_wr);
+}
+
+static void gaudi2_handle_psoc_drain(struct hl_device *hdev, u64 intr_cause_data)
+{
+	int i;
+
+	for (i = 0 ; i < GAUDI2_NUM_OF_AXI_DRAIN_ERR_CAUSE ; i++) {
+		if (intr_cause_data & BIT_ULL(i))
+			dev_err_ratelimited(hdev->dev, "PSOC %s completed\n",
+				gaudi2_psoc_axi_drain_interrupts_cause[i]);
+	}
+}
+
+static void gaudi2_print_cpu_pkt_failure_info(struct hl_device *hdev,
+					struct cpucp_pkt_sync_err *sync_err)
+{
+	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
+
+	dev_warn(hdev->dev,
+		"FW reported sanity check failure, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
+		sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+}
+
+static void hl_arc_event_handle(struct hl_device *hdev,
+					struct hl_eq_engine_arc_intr_data *data)
+{
+	struct hl_engine_arc_dccm_queue_full_irq *q;
+	u32 intr_type, engine_id;
+	u64 payload;
+
+	intr_type = le32_to_cpu(data->intr_type);
+	engine_id = le32_to_cpu(data->engine_id);
+	payload = le64_to_cpu(data->payload);
+
+	switch (intr_type) {
+	case ENGINE_ARC_DCCM_QUEUE_FULL_IRQ:
+		q = (struct hl_engine_arc_dccm_queue_full_irq *) &payload;
+
+		dev_err_ratelimited(hdev->dev,
+				"ARC DCCM Full event: EngId: %u, Intr_type: %u, Qidx: %u\n",
+				engine_id, intr_type, q->queue_index);
+		break;
+	default:
+		dev_err_ratelimited(hdev->dev, "Unknown ARC event type\n");
+	}
+}
+
+static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
+{
+	u32 ctl, reset_flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	bool hbm_require_reset = false, skip_reset = false;
+	int index, sbte_index;
+	u16 event_type;
+
+	ctl = le32_to_cpu(eq_entry->hdr.ctl);
+	event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK) >> EQ_CTL_EVENT_TYPE_SHIFT);
+
+	if (event_type >= GAUDI2_EVENT_SIZE) {
+		dev_err(hdev->dev, "Event type %u exceeds maximum of %u",
+				event_type, GAUDI2_EVENT_SIZE - 1);
+		return;
+	}
+
+	gaudi2->events_stat[event_type]++;
+	gaudi2->events_stat_aggregate[event_type]++;
+
+	gaudi2_print_irq_info(hdev, event_type);
+
+	switch (event_type) {
+	case GAUDI2_EVENT_PCIE_CORE_SERR ... GAUDI2_EVENT_ARC0_ECC_DERR:
+		fallthrough;
+	case GAUDI2_EVENT_ROTATOR0_SERR ... GAUDI2_EVENT_ROTATOR1_DERR:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		gaudi2_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		break;
+
+	case GAUDI2_EVENT_TPC0_QM ... GAUDI2_EVENT_PDMA1_QM:
+		fallthrough;
+	case GAUDI2_EVENT_ROTATOR0_ROT0_QM ... GAUDI2_EVENT_ROTATOR1_ROT1_QM:
+		fallthrough;
+	case GAUDI2_EVENT_NIC0_QM0 ... GAUDI2_EVENT_NIC11_QM1:
+		gaudi2_handle_qman_err(hdev, event_type);
+		break;
+
+	case GAUDI2_EVENT_ARC_AXI_ERROR_RESPONSE_0:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		gaudi2_handle_arc_farm_sei_err(hdev);
+		break;
+
+	case GAUDI2_EVENT_CPU_AXI_ERR_RSP:
+		gaudi2_handle_cpu_sei_err(hdev);
+		break;
+
+	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
+	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		gaudi2_handle_qm_sei_err(hdev, event_type, &eq_entry->razwi_info);
+		break;
+
+	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_ROTATOR1_AXI_ERROR_RESPONSE:
+		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
+		gaudi2_handle_rot_err(hdev, index, &eq_entry->razwi_with_intr_cause);
+		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		break;
+
+	case GAUDI2_EVENT_TPC0_AXI_ERR_RSP ... GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
+		index = event_type - GAUDI2_EVENT_TPC0_AXI_ERR_RSP;
+		gaudi2_tpc_ack_interrupts(hdev, index, "AXI_ERR_RSP",
+						&eq_entry->razwi_with_intr_cause);
+		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		break;
+
+	case GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE ... GAUDI2_EVENT_DEC9_AXI_ERR_RSPONSE:
+		index = event_type - GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE;
+		gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE", &eq_entry->razwi_info);
+		break;
+
+	case GAUDI2_EVENT_TPC0_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC1_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC2_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC3_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC4_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC5_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC6_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC7_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC8_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC9_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC10_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC11_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC12_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC13_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC14_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC15_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC16_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC17_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC18_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC19_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC20_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC21_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC22_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC23_KERNEL_ERR:
+	case GAUDI2_EVENT_TPC24_KERNEL_ERR:
+		index = (event_type - GAUDI2_EVENT_TPC0_KERNEL_ERR) /
+			(GAUDI2_EVENT_TPC1_KERNEL_ERR - GAUDI2_EVENT_TPC0_KERNEL_ERR);
+		gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR", &eq_entry->razwi_with_intr_cause);
+		break;
+
+	case GAUDI2_EVENT_DEC0_SPI:
+	case GAUDI2_EVENT_DEC1_SPI:
+	case GAUDI2_EVENT_DEC2_SPI:
+	case GAUDI2_EVENT_DEC3_SPI:
+	case GAUDI2_EVENT_DEC4_SPI:
+	case GAUDI2_EVENT_DEC5_SPI:
+	case GAUDI2_EVENT_DEC6_SPI:
+	case GAUDI2_EVENT_DEC7_SPI:
+	case GAUDI2_EVENT_DEC8_SPI:
+	case GAUDI2_EVENT_DEC9_SPI:
+		index = (event_type - GAUDI2_EVENT_DEC0_SPI) /
+				(GAUDI2_EVENT_DEC1_SPI - GAUDI2_EVENT_DEC0_SPI);
+		gaudi2_handle_dec_err(hdev, index, "SPI", &eq_entry->razwi_info);
+		break;
+
+	case GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_MME2_CTRL_AXI_ERROR_RESPONSE:
+	case GAUDI2_EVENT_MME3_CTRL_AXI_ERROR_RESPONSE:
+		index = (event_type - GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE) /
+				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
+						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
+		gaudi2_handle_mme_err(hdev, index,
+				"CTRL_AXI_ERROR_RESPONSE", &eq_entry->razwi_info);
+		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		break;
+
+	case GAUDI2_EVENT_MME0_QMAN_SW_ERROR:
+	case GAUDI2_EVENT_MME1_QMAN_SW_ERROR:
+	case GAUDI2_EVENT_MME2_QMAN_SW_ERROR:
+	case GAUDI2_EVENT_MME3_QMAN_SW_ERROR:
+		index = (event_type - GAUDI2_EVENT_MME0_QMAN_SW_ERROR) /
+				(GAUDI2_EVENT_MME1_QMAN_SW_ERROR -
+					GAUDI2_EVENT_MME0_QMAN_SW_ERROR);
+		gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR", &eq_entry->razwi_info);
+		break;
+
+	case GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID:
+	case GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID:
+	case GAUDI2_EVENT_MME2_WAP_SOURCE_RESULT_INVALID:
+	case GAUDI2_EVENT_MME3_WAP_SOURCE_RESULT_INVALID:
+		index = (event_type - GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID) /
+				(GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID -
+					GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID);
+		gaudi2_handle_mme_wap_err(hdev, index, &eq_entry->razwi_info);
+		break;
+
+	case GAUDI2_EVENT_KDMA_CH0_AXI_ERR_RSP:
+	case GAUDI2_EVENT_KDMA0_CORE:
+		gaudi2_handle_kdma_core_event(hdev,
+					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+
+	case GAUDI2_EVENT_HDMA2_CORE ... GAUDI2_EVENT_PDMA1_CORE:
+		gaudi2_handle_dma_core_event(hdev,
+					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+
+	case GAUDI2_EVENT_PCIE_ADDR_DEC_ERR:
+		gaudi2_print_pcie_addr_dec_info(hdev,
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+
+	case GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM ... GAUDI2_EVENT_HMMU12_SECURITY_ERROR:
+	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
+	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
+	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
+		gaudi2_handle_mmu_spi_sei_err(hdev, event_type);
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+
+	case GAUDI2_EVENT_HIF0_FATAL ... GAUDI2_EVENT_HIF12_FATAL:
+		gaudi2_handle_hif_fatal(hdev, event_type,
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+
+	case GAUDI2_EVENT_PMMU_FATAL_0:
+		gaudi2_handle_pif_fatal(hdev,
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+
+	case GAUDI2_EVENT_PSOC63_RAZWI_OR_PID_MIN_MAX_INTERRUPT:
+		gaudi2_ack_psoc_razwi_event_handler(hdev);
+		break;
+
+	case GAUDI2_EVENT_HBM0_MC0_SEI_SEVERE ... GAUDI2_EVENT_HBM5_MC1_SEI_NON_SEVERE:
+		if (gaudi2_handle_hbm_mc_sei_err(hdev, event_type, &eq_entry->sei_data)) {
+			reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+			hbm_require_reset = true;
+		}
+		break;
+
+	case GAUDI2_EVENT_HBM_CATTRIP_0 ... GAUDI2_EVENT_HBM_CATTRIP_5:
+		gaudi2_handle_hbm_cattrip(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+
+	case GAUDI2_EVENT_HBM0_MC0_SPI ... GAUDI2_EVENT_HBM5_MC1_SPI:
+		gaudi2_handle_hbm_mc_spi(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+
+	case GAUDI2_EVENT_PCIE_DRAIN_COMPLETE:
+		gaudi2_handle_pcie_drain(hdev, &eq_entry->pcie_drain_ind_data);
+		break;
+
+	case GAUDI2_EVENT_PSOC59_RPM_ERROR_OR_DRAIN:
+		gaudi2_handle_psoc_drain(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+
+	case GAUDI2_EVENT_CPU_AXI_ECC:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+	case GAUDI2_EVENT_CPU_L2_RAM_ECC:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+	case GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME0_SBTE4_AXI_ERR_RSP:
+	case GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME1_SBTE4_AXI_ERR_RSP:
+	case GAUDI2_EVENT_MME2_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME2_SBTE4_AXI_ERR_RSP:
+	case GAUDI2_EVENT_MME3_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME3_SBTE4_AXI_ERR_RSP:
+		index = (event_type - GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP) /
+				(GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP -
+					GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP);
+		sbte_index = (event_type - GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP) %
+				(GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP -
+					GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP);
+		gaudi2_handle_mme_sbte_err(hdev, index, sbte_index,
+						le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		break;
+	case GAUDI2_EVENT_VM0_ALARM_A ... GAUDI2_EVENT_VM3_ALARM_B:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+	case GAUDI2_EVENT_PSOC_AXI_ERR_RSP:
+	case GAUDI2_EVENT_PSOC_PRSTN_FALL:
+		break;
+	case GAUDI2_EVENT_PCIE_APB_TIMEOUT:
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		break;
+	case GAUDI2_EVENT_PCIE_FATAL_ERR:
+		break;
+	case GAUDI2_EVENT_TPC0_BMON_SPMU:
+	case GAUDI2_EVENT_TPC1_BMON_SPMU:
+	case GAUDI2_EVENT_TPC2_BMON_SPMU:
+	case GAUDI2_EVENT_TPC3_BMON_SPMU:
+	case GAUDI2_EVENT_TPC4_BMON_SPMU:
+	case GAUDI2_EVENT_TPC5_BMON_SPMU:
+	case GAUDI2_EVENT_TPC6_BMON_SPMU:
+	case GAUDI2_EVENT_TPC7_BMON_SPMU:
+	case GAUDI2_EVENT_TPC8_BMON_SPMU:
+	case GAUDI2_EVENT_TPC9_BMON_SPMU:
+	case GAUDI2_EVENT_TPC10_BMON_SPMU:
+	case GAUDI2_EVENT_TPC11_BMON_SPMU:
+	case GAUDI2_EVENT_TPC12_BMON_SPMU:
+	case GAUDI2_EVENT_TPC13_BMON_SPMU:
+	case GAUDI2_EVENT_TPC14_BMON_SPMU:
+	case GAUDI2_EVENT_TPC15_BMON_SPMU:
+	case GAUDI2_EVENT_TPC16_BMON_SPMU:
+	case GAUDI2_EVENT_TPC17_BMON_SPMU:
+	case GAUDI2_EVENT_TPC18_BMON_SPMU:
+	case GAUDI2_EVENT_TPC19_BMON_SPMU:
+	case GAUDI2_EVENT_TPC20_BMON_SPMU:
+	case GAUDI2_EVENT_TPC21_BMON_SPMU:
+	case GAUDI2_EVENT_TPC22_BMON_SPMU:
+	case GAUDI2_EVENT_TPC23_BMON_SPMU:
+	case GAUDI2_EVENT_TPC24_BMON_SPMU:
+	case GAUDI2_EVENT_MME0_CTRL_BMON_SPMU:
+	case GAUDI2_EVENT_MME0_SBTE_BMON_SPMU:
+	case GAUDI2_EVENT_MME0_WAP_BMON_SPMU:
+	case GAUDI2_EVENT_MME1_CTRL_BMON_SPMU:
+	case GAUDI2_EVENT_MME1_SBTE_BMON_SPMU:
+	case GAUDI2_EVENT_MME1_WAP_BMON_SPMU:
+	case GAUDI2_EVENT_MME2_CTRL_BMON_SPMU:
+	case GAUDI2_EVENT_MME2_SBTE_BMON_SPMU:
+	case GAUDI2_EVENT_MME2_WAP_BMON_SPMU:
+	case GAUDI2_EVENT_MME3_CTRL_BMON_SPMU:
+	case GAUDI2_EVENT_MME3_SBTE_BMON_SPMU:
+	case GAUDI2_EVENT_MME3_WAP_BMON_SPMU:
+	case GAUDI2_EVENT_HDMA2_BM_SPMU ... GAUDI2_EVENT_PDMA1_BM_SPMU:
+		fallthrough;
+	case GAUDI2_EVENT_DEC0_BMON_SPMU:
+	case GAUDI2_EVENT_DEC1_BMON_SPMU:
+	case GAUDI2_EVENT_DEC2_BMON_SPMU:
+	case GAUDI2_EVENT_DEC3_BMON_SPMU:
+	case GAUDI2_EVENT_DEC4_BMON_SPMU:
+	case GAUDI2_EVENT_DEC5_BMON_SPMU:
+	case GAUDI2_EVENT_DEC6_BMON_SPMU:
+	case GAUDI2_EVENT_DEC7_BMON_SPMU:
+	case GAUDI2_EVENT_DEC8_BMON_SPMU:
+	case GAUDI2_EVENT_DEC9_BMON_SPMU:
+	case GAUDI2_EVENT_ROTATOR0_BMON_SPMU ... GAUDI2_EVENT_SM3_BMON_SPMU:
+		break;
+
+	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_S:
+	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_E:
+	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_S:
+	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
+		gaudi2_print_clk_change_info(hdev, event_type);
+		break;
+
+	case GAUDI2_EVENT_CPU_PKT_QUEUE_OUT_SYNC:
+		gaudi2_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		break;
+
+	case GAUDI2_EVENT_PCIE_FLR_REQUESTED:
+		/* Do nothing- FW will handle it */
+		break;
+
+	case GAUDI2_EVENT_PCIE_P2P_MSIX:
+		gaudi2_handle_pcie_p2p_msix(hdev);
+		break;
+
+	case GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE ... GAUDI2_EVENT_SM3_AXI_ERROR_RESPONSE:
+		index = event_type - GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE;
+		skip_reset = !gaudi2_handle_sm_err(hdev, index);
+		break;
+
+	case GAUDI2_EVENT_PSOC_MME_PLL_LOCK_ERR ... GAUDI2_EVENT_DCORE2_HBM_PLL_LOCK_ERR:
+		break;
+
+	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_CAUSE:
+		dev_info(hdev->dev, "CPLD shutdown cause, reset reason: 0x%llx\n",
+						le64_to_cpu(eq_entry->data[0]));
+		break;
+	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_EVENT:
+		dev_err(hdev->dev, "CPLD shutdown event, reset reason: 0x%llx\n",
+						le64_to_cpu(eq_entry->data[0]));
+		break;
+
+	case GAUDI2_EVENT_CPU_PKT_SANITY_FAILED:
+		gaudi2_print_cpu_pkt_failure_info(hdev, &eq_entry->pkt_sync_err);
+		break;
+
+	case GAUDI2_EVENT_ARC_DCCM_FULL:
+		hl_arc_event_handle(hdev, &eq_entry->arc_data);
+		break;
+
+	default:
+		if (gaudi2_irq_map_table[event_type].valid)
+			dev_err_ratelimited(hdev->dev, "Cannot find handler for event %d\n",
+						event_type);
+	}
+
+	if ((gaudi2_irq_map_table[event_type].reset || hbm_require_reset) && !skip_reset)
+		goto reset_device;
+
+	/* Send unmask irq only for interrupts not classified as MSG */
+	if (!gaudi2_irq_map_table[event_type].msg)
+		hl_fw_unmask_irq(hdev, event_type);
+
+	return;
+
+reset_device:
+	if (hdev->hard_reset_on_fw_events) {
+		hl_device_reset(hdev, reset_flags);
+	} else {
+		if (!gaudi2_irq_map_table[event_type].msg)
+			hl_fw_unmask_irq(hdev, event_type);
+	}
+}
+
+static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 comp_addr, cur_addr = addr, end_addr = addr + size;
+	u32 chunk_size, busy, dcore, edma_idx, sob_offset, sob_addr, comp_val, edma_commit;
+	u32 old_mmubp, mmubp;
+	int rc = 0;
+
+	sob_offset = hdev->asic_prop.first_available_user_sob[0] * 4;
+	sob_addr = mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset;
+	comp_addr = CFG_BASE + sob_addr;
+	comp_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1) |
+		FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1);
+
+	edma_commit = FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_LIN_MASK, 1) |
+			FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_MEM_SET_MASK, 1) |
+			FIELD_PREP(ARC_FARM_KDMA_CTX_COMMIT_WR_COMP_EN_MASK, 1);
+	mmubp = FIELD_PREP(ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_WR_MASK, 1) |
+		FIELD_PREP(ARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP_RD_MASK, 1);
+
+	if (prop->edma_enabled_mask == 0) {
+		dev_info(hdev->dev, "non of the EDMA engines is enabled - skip dram scrubbing\n");
+		return -EIO;
+	}
+
+	/*
+	 * set mmu bypass for the scrubbing - all ddmas are configured the same so save
+	 * only the first one to restore later
+	 */
+	old_mmubp = RREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP);
+	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+		for (edma_idx = 0 ; edma_idx < NUM_OF_EDMA_PER_DCORE ; edma_idx++) {
+			u32 edma_offset = dcore * DCORE_OFFSET + edma_idx * DCORE_EDMA_OFFSET;
+			u32 edma_bit = dcore * NUM_OF_EDMA_PER_DCORE + edma_idx;
+
+			if (!(prop->edma_enabled_mask & BIT(edma_bit)))
+				continue;
+
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP +
+					edma_offset, mmubp);
+		}
+	}
+
+	while (cur_addr < end_addr) {
+		int dma_num = 0;
+
+		WREG32(sob_addr, 0);
+		for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+			for (edma_idx = 0 ; edma_idx < NUM_OF_EDMA_PER_DCORE ; edma_idx++) {
+				u32 edma_offset = dcore * DCORE_OFFSET +
+					edma_idx * DCORE_EDMA_OFFSET;
+				u32 edma_bit = dcore * NUM_OF_EDMA_PER_DCORE + edma_idx;
+
+				if (!(prop->edma_enabled_mask & BIT(edma_bit)))
+					continue;
+
+				chunk_size = min_t(u64, SZ_2G, end_addr - cur_addr);
+
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_SRC_BASE_LO + edma_offset,
+						lower_32_bits(val));
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_SRC_BASE_HI + edma_offset,
+						upper_32_bits(val));
+
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_DST_BASE_LO + edma_offset,
+						lower_32_bits(cur_addr));
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_DST_BASE_HI + edma_offset,
+						upper_32_bits(cur_addr));
+
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_LO + edma_offset,
+						lower_32_bits(comp_addr));
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_ADDR_HI + edma_offset,
+						upper_32_bits(comp_addr));
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_WR_COMP_WDATA + edma_offset,
+						comp_val);
+
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_DST_TSIZE_0 + edma_offset,
+						chunk_size);
+				WREG32(mmDCORE0_EDMA0_CORE_CTX_COMMIT + edma_offset, edma_commit);
+
+				dma_num++;
+
+				cur_addr += chunk_size;
+
+				if (cur_addr == end_addr)
+					goto poll;
+			}
+		}
+poll:
+		rc = hl_poll_timeout(hdev, sob_addr, busy, (busy == dma_num), 1000, 1000000);
+		if (rc) {
+			dev_err(hdev->dev, "DMA Timeout during HBM scrubbing\n");
+			goto end;
+		}
+	}
+end:
+	for (dcore = 0 ; dcore < NUM_OF_DCORES ; dcore++) {
+		for (edma_idx = 0 ; edma_idx < NUM_OF_EDMA_PER_DCORE ; edma_idx++) {
+			u32 edma_offset = dcore * DCORE_OFFSET + edma_idx * DCORE_EDMA_OFFSET;
+			u32 edma_bit = dcore * NUM_OF_EDMA_PER_DCORE + edma_idx;
+
+			if (!(prop->edma_enabled_mask & BIT(edma_bit)))
+				continue;
+
+			WREG32(mmDCORE0_EDMA0_CORE_CTX_AXUSER_HB_MMU_BP + edma_offset, old_mmubp);
+		}
+	}
+
+	WREG32(sob_addr, 0);
+	return rc;
+}
+
+static int gaudi2_scrub_device_dram(struct hl_device *hdev, u64 val)
+{
+	int rc;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 size = prop->dram_end_address - prop->dram_user_base_address;
+
+	rc = gaudi2_memset_device_memory(hdev, prop->dram_user_base_address, size, val);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to scrub dram, address: 0x%llx size: %llu\n",
+				prop->dram_user_base_address, size);
+	return rc;
+}
+
+static int gaudi2_scrub_device_mem(struct hl_device *hdev)
+{
+	int rc;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 val = hdev->memory_scrub_val;
+	u64 addr, size;
+
+	if (!hdev->memory_scrub)
+		return 0;
+
+	/* scrub SRAM */
+	addr = prop->sram_user_base_address;
+	size = hdev->pldm ? 0x10000 : (prop->sram_size - SRAM_USER_BASE_OFFSET);
+	dev_dbg(hdev->dev, "Scrubbing SRAM: 0x%09llx - 0x%09llx, val: 0x%llx\n",
+			addr, addr + size, val);
+	rc = gaudi2_memset_device_memory(hdev, addr, size, val);
+	if (rc) {
+		dev_err(hdev->dev, "scrubbing SRAM failed (%d)\n", rc);
+		return rc;
+	}
+
+	/* scrub DRAM */
+	rc = gaudi2_scrub_device_dram(hdev, val);
+	if (rc) {
+		dev_err(hdev->dev, "scrubbing DRAM failed (%d)\n", rc);
+		return rc;
+	}
+	return 0;
+}
+
+static void gaudi2_restore_user_sm_registers(struct hl_device *hdev)
+{
+	u64 addr, mon_sts_addr, mon_cfg_addr, cq_lbw_l_addr, cq_lbw_h_addr,
+		cq_lbw_data_addr, cq_base_l_addr, cq_base_h_addr, cq_size_addr;
+	u32 val, size, offset;
+	int dcore_id;
+
+	offset = hdev->asic_prop.first_available_cq[0] * 4;
+	cq_lbw_l_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0 + offset;
+	cq_lbw_h_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0 + offset;
+	cq_lbw_data_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_DATA_0 + offset;
+	cq_base_l_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_BASE_ADDR_L_0 + offset;
+	cq_base_h_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_BASE_ADDR_H_0 + offset;
+	cq_size_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_SIZE_LOG2_0 + offset;
+	size = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0 -
+			(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0 + offset);
+
+	/* memset dcore0 CQ registers */
+	gaudi2_memset_device_lbw(hdev, cq_lbw_l_addr, size, 0);
+	gaudi2_memset_device_lbw(hdev, cq_lbw_h_addr, size, 0);
+	gaudi2_memset_device_lbw(hdev, cq_lbw_data_addr, size, 0);
+	gaudi2_memset_device_lbw(hdev, cq_base_l_addr, size, 0);
+	gaudi2_memset_device_lbw(hdev, cq_base_h_addr, size, 0);
+
+	cq_lbw_l_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0 + DCORE_OFFSET;
+	cq_lbw_h_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0 + DCORE_OFFSET;
+	cq_lbw_data_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_DATA_0 + DCORE_OFFSET;
+	cq_base_l_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_BASE_ADDR_L_0 + DCORE_OFFSET;
+	cq_base_h_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_BASE_ADDR_H_0 + DCORE_OFFSET;
+	cq_size_addr = mmDCORE0_SYNC_MNGR_GLBL_CQ_SIZE_LOG2_0 + DCORE_OFFSET;
+	size = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0 - mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0;
+
+	for (dcore_id = 1 ; dcore_id < NUM_OF_DCORES ; dcore_id++) {
+		gaudi2_memset_device_lbw(hdev, cq_lbw_l_addr, size, 0);
+		gaudi2_memset_device_lbw(hdev, cq_lbw_h_addr, size, 0);
+		gaudi2_memset_device_lbw(hdev, cq_lbw_data_addr, size, 0);
+		gaudi2_memset_device_lbw(hdev, cq_base_l_addr, size, 0);
+		gaudi2_memset_device_lbw(hdev, cq_base_h_addr, size, 0);
+		gaudi2_memset_device_lbw(hdev, cq_size_addr, size, 0);
+
+		cq_lbw_l_addr += DCORE_OFFSET;
+		cq_lbw_h_addr += DCORE_OFFSET;
+		cq_lbw_data_addr += DCORE_OFFSET;
+		cq_base_l_addr += DCORE_OFFSET;
+		cq_base_h_addr += DCORE_OFFSET;
+		cq_size_addr += DCORE_OFFSET;
+	}
+
+	offset = hdev->asic_prop.first_available_user_mon[0] * 4;
+	addr = mmDCORE0_SYNC_MNGR_OBJS_MON_STATUS_0 + offset;
+	val = 1 << DCORE0_SYNC_MNGR_OBJS_MON_STATUS_PROT_SHIFT;
+	size = mmDCORE0_SYNC_MNGR_OBJS_SM_SEC_0 - (mmDCORE0_SYNC_MNGR_OBJS_MON_STATUS_0 + offset);
+
+	/* memset dcore0 monitors */
+	gaudi2_memset_device_lbw(hdev, addr, size, val);
+
+	addr = mmDCORE0_SYNC_MNGR_OBJS_MON_CONFIG_0 + offset;
+	gaudi2_memset_device_lbw(hdev, addr, size, 0);
+
+	mon_sts_addr = mmDCORE0_SYNC_MNGR_OBJS_MON_STATUS_0 + DCORE_OFFSET;
+	mon_cfg_addr = mmDCORE0_SYNC_MNGR_OBJS_MON_CONFIG_0 + DCORE_OFFSET;
+	size = mmDCORE0_SYNC_MNGR_OBJS_SM_SEC_0 - mmDCORE0_SYNC_MNGR_OBJS_MON_STATUS_0;
+
+	for (dcore_id = 1 ; dcore_id < NUM_OF_DCORES ; dcore_id++) {
+		gaudi2_memset_device_lbw(hdev, mon_sts_addr, size, val);
+		gaudi2_memset_device_lbw(hdev, mon_cfg_addr, size, 0);
+		mon_sts_addr += DCORE_OFFSET;
+		mon_cfg_addr += DCORE_OFFSET;
+	}
+
+	offset = hdev->asic_prop.first_available_user_sob[0] * 4;
+	addr = mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset;
+	val = 0;
+	size = mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 -
+			(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset);
+
+	/* memset dcore0 sobs */
+	gaudi2_memset_device_lbw(hdev, addr, size, val);
+
+	addr = mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + DCORE_OFFSET;
+	size = mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 - mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0;
+
+	for (dcore_id = 1 ; dcore_id < NUM_OF_DCORES ; dcore_id++) {
+		gaudi2_memset_device_lbw(hdev, addr, size, val);
+		addr += DCORE_OFFSET;
+	}
+
+	/* Flush all WREG to prevent race */
+	val = RREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset);
+}
+
+static void gaudi2_restore_user_qm_registers(struct hl_device *hdev)
+{
+	u32 reg_base, hw_queue_id;
+
+	for (hw_queue_id = GAUDI2_QUEUE_ID_PDMA_0_0 ; hw_queue_id <= GAUDI2_QUEUE_ID_ROT_1_0;
+							hw_queue_id += NUM_OF_PQ_PER_QMAN) {
+		if (!gaudi2_is_queue_enabled(hdev, hw_queue_id))
+			continue;
+
+		gaudi2_clear_qm_fence_counters_common(hdev, hw_queue_id, false);
+
+		reg_base = gaudi2_qm_blocks_bases[hw_queue_id];
+		WREG32(reg_base + QM_ARB_CFG_0_OFFSET, 0);
+	}
+
+	/* Flush all WREG to prevent race */
+	RREG32(mmPDMA0_QM_ARB_CFG_0);
+}
+
+static void gaudi2_restore_nic_qm_registers(struct hl_device *hdev)
+{
+	u32 reg_base, hw_queue_id;
+
+	for (hw_queue_id = GAUDI2_QUEUE_ID_NIC_0_0 ; hw_queue_id <= GAUDI2_QUEUE_ID_NIC_23_3;
+							hw_queue_id += NUM_OF_PQ_PER_QMAN) {
+		if (!gaudi2_is_queue_enabled(hdev, hw_queue_id))
+			continue;
+
+		gaudi2_clear_qm_fence_counters_common(hdev, hw_queue_id, false);
+
+		reg_base = gaudi2_qm_blocks_bases[hw_queue_id];
+		WREG32(reg_base + QM_ARB_CFG_0_OFFSET, 0);
+	}
+
+	/* Flush all WREG to prevent race */
+	RREG32(mmPDMA0_QM_ARB_CFG_0);
+}
+
+static int gaudi2_context_switch(struct hl_device *hdev, u32 asid)
+{
+	return 0;
+}
+
+static void gaudi2_restore_phase_topology(struct hl_device *hdev)
+{
+}
+
+static void gaudi2_init_block_instances(struct hl_device *hdev, u32 block_idx,
+						struct dup_block_ctx *cfg_ctx)
+{
+	u64 block_base = cfg_ctx->base + block_idx * cfg_ctx->block_off;
+	u8 seq;
+	int i;
+
+	for (i = 0 ; i < cfg_ctx->instances ; i++) {
+		seq = block_idx * cfg_ctx->instances + i;
+
+		/* skip disabled instance */
+		if (!(cfg_ctx->enabled_mask & BIT_ULL(seq)))
+			continue;
+
+		cfg_ctx->instance_cfg_fn(hdev, block_base + i * cfg_ctx->instance_off,
+					cfg_ctx->data);
+	}
+}
+
+static void gaudi2_init_blocks_with_mask(struct hl_device *hdev, struct dup_block_ctx *cfg_ctx,
+						u64 mask)
+{
+	int i;
+
+	cfg_ctx->enabled_mask = mask;
+
+	for (i = 0 ; i < cfg_ctx->blocks ; i++)
+		gaudi2_init_block_instances(hdev, i, cfg_ctx);
+}
+
+void gaudi2_init_blocks(struct hl_device *hdev, struct dup_block_ctx *cfg_ctx)
+{
+	gaudi2_init_blocks_with_mask(hdev, cfg_ctx, U64_MAX);
+}
+
+static int gaudi2_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size, void *blob_addr)
+{
+	void *host_mem_virtual_addr;
+	dma_addr_t host_mem_dma_addr;
+	u64 reserved_va_base;
+	u32 pos, size_left, size_to_dma;
+	struct hl_ctx *ctx;
+	int rc = 0;
+
+	/* Fetch the ctx */
+	ctx = hl_get_compute_ctx(hdev);
+	if (!ctx) {
+		dev_err(hdev->dev, "No ctx available\n");
+		return -EINVAL;
+	}
+
+	/* Allocate buffers for read and for poll */
+	host_mem_virtual_addr = hl_asic_dma_alloc_coherent(hdev, SZ_2M, &host_mem_dma_addr,
+								GFP_KERNEL | __GFP_ZERO);
+	if (host_mem_virtual_addr == NULL) {
+		dev_err(hdev->dev, "Failed to allocate memory for KDMA read\n");
+		rc = -ENOMEM;
+		goto put_ctx;
+	}
+
+	/* Reserve VM region on asic side */
+	reserved_va_base = hl_reserve_va_block(hdev, ctx, HL_VA_RANGE_TYPE_HOST, SZ_2M,
+						HL_MMU_VA_ALIGNMENT_NOT_NEEDED);
+	if (!reserved_va_base) {
+		dev_err(hdev->dev, "Failed to reserve vmem on asic\n");
+		rc = -ENOMEM;
+		goto free_data_buffer;
+	}
+
+	/* Create mapping on asic side */
+	mutex_lock(&ctx->mmu_lock);
+	rc = hl_mmu_map_contiguous(ctx, reserved_va_base, host_mem_dma_addr, SZ_2M);
+	hl_mmu_invalidate_cache_range(hdev, false,
+				      MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV,
+				      ctx->asid, reserved_va_base, SZ_2M);
+	mutex_unlock(&ctx->mmu_lock);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to create mapping on asic mmu\n");
+		goto unreserve_va;
+	}
+
+	hdev->asic_funcs->kdma_lock(hdev, 0);
+
+	/* Enable MMU on KDMA */
+	gaudi2_kdma_set_mmbp_asid(hdev, false, ctx->asid);
+
+	pos = 0;
+	size_left = size;
+	size_to_dma = SZ_2M;
+
+	while (size_left > 0) {
+		if (size_left < SZ_2M)
+			size_to_dma = size_left;
+
+		rc = gaudi2_send_job_to_kdma(hdev, addr, reserved_va_base, size_to_dma, false);
+		if (rc)
+			break;
+
+		memcpy(blob_addr + pos, host_mem_virtual_addr, size_to_dma);
+
+		if (size_left <= SZ_2M)
+			break;
+
+		pos += SZ_2M;
+		addr += SZ_2M;
+		size_left -= SZ_2M;
+	}
+
+	gaudi2_kdma_set_mmbp_asid(hdev, true, HL_KERNEL_ASID_ID);
+
+	hdev->asic_funcs->kdma_unlock(hdev, 0);
+
+	mutex_lock(&ctx->mmu_lock);
+	hl_mmu_unmap_contiguous(ctx, reserved_va_base, SZ_2M);
+	hl_mmu_invalidate_cache_range(hdev, false, MMU_OP_USERPTR,
+				      ctx->asid, reserved_va_base, SZ_2M);
+	mutex_unlock(&ctx->mmu_lock);
+unreserve_va:
+	hl_unreserve_va_block(hdev, ctx, reserved_va_base, SZ_2M);
+free_data_buffer:
+	hl_asic_dma_free_coherent(hdev, SZ_2M, host_mem_virtual_addr, host_mem_dma_addr);
+put_ctx:
+	hl_ctx_put(ctx);
+
+	return rc;
+}
+
+static int gaudi2_internal_cb_pool_init(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int min_alloc_order, rc;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_PMMU))
+		return 0;
+
+	hdev->internal_cb_pool_virt_addr = hl_asic_dma_alloc_coherent(hdev,
+								HOST_SPACE_INTERNAL_CB_SZ,
+								&hdev->internal_cb_pool_dma_addr,
+								GFP_KERNEL | __GFP_ZERO);
+
+	if (!hdev->internal_cb_pool_virt_addr)
+		return -ENOMEM;
+
+	min_alloc_order = ilog2(min(gaudi2_get_signal_cb_size(hdev),
+					gaudi2_get_wait_cb_size(hdev)));
+
+	hdev->internal_cb_pool = gen_pool_create(min_alloc_order, -1);
+	if (!hdev->internal_cb_pool) {
+		dev_err(hdev->dev, "Failed to create internal CB pool\n");
+		rc = -ENOMEM;
+		goto free_internal_cb_pool;
+	}
+
+	rc = gen_pool_add(hdev->internal_cb_pool, (uintptr_t) hdev->internal_cb_pool_virt_addr,
+				HOST_SPACE_INTERNAL_CB_SZ, -1);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to add memory to internal CB pool\n");
+		rc = -EFAULT;
+		goto destroy_internal_cb_pool;
+	}
+
+	hdev->internal_cb_va_base = hl_reserve_va_block(hdev, ctx, HL_VA_RANGE_TYPE_HOST,
+					HOST_SPACE_INTERNAL_CB_SZ, HL_MMU_VA_ALIGNMENT_NOT_NEEDED);
+
+	if (!hdev->internal_cb_va_base) {
+		rc = -ENOMEM;
+		goto destroy_internal_cb_pool;
+	}
+
+	mutex_lock(&ctx->mmu_lock);
+	rc = hl_mmu_map_contiguous(ctx, hdev->internal_cb_va_base, hdev->internal_cb_pool_dma_addr,
+					HOST_SPACE_INTERNAL_CB_SZ);
+	hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
+	mutex_unlock(&ctx->mmu_lock);
+
+	if (rc)
+		goto unreserve_internal_cb_pool;
+
+	return 0;
+
+unreserve_internal_cb_pool:
+	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base, HOST_SPACE_INTERNAL_CB_SZ);
+destroy_internal_cb_pool:
+	gen_pool_destroy(hdev->internal_cb_pool);
+free_internal_cb_pool:
+	hl_asic_dma_free_coherent(hdev, HOST_SPACE_INTERNAL_CB_SZ, hdev->internal_cb_pool_virt_addr,
+					hdev->internal_cb_pool_dma_addr);
+
+	return rc;
+}
+
+static void gaudi2_internal_cb_pool_fini(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_PMMU))
+		return;
+
+	mutex_lock(&ctx->mmu_lock);
+	hl_mmu_unmap_contiguous(ctx, hdev->internal_cb_va_base, HOST_SPACE_INTERNAL_CB_SZ);
+	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base, HOST_SPACE_INTERNAL_CB_SZ);
+	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
+	mutex_unlock(&ctx->mmu_lock);
+
+	gen_pool_destroy(hdev->internal_cb_pool);
+
+	hl_asic_dma_free_coherent(hdev, HOST_SPACE_INTERNAL_CB_SZ, hdev->internal_cb_pool_virt_addr,
+					hdev->internal_cb_pool_dma_addr);
+}
+
+static void gaudi2_restore_user_registers(struct hl_device *hdev)
+{
+	gaudi2_restore_user_sm_registers(hdev);
+	gaudi2_restore_user_qm_registers(hdev);
+}
+
+static int gaudi2_ctx_init(struct hl_ctx *ctx)
+{
+	int rc;
+
+	rc = gaudi2_mmu_prepare(ctx->hdev, ctx->asid);
+	if (rc)
+		return rc;
+
+	/* No need to clear user registers if the device has just
+	 * performed reset, we restore only nic qm registers
+	 */
+	if (ctx->hdev->reset_upon_device_release)
+		gaudi2_restore_nic_qm_registers(ctx->hdev);
+	else
+		gaudi2_restore_user_registers(ctx->hdev);
+
+	return gaudi2_internal_cb_pool_init(ctx->hdev, ctx);
+}
+
+static void gaudi2_ctx_fini(struct hl_ctx *ctx)
+{
+	if (ctx->asid == HL_KERNEL_ASID_ID)
+		return;
+
+	gaudi2_internal_cb_pool_fini(ctx->hdev, ctx);
+}
+
+static int gaudi2_pre_schedule_cs(struct hl_cs *cs)
+{
+	struct hl_device *hdev = cs->ctx->hdev;
+	int index = cs->sequence & (hdev->asic_prop.max_pending_cs - 1);
+	u32 mon_payload;
+
+	if (!cs_needs_completion(cs))
+		return 0;
+
+	/*
+	 * First 1024 SOB/MON are reserved for driver for QMAN auto completion
+	 * mechanism. Each SOB/MON pair are used for a pending CS with the same
+	 * cyclic index. The SOB value is increased when each of the CS jobs is
+	 * completed. When the SOB reaches the number of CS jobs, the monitor
+	 * generates MSI-X interrupt.
+	 */
+
+	mon_payload = (1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT) |
+				(1 << CQ_ENTRY_READY_SHIFT) | index;
+
+	gaudi2_arm_cq_monitor(hdev, index, GAUDI2_RESERVED_CQ_COMPLETION,
+						mon_payload, cs->jobs_cnt);
+
+	return 0;
+}
+
+static u32 gaudi2_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
+{
+	return HL_INVALID_QUEUE;
+}
+
+static u32 gaudi2_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id, u32 size, bool eb)
+{
+	struct hl_cb *cb = (struct hl_cb *) data;
+	struct packet_msg_short *pkt;
+	u32 value, ctl, pkt_size = sizeof(*pkt);
+
+	pkt = (struct packet_msg_short *) (uintptr_t) (cb->kernel_address + size);
+	memset(pkt, 0, pkt_size);
+
+	/* Inc by 1, Mode ADD */
+	value = FIELD_PREP(GAUDI2_PKT_SHORT_VAL_SOB_SYNC_VAL_MASK, 1);
+	value |= FIELD_PREP(GAUDI2_PKT_SHORT_VAL_SOB_MOD_MASK, 1);
+
+	ctl = FIELD_PREP(GAUDI2_PKT_SHORT_CTL_ADDR_MASK, sob_id * 4);
+	ctl |= FIELD_PREP(GAUDI2_PKT_SHORT_CTL_BASE_MASK, 1); /* SOB base */
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_EB_MASK, eb);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_MB_MASK, 1);
+
+	pkt->value = cpu_to_le32(value);
+	pkt->ctl = cpu_to_le32(ctl);
+
+	return size + pkt_size;
+}
+
+static u32 gaudi2_add_mon_msg_short(struct packet_msg_short *pkt, u32 value, u16 addr)
+{
+	u32 ctl, pkt_size = sizeof(*pkt);
+
+	memset(pkt, 0, pkt_size);
+
+	ctl = FIELD_PREP(GAUDI2_PKT_SHORT_CTL_ADDR_MASK, addr);
+	ctl |= FIELD_PREP(GAUDI2_PKT_SHORT_CTL_BASE_MASK, 0);  /* MON base */
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_MB_MASK, 0);
+
+	pkt->value = cpu_to_le32(value);
+	pkt->ctl = cpu_to_le32(ctl);
+
+	return pkt_size;
+}
+
+static u32 gaudi2_add_arm_monitor_pkt(struct hl_device *hdev, struct packet_msg_short *pkt,
+					u16 sob_base, u8 sob_mask, u16 sob_val, u16 addr)
+{
+	u32 ctl, value, pkt_size = sizeof(*pkt);
+	u8 mask;
+
+	if (hl_gen_sob_mask(sob_base, sob_mask, &mask)) {
+		dev_err(hdev->dev, "sob_base %u (mask %#x) is not valid\n", sob_base, sob_mask);
+		return 0;
+	}
+
+	memset(pkt, 0, pkt_size);
+
+	value = FIELD_PREP(GAUDI2_PKT_SHORT_VAL_MON_SYNC_GID_MASK, sob_base / 8);
+	value |= FIELD_PREP(GAUDI2_PKT_SHORT_VAL_MON_SYNC_VAL_MASK, sob_val);
+	value |= FIELD_PREP(GAUDI2_PKT_SHORT_VAL_MON_MODE_MASK, 0); /* GREATER OR EQUAL*/
+	value |= FIELD_PREP(GAUDI2_PKT_SHORT_VAL_MON_MASK_MASK, mask);
+
+	ctl = FIELD_PREP(GAUDI2_PKT_SHORT_CTL_ADDR_MASK, addr);
+	ctl |= FIELD_PREP(GAUDI2_PKT_SHORT_CTL_BASE_MASK, 0); /* MON base */
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_MB_MASK, 1);
+
+	pkt->value = cpu_to_le32(value);
+	pkt->ctl = cpu_to_le32(ctl);
+
+	return pkt_size;
+}
+
+static u32 gaudi2_add_fence_pkt(struct packet_fence *pkt)
+{
+	u32 ctl, cfg, pkt_size = sizeof(*pkt);
+
+	memset(pkt, 0, pkt_size);
+
+	cfg = FIELD_PREP(GAUDI2_PKT_FENCE_CFG_DEC_VAL_MASK, 1);
+	cfg |= FIELD_PREP(GAUDI2_PKT_FENCE_CFG_TARGET_VAL_MASK, 1);
+	cfg |= FIELD_PREP(GAUDI2_PKT_FENCE_CFG_ID_MASK, 2);
+
+	ctl = FIELD_PREP(GAUDI2_PKT_CTL_OPCODE_MASK, PACKET_FENCE);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI2_PKT_CTL_MB_MASK, 1);
+
+	pkt->cfg = cpu_to_le32(cfg);
+	pkt->ctl = cpu_to_le32(ctl);
+
+	return pkt_size;
+}
+
+static u32 gaudi2_gen_wait_cb(struct hl_device *hdev, struct hl_gen_wait_properties *prop)
+{
+	struct hl_cb *cb = (struct hl_cb *) prop->data;
+	void *buf = (void *) (uintptr_t) (cb->kernel_address);
+
+	u64 monitor_base, fence_addr = 0;
+	u32 stream_index, size = prop->size;
+	u16 msg_addr_offset;
+
+	stream_index = prop->q_idx % 4;
+	fence_addr = CFG_BASE + gaudi2_qm_blocks_bases[prop->q_idx] +
+			QM_FENCE2_OFFSET + stream_index * 4;
+
+	/*
+	 * monitor_base should be the content of the base0 address registers,
+	 * so it will be added to the msg short offsets
+	 */
+	monitor_base = mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0;
+
+	/* First monitor config packet: low address of the sync */
+	msg_addr_offset = (mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + prop->mon_id * 4) -
+				monitor_base;
+
+	size += gaudi2_add_mon_msg_short(buf + size, (u32) fence_addr, msg_addr_offset);
+
+	/* Second monitor config packet: high address of the sync */
+	msg_addr_offset = (mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0 + prop->mon_id * 4) -
+				monitor_base;
+
+	size += gaudi2_add_mon_msg_short(buf + size, (u32) (fence_addr >> 32), msg_addr_offset);
+
+	/*
+	 * Third monitor config packet: the payload, i.e. what to write when the
+	 * sync triggers
+	 */
+	msg_addr_offset = (mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + prop->mon_id * 4) -
+				monitor_base;
+
+	size += gaudi2_add_mon_msg_short(buf + size, 1, msg_addr_offset);
+
+	/* Fourth monitor config packet: bind the monitor to a sync object */
+	msg_addr_offset = (mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + prop->mon_id * 4) - monitor_base;
+
+	size += gaudi2_add_arm_monitor_pkt(hdev, buf + size, prop->sob_base, prop->sob_mask,
+						prop->sob_val, msg_addr_offset);
+
+	/* Fence packet */
+	size += gaudi2_add_fence_pkt(buf + size);
+
+	return size;
+}
+
+static void gaudi2_reset_sob(struct hl_device *hdev, void *data)
+{
+	struct hl_hw_sob *hw_sob = (struct hl_hw_sob *) data;
+
+	dev_dbg(hdev->dev, "reset SOB, q_idx: %d, sob_id: %d\n", hw_sob->q_idx, hw_sob->sob_id);
+
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + hw_sob->sob_id * 4, 0);
+
+	kref_init(&hw_sob->kref);
+}
+
+static void gaudi2_reset_sob_group(struct hl_device *hdev, u16 sob_group)
+{
+}
+
+static u64 gaudi2_get_device_time(struct hl_device *hdev)
+{
+	u64 device_time = ((u64) RREG32(mmPSOC_TIMESTAMP_CNTCVU)) << 32;
+
+	return device_time | RREG32(mmPSOC_TIMESTAMP_CNTCVL);
+}
+
+static int gaudi2_collective_wait_init_cs(struct hl_cs *cs)
+{
+	return 0;
+}
+
+static int gaudi2_collective_wait_create_jobs(struct hl_device *hdev, struct hl_ctx *ctx,
+					struct hl_cs *cs, u32 wait_queue_id,
+					u32 collective_engine_id, u32 encaps_signal_offset)
+{
+	return -EINVAL;
+}
+
+/*
+ * hl_mmu_scramble - converts a dram (non power of 2) page-size aligned address
+ *                   to DMMU page-size address (64MB) before mapping it in
+ *                   the MMU.
+ * The operation is performed on both the virtual and physical addresses.
+ * for device with 6 HBMs the scramble is:
+ * (addr[47:0] / 48M) * 64M + addr % 48M + addr[63:48]
+ *
+ * Example:
+ * =============================================================================
+ * Allocated DRAM  Reserved VA      scrambled VA for MMU mapping    Scrambled PA
+ * Phys address                                                     in MMU last
+ *                                                                    HOP
+ * =============================================================================
+ * PA1 0x3000000  VA1 0x9C000000  SVA1= (VA1/48M)*64M 0xD0000000  <- PA1/48M 0x1
+ * PA2 0x9000000  VA2 0x9F000000  SVA2= (VA2/48M)*64M 0xD4000000  <- PA2/48M 0x3
+ * =============================================================================
+ */
+static u64 gaudi2_mmu_scramble_addr(struct hl_device *hdev, u64 raw_addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 divisor, mod_va;
+	u64 div_va;
+
+	/* accept any address in the DRAM address space */
+	if (hl_mem_area_inside_range(raw_addr, sizeof(raw_addr), DRAM_PHYS_BASE,
+									VA_HBM_SPACE_END)) {
+
+		divisor = prop->num_functional_hbms * GAUDI2_HBM_MMU_SCRM_MEM_SIZE;
+		div_va = div_u64_rem(raw_addr & GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK, divisor, &mod_va);
+		return (raw_addr & ~GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK) |
+			(div_va << GAUDI2_HBM_MMU_SCRM_DIV_SHIFT) |
+			(mod_va << GAUDI2_HBM_MMU_SCRM_MOD_SHIFT);
+	}
+
+	return raw_addr;
+}
+
+static u64 gaudi2_mmu_descramble_addr(struct hl_device *hdev, u64 scrambled_addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 divisor, mod_va;
+	u64 div_va;
+
+	/* accept any address in the DRAM address space */
+	if (hl_mem_area_inside_range(scrambled_addr, sizeof(scrambled_addr), DRAM_PHYS_BASE,
+									VA_HBM_SPACE_END)) {
+
+		divisor = prop->num_functional_hbms * GAUDI2_HBM_MMU_SCRM_MEM_SIZE;
+		div_va = div_u64_rem(scrambled_addr & GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK,
+					PAGE_SIZE_64MB, &mod_va);
+
+		return ((scrambled_addr & ~GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK) +
+					(div_va * divisor + mod_va));
+	}
+
+	return scrambled_addr;
+}
+
+static u32 gaudi2_get_dec_base_addr(struct hl_device *hdev, u32 core_id)
+{
+	u32 base = 0, dcore_id, dec_id;
+
+	if (core_id >= NUMBER_OF_DEC) {
+		dev_err(hdev->dev, "Unexpected core number %d for DEC\n", core_id);
+		goto out;
+	}
+
+	if (core_id < 8) {
+		dcore_id = core_id / NUM_OF_DEC_PER_DCORE;
+		dec_id = core_id % NUM_OF_DEC_PER_DCORE;
+
+		base = mmDCORE0_DEC0_CMD_BASE + dcore_id * DCORE_OFFSET +
+				dec_id * DCORE_VDEC_OFFSET;
+	} else {
+		/* PCIe Shared Decoder */
+		base = mmPCIE_DEC0_CMD_BASE + ((core_id % 8) * PCIE_VDEC_OFFSET);
+	}
+out:
+	return base;
+}
+
+static int gaudi2_get_hw_block_id(struct hl_device *hdev, u64 block_addr,
+				u32 *block_size, u32 *block_id)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int i;
+
+	for (i = 0 ; i < NUM_USER_MAPPED_BLOCKS ; i++) {
+		if (block_addr == CFG_BASE + gaudi2->mapped_blocks[i].address) {
+			*block_id = i;
+			if (block_size)
+				*block_size = gaudi2->mapped_blocks[i].size;
+			return 0;
+		}
+	}
+
+	dev_err(hdev->dev, "Invalid block address %#llx", block_addr);
+
+	return -EINVAL;
+}
+
+static int gaudi2_block_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+			u32 block_id, u32 block_size)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u64 offset_in_bar;
+	u64 address;
+	int rc;
+
+	if (block_id >= NUM_USER_MAPPED_BLOCKS) {
+		dev_err(hdev->dev, "Invalid block id %u", block_id);
+		return -EINVAL;
+	}
+
+	/* we allow mapping only an entire block */
+	if (block_size != gaudi2->mapped_blocks[block_id].size) {
+		dev_err(hdev->dev, "Invalid block size %u", block_size);
+		return -EINVAL;
+	}
+
+	offset_in_bar = CFG_BASE + gaudi2->mapped_blocks[block_id].address - STM_FLASH_BASE_ADDR;
+
+	address = pci_resource_start(hdev->pdev, SRAM_CFG_BAR_ID) + offset_in_bar;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
+			VM_DONTCOPY | VM_NORESERVE;
+
+	rc = remap_pfn_range(vma, vma->vm_start, address >> PAGE_SHIFT,
+			block_size, vma->vm_page_prot);
+	if (rc)
+		dev_err(hdev->dev, "remap_pfn_range error %d", rc);
+
+	return rc;
+}
+
+static void gaudi2_enable_events_from_fw(struct hl_device *hdev)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	struct cpu_dyn_regs *dyn_regs = &hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+	u32 irq_handler_offset = le32_to_cpu(dyn_regs->gic_host_ints_irq);
+
+	if (gaudi2->hw_cap_initialized & HW_CAP_CPU_Q)
+		WREG32(irq_handler_offset,
+			gaudi2_irq_map_table[GAUDI2_EVENT_CPU_INTS_REGISTER].cpu_id);
+}
+
+static int gaudi2_get_mmu_base(struct hl_device *hdev, u64 mmu_id, u32 *mmu_base)
+{
+	switch (mmu_id) {
+	case HW_CAP_DCORE0_DMMU0:
+		*mmu_base = mmDCORE0_HMMU0_MMU_BASE;
+		break;
+	case HW_CAP_DCORE0_DMMU1:
+		*mmu_base = mmDCORE0_HMMU1_MMU_BASE;
+		break;
+	case HW_CAP_DCORE0_DMMU2:
+		*mmu_base = mmDCORE0_HMMU2_MMU_BASE;
+		break;
+	case HW_CAP_DCORE0_DMMU3:
+		*mmu_base = mmDCORE0_HMMU3_MMU_BASE;
+		break;
+	case HW_CAP_DCORE1_DMMU0:
+		*mmu_base = mmDCORE1_HMMU0_MMU_BASE;
+		break;
+	case HW_CAP_DCORE1_DMMU1:
+		*mmu_base = mmDCORE1_HMMU1_MMU_BASE;
+		break;
+	case HW_CAP_DCORE1_DMMU2:
+		*mmu_base = mmDCORE1_HMMU2_MMU_BASE;
+		break;
+	case HW_CAP_DCORE1_DMMU3:
+		*mmu_base = mmDCORE1_HMMU3_MMU_BASE;
+		break;
+	case HW_CAP_DCORE2_DMMU0:
+		*mmu_base = mmDCORE2_HMMU0_MMU_BASE;
+		break;
+	case HW_CAP_DCORE2_DMMU1:
+		*mmu_base = mmDCORE2_HMMU1_MMU_BASE;
+		break;
+	case HW_CAP_DCORE2_DMMU2:
+		*mmu_base = mmDCORE2_HMMU2_MMU_BASE;
+		break;
+	case HW_CAP_DCORE2_DMMU3:
+		*mmu_base = mmDCORE2_HMMU3_MMU_BASE;
+		break;
+	case HW_CAP_DCORE3_DMMU0:
+		*mmu_base = mmDCORE3_HMMU0_MMU_BASE;
+		break;
+	case HW_CAP_DCORE3_DMMU1:
+		*mmu_base = mmDCORE3_HMMU1_MMU_BASE;
+		break;
+	case HW_CAP_DCORE3_DMMU2:
+		*mmu_base = mmDCORE3_HMMU2_MMU_BASE;
+		break;
+	case HW_CAP_DCORE3_DMMU3:
+		*mmu_base = mmDCORE3_HMMU3_MMU_BASE;
+		break;
+	case HW_CAP_PMMU:
+		*mmu_base = mmPMMU_HBW_MMU_BASE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void gaudi2_ack_mmu_error(struct hl_device *hdev, u64 mmu_id)
+{
+	bool is_pmmu = (mmu_id == HW_CAP_PMMU ? true : false);
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u32 mmu_base;
+
+	if (!(gaudi2->hw_cap_initialized & mmu_id))
+		return;
+
+	if (gaudi2_get_mmu_base(hdev, mmu_id, &mmu_base))
+		return;
+
+	gaudi2_handle_page_error(hdev, mmu_base, is_pmmu);
+	gaudi2_handle_access_error(hdev, mmu_base, is_pmmu);
+}
+
+static int gaudi2_ack_mmu_page_fault_or_access_error(struct hl_device *hdev, u64 mmu_cap_mask)
+{
+	u32 i, mmu_id, num_of_hmmus = NUM_OF_HMMU_PER_DCORE * NUM_OF_DCORES;
+
+	/* check all HMMUs */
+	for (i = 0 ; i < num_of_hmmus ; i++) {
+		mmu_id = HW_CAP_DCORE0_DMMU0 << i;
+
+		if (mmu_cap_mask & mmu_id)
+			gaudi2_ack_mmu_error(hdev, mmu_id);
+	}
+
+	/* check PMMU */
+	if (mmu_cap_mask & HW_CAP_PMMU)
+		gaudi2_ack_mmu_error(hdev, HW_CAP_PMMU);
+
+	return 0;
+}
+
+static void gaudi2_get_msi_info(__le32 *table)
+{
+	table[CPUCP_EVENT_QUEUE_MSI_TYPE] = cpu_to_le32(GAUDI2_EVENT_QUEUE_MSIX_IDX);
+}
+
+static int gaudi2_map_pll_idx_to_fw_idx(u32 pll_idx)
+{
+	switch (pll_idx) {
+	case HL_GAUDI2_CPU_PLL: return CPU_PLL;
+	case HL_GAUDI2_PCI_PLL: return PCI_PLL;
+	case HL_GAUDI2_NIC_PLL: return NIC_PLL;
+	case HL_GAUDI2_DMA_PLL: return DMA_PLL;
+	case HL_GAUDI2_MESH_PLL: return MESH_PLL;
+	case HL_GAUDI2_MME_PLL: return MME_PLL;
+	case HL_GAUDI2_TPC_PLL: return TPC_PLL;
+	case HL_GAUDI2_IF_PLL: return IF_PLL;
+	case HL_GAUDI2_SRAM_PLL: return SRAM_PLL;
+	case HL_GAUDI2_HBM_PLL: return HBM_PLL;
+	case HL_GAUDI2_VID_PLL: return VID_PLL;
+	case HL_GAUDI2_MSS_PLL: return MSS_PLL;
+	default: return -EINVAL;
+	}
+}
+
+static int gaudi2_gen_sync_to_engine_map(struct hl_device *hdev, struct hl_sync_to_engine_map *map)
+{
+	/* Not implemented */
+	return 0;
+}
+
+static int gaudi2_monitor_valid(struct hl_mon_state_dump *mon)
+{
+	/* Not implemented */
+	return 0;
+}
+
+static int gaudi2_print_single_monitor(char **buf, size_t *size, size_t *offset,
+				struct hl_device *hdev, struct hl_mon_state_dump *mon)
+{
+	/* Not implemented */
+	return 0;
+}
+
+
+static int gaudi2_print_fences_single_engine(struct hl_device *hdev, u64 base_offset,
+				u64 status_base_offset, enum hl_sync_engine_type engine_type,
+				u32 engine_id, char **buf, size_t *size, size_t *offset)
+{
+	/* Not implemented */
+	return 0;
+}
+
+
+static struct hl_state_dump_specs_funcs gaudi2_state_dump_funcs = {
+	.monitor_valid = gaudi2_monitor_valid,
+	.print_single_monitor = gaudi2_print_single_monitor,
+	.gen_sync_to_engine_map = gaudi2_gen_sync_to_engine_map,
+	.print_fences_single_engine = gaudi2_print_fences_single_engine,
+};
+
+static void gaudi2_state_dump_init(struct hl_device *hdev)
+{
+	/* Not implemented */
+	hdev->state_dump_specs.props = gaudi2_state_dump_specs_props;
+	hdev->state_dump_specs.funcs = gaudi2_state_dump_funcs;
+}
+
+static u32 gaudi2_get_sob_addr(struct hl_device *hdev, u32 sob_id)
+{
+	return 0;
+}
+
+static u32 *gaudi2_get_stream_master_qid_arr(void)
+{
+	return NULL;
+}
+
+static void gaudi2_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
+				struct attribute_group *dev_vrm_attr_grp)
+{
+	hl_sysfs_add_dev_clk_attr(hdev, dev_clk_attr_grp);
+	hl_sysfs_add_dev_vrm_attr(hdev, dev_vrm_attr_grp);
+}
+
+static int gaudi2_mmu_get_real_page_size(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
+					u32 page_size, u32 *real_page_size, bool is_dram_addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/* for host pages the page size must be  */
+	if (!is_dram_addr) {
+		if (page_size % mmu_prop->page_size)
+			goto page_size_err;
+
+		*real_page_size = mmu_prop->page_size;
+		return 0;
+	}
+
+	if ((page_size % prop->dram_page_size) || (prop->dram_page_size > mmu_prop->page_size))
+		goto page_size_err;
+
+	/*
+	 * MMU page size is different from DRAM page size (more precisely, DMMU page is greater
+	 * than DRAM page size).
+	 * for this reason work with the DRAM page size and let the MMU scrambling routine handle
+	 * this mismatch when calculating the address to place in the MMU page table.
+	 * (in that case also make sure that the dram_page_size is not greater than the
+	 * mmu page size)
+	 */
+	*real_page_size = prop->dram_page_size;
+
+	return 0;
+
+page_size_err:
+	dev_err(hdev->dev, "page size of %u is not %uKB aligned, can't map\n",
+							page_size, mmu_prop->page_size >> 10);
+	return -EFAULT;
+}
+
+static int gaudi2_get_monitor_dump(struct hl_device *hdev, void *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct hl_asic_funcs gaudi2_funcs = {
+	.early_init = gaudi2_early_init,
+	.early_fini = gaudi2_early_fini,
+	.late_init = gaudi2_late_init,
+	.late_fini = gaudi2_late_fini,
+	.sw_init = gaudi2_sw_init,
+	.sw_fini = gaudi2_sw_fini,
+	.hw_init = gaudi2_hw_init,
+	.hw_fini = gaudi2_hw_fini,
+	.halt_engines = gaudi2_halt_engines,
+	.suspend = gaudi2_suspend,
+	.resume = gaudi2_resume,
+	.mmap = gaudi2_mmap,
+	.ring_doorbell = gaudi2_ring_doorbell,
+	.pqe_write = gaudi2_pqe_write,
+	.asic_dma_alloc_coherent = gaudi2_dma_alloc_coherent,
+	.asic_dma_free_coherent = gaudi2_dma_free_coherent,
+	.scrub_device_mem = gaudi2_scrub_device_mem,
+	.scrub_device_dram = gaudi2_scrub_device_dram,
+	.get_int_queue_base = NULL,
+	.test_queues = gaudi2_test_queues,
+	.asic_dma_pool_zalloc = gaudi2_dma_pool_zalloc,
+	.asic_dma_pool_free = gaudi2_dma_pool_free,
+	.cpu_accessible_dma_pool_alloc = gaudi2_cpu_accessible_dma_pool_alloc,
+	.cpu_accessible_dma_pool_free = gaudi2_cpu_accessible_dma_pool_free,
+	.asic_dma_unmap_single = gaudi2_dma_unmap_single,
+	.asic_dma_map_single = gaudi2_dma_map_single,
+	.hl_dma_unmap_sgtable = hl_dma_unmap_sgtable,
+	.cs_parser = gaudi2_cs_parser,
+	.asic_dma_map_sgtable = hl_dma_map_sgtable,
+	.add_end_of_cb_packets = NULL,
+	.update_eq_ci = gaudi2_update_eq_ci,
+	.context_switch = gaudi2_context_switch,
+	.restore_phase_topology = gaudi2_restore_phase_topology,
+	.debugfs_read_dma = gaudi2_debugfs_read_dma,
+	.add_device_attr = gaudi2_add_device_attr,
+	.handle_eqe = gaudi2_handle_eqe,
+	.get_events_stat = gaudi2_get_events_stat,
+	.read_pte = NULL,
+	.write_pte = NULL,
+	.mmu_invalidate_cache = gaudi2_mmu_invalidate_cache,
+	.mmu_invalidate_cache_range = gaudi2_mmu_invalidate_cache_range,
+	.mmu_prefetch_cache_range = NULL,
+	.send_heartbeat = gaudi2_send_heartbeat,
+	.debug_coresight = NULL,
+	.is_device_idle = gaudi2_is_device_idle,
+	.non_hard_reset_late_init = gaudi2_non_hard_reset_late_init,
+	.hw_queues_lock = gaudi2_hw_queues_lock,
+	.hw_queues_unlock = gaudi2_hw_queues_unlock,
+	.kdma_lock = gaudi2_kdma_lock,
+	.kdma_unlock = gaudi2_kdma_unlock,
+	.get_pci_id = gaudi2_get_pci_id,
+	.get_eeprom_data = gaudi2_get_eeprom_data,
+	.get_monitor_dump = gaudi2_get_monitor_dump,
+	.send_cpu_message = gaudi2_send_cpu_message,
+	.pci_bars_map = gaudi2_pci_bars_map,
+	.init_iatu = gaudi2_init_iatu,
+	.rreg = hl_rreg,
+	.wreg = hl_wreg,
+	.halt_coresight = NULL,
+	.ctx_init = gaudi2_ctx_init,
+	.ctx_fini = gaudi2_ctx_fini,
+	.pre_schedule_cs = gaudi2_pre_schedule_cs,
+	.get_queue_id_for_cq = gaudi2_get_queue_id_for_cq,
+	.load_firmware_to_device = NULL,
+	.load_boot_fit_to_device = NULL,
+	.get_signal_cb_size = gaudi2_get_signal_cb_size,
+	.get_wait_cb_size = gaudi2_get_wait_cb_size,
+	.gen_signal_cb = gaudi2_gen_signal_cb,
+	.gen_wait_cb = gaudi2_gen_wait_cb,
+	.reset_sob = gaudi2_reset_sob,
+	.reset_sob_group = gaudi2_reset_sob_group,
+	.get_device_time = gaudi2_get_device_time,
+	.pb_print_security_errors = NULL,
+	.collective_wait_init_cs = gaudi2_collective_wait_init_cs,
+	.collective_wait_create_jobs = gaudi2_collective_wait_create_jobs,
+	.get_dec_base_addr = gaudi2_get_dec_base_addr,
+	.scramble_addr = gaudi2_mmu_scramble_addr,
+	.descramble_addr = gaudi2_mmu_descramble_addr,
+	.get_hw_block_id = gaudi2_get_hw_block_id,
+	.hw_block_mmap = gaudi2_block_mmap,
+	.enable_events_from_fw = gaudi2_enable_events_from_fw,
+	.ack_mmu_errors = gaudi2_ack_mmu_page_fault_or_access_error,
+	.get_msi_info = gaudi2_get_msi_info,
+	.map_pll_idx_to_fw_idx = gaudi2_map_pll_idx_to_fw_idx,
+	.init_firmware_loader = gaudi2_init_firmware_loader,
+	.init_cpu_scrambler_dram = gaudi2_init_scrambler_hbm,
+	.state_dump_init = gaudi2_state_dump_init,
+	.get_sob_addr = &gaudi2_get_sob_addr,
+	.set_pci_memory_regions = gaudi2_set_pci_memory_regions,
+	.get_stream_master_qid_arr = gaudi2_get_stream_master_qid_arr,
+	.check_if_razwi_happened = gaudi2_check_if_razwi_happened,
+	.mmu_get_real_page_size = gaudi2_mmu_get_real_page_size,
+	.access_dev_mem = hl_access_dev_mem,
+	.set_dram_bar_base = gaudi2_set_hbm_bar_base,
+};
+
+void gaudi2_set_asic_funcs(struct hl_device *hdev)
+{
+	hdev->asic_funcs = &gaudi2_funcs;
+}
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
new file mode 100644
index 000000000000..e5ba1fdac61a
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -0,0 +1,534 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2020-2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GAUDI2P_H_
+#define GAUDI2P_H_
+
+#include <uapi/misc/habanalabs.h>
+#include "../common/habanalabs.h"
+#include "../include/common/hl_boot_if.h"
+#include "../include/gaudi2/gaudi2.h"
+#include "../include/gaudi2/gaudi2_packets.h"
+#include "../include/gaudi2/gaudi2_fw_if.h"
+#include "../include/gaudi2/gaudi2_async_events.h"
+#include "../include/gaudi2/gaudi2_async_virt_events.h"
+
+#define GAUDI2_LINUX_FW_FILE	"habanalabs/gaudi2/gaudi2-fit.itb"
+#define GAUDI2_BOOT_FIT_FILE	"habanalabs/gaudi2/gaudi2-boot-fit.itb"
+
+#define MMU_PAGE_TABLES_INITIAL_SIZE	0x10000000	/* 256MB */
+
+#define GAUDI2_CPU_TIMEOUT_USEC		30000000	/* 30s */
+
+#define GAUDI2_FPGA_CPU_TIMEOUT		100000000	/* 100s */
+
+#define NUMBER_OF_PDMA_QUEUES		2
+#define NUMBER_OF_EDMA_QUEUES		8
+#define NUMBER_OF_MME_QUEUES		4
+#define NUMBER_OF_TPC_QUEUES		25
+#define NUMBER_OF_NIC_QUEUES		24
+#define NUMBER_OF_ROT_QUEUES		2
+#define NUMBER_OF_CPU_QUEUES		1
+
+#define NUMBER_OF_HW_QUEUES		((NUMBER_OF_PDMA_QUEUES + \
+					NUMBER_OF_EDMA_QUEUES + \
+					NUMBER_OF_MME_QUEUES + \
+					NUMBER_OF_TPC_QUEUES + \
+					NUMBER_OF_NIC_QUEUES + \
+					NUMBER_OF_ROT_QUEUES + \
+					NUMBER_OF_CPU_QUEUES) * \
+					NUM_OF_PQ_PER_QMAN)
+
+#define NUMBER_OF_QUEUES		(NUMBER_OF_CPU_QUEUES + NUMBER_OF_HW_QUEUES)
+
+#define DCORE_NUM_OF_SOB		\
+	(((mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_8191 - \
+	mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0) + 4) >> 2)
+
+#define DCORE_NUM_OF_MONITORS		\
+	(((mmDCORE0_SYNC_MNGR_OBJS_MON_STATUS_2047 - \
+	mmDCORE0_SYNC_MNGR_OBJS_MON_STATUS_0) + 4) >> 2)
+
+#define NUMBER_OF_DEC		((NUM_OF_DEC_PER_DCORE * NUM_OF_DCORES) + NUMBER_OF_PCIE_DEC)
+
+/* Map all arcs dccm + arc schedulers acp blocks */
+#define NUM_OF_USER_ACP_BLOCKS		(NUM_OF_SCHEDULER_ARC + 2)
+#define NUM_OF_USER_NIC_UMR_BLOCKS	15
+#define NUM_OF_EXPOSED_SM_BLOCKS	((NUM_OF_DCORES - 1) * 2)
+#define NUM_USER_MAPPED_BLOCKS \
+	(NUM_ARC_CPUS + NUM_OF_USER_ACP_BLOCKS + NUMBER_OF_DEC + \
+	NUM_OF_EXPOSED_SM_BLOCKS + \
+	(NIC_NUMBER_OF_ENGINES * NUM_OF_USER_NIC_UMR_BLOCKS))
+
+/* Within the user mapped array, decoder entries start post all the ARC related
+ * entries
+ */
+#define USR_MAPPED_BLK_DEC_START_IDX \
+	(NUM_ARC_CPUS + NUM_OF_USER_ACP_BLOCKS + \
+	(NIC_NUMBER_OF_ENGINES * NUM_OF_USER_NIC_UMR_BLOCKS))
+
+#define USR_MAPPED_BLK_SM_START_IDX \
+	(NUM_ARC_CPUS + NUM_OF_USER_ACP_BLOCKS + NUMBER_OF_DEC + \
+	(NIC_NUMBER_OF_ENGINES * NUM_OF_USER_NIC_UMR_BLOCKS))
+
+#define SM_OBJS_BLOCK_SIZE		(mmDCORE0_SYNC_MNGR_OBJS_SM_SEC_0 - \
+					 mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0)
+
+#define GAUDI2_MAX_PENDING_CS		64
+
+/* Sob/Mon per CS + Sob/Mon for KDMA completion */
+#define GAUDI2_RESERVED_SOBS		(GAUDI2_MAX_PENDING_CS + 1)
+#define GAUDI2_RESERVED_MONITORS	(GAUDI2_MAX_PENDING_CS + 1)
+#define GAUDI2_RESERVED_SOB_KDMA_COMP	(GAUDI2_MAX_PENDING_CS)
+#define GAUDI2_RESERVED_MON_KDMA_COMP	(GAUDI2_MAX_PENDING_CS)
+
+#if !IS_MAX_PENDING_CS_VALID(GAUDI2_MAX_PENDING_CS)
+#error "GAUDI2_MAX_PENDING_CS must be power of 2 and greater than 1"
+#endif
+
+#define CORESIGHT_TIMEOUT_USEC			100000		/* 100 ms */
+
+#define GAUDI2_PREBOOT_REQ_TIMEOUT_USEC		25000000	/* 25s */
+
+#define GAUDI2_BOOT_FIT_REQ_TIMEOUT_USEC	10000000	/* 10s */
+
+#define GAUDI2_NIC_CLK_FREQ			450000000ull	/* 450 MHz */
+
+#define DC_POWER_DEFAULT			60000		/* 60W */
+
+#define GAUDI2_HBM_NUM				6
+
+#define DMA_MAX_TRANSFER_SIZE			U32_MAX
+
+#define GAUDI2_DEFAULT_CARD_NAME		"HL225"
+
+#define QMAN_STREAMS				4
+#define PQ_FETCHER_CACHE_SIZE			8
+#define NUM_OF_MME_SBTE_PORTS			5
+#define NUM_OF_MME_WB_PORTS			2
+
+#define GAUDI2_ENGINE_ID_DCORE_OFFSET \
+	(GAUDI2_DCORE1_ENGINE_ID_EDMA_0 - GAUDI2_DCORE0_ENGINE_ID_EDMA_0)
+
+/* DRAM Memory Map */
+
+#define CPU_FW_IMAGE_SIZE			0x10000000	/* 256MB */
+
+/* This define should be used only when working in a debug mode without dram.
+ * When working with dram, the driver size will be calculated dynamically.
+ */
+#define NIC_DEFAULT_DRV_SIZE			0x20000000	/* 512MB */
+
+#define CPU_FW_IMAGE_ADDR			DRAM_PHYS_BASE
+
+#define NIC_NUMBER_OF_PORTS			NIC_NUMBER_OF_ENGINES
+
+#define NUMBER_OF_PCIE_DEC			2
+#define PCIE_DEC_SHIFT				8
+
+#define SRAM_USER_BASE_OFFSET			0
+
+/* cluster binning */
+#define MAX_FAULTY_HBMS				1
+#define GAUDI2_XBAR_EDGE_FULL_MASK		0xF
+#define GAUDI2_EDMA_FULL_MASK			0xFF
+#define GAUDI2_DRAM_FULL_MASK			0x3F
+
+/* Host virtual address space. */
+
+#define VA_HOST_SPACE_PAGE_START		0xFFF0000000000000ull
+#define VA_HOST_SPACE_PAGE_END			0xFFF0800000000000ull /* 140TB */
+
+#define VA_HOST_SPACE_HPAGE_START		0xFFF0800000000000ull
+#define VA_HOST_SPACE_HPAGE_END			0xFFF1000000000000ull /* 140TB */
+
+#define VA_HOST_SPACE_USER_MAPPED_CB_START	0xFFF1000000000000ull
+#define VA_HOST_SPACE_USER_MAPPED_CB_END	0xFFF1000100000000ull /* 4GB */
+
+/* 140TB */
+#define VA_HOST_SPACE_PAGE_SIZE		(VA_HOST_SPACE_PAGE_END - VA_HOST_SPACE_PAGE_START)
+
+/* 140TB */
+#define VA_HOST_SPACE_HPAGE_SIZE	(VA_HOST_SPACE_HPAGE_END - VA_HOST_SPACE_HPAGE_START)
+
+#define VA_HOST_SPACE_SIZE		(VA_HOST_SPACE_PAGE_SIZE + VA_HOST_SPACE_HPAGE_SIZE)
+
+#define HOST_SPACE_INTERNAL_CB_SZ		SZ_2M
+
+/*
+ * HBM virtual address space
+ * Gaudi2 has 6 HBM devices, each supporting 16GB total of 96GB at most.
+ * No core separation is supported so we can have one chunk of virtual address
+ * space just above the physical ones.
+ * The virtual address space starts immediately after the end of the physical
+ * address space which is determined at run-time.
+ */
+#define VA_HBM_SPACE_END		0x1002000000000000ull
+
+#define HW_CAP_PLL			BIT_ULL(0)
+#define HW_CAP_DRAM			BIT_ULL(1)
+#define HW_CAP_PMMU			BIT_ULL(2)
+#define HW_CAP_CPU			BIT_ULL(3)
+#define HW_CAP_MSIX			BIT_ULL(4)
+
+#define HW_CAP_CPU_Q			BIT_ULL(5)
+#define HW_CAP_CPU_Q_SHIFT		5
+
+#define HW_CAP_CLK_GATE			BIT_ULL(6)
+#define HW_CAP_KDMA			BIT_ULL(7)
+#define HW_CAP_SRAM_SCRAMBLER		BIT_ULL(8)
+
+#define HW_CAP_DCORE0_DMMU0		BIT_ULL(9)
+#define HW_CAP_DCORE0_DMMU1		BIT_ULL(10)
+#define HW_CAP_DCORE0_DMMU2		BIT_ULL(11)
+#define HW_CAP_DCORE0_DMMU3		BIT_ULL(12)
+#define HW_CAP_DCORE1_DMMU0		BIT_ULL(13)
+#define HW_CAP_DCORE1_DMMU1		BIT_ULL(14)
+#define HW_CAP_DCORE1_DMMU2		BIT_ULL(15)
+#define HW_CAP_DCORE1_DMMU3		BIT_ULL(16)
+#define HW_CAP_DCORE2_DMMU0		BIT_ULL(17)
+#define HW_CAP_DCORE2_DMMU1		BIT_ULL(18)
+#define HW_CAP_DCORE2_DMMU2		BIT_ULL(19)
+#define HW_CAP_DCORE2_DMMU3		BIT_ULL(20)
+#define HW_CAP_DCORE3_DMMU0		BIT_ULL(21)
+#define HW_CAP_DCORE3_DMMU1		BIT_ULL(22)
+#define HW_CAP_DCORE3_DMMU2		BIT_ULL(23)
+#define HW_CAP_DCORE3_DMMU3		BIT_ULL(24)
+#define HW_CAP_DMMU_MASK		GENMASK_ULL(24, 9)
+#define HW_CAP_DMMU_SHIFT		9
+#define HW_CAP_PDMA_MASK		BIT_ULL(26)
+#define HW_CAP_EDMA_MASK		GENMASK_ULL(34, 27)
+#define HW_CAP_EDMA_SHIFT		27
+#define HW_CAP_MME_MASK			GENMASK_ULL(38, 35)
+#define HW_CAP_MME_SHIFT		35
+#define HW_CAP_ROT_MASK			GENMASK_ULL(40, 39)
+#define HW_CAP_ROT_SHIFT		39
+#define HW_CAP_HBM_SCRAMBLER_HW_RESET	BIT_ULL(41)
+#define HW_CAP_HBM_SCRAMBLER_SW_RESET	BIT_ULL(42)
+#define HW_CAP_HBM_SCRAMBLER_MASK	(HW_CAP_HBM_SCRAMBLER_HW_RESET | \
+						HW_CAP_HBM_SCRAMBLER_SW_RESET)
+#define HW_CAP_HBM_SCRAMBLER_SHIFT	41
+#define HW_CAP_RESERVED			BIT(43)
+#define HW_CAP_MMU_MASK			(HW_CAP_PMMU | HW_CAP_DMMU_MASK)
+
+/* Range Registers */
+#define RR_TYPE_SHORT			0
+#define RR_TYPE_LONG			1
+#define RR_TYPE_SHORT_PRIV		2
+#define RR_TYPE_LONG_PRIV		3
+#define NUM_SHORT_LBW_RR		14
+#define NUM_LONG_LBW_RR			4
+#define NUM_SHORT_HBW_RR		6
+#define NUM_LONG_HBW_RR			4
+
+/* RAZWI initiator coordinates- X- 5 bits, Y- 4 bits */
+#define RAZWI_INITIATOR_X_SHIFT		0
+#define RAZWI_INITIATOR_X_MASK		0x1F
+#define RAZWI_INITIATOR_Y_SHIFT		5
+#define RAZWI_INITIATOR_Y_MASK		0xF
+
+#define RTR_ID_X_Y(x, y) \
+	((((y) & RAZWI_INITIATOR_Y_MASK) << RAZWI_INITIATOR_Y_SHIFT) | \
+		(((x) & RAZWI_INITIATOR_X_MASK) << RAZWI_INITIATOR_X_SHIFT))
+
+/* decoders have separate mask */
+#define HW_CAP_DEC_SHIFT		0
+#define HW_CAP_DEC_MASK			GENMASK_ULL(9, 0)
+
+/* TPCs have separate mask */
+#define HW_CAP_TPC_SHIFT		0
+#define HW_CAP_TPC_MASK			GENMASK_ULL(24, 0)
+
+/* nics have separate mask */
+#define HW_CAP_NIC_SHIFT		0
+#define HW_CAP_NIC_MASK			GENMASK_ULL(NIC_NUMBER_OF_ENGINES - 1, 0)
+
+#define GAUDI2_ARC_PCI_MSB_ADDR(addr)	(((addr) & GENMASK_ULL(49, 28)) >> 28)
+
+enum gaudi2_reserved_cq_id {
+	GAUDI2_RESERVED_CQ_COMPLETION,
+	GAUDI2_RESERVED_CQ_KDMA_COMPLETION,
+	GAUDI2_RESERVED_CQ_NUMBER,
+};
+
+/*
+ * Gaudi2 subtitute TPCs Numbering
+ * At most- two faulty TPCs are allowed
+ * First replacement to a faulty TPC will be TPC24, second- TPC23
+ */
+enum substitude_tpc {
+	FAULTY_TPC_SUBTS_1_TPC_24,
+	FAULTY_TPC_SUBTS_2_TPC_23,
+	MAX_FAULTY_TPCS
+};
+
+enum gaudi2_dma_core_id {
+	DMA_CORE_ID_PDMA0, /* Dcore 0 */
+	DMA_CORE_ID_PDMA1, /* Dcore 0 */
+	DMA_CORE_ID_EDMA0, /* Dcore 0 */
+	DMA_CORE_ID_EDMA1, /* Dcore 0 */
+	DMA_CORE_ID_EDMA2, /* Dcore 1 */
+	DMA_CORE_ID_EDMA3, /* Dcore 1 */
+	DMA_CORE_ID_EDMA4, /* Dcore 2 */
+	DMA_CORE_ID_EDMA5, /* Dcore 2 */
+	DMA_CORE_ID_EDMA6, /* Dcore 3 */
+	DMA_CORE_ID_EDMA7, /* Dcore 3 */
+	DMA_CORE_ID_KDMA, /* Dcore 0 */
+	DMA_CORE_ID_SIZE
+};
+
+enum gaudi2_rotator_id {
+	ROTATOR_ID_0,
+	ROTATOR_ID_1,
+	ROTATOR_ID_SIZE,
+};
+
+enum gaudi2_mme_id {
+	MME_ID_DCORE0,
+	MME_ID_DCORE1,
+	MME_ID_DCORE2,
+	MME_ID_DCORE3,
+	MME_ID_SIZE,
+};
+
+enum gaudi2_tpc_id {
+	TPC_ID_DCORE0_TPC0,
+	TPC_ID_DCORE0_TPC1,
+	TPC_ID_DCORE0_TPC2,
+	TPC_ID_DCORE0_TPC3,
+	TPC_ID_DCORE0_TPC4,
+	TPC_ID_DCORE0_TPC5,
+	TPC_ID_DCORE1_TPC0,
+	TPC_ID_DCORE1_TPC1,
+	TPC_ID_DCORE1_TPC2,
+	TPC_ID_DCORE1_TPC3,
+	TPC_ID_DCORE1_TPC4,
+	TPC_ID_DCORE1_TPC5,
+	TPC_ID_DCORE2_TPC0,
+	TPC_ID_DCORE2_TPC1,
+	TPC_ID_DCORE2_TPC2,
+	TPC_ID_DCORE2_TPC3,
+	TPC_ID_DCORE2_TPC4,
+	TPC_ID_DCORE2_TPC5,
+	TPC_ID_DCORE3_TPC0,
+	TPC_ID_DCORE3_TPC1,
+	TPC_ID_DCORE3_TPC2,
+	TPC_ID_DCORE3_TPC3,
+	TPC_ID_DCORE3_TPC4,
+	TPC_ID_DCORE3_TPC5,
+	/* the PCI TPC is placed last (mapped liked HW) */
+	TPC_ID_DCORE0_TPC6,
+	TPC_ID_SIZE,
+};
+
+enum gaudi2_dec_id {
+	DEC_ID_DCORE0_DEC0,
+	DEC_ID_DCORE0_DEC1,
+	DEC_ID_DCORE1_DEC0,
+	DEC_ID_DCORE1_DEC1,
+	DEC_ID_DCORE2_DEC0,
+	DEC_ID_DCORE2_DEC1,
+	DEC_ID_DCORE3_DEC0,
+	DEC_ID_DCORE3_DEC1,
+	DEC_ID_PCIE_VDEC0,
+	DEC_ID_PCIE_VDEC1,
+	DEC_ID_SIZE,
+};
+
+enum gaudi2_hbm_id {
+	HBM_ID0,
+	HBM_ID1,
+	HBM_ID2,
+	HBM_ID3,
+	HBM_ID4,
+	HBM_ID5,
+	HBM_ID_SIZE,
+};
+
+/* specific EDMA enumeration */
+enum gaudi2_edma_id {
+	EDMA_ID_DCORE0_INSTANCE0,
+	EDMA_ID_DCORE0_INSTANCE1,
+	EDMA_ID_DCORE1_INSTANCE0,
+	EDMA_ID_DCORE1_INSTANCE1,
+	EDMA_ID_DCORE2_INSTANCE0,
+	EDMA_ID_DCORE2_INSTANCE1,
+	EDMA_ID_DCORE3_INSTANCE0,
+	EDMA_ID_DCORE3_INSTANCE1,
+	EDMA_ID_SIZE,
+};
+
+/* User interrupt count is aligned with HW CQ count.
+ * We have 64 CQ's per dcore, CQ0 in dcore 0 is reserved for legacy mode
+ */
+#define GAUDI2_NUM_USER_INTERRUPTS 255
+
+enum gaudi2_irq_num {
+	GAUDI2_IRQ_NUM_EVENT_QUEUE = GAUDI2_EVENT_QUEUE_MSIX_IDX,
+	GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM,
+	GAUDI2_IRQ_NUM_DCORE0_DEC0_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE0_DEC1_NRM,
+	GAUDI2_IRQ_NUM_DCORE0_DEC1_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE1_DEC0_NRM,
+	GAUDI2_IRQ_NUM_DCORE1_DEC0_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE1_DEC1_NRM,
+	GAUDI2_IRQ_NUM_DCORE1_DEC1_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE2_DEC0_NRM,
+	GAUDI2_IRQ_NUM_DCORE2_DEC0_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE2_DEC1_NRM,
+	GAUDI2_IRQ_NUM_DCORE2_DEC1_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE3_DEC0_NRM,
+	GAUDI2_IRQ_NUM_DCORE3_DEC0_ABNRM,
+	GAUDI2_IRQ_NUM_DCORE3_DEC1_NRM,
+	GAUDI2_IRQ_NUM_DCORE3_DEC1_ABNRM,
+	GAUDI2_IRQ_NUM_SHARED_DEC0_NRM,
+	GAUDI2_IRQ_NUM_SHARED_DEC0_ABNRM,
+	GAUDI2_IRQ_NUM_SHARED_DEC1_NRM,
+	GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM,
+	GAUDI2_IRQ_NUM_COMPLETION,
+	GAUDI2_IRQ_NUM_NIC_PORT_FIRST,
+	GAUDI2_IRQ_NUM_NIC_PORT_LAST = (GAUDI2_IRQ_NUM_NIC_PORT_FIRST + NIC_NUMBER_OF_PORTS - 1),
+	GAUDI2_IRQ_NUM_RESERVED_FIRST,
+	GAUDI2_IRQ_NUM_RESERVED_LAST = (GAUDI2_MSIX_ENTRIES - GAUDI2_NUM_USER_INTERRUPTS - 1),
+	GAUDI2_IRQ_NUM_USER_FIRST,
+	GAUDI2_IRQ_NUM_USER_LAST = (GAUDI2_IRQ_NUM_USER_FIRST + GAUDI2_NUM_USER_INTERRUPTS - 1),
+	GAUDI2_IRQ_NUM_LAST = (GAUDI2_MSIX_ENTRIES - 1)
+};
+
+static_assert(GAUDI2_IRQ_NUM_USER_FIRST > GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM);
+
+/**
+ * struct dup_block_ctx - context to initialize unit instances across multiple
+ *                        blocks where block can be either a dcore of duplicated
+ *                        common module. this code relies on constant offsets
+ *                        of blocks and unit instances in a block.
+ * @instance_cfg_fn: instance specific configuration function.
+ * @data: private configuration data.
+ * @base: base address of the first instance in the first block.
+ * @block_off: subsequent blocks address spacing.
+ * @instance_off: subsequent block's instances address spacing.
+ * @enabled_mask: mask of enabled instances (1- enabled, 0- disabled).
+ * @blocks: number of blocks.
+ * @instances: unit instances per block.
+ */
+struct dup_block_ctx {
+	void (*instance_cfg_fn)(struct hl_device *hdev, u64 base, void *data);
+	void *data;
+	u64 base;
+	u64 block_off;
+	u64 instance_off;
+	u64 enabled_mask;
+	unsigned int blocks;
+	unsigned int instances;
+};
+
+/**
+ * struct gaudi2_device - ASIC specific manage structure.
+ * @cpucp_info_get: get information on device from CPU-CP
+ * @mapped_blocks: array that holds the base address and size of all blocks
+ *                 the user can map.
+ * @lfsr_rand_seeds: array of MME ACC random seeds to set.
+ * @hw_queues_lock: protects the H/W queues from concurrent access.
+ * @kdma_lock: protects the KDMA engine from concurrent access.
+ * @scratchpad_kernel_address: general purpose PAGE_SIZE contiguous memory,
+ *                             this memory region should be write-only.
+ *                             currently used for HBW QMAN writes which is
+ *                             redundant.
+ * @scratchpad_bus_address: scratchpad bus address
+ * @dram_bar_cur_addr: current address of DRAM PCI bar.
+ * @hw_cap_initialized: This field contains a bit per H/W engine. When that
+ *                      engine is initialized, that bit is set by the driver to
+ *                      signal we can use this engine in later code paths.
+ *                      Each bit is cleared upon reset of its corresponding H/W
+ *                      engine.
+ * @active_hw_arc: This field contains a bit per ARC of an H/W engine with
+ *                 exception of TPC and NIC engines. Once an engine arc is
+ *                 initialized, its respective bit is set. Driver can uniquely
+ *                 identify each initialized ARC and use this information in
+ *                 later code paths. Each respective bit is cleared upon reset
+ *                 of its corresponding ARC of the H/W engine.
+ * @dec_hw_cap_initialized: This field contains a bit per decoder H/W engine.
+ *                      When that engine is initialized, that bit is set by
+ *                      the driver to signal we can use this engine in later
+ *                      code paths.
+ *                      Each bit is cleared upon reset of its corresponding H/W
+ *                      engine.
+ * @tpc_hw_cap_initialized: This field contains a bit per TPC H/W engine.
+ *                      When that engine is initialized, that bit is set by
+ *                      the driver to signal we can use this engine in later
+ *                      code paths.
+ *                      Each bit is cleared upon reset of its corresponding H/W
+ *                      engine.
+ * @active_tpc_arc: This field contains a bit per ARC of the TPC engines.
+ *                  Once an engine arc is initialized, its respective bit is
+ *                  set. Each respective bit is cleared upon reset of its
+ *                  corresponding ARC of the TPC engine.
+ * @nic_hw_cap_initialized: This field contains a bit per nic H/W engine.
+ * @active_nic_arc: This field contains a bit per ARC of the NIC engines.
+ *                  Once an engine arc is initialized, its respective bit is
+ *                  set. Each respective bit is cleared upon reset of its
+ *                  corresponding ARC of the NIC engine.
+ * @hw_events: array that holds all H/W events that are defined valid.
+ * @events_stat: array that holds histogram of all received events.
+ * @events_stat_aggregate: same as events_stat but doesn't get cleared on reset.
+ * @num_of_valid_hw_events: used to hold the number of valid H/W events.
+ * @nic_ports: array that holds all NIC ports manage structures.
+ * @nic_macros: array that holds all NIC macro manage structures.
+ * @core_info: core info to be used by the Ethernet driver.
+ * @aux_ops: functions for core <-> aux drivers communication.
+ * @flush_db_fifo: flag to force flush DB FIFO after a write.
+ * @hbm_cfg: HBM subsystem settings
+ * @hw_queues_lock_mutex: used by simulator instead of hw_queues_lock.
+ * @kdma_lock_mutex: used by simulator instead of kdma_lock.
+ * @use_deprecated_event_mappings: use old event mappings which are about to be
+ *                                 deprecated
+ */
+struct gaudi2_device {
+	int (*cpucp_info_get)(struct hl_device *hdev);
+
+	struct user_mapped_block	mapped_blocks[NUM_USER_MAPPED_BLOCKS];
+	int				lfsr_rand_seeds[MME_NUM_OF_LFSR_SEEDS];
+
+	spinlock_t			hw_queues_lock;
+	spinlock_t			kdma_lock;
+
+	void				*scratchpad_kernel_address;
+	dma_addr_t			scratchpad_bus_address;
+
+	u64				dram_bar_cur_addr;
+	u64				hw_cap_initialized;
+	u64				active_hw_arc;
+	u64				dec_hw_cap_initialized;
+	u64				tpc_hw_cap_initialized;
+	u64				active_tpc_arc;
+	u64				nic_hw_cap_initialized;
+	u64				active_nic_arc;
+	u32				hw_events[GAUDI2_EVENT_SIZE];
+	u32				events_stat[GAUDI2_EVENT_SIZE];
+	u32				events_stat_aggregate[GAUDI2_EVENT_SIZE];
+	u32				num_of_valid_hw_events;
+};
+
+extern const u32 gaudi2_dma_core_blocks_bases[DMA_CORE_ID_SIZE];
+extern const u32 gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_SIZE];
+extern const u32 gaudi2_mme_acc_blocks_bases[MME_ID_SIZE];
+extern const u32 gaudi2_mme_ctrl_lo_blocks_bases[MME_ID_SIZE];
+extern const u32 edma_stream_base[NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES];
+extern const u32 gaudi2_rot_blocks_bases[ROTATOR_ID_SIZE];
+
+void gaudi2_iterate_tpcs(struct hl_device *hdev, struct iterate_module_ctx *ctx);
+int gaudi2_coresight_init(struct hl_device *hdev);
+int gaudi2_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
+void gaudi2_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx);
+void gaudi2_init_blocks(struct hl_device *hdev, struct dup_block_ctx *cfg_ctx);
+bool gaudi2_is_hmmu_enabled(struct hl_device *hdev, int dcore_id, int hmmu_id);
+void gaudi2_write_rr_to_all_lbw_rtrs(struct hl_device *hdev, u8 rr_type, u32 rr_index, u64 min_val,
+					u64 max_val);
+void gaudi2_pb_print_security_errors(struct hl_device *hdev, u32 block_addr, u32 cause,
+					u32 offended_addr);
+
+#endif /* GAUDI2P_H_ */
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
new file mode 100644
index 000000000000..19ec1f130bef
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2020-2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GAUDI2_MASKS_H_
+#define GAUDI2_MASKS_H_
+
+#include "../include/gaudi2/asic_reg/gaudi2_regs.h"
+
+/* Useful masks for bits in various registers */
+#define QMAN_GLBL_ERR_CFG_MSG_EN_MASK	\
+	((0xF << PDMA0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_ERR_CFG_CQF_ERR_MSG_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_ERR_CFG_CP_ERR_MSG_EN_SHIFT))
+
+#define QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	\
+	((0xF << PDMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT) | \
+	(0x1 << PDMA0_QM_GLBL_ERR_CFG_ARB_STOP_ON_ERR_SHIFT))
+
+#define QMAN_GLBL_ERR_CFG1_MSG_EN_MASK	\
+	(0x1 << PDMA0_QM_GLBL_ERR_CFG1_CQF_ERR_MSG_EN_SHIFT)
+
+#define QMAN_GLBL_ERR_CFG1_STOP_ON_ERR_EN_MASK	\
+	((0x1 << PDMA0_QM_GLBL_ERR_CFG1_CQF_STOP_ON_ERR_SHIFT) | \
+	(0x1 << PDMA0_QM_GLBL_ERR_CFG1_ARC_STOP_ON_ERR_SHIFT))
+
+#define QM_PQC_LBW_WDATA	\
+	((1 << DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_SHIFT) | \
+	(1 << DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_SHIFT))
+
+#define QMAN_MAKE_TRUSTED	\
+	((0xF << PDMA0_QM_GLBL_PROT_PQF_SHIFT) | \
+	(0x1 << PDMA0_QM_GLBL_PROT_ERR_SHIFT) | \
+	(0x1 << PDMA0_QM_GLBL_PROT_PQC_SHIFT))
+
+#define QMAN_MAKE_TRUSTED_TEST_MODE	\
+	((0xF << PDMA0_QM_GLBL_PROT_PQF_SHIFT) | \
+	(0xF << PDMA0_QM_GLBL_PROT_CQF_SHIFT) | \
+	(0xF << PDMA0_QM_GLBL_PROT_CP_SHIFT) | \
+	(0x1 << PDMA0_QM_GLBL_PROT_ERR_SHIFT) | \
+	(0x1 << PDMA0_QM_GLBL_PROT_PQC_SHIFT))
+
+#define QMAN_ENABLE		\
+	((0xF << PDMA0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_CFG0_CP_EN_SHIFT)  | \
+	(0x1 << PDMA0_QM_GLBL_CFG0_ARC_CQF_EN_SHIFT))
+
+#define PDMA1_QMAN_ENABLE	\
+	((0x3 << PDMA0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_CFG0_CP_EN_SHIFT)  | \
+	(0x1 << PDMA0_QM_GLBL_CFG0_ARC_CQF_EN_SHIFT))
+
+/* QM_IDLE_MASK is valid for all engines QM idle check */
+#define QM_IDLE_MASK	(DCORE0_EDMA0_QM_GLBL_STS0_PQF_IDLE_MASK | \
+			DCORE0_EDMA0_QM_GLBL_STS0_CQF_IDLE_MASK | \
+			DCORE0_EDMA0_QM_GLBL_STS0_CP_IDLE_MASK)
+
+#define QM_ARC_IDLE_MASK	DCORE0_EDMA0_QM_GLBL_STS1_ARC_CQF_IDLE_MASK
+
+#define MME_ARCH_IDLE_MASK	\
+			(DCORE0_MME_CTRL_LO_ARCH_STATUS_SB_IN_EMPTY_MASK | \
+			DCORE0_MME_CTRL_LO_ARCH_STATUS_AGU_COUT_SM_IDLE_MASK | \
+			DCORE0_MME_CTRL_LO_ARCH_STATUS_WBC_AXI_IDLE_MASK | \
+			DCORE0_MME_CTRL_LO_ARCH_STATUS_SB_IN_AXI_IDLE_MASK | \
+			DCORE0_MME_CTRL_LO_ARCH_STATUS_QM_IDLE_MASK | \
+			DCORE0_MME_CTRL_LO_ARCH_STATUS_QM_RDY_MASK)
+
+#define TPC_IDLE_MASK	(DCORE0_TPC0_CFG_STATUS_SCALAR_PIPE_EMPTY_MASK | \
+			DCORE0_TPC0_CFG_STATUS_VECTOR_PIPE_EMPTY_MASK | \
+			DCORE0_TPC0_CFG_STATUS_IQ_EMPTY_MASK | \
+			DCORE0_TPC0_CFG_STATUS_SB_EMPTY_MASK | \
+			DCORE0_TPC0_CFG_STATUS_QM_IDLE_MASK | \
+			DCORE0_TPC0_CFG_STATUS_QM_RDY_MASK)
+
+#define DCORE0_TPC0_QM_CGM_STS_AGENT_IDLE_MASK 0x100
+
+/* CGM_IDLE_MASK is valid for all engines CGM idle check */
+#define CGM_IDLE_MASK	DCORE0_TPC0_QM_CGM_STS_AGENT_IDLE_MASK
+
+#define QM_GLBL_CFG1_PQF_STOP		PDMA0_QM_GLBL_CFG1_PQF_STOP_MASK
+#define QM_GLBL_CFG1_CQF_STOP		PDMA0_QM_GLBL_CFG1_CQF_STOP_MASK
+#define QM_GLBL_CFG1_CP_STOP		PDMA0_QM_GLBL_CFG1_CP_STOP_MASK
+#define QM_GLBL_CFG1_PQF_FLUSH		PDMA0_QM_GLBL_CFG1_PQF_FLUSH_MASK
+#define QM_GLBL_CFG1_CQF_FLUSH		PDMA0_QM_GLBL_CFG1_CQF_FLUSH_MASK
+#define QM_GLBL_CFG1_CP_FLUSH		PDMA0_QM_GLBL_CFG1_CP_FLUSH_MASK
+
+#define QM_GLBL_CFG2_ARC_CQF_STOP	PDMA0_QM_GLBL_CFG2_ARC_CQF_STOP_MASK
+#define QM_GLBL_CFG2_ARC_CQF_FLUSH	PDMA0_QM_GLBL_CFG2_ARC_CQF_FLUSH_MASK
+
+#define QM_ARB_ERR_MSG_EN_CHOISE_OVF_MASK                            0x1
+#define QM_ARB_ERR_MSG_EN_CHOISE_WDT_MASK                            0x2
+#define QM_ARB_ERR_MSG_EN_AXI_LBW_ERR_MASK                           0x4
+
+#define QM_ARB_ERR_MSG_EN_MASK		(\
+					QM_ARB_ERR_MSG_EN_CHOISE_OVF_MASK |\
+					QM_ARB_ERR_MSG_EN_CHOISE_WDT_MASK |\
+					QM_ARB_ERR_MSG_EN_AXI_LBW_ERR_MASK)
+
+#define PCIE_AUX_FLR_CTRL_HW_CTRL_MASK		0x1
+#define PCIE_AUX_FLR_CTRL_INT_MASK_MASK		0x2
+
+#define MME_ACC_INTR_MASK_WBC_ERR_RESP_MASK		GENMASK(1, 0)
+#define MME_ACC_INTR_MASK_AP_SRC_POS_INF_MASK		BIT(2)
+#define MME_ACC_INTR_MASK_AP_SRC_NEG_INF_MASK		BIT(3)
+#define MME_ACC_INTR_MASK_AP_SRC_NAN_MASK		BIT(4)
+#define MME_ACC_INTR_MASK_AP_RESULT_POS_INF_MASK	BIT(5)
+#define MME_ACC_INTR_MASK_AP_RESULT_NEG_INF_MASK	BIT(6)
+
+#define SM_CQ_L2H_MASK_VAL		0xFFFFFFFFFC000000ull
+#define SM_CQ_L2H_CMPR_VAL		0x1000007FFC000000ull
+#define SM_CQ_L2H_LOW_MASK		GENMASK(31, 20)
+#define SM_CQ_L2H_LOW_SHIFT		20
+
+#define MMU_STATIC_MULTI_PAGE_SIZE_HOP4_PAGE_SIZE_MASK \
+	REG_FIELD_MASK(DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE, HOP4_PAGE_SIZE)
+#define STLB_HOP_CONFIGURATION_ONLY_LARGE_PAGE_MASK \
+	REG_FIELD_MASK(DCORE0_HMMU0_STLB_HOP_CONFIGURATION, ONLY_LARGE_PAGE)
+
+#define AXUSER_HB_SEC_ASID_MASK                0x3FF
+#define AXUSER_HB_SEC_MMBP_MASK                0x400
+
+#define MMUBP_ASID_MASK	(AXUSER_HB_SEC_ASID_MASK | AXUSER_HB_SEC_MMBP_MASK)
+
+#define ROT_MSS_HALT_WBC_MASK	BIT(0)
+#define ROT_MSS_HALT_RSB_MASK	BIT(1)
+#define ROT_MSS_HALT_MRSB_MASK	BIT(2)
+
+#endif /* GAUDI2_MASKS_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3255d2044c6c..df6ed2a3cca7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -470,7 +470,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
 
-	prop->first_available_user_msix_interrupt = USHRT_MAX;
+	prop->first_available_user_interrupt = USHRT_MAX;
 
 	for (i = 0 ; i < HL_MAX_DCORES ; i++)
 		prop->first_available_cq[i] = USHRT_MAX;
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index b190a44ef2e2..719b2ff80985 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2020-2021 HabanaLabs, Ltd.
+ * Copyright 2020-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -99,27 +99,265 @@ struct hl_eq_fw_alive {
 	__u8 pad[7];
 };
 
-enum hl_pcie_addr_dec_cause {
-	PCIE_ADDR_DEC_HBW_ERR_RESP,
-	PCIE_ADDR_DEC_LBW_ERR_RESP,
-	PCIE_ADDR_DEC_TLP_BLOCKED_BY_RR
+struct hl_eq_intr_cause {
+	__le64 intr_cause_data;
 };
 
-struct hl_eq_pcie_addr_dec_data {
-	/* enum hl_pcie_addr_dec_cause */
-	__u8 addr_dec_cause;
-	__u8 pad[7];
+struct hl_eq_pcie_drain_ind_data {
+	struct hl_eq_intr_cause intr_cause;
+	__le64 drain_wr_addr_lbw;
+	__le64 drain_rd_addr_lbw;
+	__le64 drain_wr_addr_hbw;
+	__le64 drain_rd_addr_hbw;
+};
+
+struct hl_eq_razwi_lbw_info_regs {
+	__le32 rr_aw_razwi_reg;
+	__le32 rr_aw_razwi_id_reg;
+	__le32 rr_ar_razwi_reg;
+	__le32 rr_ar_razwi_id_reg;
+};
+
+struct hl_eq_razwi_hbw_info_regs {
+	__le32 rr_aw_razwi_hi_reg;
+	__le32 rr_aw_razwi_lo_reg;
+	__le32 rr_aw_razwi_id_reg;
+	__le32 rr_ar_razwi_hi_reg;
+	__le32 rr_ar_razwi_lo_reg;
+	__le32 rr_ar_razwi_id_reg;
+};
+
+/* razwi_happened masks */
+#define RAZWI_HAPPENED_HBW	0x1
+#define RAZWI_HAPPENED_LBW	0x2
+#define RAZWI_HAPPENED_AW	0x4
+#define RAZWI_HAPPENED_AR	0x8
+
+struct hl_eq_razwi_info {
+	__le32 razwi_happened_mask;
+	union {
+		struct hl_eq_razwi_lbw_info_regs lbw;
+		struct hl_eq_razwi_hbw_info_regs hbw;
+	};
+	__le32 pad;
+};
+
+struct hl_eq_razwi_with_intr_cause {
+	struct hl_eq_razwi_info razwi_info;
+	struct hl_eq_intr_cause intr_cause;
+};
+
+#define HBM_CA_ERR_CMD_LIFO_LEN		8
+#define HBM_RD_ERR_DATA_LIFO_LEN	8
+#define HBM_WR_PAR_CMD_LIFO_LEN		11
+
+enum hl_hbm_sei_cause {
+	/* Command/address parity error event is split into 2 events due to
+	 * size limitation: ODD suffix for odd HBM CK_t cycles and EVEN  suffix
+	 * for even HBM CK_t cycles
+	 */
+	HBM_SEI_CMD_PARITY_EVEN,
+	HBM_SEI_CMD_PARITY_ODD,
+	/* Read errors can be reflected as a combination of SERR/DERR/parity
+	 * errors. Therefore, we define one event for all read error types.
+	 * LKD will perform further proccessing.
+	 */
+	HBM_SEI_READ_ERR,
+	HBM_SEI_WRITE_DATA_PARITY_ERR,
+	HBM_SEI_CATTRIP,
+	HBM_SEI_MEM_BIST_FAIL,
+	HBM_SEI_DFI,
+	HBM_SEI_INV_TEMP_READ_OUT,
+	HBM_SEI_BIST_FAIL,
+};
+
+/* Masks for parsing hl_hbm_sei_headr fields */
+#define HBM_ECC_SERR_CNTR_MASK		0xFF
+#define HBM_ECC_DERR_CNTR_MASK		0xFF00
+#define HBM_RD_PARITY_CNTR_MASK		0xFF0000
+
+/* HBM index and MC index are known by the event_id */
+struct hl_hbm_sei_header {
+	union {
+		/* relevant only in case of HBM read error */
+		struct {
+			__u8 ecc_serr_cnt;
+			__u8 ecc_derr_cnt;
+			__u8 read_par_cnt;
+			__u8 reserved;
+		};
+		/* All other cases */
+		__le32 cnt;
+	};
+	__u8 sei_cause;		/* enum hl_hbm_sei_cause */
+	__u8 mc_channel;		/* range: 0-3 */
+	__u8 mc_pseudo_channel;	/* range: 0-7 */
+	__u8 pad[1];
+};
+
+#define HBM_RD_ADDR_SID_SHIFT		0
+#define HBM_RD_ADDR_SID_MASK		0x1
+#define HBM_RD_ADDR_BG_SHIFT		1
+#define HBM_RD_ADDR_BG_MASK		0x6
+#define HBM_RD_ADDR_BA_SHIFT		3
+#define HBM_RD_ADDR_BA_MASK		0x18
+#define HBM_RD_ADDR_COL_SHIFT		5
+#define HBM_RD_ADDR_COL_MASK		0x7E0
+#define HBM_RD_ADDR_ROW_SHIFT		11
+#define HBM_RD_ADDR_ROW_MASK		0x3FFF800
+
+struct hbm_rd_addr {
+	union {
+		/* bit fields are only for FW use */
+		struct {
+			u32 dbg_rd_err_addr_sid:1;
+			u32 dbg_rd_err_addr_bg:2;
+			u32 dbg_rd_err_addr_ba:2;
+			u32 dbg_rd_err_addr_col:6;
+			u32 dbg_rd_err_addr_row:15;
+			u32 reserved:6;
+		};
+		__le32 rd_addr_val;
+	};
+};
+
+#define HBM_RD_ERR_BEAT_SHIFT		2
+/* dbg_rd_err_misc fields: */
+/* Read parity is calculated per DW on every beat */
+#define HBM_RD_ERR_PAR_ERR_BEAT0_SHIFT	0
+#define HBM_RD_ERR_PAR_ERR_BEAT0_MASK	0x3
+#define HBM_RD_ERR_PAR_DATA_BEAT0_SHIFT	8
+#define HBM_RD_ERR_PAR_DATA_BEAT0_MASK	0x300
+/* ECC is calculated per PC on every beat */
+#define HBM_RD_ERR_SERR_BEAT0_SHIFT	16
+#define HBM_RD_ERR_SERR_BEAT0_MASK	0x10000
+#define HBM_RD_ERR_DERR_BEAT0_SHIFT	24
+#define HBM_RD_ERR_DERR_BEAT0_MASK	0x100000
+
+struct hl_eq_hbm_sei_read_err_intr_info {
+	/* DFI_RD_ERR_REP_ADDR */
+	struct hbm_rd_addr dbg_rd_err_addr;
+	/* DFI_RD_ERR_REP_ERR */
+	union {
+		struct {
+			/* bit fields are only for FW use */
+			u32 dbg_rd_err_par:8;
+			u32 dbg_rd_err_par_data:8;
+			u32 dbg_rd_err_serr:4;
+			u32 dbg_rd_err_derr:4;
+			u32 reserved:8;
+		};
+		__le32 dbg_rd_err_misc;
+	};
+	/* DFI_RD_ERR_REP_DM */
+	__le32 dbg_rd_err_dm;
+	/* DFI_RD_ERR_REP_SYNDROME */
+	__le32 dbg_rd_err_syndrome;
+	/* DFI_RD_ERR_REP_DATA */
+	__le32 dbg_rd_err_data[HBM_RD_ERR_DATA_LIFO_LEN];
+};
+
+struct hl_eq_hbm_sei_ca_par_intr_info {
+	/* 14 LSBs */
+	__le16 dbg_row[HBM_CA_ERR_CMD_LIFO_LEN];
+	/* 18 LSBs */
+	__le32 dbg_col[HBM_CA_ERR_CMD_LIFO_LEN];
+};
+
+#define WR_PAR_LAST_CMD_COL_SHIFT	0
+#define WR_PAR_LAST_CMD_COL_MASK	0x3F
+#define WR_PAR_LAST_CMD_BG_SHIFT	6
+#define WR_PAR_LAST_CMD_BG_MASK		0xC0
+#define WR_PAR_LAST_CMD_BA_SHIFT	8
+#define WR_PAR_LAST_CMD_BA_MASK		0x300
+#define WR_PAR_LAST_CMD_SID_SHIFT	10
+#define WR_PAR_LAST_CMD_SID_MASK	0x400
+
+/* Row address isn't latched */
+struct hbm_sei_wr_cmd_address {
+	/* DFI_DERR_LAST_CMD */
+	union {
+		struct {
+			/* bit fields are only for FW use */
+			u32 col:6;
+			u32 bg:2;
+			u32 ba:2;
+			u32 sid:1;
+			u32 reserved:21;
+		};
+		__le32 dbg_wr_cmd_addr;
+	};
+};
+
+struct hl_eq_hbm_sei_wr_par_intr_info {
+	/* entry 0: WR command address from the 1st cycle prior to the error
+	 * entry 1: WR command address from the 2nd cycle prior to the error
+	 * and so on...
+	 */
+	struct hbm_sei_wr_cmd_address dbg_last_wr_cmds[HBM_WR_PAR_CMD_LIFO_LEN];
+	/* derr[0:1] - 1st HBM cycle DERR output
+	 * derr[2:3] - 2nd HBM cycle DERR output
+	 */
+	__u8 dbg_derr;
+	/* extend to reach 8B */
+	__u8 pad[3];
+};
+
+/*
+ * this struct represents the following sei causes:
+ * command parity, ECC double error, ECC single error, dfi error, cattrip,
+ * temperature read-out, read parity error and write parity error.
+ * some only use the header while some have extra data.
+ */
+struct hl_eq_hbm_sei_data {
+	struct hl_hbm_sei_header hdr;
+	union {
+		struct hl_eq_hbm_sei_ca_par_intr_info ca_parity_even_info;
+		struct hl_eq_hbm_sei_ca_par_intr_info ca_parity_odd_info;
+		struct hl_eq_hbm_sei_read_err_intr_info read_err_info;
+		struct hl_eq_hbm_sei_wr_par_intr_info wr_parity_info;
+	};
+};
+
+/* Engine/farm arc interrupt type */
+enum hl_engine_arc_interrupt_type {
+	/* Qman/farm ARC DCCM QUEUE FULL interrupt type */
+	ENGINE_ARC_DCCM_QUEUE_FULL_IRQ = 1
+};
+
+/* Data structure specifies details of payload of DCCM QUEUE FULL interrupt */
+struct hl_engine_arc_dccm_queue_full_irq {
+	/* Queue index value which caused DCCM QUEUE FULL */
+	__le32 queue_index;
+	__le32 pad;
+};
+
+/* Data structure specifies details of QM/FARM ARC interrupt */
+struct hl_eq_engine_arc_intr_data {
+	/* ARC engine id e.g.  DCORE0_TPC0_QM_ARC, DCORE0_TCP1_QM_ARC */
+	__le32 engine_id;
+	__le32 intr_type; /* enum hl_engine_arc_interrupt_type */
+	/* More info related to the interrupt e.g. queue index
+	 * incase of DCCM_QUEUE_FULL interrupt.
+	 */
+	__le64 payload;
+	__le64 pad[5];
 };
 
 struct hl_eq_entry {
 	struct hl_eq_header hdr;
 	union {
 		struct hl_eq_ecc_data ecc_data;
-		struct hl_eq_hbm_ecc_data hbm_ecc_data;
+		struct hl_eq_hbm_ecc_data hbm_ecc_data;	/* Gaudi1 HBM */
 		struct hl_eq_sm_sei_data sm_sei_data;
 		struct cpucp_pkt_sync_err pkt_sync_err;
 		struct hl_eq_fw_alive fw_alive;
-		struct hl_eq_pcie_addr_dec_data pcie_addr_dec_data;
+		struct hl_eq_intr_cause intr_cause;
+		struct hl_eq_pcie_drain_ind_data pcie_drain_ind_data;
+		struct hl_eq_razwi_info razwi_info;
+		struct hl_eq_razwi_with_intr_cause razwi_with_intr_cause;
+		struct hl_eq_hbm_sei_data sei_data;	/* Gaudi2 HBM */
+		struct hl_eq_engine_arc_intr_data arc_data;
 		__le64 data[7];
 	};
 };
@@ -793,10 +1031,23 @@ struct cpucp_security_info {
  * @infineon_second_stage_version: Infineon 2nd stage DC-DC version.
  * @dram_size: available DRAM size.
  * @card_name: card name that will be displayed in HWMON subsystem on the host
+ * @tpc_binning_mask: TPC binning mask, 1 bit per TPC instance
+ *                    (0 = functional, 1 = binned)
+ * @decoder_binning_mask: Decoder binning mask, 1 bit per decoder instance
+ *                        (0 = functional, 1 = binned), maximum 1 per dcore
+ * @sram_binning: Categorize SRAM functionality
+ *                (0 = fully functional, 1 = lower-half is not functional,
+ *                 2 = upper-half is not functional)
  * @sec_info: security information
  * @pll_map: Bit map of supported PLLs for current ASIC version.
  * @mme_binning_mask: MME binning mask,
- *                   (0 = functional, 1 = binned)
+ *                    bits [0:6]   <==> dcore0 mme fma
+ *                    bits [7:13]  <==> dcore1 mme fma
+ *                    bits [14:20] <==> dcore0 mme ima
+ *                    bits [21:27] <==> dcore1 mme ima
+ *                    For each group, if the 6th bit is set then first 5 bits
+ *                    represent the col's idx [0-31], otherwise these bits are
+ *                    ignored, and col idx 32 is binned. 7th bit is don't care.
  * @dram_binning_mask: DRAM binning mask, 1 bit per dram instance
  *                     (0 = functional 1 = binned)
  * @memory_repair_flag: eFuse flag indicating memory repair
@@ -804,6 +1055,8 @@ struct cpucp_security_info {
  *                     (0 = functional 1 = binned)
  * @xbar_binning_mask: Xbar binning mask, 1 bit per Xbar instance
  *                     (0 = functional 1 = binned)
+ * @interposer_version: Interposer version programmed in eFuse
+ * @substrate_version: Substrate version programmed in eFuse
  * @fw_os_version: Firmware OS Version
  */
 struct cpucp_info {
@@ -820,16 +1073,18 @@ struct cpucp_info {
 	__le32 infineon_second_stage_version;
 	__le64 dram_size;
 	char card_name[CARD_NAME_MAX_LEN];
-	__le64 reserved3;
-	__le64 reserved4;
-	__u8 reserved5;
+	__le64 tpc_binning_mask;
+	__le64 decoder_binning_mask;
+	__u8 sram_binning;
 	__u8 dram_binning_mask;
 	__u8 memory_repair_flag;
 	__u8 edma_binning_mask;
 	__u8 xbar_binning_mask;
-	__u8 pad[3];
+	__u8 interposer_version;
+	__u8 substrate_version;
+	__u8 reserved2;
 	struct cpucp_security_info sec_info;
-	__le32 reserved6;
+	__le32 reserved3;
 	__u8 pll_map[PLL_MAP_LEN];
 	__le64 mme_binning_mask;
 	__u8 fw_os_version[VERSION_MAX_LEN];
@@ -933,6 +1188,11 @@ struct cpucp_hbm_row_replaced_rows_info {
 	struct cpucp_hbm_row_info replaced_rows[CPUCP_HBM_ROW_REPLACE_MAX];
 };
 
+enum cpu_reset_status {
+	CPU_RST_STATUS_NA = 0,
+	CPU_RST_STATUS_SOFT_RST_DONE = 1,
+};
+
 /*
  * struct dcore_monitor_regs_data - DCORE monitor regs data.
  * the structure follows sync manager block layout. relevant only to Gaudi.
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 15f91ae9de6e..a3594119bc51 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -525,6 +525,13 @@ struct lkd_fw_comms_msg {
 		struct {
 			__u8 fw_cfg_skip; /* 1 - skip, 0 - don't skip */
 		};
+		struct {
+			__le64 tpc_binning_conf;
+			__le32 dec_binning_conf;
+			__le32 hbm_binning_conf;
+			__le32 edma_binning_conf;
+			__le32 mme_redundancy_conf; /* use MME_REDUNDANT_COLUMN */
+		};
 	};
 };
 
-- 
2.25.1


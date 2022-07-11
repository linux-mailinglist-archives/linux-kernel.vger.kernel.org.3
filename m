Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF656D4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiGKGau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiGKGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CE9FED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8005B611E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B298C34115
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521021;
        bh=PkPPf/0K5iv1rTiWjYmeuajFfHNRZuvpRN0RErubXDE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ddqNO9ktkpxVHDBnTRpjEmBMKlnl2Gxlyi2RYdRI6/cserm0n8LRBur4foKdJUV2O
         2/Slt2KyoRu8HTuaafV3xO2fKNw1nfe0TSGuZbNmOxw79R2R5xtAN6mCGEwdQ0bJuO
         jhvg73GZl+T+Ci4a6syQKfW0sXcn0pIOLAuijZdD1r4TRTeWhMb6ZsK/yIx+V83QnX
         2eTOG6hJ3W6vaDmWLFRrHYEe/S3Xy2y9TQLkHk7Tt/4yL04hFtjOEPHa/xhDXm+xQ4
         lix7gCJrkZDvmxWf2pK8Ke65E8cffLeW88OYxWH1YVmWSZ6lFxm8FRL3rV0JlUgEpi
         DTVAMD3g+2Wbg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] habanalabs: rename soft reset to compute reset
Date:   Mon, 11 Jul 2022 09:30:02 +0300
Message-Id: <20220711063003.3182795-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing compute reset can be the traditional inference soft reset
that is supported only in Goya.

Or it can be the new reset upon device release, which is supported
in Gaudi2 and above.

Therefore, wherever suitable, use the terminology of compute reset
instead of soft reset.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 28 +++++++++----------
 drivers/misc/habanalabs/common/firmware_if.c  |  4 +--
 drivers/misc/habanalabs/common/habanalabs.h   | 16 +++++------
 .../misc/habanalabs/common/habanalabs_ioctl.c |  2 +-
 drivers/misc/habanalabs/common/irq.c          |  2 +-
 drivers/misc/habanalabs/common/sysfs.c        |  2 +-
 drivers/misc/habanalabs/gaudi2/gaudi2.c       |  4 +--
 drivers/misc/habanalabs/goya/goya.c           |  2 +-
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 19c049046383..b30aeb1c657f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -272,7 +272,7 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 	enum hl_device_status status;
 
 	if (hdev->reset_info.in_reset) {
-		if (hdev->reset_info.is_in_soft_reset)
+		if (hdev->reset_info.in_compute_reset)
 			status = HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE;
 		else
 			status = HL_DEVICE_STATUS_IN_RESET;
@@ -1306,7 +1306,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	skip_wq_flush = !!(flags & HL_DRV_RESET_DEV_RELEASE);
 	delay_reset = !!(flags & HL_DRV_RESET_DELAY);
 
-	if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
+	if (!hard_reset && !hdev->asic_prop.supports_compute_reset) {
 		hard_instead_soft = true;
 		hard_reset = true;
 	}
@@ -1329,7 +1329,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	}
 
 	if (hard_instead_soft)
-		dev_dbg(hdev->dev, "Doing hard-reset instead of soft-reset\n");
+		dev_dbg(hdev->dev, "Doing hard-reset instead of compute reset\n");
 
 do_reset:
 	/* Re-entry of reset thread */
@@ -1345,17 +1345,17 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		/* Block future CS/VM/JOB completion operations */
 		spin_lock(&hdev->reset_info.lock);
 		if (hdev->reset_info.in_reset) {
-			/* We only allow scheduling of a hard reset during soft reset */
-			if (hard_reset && hdev->reset_info.is_in_soft_reset)
+			/* We only allow scheduling of a hard reset during compute reset */
+			if (hard_reset && hdev->reset_info.in_compute_reset)
 				hdev->reset_info.hard_reset_schedule_flags = flags;
 			spin_unlock(&hdev->reset_info.lock);
 			return 0;
 		}
 
 		/* This still allows the completion of some KDMA ops
-		 * Update this before in_reset because is_in_soft_reset implies we are in reset
+		 * Update this before in_reset because in_compute_reset implies we are in reset
 		 */
-		hdev->reset_info.is_in_soft_reset = !hard_reset;
+		hdev->reset_info.in_compute_reset = !hard_reset;
 
 		hdev->reset_info.in_reset = 1;
 
@@ -1562,7 +1562,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 				dev_err(hdev->dev,
 					"Failed late init in reset after device release\n");
 			else
-				dev_err(hdev->dev, "Failed late init after soft reset\n");
+				dev_err(hdev->dev, "Failed late init after compute reset\n");
 			goto out_err;
 		}
 	}
@@ -1574,7 +1574,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	}
 
 	spin_lock(&hdev->reset_info.lock);
-	hdev->reset_info.is_in_soft_reset = 0;
+	hdev->reset_info.in_compute_reset = 0;
 
 	/* Schedule hard reset only if requested and if not already in hard reset.
 	 * We keep 'in_reset' enabled, so no other reset can go in during the hard
@@ -1604,11 +1604,11 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		 */
 		hdev->asic_funcs->enable_events_from_fw(hdev);
 	} else if (!reset_upon_device_release) {
-		hdev->reset_info.soft_reset_cnt++;
+		hdev->reset_info.compute_reset_cnt++;
 	}
 
 	if (schedule_hard_reset) {
-		dev_info(hdev->dev, "Performing hard reset scheduled during soft reset\n");
+		dev_info(hdev->dev, "Performing hard reset scheduled during compute reset\n");
 		flags = hdev->reset_info.hard_reset_schedule_flags;
 		hdev->reset_info.hard_reset_schedule_flags = 0;
 		hdev->disabled = true;
@@ -1623,7 +1623,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hdev->disabled = true;
 
 	spin_lock(&hdev->reset_info.lock);
-	hdev->reset_info.is_in_soft_reset = 0;
+	hdev->reset_info.in_compute_reset = 0;
 
 	if (hard_reset) {
 		dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
@@ -1637,8 +1637,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		goto again;
 	} else {
 		spin_unlock(&hdev->reset_info.lock);
-		dev_err(hdev->dev, "Failed to do soft-reset\n");
-		hdev->reset_info.soft_reset_cnt++;
+		dev_err(hdev->dev, "Failed to do compute reset\n");
+		hdev->reset_info.compute_reset_cnt++;
 		flags |= HL_DRV_RESET_HARD;
 		hard_reset = true;
 		goto again;
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index f80a8c9d2cc8..608ca67527a5 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -275,7 +275,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	mutex_lock(&hdev->send_cpu_message_lock);
 
 	/* CPU-CP messages can be sent during soft-reset */
-	if (hdev->disabled && !hdev->reset_info.is_in_soft_reset) {
+	if (hdev->disabled && !hdev->reset_info.in_compute_reset) {
 		rc = 0;
 		goto out;
 	}
@@ -314,7 +314,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		/* If FW performed reset just before sending it a packet, we will get a timeout.
 		 * This is expected behavior, hence no need for error message.
 		 */
-		if (!hl_device_operational(hdev, NULL) && !hdev->reset_info.is_in_soft_reset)
+		if (!hl_device_operational(hdev, NULL) && !hdev->reset_info.in_compute_reset)
 			dev_dbg(hdev->dev, "Device CPU packet timeout (0x%x) due to FW reset\n",
 					tmp);
 		else
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0e45f2be13ed..d59bba9e55c9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -647,7 +647,7 @@ struct hl_hints_range {
  *                         false otherwise.
  * @use_get_power_for_reset_history: To support backward compatibility for Goya
  *                                   and Gaudi
- * @supports_soft_reset: is soft reset supported.
+ * @supports_compute_reset: is a reset which is not a hard-reset supported by this asic.
  * @allow_inference_soft_reset: true if the ASIC supports soft reset that is
  *                              initiated by user or TDR. This is only true
  *                              in inference ASICs, as there is no real-world
@@ -760,7 +760,7 @@ struct asic_fixed_properties {
 	u8				dynamic_fw_load;
 	u8				gic_interrupts_enable;
 	u8				use_get_power_for_reset_history;
-	u8				supports_soft_reset;
+	u8				supports_compute_reset;
 	u8				allow_inference_soft_reset;
 	u8				configurable_stop_on_err;
 	u8				set_max_power_on_device_init;
@@ -2960,12 +2960,12 @@ struct last_error_session_info {
 /**
  * struct hl_reset_info - holds current device reset information.
  * @lock: lock to protect critical reset flows.
- * @soft_reset_cnt: number of soft reset since the driver was loaded.
- * @hard_reset_cnt: number of hard reset since the driver was loaded.
- * @hard_reset_schedule_flags: hard reset is scheduled to after current soft reset,
+ * @compute_reset_cnt: number of compte resets since the driver was loaded.
+ * @hard_reset_cnt: number of hard resets since the driver was loaded.
+ * @hard_reset_schedule_flags: hard reset is scheduled to after current compute reset,
  *                             here we hold the hard reset flags.
  * @in_reset: is device in reset flow.
- * @is_in_soft_reset: Device is currently in soft reset process.
+ * @in_compute_reset: Device is currently in reset but not in hard-reset.
  * @needs_reset: true if reset_on_lockup is false and device should be reset
  *               due to lockup.
  * @hard_reset_pending: is there a hard reset work pending.
@@ -2980,11 +2980,11 @@ struct last_error_session_info {
  */
 struct hl_reset_info {
 	spinlock_t	lock;
-	u32		soft_reset_cnt;
+	u32		compute_reset_cnt;
 	u32		hard_reset_cnt;
 	u32		hard_reset_schedule_flags;
 	u8		in_reset;
-	u8		is_in_soft_reset;
+	u8		in_compute_reset;
 	u8		needs_reset;
 	u8		hard_reset_pending;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 96e12ab7a924..6a30bd98ab5e 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -294,7 +294,7 @@ static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
 		return -EINVAL;
 
 	reset_count.hard_reset_cnt = hdev->reset_info.hard_reset_cnt;
-	reset_count.soft_reset_cnt = hdev->reset_info.soft_reset_cnt;
+	reset_count.soft_reset_cnt = hdev->reset_info.compute_reset_cnt;
 
 	return copy_to_user(out, &reset_count,
 		min((size_t) max_size, sizeof(reset_count))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index d60dafb03a8e..94d537fd4fde 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -411,7 +411,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 		 */
 		dma_rmb();
 
-		if (hdev->disabled && !hdev->reset_info.is_in_soft_reset) {
+		if (hdev->disabled && !hdev->reset_info.in_compute_reset) {
 			dev_warn(hdev->dev, "Device disabled but received an EQ event\n");
 			goto skip_irq;
 		}
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index edebdf960785..6c5271f01160 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -291,7 +291,7 @@ static ssize_t soft_reset_cnt_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", hdev->reset_info.soft_reset_cnt);
+	return sprintf(buf, "%d\n", hdev->reset_info.compute_reset_cnt);
 }
 
 static ssize_t hard_reset_cnt_show(struct device *dev,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index eba8b0d674c3..2ce1fed8ef26 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2392,7 +2392,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 	/* No point of asking this information again when not doing hard reset, as the device
 	 * CPU hasn't been reset
 	 */
-	if (hdev->reset_info.is_in_soft_reset)
+	if (hdev->reset_info.in_compute_reset)
 		return 0;
 
 	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
@@ -3014,7 +3014,7 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 	hdev->supports_cb_mapping = true;
 	hdev->supports_wait_for_multi_cs = false;
 
-	prop->supports_soft_reset = true;
+	prop->supports_compute_reset = true;
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 216570938b91..573f8f7df976 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1038,7 +1038,7 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	spin_lock_init(&goya->hw_queues_lock);
 	hdev->supports_coresight = true;
-	hdev->asic_prop.supports_soft_reset = true;
+	hdev->asic_prop.supports_compute_reset = true;
 	hdev->asic_prop.allow_inference_soft_reset = true;
 	hdev->supports_wait_for_multi_cs = false;
 
-- 
2.25.1


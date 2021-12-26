Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A747F6CA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhLZMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhLZMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:43:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D05C061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 04:43:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB7560DF2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B37C36AEB;
        Sun, 26 Dec 2021 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522592;
        bh=OQCXK48sXXKifWlnLy97VS6e7cOaq5/8jLhfDTkGdjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vApz6EidVJuDLDg3fP99pD7+8sut04zJ70E61OGFvI+FkX5Nz2zpRJ6t22PJVUvCC
         PUkC33ULNwglqhdZs9APNFWshsTno79xJdc4tuAQ4bYIl/2RApXuim7FGIzPuPby06
         BK1PT0MPYYMJ4fi/9pynpoyIxQSxcXlL4xZgsYwH7IR1SygQumxymk2wjLxeqeBPn5
         ycITGMUVRJMEqNdfta6VAUTPhPGY3n1tS5bcQhXi/XIGCagAzQxdC374CzVMBReNxt
         dQgKmTwX+NN3RE+DwPsd4tiIM956RLzqnVOqTDMKuTDurqNg7U8S3j7DBLj7Oe035G
         ZgnAYOpX84E+w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/5] habanalabs: refactor reset information variables
Date:   Sun, 26 Dec 2021 14:43:02 +0200
Message-Id: <20211226124304.237107-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226124304.237107-1-ogabbay@kernel.org>
References: <20211226124304.237107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Unify variables related to device reset, which will help us to
add some new reset functionality in future patches.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  2 +-
 .../habanalabs/common/command_submission.c    |  4 +-
 drivers/misc/habanalabs/common/debugfs.c      | 18 ++---
 drivers/misc/habanalabs/common/device.c       | 76 +++++++++---------
 drivers/misc/habanalabs/common/firmware_if.c  |  6 +-
 drivers/misc/habanalabs/common/habanalabs.h   | 79 +++++++++++--------
 .../misc/habanalabs/common/habanalabs_drv.c   |  4 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |  4 +-
 drivers/misc/habanalabs/common/irq.c          |  2 +-
 drivers/misc/habanalabs/common/memory.c       |  2 +-
 drivers/misc/habanalabs/common/sysfs.c        | 10 +--
 drivers/misc/habanalabs/gaudi/gaudi.c         |  8 +-
 drivers/misc/habanalabs/goya/goya.c           | 10 +--
 13 files changed, 119 insertions(+), 106 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index e7534b5129fa..649380bb189f 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -250,7 +250,7 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	 * Can't use generic function to check this because of special case
 	 * where we create a CB as part of the reset process
 	 */
-	if ((hdev->disabled) || ((atomic_read(&hdev->in_reset)) &&
+	if ((hdev->disabled) || ((atomic_read(&hdev->reset_info.in_reset)) &&
 					(ctx_id != HL_KERNEL_ASID_ID))) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is disabled or in reset. Can't create new CBs\n");
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index d39343f90bc2..0a4ef13d9ac4 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -777,7 +777,7 @@ static void cs_timedout(struct work_struct *work)
 		if (hdev->reset_on_lockup)
 			hl_device_reset(hdev, HL_DRV_RESET_TDR);
 		else
-			hdev->needs_reset = true;
+			hdev->reset_info.needs_reset = true;
 	}
 }
 
@@ -814,7 +814,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->encaps_signals = !!(flags & HL_CS_FLAGS_ENCAP_SIGNALS);
 	cs->timeout_jiffies = timeout;
 	cs->skip_reset_on_timeout =
-		hdev->skip_reset_on_timeout ||
+		hdev->reset_info.skip_reset_on_timeout ||
 		!!(flags & HL_CS_FLAGS_SKIP_RESET_ON_TIMEOUT);
 	cs->submission_time_jiffies = jiffies;
 	INIT_LIST_HEAD(&cs->job_list);
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 2e9c31d79d5e..746d1a18de63 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -527,7 +527,7 @@ static int engines_show(struct seq_file *s, void *data)
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't check device idle during reset\n");
 		return 0;
@@ -658,7 +658,7 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	ssize_t rc;
 	u32 val;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
 		return 0;
 	}
@@ -694,7 +694,7 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	u32 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev, "Can't write during reset\n");
 		return 0;
 	}
@@ -731,7 +731,7 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 	ssize_t rc;
 	u64 val;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
 		return 0;
 	}
@@ -767,7 +767,7 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	u64 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev, "Can't write during reset\n");
 		return 0;
 	}
@@ -802,7 +802,7 @@ static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
 	ssize_t rc;
 	u32 size;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev, "Can't DMA during reset\n");
 		return 0;
 	}
@@ -1077,7 +1077,7 @@ static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
 	u64 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't change clock gating during reset\n");
 		return 0;
@@ -1119,7 +1119,7 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 	u32 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->in_reset)) {
+	if (atomic_read(&hdev->reset_info.in_reset)) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't change stop on error during reset\n");
 		return 0;
@@ -1497,7 +1497,7 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	debugfs_create_x8("skip_reset_on_timeout",
 				0644,
 				dev_entry->root,
-				&hdev->skip_reset_on_timeout);
+				&hdev->reset_info.skip_reset_on_timeout);
 
 	debugfs_create_file("state_dump",
 				0600,
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index f1f482c5cdcb..f8f9eb7a934f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -17,9 +17,9 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
 
-	if (atomic_read(&hdev->in_reset))
+	if (atomic_read(&hdev->reset_info.in_reset))
 		status = HL_DEVICE_STATUS_IN_RESET;
-	else if (hdev->needs_reset)
+	else if (hdev->reset_info.needs_reset)
 		status = HL_DEVICE_STATUS_NEEDS_RESET;
 	else if (hdev->disabled)
 		status = HL_DEVICE_STATUS_MALFUNCTION;
@@ -452,7 +452,7 @@ static int device_early_init(struct hl_device *hdev)
 	INIT_LIST_HEAD(&hdev->fpriv_ctrl_list);
 	mutex_init(&hdev->fpriv_list_lock);
 	mutex_init(&hdev->fpriv_ctrl_list_lock);
-	atomic_set(&hdev->in_reset, 0);
+	atomic_set(&hdev->reset_info.in_reset, 0);
 	mutex_init(&hdev->clk_throttling.lock);
 
 	return 0;
@@ -544,8 +544,8 @@ static void hl_device_heartbeat(struct work_struct *work)
 	 * status for at least one heartbeat. From this point driver restarts
 	 * tracking future consecutive fatal errors.
 	 */
-	if (!(atomic_read(&hdev->in_reset)))
-		hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
+	if (!(atomic_read(&hdev->reset_info.in_reset)))
+		hdev->reset_info.prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
 
 	schedule_delayed_work(&hdev->work_heartbeat,
 			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
@@ -639,12 +639,12 @@ int hl_device_set_debug_mode(struct hl_device *hdev, struct hl_ctx *ctx, bool en
 			goto out;
 		}
 
-		if (!hdev->hard_reset_pending)
+		if (!hdev->reset_info.hard_reset_pending)
 			hdev->asic_funcs->halt_coresight(hdev, ctx);
 
 		hdev->in_debug = 0;
 
-		if (!hdev->hard_reset_pending)
+		if (!hdev->reset_info.hard_reset_pending)
 			hdev->asic_funcs->set_clock_gating(hdev);
 
 		goto out;
@@ -722,7 +722,7 @@ int hl_device_suspend(struct hl_device *hdev)
 	pci_save_state(hdev->pdev);
 
 	/* Block future CS/VM/JOB completion operations */
-	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+	rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
 	if (rc) {
 		dev_err(hdev->dev, "Can't suspend while in reset\n");
 		return -EIO;
@@ -777,7 +777,7 @@ int hl_device_resume(struct hl_device *hdev)
 
 
 	hdev->disabled = false;
-	atomic_set(&hdev->in_reset, 0);
+	atomic_set(&hdev->reset_info.in_reset, 0);
 
 	rc = hl_device_reset(hdev, HL_DRV_RESET_HARD);
 	if (rc) {
@@ -906,16 +906,16 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 	 * 'reset_cause' will continue holding its 1st recorded reason!
 	 */
 	if (flags & HL_DRV_RESET_HEARTBEAT) {
-		hdev->curr_reset_cause = HL_RESET_CAUSE_HEARTBEAT;
+		hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_HEARTBEAT;
 		cur_reset_trigger = HL_DRV_RESET_HEARTBEAT;
 	} else if (flags & HL_DRV_RESET_TDR) {
-		hdev->curr_reset_cause = HL_RESET_CAUSE_TDR;
+		hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_TDR;
 		cur_reset_trigger = HL_DRV_RESET_TDR;
 	} else if (flags & HL_DRV_RESET_FW_FATAL_ERR) {
-		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+		hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 		cur_reset_trigger = HL_DRV_RESET_FW_FATAL_ERR;
 	} else {
-		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+		hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 	}
 
 	/*
@@ -923,11 +923,11 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 	 * is set and if this reset is due to a fatal FW error
 	 * device is set to an unstable state.
 	 */
-	if (hdev->prev_reset_trigger != cur_reset_trigger) {
-		hdev->prev_reset_trigger = cur_reset_trigger;
-		hdev->reset_trigger_repeated = 0;
+	if (hdev->reset_info.prev_reset_trigger != cur_reset_trigger) {
+		hdev->reset_info.prev_reset_trigger = cur_reset_trigger;
+		hdev->reset_info.reset_trigger_repeated = 0;
 	} else {
-		hdev->reset_trigger_repeated = 1;
+		hdev->reset_info.reset_trigger_repeated = 1;
 	}
 
 	/* If reset is due to heartbeat, device CPU is no responsive in
@@ -987,7 +987,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
 	fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
 
-	if (!hard_reset && !hdev->supports_soft_reset) {
+	if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
 		hard_instead_soft = true;
 		hard_reset = true;
 	}
@@ -1004,7 +1004,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		goto do_reset;
 	}
 
-	if (!hard_reset && !hdev->allow_inference_soft_reset) {
+	if (!hard_reset && !hdev->asic_prop.allow_inference_soft_reset) {
 		hard_instead_soft = true;
 		hard_reset = true;
 	}
@@ -1024,13 +1024,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	 */
 	if (!from_hard_reset_thread) {
 		/* Block future CS/VM/JOB completion operations */
-		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+		rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
 		if (rc)
 			return 0;
 
 		handle_reset_trigger(hdev, flags);
 
-		hdev->is_in_soft_reset = !hard_reset;
+		/* This still allows the completion of some KDMA ops */
+		hdev->reset_info.is_in_soft_reset = !hard_reset;
 
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
@@ -1047,7 +1048,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 again:
 	if ((hard_reset) && (!from_hard_reset_thread)) {
-		hdev->hard_reset_pending = true;
+		hdev->reset_info.hard_reset_pending = true;
 
 		hdev->process_kill_trial_cnt = 0;
 
@@ -1128,10 +1129,11 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 	if (hard_reset) {
 		hdev->device_cpu_disabled = false;
-		hdev->hard_reset_pending = false;
+		hdev->reset_info.hard_reset_pending = false;
 
-		if (hdev->reset_trigger_repeated &&
-				(hdev->prev_reset_trigger == HL_DRV_RESET_FW_FATAL_ERR)) {
+		if (hdev->reset_info.reset_trigger_repeated &&
+				(hdev->reset_info.prev_reset_trigger ==
+						HL_DRV_RESET_FW_FATAL_ERR)) {
 			/* if there 2 back to back resets from FW,
 			 * ensure driver puts the driver in a unusable state
 			 */
@@ -1182,7 +1184,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	 * is required for the initialization itself
 	 */
 	hdev->disabled = false;
-	hdev->is_in_soft_reset = false;
+	hdev->reset_info.is_in_soft_reset = false;
 
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
@@ -1232,13 +1234,13 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		}
 	}
 
-	atomic_set(&hdev->in_reset, 0);
-	hdev->needs_reset = false;
+	atomic_set(&hdev->reset_info.in_reset, 0);
+	hdev->reset_info.needs_reset = false;
 
 	dev_notice(hdev->dev, "Successfully finished resetting the device\n");
 
 	if (hard_reset) {
-		hdev->hard_reset_cnt++;
+		hdev->reset_info.hard_reset_cnt++;
 
 		/* After reset is done, we are ready to receive events from
 		 * the F/W. We can't do it before because we will ignore events
@@ -1247,30 +1249,30 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		 */
 		hdev->asic_funcs->enable_events_from_fw(hdev);
 	} else if (!reset_upon_device_release) {
-		hdev->soft_reset_cnt++;
+		hdev->reset_info.soft_reset_cnt++;
 	}
 
 	return 0;
 
 out_err:
 	hdev->disabled = true;
-	hdev->is_in_soft_reset = false;
+	hdev->reset_info.is_in_soft_reset = false;
 
 	if (hard_reset) {
 		dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
-		hdev->hard_reset_cnt++;
+		hdev->reset_info.hard_reset_cnt++;
 	} else if (reset_upon_device_release) {
 		dev_err(hdev->dev, "Failed to reset device after user release\n");
 		hard_reset = true;
 		goto again;
 	} else {
 		dev_err(hdev->dev, "Failed to do soft-reset\n");
-		hdev->soft_reset_cnt++;
+		hdev->reset_info.soft_reset_cnt++;
 		hard_reset = true;
 		goto again;
 	}
 
-	atomic_set(&hdev->in_reset, 0);
+	atomic_set(&hdev->reset_info.in_reset, 0);
 
 	return rc;
 }
@@ -1604,10 +1606,10 @@ void hl_device_fini(struct hl_device *hdev)
 	 */
 
 	timeout = ktime_add_us(ktime_get(), reset_sec * 1000 * 1000);
-	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+	rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
 	while (rc) {
 		usleep_range(50, 200);
-		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+		rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
 		if (ktime_compare(ktime_get(), timeout) > 0) {
 			dev_crit(hdev->dev,
 				"Failed to remove device because reset function did not finish\n");
@@ -1629,7 +1631,7 @@ void hl_device_fini(struct hl_device *hdev)
 
 	take_release_locks(hdev);
 
-	hdev->hard_reset_pending = true;
+	hdev->reset_info.hard_reset_pending = true;
 
 	hl_hwmon_fini(hdev);
 
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2cc2015c2416..6775c5c3166b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2371,14 +2371,14 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	if (rc)
 		goto protocol_err;
 
-	if (hdev->curr_reset_cause) {
+	if (hdev->reset_info.curr_reset_cause) {
 		rc = hl_fw_dynamic_send_msg(hdev, fw_loader,
-				HL_COMMS_RESET_CAUSE_TYPE, &hdev->curr_reset_cause);
+				HL_COMMS_RESET_CAUSE_TYPE, &hdev->reset_info.curr_reset_cause);
 		if (rc)
 			goto protocol_err;
 
 		/* Clear current reset cause */
-		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+		hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 	}
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index fc1bdc07a169..47eaeff9e924 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -547,6 +547,13 @@ struct hl_hints_range {
  *                         false otherwise.
  * @use_get_power_for_reset_history: To support backward compatibility for Goya
  *                                   and Gaudi
+ * @supports_soft_reset: is soft reset supported.
+ * @allow_inference_soft_reset: true if the ASIC supports soft reset that is
+ *                              initiated by user or TDR. This is only true
+ *                              in inference ASICs, as there is no real-world
+ *                              use-case of doing soft-reset in training (due
+ *                              to the fact that training runs on multiple
+ *                              devices)
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -628,6 +635,8 @@ struct asic_fixed_properties {
 	u8				dynamic_fw_load;
 	u8				gic_interrupts_enable;
 	u8				use_get_power_for_reset_history;
+	u8				supports_soft_reset;
+	u8				allow_inference_soft_reset;
 };
 
 /**
@@ -2446,6 +2455,39 @@ struct last_error_session_info {
 	u8		razwi_type;
 };
 
+/**
+ * struct hl_reset_info - holds current device reset information.
+ * @in_reset: is device in reset flow.
+ * @soft_reset_cnt: number of soft reset since the driver was loaded.
+ * @hard_reset_cnt: number of hard reset since the driver was loaded.
+ * @is_in_soft_reset: Device is currently in soft reset process.
+ * @needs_reset: true if reset_on_lockup is false and device should be reset
+ *               due to lockup.
+ * @hard_reset_pending: is there a hard reset work pending.
+ * @curr_reset_cause: saves an enumerated reset cause when a hard reset is
+ *                    triggered, and cleared after it is shared with preboot.
+ * @prev_reset_trigger: saves the previous trigger which caused a reset, overidden
+ *                      with a new value on next reset
+ * @reset_trigger_repeated: set if device reset is triggered more than once with
+ *                          same cause.
+ * @skip_reset_on_timeout: Skip device reset if CS has timed out, wait for it to
+ *                         complete instead.
+ */
+struct hl_reset_info {
+	atomic_t	in_reset;
+	u32		soft_reset_cnt;
+	u32		hard_reset_cnt;
+	u8		is_in_soft_reset;
+	u8		needs_reset;
+	u8		hard_reset_pending;
+
+	u8		curr_reset_cause;
+	u8		prev_reset_trigger;
+	u8		reset_trigger_repeated;
+
+	u8		skip_reset_on_timeout;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -2514,6 +2556,7 @@ struct last_error_session_info {
  * @state_dump_specs: constants and dictionaries needed to dump system state.
  * @multi_cs_completion: array of multi-CS completion.
  * @clk_throttling: holds information about current/previous clock throttling events
+ * @reset_info: holds current device reset information.
  * @last_error: holds information about last session in which CS timeout or razwi error occurred.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @dram_used_mem: current DRAM memory consumption.
@@ -2538,13 +2581,10 @@ struct last_error_session_info {
  *                                  session.
  * @open_counter: number of successful device open operations.
  * @fw_poll_interval_usec: FW status poll interval in usec.
- * @in_reset: is device in reset flow.
  * @card_type: Various ASICs have several card types. This indicates the card
  *             type of the current device.
  * @major: habanalabs kernel driver major.
  * @high_pll: high PLL profile frequency.
- * @soft_reset_cnt: number of soft reset since the driver was loaded.
- * @hard_reset_cnt: number of hard reset since the driver was loaded.
  * @id: device minor.
  * @id_control: minor of the control device
  * @cpu_pci_msb_addr: 50-bit extension bits for the device CPU's 40-bit
@@ -2552,7 +2592,6 @@ struct last_error_session_info {
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
- * @hard_reset_pending: is there a hard reset work pending.
  * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.
  * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
  *                   otherwise.
@@ -2575,35 +2614,17 @@ struct last_error_session_info {
  * @sync_stream_queue_idx: helper index for sync stream queues initialization.
  * @collective_mon_idx: helper index for collective initialization
  * @supports_coresight: is CoreSight supported.
- * @supports_soft_reset: is soft reset supported.
- * @allow_inference_soft_reset: true if the ASIC supports soft reset that is
- *                              initiated by user or TDR. This is only true
- *                              in inference ASICs, as there is no real-world
- *                              use-case of doing soft-reset in training (due
- *                              to the fact that training runs on multiple
- *                              devices)
  * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
- * @needs_reset: true if reset_on_lockup is false and device should be reset
- *               due to lockup.
  * @process_kill_trial_cnt: number of trials reset thread tried killing
  *                          user processes
  * @device_fini_pending: true if device_fini was called and might be
  *                       waiting for the reset thread to finish
  * @supports_staged_submission: true if staged submissions are supported
- * @curr_reset_cause: saves an enumerated reset cause when a hard reset is
- *                    triggered, and cleared after it is shared with preboot.
- * @prev_reset_trigger: saves the previous trigger which caused a reset, overidden
- *                      with a new value on next reset
- * @reset_trigger_repeated: set if device reset is triggered more than once with
- *                          same cause.
- * @skip_reset_on_timeout: Skip device reset if CS has timed out, wait for it to
- *                         complete instead.
  * @device_cpu_is_halted: Flag to indicate whether the device CPU was already
  *                        halted. We can't halt it again because the COMMS
  *                        protocol will throw an error. Relevant only for
  *                        cases where Linux was not loaded to device CPU
  * @supports_wait_for_multi_cs: true if wait for multi CS is supported
- * @is_in_soft_reset: Device is currently in soft reset process.
  * @is_compute_ctx_active: Whether there is an active compute context executing.
  */
 struct hl_device {
@@ -2678,6 +2699,8 @@ struct hl_device {
 	struct hl_clk_throttle		clk_throttling;
 	struct last_error_session_info	last_error;
 
+	struct hl_reset_info		reset_info;
+
 	u32				*stream_master_qid_arr;
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
@@ -2689,20 +2712,16 @@ struct hl_device {
 	u64				last_open_session_duration_jif;
 	u64				open_counter;
 	u64				fw_poll_interval_usec;
-	atomic_t			in_reset;
 	ktime_t				last_successful_open_ktime;
 	enum cpucp_card_types		card_type;
 	u32				major;
 	u32				high_pll;
-	u32				soft_reset_cnt;
-	u32				hard_reset_cnt;
 	u16				id;
 	u16				id_control;
 	u16				cpu_pci_msb_addr;
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
-	u8				hard_reset_pending;
 	u8				heartbeat;
 	u8				reset_on_lockup;
 	u8				dram_default_page_mapping;
@@ -2719,21 +2738,13 @@ struct hl_device {
 	u8				sync_stream_queue_idx;
 	u8				collective_mon_idx;
 	u8				supports_coresight;
-	u8				supports_soft_reset;
-	u8				allow_inference_soft_reset;
 	u8				supports_cb_mapping;
-	u8				needs_reset;
 	u8				process_kill_trial_cnt;
 	u8				device_fini_pending;
 	u8				supports_staged_submission;
-	u8				curr_reset_cause;
-	u8				prev_reset_trigger;
-	u8				reset_trigger_repeated;
-	u8				skip_reset_on_timeout;
 	u8				device_cpu_is_halted;
 	u8				supports_wait_for_multi_cs;
 	u8				stream_master_qid_arr_size;
-	u8				is_in_soft_reset;
 	u8				is_compute_ctx_active;
 
 	/* Parameters for bring-up */
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index aa4e07b1f839..690b763c7a95 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -289,8 +289,8 @@ static int fixup_device_params(struct hl_device *hdev)
 	hdev->fw_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 
 	hdev->stop_on_err = true;
-	hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
-	hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
+	hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+	hdev->reset_info.prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
 
 	/* Enable only after the initialization of the device */
 	hdev->disabled = true;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 7ddf70a0ca8a..3ba3a8ffda3e 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -269,8 +269,8 @@ static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	reset_count.hard_reset_cnt = hdev->hard_reset_cnt;
-	reset_count.soft_reset_cnt = hdev->soft_reset_cnt;
+	reset_count.hard_reset_cnt = hdev->reset_info.hard_reset_cnt;
+	reset_count.soft_reset_cnt = hdev->reset_info.soft_reset_cnt;
 
 	return copy_to_user(out, &reset_count,
 		min((size_t) max_size, sizeof(reset_count))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 6454ea12bf3a..1b6bdc900c26 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -249,7 +249,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 		 */
 		dma_rmb();
 
-		if (hdev->disabled && !hdev->is_in_soft_reset) {
+		if (hdev->disabled && !hdev->reset_info.is_in_soft_reset) {
 			dev_warn(hdev->dev, "Device disabled but received an EQ event\n");
 			goto skip_irq;
 		}
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index b8596846f3dc..c1eefaebacb6 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2624,7 +2624,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	 * Clearly something went wrong on hard reset so no point in printing
 	 * another side effect error
 	 */
-	if (!hdev->hard_reset_pending && !hash_empty(ctx->mem_hash))
+	if (!hdev->reset_info.hard_reset_pending && !hash_empty(ctx->mem_hash))
 		dev_dbg(hdev->dev,
 			"user released device without removing its memory mappings\n");
 
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 1af568e46f46..45c715325e2a 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -211,7 +211,7 @@ static ssize_t soft_reset_store(struct device *dev,
 		goto out;
 	}
 
-	if (!hdev->allow_inference_soft_reset) {
+	if (!hdev->asic_prop.allow_inference_soft_reset) {
 		dev_err(hdev->dev, "Device does not support inference soft-reset\n");
 		goto out;
 	}
@@ -303,7 +303,7 @@ static ssize_t soft_reset_cnt_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", hdev->soft_reset_cnt);
+	return sprintf(buf, "%d\n", hdev->reset_info.soft_reset_cnt);
 }
 
 static ssize_t hard_reset_cnt_show(struct device *dev,
@@ -311,7 +311,7 @@ static ssize_t hard_reset_cnt_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", hdev->hard_reset_cnt);
+	return sprintf(buf, "%d\n", hdev->reset_info.hard_reset_cnt);
 }
 
 static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
@@ -478,7 +478,7 @@ int hl_sysfs_init(struct hl_device *hdev)
 		return rc;
 	}
 
-	if (!hdev->allow_inference_soft_reset)
+	if (!hdev->asic_prop.allow_inference_soft_reset)
 		return 0;
 
 	rc = device_add_groups(hdev->dev, hl_dev_inference_attr_groups);
@@ -495,7 +495,7 @@ void hl_sysfs_fini(struct hl_device *hdev)
 {
 	device_remove_groups(hdev->dev, hl_dev_attr_groups);
 
-	if (!hdev->allow_inference_soft_reset)
+	if (!hdev->asic_prop.allow_inference_soft_reset)
 		return;
 
 	device_remove_groups(hdev->dev, hl_dev_inference_attr_groups);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b3431eac4f04..013c6da2e3ca 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4325,7 +4325,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset
 		 * In case watchdog hasn't expired but we still got HB, then this won't do any
 		 * damage.
 		 */
-		if (hdev->curr_reset_cause == HL_RESET_CAUSE_HEARTBEAT) {
+		if (hdev->reset_info.curr_reset_cause == HL_RESET_CAUSE_HEARTBEAT) {
 			if (hdev->asic_prop.hard_reset_done_by_fw)
 				hl_fw_ask_hard_reset_without_linux(hdev);
 			else
@@ -6564,7 +6564,7 @@ static u64 gaudi_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
-	if (hdev->hard_reset_pending)
+	if (hdev->reset_info.hard_reset_pending)
 		return U64_MAX;
 
 	return readq(hdev->pcie_bar[HBM_BAR_ID] +
@@ -6575,7 +6575,7 @@ static void gaudi_write_pte(struct hl_device *hdev, u64 addr, u64 val)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
-	if (hdev->hard_reset_pending)
+	if (hdev->reset_info.hard_reset_pending)
 		return;
 
 	writeq(val, hdev->pcie_bar[HBM_BAR_ID] +
@@ -8341,7 +8341,7 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	int rc;
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU) ||
-		hdev->hard_reset_pending)
+		hdev->reset_info.hard_reset_pending)
 		return 0;
 
 	if (hdev->pldm)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f4473013f1ee..fbcc7bbf44b3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1033,8 +1033,8 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	spin_lock_init(&goya->hw_queues_lock);
 	hdev->supports_coresight = true;
-	hdev->supports_soft_reset = true;
-	hdev->allow_inference_soft_reset = true;
+	hdev->asic_prop.supports_soft_reset = true;
+	hdev->asic_prop.allow_inference_soft_reset = true;
 	hdev->supports_wait_for_multi_cs = false;
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
@@ -4477,7 +4477,7 @@ static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
-	if (hdev->hard_reset_pending)
+	if (hdev->reset_info.hard_reset_pending)
 		return U64_MAX;
 
 	return readq(hdev->pcie_bar[DDR_BAR_ID] +
@@ -4488,7 +4488,7 @@ static void goya_write_pte(struct hl_device *hdev, u64 addr, u64 val)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
-	if (hdev->hard_reset_pending)
+	if (hdev->reset_info.hard_reset_pending)
 		return;
 
 	writeq(val, hdev->pcie_bar[DDR_BAR_ID] +
@@ -5308,7 +5308,7 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	int rc;
 
 	if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
-		hdev->hard_reset_pending)
+		hdev->reset_info.hard_reset_pending)
 		return 0;
 
 	/* no need in L1 only invalidation in Goya */
-- 
2.25.1


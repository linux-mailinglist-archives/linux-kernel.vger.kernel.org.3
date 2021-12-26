Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E156847F6C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhLZMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhLZMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:43:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C0C061757
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 04:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5DC60C99
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9677EC36AE9;
        Sun, 26 Dec 2021 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522593;
        bh=ZUK99mIaFRZJ82X3FpuK7kVm07gbjrdNWNk8TJ+XpoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4Qz+lqItMCRVAqb+7BmFBpyy8XfkzyzEzkOWobHtjywjfkxdPiywidu9y9wsSHkL
         v8NR75LfkSUOOUv1LAT8yTN1Hn5GwMigGKuaRRVkyJuQgIRvygxugFrh4Roz4nJ4YK
         zXBlVh4kaL12liyytLsEJH+AodC83fuLGDF3FXu5qKN2NSaWwD0pKr2eJ2nAua0ws1
         mIU8j09LLBA2lNePgZ7AIFddVza6u0zoSkoMhtksQxNDt4j2iOADq46LfGtcliPMI2
         y8MDnEv7GQ9CxAowEDM0ZDh7pCYgBBUlxWx3PpoDkS6dC8QrwsEhHP6K6JQ48Cz4Q+
         achHKunNhJu1w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/5] habanalabs: add a lock to protect multiple reset variables
Date:   Sun, 26 Dec 2021 14:43:03 +0200
Message-Id: <20211226124304.237107-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226124304.237107-1-ogabbay@kernel.org>
References: <20211226124304.237107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Atomic operations during reset are replaced by a spinlock in order
to have the ability to protect more than a single variable.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  3 +-
 drivers/misc/habanalabs/common/debugfs.c      | 16 +++---
 drivers/misc/habanalabs/common/device.c       | 50 +++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h   |  6 ++-
 4 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 649380bb189f..3c0ae07a2d80 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -250,8 +250,7 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	 * Can't use generic function to check this because of special case
 	 * where we create a CB as part of the reset process
 	 */
-	if ((hdev->disabled) || ((atomic_read(&hdev->reset_info.in_reset)) &&
-					(ctx_id != HL_KERNEL_ASID_ID))) {
+	if ((hdev->disabled) || (hdev->reset_info.in_reset && (ctx_id != HL_KERNEL_ASID_ID))) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is disabled or in reset. Can't create new CBs\n");
 		rc = -EBUSY;
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 746d1a18de63..fc084ee5106e 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -527,7 +527,7 @@ static int engines_show(struct seq_file *s, void *data)
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't check device idle during reset\n");
 		return 0;
@@ -658,7 +658,7 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	ssize_t rc;
 	u32 val;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
 		return 0;
 	}
@@ -694,7 +694,7 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	u32 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev, "Can't write during reset\n");
 		return 0;
 	}
@@ -731,7 +731,7 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 	ssize_t rc;
 	u64 val;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
 		return 0;
 	}
@@ -767,7 +767,7 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	u64 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev, "Can't write during reset\n");
 		return 0;
 	}
@@ -802,7 +802,7 @@ static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
 	ssize_t rc;
 	u32 size;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev, "Can't DMA during reset\n");
 		return 0;
 	}
@@ -1077,7 +1077,7 @@ static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
 	u64 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't change clock gating during reset\n");
 		return 0;
@@ -1119,7 +1119,7 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 	u32 value;
 	ssize_t rc;
 
-	if (atomic_read(&hdev->reset_info.in_reset)) {
+	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't change stop on error during reset\n");
 		return 0;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index f8f9eb7a934f..84621ad765bc 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -17,7 +17,7 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
 
-	if (atomic_read(&hdev->reset_info.in_reset))
+	if (hdev->reset_info.in_reset)
 		status = HL_DEVICE_STATUS_IN_RESET;
 	else if (hdev->reset_info.needs_reset)
 		status = HL_DEVICE_STATUS_NEEDS_RESET;
@@ -448,11 +448,11 @@ static int device_early_init(struct hl_device *hdev)
 	mutex_init(&hdev->debug_lock);
 	INIT_LIST_HEAD(&hdev->cs_mirror_list);
 	spin_lock_init(&hdev->cs_mirror_lock);
+	spin_lock_init(&hdev->reset_info.lock);
 	INIT_LIST_HEAD(&hdev->fpriv_list);
 	INIT_LIST_HEAD(&hdev->fpriv_ctrl_list);
 	mutex_init(&hdev->fpriv_list_lock);
 	mutex_init(&hdev->fpriv_ctrl_list_lock);
-	atomic_set(&hdev->reset_info.in_reset, 0);
 	mutex_init(&hdev->clk_throttling.lock);
 
 	return 0;
@@ -544,7 +544,7 @@ static void hl_device_heartbeat(struct work_struct *work)
 	 * status for at least one heartbeat. From this point driver restarts
 	 * tracking future consecutive fatal errors.
 	 */
-	if (!(atomic_read(&hdev->reset_info.in_reset)))
+	if (!hdev->reset_info.in_reset)
 		hdev->reset_info.prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
 
 	schedule_delayed_work(&hdev->work_heartbeat,
@@ -722,11 +722,14 @@ int hl_device_suspend(struct hl_device *hdev)
 	pci_save_state(hdev->pdev);
 
 	/* Block future CS/VM/JOB completion operations */
-	rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
-	if (rc) {
+	spin_lock(&hdev->reset_info.lock);
+	if (hdev->reset_info.in_reset) {
+		spin_unlock(&hdev->reset_info.lock);
 		dev_err(hdev->dev, "Can't suspend while in reset\n");
 		return -EIO;
 	}
+	hdev->reset_info.in_reset = 1;
+	spin_unlock(&hdev->reset_info.lock);
 
 	/* This blocks all other stuff that is not blocked by in_reset */
 	hdev->disabled = true;
@@ -776,8 +779,10 @@ int hl_device_resume(struct hl_device *hdev)
 	}
 
 
-	hdev->disabled = false;
-	atomic_set(&hdev->reset_info.in_reset, 0);
+	/* 'in_reset' was set to true during suspend, now we must clear it in order
+	 * for hard reset to be performed
+	 */
+	hdev->reset_info.in_reset = 0;
 
 	rc = hl_device_reset(hdev, HL_DRV_RESET_HARD);
 	if (rc) {
@@ -1024,9 +1029,13 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	 */
 	if (!from_hard_reset_thread) {
 		/* Block future CS/VM/JOB completion operations */
-		rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
-		if (rc)
+		spin_lock(&hdev->reset_info.lock);
+		if (hdev->reset_info.in_reset) {
+			spin_unlock(&hdev->reset_info.lock);
 			return 0;
+		}
+		hdev->reset_info.in_reset = 1;
+		spin_unlock(&hdev->reset_info.lock);
 
 		handle_reset_trigger(hdev, flags);
 
@@ -1234,7 +1243,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		}
 	}
 
-	atomic_set(&hdev->reset_info.in_reset, 0);
+	hdev->reset_info.in_reset = 0;
 	hdev->reset_info.needs_reset = false;
 
 	dev_notice(hdev->dev, "Successfully finished resetting the device\n");
@@ -1272,7 +1281,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		goto again;
 	}
 
-	atomic_set(&hdev->reset_info.in_reset, 0);
+	hdev->reset_info.in_reset = 0;
 
 	return rc;
 }
@@ -1583,6 +1592,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
  */
 void hl_device_fini(struct hl_device *hdev)
 {
+	bool device_in_reset;
 	ktime_t timeout;
 	u64 reset_sec;
 	int i, rc;
@@ -1606,10 +1616,22 @@ void hl_device_fini(struct hl_device *hdev)
 	 */
 
 	timeout = ktime_add_us(ktime_get(), reset_sec * 1000 * 1000);
-	rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
-	while (rc) {
+
+	spin_lock(&hdev->reset_info.lock);
+	device_in_reset = !!hdev->reset_info.in_reset;
+	if (!device_in_reset)
+		hdev->reset_info.in_reset = 1;
+	spin_unlock(&hdev->reset_info.lock);
+
+	while (device_in_reset) {
 		usleep_range(50, 200);
-		rc = atomic_cmpxchg(&hdev->reset_info.in_reset, 0, 1);
+
+		spin_lock(&hdev->reset_info.lock);
+		device_in_reset = !!hdev->reset_info.in_reset;
+		if (!device_in_reset)
+			hdev->reset_info.in_reset = 1;
+		spin_unlock(&hdev->reset_info.lock);
+
 		if (ktime_compare(ktime_get(), timeout) > 0) {
 			dev_crit(hdev->dev,
 				"Failed to remove device because reset function did not finish\n");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 47eaeff9e924..37a3a469b42f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2457,9 +2457,10 @@ struct last_error_session_info {
 
 /**
  * struct hl_reset_info - holds current device reset information.
- * @in_reset: is device in reset flow.
+ * @lock: lock to protect critical reset flows.
  * @soft_reset_cnt: number of soft reset since the driver was loaded.
  * @hard_reset_cnt: number of hard reset since the driver was loaded.
+ * @in_reset: is device in reset flow.
  * @is_in_soft_reset: Device is currently in soft reset process.
  * @needs_reset: true if reset_on_lockup is false and device should be reset
  *               due to lockup.
@@ -2474,9 +2475,10 @@ struct last_error_session_info {
  *                         complete instead.
  */
 struct hl_reset_info {
-	atomic_t	in_reset;
+	spinlock_t	lock;
 	u32		soft_reset_cnt;
 	u32		hard_reset_cnt;
+	u8		in_reset;
 	u8		is_in_soft_reset;
 	u8		needs_reset;
 	u8		hard_reset_pending;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD94745F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhLNPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhLNPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1450C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:06:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACD96155F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39911C3460C;
        Tue, 14 Dec 2021 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494362;
        bh=lKVekf/yuYUzrh3XxQM41bp7/oWFKAa5vrIXITdrNpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTyWIxwHVDnZUZR+YWWXV7qzeKbC8+st3lewCEhs+Pohm2Mjtxb+hDOmhvw1FsXyv
         hnl1414Q2bsH8DVxZWx061MX6yIAMC4JlaEk2xeL5vvioZ1FDu5L2ez8Z3r4F7xdL5
         xM8YoSYZGHgXLptdFLYHslpMMzNOXMU+/X0DbRbHkWOC2dEVdrKxnP3sLmGSAmoDXp
         dTyf7m4Q8G9ho2wXTAkG8v1FDIt/lZ/7eu83hSK5l+vcfjZkgBXGJnD7da7WK+uApc
         pArkesoKon4AEET8JttXnr9TQgN+UYs3GYy7V8pfKBqlmQlfHSzlqc9E0n6fwoIINo
         E8/ZGSaRmbFUg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 05/11] habanalabs: keep control device alive during hard reset
Date:   Tue, 14 Dec 2021 17:05:45 +0200
Message-Id: <20211214150551.1568192-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Need to allow user retrieve data during reset and afterwards without
the need to reopen the device.
Did it by seperating the user peocesses list into two lists:
1. fpriv_list which contains list of user processes that opened
   the device (currently only one).
2. fpriv_ctrl_list which contains list of user processes that opened
   the control device. This processes in this list shall not be
   killed during reset, only when the device is suddenly removed from
   PCI chain.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c      |  8 +--
 drivers/misc/habanalabs/common/device.c       | 56 +++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h   |  7 ++-
 .../misc/habanalabs/common/habanalabs_drv.c   |  9 ++-
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 49e6f1172d18..c6360e33bce8 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -283,11 +283,9 @@ struct hl_ctx *hl_get_compute_ctx(struct hl_device *hdev)
 		/* There can only be a single user which has opened the compute device, so exit
 		 * immediately once we find him
 		 */
-		if (!hpriv->is_control) {
-			ctx = hpriv->ctx;
-			hl_ctx_get(hdev, ctx);
-			break;
-		}
+		ctx = hpriv->ctx;
+		hl_ctx_get(hdev, ctx);
+		break;
 	}
 
 	mutex_unlock(&hdev->fpriv_list_lock);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bea05a59425f..f1f482c5cdcb 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -169,9 +169,9 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 		goto out;
 	}
 
-	mutex_lock(&hdev->fpriv_list_lock);
+	mutex_lock(&hdev->fpriv_ctrl_list_lock);
 	list_del(&hpriv->dev_node);
-	mutex_unlock(&hdev->fpriv_list_lock);
+	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 out:
 	put_pid(hpriv->taskpid);
 
@@ -449,7 +449,9 @@ static int device_early_init(struct hl_device *hdev)
 	INIT_LIST_HEAD(&hdev->cs_mirror_list);
 	spin_lock_init(&hdev->cs_mirror_lock);
 	INIT_LIST_HEAD(&hdev->fpriv_list);
+	INIT_LIST_HEAD(&hdev->fpriv_ctrl_list);
 	mutex_init(&hdev->fpriv_list_lock);
+	mutex_init(&hdev->fpriv_ctrl_list_lock);
 	atomic_set(&hdev->in_reset, 0);
 	mutex_init(&hdev->clk_throttling.lock);
 
@@ -491,6 +493,7 @@ static void device_early_fini(struct hl_device *hdev)
 	mutex_destroy(&hdev->send_cpu_message_lock);
 
 	mutex_destroy(&hdev->fpriv_list_lock);
+	mutex_destroy(&hdev->fpriv_ctrl_list_lock);
 
 	mutex_destroy(&hdev->clk_throttling.lock);
 
@@ -678,6 +681,8 @@ static void take_release_locks(struct hl_device *hdev)
 	/* Flush anyone that is inside device open */
 	mutex_lock(&hdev->fpriv_list_lock);
 	mutex_unlock(&hdev->fpriv_list_lock);
+	mutex_lock(&hdev->fpriv_ctrl_list_lock);
+	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 }
 
 static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_reset)
@@ -789,17 +794,21 @@ int hl_device_resume(struct hl_device *hdev)
 	return rc;
 }
 
-static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
+static int device_kill_open_processes(struct hl_device *hdev, u32 timeout, bool control_dev)
 {
-	struct hl_fpriv	*hpriv;
 	struct task_struct *task = NULL;
+	struct list_head *fd_list;
+	struct hl_fpriv	*hpriv;
+	struct mutex *fd_lock;
 	u32 pending_cnt;
 
+	fd_lock = control_dev ? &hdev->fpriv_ctrl_list_lock : &hdev->fpriv_list_lock;
+	fd_list = control_dev ? &hdev->fpriv_ctrl_list : &hdev->fpriv_list;
 
 	/* Giving time for user to close FD, and for processes that are inside
 	 * hl_device_open to finish
 	 */
-	if (!list_empty(&hdev->fpriv_list))
+	if (!list_empty(fd_list))
 		ssleep(1);
 
 	if (timeout) {
@@ -815,12 +824,12 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 		}
 	}
 
-	mutex_lock(&hdev->fpriv_list_lock);
+	mutex_lock(fd_lock);
 
 	/* This section must be protected because we are dereferencing
 	 * pointers that are freed if the process exits
 	 */
-	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node) {
+	list_for_each_entry(hpriv, fd_list, dev_node) {
 		task = get_pid_task(hpriv->taskpid, PIDTYPE_PID);
 		if (task) {
 			dev_info(hdev->dev, "Killing user process pid=%d\n",
@@ -832,12 +841,12 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 		} else {
 			dev_warn(hdev->dev,
 				"Can't get task struct for PID so giving up on killing process\n");
-			mutex_unlock(&hdev->fpriv_list_lock);
+			mutex_unlock(fd_lock);
 			return -ETIME;
 		}
 	}
 
-	mutex_unlock(&hdev->fpriv_list_lock);
+	mutex_unlock(fd_lock);
 
 	/*
 	 * We killed the open users, but that doesn't mean they are closed.
@@ -849,7 +858,7 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 	 */
 
 wait_for_processes:
-	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
+	while ((!list_empty(fd_list)) && (pending_cnt)) {
 		dev_dbg(hdev->dev,
 			"Waiting for all unmap operations to finish before hard reset\n");
 
@@ -859,7 +868,7 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 	}
 
 	/* All processes exited successfully */
-	if (list_empty(&hdev->fpriv_list))
+	if (list_empty(fd_list))
 		return 0;
 
 	/* Give up waiting for processes to exit */
@@ -871,14 +880,19 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 	return -EBUSY;
 }
 
-static void device_disable_open_processes(struct hl_device *hdev)
+static void device_disable_open_processes(struct hl_device *hdev, bool control_dev)
 {
+	struct list_head *fd_list;
 	struct hl_fpriv *hpriv;
+	struct mutex *fd_lock;
 
-	mutex_lock(&hdev->fpriv_list_lock);
-	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node)
+	fd_lock = control_dev ? &hdev->fpriv_ctrl_list_lock : &hdev->fpriv_list_lock;
+	fd_list = control_dev ? &hdev->fpriv_ctrl_list : &hdev->fpriv_list;
+
+	mutex_lock(fd_lock);
+	list_for_each_entry(hpriv, fd_list, dev_node)
 		hpriv->hdev = NULL;
-	mutex_unlock(&hdev->fpriv_list_lock);
+	mutex_unlock(fd_lock);
 }
 
 static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
@@ -1057,7 +1071,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		 * process can't really exit until all its CSs are done, which
 		 * is what we do in cs rollback
 		 */
-		rc = device_kill_open_processes(hdev, 0);
+		rc = device_kill_open_processes(hdev, 0, false);
 
 		if (rc == -EBUSY) {
 			if (hdev->device_fini_pending) {
@@ -1629,10 +1643,16 @@ void hl_device_fini(struct hl_device *hdev)
 		"Waiting for all processes to exit (timeout of %u seconds)",
 		HL_PENDING_RESET_LONG_SEC);
 
-	rc = device_kill_open_processes(hdev, HL_PENDING_RESET_LONG_SEC);
+	rc = device_kill_open_processes(hdev, HL_PENDING_RESET_LONG_SEC, false);
 	if (rc) {
 		dev_crit(hdev->dev, "Failed to kill all open processes\n");
-		device_disable_open_processes(hdev);
+		device_disable_open_processes(hdev, false);
+	}
+
+	rc = device_kill_open_processes(hdev, 0, true);
+	if (rc) {
+		dev_crit(hdev->dev, "Failed to kill all control device open processes\n");
+		device_disable_open_processes(hdev, true);
 	}
 
 	hl_cb_pool_fini(hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 362eee3f028c..015aa1ee8ce0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1824,7 +1824,6 @@ struct hl_debug_params {
  * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
  * @restore_phase_mutex: lock for context switch and restore phase.
- * @is_control: true for control device, false otherwise
  */
 struct hl_fpriv {
 	struct hl_device	*hdev;
@@ -1837,7 +1836,6 @@ struct hl_fpriv {
 	struct list_head	dev_node;
 	struct kref		refcount;
 	struct mutex		restore_phase_mutex;
-	u8			is_control;
 };
 
 
@@ -2502,7 +2500,10 @@ struct last_error_session_info {
  * @internal_cb_va_base: internal cb pool mmu virtual address base
  * @fpriv_list: list of file private data structures. Each structure is created
  *              when a user opens the device
+ * @fpriv_ctrl_list: list of file private data structures. Each structure is created
+ *              when a user opens the control device
  * @fpriv_list_lock: protects the fpriv_list
+ * @fpriv_ctrl_list_lock: protects the fpriv_ctrl_list
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
@@ -2655,7 +2656,9 @@ struct hl_device {
 	u64				internal_cb_va_base;
 
 	struct list_head		fpriv_list;
+	struct list_head		fpriv_ctrl_list;
 	struct mutex			fpriv_list_lock;
+	struct mutex			fpriv_ctrl_list_lock;
 
 	struct hl_cs_counters_atomic	aggregated_cs_counters;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d59201f93de9..aa4e07b1f839 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -220,12 +220,11 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
-	hpriv->is_control = true;
 	nonseekable_open(inode, filp);
 
 	hpriv->taskpid = find_get_pid(current->pid);
 
-	mutex_lock(&hdev->fpriv_list_lock);
+	mutex_lock(&hdev->fpriv_ctrl_list_lock);
 
 	if (!hl_device_operational(hdev, NULL)) {
 		dev_err_ratelimited(hdev->dev_ctrl,
@@ -235,13 +234,13 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	list_add(&hpriv->dev_node, &hdev->fpriv_list);
-	mutex_unlock(&hdev->fpriv_list_lock);
+	list_add(&hpriv->dev_node, &hdev->fpriv_ctrl_list);
+	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 
 	return 0;
 
 out_err:
-	mutex_unlock(&hdev->fpriv_list_lock);
+	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 	filp->private_data = NULL;
 	put_pid(hpriv->taskpid);
 
-- 
2.25.1


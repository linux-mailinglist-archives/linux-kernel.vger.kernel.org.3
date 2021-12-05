Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35C468BFA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhLEPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41176 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhLEPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9C7260FC1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E28C341C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718970;
        bh=z3dXk5PP6LElP0HJeBGTswP+UvgKdYwdbOO8PrnN2tA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HXkpgFRc9sweWuMa/1uXuf25AqkRqvI+SeibfOMgRqchXu8jwUzMaBHuu0ZWmAV3t
         CQ9sXXIdoAUclKnOTTufPbjXLX2nzCYwhruCHqVTyd71Xj+ZJQkD/l4fWFs2VP7bSx
         GiPDcEoX6RbNTO2zpBZMiKjadq9Km+9P6lHDSw6vgH25hbXsaNEgXeB6TcPeGB/IgV
         pZaPC5XCqjFs8e/dF7tP/tIkilgqNxHcODPgknYUWMlOPqmN2qZx+Knq0H9Lx9D46m
         9We3g6YVango/R052VTgrwtV9SqV2FvZG908/7L44JTd0FPgmuzMWhZbT1KCiBfm1D
         c6aWfxcRJFGYg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] habanalabs: remove compute context pointer
Date:   Sun,  5 Dec 2021 17:42:35 +0200
Message-Id: <20211205154236.2198481-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was an error to save the compute context's pointer in the device
structure, as it allowed its use without proper ref-cnt.

Change the variable to a flag that only indicates whether there is
an active compute context. Code that needs the pointer will now
be forced to use proper internal APIs to get the pointer.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c        |  2 +-
 drivers/misc/habanalabs/common/device.c         | 10 +++++-----
 drivers/misc/habanalabs/common/habanalabs.h     |  5 ++---
 drivers/misc/habanalabs/common/habanalabs_drv.c |  2 +-
 drivers/misc/habanalabs/goya/goya.c             |  4 ++--
 drivers/misc/habanalabs/goya/goya_hwmgr.c       |  4 ++--
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index b2884107fa15..49e6f1172d18 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -165,7 +165,7 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	hpriv->ctx = ctx;
 
 	/* TODO: remove the following line for multiple process support */
-	hdev->compute_ctx = ctx;
+	hdev->is_compute_ctx_active = true;
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 407f6c5020c7..bea05a59425f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -97,12 +97,12 @@ static void hpriv_release(struct kref *ref)
 			|| hdev->reset_upon_device_release)
 		hl_device_reset(hdev, HL_DRV_RESET_DEV_RELEASE);
 
-	/* Now we can mark the compute_ctx as empty. Even if a reset is running in a different
+	/* Now we can mark the compute_ctx as not active. Even if a reset is running in a different
 	 * thread, we don't care because the in_reset is marked so if a user will try to open
-	 * the device it will fail on that, even if compute_ctx is NULL.
+	 * the device it will fail on that, even if compute_ctx is false.
 	 */
 	mutex_lock(&hdev->fpriv_list_lock);
-	hdev->compute_ctx = NULL;
+	hdev->is_compute_ctx_active = false;
 	mutex_unlock(&hdev->fpriv_list_lock);
 
 	kfree(hpriv);
@@ -1150,7 +1150,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 			goto out_err;
 		}
 
-		hdev->compute_ctx = NULL;
+		hdev->is_compute_ctx_active = false;
 
 		rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
 		if (rc) {
@@ -1403,7 +1403,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto mmu_fini;
 	}
 
-	hdev->compute_ctx = NULL;
+	hdev->is_compute_ctx_active = false;
 
 	hdev->asic_funcs->state_dump_init(hdev);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eec96e506bb0..df1935952c28 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2503,7 +2503,6 @@ struct last_error_session_info {
  * @fpriv_list: list of file private data structures. Each structure is created
  *              when a user opens the device
  * @fpriv_list_lock: protects the fpriv_list
- * @compute_ctx: current compute context executing.
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
@@ -2601,6 +2600,7 @@ struct last_error_session_info {
  *                        cases where Linux was not loaded to device CPU
  * @supports_wait_for_multi_cs: true if wait for multi CS is supported
  * @is_in_soft_reset: Device is currently in soft reset process.
+ * @is_compute_ctx_active: Whether there is an active compute context executing.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2656,8 +2656,6 @@ struct hl_device {
 	struct list_head		fpriv_list;
 	struct mutex			fpriv_list_lock;
 
-	struct hl_ctx			*compute_ctx;
-
 	struct hl_cs_counters_atomic	aggregated_cs_counters;
 
 	struct hl_mmu_priv		mmu_priv;
@@ -2730,6 +2728,7 @@ struct hl_device {
 	u8				supports_wait_for_multi_cs;
 	u8				stream_master_qid_arr_size;
 	u8				is_in_soft_reset;
+	u8				is_compute_ctx_active;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d4ef99952d15..62a02ef43bb7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -161,7 +161,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	if (hdev->compute_ctx) {
+	if (hdev->is_compute_ctx_active) {
 		dev_dbg_ratelimited(hdev->dev,
 			"Can't open %s because another user is working on it\n",
 			dev_name(hdev->dev));
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e54d60e75854..8d0f2cd608fc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -827,7 +827,7 @@ static void goya_set_freq_to_low_job(struct work_struct *work)
 
 	mutex_lock(&hdev->fpriv_list_lock);
 
-	if (!hdev->compute_ctx)
+	if (!hdev->is_compute_ctx_active)
 		goya_set_frequency(hdev, PLL_LOW);
 
 	mutex_unlock(&hdev->fpriv_list_lock);
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 42985a85b625..76b47749affe 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -258,7 +258,7 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 
 	mutex_lock(&hdev->fpriv_list_lock);
 
-	if (hdev->compute_ctx) {
+	if (hdev->is_compute_ctx_active) {
 		dev_err(hdev->dev,
 			"Can't change PM profile while compute context is opened on the device\n");
 		count = -EPERM;
-- 
2.25.1


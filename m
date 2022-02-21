Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92434BE799
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiBUIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:49:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbiBUItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:49:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3FA2BCB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4CD61133
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C895BC340EB;
        Mon, 21 Feb 2022 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645433361;
        bh=61m5opydu6oIZ50muRjad8uTMbMvpXyXDzNMREOXZpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZu35ojSxp2XkQAhJTMWouvu1Uk6mWhfomIyuXqZX8yosG8tbK8TQlKlcYyftaNyY
         FiO9jE76oa2m37dqchSGdw83dKSfJq8zaoyyl3MU6Itxfg5+z7Ial026O3CnM34zrN
         d2wjqdA9rLQWqEkzaaINMAQcQuBwYPxwDs2hyEnQfD1AGZgAsZjcKo71Q0MJz+DxKv
         bqPHgij4ZI9K2cFLAuYnDsboTaXuwUlN7/7HaahHAebHizENw9SONlJOhvrkCKvOOc
         IMl38juleaIj4XWZUdTKt2URkYQr+Bzx//eys0uKaIW5jEolZjOYudFGGbQ2QZu+lj
         GfWhGMtiWvcdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/2] habanalabs: Fix reset upon device release bug
Date:   Mon, 21 Feb 2022 10:49:14 +0200
Message-Id: <20220221084914.493784-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221084914.493784-1-ogabbay@kernel.org>
References: <20220221084914.493784-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

In case user application was interrupted while some cs still in-flight
or in the middle of completion handling in driver, the
last refcount of the kernel private data for the user process
will not be put in the fd close flow, but in the cs completion
workqueue context.

This means that the device reset-upon-device-release will be called
from that context. During the reset flow, the driver flushes all the cs
workqueue to ensure that any scheduled work has run to completion,
and since we are running from the completion context we will
have deadlock.

Therefore, we need to skip flushing the workqueue in those cases.
It is safe to do it because the user won't be able to release the device
unless the workqueues are already empty.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c | 17 ++++++++++-------
 drivers/misc/habanalabs/common/device.c         | 13 ++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h     |  2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index c7757c78d0b1..d93ef9f1c45c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -921,18 +921,21 @@ static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
 		complete_job(hdev, job);
 }
 
-void hl_cs_rollback_all(struct hl_device *hdev)
+void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush)
 {
 	int i;
 	struct hl_cs *cs, *tmp;
 
-	flush_workqueue(hdev->ts_free_obj_wq);
+	if (!skip_wq_flush) {
+		flush_workqueue(hdev->ts_free_obj_wq);
 
-	/* flush all completions before iterating over the CS mirror list in
-	 * order to avoid a race with the release functions
-	 */
-	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
-		flush_workqueue(hdev->cq_wq[i]);
+		/* flush all completions before iterating over the CS mirror list in
+		 * order to avoid a race with the release functions
+		 */
+		for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+			flush_workqueue(hdev->cq_wq[i]);
+
+	}
 
 	/* Make sure we don't have leftovers in the CS mirror list */
 	list_for_each_entry_safe(cs, tmp, &hdev->cs_mirror_list, mirror_node) {
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 8ea9dfe3f79b..d52381d1fbd2 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -685,7 +685,8 @@ static void take_release_locks(struct hl_device *hdev)
 	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 }
 
-static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_reset)
+static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_reset,
+				bool skip_wq_flush)
 {
 	if (hard_reset)
 		device_late_fini(hdev);
@@ -698,7 +699,7 @@ static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_r
 	hdev->asic_funcs->halt_engines(hdev, hard_reset, fw_reset);
 
 	/* Go over all the queues, release all CS and their jobs */
-	hl_cs_rollback_all(hdev);
+	hl_cs_rollback_all(hdev, skip_wq_flush);
 
 	/* Release all pending user interrupts, each pending user interrupt
 	 * holds a reference to user context
@@ -978,7 +979,8 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
-			reset_upon_device_release = false, schedule_hard_reset = false;
+			reset_upon_device_release = false, schedule_hard_reset = false,
+			skip_wq_flush = false;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	struct hl_ctx *ctx;
 	int i, rc;
@@ -991,6 +993,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hard_reset = !!(flags & HL_DRV_RESET_HARD);
 	from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
 	fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
+	skip_wq_flush = !!(flags & HL_DRV_RESET_DEV_RELEASE);
 
 	if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
 		hard_instead_soft = true;
@@ -1076,7 +1079,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		return 0;
 	}
 
-	cleanup_resources(hdev, hard_reset, fw_reset);
+	cleanup_resources(hdev, hard_reset, fw_reset, skip_wq_flush);
 
 kill_processes:
 	if (hard_reset) {
@@ -1686,7 +1689,7 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_hwmon_fini(hdev);
 
-	cleanup_resources(hdev, true, false);
+	cleanup_resources(hdev, true, false, false);
 
 	/* Kill processes here after CS rollback. This is because the process
 	 * can't really exit until all its CSs are done, which is what we
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 677ae4ff922c..cef4717d0916 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3054,7 +3054,7 @@ int hl_cb_pool_fini(struct hl_device *hdev);
 int hl_cb_va_pool_init(struct hl_ctx *ctx);
 void hl_cb_va_pool_fini(struct hl_ctx *ctx);
 
-void hl_cs_rollback_all(struct hl_device *hdev);
+void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush);
 struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 		enum hl_queue_type queue_type, bool is_kernel_allocated_cb);
 void hl_sob_reset_error(struct kref *ref);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23A55D9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiF1LBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbiF1LA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593C29820
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7A0C61952
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CD8C3411D;
        Tue, 28 Jun 2022 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414023;
        bh=Vx2HiSQOnAqnP7AFygjo9EjJfyEX9Om6OUx56ll06/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFDDcoG91844daZ3JKhMTcpbVaakVd5hw+RoV115vjKB7jFxgMH8ORzYf7cDrIKYy
         nkhHSo6UpxHQrawqy662NwjaxwuSLtBUD3rmivdL80Ty3C1cpknSPRxgZc8TEhHYXd
         3UKjJrN4MmAFbL1q36/0hhHj8bMoBngFmBvDZUND3ky0nePrU0PT8dkWURb+dvHWq1
         M/T3NXxc+GYQuBc1WDgmbt3erPzciDsNbEHLCOQC6ieY3b003E3mEjV+6QmCNn9Oaz
         ajN+GFOn8AnoE/YhluCt+tA7Cx7kU+jjTUOkKmxs486nsBKML/JmQiGFro6H39xnjs
         WV4qstr6NnNOQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2 10/12] habanalabs: add gaudi2 wait-for-CS support
Date:   Tue, 28 Jun 2022 13:59:56 +0300
Message-Id: <20220628105958.1254875-11-ogabbay@kernel.org>
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

In Gaudi2 we moved to a different wait for command submission
completion model. Instead of receiving interrupt only on external
queues, we use the device's sync manager to notify us when the
entire command submission finishes.

This enables us to remove the categorization of queues to external
and internal, and treat each queue equally, without the need to parse
and patch any command buffer.

This change also requires refactoring to the IRQ handling of
CS completions.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
Changes in v2:
 - Remove unused function and set some functions to be static

 .../habanalabs/common/command_submission.c    | 118 +++++++++++-------
 drivers/misc/habanalabs/common/debugfs.c      |  21 ++--
 drivers/misc/habanalabs/common/device.c       |  48 ++++---
 drivers/misc/habanalabs/common/habanalabs.h   |   6 +
 drivers/misc/habanalabs/common/hw_queue.c     |  10 ++
 drivers/misc/habanalabs/common/irq.c          |  94 ++++++++++----
 drivers/misc/habanalabs/common/security.c     |   2 +-
 7 files changed, 210 insertions(+), 89 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 3805c6d6b65c..e91ca31d4930 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 
 #define HL_CS_FLAGS_TYPE_MASK	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT | \
-				HL_CS_FLAGS_COLLECTIVE_WAIT)
+					HL_CS_FLAGS_COLLECTIVE_WAIT)
 
 #define MAX_TS_ITER_NUM 10
 
@@ -29,8 +29,7 @@ enum hl_cs_wait_status {
 };
 
 static void job_wq_completion(struct work_struct *work);
-static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				u64 timeout_us, u64 seq,
+static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx, u64 timeout_us, u64 seq,
 				enum hl_cs_wait_status *status, s64 *timestamp);
 static void cs_do_release(struct kref *ref);
 
@@ -249,7 +248,7 @@ static void cs_job_do_release(struct kref *ref)
 	kfree(job);
 }
 
-static void cs_job_put(struct hl_cs_job *job)
+static void hl_cs_job_put(struct hl_cs_job *job)
 {
 	kref_put(&job->refcount, cs_job_do_release);
 }
@@ -344,7 +343,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 	return rc;
 }
 
-static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
+static void hl_complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 {
 	struct hl_cs *cs = job->cs;
 
@@ -363,12 +362,12 @@ static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 
 	/* For H/W queue jobs, if a user CB was allocated by driver and MMU is
 	 * enabled, the user CB isn't released in cs_parser() and thus should be
-	 * released here.
-	 * This is also true for INT queues jobs which were allocated by driver
+	 * released here. This is also true for INT queues jobs which were
+	 * allocated by driver.
 	 */
-	if (job->is_kernel_allocated_cb &&
+	if ((job->is_kernel_allocated_cb &&
 		((job->queue_type == QUEUE_TYPE_HW && hdev->mmu_enable) ||
-				job->queue_type == QUEUE_TYPE_INT)) {
+				job->queue_type == QUEUE_TYPE_INT))) {
 		atomic_dec(&job->user_cb->cs_cnt);
 		hl_cb_put(job->user_cb);
 	}
@@ -396,11 +395,10 @@ static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 	 * flow by calling 'hl_hw_queue_update_ci'.
 	 */
 	if (cs_needs_completion(cs) &&
-		(job->queue_type == QUEUE_TYPE_EXT ||
-			job->queue_type == QUEUE_TYPE_HW))
+		(job->queue_type == QUEUE_TYPE_EXT || job->queue_type == QUEUE_TYPE_HW))
 		cs_put(cs);
 
-	cs_job_put(job);
+	hl_cs_job_put(job);
 }
 
 /*
@@ -690,7 +688,7 @@ static void cs_do_release(struct kref *ref)
 	 * still holds a pointer to them (but no reference).
 	 */
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
-		complete_job(hdev, job);
+		hl_complete_job(hdev, job);
 
 	if (!cs->submitted) {
 		/*
@@ -756,6 +754,7 @@ static void cs_do_release(struct kref *ref)
 	 */
 	hl_debugfs_remove_cs(cs);
 
+	hdev->shadow_cs_queue[cs->sequence & (hdev->asic_prop.max_pending_cs - 1)] = NULL;
 
 	/* We need to mark an error for not submitted because in that case
 	 * the hl fence release flow is different. Mainly, we don't need
@@ -1007,7 +1006,7 @@ static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
 	staged_cs_put(hdev, cs);
 
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
-		complete_job(hdev, job);
+		hl_complete_job(hdev, job);
 }
 
 void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush)
@@ -1024,6 +1023,7 @@ void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush)
 		for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 			flush_workqueue(hdev->cq_wq[i]);
 
+		flush_workqueue(hdev->cs_cmplt_wq);
 	}
 
 	/* Make sure we don't have leftovers in the CS mirror list */
@@ -1031,7 +1031,7 @@ void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush)
 		cs_get(cs);
 		cs->aborted = true;
 		dev_warn_ratelimited(hdev->dev, "Killing CS %d.%llu\n",
-				cs->ctx->asid, cs->sequence);
+					cs->ctx->asid, cs->sequence);
 		cs_rollback(hdev, cs);
 		cs_put(cs);
 	}
@@ -1092,7 +1092,17 @@ static void job_wq_completion(struct work_struct *work)
 	struct hl_device *hdev = cs->ctx->hdev;
 
 	/* job is no longer needed */
-	complete_job(hdev, job);
+	hl_complete_job(hdev, job);
+}
+
+static void cs_completion(struct work_struct *work)
+{
+	struct hl_cs *cs = container_of(work, struct hl_cs, finish_work);
+	struct hl_device *hdev = cs->ctx->hdev;
+	struct hl_cs_job *job, *tmp;
+
+	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
+		hl_complete_job(hdev, job);
 }
 
 static int validate_queue_index(struct hl_device *hdev,
@@ -1115,7 +1125,13 @@ static int validate_queue_index(struct hl_device *hdev,
 	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
 
 	if (hw_queue_prop->type == QUEUE_TYPE_NA) {
-		dev_err(hdev->dev, "Queue index %d is invalid\n",
+		dev_err(hdev->dev, "Queue index %d is not applicable\n",
+			chunk->queue_index);
+		return -EINVAL;
+	}
+
+	if (hw_queue_prop->binned) {
+		dev_err(hdev->dev, "Queue index %d is binned out\n",
 			chunk->queue_index);
 		return -EINVAL;
 	}
@@ -1257,17 +1273,16 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 	cs_type = hl_cs_get_cs_type(cs_type_flags);
 	num_chunks = args->in.num_chunks_execute;
 
-	if (unlikely((cs_type != CS_TYPE_DEFAULT) &&
-					!hdev->supports_sync_stream)) {
+	if (unlikely((cs_type == CS_TYPE_SIGNAL || cs_type == CS_TYPE_WAIT ||
+			cs_type == CS_TYPE_COLLECTIVE_WAIT) &&
+			!hdev->supports_sync_stream)) {
 		dev_err(hdev->dev, "Sync stream CS is not supported\n");
 		return -EINVAL;
 	}
 
 	if (cs_type == CS_TYPE_DEFAULT) {
 		if (!num_chunks) {
-			dev_err(hdev->dev,
-				"Got execute CS with 0 chunks, context %d\n",
-				ctx->asid);
+			dev_err(hdev->dev, "Got execute CS with 0 chunks, context %d\n", ctx->asid);
 			return -EINVAL;
 		}
 	} else if (num_chunks != 1) {
@@ -1367,7 +1382,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 				u32 encaps_signals_handle, u32 timeout,
 				u16 *signal_initial_sob_count)
 {
-	bool staged_mid, int_queues_only = true;
+	bool staged_mid, int_queues_only = true, using_hw_queues = false;
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_chunk *cs_chunk_array;
 	struct hl_cs_counters_atomic *cntr;
@@ -1456,6 +1471,9 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 							chunk->queue_index);
 		}
 
+		if (queue_type == QUEUE_TYPE_HW)
+			using_hw_queues = true;
+
 		job = hl_cs_allocate_job(hdev, queue_type,
 						is_kernel_allocated_cb);
 		if (!job) {
@@ -1476,6 +1494,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		job->hw_queue_id = chunk->queue_index;
 
 		cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+		cs->jobs_cnt++;
 
 		list_add_tail(&job->cs_node, &cs->job_list);
 
@@ -1516,6 +1535,9 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		goto free_cs_object;
 	}
 
+	if (using_hw_queues)
+		INIT_WORK(&cs->finish_work, cs_completion);
+
 	/*
 	 * store the (external/HW queues) streams used by the CS in the
 	 * fence object for multi-CS completion
@@ -1864,6 +1886,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	cs_get(cs);
 
 	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+	cs->jobs_cnt++;
 
 	list_add_tail(&job->cs_node, &cs->job_list);
 
@@ -2282,6 +2305,9 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	if (rc)
 		goto free_cs_object;
 
+	if (q_type == QUEUE_TYPE_HW)
+		INIT_WORK(&cs->finish_work, cs_completion);
+
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
 		/* In case wait cs failed here, it means the signal cs
@@ -2412,8 +2438,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 }
 
 static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence,
-				enum hl_cs_wait_status *status, u64 timeout_us,
-				s64 *timestamp)
+				enum hl_cs_wait_status *status, u64 timeout_us, s64 *timestamp)
 {
 	struct hl_device *hdev = ctx->hdev;
 	ktime_t timestamp_kt;
@@ -2432,9 +2457,8 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
 	if (!fence) {
 		if (!hl_pop_cs_outcome(&ctx->outcome_store, seq, &timestamp_kt, &error)) {
 			dev_dbg(hdev->dev,
-			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
+				"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
 				seq, ctx->cs_sequence);
-
 			*status = CS_WAIT_STATUS_GONE;
 			return 0;
 		}
@@ -2542,8 +2566,7 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_com
 		 * function won't sleep as it is called with timeout 0 (i.e.
 		 * poll the fence)
 		 */
-		rc = hl_wait_for_fence(mcs_data->ctx, seq_arr[i], fence,
-						&status, 0, NULL);
+		rc = hl_wait_for_fence(mcs_data->ctx, seq_arr[i], fence, &status, 0, NULL);
 		if (rc) {
 			dev_err(hdev->dev,
 				"wait_for_fence error :%d for CS seq %llu\n",
@@ -2612,8 +2635,7 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_com
 	return rc;
 }
 
-static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				u64 timeout_us, u64 seq,
+static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx, u64 timeout_us, u64 seq,
 				enum hl_cs_wait_status *status, s64 *timestamp)
 {
 	struct hl_fence *fence;
@@ -2914,8 +2936,7 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	s64 timestamp;
 	int rc;
 
-	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq,
-				&status, &timestamp);
+	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq, &status, &timestamp);
 
 	if (rc == -ERESTARTSYS) {
 		dev_err_ratelimited(hdev->dev,
@@ -3200,7 +3221,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 static int _hl_interrupt_wait_ioctl_user_addr(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 user_address,
 				u64 target_value, struct hl_user_interrupt *interrupt,
-
 				u32 *status,
 				u64 *timestamp)
 {
@@ -3322,12 +3342,12 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct hl_user_interrupt *interrupt;
 	union hl_wait_cs_args *args = data;
 	u32 status = HL_WAIT_CS_STATUS_BUSY;
+	int rc, int_idx;
 	u64 timestamp;
-	int rc;
 
 	prop = &hdev->asic_prop;
 
-	if (!prop->user_interrupt_count) {
+	if (!(prop->user_interrupt_count + prop->user_dec_intr_count)) {
 		dev_err(hdev->dev, "no user interrupts allowed");
 		return -EPERM;
 	}
@@ -3337,17 +3357,29 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	first_interrupt = prop->first_available_user_interrupt;
 	last_interrupt = prop->first_available_user_interrupt + prop->user_interrupt_count - 1;
 
-	if ((interrupt_id < first_interrupt || interrupt_id > last_interrupt) &&
-			interrupt_id != HL_COMMON_USER_INTERRUPT_ID) {
+	if (interrupt_id < prop->user_dec_intr_count) {
+
+		/* Check if the requested core is enabled */
+		if (!(prop->decoder_enabled_mask & BIT(interrupt_id))) {
+			dev_err(hdev->dev, "interrupt on a disabled core(%u) not allowed",
+				interrupt_id);
+			return -EINVAL;
+		}
+
+		interrupt = &hdev->user_interrupt[interrupt_id];
+
+	} else if (interrupt_id >= first_interrupt && interrupt_id <= last_interrupt) {
+
+		int_idx = interrupt_id - first_interrupt + prop->user_dec_intr_count;
+		interrupt = &hdev->user_interrupt[int_idx];
+
+	} else if (interrupt_id == HL_COMMON_USER_INTERRUPT_ID) {
+		interrupt = &hdev->common_user_interrupt;
+	} else {
 		dev_err(hdev->dev, "invalid user interrupt %u", interrupt_id);
 		return -EINVAL;
 	}
 
-	if (interrupt_id == HL_COMMON_USER_INTERRUPT_ID)
-		interrupt = &hdev->common_user_interrupt;
-	else
-		interrupt = &hdev->user_interrupt[interrupt_id - first_interrupt];
-
 	if (args->in.flags & HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ)
 		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->mem_mgr, &hpriv->mem_mgr,
 				args->in.interrupt_timeout_us, args->in.cq_counters_handle,
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 831b050a1bf0..90273481a466 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -152,12 +152,12 @@ static int command_submission_show(struct seq_file *s, void *data)
 		if (first) {
 			first = false;
 			seq_puts(s, "\n");
-			seq_puts(s, " CS ID   CTX ASID   CS RefCnt   Submitted    Completed\n");
-			seq_puts(s, "------------------------------------------------------\n");
+			seq_puts(s, " CS ID   CS TYPE   CTX ASID   CS RefCnt   Submitted    Completed\n");
+			seq_puts(s, "----------------------------------------------------------------\n");
 		}
 		seq_printf(s,
-			"   %llu       %d          %d           %d            %d\n",
-			cs->sequence, cs->ctx->asid,
+			"   %llu        %d          %d          %d           %d            %d\n",
+			cs->sequence, cs->type, cs->ctx->asid,
 			kref_read(&cs->refcount),
 			cs->submitted, cs->completed);
 	}
@@ -183,17 +183,18 @@ static int command_submission_jobs_show(struct seq_file *s, void *data)
 		if (first) {
 			first = false;
 			seq_puts(s, "\n");
-			seq_puts(s, " JOB ID   CS ID    CTX ASID   JOB RefCnt   H/W Queue\n");
-			seq_puts(s, "----------------------------------------------------\n");
+			seq_puts(s, " JOB ID   CS ID    CS TYPE    CTX ASID   JOB RefCnt   H/W Queue\n");
+			seq_puts(s, "---------------------------------------------------------------\n");
 		}
 		if (job->cs)
 			seq_printf(s,
-				"   %02d      %llu        %d          %d           %d\n",
-				job->id, job->cs->sequence, job->cs->ctx->asid,
-				kref_read(&job->refcount), job->hw_queue_id);
+				"   %02d      %llu        %d        %d          %d           %d\n",
+				job->id, job->cs->sequence, job->cs->type,
+				job->cs->ctx->asid, kref_read(&job->refcount),
+				job->hw_queue_id);
 		else
 			seq_printf(s,
-				"   %02d      0        %d          %d           %d\n",
+				"   %02d      0        0        %d          %d           %d\n",
 				job->id, HL_KERNEL_ASID_ID,
 				kref_read(&job->refcount), job->hw_queue_id);
 	}
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 4b6b6ba5b2fa..ff7634d32282 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -15,14 +15,14 @@
 
 #define HL_RESET_DELAY_USEC		10000	/* 10ms */
 
-#define MEM_SCRUB_DEFAULT_VAL 0x1122334455667788
-
 enum dma_alloc_type {
 	DMA_ALLOC_COHERENT,
 	DMA_ALLOC_CPU_ACCESSIBLE,
 	DMA_ALLOC_POOL,
 };
 
+#define MEM_SCRUB_DEFAULT_VAL 0x1122334455667788
+
 /*
  * hl_set_dram_bar- sets the bar to allow later access to address
  *
@@ -412,8 +412,8 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	 */
 	hl_release_pending_user_interrupts(hpriv->hdev);
 
-	hl_mem_mgr_fini(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
+	hl_mem_mgr_fini(&hpriv->mem_mgr);
 
 	hdev->compute_ctx_in_release = 1;
 
@@ -461,7 +461,7 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
  * @*filp: pointer to file structure
  * @*vma: pointer to vm_area_struct of the process
  *
- * Called when process does an mmap on habanalabs device. Call the device's mmap
+ * Called when process does an mmap on habanalabs device. Call the relevant mmap
  * function at the end of the common code.
  */
 static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -486,7 +486,6 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 	case HL_MMAP_TYPE_TS_BUFF:
 		return hl_mem_mgr_mmap(&hpriv->mem_mgr, vma, NULL);
 	}
-
 	return -EINVAL;
 }
 
@@ -686,12 +685,20 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cq_wq;
 	}
 
+	hdev->cs_cmplt_wq = alloc_workqueue("hl-cs-completions", WQ_UNBOUND, 0);
+	if (!hdev->cs_cmplt_wq) {
+		dev_err(hdev->dev,
+			"Failed to allocate CS completions workqueue\n");
+		rc = -ENOMEM;
+		goto free_eq_wq;
+	}
+
 	hdev->ts_free_obj_wq = alloc_workqueue("hl-ts-free-obj", WQ_UNBOUND, 0);
 	if (!hdev->ts_free_obj_wq) {
 		dev_err(hdev->dev,
 			"Failed to allocate Timestamp registration free workqueue\n");
 		rc = -ENOMEM;
-		goto free_eq_wq;
+		goto free_cs_cmplt_wq;
 	}
 
 	hdev->pf_wq = alloc_workqueue("hl-prefetch", WQ_UNBOUND, 0);
@@ -748,6 +755,8 @@ static int device_early_init(struct hl_device *hdev)
 	destroy_workqueue(hdev->pf_wq);
 free_ts_free_wq:
 	destroy_workqueue(hdev->ts_free_obj_wq);
+free_cs_cmplt_wq:
+	destroy_workqueue(hdev->cs_cmplt_wq);
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
@@ -788,6 +797,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	destroy_workqueue(hdev->pf_wq);
 	destroy_workqueue(hdev->ts_free_obj_wq);
+	destroy_workqueue(hdev->cs_cmplt_wq);
 	destroy_workqueue(hdev->eq_wq);
 	destroy_workqueue(hdev->device_reset_work.wq);
 
@@ -1706,13 +1716,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto free_dev_ctrl;
 
-	user_interrupt_cnt = hdev->asic_prop.user_interrupt_count;
+	user_interrupt_cnt = hdev->asic_prop.user_dec_intr_count +
+				hdev->asic_prop.user_interrupt_count;
 
 	if (user_interrupt_cnt) {
-		hdev->user_interrupt = kcalloc(user_interrupt_cnt,
-				sizeof(*hdev->user_interrupt),
-				GFP_KERNEL);
-
+		hdev->user_interrupt = kcalloc(user_interrupt_cnt, sizeof(*hdev->user_interrupt),
+						GFP_KERNEL);
 		if (!hdev->user_interrupt) {
 			rc = -ENOMEM;
 			goto early_fini;
@@ -1725,7 +1734,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	 */
 	rc = hdev->asic_funcs->sw_init(hdev);
 	if (rc)
-		goto user_interrupts_fini;
+		goto free_usr_intr_mem;
 
 
 	/* initialize completion structure for multi CS wait */
@@ -1773,6 +1782,13 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		hdev->completion_queue[i].cq_idx = i;
 	}
 
+	hdev->shadow_cs_queue = kcalloc(hdev->asic_prop.max_pending_cs,
+					sizeof(*hdev->shadow_cs_queue), GFP_KERNEL);
+	if (!hdev->shadow_cs_queue) {
+		rc = -ENOMEM;
+		goto cq_fini;
+	}
+
 	/*
 	 * Initialize the event queue. Must be done before hw_init,
 	 * because there the address of the event queue is being
@@ -1781,7 +1797,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	rc = hl_eq_init(hdev, &hdev->event_queue);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize event queue\n");
-		goto cq_fini;
+		goto free_shadow_cs_queue;
 	}
 
 	/* MMU S/W must be initialized before kernel context is created */
@@ -1932,6 +1948,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	hl_mmu_fini(hdev);
 eq_fini:
 	hl_eq_fini(hdev, &hdev->event_queue);
+free_shadow_cs_queue:
+	kfree(hdev->shadow_cs_queue);
 cq_fini:
 	for (i = 0 ; i < cq_ready_cnt ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
@@ -1940,7 +1958,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	hl_hw_queues_destroy(hdev);
 sw_fini:
 	hdev->asic_funcs->sw_fini(hdev);
-user_interrupts_fini:
+free_usr_intr_mem:
 	kfree(hdev->user_interrupt);
 early_fini:
 	device_early_fini(hdev);
@@ -2080,6 +2098,8 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_eq_fini(hdev, &hdev->event_queue);
 
+	kfree(hdev->shadow_cs_queue);
+
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
 	kfree(hdev->completion_queue);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 62a228ce9775..7723575ba737 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2893,9 +2893,13 @@ struct hl_reset_info {
  * @common_user_interrupt: common user interrupt for all user interrupts.
  *                         upon any user interrupt, driver will monitor the
  *                         list of fences registered to this common structure.
+ * @shadow_cs_queue: pointer to a shadow queue that holds pointers to
+ *                   outstanding command submissions.
  * @cq_wq: work queues of completion queues for executing work in process
  *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
+ * @cs_cmplt_wq: work queue of CS completions for executing work in process
+ *               context.
  * @ts_free_obj_wq: work queue for timestamp registration objects release.
  * @pf_wq: work queue for MMU pre-fetch operations.
  * @kernel_ctx: Kernel driver context structure.
@@ -3053,8 +3057,10 @@ struct hl_device {
 	struct hl_cq			*completion_queue;
 	struct hl_user_interrupt	*user_interrupt;
 	struct hl_user_interrupt	common_user_interrupt;
+	struct hl_cs			**shadow_cs_queue;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
+	struct workqueue_struct		*cs_cmplt_wq;
 	struct workqueue_struct		*ts_free_obj_wq;
 	struct workqueue_struct		*pf_wq;
 	struct hl_ctx			*kernel_ctx;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 1abd2340927a..3f15ab9d827f 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -696,6 +696,16 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 			goto unroll_cq_resv;
 	}
 
+	rc = hdev->asic_funcs->pre_schedule_cs(cs);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed in pre-submission operations of CS %d.%llu\n",
+			ctx->asid, cs->sequence);
+		goto unroll_cq_resv;
+	}
+
+	hdev->shadow_cs_queue[cs->sequence &
+				(hdev->asic_prop.max_pending_cs - 1)] = cs;
 
 	if (cs->encaps_signals && cs->staged_first) {
 		rc = encaps_sig_first_staged_cs_handler(hdev, cs);
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 02c6faf9a10d..c1088377d1de 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -66,6 +66,56 @@ static void irq_handle_eqe(struct work_struct *work)
 	kfree(eqe_work);
 }
 
+/**
+ * job_finish - queue job finish work
+ *
+ * @hdev: pointer to device structure
+ * @cs_seq: command submission sequence
+ * @cq: completion queue
+ *
+ */
+static void job_finish(struct hl_device *hdev, u32 cs_seq, struct hl_cq *cq)
+{
+	struct hl_hw_queue *queue;
+	struct hl_cs_job *job;
+
+	queue = &hdev->kernel_queues[cq->hw_queue_id];
+	job = queue->shadow_queue[hl_pi_2_offset(cs_seq)];
+	queue_work(hdev->cq_wq[cq->cq_idx], &job->finish_work);
+
+	atomic_inc(&queue->ci);
+}
+
+/**
+ * cs_finish - queue all cs jobs finish work
+ *
+ * @hdev: pointer to device structure
+ * @cs_seq: command submission sequence
+ *
+ */
+static void cs_finish(struct hl_device *hdev, u16 cs_seq)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_hw_queue *queue;
+	struct hl_cs *cs;
+	struct hl_cs_job *job;
+
+	cs = hdev->shadow_cs_queue[cs_seq & (prop->max_pending_cs - 1)];
+	if (!cs) {
+		dev_warn(hdev->dev,
+			"No pointer to CS in shadow array at index %d\n",
+			cs_seq);
+		return;
+	}
+
+	list_for_each_entry(job, &cs->job_list, cs_node) {
+		queue = &hdev->kernel_queues[job->hw_queue_id];
+		atomic_inc(&queue->ci);
+	}
+
+	queue_work(hdev->cs_cmplt_wq, &cs->finish_work);
+}
+
 /**
  * hl_irq_handler_cq - irq handler for completion queue
  *
@@ -77,9 +127,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 {
 	struct hl_cq *cq = arg;
 	struct hl_device *hdev = cq->hdev;
-	struct hl_hw_queue *queue;
-	struct hl_cs_job *job;
-	bool shadow_index_valid;
+	bool shadow_index_valid, entry_ready;
 	u16 shadow_index;
 	struct hl_cq_entry *cq_entry, *cq_base;
 
@@ -93,37 +141,41 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	cq_base = cq->kernel_address;
 
 	while (1) {
-		bool entry_ready = ((le32_to_cpu(cq_base[cq->ci].data) &
-					CQ_ENTRY_READY_MASK)
-						>> CQ_ENTRY_READY_SHIFT);
+		cq_entry = (struct hl_cq_entry *) &cq_base[cq->ci];
 
+		entry_ready = !!FIELD_GET(CQ_ENTRY_READY_MASK,
+				le32_to_cpu(cq_entry->data));
 		if (!entry_ready)
 			break;
 
-		cq_entry = (struct hl_cq_entry *) &cq_base[cq->ci];
-
 		/* Make sure we read CQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
 
-		shadow_index_valid = ((le32_to_cpu(cq_entry->data) &
-					CQ_ENTRY_SHADOW_INDEX_VALID_MASK)
-					>> CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT);
-
-		shadow_index = (u16) ((le32_to_cpu(cq_entry->data) &
-					CQ_ENTRY_SHADOW_INDEX_MASK)
-					>> CQ_ENTRY_SHADOW_INDEX_SHIFT);
+		shadow_index_valid =
+			!!FIELD_GET(CQ_ENTRY_SHADOW_INDEX_VALID_MASK,
+					le32_to_cpu(cq_entry->data));
 
-		queue = &hdev->kernel_queues[cq->hw_queue_id];
+		shadow_index = FIELD_GET(CQ_ENTRY_SHADOW_INDEX_MASK,
+				le32_to_cpu(cq_entry->data));
 
-		if ((shadow_index_valid) && (!hdev->disabled)) {
-			job = queue->shadow_queue[hl_pi_2_offset(shadow_index)];
-			queue_work(hdev->cq_wq[cq->cq_idx], &job->finish_work);
+		/*
+		 * CQ interrupt handler has 2 modes of operation:
+		 * 1. Interrupt per CS completion: (Single CQ for all queues)
+		 *    CQ entry represents a completed CS
+		 *
+		 * 2. Interrupt per CS job completion in queue: (CQ per queue)
+		 *    CQ entry represents a completed job in a certain queue
+		 */
+		if (shadow_index_valid && !hdev->disabled) {
+			if (hdev->asic_prop.completion_mode ==
+					HL_COMPLETION_MODE_CS)
+				cs_finish(hdev, shadow_index);
+			else
+				job_finish(hdev, shadow_index, cq);
 		}
 
-		atomic_inc(&queue->ci);
-
 		/* Clear CQ entry ready bit */
 		cq_entry->data = cpu_to_le32(le32_to_cpu(cq_entry->data) &
 						~CQ_ENTRY_READY_MASK);
diff --git a/drivers/misc/habanalabs/common/security.c b/drivers/misc/habanalabs/common/security.c
index b27ab097776b..6196c0487c8b 100644
--- a/drivers/misc/habanalabs/common/security.c
+++ b/drivers/misc/habanalabs/common/security.c
@@ -44,7 +44,7 @@ static int hl_get_pb_block(struct hl_device *hdev, u32 mm_reg_addr,
  *
  */
 static int hl_unset_pb_in_block(struct hl_device *hdev, u32 reg_offset,
-		struct hl_block_glbl_sec *sgs_entry)
+				struct hl_block_glbl_sec *sgs_entry)
 {
 	if ((reg_offset >= HL_BLOCK_SIZE) || (reg_offset & 0x3)) {
 		dev_err(hdev->dev,
-- 
2.25.1


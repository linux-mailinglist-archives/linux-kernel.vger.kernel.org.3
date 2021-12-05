Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EEE468BFB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhLEPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbhLEPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C03C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:42:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E65A2B80DBE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E01C00446;
        Sun,  5 Dec 2021 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718971;
        bh=uI3agcGf17+tZeTnRpNKv+/qeSfZXoifq44U4PrhLIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6IIXC6djNVbXxEkSEmQef2zwJHdj5QIt/dYAcPeUwfCG5LBG0yjY2b4844+7V7i9
         PEmwSIShpJ9PhYzlbXoneMT6YuFCcyFa2snP/L5e3RZGYyiU4seHACYAFQFPTSxUtZ
         ChXFFOcmvx1cUw/tyamUVYM4U+pm3Fsi+RFHIF7TRsq64ZGnBY/69ticB4ZpwOWX59
         sGDgABiEZNqh9LEmDyxVtAIw8BXV/hYDJEIYxIoM9NauLXwwCSrvFXayQOYjWaYy5s
         UjiEmgqfXaRamwQ8zui+CtcTErTTVoc8HfhtA6Edlesb4qyatdYQOESQk0uCdOCsUE
         I9hNcL++HA0sQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>,
        Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 9/9] habanalabs: wait again for multi-CS if no CS completed
Date:   Sun,  5 Dec 2021 17:42:36 +0200
Message-Id: <20211205154236.2198481-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

The original multi-CS design assumption that stream masters are used
exclusively (i.e. multi-CS with set of stream master QIDs will not get
completed by CS not from the multi-CS set) is inaccurate.

Thus multi-CS behavior is now modified not to treat such case as an
error.

Instead, if we have multi-CS completion but we detect that no CS from
the list is actually completed we will do another multi-CS wait (with
modified timeout).

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 97 +++++++++----------
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +-
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a63ebbc04787..f58fff3671d6 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -545,13 +545,6 @@ static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 			 * mcs fences.
 			 */
 			fence->mcs_handling_done = true;
-			/*
-			 * Since CS (and its related fence) can be associated with only one
-			 * multi CS context, once it triggered multi CS completion no need to
-			 * continue checking other multi CS contexts.
-			 */
-			spin_unlock(&mcs_compl->lock);
-			break;
 		}
 
 		spin_unlock(&mcs_compl->lock);
@@ -2498,6 +2491,21 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	return rc;
 }
 
+static inline unsigned long hl_usecs64_to_jiffies(const u64 usecs)
+{
+	if (usecs <= U32_MAX)
+		return usecs_to_jiffies(usecs);
+
+	/*
+	 * If the value in nanoseconds is larger than 64 bit, use the largest
+	 * 64 bit value.
+	 */
+	if (usecs >= ((u64)(U64_MAX / NSEC_PER_USEC)))
+		return nsecs_to_jiffies(U64_MAX);
+
+	return nsecs_to_jiffies(usecs * NSEC_PER_USEC);
+}
+
 /*
  * hl_wait_multi_cs_completion_init - init completion structure
  *
@@ -2534,8 +2542,7 @@ static struct multi_cs_completion *hl_wait_multi_cs_completion_init(
 	}
 
 	if (i == MULTI_CS_MAX_USER_CTX) {
-		dev_err(hdev->dev,
-				"no available multi-CS completion structure\n");
+		dev_err(hdev->dev, "no available multi-CS completion structure\n");
 		return ERR_PTR(-ENOMEM);
 	}
 	return mcs_compl;
@@ -2566,27 +2573,18 @@ static void hl_wait_multi_cs_completion_fini(
  *
  * @return 0 on success, otherwise non 0 error code
  */
-static int hl_wait_multi_cs_completion(struct multi_cs_data *mcs_data)
+static int hl_wait_multi_cs_completion(struct multi_cs_data *mcs_data,
+						struct multi_cs_completion *mcs_compl)
 {
-	struct hl_device *hdev = mcs_data->ctx->hdev;
-	struct multi_cs_completion *mcs_compl;
 	long completion_rc;
 
-	mcs_compl = hl_wait_multi_cs_completion_init(hdev,
-					mcs_data->stream_master_qid_map);
-	if (IS_ERR(mcs_compl))
-		return PTR_ERR(mcs_compl);
-
-	completion_rc = wait_for_completion_interruptible_timeout(
-					&mcs_compl->completion,
-					usecs_to_jiffies(mcs_data->timeout_us));
+	completion_rc = wait_for_completion_interruptible_timeout(&mcs_compl->completion,
+									mcs_data->timeout_jiffies);
 
 	/* update timestamp */
 	if (completion_rc > 0)
 		mcs_data->timestamp = mcs_compl->timestamp;
 
-	hl_wait_multi_cs_completion_fini(mcs_compl);
-
 	mcs_data->wait_status = completion_rc;
 
 	return 0;
@@ -2619,6 +2617,7 @@ void hl_multi_cs_completion_init(struct hl_device *hdev)
  */
 static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
+	struct multi_cs_completion *mcs_compl;
 	struct hl_device *hdev = hpriv->hdev;
 	struct multi_cs_data mcs_data = {0};
 	union hl_wait_cs_args *args = data;
@@ -2686,12 +2685,19 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto put_ctx;
 
 	/* wait (with timeout) for the first CS to be completed */
-	mcs_data.timeout_us = args->in.timeout_us;
-	rc = hl_wait_multi_cs_completion(&mcs_data);
-	if (rc)
+	mcs_data.timeout_jiffies = hl_usecs64_to_jiffies(args->in.timeout_us);
+
+	mcs_compl = hl_wait_multi_cs_completion_init(hdev, mcs_data.stream_master_qid_map);
+	if (IS_ERR(mcs_compl)) {
+		rc = PTR_ERR(mcs_compl);
 		goto put_ctx;
+	}
+
+	while (true) {
+		rc = hl_wait_multi_cs_completion(&mcs_data, mcs_compl);
+		if (rc || (mcs_data.wait_status == 0))
+			break;
 
-	if (mcs_data.wait_status > 0) {
 		/*
 		 * poll fences once again to update the CS map.
 		 * no timestamp should be updated this time.
@@ -2699,18 +2705,26 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		mcs_data.update_ts = false;
 		rc = hl_cs_poll_fences(&mcs_data);
 
+		if (mcs_data.completion_bitmap)
+			break;
+
 		/*
 		 * if hl_wait_multi_cs_completion returned before timeout (i.e.
-		 * it got a completion) we expect to see at least one CS
-		 * completed after the poll function.
+		 * it got a completion) it either got completed by CS in the multi CS list
+		 * (in which case the indication will be non empty completion_bitmap) or it
+		 * got completed by CS submitted to one of the shared stream master but
+		 * not in the multi CS list (in which case we should wait again but reinit
+		 * the completion, modify the timeout and set timestamp as zero to let a CS
+		 * related to the current multi-CS set a new, relevant, timestamp)
 		 */
-		if (!mcs_data.completion_bitmap) {
-			dev_warn_ratelimited(hdev->dev,
-				"Multi-CS got completion on wait but no CS completed\n");
-			rc = -EFAULT;
-		}
+		/* wait again with modified timeout */
+		mcs_data.timeout_jiffies = mcs_data.wait_status;
+		reinit_completion(&mcs_compl->completion);
+		mcs_compl->timestamp = 0;
 	}
 
+	hl_wait_multi_cs_completion_fini(mcs_compl);
+
 put_ctx:
 	hl_ctx_put(ctx);
 	kfree(fence_arr);
@@ -2741,7 +2755,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		}
 
 		/* update if some CS was gone */
-		if (mcs_data.timestamp)
+		if (!mcs_data.timestamp)
 			args->out.flags |= HL_WAIT_CS_STATUS_FLAG_GONE;
 	} else {
 		args->out.status = HL_WAIT_CS_STATUS_BUSY;
@@ -2807,21 +2821,6 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	return 0;
 }
 
-static inline unsigned long hl_usecs64_to_jiffies(const u64 usecs)
-{
-	if (usecs <= U32_MAX)
-		return usecs_to_jiffies(usecs);
-
-	/*
-	 * If the value in nanoseconds is larger than 64 bit, use the largest
-	 * 64 bit value.
-	 */
-	if (usecs >= ((u64)(U64_MAX / NSEC_PER_USEC)))
-		return nsecs_to_jiffies(U64_MAX);
-
-	return nsecs_to_jiffies(usecs * NSEC_PER_USEC);
-}
-
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 user_address,
 				u64 target_value, struct hl_user_interrupt *interrupt,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index df1935952c28..eda1c70f6966 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2362,7 +2362,7 @@ struct multi_cs_completion {
  * @ctx: pointer to the context structure
  * @fence_arr: array of fences of all CSs
  * @seq_arr: array of CS sequence numbers
- * @timeout_us: timeout in usec for waiting for CS to complete
+ * @timeout_jiffies: timeout in jiffies for waiting for CS to complete
  * @timestamp: timestamp of first completed CS
  * @wait_status: wait for CS status
  * @completion_bitmap: bitmap of completed CSs (1- completed, otherwise 0)
@@ -2376,7 +2376,7 @@ struct multi_cs_data {
 	struct hl_ctx	*ctx;
 	struct hl_fence	**fence_arr;
 	u64		*seq_arr;
-	s64		timeout_us;
+	s64		timeout_jiffies;
 	s64		timestamp;
 	long		wait_status;
 	u32		completion_bitmap;
-- 
2.25.1


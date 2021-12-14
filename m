Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27E84745FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhLNPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLNPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C0C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:06:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 649EF6156D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04078C34605;
        Tue, 14 Dec 2021 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494368;
        bh=0VtzYGyMNWiTiUmum52VFIUo+7M/gY0tln7ij1i1u1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSSFlGb78wKKmWsf+gt1uWGCFTM6phbJkno+uRDHMTGLVgaHcEL8I7kzPX9C0k5AN
         rGlNFnfZ9yHHpVwTpdrrcbK4J+ReQ7UaPmJ1H6mzmD7Mwsl/hgmMLa0gwh8jpG/yhp
         yGV336FIh5BX+5oJrWxtrWi4Py9WpCgDaPE23J3rASqHVqwac6yqu8Q4r2dnyWBrsK
         np33zkMrwVHCqBiAIVA0BRwZ9eoeQlSBQ/eMfSsv5oyBg+113n8qe4oJTKzm1GZx7L
         j0g7+dzuvbHOWHgJKjlGiHI7M0P776lq90wixmvrmX57NfXFWfU3x6AgxZDYP4i/q4
         pgrJ6T5OnUbhA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 10/11] habanalabs: prevent wait if CS in multi-CS list completed
Date:   Tue, 14 Dec 2021 17:05:50 +0200
Message-Id: <20211214150551.1568192-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

By the original design we assumed that if we "miss" multi CS completion
it is of no severe consequence as we'll just call wait_for_multi_cs
again.

Sequence of events for such scenario:
1. user submit CS with sequence N
2. user calls wait for multi-CS with only CS #N in the list
3. the multi CS call starts with poll of the CSs but find that none
   completed (while CS #N did not completed yet)
4. now, multi CS #N complete but multi CS CTX was not yet created for
   the above multi-CS. so, attempt to complete multi-CS fails (as no
   multi CS CTX exist)
5. wait_for_multi_cs call now does init_wait_multi_cs_completion (and
   for this create the multi-CS CTX)
6. wait_for_multi_cs wits on completion but will not get one as CS #N
   already completed

To fix the issue we initialize the multi-CS CTX prior polling the
fences.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 85 ++++++++++++-------
 drivers/misc/habanalabs/common/habanalabs.h   |  3 -
 2 files changed, 54 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index f58fff3671d6..b9fed6b6d1ab 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -533,8 +533,8 @@ static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 					mcs_compl->stream_master_qid_map)) {
 			/* extract the timestamp only of first completed CS */
 			if (!mcs_compl->timestamp)
-				mcs_compl->timestamp =
-						ktime_to_ns(fence->timestamp);
+				mcs_compl->timestamp = ktime_to_ns(fence->timestamp);
+
 			complete_all(&mcs_compl->completion);
 
 			/*
@@ -2369,16 +2369,18 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
  * hl_cs_poll_fences - iterate CS fences to check for CS completion
  *
  * @mcs_data: multi-CS internal data
+ * @mcs_compl: multi-CS completion structure
  *
  * @return 0 on success, otherwise non 0 error code
  *
  * The function iterates on all CS sequence in the list and set bit in
  * completion_bitmap for each completed CS.
- * while iterating, the function can extracts the stream map to be later
- * used by the waiting function.
- * this function shall be called after taking context ref
+ * While iterating, the function sets the stream map of each fence in the fence
+ * array in the completion QID stream map to be used by CSs to perform
+ * completion to the multi-CS context.
+ * This function shall be called after taking context ref
  */
-static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
+static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_completion *mcs_compl)
 {
 	struct hl_fence **fence_ptr = mcs_data->fence_arr;
 	struct hl_device *hdev = mcs_data->ctx->hdev;
@@ -2394,6 +2396,15 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 	if (rc)
 		return rc;
 
+	/*
+	 * re-initialize the completion here to handle 2 possible cases:
+	 * 1. CS will complete the multi-CS prior clearing the completion. in which
+	 *    case the fence iteration is guaranteed to catch the CS completion.
+	 * 2. the completion will occur after re-init of the completion.
+	 *    in which case we will wake up immediately in wait_for_completion.
+	 */
+	reinit_completion(&mcs_compl->completion);
+
 	/*
 	 * set to maximum time to verify timestamp is valid: if at the end
 	 * this value is maintained- no timestamp was updated
@@ -2404,6 +2415,21 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 	for (i = 0; i < arr_len; i++, fence_ptr++) {
 		struct hl_fence *fence = *fence_ptr;
 
+		/*
+		 * In order to prevent case where we wait until timeout even though a CS associated
+		 * with the multi-CS actually completed we do things in the below order:
+		 * 1. for each fence set it's QID map in the multi-CS completion QID map. This way
+		 *    any CS can, potentially, complete the multi CS for the specific QID (note
+		 *    that once completion is initialized, calling complete* and then wait on the
+		 *    completion will cause it to return at once)
+		 * 2. only after allowing multi-CS completion for the specific QID we check whether
+		 *    the specific CS already completed (and thus the wait for completion part will
+		 *    be skipped). if the CS not completed it is guaranteed that completing CS will
+		 *    wake up the completion.
+		 */
+		if (fence)
+			mcs_compl->stream_master_qid_map |= fence->stream_master_qid_map;
+
 		/*
 		 * function won't sleep as it is called with timeout 0 (i.e.
 		 * poll the fence)
@@ -2419,9 +2445,7 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 
 		switch (status) {
 		case CS_WAIT_STATUS_BUSY:
-			/* CS did not finished, keep waiting on its QID*/
-			mcs_data->stream_master_qid_map |=
-					fence->stream_master_qid_map;
+			/* CS did not finished, QID to wait on already stored */
 			break;
 		case CS_WAIT_STATUS_COMPLETED:
 			/*
@@ -2519,9 +2543,7 @@ static inline unsigned long hl_usecs64_to_jiffies(const u64 usecs)
  * the function gets the first available completion (by marking it "used")
  * and initialize its values.
  */
-static struct multi_cs_completion *hl_wait_multi_cs_completion_init(
-							struct hl_device *hdev,
-							u8 stream_master_bitmap)
+static struct multi_cs_completion *hl_wait_multi_cs_completion_init(struct hl_device *hdev)
 {
 	struct multi_cs_completion *mcs_compl;
 	int i;
@@ -2533,8 +2555,11 @@ static struct multi_cs_completion *hl_wait_multi_cs_completion_init(
 		if (!mcs_compl->used) {
 			mcs_compl->used = 1;
 			mcs_compl->timestamp = 0;
-			mcs_compl->stream_master_qid_map = stream_master_bitmap;
-			reinit_completion(&mcs_compl->completion);
+			/*
+			 * init QID map to 0 to avoid completion by CSs. the actual QID map
+			 * to multi-CS CSs will be set incrementally at a later stage
+			 */
+			mcs_compl->stream_master_qid_map = 0;
 			spin_unlock(&mcs_compl->lock);
 			break;
 		}
@@ -2672,9 +2697,17 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	hl_ctx_get(hdev, ctx);
 
+	/* wait (with timeout) for the first CS to be completed */
+	mcs_data.timeout_jiffies = hl_usecs64_to_jiffies(args->in.timeout_us);
+	mcs_compl = hl_wait_multi_cs_completion_init(hdev);
+	if (IS_ERR(mcs_compl)) {
+		rc = PTR_ERR(mcs_compl);
+		goto put_ctx;
+	}
+
 	/* poll all CS fences, extract timestamp */
 	mcs_data.update_ts = true;
-	rc = hl_cs_poll_fences(&mcs_data);
+	rc = hl_cs_poll_fences(&mcs_data, mcs_compl);
 	/*
 	 * skip wait for CS completion when one of the below is true:
 	 * - an error on the poll function
@@ -2682,16 +2715,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	 * - the user called ioctl with timeout 0
 	 */
 	if (rc || mcs_data.completion_bitmap || !args->in.timeout_us)
-		goto put_ctx;
-
-	/* wait (with timeout) for the first CS to be completed */
-	mcs_data.timeout_jiffies = hl_usecs64_to_jiffies(args->in.timeout_us);
-
-	mcs_compl = hl_wait_multi_cs_completion_init(hdev, mcs_data.stream_master_qid_map);
-	if (IS_ERR(mcs_compl)) {
-		rc = PTR_ERR(mcs_compl);
-		goto put_ctx;
-	}
+		goto completion_fini;
 
 	while (true) {
 		rc = hl_wait_multi_cs_completion(&mcs_data, mcs_compl);
@@ -2703,7 +2727,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		 * no timestamp should be updated this time.
 		 */
 		mcs_data.update_ts = false;
-		rc = hl_cs_poll_fences(&mcs_data);
+		rc = hl_cs_poll_fences(&mcs_data, mcs_compl);
 
 		if (mcs_data.completion_bitmap)
 			break;
@@ -2713,16 +2737,15 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		 * it got a completion) it either got completed by CS in the multi CS list
 		 * (in which case the indication will be non empty completion_bitmap) or it
 		 * got completed by CS submitted to one of the shared stream master but
-		 * not in the multi CS list (in which case we should wait again but reinit
-		 * the completion, modify the timeout and set timestamp as zero to let a CS
-		 * related to the current multi-CS set a new, relevant, timestamp)
+		 * not in the multi CS list (in which case we should wait again but modify
+		 * the timeout and set timestamp as zero to let a CS related to the current
+		 * multi-CS set a new, relevant, timestamp)
 		 */
-		/* wait again with modified timeout */
 		mcs_data.timeout_jiffies = mcs_data.wait_status;
-		reinit_completion(&mcs_compl->completion);
 		mcs_compl->timestamp = 0;
 	}
 
+completion_fini:
 	hl_wait_multi_cs_completion_fini(mcs_compl);
 
 put_ctx:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 015aa1ee8ce0..4d4986177776 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2364,8 +2364,6 @@ struct multi_cs_completion {
  * @timestamp: timestamp of first completed CS
  * @wait_status: wait for CS status
  * @completion_bitmap: bitmap of completed CSs (1- completed, otherwise 0)
- * @stream_master_qid_map: bitmap of all stream master QIDs on which the
- *                         multi-CS is waiting
  * @arr_len: fence_arr and seq_arr array length
  * @gone_cs: indication of gone CS (1- there was gone CS, otherwise 0)
  * @update_ts: update timestamp. 1- update the timestamp, otherwise 0.
@@ -2378,7 +2376,6 @@ struct multi_cs_data {
 	s64		timestamp;
 	long		wait_status;
 	u32		completion_bitmap;
-	u32		stream_master_qid_map;
 	u8		arr_len;
 	u8		gone_cs;
 	u8		update_ts;
-- 
2.25.1


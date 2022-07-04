Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC69B5650C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiGDJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiGDJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6542AC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30AABB80E03
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BC3C341CA;
        Mon,  4 Jul 2022 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926989;
        bh=7B82m5XRERByv+4HslA53l23LR28CuNAjQPqNVtFFGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flUG53cItCCSS0JF+bXf7lgvP8ASFZOcxpLQ3ytdFUapHaSPagP7uiMMMvv3DH2ro
         vniVUls1vHoneRLLMwMmSjicMKMhP30uX2w11HY8YCTIwUUARJ9UzrB4235+su06Ko
         hPZLkk8DijWZF4q6//grPsUMettbfbLZr1EMfUWqLB1MZ0juSI9tp3tpv3imFTh0mC
         aKNtdYbXaalqpdonoZkFdA3E+tHHDoaEZFPGSF2cMqNJcQNM0Q/buckj9of528wlRF
         xdY+W8/B0DNJVBqDINKZSZUmFRmjAw8eEdnSmpXA3Iye4tWIQzF7xhN/0V7su83Ozb
         9J/cKv7jyCE9Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 03/12] habanalabs: naming refactor of user interrupt flow
Date:   Mon,  4 Jul 2022 12:29:32 +0300
Message-Id: <20220704092941.2237683-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Current naming convention can be misleading. Hence renaming some
variables and defines in order to be more explicit.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c |  6 +++---
 drivers/misc/habanalabs/common/habanalabs.h         |  8 ++++----
 drivers/misc/habanalabs/common/irq.c                | 12 ++++++------
 drivers/misc/habanalabs/gaudi2/gaudi2.c             |  6 +++---
 include/uapi/misc/habanalabs.h                      |  7 +++++--
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index e91ca31d4930..275dcb69a40e 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1080,7 +1080,7 @@ void hl_release_pending_user_interrupts(struct hl_device *hdev)
 		wake_pending_user_interrupt_threads(interrupt);
 	}
 
-	interrupt = &hdev->common_user_interrupt;
+	interrupt = &hdev->common_user_cq_interrupt;
 	wake_pending_user_interrupt_threads(interrupt);
 }
 
@@ -3373,8 +3373,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		int_idx = interrupt_id - first_interrupt + prop->user_dec_intr_count;
 		interrupt = &hdev->user_interrupt[int_idx];
 
-	} else if (interrupt_id == HL_COMMON_USER_INTERRUPT_ID) {
-		interrupt = &hdev->common_user_interrupt;
+	} else if (interrupt_id == HL_COMMON_USER_CQ_INTERRUPT_ID) {
+		interrupt = &hdev->common_user_cq_interrupt;
 	} else {
 		dev_err(hdev->dev, "invalid user interrupt %u", interrupt_id);
 		return -EINVAL;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8c38c2c1b1dc..9b2451f3619a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -76,7 +76,7 @@ struct hl_fpriv;
 
 #define HL_INVALID_QUEUE		UINT_MAX
 
-#define HL_COMMON_USER_INTERRUPT_ID	0xFFF
+#define HL_COMMON_USER_CQ_INTERRUPT_ID	0xFFF
 
 #define HL_STATE_DUMP_HIST_LEN		5
 
@@ -2952,8 +2952,8 @@ struct hl_reset_info {
  * @user_interrupt: array of hl_user_interrupt. upon the corresponding user
  *                  interrupt, driver will monitor the list of fences
  *                  registered to this interrupt.
- * @common_user_interrupt: common user interrupt for all user interrupts.
- *                         upon any user interrupt, driver will monitor the
+ * @common_user_cq_interrupt: common user CQ interrupt for all user CQ interrupts.
+ *                         upon any user CQ interrupt, driver will monitor the
  *                         list of fences registered to this common structure.
  * @shadow_cs_queue: pointer to a shadow queue that holds pointers to
  *                   outstanding command submissions.
@@ -3118,7 +3118,7 @@ struct hl_device {
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
 	struct hl_user_interrupt	*user_interrupt;
-	struct hl_user_interrupt	common_user_interrupt;
+	struct hl_user_interrupt	common_user_cq_interrupt;
 	struct hl_cs			**shadow_cs_queue;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index c1088377d1de..fd8f2bd9020e 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -269,7 +269,7 @@ static int handle_registration_node(struct hl_device *hdev, struct hl_user_pendi
 	return 0;
 }
 
-static void handle_user_cq(struct hl_device *hdev, struct hl_user_interrupt *user_cq)
+static void handle_user_interrupt(struct hl_device *hdev, struct hl_user_interrupt *intr)
 {
 	struct hl_user_pending_interrupt *pend, *temp_pend;
 	struct list_head *ts_reg_free_list_head = NULL;
@@ -291,8 +291,8 @@ static void handle_user_cq(struct hl_device *hdev, struct hl_user_interrupt *use
 	if (!job)
 		return;
 
-	spin_lock(&user_cq->wait_list_lock);
-	list_for_each_entry_safe(pend, temp_pend, &user_cq->wait_list_head, wait_list_node) {
+	spin_lock(&intr->wait_list_lock);
+	list_for_each_entry_safe(pend, temp_pend, &intr->wait_list_head, wait_list_node) {
 		if ((pend->cq_kernel_addr && *(pend->cq_kernel_addr) >= pend->cq_target_value) ||
 				!pend->cq_kernel_addr) {
 			if (pend->ts_reg_info.buf) {
@@ -309,7 +309,7 @@ static void handle_user_cq(struct hl_device *hdev, struct hl_user_interrupt *use
 			}
 		}
 	}
-	spin_unlock(&user_cq->wait_list_lock);
+	spin_unlock(&intr->wait_list_lock);
 
 	if (ts_reg_free_list_head) {
 		INIT_WORK(&job->free_obj, hl_ts_free_objects);
@@ -339,10 +339,10 @@ irqreturn_t hl_irq_handler_user_interrupt(int irq, void *arg)
 	 */
 	if (!user_int->is_decoder)
 		/* Handle user cq interrupts registered on all interrupts */
-		handle_user_cq(hdev, &hdev->common_user_interrupt);
+		handle_user_interrupt(hdev, &hdev->common_user_cq_interrupt);
 
 	/* Handle user cq or decoder interrupts registered on this specific irq */
-	handle_user_cq(hdev, user_int);
+	handle_user_interrupt(hdev, user_int);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 5e6df7814fb1..5f61c45e4695 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2891,9 +2891,9 @@ static void gaudi2_user_interrupt_setup(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int i, j, k;
 
-	/* Initialize common user interrupt */
-	HL_USR_INTR_STRUCT_INIT(hdev->common_user_interrupt, hdev, HL_COMMON_USER_INTERRUPT_ID,
-				false);
+	/* Initialize common user CQ interrupt */
+	HL_USR_INTR_STRUCT_INIT(hdev->common_user_cq_interrupt, hdev,
+				HL_COMMON_USER_CQ_INTERRUPT_ID, false);
 
 	/* User interrupts structure holds both decoder and user interrupts from various engines.
 	 * We first initialize the decoder interrupts and then we add the user interrupts.
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 77b89c537ee8..4ee24a3a13e9 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1442,6 +1442,7 @@ union hl_cs_args {
 
 #define HL_WAIT_CS_FLAGS_INTERRUPT		0x2
 #define HL_WAIT_CS_FLAGS_INTERRUPT_MASK		0xFFF00000
+#define HL_WAIT_CS_FLAGS_ANY_CQ_INTERRUPT	0xFFF00000
 #define HL_WAIT_CS_FLAGS_MULTI_CS		0x4
 #define HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ	0x10
 #define HL_WAIT_CS_FLAGS_REGISTER_INTERRUPT	0x20
@@ -1491,8 +1492,10 @@ struct hl_wait_cs_in {
 
 	/* HL_WAIT_CS_FLAGS_*
 	 * If HL_WAIT_CS_FLAGS_INTERRUPT is set, this field should include
-	 * interrupt id according to HL_WAIT_CS_FLAGS_INTERRUPT_MASK, in order
-	 * not to specify an interrupt id ,set mask to all 1s.
+	 * interrupt id according to HL_WAIT_CS_FLAGS_INTERRUPT_MASK
+	 *
+	 * in order to wait for any CQ interrupt, set interrupt value to
+	 * HL_WAIT_CS_FLAGS_ANY_CQ_INTERRUPT.
 	 */
 	__u32 flags;
 
-- 
2.25.1


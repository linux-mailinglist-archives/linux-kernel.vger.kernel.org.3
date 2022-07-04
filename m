Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCF5650CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiGDJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiGDJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9ECFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE84361414
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CC5C341CD;
        Mon,  4 Jul 2022 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926991;
        bh=JkPd/7RJYi7pOUOa5okbwFDx24y/tNci5WuULgEY72o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1Bo1hgSM/mviu+4obAPi0qR1vfXMzaGqgdUJYsmFZP5ZnJdT073q5mjep4zk5h+M
         mCUG8dXiIEAgaL3+5Q9KpPEtoEWuge75jIRFnKOFUSDO7rLsBAPbSZX1UMprkKfSKD
         JMbrvnwJL2mKRi2rE4/VmG5bgb4N/bfPH/cIKD7raUbfFeFLO3qXVUvSXS7IuUuul4
         xsLxth/zoWONTz5e40vScl88q1gBHzgdnrRrrsWkclqRXSlAV34aguxJ+Zcpe6U98r
         x7xqXlC/GTtV2Fc9GWlVx8pS+iTQP1lK/Aqw5OBYZQHyMyYM3hcwEi4au+4gFS1G0W
         o75d08G7beO4w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 04/12] habanalabs: add support for common decoder interrupts
Date:   Mon,  4 Jul 2022 12:29:33 +0300
Message-Id: <20220704092941.2237683-4-ogabbay@kernel.org>
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

User application should be able to get notification for any decoder
completion. Hence, we introduce a new interface in which a user
can wait for all current decoder pending interrupts.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 5 +++++
 drivers/misc/habanalabs/common/habanalabs.h         | 3 +++
 drivers/misc/habanalabs/common/irq.c                | 9 +++------
 drivers/misc/habanalabs/gaudi2/gaudi2.c             | 4 ++++
 include/uapi/misc/habanalabs.h                      | 4 ++++
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 275dcb69a40e..eb5f1aee15fc 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1082,6 +1082,9 @@ void hl_release_pending_user_interrupts(struct hl_device *hdev)
 
 	interrupt = &hdev->common_user_cq_interrupt;
 	wake_pending_user_interrupt_threads(interrupt);
+
+	interrupt = &hdev->common_decoder_interrupt;
+	wake_pending_user_interrupt_threads(interrupt);
 }
 
 static void job_wq_completion(struct work_struct *work)
@@ -3375,6 +3378,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	} else if (interrupt_id == HL_COMMON_USER_CQ_INTERRUPT_ID) {
 		interrupt = &hdev->common_user_cq_interrupt;
+	} else if (interrupt_id == HL_COMMON_DEC_INTERRUPT_ID) {
+		interrupt = &hdev->common_decoder_interrupt;
 	} else {
 		dev_err(hdev->dev, "invalid user interrupt %u", interrupt_id);
 		return -EINVAL;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9b2451f3619a..7e84f2ce49ae 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -77,6 +77,7 @@ struct hl_fpriv;
 #define HL_INVALID_QUEUE		UINT_MAX
 
 #define HL_COMMON_USER_CQ_INTERRUPT_ID	0xFFF
+#define HL_COMMON_DEC_INTERRUPT_ID	0xFFE
 
 #define HL_STATE_DUMP_HIST_LEN		5
 
@@ -2955,6 +2956,7 @@ struct hl_reset_info {
  * @common_user_cq_interrupt: common user CQ interrupt for all user CQ interrupts.
  *                         upon any user CQ interrupt, driver will monitor the
  *                         list of fences registered to this common structure.
+ * @common_decoder_interrupt: common decoder interrupt for all user decoder interrupts.
  * @shadow_cs_queue: pointer to a shadow queue that holds pointers to
  *                   outstanding command submissions.
  * @cq_wq: work queues of completion queues for executing work in process
@@ -3119,6 +3121,7 @@ struct hl_device {
 	struct hl_cq			*completion_queue;
 	struct hl_user_interrupt	*user_interrupt;
 	struct hl_user_interrupt	common_user_cq_interrupt;
+	struct hl_user_interrupt	common_decoder_interrupt;
 	struct hl_cs			**shadow_cs_queue;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index fd8f2bd9020e..d60dafb03a8e 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -333,12 +333,9 @@ irqreturn_t hl_irq_handler_user_interrupt(int irq, void *arg)
 	struct hl_user_interrupt *user_int = arg;
 	struct hl_device *hdev = user_int->hdev;
 
-	/* If the interrupt is not a decoder interrupt, it means the interrupt
-	 * belongs to a user cq. In that case, before handling it, we need to handle the common
-	 * user cq
-	 */
-	if (!user_int->is_decoder)
-		/* Handle user cq interrupts registered on all interrupts */
+	if (user_int->is_decoder)
+		handle_user_interrupt(hdev, &hdev->common_decoder_interrupt);
+	else
 		handle_user_interrupt(hdev, &hdev->common_user_cq_interrupt);
 
 	/* Handle user cq or decoder interrupts registered on this specific irq */
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 5f61c45e4695..71eb767835bd 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2895,6 +2895,10 @@ static void gaudi2_user_interrupt_setup(struct hl_device *hdev)
 	HL_USR_INTR_STRUCT_INIT(hdev->common_user_cq_interrupt, hdev,
 				HL_COMMON_USER_CQ_INTERRUPT_ID, false);
 
+	/* Initialize common decoder interrupt */
+	HL_USR_INTR_STRUCT_INIT(hdev->common_decoder_interrupt, hdev,
+				HL_COMMON_DEC_INTERRUPT_ID, true);
+
 	/* User interrupts structure holds both decoder and user interrupts from various engines.
 	 * We first initialize the decoder interrupts and then we add the user interrupts.
 	 * The only limitation is that the last decoder interrupt id must be smaller
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 4ee24a3a13e9..8c6ab71e7831 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1443,6 +1443,7 @@ union hl_cs_args {
 #define HL_WAIT_CS_FLAGS_INTERRUPT		0x2
 #define HL_WAIT_CS_FLAGS_INTERRUPT_MASK		0xFFF00000
 #define HL_WAIT_CS_FLAGS_ANY_CQ_INTERRUPT	0xFFF00000
+#define HL_WAIT_CS_FLAGS_ANY_DEC_INTERRUPT	0xFFE00000
 #define HL_WAIT_CS_FLAGS_MULTI_CS		0x4
 #define HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ	0x10
 #define HL_WAIT_CS_FLAGS_REGISTER_INTERRUPT	0x20
@@ -1496,6 +1497,9 @@ struct hl_wait_cs_in {
 	 *
 	 * in order to wait for any CQ interrupt, set interrupt value to
 	 * HL_WAIT_CS_FLAGS_ANY_CQ_INTERRUPT.
+	 *
+	 * in order to wait for any decoder interrupt, set interrupt value to
+	 * HL_WAIT_CS_FLAGS_ANY_DEC_INTERRUPT.
 	 */
 	__u32 flags;
 
-- 
2.25.1


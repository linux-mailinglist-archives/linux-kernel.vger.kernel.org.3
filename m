Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106956D4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiGKGa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiGKGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D79FDE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60C3BB80DA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EFCC3411C;
        Mon, 11 Jul 2022 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521013;
        bh=5pbIGIBK4GHTaDaRaErlg2h4kfcH4zLZIFSMl58kGEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLIH05xV0Za3VQBbaYJLp24JIhgqCuOuSHiiT3SDXN3/3lilYdj76hLrGvlQMzKMs
         jvOju6dEhryTVWa7zBdMcGZEzo3KMzaVrDqtbHk9rr8Wi0/XD2m7v4M+P+vCBL68W2
         llmzjCg3o6d2N+Ln/dWoJ6V3a9+RnE8YlpMyGkdJQlS8n8HDfUfnwVMuG4vCSONu3E
         MEPGWZJmlq0kdoLm1KnRA0NtwIXalhHgTjUH5OF3aGM+p+gTq8WmX2I7qimT0lfW0n
         CobExqghheLXai4PlDiAf5gVB8cmNh4LWhCLxNDSCd4g6xRymWAJR0Yl68ANAS4jVN
         aNKgBmohyKUQw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 04/12] habanalabs/gaudi2: replace defines for reserved sob/mob with enums
Date:   Mon, 11 Jul 2022 09:29:55 +0300
Message-Id: <20220711063003.3182795-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Following patches are going to add more reserved sync objects and
monitors.
To make the counting of these reserved resources simpler, replace the
existing RESERVED_* defines with enumerations.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 48 ++++++++++---------
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      | 26 ++++++----
 .../misc/habanalabs/gaudi2/gaudi2_security.c  |  4 +-
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 539cb88a88e4..398bc0957417 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1867,8 +1867,8 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 	prop->user_dec_intr_count = NUMBER_OF_DEC;
 	prop->user_interrupt_count = GAUDI2_IRQ_NUM_USER_LAST - GAUDI2_IRQ_NUM_USER_FIRST + 1;
 	prop->completion_mode = HL_COMPLETION_MODE_CS;
-	prop->sync_stream_first_sob = GAUDI2_RESERVED_SOBS;
-	prop->sync_stream_first_mon = GAUDI2_RESERVED_MONITORS;
+	prop->sync_stream_first_sob = GAUDI2_RESERVED_SOB_NUMBER;
+	prop->sync_stream_first_mon = GAUDI2_RESERVED_MON_NUMBER;
 
 	prop->sram_base_address = SRAM_BASE_ADDR;
 	prop->sram_size = SRAM_SIZE;
@@ -1988,10 +1988,10 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 
 	prop->mme_master_slave_mode = 1;
 
-	prop->first_available_user_sob[0] = GAUDI2_RESERVED_SOBS +
+	prop->first_available_user_sob[0] = GAUDI2_RESERVED_SOB_NUMBER +
 					(num_sync_stream_queues * HL_RSVD_SOBS);
 
-	prop->first_available_user_mon[0] = GAUDI2_RESERVED_MONITORS +
+	prop->first_available_user_mon[0] = GAUDI2_RESERVED_MON_NUMBER +
 					(num_sync_stream_queues * HL_RSVD_MONS);
 
 	prop->first_available_user_interrupt = GAUDI2_IRQ_NUM_USER_FIRST;
@@ -3533,7 +3533,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 	}
 
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
-	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_COMPLETION];
+	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_CS_COMPLETION];
 	rc = request_irq(irq, hl_irq_handler_cq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
@@ -3643,7 +3643,7 @@ static void gaudi2_disable_msix(struct hl_device *hdev)
 	}
 
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
-	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_COMPLETION];
+	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_CS_COMPLETION];
 	free_irq(irq, cq);
 
 	pci_free_irq_vectors(hdev->pdev);
@@ -4139,7 +4139,7 @@ static void gaudi2_init_qman(struct hl_device *hdev, u32 reg_base,
 	u32 pq_id;
 
 	for (pq_id = 0 ; pq_id < NUM_OF_PQ_PER_QMAN ; pq_id++)
-		hdev->kernel_queues[queue_id_base + pq_id].cq_id = GAUDI2_RESERVED_CQ_COMPLETION;
+		hdev->kernel_queues[queue_id_base + pq_id].cq_id = GAUDI2_RESERVED_CQ_CS_COMPLETION;
 
 	gaudi2_init_qman_pq(hdev, reg_base, queue_id_base);
 	gaudi2_init_qman_cp(hdev, reg_base);
@@ -5762,31 +5762,33 @@ static void gaudi2_kdma_set_mmbp_asid(struct hl_device *hdev,
 	WREG32(mmARC_FARM_KDMA_CTX_AXUSER_HB_MMU_BP, rw_mmu_bp);
 }
 
-static void gaudi2_arm_cq_monitor(struct hl_device *hdev, u32 index, u32 cq_id,
+static void gaudi2_arm_cq_monitor(struct hl_device *hdev, u32 sob_id, u32 mon_id, u32 cq_id,
 						u32 mon_payload, u32 sync_value)
 {
-	u32 sync_group_id, mode, mon_arm;
-	int offset = index * 4;
+	u32 sob_offset, mon_offset, sync_group_id, mode, mon_arm;
 	u8 mask;
 
+	sob_offset = sob_id * 4;
+	mon_offset = mon_id * 4;
+
 	/* Reset the SOB value */
-	WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + offset, 0);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset, 0);
 
 	/* Configure this address with CQ_ID 0 because CQ_EN is set */
-	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + offset, cq_id);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + mon_offset, cq_id);
 
 	/* Configure this address with CS index because CQ_EN is set */
-	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + offset, mon_payload);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + mon_offset, mon_payload);
 
-	sync_group_id = index / 8;
-	mask = ~(1 << (index & 0x7));
+	sync_group_id = sob_id / 8;
+	mask = ~(1 << (sob_id & 0x7));
 	mode = 1; /* comparison mode is "equal to" */
 
 	mon_arm = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOD_MASK, sync_value);
 	mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOP_MASK, mode);
 	mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_MASK_MASK, mask);
 	mon_arm |= FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SID_MASK, sync_group_id);
-	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + offset, mon_arm);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + mon_offset, mon_arm);
 }
 
 /* This is an internal helper function used by gaudi2_send_job_to_kdma only */
@@ -5800,11 +5802,12 @@ static int gaudi2_send_job_to_kdma(struct hl_device *hdev,
 	u64 comp_addr;
 	int rc;
 
-	gaudi2_arm_cq_monitor(hdev, GAUDI2_RESERVED_SOB_KDMA_COMP,
+	gaudi2_arm_cq_monitor(hdev, GAUDI2_RESERVED_SOB_KDMA_COMPLETION,
+				GAUDI2_RESERVED_MON_KDMA_COMPLETION,
 				GAUDI2_RESERVED_CQ_KDMA_COMPLETION, 1, 1);
 
 	comp_addr = CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 +
-			(GAUDI2_RESERVED_SOB_KDMA_COMP * sizeof(u32));
+			(GAUDI2_RESERVED_SOB_KDMA_COMPLETION * sizeof(u32));
 
 	comp_val = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1) |
 			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1);
@@ -9125,24 +9128,25 @@ static int gaudi2_pre_schedule_cs(struct hl_cs *cs)
 {
 	struct hl_device *hdev = cs->ctx->hdev;
 	int index = cs->sequence & (hdev->asic_prop.max_pending_cs - 1);
-	u32 mon_payload;
+	u32 mon_payload, sob_id, mon_id;
 
 	if (!cs_needs_completion(cs))
 		return 0;
 
 	/*
-	 * First 1024 SOB/MON are reserved for driver for QMAN auto completion
+	 * First 64 SOB/MON are reserved for driver for QMAN auto completion
 	 * mechanism. Each SOB/MON pair are used for a pending CS with the same
 	 * cyclic index. The SOB value is increased when each of the CS jobs is
 	 * completed. When the SOB reaches the number of CS jobs, the monitor
 	 * generates MSI-X interrupt.
 	 */
 
+	sob_id = mon_id = index;
 	mon_payload = (1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT) |
 				(1 << CQ_ENTRY_READY_SHIFT) | index;
 
-	gaudi2_arm_cq_monitor(hdev, index, GAUDI2_RESERVED_CQ_COMPLETION,
-						mon_payload, cs->jobs_cnt);
+	gaudi2_arm_cq_monitor(hdev, sob_id, mon_id, GAUDI2_RESERVED_CQ_CS_COMPLETION, mon_payload,
+				cs->jobs_cnt);
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index 012413d7df9a..826d24284dc5 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -80,12 +80,6 @@
 
 #define GAUDI2_MAX_PENDING_CS		64
 
-/* Sob/Mon per CS + Sob/Mon for KDMA completion */
-#define GAUDI2_RESERVED_SOBS		(GAUDI2_MAX_PENDING_CS + 1)
-#define GAUDI2_RESERVED_MONITORS	(GAUDI2_MAX_PENDING_CS + 1)
-#define GAUDI2_RESERVED_SOB_KDMA_COMP	(GAUDI2_MAX_PENDING_CS)
-#define GAUDI2_RESERVED_MON_KDMA_COMP	(GAUDI2_MAX_PENDING_CS)
-
 #if !IS_MAX_PENDING_CS_VALID(GAUDI2_MAX_PENDING_CS)
 #error "GAUDI2_MAX_PENDING_CS must be power of 2 and greater than 1"
 #endif
@@ -249,10 +243,26 @@
 
 #define GAUDI2_ARC_PCI_MSB_ADDR(addr)	(((addr) & GENMASK_ULL(49, 28)) >> 28)
 
+enum gaudi2_reserved_sob_id {
+	GAUDI2_RESERVED_SOB_CS_COMPLETION_FIRST,
+	GAUDI2_RESERVED_SOB_CS_COMPLETION_LAST =
+			GAUDI2_RESERVED_SOB_CS_COMPLETION_FIRST + GAUDI2_MAX_PENDING_CS - 1,
+	GAUDI2_RESERVED_SOB_KDMA_COMPLETION,
+	GAUDI2_RESERVED_SOB_NUMBER
+};
+
+enum gaudi2_reserved_mon_id {
+	GAUDI2_RESERVED_MON_CS_COMPLETION_FIRST,
+	GAUDI2_RESERVED_MON_CS_COMPLETION_LAST =
+			GAUDI2_RESERVED_MON_CS_COMPLETION_FIRST + GAUDI2_MAX_PENDING_CS - 1,
+	GAUDI2_RESERVED_MON_KDMA_COMPLETION,
+	GAUDI2_RESERVED_MON_NUMBER
+};
+
 enum gaudi2_reserved_cq_id {
-	GAUDI2_RESERVED_CQ_COMPLETION,
+	GAUDI2_RESERVED_CQ_CS_COMPLETION,
 	GAUDI2_RESERVED_CQ_KDMA_COMPLETION,
-	GAUDI2_RESERVED_CQ_NUMBER,
+	GAUDI2_RESERVED_CQ_NUMBER
 };
 
 /*
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_security.c b/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
index afca8352a223..89a06ff5ba34 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
@@ -2703,8 +2703,8 @@ static int gaudi2_init_pb_sm_objs(struct hl_device *hdev)
 	if (!sec_array)
 		return -ENOMEM;
 
-	first_sob = GAUDI2_RESERVED_SOBS;
-	first_mon = GAUDI2_RESERVED_MONITORS;
+	first_sob = GAUDI2_RESERVED_SOB_NUMBER;
+	first_mon = GAUDI2_RESERVED_MON_NUMBER;
 
 	/* 8192 SOB_OBJs skipping first GAUDI2_MAX_PENDING_CS of them */
 	for (j = i = first_sob ; i < DCORE_NUM_OF_SOB ; i++, j++)
-- 
2.25.1


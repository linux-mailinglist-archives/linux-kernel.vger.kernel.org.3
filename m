Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365557B529
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiGTLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiGTLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F71FCE9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D4FB81E68
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF74C341C7;
        Wed, 20 Jul 2022 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315733;
        bh=o4oMi1HIFSmqHQWseTr4X66ZjfEw6cnJ0hNf/ZTr+oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLWeRbhxFrvOYGhULaPsEDFEimDD+6YVKnurOBAHRyBmWXMGfeM0OAf+BT0Dpb+Po
         rPGzErHk5wOZG0CWn5nqV2HGzRX0LGauFBgUZe4VXWk2p5RjPHNK0STCY3jn+nzlVQ
         1knhmO5rLUI/6j4iygLtnhHiJHPU2UsxlPk+DFnJEB5Bltd4aE0mHXqtXvy9gjmvbD
         8GnxAAkPiT4da+3iuoEKb6sTe1zBeoyR4Tr7uZFZJs8DPM+MlOCxhRLjRTjITHQY0u
         In74hO+ky3Dvhr4gyFOuH2cNHiyTk4inCf2NaotCyx097zkYuBH0RmOXqAV9x2QzE8
         CoZnnkB5w1QxQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/9] habanalabs: add return code field to module iterator
Date:   Wed, 20 Jul 2022 14:15:18 +0300
Message-Id: <20220720111523.4069830-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Up until now the module iterator called void callback functions
and so caller activating callback that may fail suffered from 2 issues:
1. The need to "plant" return called in the private data. This is a
   drawback since the iterator itself should not be aware of the private
   data of the caller.
2. Due to 1 even in a failure the iterator would keep iterating instead
   of break upon error.

To overcome this an optional rc field added to the iterator context.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h   |  7 +++--
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 26 +++++++++++++------
 .../misc/habanalabs/gaudi2/gaudi2_security.c  | 19 +++++++-------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6d7b66cd50f1..8c2c94fb1322 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -208,6 +208,7 @@ enum hl_protection_levels {
  * struct iterate_module_ctx - HW module iterator
  * @fn: function to apply to each HW module instance
  * @data: optional internal data to the function iterator
+ * @rc: return code for optional use of iterator/iterator-caller
  */
 struct iterate_module_ctx {
 	/*
@@ -217,10 +218,12 @@ struct iterate_module_ctx {
 	 * @inst: HW module instance within the block
 	 * @offset: current HW module instance offset from the 1-st HW module instance
 	 *          in the 1-st block
-	 * @data: function specific data
+	 * @ctx: the iterator context.
 	 */
-	void (*fn)(struct hl_device *hdev, int block, int inst, u32 offset, void *data);
+	void (*fn)(struct hl_device *hdev, int block, int inst, u32 offset,
+			struct iterate_module_ctx *ctx);
 	void *data;
+	int rc;
 };
 
 struct hl_block_glbl_sec {
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 465d9c319c3c..3531a339e742 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1712,6 +1712,9 @@ void gaudi2_iterate_tpcs(struct hl_device *hdev, struct iterate_module_ctx *ctx)
 	int dcore, inst, tpc_seq;
 	u32 offset;
 
+	/* init the return code */
+	ctx->rc = 0;
+
 	for (dcore = 0; dcore < NUM_OF_DCORES; dcore++) {
 		for (inst = 0; inst < NUM_OF_TPC_PER_DCORE; inst++) {
 			tpc_seq = dcore * NUM_OF_TPC_PER_DCORE + inst;
@@ -1721,7 +1724,12 @@ void gaudi2_iterate_tpcs(struct hl_device *hdev, struct iterate_module_ctx *ctx)
 
 			offset = (DCORE_OFFSET * dcore) + (DCORE_TPC_OFFSET * inst);
 
-			ctx->fn(hdev, dcore, inst, offset, ctx->data);
+			ctx->fn(hdev, dcore, inst, offset, ctx);
+			if (ctx->rc) {
+				dev_err(hdev->dev, "TPC iterator failed for DCORE%d TPC%d\n",
+							dcore, inst);
+				return;
+			}
 		}
 	}
 
@@ -1730,7 +1738,9 @@ void gaudi2_iterate_tpcs(struct hl_device *hdev, struct iterate_module_ctx *ctx)
 
 	/* special check for PCI TPC (DCORE0_TPC6) */
 	offset = DCORE_TPC_OFFSET * (NUM_DCORE0_TPC - 1);
-	ctx->fn(hdev, 0, NUM_DCORE0_TPC - 1, offset, ctx->data);
+	ctx->fn(hdev, 0, NUM_DCORE0_TPC - 1, offset, ctx);
+	if (ctx->rc)
+		dev_err(hdev->dev, "TPC iterator failed for DCORE0 TPC6\n");
 }
 
 static bool gaudi2_host_phys_addr_valid(u64 addr)
@@ -4507,10 +4517,10 @@ struct gaudi2_tpc_init_cfg_data {
 };
 
 static void gaudi2_init_tpc_config(struct hl_device *hdev, int dcore, int inst,
-							u32 offset, void *data)
+					u32 offset, struct iterate_module_ctx *ctx)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
-	struct gaudi2_tpc_init_cfg_data *cfg_data = data;
+	struct gaudi2_tpc_init_cfg_data *cfg_data = ctx->data;
 	u32 queue_id_base;
 	u8 seq;
 
@@ -6155,9 +6165,9 @@ static int gaudi2_compute_reset_late_init(struct hl_device *hdev)
 }
 
 static void gaudi2_is_tpc_engine_idle(struct hl_device *hdev, int dcore, int inst, u32 offset,
-					void *data)
+					struct iterate_module_ctx *ctx)
 {
-	struct gaudi2_tpc_idle_data *idle_data = (struct gaudi2_tpc_idle_data *)data;
+	struct gaudi2_tpc_idle_data *idle_data = ctx->data;
 	u32 tpc_cfg_sts, qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts;
 	bool is_eng_idle;
 	int engine_idx;
@@ -6736,9 +6746,9 @@ static int gaudi2_mmu_shared_prepare(struct hl_device *hdev, u32 asid)
 }
 
 static void gaudi2_tpc_mmu_prepare(struct hl_device *hdev, int dcore, int inst,	u32 offset,
-					void *data)
+					struct iterate_module_ctx *ctx)
 {
-	struct gaudi2_tpc_mmu_data *mmu_data = (struct gaudi2_tpc_mmu_data *)data;
+	struct gaudi2_tpc_mmu_data *mmu_data = ctx->data;
 
 	WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_MMU_BP + offset, 0);
 	WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_ASID + offset, mmu_data->rw_asid);
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_security.c b/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
index 89a06ff5ba34..c4165db06db2 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
@@ -2583,9 +2583,9 @@ struct gaudi2_tpc_pb_data {
 };
 
 static void gaudi2_config_tpcs_glbl_sec(struct hl_device *hdev, int dcore, int inst, u32 offset,
-					void *data)
+						struct iterate_module_ctx *ctx)
 {
-	struct gaudi2_tpc_pb_data *pb_data = (struct gaudi2_tpc_pb_data *)data;
+	struct gaudi2_tpc_pb_data *pb_data = ctx->data;
 
 	hl_config_glbl_sec(hdev, gaudi2_pb_dcr0_tpc0, pb_data->glbl_sec,
 					offset, pb_data->block_array_size);
@@ -2660,15 +2660,14 @@ static int gaudi2_init_pb_tpc(struct hl_device *hdev)
 struct gaudi2_tpc_arc_pb_data {
 	u32 unsecured_regs_arr_size;
 	u32 arc_regs_arr_size;
-	int rc;
 };
 
 static void gaudi2_config_tpcs_pb_ranges(struct hl_device *hdev, int dcore, int inst, u32 offset,
-					void *data)
+						struct iterate_module_ctx *ctx)
 {
-	struct gaudi2_tpc_arc_pb_data *pb_data = (struct gaudi2_tpc_arc_pb_data *)data;
+	struct gaudi2_tpc_arc_pb_data *pb_data = ctx->data;
 
-	pb_data->rc |= hl_init_pb_ranges(hdev, HL_PB_SHARED, HL_PB_NA, 1,
+	ctx->rc = hl_init_pb_ranges(hdev, HL_PB_SHARED, HL_PB_NA, 1,
 					offset, gaudi2_pb_dcr0_tpc0_arc,
 					pb_data->arc_regs_arr_size,
 					gaudi2_pb_dcr0_tpc0_arc_unsecured_regs,
@@ -2683,12 +2682,12 @@ static int gaudi2_init_pb_tpc_arc(struct hl_device *hdev)
 	tpc_arc_pb_data.arc_regs_arr_size = ARRAY_SIZE(gaudi2_pb_dcr0_tpc0_arc);
 	tpc_arc_pb_data.unsecured_regs_arr_size =
 			ARRAY_SIZE(gaudi2_pb_dcr0_tpc0_arc_unsecured_regs);
-	tpc_arc_pb_data.rc = 0;
+
 	tpc_iter.fn = &gaudi2_config_tpcs_pb_ranges;
 	tpc_iter.data = &tpc_arc_pb_data;
 	gaudi2_iterate_tpcs(hdev, &tpc_iter);
 
-	return tpc_arc_pb_data.rc;
+	return tpc_iter.rc;
 }
 
 static int gaudi2_init_pb_sm_objs(struct hl_device *hdev)
@@ -3547,9 +3546,9 @@ struct gaudi2_ack_pb_tpc_data {
 };
 
 static void gaudi2_ack_pb_tpc_config(struct hl_device *hdev, int dcore, int inst, u32 offset,
-					void *data)
+					struct iterate_module_ctx *ctx)
 {
-	struct gaudi2_ack_pb_tpc_data *pb_data = (struct gaudi2_ack_pb_tpc_data *)data;
+	struct gaudi2_ack_pb_tpc_data *pb_data = ctx->data;
 
 	hl_ack_pb_single_dcore(hdev, offset, HL_PB_SINGLE_INSTANCE, HL_PB_NA,
 				gaudi2_pb_dcr0_tpc0, pb_data->tpc_regs_array_size);
-- 
2.25.1


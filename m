Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1763156D4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGKGaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGKGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC29FC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67293611E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A5C3411C;
        Mon, 11 Jul 2022 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521015;
        bh=MEnl6Y9aAxF+5Le8CAQRnOg9hB1/tyRcMD2t6N/tNFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLLds8q38TJx8yyqLeJWVu05j5eFNqGIQfyrs4OTpQRvbQBnRVZydOvCjj+1pPZ/Z
         B33Xog0OE4R2PIiqYBaxJMRKlIPk1n2DsF8qdIWPMgr8RLUaJf52QT4iTQL7XT7rmd
         RFombc1RHnQDlPMvJSwCSbdBEUpgXPeUkbyGrWtUc0Rrr4P8D2P4yaRcx8k0M1t1wi
         7/81mzh/RM49MF9bQCZBQxn8avRbhtqRS3+odf4g1KLbW6McXwTw5v8y3UWPgBe/zy
         tC29l5Z7Ojn0lyhQFezLuYpg5sGFw5MAxxn812uwlGm7kHWkhfHAEPHGuoyf2kpqH6
         60uB+FO+sucUw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 06/12] habanalabs/gaudi2: modify decoder to use virtual MSI-X doorbell
Date:   Mon, 11 Jul 2022 09:29:57 +0300
Message-Id: <20220711063003.3182795-6-ogabbay@kernel.org>
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

Modify the decoder wrapper blocks to generate interrupts using the
virtual MSI-X doorbell.

As a decoder wrapper block cannot write directly to HBW upon completion,
it writes instead to SOB which is monitored by a master monitor.
When resolved, this monitor will be the one to actually write to the
virtual MSI-X doorbell.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 141 +++++++++++++++++-
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      |  15 ++
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h |   3 +
 .../include/gaudi2/asic_reg/gaudi2_regs.h     |   6 +
 4 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 60e11007e3ea..760ce5b7f955 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -4252,6 +4252,109 @@ static void gaudi2_init_edma(struct hl_device *hdev)
 	}
 }
 
+/*
+ * gaudi2_arm_monitors_for_virt_msix_db() - Arm monitors for writing to the virtual MSI-X doorbell.
+ * @hdev: pointer to habanalabs device structure.
+ * @sob_id: sync object ID.
+ * @first_mon_id: ID of first monitor out of 3 consecutive monitors.
+ * @interrupt_id: interrupt ID.
+ *
+ * Some initiators cannot have HBW address in their completion address registers, and thus cannot
+ * write directly to the HBW host memory of the virtual MSI-X doorbell.
+ * Instead, they are configured to LBW write to a sync object, and a monitor will do the HBW write.
+ *
+ * The mechanism in the sync manager block is composed of a master monitor with 3 messages.
+ * In addition to the HBW write, the other 2 messages are for preparing the monitor to next
+ * completion, by decrementing the sync object value and re-arming the monitor.
+ */
+static void gaudi2_arm_monitors_for_virt_msix_db(struct hl_device *hdev, u32 sob_id,
+							u32 first_mon_id, u32 interrupt_id)
+{
+	u32 sob_offset, first_mon_offset, mon_offset, payload, sob_group, mode, arm, config;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	u64 addr;
+	u8 mask;
+
+	/* Reset the SOB value */
+	sob_offset = sob_id * sizeof(u32);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset, 0);
+
+	/* Configure 3 monitors:
+	 * 1. Write interrupt ID to the virtual MSI-X doorbell (master monitor)
+	 * 2. Decrement SOB value by 1.
+	 * 3. Re-arm the master monitor.
+	 */
+
+	first_mon_offset = first_mon_id * sizeof(u32);
+
+	/* 2nd monitor: Decrement SOB value by 1 */
+	mon_offset = first_mon_offset + sizeof(u32);
+
+	addr = CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_offset;
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + mon_offset, lower_32_bits(addr));
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0 + mon_offset, upper_32_bits(addr));
+
+	payload = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 0x7FFF) | /* "-1" */
+			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_SIGN_MASK, 1) |
+			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1);
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + mon_offset, payload);
+
+	/* 3rd monitor: Re-arm the master monitor */
+	mon_offset = first_mon_offset + 2 * sizeof(u32);
+
+	addr = CFG_BASE + mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + first_mon_offset;
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + mon_offset, lower_32_bits(addr));
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0 + mon_offset, upper_32_bits(addr));
+
+	sob_group = sob_id / 8;
+	mask = ~BIT(sob_id & 0x7);
+	mode = 0; /* comparison mode is "greater than or equal to" */
+	arm = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SID_MASK, sob_group) |
+			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_MASK_MASK, mask) |
+			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOP_MASK, mode) |
+			FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_ARM_SOD_MASK, 1);
+
+	payload = arm;
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + mon_offset, payload);
+
+	/* 1st monitor (master): Write interrupt ID to the virtual MSI-X doorbell */
+	mon_offset = first_mon_offset;
+
+	config = FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_MON_CONFIG_WR_NUM_MASK, 2); /* "2": 3 writes */
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_CONFIG_0 + mon_offset, config);
+
+	addr = gaudi2->virt_msix_db_dma_addr;
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0 + mon_offset, lower_32_bits(addr));
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0 + mon_offset, upper_32_bits(addr));
+
+	payload = interrupt_id;
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_PAY_DATA_0 + mon_offset, payload);
+
+	WREG32(mmDCORE0_SYNC_MNGR_OBJS_MON_ARM_0 + mon_offset, arm);
+}
+
+static void gaudi2_prepare_sm_for_virt_msix_db(struct hl_device *hdev)
+{
+	u32 decoder_id, sob_id, first_mon_id, interrupt_id;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/* Decoder normal/abnormal interrupts */
+	for (decoder_id = 0 ; decoder_id < NUMBER_OF_DEC ; ++decoder_id) {
+		if (!(prop->decoder_enabled_mask & BIT(decoder_id)))
+			continue;
+
+		sob_id = GAUDI2_RESERVED_SOB_DEC_NRM_FIRST + decoder_id;
+		first_mon_id = GAUDI2_RESERVED_MON_DEC_NRM_FIRST + 3 * decoder_id;
+		interrupt_id = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM + 2 * decoder_id;
+		gaudi2_arm_monitors_for_virt_msix_db(hdev, sob_id, first_mon_id, interrupt_id);
+
+		sob_id = GAUDI2_RESERVED_SOB_DEC_ABNRM_FIRST + decoder_id;
+		first_mon_id = GAUDI2_RESERVED_MON_DEC_ABNRM_FIRST + 3 * decoder_id;
+		interrupt_id += 1;
+		gaudi2_arm_monitors_for_virt_msix_db(hdev, sob_id, first_mon_id, interrupt_id);
+	}
+}
+
 static void gaudi2_init_sm(struct hl_device *hdev)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
@@ -4304,6 +4407,9 @@ static void gaudi2_init_sm(struct hl_device *hdev)
 	/* Configure kernel ASID and MMU BP*/
 	WREG32(mmDCORE0_SYNC_MNGR_GLBL_ASID_SEC, 0x10000);
 	WREG32(mmDCORE0_SYNC_MNGR_GLBL_ASID_NONE_SEC_PRIV, 0);
+
+	/* Initialize sync objects and monitors which are used for the virtual MSI-X doorbell */
+	gaudi2_prepare_sm_for_virt_msix_db(hdev);
 }
 
 static void gaudi2_init_mme_acc(struct hl_device *hdev, u32 reg_base)
@@ -4452,10 +4558,35 @@ static void gaudi2_init_rotator(struct hl_device *hdev)
 	}
 }
 
-static void gaudi2_init_vdec_brdg_ctrl(struct hl_device *hdev, u64 base_addr, u32 msix_id)
+static void gaudi2_init_vdec_brdg_ctrl(struct hl_device *hdev, u64 base_addr, u32 decoder_id)
 {
-	WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_WDATA, msix_id);
-	WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_WDATA, msix_id + 1);
+	u32 sob_id;
+
+	/* TODO:
+	 * Remove when virtual MSI-X doorbell is supported in simulator (SW-93022) and in F/W
+	 * (SW-93024).
+	 */
+	if (!hdev->pdev || hdev->asic_prop.fw_security_enabled) {
+		u32 interrupt_id = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM + 2 * decoder_id;
+
+		WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_AWADDR, mmPCIE_DBI_MSIX_DOORBELL_OFF);
+		WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_WDATA, interrupt_id);
+		WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_AWADDR, mmPCIE_DBI_MSIX_DOORBELL_OFF);
+		WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_WDATA, interrupt_id + 1);
+		return;
+	}
+
+	/* VCMD normal interrupt */
+	sob_id = GAUDI2_RESERVED_SOB_DEC_NRM_FIRST + decoder_id;
+	WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_AWADDR,
+			mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_id * sizeof(u32));
+	WREG32(base_addr + BRDG_CTRL_NRM_MSIX_LBW_WDATA, GAUDI2_SOB_INCREMENT_BY_ONE);
+
+	/* VCMD abnormal interrupt */
+	sob_id = GAUDI2_RESERVED_SOB_DEC_ABNRM_FIRST + decoder_id;
+	WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_AWADDR,
+			mmDCORE0_SYNC_MNGR_OBJS_SOB_OBJ_0 + sob_id * sizeof(u32));
+	WREG32(base_addr + BRDG_CTRL_ABNRM_MSIX_LBW_WDATA, GAUDI2_SOB_INCREMENT_BY_ONE);
 }
 
 static void gaudi2_init_dec(struct hl_device *hdev)
@@ -4485,7 +4616,7 @@ static void gaudi2_init_dec(struct hl_device *hdev)
 			msix_id = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM +
 				(dcore_id * NUM_OF_DEC_PER_DCORE + dec_id) * 2;
 
-			gaudi2_init_vdec_brdg_ctrl(hdev, base_addr, msix_id);
+			gaudi2_init_vdec_brdg_ctrl(hdev, base_addr, dec_bit);
 
 			gaudi2->dec_hw_cap_initialized |= BIT_ULL(HW_CAP_DEC_SHIFT + dec_bit);
 		}
@@ -4500,7 +4631,7 @@ static void gaudi2_init_dec(struct hl_device *hdev)
 
 		msix_id = GAUDI2_IRQ_NUM_SHARED_DEC0_NRM + (dec_id * 2);
 
-		gaudi2_init_vdec_brdg_ctrl(hdev, base_addr, msix_id);
+		gaudi2_init_vdec_brdg_ctrl(hdev, base_addr, dec_bit);
 
 		gaudi2->dec_hw_cap_initialized |= BIT_ULL(HW_CAP_DEC_SHIFT + dec_bit);
 	}
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index 826d24284dc5..e4bc4009f05b 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -243,11 +243,20 @@
 
 #define GAUDI2_ARC_PCI_MSB_ADDR(addr)	(((addr) & GENMASK_ULL(49, 28)) >> 28)
 
+#define GAUDI2_SOB_INCREMENT_BY_ONE	(FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1) | \
+					FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1))
+
 enum gaudi2_reserved_sob_id {
 	GAUDI2_RESERVED_SOB_CS_COMPLETION_FIRST,
 	GAUDI2_RESERVED_SOB_CS_COMPLETION_LAST =
 			GAUDI2_RESERVED_SOB_CS_COMPLETION_FIRST + GAUDI2_MAX_PENDING_CS - 1,
 	GAUDI2_RESERVED_SOB_KDMA_COMPLETION,
+	GAUDI2_RESERVED_SOB_DEC_NRM_FIRST,
+	GAUDI2_RESERVED_SOB_DEC_NRM_LAST =
+			GAUDI2_RESERVED_SOB_DEC_NRM_FIRST + NUMBER_OF_DEC - 1,
+	GAUDI2_RESERVED_SOB_DEC_ABNRM_FIRST,
+	GAUDI2_RESERVED_SOB_DEC_ABNRM_LAST =
+			GAUDI2_RESERVED_SOB_DEC_ABNRM_FIRST + NUMBER_OF_DEC - 1,
 	GAUDI2_RESERVED_SOB_NUMBER
 };
 
@@ -256,6 +265,12 @@ enum gaudi2_reserved_mon_id {
 	GAUDI2_RESERVED_MON_CS_COMPLETION_LAST =
 			GAUDI2_RESERVED_MON_CS_COMPLETION_FIRST + GAUDI2_MAX_PENDING_CS - 1,
 	GAUDI2_RESERVED_MON_KDMA_COMPLETION,
+	GAUDI2_RESERVED_MON_DEC_NRM_FIRST,
+	GAUDI2_RESERVED_MON_DEC_NRM_LAST =
+			GAUDI2_RESERVED_MON_DEC_NRM_FIRST + 3 * NUMBER_OF_DEC - 1,
+	GAUDI2_RESERVED_MON_DEC_ABNRM_FIRST,
+	GAUDI2_RESERVED_MON_DEC_ABNRM_LAST =
+			GAUDI2_RESERVED_MON_DEC_ABNRM_FIRST + 3 * NUMBER_OF_DEC - 1,
 	GAUDI2_RESERVED_MON_NUMBER
 };
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
index 3fd5cf4a8645..eed16d642a5a 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
@@ -135,4 +135,7 @@
 #define PCIE_DBI_MSIX_ADDRESS_MATCH_LOW_OFF_MSIX_ADDRESS_MATCH_EN_SHIFT	0
 #define PCIE_DBI_MSIX_ADDRESS_MATCH_LOW_OFF_MSIX_ADDRESS_MATCH_EN_MASK	0x1
 
+#define DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_SIGN_SHIFT	15
+#define DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_SIGN_MASK		0x8000
+
 #endif /* GAUDI2_MASKS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h b/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
index e5fe9d5e07f5..d0e2c68a639f 100644
--- a/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
@@ -415,9 +415,15 @@
 #define SFT_DCORE_OFFSET (mmSFT1_HBW_RTR_IF0_RTR_CTRL_BASE - mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE)
 #define SFT_IF_OFFSET (mmSFT0_HBW_RTR_IF1_RTR_CTRL_BASE - mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE)
 
+#define BRDG_CTRL_NRM_MSIX_LBW_AWADDR	\
+	(mmDCORE0_VDEC0_BRDG_CTRL_NRM_MSIX_LBW_AWADDR - mmDCORE0_VDEC0_BRDG_CTRL_BASE)
+
 #define BRDG_CTRL_NRM_MSIX_LBW_WDATA	\
 	(mmDCORE0_VDEC0_BRDG_CTRL_NRM_MSIX_LBW_WDATA - mmDCORE0_VDEC0_BRDG_CTRL_BASE)
 
+#define BRDG_CTRL_ABNRM_MSIX_LBW_AWADDR	\
+	(mmDCORE0_VDEC0_BRDG_CTRL_ABNRM_MSIX_LBW_AWADDR - mmDCORE0_VDEC0_BRDG_CTRL_BASE)
+
 #define BRDG_CTRL_ABNRM_MSIX_LBW_WDATA	\
 	(mmDCORE0_VDEC0_BRDG_CTRL_ABNRM_MSIX_LBW_WDATA - mmDCORE0_VDEC0_BRDG_CTRL_BASE)
 
-- 
2.25.1


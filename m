Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF495A4600
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiH2JXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH2JXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F958511
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A82D60F1E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7305C433C1;
        Mon, 29 Aug 2022 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764987;
        bh=PyvwgoBvTN9rl3bRHPZEBDFOWHh69iUg+UYU1l4Jyxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqTGSiUN3a/2lgz+Fzss17/GhFJ/4K7Woes/dJgGZAizwqyQeeOdr8qmr8rMFRTji
         qQ36gPSXJoiLjpdFXPo8MQEqJCQ7hUaDgat/8RJCi2lJCZX2gikSyYmsUA9ibEUt/n
         UJMDakuaBy4ZZqcXCFCYWlznNj8NvNEMyiJxFI58HJfgt/5zcH+Ai4gV0Qporgz0EZ
         /gZPOcusT2FVbfOwmjdfNrRD7L3En+2uSFHCemuFY85L0irPKflLGRZxmvUCZwy3ch
         nEbV0UuOBDDu1GTZD7MDuESSYc6+Ba8sC4vyw8a/RQG9R+kKN2C5Ac64MON1KtPp2c
         7ybbcDB7eqLMA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 6/7] habanalabs/gaudi2: dump detailed information upon RAZWI
Date:   Mon, 29 Aug 2022 12:22:53 +0300
Message-Id: <20220829092254.930753-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829092254.930753-1-ogabbay@kernel.org>
References: <20220829092254.930753-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

In order to improve debuggability, we add all available information
when a RAZWI event occur.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 206 ++++++++++++++++++------
 1 file changed, 155 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 6bebd5eb0294..4696da7a57c1 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1531,17 +1531,57 @@ static const u32 rtr_coordinates_to_rtr_id[NUM_OF_RTR_PER_DCORE * NUM_OF_DCORES]
 	RTR_ID_X_Y(17, 11)
 };
 
+enum rtr_id {
+	DCORE0_RTR0,
+	DCORE0_RTR1,
+	DCORE0_RTR2,
+	DCORE0_RTR3,
+	DCORE0_RTR4,
+	DCORE0_RTR5,
+	DCORE0_RTR6,
+	DCORE0_RTR7,
+	DCORE1_RTR0,
+	DCORE1_RTR1,
+	DCORE1_RTR2,
+	DCORE1_RTR3,
+	DCORE1_RTR4,
+	DCORE1_RTR5,
+	DCORE1_RTR6,
+	DCORE1_RTR7,
+	DCORE2_RTR0,
+	DCORE2_RTR1,
+	DCORE2_RTR2,
+	DCORE2_RTR3,
+	DCORE2_RTR4,
+	DCORE2_RTR5,
+	DCORE2_RTR6,
+	DCORE2_RTR7,
+	DCORE3_RTR0,
+	DCORE3_RTR1,
+	DCORE3_RTR2,
+	DCORE3_RTR3,
+	DCORE3_RTR4,
+	DCORE3_RTR5,
+	DCORE3_RTR6,
+	DCORE3_RTR7,
+};
+
 static const u32 gaudi2_tpc_initiator_rtr_id[NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1] = {
-	1, 1, 2, 2, 3, 3, 14, 14, 13, 13, 12, 12, 19, 19, 18, 18, 17,
-	17, 28, 28, 29, 29, 30, 30, 0
+	DCORE0_RTR1, DCORE0_RTR1, DCORE0_RTR2, DCORE0_RTR2, DCORE0_RTR3, DCORE0_RTR3,
+	DCORE1_RTR6, DCORE1_RTR6, DCORE1_RTR5, DCORE1_RTR5, DCORE1_RTR4, DCORE1_RTR4,
+	DCORE2_RTR3, DCORE2_RTR3, DCORE2_RTR2, DCORE2_RTR2, DCORE2_RTR1, DCORE2_RTR1,
+	DCORE3_RTR4, DCORE3_RTR4, DCORE3_RTR5, DCORE3_RTR5, DCORE3_RTR6, DCORE3_RTR6,
+	DCORE0_RTR0
 };
 
 static const u32 gaudi2_dec_initiator_rtr_id[NUMBER_OF_DEC] = {
-	0, 0, 15, 15, 16, 16, 31, 31, 0, 0
+	DCORE0_RTR0, DCORE0_RTR0, DCORE1_RTR7, DCORE1_RTR7, DCORE2_RTR0, DCORE2_RTR0,
+	DCORE3_RTR7, DCORE3_RTR7, DCORE0_RTR0, DCORE0_RTR0
 };
 
 static const u32 gaudi2_nic_initiator_rtr_id[NIC_NUMBER_OF_MACROS] = {
-	15, 15, 15, 15, 15, 16, 16, 16, 16, 31, 31, 31
+	DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE2_RTR0,
+	DCORE2_RTR0, DCORE2_RTR0, DCORE2_RTR0, DCORE3_RTR7, DCORE3_RTR7, DCORE3_RTR7
 };
 
 struct sft_info {
@@ -1554,11 +1594,11 @@ static const struct sft_info gaudi2_edma_initiator_sft_id[NUM_OF_EDMA_PER_DCORE
 };
 
 static const u32 gaudi2_pdma_initiator_rtr_id[NUM_OF_PDMA] = {
-	0, 0
+	DCORE0_RTR0, DCORE0_RTR0
 };
 
 static const u32 gaudi2_rot_initiator_rtr_id[NUM_OF_ROT] = {
-	16, 31
+	DCORE2_RTR0, DCORE3_RTR7
 };
 
 struct mme_initiators_rtr_id {
@@ -7062,10 +7102,6 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_lo_reg);
 			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_id_reg);
 		}
-
-		dev_err_ratelimited(hdev->dev,
-			"%s-RAZWI SHARED RR HBW WR error, captured address HI 0x%x LO 0x%x, Initiator coordinates 0x%x\n",
-			name, razwi_hi, razwi_lo, razwi_xy);
 	} else {
 		if (read_razwi_regs) {
 			razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HI);
@@ -7076,11 +7112,11 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_lo_reg);
 			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_id_reg);
 		}
-
-		dev_err_ratelimited(hdev->dev,
-			"%s-RAZWI SHARED RR HBW AR error, captured address HI 0x%x LO 0x%x, Initiator coordinates 0x%x\n",
-			name, razwi_hi, razwi_lo, razwi_xy);
 	}
+
+	dev_err_ratelimited(hdev->dev,
+		"%s-RAZWI SHARED RR HBW %s error, address %#llx, Initiator coordinates 0x%x\n",
+		name, is_write ? "WR" : "RD", (u64)razwi_hi << 32 | razwi_lo, razwi_xy);
 }
 
 static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
@@ -7338,7 +7374,79 @@ static void gaudi2_check_if_razwi_happened(struct hl_device *hdev)
 		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, mod_idx, 0, NULL);
 }
 
-static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev,
+static const char *gaudi2_get_initiators_name(u32 rtr_id)
+{
+	switch (rtr_id) {
+	case DCORE0_RTR0:
+		return "DEC0/1/8/9, TPC24, PDMA0/1, PMMU, PCIE_IF, EDMA0/2, HMMU0/2/4/6, CPU";
+	case DCORE0_RTR1:
+		return "TPC0/1";
+	case DCORE0_RTR2:
+		return "TPC2/3";
+	case DCORE0_RTR3:
+		return "TPC4/5";
+	case DCORE0_RTR4:
+		return "MME0_SBTE0/1";
+	case DCORE0_RTR5:
+		return "MME0_WAP0/SBTE2";
+	case DCORE0_RTR6:
+		return "MME0_CTRL_WR/SBTE3";
+	case DCORE0_RTR7:
+		return "MME0_WAP1/CTRL_RD/SBTE4";
+	case DCORE1_RTR0:
+		return "MME1_WAP1/CTRL_RD/SBTE4";
+	case DCORE1_RTR1:
+		return "MME1_CTRL_WR/SBTE3";
+	case DCORE1_RTR2:
+		return "MME1_WAP0/SBTE2";
+	case DCORE1_RTR3:
+		return "MME1_SBTE0/1";
+	case DCORE1_RTR4:
+		return "TPC10/11";
+	case DCORE1_RTR5:
+		return "TPC8/9";
+	case DCORE1_RTR6:
+		return "TPC6/7";
+	case DCORE1_RTR7:
+		return "DEC2/3, NIC0/1/2/3/4, ARC_FARM, KDMA, EDMA1/3, HMMU1/3/5/7";
+	case DCORE2_RTR0:
+		return "DEC4/5, NIC5/6/7/8, EDMA4/6, HMMU8/10/12/14, ROT0";
+	case DCORE2_RTR1:
+		return "TPC16/17";
+	case DCORE2_RTR2:
+		return "TPC14/15";
+	case DCORE2_RTR3:
+		return "TPC12/13";
+	case DCORE2_RTR4:
+		return "MME2_SBTE0/1";
+	case DCORE2_RTR5:
+		return "MME2_WAP0/SBTE2";
+	case DCORE2_RTR6:
+		return "MME2_CTRL_WR/SBTE3";
+	case DCORE2_RTR7:
+		return "MME2_WAP1/CTRL_RD/SBTE4";
+	case DCORE3_RTR0:
+		return "MME3_WAP1/CTRL_RD/SBTE4";
+	case DCORE3_RTR1:
+		return "MME3_CTRL_WR/SBTE3";
+	case DCORE3_RTR2:
+		return "MME3_WAP0/SBTE2";
+	case DCORE3_RTR3:
+		return "MME3_SBTE0/1";
+	case DCORE3_RTR4:
+		return "TPC18/19";
+	case DCORE3_RTR5:
+		return "TPC20/21";
+	case DCORE3_RTR6:
+		return "TPC22/23";
+	case DCORE3_RTR7:
+		return "DEC6/7, NIC9/10/11, EDMA5/7, HMMU9/11/13/15, ROT1, PSOC";
+	default:
+	return "N/A";
+	}
+}
+
+static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev, u32 rtr_id,
 							u64 rtr_ctrl_base_addr, bool is_write)
 {
 	u32 razwi_hi, razwi_lo;
@@ -7347,50 +7455,47 @@ static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev,
 		razwi_hi = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_ADDR_HI);
 		razwi_lo = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_ADDR_LO);
 
-		dev_err_ratelimited(hdev->dev,
-			"RAZWI PSOC unmapped HBW WR error, ctr_base 0x%llx, captured address HI 0x%x, LO 0x%x\n",
-			rtr_ctrl_base_addr, razwi_hi, razwi_lo);
-
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_SET, 0x1);
 	} else {
 		razwi_hi = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_ADDR_HI);
-
 		razwi_lo = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_ADDR_LO);
 
-		dev_err_ratelimited(hdev->dev,
-			"RAZWI PSOC unmapped HBW AR error, ctr_base 0x%llx, captured address HI 0x%x, LO 0x%x\n",
-			rtr_ctrl_base_addr, razwi_hi, razwi_lo);
-
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_SET, 0x1);
 	}
+
+	dev_err_ratelimited(hdev->dev,
+		"RAZWI PSOC unmapped HBW %s error, rtr id %u, address %#llx\n",
+		is_write ? "WR" : "RD", rtr_id, (u64)razwi_hi << 32 | razwi_lo);
+
+	dev_err_ratelimited(hdev->dev,
+		"Initiators: %s\n", gaudi2_get_initiators_name(rtr_id));
 }
 
-static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev,
-					u64 rtr_ctrl_base_addr, bool is_write)
+static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u32 rtr_id,
+							u64 rtr_ctrl_base_addr, bool is_write)
 {
 	u32 razwi_addr;
 
 	if (is_write) {
 		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_ADDR);
 
-		dev_err_ratelimited(hdev->dev,
-			"RAZWI PSOC unmapped LBW WR error, ctr_base 0x%llx, captured address 0x%x\n",
-			rtr_ctrl_base_addr, razwi_addr);
-
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_SET, 0x1);
 	} else {
 		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_ADDR);
 
-		dev_err_ratelimited(hdev->dev,
-			"RAZWI PSOC unmapped LBW AR error, ctr_base 0x%llx, captured address 0x%x\n",
-			rtr_ctrl_base_addr, razwi_addr);
-
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_SET, 0x1);
 	}
+
+	dev_err_ratelimited(hdev->dev,
+		"RAZWI PSOC unmapped LBW %s error, rtr id %u, address %#x\n",
+		is_write ? "WR" : "RD", rtr_id, razwi_addr);
+
+	dev_err_ratelimited(hdev->dev,
+		"Initiators: %s\n", gaudi2_get_initiators_name(rtr_id));
 }
 
 /* PSOC RAZWI interrupt occurs only when trying to access a bad address */
@@ -7408,21 +7513,16 @@ static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev)
 	}
 
 	razwi_mask_info = RREG32(mmPSOC_GLOBAL_CONF_RAZWI_MASK_INFO);
-
-	xy = (razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_L_MASK)
-		>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_L_SHIFT;
+	xy = FIELD_GET(PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_L_MASK, razwi_mask_info);
 
 	dev_err_ratelimited(hdev->dev,
-		"PSOC RAZWI interrupt: Mask %d, WAS_AR %d, WAS_AW %d, AXUSER_L 0x%x AXUSER_H 0x%x\n",
-		(razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_MASK_MASK)
-			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_MASK_SHIFT,
-		(razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AR_MASK)
-			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AR_SHIFT,
-		(razwi_mask_info & PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AW_MASK)
-			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AW_SHIFT, xy,
-		(razwi_mask_info &
-			PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_H_MASK)
-			>> PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_H_SHIFT);
+		"PSOC RAZWI interrupt: Mask %d, AR %d, AW %d, AXUSER_L 0x%x AXUSER_H 0x%x\n",
+		FIELD_GET(PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_MASK_MASK, razwi_mask_info),
+		FIELD_GET(PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AR_MASK, razwi_mask_info),
+		FIELD_GET(PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_WAS_AW_MASK, razwi_mask_info),
+		xy,
+		FIELD_GET(PSOC_GLOBAL_CONF_RAZWI_MASK_INFO_AXUSER_H_MASK, razwi_mask_info));
+
 	if (xy == 0) {
 		dev_err_ratelimited(hdev->dev,
 				"PSOC RAZWI interrupt: received event from 0 rtr coordinates\n");
@@ -7452,16 +7552,20 @@ static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev)
 	lbw_ar_set = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_SET);
 
 	if (hbw_aw_set)
-		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_ctrl_base_addr, true);
+		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_id,
+						rtr_ctrl_base_addr, true);
 
 	if (hbw_ar_set)
-		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_ctrl_base_addr, false);
+		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_id,
+						rtr_ctrl_base_addr, false);
 
 	if (lbw_aw_set)
-		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_ctrl_base_addr, true);
+		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_id,
+						rtr_ctrl_base_addr, true);
 
 	if (lbw_ar_set)
-		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_ctrl_base_addr, false);
+		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_id,
+						rtr_ctrl_base_addr, false);
 
 clear:
 	/* Clear Interrupts only on pldm or if f/w doesn't handle interrupts */
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA45AEEEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiIFPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiIFPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367C8C3F62
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D86B4B818B9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79754C433D7;
        Tue,  6 Sep 2022 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475414;
        bh=ef8uUU+gL2a+TZ6jOv7oaD0MvH3pabP9bTuEddQ/pCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evLbmBXJSn1pgEn4FAnBNjdhim8hLr3WwCt2g9JuMIixqFbQY4ie+2AVuTTyFIF5L
         4dG+FeLvrPWGAekJClHqgIv/NeK/kJsg07nQ4Z4CTGxqfhz36d28lZjp1vCrTCu8lr
         8e4XW+pdmMFFI0duNbmi6B2Z+tbYZV+0meT5/TtSKUlq2lxEMdnhwtd/sKL1fYJUkj
         /CEXh/AHRHn28zy2e0Vwf3dSDJ/+K9Z2oi8ZgtS2GCoFhJK9i4NL4PTx7CkosVD5yn
         4mCe7K+qRrk/BvO0fH57BN4+4Wd+8XX9vXHzku3Oxn7hS21grJtAikEsQMIEKMe9g6
         vQL3e2AZmDAkQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 8/9] habanalabs: new notifier events for device state
Date:   Tue,  6 Sep 2022 17:43:17 +0300
Message-Id: <20220906144318.1890416-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

Add new notifier events that inform several device states.
General H/W error raised on device general H/W error occurs.
User engine error is raised when a device engine informs of an error.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c   | 39 +++++++++++++++---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 54 ++++++++++++++++++++++++-
 include/uapi/misc/habanalabs.h          |  4 ++
 3 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 87dbdbb220da..2b328cb62096 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7685,6 +7685,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_NIC0_CS_DBG_DERR ... GAUDI_EVENT_NIC4_CS_DBG_DERR:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
@@ -7694,6 +7695,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
 		gaudi_print_irq_info(hdev, event_type, false);
 		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_0:
@@ -7705,6 +7707,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
 		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_1:
@@ -7716,6 +7719,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
 		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI_EVENT_TPC0_DEC:
@@ -7730,6 +7734,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_dec_event_to_tpc_id(event_type),
 					"AXI_SLV_DEC_Error");
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		if (reset_required) {
 			dev_err(hdev->dev, "reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
@@ -7738,6 +7743,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 			goto reset_device;
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
+			event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
 		}
 		break;
 
@@ -7753,6 +7759,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_krn_event_to_tpc_id(event_type),
 					"KRN_ERR");
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		if (reset_required) {
 			dev_err(hdev->dev, "reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
@@ -7761,6 +7768,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 			goto reset_device;
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
+			event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
 		}
 		break;
 
@@ -7789,9 +7797,25 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI_EVENT_PCIE_DEC:
+	case GAUDI_EVENT_CPU_AXI_SPLITTER:
+	case GAUDI_EVENT_PSOC_AXI_DEC:
+	case GAUDI_EVENT_PSOC_PRSTN_FALL:
+		gaudi_print_irq_info(hdev, event_type, true);
+		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
+		break;
+
+	case GAUDI_EVENT_MMU_PAGE_FAULT:
+	case GAUDI_EVENT_MMU_WR_PERM:
+		gaudi_print_irq_info(hdev, event_type, true);
+		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
+		break;
+
 	case GAUDI_EVENT_MME0_WBC_RSP:
 	case GAUDI_EVENT_MME0_SBAB0_RSP:
 	case GAUDI_EVENT_MME1_WBC_RSP:
@@ -7800,11 +7824,6 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_MME2_SBAB0_RSP:
 	case GAUDI_EVENT_MME3_WBC_RSP:
 	case GAUDI_EVENT_MME3_SBAB0_RSP:
-	case GAUDI_EVENT_CPU_AXI_SPLITTER:
-	case GAUDI_EVENT_PSOC_AXI_DEC:
-	case GAUDI_EVENT_PSOC_PRSTN_FALL:
-	case GAUDI_EVENT_MMU_PAGE_FAULT:
-	case GAUDI_EVENT_MMU_WR_PERM:
 	case GAUDI_EVENT_RAZWI_OR_ADC:
 	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
 	case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
@@ -7824,10 +7843,12 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_qman_err(hdev, event_type, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= (HL_NOTIFIER_EVENT_USER_ENGINE_ERR | HL_NOTIFIER_EVENT_DEVICE_RESET);
 		break;
 
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
 		gaudi_print_irq_info(hdev, event_type, true);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_TPC0_BMON_SPMU:
@@ -7841,11 +7862,13 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_DMA_BM_CH0 ... GAUDI_EVENT_DMA_BM_CH7:
 		gaudi_print_irq_info(hdev, event_type, false);
 		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI_EVENT_NIC_SEI_0 ... GAUDI_EVENT_NIC_SEI_4:
 		gaudi_print_nic_axi_irq_info(hdev, event_type, &data);
 		hl_fw_unmask_irq(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI_EVENT_DMA_IF_SEI_0 ... GAUDI_EVENT_DMA_IF_SEI_3:
@@ -7853,6 +7876,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		gaudi_print_sm_sei_info(hdev, event_type,
 					&eq_entry->sm_sei_data);
 		rc = hl_state_dump(hdev);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		if (rc)
 			dev_err(hdev->dev,
 				"Error during system state dump %d\n", rc);
@@ -7863,6 +7887,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		break;
 
 	case GAUDI_EVENT_FIX_POWER_ENV_S ... GAUDI_EVENT_FIX_THERMAL_ENV_E:
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		gaudi_print_clk_change_info(hdev, event_type);
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
@@ -7872,20 +7897,24 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		dev_err(hdev->dev,
 			"Received high temp H/W interrupt %d (cause %d)\n",
 			event_type, cause);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI_EVENT_DEV_RESET_REQ:
 		gaudi_print_irq_info(hdev, event_type, false);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_PKT_QUEUE_OUT_SYNC:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_FW_ALIVE_S:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_print_fw_alive_info(hdev, &eq_entry->fw_alive);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	default:
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 60694b8ed6fe..f749f7377ea6 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8530,6 +8530,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	bool reset_required = false, skip_reset = false;
 	int index, sbte_index;
+	u64 event_mask = 0;
 	u16 event_type;
 
 	ctl = le32_to_cpu(eq_entry->hdr.ctl);
@@ -8551,6 +8552,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		fallthrough;
 	case GAUDI2_EVENT_ROTATOR0_SERR ... GAUDI2_EVENT_ROTATOR1_DERR:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		reset_required = gaudi2_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		break;
 
@@ -8560,21 +8562,25 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		fallthrough;
 	case GAUDI2_EVENT_NIC0_QM0 ... GAUDI2_EVENT_NIC11_QM1:
 		gaudi2_handle_qman_err(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_ARC_AXI_ERROR_RESPONSE_0:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		gaudi2_handle_arc_farm_sei_err(hdev);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_AXI_ERR_RSP:
 		gaudi2_handle_cpu_sei_err(hdev);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		gaudi2_handle_qm_sei_err(hdev, event_type, &eq_entry->razwi_info);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
@@ -8582,6 +8588,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
 		gaudi2_handle_rot_err(hdev, index, &eq_entry->razwi_with_intr_cause);
 		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_TPC0_AXI_ERR_RSP ... GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
@@ -8589,11 +8596,13 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		gaudi2_tpc_ack_interrupts(hdev, index, "AXI_ERR_RSP",
 						&eq_entry->razwi_with_intr_cause);
 		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE ... GAUDI2_EVENT_DEC9_AXI_ERR_RSPONSE:
 		index = event_type - GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE;
 		gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE", &eq_entry->razwi_info);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_TPC0_KERNEL_ERR:
@@ -8624,6 +8633,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_TPC0_KERNEL_ERR) /
 			(GAUDI2_EVENT_TPC1_KERNEL_ERR - GAUDI2_EVENT_TPC0_KERNEL_ERR);
 		gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR", &eq_entry->razwi_with_intr_cause);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_DEC0_SPI:
@@ -8639,6 +8649,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_DEC0_SPI) /
 				(GAUDI2_EVENT_DEC1_SPI - GAUDI2_EVENT_DEC0_SPI);
 		gaudi2_handle_dec_err(hdev, index, "SPI", &eq_entry->razwi_info);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE:
@@ -8651,6 +8662,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		gaudi2_handle_mme_err(hdev, index,
 				"CTRL_AXI_ERROR_RESPONSE", &eq_entry->razwi_info);
 		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_MME0_QMAN_SW_ERROR:
@@ -8661,6 +8673,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 				(GAUDI2_EVENT_MME1_QMAN_SW_ERROR -
 					GAUDI2_EVENT_MME0_QMAN_SW_ERROR);
 		gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR", &eq_entry->razwi_info);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID:
@@ -8671,50 +8684,58 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 				(GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID -
 					GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID);
 		gaudi2_handle_mme_wap_err(hdev, index, &eq_entry->razwi_info);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_KDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_KDMA0_CORE:
 		gaudi2_handle_kdma_core_event(hdev,
 					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_HDMA2_CORE ... GAUDI2_EVENT_PDMA1_CORE:
 		gaudi2_handle_dma_core_event(hdev,
 					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_ADDR_DEC_ERR:
 		gaudi2_print_pcie_addr_dec_info(hdev,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM ... GAUDI2_EVENT_HMMU12_SECURITY_ERROR:
 	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
-	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
 	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
 		gaudi2_handle_mmu_spi_sei_err(hdev, event_type);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_HIF0_FATAL ... GAUDI2_EVENT_HIF12_FATAL:
 		gaudi2_handle_hif_fatal(hdev, event_type,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PMMU_FATAL_0:
 		gaudi2_handle_pif_fatal(hdev,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PSOC63_RAZWI_OR_PID_MIN_MAX_INTERRUPT:
 		gaudi2_ack_psoc_razwi_event_handler(hdev);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_HBM0_MC0_SEI_SEVERE ... GAUDI2_EVENT_HBM5_MC1_SEI_NON_SEVERE:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		if (gaudi2_handle_hbm_mc_sei_err(hdev, event_type, &eq_entry->sei_data)) {
 			reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 			reset_required = true;
@@ -8723,25 +8744,31 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_HBM_CATTRIP_0 ... GAUDI2_EVENT_HBM_CATTRIP_5:
 		gaudi2_handle_hbm_cattrip(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_HBM0_MC0_SPI ... GAUDI2_EVENT_HBM5_MC1_SPI:
 		gaudi2_handle_hbm_mc_spi(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_DRAIN_COMPLETE:
 		gaudi2_handle_pcie_drain(hdev, &eq_entry->pcie_drain_ind_data);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PSOC59_RPM_ERROR_OR_DRAIN:
 		gaudi2_handle_psoc_drain(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_AXI_ECC:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_CPU_L2_RAM_ECC:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME0_SBTE4_AXI_ERR_RSP:
 	case GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME1_SBTE4_AXI_ERR_RSP:
@@ -8755,17 +8782,24 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 					GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP);
 		gaudi2_handle_mme_sbte_err(hdev, index, sbte_index,
 						le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 	case GAUDI2_EVENT_VM0_ALARM_A ... GAUDI2_EVENT_VM3_ALARM_B:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PSOC_AXI_ERR_RSP:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
+		break;
 	case GAUDI2_EVENT_PSOC_PRSTN_FALL:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PCIE_APB_TIMEOUT:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PCIE_FATAL_ERR:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_TPC0_BMON_SPMU:
 	case GAUDI2_EVENT_TPC1_BMON_SPMU:
@@ -8817,6 +8851,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_DEC8_BMON_SPMU:
 	case GAUDI2_EVENT_DEC9_BMON_SPMU:
 	case GAUDI2_EVENT_ROTATOR0_BMON_SPMU ... GAUDI2_EVENT_SM3_BMON_SPMU:
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_S:
@@ -8824,43 +8859,53 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_S:
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
 		gaudi2_print_clk_change_info(hdev, event_type);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_QUEUE_OUT_SYNC:
 		gaudi2_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_FLR_REQUESTED:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		/* Do nothing- FW will handle it */
 		break;
 
 	case GAUDI2_EVENT_PCIE_P2P_MSIX:
 		gaudi2_handle_pcie_p2p_msix(hdev);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE ... GAUDI2_EVENT_SM3_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE;
 		skip_reset = !gaudi2_handle_sm_err(hdev, index);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_PSOC_MME_PLL_LOCK_ERR ... GAUDI2_EVENT_DCORE2_HBM_PLL_LOCK_ERR:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_CAUSE:
 		dev_info(hdev->dev, "CPLD shutdown cause, reset reason: 0x%llx\n",
 						le64_to_cpu(eq_entry->data[0]));
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_EVENT:
 		dev_err(hdev->dev, "CPLD shutdown event, reset reason: 0x%llx\n",
 						le64_to_cpu(eq_entry->data[0]));
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_SANITY_FAILED:
 		gaudi2_print_cpu_pkt_failure_info(hdev, &eq_entry->pkt_sync_err);
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_ARC_DCCM_FULL:
 		hl_arc_event_handle(hdev, &eq_entry->arc_data);
+		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	default:
@@ -8876,15 +8921,22 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	if (!gaudi2_irq_map_table[event_type].msg)
 		hl_fw_unmask_irq(hdev, event_type);
 
+	if (event_mask)
+		hl_notifier_event_send_all(hdev, event_mask);
+
 	return;
 
 reset_device:
 	if (hdev->hard_reset_on_fw_events) {
 		hl_device_reset(hdev, reset_flags);
+		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
 	} else {
 		if (!gaudi2_irq_map_table[event_type].msg)
 			hl_fw_unmask_irq(hdev, event_type);
 	}
+
+	if (event_mask)
+		hl_notifier_event_send_all(hdev, event_mask);
 }
 
 static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val)
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 3005cc04d4b1..a4bab0fd8223 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -715,12 +715,16 @@ enum hl_server_type {
  * HL_NOTIFIER_EVENT_DEVICE_RESET	- Indicates device requires a reset
  * HL_NOTIFIER_EVENT_CS_TIMEOUT		- Indicates CS timeout error
  * HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	- Indicates device is unavailable
+ * HL_NOTIFIER_EVENT_USER_ENGINE_ERR	- Indicates device engine in error state
+ * HL_NOTIFIER_EVENT_GENERAL_HW_ERR     - Indicates device HW error
  */
 #define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
 #define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
 #define HL_NOTIFIER_EVENT_DEVICE_RESET		(1ULL << 2)
 #define HL_NOTIFIER_EVENT_CS_TIMEOUT		(1ULL << 3)
 #define HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	(1ULL << 4)
+#define HL_NOTIFIER_EVENT_USER_ENGINE_ERR	(1ULL << 5)
+#define HL_NOTIFIER_EVENT_GENERAL_HW_ERR	(1ULL << 6)
 
 /* Opcode for management ioctl
  *
-- 
2.25.1


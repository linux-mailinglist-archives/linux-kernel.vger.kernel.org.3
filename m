Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CF5650C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiGDJ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiGDJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5461032
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BCFB61359
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18181C341CA;
        Mon,  4 Jul 2022 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926986;
        bh=1wsIdycnrqzsuzq1whzSnhWvD5i97u2Oi47CN1BM/EU=;
        h=From:To:Cc:Subject:Date:From;
        b=fOJtNuaGWuSrRVDbyU36xlo+6bYYTiwRGcr4c2RQxKQ2w51rESMRDjkV+xt80//it
         P2IPhprfuN2oJLXyBcMk+RSAy411joxAmqjXLJSz2hgpN48pzoqEu//YEFZ2xwNko8
         8XVM6hIMsDdhkpMJsny7TX5xpPg63ih7zkzEZr2hMh/WmF5gd5gpC3kj1mMXZgd/tG
         TFPeAzNZRwAGDAtaDo+TA/wGhtrGtIiN8469rhX5QVs7Veca+HgDFIXjqLk9SamJyg
         MzJQfyT6IillwxUBJmujK6XU7guhfetGLg+w42vHkDDE0nC5jQW1VLBIaogH2C5dJR
         z+6j7ugtaP6Vg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 01/12] habanalabs/gaudi2: reset device upon critical ECC event
Date:   Mon,  4 Jul 2022 12:29:30 +0300
Message-Id: <20220704092941.2237683-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Correctable ECC events are not fatal, but as they accumulate, the f/w
can decide that a hard-rest is required. This indication is
propagated to the host using the existing ECC event interface.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 25 +++++++++++--------
 .../misc/habanalabs/include/common/cpucp_if.h |  2 +-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index edcf23b314a7..dbbd08600a56 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -6637,7 +6637,7 @@ static void gaudi2_print_irq_info(struct hl_device *hdev, u16 event_type)
 								event_type, desc);
 }
 
-static void gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
+static bool gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		struct hl_eq_ecc_data *ecc_data)
 {
 	u64 ecc_address = 0, ecc_syndrom = 0;
@@ -6647,8 +6647,11 @@ static void gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 	ecc_syndrom = le64_to_cpu(ecc_data->ecc_syndrom);
 	memory_wrapper_idx = ecc_data->memory_wrapper_idx;
 
-	dev_err(hdev->dev, "ECC error detected. address: %#llx. Syndrom: %#llx. block id %u\n",
-		ecc_address, ecc_syndrom, memory_wrapper_idx);
+	dev_err(hdev->dev,
+		"ECC error detected. address: %#llx. Syndrom: %#llx. block id %u. critical %u.\n",
+		ecc_address, ecc_syndrom, memory_wrapper_idx, ecc_data->is_critical);
+
+	return !!ecc_data->is_critical;
 }
 
 /*
@@ -7991,9 +7994,9 @@ static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
 	}
 
 	dev_err_ratelimited(hdev->dev,
-			"System Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
-			hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
-			hbm_mc_sei_cause[cause_idx]);
+		"System Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Critical(%u). Error cause: %s\n",
+		hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
+		sei_data->hdr.is_critical, hbm_mc_sei_cause[cause_idx]);
 
 	/* Print error-specific info */
 	switch (cause_idx) {
@@ -8032,6 +8035,8 @@ static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
 		break;
 	};
 
+	require_hard_reset |= !!sei_data->hdr.is_critical;
+
 	return require_hard_reset;
 }
 
@@ -8199,7 +8204,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 {
 	u32 ctl, reset_flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY;
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
-	bool hbm_require_reset = false, skip_reset = false;
+	bool reset_required = false, skip_reset = false;
 	int index, sbte_index;
 	u16 event_type;
 
@@ -8222,7 +8227,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		fallthrough;
 	case GAUDI2_EVENT_ROTATOR0_SERR ... GAUDI2_EVENT_ROTATOR1_DERR:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-		gaudi2_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		reset_required = gaudi2_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		break;
 
 	case GAUDI2_EVENT_TPC0_QM ... GAUDI2_EVENT_PDMA1_QM:
@@ -8387,7 +8392,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_HBM0_MC0_SEI_SEVERE ... GAUDI2_EVENT_HBM5_MC1_SEI_NON_SEVERE:
 		if (gaudi2_handle_hbm_mc_sei_err(hdev, event_type, &eq_entry->sei_data)) {
 			reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-			hbm_require_reset = true;
+			reset_required = true;
 		}
 		break;
 
@@ -8539,7 +8544,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 						event_type);
 	}
 
-	if ((gaudi2_irq_map_table[event_type].reset || hbm_require_reset) && !skip_reset)
+	if ((gaudi2_irq_map_table[event_type].reset || reset_required) && !skip_reset)
 		goto reset_device;
 
 	/* Send unmask irq only for interrupts not classified as MSG */
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 719b2ff80985..abf40e1c4965 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -192,7 +192,7 @@ struct hl_hbm_sei_header {
 	__u8 sei_cause;		/* enum hl_hbm_sei_cause */
 	__u8 mc_channel;		/* range: 0-3 */
 	__u8 mc_pseudo_channel;	/* range: 0-7 */
-	__u8 pad[1];
+	__u8 is_critical;
 };
 
 #define HBM_RD_ADDR_SID_SHIFT		0
-- 
2.25.1


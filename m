Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74A053DB41
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiFEKda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiFEKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DFF20BFE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D0460EF6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3859C385A5;
        Sun,  5 Jun 2022 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425204;
        bh=XfjkGAV2OmMLjtrexlOjNmfhOf9dCxrrH3nIxqowlrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNstXGcQDm1uVBkGudXIB2dajfF435nDAq20Do8d3QDth5ckrKDxJmbslWYlwGyaY
         x9L9WOn7G6yMA1uANYhrOmsh5yrK872C4PqBjwu7kCwmjGOu6q6ebV2uPOfVD6+eaj
         fmcVe36zQuFvJyIG3cyy1f7z790BSBEGfafd92+ScfTVsEQQQT734/SakmCzKXUoAr
         97YwrJOTqU774CGTzcexopQlifS3ld9BQdw+T4tRzZRjrlQsUmLVeC+YJksLJXXw9M
         e9kDMLsnyefmaOrLfllppZoD17/Ysu/ZrKHWaVdBQAEsPowK1JQXZS0aXU24LNwVQl
         dL3+hW99gTcfQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 3/7] habanalabs/gaudi: move tpc assert raise into internal func
Date:   Sun,  5 Jun 2022 13:33:12 +0300
Message-Id: <20220605103316.3414541-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605103316.3414541-1-ogabbay@kernel.org>
References: <20220605103316.3414541-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

raising the tpc assert event in an internal function will make
the code cleaner as we are going to be adding more events

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 25d735aee6a3..4db5f6ef96f1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7290,7 +7290,7 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		ecc_address, ecc_syndrom, memory_wrapper_idx);
 }
 
-static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
+static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	u64 qman_base;
 	char desc[32];
@@ -7299,6 +7299,12 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
 
 	switch (event_type) {
 	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
+		/* In TPC QM event, notify on TPC assertion. While there isn't
+		 * a specific event for assertion yet, the FW generates QM event.
+		 * The SW upper layer will inspect an internal mapped area to indicate
+		 * if the event is a tpc assertion or tpc QM.
+		 */
+		*event_mask |= HL_NOTIFIER_EVENT_TPC_ASSERT;
 		index = event_type - GAUDI_EVENT_TPC0_QM;
 		qid_base = GAUDI_QUEUE_ID_TPC_0_0 + index * QMAN_STREAMS;
 		qman_base = mmTPC0_QM_BASE + index * TPC_QMAN_OFFSET;
@@ -7715,7 +7721,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 				struct hl_eq_entry *eq_entry)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 data = le64_to_cpu(eq_entry->data[0]);
+	u64 data = le64_to_cpu(eq_entry->data[0]), event_mask = 0;
 	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
 	u32 fw_fatal_err_flag = 0;
 	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
@@ -7892,22 +7898,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_NIC4_QM0:
 	case GAUDI_EVENT_NIC4_QM1:
 	case GAUDI_EVENT_DMA0_CORE ... GAUDI_EVENT_DMA7_CORE:
-		gaudi_print_irq_info(hdev, event_type, true);
-		gaudi_handle_qman_err(hdev, event_type);
-		hl_fw_unmask_irq(hdev, event_type);
-		break;
-
 	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
 		gaudi_print_irq_info(hdev, event_type, true);
-		gaudi_handle_qman_err(hdev, event_type);
+		gaudi_handle_qman_err(hdev, event_type, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
-
-		/* In TPC QM event, notify on TPC assertion. While there isn't
-		 * a specific event for assertion yet, the FW generates QM event.
-		 * The SW upper layer will inspect an internal mapped area to indicate
-		 * if the event is a tpc assertion or tpc QM.
-		 */
-		hl_notifier_event_send_all(hdev, HL_NOTIFIER_EVENT_TPC_ASSERT);
 		break;
 
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
@@ -7978,6 +7972,9 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		break;
 	}
 
+	if (event_mask)
+		hl_notifier_event_send_all(hdev, event_mask);
+
 	return;
 
 reset_device:
-- 
2.25.1


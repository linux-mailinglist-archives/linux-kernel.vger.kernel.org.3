Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706F859B2C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiHUI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:28:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5315724
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC356B80BD1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA4CC433D7;
        Sun, 21 Aug 2022 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661070513;
        bh=xT4dZ1Sjn9STEnrL9xmz/Kszc/fiJuPHIQHK/spbNI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jy+u9VUsGMpPoqM0QVrYLlLZu/sJwFwrhu/yPnajeEIjEmtggF89pGuvl/Sb1xFUd
         v90WntiE40Ola8xkFYZbxY7n7ED3U2KFehuTbsDq2dkgs540sdInkulqGexAkXl1zK
         xxkO+rouCSSGw5kVx0+At3VnWVOSRFWGNPYpP2Zc94dRcNnrbKGbA1LdJ24Rf1dyiP
         oiozjpm8j3b+tYigcBOmghJFLOf0Q+xtLqwqulnj4GTh7BsQ6HR8AEJ1h0HRwOxHp3
         bVP2J649Fwaf0c9CML5dIBXJssz1GUOKda+dkLcFIXhxrRjOWMvHEG5kiQSkzwDJAP
         C60eVk18/MQvA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajarama Manjukody Bhat <rmbhat@habana.ai>
Subject: [PATCH 5/5] habanalabs/gaudi2: assigning PQFs for ARC f/w in PDMA
Date:   Sun, 21 Aug 2022 11:28:23 +0300
Message-Id: <20220821082823.62846-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821082823.62846-1-ogabbay@kernel.org>
References: <20220821082823.62846-1-ogabbay@kernel.org>
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

From: Rajarama Manjukody Bhat <rmbhat@habana.ai>

Assigning 3 PQFs in PDMA1 and 2 PQFs in PDMA0 for ARC firmware usage.

Signed-off-by: Rajarama Manjukody Bhat <rmbhat@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 13 +++++++++----
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h |  8 +++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index fa806e5b6680..c907e0fbf182 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -4175,11 +4175,15 @@ static void gaudi2_init_qman_common(struct hl_device *hdev, u32 reg_base,
 	WREG32(reg_base + QM_GLBL_CFG2_OFFSET, 0);
 
 	/* Enable the QMAN channel.
-	 * PDMA1 QMAN configuration is different, as we do not allow user to
-	 * access CP2/3, it is reserved for the ARC usage.
+	 * PDMA QMAN configuration is different, as we do not allow user to
+	 * access some of the CPs.
+	 * PDMA0: CP2/3 are reserved for the ARC usage.
+	 * PDMA1: CP1/2/3 are reserved for the ARC usage.
 	 */
 	if (reg_base == gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_PDMA_1_0])
 		WREG32(reg_base + QM_GLBL_CFG0_OFFSET, PDMA1_QMAN_ENABLE);
+	else if (reg_base == gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_PDMA_0_0])
+		WREG32(reg_base + QM_GLBL_CFG0_OFFSET, PDMA0_QMAN_ENABLE);
 	else
 		WREG32(reg_base + QM_GLBL_CFG0_OFFSET, QMAN_ENABLE);
 }
@@ -5580,10 +5584,11 @@ static bool gaudi2_is_queue_enabled(struct hl_device *hdev, u32 hw_queue_id)
 	u64 hw_test_cap_bit = 0;
 
 	switch (hw_queue_id) {
-	case GAUDI2_QUEUE_ID_PDMA_0_0 ... GAUDI2_QUEUE_ID_PDMA_1_1:
+	case GAUDI2_QUEUE_ID_PDMA_0_0:
+	case GAUDI2_QUEUE_ID_PDMA_0_1:
+	case GAUDI2_QUEUE_ID_PDMA_1_0:
 		hw_cap_mask = HW_CAP_PDMA_MASK;
 		break;
-
 	case GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0...GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3:
 		hw_test_cap_bit = HW_CAP_EDMA_SHIFT +
 			((hw_queue_id - GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0) >> 2);
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
index eed16d642a5a..0239d118abc5 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
@@ -51,12 +51,18 @@
 	(0x1F << PDMA0_QM_GLBL_CFG0_CP_EN_SHIFT)  | \
 	(0x1 << PDMA0_QM_GLBL_CFG0_ARC_CQF_EN_SHIFT))
 
-#define PDMA1_QMAN_ENABLE	\
+#define PDMA0_QMAN_ENABLE	\
 	((0x3 << PDMA0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
 	(0x1F << PDMA0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
 	(0x1F << PDMA0_QM_GLBL_CFG0_CP_EN_SHIFT)  | \
 	(0x1 << PDMA0_QM_GLBL_CFG0_ARC_CQF_EN_SHIFT))
 
+#define PDMA1_QMAN_ENABLE	\
+	((0x1 << PDMA0_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_CFG0_CQF_EN_SHIFT) | \
+	(0x1F << PDMA0_QM_GLBL_CFG0_CP_EN_SHIFT)  | \
+	(0x1 << PDMA0_QM_GLBL_CFG0_ARC_CQF_EN_SHIFT))
+
 /* QM_IDLE_MASK is valid for all engines QM idle check */
 #define QM_IDLE_MASK	(DCORE0_EDMA0_QM_GLBL_STS0_PQF_IDLE_MASK | \
 			DCORE0_EDMA0_QM_GLBL_STS0_CQF_IDLE_MASK | \
-- 
2.25.1


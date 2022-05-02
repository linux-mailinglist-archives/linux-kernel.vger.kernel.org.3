Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0D516BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiEBIJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiEBIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A73B3EC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D58960F1B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA53C385AC;
        Mon,  2 May 2022 08:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651478757;
        bh=DmyU9MPeUsQehsrBT4fYfNKoy74L9qEX/gb+/ukQ7F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQF6kb72lVFywHH1TQTWQkW8QMCGDGIYFSVXY9Y6HE9IR02VSR8bb2BYnqutitkI0
         5YF2vHYzYSZoWksBDG7q0ZSWgxAWFZDTueG5J/ur2oD4Qod9ai68VlndUFWx3gqLF9
         9N2rl+FA9rdkrSmDY9VCcXEs7e4cRLGTJyL8AEn2xVAg2fbZ1rWuF5HyyOo7Z/h/dE
         91Ytx45s6DbXSTOYGkXmg+s+hiMeY03AIPLuprHwoHf1Zl9x58vFOrHZBCTh1iuxxP
         wEMzwT6jrRsTs+j8Y98dtYwQh+ZCfz6HY+RjrNxX/atwKPOjp9hxnuESuaT6xfNYt9
         jZ7g+Stcaw6mQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/6] habanalabs/gaudi: set arbitration timeout to a high value
Date:   Mon,  2 May 2022 11:05:46 +0300
Message-Id: <20220502080549.230411-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502080549.230411-1-ogabbay@kernel.org>
References: <20220502080549.230411-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

In certain workloads, arbitration timeout might expire although
no actual issue present. Hence, we set timeout to a very high value.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7828337eedce..e74ea4c2d008 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -95,7 +95,7 @@
 
 #define GAUDI_NUM_OF_QM_ARB_ERR_CAUSE	3
 
-#define GAUDI_ARB_WDT_TIMEOUT		0x1000000
+#define GAUDI_ARB_WDT_TIMEOUT		0xEE6b27FF /* 8 seconds */
 
 #define GAUDI_CLK_GATE_DEBUGFS_MASK	(\
 		BIT(GAUDI_ENGINE_ID_MME_0) |\
@@ -2811,9 +2811,8 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 		WREG32(mmDMA0_QM_ARB_ERR_MSG_EN + dma_qm_offset,
 				QM_ARB_ERR_MSG_EN_MASK);
 
-		/* Increase ARB WDT to support streams architecture */
-		WREG32(mmDMA0_QM_ARB_SLV_CHOISE_WDT + dma_qm_offset,
-				GAUDI_ARB_WDT_TIMEOUT);
+		/* Set timeout to maximum */
+		WREG32(mmDMA0_QM_ARB_SLV_CHOISE_WDT + dma_qm_offset, GAUDI_ARB_WDT_TIMEOUT);
 
 		WREG32(mmDMA0_QM_GLBL_PROT + dma_qm_offset,
 				QMAN_EXTERNAL_MAKE_TRUSTED);
@@ -2990,9 +2989,8 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 		WREG32(mmDMA0_QM_ARB_ERR_MSG_EN + dma_qm_offset,
 				QM_ARB_ERR_MSG_EN_MASK);
 
-		/* Increase ARB WDT to support streams architecture */
-		WREG32(mmDMA0_QM_ARB_SLV_CHOISE_WDT + dma_qm_offset,
-				GAUDI_ARB_WDT_TIMEOUT);
+		/* Set timeout to maximum */
+		WREG32(mmDMA0_QM_ARB_SLV_CHOISE_WDT + dma_qm_offset, GAUDI_ARB_WDT_TIMEOUT);
 
 		WREG32(mmDMA0_QM_GLBL_CFG1 + dma_qm_offset, 0);
 		WREG32(mmDMA0_QM_GLBL_PROT + dma_qm_offset,
@@ -3127,9 +3125,8 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 		WREG32(mmMME0_QM_ARB_ERR_MSG_EN + mme_offset,
 				QM_ARB_ERR_MSG_EN_MASK);
 
-		/* Increase ARB WDT to support streams architecture */
-		WREG32(mmMME0_QM_ARB_SLV_CHOISE_WDT + mme_offset,
-				GAUDI_ARB_WDT_TIMEOUT);
+		/* Set timeout to maximum */
+		WREG32(mmMME0_QM_ARB_SLV_CHOISE_WDT + mme_offset, GAUDI_ARB_WDT_TIMEOUT);
 
 		WREG32(mmMME0_QM_GLBL_CFG1 + mme_offset, 0);
 		WREG32(mmMME0_QM_GLBL_PROT + mme_offset,
@@ -3261,9 +3258,8 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 		WREG32(mmTPC0_QM_ARB_ERR_MSG_EN + tpc_offset,
 				QM_ARB_ERR_MSG_EN_MASK);
 
-		/* Increase ARB WDT to support streams architecture */
-		WREG32(mmTPC0_QM_ARB_SLV_CHOISE_WDT + tpc_offset,
-				GAUDI_ARB_WDT_TIMEOUT);
+		/* Set timeout to maximum */
+		WREG32(mmTPC0_QM_ARB_SLV_CHOISE_WDT + tpc_offset, GAUDI_ARB_WDT_TIMEOUT);
 
 		WREG32(mmTPC0_QM_GLBL_CFG1 + tpc_offset, 0);
 		WREG32(mmTPC0_QM_GLBL_PROT + tpc_offset,
@@ -3412,9 +3408,8 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 		WREG32(mmNIC0_QM0_ARB_ERR_MSG_EN + nic_offset,
 				QM_ARB_ERR_MSG_EN_MASK);
 
-		/* Increase ARB WDT to support streams architecture */
-		WREG32(mmNIC0_QM0_ARB_SLV_CHOISE_WDT + nic_offset,
-				GAUDI_ARB_WDT_TIMEOUT);
+		/* Set timeout to maximum */
+		WREG32(mmNIC0_QM0_ARB_SLV_CHOISE_WDT + nic_offset, GAUDI_ARB_WDT_TIMEOUT);
 
 		WREG32(mmNIC0_QM0_GLBL_CFG1 + nic_offset, 0);
 		WREG32(mmNIC0_QM0_GLBL_PROT + nic_offset,
-- 
2.25.1


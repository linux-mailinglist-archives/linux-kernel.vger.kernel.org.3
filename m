Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D797C56D4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiGKGaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGKGaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00D9FC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12AFF611E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47ACC34115;
        Mon, 11 Jul 2022 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521014;
        bh=7MlAZAOEhQYesg+tKqbJ0vd7Q9CBnbidWhP/DfojCu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYd1cwdH7jkqsMHHjA/koU4p7csDeoJV0E+Y0qPcTzBNIiJD86B4GiTBkvq+LUbvs
         w2wvui9Vi/8aSutAPMam2PvSj3UHR/UzQffXqtTF7rAwVCABx8yvmHOw524dMTc5XL
         YLToFFDCj+NQZJerkSWPMTPFpM2j3l0i3VyNWtcFLhvSGuol1kh7lc1tRYZP+mdPyg
         4WIxJZ2h0j9K/bqK2yQiZ4SIHYrWLV6HnCCPef4wNKs1mGQ/7eB2QzggmU6Iwu3Bap
         kQ1OxZ+K6kYlQB8Ex1FIq0PTRdG9PY7Q/icgewfS8mF8zb43NsQ2NPww18ey28hhLm
         gWKoDw1LKTGnQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 05/12] habanalabs/gaudi2: modify CS completion CQ to use virtual MSI-X doorbell
Date:   Mon, 11 Jul 2022 09:29:56 +0300
Message-Id: <20220711063003.3182795-5-ogabbay@kernel.org>
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

Modify the CQ which is used for CS completion, to use the virtual MSI-X
doorbell.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 398bc0957417..60e11007e3ea 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -4254,7 +4254,7 @@ static void gaudi2_init_edma(struct hl_device *hdev)
 
 static void gaudi2_init_sm(struct hl_device *hdev)
 {
-	u64 msix_db_reg = CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	u64 cq_address;
 	u32 reg_val;
 	int i;
@@ -4272,8 +4272,21 @@ static void gaudi2_init_sm(struct hl_device *hdev)
 
 	/* Init CQ0 DB */
 	/* Configure the monitor to trigger MSI-X interrupt */
-	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0, lower_32_bits(msix_db_reg));
-	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0, upper_32_bits(msix_db_reg));
+	/* TODO:
+	 * Remove the if statement when virtual MSI-X doorbell is supported in simulator (SW-93022)
+	 * and in F/W (SW-93024).
+	 */
+	if (!hdev->pdev || hdev->asic_prop.fw_security_enabled) {
+		u64 msix_db_reg = CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF;
+
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0, lower_32_bits(msix_db_reg));
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0, upper_32_bits(msix_db_reg));
+	} else {
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0,
+				lower_32_bits(gaudi2->virt_msix_db_dma_addr));
+		WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0,
+				upper_32_bits(gaudi2->virt_msix_db_dma_addr));
+	}
 	WREG32(mmDCORE0_SYNC_MNGR_GLBL_LBW_DATA_0, GAUDI2_IRQ_NUM_COMPLETION);
 
 	for (i = 0 ; i < GAUDI2_RESERVED_CQ_NUMBER ; i++) {
-- 
2.25.1


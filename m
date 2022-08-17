Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0420F5968B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiHQFl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiHQFlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:41:51 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C277570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:41:39 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31AE41A1A83;
        Wed, 17 Aug 2022 07:41:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC0291A1A2E;
        Wed, 17 Aug 2022 07:41:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 71091180031E;
        Wed, 17 Aug 2022 13:41:36 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Remove unnecessary FIFO reset in ISR
Date:   Wed, 17 Aug 2022 13:24:27 +0800
Message-Id: <1660713867-26921-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIFO reset drops the words in the FIFO, which may cause
channel swap when SAI module is running, especially when the
DMA speed is low. So it is not good to do FIFO reset in ISR,
then remove the operation.

Fixes: e2681a1bf5ae ("ASoC: fsl_sai: Add isr to deal with error flag")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d430eece1d6b..a7fa6f0bf83d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -114,11 +114,8 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 	if (flags & FSL_SAI_CSR_SEF)
 		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
 
-	if (flags & FSL_SAI_CSR_FEF) {
+	if (flags & FSL_SAI_CSR_FEF)
 		dev_dbg(dev, "isr: Transmit underrun detected\n");
-		/* FIFO reset for safety */
-		xcsr |= FSL_SAI_CSR_FR;
-	}
 
 	if (flags & FSL_SAI_CSR_FWF)
 		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
@@ -148,11 +145,8 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 	if (flags & FSL_SAI_CSR_SEF)
 		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
 
-	if (flags & FSL_SAI_CSR_FEF) {
+	if (flags & FSL_SAI_CSR_FEF)
 		dev_dbg(dev, "isr: Receive overflow detected\n");
-		/* FIFO reset for safety */
-		xcsr |= FSL_SAI_CSR_FR;
-	}
 
 	if (flags & FSL_SAI_CSR_FWF)
 		dev_dbg(dev, "isr: Enabled receive FIFO is full\n");
-- 
2.34.1


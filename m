Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079954A80E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351147AbiFNEZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346694AbiFNEZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:25:37 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5422AC66;
        Mon, 13 Jun 2022 21:25:36 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07F54202710;
        Tue, 14 Jun 2022 06:25:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B1A13202717;
        Tue, 14 Jun 2022 06:25:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CC104180219B;
        Tue, 14 Jun 2022 12:25:32 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ASoC: fsl_sai: Move res variable to be global
Date:   Tue, 14 Jun 2022 12:11:22 +0800
Message-Id: <1655179884-12278-6-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource info need to be accessed by hw_params()
function for multi fifo case, the start address may
be not the FIFO0. So move it to be global first.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++----
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ddfe28cb7df0..86aa0baba848 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1077,7 +1077,6 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fsl_sai *sai;
 	struct regmap *gpr;
-	struct resource *res;
 	void __iomem *base;
 	char tmp[8];
 	int irq, ret, i;
@@ -1092,7 +1091,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
 
-	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &sai->res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
@@ -1192,8 +1191,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 				   MCLK_DIR(index));
 	}
 
-	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR0;
-	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR0;
+	sai->dma_params_rx.addr = sai->res->start + FSL_SAI_RDR0;
+	sai->dma_params_tx.addr = sai->res->start + FSL_SAI_TDR0;
 	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
 	sai->dma_params_tx.maxburst = FSL_SAI_MAXBURST_TX;
 
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index c0b6bc42fc3c..4d657edc9c9f 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -258,6 +258,7 @@ struct fsl_sai {
 	struct regmap *regmap;
 	struct clk *bus_clk;
 	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
+	struct resource *res;
 
 	bool is_consumer_mode;
 	bool is_lsb_first;
-- 
2.17.1


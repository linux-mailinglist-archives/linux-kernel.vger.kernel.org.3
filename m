Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5A4C5952
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 06:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiB0FKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 00:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiB0FK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 00:10:27 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C763CD3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 21:09:46 -0800 (PST)
X-QQ-mid: bizesmtp67t1645938576th46lq5y
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Feb 2022 13:09:30 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: TskX/GkkryA71JOqngR2rwZY4PD6O/RVwtsyrw4mgSIqLyrN4/cHwFSRUAAp2
        nR0XRI4wrRVKRLrdiE6qGyegr41pyu+1MEpFc3Hz29sKVjLWnSopnntoSvE/kbFq32SbGIt
        rbKaxgHdClGn63PGDLiKLSpge7rvhJ2Lb3a5Y/yGuNkxqQUnijlLwfyWJU6wXBOxTJ7JKFX
        cMi+vVSHFi+wNBW55gLFClF6hKkyj7uafbdRpW+nMSEPF3jbY4VNx4svjPYstj924syC6eE
        yDSDVNSo2F2ERn2AuTqDZRqdAo9LtT/+peenskUgLlQaHG5yjuZnqfpatn4Pz+NsjBWotzV
        joUCZm/9zOQ9wEjuOAG21F38Ciz/O1ZZ9k68BUb
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     tiwai@suse.com, perex@perex.cz, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ASoC: amd: pcm-dma: Use platform_get_irq() to get the interrupt
Date:   Sun, 27 Feb 2022 13:09:28 +0800
Message-Id: <20220227050928.32270-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/amd/acp-pcm-dma.c           | 11 ++++-------
 sound/soc/amd/raven/acp3x-pcm-dma.c   |  8 ++------
 sound/soc/amd/renoir/acp3x-pdm-dma.c  |  7 ++-----
 sound/soc/amd/vangogh/acp5x-pcm-dma.c |  7 ++-----
 4 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 8fa2e2fde4f1..1cd2e70a57df 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1217,9 +1217,8 @@ static const struct snd_soc_component_driver acp_asoc_platform = {
 
 static int acp_audio_probe(struct platform_device *pdev)
 {
-	int status;
+	int status, irq;
 	struct audio_drv_data *audio_drv_data;
-	struct resource *res;
 	const u32 *pdata = pdev->dev.platform_data;
 
 	if (!pdata) {
@@ -1249,13 +1248,11 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->asic_type =  *pdata;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
 		return -ENODEV;
-	}
 
-	status = devm_request_irq(&pdev->dev, res->start, dma_irq_handler,
+	status = devm_request_irq(&pdev->dev, irq, dma_irq_handler,
 				  0, "ACP_IRQ", &pdev->dev);
 	if (status) {
 		dev_err(&pdev->dev, "ACP IRQ request failed\n");
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 75c06697fa09..e4f8dbf0d11d 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -394,13 +394,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 	if (!adata->acp3x_base)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+	adata->i2s_irq =  platform_get_irq(pdev, 0);
+	if (adata->i2s_irq < 0)
 		return -ENODEV;
-	}
-
-	adata->i2s_irq = res->start;
 
 	dev_set_drvdata(&pdev->dev, adata);
 	status = devm_snd_soc_register_component(&pdev->dev,
diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 9dd22a2fa2e5..88a242538461 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -399,13 +399,10 @@ static int acp_pdm_audio_probe(struct platform_device *pdev)
 	if (!adata->acp_base)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+	adata->pdm_irq = platform_get_irq(pdev, 0);
+	if (adata->pdm_irq < 0)
 		return -ENODEV;
-	}
 
-	adata->pdm_irq = res->start;
 	adata->capture_stream = NULL;
 
 	dev_set_drvdata(&pdev->dev, adata);
diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index f10de38976cb..c8cd1777a63c 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -388,13 +388,10 @@ static int acp5x_audio_probe(struct platform_device *pdev)
 	if (!adata->acp5x_base)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+	adata->i2s_irq = platform_get_irq(pdev, 0);
+	if (adata->i2s_irq < 0)
 		return -ENODEV;
-	}
 
-	adata->i2s_irq = res->start;
 	dev_set_drvdata(&pdev->dev, adata);
 	status = devm_snd_soc_register_component(&pdev->dev,
 						 &acp5x_i2s_component,
-- 
2.20.1




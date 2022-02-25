Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44B4C43A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiBYL3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiBYL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:29:50 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFEC1E4825
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:29:16 -0800 (PST)
X-QQ-mid: bizesmtp86t1645788534t8f8h8iv
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 25 Feb 2022 19:28:48 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000000A0000000
X-QQ-FEAT: fp8AQXDviwlRcg4zql4tzXpwUuKmi9it+HjeQlar+ZzEnu8sFGW5lg28uXVhq
        Im1s3Z5UrlkvDa2u9izy9rzBOc02AkQXaTaz75GL2XcaRv111jDjkRM+VowxEwoxfOsr7Fy
        5Aa55349s931VgwVxkQH5GWWeMsreZpe7F9RC3LLj4I95DMoxPdhGR1PZny9dR1iq6su5jx
        t1/bRuRQzCsHoaOJlFpiJcOKblE7hbbdix6w4fcrE50grCUmtGJEqpcaR6AVO5tSi3hhU5T
        k+1SMlZNjj73yOJlwjb8v88W6ikNJmgQPJJdD/tbugjbe91Tuo4mB7xSqBPPex6UU1hCE+M
        pjjDVBJrbDP+AUk/kZyITDm1Nud7qN38w1kajD0qj7yVfBUI08=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] sound/soc/amd: Use platform_get_irq() to get the interrupt
Date:   Fri, 25 Feb 2022 19:28:47 +0800
Message-Id: <20220225112847.21851-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9FB586B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiHAMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiHAMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:49:24 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86863232
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:42:35 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0228A20148F;
        Mon,  1 Aug 2022 14:42:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BEB9220130A;
        Mon,  1 Aug 2022 14:42:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C22A180031C;
        Mon,  1 Aug 2022 20:42:32 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-rpmsg: Support configure sysclk for codec dai
Date:   Mon,  1 Aug 2022 20:26:13 +0800
Message-Id: <1659356773-8315-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some codecs need to configure the sysclk even with slave
mode, otherwise it may not work properly with some case.

wm8960 is the one that need sysclk be configured, so add
late_probe() to call the snd_soc_dai_set_sysclk() of codec

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-rpmsg.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 2e117311e582..bef4bd997c98 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -19,6 +19,7 @@
 struct imx_rpmsg {
 	struct snd_soc_dai_link dai;
 	struct snd_soc_card card;
+	unsigned int sysclk;
 };
 
 static const struct snd_soc_dapm_widget imx_rpmsg_dapm_widgets[] = {
@@ -28,6 +29,27 @@ static const struct snd_soc_dapm_widget imx_rpmsg_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Main MIC", NULL),
 };
 
+static int imx_rpmsg_late_probe(struct snd_soc_card *card)
+{
+	struct imx_rpmsg *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_pcm_runtime *rtd = list_first_entry(&card->rtd_list,
+							   struct snd_soc_pcm_runtime, list);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct device *dev = card->dev;
+	int ret;
+
+	if (!data->sysclk)
+		return 0;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, data->sysclk, SND_SOC_CLOCK_IN);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(dev, "failed to set sysclk in %s\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int imx_rpmsg_probe(struct platform_device *pdev)
 {
 	struct snd_soc_dai_link_component *dlc;
@@ -72,12 +94,18 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 		data->dai.codecs->dai_name = "snd-soc-dummy-dai";
 		data->dai.codecs->name = "snd-soc-dummy";
 	} else {
+		struct clk *clk;
+
 		data->dai.codecs->of_node = args.np;
 		ret = snd_soc_get_dai_name(&args, &data->dai.codecs->dai_name);
 		if (ret) {
 			dev_err(&pdev->dev, "Unable to get codec_dai_name\n");
 			goto fail;
 		}
+
+		clk = devm_get_clk_from_child(&pdev->dev, args.np, NULL);
+		if (!IS_ERR(clk))
+			data->sysclk = clk_get_rate(clk);
 	}
 
 	data->dai.cpus->dai_name = dev_name(&rpmsg_pdev->dev);
@@ -103,6 +131,7 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 	data->card.owner = THIS_MODULE;
 	data->card.dapm_widgets = imx_rpmsg_dapm_widgets;
 	data->card.num_dapm_widgets = ARRAY_SIZE(imx_rpmsg_dapm_widgets);
+	data->card.late_probe = imx_rpmsg_late_probe;
 	/*
 	 * Inoder to use common api to get card name and audio routing.
 	 * Use parent of_node for this device, revert it after finishing using
-- 
2.34.1


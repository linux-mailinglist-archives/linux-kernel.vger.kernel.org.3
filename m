Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC704E56BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiCWQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiCWQqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:46:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD8DE8A;
        Wed, 23 Mar 2022 09:45:08 -0700 (PDT)
X-UUID: 45a5b0fe02f64b9cb12e06f1912f113a-20220324
X-UUID: 45a5b0fe02f64b9cb12e06f1912f113a-20220324
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1564609546; Thu, 24 Mar 2022 00:45:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 24 Mar 2022 00:45:03 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 00:45:02 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <tzungbi@google.com>
CC:     <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v6 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of speaker
Date:   Thu, 24 Mar 2022 00:44:40 +0800
Message-ID: <20220323164442.921-3-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323164442.921-1-jiaxin.yu@mediatek.com>
References: <20220323164442.921-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8192 platform will use rt1015 or rt105p codec, so through the
snd_soc_of_get_dai_link_codecs() to complete the configuration
of dai_link's codecs.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 108 ++++++++++--------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index ee91569c0911..362bd6853e5e 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -604,17 +604,9 @@ SND_SOC_DAILINK_DEFS(i2s2,
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-SND_SOC_DAILINK_DEFS(i2s3_rt1015,
+SND_SOC_DAILINK_DEFS(i2s3,
 		     DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC(RT1015_DEV0_NAME,
-						   RT1015_CODEC_DAI),
-					COMP_CODEC(RT1015_DEV1_NAME,
-						   RT1015_CODEC_DAI)),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(i2s3_rt1015p,
-		     DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC("rt1015p", "HiFi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(i2s5,
@@ -929,6 +921,7 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8192_i2s_hw_params_fixup,
+		SND_SOC_DAILINK_REG(i2s3),
 	},
 	{
 		.name = "I2S5",
@@ -1100,55 +1093,64 @@ static struct snd_soc_card mt8192_mt6359_rt1015p_rt5682_card = {
 	.num_dapm_routes = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_routes),
 };
 
+static int mt8192_mt6359_card_set_be_link(struct snd_soc_card *card,
+					  struct snd_soc_dai_link *link,
+					  struct device_node *node,
+					  char *link_name)
+{
+	int ret;
+
+	if (node && strcmp(link->name, link_name) == 0) {
+		ret = snd_soc_of_get_dai_link_codecs(card->dev, node, link);
+		if (ret < 0) {
+			dev_err_probe(card->dev, ret, "get dai link codecs fail\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
-	struct device_node *platform_node, *hdmi_codec;
+	struct device_node *platform_node, *hdmi_codec, *speaker_codec;
 	int ret, i;
 	struct snd_soc_dai_link *dai_link;
 	struct mt8192_mt6359_priv *priv;
 
-	platform_node = of_parse_phandle(pdev->dev.of_node,
-					 "mediatek,platform", 0);
-	if (!platform_node) {
-		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
+	if (!card)
 		return -EINVAL;
+	card->dev = &pdev->dev;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
+	if (!platform_node) {
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
+		goto err_platform_node;
 	}
 
-	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
-	if (!card) {
+	hdmi_codec = of_parse_phandle(pdev->dev.of_node, "mediatek,hdmi-codec", 0);
+	if (!hdmi_codec) {
 		ret = -EINVAL;
-		goto put_platform_node;
+		dev_err_probe(&pdev->dev, ret, "Property 'hdmi-codec' missing or invalid\n");
+		goto err_hdmi_codec;
 	}
-	card->dev = &pdev->dev;
 
-	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
-				      "mediatek,hdmi-codec", 0);
+	speaker_codec = of_get_child_by_name(pdev->dev.of_node, "speaker-codec");
+	if (!speaker_codec) {
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret, "Property 'speaker_codec' missing or invalid\n");
+		goto err_speaker_codec;
+	}
 
 	for_each_card_prelinks(card, i, dai_link) {
-		if (strcmp(dai_link->name, "I2S3") == 0) {
-			if (card == &mt8192_mt6359_rt1015_rt5682_card) {
-				dai_link->ops = &mt8192_rt1015_i2s_ops;
-				dai_link->cpus = i2s3_rt1015_cpus;
-				dai_link->num_cpus =
-					ARRAY_SIZE(i2s3_rt1015_cpus);
-				dai_link->codecs = i2s3_rt1015_codecs;
-				dai_link->num_codecs =
-					ARRAY_SIZE(i2s3_rt1015_codecs);
-				dai_link->platforms = i2s3_rt1015_platforms;
-				dai_link->num_platforms =
-					ARRAY_SIZE(i2s3_rt1015_platforms);
-			} else if (card == &mt8192_mt6359_rt1015p_rt5682_card) {
-				dai_link->cpus = i2s3_rt1015p_cpus;
-				dai_link->num_cpus =
-					ARRAY_SIZE(i2s3_rt1015p_cpus);
-				dai_link->codecs = i2s3_rt1015p_codecs;
-				dai_link->num_codecs =
-					ARRAY_SIZE(i2s3_rt1015p_codecs);
-				dai_link->platforms = i2s3_rt1015p_platforms;
-				dai_link->num_platforms =
-					ARRAY_SIZE(i2s3_rt1015p_platforms);
-			}
+		ret = mt8192_mt6359_card_set_be_link(card, dai_link, speaker_codec, "I2S3");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",
+				      dai_link->name);
+			goto err_probe;
 		}
 
 		if (hdmi_codec && strcmp(dai_link->name, "TDM") == 0) {
@@ -1156,6 +1158,9 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 			dai_link->ignore = 0;
 		}
 
+		if (strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
+			dai_link->ops = &mt8192_rt1015_i2s_ops;
+
 		if (!dai_link->platforms->name)
 			dai_link->platforms->of_node = platform_node;
 	}
@@ -1163,22 +1168,27 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto put_hdmi_codec;
+		goto err_probe;
 	}
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = mt8192_afe_gpio_init(&pdev->dev);
 	if (ret) {
-		dev_err(&pdev->dev, "init gpio error %d\n", ret);
-		goto put_hdmi_codec;
+		dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);
+		goto err_probe;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);
 
-put_hdmi_codec:
+err_probe:
+	of_node_put(speaker_codec);
+err_speaker_codec:
 	of_node_put(hdmi_codec);
-put_platform_node:
+err_hdmi_codec:
 	of_node_put(platform_node);
+err_platform_node:
 	return ret;
 }
 
-- 
2.18.0


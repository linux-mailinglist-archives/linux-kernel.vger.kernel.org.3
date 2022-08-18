Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D578F597BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbiHRCve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiHRCv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:51:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69CA4B13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:51:27 -0700 (PDT)
X-UUID: b64a40a2e796435bb3639f947e07c2f0-20220818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NlUSWo/dINL4cHeCvNWgETfxjDLnRIsYe3tS38l7UtQ=;
        b=o66araVcaHPRF+EHtgfx+hX164yr0PyeKacsl1FZJTa/ccLV1saU4S3+eHEPK4ejraUBESycOAR1Dohin/mXgPZc8kNQqUfVTi30bt4SJkaqRx4ZBPWmeVDkji7oEVQxb5x2751G1VAS6rjHD2Nn6H5DuLNTrCFuwoADwWe1KaU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:6daf94eb-9bc2-4167-aceb-b0d145139c94,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:c003a3fd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b64a40a2e796435bb3639f947e07c2f0-20220818
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2127082796; Thu, 18 Aug 2022 10:51:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 18 Aug 2022 10:51:21 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 18 Aug 2022 10:51:21 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <matthias.bgg@gmail.com>, <jiaxin.yu@mediatek.com>,
        <tzungbi@google.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH RESEND 3/3] ASoC: mediatek: mt8186: add SOF support on mt8186-mt6366-da7219-max98357
Date:   Thu, 18 Aug 2022 10:51:13 +0800
Message-ID: <20220818025113.17144-4-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818025113.17144-1-chunxu.li@mediatek.com>
References: <20220818025113.17144-1-chunxu.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add widgets, routes and dai-links required by SOF

2. Only when adsp phandle could be retrieved from DTS, the SOF related part
of machine driver is executed.

3. Support dai-links could be specified from DTS, so that
we can disable AP side hardware controls when DSP SOF controls the same
audio FE.

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 .../mt8186/mt8186-mt6366-da7219-max98357.c    | 168 ++++++++++++++++--
 1 file changed, 155 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index 387f25cad809..84ee5d95a9f0 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -18,6 +18,8 @@
 #include "../../codecs/da7219.h"
 #include "../../codecs/mt6358.h"
 #include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-dsp-sof-common.h"
+#include "../common/mtk-soc-card.h"
 #include "mt8186-afe-common.h"
 #include "mt8186-afe-clk.h"
 #include "mt8186-afe-gpio.h"
@@ -26,6 +28,11 @@
 #define DA7219_CODEC_DAI "da7219-hifi"
 #define DA7219_DEV_NAME "da7219.5-001a"
 
+#define SOF_DMA_DL1 "SOF_DMA_DL1"
+#define SOF_DMA_DL2 "SOF_DMA_DL2"
+#define SOF_DMA_UL1 "SOF_DMA_UL1"
+#define SOF_DMA_UL2 "SOF_DMA_UL2"
+
 struct mt8186_mt6366_da7219_max98357_priv {
 	struct snd_soc_jack headset_jack, hdmi_jack;
 };
@@ -47,8 +54,9 @@ static struct snd_soc_codec_conf mt8186_mt6366_da7219_max98357_codec_conf[] = {
 
 static int mt8186_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct mt8186_mt6366_da7219_max98357_priv *priv =
+	struct mtk_soc_card_data *soc_card_data =
 		snd_soc_card_get_drvdata(rtd->card);
+	struct mt8186_mt6366_da7219_max98357_priv *priv = soc_card_data->mach_priv;
 	struct snd_soc_jack *jack = &priv->headset_jack;
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
@@ -154,8 +162,9 @@ static int mt8186_mt6366_da7219_max98357_hdmi_init(struct snd_soc_pcm_runtime *r
 {
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mt8186_mt6366_da7219_max98357_priv *priv =
+	struct mtk_soc_card_data *soc_card_data =
 		snd_soc_card_get_drvdata(rtd->card);
+	struct mt8186_mt6366_da7219_max98357_priv *priv = soc_card_data->mach_priv;
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, &priv->hdmi_jack);
@@ -201,6 +210,24 @@ static int mt8186_anx7625_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return mt8186_hw_params_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
 }
 
+/* fixup the BE DAI link to match any values from topology */
+static int mt8186_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
+				     struct snd_pcm_hw_params *params)
+{
+	int ret;
+
+	ret = mtk_sof_dai_link_fixup(rtd, params);
+
+	if (!strcmp(rtd->dai_link->name, "I2S0") ||
+	    !strcmp(rtd->dai_link->name, "I2S1") ||
+	    !strcmp(rtd->dai_link->name, "I2S2"))
+		mt8186_i2s_hw_params_fixup(rtd, params);
+	else if (!strcmp(rtd->dai_link->name, "I2S3"))
+		mt8186_anx7625_i2s_hw_params_fixup(rtd, params);
+
+	return ret;
+}
+
 static int mt8186_mt6366_da7219_max98357_playback_startup(struct snd_pcm_substream *substream)
 {
 	static const unsigned int rates[] = {
@@ -474,6 +501,33 @@ SND_SOC_DAILINK_DEFS(hostless_src_aaudio,
 		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless SRC AAudio DAI")),
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(AFE_SOF_DL1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_DL2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_UL1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_UL2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static const struct sof_conn_stream g_sof_conn_streams[] = {
+	{ "I2S1", "AFE_SOF_DL1", SOF_DMA_DL1, SNDRV_PCM_STREAM_PLAYBACK},
+	{ "I2S3", "AFE_SOF_DL2", SOF_DMA_DL2, SNDRV_PCM_STREAM_PLAYBACK},
+	{ "Primary Codec", "AFE_SOF_UL1", SOF_DMA_UL1, SNDRV_PCM_STREAM_CAPTURE},
+	{ "I2S0", "AFE_SOF_UL2", SOF_DMA_UL2, SNDRV_PCM_STREAM_CAPTURE},
+};
+
 static struct snd_soc_dai_link mt8186_mt6366_da7219_max98357_dai_links[] = {
 	/* Front End DAI links */
 	{
@@ -848,12 +902,41 @@ static struct snd_soc_dai_link mt8186_mt6366_da7219_max98357_dai_links[] = {
 		.ignore_suspend = 1,
 		SND_SOC_DAILINK_REG(hostless_ul6),
 	},
+	/* SOF BE */
+	{
+		.name = "AFE_SOF_DL1",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_DL1),
+	},
+	{
+		.name = "AFE_SOF_DL2",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_DL2),
+	},
+	{
+		.name = "AFE_SOF_UL1",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_UL1),
+	},
+	{
+		.name = "AFE_SOF_UL2",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_UL2),
+	},
 };
 
 static const struct snd_soc_dapm_widget
 mt8186_mt6366_da7219_max98357_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_OUTPUT("HDMI1"),
+	SND_SOC_DAPM_MIXER(SOF_DMA_DL1, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_UL1, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_UL2, SND_SOC_NOPM, 0, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route
@@ -862,6 +945,14 @@ mt8186_mt6366_da7219_max98357_routes[] = {
 	{ "Speakers", NULL, "Speaker"},
 	/* HDMI */
 	{ "HDMI1", NULL, "TX"},
+	/* SOF Uplink */
+	{SOF_DMA_UL1, NULL, "UL1_CH1"},
+	{SOF_DMA_UL1, NULL, "UL1_CH2"},
+	{SOF_DMA_UL2, NULL, "UL2_CH1"},
+	{SOF_DMA_UL2, NULL, "UL2_CH2"},
+	/* SOF Downlink */
+	{"DSP_DL1_VIRT", NULL, SOF_DMA_DL1},
+	{"DSP_DL2_VIRT", NULL, SOF_DMA_DL2},
 };
 
 static const struct snd_kcontrol_new
@@ -889,8 +980,10 @@ static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8186_mt6366_da7219_max98357_priv *priv;
-	struct device_node *platform_node, *headset_codec, *playback_codec;
+	struct mtk_soc_card_data *soc_card_data;
+	struct mt8186_mt6366_da7219_max98357_priv *mach_priv;
+	struct device_node *platform_node, *headset_codec, *playback_codec, *adsp_node;
+	int sof_on = 0;
 	int ret, i;
 
 	card = (struct snd_soc_card *)device_get_match_data(&pdev->dev);
@@ -898,11 +991,60 @@ static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	card->dev = &pdev->dev;
 
+	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*soc_card_data), GFP_KERNEL);
+	if (!soc_card_data)
+		return -ENOMEM;
+	mach_priv = devm_kzalloc(&pdev->dev, sizeof(*mach_priv), GFP_KERNEL);
+	if (!mach_priv)
+		return -ENOMEM;
+
+	soc_card_data->mach_priv = mach_priv;
+
+	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
+	if (adsp_node) {
+		struct mtk_sof_priv *sof_priv;
+
+		sof_priv = devm_kzalloc(&pdev->dev, sizeof(*sof_priv), GFP_KERNEL);
+		if (!sof_priv) {
+			ret = -ENOMEM;
+			goto err_adsp_node;
+		}
+		sof_priv->conn_streams = g_sof_conn_streams;
+		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
+		sof_priv->sof_dai_link_fixup = mt8186_sof_dai_link_fixup;
+		soc_card_data->sof_priv = sof_priv;
+		card->probe = mtk_sof_card_probe;
+		card->late_probe = mtk_sof_card_late_probe;
+		if (!card->topology_shortname_created) {
+			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
+			card->topology_shortname_created = true;
+		}
+		card->name = card->topology_shortname;
+		sof_on = 1;
+	} else {
+		dev_info(&pdev->dev, "Probe without adsp\n");
+	}
+
+	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
+		ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
+					       "mediatek,dai-link",
+					       mt8186_mt6366_da7219_max98357_dai_links,
+					       ARRAY_SIZE(mt8186_mt6366_da7219_max98357_dai_links));
+		if (ret) {
+			dev_dbg(&pdev->dev, "Parse dai-link fail\n");
+			goto err_adsp_node;
+		}
+	} else {
+		if (!sof_on)
+			card->num_links = ARRAY_SIZE(mt8186_mt6366_da7219_max98357_dai_links)
+					- ARRAY_SIZE(g_sof_conn_streams);
+	}
+
 	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
 	if (!platform_node) {
 		ret = -EINVAL;
 		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
-		return ret;
+		goto err_platform_node;
 	}
 
 	playback_codec = of_get_child_by_name(pdev->dev.of_node, "playback-codecs");
@@ -941,17 +1083,14 @@ static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
 			goto err_probe;
 		}
 
-		if (!dai_link->platforms->name)
-			dai_link->platforms->of_node = platform_node;
-	}
+		if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && sof_on)
+			dai_link->platforms->of_node = adsp_node;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto err_probe;
+		if (!dai_link->platforms->name && !dai_link->platforms->of_node)
+			dai_link->platforms->of_node = platform_node;
 	}
 
-	snd_soc_card_set_drvdata(card, priv);
+	snd_soc_card_set_drvdata(card, soc_card_data);
 
 	ret = mt8186_afe_gpio_init(&pdev->dev);
 	if (ret) {
@@ -969,6 +1108,9 @@ static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
 	of_node_put(playback_codec);
 err_playback_codec:
 	of_node_put(platform_node);
+err_platform_node:
+err_adsp_node:
+	of_node_put(adsp_node);
 
 	return ret;
 }
-- 
2.25.1


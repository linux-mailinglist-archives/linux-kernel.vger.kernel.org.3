Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A02475339
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhLOG6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:58:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60634 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234767AbhLOG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:58:41 -0500
X-UUID: 1131d0494e1b4828953bc7b5456bc9b4-20211215
X-UUID: 1131d0494e1b4828953bc7b5456bc9b4-20211215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1695488071; Wed, 15 Dec 2021 14:58:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Dec 2021 14:58:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Dec 2021 14:58:37 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jiaxin.yu@mediatek.com>, <shumingf@realtek.com>
Subject: [PATCH 1/2] ASoC: mediatek: mt8195: update control for RT5682 series
Date:   Wed, 15 Dec 2021 14:58:34 +0800
Message-ID: <20211215065835.3074-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playback pop is observed and the root cause is the reference clock
provided by MT8195 is diabled before RT5682 finishes the control flow.

To ensure the reference clock supplied to RT5682 is disabled after RT5682
finishes all register controls. We replace BCLK with MCLK for RT5682
reference clock, and makes use of set_bias_level_post to handle MCLK
which guarantees MCLK is off after all RT5682 register access.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 66 +++++++++++++++-
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 76 ++++++++++++++++---
 2 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index 5cdbfaafd479..05359365f200 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -37,6 +37,7 @@ struct mt8195_mt6359_rt1011_rt5682_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
+	struct clk *i2so1_mclk;
 };
 
 static const struct snd_soc_dapm_widget
@@ -87,8 +88,8 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_BCLK1,
-				  rate * 64, rate * 512);
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
+				  rate * 256, rate * 512);
 	if (ret) {
 		dev_err(card->dev, "failed to set pll\n");
 		return ret;
@@ -101,7 +102,7 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 128,
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
 				      SND_SOC_CLOCK_OUT);
 }
 
@@ -565,6 +566,51 @@ static const struct snd_soc_ops mt8195_capture_ops = {
 	.startup = mt8195_capture_startup,
 };
 
+static int mt8195_set_bias_level_post(struct snd_soc_card *card,
+	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
+		snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	/*
+	 * It's required to control mclk directly in the set_bias_level_post
+	 * function for rt5682 and rt5682s codec, or the unexpected pop happens
+	 * at the end of playback.
+	 */
+	if (!component ||
+	    (strcmp(component->name, RT5682_DEV0_NAME) &&
+	    strcmp(component->name, RT5682S_DEV0_NAME)))
+		return 0;
+
+	if (IS_ERR(priv->i2so1_mclk))
+		return 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_OFF:
+		if (!__clk_is_enabled(priv->i2so1_mclk))
+			return 0;
+
+		dev_dbg(card->dev, "Disable i2so1");
+		clk_disable_unprepare(priv->i2so1_mclk);
+		break;
+	case SND_SOC_BIAS_ON:
+		dev_dbg(card->dev, "Enable i2so1");
+		ret = clk_prepare_enable(priv->i2so1_mclk);
+		if (ret) {
+			dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+
 enum {
 	DAI_LINK_DL2_FE,
 	DAI_LINK_DL3_FE,
@@ -1040,6 +1086,7 @@ static struct snd_soc_card mt8195_mt6359_rt1011_rt5682_soc_card = {
 	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1011_rt5682_routes),
 	.codec_conf = rt1011_amp_conf,
 	.num_configs = ARRAY_SIZE(rt1011_amp_conf),
+	.set_bias_level_post = mt8195_set_bias_level_post,
 };
 
 static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
@@ -1072,6 +1119,19 @@ static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	priv->i2so1_mclk = devm_clk_get(&pdev->dev, "i2so1_mclk");
+	if (IS_ERR(priv->i2so1_mclk)) {
+		ret = PTR_ERR(priv->i2so1_mclk);
+		if (ret == -ENOENT) {
+			dev_dbg(&pdev->dev,
+				"Failed to get i2so1_mclk, defer probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(&pdev->dev, "Failed to get i2so1_mclk, err:%d\n", ret);
+		return ret;
+	}
+
 	for_each_card_prelinks(card, i, dai_link) {
 		if (!dai_link->platforms->name)
 			dai_link->platforms->of_node = priv->platform_node;
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index fa50a31e9718..b2c3b57da9c4 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -50,6 +50,7 @@ struct mt8195_mt6359_rt1019_rt5682_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
+	struct clk *i2so1_mclk;
 };
 
 static const struct snd_soc_dapm_widget
@@ -96,8 +97,6 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	unsigned int rate = params_rate(params);
-	unsigned int mclk_fs_ratio = 128;
-	unsigned int mclk_fs = rate * mclk_fs_ratio;
 	int bitwidth;
 	int ret;
 
@@ -113,25 +112,22 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1,
-				  RT5682_PLL1_S_BCLK1,
-				  params_rate(params) * 64,
-				  params_rate(params) * 512);
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
+				  rate * 256, rate * 512);
 	if (ret) {
 		dev_err(card->dev, "failed to set pll\n");
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-				     RT5682_SCLK_S_PLL1,
-				     params_rate(params) * 512,
-				     SND_SOC_CLOCK_IN);
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
+				     rate * 512, SND_SOC_CLOCK_IN);
 	if (ret) {
 		dev_err(card->dev, "failed to set sysclk\n");
 		return ret;
 	}
 
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, mclk_fs, SND_SOC_CLOCK_OUT);
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
+				      SND_SOC_CLOCK_OUT);
 }
 
 static const struct snd_soc_ops mt8195_rt5682_etdm_ops = {
@@ -564,6 +560,50 @@ static const struct snd_soc_ops mt8195_capture_ops = {
 	.startup = mt8195_capture_startup,
 };
 
+static int mt8195_set_bias_level_post(struct snd_soc_card *card,
+	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
+		snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	/*
+	 * It's required to control mclk directly in the set_bias_level_post
+	 * function for rt5682 and rt5682s codec, or the unexpected pop happens
+	 * at the end of playback.
+	 */
+	if (!component ||
+	    (strcmp(component->name, RT5682_DEV0_NAME) &&
+	    strcmp(component->name, RT5682S_DEV0_NAME)))
+		return 0;
+
+	if (IS_ERR(priv->i2so1_mclk))
+		return 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_OFF:
+		if (!__clk_is_enabled(priv->i2so1_mclk))
+			return 0;
+
+		dev_dbg(card->dev, "Disable i2so1");
+		clk_disable_unprepare(priv->i2so1_mclk);
+		break;
+	case SND_SOC_BIAS_ON:
+		dev_dbg(card->dev, "Enable i2so1");
+		ret = clk_prepare_enable(priv->i2so1_mclk);
+		if (ret) {
+			dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 enum {
 	DAI_LINK_DL2_FE,
 	DAI_LINK_DL3_FE,
@@ -1203,6 +1243,7 @@ static struct snd_soc_card mt8195_mt6359_rt1019_rt5682_soc_card = {
 	.num_dapm_widgets = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_widgets),
 	.dapm_routes = mt8195_mt6359_rt1019_rt5682_routes,
 	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_routes),
+	.set_bias_level_post = mt8195_set_bias_level_post,
 };
 
 static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
@@ -1285,6 +1326,19 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	priv->i2so1_mclk = devm_clk_get(&pdev->dev, "i2so1_mclk");
+	if (IS_ERR(priv->i2so1_mclk)) {
+		ret = PTR_ERR(priv->i2so1_mclk);
+		if (ret == -ENOENT) {
+			dev_dbg(&pdev->dev,
+				"Failed to get i2so1_mclk, defer probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(&pdev->dev, "Failed to get i2so1_mclk, err:%d\n", ret);
+		return ret;
+	}
+
 	/* dai link */
 	priv->adsp_node = of_parse_phandle(pdev->dev.of_node,
 					   "mediatek,adsp", 0);
-- 
2.18.0


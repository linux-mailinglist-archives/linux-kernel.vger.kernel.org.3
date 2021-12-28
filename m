Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6B4806D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhL1Gsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:48:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46980 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235198AbhL1Gs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:48:28 -0500
X-UUID: 594e3613dc8f4311bbf479f4fa493a53-20211228
X-UUID: 594e3613dc8f4311bbf479f4fa493a53-20211228
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1302098814; Tue, 28 Dec 2021 14:48:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 28 Dec 2021 14:48:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Dec 2021 14:48:22 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jiaxin.yu@mediatek.com>, <shumingf@realtek.com>,
        <tzungbi@google.com>
Subject: [PATCH v2] ASoC: mediatek: mt8195: update control for RT5682 series
Date:   Tue, 28 Dec 2021 14:48:21 +0800
Message-ID: <20211228064821.27865-1-trevor.wu@mediatek.com>
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
Changes since v1:
  1. Adopt some suggestions from Tzung-bi.
  2. mclk phandle is retrieved from afe component instead of dts.
---
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 56 ++++++++++++++-
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 68 ++++++++++++++++---
 2 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index ce8dace6527c..8adbd46c4bc4 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -18,6 +18,7 @@
 #include "../../codecs/rt1011.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
+#include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
 
 #define RT1011_CODEC_DAI	"rt1011-aif"
@@ -34,6 +35,7 @@ struct mt8195_mt6359_rt1011_rt5682_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
+	struct clk *i2so1_mclk;
 };
 
 static const struct snd_soc_dapm_widget
@@ -84,8 +86,8 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_BCLK1,
-				  rate * 64, rate * 512);
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
+				  rate * 256, rate * 512);
 	if (ret) {
 		dev_err(card->dev, "failed to set pll\n");
 		return ret;
@@ -98,7 +100,7 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 128,
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
 				      SND_SOC_CLOCK_OUT);
 }
 
@@ -327,8 +329,14 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
 		snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_component *cmpnt_afe =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
+	priv->i2so1_mclk = afe_priv->clk[MT8195_CLK_TOP_APLL12_DIV2];
+
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
@@ -562,6 +570,47 @@ static const struct snd_soc_ops mt8195_capture_ops = {
 	.startup = mt8195_capture_startup,
 };
 
+static int mt8195_set_bias_level_post(struct snd_soc_card *card,
+	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
+		snd_soc_card_get_drvdata(card);
+	int ret;
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
+	switch (level) {
+	case SND_SOC_BIAS_OFF:
+		if (!__clk_is_enabled(priv->i2so1_mclk))
+			return 0;
+
+		clk_disable_unprepare(priv->i2so1_mclk);
+		dev_dbg(card->dev, "Disable i2so1 mclk\n");
+		break;
+	case SND_SOC_BIAS_ON:
+		ret = clk_prepare_enable(priv->i2so1_mclk);
+		if (ret) {
+			dev_err(card->dev, "Can't enable i2so1 mclk: %d\n", ret);
+			return ret;
+		}
+		dev_dbg(card->dev, "Enable i2so1 mclk\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 enum {
 	DAI_LINK_DL2_FE,
 	DAI_LINK_DL3_FE,
@@ -1037,6 +1086,7 @@ static struct snd_soc_card mt8195_mt6359_rt1011_rt5682_soc_card = {
 	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1011_rt5682_routes),
 	.codec_conf = rt1011_amp_conf,
 	.num_configs = ARRAY_SIZE(rt1011_amp_conf),
+	.set_bias_level_post = mt8195_set_bias_level_post,
 };
 
 static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index c15c58170e9d..20b351faeaff 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -19,6 +19,7 @@
 #include "../../codecs/mt6359.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
+#include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
 
 #define RT1019_CODEC_DAI	"HiFi"
@@ -46,6 +47,7 @@ struct mt8195_mt6359_rt1019_rt5682_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack dp_jack;
 	struct snd_soc_jack hdmi_jack;
+	struct clk *i2so1_mclk;
 };
 
 static const struct snd_soc_dapm_widget
@@ -92,8 +94,6 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	unsigned int rate = params_rate(params);
-	unsigned int mclk_fs_ratio = 128;
-	unsigned int mclk_fs = rate * mclk_fs_ratio;
 	int bitwidth;
 	int ret;
 
@@ -109,25 +109,22 @@ static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
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
@@ -322,8 +319,14 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
 		snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_component *cmpnt_afe =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
+	priv->i2so1_mclk = afe_priv->clk[MT8195_CLK_TOP_APLL12_DIV2];
+
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
@@ -560,6 +563,48 @@ static const struct snd_soc_ops mt8195_capture_ops = {
 	.startup = mt8195_capture_startup,
 };
 
+static int mt8195_set_bias_level_post(struct snd_soc_card *card,
+	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
+		snd_soc_card_get_drvdata(card);
+	int ret;
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
+
+	switch (level) {
+	case SND_SOC_BIAS_OFF:
+		if (!__clk_is_enabled(priv->i2so1_mclk))
+			return 0;
+
+		clk_disable_unprepare(priv->i2so1_mclk);
+		dev_dbg(card->dev, "Disable i2so1 mclk\n");
+		break;
+	case SND_SOC_BIAS_ON:
+		ret = clk_prepare_enable(priv->i2so1_mclk);
+		if (ret) {
+			dev_err(card->dev, "Can't enable i2so1 mclk: %d\n", ret);
+			return ret;
+		}
+		dev_dbg(card->dev, "Enable i2so1 mclk\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 enum {
 	DAI_LINK_DL2_FE,
 	DAI_LINK_DL3_FE,
@@ -1199,6 +1244,7 @@ static struct snd_soc_card mt8195_mt6359_rt1019_rt5682_soc_card = {
 	.num_dapm_widgets = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_widgets),
 	.dapm_routes = mt8195_mt6359_rt1019_rt5682_routes,
 	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_routes),
+	.set_bias_level_post = mt8195_set_bias_level_post,
 };
 
 static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
-- 
2.18.0


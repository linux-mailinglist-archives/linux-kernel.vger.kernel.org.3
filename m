Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB744D10E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiCHH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344586AbiCHHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:25:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD253DA5E;
        Mon,  7 Mar 2022 23:24:49 -0800 (PST)
X-UUID: bd4cbb7b05084d23972d69ab5057e0b8-20220308
X-UUID: bd4cbb7b05084d23972d69ab5057e0b8-20220308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 246457759; Tue, 08 Mar 2022 15:24:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Mar 2022 15:24:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 15:24:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Subject: [PATCH 4/5] ASoC: mediatek: mt8195: add machine driver with mt6359, max98390 and rt5682
Date:   Tue, 8 Mar 2022 15:24:34 +0800
Message-ID: <20220308072435.22460-5-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220308072435.22460-1-trevor.wu@mediatek.com>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for mt8195 board with mt6359, max98390 and rt5682.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |   16 +
 sound/soc/mediatek/mt8195/Makefile            |    5 +
 .../mt8195/mt8195-mt6359-max98390-rt5682.c    | 1058 +++++++++++++++++
 3 files changed, 1079 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 0d154350f180..ce9000013ac4 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -229,3 +229,19 @@ config SND_SOC_MT8195_MT6359_RT1011_RT5682
 	  with the MT6359 RT1011 RT5682 audio codec.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
+config SND_SOC_MT8195_MT6359_MAX98390_RT5682
+	tristate "ASoC Audio driver for MT8195 with MT6359 MAX98390 RT5682 codec"
+	depends on I2C
+	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
+	select SND_SOC_MT6359
+	select SND_SOC_MAX98390
+	select SND_SOC_RT5682_I2C
+	select SND_SOC_RT5682S
+	select SND_SOC_DMIC
+	select SND_SOC_HDMI_CODEC
+	help
+	  This adds ASoC driver for Mediatek MT8195 boards
+	  with the MT6359 MAX98390 RT5682 audio codec.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/soc/mediatek/mt8195/Makefile b/sound/soc/mediatek/mt8195/Makefile
index d707cbd2672d..e70ee2c6a61e 100644
--- a/sound/soc/mediatek/mt8195/Makefile
+++ b/sound/soc/mediatek/mt8195/Makefile
@@ -20,5 +20,10 @@ snd-soc-mt8195-rt1011-rt5682-objs := \
 	mt8195-mt6359-rt1011-rt5682.o \
 	mt8195-mt6359-common.o
 
+snd-soc-mt8195-max98390-rt5682-objs := \
+	mt8195-mt6359-max98390-rt5682.o \
+	mt8195-mt6359-common.o
+
 obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1019_RT5682) += snd-soc-mt8195-rt1019-rt5682.o
 obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1011_RT5682) += snd-soc-mt8195-rt1011-rt5682.o
+obj-$(CONFIG_SND_SOC_MT8195_MT6359_MAX98390_RT5682) += snd-soc-mt8195-max98390-rt5682.o
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c
new file mode 100644
index 000000000000..b0d55a7889d2
--- /dev/null
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c
@@ -0,0 +1,1058 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt8195-mt6359-max98390-rt5682.c  --
+ *	MT8195-MT6359-MAX98390-RT5682 ALSA SoC machine driver
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#include <linux/input.h>
+#include <linux/module.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include <sound/rt5682.h>
+#include <sound/sof.h>
+#include <sound/soc.h>
+#include "../../codecs/rt5682.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "mt8195-afe-clk.h"
+#include "mt8195-afe-common.h"
+#include "mt8195-mt6359-common.h"
+
+#define MAX98390_CODEC_DAI	"max98390-aif1"
+#define MAX98390_DEV0_NAME	"max98390.2-0038" /* right */
+#define MAX98390_DEV1_NAME	"max98390.2-0039" /* left */
+
+#define RT5682_CODEC_DAI	"rt5682-aif1"
+#define RT5682_DEV0_NAME	"rt5682.2-001a"
+
+#define RT5682S_CODEC_DAI	"rt5682s-aif1"
+#define RT5682S_DEV0_NAME	"rt5682s.2-001a"
+
+#define SOF_DMA_DL2 "SOF_DMA_DL2"
+#define SOF_DMA_DL3 "SOF_DMA_DL3"
+#define SOF_DMA_UL4 "SOF_DMA_UL4"
+#define SOF_DMA_UL5 "SOF_DMA_UL5"
+
+struct sof_conn_stream {
+	const char *normal_link;
+	const char *sof_link;
+	const char *sof_dma;
+	int stream_dir;
+};
+
+static const struct snd_soc_dapm_widget
+	mt8195_mt6359_max98390_rt5682_widgets[] = {
+	SND_SOC_DAPM_SPK("Left Speaker", NULL),
+	SND_SOC_DAPM_SPK("Right Speaker", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_DL3, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_UL4, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_UL5, SND_SOC_NOPM, 0, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_route mt8195_mt6359_max98390_rt5682_routes[] = {
+	/* speaker */
+	{ "Left Speaker", NULL, "Left BE_OUT" },
+	{ "Right Speaker", NULL, "Right BE_OUT" },
+	/* headset */
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+	{ "IN1P", NULL, "Headset Mic" },
+	/* SOF Uplink */
+	{SOF_DMA_UL4, NULL, "O034"},
+	{SOF_DMA_UL4, NULL, "O035"},
+	{SOF_DMA_UL5, NULL, "O036"},
+	{SOF_DMA_UL5, NULL, "O037"},
+	/* SOF Downlink */
+	{"I070", NULL, SOF_DMA_DL2},
+	{"I071", NULL, SOF_DMA_DL2},
+	{"I020", NULL, SOF_DMA_DL3},
+	{"I021", NULL, SOF_DMA_DL3},
+};
+
+static const struct snd_kcontrol_new mt8195_mt6359_max98390_rt5682_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Left Speaker"),
+	SOC_DAPM_PIN_SWITCH("Right Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	unsigned int rate = params_rate(params);
+	int bitwidth;
+	int ret;
+
+	bitwidth = snd_pcm_format_width(params_format(params));
+	if (bitwidth < 0) {
+		dev_err(card->dev, "invalid bit width: %d\n", bitwidth);
+		return bitwidth;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x00, 0x0, 0x2, bitwidth);
+	if (ret) {
+		dev_err(card->dev, "failed to set tdm slot\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
+				  rate * 256, rate * 512);
+	if (ret) {
+		dev_err(card->dev, "failed to set pll\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
+				     rate * 512, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(card->dev, "failed to set sysclk\n");
+		return ret;
+	}
+
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
+				      SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8195_rt5682_etdm_ops = {
+	.hw_params = mt8195_rt5682_etdm_hw_params,
+};
+
+static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_component *cmpnt_afe =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	priv->i2so1_mclk = afe_priv->clk[MT8195_CLK_TOP_APLL12_DIV2];
+
+	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+				    SND_JACK_BTN_3,
+				    jack, NULL, 0);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	ret = snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack set failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+};
+
+static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				       struct snd_pcm_hw_params *params)
+{
+	/* fix BE i2s format to S24_LE, clean param mask first */
+	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
+
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+
+	return 0;
+}
+
+static int mt8195_set_bias_level_post(struct snd_soc_card *card,
+				      struct snd_soc_dapm_context *dapm,
+				      enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
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
+enum {
+	DAI_LINK_DL2_FE,
+	DAI_LINK_DL3_FE,
+	DAI_LINK_DL6_FE,
+	DAI_LINK_DL7_FE,
+	DAI_LINK_DL8_FE,
+	DAI_LINK_DL10_FE,
+	DAI_LINK_DL11_FE,
+	DAI_LINK_UL1_FE,
+	DAI_LINK_UL2_FE,
+	DAI_LINK_UL3_FE,
+	DAI_LINK_UL4_FE,
+	DAI_LINK_UL5_FE,
+	DAI_LINK_UL6_FE,
+	DAI_LINK_UL8_FE,
+	DAI_LINK_UL9_FE,
+	DAI_LINK_UL10_FE,
+	DAI_LINK_DL_SRC_BE,
+	DAI_LINK_DPTX_BE,
+	DAI_LINK_ETDM1_IN_BE,
+	DAI_LINK_ETDM2_IN_BE,
+	DAI_LINK_ETDM1_OUT_BE,
+	DAI_LINK_ETDM2_OUT_BE,
+	DAI_LINK_ETDM3_OUT_BE,
+	DAI_LINK_PCM1_BE,
+	DAI_LINK_UL_SRC1_BE,
+	DAI_LINK_UL_SRC2_BE,
+	DAI_LINK_REGULAR_LAST = DAI_LINK_UL_SRC2_BE,
+	DAI_LINK_SOF_START,
+	DAI_LINK_SOF_DL2_BE = DAI_LINK_SOF_START,
+	DAI_LINK_SOF_DL3_BE,
+	DAI_LINK_SOF_UL4_BE,
+	DAI_LINK_SOF_UL5_BE,
+	DAI_LINK_SOF_END = DAI_LINK_SOF_UL5_BE,
+};
+
+#define	DAI_LINK_REGULAR_NUM	(DAI_LINK_REGULAR_LAST + 1)
+
+/* FE */
+SND_SOC_DAILINK_DEFS(DL2_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DL3_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DL6_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DL7_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL7")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DL8_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DL10_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL10")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DL11_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL11")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL1_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL2_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL3_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL4_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL5_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL6_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL8_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL9_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL9")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL10_FE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL10")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+/* BE */
+SND_SOC_DAILINK_DEFS(DL_SRC_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL_SRC")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif1")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(DPTX_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DPTX")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(ETDM1_IN_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_IN")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_IN")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(MAX98390_DEV0_NAME,
+						   MAX98390_CODEC_DAI),
+					COMP_CODEC(MAX98390_DEV1_NAME,
+						   MAX98390_CODEC_DAI)),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(ETDM3_OUT_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM3_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(PCM1_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("PCM1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL_SRC1_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC1")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif1"),
+					COMP_CODEC("dmic-codec",
+						   "dmic-hifi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(UL_SRC2_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC2")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif2")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_DL2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_DL3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_UL4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(AFE_SOF_UL5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static const struct sof_conn_stream g_sof_conn_streams[] = {
+	{ "ETDM2_OUT_BE", "AFE_SOF_DL2", SOF_DMA_DL2, SNDRV_PCM_STREAM_PLAYBACK},
+	{ "ETDM1_OUT_BE", "AFE_SOF_DL3", SOF_DMA_DL3, SNDRV_PCM_STREAM_PLAYBACK},
+	{ "UL_SRC1_BE", "AFE_SOF_UL4", SOF_DMA_UL4, SNDRV_PCM_STREAM_CAPTURE},
+	{ "ETDM2_IN_BE", "AFE_SOF_UL5", SOF_DMA_UL5, SNDRV_PCM_STREAM_CAPTURE},
+};
+
+/* fixup the BE DAI link to match any values from topology */
+static int mt8195_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai_link *sof_dai_link = NULL;
+	struct snd_soc_pcm_runtime *runtime;
+	struct snd_soc_dai *cpu_dai;
+	int i, j, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(g_sof_conn_streams); i++) {
+		const struct sof_conn_stream *conn = &g_sof_conn_streams[i];
+
+		if (strcmp(rtd->dai_link->name, conn->normal_link))
+			continue;
+
+		for_each_card_rtds(card, runtime) {
+			if (strcmp(runtime->dai_link->name, conn->sof_link))
+				continue;
+
+			for_each_rtd_cpu_dais(runtime, j, cpu_dai) {
+				if (cpu_dai->stream_active[conn->stream_dir] > 0) {
+					sof_dai_link = runtime->dai_link;
+					break;
+				}
+			}
+			break;
+		}
+
+		if (sof_dai_link && sof_dai_link->be_hw_params_fixup)
+			ret = sof_dai_link->be_hw_params_fixup(runtime, params);
+
+		break;
+	}
+
+	if (!strcmp(rtd->dai_link->name, "ETDM2_IN_BE") ||
+	    !strcmp(rtd->dai_link->name, "ETDM1_OUT_BE")) {
+		mt8195_etdm_hw_params_fixup(runtime, params);
+	}
+
+	return ret;
+}
+
+static int mt8195_mt6359_max98390_rt5682_card_late_probe(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *runtime;
+	struct snd_soc_component *sof_comp = NULL;
+	int i;
+
+	/* 1. find sof component */
+	for_each_card_rtds(card, runtime) {
+		for (i = 0; i < runtime->num_components; i++) {
+			if (!runtime->components[i]->driver->name)
+				continue;
+			if (!strcmp(runtime->components[i]->driver->name, "sof-audio-component")) {
+				sof_comp = runtime->components[i];
+				break;
+			}
+		}
+	}
+
+	if (!sof_comp) {
+		dev_info(card->dev, " probe without component\n");
+		return 0;
+	}
+	/* 2. add route path and fixup callback */
+	for (i = 0; i < ARRAY_SIZE(g_sof_conn_streams); i++) {
+		const struct sof_conn_stream *conn = &g_sof_conn_streams[i];
+		struct snd_soc_pcm_runtime *sof_rtd = NULL;
+		struct snd_soc_pcm_runtime *normal_rtd = NULL;
+		struct snd_soc_pcm_runtime *rtd = NULL;
+
+		for_each_card_rtds(card, rtd) {
+			if (!strcmp(rtd->dai_link->name, conn->sof_link)) {
+				sof_rtd = rtd;
+				continue;
+			}
+			if (!strcmp(rtd->dai_link->name, conn->normal_link)) {
+				normal_rtd = rtd;
+				continue;
+			}
+			if (normal_rtd && sof_rtd)
+				break;
+		}
+		if (normal_rtd && sof_rtd) {
+			int j;
+			struct snd_soc_dai *cpu_dai;
+
+			for_each_rtd_cpu_dais(sof_rtd, j, cpu_dai) {
+				struct snd_soc_dapm_route route;
+				struct snd_soc_dapm_path *p = NULL;
+				struct snd_soc_dapm_widget *play_widget =
+					cpu_dai->playback_widget;
+				struct snd_soc_dapm_widget *cap_widget =
+					cpu_dai->capture_widget;
+				memset(&route, 0, sizeof(route));
+				if (conn->stream_dir == SNDRV_PCM_STREAM_CAPTURE &&
+				    cap_widget) {
+					snd_soc_dapm_widget_for_each_sink_path(cap_widget, p) {
+						route.source = conn->sof_dma;
+						route.sink = p->sink->name;
+						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
+					}
+				} else if (conn->stream_dir == SNDRV_PCM_STREAM_PLAYBACK &&
+						play_widget){
+					snd_soc_dapm_widget_for_each_source_path(play_widget, p) {
+						route.source = p->source->name;
+						route.sink = conn->sof_dma;
+						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
+					}
+				} else {
+					dev_err(cpu_dai->dev, "stream dir and widget not pair\n");
+				}
+			}
+			normal_rtd->dai_link->be_hw_params_fixup = mt8195_dai_link_fixup;
+		}
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_link mt8195_mt6359_max98390_rt5682_dai_links[] = {
+	/* FE */
+	[DAI_LINK_DL2_FE] = {
+		.name = "DL2_FE",
+		.stream_name = "DL2 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_playback_ops,
+		SND_SOC_DAILINK_REG(DL2_FE),
+	},
+	[DAI_LINK_DL3_FE] = {
+		.name = "DL3_FE",
+		.stream_name = "DL3 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_playback_ops,
+		SND_SOC_DAILINK_REG(DL3_FE),
+	},
+	[DAI_LINK_DL6_FE] = {
+		.name = "DL6_FE",
+		.stream_name = "DL6 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_playback_ops,
+		SND_SOC_DAILINK_REG(DL6_FE),
+	},
+	[DAI_LINK_DL7_FE] = {
+		.name = "DL7_FE",
+		.stream_name = "DL7 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_PRE,
+			SND_SOC_DPCM_TRIGGER_PRE,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(DL7_FE),
+	},
+	[DAI_LINK_DL8_FE] = {
+		.name = "DL8_FE",
+		.stream_name = "DL8 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_playback_ops,
+		SND_SOC_DAILINK_REG(DL8_FE),
+	},
+	[DAI_LINK_DL10_FE] = {
+		.name = "DL10_FE",
+		.stream_name = "DL10 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_hdmitx_dptx_playback_ops,
+		SND_SOC_DAILINK_REG(DL10_FE),
+	},
+	[DAI_LINK_DL11_FE] = {
+		.name = "DL11_FE",
+		.stream_name = "DL11 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_playback_ops,
+		SND_SOC_DAILINK_REG(DL11_FE),
+	},
+	[DAI_LINK_UL1_FE] = {
+		.name = "UL1_FE",
+		.stream_name = "UL1 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_PRE,
+			SND_SOC_DPCM_TRIGGER_PRE,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(UL1_FE),
+	},
+	[DAI_LINK_UL2_FE] = {
+		.name = "UL2_FE",
+		.stream_name = "UL2 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL2_FE),
+	},
+	[DAI_LINK_UL3_FE] = {
+		.name = "UL3_FE",
+		.stream_name = "UL3 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL3_FE),
+	},
+	[DAI_LINK_UL4_FE] = {
+		.name = "UL4_FE",
+		.stream_name = "UL4 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL4_FE),
+	},
+	[DAI_LINK_UL5_FE] = {
+		.name = "UL5_FE",
+		.stream_name = "UL5 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL5_FE),
+	},
+	[DAI_LINK_UL6_FE] = {
+		.name = "UL6_FE",
+		.stream_name = "UL6 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_PRE,
+			SND_SOC_DPCM_TRIGGER_PRE,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(UL6_FE),
+	},
+	[DAI_LINK_UL8_FE] = {
+		.name = "UL8_FE",
+		.stream_name = "UL8 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL8_FE),
+	},
+	[DAI_LINK_UL9_FE] = {
+		.name = "UL9_FE",
+		.stream_name = "UL9 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL9_FE),
+	},
+	[DAI_LINK_UL10_FE] = {
+		.name = "UL10_FE",
+		.stream_name = "UL10 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ops = &mt8195_capture_ops,
+		SND_SOC_DAILINK_REG(UL10_FE),
+	},
+	/* BE */
+	[DAI_LINK_DL_SRC_BE] = {
+		.name = "DL_SRC_BE",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(DL_SRC_BE),
+	},
+	[DAI_LINK_DPTX_BE] = {
+		.name = "DPTX_BE",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.ops = &mt8195_dptx_ops,
+		.be_hw_params_fixup = mt8195_dptx_hw_params_fixup,
+		SND_SOC_DAILINK_REG(DPTX_BE),
+	},
+	[DAI_LINK_ETDM1_IN_BE] = {
+		.name = "ETDM1_IN_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(ETDM1_IN_BE),
+	},
+	[DAI_LINK_ETDM2_IN_BE] = {
+		.name = "ETDM2_IN_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_capture = 1,
+		.init = mt8195_rt5682_init,
+		.ops = &mt8195_rt5682_etdm_ops,
+		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
+		SND_SOC_DAILINK_REG(ETDM2_IN_BE),
+	},
+	[DAI_LINK_ETDM1_OUT_BE] = {
+		.name = "ETDM1_OUT_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_playback = 1,
+		.ops = &mt8195_rt5682_etdm_ops,
+		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
+		SND_SOC_DAILINK_REG(ETDM1_OUT_BE),
+	},
+	[DAI_LINK_ETDM2_OUT_BE] = {
+		.name = "ETDM2_OUT_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(ETDM2_OUT_BE),
+	},
+	[DAI_LINK_ETDM3_OUT_BE] = {
+		.name = "ETDM3_OUT_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(ETDM3_OUT_BE),
+	},
+	[DAI_LINK_PCM1_BE] = {
+		.name = "PCM1_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(PCM1_BE),
+	},
+	[DAI_LINK_UL_SRC1_BE] = {
+		.name = "UL_SRC1_BE",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(UL_SRC1_BE),
+	},
+	[DAI_LINK_UL_SRC2_BE] = {
+		.name = "UL_SRC2_BE",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(UL_SRC2_BE),
+	},
+	/* SOF BE */
+	[DAI_LINK_SOF_DL2_BE] = {
+		.name = "AFE_SOF_DL2",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_DL2),
+	},
+	[DAI_LINK_SOF_DL3_BE] = {
+		.name = "AFE_SOF_DL3",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_DL3),
+	},
+	[DAI_LINK_SOF_UL4_BE] = {
+		.name = "AFE_SOF_UL4",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_UL4),
+	},
+	[DAI_LINK_SOF_UL5_BE] = {
+		.name = "AFE_SOF_UL5",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(AFE_SOF_UL5),
+	},
+};
+
+static struct snd_soc_codec_conf max98390_codec_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF(MAX98390_DEV0_NAME),
+		.name_prefix = "Right",
+	},
+	{
+		.dlc = COMP_CODEC_CONF(MAX98390_DEV1_NAME),
+		.name_prefix = "Left",
+	},
+};
+
+static struct snd_soc_card mt8195_mt6359_max98390_rt5682_soc_card = {
+	.name = "mt8195_m98390_r5682",
+	.owner = THIS_MODULE,
+	.dai_link = mt8195_mt6359_max98390_rt5682_dai_links,
+	.num_links = ARRAY_SIZE(mt8195_mt6359_max98390_rt5682_dai_links),
+	.controls = mt8195_mt6359_max98390_rt5682_controls,
+	.num_controls = ARRAY_SIZE(mt8195_mt6359_max98390_rt5682_controls),
+	.dapm_widgets = mt8195_mt6359_max98390_rt5682_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8195_mt6359_max98390_rt5682_widgets),
+	.dapm_routes = mt8195_mt6359_max98390_rt5682_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_max98390_rt5682_routes),
+	.codec_conf = max98390_codec_conf,
+	.num_configs = ARRAY_SIZE(max98390_codec_conf),
+	.set_bias_level_post = mt8195_set_bias_level_post,
+};
+
+static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
+				   const char *propname)
+{
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	const char *dai_name = NULL;
+	int i, j, ret, num_links;
+
+	num_links = of_property_count_strings(np, "mediatek,dai-link");
+
+	if (num_links < 0 || num_links > ARRAY_SIZE(mt8195_mt6359_max98390_rt5682_dai_links)) {
+		dev_dbg(dev, "number of dai-link is invalid\n");
+		return -EINVAL;
+	}
+
+	card->dai_link = devm_kcalloc(dev, num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links = 0;
+	link = card->dai_link;
+
+	for (i = 0; i < num_links; i++) {
+		ret = of_property_read_string_index(np, propname, i, &dai_name);
+		if (ret) {
+			dev_dbg(dev, "ASoC: Property '%s' index %d could not be read: %d\n",
+				propname, i, ret);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < ARRAY_SIZE(mt8195_mt6359_max98390_rt5682_dai_links); j++) {
+			if (!strcmp(dai_name, mt8195_mt6359_max98390_rt5682_dai_links[j].name)) {
+				memcpy(link, &mt8195_mt6359_max98390_rt5682_dai_links[j],
+				       sizeof(struct snd_soc_dai_link));
+				link++;
+				card->num_links++;
+				break;
+			}
+		}
+	}
+
+	if (card->num_links != num_links)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mt8195_mt6359_max98390_rt5682_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt8195_mt6359_max98390_rt5682_soc_card;
+	struct snd_soc_dai_link *dai_link;
+	struct mt8195_mt6359_priv *priv;
+	struct device_node *platform_node, *adsp_node, *dp_node, *hdmi_node;
+	int is5682s = 0;
+	int init6359 = 0;
+	int sof_on = 0;
+	int ret, i;
+
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret) {
+		dev_err(&pdev->dev, "%s new card name parsing error %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	if (strstr(card->name, "_5682s"))
+		is5682s = 1;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_dbg(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
+	if (adsp_node)
+		sof_on = 1;
+
+	dp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,dptx-codec", 0);
+	hdmi_node = of_parse_phandle(pdev->dev.of_node,
+				     "mediatek,hdmi-codec", 0);
+
+	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
+		ret = mt8195_dailink_parse_of(card, pdev->dev.of_node,
+					      "mediatek,dai-link");
+		if (ret) {
+			dev_dbg(&pdev->dev, "Parse dai-link fail\n");
+			return -EINVAL;
+		}
+	} else {
+		if (!sof_on)
+			card->num_links = DAI_LINK_REGULAR_NUM;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (!dai_link->platforms->name) {
+			if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && sof_on)
+				dai_link->platforms->of_node = adsp_node;
+			else
+				dai_link->platforms->of_node = platform_node;
+		}
+
+		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
+			if (!dp_node) {
+				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
+			} else {
+				dai_link->codecs->of_node = dp_node;
+				dai_link->codecs->name = NULL;
+				dai_link->codecs->dai_name = "i2s-hifi";
+				dai_link->init = mt8195_dptx_codec_init;
+			}
+		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
+			if (!hdmi_node) {
+				dev_dbg(&pdev->dev, "No property 'hdmi-codec'\n");
+			} else {
+				dai_link->codecs->of_node = hdmi_node;
+				dai_link->codecs->name = NULL;
+				dai_link->codecs->dai_name = "i2s-hifi";
+				dai_link->init = mt8195_hdmi_codec_init;
+			}
+		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
+			dai_link->codecs->name =
+				is5682s ? RT5682S_DEV0_NAME : RT5682_DEV0_NAME;
+			dai_link->codecs->dai_name =
+				is5682s ? RT5682S_CODEC_DAI : RT5682_CODEC_DAI;
+		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC1_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC2_BE") == 0) {
+			if (!init6359) {
+				dai_link->init = mt8195_mt6359_init;
+				init6359 = 1;
+			}
+		}
+	}
+
+	if (sof_on)
+		card->late_probe = mt8195_mt6359_max98390_rt5682_card_late_probe;
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+
+	of_node_put(platform_node);
+	of_node_put(adsp_node);
+	of_node_put(dp_node);
+	of_node_put(hdmi_node);
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mt8195_mt6359_max98390_rt5682_dt_match[] = {
+	{.compatible = "mediatek,mt8195_mt6359_max98390_rt5682",},
+	{}
+};
+#endif
+
+static struct platform_driver mt8195_mt6359_max98390_rt5682_driver = {
+	.driver = {
+		.name = "mt8195_mt6359_max98390_rt5682",
+#ifdef CONFIG_OF
+		.of_match_table = mt8195_mt6359_max98390_rt5682_dt_match,
+#endif
+		.pm = &mt8195_mt6359_pm_ops,
+	},
+	.probe = mt8195_mt6359_max98390_rt5682_dev_probe,
+};
+
+module_platform_driver(mt8195_mt6359_max98390_rt5682_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT8195-MT6359-MAX98390-RT5682 ALSA SoC machine driver");
+MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("mt8195_mt6359_max98390_rt5682 soc card");
-- 
2.18.0


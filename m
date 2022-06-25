Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE755AC1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiFYTJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiFYTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:09:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3B713FA1;
        Sat, 25 Jun 2022 12:09:13 -0700 (PDT)
X-UUID: 430b59ad2e3b46fea0e60640581a3ce0-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c70013c9-1855-496d-a2b6-c34ba82e9811,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:e803082e-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 430b59ad2e3b46fea0e60640581a3ce0-20220626
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1913340059; Sun, 26 Jun 2022 03:09:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 26 Jun 2022 03:09:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 03:09:06 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v8 7/8] ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and rt5682s
Date:   Sun, 26 Jun 2022 03:08:51 +0800
Message-ID: <20220625190852.29130-8-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
References: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mt8186 board with mt6366, rt1019 and rt5682s.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |  16 +
 sound/soc/mediatek/mt8186/Makefile            |   1 +
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 978 ++++++++++++++++++
 3 files changed, 995 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index cc93a0d42fe1..11da3f1b3022 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -180,6 +180,22 @@ config SND_SOC_MT8186_MT6366_DA7219_MAX98357
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT8186_MT6366_RT1019_RT5682S
+	tristate "ASoC Audio driver for MT8186 with RT1019 RT5682S codec"
+	depends on I2C && GPIOLIB
+	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
+	select SND_SOC_MT6358
+	select SND_SOC_RT1015P
+	select SND_SOC_RT5682S
+	select SND_SOC_BT_SCO
+	select SND_SOC_DMIC
+	select SND_SOC_HDMI_CODEC
+	help
+	  This adds ASoC driver for Mediatek MT8186 boards
+	  with the MT6366(MT6358) RT1019 RT5682S codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MTK_BTCVSD
 	tristate "ALSA BT SCO CVSD/MSBC Driver"
 	help
diff --git a/sound/soc/mediatek/mt8186/Makefile b/sound/soc/mediatek/mt8186/Makefile
index e7ddbe74d9d5..49b0026628a0 100644
--- a/sound/soc/mediatek/mt8186/Makefile
+++ b/sound/soc/mediatek/mt8186/Makefile
@@ -19,3 +19,4 @@ snd-soc-mt8186-afe-objs := \
 
 obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
 obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-mt6366-da7219-max98357.o
+obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-mt6366-rt1019-rt5682s.o
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
new file mode 100644
index 000000000000..091ecab9ef58
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -0,0 +1,978 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt8186-mt6366-rt1019-rt5682s.c
+//	--  MT8186-MT6366-RT1019-RT5682S ALSA SoC machine driver
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+//
+
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include <sound/rt5682.h>
+#include <sound/soc.h>
+
+#include "../../codecs/mt6358.h"
+#include "../../codecs/rt5682.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "mt8186-afe-common.h"
+#include "mt8186-afe-clk.h"
+#include "mt8186-afe-gpio.h"
+#include "mt8186-mt6366-common.h"
+
+#define RT1019_CODEC_DAI	"HiFi"
+#define RT1019_DEV0_NAME	"rt1019p"
+
+#define RT5682S_CODEC_DAI	"rt5682s-aif1"
+#define RT5682S_DEV0_NAME	"rt5682s.5-001a"
+
+struct mt8186_mt6366_rt1019_rt5682s_priv {
+	struct snd_soc_jack headset_jack, hdmi_jack;
+};
+
+static struct snd_soc_codec_conf mt8186_mt6366_rt1019_rt5682s_codec_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF("mt6358-sound"),
+		.name_prefix = "Mt6366",
+	},
+	{
+		.dlc = COMP_CODEC_CONF("bt-sco"),
+		.name_prefix = "Mt8186 bt",
+	},
+	{
+		.dlc = COMP_CODEC_CONF("hdmi-audio-codec"),
+		.name_prefix = "Mt8186 hdmi",
+	},
+};
+
+static int mt8186_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8186_mt6366_rt1019_rt5682s_priv *priv =
+		snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+				    SND_JACK_BTN_3,
+				    jack);
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
+	return snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
+}
+
+static int mt8186_rt5682s_i2s_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	unsigned int rate = params_rate(params);
+	unsigned int mclk_fs_ratio = 128;
+	unsigned int mclk_fs = rate * mclk_fs_ratio;
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
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1,
+				  RT5682_PLL1_S_BCLK1,
+				  params_rate(params) * 64,
+				  params_rate(params) * 512);
+	if (ret) {
+		dev_err(card->dev, "failed to set pll\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai,
+				     RT5682_SCLK_S_PLL1,
+				     params_rate(params) * 512,
+				     SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(card->dev, "failed to set sysclk\n");
+		return ret;
+	}
+
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, mclk_fs, SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8186_rt5682s_i2s_ops = {
+	.hw_params = mt8186_rt5682s_i2s_hw_params,
+};
+
+static int mt8186_mt6366_rt1019_rt5682s_hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	struct mt8186_mt6366_rt1019_rt5682s_priv *priv =
+		snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, &priv->hdmi_jack);
+	if (ret) {
+		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
+}
+
+static int mt8186_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				  struct snd_pcm_hw_params *params,
+				  snd_pcm_format_t fmt)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+		SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	dev_dbg(rtd->dev, "%s(), fix format to %d\n", __func__, fmt);
+
+	/* fix BE i2s channel to 2 channel */
+	channels->min = 2;
+	channels->max = 2;
+
+	/* clean param mask first */
+	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
+
+	params_set_format(params, fmt);
+
+	return 0;
+}
+
+static int mt8186_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				      struct snd_pcm_hw_params *params)
+{
+	return mt8186_hw_params_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
+}
+
+static int mt8186_it6505_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+					     struct snd_pcm_hw_params *params)
+{
+	return mt8186_hw_params_fixup(rtd, params, SNDRV_PCM_FORMAT_S32_LE);
+}
+
+static int mt8186_mt6366_rt1019_rt5682s_playback_startup(struct snd_pcm_substream *substream)
+{
+	static const unsigned int rates[] = {
+		48000
+	};
+	static const unsigned int channels[] = {
+		2
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list  = rates,
+		.mask = 0,
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_channels = {
+		.count = ARRAY_SIZE(channels),
+		.list  = channels,
+		.mask = 0,
+	};
+
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &constraints_rates);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
+		return ret;
+	}
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_CHANNELS,
+					 &constraints_channels);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8186_mt6366_rt1019_rt5682s_playback_ops = {
+	.startup = mt8186_mt6366_rt1019_rt5682s_playback_startup,
+};
+
+static int mt8186_mt6366_rt1019_rt5682s_capture_startup(struct snd_pcm_substream *substream)
+{
+	static const unsigned int rates[] = {
+		48000
+	};
+	static const unsigned int channels[] = {
+		1, 2
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list  = rates,
+		.mask = 0,
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_channels = {
+		.count = ARRAY_SIZE(channels),
+		.list  = channels,
+		.mask = 0,
+	};
+
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &constraints_rates);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
+		return ret;
+	}
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_CHANNELS,
+					 &constraints_channels);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8186_mt6366_rt1019_rt5682s_capture_ops = {
+	.startup = mt8186_mt6366_rt1019_rt5682s_capture_startup,
+};
+
+/* FE */
+SND_SOC_DAILINK_DEFS(playback1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback12,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL12")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback7,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL7")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback8,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture7,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL7")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+/* hostless */
+SND_SOC_DAILINK_DEFS(hostless_lpbk,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless LPBK DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_fm,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless FM DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_src1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_SRC_1_DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_src_bargein,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_SRC_Bargein_DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+/* BE */
+SND_SOC_DAILINK_DEFS(adda,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ADDA")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6358-sound",
+						   "mt6358-snd-codec-aif1"),
+					COMP_CODEC("dmic-codec",
+						   "dmic-hifi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2s0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2S0")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2s1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2S1")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2s2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2S2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2s3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hw_gain1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("HW Gain 1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hw_gain2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("HW Gain 2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hw_src1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("HW_SRC_1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hw_src2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("HW_SRC_2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(connsys_i2s,
+		     DAILINK_COMP_ARRAY(COMP_CPU("CONNSYS_I2S")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(pcm1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("PCM 1")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm-wb")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(tdm_in,
+		     DAILINK_COMP_ARRAY(COMP_CPU("TDM IN")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+/* hostless */
+SND_SOC_DAILINK_DEFS(hostless_ul1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_UL1 DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_ul2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_UL2 DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_ul3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_UL3 DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_ul5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_UL5 DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_ul6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless_UL6 DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_hw_gain_aaudio,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless HW Gain AAudio DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(hostless_src_aaudio,
+		     DAILINK_COMP_ARRAY(COMP_CPU("Hostless SRC AAudio DAI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
+	/* Front End DAI links */
+	{
+		.name = "Playback_1",
+		.stream_name = "Playback_1",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_merged_format = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.ops = &mt8186_mt6366_rt1019_rt5682s_playback_ops,
+		SND_SOC_DAILINK_REG(playback1),
+	},
+	{
+		.name = "Playback_12",
+		.stream_name = "Playback_12",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback12),
+	},
+	{
+		.name = "Playback_2",
+		.stream_name = "Playback_2",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_merged_format = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		SND_SOC_DAILINK_REG(playback2),
+	},
+	{
+		.name = "Playback_3",
+		.stream_name = "Playback_3",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_merged_format = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.ops = &mt8186_mt6366_rt1019_rt5682s_playback_ops,
+		SND_SOC_DAILINK_REG(playback3),
+	},
+	{
+		.name = "Playback_4",
+		.stream_name = "Playback_4",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback4),
+	},
+	{
+		.name = "Playback_5",
+		.stream_name = "Playback_5",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback5),
+	},
+	{
+		.name = "Playback_6",
+		.stream_name = "Playback_6",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback6),
+	},
+	{
+		.name = "Playback_7",
+		.stream_name = "Playback_7",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback7),
+	},
+	{
+		.name = "Playback_8",
+		.stream_name = "Playback_8",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback8),
+	},
+	{
+		.name = "Capture_1",
+		.stream_name = "Capture_1",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture1),
+	},
+	{
+		.name = "Capture_2",
+		.stream_name = "Capture_2",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.dpcm_merged_format = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.ops = &mt8186_mt6366_rt1019_rt5682s_capture_ops,
+		SND_SOC_DAILINK_REG(capture2),
+	},
+	{
+		.name = "Capture_3",
+		.stream_name = "Capture_3",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture3),
+	},
+	{
+		.name = "Capture_4",
+		.stream_name = "Capture_4",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.dpcm_merged_format = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.ops = &mt8186_mt6366_rt1019_rt5682s_capture_ops,
+		SND_SOC_DAILINK_REG(capture4),
+	},
+	{
+		.name = "Capture_5",
+		.stream_name = "Capture_5",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture5),
+	},
+	{
+		.name = "Capture_6",
+		.stream_name = "Capture_6",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.dpcm_merged_format = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		SND_SOC_DAILINK_REG(capture6),
+	},
+	{
+		.name = "Capture_7",
+		.stream_name = "Capture_7",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture7),
+	},
+	{
+		.name = "Hostless_LPBK",
+		.stream_name = "Hostless_LPBK",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_lpbk),
+	},
+	{
+		.name = "Hostless_FM",
+		.stream_name = "Hostless_FM",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_fm),
+	},
+	{
+		.name = "Hostless_SRC_1",
+		.stream_name = "Hostless_SRC_1",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_src1),
+	},
+	{
+		.name = "Hostless_SRC_Bargein",
+		.stream_name = "Hostless_SRC_Bargein",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_src_bargein),
+	},
+	{
+		.name = "Hostless_HW_Gain_AAudio",
+		.stream_name = "Hostless_HW_Gain_AAudio",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_hw_gain_aaudio),
+	},
+	{
+		.name = "Hostless_SRC_AAudio",
+		.stream_name = "Hostless_SRC_AAudio",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_src_aaudio),
+	},
+	/* Back End DAI links */
+	{
+		.name = "Primary Codec",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.init = mt8186_mt6366_init,
+		SND_SOC_DAILINK_REG(adda),
+	},
+	{
+		.name = "I2S3",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			   SND_SOC_DAIFMT_IB_IF |
+			   SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_playback = 1,
+		.ignore_suspend = 1,
+		.init = mt8186_mt6366_rt1019_rt5682s_hdmi_init,
+		.be_hw_params_fixup = mt8186_it6505_i2s_hw_params_fixup,
+		SND_SOC_DAILINK_REG(i2s3),
+	},
+	{
+		.name = "I2S0",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.be_hw_params_fixup = mt8186_i2s_hw_params_fixup,
+		.ops = &mt8186_rt5682s_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s0),
+	},
+	{
+		.name = "I2S1",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.ignore_suspend = 1,
+		.be_hw_params_fixup = mt8186_i2s_hw_params_fixup,
+		.init = mt8186_rt5682s_init,
+		.ops = &mt8186_rt5682s_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s1),
+	},
+	{
+		.name = "I2S2",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.be_hw_params_fixup = mt8186_i2s_hw_params_fixup,
+		SND_SOC_DAILINK_REG(i2s2),
+	},
+	{
+		.name = "HW Gain 1",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hw_gain1),
+	},
+	{
+		.name = "HW Gain 2",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hw_gain2),
+	},
+	{
+		.name = "HW_SRC_1",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hw_src1),
+	},
+	{
+		.name = "HW_SRC_2",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hw_src2),
+	},
+	{
+		.name = "CONNSYS_I2S",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(connsys_i2s),
+	},
+	{
+		.name = "PCM 1",
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			   SND_SOC_DAIFMT_NB_IF,
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(pcm1),
+	},
+	{
+		.name = "TDM IN",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(tdm_in),
+	},
+	/* dummy BE for ul memif to record from dl memif */
+	{
+		.name = "Hostless_UL1",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_ul1),
+	},
+	{
+		.name = "Hostless_UL2",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_ul2),
+	},
+	{
+		.name = "Hostless_UL3",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_ul3),
+	},
+	{
+		.name = "Hostless_UL5",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_ul5),
+	},
+	{
+		.name = "Hostless_UL6",
+		.no_pcm = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(hostless_ul6),
+	},
+};
+
+static const struct snd_soc_dapm_widget
+mt8186_mt6366_rt1019_rt5682s_widgets[] = {
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_OUTPUT("HDMI1"),
+};
+
+static const struct snd_soc_dapm_route
+mt8186_mt6366_rt1019_rt5682s_routes[] = {
+	/* SPK */
+	{ "Speakers", NULL, "Speaker" },
+	/* HDMI */
+	{ "HDMI1", NULL, "TX" },
+};
+
+static const struct snd_kcontrol_new
+mt8186_mt6366_rt1019_rt5682s_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("HDMI1"),
+};
+
+static struct snd_soc_card mt8186_mt6366_rt1019_rt5682s_soc_card = {
+	.name = "mt8186_mt6366_rt1019_rt5682s",
+	.owner = THIS_MODULE,
+	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
+	.num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links),
+	.controls = mt8186_mt6366_rt1019_rt5682s_controls,
+	.num_controls = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_controls),
+	.dapm_widgets = mt8186_mt6366_rt1019_rt5682s_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_widgets),
+	.dapm_routes = mt8186_mt6366_rt1019_rt5682s_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_routes),
+	.codec_conf = mt8186_mt6366_rt1019_rt5682s_codec_conf,
+	.num_configs = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_codec_conf),
+};
+
+static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card;
+	struct snd_soc_dai_link *dai_link;
+	struct mt8186_mt6366_rt1019_rt5682s_priv *priv;
+	struct device_node *platform_node, *headset_codec, *playback_codec;
+	int ret, i;
+
+	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
+	if (!card)
+		return -EINVAL;
+	card->dev = &pdev->dev;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
+	if (!platform_node) {
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
+		return ret;
+	}
+
+	playback_codec = of_get_child_by_name(pdev->dev.of_node, "playback-codecs");
+	if (!playback_codec) {
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret, "Property 'speaker-codecs' missing or invalid\n");
+		goto err_playback_codec;
+	}
+
+	headset_codec = of_get_child_by_name(pdev->dev.of_node, "headset-codec");
+	if (!headset_codec) {
+		ret = -EINVAL;
+		dev_err_probe(&pdev->dev, ret, "Property 'headset-codec' missing or invalid\n");
+		goto err_headset_codec;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		ret = mt8186_mt6366_card_set_be_link(card, dai_link, playback_codec, "I2S3");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",
+				      dai_link->name);
+			goto err_probe;
+		}
+
+		ret = mt8186_mt6366_card_set_be_link(card, dai_link, headset_codec, "I2S0");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+				      dai_link->name);
+			goto err_probe;
+		}
+
+		ret = mt8186_mt6366_card_set_be_link(card, dai_link, headset_codec, "I2S1");
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+				      dai_link->name);
+			goto err_probe;
+		}
+
+		if (!dai_link->platforms->name)
+			dai_link->platforms->of_node = platform_node;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_probe;
+	}
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = mt8186_afe_gpio_init(&pdev->dev);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);
+		goto err_probe;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);
+
+err_probe:
+	of_node_put(headset_codec);
+err_headset_codec:
+	of_node_put(playback_codec);
+err_playback_codec:
+	of_node_put(platform_node);
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id mt8186_mt6366_rt1019_rt5682s_dt_match[] = {
+	{	.compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound",
+		.data = &mt8186_mt6366_rt1019_rt5682s_soc_card,
+	},
+	{}
+};
+#endif
+
+static struct platform_driver mt8186_mt6366_rt1019_rt5682s_driver = {
+	.driver = {
+		.name = "mt8186_mt6366_rt1019_rt5682s",
+#if IS_ENABLED(CONFIG_OF)
+		.of_match_table = mt8186_mt6366_rt1019_rt5682s_dt_match,
+#endif
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = mt8186_mt6366_rt1019_rt5682s_dev_probe,
+};
+
+module_platform_driver(mt8186_mt6366_rt1019_rt5682s_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT8186-MT6366-RT1019-RT5682S ALSA SoC machine driver");
+MODULE_AUTHOR("Jiaxin Yu <jiaxin.yu@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("mt8186_mt6366_rt1019_rt5682s soc card");
-- 
2.18.0


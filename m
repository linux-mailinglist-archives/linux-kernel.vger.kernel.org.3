Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D14E4DAA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353793AbiCPGDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353766AbiCPGDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57850606E8;
        Tue, 15 Mar 2022 23:01:57 -0700 (PDT)
X-UUID: 3f29954c5e1140658e396815e50d1a36-20220316
X-UUID: 3f29954c5e1140658e396815e50d1a36-20220316
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 489622149; Wed, 16 Mar 2022 14:01:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 14:01:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 14:01:46 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <yc.hung@mediatek.com>
Subject: [PATCH v2 1/5] ASoC: mediatek: mt8195: merge machine driver
Date:   Wed, 16 Mar 2022 14:01:35 +0800
Message-ID: <20220316060139.6211-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220316060139.6211-1-trevor.wu@mediatek.com>
References: <20220316060139.6211-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because most functions can be reused in different codec combinations,
mt8195 machine drivers are combined to one common file.

The model and compatible string are used to decide which codecs are
being used.

As a result, We can prevent from copy-paste functions when new codec
combination is introduced.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |   25 +-
 sound/soc/mediatek/mt8195/Makefile            |    3 +-
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 1198 -----------------
 ...mt6359-rt1019-rt5682.c => mt8195-mt6359.c} |  918 ++++++++-----
 4 files changed, 558 insertions(+), 1586 deletions(-)
 delete mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
 rename sound/soc/mediatek/mt8195/{mt8195-mt6359-rt1019-rt5682.c => mt8195-mt6359.c} (80%)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 0d154350f180..16204a135c4d 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -198,34 +198,19 @@ config SND_SOC_MT8195
 	  Select Y if you have such device.
 	  If unsure select "N".
 
-config SND_SOC_MT8195_MT6359_RT1019_RT5682
-	tristate "ASoC Audio driver for MT8195 with MT6359 RT1019 RT5682 codec"
-	depends on I2C && GPIOLIB
-	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
-	select SND_SOC_MT6359
-	select SND_SOC_RT1015P
-	select SND_SOC_RT5682_I2C
-	select SND_SOC_RT5682S
-	select SND_SOC_DMIC
-	select SND_SOC_HDMI_CODEC
-	help
-	  This adds ASoC driver for Mediatek MT8195 boards
-	  with the MT6359 RT1019 RT5682 audio codec.
-	  Select Y if you have such device.
-	  If unsure select "N".
-
-config SND_SOC_MT8195_MT6359_RT1011_RT5682
-	tristate "ASoC Audio driver for MT8195 with MT6359 RT1011 RT5682 codec"
+config SND_SOC_MT8195_MT6359
+	tristate "ASoC Audio driver for MT8195 with MT6359 and I2S codec"
 	depends on I2C && GPIOLIB
 	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_RT1011
+	select SND_SOC_RT1015P
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_RT5682S
 	select SND_SOC_DMIC
 	select SND_SOC_HDMI_CODEC
 	help
-	  This adds ASoC driver for Mediatek MT8195 boards
-	  with the MT6359 RT1011 RT5682 audio codec.
+	  This adds support for ASoC machine driver for Mediatek MT8195
+	  boards with MT6359 and other I2S audio codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
diff --git a/sound/soc/mediatek/mt8195/Makefile b/sound/soc/mediatek/mt8195/Makefile
index e5f0df5010b6..aae673ec751b 100644
--- a/sound/soc/mediatek/mt8195/Makefile
+++ b/sound/soc/mediatek/mt8195/Makefile
@@ -12,5 +12,4 @@ snd-soc-mt8195-afe-objs := \
 obj-$(CONFIG_SND_SOC_MT8195) += snd-soc-mt8195-afe.o
 
 # machine driver
-obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1019_RT5682) += mt8195-mt6359-rt1019-rt5682.o
-obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1011_RT5682) += mt8195-mt6359-rt1011-rt5682.o
+obj-$(CONFIG_SND_SOC_MT8195_MT6359) += mt8195-mt6359.o
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
deleted file mode 100644
index 5443a29da7b1..000000000000
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ /dev/null
@@ -1,1198 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// mt8195-mt6359-rt1011-rt5682.c  --
-//	MT8195-MT6359-RT1011-RT5682 ALSA SoC machine driver
-//
-// Copyright (c) 2021 MediaTek Inc.
-// Author: Trevor Wu <trevor.wu@mediatek.com>
-//
-
-#include <linux/input.h>
-#include <linux/module.h>
-#include <linux/pm_runtime.h>
-#include <sound/jack.h>
-#include <sound/pcm_params.h>
-#include <sound/rt5682.h>
-#include <sound/soc.h>
-#include "../../codecs/mt6359.h"
-#include "../../codecs/rt1011.h"
-#include "../../codecs/rt5682.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "mt8195-afe-clk.h"
-#include "mt8195-afe-common.h"
-
-#define RT1011_CODEC_DAI	"rt1011-aif"
-#define RT1011_DEV0_NAME	"rt1011.2-0038"
-#define RT1011_DEV1_NAME	"rt1011.2-0039"
-
-#define RT5682_CODEC_DAI	"rt5682-aif1"
-#define RT5682_DEV0_NAME	"rt5682.2-001a"
-
-#define RT5682S_CODEC_DAI	"rt5682s-aif1"
-#define RT5682S_DEV0_NAME	"rt5682s.2-001a"
-
-struct mt8195_mt6359_rt1011_rt5682_priv {
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack dp_jack;
-	struct snd_soc_jack hdmi_jack;
-	struct clk *i2so1_mclk;
-};
-
-static const struct snd_soc_dapm_widget
-mt8195_mt6359_rt1011_rt5682_widgets[] = {
-	SND_SOC_DAPM_SPK("Left Speaker", NULL),
-	SND_SOC_DAPM_SPK("Right Speaker", NULL),
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-};
-
-static const struct snd_soc_dapm_route mt8195_mt6359_rt1011_rt5682_routes[] = {
-	/* speaker */
-	{ "Left Speaker", NULL, "Left SPO" },
-	{ "Right Speaker", NULL, "Right SPO" },
-	/* headset */
-	{ "Headphone Jack", NULL, "HPOL" },
-	{ "Headphone Jack", NULL, "HPOR" },
-	{ "IN1P", NULL, "Headset Mic" },
-};
-
-static const struct snd_kcontrol_new mt8195_mt6359_rt1011_rt5682_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Left Speaker"),
-	SOC_DAPM_PIN_SWITCH("Right Speaker"),
-	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-};
-
-static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	unsigned int rate = params_rate(params);
-	int bitwidth;
-	int ret;
-
-	bitwidth = snd_pcm_format_width(params_format(params));
-	if (bitwidth < 0) {
-		dev_err(card->dev, "invalid bit width: %d\n", bitwidth);
-		return bitwidth;
-	}
-
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x00, 0x0, 0x2, bitwidth);
-	if (ret) {
-		dev_err(card->dev, "failed to set tdm slot\n");
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
-				  rate * 256, rate * 512);
-	if (ret) {
-		dev_err(card->dev, "failed to set pll\n");
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
-				     rate * 512, SND_SOC_CLOCK_IN);
-	if (ret) {
-		dev_err(card->dev, "failed to set sysclk\n");
-		return ret;
-	}
-
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
-				      SND_SOC_CLOCK_OUT);
-}
-
-static const struct snd_soc_ops mt8195_rt5682_etdm_ops = {
-	.hw_params = mt8195_rt5682_etdm_hw_params,
-};
-
-static int mt8195_rt1011_etdm_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai;
-	struct snd_soc_card *card = rtd->card;
-	int srate, i, ret = 0;
-
-	srate = params_rate(params);
-
-	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1011_PLL1_S_BCLK,
-					  64 * srate, 256 * srate);
-		if (ret < 0) {
-			dev_err(card->dev, "codec_dai clock not set\n");
-			return ret;
-		}
-
-		ret = snd_soc_dai_set_sysclk(codec_dai,
-					     RT1011_FS_SYS_PRE_S_PLL1,
-					     256 * srate, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			dev_err(card->dev, "codec_dai clock not set\n");
-			return ret;
-		}
-	}
-	return ret;
-}
-
-static const struct snd_soc_ops mt8195_rt1011_etdm_ops = {
-	.hw_params = mt8195_rt1011_etdm_hw_params,
-};
-
-#define CKSYS_AUD_TOP_CFG 0x032c
-#define CKSYS_AUD_TOP_MON 0x0330
-
-static int mt8195_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_component *cmpnt_afe =
-		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtkaif_param *param = &afe_priv->mtkaif_params;
-	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
-	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
-	int test_done_1, test_done_2, test_done_3;
-	int cycle_1, cycle_2, cycle_3;
-	int mtkaif_chosen_phase[MT8195_MTKAIF_MISO_NUM];
-	int mtkaif_phase_cycle[MT8195_MTKAIF_MISO_NUM];
-	int mtkaif_calibration_num_phase;
-	bool mtkaif_calibration_ok;
-	unsigned int monitor;
-	int counter;
-	int phase;
-	int i;
-
-	dev_dbg(afe->dev, "%s(), start\n", __func__);
-
-	param->mtkaif_calibration_ok = false;
-	for (i = 0; i < MT8195_MTKAIF_MISO_NUM; i++) {
-		param->mtkaif_chosen_phase[i] = -1;
-		param->mtkaif_phase_cycle[i] = 0;
-		mtkaif_chosen_phase[i] = -1;
-		mtkaif_phase_cycle[i] = 0;
-	}
-
-	if (IS_ERR(afe_priv->topckgen)) {
-		dev_info(afe->dev, "%s() Cannot find topckgen controller\n",
-			 __func__);
-		return 0;
-	}
-
-	pm_runtime_get_sync(afe->dev);
-	mt6359_mtkaif_calibration_enable(cmpnt_codec);
-
-	/* set test type to synchronizer pulse */
-	regmap_update_bits(afe_priv->topckgen,
-			   CKSYS_AUD_TOP_CFG, 0xffff, 0x4);
-	mtkaif_calibration_num_phase = 42;	/* mt6359: 0 ~ 42 */
-	mtkaif_calibration_ok = true;
-
-	for (phase = 0;
-	     phase <= mtkaif_calibration_num_phase && mtkaif_calibration_ok;
-	     phase++) {
-		mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
-						    phase, phase, phase);
-
-		regmap_update_bits(afe_priv->topckgen,
-				   CKSYS_AUD_TOP_CFG, 0x1, 0x1);
-
-		test_done_1 = 0;
-		test_done_2 = 0;
-		test_done_3 = 0;
-		cycle_1 = -1;
-		cycle_2 = -1;
-		cycle_3 = -1;
-		counter = 0;
-		while (!(test_done_1 & test_done_2 & test_done_3)) {
-			regmap_read(afe_priv->topckgen,
-				    CKSYS_AUD_TOP_MON, &monitor);
-			test_done_1 = (monitor >> 28) & 0x1;
-			test_done_2 = (monitor >> 29) & 0x1;
-			test_done_3 = (monitor >> 30) & 0x1;
-			if (test_done_1 == 1)
-				cycle_1 = monitor & 0xf;
-
-			if (test_done_2 == 1)
-				cycle_2 = (monitor >> 4) & 0xf;
-
-			if (test_done_3 == 1)
-				cycle_3 = (monitor >> 8) & 0xf;
-
-			/* handle if never test done */
-			if (++counter > 10000) {
-				dev_info(afe->dev, "%s(), test fail, cycle_1 %d, cycle_2 %d, cycle_3 %d, monitor 0x%x\n",
-					 __func__,
-					 cycle_1, cycle_2, cycle_3, monitor);
-				mtkaif_calibration_ok = false;
-				break;
-			}
-		}
-
-		if (phase == 0) {
-			prev_cycle_1 = cycle_1;
-			prev_cycle_2 = cycle_2;
-			prev_cycle_3 = cycle_3;
-		}
-
-		if (cycle_1 != prev_cycle_1 &&
-		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] < 0) {
-			mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] = phase - 1;
-			mtkaif_phase_cycle[MT8195_MTKAIF_MISO_0] = prev_cycle_1;
-		}
-
-		if (cycle_2 != prev_cycle_2 &&
-		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] < 0) {
-			mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] = phase - 1;
-			mtkaif_phase_cycle[MT8195_MTKAIF_MISO_1] = prev_cycle_2;
-		}
-
-		if (cycle_3 != prev_cycle_3 &&
-		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] < 0) {
-			mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] = phase - 1;
-			mtkaif_phase_cycle[MT8195_MTKAIF_MISO_2] = prev_cycle_3;
-		}
-
-		regmap_update_bits(afe_priv->topckgen,
-				   CKSYS_AUD_TOP_CFG, 0x1, 0x0);
-
-		if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] >= 0 &&
-		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] >= 0 &&
-		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] >= 0)
-			break;
-	}
-
-	if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] < 0) {
-		mtkaif_calibration_ok = false;
-		chosen_phase_1 = 0;
-	} else {
-		chosen_phase_1 = mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0];
-	}
-
-	if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] < 0) {
-		mtkaif_calibration_ok = false;
-		chosen_phase_2 = 0;
-	} else {
-		chosen_phase_2 = mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1];
-	}
-
-	if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] < 0) {
-		mtkaif_calibration_ok = false;
-		chosen_phase_3 = 0;
-	} else {
-		chosen_phase_3 = mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2];
-	}
-
-	mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
-					    chosen_phase_1,
-					    chosen_phase_2,
-					    chosen_phase_3);
-
-	mt6359_mtkaif_calibration_disable(cmpnt_codec);
-	pm_runtime_put(afe->dev);
-
-	param->mtkaif_calibration_ok = mtkaif_calibration_ok;
-	param->mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] = chosen_phase_1;
-	param->mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] = chosen_phase_2;
-	param->mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] = chosen_phase_3;
-	for (i = 0; i < MT8195_MTKAIF_MISO_NUM; i++)
-		param->mtkaif_phase_cycle[i] = mtkaif_phase_cycle[i];
-
-	dev_info(afe->dev, "%s(), end, calibration ok %d\n",
-		 __func__, param->mtkaif_calibration_ok);
-
-	return 0;
-}
-
-static int mt8195_mt6359_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-
-	/* set mtkaif protocol */
-	mt6359_set_mtkaif_protocol(cmpnt_codec,
-				   MT6359_MTKAIF_PROTOCOL_2_CLK_P2);
-
-	/* mtkaif calibration */
-	mt8195_mt6359_mtkaif_calibration(rtd);
-
-	return 0;
-}
-
-static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_jack *jack = &priv->headset_jack;
-	struct snd_soc_component *cmpnt_afe =
-		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	int ret;
-
-	priv->i2so1_mclk = afe_priv->clk[MT8195_CLK_TOP_APLL12_DIV2];
-
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3,
-				    jack, NULL, 0);
-	if (ret) {
-		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
-		return ret;
-	}
-
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
-
-	ret = snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
-	if (ret) {
-		dev_err(rtd->dev, "Headset Jack set failed: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-};
-
-static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				       struct snd_pcm_hw_params *params)
-{
-	/* fix BE i2s format to S24_LE, clean param mask first */
-	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
-
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
-
-	return 0;
-}
-
-static int mt8195_hdmitx_dptx_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int rates[] = {
-		48000
-	};
-	static const unsigned int channels[] = {
-		2, 4, 6, 8
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list  = channels,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops = {
-	.startup = mt8195_hdmitx_dptx_startup,
-};
-
-static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, params_rate(params) * 256,
-				      SND_SOC_CLOCK_OUT);
-}
-
-static const struct snd_soc_ops mt8195_dptx_ops = {
-	.hw_params = mt8195_dptx_hw_params,
-};
-
-static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-	int ret;
-
-	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-				    &priv->dp_jack, NULL, 0);
-	if (ret)
-		return ret;
-
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->dp_jack, NULL);
-}
-
-static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-	int ret;
-
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
-	if (ret)
-		return ret;
-
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
-}
-
-static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				       struct snd_pcm_hw_params *params)
-
-{
-	/* fix BE i2s format to S24_LE, clean param mask first */
-	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
-
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
-
-	return 0;
-}
-
-static int mt8195_playback_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int rates[] = {
-		48000
-	};
-	static const unsigned int channels[] = {
-		2
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list  = channels,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8195_playback_ops = {
-	.startup = mt8195_playback_startup,
-};
-
-static int mt8195_capture_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int rates[] = {
-		48000
-	};
-	static const unsigned int channels[] = {
-		1, 2
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list  = channels,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8195_capture_ops = {
-	.startup = mt8195_capture_startup,
-};
-
-static int mt8195_set_bias_level_post(struct snd_soc_card *card,
-	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
-{
-	struct snd_soc_component *component = dapm->component;
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(card);
-	int ret;
-
-	/*
-	 * It's required to control mclk directly in the set_bias_level_post
-	 * function for rt5682 and rt5682s codec, or the unexpected pop happens
-	 * at the end of playback.
-	 */
-	if (!component ||
-	    (strcmp(component->name, RT5682_DEV0_NAME) &&
-	    strcmp(component->name, RT5682S_DEV0_NAME)))
-		return 0;
-
-	switch (level) {
-	case SND_SOC_BIAS_OFF:
-		if (!__clk_is_enabled(priv->i2so1_mclk))
-			return 0;
-
-		clk_disable_unprepare(priv->i2so1_mclk);
-		dev_dbg(card->dev, "Disable i2so1 mclk\n");
-		break;
-	case SND_SOC_BIAS_ON:
-		ret = clk_prepare_enable(priv->i2so1_mclk);
-		if (ret) {
-			dev_err(card->dev, "Can't enable i2so1 mclk: %d\n", ret);
-			return ret;
-		}
-		dev_dbg(card->dev, "Enable i2so1 mclk\n");
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-enum {
-	DAI_LINK_DL2_FE,
-	DAI_LINK_DL3_FE,
-	DAI_LINK_DL6_FE,
-	DAI_LINK_DL7_FE,
-	DAI_LINK_DL8_FE,
-	DAI_LINK_DL10_FE,
-	DAI_LINK_DL11_FE,
-	DAI_LINK_UL1_FE,
-	DAI_LINK_UL2_FE,
-	DAI_LINK_UL3_FE,
-	DAI_LINK_UL4_FE,
-	DAI_LINK_UL5_FE,
-	DAI_LINK_UL6_FE,
-	DAI_LINK_UL8_FE,
-	DAI_LINK_UL9_FE,
-	DAI_LINK_UL10_FE,
-	DAI_LINK_DL_SRC_BE,
-	DAI_LINK_DPTX_BE,
-	DAI_LINK_ETDM1_IN_BE,
-	DAI_LINK_ETDM2_IN_BE,
-	DAI_LINK_ETDM1_OUT_BE,
-	DAI_LINK_ETDM2_OUT_BE,
-	DAI_LINK_ETDM3_OUT_BE,
-	DAI_LINK_PCM1_BE,
-	DAI_LINK_UL_SRC1_BE,
-	DAI_LINK_UL_SRC2_BE,
-};
-
-/* FE */
-SND_SOC_DAILINK_DEFS(DL2_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DL3_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DL6_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL6")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DL7_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL7")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DL8_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL8")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DL10_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL10")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DL11_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL11")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL1_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL2_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL3_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL4_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL4")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL5_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL5")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL6_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL6")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL8_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL8")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL9_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL9")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL10_FE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL10")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-/* BE */
-SND_SOC_DAILINK_DEFS(DL_SRC_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DL_SRC")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif1")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(DPTX_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("DPTX")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(ETDM1_IN_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_IN")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_IN")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_OUT")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC(RT1011_DEV0_NAME,
-						   RT1011_CODEC_DAI),
-					COMP_CODEC(RT1011_DEV1_NAME,
-						   RT1011_CODEC_DAI)),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(ETDM3_OUT_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM3_OUT")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(PCM1_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("PCM1")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL_SRC1_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC1")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif1"),
-					COMP_CODEC("dmic-codec",
-						   "dmic-hifi")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL_SRC2_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC2")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif2")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-static struct snd_soc_dai_link mt8195_mt6359_rt1011_rt5682_dai_links[] = {
-	/* FE */
-	[DAI_LINK_DL2_FE] = {
-		.name = "DL2_FE",
-		.stream_name = "DL2 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_playback_ops,
-		SND_SOC_DAILINK_REG(DL2_FE),
-	},
-	[DAI_LINK_DL3_FE] = {
-		.name = "DL3_FE",
-		.stream_name = "DL3 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_playback_ops,
-		SND_SOC_DAILINK_REG(DL3_FE),
-	},
-	[DAI_LINK_DL6_FE] = {
-		.name = "DL6_FE",
-		.stream_name = "DL6 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_playback_ops,
-		SND_SOC_DAILINK_REG(DL6_FE),
-	},
-	[DAI_LINK_DL7_FE] = {
-		.name = "DL7_FE",
-		.stream_name = "DL7 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_PRE,
-			SND_SOC_DPCM_TRIGGER_PRE,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		SND_SOC_DAILINK_REG(DL7_FE),
-	},
-	[DAI_LINK_DL8_FE] = {
-		.name = "DL8_FE",
-		.stream_name = "DL8 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_playback_ops,
-		SND_SOC_DAILINK_REG(DL8_FE),
-	},
-	[DAI_LINK_DL10_FE] = {
-		.name = "DL10_FE",
-		.stream_name = "DL10 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_hdmitx_dptx_playback_ops,
-		SND_SOC_DAILINK_REG(DL10_FE),
-	},
-	[DAI_LINK_DL11_FE] = {
-		.name = "DL11_FE",
-		.stream_name = "DL11 Playback",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_playback_ops,
-		SND_SOC_DAILINK_REG(DL11_FE),
-	},
-	[DAI_LINK_UL1_FE] = {
-		.name = "UL1_FE",
-		.stream_name = "UL1 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_PRE,
-			SND_SOC_DPCM_TRIGGER_PRE,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(UL1_FE),
-	},
-	[DAI_LINK_UL2_FE] = {
-		.name = "UL2_FE",
-		.stream_name = "UL2 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL2_FE),
-	},
-	[DAI_LINK_UL3_FE] = {
-		.name = "UL3_FE",
-		.stream_name = "UL3 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL3_FE),
-	},
-	[DAI_LINK_UL4_FE] = {
-		.name = "UL4_FE",
-		.stream_name = "UL4 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL4_FE),
-	},
-	[DAI_LINK_UL5_FE] = {
-		.name = "UL5_FE",
-		.stream_name = "UL5 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL5_FE),
-	},
-	[DAI_LINK_UL6_FE] = {
-		.name = "UL6_FE",
-		.stream_name = "UL6 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_PRE,
-			SND_SOC_DPCM_TRIGGER_PRE,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(UL6_FE),
-	},
-	[DAI_LINK_UL8_FE] = {
-		.name = "UL8_FE",
-		.stream_name = "UL8 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL8_FE),
-	},
-	[DAI_LINK_UL9_FE] = {
-		.name = "UL9_FE",
-		.stream_name = "UL9 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL9_FE),
-	},
-	[DAI_LINK_UL10_FE] = {
-		.name = "UL10_FE",
-		.stream_name = "UL10 Capture",
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST,
-			SND_SOC_DPCM_TRIGGER_POST,
-		},
-		.dynamic = 1,
-		.dpcm_capture = 1,
-		.ops = &mt8195_capture_ops,
-		SND_SOC_DAILINK_REG(UL10_FE),
-	},
-	/* BE */
-	[DAI_LINK_DL_SRC_BE] = {
-		.name = "DL_SRC_BE",
-		.init = mt8195_mt6359_init,
-		.no_pcm = 1,
-		.dpcm_playback = 1,
-		SND_SOC_DAILINK_REG(DL_SRC_BE),
-	},
-	[DAI_LINK_DPTX_BE] = {
-		.name = "DPTX_BE",
-		.no_pcm = 1,
-		.dpcm_playback = 1,
-		.ops = &mt8195_dptx_ops,
-		.be_hw_params_fixup = mt8195_dptx_hw_params_fixup,
-		SND_SOC_DAILINK_REG(DPTX_BE),
-	},
-	[DAI_LINK_ETDM1_IN_BE] = {
-		.name = "ETDM1_IN_BE",
-		.no_pcm = 1,
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(ETDM1_IN_BE),
-	},
-	[DAI_LINK_ETDM2_IN_BE] = {
-		.name = "ETDM2_IN_BE",
-		.no_pcm = 1,
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_capture = 1,
-		.init = mt8195_rt5682_init,
-		.ops = &mt8195_rt5682_etdm_ops,
-		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
-		SND_SOC_DAILINK_REG(ETDM2_IN_BE),
-	},
-	[DAI_LINK_ETDM1_OUT_BE] = {
-		.name = "ETDM1_OUT_BE",
-		.no_pcm = 1,
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_playback = 1,
-		.ops = &mt8195_rt5682_etdm_ops,
-		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
-		SND_SOC_DAILINK_REG(ETDM1_OUT_BE),
-	},
-	[DAI_LINK_ETDM2_OUT_BE] = {
-		.name = "ETDM2_OUT_BE",
-		.no_pcm = 1,
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_playback = 1,
-		.ops = &mt8195_rt1011_etdm_ops,
-		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
-		SND_SOC_DAILINK_REG(ETDM2_OUT_BE),
-	},
-	[DAI_LINK_ETDM3_OUT_BE] = {
-		.name = "ETDM3_OUT_BE",
-		.no_pcm = 1,
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_playback = 1,
-		SND_SOC_DAILINK_REG(ETDM3_OUT_BE),
-	},
-	[DAI_LINK_PCM1_BE] = {
-		.name = "PCM1_BE",
-		.no_pcm = 1,
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_playback = 1,
-		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(PCM1_BE),
-	},
-	[DAI_LINK_UL_SRC1_BE] = {
-		.name = "UL_SRC1_BE",
-		.no_pcm = 1,
-		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(UL_SRC1_BE),
-	},
-	[DAI_LINK_UL_SRC2_BE] = {
-		.name = "UL_SRC2_BE",
-		.no_pcm = 1,
-		.dpcm_capture = 1,
-		SND_SOC_DAILINK_REG(UL_SRC2_BE),
-	},
-};
-
-static struct snd_soc_codec_conf rt1011_amp_conf[] = {
-	{
-		.dlc = COMP_CODEC_CONF(RT1011_DEV0_NAME),
-		.name_prefix = "Left",
-	},
-	{
-		.dlc = COMP_CODEC_CONF(RT1011_DEV1_NAME),
-		.name_prefix = "Right",
-	},
-};
-
-static struct snd_soc_card mt8195_mt6359_rt1011_rt5682_soc_card = {
-	.name = "mt8195_r1011_5682",
-	.owner = THIS_MODULE,
-	.dai_link = mt8195_mt6359_rt1011_rt5682_dai_links,
-	.num_links = ARRAY_SIZE(mt8195_mt6359_rt1011_rt5682_dai_links),
-	.controls = mt8195_mt6359_rt1011_rt5682_controls,
-	.num_controls = ARRAY_SIZE(mt8195_mt6359_rt1011_rt5682_controls),
-	.dapm_widgets = mt8195_mt6359_rt1011_rt5682_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mt8195_mt6359_rt1011_rt5682_widgets),
-	.dapm_routes = mt8195_mt6359_rt1011_rt5682_routes,
-	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1011_rt5682_routes),
-	.codec_conf = rt1011_amp_conf,
-	.num_configs = ARRAY_SIZE(rt1011_amp_conf),
-	.set_bias_level_post = mt8195_set_bias_level_post,
-};
-
-static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &mt8195_mt6359_rt1011_rt5682_soc_card;
-	struct snd_soc_dai_link *dai_link;
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv;
-	struct device_node *platform_node, *dp_node, *hdmi_node;
-	int is5682s = 0;
-	int ret, i;
-
-	card->dev = &pdev->dev;
-	ret = snd_soc_of_parse_card_name(card, "model");
-	if (ret) {
-		dev_err(&pdev->dev, "%s new card name parsing error %d\n",
-			__func__, ret);
-		return ret;
-	}
-
-	if (strstr(card->name, "_5682s"))
-		is5682s = 1;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	platform_node = of_parse_phandle(pdev->dev.of_node,
-					 "mediatek,platform", 0);
-	if (!platform_node) {
-		dev_dbg(&pdev->dev, "Property 'platform' missing or invalid\n");
-		return -EINVAL;
-	}
-
-	dp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,dptx-codec", 0);
-	hdmi_node = of_parse_phandle(pdev->dev.of_node,
-				     "mediatek,hdmi-codec", 0);
-
-	for_each_card_prelinks(card, i, dai_link) {
-		if (!dai_link->platforms->name)
-			dai_link->platforms->of_node = platform_node;
-
-		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
-			if (!dp_node) {
-				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
-			} else {
-				dai_link->codecs->of_node = dp_node;
-				dai_link->codecs->name = NULL;
-				dai_link->codecs->dai_name = "i2s-hifi";
-				dai_link->init = mt8195_dptx_codec_init;
-			}
-		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
-			if (!hdmi_node) {
-				dev_dbg(&pdev->dev, "No property 'hdmi-codec'\n");
-			} else {
-				dai_link->codecs->of_node = hdmi_node;
-				dai_link->codecs->name = NULL;
-				dai_link->codecs->dai_name = "i2s-hifi";
-				dai_link->init = mt8195_hdmi_codec_init;
-			}
-		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0 ||
-			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
-			dai_link->codecs->name =
-				is5682s ? RT5682S_DEV0_NAME : RT5682_DEV0_NAME;
-			dai_link->codecs->dai_name =
-				is5682s ? RT5682S_CODEC_DAI : RT5682_CODEC_DAI;
-		}
-	}
-
-	snd_soc_card_set_drvdata(card, priv);
-
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-
-	of_node_put(platform_node);
-	of_node_put(dp_node);
-	of_node_put(hdmi_node);
-	return ret;
-}
-
-#ifdef CONFIG_OF
-static const struct of_device_id mt8195_mt6359_rt1011_rt5682_dt_match[] = {
-	{.compatible = "mediatek,mt8195_mt6359_rt1011_rt5682",},
-	{}
-};
-#endif
-
-static const struct dev_pm_ops mt8195_mt6359_rt1011_rt5682_pm_ops = {
-	.poweroff = snd_soc_poweroff,
-	.restore = snd_soc_resume,
-};
-
-static struct platform_driver mt8195_mt6359_rt1011_rt5682_driver = {
-	.driver = {
-		.name = "mt8195_mt6359_rt1011_rt5682",
-#ifdef CONFIG_OF
-		.of_match_table = mt8195_mt6359_rt1011_rt5682_dt_match,
-#endif
-		.pm = &mt8195_mt6359_rt1011_rt5682_pm_ops,
-	},
-	.probe = mt8195_mt6359_rt1011_rt5682_dev_probe,
-};
-
-module_platform_driver(mt8195_mt6359_rt1011_rt5682_driver);
-
-/* Module information */
-MODULE_DESCRIPTION("MT8195-MT6359-RT1011-RT5682 ALSA SoC machine driver");
-MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("mt8195_mt6359_rt1011_rt5682 soc card");
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
similarity index 80%
rename from sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
rename to sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 29c2d3407cc7..544e99c83f3f 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1,27 +1,54 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * mt8195-mt6359-rt1019-rt5682.c  --
- *	MT8195-MT6359-RT1019-RT5682 ALSA SoC machine driver
+ * mt8195-mt6359.c  --
+ *	MT8195-MT6359 ALSA SoC machine driver code
  *
- * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2022 MediaTek Inc.
  * Author: Trevor Wu <trevor.wu@mediatek.com>
  *	   YC Hung <yc.hung@mediatek.com>
  */
 
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include <sound/rt5682.h>
-#include <sound/sof.h>
 #include <sound/soc.h>
 #include "../../codecs/mt6359.h"
+#include "../../codecs/rt1011.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
 
+struct mt8195_mt6359_priv {
+	struct snd_soc_jack headset_jack;
+	struct snd_soc_jack dp_jack;
+	struct snd_soc_jack hdmi_jack;
+	struct clk *i2so1_mclk;
+};
+
+struct mt8195_card_data {
+	const char *name;
+	unsigned long quirk;
+};
+
+struct sof_conn_stream {
+	const char *normal_link;
+	const char *sof_link;
+	const char *sof_dma;
+	int stream_dir;
+};
+
+#define RT1011_SPEAKER_AMP_PRESENT		BIT(0)
+#define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
+
+#define RT1011_CODEC_DAI	"rt1011-aif"
+#define RT1011_DEV0_NAME	"rt1011.2-0038"
+#define RT1011_DEV1_NAME	"rt1011.2-0039"
+
 #define RT1019_CODEC_DAI	"HiFi"
 #define RT1019_DEV0_NAME	"rt1019p"
 
@@ -36,23 +63,7 @@
 #define SOF_DMA_UL4 "SOF_DMA_UL4"
 #define SOF_DMA_UL5 "SOF_DMA_UL5"
 
-struct sof_conn_stream {
-	const char *normal_link;
-	const char *sof_link;
-	const char *sof_dma;
-	int stream_dir;
-};
-
-struct mt8195_mt6359_rt1019_rt5682_priv {
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack dp_jack;
-	struct snd_soc_jack hdmi_jack;
-	struct clk *i2so1_mclk;
-};
-
-static const struct snd_soc_dapm_widget
-	mt8195_mt6359_rt1019_rt5682_widgets[] = {
-	SND_SOC_DAPM_SPK("Speakers", NULL),
+static const struct snd_soc_dapm_widget mt8195_mt6359_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -61,9 +72,12 @@ static const struct snd_soc_dapm_widget
 	SND_SOC_DAPM_MIXER(SOF_DMA_UL5, SND_SOC_NOPM, 0, 0, NULL, 0),
 };
 
-static const struct snd_soc_dapm_route mt8195_mt6359_rt1019_rt5682_routes[] = {
-	/* speaker */
-	{ "Speakers", NULL, "Speaker" },
+static const struct snd_kcontrol_new mt8195_mt6359_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_route mt8195_mt6359_routes[] = {
 	/* headset */
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
@@ -80,55 +94,31 @@ static const struct snd_soc_dapm_route mt8195_mt6359_rt1019_rt5682_routes[] = {
 	{"I021", NULL, SOF_DMA_DL3},
 };
 
-static const struct snd_kcontrol_new mt8195_mt6359_rt1019_rt5682_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Speakers"),
-	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+static const struct snd_soc_dapm_widget mt8195_dual_speaker_widgets[] = {
+	SND_SOC_DAPM_SPK("Left Speaker", NULL),
+	SND_SOC_DAPM_SPK("Right Speaker", NULL),
 };
 
-static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	unsigned int rate = params_rate(params);
-	int bitwidth;
-	int ret;
-
-	bitwidth = snd_pcm_format_width(params_format(params));
-	if (bitwidth < 0) {
-		dev_err(card->dev, "invalid bit width: %d\n", bitwidth);
-		return bitwidth;
-	}
-
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x00, 0x0, 0x2, bitwidth);
-	if (ret) {
-		dev_err(card->dev, "failed to set tdm slot\n");
-		return ret;
-	}
+static const struct snd_kcontrol_new mt8195_dual_speaker_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Left Speaker"),
+	SOC_DAPM_PIN_SWITCH("Right Speaker"),
+};
 
-	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
-				  rate * 256, rate * 512);
-	if (ret) {
-		dev_err(card->dev, "failed to set pll\n");
-		return ret;
-	}
+static const struct snd_soc_dapm_widget mt8195_speaker_widgets[] = {
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+};
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
-				     rate * 512, SND_SOC_CLOCK_IN);
-	if (ret) {
-		dev_err(card->dev, "failed to set sysclk\n");
-		return ret;
-	}
+static const struct snd_kcontrol_new mt8195_speaker_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+};
 
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
-				      SND_SOC_CLOCK_OUT);
-}
+static const struct snd_soc_dapm_route mt8195_rt1011_routes[] = {
+	{ "Left Speaker", NULL, "Left SPO" },
+	{ "Right Speaker", NULL, "Right SPO" },
+};
 
-static const struct snd_soc_ops mt8195_rt5682_etdm_ops = {
-	.hw_params = mt8195_rt5682_etdm_hw_params,
+static const struct snd_soc_dapm_route mt8195_rt1019_routes[] = {
+	{ "Speakers", NULL, "Speaker" },
 };
 
 #define CKSYS_AUD_TOP_CFG 0x032c
@@ -143,20 +133,20 @@ static int mt8195_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	struct mtkaif_param *param = &afe_priv->mtkaif_params;
-	int phase;
-	unsigned int monitor;
-	int mtkaif_calibration_num_phase;
+	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
+	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
 	int test_done_1, test_done_2, test_done_3;
 	int cycle_1, cycle_2, cycle_3;
-	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
-	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
-	int counter;
-	bool mtkaif_calibration_ok;
 	int mtkaif_chosen_phase[MT8195_MTKAIF_MISO_NUM];
 	int mtkaif_phase_cycle[MT8195_MTKAIF_MISO_NUM];
+	int mtkaif_calibration_num_phase;
+	bool mtkaif_calibration_ok;
+	unsigned int monitor;
+	int counter;
+	int phase;
 	int i;
 
-	dev_info(afe->dev, "%s(), start\n", __func__);
+	dev_dbg(afe->dev, "%s(), start\n", __func__);
 
 	param->mtkaif_calibration_ok = false;
 	for (i = 0; i < MT8195_MTKAIF_MISO_NUM; i++) {
@@ -312,46 +302,51 @@ static int mt8195_mt6359_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
+static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, params_rate(params) * 256,
+				      SND_SOC_CLOCK_OUT);
+}
+
+const struct snd_soc_ops mt8195_dptx_ops = {
+	.hw_params = mt8195_dptx_hw_params,
+};
+
+static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_jack *jack = &priv->headset_jack;
-	struct snd_soc_component *cmpnt_afe =
-		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
-	priv->i2so1_mclk = afe_priv->clk[MT8195_CLK_TOP_APLL12_DIV2];
-
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3,
-				    jack, NULL, 0);
-	if (ret) {
-		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
+	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+				    &priv->dp_jack, NULL, 0);
+	if (ret)
 		return ret;
-	}
 
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	return snd_soc_component_set_jack(cmpnt_codec, &priv->dp_jack, NULL);
+}
 
-	ret = snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
-	if (ret) {
-		dev_err(rtd->dev, "Headset Jack set failed: %d\n", ret);
+static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &priv->hdmi_jack, NULL, 0);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
-};
+	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
+}
 
-static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				       struct snd_pcm_hw_params *params)
 {
 	/* fix BE i2s format to S24_LE, clean param mask first */
@@ -405,72 +400,10 @@ static int mt8195_hdmitx_dptx_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops = {
+const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops = {
 	.startup = mt8195_hdmitx_dptx_startup,
 };
 
-static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	unsigned int rate = params_rate(params);
-	unsigned int mclk_fs_ratio = 256;
-	unsigned int mclk_fs = rate * mclk_fs_ratio;
-
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, mclk_fs,
-				      SND_SOC_CLOCK_OUT);
-}
-
-static const struct snd_soc_ops mt8195_dptx_ops = {
-	.hw_params = mt8195_dptx_hw_params,
-};
-
-static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-	int ret = 0;
-
-	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-				    &priv->dp_jack, NULL, 0);
-	if (ret)
-		return ret;
-
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->dp_jack, NULL);
-}
-
-static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_component *cmpnt_codec =
-		asoc_rtd_to_codec(rtd, 0)->component;
-	int ret = 0;
-
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
-	if (ret)
-		return ret;
-
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
-}
-
-static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				       struct snd_pcm_hw_params *params)
-
-{
-	/* fix BE i2s format to S24_LE, clean param mask first */
-	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
-			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
-
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
-
-	return 0;
-}
-
 static int mt8195_playback_startup(struct snd_pcm_substream *substream)
 {
 	static const unsigned int rates[] = {
@@ -513,7 +446,7 @@ static int mt8195_playback_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_soc_ops mt8195_playback_ops = {
+const struct snd_soc_ops mt8195_playback_ops = {
 	.startup = mt8195_playback_startup,
 };
 
@@ -559,16 +492,199 @@ static int mt8195_capture_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_soc_ops mt8195_capture_ops = {
+const struct snd_soc_ops mt8195_capture_ops = {
 	.startup = mt8195_capture_startup,
 };
 
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
+	struct snd_soc_component *cmpnt_codec = asoc_rtd_to_codec(rtd, 0)->component;
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_component *cmpnt_afe = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
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
+static int mt8195_rt1011_etdm_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_card *card = rtd->card;
+	int srate, i, ret = 0;
+
+	srate = params_rate(params);
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1011_PLL1_S_BCLK,
+					  64 * srate, 256 * srate);
+		if (ret < 0) {
+			dev_err(card->dev, "codec_dai clock not set\n");
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+					     RT1011_FS_SYS_PRE_S_PLL1,
+					     256 * srate, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "codec_dai clock not set\n");
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static const struct snd_soc_ops mt8195_rt1011_etdm_ops = {
+	.hw_params = mt8195_rt1011_etdm_hw_params,
+};
+
+static int mt8195_rt1011_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8195_dual_speaker_widgets,
+					ARRAY_SIZE(mt8195_dual_speaker_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add dapm controls, ret %d\n", ret);
+		/* Don't need to add routes if widget addition failed */
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8195_dual_speaker_controls,
+					ARRAY_SIZE(mt8195_dual_speaker_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, mt8195_rt1011_routes,
+				      ARRAY_SIZE(mt8195_rt1011_routes));
+
+	if (ret)
+		dev_err(rtd->dev, "unable to add dapm routes, ret %d\n", ret);
+
+	return ret;
+}
+
+static int mt8195_rt1019_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8195_speaker_widgets,
+					ARRAY_SIZE(mt8195_speaker_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add dapm controls, ret %d\n", ret);
+		/* Don't need to add routes if widget addition failed */
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8195_speaker_controls,
+					ARRAY_SIZE(mt8195_speaker_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, mt8195_rt1019_routes,
+				      ARRAY_SIZE(mt8195_rt1019_routes));
+
+	if (ret)
+		dev_err(rtd->dev, "unable to add dapm routes, ret %d\n", ret);
+
+	return ret;
+}
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
 static int mt8195_set_bias_level_post(struct snd_soc_card *card,
 	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
 {
 	struct snd_soc_component *component = dapm->component;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(card);
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	/*
@@ -581,7 +697,6 @@ static int mt8195_set_bias_level_post(struct snd_soc_card *card,
 	    strcmp(component->name, RT5682S_DEV0_NAME)))
 		return 0;
 
-
 	switch (level) {
 	case SND_SOC_BIAS_OFF:
 		if (!__clk_is_enabled(priv->i2so1_mclk))
@@ -753,8 +868,10 @@ SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
 
 SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_OUT")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC(RT1019_DEV0_NAME,
-						   RT1019_CODEC_DAI)),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(RT1011_DEV0_NAME,
+						   RT1011_CODEC_DAI),
+					COMP_CODEC(RT1011_DEV1_NAME,
+						   RT1011_CODEC_DAI)),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM3_OUT_BE,
@@ -767,169 +884,52 @@ SND_SOC_DAILINK_DEFS(PCM1_BE,
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-SND_SOC_DAILINK_DEFS(UL_SRC1_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC1")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif1"),
-					COMP_CODEC("dmic-codec",
-						   "dmic-hifi")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(UL_SRC2_BE,
-		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC2")),
-		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif2")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(AFE_SOF_DL2,
-		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL2")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(AFE_SOF_DL3,
-		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL3")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(AFE_SOF_UL4,
-		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL4")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(AFE_SOF_UL5,
-		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL5")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-static const struct sof_conn_stream g_sof_conn_streams[] = {
-	{ "ETDM2_OUT_BE", "AFE_SOF_DL2", SOF_DMA_DL2, SNDRV_PCM_STREAM_PLAYBACK},
-	{ "ETDM1_OUT_BE", "AFE_SOF_DL3", SOF_DMA_DL3, SNDRV_PCM_STREAM_PLAYBACK},
-	{ "UL_SRC1_BE", "AFE_SOF_UL4", SOF_DMA_UL4, SNDRV_PCM_STREAM_CAPTURE},
-	{ "ETDM2_IN_BE", "AFE_SOF_UL5", SOF_DMA_UL5, SNDRV_PCM_STREAM_CAPTURE},
-};
-
-/* fixup the BE DAI link to match any values from topology */
-static int mt8195_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
-				 struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai_link *sof_dai_link = NULL;
-	struct snd_soc_pcm_runtime *runtime;
-	struct snd_soc_dai *cpu_dai;
-	int i, j, ret = 0;
-
-	for (i = 0; i < ARRAY_SIZE(g_sof_conn_streams); i++) {
-		const struct sof_conn_stream *conn = &g_sof_conn_streams[i];
-
-		if (strcmp(rtd->dai_link->name, conn->normal_link))
-			continue;
-
-		for_each_card_rtds(card, runtime) {
-			if (strcmp(runtime->dai_link->name, conn->sof_link))
-				continue;
-
-			for_each_rtd_cpu_dais(runtime, j, cpu_dai) {
-				if (cpu_dai->stream_active[conn->stream_dir] > 0) {
-					sof_dai_link = runtime->dai_link;
-					break;
-				}
-			}
-			break;
-		}
-
-		if (sof_dai_link && sof_dai_link->be_hw_params_fixup)
-			ret = sof_dai_link->be_hw_params_fixup(runtime, params);
-
-		break;
-	}
-
-	if (!strcmp(rtd->dai_link->name, "ETDM2_IN_BE") ||
-	    !strcmp(rtd->dai_link->name, "ETDM1_OUT_BE")) {
-		mt8195_etdm_hw_params_fixup(runtime, params);
-	}
+SND_SOC_DAILINK_DEFS(UL_SRC1_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC1")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif1"),
+					COMP_CODEC("dmic-codec",
+						   "dmic-hifi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-	return ret;
-}
+SND_SOC_DAILINK_DEFS(UL_SRC2_BE,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC2")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif2")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-static int mt8195_mt6359_rt1019_rt5682_card_late_probe(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *runtime;
-	struct snd_soc_component *sof_comp = NULL;
-	int i;
+SND_SOC_DAILINK_DEFS(AFE_SOF_DL2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-	/* 1. find sof component */
-	for_each_card_rtds(card, runtime) {
-		for (i = 0; i < runtime->num_components; i++) {
-			if (!runtime->components[i]->driver->name)
-				continue;
-			if (!strcmp(runtime->components[i]->driver->name, "sof-audio-component")) {
-				sof_comp = runtime->components[i];
-				break;
-			}
-		}
-	}
+SND_SOC_DAILINK_DEFS(AFE_SOF_DL3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-	if (!sof_comp) {
-		dev_info(card->dev, " probe without component\n");
-		return 0;
-	}
-	/* 2. add route path and fixup callback */
-	for (i = 0; i < ARRAY_SIZE(g_sof_conn_streams); i++) {
-		const struct sof_conn_stream *conn = &g_sof_conn_streams[i];
-		struct snd_soc_pcm_runtime *sof_rtd = NULL;
-		struct snd_soc_pcm_runtime *normal_rtd = NULL;
-		struct snd_soc_pcm_runtime *rtd = NULL;
+SND_SOC_DAILINK_DEFS(AFE_SOF_UL4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-		for_each_card_rtds(card, rtd) {
-			if (!strcmp(rtd->dai_link->name, conn->sof_link)) {
-				sof_rtd = rtd;
-				continue;
-			}
-			if (!strcmp(rtd->dai_link->name, conn->normal_link)) {
-				normal_rtd = rtd;
-				continue;
-			}
-			if (normal_rtd && sof_rtd)
-				break;
-		}
-		if (normal_rtd && sof_rtd) {
-			int j;
-			struct snd_soc_dai *cpu_dai;
+SND_SOC_DAILINK_DEFS(AFE_SOF_UL5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-			for_each_rtd_cpu_dais(sof_rtd, j, cpu_dai) {
-				struct snd_soc_dapm_route route;
-				struct snd_soc_dapm_path *p = NULL;
-				struct snd_soc_dapm_widget *play_widget =
-					cpu_dai->playback_widget;
-				struct snd_soc_dapm_widget *cap_widget =
-					cpu_dai->capture_widget;
-				memset(&route, 0, sizeof(route));
-				if (conn->stream_dir == SNDRV_PCM_STREAM_CAPTURE &&
-				    cap_widget) {
-					snd_soc_dapm_widget_for_each_sink_path(cap_widget, p) {
-						route.source = conn->sof_dma;
-						route.sink = p->sink->name;
-						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
-					}
-				} else if (conn->stream_dir == SNDRV_PCM_STREAM_PLAYBACK &&
-						play_widget){
-					snd_soc_dapm_widget_for_each_source_path(play_widget, p) {
-						route.source = p->source->name;
-						route.sink = conn->sof_dma;
-						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
-					}
-				} else {
-					dev_err(cpu_dai->dev, "stream dir and widget not pair\n");
-				}
-			}
-			normal_rtd->dai_link->be_hw_params_fixup = mt8195_dai_link_fixup;
-		}
-	}
+/* codec */
+SND_SOC_DAILINK_DEF(rt1019_comps,
+		    DAILINK_COMP_ARRAY(COMP_CODEC(RT1019_DEV0_NAME,
+						  RT1019_CODEC_DAI)));
 
-	return 0;
-}
+SND_SOC_DAILINK_DEF(rt1011_comps,
+		    DAILINK_COMP_ARRAY(COMP_CODEC(RT1011_DEV0_NAME,
+						  RT1011_CODEC_DAI),
+				       COMP_CODEC(RT1011_DEV1_NAME,
+						  RT1011_CODEC_DAI)));
 
-static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
+static struct snd_soc_dai_link mt8195_mt6359_dai_links[] = {
 	/* FE */
 	[DAI_LINK_DL2_FE] = {
 		.name = "DL2_FE",
@@ -1123,6 +1123,7 @@ static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 	/* BE */
 	[DAI_LINK_DL_SRC_BE] = {
 		.name = "DL_SRC_BE",
+		.init = mt8195_mt6359_init,
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		SND_SOC_DAILINK_REG(DL_SRC_BE),
@@ -1234,20 +1235,145 @@ static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 	},
 };
 
-static struct snd_soc_card mt8195_mt6359_rt1019_rt5682_soc_card = {
-	.name = "mt8195_r1019_5682",
-	.owner = THIS_MODULE,
-	.dai_link = mt8195_mt6359_rt1019_rt5682_dai_links,
-	.num_links = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_dai_links),
-	.controls = mt8195_mt6359_rt1019_rt5682_controls,
-	.num_controls = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_controls),
-	.dapm_widgets = mt8195_mt6359_rt1019_rt5682_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_widgets),
-	.dapm_routes = mt8195_mt6359_rt1019_rt5682_routes,
-	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_routes),
-	.set_bias_level_post = mt8195_set_bias_level_post,
+static struct snd_soc_codec_conf rt1011_codec_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF(RT1011_DEV0_NAME),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF(RT1011_DEV1_NAME),
+		.name_prefix = "Right",
+	},
+};
+
+static const struct sof_conn_stream g_sof_conn_streams[] = {
+	{ "ETDM2_OUT_BE", "AFE_SOF_DL2", SOF_DMA_DL2, SNDRV_PCM_STREAM_PLAYBACK},
+	{ "ETDM1_OUT_BE", "AFE_SOF_DL3", SOF_DMA_DL3, SNDRV_PCM_STREAM_PLAYBACK},
+	{ "UL_SRC1_BE", "AFE_SOF_UL4", SOF_DMA_UL4, SNDRV_PCM_STREAM_CAPTURE},
+	{ "ETDM2_IN_BE", "AFE_SOF_UL5", SOF_DMA_UL5, SNDRV_PCM_STREAM_CAPTURE},
 };
 
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
+static int mt8195_mt6359_card_late_probe(struct snd_soc_card *card)
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
 static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
 				   const char *propname)
 {
@@ -1258,7 +1384,7 @@ static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node
 
 	num_links = of_property_count_strings(np, "mediatek,dai-link");
 
-	if (num_links < 0 || num_links > ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_dai_links)) {
+	if (num_links < 0 || num_links > ARRAY_SIZE(mt8195_mt6359_dai_links)) {
 		dev_dbg(dev, "number of dai-link is invalid\n");
 		return -EINVAL;
 	}
@@ -1278,9 +1404,9 @@ static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node
 			return -EINVAL;
 		}
 
-		for (j = 0; j < ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_dai_links); j++) {
-			if (!strcmp(dai_name, mt8195_mt6359_rt1019_rt5682_dai_links[j].name)) {
-				memcpy(link, &mt8195_mt6359_rt1019_rt5682_dai_links[j],
+		for (j = 0; j < ARRAY_SIZE(mt8195_mt6359_dai_links); j++) {
+			if (!strcmp(dai_name, mt8195_mt6359_dai_links[j].name)) {
+				memcpy(link, &mt8195_mt6359_dai_links[j],
 				       sizeof(struct snd_soc_dai_link));
 				link++;
 				card->num_links++;
@@ -1295,17 +1421,40 @@ static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node
 	return 0;
 }
 
-static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
+static struct snd_soc_card mt8195_mt6359_soc_card = {
+	.owner = THIS_MODULE,
+	.dai_link = mt8195_mt6359_dai_links,
+	.num_links = ARRAY_SIZE(mt8195_mt6359_dai_links),
+	.controls = mt8195_mt6359_controls,
+	.num_controls = ARRAY_SIZE(mt8195_mt6359_controls),
+	.dapm_widgets = mt8195_mt6359_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8195_mt6359_widgets),
+	.dapm_routes = mt8195_mt6359_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_routes),
+	.set_bias_level_post = mt8195_set_bias_level_post,
+};
+
+static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = &mt8195_mt6359_rt1019_rt5682_soc_card;
+	struct snd_soc_card *card = &mt8195_mt6359_soc_card;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv;
-	struct device_node *platform_node, *adsp_node, *dp_node, *hdmi_node;
+	const struct of_device_id *match;
+	struct device_node *platform_node;
+	struct device_node *adsp_node;
+	struct device_node *dp_node;
+	struct device_node *hdmi_node;
+	struct mt8195_mt6359_priv *priv;
+	struct mt8195_card_data *card_data;
 	int is5682s = 0;
 	int init6359 = 0;
 	int sof_on = 0;
 	int ret, i;
 
+	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
+	if (!match || !match->data)
+		return -EINVAL;
+
+	card_data = (struct mt8195_card_data *)match->data;
 	card->dev = &pdev->dev;
 
 	ret = snd_soc_of_parse_card_name(card, "model");
@@ -1315,6 +1464,9 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (!card->name)
+		card->name = card_data->name;
+
 	if (strstr(card->name, "_5682s"))
 		is5682s = 1;
 
@@ -1322,8 +1474,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_node = of_parse_phandle(pdev->dev.of_node,
-					 "mediatek,platform", 0);
+	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
 	if (!platform_node) {
 		dev_dbg(&pdev->dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
@@ -1334,8 +1485,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		sof_on = 1;
 
 	dp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,dptx-codec", 0);
-	hdmi_node = of_parse_phandle(pdev->dev.of_node,
-				     "mediatek,hdmi-codec", 0);
+	hdmi_node = of_parse_phandle(pdev->dev.of_node, "mediatek,hdmi-codec", 0);
 
 	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
 		ret = mt8195_dailink_parse_of(card, pdev->dev.of_node,
@@ -1388,11 +1538,30 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 				dai_link->init = mt8195_mt6359_init;
 				init6359 = 1;
 			}
+		} else if (strcmp(dai_link->name, "ETDM2_OUT_BE") == 0) {
+			switch (card_data->quirk) {
+			case RT1011_SPEAKER_AMP_PRESENT:
+				dai_link->codecs = rt1011_comps;
+				dai_link->num_codecs = ARRAY_SIZE(rt1011_comps);
+				dai_link->init = mt8195_rt1011_init;
+				dai_link->ops = &mt8195_rt1011_etdm_ops;
+				dai_link->be_hw_params_fixup = mt8195_etdm_hw_params_fixup;
+				card->codec_conf = rt1011_codec_conf;
+				card->num_configs = ARRAY_SIZE(rt1011_codec_conf);
+				break;
+			case RT1019_SPEAKER_AMP_PRESENT:
+				dai_link->codecs = rt1019_comps;
+				dai_link->num_codecs = ARRAY_SIZE(rt1019_comps);
+				dai_link->init = mt8195_rt1019_init;
+				break;
+			default:
+				break;
+			}
 		}
 	}
 
 	if (sof_on)
-		card->late_probe = mt8195_mt6359_rt1019_rt5682_card_late_probe;
+		card->late_probe = mt8195_mt6359_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, priv);
 
@@ -1405,34 +1574,51 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
+	.name = "mt8195_r1019_5682",
+	.quirk = RT1019_SPEAKER_AMP_PRESENT,
+};
+
+static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card = {
+	.name = "mt8195_r1011_5682",
+	.quirk = RT1011_SPEAKER_AMP_PRESENT,
+};
+
 #ifdef CONFIG_OF
-static const struct of_device_id mt8195_mt6359_rt1019_rt5682_dt_match[] = {
-	{.compatible = "mediatek,mt8195_mt6359_rt1019_rt5682",},
-	{}
+static const struct of_device_id mt8195_mt6359_dt_match[] = {
+	{
+		.compatible = "mediatek,mt8195_mt6359_rt1019_rt5682",
+		.data = &mt8195_mt6359_rt1019_rt5682_card,
+	},
+	{
+		.compatible = "mediatek,mt8195_mt6359_rt1011_rt5682",
+		.data = &mt8195_mt6359_rt1011_rt5682_card,
+	},
 };
 #endif
 
-static const struct dev_pm_ops mt8195_mt6359_rt1019_rt5682_pm_ops = {
+const struct dev_pm_ops mt8195_mt6359_pm_ops = {
 	.poweroff = snd_soc_poweroff,
 	.restore = snd_soc_resume,
 };
 
-static struct platform_driver mt8195_mt6359_rt1019_rt5682_driver = {
+static struct platform_driver mt8195_mt6359_driver = {
 	.driver = {
-		.name = "mt8195_mt6359_rt1019_rt5682",
+		.name = "mt8195_mt6359",
 #ifdef CONFIG_OF
-		.of_match_table = mt8195_mt6359_rt1019_rt5682_dt_match,
+		.of_match_table = mt8195_mt6359_dt_match,
 #endif
-		.pm = &mt8195_mt6359_rt1019_rt5682_pm_ops,
+		.pm = &mt8195_mt6359_pm_ops,
 	},
-	.probe = mt8195_mt6359_rt1019_rt5682_dev_probe,
+	.probe = mt8195_mt6359_dev_probe,
 };
 
-module_platform_driver(mt8195_mt6359_rt1019_rt5682_driver);
+module_platform_driver(mt8195_mt6359_driver);
 
 /* Module information */
-MODULE_DESCRIPTION("MT8195-MT6359-RT1019-RT5682 ALSA SoC machine driver");
+MODULE_DESCRIPTION("MT8195-MT6359 ALSA SoC machine driver");
 MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
 MODULE_AUTHOR("YC Hung <yc.hung@mediatek.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("mt8195_mt6359_rt1019_rt5682 soc card");
+MODULE_ALIAS("mt8195_mt6359 soc card");
+
-- 
2.18.0


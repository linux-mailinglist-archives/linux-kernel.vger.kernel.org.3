Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7F51303E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiD1Juw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348210AbiD1JhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:37:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E89548E;
        Thu, 28 Apr 2022 02:34:09 -0700 (PDT)
X-UUID: 74405bc576e946aaa745242d17488b26-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a6f305aa-7730-4a58-abc2-7c1a838a8285,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:24,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:24
X-CID-META: VersionHash:faefae9,CLOUDID:c957082f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 74405bc576e946aaa745242d17488b26-20220428
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2051117308; Thu, 28 Apr 2022 17:34:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 17:34:03 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 17:34:01 +0800
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
Subject: [v4 06/18] ASoC: mediatek: mt8186: support hw gain in platform driver
Date:   Thu, 28 Apr 2022 17:33:43 +0800
Message-ID: <20220428093355.16172-7-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8186 hw gain dai driver.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../soc/mediatek/mt8186/mt8186-dai-hw-gain.c  | 236 ++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c b/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
new file mode 100644
index 000000000000..33edd6cbde12
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI HW Gain Control
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include <linux/regmap.h>
+#include "mt8186-afe-common.h"
+#include "mt8186-interconnection.h"
+
+#define HW_GAIN_1_EN_W_NAME "HW GAIN 1 Enable"
+#define HW_GAIN_2_EN_W_NAME "HW GAIN 2 Enable"
+
+/* dai component */
+static const struct snd_kcontrol_new mtk_hw_gain1_in_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("CONNSYS_I2S_CH1 Switch", AFE_CONN13_1,
+				    I_CONNSYS_I2S_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_hw_gain1_in_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("CONNSYS_I2S_CH2 Switch", AFE_CONN14_1,
+				    I_CONNSYS_I2S_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_hw_gain2_in_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN15,
+				    I_ADDA_UL_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_hw_gain2_in_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN16,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static int mtk_hw_gain_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int gain_cur;
+	unsigned int gain_con1;
+
+	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (strcmp(w->name, HW_GAIN_1_EN_W_NAME) == 0) {
+			gain_cur = AFE_GAIN1_CUR;
+			gain_con1 = AFE_GAIN1_CON1;
+		} else {
+			gain_cur = AFE_GAIN2_CUR;
+			gain_con1 = AFE_GAIN2_CON1;
+		}
+
+		/* let hw gain ramp up, set cur gain to 0 */
+		regmap_update_bits(afe->regmap, gain_cur, AFE_GAIN1_CUR_MASK_SFT, 0);
+
+		/* set target gain to 0 */
+		regmap_update_bits(afe->regmap, gain_con1, GAIN1_TARGET_MASK_SFT, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget mtk_dai_hw_gain_widgets[] = {
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("HW_GAIN1_IN_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_hw_gain1_in_ch1_mix,
+			   ARRAY_SIZE(mtk_hw_gain1_in_ch1_mix)),
+	SND_SOC_DAPM_MIXER("HW_GAIN1_IN_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_hw_gain1_in_ch2_mix,
+			   ARRAY_SIZE(mtk_hw_gain1_in_ch2_mix)),
+	SND_SOC_DAPM_MIXER("HW_GAIN2_IN_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_hw_gain2_in_ch1_mix,
+			   ARRAY_SIZE(mtk_hw_gain2_in_ch1_mix)),
+	SND_SOC_DAPM_MIXER("HW_GAIN2_IN_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_hw_gain2_in_ch2_mix,
+			   ARRAY_SIZE(mtk_hw_gain2_in_ch2_mix)),
+
+	SND_SOC_DAPM_SUPPLY(HW_GAIN_1_EN_W_NAME,
+			    AFE_GAIN1_CON0, GAIN1_ON_SFT, 0,
+			    mtk_hw_gain_event,
+			    SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_SUPPLY(HW_GAIN_2_EN_W_NAME,
+			    AFE_GAIN2_CON0, GAIN2_ON_SFT, 0,
+			    mtk_hw_gain_event,
+			    SND_SOC_DAPM_PRE_PMU),
+
+	SND_SOC_DAPM_INPUT("HW Gain 1 Out Endpoint"),
+	SND_SOC_DAPM_INPUT("HW Gain 2 Out Endpoint"),
+	SND_SOC_DAPM_OUTPUT("HW Gain 1 In Endpoint"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_hw_gain_routes[] = {
+	{"HW Gain 1 In", NULL, "HW_GAIN1_IN_CH1"},
+	{"HW Gain 1 In", NULL, "HW_GAIN1_IN_CH2"},
+	{"HW Gain 2 In", NULL, "HW_GAIN2_IN_CH1"},
+	{"HW Gain 2 In", NULL, "HW_GAIN2_IN_CH2"},
+
+	{"HW Gain 1 In", NULL, HW_GAIN_1_EN_W_NAME},
+	{"HW Gain 1 Out", NULL, HW_GAIN_1_EN_W_NAME},
+	{"HW Gain 2 In", NULL, HW_GAIN_2_EN_W_NAME},
+	{"HW Gain 2 Out", NULL, HW_GAIN_2_EN_W_NAME},
+
+	{"HW Gain 1 In Endpoint", NULL, "HW Gain 1 In"},
+	{"HW Gain 1 Out", NULL, "HW Gain 1 Out Endpoint"},
+	{"HW Gain 2 Out", NULL, "HW Gain 2 Out Endpoint"},
+};
+
+static const struct snd_kcontrol_new mtk_hw_gain_controls[] = {
+	SOC_SINGLE("HW Gain 1 Volume", AFE_GAIN1_CON1,
+		   GAIN1_TARGET_SFT, GAIN1_TARGET_MASK, 0),
+	SOC_SINGLE("HW Gain 2 Volume", AFE_GAIN2_CON1,
+		   GAIN2_TARGET_SFT, GAIN2_TARGET_MASK, 0),
+};
+
+/* dai ops */
+static int mtk_dai_gain_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	unsigned int rate_reg = mt8186_rate_transform(afe->dev, rate, dai->id);
+
+	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d\n",
+		__func__, dai->id, substream->stream, rate);
+
+	/* rate */
+	regmap_update_bits(afe->regmap,
+			   dai->id == MT8186_DAI_HW_GAIN_1 ?
+			   AFE_GAIN1_CON0 : AFE_GAIN2_CON0,
+			   GAIN1_MODE_MASK_SFT,
+			   rate_reg << GAIN1_MODE_SFT);
+
+	/* sample per step */
+	regmap_update_bits(afe->regmap,
+			   dai->id == MT8186_DAI_HW_GAIN_1 ?
+			   AFE_GAIN1_CON0 : AFE_GAIN2_CON0,
+			   GAIN1_SAMPLE_PER_STEP_MASK_SFT,
+			   (dai->id == MT8186_DAI_HW_GAIN_1 ? 0x40 : 0x0) <<
+			   GAIN1_SAMPLE_PER_STEP_SFT);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_gain_ops = {
+	.hw_params = mtk_dai_gain_hw_params,
+};
+
+/* dai driver */
+#define MTK_HW_GAIN_RATES (SNDRV_PCM_RATE_8000_48000 |\
+			   SNDRV_PCM_RATE_88200 |\
+			   SNDRV_PCM_RATE_96000 |\
+			   SNDRV_PCM_RATE_176400 |\
+			   SNDRV_PCM_RATE_192000)
+
+#define MTK_HW_GAIN_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			     SNDRV_PCM_FMTBIT_S24_LE |\
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_gain_driver[] = {
+	{
+		.name = "HW Gain 1",
+		.id = MT8186_DAI_HW_GAIN_1,
+		.playback = {
+			.stream_name = "HW Gain 1 In",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HW_GAIN_RATES,
+			.formats = MTK_HW_GAIN_FORMATS,
+		},
+		.capture = {
+			.stream_name = "HW Gain 1 Out",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HW_GAIN_RATES,
+			.formats = MTK_HW_GAIN_FORMATS,
+		},
+		.ops = &mtk_dai_gain_ops,
+		.symmetric_rate = 1,
+		.symmetric_channels = 1,
+		.symmetric_sample_bits = 1,
+	},
+	{
+		.name = "HW Gain 2",
+		.id = MT8186_DAI_HW_GAIN_2,
+		.playback = {
+			.stream_name = "HW Gain 2 In",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HW_GAIN_RATES,
+			.formats = MTK_HW_GAIN_FORMATS,
+		},
+		.capture = {
+			.stream_name = "HW Gain 2 Out",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HW_GAIN_RATES,
+			.formats = MTK_HW_GAIN_FORMATS,
+		},
+		.ops = &mtk_dai_gain_ops,
+		.symmetric_rate = 1,
+		.symmetric_channels = 1,
+		.symmetric_sample_bits = 1,
+	},
+};
+
+int mt8186_dai_hw_gain_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_gain_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_gain_driver);
+
+	dai->controls = mtk_hw_gain_controls;
+	dai->num_controls = ARRAY_SIZE(mtk_hw_gain_controls);
+	dai->dapm_widgets = mtk_dai_hw_gain_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_hw_gain_widgets);
+	dai->dapm_routes = mtk_dai_hw_gain_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_hw_gain_routes);
+	return 0;
+}
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924251303F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiD1Juz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348209AbiD1JhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:37:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2559548B;
        Thu, 28 Apr 2022 02:34:09 -0700 (PDT)
X-UUID: 586c076a373e4c309cef496ddaaaf273-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1846bac3-5c28-459d-b09b-870286c3bbaa,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:f357082f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 586c076a373e4c309cef496ddaaaf273-20220428
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1843924892; Thu, 28 Apr 2022 17:34:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 17:34:01 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 17:34:00 +0800
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
Subject: [v4 05/18] ASoC: mediatek: mt8186: support hostless in platform driver
Date:   Thu, 28 Apr 2022 17:33:42 +0800
Message-ID: <20220428093355.16172-6-jiaxin.yu@mediatek.com>
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

Add mt8186 hostless dai driver.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../soc/mediatek/mt8186/mt8186-dai-hostless.c | 298 ++++++++++++++++++
 1 file changed, 298 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hostless.c

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-hostless.c b/sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
new file mode 100644
index 000000000000..bf0d83840cf4
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI Hostless Control
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include "mt8186-afe-common.h"
+
+static const struct snd_pcm_hardware mt8186_hostless_hardware = {
+	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_MMAP_VALID),
+	.period_bytes_min = 256,
+	.period_bytes_max = 4 * 48 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
+	.buffer_bytes_max = 4 * 48 * 1024,
+	.fifo_size = 0,
+};
+
+/* dai component */
+static const struct snd_soc_dapm_route mtk_dai_hostless_routes[] = {
+	/* Hostless ADDA Loopback */
+	{"ADDA_DL_CH1", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
+	{"ADDA_DL_CH1", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
+	{"ADDA_DL_CH2", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
+	{"ADDA_DL_CH2", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
+	{"I2S1_CH1", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
+	{"I2S1_CH2", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
+	{"I2S3_CH1", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
+	{"I2S3_CH1", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
+	{"I2S3_CH2", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
+	{"I2S3_CH2", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
+	{"Hostless LPBK UL", NULL, "ADDA_UL_Mux"},
+
+	/* Hostelss FM */
+	/* connsys_i2s to hw gain 1*/
+	{"Hostless FM UL", NULL, "Connsys I2S"},
+
+	{"HW_GAIN1_IN_CH1", "CONNSYS_I2S_CH1 Switch", "Hostless FM DL"},
+	{"HW_GAIN1_IN_CH2", "CONNSYS_I2S_CH2 Switch", "Hostless FM DL"},
+	/* hw gain to adda dl */
+	{"Hostless FM UL", NULL, "HW Gain 1 Out"},
+
+	{"ADDA_DL_CH1", "GAIN1_OUT_CH1 Switch", "Hostless FM DL"},
+	{"ADDA_DL_CH2", "GAIN1_OUT_CH2 Switch", "Hostless FM DL"},
+	/* hw gain to i2s3 */
+	{"I2S3_CH1", "GAIN1_OUT_CH1 Switch", "Hostless FM DL"},
+	{"I2S3_CH2", "GAIN1_OUT_CH2 Switch", "Hostless FM DL"},
+	/* hw gain to i2s1 */
+	{"I2S1_CH1", "GAIN1_OUT_CH1 Switch", "Hostless FM DL"},
+	{"I2S1_CH2", "GAIN1_OUT_CH2 Switch", "Hostless FM DL"},
+
+	/* Hostless_SRC */
+	{"ADDA_DL_CH1", "SRC_1_OUT_CH1 Switch", "Hostless_SRC_1_DL"},
+	{"ADDA_DL_CH2", "SRC_1_OUT_CH2 Switch", "Hostless_SRC_1_DL"},
+	{"I2S1_CH1", "SRC_1_OUT_CH1 Switch", "Hostless_SRC_1_DL"},
+	{"I2S1_CH2", "SRC_1_OUT_CH2 Switch", "Hostless_SRC_1_DL"},
+	{"I2S3_CH1", "SRC_1_OUT_CH1 Switch", "Hostless_SRC_1_DL"},
+	{"I2S3_CH2", "SRC_1_OUT_CH2 Switch", "Hostless_SRC_1_DL"},
+	{"Hostless_SRC_1_UL", NULL, "HW_SRC_1_Out"},
+
+	/* Hostless_SRC_bargein */
+	{"HW_SRC_1_IN_CH1", "I2S0_CH1 Switch", "Hostless_SRC_Bargein_DL"},
+	{"HW_SRC_1_IN_CH2", "I2S0_CH2 Switch", "Hostless_SRC_Bargein_DL"},
+	{"Hostless_SRC_Bargein_UL", NULL, "I2S0"},
+
+	/* Hostless AAudio */
+	{"Hostless HW Gain AAudio In", NULL, "HW Gain 2 In"},
+	{"Hostless SRC AAudio UL", NULL, "HW Gain 2 Out"},
+	{"HW_SRC_2_IN_CH1", "HW_GAIN2_OUT_CH1 Switch", "Hostless SRC AAudio DL"},
+	{"HW_SRC_2_IN_CH2", "HW_GAIN2_OUT_CH2 Switch", "Hostless SRC AAudio DL"},
+};
+
+/* dai ops */
+static int mtk_dai_hostless_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	snd_soc_set_runtime_hwparams(substream, &mt8186_hostless_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(afe->dev, "snd_pcm_hw_constraint_integer failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_hostless_ops = {
+	.startup = mtk_dai_hostless_startup,
+};
+
+/* dai driver */
+#define MTK_HOSTLESS_RATES (SNDRV_PCM_RATE_8000_48000 |\
+			   SNDRV_PCM_RATE_88200 |\
+			   SNDRV_PCM_RATE_96000 |\
+			   SNDRV_PCM_RATE_176400 |\
+			   SNDRV_PCM_RATE_192000)
+
+#define MTK_HOSTLESS_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			     SNDRV_PCM_FMTBIT_S24_LE |\
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_hostless_driver[] = {
+	{
+		.name = "Hostless LPBK DAI",
+		.id = MT8186_DAI_HOSTLESS_LPBK,
+		.playback = {
+			.stream_name = "Hostless LPBK DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless LPBK UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless FM DAI",
+		.id = MT8186_DAI_HOSTLESS_FM,
+		.playback = {
+			.stream_name = "Hostless FM DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless FM UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless_SRC_1_DAI",
+		.id = MT8186_DAI_HOSTLESS_SRC_1,
+		.playback = {
+			.stream_name = "Hostless_SRC_1_DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless_SRC_1_UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless_SRC_Bargein_DAI",
+		.id = MT8186_DAI_HOSTLESS_SRC_BARGEIN,
+		.playback = {
+			.stream_name = "Hostless_SRC_Bargein_DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless_SRC_Bargein_UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	/* BE dai */
+	{
+		.name = "Hostless_UL1 DAI",
+		.id = MT8186_DAI_HOSTLESS_UL1,
+		.capture = {
+			.stream_name = "Hostless_UL1 UL",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless_UL2 DAI",
+		.id = MT8186_DAI_HOSTLESS_UL2,
+		.capture = {
+			.stream_name = "Hostless_UL2 UL",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless_UL3 DAI",
+		.id = MT8186_DAI_HOSTLESS_UL3,
+		.capture = {
+			.stream_name = "Hostless_UL3 UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless_UL5 DAI",
+		.id = MT8186_DAI_HOSTLESS_UL5,
+		.capture = {
+			.stream_name = "Hostless_UL5 UL",
+			.channels_min = 1,
+			.channels_max = 12,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless_UL6 DAI",
+		.id = MT8186_DAI_HOSTLESS_UL6,
+		.capture = {
+			.stream_name = "Hostless_UL6 UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless HW Gain AAudio DAI",
+		.id = MT8186_DAI_HOSTLESS_HW_GAIN_AAUDIO,
+		.capture = {
+			.stream_name = "Hostless HW Gain AAudio In",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless SRC AAudio DAI",
+		.id = MT8186_DAI_HOSTLESS_SRC_AAUDIO,
+		.playback = {
+			.stream_name = "Hostless SRC AAudio DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless SRC AAudio UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+};
+
+int mt8186_dai_hostless_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_hostless_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_hostless_driver);
+
+	dai->dapm_routes = mtk_dai_hostless_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_hostless_routes);
+
+	return 0;
+}
-- 
2.25.1


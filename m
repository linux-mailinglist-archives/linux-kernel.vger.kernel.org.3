Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80674D10EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbiCHH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344574AbiCHHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:25:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82A3DA59;
        Mon,  7 Mar 2022 23:24:48 -0800 (PST)
X-UUID: 1ed9f421a81145fa9236311cfabe2c45-20220308
X-UUID: 1ed9f421a81145fa9236311cfabe2c45-20220308
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1476253785; Tue, 08 Mar 2022 15:24:42 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Mar 2022 15:24:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Mar
 2022 15:24:41 +0800
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
Subject: [PATCH 3/5] ASoC: mediatek: mt8195: common code for mt8195 machine driver
Date:   Tue, 8 Mar 2022 15:24:33 +0800
Message-ID: <20220308072435.22460-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220308072435.22460-1-trevor.wu@mediatek.com>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code blocks are not affected by different external codecs, so
extracting the common code to preventing from the duplicated code blocks
in different mt8195 machine drivers.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/Makefile            |  12 +-
 .../mediatek/mt8195/mt8195-mt6359-common.c    | 398 +++++++++++++++++
 .../mediatek/mt8195/mt8195-mt6359-common.h    |  30 ++
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 406 +----------------
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 409 +-----------------
 5 files changed, 452 insertions(+), 803 deletions(-)
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-common.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-common.h

diff --git a/sound/soc/mediatek/mt8195/Makefile b/sound/soc/mediatek/mt8195/Makefile
index e5f0df5010b6..d707cbd2672d 100644
--- a/sound/soc/mediatek/mt8195/Makefile
+++ b/sound/soc/mediatek/mt8195/Makefile
@@ -12,5 +12,13 @@ snd-soc-mt8195-afe-objs := \
 obj-$(CONFIG_SND_SOC_MT8195) += snd-soc-mt8195-afe.o
 
 # machine driver
-obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1019_RT5682) += mt8195-mt6359-rt1019-rt5682.o
-obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1011_RT5682) += mt8195-mt6359-rt1011-rt5682.o
+snd-soc-mt8195-rt1019-rt5682-objs := \
+	mt8195-mt6359-rt1019-rt5682.o \
+	mt8195-mt6359-common.o
+
+snd-soc-mt8195-rt1011-rt5682-objs := \
+	mt8195-mt6359-rt1011-rt5682.o \
+	mt8195-mt6359-common.o
+
+obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1019_RT5682) += snd-soc-mt8195-rt1019-rt5682.o
+obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1011_RT5682) += snd-soc-mt8195-rt1011-rt5682.o
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-common.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-common.c
new file mode 100644
index 000000000000..764d5c71acff
--- /dev/null
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-common.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt8195-mt6359-common.c  --
+ *	MT8195-MT6359 ALSA SoC machine driver common code
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#include <linux/pm_runtime.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../../codecs/mt6359.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "mt8195-afe-common.h"
+#include "mt8195-mt6359-common.h"
+
+#define CKSYS_AUD_TOP_CFG 0x032c
+#define CKSYS_AUD_TOP_MON 0x0330
+
+static int mt8195_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_afe =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
+	struct mtkaif_param *param = &afe_priv->mtkaif_params;
+	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
+	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
+	int test_done_1, test_done_2, test_done_3;
+	int cycle_1, cycle_2, cycle_3;
+	int mtkaif_chosen_phase[MT8195_MTKAIF_MISO_NUM];
+	int mtkaif_phase_cycle[MT8195_MTKAIF_MISO_NUM];
+	int mtkaif_calibration_num_phase;
+	bool mtkaif_calibration_ok;
+	unsigned int monitor;
+	int counter;
+	int phase;
+	int i;
+
+	dev_dbg(afe->dev, "%s(), start\n", __func__);
+
+	param->mtkaif_calibration_ok = false;
+	for (i = 0; i < MT8195_MTKAIF_MISO_NUM; i++) {
+		param->mtkaif_chosen_phase[i] = -1;
+		param->mtkaif_phase_cycle[i] = 0;
+		mtkaif_chosen_phase[i] = -1;
+		mtkaif_phase_cycle[i] = 0;
+	}
+
+	if (IS_ERR(afe_priv->topckgen)) {
+		dev_info(afe->dev, "%s() Cannot find topckgen controller\n",
+			 __func__);
+		return 0;
+	}
+
+	pm_runtime_get_sync(afe->dev);
+	mt6359_mtkaif_calibration_enable(cmpnt_codec);
+
+	/* set test type to synchronizer pulse */
+	regmap_update_bits(afe_priv->topckgen,
+			   CKSYS_AUD_TOP_CFG, 0xffff, 0x4);
+	mtkaif_calibration_num_phase = 42;	/* mt6359: 0 ~ 42 */
+	mtkaif_calibration_ok = true;
+
+	for (phase = 0;
+	     phase <= mtkaif_calibration_num_phase && mtkaif_calibration_ok;
+	     phase++) {
+		mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
+						    phase, phase, phase);
+
+		regmap_update_bits(afe_priv->topckgen,
+				   CKSYS_AUD_TOP_CFG, 0x1, 0x1);
+
+		test_done_1 = 0;
+		test_done_2 = 0;
+		test_done_3 = 0;
+		cycle_1 = -1;
+		cycle_2 = -1;
+		cycle_3 = -1;
+		counter = 0;
+		while (!(test_done_1 & test_done_2 & test_done_3)) {
+			regmap_read(afe_priv->topckgen,
+				    CKSYS_AUD_TOP_MON, &monitor);
+			test_done_1 = (monitor >> 28) & 0x1;
+			test_done_2 = (monitor >> 29) & 0x1;
+			test_done_3 = (monitor >> 30) & 0x1;
+			if (test_done_1 == 1)
+				cycle_1 = monitor & 0xf;
+
+			if (test_done_2 == 1)
+				cycle_2 = (monitor >> 4) & 0xf;
+
+			if (test_done_3 == 1)
+				cycle_3 = (monitor >> 8) & 0xf;
+
+			/* handle if never test done */
+			if (++counter > 10000) {
+				dev_info(afe->dev, "%s(), test fail, cycle_1 %d, cycle_2 %d, cycle_3 %d, monitor 0x%x\n",
+					 __func__,
+					 cycle_1, cycle_2, cycle_3, monitor);
+				mtkaif_calibration_ok = false;
+				break;
+			}
+		}
+
+		if (phase == 0) {
+			prev_cycle_1 = cycle_1;
+			prev_cycle_2 = cycle_2;
+			prev_cycle_3 = cycle_3;
+		}
+
+		if (cycle_1 != prev_cycle_1 &&
+		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] < 0) {
+			mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] = phase - 1;
+			mtkaif_phase_cycle[MT8195_MTKAIF_MISO_0] = prev_cycle_1;
+		}
+
+		if (cycle_2 != prev_cycle_2 &&
+		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] < 0) {
+			mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] = phase - 1;
+			mtkaif_phase_cycle[MT8195_MTKAIF_MISO_1] = prev_cycle_2;
+		}
+
+		if (cycle_3 != prev_cycle_3 &&
+		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] < 0) {
+			mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] = phase - 1;
+			mtkaif_phase_cycle[MT8195_MTKAIF_MISO_2] = prev_cycle_3;
+		}
+
+		regmap_update_bits(afe_priv->topckgen,
+				   CKSYS_AUD_TOP_CFG, 0x1, 0x0);
+
+		if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] >= 0 &&
+		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] >= 0 &&
+		    mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] >= 0)
+			break;
+	}
+
+	if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] < 0) {
+		mtkaif_calibration_ok = false;
+		chosen_phase_1 = 0;
+	} else {
+		chosen_phase_1 = mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0];
+	}
+
+	if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] < 0) {
+		mtkaif_calibration_ok = false;
+		chosen_phase_2 = 0;
+	} else {
+		chosen_phase_2 = mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1];
+	}
+
+	if (mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] < 0) {
+		mtkaif_calibration_ok = false;
+		chosen_phase_3 = 0;
+	} else {
+		chosen_phase_3 = mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2];
+	}
+
+	mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
+					    chosen_phase_1,
+					    chosen_phase_2,
+					    chosen_phase_3);
+
+	mt6359_mtkaif_calibration_disable(cmpnt_codec);
+	pm_runtime_put(afe->dev);
+
+	param->mtkaif_calibration_ok = mtkaif_calibration_ok;
+	param->mtkaif_chosen_phase[MT8195_MTKAIF_MISO_0] = chosen_phase_1;
+	param->mtkaif_chosen_phase[MT8195_MTKAIF_MISO_1] = chosen_phase_2;
+	param->mtkaif_chosen_phase[MT8195_MTKAIF_MISO_2] = chosen_phase_3;
+	for (i = 0; i < MT8195_MTKAIF_MISO_NUM; i++)
+		param->mtkaif_phase_cycle[i] = mtkaif_phase_cycle[i];
+
+	dev_info(afe->dev, "%s(), end, calibration ok %d\n",
+		 __func__, param->mtkaif_calibration_ok);
+
+	return 0;
+}
+
+int mt8195_mt6359_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+
+	/* set mtkaif protocol */
+	mt6359_set_mtkaif_protocol(cmpnt_codec,
+				   MT6359_MTKAIF_PROTOCOL_2_CLK_P2);
+
+	/* mtkaif calibration */
+	mt8195_mt6359_mtkaif_calibration(rtd);
+
+	return 0;
+}
+
+static int mt8195_hdmitx_dptx_startup(struct snd_pcm_substream *substream)
+{
+	static const unsigned int rates[] = {
+		48000
+	};
+	static const unsigned int channels[] = {
+		2, 4, 6, 8
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
+const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops = {
+	.startup = mt8195_hdmitx_dptx_startup,
+};
+
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
+int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+				    &priv->dp_jack, NULL, 0);
+	if (ret)
+		return ret;
+
+	return snd_soc_component_set_jack(cmpnt_codec, &priv->dp_jack, NULL);
+}
+
+int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &priv->hdmi_jack, NULL, 0);
+	if (ret)
+		return ret;
+
+	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
+}
+
+int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params)
+
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
+static int mt8195_playback_startup(struct snd_pcm_substream *substream)
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
+const struct snd_soc_ops mt8195_playback_ops = {
+	.startup = mt8195_playback_startup,
+};
+
+static int mt8195_capture_startup(struct snd_pcm_substream *substream)
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
+const struct snd_soc_ops mt8195_capture_ops = {
+	.startup = mt8195_capture_startup,
+};
+
+const struct dev_pm_ops mt8195_mt6359_pm_ops = {
+	.poweroff = snd_soc_poweroff,
+	.restore = snd_soc_resume,
+};
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-common.h b/sound/soc/mediatek/mt8195/mt8195-mt6359-common.h
new file mode 100644
index 000000000000..c86d0594287f
--- /dev/null
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-common.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8195-mt6359-common.h  --  Mediatek 8195 and 6359 common audio driver definitions
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#ifndef _MT_8195_6359_COMMON_H_
+#define _MT_8195_6359_COMMON_H_
+
+struct mt8195_mt6359_priv {
+	struct snd_soc_jack headset_jack;
+	struct snd_soc_jack dp_jack;
+	struct snd_soc_jack hdmi_jack;
+	struct clk *i2so1_mclk;
+};
+
+extern const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops;
+extern const struct snd_soc_ops mt8195_dptx_ops;
+extern const struct snd_soc_ops mt8195_playback_ops;
+extern const struct snd_soc_ops mt8195_capture_ops;
+extern const struct dev_pm_ops mt8195_mt6359_pm_ops;
+
+int mt8195_mt6359_init(struct snd_soc_pcm_runtime *rtd);
+int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd);
+int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd);
+int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params);
+#endif
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index 5443a29da7b1..cb2f076e06a9 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -9,17 +9,16 @@
 
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/pm_runtime.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include <sound/rt5682.h>
 #include <sound/soc.h>
-#include "../../codecs/mt6359.h"
 #include "../../codecs/rt1011.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
+#include "mt8195-mt6359-common.h"
 
 #define RT1011_CODEC_DAI	"rt1011-aif"
 #define RT1011_DEV0_NAME	"rt1011.2-0038"
@@ -31,13 +30,6 @@
 #define RT5682S_CODEC_DAI	"rt5682s-aif1"
 #define RT5682S_DEV0_NAME	"rt5682s.2-001a"
 
-struct mt8195_mt6359_rt1011_rt5682_priv {
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack dp_jack;
-	struct snd_soc_jack hdmi_jack;
-	struct clk *i2so1_mclk;
-};
-
 static const struct snd_soc_dapm_widget
 mt8195_mt6359_rt1011_rt5682_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Speaker", NULL),
@@ -141,193 +133,11 @@ static const struct snd_soc_ops mt8195_rt1011_etdm_ops = {
 	.hw_params = mt8195_rt1011_etdm_hw_params,
 };
 
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
 static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(rtd->card);
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_jack *jack = &priv->headset_jack;
 	struct snd_soc_component *cmpnt_afe =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
@@ -373,209 +183,12 @@ static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
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
 static int mt8195_set_bias_level_post(struct snd_soc_card *card,
-	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+				      struct snd_soc_dapm_context *dapm,
+				      enum snd_soc_bias_level level)
 {
 	struct snd_soc_component *component = dapm->component;
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(card);
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	/*
@@ -1094,7 +707,7 @@ static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8195_mt6359_rt1011_rt5682_soc_card;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8195_mt6359_rt1011_rt5682_priv *priv;
+	struct mt8195_mt6359_priv *priv;
 	struct device_node *platform_node, *dp_node, *hdmi_node;
 	int is5682s = 0;
 	int ret, i;
@@ -1173,18 +786,13 @@ static const struct of_device_id mt8195_mt6359_rt1011_rt5682_dt_match[] = {
 };
 #endif
 
-static const struct dev_pm_ops mt8195_mt6359_rt1011_rt5682_pm_ops = {
-	.poweroff = snd_soc_poweroff,
-	.restore = snd_soc_resume,
-};
-
 static struct platform_driver mt8195_mt6359_rt1011_rt5682_driver = {
 	.driver = {
 		.name = "mt8195_mt6359_rt1011_rt5682",
 #ifdef CONFIG_OF
 		.of_match_table = mt8195_mt6359_rt1011_rt5682_dt_match,
 #endif
-		.pm = &mt8195_mt6359_rt1011_rt5682_pm_ops,
+		.pm = &mt8195_mt6359_pm_ops,
 	},
 	.probe = mt8195_mt6359_rt1011_rt5682_dev_probe,
 };
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 29c2d3407cc7..5c6d6e51b152 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -10,17 +10,16 @@
 
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/pm_runtime.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include <sound/rt5682.h>
 #include <sound/sof.h>
 #include <sound/soc.h>
-#include "../../codecs/mt6359.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
+#include "mt8195-mt6359-common.h"
 
 #define RT1019_CODEC_DAI	"HiFi"
 #define RT1019_DEV0_NAME	"rt1019p"
@@ -43,13 +42,6 @@ struct sof_conn_stream {
 	int stream_dir;
 };
 
-struct mt8195_mt6359_rt1019_rt5682_priv {
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack dp_jack;
-	struct snd_soc_jack hdmi_jack;
-	struct clk *i2so1_mclk;
-};
-
 static const struct snd_soc_dapm_widget
 	mt8195_mt6359_rt1019_rt5682_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
@@ -131,192 +123,11 @@ static const struct snd_soc_ops mt8195_rt5682_etdm_ops = {
 	.hw_params = mt8195_rt5682_etdm_hw_params,
 };
 
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
-	int phase;
-	unsigned int monitor;
-	int mtkaif_calibration_num_phase;
-	int test_done_1, test_done_2, test_done_3;
-	int cycle_1, cycle_2, cycle_3;
-	int prev_cycle_1, prev_cycle_2, prev_cycle_3;
-	int chosen_phase_1, chosen_phase_2, chosen_phase_3;
-	int counter;
-	bool mtkaif_calibration_ok;
-	int mtkaif_chosen_phase[MT8195_MTKAIF_MISO_NUM];
-	int mtkaif_phase_cycle[MT8195_MTKAIF_MISO_NUM];
-	int i;
-
-	dev_info(afe->dev, "%s(), start\n", __func__);
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
 static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
+	struct mt8195_mt6359_priv *priv =
 		snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_jack *jack = &priv->headset_jack;
 	struct snd_soc_component *cmpnt_afe =
@@ -363,212 +174,12 @@ static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
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
 static int mt8195_set_bias_level_post(struct snd_soc_card *card,
-	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+				      struct snd_soc_dapm_context *dapm,
+				      enum snd_soc_bias_level level)
 {
 	struct snd_soc_component *component = dapm->component;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
-		snd_soc_card_get_drvdata(card);
+	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	/*
@@ -581,7 +192,6 @@ static int mt8195_set_bias_level_post(struct snd_soc_card *card,
 	    strcmp(component->name, RT5682S_DEV0_NAME)))
 		return 0;
 
-
 	switch (level) {
 	case SND_SOC_BIAS_OFF:
 		if (!__clk_is_enabled(priv->i2so1_mclk))
@@ -1299,7 +909,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8195_mt6359_rt1019_rt5682_soc_card;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8195_mt6359_rt1019_rt5682_priv *priv;
+	struct mt8195_mt6359_priv *priv;
 	struct device_node *platform_node, *adsp_node, *dp_node, *hdmi_node;
 	int is5682s = 0;
 	int init6359 = 0;
@@ -1412,18 +1022,13 @@ static const struct of_device_id mt8195_mt6359_rt1019_rt5682_dt_match[] = {
 };
 #endif
 
-static const struct dev_pm_ops mt8195_mt6359_rt1019_rt5682_pm_ops = {
-	.poweroff = snd_soc_poweroff,
-	.restore = snd_soc_resume,
-};
-
 static struct platform_driver mt8195_mt6359_rt1019_rt5682_driver = {
 	.driver = {
 		.name = "mt8195_mt6359_rt1019_rt5682",
 #ifdef CONFIG_OF
 		.of_match_table = mt8195_mt6359_rt1019_rt5682_dt_match,
 #endif
-		.pm = &mt8195_mt6359_rt1019_rt5682_pm_ops,
+		.pm = &mt8195_mt6359_pm_ops,
 	},
 	.probe = mt8195_mt6359_rt1019_rt5682_dev_probe,
 };
-- 
2.18.0


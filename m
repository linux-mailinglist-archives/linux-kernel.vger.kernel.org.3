Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2B4617B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbhK2OQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:16:32 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237385AbhK2OO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:14:28 -0500
X-UUID: 0c619df50ff74472bfafe0972f063810-20211129
X-UUID: 0c619df50ff74472bfafe0972f063810-20211129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 769237006; Mon, 29 Nov 2021 22:11:06 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 29 Nov 2021 22:11:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Nov
 2021 22:11:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Nov 2021 22:11:05 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yc.hung@mediatek.com>, <daniel.baluta@nxp.com>,
        <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 3/4] ASoC: mediatek: mt8195: add sof support on mt8195-mt6359-rt1019-rt5682
Date:   Mon, 29 Nov 2021 22:10:56 +0800
Message-ID: <20211129141057.12422-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211129141057.12422-1-trevor.wu@mediatek.com>
References: <20211129141057.12422-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch, widgets, routes and dai-link requrird by SOF are included,
and late_probe is introduced for SOF route connection.

Only when adsp phandle could be retrieved from DTS, the SOF related part
of machine driver is executed.

Additionally, supported dai-links could be specified from DTS, so that
we can disable AP side hardware controls when DSP SOF controls the same
audio FE.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Signed-off-by: YC Hung <yc.hung@mediatek.com>
---
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 317 +++++++++++++++++-
 1 file changed, 305 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 7209c70acf6e..06e60fea2ca7 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-//
-// mt8195-mt6359-rt1019-rt5682.c  --
-//	MT8195-MT6359-RT1019-RT6358 ALSA SoC machine driver
-//
-// Copyright (c) 2021 MediaTek Inc.
-// Author: Trevor Wu <trevor.wu@mediatek.com>
-//
+/*
+ * mt8195-mt6359-rt1019-rt5682.c  --
+ *	MT8195-MT6359-RT1019-RT5682 ALSA SoC machine driver
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ *	   YC Hung <yc.hung@mediatek.com>
+ */
 
 #include <linux/input.h>
 #include <linux/module.h>
@@ -13,6 +14,7 @@
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include <sound/rt5682.h>
+#include <sound/sof.h>
 #include <sound/soc.h>
 #include "../../codecs/mt6359.h"
 #include "../../codecs/rt5682.h"
@@ -28,8 +30,21 @@
 #define RT5682S_CODEC_DAI	"rt5682s-aif1"
 #define RT5682S_DEV0_NAME	"rt5682s.2-001a"
 
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
 struct mt8195_mt6359_rt1019_rt5682_priv {
 	struct device_node *platform_node;
+	struct device_node *adsp_node;
 	struct device_node *hdmi_node;
 	struct device_node *dp_node;
 	struct snd_soc_jack headset_jack;
@@ -42,6 +57,10 @@ static const struct snd_soc_dapm_widget
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_DL3, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_UL4, SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER(SOF_DMA_UL5, SND_SOC_NOPM, 0, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route mt8195_mt6359_rt1019_rt5682_routes[] = {
@@ -51,6 +70,16 @@ static const struct snd_soc_dapm_route mt8195_mt6359_rt1019_rt5682_routes[] = {
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 	{ "IN1P", NULL, "Headset Mic" },
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
 };
 
 static const struct snd_kcontrol_new mt8195_mt6359_rt1019_rt5682_controls[] = {
@@ -562,8 +591,17 @@ enum {
 	DAI_LINK_PCM1_BE,
 	DAI_LINK_UL_SRC1_BE,
 	DAI_LINK_UL_SRC2_BE,
+	DAI_LINK_REGULAR_LAST = DAI_LINK_UL_SRC2_BE,
+	DAI_LINK_SOF_START,
+	DAI_LINK_SOF_DL2_BE = DAI_LINK_SOF_START,
+	DAI_LINK_SOF_DL3_BE,
+	DAI_LINK_SOF_UL4_BE,
+	DAI_LINK_SOF_UL5_BE,
+	DAI_LINK_SOF_END = DAI_LINK_SOF_UL5_BE,
 };
 
+#define	DAI_LINK_REGULAR_NUM	(DAI_LINK_REGULAR_LAST + 1)
+
 /* FE */
 SND_SOC_DAILINK_DEFS(DL2_FE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
@@ -702,6 +740,154 @@ SND_SOC_DAILINK_DEFS(UL_SRC2_BE,
 						   "mt6359-snd-codec-aif2")),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
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
+static int mt8195_mt6359_rt1019_rt5682_card_late_probe(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *runtime;
+	struct snd_soc_component *sof_comp;
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
 static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 	/* FE */
 	[DAI_LINK_DL2_FE] = {
@@ -896,7 +1082,6 @@ static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 	/* BE */
 	[DAI_LINK_DL_SRC_BE] = {
 		.name = "DL_SRC_BE",
-		.init = mt8195_mt6359_init,
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		SND_SOC_DAILINK_REG(DL_SRC_BE),
@@ -980,6 +1165,31 @@ static struct snd_soc_dai_link mt8195_mt6359_rt1019_rt5682_dai_links[] = {
 		.dpcm_capture = 1,
 		SND_SOC_DAILINK_REG(UL_SRC2_BE),
 	},
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
 };
 
 static struct snd_soc_card mt8195_mt6359_rt1019_rt5682_soc_card = {
@@ -995,12 +1205,61 @@ static struct snd_soc_card mt8195_mt6359_rt1019_rt5682_soc_card = {
 	.num_dapm_routes = ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_routes),
 };
 
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
+	if (num_links < 0 || num_links > ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_dai_links)) {
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
+		for (j = 0; j < ARRAY_SIZE(mt8195_mt6359_rt1019_rt5682_dai_links); j++) {
+			if (!strcmp(dai_name, mt8195_mt6359_rt1019_rt5682_dai_links[j].name)) {
+				memcpy(link, &mt8195_mt6359_rt1019_rt5682_dai_links[j],
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
 static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8195_mt6359_rt1019_rt5682_soc_card;
 	struct snd_soc_dai_link *dai_link;
 	struct mt8195_mt6359_rt1019_rt5682_priv *priv;
 	int is5682s = 0;
+	int init6359 = 0;
+	int sof_on = 0;
 	int ret, i;
 
 	card->dev = &pdev->dev;
@@ -1026,15 +1285,36 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* dai link */
+	priv->adsp_node = of_parse_phandle(pdev->dev.of_node,
+					   "mediatek,adsp", 0);
+	if (priv->adsp_node)
+		sof_on = 1;
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
 	for_each_card_prelinks(card, i, dai_link) {
-		if (!dai_link->platforms->name)
-			dai_link->platforms->of_node = priv->platform_node;
+		if (!dai_link->platforms->name) {
+			if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && sof_on)
+				dai_link->platforms->of_node = priv->adsp_node;
+			else
+				dai_link->platforms->of_node = priv->platform_node;
+		}
 
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
 			priv->dp_node =
 				of_parse_phandle(pdev->dev.of_node,
 						 "mediatek,dptx-codec", 0);
-
 			if (!priv->dp_node) {
 				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
 			} else {
@@ -1061,9 +1341,19 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 				is5682s ? RT5682S_DEV0_NAME : RT5682_DEV0_NAME;
 			dai_link->codecs->dai_name =
 				is5682s ? RT5682S_CODEC_DAI : RT5682_CODEC_DAI;
+		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC1_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC2_BE") == 0) {
+			if (!init6359) {
+				dai_link->init = mt8195_mt6359_init;
+				init6359 = 1;
+			}
 		}
 	}
 
+	if (sof_on)
+		card->late_probe = mt8195_mt6359_rt1019_rt5682_card_late_probe;
+
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
@@ -1073,6 +1363,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 		of_node_put(priv->hdmi_node);
 		of_node_put(priv->dp_node);
 		of_node_put(priv->platform_node);
+		of_node_put(priv->adsp_node);
 	}
 
 	return ret;
@@ -1087,6 +1378,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_remove(struct platform_device *pdev)
 	of_node_put(priv->hdmi_node);
 	of_node_put(priv->dp_node);
 	of_node_put(priv->platform_node);
+	of_node_put(priv->adsp_node);
 
 	return 0;
 }
@@ -1120,5 +1412,6 @@ module_platform_driver(mt8195_mt6359_rt1019_rt5682_driver);
 /* Module information */
 MODULE_DESCRIPTION("MT8195-MT6359-RT1019-RT5682 ALSA SoC machine driver");
 MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("YC Hung <yc.hung@mediatek.com>");
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("mt8195_mt6359_rt1019_rt5682 soc card");
-- 
2.18.0


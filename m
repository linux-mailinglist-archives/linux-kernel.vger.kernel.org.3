Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7E575A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbiGODmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:42:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A97749E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:42:41 -0700 (PDT)
X-UUID: b5e38905d1ef4ac69d394aeccc3ee572-20220715
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:47cfd50c-044a-40df-9f73-604168719d9d,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:47cfd50c-044a-40df-9f73-604168719d9d,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:3e290b33-b9e4-42b8-b28a-6364427c76bb,C
        OID:e8a2cfcbedff,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: b5e38905d1ef4ac69d394aeccc3ee572-20220715
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1510280689; Fri, 15 Jul 2022 11:42:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 15 Jul 2022 11:42:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 15 Jul 2022 11:42:33 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <angelogioacchino.delregno@collabora.com>
CC:     <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <tzungbi@google.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8195: extract SOF common code
Date:   Fri, 15 Jul 2022 11:42:23 +0800
Message-ID: <20220715034223.3897-1-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions related to SOF can be reused in different machine drivers,
such as mt8195 or mt8186, so extract the common code to avoid duplication.

Set mtk_soc_card_data which include machine private data and SOF private
data as card drvdata, then the difference between machine private can be
ignored such as mt8195_mt6359_priv or mt8186_mt6366_priv, at the same
time the SOF related code can be reused in different machine drivers.

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/mediatek/common/Makefile            |   2 +-
 .../soc/mediatek/common/mtk-dsp-sof-common.c  | 196 +++++++++++++++
 .../soc/mediatek/common/mtk-dsp-sof-common.h  |  35 +++
 sound/soc/mediatek/common/mtk-soc-card.h      |  17 ++
 sound/soc/mediatek/mt8195/mt8195-mt6359.c     | 233 ++++--------------
 5 files changed, 300 insertions(+), 183 deletions(-)
 create mode 100644 sound/soc/mediatek/common/mtk-dsp-sof-common.c
 create mode 100644 sound/soc/mediatek/common/mtk-dsp-sof-common.h
 create mode 100644 sound/soc/mediatek/common/mtk-soc-card.h

diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index acbe01e9e928..576deb7f8cce 100644
--- a/sound/soc/mediatek/common/Makefile
+++ b/sound/soc/mediatek/common/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # platform driver
-snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
+snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o mtk-dsp-sof-common.o
 obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
 
 obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.c b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
new file mode 100644
index 000000000000..1098694f4f36
--- /dev/null
+++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mtk-dsp-sof-common.c  --  MediaTek dsp sof common ctrl
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chunxu Li <chunxu.li@mediatek.com>
+ */
+
+#include <mtk-dsp-sof-common.h>
+#include <mtk-soc-card.h>
+
+/* fixup the BE DAI link to match any values from topology */
+int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
+	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
+	int i, j, ret = 0;
+
+	for (i = 0; i < sof_priv->num_streams; i++) {
+		struct snd_soc_dai *cpu_dai;
+		struct snd_soc_pcm_runtime *runtime;
+		struct snd_soc_dai_link *sof_dai_link = NULL;
+		const struct sof_conn_stream *conn = &sof_priv->conn_streams[i];
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mtk_sof_dai_link_fixup);
+
+int mtk_sof_card_probe(struct snd_soc_card *card)
+{
+	int i;
+	struct snd_soc_dai_link *dai_link;
+
+	/* Set stream_name to help sof bind widgets */
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->no_pcm && !dai_link->stream_name && dai_link->name)
+			dai_link->stream_name = dai_link->name;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_sof_card_probe);
+
+int mtk_sof_card_late_probe(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_component *sof_comp = NULL;
+	struct mtk_soc_card_data *soc_card_data =
+		snd_soc_card_get_drvdata(card);
+	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
+	int i;
+
+	/* 1. find sof component */
+	for_each_card_rtds(card, rtd) {
+		sof_comp = snd_soc_rtdcom_lookup(rtd, "sof-audio-component");
+		if (sof_comp)
+			break;
+	}
+
+	if (!sof_comp) {
+		dev_info(card->dev, "probe without sof-audio-component\n");
+		return 0;
+	}
+
+	/* 2. add route path and fixup callback */
+	for (i = 0; i < sof_priv->num_streams; i++) {
+		const struct sof_conn_stream *conn = &sof_priv->conn_streams[i];
+		struct snd_soc_pcm_runtime *sof_rtd = NULL;
+		struct snd_soc_pcm_runtime *normal_rtd = NULL;
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
+						play_widget) {
+					snd_soc_dapm_widget_for_each_source_path(play_widget, p) {
+						route.source = p->source->name;
+						route.sink = conn->sof_dma;
+						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
+					}
+				} else {
+					dev_err(cpu_dai->dev, "stream dir and widget not pair\n");
+				}
+			}
+
+			sof_rtd->dai_link->be_hw_params_fixup =
+				sof_comp->driver->be_hw_params_fixup;
+			if (sof_priv->sof_dai_link_fixup)
+				normal_rtd->dai_link->be_hw_params_fixup =
+					sof_priv->sof_dai_link_fixup;
+			else
+				normal_rtd->dai_link->be_hw_params_fixup = mtk_sof_dai_link_fixup;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_sof_card_late_probe);
+
+int mtk_sof_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
+			     const char *propname, struct snd_soc_dai_link *pre_dai_links,
+			     int pre_num_links)
+{
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *parsed_dai_link;
+	const char *dai_name = NULL;
+	int i, j, ret, num_links, parsed_num_links = 0;
+
+	num_links = of_property_count_strings(np, "mediatek,dai-link");
+	if (num_links < 0 || num_links > card->num_links) {
+		dev_dbg(dev, "number of dai-link is invalid\n");
+		return -EINVAL;
+	}
+
+	parsed_dai_link = devm_kcalloc(dev, num_links, sizeof(*parsed_dai_link), GFP_KERNEL);
+	if (!parsed_dai_link)
+		return -ENOMEM;
+
+	for (i = 0; i < num_links; i++) {
+		ret = of_property_read_string_index(np, propname, i, &dai_name);
+		if (ret) {
+			dev_dbg(dev, "ASoC: Property '%s' index %d could not be read: %d\n",
+				propname, i, ret);
+			return ret;
+		}
+		dev_dbg(dev, "ASoC: Property get dai_name:%s\n", dai_name);
+		for (j = 0; j < pre_num_links; j++) {
+			if (!strcmp(dai_name, pre_dai_links[j].name)) {
+				memcpy(&parsed_dai_link[parsed_num_links++], &pre_dai_links[j],
+				       sizeof(struct snd_soc_dai_link));
+				break;
+			}
+		}
+	}
+
+	if (parsed_num_links != num_links)
+		return -EINVAL;
+
+	card->dai_link = parsed_dai_link;
+	card->num_links = parsed_num_links;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_sof_dailink_parse_of);
diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.h b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
new file mode 100644
index 000000000000..f02ba2ce3718
--- /dev/null
+++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mtk-dsp-sof-common.h  --  MediaTek dsp sof common definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chunxu Li <chunxu.li@mediatek.com>
+ */
+
+#ifndef _MTK_DSP_SOF_COMMON_H_
+#define _MTK_DSP_SOF_COMMON_H_
+
+#include <sound/soc.h>
+struct sof_conn_stream {
+	const char *normal_link;
+	const char *sof_link;
+	const char *sof_dma;
+	int stream_dir;
+};
+
+struct mtk_sof_priv {
+	const struct sof_conn_stream *conn_streams;
+	int num_streams;
+	int (*sof_dai_link_fixup)(struct snd_soc_pcm_runtime *rtd,
+				  struct snd_pcm_hw_params *params);
+};
+
+int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_hw_params *params);
+int mtk_sof_card_probe(struct snd_soc_card *card);
+int mtk_sof_card_late_probe(struct snd_soc_card *card);
+int mtk_sof_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
+			     const char *propname, struct snd_soc_dai_link *pre_dai_links,
+			     int pre_num_links);
+
+#endif
diff --git a/sound/soc/mediatek/common/mtk-soc-card.h b/sound/soc/mediatek/common/mtk-soc-card.h
new file mode 100644
index 000000000000..eeda79370049
--- /dev/null
+++ b/sound/soc/mediatek/common/mtk-soc-card.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mtk-soc-card.h  --  MediaTek soc card data definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chunxu Li <chunxu.li@mediatek.com>
+ */
+
+#ifndef _MTK_SOC_CARD_H_
+#define _MTK_SOC_CARD_H_
+
+struct mtk_soc_card_data {
+	void *mach_priv;
+	void *sof_priv;
+};
+
+#endif
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 54a00b0699b1..c530e3fc27e4 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -20,6 +20,8 @@
 #include "../../codecs/rt1011.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-dsp-sof-common.h"
+#include "../common/mtk-soc-card.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
 
@@ -54,13 +56,6 @@ struct mt8195_card_data {
 	unsigned long quirk;
 };
 
-struct sof_conn_stream {
-	const char *normal_link;
-	const char *sof_link;
-	const char *sof_dma;
-	int stream_dir;
-};
-
 struct mt8195_mt6359_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack dp_jack;
@@ -374,7 +369,8 @@ static const struct snd_soc_ops mt8195_dptx_ops = {
 
 static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
 	int ret;
@@ -389,7 +385,8 @@ static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
 	int ret;
@@ -555,7 +552,8 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
-	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
 	struct snd_soc_jack *jack = &priv->headset_jack;
 	struct snd_soc_component *cmpnt_afe =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
@@ -722,7 +720,8 @@ static int mt8195_set_bias_level_post(struct snd_soc_card *card,
 	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
 {
 	struct snd_soc_component *component = dapm->component;
-	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
+	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
 	int ret;
 
 	/*
@@ -1321,175 +1320,24 @@ static struct snd_soc_card mt8195_mt6359_soc_card = {
 static int mt8195_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 				 struct snd_pcm_hw_params *params)
 {
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
+	int ret;
 
-		if (sof_dai_link && sof_dai_link->be_hw_params_fixup)
-			ret = sof_dai_link->be_hw_params_fixup(runtime, params);
-
-		break;
-	}
+	ret = mtk_sof_dai_link_fixup(rtd, params);
 
 	if (!strcmp(rtd->dai_link->name, "ETDM2_IN_BE") ||
 	    !strcmp(rtd->dai_link->name, "ETDM1_OUT_BE")) {
-		mt8195_etdm_hw_params_fixup(runtime, params);
+		mt8195_etdm_hw_params_fixup(rtd, params);
 	}
 
 	return ret;
 }
 
-static int mt8195_mt6359_card_late_probe(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *runtime;
-	struct snd_soc_component *sof_comp = NULL;
-	int i;
-
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
-
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
-
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
-
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
-
-	return 0;
-}
-
-static int mt8195_dailink_parse_of(struct snd_soc_card *card, struct device_node *np,
-				   const char *propname)
-{
-	struct device *dev = card->dev;
-	struct snd_soc_dai_link *link;
-	const char *dai_name = NULL;
-	int i, j, ret, num_links;
-
-	num_links = of_property_count_strings(np, "mediatek,dai-link");
-
-	if (num_links < 0 || num_links > ARRAY_SIZE(mt8195_mt6359_dai_links)) {
-		dev_dbg(dev, "number of dai-link is invalid\n");
-		return -EINVAL;
-	}
-
-	card->dai_link = devm_kcalloc(dev, num_links, sizeof(*link), GFP_KERNEL);
-	if (!card->dai_link)
-		return -ENOMEM;
-
-	card->num_links = 0;
-	link = card->dai_link;
-
-	for (i = 0; i < num_links; i++) {
-		ret = of_property_read_string_index(np, propname, i, &dai_name);
-		if (ret) {
-			dev_dbg(dev, "ASoC: Property '%s' index %d could not be read: %d\n",
-				propname, i, ret);
-			return -EINVAL;
-		}
-
-		for (j = 0; j < ARRAY_SIZE(mt8195_mt6359_dai_links); j++) {
-			if (!strcmp(dai_name, mt8195_mt6359_dai_links[j].name)) {
-				memcpy(link, &mt8195_mt6359_dai_links[j],
-				       sizeof(struct snd_soc_dai_link));
-				link++;
-				card->num_links++;
-				break;
-			}
-		}
-	}
-
-	if (card->num_links != num_links)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8195_mt6359_soc_card;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8195_mt6359_priv *priv;
+	struct mtk_soc_card_data *soc_card_data;
+	struct mt8195_mt6359_priv *mach_priv;
 	struct device_node *platform_node, *adsp_node, *dp_node, *hdmi_node;
 	struct mt8195_card_data *card_data;
 	int is5682s = 0;
@@ -1512,17 +1360,41 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 
 	if (strstr(card->name, "_5682s"))
 		is5682s = 1;
+	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*card_data), GFP_KERNEL);
+	if (!soc_card_data)
+		return -ENOMEM;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	mach_priv = devm_kzalloc(&pdev->dev, sizeof(*mach_priv), GFP_KERNEL);
+	if (!mach_priv)
 		return -ENOMEM;
 
+	soc_card_data->mach_priv = mach_priv;
+
+	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
+	if (adsp_node) {
+		struct mtk_sof_priv *sof_priv;
+
+		sof_priv = devm_kzalloc(&pdev->dev, sizeof(*sof_priv), GFP_KERNEL);
+		if (!sof_priv) {
+			ret = -ENOMEM;
+			goto err_kzalloc;
+		}
+		sof_priv->conn_streams = g_sof_conn_streams;
+		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
+		sof_priv->sof_dai_link_fixup = mt8195_dai_link_fixup;
+		soc_card_data->sof_priv = sof_priv;
+		card->late_probe = mtk_sof_card_late_probe;
+		sof_on = 1;
+	}
+
 	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
-		ret = mt8195_dailink_parse_of(card, pdev->dev.of_node,
-					      "mediatek,dai-link");
+		ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
+					       "mediatek,dai-link",
+					       mt8195_mt6359_dai_links,
+					       ARRAY_SIZE(mt8195_mt6359_dai_links));
 		if (ret) {
 			dev_dbg(&pdev->dev, "Parse dai-link fail\n");
-			return -EINVAL;
+			goto err_parse_of;
 		}
 	} else {
 		if (!sof_on)
@@ -1533,13 +1405,10 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 					 "mediatek,platform", 0);
 	if (!platform_node) {
 		dev_dbg(&pdev->dev, "Property 'platform' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_platform_node;
 	}
 
-	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
-	if (adsp_node)
-		sof_on = 1;
-
 	dp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,dptx-codec", 0);
 	hdmi_node = of_parse_phandle(pdev->dev.of_node,
 				     "mediatek,hdmi-codec", 0);
@@ -1612,17 +1481,17 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (sof_on)
-		card->late_probe = mt8195_mt6359_card_late_probe;
-
-	snd_soc_card_set_drvdata(card, priv);
+	snd_soc_card_set_drvdata(card, soc_card_data);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
 	of_node_put(platform_node);
-	of_node_put(adsp_node);
 	of_node_put(dp_node);
 	of_node_put(hdmi_node);
+err_kzalloc:
+err_parse_of:
+err_platform_node:
+	of_node_put(adsp_node);
 	return ret;
 }
 
-- 
2.25.1


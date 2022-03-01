Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CA4C852F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiCAHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiCAHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:30:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E1443F2;
        Mon, 28 Feb 2022 23:29:36 -0800 (PST)
X-UUID: cd7626bb2ca04115b1a5fd635e7d9b07-20220301
X-UUID: cd7626bb2ca04115b1a5fd635e7d9b07-20220301
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1427711592; Tue, 01 Mar 2022 15:29:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Mar 2022 15:29:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 15:29:29 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH 2/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Date:   Tue, 1 Mar 2022 15:29:24 +0800
Message-ID: <20220301072924.24814-3-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301072924.24814-1-jiaxin.yu@mediatek.com>
References: <20220301072924.24814-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>

Supports machines with rt1015p and rt5682s.  Uses new proposed compatible
string "mt8192_mt6359_rt1015p_rt5682s".

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |  1 +
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 87 +++++++++++++++++--
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index d515613a79da..cacfbab4262d 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -176,6 +176,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
 	select SND_SOC_RT5682_I2C
+	select SND_SOC_RT5682S
 	select SND_SOC_DMIC
 	help
 	  This adds ASoC driver for Mediatek MT8192 boards
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index a606133951b7..17ca6db5cd64 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -31,6 +31,9 @@
 #define RT5682_CODEC_DAI	"rt5682-aif1"
 #define RT5682_DEV0_NAME	"rt5682.1-001a"
 
+#define RT5682S_CODEC_DAI	"rt5682s-aif1"
+#define RT5682S_DEV0_NAME	"rt5682s.1-001a"
+
 struct mt8192_mt6359_priv {
 	struct snd_soc_jack headset_jack;
 	struct snd_soc_jack hdmi_jack;
@@ -632,18 +635,30 @@ SND_SOC_DAILINK_DEFS(i2s7,
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-SND_SOC_DAILINK_DEFS(i2s8,
+SND_SOC_DAILINK_DEFS(i2s8_rt5682,
 		     DAILINK_COMP_ARRAY(COMP_CPU("I2S8")),
 		     DAILINK_COMP_ARRAY(COMP_CODEC(RT5682_DEV0_NAME,
 						   RT5682_CODEC_DAI)),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-SND_SOC_DAILINK_DEFS(i2s9,
+SND_SOC_DAILINK_DEFS(i2s8_rt5682s,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2S8")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(RT5682S_DEV0_NAME,
+						   RT5682S_CODEC_DAI)),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(i2s9_rt5682,
 		     DAILINK_COMP_ARRAY(COMP_CPU("I2S9")),
 		     DAILINK_COMP_ARRAY(COMP_CODEC(RT5682_DEV0_NAME,
 						   RT5682_CODEC_DAI)),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
+SND_SOC_DAILINK_DEFS(i2s9_rt5682s,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2S9")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(RT5682S_DEV0_NAME,
+						   RT5682S_CODEC_DAI)),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 SND_SOC_DAILINK_DEFS(connsys_i2s,
 		     DAILINK_COMP_ARRAY(COMP_CPU("CONNSYS_I2S")),
 		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
@@ -961,7 +976,6 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 		.ignore_suspend = 1,
 		.init = mt8192_rt5682_init,
 		.be_hw_params_fixup = mt8192_i2s_hw_params_fixup,
-		SND_SOC_DAILINK_REG(i2s8),
 		.ops = &mt8192_rt5682_i2s_ops,
 	},
 	{
@@ -970,7 +984,6 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8192_i2s_hw_params_fixup,
-		SND_SOC_DAILINK_REG(i2s9),
 		.ops = &mt8192_rt5682_i2s_ops,
 	},
 	{
@@ -1100,6 +1113,19 @@ static struct snd_soc_card mt8192_mt6359_rt1015p_rt5682_card = {
 	.num_dapm_routes = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_routes),
 };
 
+static struct snd_soc_card mt8192_mt6359_rt1015p_rt5682s_card = {
+	.name = "mt8192_mt6359_rt1015p_rt5682s",
+	.owner = THIS_MODULE,
+	.dai_link = mt8192_mt6359_dai_links,
+	.num_links = ARRAY_SIZE(mt8192_mt6359_dai_links),
+	.controls = mt8192_mt6359_rt1015p_rt5682_controls,
+	.num_controls = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_controls),
+	.dapm_widgets = mt8192_mt6359_rt1015p_rt5682_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_widgets),
+	.dapm_routes = mt8192_mt6359_rt1015p_rt5682_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_routes),
+};
+
 static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -1139,7 +1165,8 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 				dai_link->platforms = i2s3_rt1015_platforms;
 				dai_link->num_platforms =
 					ARRAY_SIZE(i2s3_rt1015_platforms);
-			} else if (card == &mt8192_mt6359_rt1015p_rt5682_card) {
+			} else if (card == &mt8192_mt6359_rt1015p_rt5682_card ||
+				   card == &mt8192_mt6359_rt1015p_rt5682s_card) {
 				dai_link->cpus = i2s3_rt1015p_cpus;
 				dai_link->num_cpus =
 					ARRAY_SIZE(i2s3_rt1015p_cpus);
@@ -1150,6 +1177,52 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 				dai_link->num_platforms =
 					ARRAY_SIZE(i2s3_rt1015p_platforms);
 			}
+		} else if (strcmp(dai_link->name, "I2S8") == 0) {
+			if (card == &mt8192_mt6359_rt1015_rt5682_card ||
+			    card == &mt8192_mt6359_rt1015p_rt5682_card) {
+				dai_link->cpus = i2s8_rt5682_cpus;
+				dai_link->num_cpus =
+					ARRAY_SIZE(i2s8_rt5682_cpus);
+				dai_link->codecs = i2s8_rt5682_codecs;
+				dai_link->num_codecs =
+					ARRAY_SIZE(i2s8_rt5682_codecs);
+				dai_link->platforms = i2s8_rt5682_platforms;
+				dai_link->num_platforms =
+					ARRAY_SIZE(i2s8_rt5682_platforms);
+			} else if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
+				dai_link->cpus = i2s8_rt5682s_cpus;
+				dai_link->num_cpus =
+					ARRAY_SIZE(i2s8_rt5682s_cpus);
+				dai_link->codecs = i2s8_rt5682s_codecs;
+				dai_link->num_codecs =
+					ARRAY_SIZE(i2s8_rt5682s_codecs);
+				dai_link->platforms = i2s8_rt5682s_platforms;
+				dai_link->num_platforms =
+					ARRAY_SIZE(i2s8_rt5682s_platforms);
+			}
+		} else if (strcmp(dai_link->name, "I2S9") == 0) {
+			if (card == &mt8192_mt6359_rt1015_rt5682_card ||
+			    card == &mt8192_mt6359_rt1015p_rt5682_card) {
+				dai_link->cpus = i2s9_rt5682_cpus;
+				dai_link->num_cpus =
+					ARRAY_SIZE(i2s9_rt5682_cpus);
+				dai_link->codecs = i2s9_rt5682_codecs;
+				dai_link->num_codecs =
+					ARRAY_SIZE(i2s9_rt5682_codecs);
+				dai_link->platforms = i2s9_rt5682_platforms;
+				dai_link->num_platforms =
+					ARRAY_SIZE(i2s9_rt5682_platforms);
+			} else if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
+				dai_link->cpus = i2s9_rt5682s_cpus;
+				dai_link->num_cpus =
+					ARRAY_SIZE(i2s9_rt5682s_cpus);
+				dai_link->codecs = i2s9_rt5682s_codecs;
+				dai_link->num_codecs =
+					ARRAY_SIZE(i2s9_rt5682s_codecs);
+				dai_link->platforms = i2s9_rt5682s_platforms;
+				dai_link->num_platforms =
+					ARRAY_SIZE(i2s9_rt5682s_platforms);
+			}
 		}
 
 		if (hdmi_codec && strcmp(dai_link->name, "TDM") == 0) {
@@ -1185,6 +1258,10 @@ static const struct of_device_id mt8192_mt6359_dt_match[] = {
 		.compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682",
 		.data = &mt8192_mt6359_rt1015p_rt5682_card,
 	},
+	{
+		.compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682s",
+		.data = &mt8192_mt6359_rt1015p_rt5682s_card,
+	},
 	{}
 };
 #endif
-- 
2.18.0


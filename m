Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A424481AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhL3Irn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:47:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50450 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237879AbhL3Irl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:47:41 -0500
X-UUID: 797133c2f449426e83c15226a4a1ed55-20211230
X-UUID: 797133c2f449426e83c15226a4a1ed55-20211230
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2015604545; Thu, 30 Dec 2021 16:47:36 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Dec 2021 16:47:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Dec
 2021 16:47:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 16:47:35 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: mediatek: mt8195: correct pcmif BE dai control flow
Date:   Thu, 30 Dec 2021 16:47:30 +0800
Message-ID: <20211230084731.31372-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211230084731.31372-1-trevor.wu@mediatek.com>
References: <20211230084731.31372-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, the conditions for preventing reentry are not correct.
dai->component->active is not the state specifically for pcmif dai, so it
is not a correct condition to indicate the status of pcmif dai.
On the other hand, snd_soc_dai_stream_actvie() in prepare ops for both
playback and capture possibly return true at the first entry when these
two streams are opened at the same time.

In the patch, I refer to the implementation in mt8192-dai-pcm.c.
Clock and enabling bit for PCMIF are managed by DAPM, and the condition
for prepare ops is replaced by the status of dai widget.

Fixes: 1f95c019115c ("ASoC: mediatek: mt8195: support pcm in platform driver")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c | 73 +++++++---------------
 sound/soc/mediatek/mt8195/mt8195-reg.h     |  1 +
 2 files changed, 22 insertions(+), 52 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c b/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
index 5d10d2c4c991..151914c873ac 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
@@ -80,8 +80,15 @@ static const struct snd_soc_dapm_widget mtk_dai_pcm_widgets[] = {
 			   mtk_dai_pcm_o001_mix,
 			   ARRAY_SIZE(mtk_dai_pcm_o001_mix)),
 
+	SND_SOC_DAPM_SUPPLY("PCM_EN", PCM_INTF_CON1,
+			    PCM_INTF_CON1_PCM_EN_SHIFT, 0, NULL, 0),
+
 	SND_SOC_DAPM_INPUT("PCM1_INPUT"),
 	SND_SOC_DAPM_OUTPUT("PCM1_OUTPUT"),
+
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_asrc11"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_asrc12"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_pcmif"),
 };
 
 static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
@@ -97,22 +104,18 @@ static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
 	{"PCM1 Playback", NULL, "O000"},
 	{"PCM1 Playback", NULL, "O001"},
 
+	{"PCM1 Playback", NULL, "PCM_EN"},
+	{"PCM1 Playback", NULL, "aud_asrc12"},
+	{"PCM1 Playback", NULL, "aud_pcmif"},
+
+	{"PCM1 Capture", NULL, "PCM_EN"},
+	{"PCM1 Capture", NULL, "aud_asrc11"},
+	{"PCM1 Capture", NULL, "aud_pcmif"},
+
 	{"PCM1_OUTPUT", NULL, "PCM1 Playback"},
 	{"PCM1 Capture", NULL, "PCM1_INPUT"},
 };
 
-static void mtk_dai_pcm_enable(struct mtk_base_afe *afe)
-{
-	regmap_update_bits(afe->regmap, PCM_INTF_CON1,
-			   PCM_INTF_CON1_PCM_EN, PCM_INTF_CON1_PCM_EN);
-}
-
-static void mtk_dai_pcm_disable(struct mtk_base_afe *afe)
-{
-	regmap_update_bits(afe->regmap, PCM_INTF_CON1,
-			   PCM_INTF_CON1_PCM_EN, 0x0);
-}
-
 static int mtk_dai_pcm_configure(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
@@ -207,54 +210,22 @@ static int mtk_dai_pcm_configure(struct snd_pcm_substream *substream,
 }
 
 /* dai ops */
-static int mtk_dai_pcm_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-
-	if (dai->component->active)
-		return 0;
-
-	mt8195_afe_enable_clk(afe, afe_priv->clk[MT8195_CLK_AUD_ASRC11]);
-	mt8195_afe_enable_clk(afe, afe_priv->clk[MT8195_CLK_AUD_ASRC12]);
-	mt8195_afe_enable_clk(afe, afe_priv->clk[MT8195_CLK_AUD_PCMIF]);
-
-	return 0;
-}
-
-static void mtk_dai_pcm_shutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-
-	if (dai->component->active)
-		return;
-
-	mtk_dai_pcm_disable(afe);
-
-	mt8195_afe_disable_clk(afe, afe_priv->clk[MT8195_CLK_AUD_PCMIF]);
-	mt8195_afe_disable_clk(afe, afe_priv->clk[MT8195_CLK_AUD_ASRC12]);
-	mt8195_afe_disable_clk(afe, afe_priv->clk[MT8195_CLK_AUD_ASRC11]);
-}
-
 static int mtk_dai_pcm_prepare(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
-	int ret = 0;
+	int ret;
 
-	if (snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_PLAYBACK) &&
-	    snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE))
+	dev_dbg(dai->dev, "%s(), id %d, stream %d, widget active p %d, c %d\n",
+		__func__, dai->id, substream->stream,
+		dai->playback_widget->active, dai->capture_widget->active);
+
+	if (dai->playback_widget->active || dai->capture_widget->active)
 		return 0;
 
 	ret = mtk_dai_pcm_configure(substream, dai);
 	if (ret)
 		return ret;
 
-	mtk_dai_pcm_enable(afe);
-
 	return 0;
 }
 
@@ -316,8 +287,6 @@ static int mtk_dai_pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 }
 
 static const struct snd_soc_dai_ops mtk_dai_pcm_ops = {
-	.startup	= mtk_dai_pcm_startup,
-	.shutdown	= mtk_dai_pcm_shutdown,
 	.prepare	= mtk_dai_pcm_prepare,
 	.set_fmt	= mtk_dai_pcm_set_fmt,
 };
diff --git a/sound/soc/mediatek/mt8195/mt8195-reg.h b/sound/soc/mediatek/mt8195/mt8195-reg.h
index d06f9cf85a4e..d3871353db41 100644
--- a/sound/soc/mediatek/mt8195/mt8195-reg.h
+++ b/sound/soc/mediatek/mt8195/mt8195-reg.h
@@ -2550,6 +2550,7 @@
 #define PCM_INTF_CON1_PCM_FMT(x)       (((x) & 0x3) << 1)
 #define PCM_INTF_CON1_PCM_FMT_MASK     (0x3 << 1)
 #define PCM_INTF_CON1_PCM_EN           BIT(0)
+#define PCM_INTF_CON1_PCM_EN_SHIFT     0
 
 /* PCM_INTF_CON2 */
 #define PCM_INTF_CON2_CLK_DOMAIN_SEL(x)   (((x) & 0x3) << 23)
-- 
2.18.0


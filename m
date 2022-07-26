Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43E5816A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiGZPme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiGZPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:42:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515B2C64E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:42:29 -0700 (PDT)
X-UUID: 84953202041a4e6cadc10ed23c1e432a-20220726
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:2c9fadea-997c-47bb-9ba0-23a0ac14700c,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:20adffd3-912a-458b-a623-74f605a77e93,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 84953202041a4e6cadc10ed23c1e432a-20220726
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1903332647; Tue, 26 Jul 2022 23:42:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 26 Jul 2022 23:42:22 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 26 Jul 2022 23:42:22 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <dan.carpenter@oracle.com>
CC:     <aaronyu@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8186: remove unnecessary judgments
Date:   Tue, 26 Jul 2022 23:42:20 +0800
Message-ID: <20220726154220.28141-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The afe_priv->dai_priv[] is allocated when platform driver probe(), if it
failed, the ASoC platform driver probe() will return fail first.
Therefore, this is excessive judgment, and the condition will never be
established.

Bug report: https://www.spinics.net/lists/alsa-devel/msg145609.html

This is a semi-automatic email about new static checker warnings.

The patch ae92dcbee8b6: "ASoC: mediatek: mt8186: support tdm in
platform driver" from May 23, 2022, leads to the following Smatch
complaint:

    sound/soc/mediatek/mt8186/mt8186-dai-tdm.c:424 mtk_dai_tdm_hw_params()
    warn: variable dereferenced before check 'tdm_priv' (see line 406)

sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
   405		struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[tdm_id];
   406		unsigned int tdm_mode = tdm_priv->tdm_mode;
                                        ^^^^^^^^^^^^^^^^^^^
Lot's of dereferences

   407		unsigned int data_mode = tdm_priv->data_mode;
   408		unsigned int rate = params_rate(params);
   409		unsigned int channels = params_channels(params);
   410		snd_pcm_format_t format = params_format(params);
   411		unsigned int bit_width =
   412			snd_pcm_format_physical_width(format);
   413		unsigned int tdm_channels = (data_mode == TDM_DATA_ONE_PIN) ?
   414			get_tdm_ch_per_sdata(tdm_mode, channels) : 2;
   415		unsigned int lrck_width =
   416			get_tdm_lrck_width(format, tdm_mode);
   417		unsigned int tdm_con = 0;
   418		bool slave_mode = tdm_priv->slave_mode;
   419		bool lrck_inv = tdm_priv->lck_invert;
   420		bool bck_inv = tdm_priv->bck_invert;
   421		unsigned int tran_rate;
   422		unsigned int tran_relatch_rate;
   423
   424		if (!tdm_priv) {
                    ^^^^^^^^^
Checked too late

   425			dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
   426			return -EINVAL;

Fixes: ae92dcbee8b6 ("ASoC: mediatek: mt8186: support tdm in platform driver")
Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c |  5 --
 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c  | 63 ---------------------
 sound/soc/mediatek/mt8186/mt8186-dai-pcm.c  |  5 --
 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c  | 55 +-----------------
 4 files changed, 1 insertion(+), 127 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index 6be6d4f3b585..f6f23c7c3ff5 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -655,11 +655,6 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d\n",
 		__func__, id, substream->stream, rate);
 
-	if (!adda_priv) {
-		dev_err(afe->dev, "%s(), adda_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		unsigned int dl_src2_con0;
 		unsigned int dl_src2_con1;
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
index 5c1290b950e8..ec79e2f2a54d 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
@@ -119,12 +119,6 @@ static int mt8186_i2s_hd_get(struct snd_kcontrol *kcontrol,
 	struct mtk_afe_i2s_priv *i2s_priv;
 
 	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	ucontrol->value.integer.value[0] = i2s_priv->low_jitter_en;
 
 	return 0;
@@ -148,12 +142,6 @@ static int mt8186_i2s_hd_set(struct snd_kcontrol *kcontrol,
 		__func__, kcontrol->id.name, hd_en);
 
 	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	if (i2s_priv->low_jitter_en == hd_en)
 		return 0;
 
@@ -377,11 +365,6 @@ static int mtk_i2s_en_event(struct snd_soc_dapm_widget *w,
 
 	i2s_priv = get_i2s_priv_by_name(afe, w->name);
 
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
 		__func__, w->name, event);
 
@@ -442,11 +425,6 @@ static int mtk_mclk_en_event(struct snd_soc_dapm_widget *w,
 
 	i2s_priv = get_i2s_priv_by_name(afe, w->name);
 
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		mt8186_mck_enable(afe, i2s_priv->mclk_id, i2s_priv->mclk_rate);
@@ -566,12 +544,6 @@ static int mtk_afe_i2s_share_connect(struct snd_soc_dapm_widget *source,
 	struct mtk_afe_i2s_priv *i2s_priv;
 
 	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return 0;
-	}
-
 	if (i2s_priv->share_i2s_id < 0)
 		return 0;
 
@@ -587,12 +559,6 @@ static int mtk_afe_i2s_hd_connect(struct snd_soc_dapm_widget *source,
 	struct mtk_afe_i2s_priv *i2s_priv;
 
 	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return 0;
-	}
-
 	if (get_i2s_id_by_name(afe, sink->name) ==
 	    get_i2s_id_by_name(afe, source->name))
 		return i2s_priv->low_jitter_en;
@@ -618,15 +584,8 @@ static int mtk_afe_i2s_apll_connect(struct snd_soc_dapm_widget *source,
 	int i2s_need_apll;
 
 	i2s_priv = get_i2s_priv_by_name(afe, w->name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return 0;
-	}
-
 	/* which apll */
 	cur_apll = mt8186_get_apll_by_name(afe, source->name);
-
 	/* choose APLL from i2s rate */
 	i2s_need_apll = mt8186_get_apll_by_rate(afe, i2s_priv->rate);
 
@@ -642,12 +601,6 @@ static int mtk_afe_i2s_mclk_connect(struct snd_soc_dapm_widget *source,
 	struct mtk_afe_i2s_priv *i2s_priv;
 
 	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return 0;
-	}
-
 	if (get_i2s_id_by_name(afe, sink->name) ==
 	    get_i2s_id_by_name(afe, source->name))
 		return (i2s_priv->mclk_rate > 0) ? 1 : 0;
@@ -672,12 +625,6 @@ static int mtk_afe_mclk_apll_connect(struct snd_soc_dapm_widget *source,
 	int cur_apll;
 
 	i2s_priv = get_i2s_priv_by_name(afe, w->name);
-
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return 0;
-	}
-
 	/* which apll */
 	cur_apll = mt8186_get_apll_by_name(afe, source->name);
 
@@ -980,11 +927,6 @@ static int mtk_dai_i2s_config(struct mtk_base_afe *afe,
 	dev_dbg(afe->dev, "%s(), id %d, rate %d, format %d\n",
 		__func__, i2s_id, rate, format);
 
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	i2s_priv->rate = rate;
 
 	switch (i2s_id) {
@@ -1053,11 +995,6 @@ static int mtk_dai_i2s_set_sysclk(struct snd_soc_dai *dai,
 	int apll;
 	int apll_rate;
 
-	if (!i2s_priv) {
-		dev_err(afe->dev, "%s(), i2s_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	if (dir != SND_SOC_CLOCK_OUT) {
 		dev_err(afe->dev, "%s(), dir != SND_SOC_CLOCK_OUT", __func__);
 		return -EINVAL;
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c b/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
index 0b0032ecfe6d..41221a66111c 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
@@ -287,11 +287,6 @@ static int mtk_dai_pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_pcm_priv *pcm_priv = afe_priv->dai_priv[dai->id];
 
-	if (!pcm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	/* DAI mode*/
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
index c6ead7c252f0..4148dceb3a4c 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
@@ -106,11 +106,6 @@ static int mtk_tdm_en_event(struct snd_soc_dapm_widget *w,
 	int dai_id = get_tdm_id_by_name(w->name);
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
 		__func__, w->name, event);
 
@@ -138,11 +133,6 @@ static int mtk_tdm_mck_en_event(struct snd_soc_dapm_widget *w,
 	int dai_id = get_tdm_id_by_name(w->name);
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
 		__func__, w->name, event, dai_id);
 
@@ -215,11 +205,6 @@ static int mtk_afe_tdm_mclk_connect(struct snd_soc_dapm_widget *source,
 	int dai_id = get_tdm_id_by_name(w->name);
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return 0;
-	}
-
 	return (tdm_priv->mclk_rate > 0) ? 1 : 0;
 }
 
@@ -250,11 +235,6 @@ static int mtk_afe_tdm_hd_connect(struct snd_soc_dapm_widget *source,
 	int dai_id = get_tdm_id_by_name(w->name);
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return 0;
-	}
-
 	return tdm_priv->low_jitter_en;
 }
 
@@ -270,11 +250,6 @@ static int mtk_afe_tdm_apll_connect(struct snd_soc_dapm_widget *source,
 	int cur_apll;
 	int tdm_need_apll;
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return 0;
-	}
-
 	/* which apll */
 	cur_apll = mt8186_get_apll_by_name(afe, source->name);
 
@@ -303,11 +278,6 @@ static int mt8186_tdm_hd_get(struct snd_kcontrol *kcontrol,
 	int dai_id = get_tdm_id_by_name(kcontrol->id.name);
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	ucontrol->value.integer.value[0] = tdm_priv->low_jitter_en;
 
 	return 0;
@@ -332,11 +302,6 @@ static int mt8186_tdm_hd_set(struct snd_kcontrol *kcontrol,
 	dev_dbg(afe->dev, "%s(), kcontrol name %s, hd_en %d\n",
 		__func__, kcontrol->id.name, hd_en);
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	if (tdm_priv->low_jitter_en == hd_en)
 		return 0;
 
@@ -421,22 +386,14 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int tran_rate;
 	unsigned int tran_relatch_rate;
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	tdm_priv->rate = rate;
-
 	tran_rate = mt8186_rate_transform(afe->dev, rate, dai->id);
 	tran_relatch_rate = mt8186_tdm_relatch_rate_transform(afe->dev, rate);
 
 	/* calculate mclk_rate, if not set explicitly */
 	if (!tdm_priv->mclk_rate) {
 		tdm_priv->mclk_rate = rate * tdm_priv->mclk_multiple;
-		mtk_dai_tdm_cal_mclk(afe,
-				     tdm_priv,
-				     tdm_priv->mclk_rate);
+		mtk_dai_tdm_cal_mclk(afe, tdm_priv, tdm_priv->mclk_rate);
 	}
 
 	/* ETDM_IN1_CON0 */
@@ -508,11 +465,6 @@ static int mtk_dai_tdm_set_sysclk(struct snd_soc_dai *dai,
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai->id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	if (dir != SND_SOC_CLOCK_IN) {
 		dev_err(afe->dev, "%s(), dir != SND_SOC_CLOCK_OUT", __func__);
 		return -EINVAL;
@@ -529,11 +481,6 @@ static int mtk_dai_tdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai->id];
 
-	if (!tdm_priv) {
-		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
-		return -EINVAL;
-	}
-
 	/* DAI mode*/
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDD54D8001
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiCNKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiCNKkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:40:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131815A0B;
        Mon, 14 Mar 2022 03:39:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6EA791F43C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647254354;
        bh=EUbmJON90sDQrR2mXhuO1QBu4eKg32Jxdq/pCeygcfc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rsg8jgWiDFfVzbxCVIhHFNK0MisMROZJS9K0NONEg/QBiaHGVEsNk2oj4vbCSPnBg
         vuKcrTBbMBOVd8iz6QGTGuma4rtXAiKIWvmzwf3y6F5pXnWQNa97m/k3FDtR+wVxq6
         tEzZahIEmlmSf7MSA+t3CZqmVOOyM9fvAArbvfTzBc/jnLtVjZE7LDtsBW7EK6X09c
         82zSjWS/1RWIVVwvgxQNlRyc4ndrkKmge3tPxkFUaN26EPeUsJEE3P8vdo0xcK4yGX
         thPs8E341juDwEiK/GKcDsxsz74tlxUGLqJFQi4cbk5K0QaUSE+7AOkJhmqrNxkAWT
         SjA051EyfLMCA==
Message-ID: <3c7c6e67-072c-6377-05bd-1b5baa579666@collabora.com>
Date:   Mon, 14 Mar 2022 11:39:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 10/19] ASoC: mediatek: mt8186: support tdm in platform driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-11-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-11-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 tdm dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 695 +++++++++++++++++++++
>   1 file changed, 695 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> new file mode 100644
> index 000000000000..52acc5f6e147
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> @@ -0,0 +1,695 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// MediaTek ALSA SoC Audio DAI TDM Control
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include <linux/regmap.h>
> +#include <sound/pcm_params.h>
> +
> +#include "mt8186-afe-clk.h"
> +#include "mt8186-afe-common.h"
> +#include "mt8186-afe-gpio.h"
> +#include "mt8186-interconnection.h"
> +
> +#define TDM_HD_EN_W_NAME "TDM_HD_EN"
> +#define TDM_MCLK_EN_W_NAME "TDM_MCLK_EN"
> +#define MTK_AFE_TDM_KCONTROL_NAME "TDM_HD_Mux"
> +
> +struct mtk_afe_tdm_priv {
> +	unsigned int id;
> +	unsigned int rate; /* for determine which apll to use */
> +	unsigned int bck_invert;
> +	unsigned int lck_invert;
> +	unsigned int lrck_width;
> +	unsigned int mclk_id;
> +	unsigned int mclk_multiple; /* according to sample rate */
> +	unsigned int mclk_rate;
> +	unsigned int mclk_apll;
> +	unsigned int tdm_mode;
> +	unsigned int data_mode;
> +	unsigned int slave_mode;
> +	unsigned int low_jitter_en;
> +};
> +
> +enum {
> +	TDM_IN_I2S = 0,
> +	TDM_IN_LJ = 1,
> +	TDM_IN_RJ = 2,
> +	TDM_IN_DSP_A = 4,
> +	TDM_IN_DSP_B = 5,
> +};
> +
> +enum {
> +	TDM_DATA_ONE_PIN = 0,
> +	TDM_DATA_MULTI_PIN,
> +};
> +
> +enum {
> +	TDM_BCK_NON_INV = 0,
> +	TDM_BCK_INV = 1,
> +};
> +
> +enum {
> +	TDM_LCK_NON_INV = 0,
> +	TDM_LCK_INV = 1,
> +};
> +
> +static unsigned int get_tdm_lrck_width(snd_pcm_format_t format,
> +				       unsigned int mode)
> +{
> +	if (mode == TDM_IN_DSP_A || mode == TDM_IN_DSP_B)
> +		return 0;
> +
> +	return snd_pcm_format_physical_width(format) - 1;
> +}
> +
> +static unsigned int get_tdm_ch_fixup(unsigned int channels)
> +{
> +	if (channels > 4)
> +		return 8;
> +	else if (channels > 2)
> +		return 4;
> +
> +	return 2;
> +}
> +
> +static unsigned int get_tdm_ch_per_sdata(unsigned int mode,
> +					 unsigned int channels)
> +{
> +	if (mode == TDM_IN_DSP_A || mode == TDM_IN_DSP_B)
> +		return get_tdm_ch_fixup(channels);
> +
> +	return 2;
> +}
> +
> +enum {
> +	SUPPLY_SEQ_APLL,
> +	SUPPLY_SEQ_TDM_MCK_EN,
> +	SUPPLY_SEQ_TDM_HD_EN,
> +	SUPPLY_SEQ_TDM_EN,
> +};
> +
> +static int get_tdm_id_by_name(const char *name)
> +{
> +	return MT8186_DAI_TDM_IN;
> +}
> +
> +static int mtk_tdm_en_event(struct snd_soc_dapm_widget *w,
> +			    struct snd_kcontrol *kcontrol,
> +			    int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(w->name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		mt8186_afe_gpio_request(afe->dev, true, tdm_priv->id, 0);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		mt8186_afe_gpio_request(afe->dev, false, tdm_priv->id, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_tdm_mck_en_event(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol,
> +				int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(w->name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
> +		__func__, w->name, event, dai_id);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		mt8186_mck_enable(afe, tdm_priv->mclk_id, tdm_priv->mclk_rate);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		tdm_priv->mclk_rate = 0;
> +		mt8186_mck_disable(afe, tdm_priv->mclk_id);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/* dai component */
> +/* tdm virtual mux to output widget */
> +static const char * const tdm_mux_map[] = {
> +	"Normal", "Dummy_Widget",
> +};
> +
> +static int tdm_mux_map_value[] = {
> +	0, 1,
> +};
> +
> +static SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL(tdm_mux_map_enum,
> +					      SND_SOC_NOPM,
> +					      0,
> +					      1,
> +					      tdm_mux_map,
> +					      tdm_mux_map_value);
> +
> +static const struct snd_kcontrol_new tdm_in_mux_control =
> +	SOC_DAPM_ENUM("TDM In Select", tdm_mux_map_enum);
> +
> +static const struct snd_soc_dapm_widget mtk_dai_tdm_widgets[] = {
> +	SND_SOC_DAPM_CLOCK_SUPPLY("aud_tdm_clk"),
> +
> +	SND_SOC_DAPM_SUPPLY_S("TDM_EN", SUPPLY_SEQ_TDM_EN,
> +			      ETDM_IN1_CON0, ETDM_IN1_CON0_REG_ETDM_IN_EN_SFT,
> +			      0, mtk_tdm_en_event,
> +			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +	/* tdm hd en */
> +	SND_SOC_DAPM_SUPPLY_S(TDM_HD_EN_W_NAME, SUPPLY_SEQ_TDM_HD_EN,
> +			      ETDM_IN1_CON2, ETDM_IN1_CON2_REG_CLOCK_SOURCE_SEL_SFT,
> +			      0, NULL,
> +			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +
> +	SND_SOC_DAPM_SUPPLY_S(TDM_MCLK_EN_W_NAME, SUPPLY_SEQ_TDM_MCK_EN,
> +			      SND_SOC_NOPM, 0, 0,
> +			      mtk_tdm_mck_en_event,
> +			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +
> +	SND_SOC_DAPM_INPUT("TDM_DUMMY_IN"),
> +
> +	SND_SOC_DAPM_MUX("TDM_In_Mux",
> +			 SND_SOC_NOPM, 0, 0, &tdm_in_mux_control),
> +};
> +
> +static int mtk_afe_tdm_mclk_connect(struct snd_soc_dapm_widget *source,
> +				    struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = sink;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(w->name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return 0;
> +	}
> +
> +	return (tdm_priv->mclk_rate > 0) ? 1 : 0;
> +}
> +
> +static int mtk_afe_tdm_mclk_apll_connect(struct snd_soc_dapm_widget *source,
> +					 struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = sink;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(w->name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +	int cur_apll;
> +
> +	/* which apll */
> +	cur_apll = mt8186_get_apll_by_name(afe, source->name);
> +
> +	return (tdm_priv->mclk_apll == cur_apll) ? 1 : 0;
> +}
> +
> +static int mtk_afe_tdm_hd_connect(struct snd_soc_dapm_widget *source,
> +				  struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = sink;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(w->name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return 0;
> +	}
> +
> +	return tdm_priv->low_jitter_en;
> +}
> +
> +static int mtk_afe_tdm_apll_connect(struct snd_soc_dapm_widget *source,
> +				    struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = sink;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(w->name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +	int cur_apll;
> +	int tdm_need_apll;
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return 0;
> +	}
> +
> +	/* which apll */
> +	cur_apll = mt8186_get_apll_by_name(afe, source->name);
> +
> +	/* choose APLL from tdm rate */
> +	tdm_need_apll = mt8186_get_apll_by_rate(afe, tdm_priv->rate);
> +
> +	return (tdm_need_apll == cur_apll) ? 1 : 0;
> +}
> +
> +/* low jitter control */
> +static const char * const mt8186_tdm_hd_str[] = {
> +	"Normal", "Low_Jitter"
> +};
> +
> +static const struct soc_enum mt8186_tdm_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_tdm_hd_str),
> +			    mt8186_tdm_hd_str),
> +};
> +
> +static int mt8186_tdm_hd_get(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(kcontrol->id.name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ucontrol->value.integer.value[0] = tdm_priv->low_jitter_en;
> +
> +	return 0;
> +}
> +
> +static int mt8186_tdm_hd_set(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_tdm_id_by_name(kcontrol->id.name);
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int hd_en;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	hd_en = ucontrol->value.integer.value[0];
> +
> +	dev_dbg(afe->dev, "%s(), kcontrol name %s, hd_en %d\n",
> +		__func__, kcontrol->id.name, hd_en);
> +
> +	if (!tdm_priv) {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return -EINVAL;
> +	}
> +
> +	tdm_priv->low_jitter_en = hd_en;
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new mtk_dai_tdm_controls[] = {
> +	SOC_ENUM_EXT(MTK_AFE_TDM_KCONTROL_NAME, mt8186_tdm_enum[0],
> +		     mt8186_tdm_hd_get, mt8186_tdm_hd_set),
> +};
> +
> +static const struct snd_soc_dapm_route mtk_dai_tdm_routes[] = {
> +	{"TDM IN", NULL, "aud_tdm_clk"},
> +	{"TDM IN", NULL, "TDM_EN"},
> +	{"TDM IN", NULL, TDM_HD_EN_W_NAME, mtk_afe_tdm_hd_connect},
> +	{TDM_HD_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_tdm_apll_connect},
> +	{TDM_HD_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_tdm_apll_connect},
> +
> +	{"TDM IN", NULL, TDM_MCLK_EN_W_NAME, mtk_afe_tdm_mclk_connect},
> +	{TDM_MCLK_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_tdm_mclk_apll_connect},
> +	{TDM_MCLK_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_tdm_mclk_apll_connect},
> +
> +	/* allow tdm on without codec on */
> +	{"TDM IN", NULL, "TDM_In_Mux"},
> +	{"TDM_In_Mux", "Dummy_Widget", "TDM_DUMMY_IN"},
> +};
> +
> +/* dai ops */
> +static int mtk_dai_tdm_cal_mclk(struct mtk_base_afe *afe,
> +				struct mtk_afe_tdm_priv *tdm_priv,
> +				int freq)
> +{
> +	int apll;
> +	int apll_rate;
> +
> +	apll = mt8186_get_apll_by_rate(afe, freq);
> +	apll_rate = mt8186_get_apll_rate(afe, apll);
> +
> +	if (!freq || freq > apll_rate) {
> +		dev_err(afe->dev,
> +			"%s(), freq(%d Hz) invalid\n", __func__, freq);
> +		return -EINVAL;
> +	}
> +
> +	if (apll_rate % freq != 0) {
> +		dev_err(afe->dev,
> +			"%s(), APLL cannot generate %d Hz", __func__, freq);
> +		return -EINVAL;
> +	}
> +
> +	tdm_priv->mclk_rate = freq;
> +	tdm_priv->mclk_apll = apll;
> +
> +	return 0;
> +}
> +
> +static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int tdm_id = dai->id;
> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[tdm_id];
> +	unsigned int tdm_mode = tdm_priv->tdm_mode;
> +	unsigned int data_mode = tdm_priv->data_mode;
> +	unsigned int rate = params_rate(params);
> +	unsigned int channels = params_channels(params);
> +	snd_pcm_format_t format = params_format(params);
> +	unsigned int bit_width =
> +		snd_pcm_format_physical_width(format);
> +	unsigned int tdm_channels = (data_mode == TDM_DATA_ONE_PIN) ?
> +		get_tdm_ch_per_sdata(tdm_mode, channels) : 2;
> +	unsigned int lrck_width =
> +		get_tdm_lrck_width(format, tdm_mode);
> +	unsigned int tdm_con = 0;
> +	bool slave_mode = tdm_priv->slave_mode;
> +	bool lrck_inv = tdm_priv->lck_invert;
> +	bool bck_inv = tdm_priv->bck_invert;
> +	unsigned int tran_rate;
> +	unsigned int tran_relatch_rate;
> +
> +	if (tdm_priv)
> +		tdm_priv->rate = rate;
> +	else {
> +		dev_err(afe->dev, "%s(), tdm_priv == NULL", __func__);
> +		return -EINVAL;
> +	}

This can be simpler:

	if (!tdm_priv) {
		dev_err ....
		return -EINVAL;
	}

	tdm_priv->rate = rate;

...with that fixed:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

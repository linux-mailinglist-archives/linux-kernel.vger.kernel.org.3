Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6569A4BBB0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiBROy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:54:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiBROyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:54:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2B57142;
        Fri, 18 Feb 2022 06:54:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 34E471F46B85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645196069;
        bh=EIf0SGlAefpHB2fcz2+YnKmhgWvla/b39bvryB7nZWQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Z9aoGVXaLPrzZyhWG+t5Dm+/+8IIAGL6tCfIxKZgtEQkkqXZedSqXj7BfP6jiUtVN
         xDc/Z6X+jJIsRu6FxHHhqM/BJeYC6cUmU8wC1pzRh7TsuAl35jkx/PUmvienq3OhEq
         HSFzbXfSDGLaso1X7Q8oyk8OiaMAuwIADg1+6svZOLdjVSzB1JSR3Uon1Qj0zxgpPV
         7J6aasRgtyavpIL/5XLWDfOOS8gEOCx7TbDE0i/1l/eNKrFWcun5QA1OLBNODqCeqq
         htg6PmMA7VQN2vrt+8EdVuXKgbsRv6FHxVxP7F0R9U3okw5uofXL91ZzRqSBMCJOnV
         vrTDT197WCHbQ==
Message-ID: <30ec6389-5972-02c8-9147-c4624f5f97cb@collabora.com>
Date:   Fri, 18 Feb 2022 15:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [v2 06/17] ASoC: mediatek: mt8186: support i2s in platform driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, aaronyu@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-7-jiaxin.yu@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220217134205.15400-7-jiaxin.yu@mediatek.com>
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

Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> This patch adds mt8186 i2s dai driver
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-i2s.c | 1371 ++++++++++++++++++++
>   1 file changed, 1371 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> new file mode 100644
> index 000000000000..d6db5f6a7315
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> @@ -0,0 +1,1371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// MediaTek ALSA SoC Audio DAI I2S Control
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <sound/pcm_params.h>
> +#include "mt8186-afe-clk.h"
> +#include "mt8186-afe-common.h"
> +#include "mt8186-afe-gpio.h"
> +#include "mt8186-interconnection.h"
> +
> +enum {
> +	I2S_FMT_EIAJ = 0,
> +	I2S_FMT_I2S = 1,
> +};
> +
> +enum {
> +	I2S_WLEN_16_BIT = 0,
> +	I2S_WLEN_32_BIT = 1,
> +};
> +
> +enum {
> +	I2S_HD_NORMAL = 0,
> +	I2S_HD_LOW_JITTER = 1,
> +};
> +
> +enum {
> +	I2S1_SEL_O28_O29 = 0,
> +	I2S1_SEL_O03_O04 = 1,
> +};
> +
> +enum {
> +	I2S_IN_PAD_CONNSYS = 0,
> +	I2S_IN_PAD_IO_MUX = 1,
> +};
> +
> +struct mtk_afe_i2s_priv {
> +	int id;
> +	int rate; /* for determine which apll to use */
> +	int low_jitter_en;
> +	int master; /* only i2s0 has slave mode*/
> +
> +	const char *share_property_name;
> +	int share_i2s_id;
> +
> +	int mclk_id;
> +	int mclk_rate;
> +	int mclk_apll;
> +};
> +
> +static unsigned int get_i2s_wlen(snd_pcm_format_t format)
> +{
> +	return snd_pcm_format_physical_width(format) <= 16 ?
> +	       I2S_WLEN_16_BIT : I2S_WLEN_32_BIT;
> +}
> +
> +#define MTK_AFE_I2S0_KCONTROL_NAME "I2S0_HD_Mux"
> +#define MTK_AFE_I2S1_KCONTROL_NAME "I2S1_HD_Mux"
> +#define MTK_AFE_I2S2_KCONTROL_NAME "I2S2_HD_Mux"
> +#define MTK_AFE_I2S3_KCONTROL_NAME "I2S3_HD_Mux"
> +#define MTK_AFE_I2S0_SRC_KCONTROL_NAME "I2S0_SRC_Mux"
> +
> +#define I2S0_HD_EN_W_NAME "I2S0_HD_EN"
> +#define I2S1_HD_EN_W_NAME "I2S1_HD_EN"
> +#define I2S2_HD_EN_W_NAME "I2S2_HD_EN"
> +#define I2S3_HD_EN_W_NAME "I2S3_HD_EN"
> +
> +#define I2S0_MCLK_EN_W_NAME "I2S0_MCLK_EN"
> +#define I2S1_MCLK_EN_W_NAME "I2S1_MCLK_EN"
> +#define I2S2_MCLK_EN_W_NAME "I2S2_MCLK_EN"
> +#define I2S3_MCLK_EN_W_NAME "I2S3_MCLK_EN"
> +
> +static int get_i2s_id_by_name(struct mtk_base_afe *afe,
> +			      const char *name)
> +{
> +	if (strncmp(name, "I2S0", 4) == 0)
> +		return MT8186_DAI_I2S_0;
> +	else if (strncmp(name, "I2S1", 4) == 0)
> +		return MT8186_DAI_I2S_1;
> +	else if (strncmp(name, "I2S2", 4) == 0)
> +		return MT8186_DAI_I2S_2;
> +	else if (strncmp(name, "I2S3", 4) == 0)
> +		return MT8186_DAI_I2S_3;

This is just

	return -EINVAL;

(without the "else").

> +	else
> +		return -EINVAL;
> +}
> +
> +static struct mtk_afe_i2s_priv *get_i2s_priv_by_name(struct mtk_base_afe *afe,
> +						     const char *name)
> +{
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int dai_id = get_i2s_id_by_name(afe, name);
> +
> +	if (dai_id < 0)
> +		return NULL;
> +
> +	return afe_priv->dai_priv[dai_id];
> +}
> +
> +/* low jitter control */
> +static const char * const mt8186_i2s_hd_str[] = {
> +	"Normal", "Low_Jitter"
> +};
> +
> +static const struct soc_enum mt8186_i2s_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_i2s_hd_str),
> +			    mt8186_i2s_hd_str),
> +};
> +
> +/* clock source control */
> +static const char * const mt8186_i2s_src_str[] = {
> +	"Master", "Slave"
> +};
> +
> +static const struct soc_enum mt8186_i2s_src_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_i2s_src_str),
> +			    mt8186_i2s_src_str),
> +};
> +
> +static int mt8186_i2s_hd_get(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +
> +	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	ucontrol->value.integer.value[0] = i2s_priv->low_jitter_en;
> +
> +	return 0;
> +}
> +
> +static int mt8186_i2s_hd_set(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int hd_en;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	hd_en = ucontrol->value.integer.value[0];
> +
> +	dev_info(afe->dev, "%s(), kcontrol name %s, hd_en %d\n",
> +		 __func__, kcontrol->id.name, hd_en);

dev_dbg()

> +
> +	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	i2s_priv->low_jitter_en = hd_en;
> +
> +	return 0;
> +}
> +
> +static int mt8186_i2s_src_get(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +
> +	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	ucontrol->value.integer.value[0] = i2s_priv->master;
> +
> +	return 0;
> +}
> +
> +static int mt8186_i2s_src_set(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int clk_src;
> +	int dai_id;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	clk_src = ucontrol->value.integer.value[0];
> +
> +	dev_info(afe->dev, "%s(), kcontrol name %s, hd_en %d\n",
> +		 __func__, kcontrol->id.name, clk_src);

dev_dbg()

> +
> +	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
> +	dai_id = get_i2s_id_by_name(afe, kcontrol->id.name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	switch (dai_id) {
> +	case MT8186_DAI_I2S_0:
> +		regmap_update_bits(afe->regmap, AFE_I2S_CON,
> +				   I2S_SRC_MASK_SFT,
> +				   clk_src << I2S_SRC_SFT);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	i2s_priv->master = clk_src;
> +
> +	return 0;
> +}
> +

..snip..

> +
> +static int mtk_i2s_en_event(struct snd_soc_dapm_widget *w,
> +			    struct snd_kcontrol *kcontrol,
> +			    int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +
> +	i2s_priv = get_i2s_priv_by_name(afe, w->name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		mt8186_afe_gpio_request(afe->dev, true, i2s_priv->id, 0);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		mt8186_afe_gpio_request(afe->dev, false, i2s_priv->id, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_apll_event(struct snd_soc_dapm_widget *w,
> +			  struct snd_kcontrol *kcontrol,
> +			  int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +
> +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (strcmp(w->name, APLL1_W_NAME) == 0)
> +			mt8186_apll1_enable(afe);
> +		else
> +			mt8186_apll2_enable(afe);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		if (strcmp(w->name, APLL1_W_NAME) == 0)
> +			mt8186_apll1_disable(afe);
> +		else
> +			mt8186_apll2_disable(afe);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_mclk_en_event(struct snd_soc_dapm_widget *w,
> +			     struct snd_kcontrol *kcontrol,
> +			     int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +
> +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	i2s_priv = get_i2s_priv_by_name(afe, w->name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		mt8186_mck_enable(afe, i2s_priv->mclk_id, i2s_priv->mclk_rate);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		i2s_priv->mclk_rate = 0;
> +		mt8186_mck_disable(afe, i2s_priv->mclk_id);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +

..snip..

> +
> +static int mtk_afe_i2s_share_connect(struct snd_soc_dapm_widget *source,
> +				     struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = sink;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +
> +	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

Is this an error? => dev_err()
Is this expected? => dev_dbg()

> +		return 0;
> +	}
> +
> +	if (i2s_priv->share_i2s_id < 0)
> +		return 0;
> +
> +	return i2s_priv->share_i2s_id == get_i2s_id_by_name(afe, source->name);
> +}
> +
> +static int mtk_afe_i2s_hd_connect(struct snd_soc_dapm_widget *source,
> +				  struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget *w = sink;
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mtk_afe_i2s_priv *i2s_priv;
> +
> +	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

Is this an error? => dev_err()
Is this expected? => dev_dbg()

Please fix all of the other instances of this.

> +		return 0;
> +	}
> +
> +	if (get_i2s_id_by_name(afe, sink->name) ==
> +	    get_i2s_id_by_name(afe, source->name))
> +		return i2s_priv->low_jitter_en;
> +
> +	/* check if share i2s need hd en */
> +	if (i2s_priv->share_i2s_id < 0)
> +		return 0;
> +
> +	if (i2s_priv->share_i2s_id == get_i2s_id_by_name(afe, source->name))
> +		return i2s_priv->low_jitter_en;
> +
> +	return 0;
> +}
> +

..snip...

> +
> +/* dai ops */
> +static int mtk_dai_connsys_i2s_hw_params(struct snd_pcm_substream *substream,
> +					 struct snd_pcm_hw_params *params,
> +					 struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	unsigned int rate = params_rate(params);
> +	unsigned int rate_reg = mt8186_rate_transform(afe->dev,
> +						      rate, dai->id);
> +	unsigned int i2s_con = 0;
> +
> +	dev_info(afe->dev, "%s(), id %d, stream %d, rate %d\n",
> +		 __func__,
> +		 dai->id,
> +		 substream->stream,
> +		 rate);
> +
> +	/* non-inverse, i2s mode, slave, 16bits, from connsys */
> +	i2s_con |= 0 << INV_PAD_CTRL_SFT;
> +	i2s_con |= I2S_FMT_I2S << I2S_FMT_SFT;
> +	i2s_con |= 1 << I2S_SRC_SFT;
> +	i2s_con |= get_i2s_wlen(SNDRV_PCM_FORMAT_S16_LE) << I2S_WLEN_SFT;
> +	i2s_con |= 0 << I2SIN_PAD_SEL_SFT;
> +	regmap_write(afe->regmap, AFE_CONNSYS_I2S_CON, i2s_con);
> +
> +	/* use asrc */
> +	regmap_update_bits(afe->regmap,
> +			   AFE_CONNSYS_I2S_CON,
> +			   I2S_BYPSRC_MASK_SFT,
> +			   0x0 << I2S_BYPSRC_SFT);

Zero shifted of a billion bits is still zero.

regmap_update_bits(afe->regmap, AFE_CONNSYS_I2S_CON, I2S_BYPSRC_MASK_SFT, 0);

> +
> +	/* slave mode, set i2s for asrc */
> +	regmap_update_bits(afe->regmap,
> +			   AFE_CONNSYS_I2S_CON,
> +			   I2S_MODE_MASK_SFT,
> +			   rate_reg << I2S_MODE_SFT);

	regmap_update_bits(afe->regmap, AFE_CONNSYS_I2S_CON,

			   I2S_MODE_MASK_SFT, rate_reg << I2S_MODE_SFT);

> +
> +	if (rate == 44100)
> +		regmap_write(afe->regmap, AFE_ASRC_2CH_CON3, 0x001B9000);

lower case hex, please, and no leading zeros.

> +	else if (rate == 32000)
> +		regmap_write(afe->regmap, AFE_ASRC_2CH_CON3, 0x140000);
> +	else
> +		regmap_write(afe->regmap, AFE_ASRC_2CH_CON3, 0x001E0000);
> +
> +	/* Calibration setting */
> +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON4, 0x00140000);
> +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON9, 0x00036000);
> +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON10, 0x0002FC00);
> +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON6, 0x00007EF4);
> +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON5, 0x00FF5986);

ditto.

> +
> +	/* 0:Stereo 1:Mono */
> +	regmap_update_bits(afe->regmap,
> +			   AFE_ASRC_2CH_CON2,
> +			   CHSET_IS_MONO_MASK_SFT,
> +			   0x0 << CHSET_IS_MONO_SFT);

0 << SOMETHING = 0

Also, this fits in one line.

> +
> +	return 0;
> +}
> +
> +static int mtk_dai_connsys_i2s_trigger(struct snd_pcm_substream *substream,
> +				       int cmd, struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +
> +	dev_info(afe->dev, "%s(), cmd %d, stream %d\n",
> +		 __func__,
> +		 cmd,
> +		 substream->stream);

dev_dbg(), also fits in two lines.

> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		/* i2s enable */
> +		regmap_update_bits(afe->regmap,
> +				   AFE_CONNSYS_I2S_CON,
> +				   I2S_EN_MASK_SFT,
> +				   0x1 << I2S_EN_SFT);

BIT()

> +
> +		/* calibrator enable */
> +		regmap_update_bits(afe->regmap,
> +				   AFE_ASRC_2CH_CON5,
> +				   CALI_EN_MASK_SFT,
> +				   0x1 << CALI_EN_SFT);

BIT()

> +
> +		/* asrc enable */
> +		regmap_update_bits(afe->regmap,
> +				   AFE_ASRC_2CH_CON0,
> +				   CON0_CHSET_STR_CLR_MASK_SFT,
> +				   0x1 << CON0_CHSET_STR_CLR_SFT);

BIT()

> +		regmap_update_bits(afe->regmap,
> +				   AFE_ASRC_2CH_CON0,
> +				   CON0_ASM_ON_MASK_SFT,
> +				   0x1 << CON0_ASM_ON_SFT);

BIT()

> +
> +		afe_priv->dai_on[dai->id] = true;
> +		return 0;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +		regmap_update_bits(afe->regmap,
> +				   AFE_ASRC_2CH_CON0,
> +				   CON0_ASM_ON_MASK_SFT,
> +				   0 << CON0_ASM_ON_SFT);

This is zero.

> +		regmap_update_bits(afe->regmap,
> +				   AFE_ASRC_2CH_CON5,
> +				   CALI_EN_MASK_SFT,
> +				   0 << CALI_EN_SFT);

Zero again.

> +
> +		/* i2s disable */
> +		regmap_update_bits(afe->regmap,
> +				   AFE_CONNSYS_I2S_CON,
> +				   I2S_EN_MASK_SFT,
> +				   0x0 << I2S_EN_SFT);

...and again.

> +
> +		/* bypass asrc */
> +		regmap_update_bits(afe->regmap,
> +				   AFE_CONNSYS_I2S_CON,
> +				   I2S_BYPSRC_MASK_SFT,
> +				   0x1 << I2S_BYPSRC_SFT);

BIT()

> +
> +		afe_priv->dai_on[dai->id] = false;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops mtk_dai_connsys_i2s_ops = {
> +	.hw_params = mtk_dai_connsys_i2s_hw_params,
> +	.trigger = mtk_dai_connsys_i2s_trigger,
> +};
> +
> +/* i2s */
> +static int mtk_dai_i2s_config(struct mtk_base_afe *afe,
> +			      struct snd_pcm_hw_params *params,
> +			      int i2s_id)
> +{
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_afe_i2s_priv *i2s_priv = afe_priv->dai_priv[i2s_id];
> +
> +	unsigned int rate = params_rate(params);
> +	unsigned int rate_reg = mt8186_rate_transform(afe->dev,
> +						      rate, i2s_id);

Fits on a single line.

> +	snd_pcm_format_t format = params_format(params);
> +	unsigned int i2s_con = 0;
> +	int ret = 0;
> +
> +	dev_info(afe->dev, "%s(), id %d, rate %d, format %d\n",
> +		 __func__,
> +		 i2s_id,
> +		 rate, format);

dev_dbg(), fits on two lines.

> +
> +	if (i2s_priv)
> +		i2s_priv->rate = rate;
> +	else
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

I'm not sure about this print, maybe this should also be dev_dbg()

> +
> +	switch (i2s_id) {
> +	case MT8186_DAI_I2S_0:
> +		i2s_con = I2S_IN_PAD_IO_MUX << I2SIN_PAD_SEL_SFT;
> +		i2s_con |= rate_reg << I2S_OUT_MODE_SFT;
> +		i2s_con |= I2S_FMT_I2S << I2S_FMT_SFT;
> +		i2s_con |= get_i2s_wlen(format) << I2S_WLEN_SFT;
> +		regmap_update_bits(afe->regmap, AFE_I2S_CON,
> +				   0xffffeffa, i2s_con);
> +		break;
> +	case MT8186_DAI_I2S_1:
> +		i2s_con = I2S1_SEL_O28_O29 << I2S2_SEL_O03_O04_SFT;
> +		i2s_con |= rate_reg << I2S2_OUT_MODE_SFT;
> +		i2s_con |= I2S_FMT_I2S << I2S2_FMT_SFT;
> +		i2s_con |= get_i2s_wlen(format) << I2S2_WLEN_SFT;
> +		regmap_update_bits(afe->regmap, AFE_I2S_CON1,
> +				   0xffffeffa, i2s_con);
> +		break;
> +	case MT8186_DAI_I2S_2:
> +		i2s_con = 8 << I2S3_UPDATE_WORD_SFT;
> +		i2s_con |= rate_reg << I2S3_OUT_MODE_SFT;
> +		i2s_con |= I2S_FMT_I2S << I2S3_FMT_SFT;
> +		i2s_con |= get_i2s_wlen(format) << I2S3_WLEN_SFT;
> +		regmap_update_bits(afe->regmap, AFE_I2S_CON2,
> +				   0xffffeffa, i2s_con);
> +		break;
> +	case MT8186_DAI_I2S_3:
> +		i2s_con = rate_reg << I2S4_OUT_MODE_SFT;
> +		i2s_con |= I2S_FMT_I2S << I2S4_FMT_SFT;
> +		i2s_con |= get_i2s_wlen(format) << I2S4_WLEN_SFT;
> +		regmap_update_bits(afe->regmap, AFE_I2S_CON3,
> +				   0xffffeffa, i2s_con);
> +		break;
> +	default:
> +		dev_info(afe->dev, "%s(), id %d not support\n",
> +			 __func__, i2s_id);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	/* set share i2s */
> +	if (i2s_priv && i2s_priv->share_i2s_id >= 0)
> +		ret = mtk_dai_i2s_config(afe, params, i2s_priv->share_i2s_id);
> +

	if (i2s_priv && i2s_priv->share_i2s_id >= 0) {

		ret = mtk_dai_i2s_config(afe, params, i2s_priv->share_i2s_id);

		if (ret)

			return ret;

	}



	return 0;

> +	return ret;
> +}
> +
> +static int mtk_dai_i2s_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +
> +	return mtk_dai_i2s_config(afe, params, dai->id);
> +}
> +
> +static int mtk_dai_i2s_set_sysclk(struct snd_soc_dai *dai,
> +				  int clk_id, unsigned int freq, int dir)
> +{
> +	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_afe_i2s_priv *i2s_priv = afe_priv->dai_priv[dai->id];
> +	int apll;
> +	int apll_rate;
> +
> +	if (!i2s_priv) {
> +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	if (dir != SND_SOC_CLOCK_OUT) {
> +		dev_info(afe->dev, "%s(), dir != SND_SOC_CLOCK_OUT", __func__);

again...

> +		return -EINVAL;
> +	}
> +
> +	dev_info(afe->dev, "%s(), freq %d\n", __func__, freq);

dev_dbg()

> +
> +	apll = mt8186_get_apll_by_rate(afe, freq);
> +	apll_rate = mt8186_get_apll_rate(afe, apll);
> +
> +	if (freq > apll_rate) {
> +		dev_info(afe->dev, "%s(), freq > apll rate", __func__);

dev_err() .... please fix the rest as well.

> +		return -EINVAL;
> +	}
> +
> +	if (apll_rate % freq != 0) {
> +		dev_info(afe->dev, "%s(), APLL cannot generate freq Hz", __func__);
> +		return -EINVAL;
> +	}
> +
> +	i2s_priv->mclk_rate = freq;
> +	i2s_priv->mclk_apll = apll;
> +
> +	if (i2s_priv->share_i2s_id > 0) {
> +		struct mtk_afe_i2s_priv *share_i2s_priv;
> +
> +		share_i2s_priv = afe_priv->dai_priv[i2s_priv->share_i2s_id];
> +		if (!share_i2s_priv) {
> +			dev_info(afe->dev, "%s(), share_i2s_priv == NULL", __func__);
> +			return -EINVAL;
> +		}
> +
> +		share_i2s_priv->mclk_rate = i2s_priv->mclk_rate;
> +		share_i2s_priv->mclk_apll = i2s_priv->mclk_apll;
> +	}
> +
> +	return 0;
> +}
> +

Regards,
Angelo


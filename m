Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBA04CE465
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiCELI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiCELIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:08:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9C23EA87;
        Sat,  5 Mar 2022 03:08:01 -0800 (PST)
X-UUID: 925afbf654c141299bd365f188cd639d-20220305
X-UUID: 925afbf654c141299bd365f188cd639d-20220305
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 999676758; Sat, 05 Mar 2022 19:07:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Mar 2022 19:07:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 19:07:54 +0800
Message-ID: <3acf0e4bc1a6ce41c04978c715dd3ed351e4de3d.camel@mediatek.com>
Subject: Re: [v2 06/17] ASoC: mediatek: mt8186: support i2s in platform
 driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <aaronyu@google.com>, <zhangqilong3@huawei.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 5 Mar 2022 19:07:53 +0800
In-Reply-To: <30ec6389-5972-02c8-9147-c4624f5f97cb@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-7-jiaxin.yu@mediatek.com>
         <30ec6389-5972-02c8-9147-c4624f5f97cb@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> > This patch adds mt8186 i2s dai driver
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-dai-i2s.c | 1371
> > ++++++++++++++++++++
> >   1 file changed, 1371 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> > b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> > new file mode 100644
> > index 000000000000..d6db5f6a7315
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
> > @@ -0,0 +1,1371 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// MediaTek ALSA SoC Audio DAI I2S Control
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/regmap.h>
> > +#include <sound/pcm_params.h>
> > +#include "mt8186-afe-clk.h"
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-gpio.h"
> > +#include "mt8186-interconnection.h"
> > +
> > 
> > +static int mtk_afe_i2s_share_connect(struct snd_soc_dapm_widget
> > *source,
> > +				     struct snd_soc_dapm_widget *sink)
> > +{
> > +	struct snd_soc_dapm_widget *w = sink;
> > +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w-
> > >dapm);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mtk_afe_i2s_priv *i2s_priv;
> > +
> > +	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
> > +
> > +	if (!i2s_priv) {
> > +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);
> 
> Is this an error? => dev_err()
> Is this expected? => dev_dbg()
> 
It should be an error here and use dev_err().
I will fix the rest of the similar log level issues.

> > +		return 0;
> > +	}
> > +
> > +	if (i2s_priv->share_i2s_id < 0)
> > +		return 0;
> > +
> > +	return i2s_priv->share_i2s_id == get_i2s_id_by_name(afe,
> > source->name);
> > +}
> > +
> > +static int mtk_afe_i2s_hd_connect(struct snd_soc_dapm_widget
> > *source,
> > +				  struct snd_soc_dapm_widget *sink)
> > +{
> > +	struct snd_soc_dapm_widget *w = sink;
> > +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w-
> > >dapm);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mtk_afe_i2s_priv *i2s_priv;
> > +
> > +	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
> > +
> > +	if (!i2s_priv) {
> > +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);
> 
> Is this an error? => dev_err()
> Is this expected? => dev_dbg()
> 
> Please fix all of the other instances of this.
> 
Yes, I know.

> > +		return 0;
> > +	}
> > +
> > +	if (get_i2s_id_by_name(afe, sink->name) ==
> > +	    get_i2s_id_by_name(afe, source->name))
> > +		return i2s_priv->low_jitter_en;
> > +
> > +	/* check if share i2s need hd en */
> > +	if (i2s_priv->share_i2s_id < 0)
> > +		return 0;
> > +
> > +	if (i2s_priv->share_i2s_id == get_i2s_id_by_name(afe, source-
> > >name))
> > +		return i2s_priv->low_jitter_en;
> > +
> > +	return 0;
> > +}
> > +
> 
> ..snip...
> 
> > +
> > +/* dai ops */
> > +static int mtk_dai_connsys_i2s_hw_params(struct snd_pcm_substream
> > *substream,
> > +					 struct snd_pcm_hw_params
> > *params,
> > +					 struct snd_soc_dai *dai)
> > +{
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	unsigned int rate = params_rate(params);
> > +	unsigned int rate_reg = mt8186_rate_transform(afe->dev,
> > +						      rate, dai->id);
> > +	unsigned int i2s_con = 0;
> > +
> > +	dev_info(afe->dev, "%s(), id %d, stream %d, rate %d\n",
> > +		 __func__,
> > +		 dai->id,
> > +		 substream->stream,
> > +		 rate);
> > +
> > +	/* non-inverse, i2s mode, slave, 16bits, from connsys */
> > +	i2s_con |= 0 << INV_PAD_CTRL_SFT;
> > +	i2s_con |= I2S_FMT_I2S << I2S_FMT_SFT;
> > +	i2s_con |= 1 << I2S_SRC_SFT;
> > +	i2s_con |= get_i2s_wlen(SNDRV_PCM_FORMAT_S16_LE) <<
> > I2S_WLEN_SFT;
> > +	i2s_con |= 0 << I2SIN_PAD_SEL_SFT;
> > +	regmap_write(afe->regmap, AFE_CONNSYS_I2S_CON, i2s_con);
> > +
> > +	/* use asrc */
> > +	regmap_update_bits(afe->regmap,
> > +			   AFE_CONNSYS_I2S_CON,
> > +			   I2S_BYPSRC_MASK_SFT,
> > +			   0x0 << I2S_BYPSRC_SFT);
> 
> Zero shifted of a billion bits is still zero.
> 
Got it.

> regmap_update_bits(afe->regmap, AFE_CONNSYS_I2S_CON,
> I2S_BYPSRC_MASK_SFT, 0);
> 
> > +
> > +	/* slave mode, set i2s for asrc */
> > +	regmap_update_bits(afe->regmap,
> > +			   AFE_CONNSYS_I2S_CON,
> > +			   I2S_MODE_MASK_SFT,
> > +			   rate_reg << I2S_MODE_SFT);
> 
> 	regmap_update_bits(afe->regmap, AFE_CONNSYS_I2S_CON,
> 
> 			   I2S_MODE_MASK_SFT, rate_reg <<
> I2S_MODE_SFT);
> 
> > +
> > +	if (rate == 44100)
> > +		regmap_write(afe->regmap, AFE_ASRC_2CH_CON3,
> > 0x001B9000);
> 
> lower case hex, please, and no leading zeros.
> 
Got it.
> > +	else if (rate == 32000)
> > +		regmap_write(afe->regmap, AFE_ASRC_2CH_CON3, 0x140000);
> > +	else
> > +		regmap_write(afe->regmap, AFE_ASRC_2CH_CON3,
> > 0x001E0000);
> > +
> > +	/* Calibration setting */
> > +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON4, 0x00140000);
> > +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON9, 0x00036000);
> > +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON10, 0x0002FC00);
> > +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON6, 0x00007EF4);
> > +	regmap_write(afe->regmap, AFE_ASRC_2CH_CON5, 0x00FF5986);
> 

snip...
> > +
> > +	if (i2s_priv)
> > +		i2s_priv->rate = rate;
> > +	else
> > +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);
> 
> I'm not sure about this print, maybe this should also be dev_dbg()
> 
It should be return error.
> > +
> > +	switch (i2s_id) {
> > +	case MT8186_DAI_I2S_0:
> > +		i2s_con = I2S_IN_PAD_IO_MUX << I2SIN_PAD_SEL_SFT;
> > +		i2s_con |= rate_reg << I2S_OUT_MODE_SFT;
> > +		i2s_con |= I2S_FMT_I2S << I2S_FMT_SFT;
> > +		i2s_con |= get_i2s_wlen(format) << I2S_WLEN_SFT;
> > +		regmap_update_bits(afe->regmap, AFE_I2S_CON,
> > +				   0xffffeffa, i2s_con);
> > +		break;
> > +	case MT8186_DAI_I2S_1:
> > +		i2s_con = I2S1_SEL_O28_O29 << I2S2_SEL_O03_O04_SFT;
> > +		i2s_con |= rate_reg << I2S2_OUT_MODE_SFT;
> > +		i2s_con |= I2S_FMT_I2S << I2S2_FMT_SFT;
> > +		i2s_con |= get_i2s_wlen(format) << I2S2_WLEN_SFT;
> > +		regmap_update_bits(afe->regmap, AFE_I2S_CON1,
> > +				   0xffffeffa, i2s_con);
> > +		break;
> > +	case MT8186_DAI_I2S_2:
> > +		i2s_con = 8 << I2S3_UPDATE_WORD_SFT;
> > +		i2s_con |= rate_reg << I2S3_OUT_MODE_SFT;
> > +		i2s_con |= I2S_FMT_I2S << I2S3_FMT_SFT;
> > +		i2s_con |= get_i2s_wlen(format) << I2S3_WLEN_SFT;
> > +		regmap_update_bits(afe->regmap, AFE_I2S_CON2,
> > +				   0xffffeffa, i2s_con);
> > +		break;
> > +	case MT8186_DAI_I2S_3:
> > +		i2s_con = rate_reg << I2S4_OUT_MODE_SFT;
> > +		i2s_con |= I2S_FMT_I2S << I2S4_FMT_SFT;
> > +		i2s_con |= get_i2s_wlen(format) << I2S4_WLEN_SFT;
> > +		regmap_update_bits(afe->regmap, AFE_I2S_CON3,
> > +				   0xffffeffa, i2s_con);
> > +		break;
> > +	default:
> > +		dev_info(afe->dev, "%s(), id %d not support\n",
> > +			 __func__, i2s_id);
> 
> dev_err()
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* set share i2s */
> > +	if (i2s_priv && i2s_priv->share_i2s_id >= 0)
> > +		ret = mtk_dai_i2s_config(afe, params, i2s_priv-
> > >share_i2s_id);
> > +
> 
> 	if (i2s_priv && i2s_priv->share_i2s_id >= 0) {
> 
> 		ret = mtk_dai_i2s_config(afe, params, i2s_priv-
> >share_i2s_id);
> 
> 		if (ret)
> 
> 			return ret;
> 
> 	}
> 
> 
> 
> 	return 0;
> 
> > +	return ret;
> > +}
> > +
> > +static int mtk_dai_i2s_hw_params(struct snd_pcm_substream
> > *substream,
> > +				 struct snd_pcm_hw_params *params,
> > +				 struct snd_soc_dai *dai)
> > +{
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +
> > +	return mtk_dai_i2s_config(afe, params, dai->id);
> > +}
> > +
> > +static int mtk_dai_i2s_set_sysclk(struct snd_soc_dai *dai,
> > +				  int clk_id, unsigned int freq, int
> > dir)
> > +{
> > +	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	struct mtk_afe_i2s_priv *i2s_priv = afe_priv->dai_priv[dai-
> > >id];
> > +	int apll;
> > +	int apll_rate;
> > +
> > +	if (!i2s_priv) {
> > +		dev_info(afe->dev, "%s(), i2s_priv == NULL", __func__);
> 
> dev_err()
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dir != SND_SOC_CLOCK_OUT) {
> > +		dev_info(afe->dev, "%s(), dir != SND_SOC_CLOCK_OUT",
> > __func__);
> 
> again...
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_info(afe->dev, "%s(), freq %d\n", __func__, freq);
> 
> dev_dbg()
> 
> > +
> > +	apll = mt8186_get_apll_by_rate(afe, freq);
> > +	apll_rate = mt8186_get_apll_rate(afe, apll);
> > +
> > +	if (freq > apll_rate) {
> > +		dev_info(afe->dev, "%s(), freq > apll rate", __func__);
> 
> dev_err() .... please fix the rest as well.
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (apll_rate % freq != 0) {
> > +		dev_info(afe->dev, "%s(), APLL cannot generate freq
> > Hz", __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	i2s_priv->mclk_rate = freq;
> > +	i2s_priv->mclk_apll = apll;
> > +
> > +	if (i2s_priv->share_i2s_id > 0) {
> > +		struct mtk_afe_i2s_priv *share_i2s_priv;
> > +
> > +		share_i2s_priv = afe_priv->dai_priv[i2s_priv-
> > >share_i2s_id];
> > +		if (!share_i2s_priv) {
> > +			dev_info(afe->dev, "%s(), share_i2s_priv ==
> > NULL", __func__);
> > +			return -EINVAL;
> > +		}
> > +
> > +		share_i2s_priv->mclk_rate = i2s_priv->mclk_rate;
> > +		share_i2s_priv->mclk_apll = i2s_priv->mclk_apll;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> Regards,
> Angelo
> 


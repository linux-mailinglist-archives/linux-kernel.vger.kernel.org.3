Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326CA4CBF91
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCCOLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiCCOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:11:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E518C7BF;
        Thu,  3 Mar 2022 06:10:14 -0800 (PST)
X-UUID: 6d8ca964a6bd4ff9abb1f2dea29c70d2-20220303
X-UUID: 6d8ca964a6bd4ff9abb1f2dea29c70d2-20220303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 571788455; Thu, 03 Mar 2022 22:10:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 3 Mar 2022 22:10:07 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 22:10:06 +0800
Message-ID: <9ba63387baecf598db696d0ebbc1583406a57a62.camel@mediatek.com>
Subject: Re: [v2 09/17] ASoC: mediatek: mt8186: support tdm in platform
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
Date:   Thu, 3 Mar 2022 22:10:06 +0800
In-Reply-To: <fcae42a5-6e11-e683-8f3a-453650f08d38@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-10-jiaxin.yu@mediatek.com>
         <fcae42a5-6e11-e683-8f3a-453650f08d38@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> > This patch adds mt8186 tdm dai driver.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 713
> > +++++++++++++++++++++
> >   1 file changed, 713 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> > b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> > new file mode 100644
> > index 000000000000..28dd3661f0e0
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> > @@ -0,0 +1,713 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// MediaTek ALSA SoC Audio DAI TDM Control
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/regmap.h>
> > +#include <sound/pcm_params.h>
> > +
> > +#include "mt8186-afe-clk.h"
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-gpio.h"
> > +#include "mt8186-interconnection.h"
> > +
> > +#define TDM_HD_EN_W_NAME "TDM_HD_EN"
> > +#define TDM_MCLK_EN_W_NAME "TDM_MCLK_EN"
> > +#define MTK_AFE_TDM_KCONTROL_NAME "TDM_HD_Mux"
> > +
> > +struct mtk_afe_tdm_priv {
> > +	unsigned int id;
> > +	unsigned int rate; /* for determine which apll to use */
> > +	unsigned int bck_invert;
> > +	unsigned int lck_invert;
> > +	unsigned int lrck_width;
> > +	unsigned int mclk_id;
> > +	unsigned int mclk_multiple; /* according to sample rate */
> > +	unsigned int mclk_rate;
> > +	unsigned int mclk_apll;
> > +	unsigned int tdm_mode;
> > +	unsigned int data_mode;
> > +	unsigned int slave_mode;
> > +	unsigned int low_jitter_en;
> > +};
> > +
> > +enum {
> > +	TDM_IN_I2S = 0,
> > +	TDM_IN_LJ = 1,
> > +	TDM_IN_RJ = 2,
> > +	TDM_IN_DSP_A = 4,
> > +	TDM_IN_DSP_B = 5,
> > +};
> > +
> > +enum {
> > +	TDM_DATA_ONE_PIN = 0,
> > +	TDM_DATA_MULTI_PIN,
> > +};
> > +
> > +enum {
> > +	TDM_BCK_NON_INV = 0,
> > +	TDM_BCK_INV = 1,
> > +};
> > +
> > +enum {
> > +	TDM_LCK_NON_INV = 0,
> > +	TDM_LCK_INV = 1,
> > +};
> > +
> > +static unsigned int get_tdm_lrck_width(snd_pcm_format_t format,
> > +				       unsigned int mode)
> > +{
> > +	if (mode == TDM_IN_DSP_A || mode == TDM_IN_DSP_B)
> > +		return 0;
> > +	else
> 
> Drop the "else"
> 
> > +		return snd_pcm_format_physical_width(format) - 1;
> > +}
> > +
> > +static unsigned int get_tdm_ch_fixup(unsigned int channels)
> > +{
> > +	if (channels > 4)
> > +		return 8;
> > +	else if (channels > 2)
> > +		return 4;
> > +	else
> 
> Same here
> 
> > +		return 2;
> > +}
> > +
> > +static unsigned int get_tdm_ch_per_sdata(unsigned int mode,
> > +					 unsigned int channels)
> > +{
> > +	if (mode == TDM_IN_DSP_A || mode == TDM_IN_DSP_B)
> > +		return get_tdm_ch_fixup(channels);
> > +	else
> 
> ...and same here
> 
> > +		return 2;
> > +}
> > +
> > +enum {
> > +	SUPPLY_SEQ_APLL,
> > +	SUPPLY_SEQ_TDM_MCK_EN,
> > +	SUPPLY_SEQ_TDM_HD_EN,
> > +	SUPPLY_SEQ_TDM_EN,
> > +};
> > +
> > +static int get_tdm_id_by_name(const char *name)
> > +{
> > +	return MT8186_DAI_TDM_IN;
> > +}
> > +
> > +static int mtk_tdm_en_event(struct snd_soc_dapm_widget *w,
> > +			    struct snd_kcontrol *kcontrol,
> > +			    int event)
> > +{
> > +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w-
> > >dapm);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int dai_id = get_tdm_id_by_name(w->name);
> > +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> > +
> > +	if (!tdm_priv) {
> > +		dev_info(afe->dev, "%s(), tdm_priv == NULL", __func__);
> 
> dev_err()
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> > +		__func__, w->name, event);
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		mt8186_afe_gpio_request(afe->dev, true, tdm_priv->id,
> > 0);
> > +		break;
> > +	case SND_SOC_DAPM_POST_PMD:
> > +		mt8186_afe_gpio_request(afe->dev, false, tdm_priv->id,
> > 0);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_tdm_mck_en_event(struct snd_soc_dapm_widget *w,
> > +				struct snd_kcontrol *kcontrol,
> > +				int event)
> > +{
> > +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w-
> > >dapm);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int dai_id = get_tdm_id_by_name(w->name);
> > +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> > +
> > +	if (!tdm_priv) {
> > +		dev_info(afe->dev, "%s(), tdm_priv == NULL", __func__);
> 
> dev_err() - please fix all other instances
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x, dai_id %d\n",
> > +		__func__, w->name, event, dai_id);
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		mt8186_mck_enable(afe, tdm_priv->mclk_id, tdm_priv-
> > >mclk_rate);
> > +		break;
> > +	case SND_SOC_DAPM_POST_PMD:
> > +		tdm_priv->mclk_rate = 0;
> > +		mt8186_mck_disable(afe, tdm_priv->mclk_id);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> ...snip...
> 
> > +
> > +static int mt8186_tdm_hd_set(struct snd_kcontrol *kcontrol,
> > +			     struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int dai_id = get_tdm_id_by_name(kcontrol->id.name);
> > +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai_id];
> > +	struct soc_enum *e = (struct soc_enum *)kcontrol-
> > >private_value;
> > +	int hd_en;
> > +
> > +	if (ucontrol->value.enumerated.item[0] >= e->items)
> > +		return -EINVAL;
> > +
> > +	hd_en = ucontrol->value.integer.value[0];
> > +
> > +	dev_info(afe->dev, "%s(), kcontrol name %s, hd_en %d\n",
> > +		 __func__, kcontrol->id.name, hd_en);
> 
> dev_dbg()
> 
> > +
> > +	if (!tdm_priv) {
> > +		dev_info(afe->dev, "%s(), tdm_priv == NULL", __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	tdm_priv->low_jitter_en = hd_en;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct snd_kcontrol_new mtk_dai_tdm_controls[] = {
> > +	SOC_ENUM_EXT(MTK_AFE_TDM_KCONTROL_NAME, mt8186_tdm_enum[0],
> > +		     mt8186_tdm_hd_get, mt8186_tdm_hd_set),
> > +};
> > +
> > +static const struct snd_soc_dapm_route mtk_dai_tdm_routes[] = {
> > +	{"TDM IN", NULL, "aud_tdm_clk"},
> > +	{"TDM IN", NULL, "TDM_EN"},
> > +	{"TDM IN", NULL, TDM_HD_EN_W_NAME, mtk_afe_tdm_hd_connect},
> > +	{TDM_HD_EN_W_NAME, NULL, APLL1_W_NAME,
> > mtk_afe_tdm_apll_connect},
> > +	{TDM_HD_EN_W_NAME, NULL, APLL2_W_NAME,
> > mtk_afe_tdm_apll_connect},
> > +
> > +	{"TDM IN", NULL, TDM_MCLK_EN_W_NAME, mtk_afe_tdm_mclk_connect},
> > +	{TDM_MCLK_EN_W_NAME, NULL, APLL1_W_NAME,
> > mtk_afe_tdm_mclk_apll_connect},
> > +	{TDM_MCLK_EN_W_NAME, NULL, APLL2_W_NAME,
> > mtk_afe_tdm_mclk_apll_connect},
> > +
> > +	/* allow tdm on without codec on */
> > +	{"TDM IN", NULL, "TDM_In_Mux"},
> > +	{"TDM_In_Mux", "Dummy_Widget", "TDM_DUMMY_IN"},
> > +};
> > +
> > +/* dai ops */
> > +static int mtk_dai_tdm_cal_mclk(struct mtk_base_afe *afe,
> > +				struct mtk_afe_tdm_priv *tdm_priv,
> > +				int freq)
> > +{
> > +	int apll;
> > +	int apll_rate;
> > +
> > +	apll = mt8186_get_apll_by_rate(afe, freq);
> > +	apll_rate = mt8186_get_apll_rate(afe, apll);
> > +
> > +	if (!freq || freq > apll_rate) {
> > +		dev_info(afe->dev,
> > +			 "%s(), freq(%d Hz) invalid\n", __func__,
> > freq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (apll_rate % freq != 0) {
> > +		dev_info(afe->dev,
> > +			 "%s(), APLL cannot generate %d Hz", __func__,
> > freq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	tdm_priv->mclk_rate = freq;
> > +	tdm_priv->mclk_apll = apll;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_dai_tdm_hw_params(struct snd_pcm_substream
> > *substream,
> > +				 struct snd_pcm_hw_params *params,
> > +				 struct snd_soc_dai *dai)
> > +{
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int tdm_id = dai->id;
> > +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[tdm_id];
> > +	unsigned int tdm_mode = tdm_priv->tdm_mode;
> > +	unsigned int data_mode = tdm_priv->data_mode;
> > +	unsigned int rate = params_rate(params);
> > +	unsigned int channels = params_channels(params);
> > +	snd_pcm_format_t format = params_format(params);
> > +	unsigned int bit_width =
> > +		snd_pcm_format_physical_width(format);
> > +	unsigned int tdm_channels = (data_mode == TDM_DATA_ONE_PIN) ?
> > +		get_tdm_ch_per_sdata(tdm_mode, channels) : 2;
> > +	unsigned int lrck_width =
> > +		get_tdm_lrck_width(format, tdm_mode);
> > +	unsigned int tdm_con = 0;
> > +	bool slave_mode = tdm_priv->slave_mode;
> > +	bool lrck_inv = tdm_priv->lck_invert;
> > +	bool bck_inv = tdm_priv->bck_invert;
> > +	unsigned int ctrl_reg;
> > +	unsigned int ctrl_mask;
> > +	unsigned int tran_rate;
> > +	unsigned int tran_relatch_rate;
> > +
> > +	if (tdm_priv)
> > +		tdm_priv->rate = rate;
> > +	else
> > +		dev_info(afe->dev, "%s(), tdm_priv == NULL", __func__);
> > +
> > +	tran_rate = mt8186_rate_transform(afe->dev, rate, dai->id);
> > +	tran_relatch_rate = mt8186_tdm_relatch_rate_transform(afe->dev, 
> > rate);
> > +
> > +	/* calculate mclk_rate, if not set explicitly */
> > +	if (!tdm_priv->mclk_rate) {
> > +		tdm_priv->mclk_rate = rate * tdm_priv->mclk_multiple;
> > +		mtk_dai_tdm_cal_mclk(afe,
> > +				     tdm_priv,
> > +				     tdm_priv->mclk_rate);
> > +	}
> > +
> > +	/* ETDM_IN1_CON0 */
> > +	tdm_con |= slave_mode << ETDM_IN1_CON0_REG_SLAVE_MODE_SFT;
> > +	tdm_con |= tdm_mode << ETDM_IN1_CON0_REG_FMT_SFT;
> > +	tdm_con |= (bit_width - 1) << ETDM_IN1_CON0_REG_BIT_LENGTH_SFT;
> > +	tdm_con |= (bit_width - 1) <<
> > ETDM_IN1_CON0_REG_WORD_LENGTH_SFT;
> > +	tdm_con |= (tdm_channels - 1) << ETDM_IN1_CON0_REG_CH_NUM_SFT;
> > +	/* default disable sync mode */
> > +	tdm_con |= 0 << ETDM_IN1_CON0_REG_SYNC_MODE_SFT;
> 
> 0 << (anything) == 0
> 
> (number |= 0) == number
> 
> Is this a mistake, or are you really doing nothing here?
> 
No, this is just to emphasize the need to set this bit to 0.
It really do nothing here, just link a reminder.
Can I keep this sentence?
> 
> > +	/* relatch fix to h26m */
> > +	tdm_con |= 0 << ETDM_IN1_CON0_REG_RELATCH_1X_EN_SEL_DOMAIN_SFT;
> > +
> > +	ctrl_reg = ETDM_IN1_CON0;
> > +	ctrl_mask = ETDM_IN_CON0_CTRL_MASK;
> > +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
> > +
> > +	/* ETDM_IN1_CON1 */
> > +	tdm_con = 0;
> > +	tdm_con |= 0 << ETDM_IN1_CON1_REG_LRCK_AUTO_MODE_SFT;
> > +	tdm_con |= 1 << ETDM_IN1_CON1_PINMUX_MCLK_CTRL_OE_SFT;
> > +	tdm_con |= (lrck_width - 1) <<
> > ETDM_IN1_CON1_REG_LRCK_WIDTH_SFT;
> > +
> > +	ctrl_reg = ETDM_IN1_CON1;
> > +	ctrl_mask = ETDM_IN_CON1_CTRL_MASK;
> > +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
> 
> You don't need the ctrl_reg, nor ctrl_mask variables...
I was trying to avoid a line of more than 80 words, so I shortened the
number of words through variables.

> 
> regmap_update_bits(afe->regmap, ETDM_IN1_CON1,
> ETDM_IN_CON1_CTRL_MASK, tdm_con);
> 
> > +
> > +	/* ETDM_IN1_CON3 */
> > +	tdm_con = 0;
> > +	tdm_con = ETDM_IN_CON3_FS(tran_rate);
> > +
> > +	ctrl_reg = ETDM_IN1_CON3;
> > +	ctrl_mask = ETDM_IN_CON3_CTRL_MASK;
> > +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
> 
> same here
> 
> > +
> > +	/* ETDM_IN1_CON4 */
> > +	tdm_con = 0;
> > +	tdm_con = ETDM_IN_CON4_FS(tran_relatch_rate);
> > +	if (slave_mode) {
> > +		if (lrck_inv)
> > +			tdm_con |= ETDM_IN_CON4_CON0_SLAVE_LRCK_INV;
> > +		if (bck_inv)
> > +			tdm_con |= ETDM_IN_CON4_CON0_SLAVE_BCK_INV;
> > +	} else {
> > +		if (lrck_inv)
> > +			tdm_con |= ETDM_IN_CON4_CON0_MASTER_LRCK_INV;
> > +		if (bck_inv)
> > +			tdm_con |= ETDM_IN_CON4_CON0_MASTER_BCK_INV;
> > +	}
> > +
> > +	ctrl_reg = ETDM_IN1_CON4;
> > +	ctrl_mask = ETDM_IN_CON4_CTRL_MASK;
> > +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
> 
> and here
> 
> > +
> > +	/* ETDM_IN1_CON2 */
> > +	tdm_con = 0;
> > +	if (data_mode == TDM_DATA_MULTI_PIN) {
> > +		tdm_con |= ETDM_IN_CON2_MULTI_IP_2CH_MODE;
> > +		tdm_con |= ETDM_IN_CON2_MULTI_IP_CH(channels);
> > +	}
> > +
> > +	ctrl_reg = ETDM_IN1_CON2;
> > +	ctrl_mask = ETDM_IN_CON2_CTRL_MASK;
> > +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
> 
> and here
> 
> > +
> > +	/* ETDM_IN1_CON8 */
> > +	tdm_con = 0;
> > +	if (slave_mode) {
> > +		tdm_con |= 1 << ETDM_IN1_CON8_REG_ETDM_USE_AFIFO_SFT;
> > +		tdm_con |= 0 <<
> > ETDM_IN1_CON8_REG_AFIFO_CLOCK_DOMAIN_SEL_SFT;
> > +		tdm_con |= ETDM_IN_CON8_FS(tran_relatch_rate);
> > +	} else {
> > +		tdm_con |= 0 << ETDM_IN1_CON8_REG_ETDM_USE_AFIFO_SFT;
> > +	}
> > +
> > +	ctrl_reg = ETDM_IN1_CON8;
> > +	ctrl_mask = ETDM_IN_CON8_CTRL_MASK;
> > +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
> 
> finally, here too.
> 
> > +
> > +	return 0;
> > +}
> > +
> 
> Thanks,
> ANgelo


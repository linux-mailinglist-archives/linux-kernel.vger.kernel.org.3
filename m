Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241224CC0FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiCCPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiCCPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:17:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C189190C36;
        Thu,  3 Mar 2022 07:16:48 -0800 (PST)
X-UUID: 7b8c7df88d48468daf249bb20b8724b0-20220303
X-UUID: 7b8c7df88d48468daf249bb20b8724b0-20220303
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1251532998; Thu, 03 Mar 2022 23:16:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Mar 2022 23:16:42 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 23:16:41 +0800
Message-ID: <bab4302fbab4d2887e4ebd247c2da78128abaf21.camel@mediatek.com>
Subject: Re: [v2 10/17] ASoC: mediatek: mt8186: support audio clock control
 in platform driver
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
Date:   Thu, 3 Mar 2022 23:16:40 +0800
In-Reply-To: <e2d28d1a-4bbc-931d-3534-776ee18369f4@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-11-jiaxin.yu@mediatek.com>
         <e2d28d1a-4bbc-931d-3534-776ee18369f4@collabora.com>
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
> > This patch add audio clock control with CCF interface.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-afe-clk.c | 719
> > +++++++++++++++++++++
> >   sound/soc/mediatek/mt8186/mt8186-afe-clk.h | 210 ++++++
> >   2 files changed, 929 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-clk.c
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-clk.h
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
> > b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
> > new file mode 100644
> > index 000000000000..14f64b935619
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
> > @@ -0,0 +1,719 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// mt8186-afe-clk.c  --  Mediatek 8186 afe clock ctrl
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/clk.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-clk.h"
> > +#include "mt8186-audsys-clk.h"
> > +
> > +static DEFINE_MUTEX(mutex_request_dram);
> > +
> > +static const char *aud_clks[CLK_NUM] = {
> > +	[CLK_AFE] = "aud_afe_clk",
> > +	[CLK_DAC] = "aud_dac_clk",
> > +	[CLK_DAC_PREDIS] = "aud_dac_predis_clk",
> > +	[CLK_ADC] = "aud_adc_clk",
> > +	[CLK_TML] = "aud_tml_clk",
> > +	[CLK_APLL22M] = "aud_apll22m_clk",
> > +	[CLK_APLL24M] = "aud_apll24m_clk",
> > +	[CLK_APLL1_TUNER] = "aud_apll_tuner_clk",
> > +	[CLK_APLL2_TUNER] = "aud_apll2_tuner_clk",
> > +	[CLK_TDM] = "aud_tdm_clk",
> > +	[CLK_NLE] = "aud_nle_clk",
> > +	[CLK_DAC_HIRES] = "aud_dac_hires_clk",
> > +	[CLK_ADC_HIRES] = "aud_adc_hires_clk",
> > +	[CLK_I2S1_BCLK] = "aud_i2s1_bclk",
> > +	[CLK_I2S2_BCLK] = "aud_i2s2_bclk",
> > +	[CLK_I2S3_BCLK] = "aud_i2s3_bclk",
> > +	[CLK_I2S4_BCLK] = "aud_i2s4_bclk",
> > +	[CLK_CONNSYS_I2S_ASRC] = "aud_connsys_i2s_asrc",
> > +	[CLK_GENERAL1_ASRC] = "aud_general1_asrc",
> > +	[CLK_GENERAL2_ASRC] = "aud_general2_asrc",
> > +	[CLK_ADC_HIRES_TML] = "aud_adc_hires_tml",
> > +	[CLK_ADDA6_ADC] = "aud_adda6_adc",
> > +	[CLK_ADDA6_ADC_HIRES] = "aud_adda6_adc_hires",
> > +	[CLK_3RD_DAC] = "aud_3rd_dac",
> > +	[CLK_3RD_DAC_PREDIS] = "aud_3rd_dac_predis",
> > +	[CLK_3RD_DAC_TML] = "aud_3rd_dac_tml",
> > +	[CLK_3RD_DAC_HIRES] = "aud_3rd_dac_hires",
> > +	[CLK_ETDM_IN1_BCLK] = "aud_etdm_in1_bclk",
> > +	[CLK_ETDM_OUT1_BCLK] = "aud_etdm_out1_bclk",
> > +	[CLK_INFRA_SYS_AUDIO] = "aud_infra_clk",
> > +	[CLK_INFRA_AUDIO_26M] = "mtkaif_26m_clk",
> > +	[CLK_MUX_AUDIO] = "top_mux_audio",
> > +	[CLK_MUX_AUDIOINTBUS] = "top_mux_audio_int",
> > +	[CLK_TOP_MAINPLL_D2_D4] = "top_mainpll_d2_d4",
> > +	[CLK_TOP_MUX_AUD_1] = "top_mux_aud_1",
> > +	[CLK_TOP_APLL1_CK] = "top_apll1_ck",
> > +	[CLK_TOP_MUX_AUD_2] = "top_mux_aud_2",
> > +	[CLK_TOP_APLL2_CK] = "top_apll2_ck",
> > +	[CLK_TOP_MUX_AUD_ENG1] = "top_mux_aud_eng1",
> > +	[CLK_TOP_APLL1_D8] = "top_apll1_d8",
> > +	[CLK_TOP_MUX_AUD_ENG2] = "top_mux_aud_eng2",
> > +	[CLK_TOP_APLL2_D8] = "top_apll2_d8",
> > +	[CLK_TOP_MUX_AUDIO_H] = "top_mux_audio_h",
> > +	[CLK_TOP_I2S0_M_SEL] = "top_i2s0_m_sel",
> > +	[CLK_TOP_I2S1_M_SEL] = "top_i2s1_m_sel",
> > +	[CLK_TOP_I2S2_M_SEL] = "top_i2s2_m_sel",
> > +	[CLK_TOP_I2S4_M_SEL] = "top_i2s4_m_sel",
> > +	[CLK_TOP_TDM_M_SEL] = "top_tdm_m_sel",
> > +	[CLK_TOP_APLL12_DIV0] = "top_apll12_div0",
> > +	[CLK_TOP_APLL12_DIV1] = "top_apll12_div1",
> > +	[CLK_TOP_APLL12_DIV2] = "top_apll12_div2",
> > +	[CLK_TOP_APLL12_DIV4] = "top_apll12_div4",
> > +	[CLK_TOP_APLL12_DIV_TDM] = "top_apll12_div_tdm",
> > +	[CLK_CLK26M] = "top_clk26m_clk",
> > +};
> > +
> > +int mt8186_set_audio_int_bus_parent(struct mtk_base_afe *afe,
> > +				    int clk_id)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret;
> > +
> > +	ret = clk_set_parent(afe_priv->clk[CLK_MUX_AUDIOINTBUS],
> > +			     afe_priv->clk[clk_id]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
> > +			 __func__, aud_clks[CLK_MUX_AUDIOINTBUS],
> > +			 aud_clks[clk_id], ret);
> 
> 		dev_err(......)
> 		return ret;
> 
> > +	}
> > +
> 
> 	return 0;
> 
> > +	return ret;
> > +}
> > +
> > +static int apll1_mux_setting(struct mtk_base_afe *afe, bool
> > enable)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret = 0;
> > +
> > +	if (enable) {
> > +		ret = clk_prepare_enable(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_1]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_prepare_enable %s
> > fail %d\n",
> > +				 __func__, aud_clks[CLK_TOP_MUX_AUD_1],
> > ret);
> > +			goto EXIT;
> > +		}
> > +		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_1],
> > +				     afe_priv->clk[CLK_TOP_APLL1_CK]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__, aud_clks[CLK_TOP_MUX_AUD_1],
> > +				 aud_clks[CLK_TOP_APLL1_CK], ret);
> 
> dev_err()
> 
> > +			goto EXIT;
> > +		}
> > +
> > +		/* 180.6336 / 8 = 22.5792MHz */
> > +		ret = clk_prepare_enable(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG1]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_prepare_enable %s
> > fail %d\n",
> > +				 __func__,
> > aud_clks[CLK_TOP_MUX_AUD_ENG1], ret);
> > +			goto EXIT;
> > +		}
> > +		ret = clk_set_parent(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG1],
> > +				     afe_priv->clk[CLK_TOP_APLL1_D8]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__,
> > aud_clks[CLK_TOP_MUX_AUD_ENG1],
> > +				 aud_clks[CLK_TOP_APLL1_D8], ret);
> > +			goto EXIT;
> > +		}
> > +	} else {
> > +		ret = clk_set_parent(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG1],
> > +				     afe_priv->clk[CLK_CLK26M]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__,
> > aud_clks[CLK_TOP_MUX_AUD_ENG1],
> > +				 aud_clks[CLK_CLK26M], ret);
> > +			goto EXIT;
> > +		}
> > +		clk_disable_unprepare(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG1]);
> > +
> > +		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_1],
> > +				     afe_priv->clk[CLK_CLK26M]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__, aud_clks[CLK_TOP_MUX_AUD_1],
> > +				 aud_clks[CLK_CLK26M], ret);
> > +			goto EXIT;
> > +		}
> > +		clk_disable_unprepare(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_1]);
> > +	}
> > +EXIT:
> > +	return 0;
> 
> You're returning 0 even in error cases, this is wrong.
Thanka for your careful review. I will fix this issue in next version.

> 
> > +}
> > +
> > +static int apll2_mux_setting(struct mtk_base_afe *afe, bool
> > enable)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret = 0;
> > +
> > +	if (enable) {
> > +		ret = clk_prepare_enable(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_2]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_prepare_enable %s
> > fail %d\n",
> > +				 __func__, aud_clks[CLK_TOP_MUX_AUD_2],
> > ret);
> > +			goto EXIT;
> > +		}
> > +		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_2],
> > +				     afe_priv->clk[CLK_TOP_APLL2_CK]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__, aud_clks[CLK_TOP_MUX_AUD_2],
> > +				 aud_clks[CLK_TOP_APLL2_CK], ret);
> > +			goto EXIT;
> > +		}
> > +
> > +		/* 196.608 / 8 = 24.576MHz */
> > +		ret = clk_prepare_enable(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG2]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_prepare_enable %s
> > fail %d\n",
> > +				 __func__,
> > aud_clks[CLK_TOP_MUX_AUD_ENG2], ret);
> > +			goto EXIT;
> > +		}
> > +		ret = clk_set_parent(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG2],
> > +				     afe_priv->clk[CLK_TOP_APLL2_D8]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__,
> > aud_clks[CLK_TOP_MUX_AUD_ENG2],
> > +				 aud_clks[CLK_TOP_APLL2_D8], ret);
> > +			goto EXIT;
> > +		}
> > +	} else {
> > +		ret = clk_set_parent(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG2],
> > +				     afe_priv->clk[CLK_CLK26M]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__,
> > aud_clks[CLK_TOP_MUX_AUD_ENG2],
> > +				 aud_clks[CLK_CLK26M], ret);
> > +			goto EXIT;
> > +		}
> > +		clk_disable_unprepare(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_ENG2]);
> > +
> > +		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_2],
> > +				     afe_priv->clk[CLK_CLK26M]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__, aud_clks[CLK_TOP_MUX_AUD_2],
> > +				 aud_clks[CLK_CLK26M], ret);
> > +			goto EXIT;
> > +		}
> > +		clk_disable_unprepare(afe_priv-
> > >clk[CLK_TOP_MUX_AUD_2]);
> > +	}
> > +
> > +EXIT:
> > +	return 0;
> > +}
> > +
> > +int mt8186_afe_enable_cgs(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret = 0;
> > +	int i;
> > +
> > +	for (i = CLK_I2S1_BCLK; i <= CLK_ETDM_OUT1_BCLK; i++) {
> > +		ret = clk_prepare_enable(afe_priv->clk[i]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s clk_prepare_enable %s
> > fail %d\n",
> > +				 __func__, aud_clks[i], ret);
> 
> dev_err()
> 
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void mt8186_afe_disable_cgs(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int i;
> > +
> > +	for (i = CLK_I2S1_BCLK; i <= CLK_ETDM_OUT1_BCLK; i++)
> > +		clk_disable_unprepare(afe_priv->clk[i]);
> > +}
> > +
> > +int mt8186_afe_enable_clock(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret = 0;
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_INFRA_SYS_AUDIO], ret);
> 
> dev_err()
> 
> > +		goto CLK_INFRA_SYS_AUDIO_ERR;
> 
> also, please use lower-case labels (here and everywhere else).
> 
> > +	}
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_INFRA_AUDIO_26M]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_INFRA_AUDIO_26M], ret);
> > +		goto CLK_INFRA_AUDIO_26M_ERR;
> > +	}
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_MUX_AUDIO]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_MUX_AUDIO], ret);
> > +		goto CLK_MUX_AUDIO_ERR;
> > +	}
> > +	ret = clk_set_parent(afe_priv->clk[CLK_MUX_AUDIO],
> > +			     afe_priv->clk[CLK_CLK26M]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
> > +			 __func__, aud_clks[CLK_MUX_AUDIO],
> > +			 aud_clks[CLK_CLK26M], ret);
> > +		goto CLK_MUX_AUDIO_ERR;
> > +	}
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_MUX_AUDIOINTBUS], ret);
> > +		goto CLK_MUX_AUDIO_INTBUS_ERR;
> > +	}
> > +	ret = mt8186_set_audio_int_bus_parent(afe,
> > +					      CLK_TOP_MAINPLL_D2_D4);
> > +	if (ret)
> > +		goto CLK_MUX_AUDIO_INTBUS_PARENT_ERR;
> > +
> > +	ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUDIO_H],
> > +			     afe_priv->clk[CLK_TOP_APLL2_CK]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
> > +			 __func__, aud_clks[CLK_TOP_MUX_AUDIO_H],
> > +			 aud_clks[CLK_TOP_APLL2_CK], ret);
> > +		goto CLK_MUX_AUDIO_H_PARENT_ERR;
> > +	}
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_AFE]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_AFE], ret);
> > +		goto CLK_AFE_ERR;
> > +	}
> > +
> > +	return 0;
> > +
> > +CLK_AFE_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_AFE]);
> > +CLK_MUX_AUDIO_H_PARENT_ERR:
> > +CLK_MUX_AUDIO_INTBUS_PARENT_ERR:
> > +	mt8186_set_audio_int_bus_parent(afe, CLK_CLK26M);
> > +CLK_MUX_AUDIO_INTBUS_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +CLK_MUX_AUDIO_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIO]);
> > +CLK_INFRA_SYS_AUDIO_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
> > +CLK_INFRA_AUDIO_26M_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_INFRA_AUDIO_26M]);
> > +
> > +	return ret;
> > +}
> > +
> > +void mt8186_afe_disable_clock(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	clk_disable_unprepare(afe_priv->clk[CLK_AFE]);
> > +	mt8186_set_audio_int_bus_parent(afe, CLK_CLK26M);
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIO]);
> > +	clk_disable_unprepare(afe_priv->clk[CLK_INFRA_AUDIO_26M]);
> > +	clk_disable_unprepare(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
> > +}
> > +
> > +int mt8186_afe_suspend_clock(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret;
> > +
> > +	/* set audio int bus to 26M */
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_MUX_AUDIOINTBUS], ret);
> 
> dev_err() - here and for the other similar instances.
> 
> > +		goto CLK_MUX_AUDIO_INTBUS_ERR;
> > +	}
> > +	ret = mt8186_set_audio_int_bus_parent(afe, CLK_CLK26M);
> > +	if (ret)
> > +		goto CLK_MUX_AUDIO_INTBUS_PARENT_ERR;
> > +
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +
> > +	return 0;
> > +
> > +CLK_MUX_AUDIO_INTBUS_PARENT_ERR:
> > +	mt8186_set_audio_int_bus_parent(afe, CLK_TOP_MAINPLL_D2_D4);
> > +CLK_MUX_AUDIO_INTBUS_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +	return ret;
> > +}
> > +
> > +int mt8186_afe_resume_clock(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret;
> > +
> > +	/* set audio int bus to normal working clock */
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_MUX_AUDIOINTBUS], ret);
> > +		goto CLK_MUX_AUDIO_INTBUS_ERR;
> > +	}
> > +	ret = mt8186_set_audio_int_bus_parent(afe,
> > +					      CLK_TOP_MAINPLL_D2_D4);
> > +	if (ret)
> > +		goto CLK_MUX_AUDIO_INTBUS_PARENT_ERR;
> > +
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +
> > +	return 0;
> > +
> > +CLK_MUX_AUDIO_INTBUS_PARENT_ERR:
> > +	mt8186_set_audio_int_bus_parent(afe, CLK_CLK26M);
> > +CLK_MUX_AUDIO_INTBUS_ERR:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
> > +	return ret;
> > +}
> > +
> > +int mt8186_apll1_enable(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret;
> > +
> > +	/* setting for APLL */
> > +	apll1_mux_setting(afe, true);
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL22M]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_APLL22M], ret);
> > +		goto ERR_CLK_APLL22M;
> > +	}
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL1_TUNER]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_APLL1_TUNER], ret);
> > +		goto ERR_CLK_APLL1_TUNER;
> > +	}
> > +
> > +	regmap_update_bits(afe->regmap, AFE_APLL1_TUNER_CFG,
> > +			   0x0000FFF7, 0x00000832);
> 
> no leading zeroes - and without them, it fits in one line.
> 
> > +	regmap_update_bits(afe->regmap, AFE_APLL1_TUNER_CFG, 0x1, 0x1);
> > +
> > +	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
> > +			   AFE_22M_ON_MASK_SFT,
> > +			   0x1 << AFE_22M_ON_SFT);
> 
> BIT() macro please
> 
> > +
> > +	return 0;
> > +
> > +ERR_CLK_APLL1_TUNER:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL1_TUNER]);
> > +ERR_CLK_APLL22M:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL22M]);
> > +
> > +	return ret;
> > +}
> > +
> > +void mt8186_apll1_disable(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
> > +			   AFE_22M_ON_MASK_SFT,
> > +			   0x0 << AFE_22M_ON_SFT);
> > +
> > +	regmap_update_bits(afe->regmap, AFE_APLL1_TUNER_CFG, 0x1, 0x0);
> > +
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL1_TUNER]);
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL22M]);
> > +
> > +	apll1_mux_setting(afe, false);
> > +}
> > +
> > +int mt8186_apll2_enable(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret;
> > +
> > +	/* setting for APLL */
> > +	apll2_mux_setting(afe, true);
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL24M]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_APLL24M], ret);
> > +		goto ERR_CLK_APLL24M;
> > +	}
> > +
> > +	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL2_TUNER]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[CLK_APLL2_TUNER], ret);
> > +		goto ERR_CLK_APLL2_TUNER;
> > +	}
> > +
> > +	regmap_update_bits(afe->regmap, AFE_APLL2_TUNER_CFG,
> > +			   0x0000FFF7, 0x00000634);
> > +	regmap_update_bits(afe->regmap, AFE_APLL2_TUNER_CFG, 0x1, 0x1);
> > +
> > +	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
> > +			   AFE_24M_ON_MASK_SFT,
> > +			   0x1 << AFE_24M_ON_SFT);
> > +
> > +	return 0;
> > +
> > +ERR_CLK_APLL2_TUNER:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL2_TUNER]);
> > +ERR_CLK_APLL24M:
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL24M]);
> > +
> > +	return ret;
> > +}
> > +
> > +void mt8186_apll2_disable(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
> > +			   AFE_24M_ON_MASK_SFT,
> > +			   0x0 << AFE_24M_ON_SFT);
> > +
> > +	regmap_update_bits(afe->regmap, AFE_APLL2_TUNER_CFG, 0x1, 0x0);
> > +
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL2_TUNER]);
> > +	clk_disable_unprepare(afe_priv->clk[CLK_APLL24M]);
> > +
> > +	apll2_mux_setting(afe, false);
> > +}
> > +
> > +int mt8186_get_apll_rate(struct mtk_base_afe *afe, int apll)
> > +{
> > +	return (apll == MT8186_APLL1) ? 180633600 : 196608000;
> > +}
> > +
> > +int mt8186_get_apll_by_rate(struct mtk_base_afe *afe, int rate)
> > +{
> > +	return ((rate % 8000) == 0) ? MT8186_APLL2 : MT8186_APLL1;
> > +}
> > +
> > +int mt8186_get_apll_by_name(struct mtk_base_afe *afe, const char
> > *name)
> > +{
> > +	if (strcmp(name, APLL1_W_NAME) == 0)
> > +		return MT8186_APLL1;
> > +	else
> > +		return MT8186_APLL2;
> > +}
> > +
> > +/* mck */
> > +struct mt8186_mck_div {
> > +	int m_sel_id;
> > +	int div_clk_id;
> > +	/* below will be deprecated */
> > +	int div_pdn_reg;
> > +	int div_pdn_mask_sft;
> > +	int div_reg;
> > +	int div_mask_sft;
> > +	int div_mask;
> > +	int div_sft;
> > +	int div_msb_reg;
> > +	int div_msb_mask_sft;
> > +	int div_msb_mask;
> > +	int div_msb_sft;
> > +	int div_apll_sel_reg;
> > +	int div_apll_sel_mask_sft;
> > +	int div_apll_sel_sft;
> > +	int div_inv_reg;
> > +	int div_inv_mask_sft;
> 
> 
> 
> *_reg fits in u16.
> *_mask_sft, *_sel_sft can be u32.
> 
> This would be nice to avoid wasting memory for variables that are
> larger than
> needed; besides, you're also using a signed type for a number that
> may not
> ever be less than zero.
> 
Yes, your suggestion is very correct. But I will remove some member fo
this strcut because they are not needed in audio driver.

> 
> > +};
> > +
> > +static const struct mt8186_mck_div mck_div[MT8186_MCK_NUM] = {
> > +	[MT8186_I2S0_MCK] = {
> > +		.m_sel_id = CLK_TOP_I2S0_M_SEL,
> > +		.div_clk_id = CLK_TOP_APLL12_DIV0,
> > +		.div_pdn_reg = CLK_AUDDIV_0,
> > +		.div_pdn_mask_sft = APLL12_DIV0_PDN_MASK_SFT,
> > +		.div_reg = CLK_AUDDIV_2,
> > +		.div_mask_sft = APLL12_CK_DIV0_MASK_SFT,
> > +		.div_mask = APLL12_CK_DIV0_MASK,
> > +		.div_sft = APLL12_CK_DIV0_SFT,
> > +		.div_apll_sel_reg = CLK_AUDDIV_0,
> > +		.div_apll_sel_mask_sft = APLL_I2S0_MCK_SEL_MASK_SFT,
> > +		.div_apll_sel_sft = APLL_I2S0_MCK_SEL_SFT,
> > +	},
> > +	[MT8186_I2S1_MCK] = {
> > +		.m_sel_id = CLK_TOP_I2S1_M_SEL,
> > +		.div_clk_id = CLK_TOP_APLL12_DIV1,
> > +		.div_pdn_reg = CLK_AUDDIV_0,
> > +		.div_pdn_mask_sft = APLL12_DIV1_PDN_MASK_SFT,
> > +		.div_reg = CLK_AUDDIV_2,
> > +		.div_mask_sft = APLL12_CK_DIV1_MASK_SFT,
> > +		.div_mask = APLL12_CK_DIV1_MASK,
> > +		.div_sft = APLL12_CK_DIV1_SFT,
> > +		.div_apll_sel_reg = CLK_AUDDIV_0,
> > +		.div_apll_sel_mask_sft = APLL_I2S1_MCK_SEL_MASK_SFT,
> > +		.div_apll_sel_sft = APLL_I2S1_MCK_SEL_SFT,
> > +	},
> > +	[MT8186_I2S2_MCK] = {
> > +		.m_sel_id = CLK_TOP_I2S2_M_SEL,
> > +		.div_clk_id = CLK_TOP_APLL12_DIV2,
> > +		.div_pdn_reg = CLK_AUDDIV_0,
> > +		.div_pdn_mask_sft = APLL12_DIV2_PDN_MASK_SFT,
> > +		.div_reg = CLK_AUDDIV_2,
> > +		.div_mask_sft = APLL12_CK_DIV2_MASK_SFT,
> > +		.div_mask = APLL12_CK_DIV2_MASK,
> > +		.div_sft = APLL12_CK_DIV2_SFT,
> > +		.div_apll_sel_reg = CLK_AUDDIV_0,
> > +		.div_apll_sel_mask_sft = APLL_I2S2_MCK_SEL_MASK_SFT,
> > +		.div_apll_sel_sft = APLL_I2S2_MCK_SEL_SFT,
> > +	},
> > +	[MT8186_I2S4_MCK] = {
> > +		.m_sel_id = CLK_TOP_I2S4_M_SEL,
> > +		.div_clk_id = CLK_TOP_APLL12_DIV4,
> > +		.div_pdn_reg = CLK_AUDDIV_0,
> > +		.div_pdn_mask_sft = APLL12_DIV4_PDN_MASK_SFT,
> > +		.div_reg = CLK_AUDDIV_2,
> > +		.div_mask_sft = APLL12_CK_DIV4_MASK_SFT,
> > +		.div_mask = APLL12_CK_DIV4_MASK,
> > +		.div_sft = APLL12_CK_DIV4_SFT,
> > +		.div_apll_sel_reg = CLK_AUDDIV_0,
> > +		.div_apll_sel_mask_sft = APLL_I2S4_MCK_SEL_MASK_SFT,
> > +		.div_apll_sel_sft = APLL_I2S4_MCK_SEL_SFT,
> > +	},
> > +	[MT8186_TDM_MCK] = {
> > +		.m_sel_id = CLK_TOP_TDM_M_SEL,
> > +		.div_clk_id = CLK_TOP_APLL12_DIV_TDM,
> > +		.div_pdn_reg = CLK_AUDDIV_0,
> > +		.div_pdn_mask_sft = APLL12_DIV_TDM_PDN_MASK_SFT,
> > +		.div_reg = CLK_AUDDIV_3,
> > +		.div_mask_sft = APLL12_CK_DIV_TDM_MASK_SFT,
> > +		.div_mask = APLL12_CK_DIV_TDM_MASK,
> > +		.div_sft = APLL12_CK_DIV_TDM_SFT,
> > +		.div_apll_sel_reg = CLK_AUDDIV_0,
> > +		.div_apll_sel_mask_sft = APLL_TDM_MCK_SEL_MASK_SFT,
> > +		.div_apll_sel_sft = APLL_TDM_MCK_SEL_SFT,
> > +	},
> > +};
> > +
> > +int mt8186_mck_enable(struct mtk_base_afe *afe, int mck_id, int
> > rate)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int apll = mt8186_get_apll_by_rate(afe, rate);
> > +	int apll_clk_id = apll == MT8186_APLL1 ?
> > +			  CLK_TOP_MUX_AUD_1 : CLK_TOP_MUX_AUD_2;
> > +	int m_sel_id = mck_div[mck_id].m_sel_id;
> > +	int div_clk_id = mck_div[mck_id].div_clk_id;
> > +	int ret;
> > +
> > +	/* select apll */
> > +	if (m_sel_id >= 0) {
> > +		ret = clk_prepare_enable(afe_priv->clk[m_sel_id]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s(), clk_prepare_enable %s
> > fail %d\n",
> > +				 __func__, aud_clks[m_sel_id], ret);
> 
> dev_err()
> 
> > +			return ret;
> > +		}
> > +		ret = clk_set_parent(afe_priv->clk[m_sel_id],
> > +				     afe_priv->clk[apll_clk_id]);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s(), clk_set_parent %s-%s
> > fail %d\n",
> > +				 __func__, aud_clks[m_sel_id],
> > +				aud_clks[apll_clk_id], ret);
> 
> again
> 
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* enable div, set rate */
> > +	ret = clk_prepare_enable(afe_priv->clk[div_clk_id]);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s(), clk_prepare_enable %s fail
> > %d\n",
> > +			 __func__, aud_clks[div_clk_id], ret);
> 
> again
> 
> > +		return ret;
> > +	}
> > +	ret = clk_set_rate(afe_priv->clk[div_clk_id], rate);
> > +	if (ret) {
> > +		dev_info(afe->dev, "%s(), clk_set_rate %s, rate %d,
> > fail %d\n",
> > +			 __func__, aud_clks[div_clk_id],
> > +			 rate, ret);
> 
> again - and this fits in two lines.
> 
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void mt8186_mck_disable(struct mtk_base_afe *afe, int mck_id)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int m_sel_id = mck_div[mck_id].m_sel_id;
> > +	int div_clk_id = mck_div[mck_id].div_clk_id;
> > +
> > +	clk_disable_unprepare(afe_priv->clk[div_clk_id]);
> > +	if (m_sel_id >= 0)
> > +		clk_disable_unprepare(afe_priv->clk[m_sel_id]);
> > +}
> > +
> > +int mt8186_init_clock(struct mtk_base_afe *afe)
> > +{
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	struct device_node *of_node = afe->dev->of_node;
> > +	int i = 0;
> > +
> > +	 mt8186_audsys_clk_register(afe);
> 
> Fix indentation please
> 
> > +
> > +	afe_priv->clk = devm_kcalloc(afe->dev, CLK_NUM,
> > sizeof(*afe_priv->clk),
> > +				     GFP_KERNEL);
> > +	if (!afe_priv->clk)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < CLK_NUM; i++) {
> > +		afe_priv->clk[i] = devm_clk_get(afe->dev, aud_clks[i]);
> > +		if (IS_ERR(afe_priv->clk[i])) {
> > +			dev_info(afe->dev, "%s devm_clk_get %s fail,
> > ret %ld\n",
> > +				 __func__,
> > +				 aud_clks[i], PTR_ERR(afe_priv-
> > >clk[i]));
> > +			afe_priv->clk[i] = NULL;
> > +		}
> > +	}
> > +
> > +	afe_priv->apmixedsys = syscon_regmap_lookup_by_phandle(of_node,
> > +							       "mediate
> > k,apmixedsys");
> > +	if (IS_ERR(afe_priv->apmixedsys)) {
> > +		dev_err(afe->dev, "%s() Cannot find apmixedsys
> > controller: %ld\n",
> > +			__func__, PTR_ERR(afe_priv->apmixedsys));
> > +		return PTR_ERR(afe_priv->apmixedsys);
> > +	}
> > +
> > +	afe_priv->topckgen = syscon_regmap_lookup_by_phandle(of_node,
> > +							     "mediatek,
> > topckgen");
> > +	if (IS_ERR(afe_priv->topckgen)) {
> > +		dev_err(afe->dev, "%s() Cannot find topckgen
> > controller: %ld\n",
> > +			__func__, PTR_ERR(afe_priv->topckgen));
> > +		return PTR_ERR(afe_priv->topckgen);
> > +	}
> > +
> > +	afe_priv->infracfg = syscon_regmap_lookup_by_phandle(of_node,
> > +							     "mediatek,
> > infracfg");
> > +	if (IS_ERR(afe_priv->infracfg)) {
> > +		dev_err(afe->dev, "%s() Cannot find infracfg: %ld\n",
> > +			__func__, PTR_ERR(afe_priv->infracfg));
> > +		return PTR_ERR(afe_priv->infracfg);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void mt8186_deinit_clock(struct mtk_base_afe *afe)
> > +{
> > +	mt8186_audsys_clk_unregister(afe);
> > +}
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
> > b/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
> > new file mode 100644
> > index 000000000000..3ce7a9a24d4a
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.h
> > @@ -0,0 +1,210 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * mt8186-afe-clk.h  --  Mediatek 8186 afe clock ctrl definition
> > + *
> > + * Copyright (c) 2022 MediaTek Inc.
> > + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > + */
> > +
> > +#ifndef _MT8186_AFE_CLOCK_CTRL_H_
> > +#define _MT8186_AFE_CLOCK_CTRL_H_
> > +
> > +#define PERI_BUS_DCM_CTRL 0x0074
> > +#define MODULE_SW_CG_1_STA 0x0094
> > +#define MODULE_SW_CG_2_STA 0x00ac
> > +#define CLK_CFG_7 0x0080
> > +#define CLK_CFG_8 0x0090
> > +#define CLK_CFG_11 0x00c0
> > +#define CLK_CFG_12 0x00d0
> > +#define CLK_CFG_13 0x00e0
> > +#define CLK_CFG_15 0x0100
> > +#define AP_PLL_CON3 0x0014
> > +#define APLL1_CON4 0x0328
> > +#define APLL1_TUNER_CON0 0x0040
> > +#define APLL2_CON4 0x033c
> > +#define APLL2_TUNER_CON0 0x0044
> > +
> > +#define AP_PLL_CON5 0x0014
> > +#define APLL1_CON0 0x02c0
> > +#define APLL1_CON1 0x02c4
> > +#define APLL1_CON2 0x02c8
> > +#define APLL1_CON3 0x02cc
> > +#define APLL1_PWR_CON0 0x02d0
> > +
> > +#define APLL2_CON0 0x02d4
> > +#define APLL2_CON1 0x02d8
> > +#define APLL2_CON2 0x02dc
> > +#define APLL2_CON3 0x02e0
> > +#define APLL2_PWR_CON0 0x02e4
> > +
> > +#define APMIXEDSYS_MAX_LENGTH APLL2_PWR_CON0
> > +
> > +#define CLK_CFG_6 0x0080
> > +#define CLK_AUDDIV_0 0x0320
> > +#define CLK_AUDDIV_1 0x0324
> > +#define CLK_AUDDIV_2 0x0328
> > +#define CKSYS_AUD_TOP_CFG 0x032c
> > +#define CKSYS_AUD_TOP_MON 0x0330
> > +#define CLK_AUDDIV_3 0x0334
> > +
> > +#define CLK_MAX_LENGTH CLK_AUDDIV_3
> > +
> > +/* CLK_CFG_6 */
> > +#define CLK_AUD_INTBUS_SEL_SFT              16
> > +#define CLK_AUD_INTBUS_SEL_MASK             0x3
> > +#define CLK_AUD_INTBUS_SEL_MASK_SFT         (0x3 << 16)
> 
> #define CLK_AUD_INTBUS_SEL_MASK_SFT		GENMASK(23, 22)
> 
I will remove these define because they are not used in audio driver.

> > +
> > +/* CLK_AUDDIV_0 */
> > +#define APLL12_DIV0_PDN_SFT                0
> > +#define APLL12_DIV0_PDN_MASK               0x1
> > +#define APLL12_DIV0_PDN_MASK_SFT           (0x1 << 0)
> 
> BIT() macro please
same

> 
> #define APLL12_DIV0_PDN_MASK_SFT		BIT(0)
> 
> also, using tabulations instead of spaces is nicer.
> 
> > +#define APLL12_DIV1_PDN_SFT                1
> > +#define APLL12_DIV1_PDN_MASK               0x1
> > +#define APLL12_DIV1_PDN_MASK_SFT           (0x1 << 1)
> 
> Of course, BIT() macro again, here and everywhere else applicable.
Yes, you are right.

> 
> > +#define APLL12_DIV2_PDN_SFT                2
> > +#define APLL12_DIV2_PDN_MASK               0x1
> > +#define APLL12_DIV2_PDN_MASK_SFT           (0x1 << 2)
> > +#define APLL12_DIV4_PDN_SFT                3
> > +#define APLL12_DIV4_PDN_MASK               0x1
> > +#define APLL12_DIV4_PDN_MASK_SFT           (0x1 << 3)
> > +#define APLL12_DIV_TDM_PDN_SFT             4
> > +#define APLL12_DIV_TDM_PDN_MASK            0x1
> > +#define APLL12_DIV_TDM_PDN_MASK_SFT        (0x1 << 4)
> > +#define APLL_I2S0_MCK_SEL_SFT              16
> > +#define APLL_I2S0_MCK_SEL_MASK             0x1
> > +#define APLL_I2S0_MCK_SEL_MASK_SFT         (0x1 << 16)
> > +#define APLL_I2S1_MCK_SEL_SFT              17
> > +#define APLL_I2S1_MCK_SEL_MASK             0x1
> > +#define APLL_I2S1_MCK_SEL_MASK_SFT         (0x1 << 17)
> > +#define APLL_I2S2_MCK_SEL_SFT              18
> > +#define APLL_I2S2_MCK_SEL_MASK             0x1
> > +#define APLL_I2S2_MCK_SEL_MASK_SFT         (0x1 << 17)
> > +#define APLL_I2S4_MCK_SEL_SFT              19
> > +#define APLL_I2S4_MCK_SEL_MASK             0x1
> > +#define APLL_I2S4_MCK_SEL_MASK_SFT         (0x1 << 19)
> > +#define APLL_TDM_MCK_SEL_SFT               20
> > +#define APLL_TDM_MCK_SEL_MASK              0x1
> > +#define APLL_TDM_MCK_SEL_MASK_SFT          (0x1 << 20)
> > +
> > +/* CLK_AUDDIV_2 */
> > +#define APLL12_CK_DIV0_SFT                 0
> > +#define APLL12_CK_DIV0_MASK                0xff
> > +#define APLL12_CK_DIV0_MASK_SFT            (0xff << 0)
> 
> GENMASK(7, 0)
> 
> > +#define APLL12_CK_DIV1_SFT                 8
> > +#define APLL12_CK_DIV1_MASK                0xff
> > +#define APLL12_CK_DIV1_MASK_SFT            (0xff << 8)
> 
> GENMASK(15, 8)
> 
> > +#define APLL12_CK_DIV2_SFT                 16
> > +#define APLL12_CK_DIV2_MASK                0xff
> > +#define APLL12_CK_DIV2_MASK_SFT            (0xff << 16)
> 
> Fix all the others too :))
> 
> > +#define APLL12_CK_DIV4_SFT                 24
> > +#define APLL12_CK_DIV4_MASK                0xff
> > +#define APLL12_CK_DIV4_MASK_SFT            (0xff << 24)
> > +
> > +/* CLK_AUDDIV_3 */
> > +#define APLL12_CK_DIV_TDM_SFT              0
> > +#define APLL12_CK_DIV_TDM_MASK             0xff
> > +#define APLL12_CK_DIV_TDM_MASK_SFT         (0xff << 0)
> > +
> > +/* AUD_TOP_CFG */
> > +#define AUD_TOP_CFG_SFT                    0
> > +#define AUD_TOP_CFG_MASK                   0xffffffff
> > +#define AUD_TOP_CFG_MASK_SFT               (0xffffffff << 0)
> 
> This is GENMASK(31, 0) for both MASK and MASK_SFT
> 
> > +
> > +/* AUD_TOP_MON */
> > +#define AUD_TOP_MON_SFT                    0
> > +#define AUD_TOP_MON_MASK                   0xffffffff
> > +#define AUD_TOP_MON_MASK_SFT               (0xffffffff << 0)
> 
> same here
> 
> 
> 
> Regards,
> Angelo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF644CE44B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiCEKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 05:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 05:50:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C123D1A9;
        Sat,  5 Mar 2022 02:49:40 -0800 (PST)
X-UUID: 0c607429cdc248c09512541e15b67ac7-20220305
X-UUID: 0c607429cdc248c09512541e15b67ac7-20220305
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1926967289; Sat, 05 Mar 2022 18:49:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 5 Mar 2022 18:49:34 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 18:49:33 +0800
Message-ID: <5aca64866e5441d21aaf0293a1e48286acfdd978.camel@mediatek.com>
Subject: Re: [v2 03/17] ASoC: mediatek: mt8186: support adda in platform
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
Date:   Sat, 5 Mar 2022 18:49:33 +0800
In-Reply-To: <0e633e93-566d-0a91-f5e3-f3e3131fcb43@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-4-jiaxin.yu@mediatek.com>
         <0e633e93-566d-0a91-f5e3-f3e3131fcb43@collabora.com>
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
> > This patch adds mt8186 adda dai driver
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 891
> > ++++++++++++++++++++
> >   1 file changed, 891 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > new file mode 100644
> > index 000000000000..6d7dd1533da0
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > @@ -0,0 +1,891 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// MediaTek ALSA SoC Audio DAI ADDA Control
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/regmap.h>
> > +#include <linux/delay.h>
> > +#include "mt8186-afe-clk.h"
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-gpio.h"
> > +#include "mt8186-interconnection.h"
> > +
...snip...
> > 
> > +/* dai ops */
> > +static int mtk_dai_adda_hw_params(struct snd_pcm_substream
> > *substream,
> > +				  struct snd_pcm_hw_params *params,
> > +				  struct snd_soc_dai *dai)
> > +{
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	unsigned int rate = params_rate(params);
> > +	int id = dai->id;
> > +	struct mtk_afe_adda_priv *adda_priv = afe_priv->dai_priv[id];
> > +
> > +	dev_info(afe->dev, "%s(), id %d, stream %d, rate %d\n",
> > +		 __func__,
> > +		 id,
> > +		 substream->stream,
> > +		 rate);
> > +
> > +	if (!adda_priv) {
> > +		dev_info(afe->dev, "%s(), adda_priv == NULL",
> > __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> > +		unsigned int dl_src2_con0 = 0;
> > +		unsigned int dl_src2_con1 = 0;
> 
> This initialization is redundant: you're never using these variables
> before initializing them later, so initializing them to zero is not
> needed here.
Yes, got it. Thank you.
> 
> > +
> > +		adda_priv->dl_rate = rate;
> > +
> > +		/* set sampling rate */
> > +		dl_src2_con0 = adda_dl_rate_transform(afe, rate) <<
> > +			       DL_2_INPUT_MODE_CTL_SFT;
> > +
> > +		/* set output mode, UP_SAMPLING_RATE_X8 */
> > +		dl_src2_con0 |= (0x3 << DL_2_OUTPUT_SEL_CTL_SFT);
> > +
> > +		/* turn off mute function */
> > +		dl_src2_con0 |= (0x01 <<
> > DL_2_MUTE_CH2_OFF_CTL_PRE_SFT);
> 
> BIT() macro, please
> 
> > +		dl_src2_con0 |= (0x01 <<
> > DL_2_MUTE_CH1_OFF_CTL_PRE_SFT);
> > +
> > +		/* set voice input data if input sample rate is 8k or
> > 16k */
> > +		if (rate == 8000 || rate == 16000)
> > +			dl_src2_con0 |= 0x01 <<
> > DL_2_VOICE_MODE_CTL_PRE_SFT;
> > +
> > +		/* SA suggest apply -0.3db to audio/speech path */
> > +		dl_src2_con1 = MTK_AFE_ADDA_DL_GAIN_NORMAL <<
> > +			       DL_2_GAIN_CTL_PRE_SFT;
> > +
> > +		/* turn on down-link gain */
> > +		dl_src2_con0 |= (0x01 << DL_2_GAIN_ON_CTL_PRE_SFT);
> > +
> > +		if (id == MT8186_DAI_ADDA) {
> > +			/* clean predistortion */
> > +			regmap_write(afe->regmap, AFE_ADDA_PREDIS_CON0,
> > 0);
> > +			regmap_write(afe->regmap, AFE_ADDA_PREDIS_CON1,
> > 0);
> > +
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_DL_SRC2_CON0,
> > dl_src2_con0);
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_DL_SRC2_CON1,
> > dl_src2_con1);
> > +
> > +			/* set sdm gain */
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_DL_SDM_DCCOMP_CON,
> > +					   ATTGAIN_CTL_MASK_SFT,
> > +					   AUDIO_SDM_LEVEL_NORMAL <<
> > +					   ATTGAIN_CTL_SFT);
> > +
> > +			/* Use new 2nd sdm */
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_DL_SDM_DITHER_CON,
> > +					   AFE_DL_SDM_DITHER_64TAP_EN_M
> > ASK_SFT,
> > +					   0x1 <<
> > AFE_DL_SDM_DITHER_64TAP_EN_SFT);
> 
> BIT(AFE_DL_SDM_DITHER_64TAP_EN_SFT)
> 
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_DL_SDM_AUTO_RESET_C
> > ON,
> > +					   AFE_DL_USE_NEW_2ND_SDM_MASK_
> > SFT,
> > +					   0x1 <<
> > AFE_DL_USE_NEW_2ND_SDM_SFT);
> 
> BIT(AFE_DL_USE_NEW_2ND_SDM_SFT)
> 
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_DL_SDM_DCCOMP_CON,
> > +					   USE_3RD_SDM_MASK_SFT,
> > +					   AUDIO_SDM_2ND <<
> > USE_3RD_SDM_SFT);
> > +
> > +			/* sdm auto reset */
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_DL_SDM_AUTO_RESET_CON,
> > +				     SDM_AUTO_RESET_THRESHOLD);
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_DL_SDM_AUTO_RESET_C
> > ON,
> > +					   SDM_AUTO_RESET_TEST_ON_MASK_
> > SFT,
> > +					   0x1 <<
> > SDM_AUTO_RESET_TEST_ON_SFT);
> 
> BIT(SDM_AUTO_RESET_TEST_ON_SFT)
> 
> > +		}
> > +	} else {
> > +		unsigned int voice_mode = 0;
> 
> what about...
> 		unsigned int ul_src_con0 = 0; /* default value */
> 		unsigned int voice_mode =  adda_ul_rate_transform(afe,
> rate);
Agree with you.

> > +		unsigned int ul_src_con0 = 0;	/* default value */
> > +
> > +		adda_priv->ul_rate = rate;
> > +
> > +		voice_mode = adda_ul_rate_transform(afe, rate);
> > +
> > +		ul_src_con0 |= (voice_mode << 17) & (0x7 << 17);
> > +
> > +		/* enable iir */
> > +		ul_src_con0 |= (1 << UL_IIR_ON_TMP_CTL_SFT) &
> > +			       UL_IIR_ON_TMP_CTL_MASK_SFT;
> > +		ul_src_con0 |= (UL_IIR_SW << UL_IIRMODE_CTL_SFT) &
> > +			       UL_IIRMODE_CTL_MASK_SFT;
> > +		switch (id) {
> > +		case MT8186_DAI_ADDA:
> > +		case MT8186_DAI_AP_DMIC:
> > +			/* 35Hz @ 48k */
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_IIR_COEF_02_01,
> > 0x00000000);
> 
> Please drop leading zeroes:
> 
> regmap_write(afe->regmap, AFE_ADDA_IIR_COEF_02_01, 0);
> 
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_IIR_COEF_04_03,
> > 0x00003FB8);
> 
> ... and also please write hex in lower-case:
> 
Got it.
> regmap_write(afe->regmap,
> 	     AFE_ADDA_IIR_COEF_04_03, 0x03fb8);
> 
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_IIR_COEF_06_05,
> > 0x3FB80000);
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_IIR_COEF_08_07,
> > 0x3FB80000);
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_IIR_COEF_10_09,
> > 0x0000C048);
> > +
> > +			regmap_write(afe->regmap,
> > +				     AFE_ADDA_UL_SRC_CON0,
> > ul_src_con0);
> > +
> > +			/* Using Internal ADC */
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_TOP_CON0,
> > +					   0x1 << 0,
> > +					   0x0 << 0);
> 
> Please use the BIT() macro:
> 
> regmap_update_bits(afe->regmap, AFE_ADDA_TOP_CON0, BIT(0), 0);
> 
> P.S.: 87 columns is ok

How can I judge whether it can exceed 80 lines?
> 
> > +
> > +			/* mtkaif_rxif_data_mode = 0, amic */
> > +			regmap_update_bits(afe->regmap,
> > +					   AFE_ADDA_MTKAIF_RX_CFG0,
> > +					   0x1 << 0,
> > +					   0x0 << 0);
> 
> same here.
> 
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +		/* ap dmic */
> > +		switch (id) {
> > +		case MT8186_DAI_AP_DMIC:
> > +			mtk_adda_ul_src_dmic(afe, id);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> Regards,
> Angelo
> 


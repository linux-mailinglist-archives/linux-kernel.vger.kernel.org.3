Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C14BBB09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiBROyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:54:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiBROyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:54:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4B856C02;
        Fri, 18 Feb 2022 06:54:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E2ACB1F46BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645196066;
        bh=/QgSDHmSLtXvOS6O4MR4blf2HkvBBf8c5LbK7+RhC/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l4Hk/xNAQ9LI5HLIKjHT7LXufn5WBixzlQRdyddMU3+xD8Vpmv8OIalXuAfL3AMLJ
         yz/XG6p0xcI91t9L2B2lu5FY54eZuM9gJX1/hVOnPE4VhXTAbkI1vMDlP1Ha+p3rWt
         II08XN0xewiJByAY6o++s2A5Xh8E5lIbHTrMjCtjbejwznFY7nHjfEFlP6Q0v5T2s2
         P6cDAF+JN7EieM8P4xqcqg1pUIs8TPIeCrn/4a7K38V4zaTGZwalrVwNRYWTux/46F
         p1jj2AJKIiXcGsoA1QYMpgPyG1/iNn1EUMf8WVaLmWsOsPhfBiUOfuX4ZOp9dsHbtD
         SDdZHADn3nPIg==
Message-ID: <78474983-a07c-6b1d-797a-d0788f3577b6@collabora.com>
Date:   Fri, 18 Feb 2022 15:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v2 07/17] ASoC: mediatek: mt8186: support pcm in platform driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, aaronyu@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-8-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217134205.15400-8-jiaxin.yu@mediatek.com>
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
> This patch adds mt8186 pcm dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-pcm.c | 432 +++++++++++++++++++++
>   1 file changed, 432 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c b/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
> new file mode 100644
> index 000000000000..73b3f720ed35
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-pcm.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// MediaTek ALSA SoC Audio DAI I2S Control
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include <linux/regmap.h>
> +#include <sound/pcm_params.h>
> +#include "mt8186-afe-common.h"
> +#include "mt8186-afe-gpio.h"
> +#include "mt8186-interconnection.h"
> +
> +struct mtk_afe_pcm_priv {
> +	unsigned int id;
> +	unsigned int fmt;
> +	unsigned int bck_invert;
> +	unsigned int lck_invert;
> +};
> +
> +enum AUD_TX_LCH_RPT {

lowercase enumeration names please...

enum aud_tx_lch_rpt {
	AUD_TX....BLAH
};

> +	AUD_TX_LCH_RPT_NO_REPEAT = 0,
> +	AUD_TX_LCH_RPT_REPEAT = 1
> +};
> +
> +enum AUD_VBT_16K_MODE {
> +	AUD_VBT_16K_MODE_DISABLE = 0,
> +	AUD_VBT_16K_MODE_ENABLE = 1
> +};
> +
> +enum AUD_EXT_MODEM {
> +	AUD_EXT_MODEM_SELECT_INTERNAL = 0,
> +	AUD_EXT_MODEM_SELECT_EXTERNAL = 1
> +};
> +
> +enum AUD_PCM_SYNC_TYPE {
> +	/* bck sync length = 1 */
> +	AUD_PCM_ONE_BCK_CYCLE_SYNC = 0,
> +	/* bck sync length = PCM_INTF_CON1[9:13] */
> +	AUD_PCM_EXTENDED_BCK_CYCLE_SYNC = 1
> +};
> +
> +enum AUD_BT_MODE {
> +	AUD_BT_MODE_DUAL_MIC_ON_TX = 0,
> +	AUD_BT_MODE_SINGLE_MIC_ON_TX = 1
> +};
> +
> +enum AUD_PCM_AFIFO_SRC {
> +	/* slave mode & external modem uses different crystal */
> +	AUD_PCM_AFIFO_ASRC = 0,
> +	/* slave mode & external modem uses the same crystal */
> +	AUD_PCM_AFIFO_AFIFO = 1
> +};
> +
> +enum AUD_PCM_CLOCK_SOURCE {
> +	AUD_PCM_CLOCK_MASTER_MODE = 0,
> +	AUD_PCM_CLOCK_SLAVE_MODE = 1
> +};
> +
> +enum AUD_PCM_WLEN {
> +	AUD_PCM_WLEN_PCM_32_BCK_CYCLES = 0,
> +	AUD_PCM_WLEN_PCM_64_BCK_CYCLES = 1
> +};
> +
> +enum AUD_PCM_24BIT {
> +	AUD_PCM_24BIT_PCM_16_BITS = 0,
> +	AUD_PCM_24BIT_PCM_24_BITS = 1
> +};
> +
> +enum AUD_PCM_MODE {
> +	AUD_PCM_MODE_PCM_MODE_8K = 0,
> +	AUD_PCM_MODE_PCM_MODE_16K = 1,
> +	AUD_PCM_MODE_PCM_MODE_32K = 2,
> +	AUD_PCM_MODE_PCM_MODE_48K = 3,
> +};
> +
> +enum AUD_PCM_FMT {
> +	AUD_PCM_FMT_I2S = 0,
> +	AUD_PCM_FMT_EIAJ = 1,
> +	AUD_PCM_FMT_PCM_MODE_A = 2,
> +	AUD_PCM_FMT_PCM_MODE_B = 3
> +};
> +
> +enum AUD_BCLK_OUT_INV {
> +	AUD_BCLK_OUT_INV_NO_INVERSE = 0,
> +	AUD_BCLK_OUT_INV_INVERSE = 1
> +};
> +
> +enum AUD_LRCLK_OUT_INV {
> +	AUD_LRCLK_OUT_INV_NO_INVERSE = 0,
> +	AUD_LRCLK_OUT_INV_INVERSE = 1
> +};
> +
> +enum AUD_PCM_EN {
> +	AUD_PCM_EN_DISABLE = 0,
> +	AUD_PCM_EN_ENABLE = 1
> +};
> +

..snip..

> +
> +/* dai ops */
> +static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int pcm_id = dai->id;
> +	struct mtk_afe_pcm_priv *pcm_priv = afe_priv->dai_priv[pcm_id];
> +	unsigned int rate = params_rate(params);
> +	unsigned int rate_reg = mt8186_rate_transform(afe->dev, rate, dai->id);
> +	snd_pcm_format_t format = params_format(params);
> +	unsigned int data_width =
> +		snd_pcm_format_width(format);
> +	unsigned int wlen_width =
> +		snd_pcm_format_physical_width(format);
> +	unsigned int pcm_con = 0;
> +
> +	dev_info(afe->dev, "%s(), id %d, stream %d, widget active p %d, c %d\n",
> +		 __func__,
> +		 dai->id,
> +		 substream->stream,
> +		 dai->playback_widget->active,
> +		 dai->capture_widget->active);
> +	dev_info(afe->dev, "%s(), rate %d, rate_reg %d, data_width %d, wlen_width %d\n",
> +		 __func__,
> +		 rate,
> +		 rate_reg,
> +		 data_width,
> +		 wlen_width);

dev_dbg() - also, you don't need one line per variable.

> +
> +	if (dai->playback_widget->active || dai->capture_widget->active)
> +		return 0;
> +
> +	switch (dai->id) {
> +	case MT8186_DAI_PCM:
> +		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM_TX_LCH_RPT_SFT;
> +		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM_VBT_16K_MODE_SFT;
> +		pcm_con |= AUD_EXT_MODEM_SELECT_EXTERNAL << PCM_EXT_MODEM_SFT;
> +		pcm_con |= AUD_PCM_ONE_BCK_CYCLE_SYNC << PCM_SYNC_TYPE_SFT;
> +		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM_BT_MODE_SFT;
> +		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM_BYP_ASRC_SFT;
> +		pcm_con |= AUD_PCM_CLOCK_MASTER_MODE << PCM_SLAVE_SFT;
> +		pcm_con |= 0 << PCM_SYNC_LENGTH_SFT;
> +
> +		/* sampling rate */
> +		pcm_con |= rate_reg << PCM_MODE_SFT;
> +
> +		/* format */
> +		pcm_con |= pcm_priv->fmt << PCM_FMT_SFT;
> +
> +		/* 24bit data width */
> +		if (data_width > 16)
> +			pcm_con |= AUD_PCM_24BIT_PCM_24_BITS << PCM_24BIT_SFT;
> +		else
> +			pcm_con |= AUD_PCM_24BIT_PCM_16_BITS << PCM_24BIT_SFT;
> +
> +		/* wlen width*/
> +		if (wlen_width > 16)
> +			pcm_con |= AUD_PCM_WLEN_PCM_64_BCK_CYCLES << PCM_WLEN_SFT;
> +		else
> +			pcm_con |= AUD_PCM_WLEN_PCM_32_BCK_CYCLES << PCM_WLEN_SFT;
> +
> +		/* clock invert */
> +		pcm_con |= pcm_priv->lck_invert << PCM_SYNC_OUT_INV_SFT;
> +		pcm_con |= pcm_priv->bck_invert << PCM_BCLK_OUT_INV_SFT;
> +
> +		regmap_update_bits(afe->regmap, PCM_INTF_CON1,
> +				   0xfffffffe, pcm_con);

Fits in one line.

> +		break;
> +	default:
> +		dev_info(afe->dev, "%s(), id %d not support\n",
> +			 __func__, dai->id);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dai_pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_afe_pcm_priv *pcm_priv = afe_priv->dai_priv[dai->id];
> +
> +	if (!pcm_priv) {
> +		dev_info(afe->dev, "%s(), tdm_priv == NULL", __func__);

dev_err()

> +		return -EINVAL;
> +	}
> +

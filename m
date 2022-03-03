Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1424CC0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiCCPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:09:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586522BE3;
        Thu,  3 Mar 2022 07:08:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E01201F417E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646320091;
        bh=4AnpB0bYq27BC2obrhRVr+DJd2wAvFLS3ceAZEqlmi8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YmxxYkponFYhDybTF8nddo7rMJTsASLxFCpeVD75jv0aJPhBhqX8kkXnCaPQJXvY3
         nUzbIyxllmRywUCgmIxeDhHq8Zqbpo5WJ/rporDoCUl4h6eAMGvpfYry52LIqx0InJ
         Qbg1cZKSA3fi0beT5Efr9M5IRzuFBhgzpb7xBWLv5SqCswmxDSYcW9tv+FJSs9cM7l
         PJwxmT+Z3WGs+H1NCLLrBZrfOKacGUCyJF27EiNVYp2c7bqe4zBCv7J4XBzRJ/lG5/
         dTaysJnMMzYdNSCfjYgqBwi+ZGnO09TH5IoWfFCocfLBlJZcEQ1zZ3lziCsS6x0zQF
         9H0xcfGdtKVRg==
Message-ID: <6bc78592-36c0-8462-f4f8-ad9e04a13da6@collabora.com>
Date:   Thu, 3 Mar 2022 16:08:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v2 09/17] ASoC: mediatek: mt8186: support tdm in platform driver
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
 <20220217134205.15400-10-jiaxin.yu@mediatek.com>
 <fcae42a5-6e11-e683-8f3a-453650f08d38@collabora.com>
 <9ba63387baecf598db696d0ebbc1583406a57a62.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9ba63387baecf598db696d0ebbc1583406a57a62.camel@mediatek.com>
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

Il 03/03/22 15:10, Jiaxin Yu ha scritto:
> On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
>> Il 17/02/22 14:41, Jiaxin Yu ha scritto:
>>> This patch adds mt8186 tdm dai driver.
>>>
>>> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
>>> ---
>>>    sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 713
>>> +++++++++++++++++++++
>>>    1 file changed, 713 insertions(+)
>>>    create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
>>>
>>> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
>>> b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
>>> new file mode 100644
>>> index 000000000000..28dd3661f0e0
>>> --- /dev/null
>>> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
>>> @@ -0,0 +1,713 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// MediaTek ALSA SoC Audio DAI TDM Control
>>> +//
>>> +// Copyright (c) 2022 MediaTek Inc.
>>> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
>>> +

..snip..

>>> +
>>> +static int mtk_dai_tdm_hw_params(struct snd_pcm_substream
>>> *substream,
>>> +				 struct snd_pcm_hw_params *params,
>>> +				 struct snd_soc_dai *dai)
>>> +{
>>> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
>>> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
>>> +	int tdm_id = dai->id;
>>> +	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[tdm_id];
>>> +	unsigned int tdm_mode = tdm_priv->tdm_mode;
>>> +	unsigned int data_mode = tdm_priv->data_mode;
>>> +	unsigned int rate = params_rate(params);
>>> +	unsigned int channels = params_channels(params);
>>> +	snd_pcm_format_t format = params_format(params);
>>> +	unsigned int bit_width =
>>> +		snd_pcm_format_physical_width(format);
>>> +	unsigned int tdm_channels = (data_mode == TDM_DATA_ONE_PIN) ?
>>> +		get_tdm_ch_per_sdata(tdm_mode, channels) : 2;
>>> +	unsigned int lrck_width =
>>> +		get_tdm_lrck_width(format, tdm_mode);
>>> +	unsigned int tdm_con = 0;
>>> +	bool slave_mode = tdm_priv->slave_mode;
>>> +	bool lrck_inv = tdm_priv->lck_invert;
>>> +	bool bck_inv = tdm_priv->bck_invert;
>>> +	unsigned int ctrl_reg;
>>> +	unsigned int ctrl_mask;
>>> +	unsigned int tran_rate;
>>> +	unsigned int tran_relatch_rate;
>>> +
>>> +	if (tdm_priv)
>>> +		tdm_priv->rate = rate;
>>> +	else
>>> +		dev_info(afe->dev, "%s(), tdm_priv == NULL", __func__);
>>> +
>>> +	tran_rate = mt8186_rate_transform(afe->dev, rate, dai->id);
>>> +	tran_relatch_rate = mt8186_tdm_relatch_rate_transform(afe->dev,
>>> rate);
>>> +
>>> +	/* calculate mclk_rate, if not set explicitly */
>>> +	if (!tdm_priv->mclk_rate) {
>>> +		tdm_priv->mclk_rate = rate * tdm_priv->mclk_multiple;
>>> +		mtk_dai_tdm_cal_mclk(afe,
>>> +				     tdm_priv,
>>> +				     tdm_priv->mclk_rate);
>>> +	}
>>> +
>>> +	/* ETDM_IN1_CON0 */
>>> +	tdm_con |= slave_mode << ETDM_IN1_CON0_REG_SLAVE_MODE_SFT;
>>> +	tdm_con |= tdm_mode << ETDM_IN1_CON0_REG_FMT_SFT;
>>> +	tdm_con |= (bit_width - 1) << ETDM_IN1_CON0_REG_BIT_LENGTH_SFT;
>>> +	tdm_con |= (bit_width - 1) <<
>>> ETDM_IN1_CON0_REG_WORD_LENGTH_SFT;
>>> +	tdm_con |= (tdm_channels - 1) << ETDM_IN1_CON0_REG_CH_NUM_SFT;
>>> +	/* default disable sync mode */
>>> +	tdm_con |= 0 << ETDM_IN1_CON0_REG_SYNC_MODE_SFT;
>>
>> 0 << (anything) == 0
>>
>> (number |= 0) == number
>>
>> Is this a mistake, or are you really doing nothing here?
>>
> No, this is just to emphasize the need to set this bit to 0.
> It really do nothing here, just link a reminder.
> Can I keep this sentence?

If, in your judgement, it is very important to have a reminder about that
bit having to be unset, then add a comment in the code saying so.
Don't simply comment out the statement as it is.

A good way would be something like
/* sync mode bit has to be unset because this that reason, otherwise X happens */

>>
>>> +	/* relatch fix to h26m */
>>> +	tdm_con |= 0 << ETDM_IN1_CON0_REG_RELATCH_1X_EN_SEL_DOMAIN_SFT;
>>> +
>>> +	ctrl_reg = ETDM_IN1_CON0;
>>> +	ctrl_mask = ETDM_IN_CON0_CTRL_MASK;
>>> +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
>>> +
>>> +	/* ETDM_IN1_CON1 */
>>> +	tdm_con = 0;
>>> +	tdm_con |= 0 << ETDM_IN1_CON1_REG_LRCK_AUTO_MODE_SFT;
>>> +	tdm_con |= 1 << ETDM_IN1_CON1_PINMUX_MCLK_CTRL_OE_SFT;
>>> +	tdm_con |= (lrck_width - 1) <<
>>> ETDM_IN1_CON1_REG_LRCK_WIDTH_SFT;
>>> +
>>> +	ctrl_reg = ETDM_IN1_CON1;
>>> +	ctrl_mask = ETDM_IN_CON1_CTRL_MASK;
>>> +	regmap_update_bits(afe->regmap, ctrl_reg, ctrl_mask, tdm_con);
>>
>> You don't need the ctrl_reg, nor ctrl_mask variables...
> I was trying to avoid a line of more than 80 words, so I shortened the
> number of words through variables.
> 

Yes, I know, I did understand what you were trying to do...
...but it's fine to go past 80: in this case this would be 88 columns,
which is still ok to have!

And note, this is the case with all of similar calls present in this function,
that's why I said that you don't need these two variables! :)

Thank you,
Angelo



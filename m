Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C274768C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhLPDhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:37:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40510 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229905AbhLPDhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:37:39 -0500
X-UUID: bb65dc2f54a443e99c7702d40a2cf28c-20211216
X-UUID: bb65dc2f54a443e99c7702d40a2cf28c-20211216
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 107822264; Thu, 16 Dec 2021 11:37:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Dec 2021 11:37:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Dec 2021 11:37:35 +0800
Message-ID: <0b99c46f84c98c56e8fc99b2e103f52f756b5bf9.camel@mediatek.com>
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8195: update control for RT5682
 series
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
CC:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jiaxin.yu@mediatek.com>, <shumingf@realtek.com>
Date:   Thu, 16 Dec 2021 11:37:34 +0800
In-Reply-To: <YbmlT+OSwpGuylsx@google.com>
References: <20211215065835.3074-1-trevor.wu@mediatek.com>
         <YbmlT+OSwpGuylsx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,
Thanks for your reviewing,

On Wed, 2021-12-15 at 16:20 +0800, Tzung-Bi Shih wrote:
> On Wed, Dec 15, 2021 at 02:58:34PM +0800, Trevor Wu wrote:
> > --- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
> > +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
> 
> [...]
> > +static int mt8195_set_bias_level_post(struct snd_soc_card *card,
> > +	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level
> > level)
> > +{
> > +	struct snd_soc_component *component = dapm->component;
> > +	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
> > +		snd_soc_card_get_drvdata(card);
> > +	int ret = 0;
> 
> ret doesn't need to be initialized.
> 
Originally, I initailize "ret", because it will be returned at the end
of the function. To be concise, I will return 0 directly and remove the
initialization.

> > +	/*
> > +	 * It's required to control mclk directly in the
> > set_bias_level_post
> > +	 * function for rt5682 and rt5682s codec, or the unexpected pop
> > happens
> > +	 * at the end of playback.
> > +	 */
> > +	if (!component ||
> > +	    (strcmp(component->name, RT5682_DEV0_NAME) &&
> > +	    strcmp(component->name, RT5682S_DEV0_NAME)))
> > +		return 0;
> > +
> > +	if (IS_ERR(priv->i2so1_mclk))
> > +		return 0;
> 
> I doubt if it needs to check priv->i2so1_mclk.  In other words, if
> IS_ERR(priv->i2so1_mclk) is true in _probe, does
> mt8195_set_bias_level_post() get called?
> 

Now, i2so1_mclk is a required property.
I will remove the condition in v2.

> > +	switch (level) {
> > +	case SND_SOC_BIAS_OFF:
> > +		if (!__clk_is_enabled(priv->i2so1_mclk))
> > +			return 0;
> > +
> > +		dev_dbg(card->dev, "Disable i2so1");
> > +		clk_disable_unprepare(priv->i2so1_mclk);
> 
> I would suggest move dev_dbg() later than clk_disable_unprepare()
> which means "Disable i2so1" is done.
> 
OK.

> > +		break;
> > +	case SND_SOC_BIAS_ON:
> > +		dev_dbg(card->dev, "Enable i2so1");
> > +		ret = clk_prepare_enable(priv->i2so1_mclk);
> > +		if (ret) {
> > +			dev_err(card->dev, "Can't enable mclk, err:
> > %d\n", ret);
> 
> The error message can be more specific.  "Cannot enable i2so1" for
> example.
> 
OK.

> > +			return ret;
> > +		}
> 
> Also, I would suggest move dev_dbg() later than
> clk_prepare_enable().  Otherwise, it could fail to prepare or enable
> but still can see "Enable i2so1" message.
> 
Yes, that's correct.
I will move it to a proper position.

> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return ret;
> 
> The function doesn't use any gotos.  To be concise, "return 0;".
OK.

> 
> > @@ -1072,6 +1119,19 @@ static int
> > mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > +	priv->i2so1_mclk = devm_clk_get(&pdev->dev, "i2so1_mclk");
> > +	if (IS_ERR(priv->i2so1_mclk)) {
> > +		ret = PTR_ERR(priv->i2so1_mclk);
> > +		if (ret == -ENOENT) {
> > +			dev_dbg(&pdev->dev,
> > +				"Failed to get i2so1_mclk, defer
> > probe\n");
> > +			return -EPROBE_DEFER;
> > +		}
> 
> Does devm_clk_get_optional() could make the block more concise?

Even though we use devm_clk_get_optional, we still have to handle the
(-ENOENT) case in probe function. In my opinion, original
implementation could be kept.

> 
> > +
> > +		dev_err(&pdev->dev, "Failed to get i2so1_mclk,
> > err:%d\n", ret);
> 
> If devm_clk_get() is possible to return -EPROBE_DEFER too, use
> dev_err_probe().
Ok.

> 
> > --- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> > +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> 
> [...]
> > +static int mt8195_set_bias_level_post(struct snd_soc_card *card,
> > +	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level
> > level)
> > +{
> > +	struct snd_soc_component *component = dapm->component;
> > +	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
> > +		snd_soc_card_get_drvdata(card);
> > +	int ret = 0;
> 
> Ditto, see comments above.
> 
OK.

> > +
> > +	/*
> > +	 * It's required to control mclk directly in the
> > set_bias_level_post
> > +	 * function for rt5682 and rt5682s codec, or the unexpected pop
> > happens
> > +	 * at the end of playback.
> > +	 */
> > +	if (!component ||
> > +	    (strcmp(component->name, RT5682_DEV0_NAME) &&
> > +	    strcmp(component->name, RT5682S_DEV0_NAME)))
> > +		return 0;
> > +
> > +	if (IS_ERR(priv->i2so1_mclk))
> > +		return 0;
> 
> Ditto, see comments above.
> 
OK.

> > +
> > +	switch (level) {
> > +	case SND_SOC_BIAS_OFF:
> > +		if (!__clk_is_enabled(priv->i2so1_mclk))
> > +			return 0;
> > +
> > +		dev_dbg(card->dev, "Disable i2so1");
> > +		clk_disable_unprepare(priv->i2so1_mclk);
> > +		break;
> > +	case SND_SOC_BIAS_ON:
> > +		dev_dbg(card->dev, "Enable i2so1");
> > +		ret = clk_prepare_enable(priv->i2so1_mclk);
> > +		if (ret) {
> > +			dev_err(card->dev, "Can't enable mclk, err:
> > %d\n", ret);
> > +			return ret;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> Ditto, see comments above for the block.
> 
OK.

> > +
> > +	return ret;
> 
> Ditto, see comments above.
> 
OK.

> > @@ -1285,6 +1326,19 @@ static int
> > mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > +	priv->i2so1_mclk = devm_clk_get(&pdev->dev, "i2so1_mclk");
> > +	if (IS_ERR(priv->i2so1_mclk)) {
> > +		ret = PTR_ERR(priv->i2so1_mclk);
> > +		if (ret == -ENOENT) {
> > +			dev_dbg(&pdev->dev,
> > +				"Failed to get i2so1_mclk, defer
> > probe\n");
> > +			return -EPROBE_DEFER;
> > +		}
> > +
> > +		dev_err(&pdev->dev, "Failed to get i2so1_mclk,
> > err:%d\n", ret);
> > +		return ret;
> > +	}
> 
> Ditto, see comments above for the block.
OK.



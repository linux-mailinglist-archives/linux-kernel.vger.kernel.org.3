Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433F4CE3E0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 09:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiCEI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 03:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiCEI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 03:59:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC73914C;
        Sat,  5 Mar 2022 00:58:49 -0800 (PST)
X-UUID: 4b2f0ffb8dc440c78ead1c24a77b19a0-20220305
X-UUID: 4b2f0ffb8dc440c78ead1c24a77b19a0-20220305
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1171237353; Sat, 05 Mar 2022 16:58:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Mar 2022 16:58:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 16:58:42 +0800
Message-ID: <4aa814cdac002dde73fe01054c642e90b043429a.camel@mediatek.com>
Subject: Re: [v2 14/17] ASoC: mediatek: mt8186: add machine driver with
 mt6366, da7219 and max98357
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
Date:   Sat, 5 Mar 2022 16:58:41 +0800
In-Reply-To: <70147e6f-a008-ab1a-eb07-dbb1236849b0@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-15-jiaxin.yu@mediatek.com>
         <70147e6f-a008-ab1a-eb07-dbb1236849b0@collabora.com>
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
> Il 17/02/22 14:42, Jiaxin Yu ha scritto:
> > This patch adds support for mt8186 board with mt6366, da7219 and
> > max98357.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   .../mt8186/mt8186-mt6366-da7219-max98357.c    | 910
> > ++++++++++++++++++
> >   1 file changed, 910 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-
> > da7219-max98357.c
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-
> > max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-
> > max98357.c
> > new file mode 100644
> > index 000000000000..6ba53b8d1e46
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
> > @@ -0,0 +1,910 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// mt8186-mt6366-da7219-max98357.c
> > +//	--  MT8186-MT6366-DA7219-MAX98357 ALSA SoC machine driver
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +//
> > +
> > +#include <linux/input.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +
> > +#include "../../codecs/da7219-aad.h"
> > +#include "../../codecs/da7219.h"
> > +#include "../../codecs/mt6358.h"
> > +#include "../common/mtk-afe-platform-driver.h"
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-clk.h"
> > +#include "mt8186-afe-gpio.h"
> > +
> > +#define DA7219_CODEC_DAI "da7219-hifi"
> > +#define DA7219_DEV_NAME "da7219.5-001a"
> > +
> > +struct mt8186_mt6366_da7219_max98357_priv {
> > +	struct snd_soc_jack headset_jack, hdmi_jack;
> > +};
> > +
> > +static struct snd_soc_codec_conf mt6366_codec_conf[] = {
> > +	{
> > +		.dlc = COMP_CODEC_CONF("mt6358-sound"),
> > +		.name_prefix = "Mt6366",
> > +	},
> > +};
> > +
> > +static int mt8186_da7219_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct mt8186_mt6366_da7219_max98357_priv *priv =
> > +		snd_soc_card_get_drvdata(rtd->card);
> > +	struct snd_soc_jack *jack = &priv->headset_jack;
> > +	struct snd_soc_component *cmpnt_codec =
> > +		asoc_rtd_to_codec(rtd, 0)->component;
> > +	int ret;
> > +
> > +	/* Enable Headset and 4 Buttons Jack detection */
> > +	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
> > +				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
> > +				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
> > +				    SND_JACK_BTN_3 | SND_JACK_LINEOUT,
> > +				    jack, NULL, 0);
> > +	if (ret) {
> > +		dev_err(rtd->dev, "Headset Jack creation failed: %d\n",
> > ret);
> > +		return ret;
> > +	}
> > +
> > +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> > +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> > +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> > +
> > +	da7219_aad_jack_det(cmpnt_codec, &priv->headset_jack);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_da7219_i2s_hw_params(struct snd_pcm_substream
> > *substream,
> > +				       struct snd_pcm_hw_params
> > *params)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =
> > asoc_substream_to_rtd(substream);
> > +	struct snd_soc_dai *codec_dai;
> > +	unsigned int rate = params_rate(params);
> > +	unsigned int mclk_fs_ratio = 256;
> > +	unsigned int mclk_fs = rate * mclk_fs_ratio;
> > +	unsigned int freq;
> > +	int ret = 0, j;
> > +
> > +	ret = snd_soc_dai_set_sysclk(asoc_rtd_to_cpu(rtd, 0), 0,
> > +				     mclk_fs, SND_SOC_CLOCK_OUT);
> > +	if (ret < 0)
> > +		dev_err(rtd->dev, "failed to set cpu dai sysclk\n");
> 
> Does it really make sense to go on after this failure?
> 
> > +
> > +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> > +		if (!strcmp(codec_dai->component->name,
> > DA7219_DEV_NAME)) {
> > +			ret = snd_soc_dai_set_sysclk(codec_dai,
> > +						     DA7219_CLKSRC_MCLK
> > ,
> > +						     mclk_fs,
> > +						     SND_SOC_CLOCK_IN);
> > +			if (ret < 0)
> > +				dev_err(rtd->dev, "failed to set
> > sysclk\n");
> > +
> 
> I think that going on past this wouldn't make sense as well, as it
> may result
> in unexpected behavior... just return a failure here

Yes, it is.
> 
> > +			if ((rate % 8000) == 0)
> > +				freq = DA7219_PLL_FREQ_OUT_98304;
> > +			else
> > +				freq = DA7219_PLL_FREQ_OUT_90316;
> > +
> > +			ret = snd_soc_dai_set_pll(codec_dai, 0,
> > +						  DA7219_SYSCLK_PLL_SRM
> > ,
> > +						  0, freq);
> > +			if (ret)
> > +				dev_err(rtd->dev, "failed to start PLL:
> > %d\n",
> > +					ret);
> 
> and here
Yes, you are right.

> 
> > +		}
> > +	}
> > +
> 
> So, you've covered all failure cases already, for which, you can
> simply
> return 0 here.
Yes, it is.

> 
> > +	return ret;
> > +}
> > +
> > +static int mt8186_da7219_i2s_hw_free(struct snd_pcm_substream
> > *substream)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =
> > asoc_substream_to_rtd(substream);
> > +	struct snd_soc_dai *codec_dai;
> > +	int ret = 0, j;
> > +
> > +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> > +		if (!strcmp(codec_dai->component->name,
> > DA7219_DEV_NAME)) {
> > +			ret = snd_soc_dai_set_pll(codec_dai,
> > +						  0,
> > DA7219_SYSCLK_MCLK, 0, 0);
> > +			if (ret < 0) {
> > +				dev_err(rtd->dev, "failed to stop PLL:
> > %d\n",
> > +					ret);
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct snd_soc_ops mt8186_da7219_i2s_ops = {
> > +	.hw_params = mt8186_da7219_i2s_hw_params,
> > +	.hw_free = mt8186_da7219_i2s_hw_free,
> > +};
> > +
> > +static int mt8186_mt6366_hdmi_init(struct snd_soc_pcm_runtime
> > *rtd)
> > +{
> > +	struct snd_soc_component *cmpnt_codec =
> > +		asoc_rtd_to_codec(rtd, 0)->component;
> > +	struct mt8186_mt6366_da7219_max98357_priv *priv =
> > +		snd_soc_card_get_drvdata(rtd->card);
> > +	int ret;
> > +
> > +	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack",
> > SND_JACK_LINEOUT,
> > +				    &priv->hdmi_jack, NULL, 0);
> > +	if (ret) {
> > +		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n",
> > ret);
> > +		return ret;
> > +	}
> > +
> > +	return snd_soc_component_set_jack(cmpnt_codec, &priv-
> > >hdmi_jack, NULL);
> > +}
> > +
> > +static int mt8186_mt6366_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct snd_soc_component *cmpnt_afe =
> > +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> > +	struct snd_soc_component *cmpnt_codec =
> > +		asoc_rtd_to_codec(rtd, 0)->component;
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt_afe);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
> > +	int ret;
> > +
> > +	/* set mtkaif protocol */
> > +	mt6358_set_mtkaif_protocol(cmpnt_codec,
> > +				   MT6358_MTKAIF_PROTOCOL_1);
> > +	afe_priv->mtkaif_protocol = MT6358_MTKAIF_PROTOCOL_1;
> > +
> > +	ret = snd_soc_dapm_sync(dapm);
> > +	if (ret) {
> > +		dev_info(rtd->dev, "failed to snd_soc_dapm_sync\n");
> 
> dev_err()
> 
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_i2s_hw_params_fixup(struct snd_soc_pcm_runtime
> > *rtd,
> > +				      struct snd_pcm_hw_params *params)
> > +{
> > +	struct snd_interval *channels = hw_param_interval(params,
> > +		SNDRV_PCM_HW_PARAM_CHANNELS);
> > +	dev_info(rtd->dev, "%s(), fix format to 32bit\n", __func__);
> > +
> 
> dev_dbg()
> 
> > +	/* fix BE i2s channel to 2 channel */
> > +	channels->min = 2;
> > +	channels->max = 2;
> > +
> > +	/* fix BE i2s format to S32_LE, clean param mask first */
> > +	snd_mask_reset_range(hw_param_mask(params,
> > SNDRV_PCM_HW_PARAM_FORMAT),
> > +			     0, (__force unsigned
> > int)SNDRV_PCM_FORMAT_LAST);
> > +
> > +	params_set_format(params, SNDRV_PCM_FORMAT_S32_LE);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_hdmi_i2s_hw_params_fixup(struct
> > snd_soc_pcm_runtime *rtd,
> > +					   struct snd_pcm_hw_params
> > *params)
> > +{
> > +	struct snd_interval *channels = hw_param_interval(params,
> > +		SNDRV_PCM_HW_PARAM_CHANNELS);
> > +	dev_info(rtd->dev, "%s(), fix format to 32bit\n", __func__);
> > +
> 
> dev_dbg()
> 
> > +	/* fix BE i2s channel to 2 channel */
> > +	channels->min = 2;
> > +	channels->max = 2;
> > +
> > +	/* fix BE i2s format to S24_LE, clean param mask first */
> > +	snd_mask_reset_range(hw_param_mask(params,
> > SNDRV_PCM_HW_PARAM_FORMAT),
> > +			     0, (__force unsigned
> > int)SNDRV_PCM_FORMAT_LAST);
> > +
> > +	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
> > +
> > +	return 0;
> > +}
> 

Ok, I will use this code which is really more concise.

> Besides, I would do the following instead:
> 
> static int mt8186_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> 
> 				  struct snd_pcm_hw_params *params,
> 
> 				  snd_pcm_format_t fmt)
> 
> {
> 
> 	struct snd_interval *channels = hw_param_interval(params,
> 
> 		SNDRV_PCM_HW_PARAM_CHANNELS);
> 
> 	dev_dbg(rtd->dev, "%s(), fix format to 32bit\n", __func__);
> 
> 
> 
> 	/* fix BE i2s channel to 2 channel */
> 
> 	channels->min = 2;
> 
> 	channels->max = 2;
> 
> 
> 
> 	/* fix BE i2s format to S32_LE, clean param mask first */
> 
> 	snd_mask_reset_range(hw_param_mask(params,
> SNDRV_PCM_HW_PARAM_FORMAT),
> 
> 			     0, (__force unsigned
> int)SNDRV_PCM_FORMAT_LAST);
> 
> 
> 
> 	params_set_format(params, fmt);
> 
> 
> 
> 	return 0;
> 
> }
> 
> 
> 
> static int mt8186_i2s_hw_params_fixup(struct snd_soc_pcm_runtime
> *rtd,
> 
> 				      struct snd_pcm_hw_params *params)
> 
> {
> 
> 	return mt8186_hw_params_fixup(rtd, params,
> SNDRV_PCM_FORMAT_S32_LE);
> 
> }
> 
> 
> 
> static int mt8186_hdmi_i2s_hw_params_fixup(struct snd_soc_pcm_runtime
> *rtd,
> 
> 					   struct snd_pcm_hw_params
> *params)
> 
> {
> 
> 	return mt8186_hw_params_fixup(rtd, params,
> SNDRV_PCM_FORMAT_S24_LE);
> 
> }
> 
> ... this reduces code duplication!
> 
> > +
> > +/* FE */
> > +SND_SOC_DAILINK_DEFS(playback1,
> > +		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
> > +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> > +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> 
> 
> ..snip..
> 
> > +static int mt8186_mt6366_da7219_max98357_dev_probe(struct
> > platform_device *pdev)
> > +{
> > +	struct snd_soc_card *card =
> > &mt8186_mt6366_da7219_max98357_soc_card;
> > +	struct snd_soc_dai_link *dai_link;
> > +	struct mt8186_mt6366_da7219_max98357_priv *priv;
> > +	struct device_node *platform_node, *hdmi_codec;
> > +	int ret, i;
> > +
> > +	dev_info(&pdev->dev, "%s(), ++\n", __func__);
> > +
> > +	card->dev = &pdev->dev;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	platform_node = of_parse_phandle(pdev->dev.of_node,
> > +					 "mediatek,platform", 0);
> > +	if (!platform_node) {
> > +		dev_info(&pdev->dev,
> > +			 "Property 'platform' missing or invalid\n");
> 
> 	if (!platform_node)
> 		return dev_err_probe(&pdev->dev, -EINVAL,
> 				    "mediatek,platform missing or
> invalid\n");
> 
> > +		return -EINVAL;
got err_platform_node;
> > +	}
> > +
> > +	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
> > +				      "mediatek,hdmi-codec", 0);
> > +	if (!hdmi_codec) {
> > +		dev_info(&pdev->dev,
> > +			 "Property 'hdmi' missing or invalid\n");
> 
> dev_err()
> 
> > +		return -EINVAL;
> > +	}
Should I of_node_put(platform_node) befor return?

goto err_hdmi_node;


> > +
> > +	for_each_card_prelinks(card, i, dai_link) {
> > +		if (dai_link->platforms->name)
> > +			continue;
> > +
> > +		if (hdmi_codec && strcmp(dai_link->name, "I2S3") == 0)
> > {
> > +			dai_link->codecs->of_node = hdmi_codec;
> > +			dai_link->ignore = 0;
> > +		}
> > +
> > +		dai_link->platforms->of_node = platform_node;
> > +	}
> > +
> > +	snd_soc_card_set_drvdata(card, priv);
> > +
> > +	/* init gpio */
> > +	ret = mt8186_afe_gpio_init(&pdev->dev);
> > +	if (ret)
> > +		dev_info(&pdev->dev, "init gpio error\n");
> 
> dev_err() and goto end;
Yes, goto err_init_gpio and of_node_put for hdmi_codec and
platform_node.
> 
> > +
> > +	dev_info(&pdev->dev, "%s(), devm_snd_soc_register_card\n",
> > __func__);
> > +	ret = devm_snd_soc_register_card(&pdev->dev, card);
> > +	if (ret)
> > +		dev_info(&pdev->dev, "%s snd_soc_register_card fail
> > %d\n",
> > +			 __func__, ret);
> 
> dev_err_probe()
> 
> end:
> 
err_init_gpio:
> > +	of_node_put(hdmi_codec);
err_hdmi_node:
> > +	of_node_put(platform_node);
> > +
err_platform_node:
> > +	return ret;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_OF)
> > +static const struct of_device_id
> > mt8186_mt6366_da7219_max98357_dt_match[] = {
> > +	{.compatible =
> > "mediatek,mt8186_mt6366_da7219_max98357_sound",},
> > +	{}
> > +};
> > +#endif
> > +
> > +static struct platform_driver mt8186_mt6366_da7219_max98357_driver
> > = {
> > +	.driver = {
> > +		.name = "mt8186_mt6366_da7219_max98357",
> > +#if IS_ENABLED(CONFIG_OF)
> > +		.of_match_table =
> > mt8186_mt6366_da7219_max98357_dt_match,
> > +#endif
> > +		.pm = &snd_soc_pm_ops,
> > +	},
> > +	.probe = mt8186_mt6366_da7219_max98357_dev_probe,
> > +};
> > +
> > +module_platform_driver(mt8186_mt6366_da7219_max98357_driver);
> > +
> > +/* Module information */
> > +MODULE_DESCRIPTION("MT8186-MT6366-DA7219-MAX98357 ALSA SoC machine
> > driver");
> > +MODULE_AUTHOR("Jiaxin Yu <jiaxin.yu@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("mt8186_mt6366_da7219_max98357 soc card");
> 
> 


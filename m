Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9584D4D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiCJPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243865AbiCJPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:22:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD68144F65;
        Thu, 10 Mar 2022 07:21:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8CDEC1F45626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646925697;
        bh=9RWnc91qJqCydh+oNacSQRkGF+Rn1JCDF3OHEhAcIPM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iE6XZ10jXgznuAAFzstmKsm8wRjH0v2LI3HM/7SS6H0yKQglrLjuipy230guq8SJg
         ul40OkYJ39fytXbjYcOhLIcqTE9V+esiOpDeefeB4jDkokykapv7tEMyjwd2ijr95/
         SQTHmwOQEL1ogpzZDnb7qAtFFx9AC7EtdztdxoHyM2dI30AATUoPkby3JLl1DFNokz
         k43tT54Cc2Zkioxdk40EkQGQCcl1fF/kZw9xPKDUIAJhmUdfve5iZje87eO1kFGd+H
         gZZavcjftFcslMNL8oSiRV4aO+PVXLbSus6fQXe2lEbDM6w65+d5YH+S1OF/PTle7g
         SoXlLjICWPa4g==
Message-ID: <e812796f-6b9b-fe9d-50a7-b681d7b174fd@collabora.com>
Date:   Thu, 10 Mar 2022 16:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8195: add machine driver with
 mt6359, max98390 and rt5682
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        yc.hung@mediatek.com
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-5-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308072435.22460-5-trevor.wu@mediatek.com>
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

Il 08/03/22 08:24, Trevor Wu ha scritto:
> This patch adds support for mt8195 board with mt6359, max98390 and rt5682.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Hello Trevor,
thanks for the patch! However, there's something to improve...

> ---
>   sound/soc/mediatek/Kconfig                    |   16 +
>   sound/soc/mediatek/mt8195/Makefile            |    5 +
>   .../mt8195/mt8195-mt6359-max98390-rt5682.c    | 1058 +++++++++++++++++
>   3 files changed, 1079 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 0d154350f180..ce9000013ac4 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -229,3 +229,19 @@ config SND_SOC_MT8195_MT6359_RT1011_RT5682
>   	  with the MT6359 RT1011 RT5682 audio codec.
>   	  Select Y if you have such device.
>   	  If unsure select "N".
> +
> +config SND_SOC_MT8195_MT6359_MAX98390_RT5682
> +	tristate "ASoC Audio driver for MT8195 with MT6359 MAX98390 RT5682 codec"
> +	depends on I2C
> +	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
> +	select SND_SOC_MT6359
> +	select SND_SOC_MAX98390
> +	select SND_SOC_RT5682_I2C
> +	select SND_SOC_RT5682S
> +	select SND_SOC_DMIC
> +	select SND_SOC_HDMI_CODEC
> +	help
> +	  This adds ASoC driver for Mediatek MT8195 boards
> +	  with the MT6359 MAX98390 RT5682 audio codec.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> diff --git a/sound/soc/mediatek/mt8195/Makefile b/sound/soc/mediatek/mt8195/Makefile
> index d707cbd2672d..e70ee2c6a61e 100644
> --- a/sound/soc/mediatek/mt8195/Makefile
> +++ b/sound/soc/mediatek/mt8195/Makefile
> @@ -20,5 +20,10 @@ snd-soc-mt8195-rt1011-rt5682-objs := \
>   	mt8195-mt6359-rt1011-rt5682.o \
>   	mt8195-mt6359-common.o
>   
> +snd-soc-mt8195-max98390-rt5682-objs := \
> +	mt8195-mt6359-max98390-rt5682.o \
> +	mt8195-mt6359-common.o
> +
>   obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1019_RT5682) += snd-soc-mt8195-rt1019-rt5682.o
>   obj-$(CONFIG_SND_SOC_MT8195_MT6359_RT1011_RT5682) += snd-soc-mt8195-rt1011-rt5682.o
> +obj-$(CONFIG_SND_SOC_MT8195_MT6359_MAX98390_RT5682) += snd-soc-mt8195-max98390-rt5682.o
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c
> new file mode 100644
> index 000000000000..b0d55a7889d2
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c
> @@ -0,0 +1,1058 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mt8195-mt6359-max98390-rt5682.c  --
> + *	MT8195-MT6359-MAX98390-RT5682 ALSA SoC machine driver
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Trevor Wu <trevor.wu@mediatek.com>
> + */
> +
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <sound/jack.h>
> +#include <sound/pcm_params.h>
> +#include <sound/rt5682.h>
> +#include <sound/sof.h>
> +#include <sound/soc.h>
> +#include "../../codecs/rt5682.h"
> +#include "../common/mtk-afe-platform-driver.h"
> +#include "mt8195-afe-clk.h"
> +#include "mt8195-afe-common.h"
> +#include "mt8195-mt6359-common.h"
> +
> +#define MAX98390_CODEC_DAI	"max98390-aif1"
> +#define MAX98390_DEV0_NAME	"max98390.2-0038" /* right */
> +#define MAX98390_DEV1_NAME	"max98390.2-0039" /* left */
> +
> +#define RT5682_CODEC_DAI	"rt5682-aif1"
> +#define RT5682_DEV0_NAME	"rt5682.2-001a"
> +
> +#define RT5682S_CODEC_DAI	"rt5682s-aif1"
> +#define RT5682S_DEV0_NAME	"rt5682s.2-001a"
> +
> +#define SOF_DMA_DL2 "SOF_DMA_DL2"
> +#define SOF_DMA_DL3 "SOF_DMA_DL3"
> +#define SOF_DMA_UL4 "SOF_DMA_UL4"
> +#define SOF_DMA_UL5 "SOF_DMA_UL5"
> +
> +struct sof_conn_stream {
> +	const char *normal_link;
> +	const char *sof_link;
> +	const char *sof_dma;
> +	int stream_dir;
> +};
> +
> +static const struct snd_soc_dapm_widget
> +	mt8195_mt6359_max98390_rt5682_widgets[] = {
> +	SND_SOC_DAPM_SPK("Left Speaker", NULL),
> +	SND_SOC_DAPM_SPK("Right Speaker", NULL),
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),

We can at least partially reuse existing UCM2 configuration if you
slightly change the names for these controls.

Specifically, MAX98090 (yes I know it's a different codec) has names
"Speaker Left", "Speaker Right" instead, we will be able to at least
partially reuse these (or get uniform naming, which is still good).
As for the "Headphone Jack", it's simply "Headphone".

Please note that the actual control names in userspace will be, exactly,

"Speaker Left Switch", "Speaker Right Switch",
"Headphone Left Switch", "Headphone Right Switch"...

....where "Switch" gets automatically appended because of the control type.

> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),

This "Headset Mic" name is fine.

> +	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER(SOF_DMA_DL3, SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER(SOF_DMA_UL4, SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER(SOF_DMA_UL5, SND_SOC_NOPM, 0, 0, NULL, 0),
> +};
> +
> +static const struct snd_soc_dapm_route mt8195_mt6359_max98390_rt5682_routes[] = {
> +	/* speaker */
> +	{ "Left Speaker", NULL, "Left BE_OUT" },
> +	{ "Right Speaker", NULL, "Right BE_OUT" },
> +	/* headset */
> +	{ "Headphone Jack", NULL, "HPOL" },
> +	{ "Headphone Jack", NULL, "HPOR" },
> +	{ "IN1P", NULL, "Headset Mic" },
> +	/* SOF Uplink */
> +	{SOF_DMA_UL4, NULL, "O034"},
> +	{SOF_DMA_UL4, NULL, "O035"},
> +	{SOF_DMA_UL5, NULL, "O036"},
> +	{SOF_DMA_UL5, NULL, "O037"},
> +	/* SOF Downlink */
> +	{"I070", NULL, SOF_DMA_DL2},
> +	{"I071", NULL, SOF_DMA_DL2},
> +	{"I020", NULL, SOF_DMA_DL3},
> +	{"I021", NULL, SOF_DMA_DL3},
> +};
> +
> +static const struct snd_kcontrol_new mt8195_mt6359_max98390_rt5682_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Left Speaker"),
> +	SOC_DAPM_PIN_SWITCH("Right Speaker"),
> +	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +};
> +
> +static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{

This is a copy-paste of the same function, having the same name, same lines and
same everything, as found in mt8195-mt6359-rt1019-rt5682.c.

Please don't duplicate code.

> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +	unsigned int rate = params_rate(params);
> +	int bitwidth;
> +	int ret;
> +
> +	bitwidth = snd_pcm_format_width(params_format(params));
> +	if (bitwidth < 0) {
> +		dev_err(card->dev, "invalid bit width: %d\n", bitwidth);
> +		return bitwidth;
> +	}
> +
> +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x00, 0x0, 0x2, bitwidth);
> +	if (ret) {
> +		dev_err(card->dev, "failed to set tdm slot\n");
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_MCLK,
> +				  rate * 256, rate * 512);
> +	if (ret) {
> +		dev_err(card->dev, "failed to set pll\n");
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
> +				     rate * 512, SND_SOC_CLOCK_IN);
> +	if (ret) {
> +		dev_err(card->dev, "failed to set sysclk\n");
> +		return ret;
> +	}
> +
> +	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 256,
> +				      SND_SOC_CLOCK_OUT);
> +}
> +
> +static const struct snd_soc_ops mt8195_rt5682_etdm_ops = {

same here.

> +	.hw_params = mt8195_rt5682_etdm_hw_params,
> +};
> +
> +static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)


....and same for this one too, except the "struct mt8195_mt6359_priv" has
a different name.

I think that you can commonize this function by doing something like...

int mt8195_rt5682_init(struct snd_soc_jack *jack, struct mt8195_afe_private *afe,
		       struct snd_soc_component *cmpnt_codec)

...and then calling from this file, and the others.


> +{
> +	struct snd_soc_component *cmpnt_codec =
> +		asoc_rtd_to_codec(rtd, 0)->component;
> +	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_soc_jack *jack = &priv->headset_jack;
> +	struct snd_soc_component *cmpnt_afe =
> +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
> +	struct mt8195_afe_private *afe_priv = afe->platform_priv;
> +	int ret;
> +
> +	priv->i2so1_mclk = afe_priv->clk[MT8195_CLK_TOP_APLL12_DIV2];
> +
> +	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
> +				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
> +				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
> +				    SND_JACK_BTN_3,
> +				    jack, NULL, 0);
> +	if (ret) {
> +		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +
> +	ret = snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
> +	if (ret) {
> +		dev_err(rtd->dev, "Headset Jack set failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +};
> +
> +static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> +				       struct snd_pcm_hw_params *params)
> +{
> +	/* fix BE i2s format to S24_LE, clean param mask first */
> +	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
> +			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
> +
> +	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);

...this is yet another duplicated function from mt8195-mt6359-rt1019-rt5682.c.

> +
> +	return 0;
> +}
> +
> +static int mt8195_set_bias_level_post(struct snd_soc_card *card,
> +				      struct snd_soc_dapm_context *dapm,
> +				      enum snd_soc_bias_level level)


.... and again ....

> +{
> +	struct snd_soc_component *component = dapm->component;
> +	struct mt8195_mt6359_priv *priv = snd_soc_card_get_drvdata(card);
> +	int ret;
> +
> +	/*
> +	 * It's required to control mclk directly in the set_bias_level_post
> +	 * function for rt5682 and rt5682s codec, or the unexpected pop happens
> +	 * at the end of playback.
> +	 */
> +	if (!component ||
> +	    (strcmp(component->name, RT5682_DEV0_NAME) &&
> +	    strcmp(component->name, RT5682S_DEV0_NAME)))
> +		return 0;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_OFF:
> +		if (!__clk_is_enabled(priv->i2so1_mclk))
> +			return 0;
> +
> +		clk_disable_unprepare(priv->i2so1_mclk);
> +		dev_dbg(card->dev, "Disable i2so1 mclk\n");
> +		break;
> +	case SND_SOC_BIAS_ON:
> +		ret = clk_prepare_enable(priv->i2so1_mclk);
> +		if (ret) {
> +			dev_err(card->dev, "Can't enable i2so1 mclk: %d\n", ret);
> +			return ret;
> +		}
> +		dev_dbg(card->dev, "Enable i2so1 mclk\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +enum {

....and this is the same enum....

> +	DAI_LINK_DL2_FE,
> +	DAI_LINK_DL3_FE,
> +	DAI_LINK_DL6_FE,
> +	DAI_LINK_DL7_FE,
> +	DAI_LINK_DL8_FE,
> +	DAI_LINK_DL10_FE,
> +	DAI_LINK_DL11_FE,
> +	DAI_LINK_UL1_FE,
> +	DAI_LINK_UL2_FE,
> +	DAI_LINK_UL3_FE,
> +	DAI_LINK_UL4_FE,
> +	DAI_LINK_UL5_FE,
> +	DAI_LINK_UL6_FE,
> +	DAI_LINK_UL8_FE,
> +	DAI_LINK_UL9_FE,
> +	DAI_LINK_UL10_FE,
> +	DAI_LINK_DL_SRC_BE,
> +	DAI_LINK_DPTX_BE,
> +	DAI_LINK_ETDM1_IN_BE,
> +	DAI_LINK_ETDM2_IN_BE,
> +	DAI_LINK_ETDM1_OUT_BE,
> +	DAI_LINK_ETDM2_OUT_BE,
> +	DAI_LINK_ETDM3_OUT_BE,
> +	DAI_LINK_PCM1_BE,
> +	DAI_LINK_UL_SRC1_BE,
> +	DAI_LINK_UL_SRC2_BE,
> +	DAI_LINK_REGULAR_LAST = DAI_LINK_UL_SRC2_BE,
> +	DAI_LINK_SOF_START,
> +	DAI_LINK_SOF_DL2_BE = DAI_LINK_SOF_START,
> +	DAI_LINK_SOF_DL3_BE,
> +	DAI_LINK_SOF_UL4_BE,
> +	DAI_LINK_SOF_UL5_BE,
> +	DAI_LINK_SOF_END = DAI_LINK_SOF_UL5_BE,
> +};
> +
> +#define	DAI_LINK_REGULAR_NUM	(DAI_LINK_REGULAR_LAST + 1)
> +
> +/* FE */
> +SND_SOC_DAILINK_DEFS(DL2_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DL3_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DL6_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL6")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DL7_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL7")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DL8_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL8")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DL10_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL10")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DL11_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL11")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL1_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL2_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL3_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL4_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL4")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL5_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL5")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL6_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL6")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL8_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL8")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL9_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL9")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL10_FE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL10")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +/* BE */
> +SND_SOC_DAILINK_DEFS(DL_SRC_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DL_SRC")),
> +		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
> +						   "mt6359-snd-codec-aif1")),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(DPTX_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("DPTX")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(ETDM1_IN_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_IN")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_IN")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));


.... and the same dailink definitions....

> +
> +SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_OUT")),
> +		     DAILINK_COMP_ARRAY(COMP_CODEC(MAX98390_DEV0_NAME,
> +						   MAX98390_CODEC_DAI),
> +					COMP_CODEC(MAX98390_DEV1_NAME,
> +						   MAX98390_CODEC_DAI)),

...but this one is different.

> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +


....and the rest is the same again....

> +SND_SOC_DAILINK_DEFS(ETDM3_OUT_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM3_OUT")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(PCM1_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("PCM1")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL_SRC1_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC1")),
> +		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
> +						   "mt6359-snd-codec-aif1"),
> +					COMP_CODEC("dmic-codec",
> +						   "dmic-hifi")),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(UL_SRC2_BE,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC2")),
> +		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
> +						   "mt6359-snd-codec-aif2")),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(AFE_SOF_DL2,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL2")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(AFE_SOF_DL3,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_DL3")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(AFE_SOF_UL4,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL4")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(AFE_SOF_UL5,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("SOF_UL5")),
> +		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +static const struct sof_conn_stream g_sof_conn_streams[] = {

this is also the same...

> +	{ "ETDM2_OUT_BE", "AFE_SOF_DL2", SOF_DMA_DL2, SNDRV_PCM_STREAM_PLAYBACK},
> +	{ "ETDM1_OUT_BE", "AFE_SOF_DL3", SOF_DMA_DL3, SNDRV_PCM_STREAM_PLAYBACK},
> +	{ "UL_SRC1_BE", "AFE_SOF_UL4", SOF_DMA_UL4, SNDRV_PCM_STREAM_CAPTURE},
> +	{ "ETDM2_IN_BE", "AFE_SOF_UL5", SOF_DMA_UL5, SNDRV_PCM_STREAM_CAPTURE},
> +};
> +
> +/* fixup the BE DAI link to match any values from topology */
> +static int mt8195_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
> +				 struct snd_pcm_hw_params *params)
> +{

...and this function is also a copypaste...

> +	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dai_link *sof_dai_link = NULL;
> +	struct snd_soc_pcm_runtime *runtime;
> +	struct snd_soc_dai *cpu_dai;
> +	int i, j, ret = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(g_sof_conn_streams); i++) {
> +		const struct sof_conn_stream *conn = &g_sof_conn_streams[i];
> +
> +		if (strcmp(rtd->dai_link->name, conn->normal_link))
> +			continue;
> +
> +		for_each_card_rtds(card, runtime) {
> +			if (strcmp(runtime->dai_link->name, conn->sof_link))
> +				continue;
> +
> +			for_each_rtd_cpu_dais(runtime, j, cpu_dai) {
> +				if (cpu_dai->stream_active[conn->stream_dir] > 0) {
> +					sof_dai_link = runtime->dai_link;
> +					break;
> +				}
> +			}
> +			break;
> +		}
> +
> +		if (sof_dai_link && sof_dai_link->be_hw_params_fixup)
> +			ret = sof_dai_link->be_hw_params_fixup(runtime, params);
> +
> +		break;
> +	}
> +
> +	if (!strcmp(rtd->dai_link->name, "ETDM2_IN_BE") ||
> +	    !strcmp(rtd->dai_link->name, "ETDM1_OUT_BE")) {
> +		mt8195_etdm_hw_params_fixup(runtime, params);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mt8195_mt6359_max98390_rt5682_card_late_probe(struct snd_soc_card *card)
> +{

... and this function differs from mt8195_mt6359_rt1019_rt5682_card_late_probe()
only because it has a different name ...

> +	struct snd_soc_pcm_runtime *runtime;
> +	struct snd_soc_component *sof_comp = NULL;
> +	int i;
> +
> +	/* 1. find sof component */
> +	for_each_card_rtds(card, runtime) {
> +		for (i = 0; i < runtime->num_components; i++) {
> +			if (!runtime->components[i]->driver->name)
> +				continue;
> +			if (!strcmp(runtime->components[i]->driver->name, "sof-audio-component")) {
> +				sof_comp = runtime->components[i];
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (!sof_comp) {
> +		dev_info(card->dev, " probe without component\n");
> +		return 0;
> +	}
> +	/* 2. add route path and fixup callback */
> +	for (i = 0; i < ARRAY_SIZE(g_sof_conn_streams); i++) {
> +		const struct sof_conn_stream *conn = &g_sof_conn_streams[i];
> +		struct snd_soc_pcm_runtime *sof_rtd = NULL;
> +		struct snd_soc_pcm_runtime *normal_rtd = NULL;
> +		struct snd_soc_pcm_runtime *rtd = NULL;
> +
> +		for_each_card_rtds(card, rtd) {
> +			if (!strcmp(rtd->dai_link->name, conn->sof_link)) {
> +				sof_rtd = rtd;
> +				continue;
> +			}
> +			if (!strcmp(rtd->dai_link->name, conn->normal_link)) {
> +				normal_rtd = rtd;
> +				continue;
> +			}
> +			if (normal_rtd && sof_rtd)
> +				break;
> +		}
> +		if (normal_rtd && sof_rtd) {
> +			int j;
> +			struct snd_soc_dai *cpu_dai;
> +
> +			for_each_rtd_cpu_dais(sof_rtd, j, cpu_dai) {
> +				struct snd_soc_dapm_route route;
> +				struct snd_soc_dapm_path *p = NULL;
> +				struct snd_soc_dapm_widget *play_widget =
> +					cpu_dai->playback_widget;
> +				struct snd_soc_dapm_widget *cap_widget =
> +					cpu_dai->capture_widget;
> +				memset(&route, 0, sizeof(route));
> +				if (conn->stream_dir == SNDRV_PCM_STREAM_CAPTURE &&
> +				    cap_widget) {
> +					snd_soc_dapm_widget_for_each_sink_path(cap_widget, p) {
> +						route.source = conn->sof_dma;
> +						route.sink = p->sink->name;
> +						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
> +					}
> +				} else if (conn->stream_dir == SNDRV_PCM_STREAM_PLAYBACK &&
> +						play_widget){
> +					snd_soc_dapm_widget_for_each_source_path(play_widget, p) {
> +						route.source = p->source->name;
> +						route.sink = conn->sof_dma;
> +						snd_soc_dapm_add_routes(&card->dapm, &route, 1);
> +					}
> +				} else {
> +					dev_err(cpu_dai->dev, "stream dir and widget not pair\n");
> +				}
> +			}
> +			normal_rtd->dai_link->be_hw_params_fixup = mt8195_dai_link_fixup;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_link mt8195_mt6359_max98390_rt5682_dai_links[] = {


... again, different name, same contents ...


And I won't go on repeating the same thing over and over again.
I think that the best idea here is to either create a mt8195-mt6359-rt5682-common.c
file, or to rename the others to something else and get them all in the same file.


Regards,
Angelo

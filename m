Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24049100A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiAQSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:07:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:19385 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbiAQSHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642442839; x=1673978839;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wYHbQfUDUU/CHuHFtEJtTd5cuPb4vVUaDD7VmSKxuYI=;
  b=d3N8qsnXSOiSb+Rk9LN3oqc3sWMOZ2AsZ9ri36m+6vczDfHqh8LzjtV8
   TPa5hIuc0ciOoH0c2+tv+vn9sC5nly1L+/rM+o6LGaG/Jn2ruP3gTiHoX
   VfE4WI92Ed9IBBvNNHzlGTGhkN7fFP9/L99WWytcJcVmj83PtcPRbQpIN
   0luVpZL+3wa3Z48qGjZattcvolhx9sqDItkm0mrrjBoBPtllKKgUr7U26
   jLI2iPKcPriQbBBjwF/m9k5FUvwSuI9o29U9QKCM/HJ5+Dh89QlfKnQrH
   okvXEe4xoFcc2JdtooQENNOpJCrAZ8bxG7rQNVt9FQYB+4BHkZy+Sb6Gg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="269050233"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="269050233"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:07:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625260181"
Received: from pthompso-mobl1.amr.corp.intel.com (HELO [10.213.168.97]) ([10.213.168.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:06:55 -0800
Subject: Re: [PATCH] CHROMIUM:ASOC: amd: Add Machine driver Support for
 rt5682s codec
To:     V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ajitkumar.pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julian Braha <julianbraha@gmail.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220117201856.3299086-1-vsujithkumar.reddy@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fe11cf0d-8012-a431-d06b-6e9d90976d35@linux.intel.com>
Date:   Mon, 17 Jan 2022 11:22:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220117201856.3299086-1-vsujithkumar.reddy@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is the CHROMIUM prefix intentional? this should be ASoC: amd: ...


> +static int acp3x_5682s_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	int ret;
> +	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +	struct snd_soc_component *component = codec_dai->component;

reverse x-mas tree style?

> +
> +	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);

not really useful?

> +
> +	/* set rt5682s dai fmt */
> +	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
> +			| SND_SOC_DAIFMT_NB_NF
> +			| SND_SOC_DAIFMT_CBM_CFM);

please use CBP_CFP

> +	if (ret < 0) {
> +		dev_err(rtd->card->dev,
> +			"Failed to set rt5682s dai fmt: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* set codec PLL */
> +	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
> +				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set rt5682s PLL: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set codec sysclk */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682S_SCLK_S_PLL2,
> +				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(rtd->dev,
> +			"Failed to set rt5682s SYSCLK: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set tdm/i2s1 master bclk ratio */
> +	ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
> +	if (ret < 0) {
> +		dev_err(rtd->dev,
> +			"Failed to set rt5682s tdm bclk ratio: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rt5682_dai_wclk = clk_get(component->dev, "rt5682-dai-wclk");
> +	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");

test the clocks?

also use devm_ ...

> +
> +	ret = snd_soc_card_jack_new(card, "Headset Jack",
> +				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
> +				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +				    &pco_jack, NULL, 0);
> +	if (ret) {
> +		dev_err(card->dev, "HP jack creation failed %d\n", ret);
> +		return ret;

... since in this case and below the clocks are not released.

and actually the clock and jack should be handled in the platform driver
probe, not here. This wouldn't work if you remove the platform driver,
would it?

> +	}
> +
> +	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +
> +	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
> +	if (ret) {
> +		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	int ret;
> @@ -271,6 +343,8 @@ SND_SOC_DAILINK_DEF(acp3x_i2s,
>  SND_SOC_DAILINK_DEF(acp3x_bt,
>  	DAILINK_COMP_ARRAY(COMP_CPU("acp3x_i2s_playcap.2")));
>  
> +SND_SOC_DAILINK_DEF(rt5682s,
> +	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-RTL5682:00", "rt5682s-aif1")));
>  SND_SOC_DAILINK_DEF(rt5682,
>  	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5682:00", "rt5682-aif1")));
>  SND_SOC_DAILINK_DEF(max,
> @@ -458,6 +532,19 @@ static struct snd_soc_card acp3x_1015p = {
>  	.num_controls = ARRAY_SIZE(acp3x_mc_1015p_controls),
>  };
>  
> +static struct snd_soc_card acp3x_5682s = {
> +	.name = "acp3xrt5682s98357",
> +	.owner = THIS_MODULE,
> +	.dai_link = acp3x_dai,
> +	.num_links = ARRAY_SIZE(acp3x_dai),
> +	.dapm_widgets = acp3x_1015p_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(acp3x_1015p_widgets),
> +	.dapm_routes = acp3x_1015p_route,
> +	.num_dapm_routes = ARRAY_SIZE(acp3x_1015p_route),
> +	.controls = acp3x_mc_1015p_controls,
> +	.num_controls = ARRAY_SIZE(acp3x_mc_1015p_controls),
> +};
> +
>  void *soc_is_rltk_max(struct device *dev)
>  {
>  	const struct acpi_device_id *match;
> @@ -468,6 +555,27 @@ void *soc_is_rltk_max(struct device *dev)
>  	return (void *)match->driver_data;
>  }
>  
> +static void card_hs_dai_link_present(struct snd_soc_dai_link *links,
> +					const char *card_name)
> +{
> +	if (!strcmp(card_name, "acp3xrt5682s98357")) {
> +		links[0].name = "acp3x-5682s-play";
> +		links[0].stream_name = "Playback";
> +		links[0].dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +				   SND_SOC_DAIFMT_CBM_CFM;

CBP_CFP

> +
> +		links[0].codecs = rt5682s;
> +		links[0].num_codecs = ARRAY_SIZE(rt5682s);
> +		links[0].init = acp3x_5682s_init;

again it seems wrong to allocate resources such as jacks and clocks in a
dailink init.

> +		links[0].dpcm_playback = 1;
> +		links[0].dpcm_capture = 1;
> +		links[0].cpus = acp3x_i2s;
> +		links[0].num_cpus = ARRAY_SIZE(acp3x_i2s);
> +		links[0].platforms = platform;
> +		links[0].num_platforms = ARRAY_SIZE(platform);
> +	}
> +}
> +
>  static void card_spk_dai_link_present(struct snd_soc_dai_link *links,
>  						const char *card_name)
>  {
> @@ -497,7 +605,7 @@ static int acp3x_probe(struct platform_device *pdev)
>  	machine = devm_kzalloc(&pdev->dev, sizeof(*machine), GFP_KERNEL);
>  	if (!machine)
>  		return -ENOMEM;
> -
> +	card_hs_dai_link_present(card->dai_link, card->name);
>  	card_spk_dai_link_present(card->dai_link, card->name);
>  	card->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, card);
> @@ -523,6 +631,7 @@ static const struct acpi_device_id acp3x_audio_acpi_match[] = {
>  	{ "AMDI5682", (unsigned long)&acp3x_5682},
>  	{ "AMDI1015", (unsigned long)&acp3x_1015},
>  	{ "10021015", (unsigned long)&acp3x_1015p},
> +	{ "10029835", (unsigned long)&acp3x_5682s},

how does '9835' relate to RT5682s? You may want at least a comment.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
> 

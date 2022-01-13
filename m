Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90048DDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiAMSi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:38:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:61109 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237584AbiAMSit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642099129; x=1673635129;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5g26MQKibx5sVbKGA7CFhTcEXcX6VmlkTwTbFUe7AUw=;
  b=Cw9aWNiNYmFmHVCfZPL8L+2u7sotnWB7Hx6AmHrolocCF96uM1oDRgtZ
   GkjXDe1ppCxgoVEpdAoV9wubR2ixlR59u//L49Xr/DzcTvMVxy2JVHmUX
   MdJU3Nim29yOsb3LANRxg34BdTP0o3Lzjry3QKgD3cZZ0wv97/y6hNg7C
   lkF6V6NN6S7vh6Qz2znTta554FtznXE9Y+52PL8eUUNdV/LAs/R3nf19d
   Y2cbmoclo1iScA546d2xSgeto5BdfvTx+CqAuK+KKtBQ25W8qNAUoO/vR
   Hcfh4VWOr2wm4RrmdxeieALOG7HLJ4sfjPKoapr5zSfmquBlYZWYpgqUr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242902881"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="242902881"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:38:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="620699925"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70]) ([10.212.66.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:38:47 -0800
Subject: Re: [PATCH v2 5/6] ASoC: amd: acp: acp-legacy: Add DMIC dai link
 support for Renoir
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
 <20220113163348.434108-6-AjitKumar.Pandey@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <090e073f-01d8-e0b1-646d-5ae1eceed7d9@linux.intel.com>
Date:   Thu, 13 Jan 2022 12:38:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113163348.434108-6-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
> index 0ad1cf41b308..91140d15691b 100644
> --- a/sound/soc/amd/acp/acp-legacy-mach.c
> +++ b/sound/soc/amd/acp/acp-legacy-mach.c
> @@ -23,10 +23,10 @@
>  static struct acp_card_drvdata rt5682_rt1019_data = {
>  	.hs_cpu_id = I2S_SP,
>  	.amp_cpu_id = I2S_SP,
> -	.dmic_cpu_id = NONE,
> +	.dmic_cpu_id = DMIC,
>  	.hs_codec_id = RT5682,
>  	.amp_codec_id = RT1019,
> -	.dmic_codec_id = NONE,
> +	.dmic_codec_id = DMIC,

this definition is not used?

>  	.gpio_spkr_en = EN_SPKR_GPIO_GB,
>  };
>  
> diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
> index c9caade5cb74..b163e3a68166 100644
> --- a/sound/soc/amd/acp/acp-mach-common.c
> +++ b/sound/soc/amd/acp/acp-mach-common.c
> @@ -438,6 +438,8 @@ SND_SOC_DAILINK_DEF(sof_sp,
>  	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
>  SND_SOC_DAILINK_DEF(sof_dmic,
>  	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
> +SND_SOC_DAILINK_DEF(pdm_dmic,
> +	DAILINK_COMP_ARRAY(COMP_CPU("acp-pdm-dmic")));
>  
>  int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
>  {
> @@ -613,6 +615,19 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
>  			links[i].ops = &acp_card_maxim_ops;
>  			links[i].init = acp_card_maxim_init;
>  		}
> +		i++;
> +	}
> +
> +	if (drv_data->dmic_cpu_id == DMIC) {
> +		links[i].name = "acp-dmic-codec";
> +		links[i].id = DMIC_BE_ID;
> +		links[i].codecs = dmic_codec;
> +		links[i].num_codecs = ARRAY_SIZE(dmic_codec);
> +		links[i].cpus = pdm_dmic;
> +		links[i].num_cpus = ARRAY_SIZE(pdm_dmic);
> +		links[i].platforms = platform_component;
> +		links[i].num_platforms = ARRAY_SIZE(platform_component);
> +		links[i].dpcm_capture = 1;
>  	}
>  
>  	card->dai_link = links;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B005345C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiEYVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345345AbiEYVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:30:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B08148B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653514240; x=1685050240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FoPSSUs1/5dO5P26gVSwaImoqHPclA56N3pkOrZONTg=;
  b=Lj02f7OC4xlexSWEw9kC3SUcGS8J+SoRFmYe9tSFXedCJ7up9lRXLQ5S
   bs2MMexb0WnBmGql182HbZ6sKQwFXv043X+O7jbkyZopqYYVXceyVIue5
   aip158UoeB8zfqoj6VhoTASLrUb3uS/P5+ycm6vfUSIsGD7xPAxnD71H/
   9AbbXbcAubuQwbPVe1qCPDgVU9DJU5rpWba/Hh1BhjGKUTCZhHHBXxphF
   e5uxpJBscNnkI3ZMqSVnISDEwYvDeRzoRhqR/36rt+F7Ak6/B9Wue+ZaF
   FZVt43mG4VJD4Jts7sHaUVuD8Sm8wRAG3SP2zu/hwCSNNn021WNdpVt7n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271513315"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="271513315"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 14:30:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="745955669"
Received: from srotter-mobl1.amr.corp.intel.com (HELO [10.212.216.74]) ([10.212.216.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 14:30:38 -0700
Message-ID: <01acfbad-7668-dfc6-b797-a9fa5f402a26@linux.intel.com>
Date:   Wed, 25 May 2022 16:28:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] ASoC: amd: acp: Add support for rt5682s and rt1019
 card with hs instance
Content-Language: en-US
To:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220525203415.2227914-1-Vsujithkumar.Reddy@amd.com>
 <20220525203415.2227914-3-Vsujithkumar.Reddy@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220525203415.2227914-3-Vsujithkumar.Reddy@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 15:34, V sujith kumar Reddy wrote:
> We have new platform with rt5682s as a primary codec and rt1019 as an
> amp codec. Add machine struct to register sof audio based sound card
> on such Chrome machine.
> 
> Here we are configuring as a soc mclk master and codec slave.
> 
> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> ---
>  sound/soc/amd/acp-config.c          |  9 ++++
>  sound/soc/amd/acp/acp-mach-common.c | 69 ++++++++++++++++++++++++-----
>  sound/soc/amd/acp/acp-sof-mach.c    | 15 +++++++
>  3 files changed, 82 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
> index ba9e0adacc4a..39ca48be7be9 100644
> --- a/sound/soc/amd/acp-config.c
> +++ b/sound/soc/amd/acp-config.c
> @@ -147,6 +147,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
>  		.fw_filename = "sof-rmb.ri",
>  		.sof_tplg_filename = "sof-acp-rmb.tplg",
>  	},
> +	{
> +		.id = "RTL5682",
> +		.drv_name = "rt5682s-hs-rt1019",
> +		.pdata = &acp_quirk_data,
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &amp_rt1019,
> +		.fw_filename = "sof-rmb.ri",
> +		.sof_tplg_filename = "sof-acp-rmb.tplg",
> +	},

that means a 3rd entry with the same pair of firmware/topology files?

>  	{},
>  };
>  EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
> diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
> index a03b396d96bb..4aad3fee51cf 100644
> --- a/sound/soc/amd/acp/acp-mach-common.c
> +++ b/sound/soc/amd/acp/acp-mach-common.c
> @@ -148,10 +148,15 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
>  	struct snd_soc_card *card = rtd->card;
>  	struct acp_card_drvdata *drvdata = card->drvdata;
>  	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> -	int ret;
> +	unsigned int fmt = 0;

fmt initialization is overridden below.

> +	int ret = 0;

useless init...

>  
> -	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> -				   | SND_SOC_DAIFMT_CBP_CFP);
> +	if (drvdata->soc_mclk)
> +		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
> +	else
> +		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
> +
> +	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);

... overridden here

>  	if (ret < 0) {
>  		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
>  		return ret;


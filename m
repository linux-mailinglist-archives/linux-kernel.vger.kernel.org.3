Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C810A5393B8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiEaPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiEaPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:14:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112261616
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010076; x=1685546076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KzVObEc7Veab/GZreg6FyOROGy7YjFcSKS2Z9DBNJis=;
  b=YGim7AhRATWaafYe5Wl2U9pp+RJg2yS24tp1yg5GHCcT8+IXVXbTMJdM
   VPmAAe4SW8IFvr9cJ/NUQyeWXTtE92XQurp1H8v1rrZNqcHspZU4HKxvy
   NTRissCBWZPBs552vUNokomh1HRTuKCv37gotzZn2AxbDK3UqaEIvwoJW
   uZwF8yxRwarOqRuKCCodTv/SM2QZ0WlgbujYyN65vR9x5cqHK19ctQMGN
   j85eF3H5GNmKRlziTmnT8SbQVVHAIB86qpxgo35icRCZK8JRLnuyt61Li
   /VsT3ayZhUFG9UAi2qrDIwA6UsbgiKSaIJpNAz6WpNrUvS3zZIVjrUsaZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361660467"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="361660467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:11:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="720349516"
Received: from kmoorti-mobl.amr.corp.intel.com (HELO [10.212.153.18]) ([10.212.153.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:11:12 -0700
Message-ID: <8a8a6bd9-aabf-6f27-0422-a47b01556276@linux.intel.com>
Date:   Tue, 31 May 2022 09:51:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: Intel: cirrus-common: fix incorrect channel mapping
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        xliu <xiang.liu@cirrus.com>, linux-kernel@vger.kernel.org
References: <20220530125421.885236-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220530125421.885236-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 07:54, Brent Lu wrote:
> From: xliu <xiang.liu@cirrus.com>
> 
> The default mapping of ASPRX1 Slot is left channel. Map the slots of
> right amplifiers (WR and TR) to right channel.
> 
> Signed-off-by: xliu <xiang.liu@cirrus.com>
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/boards/sof_cirrus_common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
> index e71d74ec1b0b..64ca0e3991dc 100644
> --- a/sound/soc/intel/boards/sof_cirrus_common.c
> +++ b/sound/soc/intel/boards/sof_cirrus_common.c
> @@ -107,6 +107,7 @@ static int cs35l41_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>  	struct snd_soc_dai *codec_dai;
>  	int clk_freq, i, ret;
> +	int rx_ch[2] = {1, 0};

Should this be 'const'?

I am also not clear on the mapping, how does this select the right
channel? This selects slot0 and the left channel, what am I missing?


>  
>  	clk_freq = sof_dai_get_bclk(rtd); /* BCLK freq */
>  
> @@ -134,6 +135,17 @@ static int cs35l41_hw_params(struct snd_pcm_substream *substream,
>  				ret);
>  			return ret;
>  		}
> +
> +		/* Setup for R channel Slot: WR and TR */
> +		if (i % 2) {
> +			ret = snd_soc_dai_set_channel_map(codec_dai, 0, NULL,
> +							  ARRAY_SIZE(rx_ch), rx_ch);
> +			if (ret < 0) {
> +				dev_err(codec_dai->dev, "fail to set channel map, ret %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}

Should we do this loop for the left channels as well to have an explicit
setting?

>  	}
>  
>  	return 0;

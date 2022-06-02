Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D453BA9F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiFBOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiFBOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:23:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31262666
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654179787; x=1685715787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10tdVqNXMtoaGj37cG5xipixchrN/gTHN1SNied7ehI=;
  b=nqUi7sNLARle8JQiHod0u9HKqIhr+MWouXsoYbd8wYmMm1uMT8LLA4JT
   cBJPKVU3V5Jp6FyF6r6A28/tLlaOzVP6vCcSzBJIj2B0o+En9IR4UeXtv
   92CQaauw6bCsLVop/70TJ45qs1GX1i1YWN+lMIxbdEpPkQxy/z1MRE+PQ
   IZBVIuQeDTKgoDWkX71HsdZTzar2WWRKuq3bxnytW+/khupfSqf4/OiRj
   ukZivsXyf0nqiuynnz/oFbNW0Tad3jvkLuppfWuGxAM6blrEf3Zdr3n60
   Xr0B98R0RDcjsxK+60rcaDCQENPp2ELuD9gXVJRTnBb18Falni/P/SrLC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="258034932"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="258034932"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 07:23:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="905008802"
Received: from dvnguye2-mobl.amr.corp.intel.com (HELO [10.251.7.96]) ([10.251.7.96])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 07:23:05 -0700
Message-ID: <53e13af2-d279-372c-0b5b-fdf3277e0231@linux.intel.com>
Date:   Thu, 2 Jun 2022 09:13:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ASoC: Intel: cirrus-common: fix incorrect channel
 mapping
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, xliu <xiang.liu@cirrus.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220602051922.1232457-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220602051922.1232457-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/22 00:19, Brent Lu wrote:
> From: xliu <xiang.liu@cirrus.com>
> 
> The default mapping of ASPRX1 (DAC source) is slot 0. Change the slot
> mapping of right amplifiers (WR and TR) to slot 1 to receive right
> channel data. Also update the ACPI instance ID mapping according to HW
> configuration.
> 
> Signed-off-by: xliu <xiang.liu@cirrus.com>
> Signed-off-by: Brent Lu <brent.lu@intel.com>

This v2 looks much better and self-explanatory. Thanks!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_cirrus_common.c | 40 +++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
> index e71d74ec1b0b..f4192df962d6 100644
> --- a/sound/soc/intel/boards/sof_cirrus_common.c
> +++ b/sound/soc/intel/boards/sof_cirrus_common.c
> @@ -54,22 +54,29 @@ static struct snd_soc_dai_link_component cs35l41_components[] = {
>  	},
>  };
>  
> +/*
> + * Mapping between ACPI instance id and speaker position.
> + *
> + * Four speakers:
> + *         0: Tweeter left, 1: Woofer left
> + *         2: Tweeter right, 3: Woofer right
> + */
>  static struct snd_soc_codec_conf cs35l41_codec_conf[] = {
>  	{
>  		.dlc = COMP_CODEC_CONF(CS35L41_DEV0_NAME),
> -		.name_prefix = "WL",
> +		.name_prefix = "TL",
>  	},
>  	{
>  		.dlc = COMP_CODEC_CONF(CS35L41_DEV1_NAME),
> -		.name_prefix = "WR",
> +		.name_prefix = "WL",
>  	},
>  	{
>  		.dlc = COMP_CODEC_CONF(CS35L41_DEV2_NAME),
> -		.name_prefix = "TL",
> +		.name_prefix = "TR",
>  	},
>  	{
>  		.dlc = COMP_CODEC_CONF(CS35L41_DEV3_NAME),
> -		.name_prefix = "TR",
> +		.name_prefix = "WR",
>  	},
>  };
>  
> @@ -101,6 +108,21 @@ static int cs35l41_init(struct snd_soc_pcm_runtime *rtd)
>  	return ret;
>  }
>  
> +/*
> + * Channel map:
> + *
> + * TL/WL: ASPRX1 on slot 0, ASPRX2 on slot 1 (default)
> + * TR/WR: ASPRX1 on slot 1, ASPRX2 on slot 0
> + */
> +static const struct {
> +	unsigned int rx[2];
> +} cs35l41_channel_map[] = {
> +	{.rx = {0, 1}}, /* TL */
> +	{.rx = {0, 1}}, /* WL */
> +	{.rx = {1, 0}}, /* TR */
> +	{.rx = {1, 0}}, /* WR */
> +};
> +
>  static int cs35l41_hw_params(struct snd_pcm_substream *substream,
>  			     struct snd_pcm_hw_params *params)
>  {
> @@ -134,6 +156,16 @@ static int cs35l41_hw_params(struct snd_pcm_substream *substream,
>  				ret);
>  			return ret;
>  		}
> +
> +		/* setup channel map */
> +		ret = snd_soc_dai_set_channel_map(codec_dai, 0, NULL,
> +						  ARRAY_SIZE(cs35l41_channel_map[i].rx),
> +						  (unsigned int *)cs35l41_channel_map[i].rx);
> +		if (ret < 0) {
> +			dev_err(codec_dai->dev, "fail to set channel map, ret %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	return 0;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D424E9AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiC1PN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbiC1PNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:13:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8653A46;
        Mon, 28 Mar 2022 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648480315; x=1680016315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0Xfm6ZmBe6qP65GEW9BCvq91UKkCOHo/5Qe8dITTyQs=;
  b=ngmVcqbMtM6+a3J4CdzaKjJNJ4fKpaNjWjhiVZ35CS3FHmymgU+VZ9yn
   uNCzucvlXTThxXNdz7o5pxiuD2rBR7giboer4umtaeCgNkbY60UTj3LIp
   pPUpMF9RC0HNOuPaogt6qkf2NXtZCBqm8ySKU1SOw0Nf4nwEm654V3pYm
   52jgB45ue2EzCE+keShQMABSEvqpg+A68tQBCV2TS+XYGQtgg2PXZHKoE
   OEXFxCReu9JVmyUgKrCp/4xtQAXbEi2utNhyWFn+Gh9roqeStPX+SnsuY
   /UAeZ7Tjs4vWcK7fmLij2cZgUeFIjfuyNNjvhd9649tn/muGSUujD8CoP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258991028"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="258991028"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:11:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="719145825"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.166]) ([10.99.249.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:11:50 -0700
Message-ID: <6ae534e4-25f8-5825-a2ec-cb1c512dac57@linux.intel.com>
Date:   Mon, 28 Mar 2022 17:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 4/6] ASoC: soc-pcm: tweak DPCM BE hw_param() call
 order
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-5-git-send-email-spujar@nvidia.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <1648448050-15237-5-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2022 8:14 AM, Sameer Pujar wrote:
> For DPCM links, the order of hw_param() call depends on the sequence of
> BE connection to FE. It is possible that one BE link can provide clock
> to another BE link. In such cases consumer BE DAI, to get the rate set
> by provider BE DAI, can use the standard clock functions only if provider
> has already set the appropriate rate during its hw_param() stage.

Above sentence seems to suggest that consumer can set clock only after 
provider has started, but code in this patch seems to do it the other 
way around?

> 
> Presently the order is fixed and does not depend on the provider and
> consumer relationships. So the clock rates need to be known ahead of
> hw_param() stage.
> 
> This patch tweaks the hw_param() order by connecting the provider BEs
> late to a FE. With this hw_param() calls for provider BEs happen first
> and then followed by consumer BEs. The consumers can use the standard
> clk_get_rate() function to get the rate of the clock they depend on.
> 

I'm bit confused by " With this hw_param() calls for provider BEs happen 
first and then followed by consumer BEs. "

Aren't consumers started first and provider second? Code and previous 
sentence "connecting the provider BEs late to a FE" confuse me.

Overall I don't exactly understand correct order of events after reading 
commit message and patch...

> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   TODO:
>    * The FE link is not considered in this. For Tegra it is fine to
>      call hw_params() for FE at the end. But systems, which want to apply
>      this tweak for FE as well, have to extend this tweak to FE.
>    * Also only DPCM is considered here. If normal links require such
>      tweak, it needs to be extended.
> 
>   sound/soc/soc-pcm.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 9a95468..5829514 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1442,6 +1442,29 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
>   	return prune;
>   }
>   
> +static bool defer_dpcm_be_connect(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *dai;
> +	int i;
> +
> +	if (!(rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK))
> +		return false;
> +
> +	if ((rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
> +	    SND_SOC_DAIFMT_CBC_CFC) {
> +
> +		for_each_rtd_cpu_dais(rtd, i, dai) {
> +
> +			if (!snd_soc_dai_is_dummy(dai))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +#define MAX_CLK_PROVIDER_BE 10

Not sure about this define, it adds unnecessary limitation on max clock 
number, can't you just run same loop twice while checking 
defer_dpcm_be_connect() first time and !defer_dpcm_be_connect() second 
time? defer_dpcm_be_connect() function name may need a bit of adjustment 
(rtd_is_clock_consumer() maybe?), but it gets rid of the limit.

or do something like following instead of copy pasting loop twice:

rename original dpcm_add_paths() to _dpcm_add_paths() and add additional 
argument and check somewhere inline:
static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
	struct snd_soc_dapm_widget_list **list_, bool clock_consumer)
{
	...

  // with renamed defer_dpcm_be_connect
	if (clock_consumer ^ !rtd_is_clock_consumer())
		continue;

	...
}

static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
    	struct snd_soc_dapm_widget_list **list_)
{
	int ret;

	/* start clock consumer BEs */
	ret = _dpcm_add_paths(*fe, stream, **list_, true);
	if (ret)
		return ret;

	/* start clock provider BEs */
	ret = _dpcm_add_paths(*fe, stream, **list_, false);

	return ret;
}

> +
>   static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>   	struct snd_soc_dapm_widget_list **list_)
>   {
> @@ -1449,7 +1472,8 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>   	struct snd_soc_dapm_widget_list *list = *list_;
>   	struct snd_soc_pcm_runtime *be;
>   	struct snd_soc_dapm_widget *widget;
> -	int i, new = 0, err;
> +	struct snd_soc_pcm_runtime *prov[MAX_CLK_PROVIDER_BE];
> +	int i, new = 0, err, count = 0;
>   
>   	/* Create any new FE <--> BE connections */
>   	for_each_dapm_widgets(list, i, widget) {
> @@ -1489,6 +1513,40 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>   		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
>   			continue;
>   
> +		/* Connect clock provider BEs at the end */
> +		if (defer_dpcm_be_connect(be)) {
> +			if (count >= MAX_CLK_PROVIDER_BE) {
> +				dev_err(fe->dev, "ASoC: too many clock provider BEs\n");
> +				return -EINVAL;
> +			}
> +
> +			prov[count++] = be;
> +			continue;
> +		}
> +
> +		/* newly connected FE and BE */
> +		err = dpcm_be_connect(fe, be, stream);
> +		if (err < 0) {
> +			dev_err(fe->dev, "ASoC: can't connect %s\n",
> +				widget->name);
> +			break;
> +		} else if (err == 0) /* already connected */
> +			continue;
> +
> +		/* new */
> +		dpcm_set_be_update_state(be, stream, SND_SOC_DPCM_UPDATE_BE);
> +		new++;
> +	}
> +
> +	/*
> +	 * Now connect clock provider BEs. A late connection means,
> +	 * these BE links appear first in the list maintained by FE
> +	 * and hw_param() call for these happen first.

Let's stick to ALSA terminology, hw_params() please, same in commit message.

> +	 */
> +	for (i = 0; i < count; i++) {
> +
> +		be = prov[i];
> +
>   		/* newly connected FE and BE */
>   		err = dpcm_be_connect(fe, be, stream);
>   		if (err < 0) {


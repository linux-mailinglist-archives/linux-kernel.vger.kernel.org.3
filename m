Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87754E9B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiC1Pba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiC1Pb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:31:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DEE3CA4D;
        Mon, 28 Mar 2022 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648481386; x=1680017386;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ujQCSh8gd9iXs63iL8zY1QPpgpG7qcOOfXmWogNz3mg=;
  b=Z9wZRuLYX1bKRDwZG2Q6NppxZLRflAt5DYNaTyxRp+BRNQHZCb/AprW9
   NfnEppq+sbNvQNoLfcttE/xI4VWftehq0oenlquFVIdMP8ZE0pS3/iS6O
   NJ+zGN6+KJ9QghfKR4NFrrczFgiOoWHiC4JnUcTEH3Q1exTZFH6HDu0TI
   MOzgoN72saB0QzP/nCmhKWkYWR+wfDKu85MqZPjdKKgdB3tTWMlD1zYZ3
   /plDZ1jvjSXU3X/XUcMBpTDqBfqheTYd+ySPurVQG/X8u3F1zIRw9ueiO
   T6L0MiBgKQRMxaDAZEalqfeKJBAtPQtHwcblnVf+wipwZpAlsat4dQpTc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258997215"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="258997215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:29:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="563756053"
Received: from gsfreema-mobl1.amr.corp.intel.com ([10.251.131.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:29:45 -0700
Message-ID: <51c8d2541ccff2689b9164ab9b671b0b2514e65f.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2 4/6] ASoC: soc-pcm: tweak DPCM BE hw_param() call
 order
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org
Date:   Mon, 28 Mar 2022 08:29:45 -0700
In-Reply-To: <1648448050-15237-5-git-send-email-spujar@nvidia.com>
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
         <1648448050-15237-5-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 11:44 +0530, Sameer Pujar wrote:
> For DPCM links, the order of hw_param() call depends on the sequence
> of
> BE connection to FE. It is possible that one BE link can provide
> clock
> to another BE link. In such cases consumer BE DAI, to get the rate
> set
> by provider BE DAI, can use the standard clock functions only if
> provider
> has already set the appropriate rate during its hw_param() stage.
> 
> Presently the order is fixed and does not depend on the provider and
> consumer relationships. So the clock rates need to be known ahead of
> hw_param() stage.
> 
> This patch tweaks the hw_param() order by connecting the provider BEs
> late to a FE. With this hw_param() calls for provider BEs happen
> first
> and then followed by consumer BEs. The consumers can use the standard
> clk_get_rate() function to get the rate of the clock they depend on.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  TODO:
>   * The FE link is not considered in this. For Tegra it is fine to
>     call hw_params() for FE at the end. But systems, which want to
> apply
>     this tweak for FE as well, have to extend this tweak to FE.
>   * Also only DPCM is considered here. If normal links require such
>     tweak, it needs to be extended.
> 
>  sound/soc/soc-pcm.c | 60
> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 9a95468..5829514 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1442,6 +1442,29 @@ static int dpcm_prune_paths(struct
> snd_soc_pcm_runtime *fe, int stream,
>  	return prune;
>  }
>  
> +static bool defer_dpcm_be_connect(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *dai;
> +	int i;
> +
> +	if (!(rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK))
> +		return false;
Is this check necessary?
> +
> +	if ((rtd->dai_link->dai_fmt &
> SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
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
> +
>  static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int
> stream,
>  	struct snd_soc_dapm_widget_list **list_)
>  {
> @@ -1449,7 +1472,8 @@ static int dpcm_add_paths(struct
> snd_soc_pcm_runtime *fe, int stream,
>  	struct snd_soc_dapm_widget_list *list = *list_;
>  	struct snd_soc_pcm_runtime *be;
>  	struct snd_soc_dapm_widget *widget;
> -	int i, new = 0, err;
> +	struct snd_soc_pcm_runtime *prov[MAX_CLK_PROVIDER_BE];
> +	int i, new = 0, err, count = 0;
>  
>  	/* Create any new FE <--> BE connections */
>  	for_each_dapm_widgets(list, i, widget) {
> @@ -1489,6 +1513,40 @@ static int dpcm_add_paths(struct
> snd_soc_pcm_runtime *fe, int stream,
>  		    (be->dpcm[stream].state !=
> SND_SOC_DPCM_STATE_CLOSE))
>  			continue;
>  
> +		/* Connect clock provider BEs at the end */
> +		if (defer_dpcm_be_connect(be)) {
> +			if (count >= MAX_CLK_PROVIDER_BE) {
What determines MAX_CLK_PROVIDER_BE? why 10? Can you use rtd->num_cpus
instead? 
Thanks,
Ranjani


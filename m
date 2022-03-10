Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5924D5278
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbiCJSwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCJSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:52:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D4F94FA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646938259; x=1678474259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gPJHila5zLpPmYhvasnJNpKqqfvFsbmocAlOkHlc8nA=;
  b=G3lhrTFwMDErU6kxwuEfe0l3Q4AB0GtKBQp/XFpN7LNaiXgJThZ0U9qb
   nOIgZ8LP+7d56796AYRnXrA7iO/JivMrqxVAuFA59F3uphEAwWhWcqNoY
   HqBslJ1qfi8mBd1xeCz9BPlFRu/y951XhLbGfFbaJzNiJUFj1HhOA7PvA
   A7gY4XOEStVUcDsInxQj1emYkIYOkOXHyseHfxJ7RE7oJWXRxk+jchux/
   NAVHtbx1Mqpr0SeGr3xVlBiHj8Ggr3Z5qkzMO1PdGyeiD6fvW9ssAdkMV
   ieK3OApDbMPx58wZS1AKkwVNGWnMh4WpW/h+sDBHurGeD7WXXisnNaIE5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237512180"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237512180"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 10:50:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="816005666"
Received: from maxdorn-mobl.amr.corp.intel.com (HELO [10.209.77.185]) ([10.209.77.185])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 10:50:57 -0800
Message-ID: <1371b991-ba9e-f1a8-db6a-f5cd645e7ba6@linux.intel.com>
Date:   Thu, 10 Mar 2022 09:30:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: Intel: boards: Use temporary variable for struct
 device
Content-Language: en-US
To:     Zhen Ni <nizhen@uniontech.com>, broonie@kernel.org, tiwai@suse.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220310065354.14493-1-nizhen@uniontech.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220310065354.14493-1-nizhen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/22 00:53, Zhen Ni wrote:
> Use temporary variable for struct device to make code neater. >
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

There's quite a few Intel machine drivers where we have the same sort of 
code, we'll need to do a wider cleanup at some point.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 1bc21434c9de..d9f4206e1f96 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -538,7 +538,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   	const char *platform_name;
>   	bool sof_parent;
>   
> -	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
>   	if (!drv)
>   		return -ENOMEM;
>   
> @@ -559,8 +559,8 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   	}
>   
>   	/* override plaform name, if required */
> -	snd_soc_card_cht.dev = &pdev->dev;
> -	mach = pdev->dev.platform_data;
> +	snd_soc_card_cht.dev = dev;
> +	mach = dev->platform_data;
>   	platform_name = mach->mach_params.platform;
>   
>   	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
> @@ -576,9 +576,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   	else
>   		mclk_name = "pmc_plt_clk_3";
>   
> -	drv->mclk = devm_clk_get(&pdev->dev, mclk_name);
> +	drv->mclk = devm_clk_get(dev, mclk_name);
>   	if (IS_ERR(drv->mclk)) {
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>   			"Failed to get MCLK from %s: %ld\n",
>   			mclk_name, PTR_ERR(drv->mclk));
>   		return PTR_ERR(drv->mclk);
> @@ -594,12 +594,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   	if (drv->quirks & QUIRK_PMC_PLT_CLK_0) {
>   		ret_val = clk_prepare_enable(drv->mclk);
>   		if (ret_val < 0) {
> -			dev_err(&pdev->dev, "MCLK enable error: %d\n", ret_val);
> +			dev_err(dev, "MCLK enable error: %d\n", ret_val);
>   			return ret_val;
>   		}
>   	}
>   
> -	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
> +	sof_parent = snd_soc_acpi_sof_parent(dev);
>   
>   	/* set card and driver name */
>   	if (sof_parent) {
> @@ -614,9 +614,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   	if (sof_parent)
>   		dev->driver->pm = &snd_soc_pm_ops;
>   
> -	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
> +	ret_val = devm_snd_soc_register_card(dev, &snd_soc_card_cht);
>   	if (ret_val) {
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>   			"snd_soc_register_card failed %d\n", ret_val);
>   		return ret_val;
>   	}

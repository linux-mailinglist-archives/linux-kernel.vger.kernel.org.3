Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936CA58C466
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiHHHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiHHHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:51:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763616268;
        Mon,  8 Aug 2022 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659945081; x=1691481081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w2oVn/9yhFWn7yqZ9M6VgmJBgHr61NGPEcOPgx2ofJ8=;
  b=OZav7e/y0c396bVwrAZQjH+AJNUqK5sVToRLK3Rv3ChB4aSdMT7oS+wI
   Ls46RFNCxT4YWmLDoHFKc6vUrH5eY/qvMotpZJQZCqB09llqWmtjPf+jR
   ZliuPNltdXPtz15KYxExgkr5SnXxHKyd0phPGbzMCrXWWjQXl72ZIBX2Z
   r4ybF4Nwawk2aOB8Os36JYMv2L7GmHB4Y2P7IFXD6gu8RQ2fg2Stbm5UI
   xadJPKoQADd5lekeee7bptifJK3Dc+B9XX8BvKj/OTyLnv16QakZoAN2S
   R57/+QixtuG3n2qheWC/scX6QNUc5TDfO5hVUkXu6Ia/DMo7HlH/Ebkao
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270304013"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="270304013"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 00:51:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="672382302"
Received: from ajanoscz-mobl1.ger.corp.intel.com (HELO [10.252.35.108]) ([10.252.35.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 00:51:15 -0700
Message-ID: <91d05e59-8123-de3f-55da-62b74ac96ddd@linux.intel.com>
Date:   Mon, 8 Aug 2022 09:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Simplify clk_get()
 usage
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/22 22:18, Christophe JAILLET wrote:
> If clk_get() returns -ENOENT, there is no need to defer the driver, -ENOENT
> will be returned the same for each retries.
> So, return the error code directly instead of -EPROBE_DEFER.
> 
> Remove this special case and use dev_err_probe() to simplify code. It will
> also be less verbose if the clk is really deferred.
> 
> Fixes: f7f61e08fe58 ("ASoC: Intel: kbl: Enable mclk and ssp sclk early")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is based on my understanding of clk_get().
> Review with care.
> 
> Not sure the Fixes tag is needed. The patch does not fix anything.
> If devm_clk_get() returns -ENOENT, it will just loop several time until
> the framework gives up.
> If it returns -EPROBE_DEFER, this case is already handled by the
> "return ret;"
> 
> So this patch should be a no-op, just a clean-up.

I can't pretend understanding the clk framework in depth, but the only
case where -ENOENT is returned seems to be this block in clk_hw_create_clk()

	if (!try_module_get(core->owner)) {
		free_clk(clk);
		return ERR_PTR(-ENOENT);
	}

I have no idea why this would be converted to a -EPROBE_DEFER. May to
account for module loading?

> ---
>  sound/soc/intel/boards/kbl_rt5663_max98927.c | 31 ++++----------------
>  1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> index 2d4224c5b152..07b00af2fa3c 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> @@ -989,7 +989,6 @@ static int kabylake_audio_probe(struct platform_device *pdev)
>  {
>  	struct kbl_rt5663_private *ctx;
>  	struct snd_soc_acpi_mach *mach;
> -	int ret;
>  
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -1009,32 +1008,14 @@ static int kabylake_audio_probe(struct platform_device *pdev)
>  			&constraints_dmic_2ch : &constraints_dmic_channels;
>  
>  	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
> -	if (IS_ERR(ctx->mclk)) {
> -		ret = PTR_ERR(ctx->mclk);
> -		if (ret == -ENOENT) {
> -			dev_info(&pdev->dev,
> -				"Failed to get ssp1_sclk, defer probe\n");
> -			return -EPROBE_DEFER;
> -		}
> -
> -		dev_err(&pdev->dev, "Failed to get ssp1_mclk with err:%d\n",
> -								ret);
> -		return ret;
> -	}
> +	if (IS_ERR(ctx->mclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctx->mclk),
> +				     "Failed to get ssp1_mclk\n");
>  
>  	ctx->sclk = devm_clk_get(&pdev->dev, "ssp1_sclk");
> -	if (IS_ERR(ctx->sclk)) {
> -		ret = PTR_ERR(ctx->sclk);
> -		if (ret == -ENOENT) {
> -			dev_info(&pdev->dev,
> -				"Failed to get ssp1_sclk, defer probe\n");
> -			return -EPROBE_DEFER;
> -		}
> -
> -		dev_err(&pdev->dev, "Failed to get ssp1_sclk with err:%d\n",
> -								ret);
> -		return ret;
> -	}
> +	if (IS_ERR(ctx->sclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctx->sclk),
> +				     "Failed to get ssp1_sclk\n");
>  
>  	return devm_snd_soc_register_card(&pdev->dev, kabylake_audio_card);
>  }

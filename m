Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BD561BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiF3Nry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiF3Nrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:47:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4572A409
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656596858; x=1688132858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K6USsSMJ8UC9wOjFtx6U82V6WBAGj2etKO7gooeB8dw=;
  b=PtLUVumoLHtR+weM0Chw9BQYM3MlKI0eSaivfxUvvRbJMoiiLtb1NzW9
   gmOEStNkAPkzPywbZy+mvT5o6r2gWduE6r19nSmjHYLN14hHz9w8v+LNO
   o1wylTH4H+Q7S6F/WNIlve8QQVFOvHa/U46fkF1pHku3EhRTwSLwyHgWd
   D4V7kro3xyuaNEu9Kl41BnwI200EMU5gGxxCHyOvjFrjbg7QrsJs0chux
   Qc5ZUfjp4s+qUx05KcBgjho/f12tBOrGxYXiuvP3L8KxMHnXde6WT6At9
   xWj0ucVd7aoY7mvIeNghC51omSjAutQFs//kGrTfQO9OrqKW6PzgOGpAb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307859082"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="307859082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 06:47:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="617980754"
Received: from jhilliar-mobl.amr.corp.intel.com (HELO [10.212.10.157]) ([10.212.10.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 06:47:36 -0700
Message-ID: <aee14e9b-9d5f-f243-5834-88d18b4a65db@linux.intel.com>
Date:   Thu, 30 Jun 2022 08:09:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa881x: handle timeouts in resume path
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
References: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 08:00, Srinivas Kandagatla wrote:
> Currently we do not check if SoundWire slave initialization timeout
> expired before continuing to access its registers.
> 
> Its possible that the registers are not accessible if timeout is
> expired. Handle this by returning timeout in resume path.
> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Fixes: 8dd552458361 ("ASoC: codecs: wsa881x: add runtime pm support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

For the two patches

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/wsa881x.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index dc954b85a988..6c8b1db649b8 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -1173,11 +1173,17 @@ static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct regmap *regmap = dev_get_regmap(dev, NULL);
>  	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
> +	unsigned long time;
>  
>  	gpiod_direction_output(wsa881x->sd_n, 1);
>  
> -	wait_for_completion_timeout(&slave->initialization_complete,
> -				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
> +	time = wait_for_completion_timeout(&slave->initialization_complete,
> +					   msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
> +	if (!time) {
> +		dev_err(dev, "Initialization not complete, timed out\n");
> +		gpiod_direction_output(wsa881x->sd_n, 0);
> +		return -ETIMEDOUT;
> +	}
>  
>  	regcache_cache_only(regmap, false);
>  	regcache_sync(regmap);

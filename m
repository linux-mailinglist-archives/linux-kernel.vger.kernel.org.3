Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4B558FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiFXE1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXE1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268D6808C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 468A9620E3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC198C34114;
        Fri, 24 Jun 2022 04:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656044852;
        bh=V15RsvX1+kM5FL7HzYFUlsvJt53ggBmFiKd/GuXmjCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmvU82paGPiRMAiacFz4FNJVJxeI1JbNtw1jbHoW5e3CVlH8tpmUdd6lv5BSwcdM1
         v4uL9Z7gi4ooLx2Ipm3aBWYTsPLztS/myXB1ropefpunTGcqBnKgapgHR8Z7qNpNlm
         CtAWngEOk9V9dqcka22jrMTwBN35I0NbNLic/7xIH46rzszA/U65ddirNeJx92VHb4
         /F28tF9VLYMqgi/oZAwrTyK4Tk/CN5emI9bQkR3X7AoHtWD5GIAt7+F7/aE2Bxtxt0
         /wQ8RzJWkoUSdHAEjCp57j6a422udJVCSevxb2JaSHjkTYDn7TLqN9dkFAUjOM+gkV
         OxLqHRgK6hALw==
Date:   Fri, 24 Jun 2022 09:57:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Subject: Re: [PATCH v2 1/2] soundwire: Intel: add trigger callback
Message-ID: <YrU9MEAVQojxE5i4@matsya>
References: <20220616011758.21155-1-yung-chuan.liao@linux.intel.com>
 <20220616011758.21155-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616011758.21155-2-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-22, 09:17, Bard Liao wrote:
> When a pipeline is split into FE and BE parts, the BE pipeline may need to
> be triggered separately in the BE trigger op. So add the trigger callback
> in the link_res ops that will be invoked during BE DAI trigger.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  drivers/soundwire/intel.c           | 8 ++++++++
>  include/linux/soundwire/sdw_intel.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 505c5ef061e3..2e7c27d303b4 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1004,9 +1004,17 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
>  {
>  	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
> +	struct sdw_intel_link_res *res = sdw->link_res;
>  	struct sdw_cdns_dma_data *dma;
>  	int ret = 0;
>  
> +	/* The .trigger callback is used to send required IPC to audio
> +	 * firmware. The .free_stream callback will still be called
> +	 * by intel_free_stream() in the TRIGGER_SUSPEND case.
> +	 */

we dont use this style multi-line comment, pls fix it to:
        /*
         * The .trigger callback is used to send required IPC to ..
         * ...
         */

with that fixed:

Acked-By: Vinod Koul <vkoul@kernel.org>

> +	if (res->ops && res->ops->trigger)
> +		res->ops->trigger(dai, cmd, substream->stream);
> +
>  	dma = snd_soc_dai_get_dma_data(dai, substream);
>  	if (!dma) {
>  		dev_err(dai->dev, "failed to get dma data in %s\n",
> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
> index b5b489ea1aef..ec16ae49e6a4 100644
> --- a/include/linux/soundwire/sdw_intel.h
> +++ b/include/linux/soundwire/sdw_intel.h
> @@ -121,6 +121,7 @@ struct sdw_intel_ops {
>  			     struct sdw_intel_stream_params_data *params_data);
>  	int (*free_stream)(struct device *dev,
>  			   struct sdw_intel_stream_free_data *free_data);
> +	int (*trigger)(struct snd_soc_dai *dai, int cmd, int stream);
>  };
>  
>  /**
> -- 
> 2.17.1

-- 
~Vinod

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D7545BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbiFJF0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiFJF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5F354471
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5005361E49
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE92C34114;
        Fri, 10 Jun 2022 05:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654838768;
        bh=gwCK9uMfRUGm8E6XoELsFSqRflgNay8yFNDnSDJjIw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxdUSQ2YDkvS3Pl8dMqe65wnQRwTnSFBKsCTFUh8i9zW47JnZ11Tk/6J+WRSGBO38
         soK+Wv94GzKlQGFUh4wJITycUkm7Z3Y3+PIGLMf7CB6jNTWPZyoCLuUp6r1JCVNaKt
         X+drEUBA4JfjILQuvuKd7ictTayLxW0Qo5/IfZGE=
Date:   Fri, 10 Jun 2022 07:26:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 2/2] soundwire: Intel: add trigger callback
Message-ID: <YqLV7qexsdhCI7ZZ@kroah.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610023537.27223-3-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:35:37AM +0800, Bard Liao wrote:
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
> index 808e2f320052..3f3c2c99cb8e 100644
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
> +	if (res->ops && res->ops->trigger)
> +		res->ops->trigger(dai, cmd, substream->stream);
> +
>  	dma = snd_soc_dai_get_dma_data(dai, substream);
>  	if (!dma) {
>  		dev_err(dai->dev, "failed to get dma data in %s\n",
> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
> index 67e0d3e750b5..f638707fd712 100644
> --- a/include/linux/soundwire/sdw_intel.h
> +++ b/include/linux/soundwire/sdw_intel.h
> @@ -119,6 +119,7 @@ struct sdw_intel_ops {
>  			     struct sdw_intel_stream_params_data *params_data);
>  	int (*free_stream)(struct device *dev,
>  			   struct sdw_intel_stream_free_data *free_data);
> +	int (*trigger)(struct snd_soc_dai *dai, int cmd, int stream);
>  };
>  
>  /**
> -- 
> 2.17.1
> 

Where is the in-kernel user of this new callback?  Without that, there
is no need for this, NOR is there a way to properly review this commit.

sorry,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92954AA37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353567AbiFNHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353444AbiFNHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:12:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C05FE7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2184B81649
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9637C3411B;
        Tue, 14 Jun 2022 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655190749;
        bh=bTzyUDG/xn3eoLovQdEvpgAJqPPl044VpECLbq6qQGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xxx6ZhvMaC6FlWB038KmujLKhzXwKGKHraIaNbOkIvInGjh9Ae8qjPomYrw7wmXD2
         ywL5ALOR1jRvr+PFes7ixbz22d9zfUatGQ/lqOwqZg3Cum0SgM0SCyDnD5ks0+hrkt
         vKF3L07TmL8RhM6FOuNjjHAUIvPoS6G0dt9AFEw0=
Date:   Tue, 14 Jun 2022 09:12:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 2/2] ASoC: SOF: Intel: add trigger callback into
 sdw_callback
Message-ID: <Yqg01aSixhBq9d4+@kroah.com>
References: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
 <20220614070817.2508-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614070817.2508-3-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 03:08:17PM +0800, Bard Liao wrote:
> For IPC4, we need to set pipeline state in BE DAI trigger.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  sound/soc/sof/intel/hda-dai.c | 15 ++++++++++++---
>  sound/soc/sof/intel/hda.c     |  2 +-
>  sound/soc/sof/intel/hda.h     |  1 +
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
> index 228079a52c3d..6ed99fdc5793 100644
> --- a/sound/soc/sof/intel/hda-dai.c
> +++ b/sound/soc/sof/intel/hda-dai.c
> @@ -713,8 +713,7 @@ static const struct snd_soc_dai_ops ipc3_ssp_dai_ops = {
>  	.shutdown = ssp_dai_shutdown,
>  };
>  
> -static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
> -			       int cmd, struct snd_soc_dai *dai)
> +static int ipc4_be_dai_common_trigger(struct snd_soc_dai *dai, int cmd, int stream)
>  {
>  	struct snd_sof_widget *pipe_widget;
>  	struct sof_ipc4_pipeline *pipeline;
> @@ -723,7 +722,7 @@ static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
>  	struct snd_sof_dev *sdev;
>  	int ret;
>  
> -	w = snd_soc_dai_get_widget(dai, substream->stream);
> +	w = snd_soc_dai_get_widget(dai, stream);
>  	swidget = w->dobj.private;
>  	pipe_widget = swidget->pipe_widget;
>  	pipeline = pipe_widget->private;
> @@ -758,6 +757,12 @@ static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> +static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
> +			       int cmd, struct snd_soc_dai *dai)
> +{
> +	return ipc4_be_dai_common_trigger(dai, cmd, substream->stream);
> +}
> +
>  static const struct snd_soc_dai_ops ipc4_dmic_dai_ops = {
>  	.trigger = ipc4_be_dai_trigger,
>  };
> @@ -809,6 +814,10 @@ void hda_set_dai_drv_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *ops)
>  		if (!hda_use_tplg_nhlt)
>  			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);
>  
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
> +		sdw_callback.trigger = ipc4_be_dai_common_trigger;
> +#endif

#if should not be in .c files if at all possible.  Surely there's a
better way here...

thanks,

greg k-h

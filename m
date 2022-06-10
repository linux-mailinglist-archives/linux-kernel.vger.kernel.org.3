Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99101545BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiFJFZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiFJFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:25:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23A29DC07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F65B830F6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65137C34114;
        Fri, 10 Jun 2022 05:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654838724;
        bh=I4f5JhTN7o6cdBtdV7WpYHM1lwzF1iBma58To0zMnS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UkE3l5r3w+fPXvwvYCjmAlJQNoaa/1C+MQ4ByQB8xiqkwjaAmt5TLqaVRTjkd9gr
         AC8um02sbNnQHFAz22iFLaL3/+YZzAzAgftqvJubBr6iflbmjfzF1XNTOv8RWi53YY
         4PuvDEchYt73MBxiL9gMFGk2Y/uv5aZtmTfUG8to=
Date:   Fri, 10 Jun 2022 07:25:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: intel: uniquify debug message
Message-ID: <YqLVwqx9/Pos8T06@kroah.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:35:36AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The same debug message is replicated multiple time, add __func__ to
> figure out what link is ignored.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 505c5ef061e3..808e2f320052 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1328,8 +1328,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>  
>  	if (bus->prop.hw_disabled) {
>  		dev_info(dev,
> -			 "SoundWire master %d is disabled, ignoring\n",
> -			 sdw->instance);
> +			 "%s: SoundWire master %d is disabled, ignoring\n",
> +			 __func__, sdw->instance);

This is not a debug message, please make it such if you want to have
__func__  And even then, it's not needed as you can get that from the
kernel automatically.

>  		return 0;
>  	}
>  
> @@ -1489,8 +1489,8 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
>  	bus = &sdw->cdns.bus;
>  
>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> -			bus->link_id);
> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
> +			__func__, bus->link_id);
>  		return 0;
>  	}
>  
> @@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
>  	int ret;
>  
>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> -			bus->link_id);
> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
> +			__func__, bus->link_id);

Not needed, it is provided automatically if you ask the kernel for this.
Same for all other instances in this patch.

thanks,

greg k-h

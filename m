Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8B54B44C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbiFNPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiFNPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93585377DD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF5360EA0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14664C3411B;
        Tue, 14 Jun 2022 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655219679;
        bh=j9VGIf0zMXWC/ky8RMTbRLod5E9/MceYZUjWaMpKc+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/N/RtvJvBe9XPLoAXhbpTq5xuGqAr4XRugHJN/rEqlIPsmUzfDyl/2VvZ5fKbIse
         F8iyYx31VDnNSr/mobhTm1RlMJMxjYRv+XUk6BjF/TVopiWM/NOk5vpmsePyoy6Cyq
         hgs2TLQISsbgWrc8UCl3R3XRYXda+xV7HpcAmV2U=
Date:   Tue, 14 Jun 2022 17:14:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/2] ASoC: SOF: Intel: add trigger callback into
 sdw_callback
Message-ID: <Yqil3UDSmoXN3E9M@kroah.com>
References: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
 <20220614070817.2508-3-yung-chuan.liao@linux.intel.com>
 <Yqg01aSixhBq9d4+@kroah.com>
 <3fd14acb-1de9-3fd8-81ab-27fee4a42b84@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd14acb-1de9-3fd8-81ab-27fee4a42b84@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:55:41AM -0500, Pierre-Louis Bossart wrote:
> 
> >> @@ -809,6 +814,10 @@ void hda_set_dai_drv_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *ops)
> >>  		if (!hda_use_tplg_nhlt)
> >>  			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);
> >>  
> >> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
> >> +		sdw_callback.trigger = ipc4_be_dai_common_trigger;
> >> +#endif
> > 
> > #if should not be in .c files if at all possible.  Surely there's a
> > better way here...
> 
> we could use
> 
> if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))
>     sdw_callback.trigger = ipc4_be_dai_common_trigger;
> 
> would that work?

It's more readable, right?  Also easier to maintain over time.

> We try to keep this driver configurable, not all platforms require
> SoundWire or HDaudio, and that 'sdw_callback' ops structure is
> conditionally declared.

Perhaps don't conditionally declare that?  How much does it really save
to do that?

thanks,

greg k-h

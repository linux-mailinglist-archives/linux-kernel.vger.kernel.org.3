Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8999549D93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349251AbiFMTYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349397AbiFMTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091A5250D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1851060C16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D63C3411B;
        Mon, 13 Jun 2022 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655140885;
        bh=awvuHJ3WanfHU+vluSYhtwaUL0847oXiEl8aOFz++RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjq7hoiSQsNd3XQw+AacpDwmcusDCkcHUbdP/HtIvNo+T+pJBJ6bN41S5QZDq8Jq+
         Gi4o10dNT15pR3iMmYUJVaVwoync0UcWwJ8Uy6U+4h7JpawIsuS4Bz55uKY23nOQvX
         vmYBMZBQMY5r6XBabY/p+qybbgdH2g35q3bQLvJw=
Date:   Mon, 13 Jun 2022 19:21:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: intel: uniquify debug message
Message-ID: <YqdyErIYYk85NV41@kroah.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
 <YqLVwqx9/Pos8T06@kroah.com>
 <b86e6cbd-3488-a239-d765-cf01bf0d4f70@linux.intel.com>
 <YqRCKtLGYlRQQ+DU@kroah.com>
 <7328fbb2-06af-99c8-5e7f-9d22f8c4e4f6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7328fbb2-06af-99c8-5e7f-9d22f8c4e4f6@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:48:32AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> >>>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> >>>> index 505c5ef061e3..808e2f320052 100644
> >>>> --- a/drivers/soundwire/intel.c
> >>>> +++ b/drivers/soundwire/intel.c
> >>>> @@ -1328,8 +1328,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
> >>>>  
> >>>>  	if (bus->prop.hw_disabled) {
> >>>>  		dev_info(dev,
> >>>> -			 "SoundWire master %d is disabled, ignoring\n",
> >>>> -			 sdw->instance);
> >>>> +			 "%s: SoundWire master %d is disabled, ignoring\n",
> >>>> +			 __func__, sdw->instance);
> >>>
> >>> This is not a debug message, please make it such if you want to have
> >>> __func__  And even then, it's not needed as you can get that from the
> >>> kernel automatically.
> >>
> >> Sorry, I don't understand the feedback at all.
> > 
> > dev_info() is not a way to send debug messages.
> > 
> > If you want this to be only for debugging, use dev_dbg().  And when you
> > use that, you get the __func__ location for free in the output already
> > if you want that.
> > 
> >> This message was added precisely to figure out why the expected
> >> programming sequence was not followed, only to discover that we have
> >> devices with spurious PCI wakes handled below. Without this added
> >> difference with __func__, we wouldn't know if the issue happened during
> >> the expected/regular programming sequence or not.
> > 
> > Perhaps make the text unique then?  Why would an informational message
> > need a function name.  Drivers should be quiet when all is going well.
> > If something is not going well, dev_info() is not the kernel log level
> > to be sending something out at.
> 
> This is not a debug message - unlike all the others. The BIOS and/or the
> user may disable a specific link and it's useful to know.

Ok, but that's not what your subject and changelog said you were
modifying here.  Hence my confusion :)

> The intent of __func__ was precisely to make the text unique across all
> cases where we test for hw_disabled, but you have a point that this
> specific info message should be clearer. The text was actually already
> different from the 'disable or not-started' cases, I might have done one
> too many edits in this file. Will fix.
> 
> >>>>  		return 0;
> >>>>  	}
> >>>>  
> >>>> @@ -1489,8 +1489,8 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
> >>>>  	bus = &sdw->cdns.bus;
> >>>>  
> >>>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> >>>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> >>>> -			bus->link_id);
> >>>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
> >>>> +			__func__, bus->link_id);
> >>>>  		return 0;
> >>>>  	}
> >>>>  
> >>>> @@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
> >>>>  	int ret;
> >>>>  
> >>>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> >>>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> >>>> -			bus->link_id);
> >>>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
> >>>> +			__func__, bus->link_id);
> >>>
> >>> Not needed, it is provided automatically if you ask the kernel for this.
> >>> Same for all other instances in this patch.
> >>
> >> provided how? Your comment is a bit cryptic here.
> > 
> > the dynamic debug code in the kernel already adds the function name
> > where the message was sent from, if you want to know this in userspace.
> > Please read the documentation for details (I think the key is the 'f'
> > flag to be enabled in userspace).
> > 
> > So adding __func__ to dev_dbg() calls are redundant and never needed.
> 
> Oh wow, I had no idea - and I am not the only one :-)
> 
> Here's what I get with a grep on the kernel code
> 
> git grep __func__ | grep dev_dbg | wc -l
> 
> 3122
> 
> 
> Doing this for sound/ gives me 356, and that's for single-line logs only.
> 
> There's clearly something that was missed by tons of people.

Yes, it's not commonly known so cleanups are always welcome.  Perhaps
some of those usages predate the feature being added as well.

thanks,

greg k-h

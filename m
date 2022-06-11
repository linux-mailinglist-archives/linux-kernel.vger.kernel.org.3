Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796254729C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiFKHUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiFKHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2135FB9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D2C60D57
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 07:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03364C34116;
        Sat, 11 Jun 2022 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654932014;
        bh=9rveE22F5xtfV5P9xuvluHy5z6lSISxGcOGWCcJpfP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2BBEMwG/Slx/3Y+9f8CMaHHZtSJuQ11M0fR95GxEJWiqa5Lsgg5TMOmbjVu05cvq
         TomIVygHEXnLG/EDx67fsyhd6Q4EiGjKLzeXGX+pN2AWUiwxbxDjnL+DTJWOypAucA
         YouYMAOtiuJPuptWL4BZ2wPXvaY9eSg0amijwOMM=
Date:   Sat, 11 Jun 2022 09:20:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: intel: uniquify debug message
Message-ID: <YqRCKtLGYlRQQ+DU@kroah.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
 <YqLVwqx9/Pos8T06@kroah.com>
 <b86e6cbd-3488-a239-d765-cf01bf0d4f70@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b86e6cbd-3488-a239-d765-cf01bf0d4f70@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:06:58AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 6/10/22 00:25, Greg KH wrote:
> > On Fri, Jun 10, 2022 at 10:35:36AM +0800, Bard Liao wrote:
> >> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>
> >> The same debug message is replicated multiple time, add __func__ to
> >> figure out what link is ignored.
> >>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> >> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> >> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >> ---
> >>  drivers/soundwire/intel.c | 28 ++++++++++++++--------------
> >>  1 file changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> >> index 505c5ef061e3..808e2f320052 100644
> >> --- a/drivers/soundwire/intel.c
> >> +++ b/drivers/soundwire/intel.c
> >> @@ -1328,8 +1328,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
> >>  
> >>  	if (bus->prop.hw_disabled) {
> >>  		dev_info(dev,
> >> -			 "SoundWire master %d is disabled, ignoring\n",
> >> -			 sdw->instance);
> >> +			 "%s: SoundWire master %d is disabled, ignoring\n",
> >> +			 __func__, sdw->instance);
> > 
> > This is not a debug message, please make it such if you want to have
> > __func__  And even then, it's not needed as you can get that from the
> > kernel automatically.
> 
> Sorry, I don't understand the feedback at all.

dev_info() is not a way to send debug messages.

If you want this to be only for debugging, use dev_dbg().  And when you
use that, you get the __func__ location for free in the output already
if you want that.

> This message was added precisely to figure out why the expected
> programming sequence was not followed, only to discover that we have
> devices with spurious PCI wakes handled below. Without this added
> difference with __func__, we wouldn't know if the issue happened during
> the expected/regular programming sequence or not.

Perhaps make the text unique then?  Why would an informational message
need a function name.  Drivers should be quiet when all is going well.
If something is not going well, dev_info() is not the kernel log level
to be sending something out at.

> >>  		return 0;
> >>  	}
> >>  
> >> @@ -1489,8 +1489,8 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
> >>  	bus = &sdw->cdns.bus;
> >>  
> >>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> >> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> >> -			bus->link_id);
> >> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
> >> +			__func__, bus->link_id);
> >>  		return 0;
> >>  	}
> >>  
> >> @@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
> >>  	int ret;
> >>  
> >>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> >> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> >> -			bus->link_id);
> >> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
> >> +			__func__, bus->link_id);
> > 
> > Not needed, it is provided automatically if you ask the kernel for this.
> > Same for all other instances in this patch.
> 
> provided how? Your comment is a bit cryptic here.

the dynamic debug code in the kernel already adds the function name
where the message was sent from, if you want to know this in userspace.
Please read the documentation for details (I think the key is the 'f'
flag to be enabled in userspace).

So adding __func__ to dev_dbg() calls are redundant and never needed.

thanks,

greg k-h

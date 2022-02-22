Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58E84BFAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiBVOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiBVOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:18:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F910854B;
        Tue, 22 Feb 2022 06:18:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CA3EB81A2B;
        Tue, 22 Feb 2022 14:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84629C340E8;
        Tue, 22 Feb 2022 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645539486;
        bh=ArDLp9Yf09I1STzBMYLCq+XcO2PjHAI+AeehNM63oSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gh0M4Ghe7NMX+TLc/5+z8wVPV4e/YmRLZAyJL5X0FeeUhwnqZFSK2rOLXUJ43NucH
         IOgDygEyj0i2vLHbu2HIiPu3xJ2lpRihS7rF3zllgRbs1w2mkhSYysQLDxLdWTWM+w
         wIWVzgVuIE6IvqIyJn6RQZUEr+6iNXQZpFF9wBSg=
Date:   Tue, 22 Feb 2022 15:18:03 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Message-ID: <YhTwm9yDEhjEXt6H@kroah.com>
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
 <YhST32rsfl7MDv34@kroah.com>
 <90844cba1cb64571a8597a6e0afee01d@realtek.com>
 <YhSl4WuE2Dpil/Zj@kroah.com>
 <d28b6fb6649d472a809329876c3ac4bd@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28b6fb6649d472a809329876c3ac4bd@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:31:10PM +0000, Ricky WU wrote:
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Tuesday, February 22, 2022 4:59 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> > tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> > 
> > On Tue, Feb 22, 2022 at 08:48:30AM +0000, Ricky WU wrote:
> > > > -----Original Message-----
> > > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > > Sent: Tuesday, February 22, 2022 3:42 PM
> > > > To: Ricky WU <ricky_wu@realtek.com>
> > > > Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> > > > tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> > > >
> > > > On Tue, Feb 22, 2022 at 07:27:52AM +0000, Ricky WU wrote:
> > > > > After 1ms stabilizing the voltage time add "Host provides at least
> > > > > 74 Clocks before issuing first command" that is spec definition
> > > >
> > > > You do have 72 columns to use here, no need to wrap this so tightly.
> > > >
> > >
> > > Ok...
> > > so I need to have next patch to fix this format?
> > 
> > Please do, because:
> > 
> > >
> > > > >
> > > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > > ---
> > > > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > index 2a3f14afe9f8..e016d720e453 100644
> > > > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > @@ -940,10 +940,17 @@ static int sd_power_on(struct
> > > > > realtek_pci_sdmmc
> > > > *host)
> > > > >  	if (err < 0)
> > > > >  		return err;
> > > > >
> > > > > +	mdelay(1);
> > > >
> > > > What is this delay for?
> > > >
> > >
> > > Spec definition, need to wait 1ms for voltage stable and below
> > > mdelay(5) is our device send 74 Clocks time
> > 
> > Clock cycles and mdelay() are not going to always stay the same, right?
> > 
> > I really have no idea what "74 clocks time" means, is this some specific timing
> > value for this hardware?  What is the units?  This needs to be documented
> > better in both the changelog and in the code.
> > 
> > thanks,
> > 
> 
> Please ref: https://www.sdcard.org/downloads/pls/ Version8

I can not download those specifications according to the license that
they ask me to abide by.

> And see the 6.4.1.2 Power Up Time of Host Figure 6-5: Power Up Diagram of Host
> mdelay(1) corresponds to Stable supply voltage
> mdelay(5) corresponds to Host provides at least 74 Clocks before issuing first command
> our device need 5ms to issue 74 Clocks

What is a "clock"?  The kernel works with time units, how does "5" equal
to 74?

thanks,

greg k-h

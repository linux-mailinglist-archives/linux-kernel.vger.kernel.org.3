Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAFD4BF437
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiBVI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBVI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:59:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B813D57A;
        Tue, 22 Feb 2022 00:59:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52CE861474;
        Tue, 22 Feb 2022 08:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3950FC340E8;
        Tue, 22 Feb 2022 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645520355;
        bh=HsYmaqV+ybl69syx4u6F32xycoE4iZeyNOisNiEBlhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5E4C/48rB3z4K3QtxeyEJqsu3bELmkoHuD+6jW/N/fW2BOeaAjNjYumGVulW9+yP
         LkrUmXnyxOHKl1LtjcOSNXApfyjL0ta/ObOa0BhMLtv8jhiyQRPw8AM7OEzwxfYcvF
         IApf7c/D8kpdav0NtibtXPrKF28o7YgT2NVHkw8k=
Date:   Tue, 22 Feb 2022 09:59:13 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Message-ID: <YhSl4WuE2Dpil/Zj@kroah.com>
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
 <YhST32rsfl7MDv34@kroah.com>
 <90844cba1cb64571a8597a6e0afee01d@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90844cba1cb64571a8597a6e0afee01d@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:48:30AM +0000, Ricky WU wrote:
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Tuesday, February 22, 2022 3:42 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> > tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> > 
> > On Tue, Feb 22, 2022 at 07:27:52AM +0000, Ricky WU wrote:
> > > After 1ms stabilizing the voltage time add "Host provides at least 74
> > > Clocks before issuing first command" that is spec definition
> > 
> > You do have 72 columns to use here, no need to wrap this so tightly.
> >
> 
> Ok...
> so I need to have next patch to fix this format?

Please do, because:

> 
> > >
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > ---
> > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > index 2a3f14afe9f8..e016d720e453 100644
> > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > @@ -940,10 +940,17 @@ static int sd_power_on(struct realtek_pci_sdmmc
> > *host)
> > >  	if (err < 0)
> > >  		return err;
> > >
> > > +	mdelay(1);
> > 
> > What is this delay for?
> >
> 
> Spec definition, need to wait 1ms for voltage stable
> and below mdelay(5) is our device send 74 Clocks time

Clock cycles and mdelay() are not going to always stay the same, right?

I really have no idea what "74 clocks time" means, is this some specific
timing value for this hardware?  What is the units?  This needs to be
documented better in both the changelog and in the code.

thanks,

greg k-h

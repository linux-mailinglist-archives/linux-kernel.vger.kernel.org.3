Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B546920C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbhLFJOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbhLFJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:14:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740AAC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:10:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1muA19-00028q-Uz; Mon, 06 Dec 2021 10:10:40 +0100
Message-ID: <575d2441945ef322f52068b9d8530fe16dd7f07d.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpcv2: Enable vpumix/dispmix to wait for
 handshake
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        aford@beaconembedded.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Dec 2021 10:10:36 +0100
In-Reply-To: <20211206004549.GG4216@dragon>
References: <20211120194900.1309914-1-aford173@gmail.com>
         <20211206004549.GG4216@dragon>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Am Montag, dem 06.12.2021 um 08:45 +0800 schrieb Shawn Guo:
> Hi Lucas,
> 
> What's your take on this one?
> 
Thanks for asking. This patch is incorrect. The handshake will only be
completed once all the clocks for the ADB are enabled, which is done in
the blk-ctrl driver. The blk-ctrl driver however can only do so _after_
the power-up sequence of the GPC domain is completed, so waiting for
the handshake in the middle of the power-up sequence is not going to
work for most of the GPC domains. Please drop this patch.

Regards,
Lucas

> Shawn
> 
> On Sat, Nov 20, 2021 at 01:49:00PM -0600, Adam Ford wrote:
> > There is a comment in the code that states the driver needs to
> > wait for the handshake, but it's only available when the bus
> > has been enabled from the blk-ctrl.  Since both the
> > vpumix and dispmix are called from the blk-ctl, it seems
> > reasonable to assume the bus is enabled. Add a bool to determine
> > which power-domains are able to properly wait for this
> > handshake and set the corresping boolean for the two domains
> > activated by the blk-ctrl.
> > 
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > 
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index 7b6dfa33dcb9..a957f7fff968 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -204,6 +204,7 @@ struct imx_pgc_domain {
> >  	const int voltage;
> >  	const bool keep_clocks;
> >  	struct device *dev;
> > +	bool blkctrl_bus_enabled;
> >  };
> >  
> >  struct imx_pgc_domain_data {
> > @@ -282,17 +283,14 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
> >  				   domain->bits.hskreq, domain->bits.hskreq);
> >  
> >  		/*
> > -		 * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
> > -		 *				  (reg_val & domain->bits.hskack), 0,
> > -		 *				  USEC_PER_MSEC);
> > -		 * Technically we need the commented code to wait handshake. But that needs
> > -		 * the BLK-CTL module BUS clk-en bit being set.
> > -		 *
> > -		 * There is a separate BLK-CTL module and we will have such a driver for it,
> > -		 * that driver will set the BUS clk-en bit and handshake will be triggered
> > -		 * automatically there. Just add a delay and suppose the handshake finish
> > -		 * after that.
> > +		 * blkctrl_bus_enabled implies that the GPC is being invoked from a blk-ctrl
> > +		 * and not from a peripheral or other GPC power domain.  The blk-ctrl is required
> > +		 * to support the handshake.
> >  		 */
> > +		if (domain->blkctrl_bus_enabled)
> > +			ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
> > +							(reg_val & domain->bits.hskack), 0,
> > +							USEC_PER_MSEC);
> >  	}
> >  
> >  	/* Disable reset clocks for all devices in the domain */
> > @@ -701,6 +699,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> >  		},
> >  		.pgc   = BIT(IMX8MM_PGC_VPUMIX),
> >  		.keep_clocks = true,
> > +		.blkctrl_bus_enabled = true,
> >  	},
> >  
> >  	[IMX8MM_POWER_DOMAIN_VPUG1] = {
> > @@ -749,6 +748,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> >  		},
> >  		.pgc   = BIT(IMX8MM_PGC_DISPMIX),
> >  		.keep_clocks = true,
> > +		.blkctrl_bus_enabled = true,
> >  	},
> >  
> >  	[IMX8MM_POWER_DOMAIN_MIPI] = {
> > -- 
> > 2.32.0
> > 



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE4468E65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhLFBHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:07:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43038 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbhLFAtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:49:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8557260F50
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 00:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F0C00446;
        Mon,  6 Dec 2021 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638751556;
        bh=YmGO1aNhRlDR39YvwV2W3rujFydLuNOJITmdzxHkPFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGhjfY9blXOeNvTdU7OLyNVz1sHT3I8kuy/+d64JwGivAkRT1Ok9eNjACAz8kgBvg
         76An7U40y2WcBrEiEtVylx3C0rPACnziZWYB+oYd+dmPFw1cGfG42INEtKTXxNt9gZ
         /iDyg2XXHOhHWAMOJAxKlPSJk23yi3v8+TyRJXHw/4GIbXUsp54uEK4qxhLWm7QUjg
         Ggk69C1KB56l79+3t9hDpPwrcmRi8o9f4Fb481PSk4zYleAIQFq6PpLeFjH8iU28EB
         r+J8pCNEuXeLgmGvAhk7ud5KurtSdlQh9O2ptA1xCtMc0AOWutRlEemvJSYXMKKAU6
         FYEhDssHWLe3g==
Date:   Mon, 6 Dec 2021 08:45:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        aford@beaconembedded.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: gpcv2: Enable vpumix/dispmix to wait for
 handshake
Message-ID: <20211206004549.GG4216@dragon>
References: <20211120194900.1309914-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120194900.1309914-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

What's your take on this one?

Shawn

On Sat, Nov 20, 2021 at 01:49:00PM -0600, Adam Ford wrote:
> There is a comment in the code that states the driver needs to
> wait for the handshake, but it's only available when the bus
> has been enabled from the blk-ctrl.  Since both the
> vpumix and dispmix are called from the blk-ctl, it seems
> reasonable to assume the bus is enabled. Add a bool to determine
> which power-domains are able to properly wait for this
> handshake and set the corresping boolean for the two domains
> activated by the blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 7b6dfa33dcb9..a957f7fff968 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -204,6 +204,7 @@ struct imx_pgc_domain {
>  	const int voltage;
>  	const bool keep_clocks;
>  	struct device *dev;
> +	bool blkctrl_bus_enabled;
>  };
>  
>  struct imx_pgc_domain_data {
> @@ -282,17 +283,14 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  				   domain->bits.hskreq, domain->bits.hskreq);
>  
>  		/*
> -		 * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
> -		 *				  (reg_val & domain->bits.hskack), 0,
> -		 *				  USEC_PER_MSEC);
> -		 * Technically we need the commented code to wait handshake. But that needs
> -		 * the BLK-CTL module BUS clk-en bit being set.
> -		 *
> -		 * There is a separate BLK-CTL module and we will have such a driver for it,
> -		 * that driver will set the BUS clk-en bit and handshake will be triggered
> -		 * automatically there. Just add a delay and suppose the handshake finish
> -		 * after that.
> +		 * blkctrl_bus_enabled implies that the GPC is being invoked from a blk-ctrl
> +		 * and not from a peripheral or other GPC power domain.  The blk-ctrl is required
> +		 * to support the handshake.
>  		 */
> +		if (domain->blkctrl_bus_enabled)
> +			ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
> +							(reg_val & domain->bits.hskack), 0,
> +							USEC_PER_MSEC);
>  	}
>  
>  	/* Disable reset clocks for all devices in the domain */
> @@ -701,6 +699,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
>  		},
>  		.pgc   = BIT(IMX8MM_PGC_VPUMIX),
>  		.keep_clocks = true,
> +		.blkctrl_bus_enabled = true,
>  	},
>  
>  	[IMX8MM_POWER_DOMAIN_VPUG1] = {
> @@ -749,6 +748,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
>  		},
>  		.pgc   = BIT(IMX8MM_PGC_DISPMIX),
>  		.keep_clocks = true,
> +		.blkctrl_bus_enabled = true,
>  	},
>  
>  	[IMX8MM_POWER_DOMAIN_MIPI] = {
> -- 
> 2.32.0
> 

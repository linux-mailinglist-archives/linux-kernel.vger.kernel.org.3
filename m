Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C01473ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhLNIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhLNIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:54:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:54:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx3Ze-0004AN-29; Tue, 14 Dec 2021 09:54:14 +0100
Message-ID: <3c2441ab654aae70b2d84514f98ebbcdec13fd5e.camel@pengutronix.de>
Subject: Re: [PATCH V4 2/9] soc: imx: gpcv2: Add dispmix and mipi domains to
 imx8mn
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Dec 2021 09:54:12 +0100
In-Reply-To: <20211128131853.15125-3-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-3-aford173@gmail.com>
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

Am Sonntag, dem 28.11.2021 um 07:18 -0600 schrieb Adam Ford:
> The dispmix will be needed for the blkctl driver, so add it
> to the gpcv2.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/gpcv2.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index a0eab9f41a71..3e59d479d001 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -843,6 +843,31 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
>  		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
>  		.keep_clocks = true,
>  	},
> +
> +	[IMX8MN_POWER_DOMAIN_DISPMIX] = {
> +		.genpd = {
> +			.name = "dispmix",
> +		},
> +			.bits  = {
> +			.pxx = IMX8MN_DISPMIX_SW_Pxx_REQ,
> +			.map = IMX8MN_DISPMIX_A53_DOMAIN,
> +			.hskreq = IMX8MN_DISPMIX_HSK_PWRDNREQN,
> +			.hskack = IMX8MN_DISPMIX_HSK_PWRDNACKN,
> +		},
> +		.pgc   = BIT(IMX8MN_PGC_DISPMIX),
> +		.keep_clocks = true,
> +	},
> +
> +	[IMX8MN_POWER_DOMAIN_MIPI] = {
> +		.genpd = {
> +			.name = "mipi",
> +		},
> +			.bits  = {
> +			.pxx = IMX8MN_MIPI_SW_Pxx_REQ,
> +			.map = IMX8MN_MIPI_A53_DOMAIN,
> +		},
> +		.pgc   = BIT(IMX8MN_PGC_MIPI),
> +	},
>  };
> 
>  static const struct regmap_range imx8mn_yes_ranges[] = {
> --
> 2.32.0
> 



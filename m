Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971DF4C0E09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiBWIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiBWIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:09:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC65A6D961
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:09:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nMmho-0000Jh-01; Wed, 23 Feb 2022 09:09:00 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nMmhm-0003eW-SF; Wed, 23 Feb 2022 09:08:58 +0100
Date:   Wed, 23 Feb 2022 09:08:58 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: domains: use dev_err_probe() to simplify error
 handling
Message-ID: <20220223080858.GJ9136@pengutronix.de>
References: <20220223080323.3717853-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223080323.3717853-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:07:26 up 74 days, 16:53, 83 users,  load average: 0.19, 0.27,
 0.22
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:03:23AM +0100, Sascha Hauer wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> dev_err_probe() can reduce code size, makes the code easier to read
> and has the added benefit of recording the defer reason for later
> read out. Use it where appropriate.
> 
> This also fixes an issue, where an error message in __genpd_dev_pm_attach
> was not terminated by a line break.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/base/power/domain.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

And of course:

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5db704f02e712..29428ae91349d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2248,12 +2248,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
>  	/* Parse genpd OPP table */
>  	if (genpd->set_performance_state) {
>  		ret = dev_pm_opp_of_add_table(&genpd->dev);
> -		if (ret) {
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
> -					ret);
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
>  
>  		/*
>  		 * Save table for faster processing while setting performance
> @@ -2312,9 +2308,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>  		if (genpd->set_performance_state) {
>  			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
>  			if (ret) {
> -				if (ret != -EPROBE_DEFER)
> -					dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
> -						i, ret);
> +				dev_err_probe(&genpd->dev, ret,
> +					      "Failed to add OPP table for index %d\n", i);
>  				goto error;
>  			}
>  
> @@ -2672,12 +2667,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  	ret = genpd_add_device(pd, dev, base_dev);
>  	mutex_unlock(&gpd_list_lock);
>  
> -	if (ret < 0) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to add to PM domain %s: %d",
> -				pd->name, ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add to PM domain %s\n", pd->name);
>  
>  	dev->pm_domain->detach = genpd_dev_pm_detach;
>  	dev->pm_domain->sync = genpd_dev_pm_sync;
> -- 
> 2.30.2
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

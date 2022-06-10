Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE7546542
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347587AbiFJLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiFJLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:13:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848613DC7;
        Fri, 10 Jun 2022 04:13:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276375395"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="276375395"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:13:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="671801598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:13:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nzcaN-000Yi5-Ix;
        Fri, 10 Jun 2022 14:13:51 +0300
Date:   Fri, 10 Jun 2022 14:13:51 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: dwapb: Don't print error on -EPROBE_DEFER
Message-ID: <YqMnb9FjSuU6xd+n@smile.fi.intel.com>
References: <20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru>
 <20220610104500.28774-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610104500.28774-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:45:00PM +0300, Serge Semin wrote:
> Currently if the APB or Debounce clocks aren't yet ready to be requested
> the DW GPIO driver will correctly handle that by deferring the probe
> procedure, but the error is still printed to the system log. It needlessly
> pollutes the log since there was no real error but a request to postpone
> the clock request procedure since the clocks subsystem hasn't been fully
> initialized yet. Let's fix that by using the dev_err_probe method to print
> the APB/clock request error status. It will correctly handle the deferred
> probe situation and print the error if it actually happens.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

With or without below nit-pick
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
> 
> Link: https://lore.kernel.org/linux-gpio/20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Use the dev_err_probe() return value as the return status of the
>   corresponding method. (@Philipp Zabel)
> ---
>  drivers/gpio/gpio-dwapb.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index b0f3aca61974..9467d695a33e 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -652,10 +652,9 @@ static int dwapb_get_clks(struct dwapb_gpio *gpio)
>  	gpio->clks[1].id = "db";
>  	err = devm_clk_bulk_get_optional(gpio->dev, DWAPB_NR_CLOCKS,
>  					 gpio->clks);
> -	if (err) {
> -		dev_err(gpio->dev, "Cannot get APB/Debounce clocks\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(gpio->dev, err,
> +				     "Cannot get APB/Debounce clocks\n");

I would leave it on one line, checkpatch wouldn't complain even before 100
characters era.

>  
>  	err = clk_bulk_prepare_enable(DWAPB_NR_CLOCKS, gpio->clks);
>  	if (err) {
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko



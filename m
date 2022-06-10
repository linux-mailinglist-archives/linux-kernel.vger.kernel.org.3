Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D925546EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiFJUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbiFJUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:55:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82EA4664F;
        Fri, 10 Jun 2022 13:55:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s10so339610ljh.12;
        Fri, 10 Jun 2022 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hBhPZds+0rUJB+X5O1GpYzR6ZMeTDXCoajHfp8NRBFU=;
        b=WEkjyFfBv+aVLMIB2AQPpNooXVJ4TqqATi7Mr5D8A23RV+9XzVC5cCXRl+GXa0ztof
         0VL67bNgDbU0YPMH0BqH+yGZ0GJFiIltLtcl6VXniXmCGaFQ3FzgZsmhP3v+iwGrgygJ
         +SfpzehiPkX9ad+UbVYxsGTLM/+A9vv72Bswu15Bp+QQ6q7VjPKpw75sPPw4XdxlM6+i
         yuRrfdY/0UeHoRAgWYo2sTQE3i+Rhen+jZoFSwiqZ4qkXhz0BqsII8d+Chg2mmSOxwWj
         f6k+hc9RODPiK5nZN3pR0ewB3t0+KlzZ1kEgo94Phv+cxXHCCUJqltuZRQpih1wn88cK
         vRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBhPZds+0rUJB+X5O1GpYzR6ZMeTDXCoajHfp8NRBFU=;
        b=LHmyaDRfxDaqJsCCNmL3I0N3nnIouq4GTavVGfgm+7eIlKPRJlRye2sBTZzAMk7KZ9
         CoXaM9YUURWcV7AM6r+yEmMKdVzIEuL1Sb2KRMMle5ZQdI0d4yo19cYhGkmmBYSP+sUe
         JSOiJCa54F9+/oeCWmUmwyZ5ppMd9rzgPYhdg6CDaByu0eeAA64rxvYgM7/ndTgnX0Ei
         qM3Vnl2GbXU0jaTcl0zywfH8AjLGCeJx+mfgf/C9sRnivRnn8rT9yaD/zPhmiVzzgEgP
         RZo4p24BA9zvJn0URgNpo6tlPvwkQH/QqAwqbEEaNDlSczrpr6XU01mBwbzTb4nj/yMV
         HNXA==
X-Gm-Message-State: AOAM530B9EvcnSLdMg3Arra/UNv4zvRq68p7ToOpOq7e6J/yjII1ni/W
        svG4oPbhmQl/ylXdUK2dqjw=
X-Google-Smtp-Source: ABdhPJyUIxjuOZaWxf7xrze+CMEdiPMWU6uWIMYEps47w6pOrUe7u2CO+t70doSlfTV6eJxlUqLO+Q==
X-Received: by 2002:a2e:9c43:0:b0:250:a467:400 with SMTP id t3-20020a2e9c43000000b00250a4670400mr62486754ljj.348.1654894501887;
        Fri, 10 Jun 2022 13:55:01 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id q4-20020a056512210400b0047dab95a0d5sm604672lfr.109.2022.06.10.13.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:55:01 -0700 (PDT)
Date:   Fri, 10 Jun 2022 23:54:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: dwapb: Don't print error on -EPROBE_DEFER
Message-ID: <20220610205459.ptgpuvtekwinujp2@mobilestation>
References: <20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru>
 <20220610104500.28774-1-Sergey.Semin@baikalelectronics.ru>
 <YqMnb9FjSuU6xd+n@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqMnb9FjSuU6xd+n@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:13:51PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 01:45:00PM +0300, Serge Semin wrote:
> > Currently if the APB or Debounce clocks aren't yet ready to be requested
> > the DW GPIO driver will correctly handle that by deferring the probe
> > procedure, but the error is still printed to the system log. It needlessly
> > pollutes the log since there was no real error but a request to postpone
> > the clock request procedure since the clocks subsystem hasn't been fully
> > initialized yet. Let's fix that by using the dev_err_probe method to print
> > the APB/clock request error status. It will correctly handle the deferred
> > probe situation and print the error if it actually happens.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 

> With or without below nit-pick
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks.

> 
> > ---
> > 
> > Link: https://lore.kernel.org/linux-gpio/20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Use the dev_err_probe() return value as the return status of the
> >   corresponding method. (@Philipp Zabel)
> > ---
> >  drivers/gpio/gpio-dwapb.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> > index b0f3aca61974..9467d695a33e 100644
> > --- a/drivers/gpio/gpio-dwapb.c
> > +++ b/drivers/gpio/gpio-dwapb.c
> > @@ -652,10 +652,9 @@ static int dwapb_get_clks(struct dwapb_gpio *gpio)
> >  	gpio->clks[1].id = "db";
> >  	err = devm_clk_bulk_get_optional(gpio->dev, DWAPB_NR_CLOCKS,
> >  					 gpio->clks);
> > -	if (err) {
> > -		dev_err(gpio->dev, "Cannot get APB/Debounce clocks\n");
> > -		return err;
> > -	}
> > +	if (err)
> > +		return dev_err_probe(gpio->dev, err,
> > +				     "Cannot get APB/Debounce clocks\n");
>
 
> I would leave it on one line, checkpatch wouldn't complain even before 100
> characters era.

You are right, checkpatch won't complain but the 80-chars limit is
still preferred. In this case we can fulfill that requirement without
harm to the code readability.

-Sergey

> 
> >  
> >  	err = clk_bulk_prepare_enable(DWAPB_NR_CLOCKS, gpio->clks);
> >  	if (err) {
> > -- 
> > 2.35.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2409B54669D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiFJM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiFJM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:27:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C6420BB2D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:27:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h23so42116737ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aru8d9opYdqmVU7zQRIwciw2rKwv+H6TohRF9x2A7Ww=;
        b=bP+L/F9vpe6SrwpYqU2bPZIg64aQeFcuARRZQXdjsQO3LDSbAXkmnQw3f09WYEUL1v
         2eCTbDzVARwxEWMkjUn2i2F5yESMTj0/GC+5KLf5MNKHKPAC11hHWxH3WPkLSJAGzhW6
         B72J/9rj7IMSnvbxmddXcbcLW/eNaP4VA3lw+lmJoa3meD+oU+6QkRemknztYCOHgI3g
         0Eb2eL8dmdwknYS33FNu4Miw+2TWQaarPmEdunJ5Ilg/en02e95Y817XCgRoK/y5NPvN
         OmdyOm4YjzK4j1xHN078P4C5PF0p6KqZwACfUYyAgZqLY54RgbTI5zFWL1SzXmlty7h0
         dLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aru8d9opYdqmVU7zQRIwciw2rKwv+H6TohRF9x2A7Ww=;
        b=uqbrwu+2o6pARm+A2++2P6kE4o6m1PvQ8heI6LoO6J3mMwuU/rhQmhe/nfLA8W7tPO
         yhBd+5qmjvRLJcMmFvO6pAdIzOqKXhjXSrwKUTVGlzyAP30/bpiOPt/fA5VUBnbynwxC
         YuxNdMxsmf/WHlkGwj8IBwMmdhzzrq+Awp8jKAwblQ95FSetsnxAqciY0FtFRcdWvGdm
         AVvho77Uk96HU70W5AqInm2P7jhSuSnVSuubYHGrgRJ4YoUcVTeifjwIZ55rqygxF6uR
         L9vL/f4eqYNu+vS7oMDDLtDoy4js2VFZRfnp6MH/LQYz3OtyRT/723zgLJSnPHIAyes4
         hNJg==
X-Gm-Message-State: AOAM531c2XfovPiIqJ57WspslxnCoEHo/m3X2cD7ucC+Q8cZHhnGChCA
        Hi/KycYpDI108rMLzT8u5fIA1MzfA8Y5QD3oo2zeZA==
X-Google-Smtp-Source: ABdhPJzlOAUF7lf77UWUH6vF/DqJlWlqZoKgWH5EhJRsseBG/FKbYMCUuKJPy7ZH6W8ggwSTCxrJqWKXIhgAr/4wIlM=
X-Received: by 2002:a17:907:90c8:b0:711:c8e1:7109 with SMTP id
 gk8-20020a17090790c800b00711c8e17109mr25478777ejb.492.1654864021559; Fri, 10
 Jun 2022 05:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru> <20220610104500.28774-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610104500.28774-1-Sergey.Semin@baikalelectronics.ru>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jun 2022 14:26:51 +0200
Message-ID: <CAMRc=Mc=WYNS3uhDmWGwVsQd5q9i+qYvXuJ_Ks5MwU4Rjdh4Zw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: dwapb: Don't print error on -EPROBE_DEFER
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:45 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
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
>
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
>         gpio->clks[1].id = "db";
>         err = devm_clk_bulk_get_optional(gpio->dev, DWAPB_NR_CLOCKS,
>                                          gpio->clks);
> -       if (err) {
> -               dev_err(gpio->dev, "Cannot get APB/Debounce clocks\n");
> -               return err;
> -       }
> +       if (err)
> +               return dev_err_probe(gpio->dev, err,
> +                                    "Cannot get APB/Debounce clocks\n");
>
>         err = clk_bulk_prepare_enable(DWAPB_NR_CLOCKS, gpio->clks);
>         if (err) {
> --
> 2.35.1
>

Applied, thanks!

Bart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD359CAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiHVVj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiHVVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:39:24 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F85140C;
        Mon, 22 Aug 2022 14:39:23 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cb8so9045126qtb.0;
        Mon, 22 Aug 2022 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sxi9ytifq3/mVWcX0hMlbgf9nV334o7a7Q5oIkk527I=;
        b=GKo2haEYD7YEnDqw24uLXOendXqM/c8mpfO1Vgt04VLwRGGpsP4jH7PsI4kawVDTCU
         3vtY7byYY9/39rk/ISdKeK/2i+Y9ZVoY9gWJFfwkFL/qhhzCj7EUZI7La6EUp4Mhwb4T
         gYR3sLoxAMpttUjtod9GP2znRxOw9iw5yqSG0gLpftBd7a0EeiwfktqaeEwJWePPuAvj
         BjovEFRmHnEDQP5W6KekQDuPKL3OE54+hpt2ZkDQvC6+3IYmqHpHOPQrR6kNLg1HwV/A
         w8x+/npsuSO4ZK4IGztR6eMaPhTjKRmrH/TwF/Lw7gEGNILYuPJM/geNj5k72hgQtfvq
         uMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sxi9ytifq3/mVWcX0hMlbgf9nV334o7a7Q5oIkk527I=;
        b=kjCK4MGJmr3J+EiVRe0G4VUB9tnBfiA9ZAezWPIm65slSBZS93oKQlLjkmockLRDaf
         /i9GpnZFK7PwuNLe86b8k7lfhngRmA6V7OGG3Tko+iqG34Drq7POtg3eXg7VA+YF6Xow
         mXhjjus/Xe6xfPnVRM0EAn2mjbWw1wiBBLyphTkZ20ciffDBDcarPObMKutJmhMVlvnV
         q7hDBFps8mtPgREMkvLEDX7+ocIHaVPwyqXoPyoKb+38SbBnSI7GeuHjS/ppdBwKoRMN
         U6H8ttT3zWuqU143RRcyFFpf4uHlY295LmkeZhLaxRcEIrrWv7E63n9SOlswc0ByiWYk
         llIQ==
X-Gm-Message-State: ACgBeo1Sh51YRn3xw3mgLLWOWmzxzv1d3N9wWDH501TVuCeWx6yqnLcI
        oDNAt1fWe+kqcDluBhuxcKrrvAqm/0aPTpRP7Tk=
X-Google-Smtp-Source: AA6agR4bklJsYdlNPi5QudeYa9AdfLgdLrsTb0MEyzz9ExYee2xFE2eQBEYo8lA82AcI5RJJOYT0PyTptF2zyrN98vE=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr16913009qta.429.1661204362041; Mon, 22
 Aug 2022 14:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Aug 2022 00:38:45 +0300
Message-ID: <CAHp75VefTEy7jFAFnZe5A+d+2+984RMRDqxtPDJnd+E+dbZw=w@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: Add deferred controller registration support
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 9:19 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> It's pretty possible to have the spi_register_controller() method
> returning -EPROBE_DEFER status in case, for instance, if the GPIOs used
> for the CS implementation aren't ready to be requested due to the
> corresponding platform devices still pending to be probed. Let's make sure
> the DW SSI driver won't print error message in that case by calling the
> dev_err_probe() function if the SPI-registration procedure exited with
> a non-zero status.

Shouldn't there be a Fixes tag?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/spi/spi-dw-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index f87d97ccd2d6..99edddf9958b 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -955,7 +955,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>
>         ret = spi_register_controller(master);
>         if (ret) {
> -               dev_err(&master->dev, "problem registering spi master\n");
> +               dev_err_probe(dev, ret, "problem registering spi master\n");
>                 goto err_dma_exit;
>         }
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko

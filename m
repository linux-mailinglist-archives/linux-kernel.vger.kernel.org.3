Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129094D9FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbiCOQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiCOQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:17:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2949C82
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:16:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 12so21292440oix.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qT7w6DZ83KU6YwYPnhOuT3Gs+pTXd3H6Bxc+p+SKrEI=;
        b=CH2NN6HNHNdsPmg5ik3sPucShRErDhzbb9qtWA1DWMrkLiLTWPAVvzYJMc7ooSkgNb
         kcjT2Vr5iX38ycOEpLNZnbRTU/JZAoCP2duH/1LrNVTlnH3oNsUJDkdue0ypWHfnNS60
         QBgmgSMX8Eqzi0N/s9LpyEmg/zuyyjICPwqQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qT7w6DZ83KU6YwYPnhOuT3Gs+pTXd3H6Bxc+p+SKrEI=;
        b=PG9MxK5zZxVhbhjOljvwzhJ1+RsGmqjPo/4bhuKf0fXmcbCcX1s87kTZLhKrpqS24s
         ZJV1Ykd9lAL2zlRLTcSsuSftBcohWQceWIvuhkIn4TlfvrJ2hTPEvFwCOp5CII2hlzGa
         JH+oOIFWjaWyPnKjkV4KSWgJy4ZePQMLR6MhRVFuh4YYa8+y3N3KdvjaerlD4wpYYAlc
         fxTVD5TNKh8jFjRlCxIehArayqFMzfcdWkPUaPYdlX+/aNsPwUJE7MxXIOhGRaygtvPQ
         /AcDMES1szOAmUYIyHoAnzmUwbguDOdrx2SJlCTTU94GIZP1pNv8z1hispu+TMcYLny7
         D5wA==
X-Gm-Message-State: AOAM532ig3M1zWPf+1eWa1M89S3Cn2STArjl+wpQkHxpQxmvYlWVDbgk
        pRiqE2pjt/f1zKqg31/nComt6qr1WskyZpHfauKd0A==
X-Google-Smtp-Source: ABdhPJzA1g5Zm0aW/GmGGh+CKJOasisnjS1FasntITBrNSi4UWGlNlbgVJ/Yo8qt5MeRWGIFeJz+AiJgwteli8iAyXg=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr2114839oif.63.1647360973681; Tue, 15
 Mar 2022 09:16:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Mar 2022 11:16:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAHNYxRxcXF2hkgkyxsU0Fv-bo3qv8i6uSZ8n_X9dOR0atsjSHQ@mail.gmail.com>
References: <20220314232214.4183078-1-swboyd@chromium.org> <20220314232214.4183078-3-swboyd@chromium.org>
 <CAHNYxRxcXF2hkgkyxsU0Fv-bo3qv8i6uSZ8n_X9dOR0atsjSHQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Mar 2022 11:16:13 -0500
Message-ID: <CAE-0n50P9_2abYSYCH8FLBF-mEFfQ7WbBneHJAsfggBANiCXeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_spi: Boot fingerprint
 processor during probe
To:     Alexandru M Stan <amstan@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru M Stan (2022-03-14 17:36:47)
> On Mon, Mar 14, 2022 at 4:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Add gpio control to this driver so that the fingerprint device can be
> > booted if the BIOS isn't doing it already. This eases bringup of new
> > hardware as we don't have to wait for the BIOS to be ready, supports
> > kexec where the GPIOs may not be configured by the previous boot stage,
> > and is all around good hygiene because we control GPIOs for this device
> > from the device driver.
> >
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Craig Hesling <hesling@chromium.org>
> > Cc: Tom Hughes <tomhughes@chromium.org>
> > Cc: Alexandru M Stan <amstan@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_spi.c | 38 ++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > index 14c4046fa04d..77577650afce 100644
> > --- a/drivers/platform/chrome/cros_ec_spi.c
> > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > @@ -4,6 +4,7 @@
> >  // Copyright (C) 2012 Google, Inc
> >
> >  #include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -77,6 +78,8 @@ struct cros_ec_spi {
> >         unsigned int start_of_msg_delay;
> >         unsigned int end_of_msg_delay;
> >         struct kthread_worker *high_pri_worker;
> > +       struct gpio_desc *boot0;
> > +       struct gpio_desc *reset;
> >  };
> >
> >  typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
> > @@ -690,7 +693,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> >         return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
> >  }
> >
> > -static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> > +static int cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> >  {
> >         struct device_node *np = dev->of_node;
> >         u32 val;
> > @@ -703,6 +706,31 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> >         ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
> >         if (!ret)
> >                 ec_spi->end_of_msg_delay = val;
> > +
> > +       if (!of_device_is_compatible(np, "google,cros-ec-fp"))
> > +               return 0;
> > +
> > +       ec_spi->boot0 = devm_gpiod_get(dev, "boot0", 0);
> > +       if (IS_ERR(ec_spi->boot0))
> > +               return PTR_ERR(ec_spi->boot0);
> > +
> > +       ec_spi->reset = devm_gpiod_get(dev, "reset", 0);
> > +       if (IS_ERR(ec_spi->reset))
> > +               return PTR_ERR(ec_spi->reset);
> > +
> > +       /*
> > +        * Take the FPMCU out of reset and wait for it to boot if it's in
> > +        * bootloader mode or held in reset. Otherwise the BIOS has already
> > +        * powered on the device earlier in boot in which case there's nothing
> > +        * to do.
> > +        */
> > +       if (!gpiod_get_value(ec_spi->boot0) || gpiod_get_value(ec_spi->reset)) {
> > +               gpiod_set_value(ec_spi->boot0, 1);
> If you follow my suggestions on the other patch to keep boot0
> active_high, this needs to change back to a 0. Since normal=0.
>
> > +               gpiod_set_value(ec_spi->reset, 0);
> > +               usleep_range(1000, 2000);
> You have to be careful here. I assume by the end of this if you expect
> the fpmcu to be in normal mode.
>
> There is a corner case (which I guess is unlikely) that the fpmcu,
> just before the if, was out of reset but in bootloader mode (boot0=1,
> nrst=1, physically). At that point this code will enter the if body
> and set boot0=0, but the reset signal would not be changed (we're
> already out of reset!), so we'll still be in bootloader mode since
> there was no resetting (so no sampling of boot0).
>
> I suggest you change this if body to look like:
>
> +               gpiod_set_value(ec_spi->boot0, 0); // normal mode
> +               gpiod_set_value(ec_spi->reset, 1); // enter reset
> (these reset comments might be optional)
> +               usleep_range(1000, 2000);
> +               gpiod_set_value(ec_spi->reset, 0); // release reset
> +               usleep_range(1000, 2000); // maybe increase?

Ok got it. I'll make the change and test it out.

>
> In the normal case (when we do have firmware support). All this code
> will probably get skipped and there will be plenty of time to boot the
> fpmcu before the driver enumerates.
>
> Speaking of, have you tried this path? I think booting (fpmcu all the
> way to RW) usually takes forever (seconds or so?). I remember Craig
> mentioning this is why we want to do it so early (in ap firmware)
> since by the time the kernel tries to enumerate it'll be done.
>
> If that's the case you might want to change that last usleep_range to
> actually wait that long.

I tested this by running the flashing code and then seeing if the cros
ec driver probed. I'll have to manually put it into bootloader mode and
then bind this driver to see how long it takes. Is there any way I can
poll an irq line or something to wait for boot? That would be much
better vs. sticking some delay into here.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A504E31A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353267AbiCUUWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351457AbiCUUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:22:34 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A5A8E1B8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:21:08 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so20539959oof.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rTgOdADcnyA0BCO1fGE2kUoGWJ9SsEVRiwdwRn3Fb6c=;
        b=AhNakQxvOVXeCx1Cgds6Dytg2l8lD1vKr6Pm3GAz20BKTaZ7o6VjQLV4fw/HhCP4B+
         W6NwSfTtjf88xC58ukNRqHbJw2bios24bNn6RcqBLFxRyRc7CsShxDe8HA73i7bElBs+
         Mgy483QkjW+4BS8vL2r9ouJZAgfLeDI5VfJM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rTgOdADcnyA0BCO1fGE2kUoGWJ9SsEVRiwdwRn3Fb6c=;
        b=vYDdp250ML038ifWJv6CqBKo3gvBGKtM49TJ2rj1qfyG8spKrtclHtLVNsLrUdQAo/
         LLbMrphXDsswod2bJCXH/FEepTbowjPchUQ0WC3msN4CBkQxfxm0SUCQVsmHbmDaohI3
         alHH+ndeoyPBI1zLSFgSO1V0oh6t19SnlJ+2UFqmky9YVz+x1XKHhOrnnXUqjL3sMroD
         XEr3do7Kq1WOx74Hi3tNGuNls6B9W8vkcYfWZJlzSjyPTqU19fv5KthLhCNmn1TIs9z2
         ATwOubCv+ZbEuGvWFg817SjRgkckXyUJ+Fw7Gg/xIck+N7wvIEtiD1SnzUynwwPSRSFW
         eycw==
X-Gm-Message-State: AOAM5316KZIzhiWWkjD1bAUNVo4s1eSeKJCGJRv29Dwiy2bnVwVBflJX
        c2EfQeJiGt6d06yXjZJL07jJUG2TeAiY+DVNFNLkPqCh3CU=
X-Google-Smtp-Source: ABdhPJwVF4OGh6TxCwRLL/ziqe2qhaQ39b1sTK5A1AiZYkfEHUO2iXvoRk+rkXUkPTzLxNZEfeeIn2jzi4QRNeCqzzE=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr320082oab.193.1647894068295; Mon, 21
 Mar 2022 13:21:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 21:21:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UXeJVVbJhdcoCc8iUESZ-Vz07iY-yt1OY3EM9m7T-axw@mail.gmail.com>
References: <20220321191100.1993-1-swboyd@chromium.org> <20220321191100.1993-4-swboyd@chromium.org>
 <CAD=FV=UXeJVVbJhdcoCc8iUESZ-Vz07iY-yt1OY3EM9m7T-axw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 21:21:07 +0100
Message-ID: <CAE-0n53UXmNZ9GUfh0A+F3NyJd2QqDL1GFaf-FtaJ2EidzBMeA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] platform/chrome: cros_ec_spi: Boot fingerprint
 processor during probe
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-03-21 13:04:20)
> Hi,
>
> On Mon, Mar 21, 2022 at 12:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
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
> > Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_spi.c | 42 +++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > index 51b64b392c51..92518f90f86e 100644
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
> > @@ -690,11 +691,13 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> >         return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
> >  }
> >
> > -static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> > +static int cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> >  {
> >         struct device_node *np = dev->of_node;
> >         u32 val;
> >         int ret;
> > +       struct gpio_desc *boot0;
> > +       struct gpio_desc *reset;
> >
> >         ret = of_property_read_u32(np, "google,cros-ec-spi-pre-delay", &val);
> >         if (!ret)
> > @@ -703,6 +706,37 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> >         ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
> >         if (!ret)
> >                 ec_spi->end_of_msg_delay = val;
> > +
> > +       if (!of_device_is_compatible(np, "google,cros-ec-fp"))
> > +               return 0;
> > +
> > +       boot0 = devm_gpiod_get(dev, "boot0", 0);
>
> I think that the last parameter to devm_gpiod_get() is better
> described by "GPIOD_ASIS", right? Same for the other one below.

Yes, 0 is GPIOD_ASIS.

>
>
> > +       if (IS_ERR(boot0))
> > +               return PTR_ERR(boot0);
> > +
> > +       reset = devm_gpiod_get(dev, "reset", 0);
> > +       if (IS_ERR(reset))
> > +               return PTR_ERR(reset);
> > +
> > +       /*
> > +        * Take the FPMCU out of reset and wait for it to boot if it's in
> > +        * bootloader mode or held in reset. This isn't the normal flow because
> > +        * typically the BIOS has already powered on the device to avoid the
> > +        * multi-second delay waiting for the FPMCU to boot and be responsive.
> > +        */
> > +       if (gpiod_get_value(boot0) || gpiod_get_value(reset)) {
>
> I believe that the above two calls are illegal as documented. The file
> `Documentation/driver-api/gpio/consumer.rst` says that if you use
> `GPIOD_ASIS` to get the GPIO that "The direction must be set later
> with one of the dedicated functions.". The "must" there is important.
>
> Oh, and further down it appears to be even more explicit and says "Be
> aware that there is no default direction for GPIOs. Therefore, **using
> a GPIO without setting its direction first is illegal and will result
> in undefined behavior!**".
>
> I assume that "get" counts as using?
>
> I think this sorta gets into some of the limitations of the GPIO APIs
> in Linux that try to make sure that they work on a "lowest common
> denominator" GPIO controller. I don't think they promise that
> "get_value" while in output mode is legal across all GPIO controllers.
>
> Maybe a solution is to at least add a comment saying that the code
> will only work on GPIO controllers that will let you get the value
> back if it's an output?

Ugh, yeah. I don't have a good way to detect that it is already booted
by the BIOS then, besides adding some other DT property that can
indicate we need to boot it, like "google,needs-boot", or have a
different compatible string for this device when it is powered off.

Or we could try to communicate with the device and if it fails to
respond we get the gpios and do the boot sequence before giving up on
probe. I don't see much value in that though so I'm leaning towards
dropping this patch.

>
>
> > +               /* Boot0 is sampled on reset deassertion */
> > +               gpiod_set_value(boot0, 0);
> > +               gpiod_set_value(reset, 1);
>
> Those two calls are almost certainly illegal / not guaranteed to work
> without setting a direction, at least in the general case. Luckily I
> think it's easy to just change both of them to
> "gpiod_direction_output", which takes a value.
>
> Actually, even on Qualcomm hardware I don't think those will work if
> the boot direction was input, will they? They'll set the value that
> _will_ be driven but won't cause it to actually be driven, right?
>

Correct.

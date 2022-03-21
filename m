Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465B4E3107
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352883AbiCUUGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiCUUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:06:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BB35DC0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:04:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pv16so32185087ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EphSPWlAG/seg8/XxUJ+C6+QPSj46eTtMcd7G1mgPek=;
        b=GJiGVlHHVxpjdeq+5wwQIz8f5/ZJWDeVpfFx00K5d5coCxSF4lf0U5NM44hce0/8dS
         cDFuTSLXY1Tt08BWUK1bQeUbHtbjiOlkx/fMqd5T3EQHiTBKDRUWj5duxUWAnfoZwX6n
         MJ+uELUJaR+tdQCDhu96nQH9BWXME35LCBwrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EphSPWlAG/seg8/XxUJ+C6+QPSj46eTtMcd7G1mgPek=;
        b=slrocj2x7I8ZBlzKcKlixcEiJ2IM8l8KXnJ06ZW+JWDS0IChPQ2fxxEk47EgKtIPoN
         yZLIHZ138b2t0M4GTMqFmiLf0qV1eSu2zxkQ27uxvnSpwMDB0qwi6LDaYrvowxZkmHIR
         Mv3cuWc/QnxvAl/s7i9dG5P+PoGqw1YXI6dd6w8iO5IR+0tOZoY6mxEHCVafCYAAUcKE
         2Ack3erYF3Je3HAnq4PqarFZesO8dRk2VJKccmdtGfnO772kiWIibZbrS637w0AeuN8y
         7UJq8INYeRFlvNyP6MokIgQt1dHMotio+swOmBhXsIkWoCNz+fcnZWTgLUuS51i554vR
         tLOg==
X-Gm-Message-State: AOAM531MRfY/erobjw/lr+KZtsWaS970ubJlP6FvJQAVcrd5WD1CZ97i
        MPyv8LwbKAczl5juf+bCxefOBnFBkz6IQw==
X-Google-Smtp-Source: ABdhPJzDeEtDozrCXdtZ1856Y1j+QHoE16KQNvgkH6LTmUGudVj4mz9M3gKo6ffp4E2kyhg0zyFInA==
X-Received: by 2002:a17:907:3d89:b0:6df:802d:df43 with SMTP id he9-20020a1709073d8900b006df802ddf43mr22570543ejc.76.1647893075971;
        Mon, 21 Mar 2022 13:04:35 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id dn4-20020a17090794c400b006dbec4f4acbsm7320759ejc.6.2022.03.21.13.04.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 13:04:35 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id p9so22174883wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:04:34 -0700 (PDT)
X-Received: by 2002:a5d:5551:0:b0:203:f916:e319 with SMTP id
 g17-20020a5d5551000000b00203f916e319mr13385092wrw.422.1647893074416; Mon, 21
 Mar 2022 13:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220321191100.1993-1-swboyd@chromium.org> <20220321191100.1993-4-swboyd@chromium.org>
In-Reply-To: <20220321191100.1993-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Mar 2022 13:04:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXeJVVbJhdcoCc8iUESZ-Vz07iY-yt1OY3EM9m7T-axw@mail.gmail.com>
Message-ID: <CAD=FV=UXeJVVbJhdcoCc8iUESZ-Vz07iY-yt1OY3EM9m7T-axw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] platform/chrome: cros_ec_spi: Boot fingerprint
 processor during probe
To:     Stephen Boyd <swboyd@chromium.org>
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

Hi,

On Mon, Mar 21, 2022 at 12:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add gpio control to this driver so that the fingerprint device can be
> booted if the BIOS isn't doing it already. This eases bringup of new
> hardware as we don't have to wait for the BIOS to be ready, supports
> kexec where the GPIOs may not be configured by the previous boot stage,
> and is all around good hygiene because we control GPIOs for this device
> from the device driver.
>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c | 42 +++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 51b64b392c51..92518f90f86e 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -4,6 +4,7 @@
>  // Copyright (C) 2012 Google, Inc
>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -690,11 +691,13 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
>         return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
>  }
>
> -static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> +static int cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>  {
>         struct device_node *np = dev->of_node;
>         u32 val;
>         int ret;
> +       struct gpio_desc *boot0;
> +       struct gpio_desc *reset;
>
>         ret = of_property_read_u32(np, "google,cros-ec-spi-pre-delay", &val);
>         if (!ret)
> @@ -703,6 +706,37 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>         ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
>         if (!ret)
>                 ec_spi->end_of_msg_delay = val;
> +
> +       if (!of_device_is_compatible(np, "google,cros-ec-fp"))
> +               return 0;
> +
> +       boot0 = devm_gpiod_get(dev, "boot0", 0);

I think that the last parameter to devm_gpiod_get() is better
described by "GPIOD_ASIS", right? Same for the other one below.


> +       if (IS_ERR(boot0))
> +               return PTR_ERR(boot0);
> +
> +       reset = devm_gpiod_get(dev, "reset", 0);
> +       if (IS_ERR(reset))
> +               return PTR_ERR(reset);
> +
> +       /*
> +        * Take the FPMCU out of reset and wait for it to boot if it's in
> +        * bootloader mode or held in reset. This isn't the normal flow because
> +        * typically the BIOS has already powered on the device to avoid the
> +        * multi-second delay waiting for the FPMCU to boot and be responsive.
> +        */
> +       if (gpiod_get_value(boot0) || gpiod_get_value(reset)) {

I believe that the above two calls are illegal as documented. The file
`Documentation/driver-api/gpio/consumer.rst` says that if you use
`GPIOD_ASIS` to get the GPIO that "The direction must be set later
with one of the dedicated functions.". The "must" there is important.

Oh, and further down it appears to be even more explicit and says "Be
aware that there is no default direction for GPIOs. Therefore, **using
a GPIO without setting its direction first is illegal and will result
in undefined behavior!**".

I assume that "get" counts as using?

I think this sorta gets into some of the limitations of the GPIO APIs
in Linux that try to make sure that they work on a "lowest common
denominator" GPIO controller. I don't think they promise that
"get_value" while in output mode is legal across all GPIO controllers.

Maybe a solution is to at least add a comment saying that the code
will only work on GPIO controllers that will let you get the value
back if it's an output?


> +               /* Boot0 is sampled on reset deassertion */
> +               gpiod_set_value(boot0, 0);
> +               gpiod_set_value(reset, 1);

Those two calls are almost certainly illegal / not guaranteed to work
without setting a direction, at least in the general case. Luckily I
think it's easy to just change both of them to
"gpiod_direction_output", which takes a value.

Actually, even on Qualcomm hardware I don't think those will work if
the boot direction was input, will they? They'll set the value that
_will_ be driven but won't cause it to actually be driven, right?


-Doug

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702834DE2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiCRUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbiCRUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:51:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F810611D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:50:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z92so10634353ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqXyMcosh6O0yi35uVm3REnikABrKVmHdEClLD8qyRQ=;
        b=IIT21OtaTmFd1XK0u6Xj60LiXC6QZvzAlZbuCV/xuBgzlIKcEGJjbfpHDztxQaxexU
         J/8dykpwdVx1ckyCUwy6SB/8Gu6oasOoV0msxHqdymPqhwhlYtCpTL1wqMY5A1NY7CcG
         TvGyx0F5A7Bp9NxRlaUGtGaEPSRAJdBxyKRY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqXyMcosh6O0yi35uVm3REnikABrKVmHdEClLD8qyRQ=;
        b=2aarJW/cUFGNOCz/iqTKg3/Em1QEOXUBn/b9lVeHV3sibgF4N3ieGU/HK3/aYiuD1u
         l+/QuFEsH/hMG+GJN4h1wQr3ITN9nF3BdICqULLoA6LfMxMnuCiLdd16x6V5RGBXfxQw
         uoON8M3iPZkyvyRTw8Wao2LBukeWHdXX9fL1FNMd/k6voaqyDQ2nrqtU4N3GKOj8z6VZ
         XzBfRmTwxxvTh0KcI1xyLibm1pZ6TsqNse7YGHe34YHZRTTqX3vQ5CaUE8I0s+S2AUQi
         TYGLzCQDI2X1fzk201L0eDC1R3ezMSS4JYRBiNd1OfZLoH5CziY/xIXV5Thov6ITtwSS
         94nw==
X-Gm-Message-State: AOAM530pGfEh/QlA0J7b50E0DrrYX4v5TnzFUf4SR0MAjSsrvxCWvXr+
        bX9H6eET5dXegSP85rto7c+se/z3p0LJWT82dEk=
X-Google-Smtp-Source: ABdhPJw8gziSR7LX0jc40/jovE20czy3gLBqC65qF343kYhbJ5nmFQvEK8PPT6Al9FwHgIIMyXzdDA==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr11233582edw.113.1647636619727;
        Fri, 18 Mar 2022 13:50:19 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090626d700b006cfcd39645fsm4056508ejc.88.2022.03.18.13.50.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 13:50:19 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso5059211wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:50:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2e02:b0:38c:8390:d8ca with SMTP id
 o2-20020a05600c2e0200b0038c8390d8camr6529516wmf.15.1647636618463; Fri, 18 Mar
 2022 13:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220318015451.2869388-1-swboyd@chromium.org> <20220318015451.2869388-4-swboyd@chromium.org>
In-Reply-To: <20220318015451.2869388-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Mar 2022 13:50:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJFoNgfMUHE5mUY6Uq2Jj5cyQVyW0osUm6jyHRE1no=w@mail.gmail.com>
Message-ID: <CAD=FV=VJFoNgfMUHE5mUY6Uq2Jj5cyQVyW0osUm6jyHRE1no=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/chrome: cros_ec_spi: Boot fingerprint
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 6:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
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
> index d0f9496076d6..13d413a2fe46 100644
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
> @@ -77,6 +78,8 @@ struct cros_ec_spi {
>         unsigned int start_of_msg_delay;
>         unsigned int end_of_msg_delay;
>         struct kthread_worker *high_pri_worker;
> +       struct gpio_desc *boot0;
> +       struct gpio_desc *reset;

This structure has members described with kernel-doc. You should
document your members.


>  };
>
>  typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
> @@ -690,7 +693,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
>         return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
>  }
>
> -static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> +static int cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>  {
>         struct device_node *np = dev->of_node;
>         u32 val;
> @@ -703,6 +706,37 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>         ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
>         if (!ret)
>                 ec_spi->end_of_msg_delay = val;
> +
> +       if (!of_device_is_compatible(np, "google,cros-ec-fp"))
> +               return 0;

I noticed in your previous patch that you not only added a device-tree
match for this device but also a "spi_device_id". ...but won't you
fail to do all this important GPIO work in that case?


> +       ec_spi->boot0 = devm_gpiod_get(dev, "boot0", 0);
> +       if (IS_ERR(ec_spi->boot0))
> +               return PTR_ERR(ec_spi->boot0);

Right now these GPIOs don't actually need to be stored in the "ec_spi"
structure. They could just be local variables. I guess you're trying
to future proof?


> +       ec_spi->reset = devm_gpiod_get(dev, "reset", 0);
> +       if (IS_ERR(ec_spi->reset))
> +               return PTR_ERR(ec_spi->reset);
> +
> +       /*
> +        * Take the FPMCU out of reset and wait for it to boot if it's in
> +        * bootloader mode or held in reset. This isn't the normal flow because
> +        * typically the BIOS has already powered on the device to avoid the
> +        * multi-second delay waiting for the FPMCU to boot and be responsive.
> +        */
> +       if (gpiod_get_value(ec_spi->boot0) || gpiod_get_value(ec_spi->reset)) {
> +               /* Boot0 is sampled on reset deassertion */
> +               gpiod_set_value(ec_spi->boot0, 0);
> +               gpiod_set_value(ec_spi->reset, 1);
> +               usleep_range(1000, 2000);
> +               gpiod_set_value(ec_spi->reset, 0);
> +
> +               /* Wait for boot; there isn't a "boot done" signal */
> +               dev_info(dev, "Waiting for FPMCU to boot\n");
> +               msleep(2000);
> +       }

You added the regulator to the bindings. On herobrine I know that the
regulator is a bit of a dummy (at least on herobrine), but I wonder if
you should still get/enable it here? In the device tree bindings you
listed it as not-optional so, in theory, you could use this to give an
error if someone didn't provide the regulator.

BTW: it seems like it wouldn't be a _crazy_ amount of extra work to:

1. Add a sysfs hook for turning the regulator on/off

2. Change the Chrome OS userspace to actually use the sysfs hook if it's there.

3. Actually have the kernel in charge of turning the regulator off/on

Doing this at the same time as the transition over to the more real
"cros-ec-fp" would be nice so we don't have to figure out how to
transition later. Said another way: If we don't transition now then I
guess later we'd have to find some way to detect that the regulator
specified in the kernel was actually a dummy and didn't really control
the power?

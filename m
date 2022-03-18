Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1294DE3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiCRWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiCRWC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:02:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7010DA58
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:01:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id z8so10228208oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=H2XMtIcPQfpU8xK6zEFnk7wP4y3FQhPGXifQJ5OkvqE=;
        b=jQ50mFlz+A/i9XfUvNughWdVVWWMbgsaT+1FISnucpvFpzPj2FhLH0vJlsSySiKs5M
         AUcRHnguh6tOo2cYDwZz9u94fW7MDhUzRGyPiHYfocpPy3yMnTd47CuzzuwhgzCM2RRX
         7FggQMurAZdmGJQfgWYNSnBquguYlv2bvTUno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=H2XMtIcPQfpU8xK6zEFnk7wP4y3FQhPGXifQJ5OkvqE=;
        b=AWmiFeUG5G609v7HC/0mqp1N9RveBDCe3uKSN0DNiqOsTs2IO+uLcj9lxTsnFJDCm9
         64eY/hYWhcQVl7ELpSX+/n6+7fyXsl1Vzn0auThfU0qVE2WUNGpC0jBg/zCh2O1ggtjN
         k0C67OpQgLGPO3Y2kSEV+NEAQLOjiBgpn1mhepObd1He7ObfmCYvCkck7w8e+vRKVhEj
         Qa8lL68PFJ3uRR1hDm/vyp9ygfDqMZnaSGtzx/nc2W5a19zc78/984cj+SlzEGZJWRqI
         WWk2kop2CXMYwaHTrA7i7oOOLS8RUtw2WIPVLZ2Azricz99j+b7YAXOiBPnizmgdbqmU
         eVgA==
X-Gm-Message-State: AOAM532S+HoGUoTBemKU+g17rMdi7hjmAIc6QLaVBv2c2kQvewM6Tg6S
        xILd7oKGzbDIqojp8LFGoQvNRVzVa4kwBfiqDxT3/A==
X-Google-Smtp-Source: ABdhPJzc267aBUgreK1A/B2hzk5XQO5hBzXlD4lZ12O9f7aLTxO5f8FmdCVo/I3qGRFqjm+Mu/L12PbMa7p1QwSkxyA=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr4927984oie.193.1647640869239; Fri, 18
 Mar 2022 15:01:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Mar 2022 15:01:08 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VJFoNgfMUHE5mUY6Uq2Jj5cyQVyW0osUm6jyHRE1no=w@mail.gmail.com>
References: <20220318015451.2869388-1-swboyd@chromium.org> <20220318015451.2869388-4-swboyd@chromium.org>
 <CAD=FV=VJFoNgfMUHE5mUY6Uq2Jj5cyQVyW0osUm6jyHRE1no=w@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Mar 2022 15:01:08 -0700
Message-ID: <CAE-0n50HcLLUUDgiMc7u4Gx5gb-bcpO22iD9emHrnM8sx8nbOQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/chrome: cros_ec_spi: Boot fingerprint
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-03-18 13:50:05)
> Hi,
>
> On Thu, Mar 17, 2022 at 6:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
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
> > index d0f9496076d6..13d413a2fe46 100644
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
>
> This structure has members described with kernel-doc. You should
> document your members.
>
>
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
> > @@ -703,6 +706,37 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> >         ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
> >         if (!ret)
> >                 ec_spi->end_of_msg_delay = val;
> > +
> > +       if (!of_device_is_compatible(np, "google,cros-ec-fp"))
> > +               return 0;
>
> I noticed in your previous patch that you not only added a device-tree
> match for this device but also a "spi_device_id". ...but won't you
> fail to do all this important GPIO work in that case?

I don't know when the spi_device_id path will be used. Never? I can
simply drop it from the spi_device_id list for now and we can take up
this problem later or never.

>
>
> > +       ec_spi->boot0 = devm_gpiod_get(dev, "boot0", 0);
> > +       if (IS_ERR(ec_spi->boot0))
> > +               return PTR_ERR(ec_spi->boot0);
>
> Right now these GPIOs don't actually need to be stored in the "ec_spi"
> structure. They could just be local variables. I guess you're trying
> to future proof?

Sure I will drop them because they're not useful later and I can save on
the kernel-doc.

>
>
> > +       ec_spi->reset = devm_gpiod_get(dev, "reset", 0);
> > +       if (IS_ERR(ec_spi->reset))
> > +               return PTR_ERR(ec_spi->reset);
> > +
> > +       /*
> > +        * Take the FPMCU out of reset and wait for it to boot if it's in
> > +        * bootloader mode or held in reset. This isn't the normal flow because
> > +        * typically the BIOS has already powered on the device to avoid the
> > +        * multi-second delay waiting for the FPMCU to boot and be responsive.
> > +        */
> > +       if (gpiod_get_value(ec_spi->boot0) || gpiod_get_value(ec_spi->reset)) {
> > +               /* Boot0 is sampled on reset deassertion */
> > +               gpiod_set_value(ec_spi->boot0, 0);
> > +               gpiod_set_value(ec_spi->reset, 1);
> > +               usleep_range(1000, 2000);
> > +               gpiod_set_value(ec_spi->reset, 0);
> > +
> > +               /* Wait for boot; there isn't a "boot done" signal */
> > +               dev_info(dev, "Waiting for FPMCU to boot\n");
> > +               msleep(2000);
> > +       }
>
> You added the regulator to the bindings. On herobrine I know that the
> regulator is a bit of a dummy (at least on herobrine), but I wonder if
> you should still get/enable it here? In the device tree bindings you
> listed it as not-optional so, in theory, you could use this to give an
> error if someone didn't provide the regulator.

Won't the regulator framework introduce a dummy supply if there isn't a
supply in DT but this driver calls regulator_get()? Getting and enabling
it here will make this even more independent though so it sounds like a
good idea. That way we can make it a real regulator in the DTS as long
as the firmware isn't controlling it.

>
> BTW: it seems like it wouldn't be a _crazy_ amount of extra work to:
>
> 1. Add a sysfs hook for turning the regulator on/off
>
> 2. Change the Chrome OS userspace to actually use the sysfs hook if it's there.
>
> 3. Actually have the kernel in charge of turning the regulator off/on
>
> Doing this at the same time as the transition over to the more real
> "cros-ec-fp" would be nice so we don't have to figure out how to
> transition later. Said another way: If we don't transition now then I
> guess later we'd have to find some way to detect that the regulator
> specified in the kernel was actually a dummy and didn't really control
> the power?

I'd rather not expose regulator control to userspace through some other
sysfs attribute. Instead I'd prefer the flashing logic that twiddles
gpios and power live all in the kernel and have userspace interact with
a character device to program the firmware.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FBB4679D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381611AbhLCPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbhLCPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:01:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B7C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:58:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so12835274edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uwnbjWCW2NbetnVwJHOczwYzHXg75SzbYiTjP9xuJM=;
        b=itSYy8FbZ19oFa7QhxilrMw5H6qoyCm0duHgSQZbQOZROxNHOCqcDctnEx5vqzflDU
         N6jUlqj5k29AnB79/vUGpAtkUodSRJHcft3WPsTtnSPJQdk/lrOcrTU3/GaERqzQj4Mo
         0W6BuGJKAU5xA/nHZNlszqrv62hYMYuMezz68j1sH2gkG7Xlpgc2UbDoCR6J6Kb9E/aW
         b/biOiolzetfN7+uKT0HLdFhhzQQkUKsenYBfJl2gCEL1DeHfv6+U+tfVD5KY7RmJeZS
         t6fTQaJpGQZP7y/yzK971Engixb3kVh4nRb0xmUGeyjbPJwpZ+M9v8Hp9FcmUc6az5PQ
         FQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uwnbjWCW2NbetnVwJHOczwYzHXg75SzbYiTjP9xuJM=;
        b=dwll033PUVoMxwRGj92UyH2K5EgTR0pUfgY0v1jlANhBCcFQciUXTPg21ySAqm0OKu
         kifCtN56IO7U9BBzpQDZ+MqAicettKwY2Tky4TVmLpckFk2gPmhfLhdwvKEsly9T9Eq+
         F3t36QyOOcvUW9cu66iH+ZQ2b363etnxEQtrELvwT0fRLT+7R1iUaQadhjvdvYk1by7/
         Vwk2bh7yqJCEyxdjTtNtSaG8xtsDGS7yQeyxdV6kyrWXh3tyNwEV3apSV9PkA5ZBFuOi
         j2nM1YcLomC9gk3Uz4YKOeE5S3ghlOHskAu1tGAiF5Yx3Gre/aXZ4/4fVKDLqw5u4QQL
         Kauw==
X-Gm-Message-State: AOAM532W+WMWsH7bGy0sF8/9qDO7ENtAPAsqK+y01G4N9l/A0dVWOODO
        aKJfLNvSvrQwqBvySoWsfTWlYkxwbHwFXKf77rilfA==
X-Google-Smtp-Source: ABdhPJzxwFL6qWvmN/+BTvbHoiwaKvQaI0NVlklxFRKIO8SNlltV6yKzNybdFxvRBsZ6lYhom3cwTNMblsarjuCpmsw=
X-Received: by 2002:aa7:cb45:: with SMTP id w5mr27367673edt.405.1638543503580;
 Fri, 03 Dec 2021 06:58:23 -0800 (PST)
MIME-Version: 1.0
References: <ba7f82f348d77b6a65498dd13a92550949e69cc3.1638540167.git.geert+renesas@glider.be>
 <CAMRc=Me2528N_jT6AoSSTajznY4EFP+cFvEbqnw4rONB5nJsQw@mail.gmail.com>
In-Reply-To: <CAMRc=Me2528N_jT6AoSSTajznY4EFP+cFvEbqnw4rONB5nJsQw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Dec 2021 15:58:13 +0100
Message-ID: <CAMRc=Mdw1pEUntRkJRYcuQH9ZhWc9=psPDe7bXwkj=RCYQKO=g@mail.gmail.com>
Subject: Re: [PATCH resend] gpio: aggregator: Add interrupt support
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enrico Weigelt metux IT consult <info@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        stratos-dev@op-lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 3:56 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Fri, Dec 3, 2021 at 3:06 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > Currently the GPIO Aggregator does not support interrupts.  This means
> > that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
> > and userspace applications using line events do not work.
> >
> > Add interrupt support by providing a gpio_chip.to_irq() callback, which
> > just calls into the parent GPIO controller.
> >
> > Note that this does not implement full interrupt controller (irq_chip)
> > support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
> > still does not work.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > I would prefer to avoid implementing irq_chip support, until there is a
> > real use case for this.
> >
> > This has been tested with gpio-keys and gpiomon on the Koelsch
> > development board:
> >
> >   - gpio-keys, using a DT overlay[1]:
> >
> >         $ overlay add r8a7791-koelsch-keyboard-controlled-led
> >         $ echo gpio-aggregator > /sys/devices/platform/frobnicator/driver_override
> >         $ echo frobnicator > /sys/bus/platform/drivers/gpio-aggregator/bind
> >
> >         $ gpioinfo frobnicator
> >         gpiochip12 - 3 lines:
> >                 line   0:      "light"      "light"  output  active-high [used]
> >                 line   1:         "on"         "On"   input   active-low [used]
> >                 line   2:        "off"        "Off"   input   active-low [used]
> >
> >         $ echo 255 > /sys/class/leds/light/brightness
> >         $ echo 0 > /sys/class/leds/light/brightness
> >
> >         $ evtest /dev/input/event0
> >
> >   - gpiomon, using the GPIO sysfs API:
> >
> >         $ echo keyboard > /sys/bus/platform/drivers/gpio-keys/unbind
> >         $ echo e6055800.gpio 2,6 > /sys/bus/platform/drivers/gpio-aggregator/new_device
> >         $ gpiomon gpiochip12 0 1
> >
> > [1] "ARM: dts: koelsch: Add overlay for keyboard-controlled LED"
> >     https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=c78d817869e63a3485bb4ab98aeea6ce368a396e
> > ---
> >  drivers/gpio/gpio-aggregator.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
> > index e9671d1660ef4b40..869dc952cf45218b 100644
> > --- a/drivers/gpio/gpio-aggregator.c
> > +++ b/drivers/gpio/gpio-aggregator.c
> > @@ -371,6 +371,13 @@ static int gpio_fwd_set_config(struct gpio_chip *chip, unsigned int offset,
> >         return gpiod_set_config(fwd->descs[offset], config);
> >  }
> >
> > +static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
> > +
> > +       return gpiod_to_irq(fwd->descs[offset]);
> > +}
> > +
> >  /**
> >   * gpiochip_fwd_create() - Create a new GPIO forwarder
> >   * @dev: Parent device pointer
> > @@ -411,7 +418,8 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
> >         for (i = 0; i < ngpios; i++) {
> >                 struct gpio_chip *parent = gpiod_to_chip(descs[i]);
> >
> > -               dev_dbg(dev, "%u => gpio-%d\n", i, desc_to_gpio(descs[i]));
> > +               dev_dbg(dev, "%u => gpio %d irq %d\n", i,
> > +                       desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));
> >
> >                 if (gpiod_cansleep(descs[i]))
> >                         chip->can_sleep = true;
> > @@ -429,6 +437,7 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
> >         chip->get_multiple = gpio_fwd_get_multiple_locked;
> >         chip->set = gpio_fwd_set;
> >         chip->set_multiple = gpio_fwd_set_multiple_locked;
> > +       chip->to_irq = gpio_fwd_to_irq;
> >         chip->base = -1;
> >         chip->ngpio = ngpios;
> >         fwd->descs = descs;
> > --
> > 2.25.1
> >
>
> Applied, thanks!
>
> Bart

Eek, missed the explanation.

I think this is fine. For user-space eventual switch to a real
irq_chip won't break anything so let's take it.

Bart

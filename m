Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A67464E93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349542AbhLANPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349512AbhLANPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:15:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04326C061756
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:11:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so101273769edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liC6iBHdVHj8wrS34Mv4qj/s+gn0Mtz6/NZeXb3PmG0=;
        b=CW883sHA/ZsErtuI3bBKwZH7FrSIo6SF/udDvszUZTIfAWjof6aw/X6qtqF6e/83+e
         Qz50HsrZj7OUdZoK9oP6fKMs/blgQZ0ffMhE1aJGR1dzTa0lTeMFAhvBjqbeVigBkTaM
         PWbItNOZEKHzVZ92ZsfTsGwAHNMEfG5wPpYBPd8sCNiVnnRABSTnZCAUrHvEL7nyyJc2
         cJzm/1+U9eb+I8rCxW90/bqbNbx95VrX3Iu68TelOmXj4Z6WqnMlAqkV8tjkJbgiiJze
         6FM+UqTZzC2OeqKQsofRWnuTdYE2vYadOSzCHKAxD5MRkew2GtOQ3s+M0yX35D98WXLs
         piyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liC6iBHdVHj8wrS34Mv4qj/s+gn0Mtz6/NZeXb3PmG0=;
        b=0z+gNsM7C5wLR/1Nn09thJF0FNwvEDkJPfgLrZ1jR9fWjymasudeyvw5p8K4BGG+S5
         uGcC8oRrEzrUEwiUDIyknX1tI/4fLK8DqjcS84zVXfsBkuT2tgYA3ARAQG2xYAYqUK8s
         sJGcRyUrP7SPCAZoCDL95/zDKZgbPgfKyMAweuOQiY45JG9dW+ixY9QDxkeeso0ZrwdY
         SO1oY3V8yHCO7G6qMvnla2FqdpZyEhrId7ecPIct1dVQ4KmQQLJfujbcgn/NU5C2+tMC
         qbUp96cfG0nsNDrgSlq+PsEA/qHH52qlODPueu4nsryCwDQi7N7KGDwg3ZAtKfW4m/0q
         BtXg==
X-Gm-Message-State: AOAM530nL7uifFDcT6J9GIj67rMrl02nbqMz/71Kh3eVWcmVp9Z/tXOh
        7LuirQtWQnTcWqRWW0aF+zwTSC0mmEWDZCeWnxrbow==
X-Google-Smtp-Source: ABdhPJzXpOwR/zmaQijtGvVMihRvtGN4y1YzAc1jjrZxJxi1juTyRwOdjlj1BPD38T9PG+TZgGcLPYM5+xi2wbTzz5k=
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr7104471ejc.433.1638364299412;
 Wed, 01 Dec 2021 05:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20211130154127.12272-1-brgl@bgdev.pl> <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
In-Reply-To: <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Dec 2021 14:11:28 +0100
Message-ID: <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Nov 30, 2021 at 10:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 30, 2021 at 09:25:35PM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Nov 30, 2021 at 5:15 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> > > > > Software nodes allow us to represent hierarchies for device components
> > > > > that don't have their struct device representation yet - for instance:
> > > > > banks of GPIOs under a common GPIO expander. The core gpiolib core
> > > >
> > > > core .. core ?!
> > > >
> > > > > however doesn't offer any way of passing this information from the
> > > > > drivers.
> > > > >
> > > > > This extends struct gpio_chip with a pointer to fwnode that can be set
> > > > > by the driver and used to pass device properties for child nodes.
> > > > >
> > > > > This is similar to how we handle device-tree sub-nodes with
> > > > > CONFIG_OF_GPIO enabled.
> > > >
> > > > Not sure I understand the proposal. Can you provide couple of (simplest)
> > > > examples?
> > > >
> > > > And also it sounds like reinventing a wheel. What problem do you have that you
> > > > need to solve this way?
> > > >
> > > > ...
> > > >
> > > > > +#if IS_ENABLED(CONFIG_OF_GPIO)
> > > > > +     if (gc->of_node && gc->fwnode) {
> > > > > +             pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
> > > > > +                    __func__);
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +#endif /* CONFIG_OF_GPIO */
> > > >
> > > > I don't like this. It seems like a hack right now.
> > > >
> > > > Is it possible to convert all GPIO controller drivers to provide an fwnode
> > > > rather than doing this? (I believe in most of the drivers we can drop
> > > > completely the of_node assignment).
> > > >
> > >
> > > Yes, it's definitely a good idea but I would be careful with just
> > > dropping the of_node assignments as callbacks may depend on them
> > > later.
> >
> > GPIO library does it for us among these lines:
> >
> >         struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
> >
> >         of_gpio_dev_init(gc, gdev); <<< HERE!
> >         acpi_gpio_dev_init(gc, gdev);
> >
> >         /*
> >          * Assign fwnode depending on the result of the previous calls,
> >          * if none of them succeed, assign it to the parent's one.
> >          */
> >         gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> >
>
> Except that it doesn't and I noticed that when working on the
> subsequent patch. The child gpiochipX devices all had the parent's
> fwnode assigned as their primary fwnode and no secondary fwnode.
>
> Note that this driver doesn't use neither OF nor ACPI in which case
> gdev->dev has no fwnode and the parent's one is used. This patch
> addresses it. If you have a better idea, let me know.
>
> Bart

Let me maybe rephrase the problem: currently, for GPIO devices
instantiating multiple banks created outside of the OF or ACPI
frameworks (e.g. instantiated manually and configured using a
hierarchy of software nodes with a single parent swnode and a number
of child swnodes representing the children), it is impossible to
assign firmware nodes other than the one representing the top GPIO
device to the gpiochip child devices.

In fact if we want to drop the OF APIs entirely from gpiolib - this
would be the right first step as for gpio-sim it actually replaces the
gc->of_node = some_of_node; assignment that OF-based drivers do for
sub-nodes defining banks and it does work with device-tree (I verified
that too) thanks to the fwnode abstraction layer.

Linus: Do you have anything against this change?

Bart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2A464F36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349862AbhLAN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244426AbhLAN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:57:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB1C06175B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:53:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so102063580edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 05:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4deMsVbOnJ3WN8CLL6wclTeFqPAZPUEWcJx/Fop1Tyo=;
        b=1l3lnEtuA8NrfBhwXmTUJrdk7Oemc/pyml50HxaN70UALtlVNqS/FBDnUVC7ONlL/U
         0mkYW5ZoouJf3JnG/o77BM4sfzCkQLxpP1Fi8occwNuQ64wWZeounUscVrblhDB2cJkS
         OFqk323TvUF4e4TQ7bV5Fd6U76FH2Vh4WytR9Os5ZKcPC0HC7aHuKRMsSg7rukyfHluk
         fBH/c7u7YnxTFx/oL4sHzXNjIcNftnTaAKpFZLVtGaahBiderqY+hbB4owgEMwzoIpUd
         XInsHlVVxSgyGQ5qE1QNrFRlZLtycXhguSdZNUopMhFBYnY2Gw7Ge3aQaia4wGVlnb1l
         b7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4deMsVbOnJ3WN8CLL6wclTeFqPAZPUEWcJx/Fop1Tyo=;
        b=qqoVSz9qla23M+y1dLYHI/TZ90suCy2FFrKsIu052fHWs7Kixzplzz/ouUhm9vgU6E
         dU8LXWJ0jJUreaxDtSMuV87pHUS7m/pY3jKHBYzzPDekFTBZbjmyW6eXRB714Hsne7gX
         I6DojSWNNCRpX8zwL0Y9h2RbXPcRyLbFAt3OOxrifAqWS7pyJo7I1Uc4ym0Nhz7OWIj7
         r5z5mPDEYHFv1a0tgwf5AOzxln1oHTQBdAqEXbHuvAVIimRaoOitdW7LdEJdaJrrFwGJ
         zDbHyq97DXmM0jxjx5nkFE/qkGDmNA1J3AXYwAuR+b+QyH8LOm+KcI5JzjMNTSgjz+Vv
         64eg==
X-Gm-Message-State: AOAM532Dedbru3UajEgnWO20noouvJX0bxYCnRJrNXzxsdFInXDzeZBe
        3w/WuHG6OT1ysHc04EGsev1jlZ/8uC2Jek9v1Q56vg==
X-Google-Smtp-Source: ABdhPJyqZibQyod4rRaPKH46bY4KCTTr61Gqj21JVMYOSoBhV1RUk41ThnrGC0919q5EKf6+TNKmvWK5ti4obl53xsk=
X-Received: by 2002:a05:6402:2744:: with SMTP id z4mr8861558edd.310.1638366832980;
 Wed, 01 Dec 2021 05:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20211130154127.12272-1-brgl@bgdev.pl> <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com> <Yad7IQwXDc8gS2Ne@smile.fi.intel.com>
In-Reply-To: <Yad7IQwXDc8gS2Ne@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Dec 2021 14:53:42 +0100
Message-ID: <CAMRc=MeScPA=764xoi9Leu7LayEbhMCuA3u_g5NJjLyc8sJ-vg@mail.gmail.com>
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

On Wed, Dec 1, 2021 at 2:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 10:00 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Nov 30, 2021 at 09:25:35PM +0100, Bartosz Golaszewski wrote:
> > > > > On Tue, Nov 30, 2021 at 5:15 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> > > > > > > Software nodes allow us to represent hierarchies for device components
> > > > > > > that don't have their struct device representation yet - for instance:
> > > > > > > banks of GPIOs under a common GPIO expander. The core gpiolib core
> > > > > >
> > > > > > core .. core ?!
> > > > > >
> > > > > > > however doesn't offer any way of passing this information from the
> > > > > > > drivers.
> > > > > > >
> > > > > > > This extends struct gpio_chip with a pointer to fwnode that can be set
> > > > > > > by the driver and used to pass device properties for child nodes.
> > > > > > >
> > > > > > > This is similar to how we handle device-tree sub-nodes with
> > > > > > > CONFIG_OF_GPIO enabled.
> > > > > >
> > > > > > Not sure I understand the proposal. Can you provide couple of (simplest)
> > > > > > examples?
> > > > > >
> > > > > > And also it sounds like reinventing a wheel. What problem do you have that you
> > > > > > need to solve this way?
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > +#if IS_ENABLED(CONFIG_OF_GPIO)
> > > > > > > +     if (gc->of_node && gc->fwnode) {
> > > > > > > +             pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
> > > > > > > +                    __func__);
> > > > > > > +             return -EINVAL;
> > > > > > > +     }
> > > > > > > +#endif /* CONFIG_OF_GPIO */
> > > > > >
> > > > > > I don't like this. It seems like a hack right now.
> > > > > >
> > > > > > Is it possible to convert all GPIO controller drivers to provide an fwnode
> > > > > > rather than doing this? (I believe in most of the drivers we can drop
> > > > > > completely the of_node assignment).
> > > > > >
> > > > >
> > > > > Yes, it's definitely a good idea but I would be careful with just
> > > > > dropping the of_node assignments as callbacks may depend on them
> > > > > later.
> > > >
> > > > GPIO library does it for us among these lines:
> > > >
> > > >         struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
> > > >
> > > >         of_gpio_dev_init(gc, gdev); <<< HERE!
> > > >         acpi_gpio_dev_init(gc, gdev);
> > > >
> > > >         /*
> > > >          * Assign fwnode depending on the result of the previous calls,
> > > >          * if none of them succeed, assign it to the parent's one.
> > > >          */
> > > >         gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> > > >
> > >
> > > Except that it doesn't and I noticed that when working on the
> > > subsequent patch. The child gpiochipX devices all had the parent's
> > > fwnode assigned as their primary fwnode and no secondary fwnode.
> > >
> > > Note that this driver doesn't use neither OF nor ACPI in which case
> > > gdev->dev has no fwnode and the parent's one is used. This patch
> > > addresses it. If you have a better idea, let me know.
> > >
> > > Bart
> >
> > Let me maybe rephrase the problem: currently, for GPIO devices
> > instantiating multiple banks created outside of the OF or ACPI
> > frameworks (e.g. instantiated manually and configured using a
> > hierarchy of software nodes with a single parent swnode and a number
> > of child swnodes representing the children), it is impossible to
> > assign firmware nodes other than the one representing the top GPIO
> > device to the gpiochip child devices.
> >
> > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > would be the right first step as for gpio-sim it actually replaces the
> > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > sub-nodes defining banks and it does work with device-tree (I verified
> > that too) thanks to the fwnode abstraction layer.
>
> I still don't see how you set up hierarchy of primary/secondary fwnodes.
>
> And I don't like this change. It seems it band-aids some issue with fwnode
> usage. What the easiest way to reproduce the issue with your series applied
> (without this change)?
>

Drop this patch and drop the line where the fwnode is assigned in
gpio-sim.c. Then probe the device and print the addresses of the
parent and child swnodes. See how they are the same and don't match
the swnode hierarchy we created. You can then apply this patch and see
how it becomes correct.

Bart

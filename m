Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC34CFBE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiCGKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiCGKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:49:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A6713E33
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:09:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so6888980edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RbEVZC+Zn7EdMfDVyWjWQwqfg3j1tRp8MbERqIxiTs=;
        b=pN8nU1q9ySHoAKnP7nXKZRGIEuHyTET5VChdK5cTekSZQIK2bE6Xd6MoIOKyUO9BQg
         9hjm0J2qWAYUvTtxaVxzOuFCvx9GNaUF5+p2V+wY2SH4gSMByOfKk2Qw/N7iev8OHmG8
         AqMSQ89eCjhkRLjDjUyhx6DRjL8cOyQQK358Cfks8e0pWbY7VAV0KdE1IJL1W8dtlqIA
         Dl3F5MhUXbaBGP5PJtCxsFKKSCOu6i36Kwj5Z1/E3NpgDVU8h7dje/LHMlZNjzO7SP2t
         0R+JAm6SgK7DNZCByO/wZzk8PJweVaN4L/B5xGuUoDXNLIFHJCWSVttTrqnFQppjiIHG
         P8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RbEVZC+Zn7EdMfDVyWjWQwqfg3j1tRp8MbERqIxiTs=;
        b=m9yTwf9eCdM3Mh1WYx8stJ8ry/ieGwrr6I5cWmGrkxKpf0RpXUzvMLB1DHH8VPElZ9
         aqg5fhvp6o7fRMVpxS55Jgr6VUvbxvzgUCvS1HE6wpNPXYHQsd1XsPCZCqbPPFv97lJQ
         cKUqpnVXQKRfnFMVwm4t4fKgWm2XG2lPmiDGxB63M0lLF8ept8iuCAWHzY3DHOvVCg0c
         6pcwaJUEU6ODvHXj9iuxhOyNpj94aeCmSy4cdb6pvVHiTHcCRkx1LPW9LoTO54wN6wVv
         axpY+6kTRVsadYfizX+DIH1keHMS/lk54f0jRXAXCAnzhu4K+pdEdo4XFAFCmWF9kBHi
         Sg3w==
X-Gm-Message-State: AOAM530jl2bXZjiI3ecwA2vjoInHByu8WOf/LZkiBEgffdJWa6l6eS0/
        /9cvSq9zsZWapoWq/qiesZVfVzzjuRPzTKfhNtT0NeDDuDEqRg==
X-Google-Smtp-Source: ABdhPJyrchgjU5FZ9PVBmdm5+a5+0N5lpaUKoSIBQyXTzcwt5/G4HGOkhu+f3VIStHwT8ncHZyXdlpdzSOBWlINjo60=
X-Received: by 2002:a05:6402:d0d:b0:416:1d69:f23b with SMTP id
 eb13-20020a0564020d0d00b004161d69f23bmr10244279edb.141.1646647742202; Mon, 07
 Mar 2022 02:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20220306193420.99714-1-brgl@bgdev.pl> <CAHp75Vfgsa5Ru5aA7Bx_mV--h-GFKSX9Uocf+njvh8Rc1yNTow@mail.gmail.com>
 <CAHp75Vd8Z-XmSE-JxM55rLAzMqFqm5D7B2HsQ+P_vdh==deOJQ@mail.gmail.com> <YiXWBAlQ4GHiPkDg@smile.fi.intel.com>
In-Reply-To: <YiXWBAlQ4GHiPkDg@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Mar 2022 11:08:51 +0100
Message-ID: <CAMRc=McRVSjiWxaDz0G5pWn7JxMXUV-b8VoUfvsLhc-iZSk4oQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: check for overflow when reading the 'ngpios' property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 10:53 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 07, 2022 at 12:23:03AM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 7, 2022 at 12:19 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Mar 7, 2022 at 12:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > The ngpio fields both in struct gpio_device as well as gpio_chip are
> > > > 16-bit unsigned integers. Let's not risk an overflow and check if the
> > > > property value represented as a 32-bit unsigned integer is not greater
> > > > than U16_MAX.
> > >
> > > ...
> > >
> > > > +               if (ngpios > U16_MAX) {
> > > > +                       ret = EINVAL;
> > > > +                       goto err_free_descs;
> > > > +               }
> > >
> > > I don't think it's a fatal error in this case. I would perhaps print a
> > > warning and simply use a masked (which is done implicitly by an
> > > assignment of the different type) value. Note, the above is buggy on
> > > the buggy DTs, where the upper part of the value is not used. After
> > > this patch you effectively make a regression on, yes, broken DTs.
> >
> > Like
> >
> >     if (ngpios > U16_MAX)
> >         chip_warn(gc, "line cnt %u is greater than supported; use
> > %u\n", ngpios, (u16)ngpio);
>
> Or to be on safer side move this after == 0 check as
>
>         if (gc->ngpio != ngpios)
>                 chip_warn(gc, "line cnt %u is greater than supported; use %u\n", ngpios, gc->ngpio);
>

ngpios is not necessarily used so this check must be in the scope of
the device property read (inside the if (gc->ngpio == 0) { block).

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

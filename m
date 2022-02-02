Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAE4A6F36
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiBBKyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiBBKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:54:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B81C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:54:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s13so64403953ejy.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRzI+h4+4G3K8WlXyiWrWECSH5mt2N8z3QLOfw+ZawA=;
        b=6crsEOUF+BltFBb1hKPB45Jbk3Fyj4l9PeUrgNqQ8AOLnFw4LYEyRY5oa1GelyZK81
         8nGw12FZcCEM2I4sANtgtnYatCUbNXNep0WJn6RCGxLJ32w0zRK+nLRrdYCrk3psTiCr
         PG3jOoCIiRmfA0pZ7w5P1eK5nikm24Ii4caBBq9/AMLek/z39uJOOga6xvzbx6dbqu//
         MVvIimT51bMKW6c4S0KYvG4bAr3XTZdoM7nNKDfQVug0KHZhB3pV+QhkE1dshbn3W/WG
         fLGChz5vNMF5IgKBkwhmpiDF2zkS99eIUCTGhljZJG4cSsS0tlGb0bnNMw2r1s7g8px/
         tm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRzI+h4+4G3K8WlXyiWrWECSH5mt2N8z3QLOfw+ZawA=;
        b=RE7z91EQ/fZq/DVd/A1npGEcuBVsOfYeKNGIiNRcNQVton6gtONqQQF3tEyCgm2UfT
         WD1Gs4HcWa4ofNgRjKPnmg1uuUdF4SnxtwBIsqWcqB3iGfsL9dZWpds8Z66xnv+1uAYz
         1sQggBQnZF4fH2RyXqSQzfLLhHoMFUw+gcnFUGnEmstMzYxf8Ks+W1H6rCrml5ocDHfr
         OGMIaj5Ku4868M1TpWc5LRYQG6Qiw5BFfEETImlYwjZFV5N7t6dEZx6PnP6H94kPvu6t
         GyALSsouqZ8rN96+svAWjaamkRgNH5n4UTGwj6nvtZJ0oa7em1u4qMSaS5SPDUGg0Ao8
         oK8Q==
X-Gm-Message-State: AOAM530imrQdi+Kvq4Q4w3r3S+9mv1Jj1tJmDqVzvNsLpzQSU8vXGrmt
        jtC3Z2SUOnT+SLstN8HitPdxDgQ2pK5I/IyiJIoSYg==
X-Google-Smtp-Source: ABdhPJwAMLpCwX1yF59xEw6bQlSCaxNpbgzeRxBctFwzXbjiP2pgZK6JNnp4qRE8QXsuXDh6SGCvOFE6PO5MkpWrlys=
X-Received: by 2002:a17:906:c150:: with SMTP id dp16mr23410451ejc.736.1643799271223;
 Wed, 02 Feb 2022 02:54:31 -0800 (PST)
MIME-Version: 1.0
References: <6a62a531227cd4f20d77d50cdde60c7a18b9f052.1643625325.git.geert+renesas@glider.be>
 <CAHp75Vd68gsU-NWTGv4Y7Mo4-Vq7DBePa_yVxpDq=DAN5GLEBA@mail.gmail.com>
 <CAMuHMdUq3qZqVHH-QSVnwemVRyCp7b2Ldd-7Q2V8CXcj0+9aow@mail.gmail.com> <CAHp75VccHbfmmk7bEXRrQOcePYxCb28sEY-RV6GBCgXAo8A5Sw@mail.gmail.com>
In-Reply-To: <CAHp75VccHbfmmk7bEXRrQOcePYxCb28sEY-RV6GBCgXAo8A5Sw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 2 Feb 2022 11:54:20 +0100
Message-ID: <CAMRc=MeytMp7JSZUZ+6hz=g77dF1sp83uRMbf5bqvVgKneyV+Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Fix calling into sleeping GPIO controllers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Mikko_Salom=C3=A4ki?= <ms@datarespons.se>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 9:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Feb 1, 2022 at 10:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Feb 1, 2022 at 9:35 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Feb 1, 2022 at 10:09 PM Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
>
> ...
>
> > > > +       return chip->can_sleep ? gpiod_get_value_cansleep(fwd->descs[offset])
> > > > +                              : gpiod_get_value(fwd->descs[offset]);
> > >
> > > This indentation kills the perfectionist in me :-)
> >
> > Why? The above is aligned perfectly ("?" just above ":")?
> >
> > > What about:
> > >
> > >        return chip->can_sleep ?
> > >                gpiod_get_value_cansleep(fwd->descs[offset]) :
> > > gpiod_get_value(fwd->descs[offset]);
> > >
> > > ?
> > >
> > > Or as variant
> > >
> > >        struct gpio_desc *desc = fwd->descs[offset];
> > >
> > >        return chip->can_sleep ? gpiod_get_value_cansleep(desc) :
> > > gpiod_get_value(desc);
> > >
> > > ?
> >
> > IMHO, those are ugly as hell ;-)
>
> I have the same opinion about your initial variant. :-)
>
> So, up to the maintainer(s) what to do.
>

It's Geert's code so let's keep his version. I like it better myself too.

Queued for fixes.

Bart

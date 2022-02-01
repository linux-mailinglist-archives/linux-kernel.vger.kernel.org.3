Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46BF4A5E24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiBAOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:20:26 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36725 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbiBAOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:20:22 -0500
Received: by mail-pf1-f180.google.com with SMTP id 192so16021188pfz.3;
        Tue, 01 Feb 2022 06:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JTo8Sy9jsMuY9se9GPF3GJU4ezrpNEbpV0Rieuvz5M=;
        b=3A+egGLO2Hj12855kPGUmSOtyLxq2qLtaLB1MJ6mLMxkyoJwgmuvzB6Wo0FW548KZ6
         HNhgBaO92dCips+3WdwTcqAla6WvtJpcQTUu78+uqD924J2OCudfA4azV7mYEN3fZjlD
         bgB86i8uItUThbxL1T52Zfol/Wy9BIrcGITfThXHIm5Mh+IuHQVb3bpzPMzpZoxCvWyE
         g0JQ8oZayD6EQ/4w8Tq/ZGsUrbeWefrNkYJ78Iu5QfZuZk1cHxcqB4/Sfp5rvTT2rnL2
         cpBzb/pbfntOHHQqyy3yiBqeZ6BJNfil27FbN09MpNZ3WrghCRUeTD4KnpZ327uLe4V8
         Dmmw==
X-Gm-Message-State: AOAM530n+L8qrn1PnyFuPfX22ssupwFuzDIjGu9dX4Hfwtv+KI8plqyo
        Pfk7RdgJt2xy3dAkc2v2kIKvkf9YebCMBFJw
X-Google-Smtp-Source: ABdhPJywTWEkHeB/ezAPrPHuasVqZp1UUdqA+Lida8AD9HD01NAPu8IVT3VSdza4ZHv2UJWpI6mxpg==
X-Received: by 2002:a63:9d84:: with SMTP id i126mr20757638pgd.617.1643725221235;
        Tue, 01 Feb 2022 06:20:21 -0800 (PST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id m7sm9762881pfb.80.2022.02.01.06.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:20:21 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id x11so15508197plg.6;
        Tue, 01 Feb 2022 06:20:20 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr9456510vsb.68.1643724868281;
 Tue, 01 Feb 2022 06:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <YfhM97cVH3+lJKg0@ravnborg.org>
 <Yfj/XGRRDNABsLPm@smile.fi.intel.com> <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com> <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
In-Reply-To: <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 15:14:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
Message-ID: <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Feb 1, 2022 at 2:09 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/1/22 12:38, Geert Uytterhoeven wrote:
> >> Since the current binding has a compatible "ssd1305fb-i2c", we could make the
> >> new one "ssd1305drm-i2c" or better, just "ssd1305-i2c".
> >
> > DT describes hardware, not software policy.
> > If the hardware is the same, the DT bindings should stay the same.
> >
>
> Yes I know that but the thing is that the current binding don't describe
> the hardware correctly. For instance, don't use a backlight DT node as a
> property of the panel and have this "fb" suffix in the compatible strings.
>
> Having said that, my opinion is that we should just keep with the existing
> bindings and make compatible to that even if isn't completely correct.
>
> Since that will ease adoption of the new DRM driver and allow users to use
> it without the need to update their DTBs.

To me it looks like the pwms property is not related to the backlight
at all, and only needed for some variants?

And the actual backlight code seems to be about internal contrast
adjustment?

So if the pwms usage is OK, what other reasons are there to break
DT compatibility? IMHO just the "fb" suffix is not a good reason.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

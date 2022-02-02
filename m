Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D934A6F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiBBKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:55:50 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37644 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiBBKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:55:47 -0500
Received: by mail-ua1-f42.google.com with SMTP id b16so18340588uaq.4;
        Wed, 02 Feb 2022 02:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNMiBPAokm6B+Md/914T5KDvXk5STANjp7/fM4StjiM=;
        b=psqQyd66KjivR5zMfgMI18Df5a1rILS6KVBBpV4GByZnZFFsOva81FMmZP+XQWkJVF
         L4sxBkWhR20qDeYwdPr4r0l18Hn/MUOTs+siUNwFfBIIt32HTeKCIx1NkqZn8HJb2pan
         NL7qnIg8kxTJD4ZHPbH3RNBq+OUwbsdnOZ3zNtEiE6YYX8rYouyxl0Dm31Ogaejq41P/
         NlC7fCDeto0KR2X3QdmKcJ5+lzS8ffhjYLiRvxdkQkp32pWTewihAtbGvdbIr7Foq9Lp
         ekxUrE00nHlOdvh0zG6xSduAI31dzTbnospWm31dqgR9IVawa/UvA3SLImyZ2pDRdNGz
         YD/g==
X-Gm-Message-State: AOAM533D7nqqQbYamww7VVzV0Eq9JzytAwZv7UnfQ7G+NDZjawIbuWe3
        sDCSI2T2Fgnlqgl70YSwhEtNEQdaM+OZAw==
X-Google-Smtp-Source: ABdhPJxiB/AZPpKPFZU60f6kma0yT5m92Rq8JuCfNWQ+PXkvWCzfMnGjQVBZ8rALTiWNxk0RgEBvAg==
X-Received: by 2002:a67:3294:: with SMTP id y142mr11361507vsy.58.1643799346779;
        Wed, 02 Feb 2022 02:55:46 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id r4sm4754300vsk.2.2022.02.02.02.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 02:55:46 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a24so4604012uat.10;
        Wed, 02 Feb 2022 02:55:45 -0800 (PST)
X-Received: by 2002:ab0:6cf9:: with SMTP id l25mr11903238uai.122.1643799345531;
 Wed, 02 Feb 2022 02:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
 <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
 <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
 <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
 <b0788b3d-9c77-0e96-0969-380d21663909@redhat.com> <20220201124208.39c31e59@eldfell>
 <CAMuHMdX_uyEznHy5vYwS8Q=+bBKPddeJa41KTWi4Fwh3tjX+zQ@mail.gmail.com> <20220202111954.6ee9a10c@eldfell>
In-Reply-To: <20220202111954.6ee9a10c@eldfell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 11:55:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvUO3rWfvM0M0EdTNdJ4AabT_cN--T9Kv5ZZx5u1U2=g@mail.gmail.com>
Message-ID: <CAMuHMdVvUO3rWfvM0M0EdTNdJ4AabT_cN--T9Kv5ZZx5u1U2=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Wed, Feb 2, 2022 at 10:20 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Tue, 1 Feb 2022 12:07:07 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Feb 1, 2022 at 11:42 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > On Tue, 1 Feb 2022 10:49:03 +0100
> > > Javier Martinez Canillas <javierm@redhat.com> wrote:
> > > > On 2/1/22 09:38, Daniel Vetter wrote:
> > > > > On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrote:
> > > > >> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > >>> What's the story with the Rn formats?
> > > > >>>
> > > > >>> The comments say "n bpp Red", while this is a monochrome (even
> > > > >>> inverted) display?
> > > > >>
> > > > >> I don't think the color matters that much. "Red" was picked just because it was
> > > > >> an arbitrary color, to make the difference with e.g. C8. Or am I mistaken?
> > > > >
> > > > > The red comes from gl, where with shaders it really doesn't matter
> > > > > what meaning you attach to channels, but really just how many you
> > > > > have. So 2-channel formats are called RxGx, 3-channel RxGxBx,
> > > > > 4-channel RxGxBxAx and single-channel Rx. And we use drm_fourcc for
> > > > > interop in general, hence why these exist.
> > > > >
> > > > > We should probably make a comment that this really isn't a red channel
> > > > > when used for display it's a greyscale/intensity format. Aside from
> > > > > that documentation gap I think reusing Rx formats for
> > > > > greyscale/intensity for display makes perfect sense.
> > > > > -Daniel
> > > >
> > > > To sump up the conversation in the #dri-devel channel, these drivers
> > > > should support the following formats:
> > > >
> > > > 1) Dx (Daniel suggested that for darkness, but inverted mono)
> > >
> > > Did you consider format C1 instead?
> >
> > That would be a 2-color display, which is not necessarily black
> > and white. Cfr. Amiga or Atari bit planes with bpp=1.
> > That's why fbdev has separate visuals for monochrome.
>
> Yes, that is exactly what I was aiming at: to draft a plan for panels
> that have a fixed and arbitrary palette. From the discussions I
> understood that the panel in question here requires somehow reversed
> colors ("inverted mono"), which didn't really sound to be like "normal
> monochrome".
>
> > > I have no idea how this would map to fbdev API though.
> >
> >     #define FB_VISUAL_MONO01                0       /* Monochr.
> > 1=Black 0=White */
> >     #define FB_VISUAL_MONO10                1       /* Monochr.
> > 1=White 0=Black */
> >     #define FB_VISUAL_TRUECOLOR             2       /* True color   */
> >
> > The above is RGB (or grayscale, see below).
> >
> >     #define FB_VISUAL_PSEUDOCOLOR           3       /* Pseudo color
> > (like atari) */
> >
> > Palette
> >
> >     #define FB_VISUAL_DIRECTCOLOR           4       /* Direct color */
> >
> > Usually used as RGB with gamma correction, but the actual hardware
> > is more flexible.
> >
> >     #define FB_VISUAL_STATIC_PSEUDOCOLOR    5       /* Pseudo color readonly */
> >
> > Fixed palette
> >
> > And:
> >
> >     struct fb_var_screeninfo {
> >             ...
> >             __u32 grayscale;                /* 0 = color, 1 = grayscale,    */
>
> DRM has pixel formats, but no visuals so far. Maybe it needs to grow
> the concept of visuals in some form? However, care should be taken to
> not clash with existing colorimetry features. I would hope that the
> colorimetry feature set could be extended to cover the above as well.
> Well, only if there would be any users for it.

Fbdev has separate (orthogonal) settings for
  1. Frame buffer layout (FB_TYPE_*),
  2. Pixel format (depth and fb_bitfields),
  3. Visual.
DRM combines all of the above in a fourcc value.

Nowadays most frame buffer layouts are packed, so using a shadow
frame buffer to support other layouts is very helpful, as it means
applications no longer have to care about legacy frame buffer layouts.

> My silly attempt with Cx formats (e.g. DRM_FORMAT_C8) was a stab in that
> direction, but maybe not flexible enough for the above.
>
> If on the other hand the panel is "grayscale" but with an arbitrary
> color (white, green, orange or other on black), the IRC consensus seems
> to be that one should use Rx formats (e.g. DRM_FORMAT_R8) for it,
> regardless of the actual color. That would convey that the pixel value
> has a monotonic (increasing) mapping to brightness, unlike with
> paletted formats. I agree with this, but wonder how reversed brightness

Agreed, the only thing that matters is a monotonic mapping, and
whether it's increasing or decreasing.

> should be dealt with - or just have the driver invert the pixel values
> before sending them to display?

That's an option. If the data has to be copied anyway, inversion is
a cheap operation. Else I think you need new fourcc types.

> Cx formats with a read-only palette could be used to represent
> "grayscale" and "reversed grayscale" too, but people seem to think that
> is too complicated to analyse and use for KMS userspace.

Yeah, it's complicated, but rather rare. Most desktop hardware
(even from the nineties ;-) does support a programmable palette.
Exceptions are CGA, the C64 (no Linux support yet ;-), and eInk
displays that support e.g. white, black, and red.

If you do want to support it, perhaps introduce Fx (F = fixed)
fourcc types?

> Other #dri-devel IRC mumblings were about maybe adding a DRM pixel
> format for grayscale or intensity or luminance so that one would not
> need to use "red" color channel for something that doesn't look red.
> That is, do not use Cx formats because those produce completely
> arbitrary colors, and do not use Rx formats because the display is not
> redscale. Personally I'd be fine with Rx formats.

Fine, as said above, monotonic mapping is what matters.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

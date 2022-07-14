Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E20574773
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGNInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGNInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:43:11 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D813EA2;
        Thu, 14 Jul 2022 01:43:09 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id o21so725601qkm.10;
        Thu, 14 Jul 2022 01:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxN0KXqSzVzIHaBApKEyHk1NU3/+nmlgLRu8+vYeWQg=;
        b=m4m55LAxVa5lf4zFKLGkrbi8QG1/BYWJW0kr2veik/w2Cq6uHbgcfv3jI57UAwUuU9
         ws9BjL4nXsHbwK49F/NV/LyBH/w9di4+3QKyfievPfOHIAYl32sBsqC54LpZVgzSzG6+
         +qHsZz6r6IgwikzsTBr9Uyn7YcktL8mvaX18H8AJPcLtdzyOm25l2zzyabkUKWw0jdmb
         JNxrwsAIpA08l1nrXWcXVNhdC3zHLcW5+GiC3GMSl6W1S/kk8Adig6MDoK79CHpMAch7
         wdyOuB+u9ZaIs0f+cmL2D/ovfs/dJcP6WnXhRLLW4du262GGEULkAnxgaTHLqXrW40W3
         44kw==
X-Gm-Message-State: AJIora8ZUvDPIjLR1qm7HX5lKeFRXVoJxndg3kDhlzbsvqGvmfE/Hrvu
        pANhj65kwc3+qoAeZ/6UFkYWu035NdIJBQ==
X-Google-Smtp-Source: AGRyM1ve0skPA/T8ThcEcseW2YsoT/zpZLPuegOXZUVPMJtvYPgWJv7g1ObFvsvxE3+UKYdaR5XDVQ==
X-Received: by 2002:a05:620a:254f:b0:6a6:313:3ccc with SMTP id s15-20020a05620a254f00b006a603133cccmr5296830qko.716.1657788188643;
        Thu, 14 Jul 2022 01:43:08 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id bq44-20020a05620a46ac00b006a6edbbca84sm868178qkb.94.2022.07.14.01.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:43:08 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r3so2051035ybr.6;
        Thu, 14 Jul 2022 01:43:08 -0700 (PDT)
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr6988768ybu.365.1657788187837; Thu, 14
 Jul 2022 01:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301107.git.geert@linux-m68k.org> <68923c8a129b6c2a70b570103679a1cf7876bbc2.1657301107.git.geert@linux-m68k.org>
 <ef2aada2-96e4-c2e4-645f-39bc9094e93a@suse.de> <20220711093513.wilv6e6aqcuyg52w@houat>
 <43d75dce-988a-0a95-cb0a-0d0a7c81ca63@suse.de> <20220711114206.sawqdl54ibuxsxp4@houat>
 <CAMuHMdXbFHWWQoryXihVsSrC5ZzHEV-YYR_eLvNmSAw8Y61TQg@mail.gmail.com>
 <20220711120243.v6lwoynqigle2aot@houat> <CAMuHMdXhmf5TudQ6a1PUVV8KXff6JjgMmZOmOWVb2qW6eXF7Ow@mail.gmail.com>
 <20220713093708.jaa3og2fablqr723@houat>
In-Reply-To: <20220713093708.jaa3og2fablqr723@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Jul 2022 10:42:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGmxo6B2EWbygi1ncKe9SBTDvyzPSw1f32P_+TMot36Q@mail.gmail.com>
Message-ID: <CAMuHMdWGmxo6B2EWbygi1ncKe9SBTDvyzPSw1f32P_+TMot36Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/modes: Add support for driver-specific named modes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Jul 13, 2022 at 11:37 AM Maxime Ripard <maxime@cerno.tech> wrote:
> On Mon, Jul 11, 2022 at 02:08:06PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 11, 2022 at 2:02 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Mon, Jul 11, 2022 at 01:59:28PM +0200, Geert Uytterhoeven wrote:
> > > > On Mon, Jul 11, 2022 at 1:42 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > On Mon, Jul 11, 2022 at 01:11:14PM +0200, Thomas Zimmermann wrote:
> > > > > > Am 11.07.22 um 11:35 schrieb Maxime Ripard:
> > > > > > > On Mon, Jul 11, 2022 at 11:03:38AM +0200, Thomas Zimmermann wrote:
> > > > > > > > Am 08.07.22 um 20:21 schrieb Geert Uytterhoeven:
> > > > > > > > > The mode parsing code recognizes named modes only if they are explicitly
> > > > > > > > > listed in the internal whitelist, which is currently limited to "NTSC"
> > > > > > > > > and "PAL".
> > > > > > > > >
> > > > > > > > > Provide a mechanism for drivers to override this list to support custom
> > > > > > > > > mode names.
> > > > > > > > >
> > > > > > > > > Ideally, this list should just come from the driver's actual list of
> > > > > > > > > modes, but connector->probed_modes is not yet populated at the time of
> > > > > > > > > parsing.
> > > > > > > >
> > > > > > > > I've looked for code that uses these names, couldn't find any. How is this
> > > > > > > > being used in practice? For example, if I say "PAL" on the command line, is
> > > > > > > > there DRM code that fills in the PAL mode parameters?
> > > > > > >
> > > > > > > We have some code to deal with this in sun4i:
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/sun4i_tv.c#L292
> > > > > > >
> > > > > > > It's a bit off topic, but for TV standards, I'm still not sure what the
> > > > > > > best course of action is. There's several interactions that make this a
> > > > > > > bit troublesome:
> > > > > > >
> > > > > > >    * Some TV standards differ by their mode (ie, PAL vs NSTC), but some
> > > > > > >      other differ by parameters that are not part of drm_display_mode
> > > > > > >      (NTSC vs NSTC-J where the only difference is the black and blanking
> > > > > > >      signal levels for example).
> > > > > > >
> > > > > > >    * The mode names allow to provide a fairly convenient way to add that
> > > > > > >      extra information, but the userspace is free to create its own mode
> > > > > > >      and might omit the mode name entirely.
> > > > > > >
> > > > > > > So in the code above, if the name has been preserved we match by name,
> > > > > > > but we fall back to matching by mode if it hasn't been, which in this
> > > > > > > case means that we have no way to differentiate between NTSC, NTSC-J,
> > > > > > > PAL-M in this case.
> > > > > > >
> > > > > > > We have some patches downstream for the RaspberryPi that has the TV
> > > > > > > standard as a property. There's a few extra logic required for the
> > > > > > > userspace (like setting the PAL property, with the NTSC mode) so I'm not
> > > > > > > sure it's preferable.
> > > > > > >
> > > > > > > Or we could do something like a property to try that standard, and
> > > > > > > another that reports the one we actually chose.
> > > > > > >
> > > > > > > > And another question I have is whether this whitelist belongs into the
> > > > > > > > driver at all. Standard modes exist independent from drivers or hardware.
> > > > > > > > Shouldn't there simply be a global list of all possible mode names? Drivers
> > > > > > > > would filter out the unsupported modes anyway.
> > > > > > >
> > > > > > > We should totally do something like that, yeah
> > > > > >
> > > > > > That sun code already looks like sometihng the DRM core/helpers should be
> > > > > > doing. And if we want to support named modes well, there's a long list of
> > > > > > modes in Wikipedia.
> > > > > >
> > > > > > https://en.wikipedia.org/wiki/Video_Graphics_Array#/media/File:Vector_Video_Standards2.svg
> > > > >
> > > > > Yeah, and NTSC is missing :)
> > > >
> > > > And that diagram is about the "digital" variant of PAL.
> > > > If you go the analog route, the only fixed parts are vfreq/hfreq,
> > > > number of lines, and synchronization. Other parameters like overscan
> > > > can vary.  The actual dot clock can vary wildly: while there is an
> > > > upper limit due to bandwidth limitations, you can come up with an
> > > > almost infinite number of video modes that can be called PAL, which
> > > > is one of the reasons why I don't want hardware-specific variants to
> > > > end up in a global video mode database.
> > >
> > > Do you have an example of what that would look like?
> >
> > You mean a PAL mode that does not use 768x576?
>
> I meant what the almost infinite number of video modes that can be
> called PAL and would have to be defined in drivers
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/video/fbdev/amifb.c#n834
>
> But that works :)
>
> I don't see what really is troublesome if we go with the mode + property
> setup here.
>
> We can deal easily with the interlaced vs non-interlaced variants
> already with DRM_MODE_FLAG_INTERLACE, and the ff variants can be dealt
> with DRM_MODE_FLAG_DBLCLK.

Sure. Interlace and doublescan are the easy parts.
(actually "ff" is not PAL, but a 31 kHz mode with the same resolution of
 the corresponding PAL mode).


> We still need something to differentiate between, say, PAL-M and NTSC-J
> where the differences are between things not exposed by the mode itself
> (black and blanking levels differ from NSTC for NTSC-J, and the color
> carrier frequency is PAL's for PAL-M)
>
> Am I missing something?
>
> > (TAG_HIRES is replaced by the actual dot clock at runtime, as it
> >  depends on the crystal present on the mainboard).
>
> If we have the crystal frequency in the kernel somehow, we could filter
> them out from the driver (or fill them in) depending on that frequency.
>
> I still think the mode + property is the way to go, possibly with some
> generic component that would take the mode name from the command line
> and create that initial state depending on the value for backward
> compatibility.
>
> What do you think?

The difficulty is the wild variety of resolutions supported by devices
that can be connected to a standard (legacy) analog PAL TV or monitor,
and thus are all called "PAL".  These range from 160x228 (Atari 2600)
over 176x184 (VIC-20), 256x192 (e.g. ZX Spectrum), 320x200 (Atari ST),
640x256/512i (Amiga) (I'm not saying we should support old 8-bit
machines, though ;-)
A longer list can be found at [1].  Most of the resolutions lower
than 0.3 Mpixels can be shown on a TV.

IMHO, only the modes backed by digital standards of PAL (and NTSC [2])
should be in a common mode database.  The rest is to be detained
to the individual drivers, as they are highly driver-specific, and
unlikely to be used with more than one driver or hardware platform.

[1] https://en.wikipedia.org/wiki/List_of_common_resolutions
[2] https://en.wikipedia.org/wiki/List_of_common_resolutions#Digital_Standards

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

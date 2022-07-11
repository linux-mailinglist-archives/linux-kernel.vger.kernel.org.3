Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300EB570170
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiGKL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGKL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:59:44 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AA357ED;
        Mon, 11 Jul 2022 04:59:42 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id w1so6817494qtv.9;
        Mon, 11 Jul 2022 04:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/I/U0YnC1LrEaVGVv4SvhKsv3VnfbWrBQRKUKtDAa0I=;
        b=WrODlGa+p7bcYgF+UU9BkJcZBbo8LvlVSFVAoaFxL3HIcTvoqYlo8jBr/yqgUNqa5u
         Q0vYWGfYrVTjHBh4duJtndm7H9TzAlbxQyFeTVleWPLjvDUIMEpHGAwK3xMGavdGFsts
         dmkFtcj5aQn2TQDfdSEJrmaOc8Ri1wCR0auEBPTH6570bTYxkjscPCWYt4R+38k6KPDJ
         rzE2WxF5z5yEGwZKm4ZB5To4WXtCAp+QyQWaRZgnNi4oXqhwX7IjBrvDNW+sDPTJIhue
         dFXRjt8uynQ+/mj8Qka1nJ5EZzZIzS5UvsvG8shbK28v5rsmTdW63ebT46YyQbuwQxS+
         aUTQ==
X-Gm-Message-State: AJIora9Vc1K5Gx6dRHM73OX+2UsVt8c10AxRUdncxlCAjfQsQAlsOGW5
        /xf4vibIuhCa+Axiv4Wymig+Ir11dyfy4Q==
X-Google-Smtp-Source: AGRyM1t/ISXoG928fExbFgZyMfFgyDzogqHObmVr7z+FU7x34yLfZVrqBnKDL3DmAIOnKRbuurtQSg==
X-Received: by 2002:ac8:5dc8:0:b0:31d:3d0b:29ec with SMTP id e8-20020ac85dc8000000b0031d3d0b29ecmr13334430qtx.242.1657540781164;
        Mon, 11 Jul 2022 04:59:41 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id m6-20020ac807c6000000b00315a5fa4bf6sm5184729qth.7.2022.07.11.04.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:59:40 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31d85f82f0bso10246137b3.7;
        Mon, 11 Jul 2022 04:59:40 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr18708130ywj.316.1657540779907; Mon, 11
 Jul 2022 04:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301107.git.geert@linux-m68k.org> <68923c8a129b6c2a70b570103679a1cf7876bbc2.1657301107.git.geert@linux-m68k.org>
 <ef2aada2-96e4-c2e4-645f-39bc9094e93a@suse.de> <20220711093513.wilv6e6aqcuyg52w@houat>
 <43d75dce-988a-0a95-cb0a-0d0a7c81ca63@suse.de> <20220711114206.sawqdl54ibuxsxp4@houat>
In-Reply-To: <20220711114206.sawqdl54ibuxsxp4@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jul 2022 13:59:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbFHWWQoryXihVsSrC5ZzHEV-YYR_eLvNmSAw8Y61TQg@mail.gmail.com>
Message-ID: <CAMuHMdXbFHWWQoryXihVsSrC5ZzHEV-YYR_eLvNmSAw8Y61TQg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, Jul 11, 2022 at 1:42 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Mon, Jul 11, 2022 at 01:11:14PM +0200, Thomas Zimmermann wrote:
> > Am 11.07.22 um 11:35 schrieb Maxime Ripard:
> > > On Mon, Jul 11, 2022 at 11:03:38AM +0200, Thomas Zimmermann wrote:
> > > > Am 08.07.22 um 20:21 schrieb Geert Uytterhoeven:
> > > > > The mode parsing code recognizes named modes only if they are explicitly
> > > > > listed in the internal whitelist, which is currently limited to "NTSC"
> > > > > and "PAL".
> > > > >
> > > > > Provide a mechanism for drivers to override this list to support custom
> > > > > mode names.
> > > > >
> > > > > Ideally, this list should just come from the driver's actual list of
> > > > > modes, but connector->probed_modes is not yet populated at the time of
> > > > > parsing.
> > > >
> > > > I've looked for code that uses these names, couldn't find any. How is this
> > > > being used in practice? For example, if I say "PAL" on the command line, is
> > > > there DRM code that fills in the PAL mode parameters?
> > >
> > > We have some code to deal with this in sun4i:
> > > https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/sun4i_tv.c#L292
> > >
> > > It's a bit off topic, but for TV standards, I'm still not sure what the
> > > best course of action is. There's several interactions that make this a
> > > bit troublesome:
> > >
> > >    * Some TV standards differ by their mode (ie, PAL vs NSTC), but some
> > >      other differ by parameters that are not part of drm_display_mode
> > >      (NTSC vs NSTC-J where the only difference is the black and blanking
> > >      signal levels for example).
> > >
> > >    * The mode names allow to provide a fairly convenient way to add that
> > >      extra information, but the userspace is free to create its own mode
> > >      and might omit the mode name entirely.
> > >
> > > So in the code above, if the name has been preserved we match by name,
> > > but we fall back to matching by mode if it hasn't been, which in this
> > > case means that we have no way to differentiate between NTSC, NTSC-J,
> > > PAL-M in this case.
> > >
> > > We have some patches downstream for the RaspberryPi that has the TV
> > > standard as a property. There's a few extra logic required for the
> > > userspace (like setting the PAL property, with the NTSC mode) so I'm not
> > > sure it's preferable.
> > >
> > > Or we could do something like a property to try that standard, and
> > > another that reports the one we actually chose.
> > >
> > > > And another question I have is whether this whitelist belongs into the
> > > > driver at all. Standard modes exist independent from drivers or hardware.
> > > > Shouldn't there simply be a global list of all possible mode names? Drivers
> > > > would filter out the unsupported modes anyway.
> > >
> > > We should totally do something like that, yeah
> >
> > That sun code already looks like sometihng the DRM core/helpers should be
> > doing. And if we want to support named modes well, there's a long list of
> > modes in Wikipedia.
> >
> > https://en.wikipedia.org/wiki/Video_Graphics_Array#/media/File:Vector_Video_Standards2.svg
>
> Yeah, and NTSC is missing :)

And that diagram is about the "digital" variant of PAL.
If you go the analog route, the only fixed parts are vfreq/hfreq,
number of lines, and synchronization. Other parameters like overscan
can vary.  The actual dot clock can vary wildly: while there is an
upper limit due to bandwidth limitations, you can come up with an
almost infinite number of video modes that can be called PAL, which
is one of the reasons why I don't want hardware-specific variants to
end up in a global video mode database.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

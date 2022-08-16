Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F14595EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiHPPC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiHPPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:02:37 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D845108D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:00:52 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id y18so8293547qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5LUM7nzor1/XqC5vXK/cNLgsMpFS8BfigyHBrmKtMuQ=;
        b=MXCOR8D7/S0L5R9wqYsXNcrYtAdlgnay6V1TOWTBTqS6YlvA/dDZj/c9RRcN5mPifM
         1G5AJsX70AKWPWum7ows9CdHSLIw7ZcRSYyZnR8MuVEFUdHjvnbK9O7oOjBY/hfmJV8B
         hilQUM1IFjwV/jEkJkOR2eMAWGidCsRnLMUbeYnocOAqC6lX/ZIDWeoytcaWGmctpfj3
         Lqof8H42BOYwveB1ylfJvoVFde3bju22lDriuO1Dh396gphyxR4JAMqgUf8X9jOsm9u3
         FGEkifsb+nhlrvCWGuGV/SILGrF/fyG5MBUK9+Jk5T3ljbR0JINjZ+5PTpOI7oLv8oKo
         3P/Q==
X-Gm-Message-State: ACgBeo026Y1j0Gy+u8xHkSF4npdIg/K32rzhvEAScyWDNdWV1Gta/iT5
        7kwVcoilt99yfmU0qgWvajDZuyxdoLloIA==
X-Google-Smtp-Source: AA6agR7aktzKP+flTWZCoWWMuXdwkjrsVo1gaOQvwRR8w+qWoBA0C+usnUdFvxJ91J1yQp5xmsInHA==
X-Received: by 2002:ac8:5c52:0:b0:343:3dc7:db0d with SMTP id j18-20020ac85c52000000b003433dc7db0dmr18798925qtj.179.1660662050964;
        Tue, 16 Aug 2022 08:00:50 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id r23-20020ae9d617000000b006af1f0af045sm12028339qkk.107.2022.08.16.08.00.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 08:00:50 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-32a09b909f6so158431067b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:00:50 -0700 (PDT)
X-Received: by 2002:a5b:bcd:0:b0:68f:b4c0:7eca with SMTP id
 c13-20020a5b0bcd000000b0068fb4c07ecamr130640ybr.202.1660662049765; Tue, 16
 Aug 2022 08:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
 <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com> <20220816132636.3tmwqmrox64pu3lt@houat>
In-Reply-To: <20220816132636.3tmwqmrox64pu3lt@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Aug 2022 17:00:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
Message-ID: <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/35] drm/modes: Introduce 480i and 576i modes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>
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

On Tue, Aug 16, 2022 at 3:26 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Fri, Aug 12, 2022 at 03:18:58PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jul 29, 2022 at 6:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > Multiple drivers (meson, vc4) define the analog TV 525-lines and 625-lines
> > > modes in the drivers.
> >
> > Nit: strictly speaking these are not analog modes, but the digital
> > variants (ITU-R BT.656 and DVD-Video D1) of NTSC and PAL, using a
> > 13.5 MHz sampling frequency for pixels.
> >
> > In analog modes, the only discrete values are the number of lines, and
> > the frame/field rate (fixing the horizontal sync rate when combined).
> >
> > The number of (in)visible pixels per line depends on the available
> > bandwidth.  In a digital variant (which is anything generated by a
> > digital computer system), the latter depends on the pixel clock, which
> > can wildly differ from the 13.5 MHz used in the BT.656 standard. (e.g.
> > Amiga uses 7.09/14.19/28.38 MHz (PAL) or 7.16/14.32/28.64 MHz (NTSC)).
> >
> > So I think we probably need some way to generate a PAL/NTSC-compatible
> > mode based not only on resolution, but also on pixel clock.
>
> This would also fix the comments made by Jani and Thomas, so I quite
> like the idea of it.
>
> I'm struggling a bit to find how would could implement this though.
>
> From what you were saying, I guess the prototype would be something like
>
> struct drm_display_mode *drm_create_analog_mode(unsigned int pixel_clock,
>                                                 unsigned int lines,
>                                                 unsigned int frame_rate)
>
> But I have zero idea on what the implementation would be. Do you have
> some resources for this you could point me to?

Horizontally, I think you should calculate left/right margins and
hsync length to yield timings that match those for the BT.656 PAL/NTSC
modes.  I.e. when a 640x512 mode with a pixel clock of 14 MHz is
requested, you want to calculate left', right', and hslen' for

| <---- left' ---> | <- 640 pixels -> | <---- right' ---> | <--- hslen' --> |
                        @ 14 MHz

so they match the timings for left, right, and hslen for

| <--- left ---> | <--- 720 pixels ---> | <--- right ---> | <--- hslen ---> |
                        @ 13.5 MHz

As 640 pixels @ 14 MHz are less wide than 720 pixels @ 13.5 MHz,
you want to make sure to align the center of the visible part.

Vertically, it's simpler, as the number of lines is discrete.
You do have to take into account interlace and doublescan, and
progressive modes with 262/312 lines.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

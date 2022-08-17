Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB759708A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiHQODR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Aug 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiHQOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:02:31 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7C98C81
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:02:03 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id a4so10386316qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9vGZaeYeF3C4CiTE5MgNIzB+zcyQS3be59eUDCUL+Fc=;
        b=TotBbNBzTNxPpCDzVL6CxahQoB/4IFpa5epyCV4d2CHJBXSLL/1INwAdTZZecxLe4T
         Fgr7OOJo17sWNf64na6EzW5Nm2jTz2FZ9oietDG2DhJ03rEI4PrVKaDnYGCCi2TAcOcw
         TGc7g8Un3Oz7KGALL8QcDaRjpqBkta0T2tiBAdPHwi+aYii3jt4dVeuClSQy8Ap7nigr
         fUX3wAKa9fchmhWlujUgGaFkUqs0+/EezWMlsOT+1Mu1hjNxxS/3pdqnGEORbgrRHCqC
         MKG54uq38adSu1tOslpRTTG4EOzlNZTkRk66Ykj+CxvmcTfIkn+ddDe9N9oC8jRZyKmO
         kt6g==
X-Gm-Message-State: ACgBeo17KwtmlHGYSwS9JIUdK5Bhp6HblocGmBwR2tpDoF3KPIsSdhiH
        /yQdEB9QJHpX5YtpotmICwowt51v+BeE6w==
X-Google-Smtp-Source: AA6agR67GDkykqb4JaxiyAEnNWSBcwVFD1TzI/d0j6GPjAK1Uc3VpWbkwQ1w3bWnhrZN0hpr+HI31g==
X-Received: by 2002:a05:622a:174f:b0:344:552b:c6a9 with SMTP id l15-20020a05622a174f00b00344552bc6a9mr15955926qtk.13.1660744922409;
        Wed, 17 Aug 2022 07:02:02 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i12-20020a05622a08cc00b003434f7483a1sm12399381qte.32.2022.08.17.07.02.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:02:01 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-32fd97c199fso208568047b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:02:00 -0700 (PDT)
X-Received: by 2002:a0d:eb45:0:b0:333:f813:6c79 with SMTP id
 u66-20020a0deb45000000b00333f8136c79mr5998789ywe.384.1660744920203; Wed, 17
 Aug 2022 07:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
 <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com>
 <20220816132636.3tmwqmrox64pu3lt@houat> <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
 <20220817075351.4xpsqdngjgtiqvob@houat> <CAMuHMdUusnhYodWGCxJBu-1Hd2KW-xdT8jxE_iVdQjDo8b3Y5Q@mail.gmail.com>
 <20220817131454.qcuywcuc4ts4hswm@houat>
In-Reply-To: <20220817131454.qcuywcuc4ts4hswm@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 16:01:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVPEgnnsY-4uuf=FDJ0YxWpch-0kZWFT_TZfcDvXLtwWQ@mail.gmail.com>
Message-ID: <CAMuHMdVPEgnnsY-4uuf=FDJ0YxWpch-0kZWFT_TZfcDvXLtwWQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Aug 17, 2022 at 3:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Wed, Aug 17, 2022 at 10:51:55AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Aug 17, 2022 at 9:54 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Tue, Aug 16, 2022 at 05:00:38PM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Aug 16, 2022 at 3:26 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > On Fri, Aug 12, 2022 at 03:18:58PM +0200, Geert Uytterhoeven wrote:
> > > > > > On Fri, Jul 29, 2022 at 6:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > Multiple drivers (meson, vc4) define the analog TV 525-lines and 625-lines
> > > > > > > modes in the drivers.
> > > > > >
> > > > > > Nit: strictly speaking these are not analog modes, but the digital
> > > > > > variants (ITU-R BT.656 and DVD-Video D1) of NTSC and PAL, using a
> > > > > > 13.5 MHz sampling frequency for pixels.
> > > > > >
> > > > > > In analog modes, the only discrete values are the number of lines, and
> > > > > > the frame/field rate (fixing the horizontal sync rate when combined).
> > > > > >
> > > > > > The number of (in)visible pixels per line depends on the available
> > > > > > bandwidth.  In a digital variant (which is anything generated by a
> > > > > > digital computer system), the latter depends on the pixel clock, which
> > > > > > can wildly differ from the 13.5 MHz used in the BT.656 standard. (e.g.
> > > > > > Amiga uses 7.09/14.19/28.38 MHz (PAL) or 7.16/14.32/28.64 MHz (NTSC)).
> > > > > >
> > > > > > So I think we probably need some way to generate a PAL/NTSC-compatible
> > > > > > mode based not only on resolution, but also on pixel clock.
> > > > >
> > > > > This would also fix the comments made by Jani and Thomas, so I quite
> > > > > like the idea of it.
> > > > >
> > > > > I'm struggling a bit to find how would could implement this though.
> > > > >
> > > > > From what you were saying, I guess the prototype would be something like
> > > > >
> > > > > struct drm_display_mode *drm_create_analog_mode(unsigned int pixel_clock,
> > > > >                                                 unsigned int lines,
> > > > >                                                 unsigned int frame_rate)
> > > > >
> > > > > But I have zero idea on what the implementation would be. Do you have
> > > > > some resources for this you could point me to?
> > > >
> > > > Horizontally, I think you should calculate left/right margins and
> > > > hsync length to yield timings that match those for the BT.656 PAL/NTSC
> > > > modes.  I.e. when a 640x512 mode with a pixel clock of 14 MHz is
> > > > requested, you want to calculate left', right', and hslen' for
> > > >
> > > > | <---- left' ---> | <- 640 pixels -> | <---- right' ---> | <--- hslen' --> |
> > > >                         @ 14 MHz
> > > >
> > > > so they match the timings for left, right, and hslen for
> > > >
> > > > | <--- left ---> | <--- 720 pixels ---> | <--- right ---> | <--- hslen ---> |
> > > >                         @ 13.5 MHz
> > > >
> > > > As 640 pixels @ 14 MHz are less wide than 720 pixels @ 13.5 MHz,
> > > > you want to make sure to align the center of the visible part.
> > >
> > > So I guess in that example if we want to center it, left == right and
> > > left' == right'? What about the sync length?
> >
> > No, left and right are asymmetrical, cfr. front and back porch in
> > https://en.wikipedia.org/wiki/PAL#PAL_signal_details
> > I.e. if the pixel part is reduced, both the left and right margins
> > should be increased by the same amount.
> >
> > From the table linked above, hslen should be ca. 4.7µs (fixed).
>
> each pixel taking 1 / pixel_clock seconds (assuming pixel_clock is in
> Hz), and thus hslen (in pixels) = 4.7 * 10 ^ -6 * pixel_clk, right?

Exactly.

> > > > Vertically, it's simpler, as the number of lines is discrete.
> > > > You do have to take into account interlace and doublescan, and
> > > > progressive modes with 262/312 lines.
> > >
> > > So we only have to deal with 525 and 625 lines total (without taking
> > > interlace and doublescan into account), right?
> >
> > Yes.
> >
> > > I guess we still have the same question, we probably want to center it,
> > > so top == bottom, but what about the vsync length?
> >
> > Unfortunately that table does not mention top and bottom margins.
> > But according to drivers/video/fbdev/amifb.c (see the "Broadcast
> > video timings" comment block and the definitions of the "ntsc-lace"
> > and "pal-lace" video modes), they are asymmetrical, too.
> >
> > Vsync length is 0.576ms, so that's 9 scan lines (I guess I didn't
> > have that info when I wrote amifb, as I used 4 lines there).
>
> Thanks, that's some great info already.
>
> It's mentioned though that the settings for NTSC are "straightforward",
> but it's definitely not for me :)

As in NTSC just uses different pixel clock and horizontal/vertical sync
rate values...

> I've looked around and it looks like the entire blanking area is
> supposed to be 40 pixels in interlaced, but I couldn't find anywhere how

625 lines - 575[*] visible lines = 50 lines.

[*] BT.656 uses 576 visible lines as that's a multiple of 2, for splitting
     a frame in two fields of equal size.

"visible" is relative, as it includes the overscan region.
Some PAL monitors used with computers had knobs to control width/height
and position of the screen, so you could make use of most or all of
the overscan region, but on a real TV you're limited to ca. 640x512 (on
PAL)  which is what an Amiga used by default (with a 14 MHz pixclock).
> it's supposed to be split between the upper and lower margins and the
> sync period.

"Field Synchronization of PAL System" on http://martin.hinner.info/vga/pal.html
shows the split.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

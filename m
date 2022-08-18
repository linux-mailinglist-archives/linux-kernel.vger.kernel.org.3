Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D5598387
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbiHRM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbiHRM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:58:14 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30EF64
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:58:12 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id g16so990635qkl.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JREs+R+hOdRL2M18w+Jk20r5RGbAGO+48abMsau2ww8=;
        b=XudvdfXtPoxRK++fiykD4IW0KRzLqHGAuPOBIitZfilOAtB93RtnE/0DLxdikqRKRF
         a/MRAgITuR13Iig/d0ExrYbrkEEST27DeJdl/kafsCHckQ0jHyRM9ezKhhU4fjYdyZ7s
         +h/cK3E4fzMOYr94PtYYhtOsftkMD/H2sy0r6hOAgKqjoE5NC+lJWv1V21IUCLYZZSIQ
         I3/KyHh8qCywErGXWQiPE1JNopzSUPH4Yg2dMHXsePJYYZyJJqU+YLrP9MFHKagdWy2d
         j5M+ruZZy7gKbs6mIO/c3WW//pq2ORmDPn7r1NC7KMGI4hMyzSG2sSelr1BFUP6C8Ykj
         EvuA==
X-Gm-Message-State: ACgBeo0ye1q+lVu7AlgmfJMK7vjgvUZ/ud/wGTi70tI2Q3ZJcAeDUqFz
        7pcHOj0xFpHbzIljslaPeuEqUsIS3QRsTQ==
X-Google-Smtp-Source: AA6agR7IMW/7sU7kj7lkqXZ4EXJAo4JGxYN5OLRms7h1DkEQq0lMwFetFp+2eFU9AEbWVOmTgGHmLw==
X-Received: by 2002:ae9:e906:0:b0:6b5:f0ec:ed92 with SMTP id x6-20020ae9e906000000b006b5f0eced92mr1877561qkf.59.1660827491433;
        Thu, 18 Aug 2022 05:58:11 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a2a5600b006b945519488sm1506461qkp.88.2022.08.18.05.58.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 05:58:09 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-32a17d3bba2so38337397b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:58:08 -0700 (PDT)
X-Received: by 2002:a25:cf83:0:b0:692:78ad:f44c with SMTP id
 f125-20020a25cf83000000b0069278adf44cmr2546178ybg.604.1660827488283; Thu, 18
 Aug 2022 05:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
 <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com>
 <20220816132636.3tmwqmrox64pu3lt@houat> <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
 <20220817075351.4xpsqdngjgtiqvob@houat> <CAMuHMdUusnhYodWGCxJBu-1Hd2KW-xdT8jxE_iVdQjDo8b3Y5Q@mail.gmail.com>
 <20220817131454.qcuywcuc4ts4hswm@houat> <CAMuHMdVPEgnnsY-4uuf=FDJ0YxWpch-0kZWFT_TZfcDvXLtwWQ@mail.gmail.com>
 <20220818123934.eim2bfrgbxsmviqx@houat>
In-Reply-To: <20220818123934.eim2bfrgbxsmviqx@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 14:57:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXbHkrBZgsmUnU=q52+q7UZZNO3tgQW7Men+msQ1JDwQ@mail.gmail.com>
Message-ID: <CAMuHMdWXbHkrBZgsmUnU=q52+q7UZZNO3tgQW7Men+msQ1JDwQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Aug 18, 2022 at 2:39 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Wed, Aug 17, 2022 at 04:01:48PM +0200, Geert Uytterhoeven wrote:
> > > I've looked around and it looks like the entire blanking area is
> > > supposed to be 40 pixels in interlaced, but I couldn't find anywhere how
> >
> > 625 lines - 575[*] visible lines = 50 lines.
> >
> > [*] BT.656 uses 576 visible lines as that's a multiple of 2, for splitting
> >      a frame in two fields of equal size.
> >
> > "visible" is relative, as it includes the overscan region.
> > Some PAL monitors used with computers had knobs to control width/height
> > and position of the screen, so you could make use of most or all of
> > the overscan region
>
> It brings back some memories :)
>
> > but on a real TV you're limited to ca. 640x512 (on PAL) which is what
> > an Amiga used by default (with a 14 MHz pixclock).
>
> > > it's supposed to be split between the upper and lower margins and the
> > > sync period.
> >
> > "Field Synchronization of PAL System" on
> > http://martin.hinner.info/vga/pal.html shows the split.
>
> Thanks, that's excellent as well.
>
> I'm mostly done with a function that creates a PAL mode, but I still
> have one question.
>
> If I understand well, the blanking period is made up (interlace) of 16
> pulses for the first field, 14 for the second, each pulse taking half a
> line. That amount to 30 pulses, so 15 lines.
>
> I first assumed that the pre-equalizing pulses would be the back porch,
> the long sync pulses the vsync, and the post-equalizing pulses the front
> porch. But... we're still missing 35 lines to amount to 625 lines, that
> seems to be counted in the field itself (305 lines == (575 + 35) / 2)
>
> So I guess my assumption was wrong to begin with.

The back porch is the number of lines between the last "visible" line
and the start of the synchronization pulse, i.e. "l" in the "Field
Synchronization of PAL System" drawing.
Virtual sync length is "m".
The front porch is the number of lines between the end of
the synchronization pulse, and the first "visible" line, i.e.
"j - l - m" (I think you used "n", thus missing lines 6-23 and 319-335).

> You seem to have used a fixed vsync in amifb to 4 lines, and I don't

Actually "m" is 2.5 lines in the first field, and 3 lines in the second field,
so "4" is not that much off of 2.5 + 3.

> understand how you come up with the upper and lower margins (or rather,
> how they are linked to what's described in that page)

These margins probably came from the Amiga hardware reference manual,
for the default 640x512 (PAL) and 640x400 (NTSC) modes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

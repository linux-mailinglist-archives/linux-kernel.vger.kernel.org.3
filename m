Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B8598846
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbiHRQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbiHRQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:04:47 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF0BBA4F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:04:46 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id s11so1446652qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Bxc+m3Zk+4Bct+cVi+3Jt/UsQ5UzvU/3z9/2O8qvP0c=;
        b=NDP7RGpk1QLeu8yfSDkPlwC55vlE+Sf1T2fM+g2JVWNLJLo4UNCMtEzXZ0IhQYu54+
         1G4ORX4WVVbaAbAE/0D73BYqmkUjG7JZqU0fzj04OoorZw0PRkuX/BeZwEibh7znkIoy
         LgWKC4eCOpMSfGlvOFCU27dKkm92UtArH608iNEx/jJyOtAv2C3KNxGzGb7nm7qTxCl5
         2VZ2jARm6YIwi+FjNb72XBJQDZ5ecRV36vEEqODATK5/QeKfugu+7XI8RxvbmjvVlOtI
         Yez5XO/h/Pyw58MCI4gyGdZU+O6zCRn0gbZiXzrw+iQitCRwncnaYdMisJ9QGVbjNbx7
         bM5A==
X-Gm-Message-State: ACgBeo1jA8LypUZqpGOUJqTvhHc8yMcHIeI2iJ/9ANxj+fmsMFYMbTXy
        +D+cvYiR3EEL8kl5wMzVJRXEj4Kp3lMuJw==
X-Google-Smtp-Source: AA6agR5RBBI2k89E7DV/DVJ8ttFSZmbUvQTm1bl/+bCFl5iZf+MVS8TAHN1UfKZx8HYO/cOO+8WHsw==
X-Received: by 2002:a05:622a:254:b0:343:55c0:1d84 with SMTP id c20-20020a05622a025400b0034355c01d84mr3241330qtx.225.1660838685446;
        Thu, 18 Aug 2022 09:04:45 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a400500b006bbb07ebd83sm1968449qko.108.2022.08.18.09.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 09:04:45 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-333a4a5d495so52978197b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:04:45 -0700 (PDT)
X-Received: by 2002:a25:250b:0:b0:68f:425b:3ee0 with SMTP id
 l11-20020a25250b000000b0068f425b3ee0mr3505302ybl.89.1660838207734; Thu, 18
 Aug 2022 08:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220816132636.3tmwqmrox64pu3lt@houat> <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
 <20220817075351.4xpsqdngjgtiqvob@houat> <CAMuHMdUusnhYodWGCxJBu-1Hd2KW-xdT8jxE_iVdQjDo8b3Y5Q@mail.gmail.com>
 <20220817131454.qcuywcuc4ts4hswm@houat> <CAMuHMdVPEgnnsY-4uuf=FDJ0YxWpch-0kZWFT_TZfcDvXLtwWQ@mail.gmail.com>
 <20220818123934.eim2bfrgbxsmviqx@houat> <CAMuHMdWXbHkrBZgsmUnU=q52+q7UZZNO3tgQW7Men+msQ1JDwQ@mail.gmail.com>
 <20220818134200.cr22bftmjn226ehn@houat> <CAMuHMdX6dyQaB34oeXwiCa2rDkxks0qNh=ekqh7Wd2kSNED9TA@mail.gmail.com>
 <20220818154641.ouvrar5s74qu74zn@houat>
In-Reply-To: <20220818154641.ouvrar5s74qu74zn@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 17:56:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUjE0mwu8z5AksW4h1OwzDCQ5h1ZoCWDi+rC4p2Pu5O4g@mail.gmail.com>
Message-ID: <CAMuHMdUjE0mwu8z5AksW4h1OwzDCQ5h1ZoCWDi+rC4p2Pu5O4g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Aug 18, 2022 at 5:46 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Thu, Aug 18, 2022 at 05:34:30PM +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 18, 2022 at 3:42 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > I started adding more sanity checks to my code, and I just realised I
> > > don't seem to be able to reach 720 pixels over a single line though. If
> > > I understood it properly, and according to [1] the active part of a line
> > > is supposed to be 51.95us, and the blanking period taking 12.05us. [2]
> > > in the timing section has pretty much the same numbers, so it looks
> > > sane.
> > >
> > > At 13.5Mhz, a pixel is going to take roughly 74ns, and 51950 / 74 = 702
> > > pixels
> > >
> > > It seems we can go push it to 52350 ns, but that still gives us only 706
> > > pixels.
> > >
> > > Similarly, if I just choose to ignore that limit and just take the
> > > active time I need, 720 * 74 = 53280ns
> > >
> > > That leaves us 10720ns for the blanking period, and that's not enough to
> > > fit even the minimum of the front porch, hsync and back porch (1.55 +
> > > 4.5 + 5.5 = 11.55us).
> > >
> > > Are those constraints merely recommendations, or am I missing something?
> >
> > You are missing that the parts near the borders of the full image are
> > part of the overscan range, and may or may not be visible, depending
> > on your actual display.
> > The full 768x576 image size from BT.656 is not visible on a typical PAL display,
> > and is more of an "absolute maximum rating", guaranteed to cover more
> > than analog PAL.
>
> So the overscan range is not part of the active area, unlike what HDMI
> is doing for example?

Indeed. DVI-D and HDMI etc. are pure digital (let's ignore they are a
digitized variant of old analog VGA ;-), hence there is a one-to-one
match between pixels in the image and pixels on the screen (ignoring
scaling).  But even when using an analog VGA input on a modern
digital display, you have controls to e.g. move the image.

> Is there some minimal timings available somewhere to fit those absolute
> maximum ratings?

I guess they can be found on the Internet...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

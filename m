Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A628596A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiHQHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:31:34 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0BF6CF70
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:31:33 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id n21so9823379qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MoCGxpdBSZqOnL0zHKYLDEdga6g996l84p2nV9SRtCY=;
        b=4OefYXc0pGXjpNAIsgTmrO+8UR6AN9QnwnRrZepETrT9jI9ofXD2wzAqJe6l+ssJSL
         eqXw7Eh+Fa9R1rPvNZFkuArDBvNbLsmR2D1dD4+G1pP7ap8fFIYLtcwI5mU0jH9XMLrO
         jBW6VDZCBTcrJ8M+Ow3JcLmSSUxFcCdnXRO9NmmsmiFyDMODDoP4SE0vkJhpLLIRG7ky
         phmlKgU/FOI4GQJHGgJ98zL+xOKkN38jDXM+TcwMSp/p+zDc6DqZfj3TFJ2eYzb8bRNS
         J7BK6vURSfjXwdJ43rMvOGLIlKsZlu1bN/tTXg87qfUbKuaGkH9cYbqayt6IjkI2gTYC
         fGcg==
X-Gm-Message-State: ACgBeo25/QWHwAlzP0ccN3RbXYeW7oMJyuyiNm2CnCznEASOOh7C1e6i
        ZPFOW2v3a0H8+oP6ih5Wa4AXMvCrPrNcdg==
X-Google-Smtp-Source: AA6agR5N887BkRUi1yYSyPlquVjvCXKJzHvwxJCVm78iXINt1q5/1roROTccRC7WDM/8b+w+IlvBYA==
X-Received: by 2002:a05:620a:170b:b0:6bb:83e2:e678 with SMTP id az11-20020a05620a170b00b006bb83e2e678mr2805860qkb.555.1660721492208;
        Wed, 17 Aug 2022 00:31:32 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05620a17a400b006baf3ffba23sm10176626qkb.38.2022.08.17.00.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:31:31 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31f445bd486so210210227b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:31:30 -0700 (PDT)
X-Received: by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr17606473ybp.380.1660721490548; Wed, 17
 Aug 2022 00:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
 <20220816132040.uwirtjm5yr6rdd3q@houat> <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
 <20220816141116.5nuszmilqv2exdb3@houat> <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
 <20220816154956.pkdpxmmw27mia5ix@houat>
In-Reply-To: <20220816154956.pkdpxmmw27mia5ix@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 09:31:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
Message-ID: <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
Subject: Re: [PATCH v1 05/35] drm/connector: Add TV standard property
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

On Tue, Aug 16, 2022 at 5:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > > > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > > > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > > > > currently a named mode and a refresh rate can't be specified both.
> > > > >
> > > > > I think the former would make more sense. It simplifies a bit the
> > > > > parser, and we're going to use a named mode anyway.
> > > > >
> > > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > > > > command-line option" uses a separate "tv_mode" option, and not the main
> > > > > > mode name, I think you want to add them here.
> > > > >
> > > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > > which would be equivalent to 1280x720,tv_mode=hd720p
> > > >
> > > > So where's the field rate in "1280x720,tv_mode=hd720p"?
> > >
> > > Yeah, sorry I meant 1280x720@50,tv_mode=hd720p
> >
> > Above you said "I think the former would make more sense", so that
> > should be "1280x720,tv_mode=hd720p50"?
>
> No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=hd720p
> and 60Hz would be hd720p60 or 1280x720@60,tv_mode=hd720p

I disagree: hd720p50 and hd720p60 are different TV modes.
Treating them the same would be similar to treating unmodulated (e.g.
component) PAL-N (25 frames/s) and PAL-M (30 frames/s) the same.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

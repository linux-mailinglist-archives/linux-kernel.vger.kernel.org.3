Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49E596A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiHQHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiHQHkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:40:35 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977C74B9B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:40:34 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id d126so12381484vsd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EmmYkaITTcx08DyrSAVVZyC+XHKGDlOn1xahJdmIIc4=;
        b=m0b3wUMISKj761W0KkkigKSH1N+y6AT+He7FM3Wp4Mi5hSje1UFRigHOI7Ed+E2FTs
         lqtYHB9QQZ4bar3Xwp+u9WemMAepwq9OxJYudtC2w/lV+aTDNoafm9cJMUB4Uy7ebsKS
         odTh3Odf0J4ADD3j6jRJgb45Z+BiLMPyqMIW2itLeiMZuyCfDZ9RWXz9/3/VDuw6TR6Y
         Y6x+wYudoB5hAopC81ag0z2nohvuuGp4z8CDBHE4Ey5wch+0tx6YW/9CmH10PN9oN8LB
         /2MDYAhdKKl/FuNS0e0PAtIHru8zJYkn/4JmsPfRn6pgf23N5hw6wye3j/t2FutinXBA
         Pt7A==
X-Gm-Message-State: ACgBeo0kRbFlYkJolSI+9wKFGPzzggvWOFMQDpLi25SpufQ7ZeRQOEH9
        ygVMCewIrbAglNUk/PwAN1EkGRtSDpq9gA==
X-Google-Smtp-Source: AA6agR4cX38V4P561M6HRPTNiQIJb8PMCj5LRhJZ0L1sy5LXHepMum6yZmkFLhkeooaf7kTe0afqYg==
X-Received: by 2002:a05:6102:e59:b0:38a:a0e4:269a with SMTP id p25-20020a0561020e5900b0038aa0e4269amr10485132vst.30.1660722032922;
        Wed, 17 Aug 2022 00:40:32 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id g3-20020a056102244300b003885a2f7a36sm8241591vss.5.2022.08.17.00.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:40:32 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id 5so4883208uay.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:40:32 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr18128602ybq.543.1660721552542; Wed, 17
 Aug 2022 00:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
 <20220816132040.uwirtjm5yr6rdd3q@houat> <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
 <20220816141116.5nuszmilqv2exdb3@houat> <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
 <20220816154956.pkdpxmmw27mia5ix@houat> <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
In-Reply-To: <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 09:32:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGwPjpsNZhcNwtCgjt9qYfPUb6eaX2q3fE2n0n8uYwhg@mail.gmail.com>
Message-ID: <CAMuHMdWGwPjpsNZhcNwtCgjt9qYfPUb6eaX2q3fE2n0n8uYwhg@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 9:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Aug 16, 2022 at 5:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > > > > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > > > > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > > > > > currently a named mode and a refresh rate can't be specified both.
> > > > > >
> > > > > > I think the former would make more sense. It simplifies a bit the
> > > > > > parser, and we're going to use a named mode anyway.
> > > > > >
> > > > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > > > > > command-line option" uses a separate "tv_mode" option, and not the main
> > > > > > > mode name, I think you want to add them here.
> > > > > >
> > > > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > > > which would be equivalent to 1280x720,tv_mode=hd720p
> > > > >
> > > > > So where's the field rate in "1280x720,tv_mode=hd720p"?
> > > >
> > > > Yeah, sorry I meant 1280x720@50,tv_mode=hd720p
> > >
> > > Above you said "I think the former would make more sense", so that
> > > should be "1280x720,tv_mode=hd720p50"?
> >
> > No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=hd720p
> > and 60Hz would be hd720p60 or 1280x720@60,tv_mode=hd720p
>
> I disagree: hd720p50 and hd720p60 are different TV modes.
> Treating them the same would be similar to treating unmodulated (e.g.
> component) PAL-N (25 frames/s) and PAL-M (30 frames/s) the same.

IIRC from my PS3 -Linux days, not all HD(-Ready) TVs supported both
hd720p50 and hd720p60.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADCD5970CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiHQOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiHQOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:11:48 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCBD39B8E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:11:46 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id j5so15492784oih.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4dcyblUn3bURjZBjn5VOr+f2Wy5bXXXMGqJEHlnVqeg=;
        b=vgJkYBRoA1y9/TAxTexzQ3ItgcluACehbN5mL0DLYADsbFRk5ButB5l3Cq9FWstEno
         yuyOpgNx3a+b5ctToz/1FLZfYJceaL+QEcX4PK/grESfVaOMd68Aw+WBmIRTrfDdvMem
         Lupd0f2sVNF8L6hQlTqhdDsX5h/VIY52AcF9LbCFwnzlWDeBLcivW2/e+Q2IQ/B3JRRL
         BKJzxJcULl1AxF3ZIb1V3WF/njbkYatwssEEtyDbI5ROSWMl+YUkJw4rBQWaYVajwNhH
         BuUVCER6H1DkUSW/rMHxF2ZcYDKK8WAq9idZwGrTOuo1ttLE3H6aFisx8DtgmIP5K2A+
         z82g==
X-Gm-Message-State: ACgBeo1+LktJyPt84UnlsKw0GvWO58X+oXleaY740e95UCzuD+buuot+
        nyY6jjwLSBjPZPxdtYIFWcogQJDlZI0vCg==
X-Google-Smtp-Source: AA6agR46NsAAY3zAcs2q5dFzXINPUgZ9rlz60vApp4s/EC52EEmyMfHYc3Rf2JwxTCgjY2E4q/w3rA==
X-Received: by 2002:a05:6808:e89:b0:33a:315a:eb90 with SMTP id k9-20020a0568080e8900b0033a315aeb90mr1530146oil.162.1660745505181;
        Wed, 17 Aug 2022 07:11:45 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b00101bd4914f9sm2806875oab.43.2022.08.17.07.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:11:44 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id bk13-20020a056830368d00b0063723999f31so9446916otb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:11:44 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr21824312ywp.383.1660745076963;
 Wed, 17 Aug 2022 07:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220816132040.uwirtjm5yr6rdd3q@houat> <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
 <20220816141116.5nuszmilqv2exdb3@houat> <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
 <20220816154956.pkdpxmmw27mia5ix@houat> <CAMuHMdX0L6cO_jYXKZTv0sm9V39Eiy_STiknSkdRQG4k-9GJeg@mail.gmail.com>
 <20220817074710.w4c4xwj7edly2b5p@houat> <CAMuHMdXeBakWr6geOWGxnjQYaU9Pi4tRvVFFtubyMJZTT2nPnw@mail.gmail.com>
 <20220817111454.pn2iltvyo2drebq7@houat> <CAMuHMdU57g1rNoLo65jhLK8mk4YkNEbMz1E7XKWk2dnCxTr=gg@mail.gmail.com>
 <20220817131854.jwmhqvhfhp77bbr3@houat>
In-Reply-To: <20220817131854.jwmhqvhfhp77bbr3@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 16:04:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrfH9MArXesfNCvqayiq17u7XaqtSvXTNt4V10=obSHQ@mail.gmail.com>
Message-ID: <CAMuHMdXrfH9MArXesfNCvqayiq17u7XaqtSvXTNt4V10=obSHQ@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Wed, Aug 17, 2022 at 03:05:52PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Aug 17, 2022 at 1:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Wed, Aug 17, 2022 at 10:35:07AM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, Aug 17, 2022 at 9:47 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > On Wed, Aug 17, 2022 at 09:31:18AM +0200, Geert Uytterhoeven wrote:
> > > > > > On Tue, Aug 16, 2022 at 5:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > > > > > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > > > > > > > > > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > > > > > > > > > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > > > > > > > > > > currently a named mode and a refresh rate can't be specified both.
> > > > > > > > > > >
> > > > > > > > > > > I think the former would make more sense. It simplifies a bit the
> > > > > > > > > > > parser, and we're going to use a named mode anyway.
> > > > > > > > > > >
> > > > > > > > > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > > > > > > > > > > command-line option" uses a separate "tv_mode" option, and not the main
> > > > > > > > > > > > mode name, I think you want to add them here.
> > > > > > > > > > >
> > > > > > > > > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > > > > > > > > which would be equivalent to 1280x720,tv_mode=hd720p
> > > > > > > > > >
> > > > > > > > > > So where's the field rate in "1280x720,tv_mode=hd720p"?
> > > > > > > > >
> > > > > > > > > Yeah, sorry I meant 1280x720@50,tv_mode=hd720p
> > > > > > > >
> > > > > > > > Above you said "I think the former would make more sense", so that
> > > > > > > > should be "1280x720,tv_mode=hd720p50"?
> > > > > > >
> > > > > > > No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=hd720p
> > > > > > > and 60Hz would be hd720p60 or 1280x720@60,tv_mode=hd720p
> > > > > >
> > > > > > I disagree: hd720p50 and hd720p60 are different TV modes.
> > > > >
> > > > > I agree, and I don't see how that command-line doesn't express that?
> > > >
> > > > Oh, I see what you mean: yes, it expresses that.
> > > > But it is inconsistent with the NTSC/PAL/SECAM/hd{480,576}[ip] modes,
> > > > where the TV mode specifies both number of lines and frame rate.
> > >
> > > Only if we're using a named mode, and naming is hard :)
> >
> > That's not true: "640x480,tv_mode=PAL-N" would give me a mode with
> > 625 lines and 25 frames/s, "640x480,tv_mode=PAL-M" would give me a
> > mode with 525 lines and 30 frames/s.
>
> In that series, "640x480,tv_mode=PAL-N" would be rejected as invalid:
>
> https://lore.kernel.org/dri-devel/20220728-rpi-analog-tv-properties-v1-14-3d53ae722097@cerno.tech/

It would become supported once the ideas from thread "[PATCH v1 04/35]
drm/modes: Introduce 480i and 576i modes" are implemented...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

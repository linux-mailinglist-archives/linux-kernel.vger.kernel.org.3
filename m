Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381B595D57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiHPN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiHPN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:29:25 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686AB6D39
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:29:22 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id h4so8061745qtj.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hdhYrvwFVCJ/wIIa+DKIK8qp10gL+xmn48+Cm6GZTzY=;
        b=jsbjZwxeGQRGwT1SdR+xPeru2lA/mZgpZrAg27ouIi70evum/8Jsg/4csrkDhKDWf2
         GHanqjAocpVMoSTent7bJ7DDRwHW1xNmuj59Ytru/E9MmljRJk+Yds/r0QDSBloOxYCs
         Mv9vsip3fOHq57MeyHYYQpZYjw6HZpn5kSY8nvtqhoBhmBJ/DDPtng1ofglpZ3M58xKp
         gNIT4GvumLza3woC/Chyym14xdHy+YBqXUrq7i0RKc8bN4C3fIV/0Z9hwY9u1044bh1i
         AW7mC5O+nmOcTK9QUjo7AGEGbj2DvJcX7TfE7cg/0hnJ0lz0AGtbQ/4jr2QbC5RwryTx
         DAWA==
X-Gm-Message-State: ACgBeo2q5oM0NCCsx1RwjtrZ0gy4MDplslZ7Qcf3oPuyTa9Jv1jPWjaA
        G1kZDsNBkgCdP+89FURiia+V1o3KPz4U9Q==
X-Google-Smtp-Source: AA6agR7/R1EycEKRK8JucE3czcRuN0S3r9RqWj3zDBiHvVYINJ2eFRpflENJYDZ4t8nKrvOiplOC+A==
X-Received: by 2002:ac8:7e88:0:b0:344:6b01:1146 with SMTP id w8-20020ac87e88000000b003446b011146mr5193161qtj.37.1660656561401;
        Tue, 16 Aug 2022 06:29:21 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b0031ef67386a5sm10120297qtb.68.2022.08.16.06.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:29:20 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-33365a01f29so53082067b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:29:20 -0700 (PDT)
X-Received: by 2002:a81:502:0:b0:32f:dcc4:146e with SMTP id
 2-20020a810502000000b0032fdcc4146emr10322596ywf.316.1660656559751; Tue, 16
 Aug 2022 06:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com> <20220816132040.uwirtjm5yr6rdd3q@houat>
In-Reply-To: <20220816132040.uwirtjm5yr6rdd3q@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Aug 2022 15:29:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
Message-ID: <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Aug 16, 2022 at 3:20 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Fri, Aug 12, 2022 at 03:25:18PM +0200, Geert Uytterhoeven wrote:
> > > --- a/drivers/gpu/drm/drm_connector.c
> > > +++ b/drivers/gpu/drm/drm_connector.c
> > > @@ -1649,11 +1650,40 @@ EXPORT_SYMBOL(drm_mode_create_tv_margin_properties);
> > >   * 0 on success or a negative error code on failure.
> > >   */
> > >  int drm_mode_create_tv_properties(struct drm_device *dev,
> > > +                                 unsigned int supported_tv_norms,
> > >                                   unsigned int num_modes,
> > >                                   const char * const modes[])
> > >  {
> > > +       static const struct drm_prop_enum_list tv_norm_values[] = {
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_443) - 1, "NTSC-443" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_J) - 1, "NTSC-J" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_M) - 1, "NTSC-M" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_60) - 1, "PAL-60" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_B) - 1, "PAL-B" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_D) - 1, "PAL-D" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_G) - 1, "PAL-G" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_H) - 1, "PAL-H" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_I) - 1, "PAL-I" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_M) - 1, "PAL-M" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_N) - 1, "PAL-N" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_NC) - 1, "PAL-Nc" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_60) - 1, "SECAM-60" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_B) - 1, "SECAM-B" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_D) - 1, "SECAM-D" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_G) - 1, "SECAM-G" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_K) - 1, "SECAM-K" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_K1) - 1, "SECAM-K1" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_L) - 1, "SECAM-L" },
> >
> > The above are analog standards, with a variable horizontal resolution.
> >
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD480I) - 1, "hd480i" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD480P) - 1, "hd480p" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD576I) - 1, "hd576i" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD576P) - 1, "hd576p" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD720P) - 1, "hd720p" },
> > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD1080I) - 1, "hd1080i" },
> >
> > The above are digital standards, with a fixed resolution.
>
> Are they?
>
> It's not clear to me from looking at nouveau, but I was under the
> impression that they were modes for a component output, so CEA 770.3. I
> don't have the spec though, so I can't check.

Oh right, I forgot about analog HD over component, where you can use
other pixel clocks than in the digital standard.

> > You seem to have missed "hd1080p"?
>
> Nobody is using it. If we ever have a driver that uses it I think we can
> add it.

The PS3 supports 1080p over component
https://manuals.playstation.net/document/en/ps3/current/settings/videooutput.html

> > In addition, "hd720p", "hd080i", and "hd1080p" are available in both 50
> > and 60 (actually 59.94) Hz, while "hd1080p" can also use 24 or 25 Hz.
>
> It looks like nouveau only exposes modes for 480p at 59.94Hz, 576p at
> 50Hz, 720p at 60Hz, 1080i at 30Hz.

PS3 supports both 50 and 60 Hz (same link above).

> > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > currently a named mode and a refresh rate can't be specified both.
>
> I think the former would make more sense. It simplifies a bit the
> parser, and we're going to use a named mode anyway.
>
> > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > command-line option" uses a separate "tv_mode" option, and not the main
> > mode name, I think you want to add them here.
>
> It's a separate story I think, we could have a named mode hd720p50,
> which would be equivalent to 1280x720,tv_mode=hd720p

So where's the field rate in "1280x720,tv_mode=hd720p"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

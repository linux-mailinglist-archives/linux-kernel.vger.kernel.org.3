Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB82591156
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiHLNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiHLNZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:25:34 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510B28727
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:25:33 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id j6so722193qkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aTZUDWioyW00G3FP5HrhAR/urlDDduygUMh7slAg+gU=;
        b=2L/a0zETAGjEFgdkXc5OqtLCtV52HykR/3+oGpx1slc2FWzU1IC+AP7tPCN/SNICyY
         LUfbZ7zGZJM1k0QGIoBGd3GaZ61DkpTqomjmuT7/mXxVbVEWpRLvx82WKYEeT+rL0x9D
         kXY0HrKlqfpEBYFkavT1xa/yzuYW+hQ5jg1YiRatxdHgpCYNGF++vIZuw43pI8DiYoLZ
         fywUVohuW0bDFyAGUv6DLV/2Iu3Lhqw35YZiSB34LMrB45xQlcc4+upS1oQJFj+FAosn
         tGGTMC/i68vcCAQMr8j0Vg9vN0XP+P/SiYbywfmJdeKoVWRntJ/snweuIaFcvxxoeryo
         erjg==
X-Gm-Message-State: ACgBeo0x+bBdZ8tp+Kt1cQ23pXYVRKP064iPn820wmLwPjqc7K5UdaPW
        jiJVndKEC9KZY0kCuxG6Hd6DXZxySiZElQ==
X-Google-Smtp-Source: AA6agR4Q3k8bOQ6qIhSul35IXgRH8/uoijgeJdR5YiW9A5aOAh2TOT7i0V8Uq+PAleAunPlF4jdVIg==
X-Received: by 2002:a05:620a:15c5:b0:6b9:96c2:a6aa with SMTP id o5-20020a05620a15c500b006b996c2a6aamr2800838qkm.382.1660310732087;
        Fri, 12 Aug 2022 06:25:32 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id s3-20020ac85283000000b0034356a0666fsm1681584qtn.17.2022.08.12.06.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:25:30 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31f41584236so9834017b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:25:29 -0700 (PDT)
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr3592742ywe.502.1660310729490; Fri, 12
 Aug 2022 06:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 15:25:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
Message-ID: <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
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
        Maxime Ripard <mripard@kernel.org>,
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

On Fri, Jul 29, 2022 at 6:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> The TV mode property has been around for a while now to select and get the
> current TV mode output on an analog TV connector.
>
> Despite that property name being generic, its content isn't and has been
> driver-specific which makes it hard to build any generic behaviour on top
> of it, both in kernel and user-space.
>
> Let's create a new bitmask tv norm property, that can contain any of the
> analog TV standards currently supported by kernel drivers. Each driver can
> then pass in a bitmask of the modes it supports.
>
> We'll then be able to phase out the older tv mode property.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1649,11 +1650,40 @@ EXPORT_SYMBOL(drm_mode_create_tv_margin_properties);
>   * 0 on success or a negative error code on failure.
>   */
>  int drm_mode_create_tv_properties(struct drm_device *dev,
> +                                 unsigned int supported_tv_norms,
>                                   unsigned int num_modes,
>                                   const char * const modes[])
>  {
> +       static const struct drm_prop_enum_list tv_norm_values[] = {
> +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_443) - 1, "NTSC-443" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_J) - 1, "NTSC-J" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_M) - 1, "NTSC-M" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_60) - 1, "PAL-60" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_B) - 1, "PAL-B" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_D) - 1, "PAL-D" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_G) - 1, "PAL-G" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_H) - 1, "PAL-H" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_I) - 1, "PAL-I" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_M) - 1, "PAL-M" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_N) - 1, "PAL-N" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_NC) - 1, "PAL-Nc" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_60) - 1, "SECAM-60" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_B) - 1, "SECAM-B" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_D) - 1, "SECAM-D" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_G) - 1, "SECAM-G" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_K) - 1, "SECAM-K" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_K1) - 1, "SECAM-K1" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_L) - 1, "SECAM-L" },

The above are analog standards, with a variable horizontal resolution.

> +               { __builtin_ffs(DRM_MODE_TV_NORM_HD480I) - 1, "hd480i" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_HD480P) - 1, "hd480p" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_HD576I) - 1, "hd576i" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_HD576P) - 1, "hd576p" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_HD720P) - 1, "hd720p" },
> +               { __builtin_ffs(DRM_MODE_TV_NORM_HD1080I) - 1, "hd1080i" },

The above are digital standards, with a fixed resolution.

You seem to have missed "hd1080p"?

In addition, "hd720p", "hd080i", and "hd1080p" are available in both 50
and 60 (actually 59.94) Hz, while "hd1080p" can also use 24 or 25 Hz.
Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
handle them through "@<refresh>".  The latter would impact "[PATCH v1
09/35] drm/modes: Move named modes parsing to a separate function", as
currently a named mode and a refresh rate can't be specified both.

As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
command-line option" uses a separate "tv_mode" option, and not the main
mode name, I think you want to add them here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

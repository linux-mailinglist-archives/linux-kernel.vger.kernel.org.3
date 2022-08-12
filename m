Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483D591150
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiHLNYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHLNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:24:19 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE690C58
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:24:17 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-10ea9ef5838so924955fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3HLPBVRse5OcNJxEM0wXkaB5QH7QwzyC6KEnOhyPoPY=;
        b=tjB2mpx9z1p/o6Gi87SVlc/18WHMMlty9TbUdKi7/4+9/RyvtMuuk9DAVOEb9d2GrS
         FgqW1HWM36Soyey4XOFSCwvlYn/TEOystHF6ehI+Ki7jiezvTwKmRN7/639kFa7HHCLw
         zrviJSP5LvVH1S+F4OoBLNAL4USu1/2vFKAGSAUupwqGyM/PQCDRfbtjJGA1X7KD6IA+
         wBFFRjMEL9wCHrfcMYbyh0rHUxl2p94ogRItp//KvSqzoAAA6JipAnweMYDoVp5a3DQG
         V8qPMPGIb5x7PLFEj+2aGCIoEJ60+58bay/s93KjAsNEwWrdMMvWpn4RavSgzn44XT6S
         CNKA==
X-Gm-Message-State: ACgBeo2iM3cPlDrLHAVmFrYvgkorOpxE/iC4CUJShyojvcbNh+R219NA
        5pEyqDcLlxQmNyyssooPYWCoPyzndyb3+A==
X-Google-Smtp-Source: AA6agR4s9b567g/ARmXWrj+FWR/WLvur0LRmT114slb6XT1B8jeDSQajxSk1qAtpqyTjOBMN/3x7TQ==
X-Received: by 2002:a05:6870:f69b:b0:10d:a0d3:4175 with SMTP id el27-20020a056870f69b00b0010da0d34175mr5566478oab.53.1660310656828;
        Fri, 12 Aug 2022 06:24:16 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id eh5-20020a056870f58500b0010e63d0afbbsm317733oab.55.2022.08.12.06.24.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:24:16 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 53-20020a9d0838000000b006371d896343so542335oty.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:24:16 -0700 (PDT)
X-Received: by 2002:a81:1204:0:b0:322:7000:4ecb with SMTP id
 4-20020a811204000000b0032270004ecbmr3771794yws.47.1660310350262; Fri, 12 Aug
 2022 06:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 15:18:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com>
Message-ID: <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for your patch!

On Fri, Jul 29, 2022 at 6:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> Multiple drivers (meson, vc4) define the analog TV 525-lines and 625-lines
> modes in the drivers.

Nit: strictly speaking these are not analog modes, but the digital
variants (ITU-R BT.656 and DVD-Video D1) of NTSC and PAL, using a
13.5 MHz sampling frequency for pixels.

In analog modes, the only discrete values are the number of lines, and
the frame/field rate (fixing the horizontal sync rate when combined).

The number of (in)visible pixels per line depends on the available
bandwidth.  In a digital variant (which is anything generated by a
digital computer system), the latter depends on the pixel clock, which
can wildly differ from the 13.5 MHz used in the BT.656 standard. (e.g.
Amiga uses 7.09/14.19/28.38 MHz (PAL) or 7.16/14.32/28.64 MHz (NTSC)).

So I think we probably need some way to generate a PAL/NTSC-compatible
mode based not only on resolution, but also on pixel clock.

>
> Since those modes are fairly standards, and that we'll need to use them in
> more places in the future, let's move the meson definition into the
> framework.
>
> The meson one was chosen because vc4's isn't accurate and doesn't amount to
> 525 and 625 lines.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -48,6 +48,24 @@
>
>  #include "drm_crtc_internal.h"
>
> +const struct drm_display_mode drm_mode_480i = {
> +       DRM_MODE("720x480i", DRM_MODE_TYPE_DRIVER, 13500,
> +                720, 739, 801, 858, 0,
> +                480, 488, 494, 525, 0,
> +                DRM_MODE_FLAG_INTERLACE),
> +       .picture_aspect_ratio = HDMI_PICTURE_ASPECT_4_3,
> +};
> +EXPORT_SYMBOL_GPL(drm_mode_480i);
> +
> +const struct drm_display_mode drm_mode_576i = {
> +       DRM_MODE("720x576i", DRM_MODE_TYPE_DRIVER, 13500,
> +                720, 732, 795, 864, 0,
> +                576, 580, 586, 625, 0,
> +                DRM_MODE_FLAG_INTERLACE),
> +       .picture_aspect_ratio = HDMI_PICTURE_ASPECT_4_3,
> +};
> +EXPORT_SYMBOL_GPL(drm_mode_576i);
> +
>  /**

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

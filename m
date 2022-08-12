Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A771591174
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiHLNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiHLNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:31:34 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D69BB47
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:31:33 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id l18so577305qvt.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6vlKlfYZ8UUr42Z0Ey6Sidm4mVEyWELk9h2eYr+jvz0=;
        b=5ooE0NP3Pi2x3r8cbFR2iCLxijwbxFGy4N7CwcBrnIlIdRH2wTvaYu3clOhgqwo5zS
         Gjrck2F5H/PqdQkD7auVoDA2wSzGiwvxCyOICteaLqMY5bZrPX6cPPXn34HWPRWzhXBe
         h2MQKv3Noe0188yzx5uQQdj2SBdtYeeOD7z04G2UBAn0bQVAe79AeaKotVXmq6cX826r
         nBL8Td72zywpd9Rxo1nWqvBfBPx02umkLVqMhJQGnqxdCbQPUy9867o3KXryy6xusFLt
         yHBfqMNzkOy5nptVnMq4qvwWnD7eP4cUZWICKWGJ956UhkzqPnQkpXUAs0GR2AkQ2M9Y
         mt3g==
X-Gm-Message-State: ACgBeo2FjOHskTojWtR8eu68IaVeUZw/xoYA0tOW+BzpCXcZ/7aicvUb
        a5nb7hkLtAASPLDGDmDWrybk0z3oZA27OA==
X-Google-Smtp-Source: AA6agR7rKr+SX3sG/xMlpCd60VV4lknD+Emfe5TFYXdJTTeEvRVj0l7rVzuOV3ppAnzXejqTSThQtg==
X-Received: by 2002:a05:6214:20ad:b0:478:a967:560 with SMTP id 13-20020a05621420ad00b00478a9670560mr3527001qvd.58.1660311092357;
        Fri, 12 Aug 2022 06:31:32 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id a8-20020ac86108000000b003435bb7fe9csm1621443qtm.78.2022.08.12.06.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:31:31 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31f445bd486so9787427b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:31:30 -0700 (PDT)
X-Received: by 2002:a81:1204:0:b0:322:7000:4ecb with SMTP id
 4-20020a811204000000b0032270004ecbmr3814535yws.47.1660311090509; Fri, 12 Aug
 2022 06:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-34-3d53ae722097@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-34-3d53ae722097@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 15:31:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXizN9OgXgxwdFc1gpnhZof-SZrCH8PczEiJrtYpB62Ow@mail.gmail.com>
Message-ID: <CAMuHMdXizN9OgXgxwdFc1gpnhZof-SZrCH8PczEiJrtYpB62Ow@mail.gmail.com>
Subject: Re: [PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
 command-line option
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

On Fri, Jul 29, 2022 at 6:37 PM Maxime Ripard <maxime@cerno.tech> wrote:
> Our new tv mode option allows to specify the TV mode from a property.
> However, it can still be useful, for example to avoid any boot time
> artifact, to set that property directly from the kernel command line.
>
> Let's add some code to allow it, and some unit tests to exercise that code.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1677,6 +1677,80 @@ static int drm_mode_parse_panel_orientation(const char *delim,
>         return 0;
>  }
>
> +#define TV_OPTION_EQUAL(value, len, option) \
> +       ((strlen(option) == len) && !strncmp(value, option, len))
> +
> +static int drm_mode_parse_tv_mode(const char *delim,
> +                                 struct drm_cmdline_mode *mode)
> +{
> +       const char *value;
> +       unsigned int len;
> +
> +       if (*delim != '=')
> +               return -EINVAL;
> +
> +       value = delim + 1;
> +       delim = strchr(value, ',');
> +       if (!delim)
> +               delim = value + strlen(value);
> +
> +       len = delim - value;
> +       if (TV_OPTION_EQUAL(value, len, "NTSC-443"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_NTSC_443;
> +       else if (TV_OPTION_EQUAL(value, len, "NTSC-J"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_NTSC_J;
> +       else if (TV_OPTION_EQUAL(value, len, "NTSC-M"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_NTSC_M;

[...]

You already have the array tv_norm_values[] from "[PATCH v1 05/35]
drm/connector: Add TV standard property". Can't you export that, and
loop over that array instead?

> +       else if (TV_OPTION_EQUAL(value, len, "HD480I"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_HD480I;
> +       else if (TV_OPTION_EQUAL(value, len, "HD480P"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_HD480P;
> +       else if (TV_OPTION_EQUAL(value, len, "HD576I"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_HD576I;
> +       else if (TV_OPTION_EQUAL(value, len, "HD576P"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_HD576P;
> +       else if (TV_OPTION_EQUAL(value, len, "HD720P"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_HD720P;
> +       else if (TV_OPTION_EQUAL(value, len, "HD1080I"))
> +               mode->tv_mode = DRM_MODE_TV_NORM_HD1080I;

The names in tv_norm_values[] use lower-case, while you use upper-case
here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

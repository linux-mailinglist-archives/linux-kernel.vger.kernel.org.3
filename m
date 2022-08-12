Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60E1591183
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiHLNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiHLNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:32:20 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611919AFCD
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:32:19 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id 67so810270vsv.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OXdSHuVG78f8K6rpNcMaWPwy/pvmJ+nqUgx8dG2xzfs=;
        b=K1soJI4r2/RDWqg2Fashs/x5heF18hY/NkA2TIHO58NjoaQ+cAiocx5dpY/d01+f69
         3kjfJgqT2IKCSSSSlCrhLJRf/sF9zQFm7xYCHfitVysc3i7PURBMzAC24OS9fAX1OjC9
         DPHI5C/qNgh04yugToovM8nEjO+NjL2VLXw7GPT3XAXf5ocn1+nm6FB7vPhSIc2nhO6V
         iow+OOPQQdG3hlqVBMooqkrdWe4w1m9cZ5ew5cZJOV3n/9Scx/Z2wEb+lz68xc5LR3Lu
         5pYlXslYXjG+dJ8Kpt/nuYrnM+8hl54RUdTyE3eao19zMOfVcUVW6odWtotDMBYKiKYi
         wQDg==
X-Gm-Message-State: ACgBeo3aFuweQDvnBs/cMOqxRBabgo8koOhAxGlkk7p7eJ67q5rvWett
        ksHMZLgVkDi4nADAiagiuDReUUkyNX+kzQ==
X-Google-Smtp-Source: AA6agR56WE75UR3CSWzCY93jzKN6GGXCSAcERY+4ZX7RuIHGJgGVxnzojaB4bxGkRjYpLZgoBFT9Fw==
X-Received: by 2002:a05:6102:2223:b0:32d:2ae1:412 with SMTP id d3-20020a056102222300b0032d2ae10412mr1901446vsb.6.1660311138174;
        Fri, 12 Aug 2022 06:32:18 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id f28-20020ab0101c000000b00384d3ce037dsm1510008uab.4.2022.08.12.06.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:32:17 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id f10so315835uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:32:17 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr3307653ybq.543.1660310750947; Fri, 12
 Aug 2022 06:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-7-3d53ae722097@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-7-3d53ae722097@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 15:25:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWa9soLHSvmxWqjKAO93WhViww6GZiC9qh0RccVENPRYw@mail.gmail.com>
Message-ID: <CAMuHMdWa9soLHSvmxWqjKAO93WhViww6GZiC9qh0RccVENPRYw@mail.gmail.com>
Subject: Re: [PATCH v1 07/35] drm/modes: Only consider bpp and refresh before options
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
> Some video= options might have a value that contains a dash. However, the
> command line parsing mode considers all dashes as the separator between the
> mode and the bpp count.
>
> Let's rework the parsing code a bit to only consider a dash as the bpp
> separator if it before a comma, the options separator.
>
> A follow-up patch will add a unit-test for this once such an option is
> introduced.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1819,20 +1819,22 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
>
>         name = mode_option;
>
> +       /* Locate the start of named options */
> +       options_ptr = strchr(name, ',');
> +       if (options_ptr)
> +               options_off = options_ptr - name;
> +       else
> +               options_off = strlen(name);
> +
>         /* Try to locate the bpp and refresh specifiers, if any */
> -       bpp_ptr = strchr(name, '-');
> +       bpp_ptr = strnchr(name, options_off, '-');

Probably you still want to add a check that the next character
is actually a digit, cfr. my "[PATCH v2 5/5] drm/modes:
parse_cmdline: Add support for named modes containing dashes"
(https://lore.kernel.org/dri-devel/2eb205da88c3cb19ddf04d167ece4e16a330948b.1657788997.git.geert@linux-m68k.org)?

>         if (bpp_ptr)
>                 bpp_off = bpp_ptr - name;
>
> -       refresh_ptr = strchr(name, '@');
> +       refresh_ptr = strnchr(name, options_off, '@');
>         if (refresh_ptr)
>                 refresh_off = refresh_ptr - name;
>
> -       /* Locate the start of named options */
> -       options_ptr = strchr(name, ',');
> -       if (options_ptr)
> -               options_off = options_ptr - name;
> -
>         /* Locate the end of the name / resolution, and parse it */
>         if (bpp_ptr) {
>                 mode_end = bpp_off;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

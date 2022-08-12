Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101EC59115F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiHLN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHLN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:27:33 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001129676C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:27:32 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id h8so586074qvs.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aaWmraAyVdsxzOKXcrqOwgi0BA7kWyk0fbcE3gB04Gk=;
        b=CnJS18zm7gCJ3LpQ39+SgwHq25pNeqJqiwKAf+ZUZNwEn61CCKWLv5GpNfG1GhOCu5
         PaPmCoKHt5Q8ekT35I+ikm6a+VA3/jAXGto0Wr6MVFPFOto2R5ayBgTlCJ3gBTgWzHPR
         jSXUt7cVbYQxHYVsfHib9TwD68CclXGrS5yzrVW7JRgYDexcrK2O7GQluTQjAnOcktDg
         QjWjWS9r5+hl7LKy582Jl7bX60TBW9JCgIOc3SXD+MAOEe/NYcViiRxJCOfrvjae2tZt
         3z4iGU5GC3G86buXdS0qApaQQ+Pwkr4foaHiafr7tHY+p5Sm34dT/a3DXJB7+uYk6Are
         sZVw==
X-Gm-Message-State: ACgBeo0qjeFB/7ad4jojsytCJjCrJ6dCjc6GaBHEem4ecWFypC/F5u4O
        C0oJejGlXUdStjYDU8V++Satw1zjV93oNQ==
X-Google-Smtp-Source: AA6agR5i+Auu6+lH3znbuIoD8uHAKWY65wkkgvZxbWToqvwfEyYnZZssR+BsLLU+DH60cdKjl7lIsg==
X-Received: by 2002:ad4:5be4:0:b0:47b:4bdd:b1c7 with SMTP id k4-20020ad45be4000000b0047b4bddb1c7mr3460252qvc.64.1660310851743;
        Fri, 12 Aug 2022 06:27:31 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84754000000b003435f947d9fsm1706037qtp.74.2022.08.12.06.27.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:27:30 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g5so1445386ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:27:29 -0700 (PDT)
X-Received: by 2002:a25:da0b:0:b0:67a:7fb6:8ae with SMTP id
 n11-20020a25da0b000000b0067a7fb608aemr3414026ybf.89.1660310848820; Fri, 12
 Aug 2022 06:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-9-3d53ae722097@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-9-3d53ae722097@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 15:27:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiMEybnhgxgBXh1Cbv6syVe9iVU=sb17zHM72R8A2Dew@mail.gmail.com>
Message-ID: <CAMuHMdUiMEybnhgxgBXh1Cbv6syVe9iVU=sb17zHM72R8A2Dew@mail.gmail.com>
Subject: Re: [PATCH v1 09/35] drm/modes: Move named modes parsing to a
 separate function
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

On Fri, Jul 29, 2022 at 6:36 PM Maxime Ripard <maxime@cerno.tech> wrote:
> The current construction of the named mode parsing doesn't allow to extend
> it easily. Let's move it to a separate function so we can add more
> parameters and modes.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for your patch, which looks similar to my "[PATCH v2 2/5]
drm/modes: Extract drm_mode_parse_cmdline_named_mode()"
(https://lore.kernel.org/dri-devel/1371554419ae63cb54c2a377db0c1016fcf200bb.1657788997.git.geert@linux-m68k.org
;-)

> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1773,6 +1773,28 @@ static const char * const drm_named_modes_whitelist[] = {
>         "PAL",
>  };
>
> +static bool drm_mode_parse_cmdline_named_mode(const char *name,
> +                                             unsigned int name_end,
> +                                             struct drm_cmdline_mode *cmdline_mode)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> +               int ret;
> +
> +               ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> +               if (ret != name_end)
> +                       continue;
> +
> +               strcpy(cmdline_mode->name, drm_named_modes_whitelist[i]);
> +               cmdline_mode->specified = true;
> +
> +               return true;
> +       }
> +
> +       return false;

What's the point in returning a value, if it is never checked?
Just make this function return void?

> +}
> +
>  /**
>   * drm_mode_parse_command_line_for_connector - parse command line modeline for connector
>   * @mode_option: optional per connector mode option
> @@ -1848,18 +1870,14 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
>                 parse_extras = true;
>         }
>
> -       /* First check for a named mode */
> -       for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> -               ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> -               if (ret == mode_end) {
> -                       if (refresh_ptr)
> -                               return false; /* named + refresh is invalid */
> +       /*
> +        * Having a mode that starts by a letter (and thus is named) and
> +        * an at-sign (used to specify a refresh rate) is disallowed.
> +        */
> +       if (!isdigit(name[0]) && refresh_ptr)

This condition may have to be relaxed, if we want to support e.g.
"hd720p@50", cfr. my comments on "[PATCH v1 05/35] drm/connector:
Add TV standard property".

> +               return false;
>
> -                       strcpy(mode->name, drm_named_modes_whitelist[i]);
> -                       mode->specified = true;
> -                       break;
> -               }
> -       }
> +       drm_mode_parse_cmdline_named_mode(name, mode_end, mode);

This call needs to be conditional on mode_end being non-zero, cfr. my
patch "[PATCH v2 1/5] drm/modes: parse_cmdline: Handle empty mode name
part" (https://lore.kernel.org/dri-devel/302d0737539daa2053134e8f24fdf37e3d939e1e.1657788997.git.geert@linux-m68k.org).

>
>         /* No named mode? Check for a normal mode argument, e.g. 1024x768 */
>         if (!mode->specified && isdigit(name[0])) {


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

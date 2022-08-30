Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E3C5A6058
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH3KLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH3KLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:35 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E2F23EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:10 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id a10so4185718qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=B6sPmfOEwPF2h7f07mGfudT4aQe+F6kN6ETICFIZHMY=;
        b=W824vV07KtK3YakholiRu+0SlX0+40rgzm9uSEvhDz67RqB1DpG3jp+q1jzTUI6Bt7
         PpO2F9bRVlGlLUE/0PtAxSiSSHoReH2+M7Kldml5h/czRL6TxKdYwsdUSpEl+kp3DBu9
         JOt3XfXR7HnO+HM19kbAfAjyklndhtZcB0RHFcShZDW9SlY/YleG+FhEKdk1xY4BFWeT
         tAXyxx/S/eROlyEkdZyYYXU8tNolkphErihWdGzpJrmiHXKtCVfZXRASaAx6WBISYiZr
         +kYEvAmaMe2LOze8fhfVZJ/bcG+pDJMjay07OJZOFhqw4tcy8wEln4hxxA6L7fm7vAGv
         i7eg==
X-Gm-Message-State: ACgBeo3AKjF5CNsjy+mpM821btGQfsv1vJfpUCOVJ/u8lmR7m05NDODp
        h/q6PzIa6kr7IJSty2MEo8oW54zOEbwSTQ==
X-Google-Smtp-Source: AA6agR7vjm9cy4ItE7wy6CTBqg+7NP4wj2MOQDywb+Y1PoN7kGw+bLQcjJ8Smzl5twtsq0NefRuJeA==
X-Received: by 2002:a05:620a:444a:b0:6bb:4e76:489c with SMTP id w10-20020a05620a444a00b006bb4e76489cmr10967284qkp.570.1661854028269;
        Tue, 30 Aug 2022 03:07:08 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id q16-20020a05620a2a5000b006bb20e8ee70sm7698073qkp.89.2022.08.30.03.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:07:07 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3413ad0640dso105105097b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:07 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr10033148ybl.604.1661854027231; Tue, 30
 Aug 2022 03:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-14-459522d653a7@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-14-459522d653a7@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 12:06:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9wVgHFfwHoqtBoYzJDnjDmKTfaZkAKvTVKh1Y-2x1pA@mail.gmail.com>
Message-ID: <CAMuHMdV9wVgHFfwHoqtBoYzJDnjDmKTfaZkAKvTVKh1Y-2x1pA@mail.gmail.com>
Subject: Re: [PATCH v2 14/41] drm/modes: Move named modes parsing to a
 separate function
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
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

On Mon, Aug 29, 2022 at 3:13 PM Maxime Ripard <maxime@cerno.tech> wrote:
> The current construction of the named mode parsing doesn't allow to extend
> it easily. Let's move it to a separate function so we can add more
> parameters and modes.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1909,6 +1909,9 @@ void drm_connector_list_update(struct drm_connector *connector)
>  }
>  EXPORT_SYMBOL(drm_connector_list_update);
>
> +#define STR_STRICT_EQ(str, len, cmp) \
> +       ((strlen(cmp) == len) && !strncmp(str, cmp, len))

This is not part of the move, but newly added.

> +
>  static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,
>                                       struct drm_cmdline_mode *mode)
>  {
> @@ -2208,6 +2211,52 @@ static const char * const drm_named_modes_whitelist[] = {
>         "PAL",
>  };
>
> +static int drm_mode_parse_cmdline_named_mode(const char *name,
> +                                            unsigned int name_end,
> +                                            struct drm_cmdline_mode *cmdline_mode)
> +{
> +       unsigned int i;
> +
> +       if (!name_end)
> +               return 0;

This is already checked by the caller.

> +
> +       /* If the name starts with a digit, it's not a named mode */
> +       if (isdigit(name[0]))
> +               return 0;
> +
> +       /*
> +        * If there's an equal sign in the name, the command-line
> +        * contains only an option and no mode.
> +        */
> +       if (strnchr(name, name_end, '='))
> +               return 0;
> +
> +       /* The connection status extras can be set without a mode. */
> +       if (STR_STRICT_EQ(name, name_end, "d") ||
> +           STR_STRICT_EQ(name, name_end, "D") ||
> +           STR_STRICT_EQ(name, name_end, "e"))
> +               return 0;

These checks are not part of the move, and should probably be added
in a separate patch.

> +
> +       /*
> +        * We're sure we're a named mode at that point, iterate over the
> +        * list of modes we're aware of.
> +        */
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
> +               return 1;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  /**
>   * drm_mode_parse_command_line_for_connector - parse command line modeline for connector
>   * @mode_option: optional per connector mode option
> @@ -2244,7 +2293,7 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
>         const char *bpp_ptr = NULL, *refresh_ptr = NULL, *extra_ptr = NULL;
>         const char *options_ptr = NULL;
>         char *bpp_end_ptr = NULL, *refresh_end_ptr = NULL;
> -       int i, len, ret;
> +       int len, ret;
>
>         memset(mode, 0, sizeof(*mode));
>         mode->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> @@ -2285,17 +2334,19 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
>                 parse_extras = true;
>         }
>
> -       /* First check for a named mode */
> -       for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> -               ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> -               if (ret == mode_end) {
> -                       if (refresh_ptr)
> -                               return false; /* named + refresh is invalid */
>
> -                       strcpy(mode->name, drm_named_modes_whitelist[i]);
> -                       mode->specified = true;
> -                       break;
> -               }
> +       if (mode_end) {
> +               ret = drm_mode_parse_cmdline_named_mode(name, mode_end, mode);
> +               if (ret < 0)
> +                       return false;
> +
> +               /*
> +                * Having a mode that starts by a letter (and thus is named)
> +                * and an at-sign (used to specify a refresh rate) is
> +                * disallowed.
> +                */
> +               if (ret && refresh_ptr)
> +                       return false;
>         }
>
>         /* No named mode? Check for a normal mode argument, e.g. 1024x768 */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

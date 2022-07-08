Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48556C3F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiGHUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGHUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:14:26 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135E2496C;
        Fri,  8 Jul 2022 13:14:24 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id ck6so28955559qtb.7;
        Fri, 08 Jul 2022 13:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zOe+CzPYZZs/hmA7mLwnSYETa9zn5ouTBI7OSu/RXM=;
        b=B46l2DUVt8IV8Z3vH+VjVlLm1GTPMDQw8nfCx8xoV1G640XPHNgN0nnalQ8Htqd7lH
         nJZXP1TnwC93xhinWA45GH7FeI2pVL9Yx6wsMgj0nSp5QZXLGmers8Luts2NiwEPlxto
         GNwJ/1/jjUR+NHm/zRJJiKSl0N94MEk6fkQwJLuFrDYZQKxAGpBapcWhzn0cR//j4H8Q
         DqzxFFN6d9YckxaV87+wVm6njiVixxKK/ZLn3NIRl8PWwYJmCwtx7ITHsjcQVu518b3b
         dsn6e0PrJjTxelY5GoNjNivVjuqy2XuWJ/B3fzdAMIOtWtRsIyG4Fj6wcLmIMQXHBjS0
         /EIw==
X-Gm-Message-State: AJIora/2tJkSPpvZ+ddzop6WPa8ClgJFEgMV2bIbZpwhfhsI6HexwcWj
        i+ZioYYY232+1UzS6r2ZN5+CPxLA/XSPxA==
X-Google-Smtp-Source: AGRyM1sLv6Wj7wNfCmiXzq0SB0ogtFSm+SbnC84MMghTfsS7jwnfNZt/kYjXa5PtzxxL7ruRL46bFA==
X-Received: by 2002:ac8:5808:0:b0:31b:ef47:38b3 with SMTP id g8-20020ac85808000000b0031bef4738b3mr4537504qtg.510.1657311263352;
        Fri, 08 Jul 2022 13:14:23 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id j17-20020ac84c91000000b002f39b99f6a4sm23461297qtv.62.2022.07.08.13.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 13:14:20 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 136so7761829ybl.5;
        Fri, 08 Jul 2022 13:14:18 -0700 (PDT)
X-Received: by 2002:a05:6902:701:b0:66e:a06d:53d7 with SMTP id
 k1-20020a056902070100b0066ea06d53d7mr5316435ybt.604.1657311257860; Fri, 08
 Jul 2022 13:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301107.git.geert@linux-m68k.org> <402dea47269f2e3960946d186ba3cb118066e74a.1657301107.git.geert@linux-m68k.org>
 <c95724ad-a3b0-2ac8-5413-b971626e7e63@redhat.com>
In-Reply-To: <c95724ad-a3b0-2ac8-5413-b971626e7e63@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 22:14:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU4tmYfnc96SGKuvdKC_JGNOHUmmNwrN4DdOmw0LijPvA@mail.gmail.com>
Message-ID: <CAMuHMdU4tmYfnc96SGKuvdKC_JGNOHUmmNwrN4DdOmw0LijPvA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/modes: Extract drm_mode_parse_cmdline_named_mode()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Hans,

On Fri, Jul 8, 2022 at 9:46 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/8/22 20:21, Geert Uytterhoeven wrote:
> > Extract the code to check for a named mode parameter into its own
> > function, to streamline the main parsing flow.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -1749,6 +1749,30 @@ static const char * const drm_named_modes_whitelist[] = {
> >       "PAL",
> >  };
> >
> > +static int drm_mode_parse_cmdline_named_mode(const char *name,
> > +                                          unsigned int length,
> > +                                          bool refresh,
> > +                                          struct drm_cmdline_mode *mode)
> > +{
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> > +             ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> > +             if (!ret)
>
> As discussed in my review of 1/5 this needs to become:
>
>                 if (ret != length)
> > +                     continue;

Agreed.

> Which renders my other comment on this patch (length not being used) mute.

/me wonders if he would have seen the light earlier if gcc would have
warned about that...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

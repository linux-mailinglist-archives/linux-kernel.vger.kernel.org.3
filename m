Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8356C2F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiGHUHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:06:57 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C978A15817;
        Fri,  8 Jul 2022 13:06:56 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id bs20so28965966qtb.11;
        Fri, 08 Jul 2022 13:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrAYMou5WShK8tYCJZhhedzGwf63ebeVvEWKhQgZ9ig=;
        b=Tdn4rg7T5hHvt6R8E+cBGKmgB20+fx+mFomvz5vcSdriCirous7ZXWfSQq0d9Gc6AX
         brj0Fh+upgv682c0a3uu8bCZ3lehdqLT5LW/8l8oL+tUtMq8Z3LFw/U4C9XeQ9gAoDo8
         52WLuAZqkd/HWVgxG3F2LqRGPJucs6DN5YxxrAV6zYLVcXXKINEcd1/zdfp8atP1jPqr
         e2JO7Rf4mDUABNRQZ7r8a+rYEqnHXvxWgNnEr6+uP+R1O149akFAdVZtNKfkM94ozOm4
         3L002k6j7KehC7jYsvQWBz9P/Gdi28gVM0YmivIR1R+yGpMC4zSGE+htcv1J9w1r8Ezz
         GczA==
X-Gm-Message-State: AJIora8efIHGMirJuIUk97+lTSfLYasqq2PxJPvEKfiUdvSCKXS2dvBq
        Gx0jkchIF2cQxnb0Va+EsF4ySFjjK5tRsQ==
X-Google-Smtp-Source: AGRyM1uxag7u/C6MTuWdpEbCmE/+oqvHVhpKyumejyQDM2B++G8HLyupj36i7Y4PjQqk+XHQFyztUQ==
X-Received: by 2002:a05:622a:44d:b0:316:fccc:9aa0 with SMTP id o13-20020a05622a044d00b00316fccc9aa0mr4660784qtx.154.1657310815688;
        Fri, 08 Jul 2022 13:06:55 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm32741273qkp.130.2022.07.08.13.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 13:06:54 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31c89111f23so157918027b3.0;
        Fri, 08 Jul 2022 13:06:54 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr6013965ywb.502.1657310814238; Fri, 08
 Jul 2022 13:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301107.git.geert@linux-m68k.org> <64e2e9b14c26df28908789374253fd12072c26c2.1657301107.git.geert@linux-m68k.org>
 <b7d937bc-d7c3-6f7a-047c-fc6e5756a5a0@redhat.com>
In-Reply-To: <b7d937bc-d7c3-6f7a-047c-fc6e5756a5a0@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 22:06:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCz4j5bxKBY-W3zWiCLRc9QP+OKco-haGH_9YUhaROgA@mail.gmail.com>
Message-ID: <CAMuHMdWCz4j5bxKBY-W3zWiCLRc9QP+OKco-haGH_9YUhaROgA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/modes: parse_cmdline: Handle empty mode name part
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

Hi Hans.

On Fri, Jul 8, 2022 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/8/22 20:21, Geert Uytterhoeven wrote:
> > If no mode name part was specified, mode_end is zero, and the "ret ==
> > mode_end" check does the wrong thing.
> >
> > Fix this by checking for a non-zero return value instead.
>
> Which is wrong to do, since now if you have e.g. a mode list
> with:
>
> "dblntsc",
> "dblntsc-ff"
>
> in there and the cmdline contains "dblntsc-ff" then you
> will already stop with a (wrong!) match at "dblntsc".

It indeed behaves that way, and did so before, as str_has_prefix()
checks for a matching prefix, and thus may never get to the full
match.  However, can we change that to an exact match, without
introducing regressions?
This can be avoided by reverse-sorting the modelist (or iterating
backwards through a sorted modelist), though.

> > While at it, skip all named mode handling when mode_end is zero, as it
> > is futile.
>
> AFAICT, this is actually what needs to be done to fix this, while keeping
> the ret == mode_end check.

"ret == mode_end" or "ret" doesn't matter (except for the special
case of mode_end is zero), as str_has_prefix() returns either zero or
the length of the prefix.  Hence it never returns a non-zero value
smaller than the length of the prefix.

> > Fixes: 7b1cce760afe38b4 ("drm/modes: parse_cmdline: Allow specifying stand-alone options")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  drivers/gpu/drm/drm_modes.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index 14b746f7ba975954..30a7be97707bfb16 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -1823,9 +1823,9 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
> >       }
> >
> >       /* First check for a named mode */
> > -     for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> > +     for (i = 0; mode_end && i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> >               ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> > -             if (ret == mode_end) {
> > +             if (ret) {
> >                       if (refresh_ptr)
> >                               return false; /* named + refresh is invalid */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

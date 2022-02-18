Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB404BB49D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiBRIxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:53:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiBRIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:53:49 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF419281;
        Fri, 18 Feb 2022 00:53:33 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id j12so4492350vkr.0;
        Fri, 18 Feb 2022 00:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IIIM8aS689yU8psbZYAY0WKVYVp4V9dRKA9Ow9rLTc=;
        b=MbyfzjkgcWpKW/6xaGtJ7JWEzP9pwxsJLmFUZGvo5au1tkg3ufPM/SPLt/aicKifu1
         Lpmkq68MGu2310sQzdBpdv6ts3Tw6w6xBkp63qWKuW9yDNLnMgd+hp7Iula1n5PQqFVz
         ZsJyTKfgttyuy3VbaJSqIVf3bMr4v7ASVoI5LRwizkYC4lnYQtM6nCB0qMugriTDT4IP
         45IZX+g4bz3/HQM7+FiR8bj8JWlgLyKD3U70Mznq6qmQXjtYgUys0jhdrRBbjyXFck6U
         TN6ty38TMKSiQ5Vc+TCycZVVmH5sDAHCwjEEAS4ooI0o4Bh4hY7nHW6nYA3hY/eJi0LS
         T2Ng==
X-Gm-Message-State: AOAM531mJwkxF4MrM+YGtV3fgr55KISe99HuW+HSmamhytWU8wFAYc6f
        ZcfWPXFZKKZ0EVA1Owsly78jr+xDJF12BA==
X-Google-Smtp-Source: ABdhPJyHW4vHQnfNg450tMEUP2Hud3vrWJ2VWq1H/0ZqnaessifvrZASsiLQpwOMJaSxXHF5Uz8WcA==
X-Received: by 2002:a1f:fc86:0:b0:32c:36f2:69d0 with SMTP id a128-20020a1ffc86000000b0032c36f269d0mr3079180vki.10.1645174412355;
        Fri, 18 Feb 2022 00:53:32 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id x24sm1993034vsk.29.2022.02.18.00.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 00:53:31 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id w128so3753361vkd.3;
        Fri, 18 Feb 2022 00:53:31 -0800 (PST)
X-Received: by 2002:a05:6122:130c:b0:330:e674:ec91 with SMTP id
 e12-20020a056122130c00b00330e674ec91mr2843712vkp.33.1645174411496; Fri, 18
 Feb 2022 00:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <20220215165226.2738568-3-geert@linux-m68k.org> <4fff0c08-adab-c1d5-4a7e-1513cb2bf7ca@suse.de>
 <CAMuHMdVK7eWfod73JQAntO=7BAMEcS-ktH4NJmDjna3zUn7giw@mail.gmail.com> <4ed13232-bee3-0bea-9abb-51bf9d0bf84b@suse.de>
In-Reply-To: <4ed13232-bee3-0bea-9abb-51bf9d0bf84b@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Feb 2022 09:53:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjXdfNSvy4tvTgxe16EHoZ1CnXKNXRoP4SVpHnSFLvAQ@mail.gmail.com>
Message-ID: <CAMuHMdXjXdfNSvy4tvTgxe16EHoZ1CnXKNXRoP4SVpHnSFLvAQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/fb-helper: Add support for DRM_FORMAT_C[124]
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Thomas,

On Fri, Feb 18, 2022 at 9:14 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 17.02.22 um 17:12 schrieb Geert Uytterhoeven:
> > On Thu, Feb 17, 2022 at 3:57 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 15.02.22 um 17:52 schrieb Geert Uytterhoeven:
> >>> Add support for color-indexed frame buffer formats with two, four, and
> >>> sixteen colors to the DRM framebuffer helper functions:
> >>>     1. Add support for depths 1/2/4 to the damage helper,
> >>>     2. For color-indexed modes, the length of the color bitfields must be
> >>>        set to the color depth, else the logo code may pick a logo with too
> >>>        many colors.  Drop the incorrect DAC width comment, which
> >>>        originates from the i915 driver.
> >>>     3. Accept C[124] modes when validating or filling in struct
> >>>        fb_var_screeninfo, and  use the correct number of bits per pixel.
> >>>     4. Set the visual to FB_VISUAL_PSEUDOCOLOR for all supported
> >>>        color-indexed modes.
> >>>
> >>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> >>> --- a/drivers/gpu/drm/drm_fb_helper.c
> >>> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >>> @@ -376,12 +376,34 @@ static void drm_fb_helper_damage_blit_real(struct drm_fb_helper *fb_helper,
> >>>                                           struct iosys_map *dst)
> >>>    {
> >>>        struct drm_framebuffer *fb = fb_helper->fb;
> >>> -     unsigned int cpp = fb->format->cpp[0];
> >>> -     size_t offset = clip->y1 * fb->pitches[0] + clip->x1 * cpp;
> >>> -     void *src = fb_helper->fbdev->screen_buffer + offset;
> >>> -     size_t len = (clip->x2 - clip->x1) * cpp;
> >>> +     size_t offset = clip->y1 * fb->pitches[0];
> >>> +     size_t len = clip->x2 - clip->x1;
> >>>        unsigned int y;
> >>> +     void *src;
> >>>
> >>> +     switch (fb->format->depth) {
> >>
> >> The depth field is deprecated. It's probably better to use
> >> fb->format->format and test against 4CC codes.
> >
> > The reason I checked for depth instead of a 4CC code is that the only
> > thing that matters here is the number of bits per pixel.  Hence this
> > function won't need any changes to support R1, R2, R4, and D1 later.
> > When we get here, we already know that we are using a format that
> > is supported by the fbdev helper code, and thus passed the 4CC
> > checks elsewhere.
>
> At some point, we will probably have to change several of these tests to
> 4cc. C8 and RGB332 both have 8-bit depth/bpp; same for C4 and RGB121; or
> whatever low-color formats we also want to add.
>
> It's not a blocker now, but maybe something to keep in mind.
>
> >
> > Alternatively, we could introduce drm_format_info_bpp() earlier in
> > the series, and use that?
>
> Having a helper for this might indeed be useful. We use depth for the
> number of color bits and bpp for the number of bits in he pixel.  That's
> important for XRGB8888, where depth is 24, or XRGB555 where depth is 15.
>
> If that makes sense, maybe have a helper for depth and one for bpp, even
> if they return the same value in most of the cases.

The helper for bpp is introduced in "[PATCH 3/8] drm/fourcc: Add
drm_format_info_bpp() helper".
I don't think we need a helper for depth, there's already the .depth
field.  It might be deprecated, but it's still used?
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

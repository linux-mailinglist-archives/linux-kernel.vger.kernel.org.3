Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C74BA57E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiBQQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:13:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiBQQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:13:22 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10416A590;
        Thu, 17 Feb 2022 08:13:06 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id m24so6810954vsp.7;
        Thu, 17 Feb 2022 08:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch9MypWpUQnZM5wHecAMH9Z6WzfQjeMjydR9fNyA8WE=;
        b=uTKFJVMqenpVj3i8C4IKfY1qZajwqUbnuQc/7DWfHW+WztzXnYDX9+9dscO3zogIys
         cnecczYn7LxAvCbfTn/neGx75PxeQfMXGT2uCfqNu7aqQxLEdtny08z3tTnn4iyccRlq
         u5JKLPCpU8Uq8FR7ziyoHTxxcQcBVugqP+LgkbpRs0j7NkfjtgnPOmD/YkfvuKPAg/7Q
         C0oLqacCxSjw/9AEAwj7NgsyBw7B3C3eWP1PGyUPk0WKuhoRIzW9QqdEUF6QjqmH2y7g
         Cp2K4N36AxnyS13O2sx0fVcfcvIQMxcyZX65W0FovP/CrHB/iaqgmGz8FOjKJbKpzm4K
         SlHQ==
X-Gm-Message-State: AOAM530RvE3J46c27pMgxxql4feqz0zJjjXLMzMKybeaZCh3ad4sDA/X
        gtty0lXuhHuV2m9ku0GqKxDEdn6OFIC3IA==
X-Google-Smtp-Source: ABdhPJxtdBoUf2pCT404xzsSZrmdg9BrdLxb/6yd3TibYDibQY0SMI39/y066sSVZ0RaZWFZoegLcA==
X-Received: by 2002:a67:fa93:0:b0:31b:738f:1954 with SMTP id f19-20020a67fa93000000b0031b738f1954mr1603015vsq.87.1645114385363;
        Thu, 17 Feb 2022 08:13:05 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id t24sm2297934vsk.27.2022.02.17.08.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 08:13:04 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id o129so3333054vko.7;
        Thu, 17 Feb 2022 08:13:04 -0800 (PST)
X-Received: by 2002:a05:6122:8c7:b0:32d:7e3:96c8 with SMTP id
 7-20020a05612208c700b0032d07e396c8mr1649377vkg.7.1645114384535; Thu, 17 Feb
 2022 08:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <20220215165226.2738568-3-geert@linux-m68k.org> <4fff0c08-adab-c1d5-4a7e-1513cb2bf7ca@suse.de>
In-Reply-To: <4fff0c08-adab-c1d5-4a7e-1513cb2bf7ca@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Feb 2022 17:12:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVK7eWfod73JQAntO=7BAMEcS-ktH4NJmDjna3zUn7giw@mail.gmail.com>
Message-ID: <CAMuHMdVK7eWfod73JQAntO=7BAMEcS-ktH4NJmDjna3zUn7giw@mail.gmail.com>
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

Thanks for your review!

On Thu, Feb 17, 2022 at 3:57 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 15.02.22 um 17:52 schrieb Geert Uytterhoeven:
> > Add support for color-indexed frame buffer formats with two, four, and
> > sixteen colors to the DRM framebuffer helper functions:
> >    1. Add support for depths 1/2/4 to the damage helper,
> >    2. For color-indexed modes, the length of the color bitfields must be
> >       set to the color depth, else the logo code may pick a logo with too
> >       many colors.  Drop the incorrect DAC width comment, which
> >       originates from the i915 driver.
> >    3. Accept C[124] modes when validating or filling in struct
> >       fb_var_screeninfo, and  use the correct number of bits per pixel.
> >    4. Set the visual to FB_VISUAL_PSEUDOCOLOR for all supported
> >       color-indexed modes.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -376,12 +376,34 @@ static void drm_fb_helper_damage_blit_real(struct drm_fb_helper *fb_helper,
> >                                          struct iosys_map *dst)
> >   {
> >       struct drm_framebuffer *fb = fb_helper->fb;
> > -     unsigned int cpp = fb->format->cpp[0];
> > -     size_t offset = clip->y1 * fb->pitches[0] + clip->x1 * cpp;
> > -     void *src = fb_helper->fbdev->screen_buffer + offset;
> > -     size_t len = (clip->x2 - clip->x1) * cpp;
> > +     size_t offset = clip->y1 * fb->pitches[0];
> > +     size_t len = clip->x2 - clip->x1;
> >       unsigned int y;
> > +     void *src;
> >
> > +     switch (fb->format->depth) {
>
> The depth field is deprecated. It's probably better to use
> fb->format->format and test against 4CC codes.

The reason I checked for depth instead of a 4CC code is that the only
thing that matters here is the number of bits per pixel.  Hence this
function won't need any changes to support R1, R2, R4, and D1 later.
When we get here, we already know that we are using a format that
is supported by the fbdev helper code, and thus passed the 4CC
checks elsewhere.

Alternatively, we could introduce drm_format_info_bpp() earlier in
the series, and use that?

>
> > +     case 1:
> > +             offset += clip->x1 / 8;
> > +             len = DIV_ROUND_UP(len + clip->x1 % 8, 8);
> > +             break;
> > +
>
> Style: no empty lines here.

OK.

> > +     case 2:
> > +             offset += clip->x1 / 4;
> > +             len = DIV_ROUND_UP(len + clip->x1 % 4, 4);
> > +             break;
> > +
> > +     case 4:
> > +             offset += clip->x1 / 2;
> > +             len = DIV_ROUND_UP(len + clip->x1 % 2, 2);
> > +             break;
> > +
>
> Can we handle case C8 like C[124]? Seems cleaner to me.

The cases above are purely to handle bpp < 8; they are not
about color-indexed vs. truecolor modes.
XRGB1111 mode would need to be handled above, too.

> > @@ -1231,19 +1253,30 @@ static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
> >   }
> >
> >   static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
> > -                                      u8 depth)
> > -{
> > -     switch (depth) {
> > -     case 8:
> > +                                      const struct drm_format_info *format)
> > +{
> > +     u8 depth = format->depth;
> > +
> > +     switch (format->format) {
> > +     // FIXME Perhaps
> > +     // #define DRM_FORMAT_C0 fourcc_code('C', '0', ' ', ' ')
>
> What is C0?

A non-existing color-indexed mode with zero colors ;-)
Introduced purely to make a check like in the comment below work.
What we really want to check here is if the mode is color-indexed
or not...

> > +     // if ((format & fourcc_code(0xff, 0xf8, 0xff, 0xff) == DRM_FORMAT_C0) ...
> > +     case DRM_FORMAT_C1:
> > +     case DRM_FORMAT_C2:
> > +     case DRM_FORMAT_C4:
> > +     case DRM_FORMAT_C8:
> >               var->red.offset = 0;
> >               var->green.offset = 0;
> >               var->blue.offset = 0;
> > -             var->red.length = 8; /* 8bit DAC */
> > -             var->green.length = 8;
> > -             var->blue.length = 8;
> > +             var->red.length = depth;
> > +             var->green.length = depth;
> > +             var->blue.length = depth;
> >               var->transp.offset = 0;
> >               var->transp.length = 0;
> > -             break;
> > +             return;
> > +     }
> > +
> > +     switch (depth) {
> >       case 15:
> >               var->red.offset = 10;
> >               var->green.offset = 5;
> > @@ -1298,7 +1331,9 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >   {
> >       struct drm_fb_helper *fb_helper = info->par;
> >       struct drm_framebuffer *fb = fb_helper->fb;
> > +     const struct drm_format_info *format = fb->format;
> >       struct drm_device *dev = fb_helper->dev;
> > +     unsigned int bpp;
> >
> >       if (in_dbg_master())
> >               return -EINVAL;
> > @@ -1308,22 +1343,34 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >               var->pixclock = 0;
> >       }
> >
> > -     if ((drm_format_info_block_width(fb->format, 0) > 1) ||
> > -         (drm_format_info_block_height(fb->format, 0) > 1))
> > -             return -EINVAL;
> > +     switch (format->format) {
> > +     case DRM_FORMAT_C1:
> > +     case DRM_FORMAT_C2:
> > +     case DRM_FORMAT_C4:
> > +             bpp = format->depth;
> > +             break;
>
> Added C8 here would be more consistent.

Again, this is not about color-indexed vs. truecolor, but about bpp.
drm_format_info_bpp()?

 > +
> > +     default:
> > +             if ((drm_format_info_block_width(format, 0) > 1) ||
> > +                 (drm_format_info_block_height(format, 0) > 1))
> > +                     return -EINVAL;
> > +
> > +             bpp = format->cpp[0] * 8;
> > +             break;
> > +     }

> > @@ -1680,11 +1727,20 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
> >   }
> >
> >   static void drm_fb_helper_fill_fix(struct fb_info *info, uint32_t pitch,
> > -                                uint32_t depth)
> > +                                uint32_t format)
> >   {
> >       info->fix.type = FB_TYPE_PACKED_PIXELS;
> > -     info->fix.visual = depth == 8 ? FB_VISUAL_PSEUDOCOLOR :
> > -             FB_VISUAL_TRUECOLOR;
> > +     switch (format) {

This one is about color-indexed vs. truecolor.

> > +     case DRM_FORMAT_C1:
> > +     case DRM_FORMAT_C2:
> > +     case DRM_FORMAT_C4:
> > +     case DRM_FORMAT_C8:
> > +             info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> > +             break;
> > +     default:
> > +             info->fix.visual = FB_VISUAL_TRUECOLOR;
> > +             break;
> > +     }
> >       info->fix.mmio_start = 0;
> >       info->fix.mmio_len = 0;
> >       info->fix.type_aux = 0;
> > @@ -1701,19 +1757,29 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
> >                                  uint32_t fb_width, uint32_t fb_height)
> >   {
> >       struct drm_framebuffer *fb = fb_helper->fb;
> > +     const struct drm_format_info *format = fb->format;
> >
> > -     WARN_ON((drm_format_info_block_width(fb->format, 0) > 1) ||
> > -             (drm_format_info_block_height(fb->format, 0) > 1));
> >       info->pseudo_palette = fb_helper->pseudo_palette;
> >       info->var.xres_virtual = fb->width;
> >       info->var.yres_virtual = fb->height;
> > -     info->var.bits_per_pixel = fb->format->cpp[0] * 8;
> > +     switch (format->format) {
> > +     case DRM_FORMAT_C1:
> > +     case DRM_FORMAT_C2:
> > +     case DRM_FORMAT_C4:
> > +             info->var.bits_per_pixel = format->depth;
> > +             break;
>
> C8.

Again, this is not about color-indexed vs. truecolor, but about bpp.
Here I do check the 4CC codes, as this controls which modes can be
handled by the fbdev emulation, and we do not want to let random
modes with depth or bpp < 8 pass.

> The fbdev helpers look correct to me.  I'm not so sure about the usage
> of the format info; especially the depth field.  The docs say that the
> field is deprecated and should be 0. Maybe depth can be handled within
> fbdev?

Perhaps. I don't know enough about DRM to know what the depth field
is used for.

Note that true fbdev supports all values of depth < bpp (e.g. a
32-color mode (depth = 5) where each pixel is stored in one byte).
I do not suggest adding support for that, though ;-)

> > +
> > +     default:
> > +             WARN_ON((drm_format_info_block_width(format, 0) > 1) ||
> > +                     (drm_format_info_block_height(format, 0) > 1));

BTW, probably this WARN_ON() (which existed before, but got moved)
should be converted into returning an error instead.

> > +             info->var.bits_per_pixel = format->cpp[0] * 8;
> > +     }
> >       info->var.accel_flags = FB_ACCELF_TEXT;
> >       info->var.xoffset = 0;
> >       info->var.yoffset = 0;
> >       info->var.activate = FB_ACTIVATE_NOW;
> >
> > -     drm_fb_helper_fill_pixel_fmt(&info->var, fb->format->depth);
> > +     drm_fb_helper_fill_pixel_fmt(&info->var, format);
> >
> >       info->var.xres = fb_width;
> >       info->var.yres = fb_height;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

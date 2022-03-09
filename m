Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64634D2FC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiCINPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiCINPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:15:45 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D3616BF94;
        Wed,  9 Mar 2022 05:14:47 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id o22so1768128qta.8;
        Wed, 09 Mar 2022 05:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUvHkX5812DRzHn1EeBQVzC3fP1RFckTmLb18DWoP3k=;
        b=6wHKbUNbojhRwIiQDr9dO5S9/0jaMiZ0uNM3YctyP79ldtZbFXWga5qoZNADrFhf1o
         O6mThS2UHOzRI35EMqx1lKUDrqNH1qv94UHMoLFq9KMLCWX6LE4dfWi3oT+jTlIJXtLy
         527IHtqr7BYxrQNj6exADxXkOvSp/ThTpRYJJYgZrMoBKyQacJVolaogqeLXGMy7q+fU
         5LLkxj8y0PN4WLqGKl9hhUPKqfLGdJDv+wGooTbgKnG8/OTkOmDvD6kqVbbD1XXOf7un
         TAqwkYeyBWvRAz1/sd1QtliXW/BkM5YoS0mZIZkL4KaACFYxyM75HVHx7DHPEu1Ng3jr
         CCaQ==
X-Gm-Message-State: AOAM5329fz7ldQYda+Y3PCAurzwXaK8CmhC+tZZyWELLDPE/D83uoXc4
        8PW1LuJPu3Qui6Lmh4+RnjVcYoXGxnYXXw==
X-Google-Smtp-Source: ABdhPJzEzDR50mDZSfeGC6D0g8OQll9ZINOWap6xYu3WWtZ7RMt7TRCGdJoVuUJqnqR+Qrd4aULJYg==
X-Received: by 2002:a05:622a:14d0:b0:2e0:64e7:3920 with SMTP id u16-20020a05622a14d000b002e064e73920mr12808558qtx.61.1646831685321;
        Wed, 09 Mar 2022 05:14:45 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id a10-20020a05622a02ca00b002e06585f36csm1234115qtx.23.2022.03.09.05.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:14:44 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id h126so4288870ybc.1;
        Wed, 09 Mar 2022 05:14:44 -0800 (PST)
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr16176129ybp.506.1646831684073; Wed, 09
 Mar 2022 05:14:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646683502.git.geert@linux-m68k.org> <c665d6ba072f3debb3fa0a139454fefef6a55011.1646683502.git.geert@linux-m68k.org>
 <355f94c7-fc8a-7d92-5979-5b1b49c1d738@redhat.com>
In-Reply-To: <355f94c7-fc8a-7d92-5979-5b1b49c1d738@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Mar 2022 14:14:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8X1k1BeHoNOGkTQq4bQM5bpr7nMzVfzD6VYB7vvuWNw@mail.gmail.com>
Message-ID: <CAMuHMdV8X1k1BeHoNOGkTQq4bQM5bpr7nMzVfzD6VYB7vvuWNw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] drm/fb-helper: Add support for DRM_FORMAT_C[124]
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
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

Hi Javier,

On Wed, Mar 9, 2022 at 2:10 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 3/7/22 21:52, Geert Uytterhoeven wrote:
> > Add support for color-indexed frame buffer formats with two, four, and
> > sixteen colors to the DRM framebuffer helper functions:
> >   1. Add support for 1, 2, and 4 bits per pixel to the damage helper,
> >   2. For color-indexed modes, the length of the color bitfields must be
> >      set to the color depth, else the logo code may pick a logo with too
> >      many colors.  Drop the incorrect DAC width comment, which
> >      originates from the i915 driver.
> >   3. Accept C[124] modes when validating or filling in struct
> >      fb_var_screeninfo, and use the correct number of bits per pixel.
> >   4. Set the visual to FB_VISUAL_PSEUDOCOLOR for all color-indexed
> >      modes.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> [snip]
>
> >  static void drm_fb_helper_fill_fix(struct fb_info *info, uint32_t pitch,
> > -                                uint32_t depth)
> > +                                bool is_color_indexed)
> >  {
> >       info->fix.type = FB_TYPE_PACKED_PIXELS;
> > -     info->fix.visual = depth == 8 ? FB_VISUAL_PSEUDOCOLOR :
> > -             FB_VISUAL_TRUECOLOR;
> > +     info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
> > +                                         : info->fix.visual;
>
> Shouldn't this be the following instead ?
>
>   +     info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
>   +                                         : FB_VISUAL_TRUECOLOR;

Indeed. Will fix in v3.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

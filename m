Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE04B9D69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiBQKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:42:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiBQKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:42:56 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD16293B73;
        Thu, 17 Feb 2022 02:42:42 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id k128so2779607vkk.10;
        Thu, 17 Feb 2022 02:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URz3vGbBYIEN5IQJZpThn97AmYBtZHbYQoPJObvpYus=;
        b=G3Gd/cOW9B4p+iV9e4iuBpBPl644LnwAqTqPVZetBGkmj2jYS93B83PoMV+tstJofv
         ++k0BjCioqKsuqwInJ1BFPIw61kIAGRMBz82LEJ+BhHZVY7BPtTLH6g64Gb53TIOJqoD
         bkFgb21fFzy66ZMKAcqNOGHD+Qw89rr+uQVPKyza0L9MabqkqKI59cpl/k1uLXnVeK94
         t7MmqRn0dcW0gavykd8pjPpUjY6OXMGsx2cVSmRCKRvb6LbhYlULDUCBePv+kRLDTe63
         aGuo7Jd3oq0hFn3lyvSczcIGFVGa5ahyKPlKetKXPSsZEbEm63eJUG2nJCFXONlS8wcu
         bJLQ==
X-Gm-Message-State: AOAM533stlObAXiB8Ny1shBVhToRl/cJaTUJTY0OKacUSmqJJP8+CWny
        KrZaQf0ok69R/5FpCZC9WdwOstFKMrKaHw==
X-Google-Smtp-Source: ABdhPJxnktVpuCw857SVyJr4O9PFDjXNYxsMStC78sWGoiVxBEDELRuDgXzFxOOJ3DEsGsXG2Vd1ow==
X-Received: by 2002:a05:6122:d9e:b0:331:33da:48e5 with SMTP id bc30-20020a0561220d9e00b0033133da48e5mr584012vkb.35.1645094561145;
        Thu, 17 Feb 2022 02:42:41 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 17sm6720336vky.10.2022.02.17.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:42:40 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id g18so2449987uak.5;
        Thu, 17 Feb 2022 02:42:40 -0800 (PST)
X-Received: by 2002:ab0:750e:0:b0:33e:8f30:e8ec with SMTP id
 m14-20020ab0750e000000b0033e8f30e8ecmr816005uap.114.1645094560576; Thu, 17
 Feb 2022 02:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <20220215165226.2738568-9-geert@linux-m68k.org> <20220217121033.0fc7f6ba@eldfell>
In-Reply-To: <20220217121033.0fc7f6ba@eldfell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Feb 2022 11:42:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXf3tFLb16Y=wh5C3QUYN4PdCjaYPCzMOTCye-eYS-N8w@mail.gmail.com>
Message-ID: <CAMuHMdXf3tFLb16Y=wh5C3QUYN4PdCjaYPCzMOTCye-eYS-N8w@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/fourcc: Add DRM_FORMAT_D1
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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

Hi Pekka,

On Thu, Feb 17, 2022 at 11:10 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Tue, 15 Feb 2022 17:52:26 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Introduce a fourcc code for a single-channel frame buffer format with two
> > darkness levels.  This can be used for two-level dark-on-light displays.
> >
> > As the number of bits per pixel is less than eight, this relies on
> > proper block handling for the calculation of bits per pixel and pitch.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -151,6 +151,8 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >               { .format = DRM_FORMAT_C4,              .depth = 4,  .num_planes = 1,
> >                 .char_per_block = { 1, }, .block_w = { 2, }, .block_h = { 1, }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_C8,              .depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
> > +             { .format = DRM_FORMAT_D1,              .depth = 1,  .num_planes = 1,
> > +               .char_per_block = { 1, }, .block_w = { 8, }, .block_h = { 1, }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_R1,              .depth = 1,  .num_planes = 1,
> >                 .char_per_block = { 1, }, .block_w = { 8, }, .block_h = { 1, }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_R2,              .depth = 2,  .num_planes = 1,
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 8605a1acc6813e6c..c15c6efcc65e5827 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -104,6 +104,9 @@ extern "C" {
> >  #define DRM_FORMAT_C4                fourcc_code('C', '4', ' ', ' ') /* [3:0] C */
> >  #define DRM_FORMAT_C8                fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> >
> > +/* 1 bpp Darkness */
> > +#define DRM_FORMAT_D1                fourcc_code('D', '1', ' ', ' ') /* [0] D */
> > +
>
> the same comment here as for C1 and R1 formats, need to specify pixel
> ordering inside a byte.

Right, will do.

> I think it would also be good to explain the rationale why C1 and R1
> are not suitable for this case and we need yet another 1-bit format in
> the commit message.
>
> For posterity, of course. I roughly remember the discussions.

C1 is color-indexed, which can be any two colors.
R1 is light-on-dark.
D1 is dark-on-light.

> I also wonder if anyone would actually use D1. Should it be added
> anyway? There is no rule that a pixel format must be used inside the
> kernel AFAIK, but is there even a prospective userspace wanting this?
>
> Exposing R1 and inverting bits while copying to hardware might be
> enough?

That's an option.  The repaper driver does that:

    drm_fb_xrgb8888_to_gray8(buf, 0, cma_obj->vaddr, fb, &clip);
    repaper_gray8_to_mono_reversed(buf, fb->width, fb->height);

Can drm_framebuffer objects be backed by graphics memory, i.e.
can they be displayed without copying?

> >  /* 1 bpp Red */
> >  #define DRM_FORMAT_R1                fourcc_code('R', '1', ' ', ' ') /* [0] R */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

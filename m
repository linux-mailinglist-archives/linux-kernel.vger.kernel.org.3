Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F045906BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiHKStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiHKStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:49:32 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D6D9DB62;
        Thu, 11 Aug 2022 11:49:30 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id h22so8718624qtu.2;
        Thu, 11 Aug 2022 11:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RhMgUDFA93QBx75MeKT6IhTNiHWRpz583vvBHXd9MR4=;
        b=mrT1JAXVc3Abr3ATl4rOs5VPY4cay0/AJtaq82lisovDyRPOp2KJdTt7/AH7kfjfMA
         T5bYRJkNvKDGfUE2VnYkil36G5TQTkKT9Jcj4p6txyXYCKT5HWFE7hVLcDnENDGO3x1Y
         wiXDREkpNvR1uAkqP9MUWOckzMG3BBTCLoUZD56An54POqGSceIK6QUIAQOKWeimKibw
         9mulIs9M+jWa+6LX9dsValo6kAcfgbuSeddQW+QhX1+54LuvuEdu4aZ2n7CjZ5uLine5
         iODxUl8WSKHkiRs5zYZLltgfNN89Qme2BRIZk4exDMlOHNWp3QchiVK9Sw0nRbWTeuCT
         hrcg==
X-Gm-Message-State: ACgBeo1DTWf4zJdC8mlPblaae7RiUrz80hNN+5UesBvP4kOgn9yooAzk
        CfU51X+SIvYP+r6OsRRJrSvJ7hG05hBG1QUo
X-Google-Smtp-Source: AA6agR5dUbfxBAjdtTIjhkzHKOQKq7ZXJn0esKtI+Mj9YdHcLUoFjIFyWzpy1el6zSNATtWrxwDRMg==
X-Received: by 2002:ac8:7d14:0:b0:343:6db3:9e6c with SMTP id g20-20020ac87d14000000b003436db39e6cmr431498qtb.251.1660243769772;
        Thu, 11 Aug 2022 11:49:29 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05620a318900b006b5f0e8d1b9sm31170qkb.81.2022.08.11.11.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 11:49:27 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31f41584236so181932147b3.5;
        Thu, 11 Aug 2022 11:49:26 -0700 (PDT)
X-Received: by 2002:a81:1204:0:b0:322:7000:4ecb with SMTP id
 4-20020a811204000000b0032270004ecbmr582563yws.47.1660243765824; Thu, 11 Aug
 2022 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657294931.git.geert@linux-m68k.org> <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
 <YvPVxy4kYKdzWgT8@phenom.ffwll.local> <CAMuHMdVMuuXgYW-AkyB+G77Wsjkm715u1ifDvaY=5DufXjryRA@mail.gmail.com>
 <YvUqPL5l8/+XbvaQ@phenom.ffwll.local> <YvVKe72jYBjucmkz@ravnborg.org>
In-Reply-To: <YvVKe72jYBjucmkz@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 20:49:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVD37MCXau4w87=x_jk9j-NMJCmu0d9qPuMqmHA_vPQRQ@mail.gmail.com>
Message-ID: <CAMuHMdVD37MCXau4w87=x_jk9j-NMJCmu0d9qPuMqmHA_vPQRQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] drm/fourcc: Add drm_format_info_bpp() helper
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
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

Hi Sam,

On Thu, Aug 11, 2022 at 8:29 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Thu, Aug 11, 2022 at 06:11:40PM +0200, Daniel Vetter wrote:
> > On Thu, Aug 11, 2022 at 09:59:39AM +0200, Geert Uytterhoeven wrote:
> > > On Wed, Aug 10, 2022 at 5:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > On Fri, Jul 08, 2022 at 08:20:46PM +0200, Geert Uytterhoeven wrote:
> > > > > Add a helper to retrieve the actual number of bits per pixel for a
> > > > > plane, taking into account the number of characters and pixels per
> > > > > block for tiled formats.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > >
> > > > > --- a/drivers/gpu/drm/drm_fourcc.c
> > > > > +++ b/drivers/gpu/drm/drm_fourcc.c
> > > > > @@ -370,6 +370,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
> > > > >  }
> > > > >  EXPORT_SYMBOL(drm_format_info_block_height);
> > > > >
> > > > > +/**
> > > > > + * drm_format_info_bpp - number of bits per pixel
> > > > > + * @info: pixel format info
> > > > > + * @plane: plane index
> > > > > + *
> > > > > + * Returns:
> > > > > + * The actual number of bits per pixel, depending on the plane index.
> > > > > + */
> > > > > +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
> > > > > +{
> > > > > +     if (!info || plane < 0 || plane >= info->num_planes)
> > > > > +             return 0;
> > > > > +
> > > > > +     return info->char_per_block[plane] * 8 /
> > > > > +            (drm_format_info_block_width(info, plane) *
> > > > > +             drm_format_info_block_height(info, plane));
> > > >
> > > > Do we really needs this for blocky formats where this is potentially
> > > > ill-defined? I think if there's no need then this should also return 0
> > > > when block_width/height != 1, it doesn't make much sense to compute bpp
> > > > when it's not really bits per _pixel_.
> > >
> > > Yes, we do need this.  For low-color formats, the number of bits
> > > per pixel is less than eight, and block_width is larger than one.
> > > That is actually the point of this patch.
> >
> > Hm right, I didn't realize that this is how we have to describe the
> > formats with less than 8 bpp.
> >
> > I think we can include them easily with a check for char_per_block == 1
> > and then making sure that the division does not have a reminder (just in
> > case someone does something really funny, it could e.g. be a 332 layout or
> > something like that for 3 pixels).
> >
> > > > Minimally this needs to check whether the division actually makes sense or
> > > > whether there's a reminder, and if there's  reminder, then fail. But that
> > > > feels like a bad hack and I think we should avoid it if it's not
> > > > absolutely necessary.
> > >
> > > Looking at drivers/gpu/drm/drm_fourcc.c, the only supported format
> > > where there can be a remainder is P030, which has 2 spare bits per
> > > 32-bit word, and thus is special anyway.
> > > Still, 4 * 8 / 3 = 10, so you get the correct numbers of bits for
> > > the first plane.  For the second plane, you get 8 * 8 / 3 = 21,
> > > but as .is_yuv = true, you have to divide that result by two again,
> > > so you get 10 again.
> >
> > Yeah I don't think we should describe these with bpp or cpp or anything
> > like that. bpp < 8 makes sense since that's how this has been done since
> > decades, but trying to extend these to funny new formats is a bad idea.
> > This is also why cpp and depth refuse to compute these (or at least
> > should).
>
> Daniel and I discussed this on irc. Let me try to recap here.
> Using the bits per pixel info from drm_format_info is something we shall
> try to avoid as this is often a sign of the wrong abstraction/design (my
> words based on the irc talk).
> So we shall limit the use of drm_format_info_bpp() to what we need now,
> thus blocky formats should not be supported - to try to avoid seeing
> this used more than necessary.
>
> Daniel suggested a rename to drm_format_info_legacy_bpp() to make it
> obvious that this is often/always the wrong solution. I did not jump on
> doing the rename as I do not know stuff good enough to tell people what
> to use when this is not the right solution. The rename is simple, it is
> the follow-up that keep me away.
>
> On top of this there is a few formats in drm_drourcc that has a depth
> field set which should be dropped. .depth is only for the few legacy
> formats where it is used today.
>
> We would also like to convert the fbdev helpers to drm_format_info,
> and doing so will likely teach us a bit more what we need and what we
> can drop.
>
> Geert - can you give drm_format_info_bpp() a spin so it is limited to
> the formats used now (not the blocky ones).

You mean return 0 if char_per_block[] > 1?
I'm not sure it's actually safe to do so (and make this change this late
in the development cycle), as this is used in drm_client_buffer_create(),
drm_client_buffer_addfb(), and drm_mode_getfb().  Some of them do
rely on bpp to be non-zero.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

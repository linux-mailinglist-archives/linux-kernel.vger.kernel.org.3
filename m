Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419858F8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiHKIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiHKH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:59:55 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1B8E9AE;
        Thu, 11 Aug 2022 00:59:54 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id a4so8261608qto.10;
        Thu, 11 Aug 2022 00:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mzt9xiZn2UZTlTKHVMvt4CFBZHRE5sVzzM2CBT3iHn0=;
        b=pTdmlRWEUv7hnG7gNZeG7U0LqUmOkF4SQ9JswnJhOhMEm1T8IpKQteS2+VdGooCB/5
         CMCFjpRXZzCyJu271gz/UIE2E2cq5wcmOpoduz0NyXPnzQb9zU9Dfe+kPqBb4saHKU+h
         WQZyy30fy4qw8IDv4JQ3o2RtJARmjn7QboGz3oB7vEZNwq0RxqrVM97fAU55Fxfnvc3G
         vPpgbFi7E80SYdk5hhmKifHvcjXKCe9KKJkkWtYhoubg4y6UQbzeL/eB0/wr/120naDe
         +iuwvTkW9SOpdegqExBwm8F8eP9LnGbUNlp4ORkUJSgpGou9hz71WstDnzXFCRg+eska
         FH6w==
X-Gm-Message-State: ACgBeo1PBRar37v4bLgukPzYXW51ElUotzSqLuQELkfV5N/8fGN/bnOr
        aUVnjzIDpnMWq3SnuNnBNwlKo+1gYnePQEQQ
X-Google-Smtp-Source: AA6agR5UjelKsbv85y1qDnOXW7mjDM3CWvFXbSNzwYa3xa5S/qotktjR3sWL/K98ghfVPgyVLdPD4g==
X-Received: by 2002:a05:622a:3d2:b0:31f:1e36:4782 with SMTP id k18-20020a05622a03d200b0031f1e364782mr26837995qtx.190.1660204792844;
        Thu, 11 Aug 2022 00:59:52 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a408400b006b46a78bc0fsm1479308qko.118.2022.08.11.00.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 00:59:51 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31f661b3f89so165054187b3.11;
        Thu, 11 Aug 2022 00:59:51 -0700 (PDT)
X-Received: by 2002:a81:b049:0:b0:324:7408:94b with SMTP id
 x9-20020a81b049000000b003247408094bmr31043465ywk.283.1660204791329; Thu, 11
 Aug 2022 00:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657294931.git.geert@linux-m68k.org> <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
 <YvPVxy4kYKdzWgT8@phenom.ffwll.local>
In-Reply-To: <YvPVxy4kYKdzWgT8@phenom.ffwll.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 09:59:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMuuXgYW-AkyB+G77Wsjkm715u1ifDvaY=5DufXjryRA@mail.gmail.com>
Message-ID: <CAMuHMdVMuuXgYW-AkyB+G77Wsjkm715u1ifDvaY=5DufXjryRA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] drm/fourcc: Add drm_format_info_bpp() helper
To:     Daniel Vetter <daniel@ffwll.ch>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Aug 10, 2022 at 5:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Jul 08, 2022 at 08:20:46PM +0200, Geert Uytterhoeven wrote:
> > Add a helper to retrieve the actual number of bits per pixel for a
> > plane, taking into account the number of characters and pixels per
> > block for tiled formats.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -370,6 +370,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
> >  }
> >  EXPORT_SYMBOL(drm_format_info_block_height);
> >
> > +/**
> > + * drm_format_info_bpp - number of bits per pixel
> > + * @info: pixel format info
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The actual number of bits per pixel, depending on the plane index.
> > + */
> > +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
> > +{
> > +     if (!info || plane < 0 || plane >= info->num_planes)
> > +             return 0;
> > +
> > +     return info->char_per_block[plane] * 8 /
> > +            (drm_format_info_block_width(info, plane) *
> > +             drm_format_info_block_height(info, plane));
>
> Do we really needs this for blocky formats where this is potentially
> ill-defined? I think if there's no need then this should also return 0
> when block_width/height != 1, it doesn't make much sense to compute bpp
> when it's not really bits per _pixel_.

Yes, we do need this.  For low-color formats, the number of bits
per pixel is less than eight, and block_width is larger than one.
That is actually the point of this patch.

> Minimally this needs to check whether the division actually makes sense or
> whether there's a reminder, and if there's  reminder, then fail. But that
> feels like a bad hack and I think we should avoid it if it's not
> absolutely necessary.

Looking at drivers/gpu/drm/drm_fourcc.c, the only supported format
where there can be a remainder is P030, which has 2 spare bits per
32-bit word, and thus is special anyway.
Still, 4 * 8 / 3 = 10, so you get the correct numbers of bits for
the first plane.  For the second plane, you get 8 * 8 / 3 = 21,
but as .is_yuv = true, you have to divide that result by two again,
so you get 10 again.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D904D9B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbiCOMuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiCOMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:50:15 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4ADF3F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:49:02 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id b67so15343013qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKZh5yP21BRJU6B3iVZohrjJUcGpXAcyv437fSYRC0Y=;
        b=Yv1MkmspeBbwsRJ2pamOnZE1WC5H25bDWwOngkXuqoBHKv1RwetJKfDBhO5KC+CN6f
         G7nJo/AwN6nt3dBgrnuryWu2c9Lmu3AHoKrRmwJRug27mzXAp5IH7WVNR4KlpUs1YAY+
         mP1ayzFjodrY5qk3bTXnLTzZmX6VNRdv3ZwUw0zsJKvb31VTVSNau2cg5pGcBLfNAo2c
         +SnnHvign1o6aTjFrq9NQj0w6YeFbHWNxMG/Y8X2M4YbQVpUtUv1nLFczkpk/7nQfI6W
         9bE4NMi3JkkcOuMXg2P/Mpq838BnD0nJTA8x4sWQpDzchM+iOQd4EwrERdudzh+azoBh
         W3cg==
X-Gm-Message-State: AOAM533yefA24/Ti/tKuYaHUR+qIOwi1wA9ZWhaJWwmOuXl8WIPgeY4D
        h2fZ7b/nDQ6ioErb/F7h9HUPhMg2RLs3Xw==
X-Google-Smtp-Source: ABdhPJyxGcR73e86Ig648PVGCnCHgzdK7E53jVPCTyd9yJ037yU9qLMTKRmCFYoFn4dCiYm704M8+A==
X-Received: by 2002:a05:620a:f03:b0:67b:1465:d447 with SMTP id v3-20020a05620a0f0300b0067b1465d447mr17756793qkl.364.1647348541477;
        Tue, 15 Mar 2022 05:49:01 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002e1e5e57e0csm406063qtx.11.2022.03.15.05.49.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:49:00 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2dbd97f9bfcso199791827b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:49:00 -0700 (PDT)
X-Received: by 2002:a81:49d0:0:b0:2db:dc6d:445d with SMTP id
 w199-20020a8149d0000000b002dbdc6d445dmr24764496ywa.512.1647348539863; Tue, 15
 Mar 2022 05:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220315110707.628166-1-geert@linux-m68k.org> <20220315110707.628166-3-geert@linux-m68k.org>
 <27e1c911-798a-c14b-e5a0-622a7c5d8755@redhat.com>
In-Reply-To: <27e1c911-798a-c14b-e5a0-622a7c5d8755@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 13:48:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQ=A1uRYdO+da9wFpzLbGEDprVjnuFcD8B=MPkOePEKw@mail.gmail.com>
Message-ID: <CAMuHMdUQ=A1uRYdO+da9wFpzLbGEDprVjnuFcD8B=MPkOePEKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/format-helper: Fix XRGB888 to monochrome conversion
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

Hi Javier,

On Tue, Mar 15, 2022 at 1:18 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 3/15/22 12:07, Geert Uytterhoeven wrote:
> > The conversion functions drm_fb_xrgb8888_to_mono() and
> > drm_fb_gray8_to_mono_line() do not behave correctly when the
> > horizontal boundaries of the clip rectangle are not multiples of 8:
> >   a. When x1 % 8 != 0, the calculated pitch is not correct,
> >   b. When x2 % 8 != 0, the pixel data for the last byte is wrong.
> >
>
> Thanks a lot for tracking down and fixing these issues.
>
> > Simplify the code and fix (a) by:
> >   1. Removing start_offset, and always storing the first pixel in the
> >      first bit of the monochrome destination buffer.
> >      Drivers that require the first pixel in a byte to be located at an
> >      x-coordinate that is a multiple of 8 can always align the clip
> >      rectangle before calling drm_fb_xrgb8888_to_mono().
> >      Note that:
> >        - The ssd130x driver does not need the alignment, as the
> >        monochrome buffer is a temporary format,
> >        - The repaper driver always updates the full screen, so the clip
> >        rectangle is always aligned.
> >   2. Passing the number of pixels to drm_fb_gray8_to_mono_line(),
> >      instead of the number of bytes, and the number of pixels in the
> >      last byte.
> >
> > Fix (b) by explicitly setting the target bit, instead of always setting
> > bit 7 and shifting the value in each loop iteration.
> >
> > Remove the bogus pitch check, which operates on bytes instead of pixels,
> > and triggers when e.g. flashing the cursor on a text console with a font
> > that is 8 pixels wide.
> >
> > Drop the confusing comment about scanlines, as a pitch in bytes always
> > contains a multiple of 8 pixels.
> >
> > While at it, use the drm_rect_height() helper instead of open-coding the
> > same operation.
> >
> > Update the comments accordingly.
> >
> > Fixes: bcf8b616deb87941 ("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

> I just have a small comment below.
>
> [snip]
>
> > +static void drm_fb_gray8_to_mono_line(u8 *dst, const u8 *src, unsigned int pixels)
> > +{
> > +     while (pixels) {
> > +             unsigned int i, bits = min(pixels, 8U);
> > +             u8 byte = 0;
> >
> > -                     byte >>= 1;
> > -                     if (src[x] >> 7)
> > -                             byte |= BIT(7);
> > +             for (i = 0; i < bits; i++, pixels--) {
>
> I think is worth to add a comment here explaining that the pixel is set to
> 1 for brightness > 127 and to 0 for brightness < 128. Or as kernel-doc for
> this helper function.
>
> > +                     if (*src++ & BIT(7))
>
> Pekka also mentioned that if (*src++ > 127) would make this easier to read.

Sure, will update. Nicely removes the need for a comment.

> > +                             byte |= BIT(i);
> >               }
> >               *dst++ = byte;
> >       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

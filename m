Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE874D9C61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiCONij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiCONih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:38:37 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5452E31
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:37:26 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id 1so14867600qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeUBfYy1MF3rdgCkqnY1ulVb8mmjHkjr8oT5jWm5FTE=;
        b=xhZrdSm7Hmgj9vj5pwALuUD6riyBh4nTM10XaHiBNsqwYKsy1EqRvdMPKeQ3p5gIxQ
         nL3ZjxAhI86avrwzboJ9Rzu+U3kacCtAxIsmfLMjr5D7un7lizei/Ndq0qcWOARbTTgE
         IRST/s/wlCTDrEX7bFghRkXbcItv270xdWA7349ZQCRtnvIEJ+Y9Lp4L8LnTEDZmAmLE
         3ybsYyWPqQmib2sdkSpB4IVE8NBPkCo0qXXJ2sorhnXO5F4rei2A451QwgMn+2RXiu36
         pXOxh/818tgy4R1U2wCTu/601nYVtHXKQYH5w/ylN8+Xdz5GILs4tv7tO+2rXIwhqnsP
         3N+A==
X-Gm-Message-State: AOAM53014WimcD8WAZ1aGA4PB4Wpy1v0SYiK2Emv9kw99TmaH43LIqiA
        nopse7+oKugAH5RwRnQJKb812SdxJcxOUw==
X-Google-Smtp-Source: ABdhPJxsfNCsmbjrjL53qpBbPvLazirKoVbtqdE5JknMz5t6TynIyLEOqrBxgPHHWDUNB2Jvzx7mMQ==
X-Received: by 2002:a37:a0ca:0:b0:67d:b628:6a4e with SMTP id j193-20020a37a0ca000000b0067db6286a4emr8562320qke.35.1647351444900;
        Tue, 15 Mar 2022 06:37:24 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a111c00b0067d3b9ef388sm8794919qkk.98.2022.03.15.06.37.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 06:37:24 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2e5757b57caso45906217b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:37:24 -0700 (PDT)
X-Received: by 2002:a81:5247:0:b0:2dc:2171:d42 with SMTP id
 g68-20020a815247000000b002dc21710d42mr24161091ywb.438.1647351444178; Tue, 15
 Mar 2022 06:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220315110707.628166-1-geert@linux-m68k.org> <20220315110707.628166-2-geert@linux-m68k.org>
 <YjCVesysvfpKNilD@smile.fi.intel.com>
In-Reply-To: <YjCVesysvfpKNilD@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 14:37:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUXT4u_ewtHP4oCk6uOvu3a0M_mZAq+jf3MC97sOp5VEQ@mail.gmail.com>
Message-ID: <CAMuHMdUXT4u_ewtHP4oCk6uOvu3a0M_mZAq+jf3MC97sOp5VEQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/format-helper: Rename drm_fb_xrgb8888_to_mono_reversed()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
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

Hi Andy,

On Tue, Mar 15, 2022 at 2:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 15, 2022 at 12:07:03PM +0100, Geert Uytterhoeven wrote:
> > There is no "reversed" handling in drm_fb_xrgb8888_to_mono_reversed():
> > the function just converts from color to grayscale, and reduces the
> > number of grayscale levels from 256 to 2 (i.e. brightness 0-127 is
> > mapped to 0, 128-255 to 1).  All "reversed" handling is done in the
> > repaper driver, where this function originated.
> >
> > Hence make this clear by renaming drm_fb_xrgb8888_to_mono_reversed() to
> > drm_fb_xrgb8888_to_mono(), and documenting the black/white pixel
> > mapping.
>
> W/ or w/o the below remark being addressed
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> > --- a/drivers/gpu/drm/drm_format_helper.c
> > +++ b/drivers/gpu/drm/drm_format_helper.c
> > @@ -692,12 +692,12 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
> >       for (y = 0; y < lines; y++) {
> >               src32 = memcpy(src32, vaddr, len_src32);
> >               drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
> > -             drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch,
> > -                                                start_offset, end_len);
>
> > +             drm_fb_gray8_to_mono_line(mono, gray8, dst_pitch, start_offset,
> > +                                       end_len);
>
> Can be one line now (definition is already quite behind 80 limit).

Yeah, but the code isn't.
Nevertheless, this will be shortened in a later patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

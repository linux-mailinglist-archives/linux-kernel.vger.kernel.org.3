Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79694D9CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiCOODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348991AbiCOODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:03:02 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39135546A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:01:36 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id q194so15535514qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGgF9LWm/bth2hHo7Fl5/pn1/+WNkNT5qOPZV+7l+iA=;
        b=Hz0MIq5llHrEeTTI1frLKAnv1sutQLuMBMAcAopGd+KLzjDYput7R/NuZQfAF+lDiT
         gaenALOjUpfzPRyJXUSE6GHaVOJWarr/1fw87YKRwVTvCLNubs2ul1w5W79qRx0OnqKF
         5jvlyN63U2QsTcsRZIrlo/c7kzfd1afh94UTJFa5n6tP4xLj9duqGYV9XkBJZNmXYk0M
         9cL0Q9laB/J6Xez1hnFFjFC0E85atj+YA+DjnEvL3vAgWMaaK4kZtJdsQ+PXpWdGUez+
         g+s22frPGB4Y8KovtvhTDrfOhilSXsL1Z6ybxfKJAawzvJBltnVKlUdPPRmGKwyqhnoa
         7+zw==
X-Gm-Message-State: AOAM531eVBLFZn7RjPBK2TFsPSvSi9+fBbJLMNC2S3pXdNJeHOSAEIvn
        o0j5GICM6sJ1D+FoFxosLkEqMfFE9/dAbw==
X-Google-Smtp-Source: ABdhPJxuJf9UqVcNQJ7ZZ5sGs66B0bM/cTyqLKgMSRkOWQiTalPXD+Yl0RiqP3YhRUdiOaYF3bSFhQ==
X-Received: by 2002:a05:620a:244f:b0:67d:ccec:3eaa with SMTP id h15-20020a05620a244f00b0067dccec3eaamr6965710qkn.744.1647352895423;
        Tue, 15 Mar 2022 07:01:35 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a108900b0067b13036bd5sm9294345qkk.52.2022.03.15.07.01.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 07:01:35 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j2so37606281ybu.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:01:34 -0700 (PDT)
X-Received: by 2002:a25:4fc4:0:b0:633:25c8:7d9 with SMTP id
 d187-20020a254fc4000000b0063325c807d9mr11648807ybb.506.1647352894696; Tue, 15
 Mar 2022 07:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220315110707.628166-1-geert@linux-m68k.org> <20220315110707.628166-5-geert@linux-m68k.org>
 <YjCZkkv//EhvxszH@smile.fi.intel.com>
In-Reply-To: <YjCZkkv//EhvxszH@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 15:01:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXisdGd2QWPEpi0sUMP3ZZr1S82=S9A=BSYmeYHySGemQ@mail.gmail.com>
Message-ID: <CAMuHMdXisdGd2QWPEpi0sUMP3ZZr1S82=S9A=BSYmeYHySGemQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm: ssd130x: Reduce temporary buffer sizes
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

On Tue, Mar 15, 2022 at 2:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 15, 2022 at 12:07:06PM +0100, Geert Uytterhoeven wrote:
> > ssd130x_clear_screen() allocates a temporary buffer sized to hold one
> > byte per pixel, while it only needs to hold one bit per pixel.
> >
> > ssd130x_fb_blit_rect() allocates a temporary buffer sized to hold one
> > byte per pixel for the whole frame buffer, while it only needs to hold
> > one bit per pixel for the part that is to be updated.
> > Pass dst_pitch to drm_fb_xrgb8888_to_mono_reversed(), as we have already
> > calculated it anyway.
>
> Can we use bitmap API? bitmap_zalloc() / etc ?

Why? There is no need to operate on an array of longs, only on an
array of bytes. Going to longs would expose us to endianness.
There's also no need to use any of the bitmap operations to modify the data.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

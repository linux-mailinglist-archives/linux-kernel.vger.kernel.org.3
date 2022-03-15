Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0394D9BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348521AbiCOM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCOM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:58:50 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAE4EA0F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:57:38 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id a14so15685503qtx.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NcySFWs72+ekNVQe/iSrb9ADVfTngo3pJTXSZ1gdhw=;
        b=MeRjuKibqZ7ZHW6AIJOPycn4lGGmXkxtyywtaO7UA35cnfOv8QLZQa30Ix02Zt7boJ
         R50ov12LSDhXr4m1fV98kGVO2ewvXMlmH8cFDJ4BDxktoNJuSOrDLL6CS2mi9Ht6nPzY
         W2Uco8W9jMWEv1UVJKMlmLWzYMz69iJPgHzANJMVJGsp25GWp0umbKJzL828fJ4q8V7q
         uMLbw2r8lg2yygZBrSJnwDytHTvmneIbceVNZ9FWDiG1Vc6+MW/cRyo56njdMJOmhwrd
         9AULh+HmDIsn7myB/jYYy83LX/Plj8AcqIxoP7T1LAlYDSWi/ke7zLiGzQRY+GewmSQ7
         xelA==
X-Gm-Message-State: AOAM531X4jW1+hliqEH2P/NQRtZVdBfpVIz49REhCrZa3TzNRIxhsrVp
        Q8l5Ag3O3KBsyE351m2En3nAuItqseD8Jw==
X-Google-Smtp-Source: ABdhPJxKedde9cK14xrFcR46Fs6xm1e3xxl2iwvvniPWDjMebGG/wWjQaPVGQgmgjAoLbOVjkDl05w==
X-Received: by 2002:a05:622a:1012:b0:2e1:e7f3:5c89 with SMTP id d18-20020a05622a101200b002e1e7f35c89mr100869qte.550.1647349057135;
        Tue, 15 Mar 2022 05:57:37 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 193-20020a3706ca000000b0067d3e4b5667sm8954818qkg.67.2022.03.15.05.57.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:57:36 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2e5969bdf31so5506337b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:57:36 -0700 (PDT)
X-Received: by 2002:a81:5a08:0:b0:2db:d8c6:7e4f with SMTP id
 o8-20020a815a08000000b002dbd8c67e4fmr24074505ywb.256.1647349056232; Tue, 15
 Mar 2022 05:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220315110707.628166-1-geert@linux-m68k.org> <20220315110707.628166-5-geert@linux-m68k.org>
 <43b88d77-bcba-e6d5-b51f-56c5c8c0318c@redhat.com>
In-Reply-To: <43b88d77-bcba-e6d5-b51f-56c5c8c0318c@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 13:57:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUAY2QOLAXG9cH_ZMRFrRjoGmxxV97q8=Pm5bd_kXtzxg@mail.gmail.com>
Message-ID: <CAMuHMdUAY2QOLAXG9cH_ZMRFrRjoGmxxV97q8=Pm5bd_kXtzxg@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm: ssd130x: Reduce temporary buffer sizes
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
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

On Tue, Mar 15, 2022 at 1:32 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 3/15/22 12:07, Geert Uytterhoeven wrote:
> > ssd130x_clear_screen() allocates a temporary buffer sized to hold one
> > byte per pixel, while it only needs to hold one bit per pixel.
> >
> > ssd130x_fb_blit_rect() allocates a temporary buffer sized to hold one
> > byte per pixel for the whole frame buffer, while it only needs to hold
> > one bit per pixel for the part that is to be updated.
> > Pass dst_pitch to drm_fb_xrgb8888_to_mono_reversed(), as we have already
>
> Just drm_fb_xrgb8888_to_mono() since you already fixed the name in patch 1/5.

Bummer, that happens when reshuffling patches :-(
Fixed for v2.

> > calculated it anyway.
> >
> > Fixes: a61732e808672cfa ("drm: Add driver for Solomon SSD130x OLED displays")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
>
> Indeed. I haven't noticed that got the calculation wrong until you pointed out.
>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

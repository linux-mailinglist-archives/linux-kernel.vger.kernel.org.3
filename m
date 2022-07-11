Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0957071D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiGKPau convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Jul 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiGKPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:30:47 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A95F106;
        Mon, 11 Jul 2022 08:30:43 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id r17so4712676qtx.6;
        Mon, 11 Jul 2022 08:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UM8AMn9ISk4ityV+MIMKJjkXCfGRegVP9qh5S/PzT30=;
        b=ZihyjDnBounxZnkOgIIfQ+ejeNNaK454LvrORp4g2A5UwQlKiS6Epj6ISAbySR/4g9
         2hlu5FIlIqchSxFcyD7QIM0MdPTuxsWeg0iAuRh18UFXlJodvgkMAnt5y6uOlMIjmzUe
         132A5fmF3iLTQ6b4HaKVufGtaC+kyd1C3dcjJvto/k9LizX30hLuvLXZk9PLCORr6LcR
         Eyucx7crFMAtoezHYDMQFzc2Q4W83ajdAQBM5jDjZgAgl+Re6L5kJgeYbnIzL3fyc9Ou
         wGc/aHjZnJQg9Mvu4DLnOuhQWKYz0I+c1+ooyaaGh+keymcSc+U+geeAtr0QKoNI7xFX
         bEpA==
X-Gm-Message-State: AJIora85ShPWdJHIVos5ia04U08m456sOhXQI694SUljf3ipFELqKWMk
        gwD66wE+pQl8k4+1A17b8/I1AfdfmgUNTg==
X-Google-Smtp-Source: AGRyM1vFZq9qIAmXtVBRrQAmYG7AJCtOjQ1Wg9Gjvy2WyFgC44rCJUvfcWLjUEjaAyLX1endoGwyQA==
X-Received: by 2002:a05:622a:1184:b0:31e:aed5:9859 with SMTP id m4-20020a05622a118400b0031eaed59859mr7886692qtk.288.1657553442266;
        Mon, 11 Jul 2022 08:30:42 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a430e00b006a6a6f148e6sm6940950qko.17.2022.07.11.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 08:30:41 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 64so9281154ybt.12;
        Mon, 11 Jul 2022 08:30:41 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr17468803ybq.543.1657553441288; Mon, 11
 Jul 2022 08:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657300532.git.geert@linux-m68k.org> <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org>
In-Reply-To: <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jul 2022 17:30:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
Message-ID: <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

Hi Michel,

On Mon, Jul 11, 2022 at 5:23 PM Michel Dänzer
<michel.daenzer@mailbox.org> wrote:
> On 2022-07-08 20:21, Geert Uytterhoeven wrote:
> > As of commit eae06120f1974e1a ("drm: refuse ADDFB2 ioctl for broken
> > bigendian drivers"), drivers must set the
> > quirk_addfb_prefer_host_byte_order quirk to make the drm_mode_addfb()
> > compat code work correctly on big-endian machines.
> >
> > While that works fine for big-endian XRGB8888 and ARGB8888, which are
> > mapped to the existing little-endian BGRX8888 and BGRA8888 formats, it
> > does not work for big-endian XRGB1555 and RGB565, as the latter are not
> > listed in the format database.
> >
> > Fix this by adding the missing formats.  Limit this to big-endian
> > platforms, as there is currently no need to support these formats on
> > little-endian platforms.
> >
> > Fixes: 6960e6da9cec3f66 ("drm: fix drm_mode_addfb() on big endian machines.")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Cirrus is the only driver setting quirk_addfb_prefer_host_byte_order
> > and supporting RGB565 or XRGB1555, but no one tried that on big-endian?
> > Cirrus does not support DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN
> > in cirrus_fb_create, so you cannot get a graphical text console.
> >
> > Do we need these definitions on little-endian platforms, too?
> > Would it be better to use "DRM_FORMAT_{XRGB1555,RGB565} |
> > DRM_FORMAT_BIG_ENDIAN" instead of "DRM_FORMAT_HOST_{XRGB1555,RGB565}" in
> > formats[]?
>
> The intention of DRM_FORMAT_HOST_* is that they are macros in include/drm/drm_fourcc.h which just map to little endian formats defined in drivers/gpu/drm/drm_fourcc.c. Since this is not possible for big endian hosts for XRGB1555 or RGB565 (or any other format with non-8-bit components), this isn't applicable here.

I read that as that you prefer to write
"DRM_FORMAT_{XRGB1555,RGB565} | DRM_FORMAT_BIG_ENDIAN" in formats[]?

> It's also doubtful that Cirrus hardware would access these formats as big endian (drivers/gpu/drm/tiny/cirrus.c has no endianness references at all, and the hardware was surely designed for x86 first and foremost).
>
> Instead, fbcon (and user space) needs to convert to little endian when using DRM_FORMAT_HOST_{XRGB1555,RGB565} with the cirrus driver on big endian hosts.

Yeah, probably the cirrus driver can use some fixes...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

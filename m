Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9114D85EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiCNNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiCNNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:31:43 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7A13D73;
        Mon, 14 Mar 2022 06:30:32 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id q4so12660482qki.11;
        Mon, 14 Mar 2022 06:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ESmoGYKvForOfgnFNNl3bul8J0TvzMfyrdSY3ncE6E=;
        b=uO+Um3ZMkaOLd27w4397t+Fkci9z8p3BGpG5jW0zNEyNevdQQ3tfMYRQx9pNG+RhSO
         QAsxZlkwXCeoTcUeUAe1swxy98G/HDfoZh//jGFz/JX6ZKfggiHzqsgI+1hKpkYMkCLA
         Xq1e6uM7YUAZmXhnNKlGjDNL+YA4lkbjb05Rb4WQ+9jzlcWCsd7NdS5v+Yovyyq+B6Xt
         HauZd5YXzbkC71oZgaILvTVBcKFwPBMBzjYNbXUuvK4uP/8H+VVg4nMW9Y/R9aeqq3o0
         wjayk+HwknTMqAXIUBrL3IFro1AQ69neLCqIjCTYulhrVSLFgMyMk2CNKgUWwxUTlhEO
         vUpw==
X-Gm-Message-State: AOAM530oWWKWLE09SRWpWTbka181do3MQbbMp7Uj40CiL+jDxlcKW9b/
        XefFAtyX4Fne666Zy+onTgYoCxKduszn7w==
X-Google-Smtp-Source: ABdhPJzO94wE27iqfcTwnmSWUlJLQydrjBgOPb1Wr0PywBgDqz56YNMacz/XufAKVIYWUsYJQWs5Aw==
X-Received: by 2002:a05:620a:4085:b0:67b:315b:a09f with SMTP id f5-20020a05620a408500b0067b315ba09fmr14881685qko.334.1647264631247;
        Mon, 14 Mar 2022 06:30:31 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm5564977qtb.28.2022.03.14.06.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 06:30:30 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2db2add4516so163661667b3.1;
        Mon, 14 Mar 2022 06:30:30 -0700 (PDT)
X-Received: by 2002:a0d:f1c7:0:b0:2db:d2bc:be11 with SMTP id
 a190-20020a0df1c7000000b002dbd2bcbe11mr18928111ywf.62.1647264630398; Mon, 14
 Mar 2022 06:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646683502.git.geert@linux-m68k.org> <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
In-Reply-To: <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Mar 2022 14:30:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com>
Message-ID: <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
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

On Mon, Mar 7, 2022 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Introduce fourcc codes for color-indexed frame buffer formats with two,
> four, and sixteen colors, and provide a mapping from bit per pixel and
> depth to fourcc codes.
>
> As the number of bits per pixel is less than eight, these rely on proper
> block handling for the calculation of bits per pixel and pitch.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -99,7 +99,10 @@ extern "C" {
>  #define DRM_FORMAT_INVALID     0
>
>  /* color index */
> -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> +#define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /* [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
> +#define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /* [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte */
> +#define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:4 two pixels/byte */
> +#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one pixel/byte */
>
>  /* 8 bpp Red */
>  #define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */

After replying to Ilia's comment[1], I realized the CFB drawing
operations use native byte and bit ordering, unless
FBINFO_FOREIGN_ENDIAN is set.
While Amiga, Atari, and Sun-3 use big-endian bit ordering,
e.g. Acorn VIDC[2] uses little endian, and SH7760[3] is configurable
(sh7760fb configures ordering to match host order).
BTW, ssd130{7fb,x}_update_rect() both assume little-endian, so I
guess they are broken on big-endian.
Fbtest uses big-endian bit ordering, so < 8 bpp is probably broken
on little-endian.

Hence the above should become:

    #define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /*
[7:0] C7:C6:C5:C4:C3:C2:C1:C0 1:1:1:1:1:1:1:1 eight pixels/byte */
    #define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /*
[7:0] C3:C2:C1:C0 2:2:2:2 four pixels/byte */
    #define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /*
[7:0] C1:C0 4:4 two pixels/byte */

The same changes should be made for DRM_FORMAT_[RD][124].

The fbdev emulation code should gain support for these with and without
DRM_FORMAT_BIG_ENDIAN, the latter perhaps only on big-endian platforms?

[1] https://lore.kernel.org/r/CAKb7UvgEdm9U=+RyRwL0TGRfA_Qc7NbhCWoZOft2DKdXggtKYw@mail.gmail.com/
[2] See p.30 of the VIDC datasheet
    http://chrisacorns.computinghistory.org.uk/docs/Acorn/Misc/Acorn_VIDC_Datasheet.pdf
[3] See p.1178 of the SH7660 datasheet
    https://datasheet.octopart.com/HD6417760BL200AV-Renesas-datasheet-14105759.pdf

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

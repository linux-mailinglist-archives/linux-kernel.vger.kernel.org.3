Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C384D861F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbiCNNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiCNNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:41:26 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076145AE0;
        Mon, 14 Mar 2022 06:40:16 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id e22so12505717qvf.9;
        Mon, 14 Mar 2022 06:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWUj/v7KabELU72fthxfijtXtCwC8AT21SzbTAGRY78=;
        b=oUPANsHfvXHj3m6YkLFp+zxukzi+N6+Cxt8fA/b2n+z88+UONEU2WVg7+PihBCfNZU
         RQbp/9dt2RlEuVj0IWeeAuIzuj1N1SiG632CCQEPtbDQ+BKX6jmDNeMbDx86C2yx2muO
         X6rWVQsp5TzKyqvlSKG0JSfqZ6hesN0uOeMpPJMnre6l1gduBTSGpAmjCrxmOO25wcdB
         7Q0vJq1VXJv+yYsCQpMdSklz54Eok369mfaweDHz+2EBsSzI05oOr9pMGD4ylcqhakaQ
         5Ov30/1oVm+Evefbt7/W7oyo/RJ7hBzDw9agTSh2QQTlT3j9i/wtilOyw8CxmiMRx7Ya
         veYw==
X-Gm-Message-State: AOAM531OlwM5UZr/XZ18LIOAEOyCMyMvoX2L4M0+f3T7O52uVcqioIzK
        /DGpUOTi6aNNu/SokYpkVKA0ax3jfStV8w==
X-Google-Smtp-Source: ABdhPJxcF1qJphNhzPbEb+TXUYhEid4TJJVmOOY+HapVx6MygWgBNSvpLf7n88T1vedFlCG5zYxuiQ==
X-Received: by 2002:a05:6214:5082:b0:435:911f:1bc1 with SMTP id kk2-20020a056214508200b00435911f1bc1mr17584086qvb.128.1647265215777;
        Mon, 14 Mar 2022 06:40:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b00648c706dda1sm7877602qki.6.2022.03.14.06.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 06:40:14 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id w16so30757111ybi.12;
        Mon, 14 Mar 2022 06:40:14 -0700 (PDT)
X-Received: by 2002:a25:dfd3:0:b0:629:24ff:eab0 with SMTP id
 w202-20020a25dfd3000000b0062924ffeab0mr17526653ybg.613.1647265213864; Mon, 14
 Mar 2022 06:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <20220131201225.2324984-3-javierm@redhat.com>
In-Reply-To: <20220131201225.2324984-3-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Mar 2022 14:40:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPQrErbMZ4wJPgROY7XOnKGvimNFg8JpiyuWqz2a3Gzw@mail.gmail.com>
Message-ID: <CAMuHMdWPQrErbMZ4wJPgROY7XOnKGvimNFg8JpiyuWqz2a3Gzw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/format-helper: Add drm_fb_gray8_to_mono_reversed()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
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

On Mon, Jan 31, 2022 at 9:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Add support to convert 8-bit grayscale to reversed monochrome for drivers
> that control monochromatic displays, that only have 1 bit per pixel depth.
>
> This helper function was based on repaper_gray8_to_mono_reversed() from
> the drivers/gpu/drm/tiny/repaper.c driver.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>         return -EINVAL;
>  }
>  EXPORT_SYMBOL(drm_fb_blit_toio);
> +
> +/**
> + * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
> + * @dst: reversed monochrome destination buffer

What's the meaning of "reversed"?
During the last few days, I've been balancing between (a) "reverse
video" and (b) "reverse bit order", but none of them seems to be true.

(a) The code maps 0-127 to 0 and 8-255 to 1, which just reduces from
    256 to 2 grayscale levels, without inversion. The result is also
    white-on-black on my ssd130x OLED.
(b) On little-endian, the CFB drawops use little-endian bit order,
    which is what ends up in "byte" in the code below.

> + * @src: 8-bit grayscale source buffer
> + * @clip: Clip rectangle area to copy
> + *
> + * DRM doesn't have native monochrome or grayscale support.
> + * Such drivers can announce the commonly supported XR24 format to userspace
> + * and use drm_fb_xrgb8888_to_gray8() to convert to grayscale and then this
> + * helper function to convert to the native format.
> + */
> +void drm_fb_gray8_to_mono_reversed(void *dst, void *src, const struct drm_rect *clip)
> +{
> +       size_t width = drm_rect_width(clip);
> +       size_t height = drm_rect_width(clip);
> +
> +       u8 *mono = dst, *gray8 = src;
> +       unsigned int y, xb, i;
> +
> +       for (y = 0; y < height; y++)
> +               for (xb = 0; xb < width / 8; xb++) {
> +                       u8 byte = 0x00;
> +
> +                       for (i = 0; i < 8; i++) {
> +                               int x = xb * 8 + i;
> +
> +                               byte >>= 1;
> +                               if (gray8[y * width + x] >> 7)
> +                                       byte |= BIT(7);
> +                       }
> +                       *mono++ = byte;
> +               }
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

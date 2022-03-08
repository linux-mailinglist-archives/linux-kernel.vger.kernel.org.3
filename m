Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FAB4D1CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348247AbiCHQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348235AbiCHQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:14:49 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF60F506ED;
        Tue,  8 Mar 2022 08:13:52 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id h196so1569337qke.12;
        Tue, 08 Mar 2022 08:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbmDfuUW6oAHjPTcZ3JNsr9CL4G+BTHO+raMIW3ftzU=;
        b=TMan+liWQQhiGyC10aLN/RNp3c7UvXLxpEfBHpEvvpSohtomUgg3r5QOpEtF6eGci7
         9+q8RgXgdjm6fLQCJEkWuuJVFjj+P5zlJ7NjGnKf0P8cAZGczk3L7Em/MKv98JWJeYRp
         EoOKaMLbAbcvPE33NXVe5JuIB7Oo8c3kybbGnswKoFwrF+Pqsyj7RlgLORyYPTtmedep
         24a+LVU4VWCNe/X6RKnNJN3f/gbhmvcv0iR/Drw+ZLwV0/54SYPkzWyGIFpgK6Ym/KiI
         QyC6Y9vCNeYnQr68VVd2O2YdVqGS+cJ5SDC2tmVBOGm4cssEAnGE0vi25KgrgW1ra1ST
         5vwA==
X-Gm-Message-State: AOAM533PiUKSqi0493fvCV4bBzElvdyuay09z8fP4bXoidiQq4kB24aw
        fiOMuh/iQe6TsEC9qvOvzs4gbOLecV/xMA==
X-Google-Smtp-Source: ABdhPJzjltD0PO11+L8829weslubb4ui+8/m2UfsRN6p+08QyqK4TfIf7IRXhTv7YEbdiiVF/CP3CA==
X-Received: by 2002:a37:909:0:b0:67b:3289:4c8f with SMTP id 9-20020a370909000000b0067b32894c8fmr5792858qkj.249.1646756031488;
        Tue, 08 Mar 2022 08:13:51 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id j11-20020a37a00b000000b0067b436faccesm2008675qke.122.2022.03.08.08.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:13:51 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id j2so38858735ybu.0;
        Tue, 08 Mar 2022 08:13:51 -0800 (PST)
X-Received: by 2002:a25:dfd3:0:b0:629:24ff:eab0 with SMTP id
 w202-20020a25dfd3000000b0062924ffeab0mr10980528ybg.613.1646756030721; Tue, 08
 Mar 2022 08:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20220214133710.3278506-1-javierm@redhat.com> <20220214133710.3278506-3-javierm@redhat.com>
In-Reply-To: <20220214133710.3278506-3-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 17:13:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZHBVwaLDi-B=PrVOfcHxGLxwgDBisvexE94x72qvdJg@mail.gmail.com>
Message-ID: <CAMuHMdWZHBVwaLDi-B=PrVOfcHxGLxwgDBisvexE94x72qvdJg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
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

On Mon, Feb 14, 2022 at 2:37 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Add support to convert from XR24 to reversed monochrome for drivers that
> control monochromatic display panels, that only have 1 bit per pixel.
>
> The function does a line-by-line conversion doing an intermediate step
> first from XR24 to 8-bit grayscale and then to reversed monochrome.
>
> The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
> drivers/gpu/drm/tiny/repaper.c driver.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch, which is now commit bcf8b616deb87941
("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
in drm/drm-next.

> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -12,9 +12,11 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>
> +#include <drm/drm_device.h>
>  #include <drm/drm_format_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_print.h>
>  #include <drm/drm_rect.h>
>
>  static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
> @@ -591,3 +593,111 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>         return -EINVAL;
>  }
>  EXPORT_SYMBOL(drm_fb_blit_toio);
> +
> +static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,

"pixels" is not the number of pixels to process, but the number of
bytes in the monochrome destination buffer.

> +                                              unsigned int start_offset, unsigned int end_len)
> +{
> +       unsigned int xb, i;
> +
> +       for (xb = 0; xb < pixels; xb++) {
> +               unsigned int start = 0, end = 8;
> +               u8 byte = 0x00;
> +
> +               if (xb == 0 && start_offset)
> +                       start = start_offset;
> +
> +               if (xb == pixels - 1 && end_len)
> +                       end = end_len;
> +
> +               for (i = start; i < end; i++) {
> +                       unsigned int x = xb * 8 + i;
> +
> +                       byte >>= 1;
> +                       if (src[x] >> 7)
> +                               byte |= BIT(7);
> +               }
> +               *dst++ = byte;
> +       }

The above is IMHO very hard to read.
I think it can be made simpler by passing the total number of pixels
to process instead of "pixels" (which is bytes) and "end_len".

> +}
> +
> +/**
> + * drm_fb_xrgb8888_to_mono_reversed - Convert XRGB8888 to reversed monochrome
> + * @dst: reversed monochrome destination buffer
> + * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> + * @src: XRGB8888 source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + *
> + * DRM doesn't have native monochrome support.
> + * Such drivers can announce the commonly supported XR24 format to userspace
> + * and use this function to convert to the native format.
> + *
> + * This function uses drm_fb_xrgb8888_to_gray8() to convert to grayscale and
> + * then the result is converted from grayscale to reversed monohrome.
> + */
> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
> +                                     const struct drm_framebuffer *fb, const struct drm_rect *clip)
> +{
> +       unsigned int linepixels = drm_rect_width(clip);
> +       unsigned int lines = clip->y2 - clip->y1;

drm_rect_height(clip)?

> +       unsigned int cpp = fb->format->cpp[0];
> +       unsigned int len_src32 = linepixels * cpp;
> +       struct drm_device *dev = fb->dev;
> +       unsigned int start_offset, end_len;
> +       unsigned int y;
> +       u8 *mono = dst, *gray8;
> +       u32 *src32;
> +
> +       if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
> +               return;
> +
> +       /*
> +        * The reversed mono destination buffer contains 1 bit per pixel
> +        * and destination scanlines have to be in multiple of 8 pixels.
> +        */
> +       if (!dst_pitch)
> +               dst_pitch = DIV_ROUND_UP(linepixels, 8);

This is not correct when clip->x1 is not a multiple of 8 pixels.
Should be:

    DIV_ROUND_UP(linepixels + clip->x1 % 8, 8);

> +
> +       drm_WARN_ONCE(dev, dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");

This triggers for me: dst_pitch = 1.
Which is perfectly fine, when flashing an 8-pixel wide cursor ;-)

> +
> +       /*
> +        * The cma memory is write-combined so reads are uncached.
> +        * Speed up by fetching one line at a time.
> +        *
> +        * Also, format conversion from XR24 to reversed monochrome
> +        * are done line-by-line but are converted to 8-bit grayscale
> +        * as an intermediate step.
> +        *
> +        * Allocate a buffer to be used for both copying from the cma
> +        * memory and to store the intermediate grayscale line pixels.
> +        */
> +       src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
> +       if (!src32)
> +               return;
> +
> +       gray8 = (u8 *)src32 + len_src32;
> +
> +       /*
> +        * For damage handling, it is possible that only parts of the source
> +        * buffer is copied and this could lead to start and end pixels that
> +        * are not aligned to multiple of 8.
> +        *
> +        * Calculate if the start and end pixels are not aligned and set the
> +        * offsets for the reversed mono line conversion function to adjust.
> +        */
> +       start_offset = clip->x1 % 8;
> +       end_len = clip->x2 % 8;
> +
> +       vaddr += clip_offset(clip, fb->pitches[0], cpp);
> +       for (y = 0; y < lines; y++) {
> +               src32 = memcpy(src32, vaddr, len_src32);
> +               drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
> +               drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch,
> +                                                  start_offset, end_len);
> +               vaddr += fb->pitches[0];
> +               mono += dst_pitch;
> +       }
> +
> +       kfree(src32);
> +}
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

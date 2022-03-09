Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6304D2EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiCIMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiCIMEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:04:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0C1416F950
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646827390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tg1o0vf2e/XRSv/u3YehBRlt1pjhs1t2fKcaz6fZZ34=;
        b=DILtZ/i8DbinSFazIKcxBn5Zp52YanVhr50ufIAVKNvQBxgSztUKPdO+XDoR17zq/BMy+V
        wqcnEDgmopl8Sw1H/2iYJ3tT8HIvghOVaxmDlr4paQqMBa/GK73EeNRg0Wrs7LDF4nfvxr
        c/Lzwcv6KwkSrq+9Ru3ELF0uQ+K+Xyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-Ax75A3PAN_SA-dzB9u4aYQ-1; Wed, 09 Mar 2022 07:03:08 -0500
X-MC-Unique: Ax75A3PAN_SA-dzB9u4aYQ-1
Received: by mail-wm1-f72.google.com with SMTP id z9-20020a7bc7c9000000b00389bd375677so884789wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tg1o0vf2e/XRSv/u3YehBRlt1pjhs1t2fKcaz6fZZ34=;
        b=J5Kteagpmz+5FXr13nP1q9qqqP7pT+O1+8tlyyEKiWs9jEBVq5gHLxnWUhxCPNb2If
         2mwbG/39cR1ejhal75g+vsBPjZ6/G21+pnpFYZ4UDyBApd01wKtzfLr5KpGvQ36SYDX3
         aKeM7uyzm2xIuS93rUB/2E97raxnnhSlWBBDXD6H5l9dUwjFF7CcJKgrhaxpH33sg2gU
         iPLpGxw2/tZvdooKEsEUkPJHzfXrQcSxjCjK3snJuXhPrMlh9N4uEvp3XKt5/6XE451E
         YA781pvuD0IRQLvn0OGQ+bH8oUbgrEYu1M+aetwGQxe7e+y9o6lVEuxEreHPyFLxldWM
         I/GA==
X-Gm-Message-State: AOAM531YL8rNxzSq3fMozgrqFVBXkjKHZjclYgmXKcEuC/UQzTIQMave
        IkEJzX96YM1dk8dlrIJ9P/pClJh4dfGMBXqbp6zMT9pKb+xoZxdJfxEKQgRndoYAvS2xTBVJ70Z
        /SlpYlSZSfTLzV+4jd46V3yRY
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr3087824wmg.38.1646827387371;
        Wed, 09 Mar 2022 04:03:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvQMnTjm+Qq5odCLZwgqJ2OfY5/z2HM+SprEExkrP+P+U9HfPpAzWfgeU88YgEHXz8I1b3Nw==
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr3087777wmg.38.1646827386977;
        Wed, 09 Mar 2022 04:03:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020adff411000000b001f03426827csm1551217wro.71.2022.03.09.04.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:03:06 -0800 (PST)
Message-ID: <809430bb-4ffb-3bd4-7062-ec8b78245387@redhat.com>
Date:   Wed, 9 Mar 2022 13:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-3-javierm@redhat.com>
 <CAMuHMdWZHBVwaLDi-B=PrVOfcHxGLxwgDBisvexE94x72qvdJg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWZHBVwaLDi-B=PrVOfcHxGLxwgDBisvexE94x72qvdJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Thanks a lot for your feedback.

On 3/8/22 17:13, Geert Uytterhoeven wrote:

[snip]

>> +
>> +static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
> 
> "pixels" is not the number of pixels to process, but the number of
> bytes in the monochrome destination buffer.
>

Right, that parameter name is misleading / incorrect indeed. Probably
should be changed by dst_pitch or dst_stride.
 
>> +                                              unsigned int start_offset, unsigned int end_len)
>> +{
>> +       unsigned int xb, i;
>> +
>> +       for (xb = 0; xb < pixels; xb++) {
>> +               unsigned int start = 0, end = 8;
>> +               u8 byte = 0x00;
>> +
>> +               if (xb == 0 && start_offset)
>> +                       start = start_offset;
>> +
>> +               if (xb == pixels - 1 && end_len)
>> +                       end = end_len;
>> +
>> +               for (i = start; i < end; i++) {
>> +                       unsigned int x = xb * 8 + i;
>> +
>> +                       byte >>= 1;
>> +                       if (src[x] >> 7)
>> +                               byte |= BIT(7);
>> +               }
>> +               *dst++ = byte;
>> +       }
> 
> The above is IMHO very hard to read.
> I think it can be made simpler by passing the total number of pixels
> to process instead of "pixels" (which is bytes) and "end_len".
>

Agreed that's hard to read. I think is better if you propose a patch
with your idea to make it simpler.
 
[snip]

>> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
>> +                                     const struct drm_framebuffer *fb, const struct drm_rect *clip)
>> +{
>> +       unsigned int linepixels = drm_rect_width(clip);
>> +       unsigned int lines = clip->y2 - clip->y1;
> 
> drm_rect_height(clip)?
>

Yes, unsure why didn't use it since used drm_rect_width() for the width.
 
>> +       unsigned int cpp = fb->format->cpp[0];
>> +       unsigned int len_src32 = linepixels * cpp;
>> +       struct drm_device *dev = fb->dev;
>> +       unsigned int start_offset, end_len;
>> +       unsigned int y;
>> +       u8 *mono = dst, *gray8;
>> +       u32 *src32;
>> +
>> +       if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
>> +               return;
>> +
>> +       /*
>> +        * The reversed mono destination buffer contains 1 bit per pixel
>> +        * and destination scanlines have to be in multiple of 8 pixels.
>> +        */
>> +       if (!dst_pitch)
>> +               dst_pitch = DIV_ROUND_UP(linepixels, 8);
> 
> This is not correct when clip->x1 is not a multiple of 8 pixels.
> Should be:
> 
>     DIV_ROUND_UP(linepixels + clip->x1 % 8, 8);
>

Agreed.
 
>> +
>> +       drm_WARN_ONCE(dev, dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> 
> This triggers for me: dst_pitch = 1.
> Which is perfectly fine, when flashing an 8-pixel wide cursor ;-)
>

Indeed. I think we should just drop that warn.

Do you want me to post patches for all these or would you do it
when simplifying the drm_fb_gray8_to_mono_reversed_line() logic ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E34B4508
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbiBNI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:57:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbiBNI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB8E65F8FD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644829046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69HvyvUIhOkkZrR25T0A4ak3h9jrAFSNcZowRzKJYOE=;
        b=Zjzwtl4YMYyVNy9+afaGXUCmm9n2IgIfHb/tE3TlE3kwQDfjCXdg2TgDIe1dwgCsXOTjok
        Duf6fbR2EUVTkIAb19nMK1dkHtKmrQl1UcHgpFHtdbY8/ISKj7445tU0fTrDkVatiD6725
        8aNIoXkU+tUkFTTWTrbxsri8L9Jch8g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-ZiIW8NspMUi0eEnxPz-FlQ-1; Mon, 14 Feb 2022 03:57:25 -0500
X-MC-Unique: ZiIW8NspMUi0eEnxPz-FlQ-1
Received: by mail-wr1-f71.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so6623034wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=69HvyvUIhOkkZrR25T0A4ak3h9jrAFSNcZowRzKJYOE=;
        b=SAqk8i9YfzVgyVyodhM9B52z9kndqAkcO1MH4keamlcoKninUZHnNEe4tokm3+0kTS
         htbEivH/47Mlat33B0jR6dA2MC+QEwLW0AydL52Bm55nG/pYVRMzuMk76l/3QTc3uCa5
         Tf54FQbz6tpbpesiTp7QWsYO9SwnLkBR0eMtyiWckkcCKvWEyzMik6DnLuUMOmKlOj0i
         gQ1h4pVtiu6OUko1rPvm+T7fZ78jAZsqCspguaxrRa26JrkpDtxAPKZRnap/e+0MtW1Z
         9AjAZ2gE9V+F53+Baz71PDiSUv/KJRxCokKyVLeUvrrbDdU4PGXRpdVLQluifawmcmrG
         z3ow==
X-Gm-Message-State: AOAM532HDMeYTzPGjO4FN3f2L0tQYI/GjUJ1Wt60Fm+hEsoHwfiT8tBl
        qeA+nhM+fCLRHVam2v+TpRl3snWPRK2a8bJsRLLQFJSbnkabHjcbix6fiKYxFLU1euqJZIFC1p8
        1XfPCjhokUAmOZiPvl/jOVPU7
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr10133011wmr.141.1644829044201;
        Mon, 14 Feb 2022 00:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLJdMQROn0HBjGMEca6+PzxDVdcjo/+C+qxpaxDMr5SR2UrWB2rcNzjEWlQvJ11E6dtoU4Jw==
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr10132993wmr.141.1644829043953;
        Mon, 14 Feb 2022 00:57:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l20sm11561086wmq.22.2022.02.14.00.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 00:57:23 -0800 (PST)
Message-ID: <e50211b1-08fa-de09-8948-664493423c33@redhat.com>
Date:   Mon, 14 Feb 2022 09:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-3-javierm@redhat.com>
 <CAMuHMdUeqXs2PeV9s8+edPpOGodRT=it3g+fOTB7DuTuW2J9ZA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUeqXs2PeV9s8+edPpOGodRT=it3g+fOTB7DuTuW2J9ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Thanks for your feedback.

On 2/12/22 16:54, Geert Uytterhoeven wrote:

[snip]

>> +
>> +               for (i = start; i < end; i++) {
>> +                       unsigned int x = xb * 8 + i;
>> +
>> +                       byte >>= 1;
>> +                       if (src[x] >> 7)
>> +                               byte |= BIT(7);
>> +               }
> 
>     x = xb * 8;
>     for (i = start; i < end; i++) {
>             byte >>= 1;
>             byte |= src[x + i] & BIT(7);
>     }
> 

I think the original version from Noralf is easier to read and understand.

It makes explicit that the bit is set if the grayscale value is >= 128.

[snip]

>> +void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
>> +                                     const struct drm_framebuffer *fb, const struct drm_rect *clip)
>> +{

[snip]

>> +       u8 *mono = dst, *gray8;
>> +       u32 *src32;

[snip]

>> +        *
>> +        * Allocate a buffer to be used for both copying from the cma
>> +        * memory and to store the intermediate grayscale line pixels.
>> +        */
>> +       src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
>> +       if (!src32)
>> +               return;
>> +
>> +       gray8 = (u8 *)src32 + len_src32;
> 
> The cast can be removed if src32 is changed to "void *".
> For symmetry, gray8 and mono can be changed to "void *", too.
>

Yes, but these being "u32 *" and "u8 *" also express that the source buffer
contains 32-bit XRGB8888 pixels, the intermediate buffer a 8-bit grayscale
pixel format and the destination buffer a 8-bit packed reversed monochrome.

Using "void *" for these would make that less clear when reading the code IMO.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


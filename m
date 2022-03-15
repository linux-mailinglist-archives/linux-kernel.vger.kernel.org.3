Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51124D9AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiCOMTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348178AbiCOMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E1013DC0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647346684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F93YLhlX3AHa6LrSoPs7cMDPZOP3lxJ4Kq/W7/cDMnE=;
        b=dNIFe/+K1mjVdmrJ9QfvtJbkwUrx/4xXnQuRp7b9G0HXes6v+OFXXtFSUkqLt66rHmkH/a
        OlyYV/xJIC0NLsiVpJMfG7d4LNmdJi16tYL+2/+03vR2l7VOD1cAP5JyhcbCshnFWxa3hl
        V/yLNnhTSGwyppsuXxj4EY4Q3qwSsrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-b3MURepfPGmTAC1VjjcXvA-1; Tue, 15 Mar 2022 08:18:03 -0400
X-MC-Unique: b3MURepfPGmTAC1VjjcXvA-1
Received: by mail-wm1-f72.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so6587375wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F93YLhlX3AHa6LrSoPs7cMDPZOP3lxJ4Kq/W7/cDMnE=;
        b=kzpu0mXh5yesa/jhPuvMRE6rCChBjqZxXTVnLT3AACgpRaHBOKhr/A7lzRjGQVWgIj
         duI/VKNLmtX/nYMDZZ5EuKJXSjebg8Qy4anp8DmMx0hpAyxrkJrst4kXLmfKdX192BLN
         XG3EvuVn9ro6i/lZPXUPUwguxQ50tyfXjE42nLOTMBgIh3raRMimC0LxVvjR2hjXK/9K
         CfHQdqIqHwgXceq5q1/d1kDgP7FQdgxuB1K7RX2E6UymKiG7cJEYVXVl8tF/ZSk7NCV7
         jVMtLLxSVCULTQ6Ui8fkAJMGSER+HwCXMR69mjCOom5E11EWXUXO//Lar0yk8Adh6f2t
         6KsA==
X-Gm-Message-State: AOAM532HcYVE1LbhZPj8OahtexaUPL/D5hcRlNgk+6BxEU5CbmCQrpVZ
        fa0TeXNQ5/LqwN1iNpzLieRyw+YFoutc+g5BpydJRkc6MxCytkj12hgdq2Pw7lsFzzXeVV/lXZ+
        tUyPpAm2/xAMImlD9JHztRTKC
X-Received: by 2002:a05:6000:15c2:b0:203:8348:8cbf with SMTP id y2-20020a05600015c200b0020383488cbfmr20070395wry.309.1647346682013;
        Tue, 15 Mar 2022 05:18:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxb1OO0YySdqz4VaKmR8uVDHQT2dklpCo8aAEnlZM/tpPNZJbwPeYR5fg/PrR+/u+YS9VXUw==
X-Received: by 2002:a05:6000:15c2:b0:203:8348:8cbf with SMTP id y2-20020a05600015c200b0020383488cbfmr20070373wry.309.1647346681724;
        Tue, 15 Mar 2022 05:18:01 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b00389f368cf1esm2270351wmq.40.2022.03.15.05.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:18:01 -0700 (PDT)
Message-ID: <27e1c911-798a-c14b-e5a0-622a7c5d8755@redhat.com>
Date:   Tue, 15 Mar 2022 13:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] drm/format-helper: Fix XRGB888 to monochrome
 conversion
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-3-geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220315110707.628166-3-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:07, Geert Uytterhoeven wrote:
> The conversion functions drm_fb_xrgb8888_to_mono() and
> drm_fb_gray8_to_mono_line() do not behave correctly when the
> horizontal boundaries of the clip rectangle are not multiples of 8:
>   a. When x1 % 8 != 0, the calculated pitch is not correct,
>   b. When x2 % 8 != 0, the pixel data for the last byte is wrong.
>

Thanks a lot for tracking down and fixing these issues.

> Simplify the code and fix (a) by:
>   1. Removing start_offset, and always storing the first pixel in the
>      first bit of the monochrome destination buffer.
>      Drivers that require the first pixel in a byte to be located at an
>      x-coordinate that is a multiple of 8 can always align the clip
>      rectangle before calling drm_fb_xrgb8888_to_mono().
>      Note that:
>        - The ssd130x driver does not need the alignment, as the
> 	 monochrome buffer is a temporary format,
>        - The repaper driver always updates the full screen, so the clip
> 	 rectangle is always aligned.
>   2. Passing the number of pixels to drm_fb_gray8_to_mono_line(),
>      instead of the number of bytes, and the number of pixels in the
>      last byte.
> 
> Fix (b) by explicitly setting the target bit, instead of always setting
> bit 7 and shifting the value in each loop iteration.
> 
> Remove the bogus pitch check, which operates on bytes instead of pixels,
> and triggers when e.g. flashing the cursor on a text console with a font
> that is 8 pixels wide.
> 
> Drop the confusing comment about scanlines, as a pitch in bytes always
> contains a multiple of 8 pixels.
> 
> While at it, use the drm_rect_height() helper instead of open-coding the
> same operation.
> 
> Update the comments accordingly.
> 
> Fixes: bcf8b616deb87941 ("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

I just have a small comment below.

[snip]

> +static void drm_fb_gray8_to_mono_line(u8 *dst, const u8 *src, unsigned int pixels)
> +{
> +	while (pixels) {
> +		unsigned int i, bits = min(pixels, 8U);
> +		u8 byte = 0;
>  
> -			byte >>= 1;
> -			if (src[x] >> 7)
> -				byte |= BIT(7);
> +		for (i = 0; i < bits; i++, pixels--) {

I think is worth to add a comment here explaining that the pixel is set to
1 for brightness > 127 and to 0 for brightness < 128. Or as kernel-doc for
this helper function.

> +			if (*src++ & BIT(7))

Pekka also mentioned that if (*src++ > 127) would make this easier to read.

> +				byte |= BIT(i);
>  		}
>  		*dst++ = byte;
>  	}

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


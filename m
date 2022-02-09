Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AA4AF29E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiBIN00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiBIN0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4632EC06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644413184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gj7EYe83fjjc2pVbDvN8nW0XXrWOw/vijRlZTRlTyb4=;
        b=Mcxz1mnVrIozmkuFD7qWJpNXslM5gzAlx88KnH97p0YvXfWuVseCEeZQFElb3f5skeedOI
        Xck1054Q0FdDVMqM2y/t3yL5vVSBUMWaQhCV4/oC5GAn45VtascEfG+/UZvv6R2DI9LUn0
        5tAEaOnE4JqZY9GKK6RghOfo4gRM7Fg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-hbLpfikLP1iWTVzTCyiSUg-1; Wed, 09 Feb 2022 08:26:23 -0500
X-MC-Unique: hbLpfikLP1iWTVzTCyiSUg-1
Received: by mail-wm1-f69.google.com with SMTP id i186-20020a1c3bc3000000b0037bb9f6feeeso1211809wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 05:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gj7EYe83fjjc2pVbDvN8nW0XXrWOw/vijRlZTRlTyb4=;
        b=4HOukX/1QssM/xi15laP0bVyqsUMaML7/310xx9owim1m4mLls9yfvTLiNBlEVTosA
         Kyea339x81Sc40o/bAZuyidjkODGAp0OAHbihmJ/vCGQAVKhbtF5QeEmQ6UVSSFf3SAh
         rZdH4h7GAVKVy88lWmIbDEsUPGHKJNCjYrfG3FKeWY05SwGpTtCzRUs3LloYvjg3Wa9o
         enCZ/N3ZR0XPVsmj0tLWX3RLhcDgxA7EfOaGZlA457RyLrZkWCbEISApz1x1nXmzlVGq
         TKXukoE23zn8pO+aplWA9F0Hpb/VolwCXa32I4mUpHxNkEsBG6J2lWKYJyAYNYqwk9c3
         WwvQ==
X-Gm-Message-State: AOAM533mFJhlTmd2b735YntSbBbWPo9EwhB5p3C33l/PZl2FKKk+U+nD
        Laf8LLbLNkw/Mb5ibTj8VxqPQPYmFLfwXsTuzICoznR7gWP28MAu788a5WTo7quH9lGTKqcGqIt
        +mItZc/OdEtNVuMIIX9nBerwU
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr2067400wmg.178.1644413182026;
        Wed, 09 Feb 2022 05:26:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFKrknf35Xf2LefmXXuc7aRIfezVH3jBJsgn4R4Bvho+wSQI39jFu6aG9bFdzQzoX5XOf93w==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr2067383wmg.178.1644413181828;
        Wed, 09 Feb 2022 05:26:21 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6sm5678550wmq.6.2022.02.09.05.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:26:21 -0800 (PST)
Message-ID: <f75a1544-5a3e-e49f-7eab-5dd5c72584b9@redhat.com>
Date:   Wed, 9 Feb 2022 14:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/7] drm/format-helper: Add drm_fb_{xrgb8888,
 gray8}_to_mono_reversed()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-3-javierm@redhat.com>
 <6df9c28d-968d-ff16-988e-8e88e4734e49@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <6df9c28d-968d-ff16-988e-8e88e4734e49@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks a lot for your feedback.

On 2/9/22 13:51, Thomas Zimmermann wrote:
> Hi
> 

[snip]

>> +
>> +		if (xb == pixels - 1 && end_offset)
>> +			end = end_offset;
> 
> end_offset should be called end_len, because it is the number of bits in
> the final byte; but not the offset of the final bit.
>

Indeed.

[snip]

>> +void drm_fb_gray8_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
>> +				   const struct drm_framebuffer *fb,
>> +				   const struct drm_rect *clip)

[snip]

> 
> Do you really need that function. It's not exported and if it's not 
> otherwise used, I'd just remove it.  We don't keep unused interfaces around.
>

At the end after your suggestion of doing line-per-line conversions it is not
needed, but since I already typed it and we were talking about adding other
formats besides the fake XRGB8888 as an optimization (R8 for grayscale and
Dx or something like that for reversed mono), I thought that would be useful
to have it as a helper.

Also other drivers that want to advertise a R8 format could just use it and
not having to add their own helper. But I'm happy to drop it in v4 if you
think that's better to not have unused helpers. 

It could be taken from this patch-set anyways if someone wants to wire the
needed support for R8.

[snip]

>> +
>> +	/*
>> +	 * The reversed mono destination buffer contains 1 bit per pixel
>> +	 * and destination scanlines have to be in multiple of 8 pixels.
>> +	 */
>> +	if (!dst_pitch)
>> +		dst_pitch = DIV_ROUND_UP(linepixels, 8);
> 
> I'd do a warn_once if (dst_pitch % 8 != 0).
>

Agreed. I'll add a warning an mention that will be rounded up.

> 
>> +
>> +	/*
>> +	 * The cma memory is write-combined so reads are uncached.
>> +	 * Speed up by fetching one line at a time.
> 
> I once had a patchset that adds caching information to struct 
> dma_buf_map (soon to be named struct iosys_map).  Blitting helpers would 
> be able to enable/disable this optimization as needed.
> 
> However, your driver doesn't use CMA. It's backed by SHMEM. Do you 
> really want to keep that code in?
>

It doesn't but the repaper does. And since the plan was to make that driver
to use the helper instead of having their own, I wanted to also make sure
that would work well with CMA.

> 
>> +	 */
>> +	src32 = kmalloc(len_src32, GFP_KERNEL);
>> +	if (!src32)
>> +		return;
>> +
>> +	/*
>> +	 * Copies are done line-by-line, allocate an intermediate
>> +	 * buffer to copy the gray8 lines and then convert to mono.
>> +	 */
>> +	gray8 = kmalloc(linepixels, GFP_KERNEL);
>> +	if (!gray8)
>> +		goto free_src32;
> 
> If might be faster to allocate both buffers in one step and set the 
> pointers into the allocated buffer.
>

Not sure I got this. Do you mean to have a single buffer with length
linepixels + len_src32 and point src32 and gray8 to the same buffer ?

>> +
>> +	/*
>> +	 * For damage handling, it is possible that only parts of the source
>> +	 * buffer is copied and this could lead to start and end pixels that
>> +	 * are not aligned to multiple of 8.
>> +	 *
>> +	 * Calculate if the start and end pixels are not aligned and set the
>> +	 * offsets for the reversed mono line conversion function to adjust.
>> +	 */
>> +	start_offset = clip->x1 % 8;
>> +	end_offset = clip->x2 % 8;
> 
> end_len, again. If you have 1 single bit set in the final byte, the
> offset is 0, but the length is 1.
>

Agreed, will change it too.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


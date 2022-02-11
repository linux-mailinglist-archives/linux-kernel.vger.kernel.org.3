Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7224B24C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349604AbiBKLuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:50:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBKLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CF41F3B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644580208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OICV3mcUbBxV6suQ2V0x/IRiIlr0MLiQcnu4h3ef4B4=;
        b=cLtGToEM1gvFiuuCpFl7M/zGyP3bGDi9PLeeXyZj15DvPcyhmUl8vsF2xQHz21FTmhqJ1i
        vLKh1K6y899YB6Nkc+snbEaB9CgSC1N0nxNkq+7OO0kyZna6IVQgkcPj4OWsLoZUGgHsLL
        DVPW41KYxSxCjjPRHpoBWWwUjPgz3Zw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-6BwHNgJHNDueH2qIuB21uQ-1; Fri, 11 Feb 2022 06:50:07 -0500
X-MC-Unique: 6BwHNgJHNDueH2qIuB21uQ-1
Received: by mail-wr1-f71.google.com with SMTP id g17-20020adfa591000000b001da86c91c22so3790317wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OICV3mcUbBxV6suQ2V0x/IRiIlr0MLiQcnu4h3ef4B4=;
        b=lvzFUd/3ukNgZHKWGFBx3ppBmYTnD1WWXwfvpqFBzAc/Xzpk2Qrgco29maf8D++EgP
         Jb2QmZHctNwZO9XE8qtLu11xXubmyVmm8wSNOYRJMvMQs0ovwyVyPcHr+wv2QSFgkDPE
         hZaVS8BaO2DyUX1WneBk/pZrxJE98/rgPXyf/iZtQ00BomzjX8KHuRYnxg4RuD3oPkq7
         EIrzq6+lKlsHHLXzB0Qx00ZxW7lMhNgSThcfxtpbjaK+iao79fSVDZgGYjhx1yvR0Mcu
         VK2hoMM9DmJOEbuKwWnfRYE/SE7Cgyxwi0RE1Qk1CkDc2J78cmPldJ4qVqzPEIOUP6eB
         xMmg==
X-Gm-Message-State: AOAM530rJsrO4PW/mlLrZr42dpoRUNsIbdyBaUcWluGGEl9DEFH7RtXT
        bNePlonR8Vi5K2OepLrQOdVO3qROg7WZV8JmZkokNjFh0AZPDfFL76xi4YSTAIVMzIuQKIyyQsz
        Vl/AcndW65GTY6CXP9eWJPLqE
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr1064550wrm.635.1644580206266;
        Fri, 11 Feb 2022 03:50:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxu19EHwNoykZrkYLd84XXhMKpSr092i38lxhqdJ6Cbdpiv/di8sAiWsz0wnYXMkIZVmABsA==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr1064526wrm.635.1644580205951;
        Fri, 11 Feb 2022 03:50:05 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay12sm2689074wrb.73.2022.02.11.03.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:50:05 -0800 (PST)
Message-ID: <00616642-1c95-9258-ab6e-b08116b36d21@redhat.com>
Date:   Fri, 11 Feb 2022 12:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-3-javierm@redhat.com>
 <YgZEPo0ERFRloDyA@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgZEPo0ERFRloDyA@smile.fi.intel.com>
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

Hello Andy,

Thanks for your feedback.

On 2/11/22 12:10, Andy Shevchenko wrote:

[snip]

>> +static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
>> +					       unsigned int start_offset, unsigned int end_len)
>> +{
>> +	unsigned int xb, i;
>> +
>> +	for (xb = 0; xb < pixels; xb++) {
>> +		unsigned int start = 0, end = 8;
>> +		u8 byte = 0x00;
> 
>> +		if (xb == 0 && start_offset)
>> +			start = start_offset;
> 
> This is invariant to the loop, can be moved out.
> 
>> +		if (xb == pixels - 1 && end_len)
>> +			end = end_len;
> 
> Ditto. However it may require to factor out the following loop to a helper.
>

Not sure I'm following, it's not invariant since it depends on the
loop iterator value. It only applies to the first and last pixels.
 
[snip]

>> +	/*
>> +	 * The reversed mono destination buffer contains 1 bit per pixel
>> +	 * and destination scanlines have to be in multiple of 8 pixels.
>> +	 */
>> +	if (!dst_pitch)
>> +		dst_pitch = DIV_ROUND_UP(linepixels, 8);
> 
> round_up() ?
> 

But it's not a round up operation but a div and round up.

>> +	WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> 
> 
> I would move this to the if conditional, i.e.
> 
> 	if (dst_pitch)
> 		WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
> 	else
> 		dst_pitch = round_up(linepixels, 8);
>

No, because we always need to div and round up. The warning is just printed to
let know that the dst pitch is not a multiple of 8 as it should be. So callers
could be fixed.

>> +	/*
>> +	 * The cma memory is write-combined so reads are uncached.
> 
> CMA
>

Yes, this bug me too. But other format helpers (e.g: drm_fb_xrgb8888_to_rgb565
and drm_fb_xrgb8888_to_gray8) had this comment with CMA in lower case. So did
the same for consistency.

>> +	 * Speed up by fetching one line at a time.
>> +	 *
>> +	 * Also, format conversion from XR24 to reversed monochrome
>> +	 * are done line-by-line but are converted to 8-bit grayscale
>> +	 * as an intermediate step.
>> +	 *
>> +	 * Allocate a buffer to be used for both copying from the cma
>> +	 * memory and to store the intermediate grayscale line pixels.
>> +	 */
>> +	src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
> 
> size_add() ?
>

I wasn't familiar with this macro and git grep returned nothing. Then I noticed
that it is fairly new, introduced in commit a66866cff71c ("overflow: Implement
size_t saturating arithmetic helpers").

git tag --contains a66866cff71c | head -1
next-20220207

So I can't really use it since isn't yet in the latest drm-misc-next base tag :)

>> +	if (!src32)
>> +		return;
> 
> ...
> 
>> +	/*
>> +	 * For damage handling, it is possible that only parts of the source
>> +	 * buffer is copied and this could lead to start and end pixels that
>> +	 * are not aligned to multiple of 8.
>> +	 *
>> +	 * Calculate if the start and end pixels are not aligned and set the
>> +	 * offsets for the reversed mono line conversion function to adjust.
>> +	 */
>> +	start_offset = clip->x1 % 8;
>> +	end_len = clip->x2 % 8;
> 
> ALIGN() ?
> 

But we don't want to align here but to know what's the start and end if is
not aligned since that would mean converting to mono in the middle of a byte.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


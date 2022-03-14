Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64764D8676
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbiCNOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiCNOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A688658F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647266868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1n9imp/roVGFW+MJg7Js2iXDtKYDylDPOOBQLufwOMo=;
        b=Ib7Pdsjf9S4oNapcCrEYDvb9D+sgnXAUpoPBex98vP0pq+qX/rUUst20SGJKrSmL+SBYnh
        6/A3zMb9MSxgkmNe8+N1yO9TZhX9ABkLiAtNdcAfZL2rpOJdaOrmFv9jjgG6wnliAJmLET
        yhcikAupQIvbLDXRtM06kaTDOJPwsGM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-3sMVhHg5O0CK2TiHjcthqg-1; Mon, 14 Mar 2022 10:07:47 -0400
X-MC-Unique: 3sMVhHg5O0CK2TiHjcthqg-1
Received: by mail-wr1-f71.google.com with SMTP id a5-20020adfdd05000000b001f023fe32ffso4388314wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1n9imp/roVGFW+MJg7Js2iXDtKYDylDPOOBQLufwOMo=;
        b=YhPwe7VZyQJMbQHUA7GHLhkiXmgZsKj4Jr5Lpjx3mZBlFT7IO+LPZhoKxcUuTvDhy1
         zZe6qRtYLAuFEAWlXLBw5DQYkknwKMMFxUT9DgNQVK7lU+IbXYgwCvfj4hQ5GiNWR0x8
         adY4I/UUHXnWZ8ORmVbNjm8IJ7G9q1xL2wLlayL9/fiRRTvnvAY27XoFKyYb3xbiUyuj
         aYX/L1Wd3k7OJ/RoTmyk+QmhsjsBMuUXm7lQxkCQ4uqrMgtSCMP8rfS56ZzHZS41lUwk
         DBBWjGexzJp67UrmFeXsfJieQyStdTfSKB7fWWu8BvAnx4uASOwkdDW0k/5uml0Ykk/C
         29UA==
X-Gm-Message-State: AOAM530l6t4QRHkuTI/RNr/jtcHbJg20mwzHEqEcBeXodouqnydfx/ag
        GsSTqcyGf6tiYLsGtDaBW7blbtlF+uqWt2MUF9ZQGTIUcpJ3jHuPSUwTv7+jcdDs/ckrn125DOa
        h5HlzTqWrRyGf0ZmdvhEkeQs3
X-Received: by 2002:a5d:6daf:0:b0:203:8214:ae65 with SMTP id u15-20020a5d6daf000000b002038214ae65mr16784118wrs.145.1647266866158;
        Mon, 14 Mar 2022 07:07:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUmZKMWpb2vbN6Fu8O0zteEWAjmmY/DHvyxw4A1qQVFF+i6VWRfQ9qS5Kjt/nNczT10/+Vzw==
X-Received: by 2002:a5d:6daf:0:b0:203:8214:ae65 with SMTP id u15-20020a5d6daf000000b002038214ae65mr16784102wrs.145.1647266865920;
        Mon, 14 Mar 2022 07:07:45 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b00389bcc75559sm15441665wml.27.2022.03.14.07.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:07:45 -0700 (PDT)
Message-ID: <9b8bbc6a-e499-99c7-8fe6-95c4256ef61d@redhat.com>
Date:   Mon, 14 Mar 2022 15:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] drm/format-helper: Add
 drm_fb_gray8_to_mono_reversed()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-3-javierm@redhat.com>
 <CAMuHMdWPQrErbMZ4wJPgROY7XOnKGvimNFg8JpiyuWqz2a3Gzw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWPQrErbMZ4wJPgROY7XOnKGvimNFg8JpiyuWqz2a3Gzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 3/14/22 14:40, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Mon, Jan 31, 2022 at 9:12 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Add support to convert 8-bit grayscale to reversed monochrome for drivers
>> that control monochromatic displays, that only have 1 bit per pixel depth.
>>
>> This helper function was based on repaper_gray8_to_mono_reversed() from
>> the drivers/gpu/drm/tiny/repaper.c driver.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
>> --- a/drivers/gpu/drm/drm_format_helper.c
>> +++ b/drivers/gpu/drm/drm_format_helper.c
>> @@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>>         return -EINVAL;
>>  }
>>  EXPORT_SYMBOL(drm_fb_blit_toio);
>> +
>> +/**
>> + * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
>> + * @dst: reversed monochrome destination buffer
> 
> What's the meaning of "reversed"?

Originally I took this helper from the repaper driver and it was called
repaper_gray8_to_mono_reversed(), so the naming just got carried over.

> During the last few days, I've been balancing between (a) "reverse
> video" and (b) "reverse bit order", but none of them seems to be true.
>
> (a) The code maps 0-127 to 0 and 8-255 to 1, which just reduces from
>     256 to 2 grayscale levels, without inversion. The result is also
>     white-on-black on my ssd130x OLED.
> (b) On little-endian, the CFB drawops use little-endian bit order,
>     which is what ends up in "byte" in the code below.
>

As far as I understand is (a) from the options since the repaper display
uses black-on-white. But as you pointed out the ssd130x OLEDs instead do
white-on-black.

I should had probably just name the helper drm_fb_gray8_to_monochrome()
or maybe drm_fb_gray8_to_gray1() ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D84A5979
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiBAJtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233633AbiBAJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643708947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgw5tIdcmG3vshG+0+gBxrtdGFyTyK1rBRl6JhXtTTs=;
        b=jDHrKLYoOVxrDiMVB0C1CGZx0xUGi8jziJTRfHAb7Tv2v38f2HtSFZH6zV+HJBFaEwD1LP
        NKa6DEo+5GWSuCuotXmdWzeqsXKgnERspsy9VSRdfm48CvW3mN6DT3Y/tnj576kFRDTCX7
        q6n6jmvv92qky/FUlVWtFSQE71zHuT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-75TkiHj8N8iEKKZli1gUdg-1; Tue, 01 Feb 2022 04:49:06 -0500
X-MC-Unique: 75TkiHj8N8iEKKZli1gUdg-1
Received: by mail-wr1-f72.google.com with SMTP id c10-20020adfa30a000000b001d79c73b64bso5815864wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 01:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tgw5tIdcmG3vshG+0+gBxrtdGFyTyK1rBRl6JhXtTTs=;
        b=Fv2AmdVrLS7nYd1ZArmRg4RBEfteUAD1h24QKf8MQNTaGwQrUCJvNdN+1EasS7KKmk
         DLGQgEFZY0ggmCexJgb23nEhKvoW8jZu0YIr+GQlFYbo5p/mBwRx0neKKx43MXxQZUUf
         iAdWkNBhofj8HSJ0w906cURO0mx6b8tOqv2U8KZbn93fjd+GAs3V2Xog0t2zhkPpBoWq
         nnN0jOdilmB73oKP18m5tsic8q7rWWWi76FFHN+kJlU8y9SogCDymfLf1zCkM6/I7tiD
         YkfgK8TaWvBoQzX7jJpN7I3SNZ+tL/Hvt3IjM7ZnA0BOHo0Vbo2e9AjRUEKFb/+F+kCT
         yDLw==
X-Gm-Message-State: AOAM530rwOMVyCGxzfxIL6poknY0hW+mZH3WOkqckuFUyd9uuixzlwOY
        EkXQDzvNTInifwkCf9fOhxwNt1jYU448Oa5wMvGq0GVJhwpgtT6F7hHTleXlQZ58eArgqjIgO6C
        yuGherobe7F1zKGWoyepI7vTd
X-Received: by 2002:a05:600c:3b11:: with SMTP id m17mr1026426wms.192.1643708945630;
        Tue, 01 Feb 2022 01:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhdmeA5uA8GuAXm+vPaWNlMLqtSa4TRUAHzW7ciPujCzAtcTIso4F/n2y/BPseeK89sy1Vtw==
X-Received: by 2002:a05:600c:3b11:: with SMTP id m17mr1026395wms.192.1643708945346;
        Tue, 01 Feb 2022 01:49:05 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10sm17584320wrf.96.2022.02.01.01.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 01:49:04 -0800 (PST)
Message-ID: <b0788b3d-9c77-0e96-0969-380d21663909@redhat.com>
Date:   Tue, 1 Feb 2022 10:49:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Ser <contact@emersion.fr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
 <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
 <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
 <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 09:38, Daniel Vetter wrote:
> On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrote:
>>
>> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>>> What's the story with the Rn formats?
>>>
>>> The comments say "n bpp Red", while this is a monochrome (even
>>> inverted) display?
>>
>> I don't think the color matters that much. "Red" was picked just because it was
>> an arbitrary color, to make the difference with e.g. C8. Or am I mistaken?
> 
> The red comes from gl, where with shaders it really doesn't matter
> what meaning you attach to channels, but really just how many you
> have. So 2-channel formats are called RxGx, 3-channel RxGxBx,
> 4-channel RxGxBxAx and single-channel Rx. And we use drm_fourcc for
> interop in general, hence why these exist.
> 
> We should probably make a comment that this really isn't a red channel
> when used for display it's a greyscale/intensity format. Aside from
> that documentation gap I think reusing Rx formats for
> greyscale/intensity for display makes perfect sense.
> -Daniel

To sump up the conversation in the #dri-devel channel, these drivers
should support the following formats:

1) Dx (Daniel suggested that for darkness, but inverted mono)
2) Rx (single-channel for grayscale)
3) RxGxBxAx (4-channel fake 32-bpp truecolor)

The format preference will be in that order, so if user-space is able
to use Dx then there won't be a need for any conversion and just the
native format will be used.

If using Rx then only a Rx -> Dx conversion will happen and the last
format will require the less performant RxGxBxAx -> Rx -> Dx path.

But we still need RxGxBxAx as a fallback for compatibility with the
existing user-space, so all this could be done as a follow-up as an
optimization and shouldn't block monochromatic panel drivers IMO.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68B6509FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385682AbiDUMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385644AbiDUMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0976A326F0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650545270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnOf3NHeZTSr4cEYbvvix37pw/apJI2q+GJ3+PP81w0=;
        b=adeGPANgsejNeCirqbYaCpwDV7+aiUoGLVQRuZu8oJW0OMimCRCyUDSLPq7Bbaoimt17HY
        0WRRzr7NDg/qGC6sSpwebf/GQuuynV6gvFLuXkEtq6SYXOP9zgM9nUo8BWr/bT4rKxbGGs
        k/3ipA5IyXEIc05/T+qzuhyey25WvRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-a3NyEnswOcmBcCql8A1jTA-1; Thu, 21 Apr 2022 08:47:49 -0400
X-MC-Unique: a3NyEnswOcmBcCql8A1jTA-1
Received: by mail-wm1-f72.google.com with SMTP id v191-20020a1cacc8000000b0038ce818d2efso2331601wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TnOf3NHeZTSr4cEYbvvix37pw/apJI2q+GJ3+PP81w0=;
        b=MzXaAS3KfNq4gVQZfjJ264c0RlUuXwxhhp5VbbDLBgac7D4jthQEQXGPyhGnTGR3dA
         6Jsb+WgE3GjeovqVIp9OmU8eG/HqtwnwImauZR1IvV4lO2eP7kN9WnRz5oxJwKasZb7f
         32Ms8OKsDo93FeovTj2kMsFc5mHeGF/aKRs+wuGn7JAj+XLNk84J2qFACTofhJ5AzfA2
         TFataMVQ/nqQn9aTqCV4o9+0aRTyuj8Qg+zIP3tEGuvVg5MD7ku09FTRUUsPAaU13WDH
         T//7YtQsbjfee6fadM1vLpvum3ffo+XlGinBGp/X0U3WmChyM/y9BH050QV/xawSC/XU
         wPGw==
X-Gm-Message-State: AOAM532Q91zkleMuQvHTSUhYDdV3ICer2619Och7Xr3yxYfQYveB4Eza
        /c8Eq24zBPmg39DcgQdpyGRV9WVHLC3v+uo9MzTI9VAjRdC5RmOsTwSGZzDUTWH+9Jk8bkT6FHj
        zvs1eSmIH7Q/Btswj34Xdo4Gh
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr18446929wrp.299.1650545267313;
        Thu, 21 Apr 2022 05:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM7PKieGr1IEXIphps56gblQ+HazfGrEHkPNWi6ZMSTtd09VlmmzSO/ZCY16iuoKF1G1KUhw==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr18446919wrp.299.1650545267042;
        Thu, 21 Apr 2022 05:47:47 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0038ed14b7ac3sm1955281wmq.40.2022.04.21.05.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 05:47:46 -0700 (PDT)
Message-ID: <dce29330-e40c-860e-2c72-7ddebdd96e20@redhat.com>
Date:   Thu, 21 Apr 2022 14:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
Content-Language: en-US
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>,
        James Hilliard <james.hilliard1@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de>
 <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Patrik,

On 4/21/22 14:39, Patrik Jakobsson wrote:
> On Thu, Apr 21, 2022 at 1:49 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Hi
>>
>> Am 09.04.22 um 06:23 schrieb James Hilliard:
>>> Select the efi framebuffer if efi is enabled.
>>>
>>> This appears to be needed for video output to function correctly.
>>>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>> ---
>>> Changes v2 -> v3:
>>>    - select EFI_FB instead of depending on it
>>> Changes v1 -> v2:
>>>    - use depends instead of select
>>> ---
>>>   drivers/gpu/drm/gma500/Kconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
>>> index 0cff20265f97..a422fa84d53b 100644
>>> --- a/drivers/gpu/drm/gma500/Kconfig
>>> +++ b/drivers/gpu/drm/gma500/Kconfig
>>> @@ -2,11 +2,13 @@
>>>   config DRM_GMA500
>>>       tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
>>>       depends on DRM && PCI && X86 && MMU
>>> +     depends on FB
>>
>> Why do we need FB here? Framebuffer support should be hidden by DRM's
>> fbdev helpers.
> 
> It is not needed but gives him video output since it enables the drm
> fbdev emulation.
>

I'm not sure to understand this. Shouldn't depend on DRM_FBDEV_EMULATION then?
 
> I looked some more at the logs and it seems weston doesn't work on his
> system without the fbdev backend. So the question is why weston isn't
> working without fbdev? Perhaps this is just a Weston configuration
> issue?
> 

But is weston using the fbdev emulated by DRM or the one registered by
efifb? I thought that the latter from what was mentioned in this thread.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


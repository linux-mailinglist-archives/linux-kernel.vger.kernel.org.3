Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB59350A0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiDUNZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDUNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D36B332EDC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650547378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJojMIzm435XzabOfDtYuG0zr6ejdW43VXmGBccZZNg=;
        b=DzzPr3kaGVjo5nhRpCRmPFGITEIZK4EAEgCSUVbf3QCneU1a/HcdODnILT3NbwklQTvzND
        DyEb6GHLpHELBPA1veABtEGUwhFZuoYh/HBNxF+mF4/pjB6MgWtcHIGAvaN/ELfP3hKWrY
        Lettolki99P7l4iKh49UpqNVHQCa6NA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-HP0bPBQINzmn7yloeuPwwg-1; Thu, 21 Apr 2022 09:22:57 -0400
X-MC-Unique: HP0bPBQINzmn7yloeuPwwg-1
Received: by mail-wm1-f71.google.com with SMTP id p31-20020a05600c1d9f00b0038ed0964a90so2414459wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BJojMIzm435XzabOfDtYuG0zr6ejdW43VXmGBccZZNg=;
        b=ZzcZPJHaMSI2QmqIuAHNGplM1eLNQ52mJm5zHxVlMAry0Zz6HECMlTGohmD/0WF1zd
         SEfHIyLE0AnvfX7pVxXcmKeCS8fAcTOM4FtHcqkgOHTmcb3N/rjzgkTGeCrwI1jp/I8H
         EI6cRs3aMzzNkx/r6nsnZEjhQBzwh/f5MeerCVilo21lr4H+05+GJkV9Ndpwjq85iuJI
         H2xqrxUI5QIz02Ox4qXpGZrwczw2ydXzDXoWkocT7/THVu6qszyrG/wZXGBcbZngSuD6
         dI5JvC9X1MerVp6MedzWLAUKeoTRi1HurrR4BYnvGWGNcoNCiJqtQlZmTK8sq2mIFhgu
         zEcA==
X-Gm-Message-State: AOAM531WWkg53Sm346ioefERbGbknucHD50OB40cvFqTWSxRZQeQriDj
        xn0TUF6iuj5zd2oHxL5pOblxWt5iMMdKoaqZ7wtunBtcBHoFMLovL/rKWBDyIdxfBqGpRN950dJ
        ZfCEOzzQYJTPr4AoNLFhDTEvn
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id q22-20020a1ce916000000b0037cf44f0573mr8663743wmc.179.1650547376599;
        Thu, 21 Apr 2022 06:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn3A3s5KnRy+9aLB72aBChb71Yy22EwcgU2Ux1UhqHDMPpPRcfl9e7aAlABnXQkQlFn6odPw==
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id q22-20020a1ce916000000b0037cf44f0573mr8663714wmc.179.1650547376244;
        Thu, 21 Apr 2022 06:22:56 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d64ca000000b0020aa97b0383sm2267705wri.113.2022.04.21.06.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:22:55 -0700 (PDT)
Message-ID: <10c81e57-2f09-f4f8-dc2f-6bd05ef819d7@redhat.com>
Date:   Thu, 21 Apr 2022 15:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
Content-Language: en-US
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        James Hilliard <james.hilliard1@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de>
 <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
 <dce29330-e40c-860e-2c72-7ddebdd96e20@redhat.com>
 <CAMeQTsYYpw5+uLgmDrbB6PUBotRC4F+_rfK+sxT0CpPHoiOmmw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMeQTsYYpw5+uLgmDrbB6PUBotRC4F+_rfK+sxT0CpPHoiOmmw@mail.gmail.com>
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

On 4/21/22 14:54, Patrik Jakobsson wrote:
> On Thu, Apr 21, 2022 at 2:47 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

>>>>> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
>>>>> index 0cff20265f97..a422fa84d53b 100644
>>>>> --- a/drivers/gpu/drm/gma500/Kconfig
>>>>> +++ b/drivers/gpu/drm/gma500/Kconfig
>>>>> @@ -2,11 +2,13 @@
>>>>>   config DRM_GMA500
>>>>>       tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
>>>>>       depends on DRM && PCI && X86 && MMU
>>>>> +     depends on FB
>>>>
>>>> Why do we need FB here? Framebuffer support should be hidden by DRM's
>>>> fbdev helpers.
>>>
>>> It is not needed but gives him video output since it enables the drm
>>> fbdev emulation.
>>>
>>
>> I'm not sure to understand this. Shouldn't depend on DRM_FBDEV_EMULATION then?
> 
> No, it shouldn't depend on any FBDEV stuff since it's not actually
> required. It just happens to help in this case since weston + fbdev
> backend works but not weston with drm backend (or whatever config
> James have set).

I see. Then the correct approach for them would be to just enable CONFIG_FB
and DRM_FBDEV_EMULATION in their kernel config, rather than making this to
depend on anything FB related as you said.

> 
>>
>>> I looked some more at the logs and it seems weston doesn't work on his
>>> system without the fbdev backend. So the question is why weston isn't
>>> working without fbdev? Perhaps this is just a Weston configuration
>>> issue?
>>>
>>
>> But is weston using the fbdev emulated by DRM or the one registered by
>> efifb? I thought that the latter from what was mentioned in this thread.
> 
> It's using drm fbdev emulation with gma500 so EFIFB has nothing to do
> with this. I believe it was just simply incorrectly reported. If I'm
> correct then "depends on FB" is what makes video output work for
> James.
> 

Got it. Thanks for the clarification.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


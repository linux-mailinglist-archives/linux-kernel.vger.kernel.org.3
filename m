Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6E51479A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358400AbiD2Kyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiD2Kxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8467211A0B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651229424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJJtQxv1WQFSKERn7SwPf179LKVZ2H2eHmmNQIPl4mc=;
        b=HhzrN00caam06dOaN9UJTUpg2niHPpyKOef7u3yh0MrjtNqN4aGgNoBNdPIP01ET24h9sw
        PHwXI+2+7sRE1VO/mlrH30m51L59VKJsbBG8rh3ljacSglfkR38Gts1Xsaz9uw+/42PwsM
        izAFKdwfYtgmVZk0eblPuVyrYy1epPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-ZJ0y4X2WNmmmgcWDekob4Q-1; Fri, 29 Apr 2022 06:50:23 -0400
X-MC-Unique: ZJ0y4X2WNmmmgcWDekob4Q-1
Received: by mail-wr1-f72.google.com with SMTP id u26-20020adfb21a000000b0020ac48a9aa4so2928780wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UJJtQxv1WQFSKERn7SwPf179LKVZ2H2eHmmNQIPl4mc=;
        b=y8071gqx/s0mR1UBnhJ8ODdcMu7M9IN/pGMgPt1F1KtmInLY0tSzHE1qfY7/38isYU
         DLHhkwNiY59QxnwG5rDmo3HWWRZuHTK40QPdI44mVcs7gtVQIOK1qMuR+c14ycU9wQmN
         9tS794rFRsoHJGtHOxr8qQ+U2HxvaV6xMgAPikC+MzsWhwr8trmLNZaJQ427/OULH1B7
         R9PCIIUf2d3oIMbzocUNlsx1YP+JWikwi8ttJXW0hykUnu5Wqau5/NUOq4egOr20uZB7
         T4fWixP1ixRnS7/Vk06MgOSCz7IMQ6AQzyeSqUm0ukoiGGYoUIgEn6XOcBdMBTLi3vpt
         EaWQ==
X-Gm-Message-State: AOAM5327Ov7G6R+Wvr1g7gu2n0B7f9I+ZeBnHjcTVfoBisVJNHOsvVNS
        IbgOG4J/a2mBl8H02vXmxbVaYUtqhiYFcjqcenSJ3yYkruGQ2ZBgj0nw2+rzQVoGBdiz+ux+hX1
        Me+DAKF01kGcR90G0RyKWFCw2
X-Received: by 2002:a05:6000:108e:b0:20a:d9a9:ad31 with SMTP id y14-20020a056000108e00b0020ad9a9ad31mr20866791wrw.331.1651229421998;
        Fri, 29 Apr 2022 03:50:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkqNVsWWkg3kncGIxxxi5dpKG8+ouBhLBj9X3lIkscb9aTewE6sU4DUEzKMvU1g4f9U0sb6w==
X-Received: by 2002:a05:6000:108e:b0:20a:d9a9:ad31 with SMTP id y14-20020a056000108e00b0020ad9a9ad31mr20866760wrw.331.1651229421574;
        Fri, 29 Apr 2022 03:50:21 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm2703007wmp.14.2022.04.29.03.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 03:50:21 -0700 (PDT)
Message-ID: <8671b156-af04-c728-d7bb-1019badbd13a@redhat.com>
Date:   Fri, 29 Apr 2022 12:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH v4 02/11] drm/fb-helper: Set FBINFO_MISC_FIRMWARE flag
 for DRIVER_FIRMWARE fb
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220429084253.1085911-1-javierm@redhat.com>
 <20220429084253.1085911-3-javierm@redhat.com>
 <7ce2f8e1-9cf2-4d89-99c2-b4280e4758ba@suse.de>
 <476d57e5-69dd-94b5-779f-230e091ae62f@redhat.com>
 <82dc11b4-d8da-e9e9-8181-5695fbd806de@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <82dc11b4-d8da-e9e9-8181-5695fbd806de@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 12:20, Thomas Zimmermann wrote:
> Hi Javier

[snip]

>>   
>>> We can do this with DRIVER_FIRMWARE. Alternatively, I'd suggest to we
>>> could also used the existing final parameter of
>>> drm_fbdev_generic_setup() to pass a flag that designates a firmware device.
>>>
>>
>> By existing final parameter you mean @preferred_bpp ? That doesn't seem
>> correct. I also like that by using DRIVER_FIRMWARE it is completely data
>> driven and transparent to the DRM driver.
> 
> DRIVER_FIRMWARE is an indirection and only used here. (Just like 
> FBINFO_MISC_FIRMWARE is a bad interface for marking framebuffers that 
> can be unplugged.) If a driver supports hot-unplugging, it should simply 
> register itself with aperture helpers, regardless of whether it's a 
> firmware framebuffer or not.
>

That's fair, and if in practice will only be used by one driver (simpledrm)
then that would also allow us to drop patches 1 and 2 from this series.

IOW, we wouldn't really need a DRIVER_FIRMWARE capability flag.
 
> Of preferred_bpp, we really only use the lowest byte. All other bits are 
> up for grabbing.  The argument is a workaround for handling 
> mode_config.prefered_depth correctly.
>

Yeah, but I didn't want to abuse that argument or package data in an int.

 
> Eventually, preferred_depth should be replaced by something like 
> 'preferred_format', which will hold the driver's preferred format in 
> 4CC.  We won't need preferred_bpp then. So we could turn preferred_bpp 
> into a flags argument.
>

That's a good point, maybe we could start from there and do this cleanup
as a preparatory change of this series ? Then the patches would only be
1) renaming preferred_bpp (that would be unused at this point) to flags
and 2) make simpledrm to set FBDEV_FIRMWARE flag or something like that.

Another option is to add a third flags param to drm_fbdev_generic_setup()
and make all drivers to set 0 besides simpledrm. That way marking the fb
as FBINFO_MISC_FIRMWARE won't be blocked by the preferred_depth cleanup.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


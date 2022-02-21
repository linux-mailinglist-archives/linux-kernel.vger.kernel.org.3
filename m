Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BCB4BEC30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiBUVCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:02:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiBUVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:02:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C81A23BD9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645477329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDRxqxZuWPSaCv6rqIdjrfVOR7wM38/w+tQeZAITHHI=;
        b=feF99/DPtSvRxmaICs0PAJhJWz2VZYANrn8+zSwAtbX/3W1b0pDv8PUJhrAmRbIAqWbUgJ
        r0vtc8axIhNB2sGxWnAufa3CRc7Y3to4LUVIubZy1BbSyjPNElaWZLW5dxMpLoBKmc7kJt
        FtLB7CSskCqUXwDIum9D0os5RPI/L3I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-8qqWOoImMdO9wpuebKMPuQ-1; Mon, 21 Feb 2022 16:02:07 -0500
X-MC-Unique: 8qqWOoImMdO9wpuebKMPuQ-1
Received: by mail-qk1-f197.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso15577777qko.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wDRxqxZuWPSaCv6rqIdjrfVOR7wM38/w+tQeZAITHHI=;
        b=rPHyEjWewnOJ9J0oCQdsVV2Ykm6qHCZgOenLWdUYYlZsglVEGunrq5xAxEAiQ0oEuu
         1AyniCAQohtO/wAzmrt2s6cz/5WIwr/NO2JPL/aqA80peNaOGyUx/j9jj0KRoz7gVcCU
         plkd4/TXdJdZ9gOWP2dzGhRN4KZ+KDzq9sD2r5OhVzZDKii37UZeJXNpDOOH53SbOti+
         pL9lbVF6KvJKkDilW1TVSNLtP/NKmL8QJdUdEU/upyW/lXUj6nFw9nNnRJwLtqEmCXIw
         Csozjcbdl5VGMMEMjuvU3Qsna9ASYguaS3bIhji9ZqE6Sb46qy3NjSWvkvsr6qBWdYb9
         Qntw==
X-Gm-Message-State: AOAM53157pUWerFLltksTdF40ehGWBUBnX73GxkEx4dNs0rmlPTnB8Bt
        o1B6xKfuGltQK79OiLDTp57E4TPG5WYXtwvZdo6t8n6FOlC7lIBCAKLCrgirWySLhhvd76469bX
        597RHLxrEGAO1MWTBUpuxXTcl
X-Received: by 2002:a05:620a:c4a:b0:508:ab56:416a with SMTP id u10-20020a05620a0c4a00b00508ab56416amr13105365qki.635.1645477327458;
        Mon, 21 Feb 2022 13:02:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMWVJJ3w7YQ16IhiKVsRJpXk3MDA7O6OtbGiyG5NMXzYhn7xuySqMgh6EnOg/tCrpRwnWHzw==
X-Received: by 2002:a05:620a:c4a:b0:508:ab56:416a with SMTP id u10-20020a05620a0c4a00b00508ab56416amr13105346qki.635.1645477327212;
        Mon, 21 Feb 2022 13:02:07 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id a20sm4639202qtx.6.2022.02.21.13.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 13:02:06 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix printk format for size_t variable
To:     Luben Tuikov <luben.tuikov@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, guchun.chen@amd.com, Prike.Liang@amd.com,
        Hawking.Zhang@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220221173737.3725760-1-trix@redhat.com>
 <84e354ec-cfbf-a23f-ddd5-417d6f029873@amd.com>
 <e490241d-9a22-f873-2b15-18b12896ea65@redhat.com>
 <84b3679e-8900-ae51-e700-867631618829@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <24848c09-8cee-5df1-bf4c-9d187ac107af@redhat.com>
Date:   Mon, 21 Feb 2022 13:02:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <84b3679e-8900-ae51-e700-867631618829@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/22 12:53 PM, Luben Tuikov wrote:
> On 2022-02-21 15:36, Tom Rix wrote:
>> On 2/21/22 11:57 AM, Luben Tuikov wrote:
>>> Hi Tom,
>>>
>>> This was already fixed with this patch, and LKML was CC-ed. See the CC tags in the patch below,
>>>
>>> commit 4f7d7cda90cbd7
>>> Author: Luben Tuikov <luben.tuikov@amd.com>
>>> Date:   Wed Feb 16 16:47:32 2022 -0500
>>>
>>>       drm/amdgpu: Fix ARM compilation warning
>>>       
>>>       Fix this ARM warning:
>> I glad it wasn't just mips ;)
>>
>> There have been a couple of build breaks with amdgpu recently.
>>
>> Nick asked about adding clang to your ci.
>>
>> Could at least one non x86_64 gcc also be added, maybe aarch64 ?
> Yeah, that's a great idea. I tried the make.cross (for ARM) as per
> the initial breakage report, but when I tried it, it got into a loop of
> "make ARCH=arm mrproper" --> "make prepare" --> "make ARCH=arm mrproper" --> "make prepare" --> ...
> and I couldn't figure out why.
Maybe need to set CROSS_COMPILE ?
> I don't mind adding ARM cross compilation into my local setup.

For crosses, I generate a 'make' script like

#!/bin/sh

export PATH=<path-to-cross-tools>/bin:$PATH

make ARCH=arm64 CROSS_COMPILE=aarch64-elf- $@

so workflow looks like normal, replacing make with ./make

Tom

>
> Regards,
> Luben
>
>
>> Tom
>>
>>>       
>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld'
>>>       expects argument of type 'long int', but argument 4 has type 'size_t' {aka
>>>       'unsigned int'} [-Wformat=]
>>>       
>>>       Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>       Cc: kbuild-all@lists.01.org
>>>       Cc: linux-kernel@vger.kernel.org
>>>       Reported-by: kernel test robot <lkp@intel.com>
>>>       Fixes: 7e60fbfbdc10a0 ("drm/amdgpu: Show IP discovery in sysfs")
>>>       Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>       Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index 2506bcf36c870c..6c7ec058125e1d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>>                               le16_to_cpu(ip->hw_id) != ii)
>>>                                   goto next_ip;
>>>    
>>> -                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>>> +                       DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
>>>    
>>>                           /* We have a hw_id match; register the hw
>>>                            * block if not yet registered.
>>>
>>> Regards,
>>> Luben
>>>
>>> On 2022-02-21 12:37, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> On mips64 allyesconfig, there is this build break
>>>> amdgpu_discovery.c:671:35: error: format '%ld' expects
>>>>     argument of type 'long int', but argument 4 has
>>>>     type 'size_t' {aka 'unsigned int'}
>>>>     DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>>>>
>>>> For size_t, use %zu.
>>>>
>>>> Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> index 7c7e28fd912e..58238f67b1d3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> @@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>>>    			    le16_to_cpu(ip->hw_id) != ii)
>>>>    				goto next_ip;
>>>>    
>>>> -			DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>>>> +			DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
>>>>    
>>>>    			/* We have a hw_id match; register the hw
>>>>    			 * block if not yet registered.
>>> Regards,
> Regards,


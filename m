Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784404BEBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiBUUhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:37:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiBUUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E33237CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645475812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OkxKWpQx5iuNsF54dXkXbOPAbRKT1pxdxrwColcc4Lg=;
        b=bew/PE3MqGBLA6Iuz3xelkWqqTvrNfq61Kmwk1CvwDYyYHl+bgmgF+LVvQvNQx746hRa7C
        AlBX5R6Ft/yg2rH8K6tn+V9sMoEGf6SFnEiFqc1VpnlGGIE3Q1TV6nvHeq0YT4QQSsTaSc
        ryQlUPvo1FeVbs1l/nMkxGqSPhH6R58=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-QeIhbjlzPGK_VOqX14Iulw-1; Mon, 21 Feb 2022 15:36:50 -0500
X-MC-Unique: QeIhbjlzPGK_VOqX14Iulw-1
Received: by mail-qk1-f199.google.com with SMTP id i10-20020a05620a144a00b00648d4fa059dso4497733qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OkxKWpQx5iuNsF54dXkXbOPAbRKT1pxdxrwColcc4Lg=;
        b=Ei/E+LWCQJE9C7jS7MxVgzpvD6z7NVKWdvlQBO1EGr3XJ7aDjm9Y6efnXWaORQtAnV
         2lI6sjU5W06bvhSVyBKiy1DlEN8OrcChVYtG9GbLM4ATYU5jLxqiLozMH8N43w6pZukU
         GfzkMYfHD71udEti0oeGOS1saqZeMhnnP36vXjB+ContvmA30fgnyr6ST7ULnDox110b
         gY4L/8LZug/kvJYxuHs4nZzst2KcTTVCWDgDrcDQBt22Dsp4OtNjsbJ7Ud5v6qOe6NT9
         M2LeNjBgoGlUlbG/Ryoeqbw4n5+ktyL6fB4fGTHXkPZY28kqsN7vddlpNhquLkOkVCit
         CBEg==
X-Gm-Message-State: AOAM533XAlqgGp0XiyGW9wr3fwJOnqATa44j3w+fH3jWSJLHoltRJYqI
        F6fzL/Ef0bumoiNggZR2MRxEmUnuJjqurOLK10c0h1sc3xfl62wielOihun3Uz9cc9DM0Muh8Jn
        KLhjL8wPgzpEq8PILctCHlARt
X-Received: by 2002:a05:622a:187:b0:2d6:8444:e30c with SMTP id s7-20020a05622a018700b002d68444e30cmr19439467qtw.413.1645475810352;
        Mon, 21 Feb 2022 12:36:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1SIyikKpt7KcdTkPlcwI08+ZgJfv7m97UYuDDAl3EUY10LCmode/caJrxhfn3/liH99A5Rw==
X-Received: by 2002:a05:622a:187:b0:2d6:8444:e30c with SMTP id s7-20020a05622a018700b002d68444e30cmr19439455qtw.413.1645475810151;
        Mon, 21 Feb 2022 12:36:50 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x13sm28560921qko.114.2022.02.21.12.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:36:49 -0800 (PST)
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
From:   Tom Rix <trix@redhat.com>
Message-ID: <e490241d-9a22-f873-2b15-18b12896ea65@redhat.com>
Date:   Mon, 21 Feb 2022 12:36:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <84e354ec-cfbf-a23f-ddd5-417d6f029873@amd.com>
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


On 2/21/22 11:57 AM, Luben Tuikov wrote:
> Hi Tom,
>
> This was already fixed with this patch, and LKML was CC-ed. See the CC tags in the patch below,
>
> commit 4f7d7cda90cbd7
> Author: Luben Tuikov <luben.tuikov@amd.com>
> Date:   Wed Feb 16 16:47:32 2022 -0500
>
>      drm/amdgpu: Fix ARM compilation warning
>      
>      Fix this ARM warning:

I glad it wasn't just mips ;)

There have been a couple of build breaks with amdgpu recently.

Nick asked about adding clang to your ci.

Could at least one non x86_64 gcc also be added, maybe aarch64 ?

Tom

>      
>      drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld'
>      expects argument of type 'long int', but argument 4 has type 'size_t' {aka
>      'unsigned int'} [-Wformat=]
>      
>      Cc: Alex Deucher <Alexander.Deucher@amd.com>
>      Cc: kbuild-all@lists.01.org
>      Cc: linux-kernel@vger.kernel.org
>      Reported-by: kernel test robot <lkp@intel.com>
>      Fixes: 7e60fbfbdc10a0 ("drm/amdgpu: Show IP discovery in sysfs")
>      Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>      Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 2506bcf36c870c..6c7ec058125e1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>                              le16_to_cpu(ip->hw_id) != ii)
>                                  goto next_ip;
>   
> -                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
> +                       DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
>   
>                          /* We have a hw_id match; register the hw
>                           * block if not yet registered.
>
> Regards,
> Luben
>
> On 2022-02-21 12:37, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> On mips64 allyesconfig, there is this build break
>> amdgpu_discovery.c:671:35: error: format '%ld' expects
>>    argument of type 'long int', but argument 4 has
>>    type 'size_t' {aka 'unsigned int'}
>>    DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>>
>> For size_t, use %zu.
>>
>> Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 7c7e28fd912e..58238f67b1d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>   			    le16_to_cpu(ip->hw_id) != ii)
>>   				goto next_ip;
>>   
>> -			DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
>> +			DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
>>   
>>   			/* We have a hw_id match; register the hw
>>   			 * block if not yet registered.
> Regards,


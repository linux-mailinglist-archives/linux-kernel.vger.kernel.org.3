Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6D4DB13A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbiCPNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356435AbiCPNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:21:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483266AD1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:19:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id A53301F44846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647436774;
        bh=KlpubNGA6jnqdOcoZkfYGoeHVn6Iss9ryIjC0eGTdmA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RWvZRt4Ig4J2VCzgPFSTDLCZAtrjGk1beFTZ339Yz5BXql21elMmTptUePF4HxO66
         y96Hxrz3VPZnRChbrS2ybn0Ftd0J/HYye8L8KiMOVxp2J/prOA18acNY7ouKB+Yt6K
         d20u/Vm1fkSyO6oDO6qByKsWACR845Vd5RfJgqlntAz+EOj1F/yaiCI5id6FeDCciP
         4cn+sm7NBu13LJICIpxDJYpOUrrt7WQ1Ja4nHuTd/wqufbFUhtbWqlWnxvbFCvvqwZ
         CFCgmr26YsfMaf8l/9pcYrfKkwvEExr0oXHK52c7NOuFmtgFje4nkd+G+2uWf8kmuA
         QCnjT6BY1H+sg==
Message-ID: <1eef3b71-ef7c-24d1-b0d7-695fc1d2d353@collabora.com>
Date:   Wed, 16 Mar 2022 13:19:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 5/7] drm/ttm: add range busy check for range manager
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220315180444.3327283-1-bob.beckett@collabora.com>
 <20220315180444.3327283-6-bob.beckett@collabora.com>
 <2918e4a2-3bb8-23e0-3b8c-90c620b82328@amd.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <2918e4a2-3bb8-23e0-3b8c-90c620b82328@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2022 09:54, Christian König wrote:
> Am 15.03.22 um 19:04 schrieb Robert Beckett:
>> RFC: do we want this to become a generic interface in
>> ttm_resource_manager_func?
>>
>> RFC: would we prefer a different interface? e.g.
>> for_each_resource_in_range or for_each_bo_in_range
> 
> Well completely NAK to that. Why do you need that?
> 
> The long term goal is to completely remove the range checks from TTM 
> instead.

ah, I did not know that.
I wanted it just to enable parity with a selftest that checks whether a 
range is allocated before initializing a given range with test data 
behind the allocator's back. It needs to check the range so that it 
doesn't destroy in use data.

I suppose we could add another drm_mm range tracker just for testing and 
shadow track each allocation in the range, but that seemed like a lot of 
extra infrastructure for no general runtime use.

would you mind explaining the rationale for removing range checks? It 
seems to me like a natural fit for a memory manager

> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_range_manager.c | 21 +++++++++++++++++++++
>>   include/drm/ttm/ttm_range_manager.h     |  3 +++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c 
>> b/drivers/gpu/drm/ttm/ttm_range_manager.c
>> index 8cd4f3fb9f79..5662627bb933 100644
>> --- a/drivers/gpu/drm/ttm/ttm_range_manager.c
>> +++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
>> @@ -206,3 +206,24 @@ int ttm_range_man_fini_nocheck(struct ttm_device 
>> *bdev,
>>       return 0;
>>   }
>>   EXPORT_SYMBOL(ttm_range_man_fini_nocheck);
>> +
>> +/**
>> + * ttm_range_man_range_busy - Check whether anything is allocated 
>> with a range
>> + *
>> + * @man: memory manager to check
>> + * @fpfn: first page number to check
>> + * @lpfn: last page number to check
>> + *
>> + * Return: true if anything allocated within the range, false otherwise.
>> + */
>> +bool ttm_range_man_range_busy(struct ttm_resource_manager *man,
>> +                  unsigned fpfn, unsigned lpfn)
>> +{
>> +    struct ttm_range_manager *rman = to_range_manager(man);
>> +    struct drm_mm *mm = &rman->mm;
>> +
>> +    if (__drm_mm_interval_first(mm, PFN_PHYS(fpfn), PFN_PHYS(lpfn + 
>> 1) - 1))
>> +        return true;
>> +    return false;
>> +}
>> +EXPORT_SYMBOL(ttm_range_man_range_busy);
>> diff --git a/include/drm/ttm/ttm_range_manager.h 
>> b/include/drm/ttm/ttm_range_manager.h
>> index 7963b957e9ef..86794a3f9101 100644
>> --- a/include/drm/ttm/ttm_range_manager.h
>> +++ b/include/drm/ttm/ttm_range_manager.h
>> @@ -53,4 +53,7 @@ static __always_inline int ttm_range_man_fini(struct 
>> ttm_device *bdev,
>>       BUILD_BUG_ON(__builtin_constant_p(type) && type >= 
>> TTM_NUM_MEM_TYPES);
>>       return ttm_range_man_fini_nocheck(bdev, type);
>>   }
>> +
>> +bool ttm_range_man_range_busy(struct ttm_resource_manager *man,
>> +                  unsigned fpfn, unsigned lpfn);
>>   #endif
> 

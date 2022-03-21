Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C94E2CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350485AbiCUPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350488AbiCUPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:45:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14C13FB2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:44:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id CF1551F42764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647877456;
        bh=Z5EhRCR8SM/OwLmxsF67iIbxxSpDBZ8yq/gYZ2Z4Kss=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kqpWzbAFNsd9ff+MRTD59ZUP6F2XXuxIZK8Y7dS4h07GqIxpZfWrbv3QCUOKmB6EC
         cdscyqdG0uHJigAgGAAtnDQdpfqsOe2FvoX51SpHbpnD+9/ZmsV0yzO5QQoU3qgac3
         J/U/Ip1ZlNX/q0DFrDwUIF4wQ543z7scn7YQj910n2DOF/mR1v2dzsqBJnAK+XEXUm
         FLuZxZYy98DA5mHdIvvBYDB73HPKr9/j84UwgXzdLvT0vnvS0/e0+rIlg6b6Sbnpyh
         lujNmAwU66FdB7y1ltGk8/grY+g/01BxZz71KJT/ARixDvp1ZP55n7hGEASZov3KNS
         9R/ulETJM79FQ==
Message-ID: <a29021bd-1447-038a-e141-d06b53173d36@collabora.com>
Date:   Mon, 21 Mar 2022 15:44:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/ttm: fix potential null ptr deref in when mem space
 alloc fails
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220318195004.416539-1-bob.beckett@collabora.com>
 <8688c626-5858-18ba-593b-cdf179ca5201@amd.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <8688c626-5858-18ba-593b-cdf179ca5201@amd.com>
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



On 21/03/2022 09:51, Christian König wrote:
> Am 18.03.22 um 20:50 schrieb Robert Beckett:
>> when allocating a resource in place it is common to free the buffer's
>> resource, then allocate a new resource in a different placement.
>>
>> e.g. amdgpu_bo_create_kernel_at calls ttm_resource_free, then calls
>> ttm_bo_mem_space.
> 
> Well yes I'm working the drivers towards this, but NAK at the moment. 
> Currently bo->resource is never expected to be NULL.
> 
> And yes I'm searching for this bug in amdgpu for quite a while. Where 
> exactly does that happen?

in my case, I am writing new code for i915 that does this. I will switch 
it to allocate the new resource first, then free the old one if successful.

For the existing amd case, see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c?h=v5.17#n384


amdgpu_bo_create_kernel_at calls ttm_resource_free, then calls 
ttm_bo_mem_space. If the ttm_bo_mem_space call fails (e.g. due to memory 
pressure), then the error path will try to deref bo->resource, which 
will be null at that point.


to fix this, I honestly don't see a reason to not also have the safety 
check for null there. It could check early and return an error if it is 
null. I think that defensive programming here makes sense, better than a 
null deref if someone programs it wrong.



> 
> Amdgpu is supposed to allocate a new resource first, then do a swap and 
> the free the old one.
> 
> Thanks,
> Christian.
> 
>>
>> In this situation, bo->resource will be null as it is cleared during
>> the initial freeing of the previous resource.
>> This leads to a null deref.
>>
>> Fixes: d3116756a710 (drm/ttm: rename bo->mem and make it a pointer)
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index db3dc7ef5382..62b29ee7d040 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -875,7 +875,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
>>       }
>>   error:
>> -    if (bo->resource->mem_type == TTM_PL_SYSTEM && !bo->pin_count)
>> +    if (bo->resource && bo->resource->mem_type == TTM_PL_SYSTEM && 
>> !bo->pin_count)
>>           ttm_bo_move_to_lru_tail_unlocked(bo);
>>       return ret;
> 

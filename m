Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26F4BB6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiBRKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:25:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBRKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:24:59 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052AF2B1AA4;
        Fri, 18 Feb 2022 02:24:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vz16so14040155ejb.0;
        Fri, 18 Feb 2022 02:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uhDLgzXXHRnN4GC26esSMVFkTXLX2SeGv1b6vABa0YE=;
        b=ldN4nYeuTFyQKl87jS97MC8XjudyI6kITPvRqrl6d+yl2KTm1tD+boxrlg93b8TgxD
         z19LW8ITaX4xanNTTI3AKJ6zVndsm2drHz8WbJ39ZWXSbakcI+BVqdxr39LhSQafLWzt
         UU2ryIVzOgqna+/SZ341V4efGFHUHZbejKJ7tMFffCaNkSE+nqAYhCuDp0laNizGvnUN
         BqicdFVnnywHLgRJQH03KE/jHonEyREg8rLeLD9SfehCoune5DCJcUz0gZwArMrldIPt
         mXntQOyV+3DiEke5yRy0Of2JP6LTpdvh0zmng7yXlgmqc8VPttf5mKxgiME7fU4BrBVH
         j9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uhDLgzXXHRnN4GC26esSMVFkTXLX2SeGv1b6vABa0YE=;
        b=a2qwUQ5A52qmZNm6eaAv/z4t9en+7zJRm+KttEoJVRpowH2brC/calSQWL+z8dlHV+
         9rZnElKZp2zLvcBrGiGKnEeR2Wadf9KQMWhx0VU4EnE3pxKoFY7LKjqpVH6bUyKwcQpb
         X1ceHfELsqISIOcTWcOQCsMNs5ZtfQq3a7JeIuNBbVujvqE5W8b58Stov9AtoRCFAqML
         GsXyZOE4HefOCnMIDRfGt9eZYy/PYUSBQuW70V8sDOnbeWeKU/9IVVWgh+bzQVIxtypN
         yv0Ck1ZgCW2Whuy318kKKhSkP74rq0xQDEl4qpbjyY9FxtMKy4w+r8hbh35rUPm79STd
         A4eg==
X-Gm-Message-State: AOAM5326b5Igp58/HhZS6I2vcsQpHYf/9ADZpMhmVc+JQm+upxfQfZOJ
        KE44HUBGIchs7A8op5WErUw=
X-Google-Smtp-Source: ABdhPJzsb3g2tHwvNZSdHlpfMu3w4VmnuROCCvCsgS1xN/yd+M7MTZTbID+81YehUvRHQYqPYW1s5g==
X-Received: by 2002:a17:907:78d1:b0:6ce:70b4:f6f9 with SMTP id kv17-20020a17090778d100b006ce70b4f6f9mr6080601ejc.196.1645179880406;
        Fri, 18 Feb 2022 02:24:40 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
        by smtp.gmail.com with ESMTPSA id g3sm2102719ejz.180.2022.02.18.02.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 02:24:39 -0800 (PST)
Message-ID: <47c3a681-379e-18d4-86da-c48721081911@gmail.com>
Date:   Fri, 18 Feb 2022 11:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: check vm bo eviction valuable at last
Content-Language: en-US
To:     Qiang Yu <yuq825@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, Qiang Yu <qiang.yu@amd.com>,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
References: <20220217090440.4468-1-qiang.yu@amd.com>
 <5d3fdd2c-e74a-49f4-2b28-32c06483236f@amd.com>
 <CAKGbVbtLTBJPF5eTu4rABUTBa8eqjQvqjo1AEUrzgPgYgCREuA@mail.gmail.com>
 <dac70c05-e712-d2e3-2267-278380895f1e@amd.com>
 <CAKGbVbvtLbDiKrX80-dMnipdLkTE+FP=g_mx37e12fuMtA1Y4Q@mail.gmail.com>
 <ca27a9c6-f390-a938-dd66-ac23f3b44dc4@amd.com>
 <CAKGbVbv4UFCybS_OFj5UkDgevbrB5qe3pv+0nHv9WdefYhy6Ww@mail.gmail.com>
 <6711073b-8771-5750-33f7-b72333b411c6@amd.com>
 <CAKGbVbvR+msXjrsXmDM8QTmsCP03hL5-q5CTJBYu4mm=NQd01A@mail.gmail.com>
 <a11b7073-6597-8e87-b724-33acab32e791@gmail.com>
 <CAKGbVbuJ-QdeoMTg=_O=1x5A5tbqZftsjt8aCCoVkAekci0USA@mail.gmail.com>
 <d830bb82-63ea-2de6-6d10-3a401ac0dcf0@amd.com>
 <CAKGbVbtorRius+Sq1_3SPUF3JzA00U747noSGhx7eP8Vn1rSDg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAKGbVbtorRius+Sq1_3SPUF3JzA00U747noSGhx7eP8Vn1rSDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.02.22 um 11:16 schrieb Qiang Yu:
> [SNIP]
>>> If amdgpu_vm_ready() use evicting flag, it's still not equivalent to check
>>> vm idle: true -> vm idle, false -> vm may be idle or busy.
>> Yeah, but why should that be relevant?
>>
>> The amdgpu_vm_ready() return if we can do page table updates or not. If
>> the VM is idle or not is only relevant for eviction.
>>
>> In other words any CS or page table update makes the VM busy, but that
>> only affects if the VM can be evicted or not.
>>
> My point is: we can't use amdgpu_vm_ready() to replace vm_is_busy(), so
> currently we update vm even when vm is busy. So why not use:
> if (!amdgpu_vm_ready() || vm_is_busy()) return;
> in amdgpu_gem_va_update_vm(), as you mentioned we prefer to not
> update vm when it's idle.

Because updating the VM while it is busy is perfectly fine, we do it all 
the time.

We should just not update it when it is already idle and was considered 
for eviction. In this situation it makes most of the time sense to keep 
it idle and postpone the update till the next command submission.

>>>>> Then we can keep the evicting flag accurate (after solving your
>>>>> concern for this patch that eviction may fail latter by further delay
>>>>> the flag update after eviction success).
>>>> That won't work. See we need to mark the VM as evicted before we
>>>> actually evict them because otherwise somebody could use the VM in
>>>> parallel and add another fence to it.
>>>>
>>> I see, make this too accurate should cost too much like holding the
>>> eviction_lock when eviction. But just delay it in
>>> amdgpu_ttm_bo_eviction_valuable()
>>> could avoid most false positive case.
>> Partially correct. Another fundamental problem is that we can't hold the
>> eviction lock because that would result in lock inversion and potential
>> deadlock.
>>
>> We could set the flag later on, but as I said before that when we set
>> the evicted flag when the VM is already idle is a desired effect.
>>
> As above, this confuse me as we can explicitly check vm idle when
> user update vm, why bother to embed it in evicting flag implicitly?

Well as I said it's irrelevant for the update if the VM is idle or not.

To summarize the rules once more:
1. When VM page tables are used by CS or page tables updates it is 
considered busy, e.g. not idle.

2. When we want to evict a VM it must be idle. As soon as we considered 
this we should set the evicted flag to make sure to keep it idle as much 
as possible.

3. When we want to update the page tables we just need to check if the 
VM is idle or not.

4. When a CS happens we don't have another chance and make the VM busy 
again. And do all postponed page table updates.

Regards,
Christian.

>
> Check vm idle need to hold resv lock. Read your patch for adding
> evicting flag is to update vm without resv lock. But user vm ops in
> amdgpu_gem_va_update_vm() do hold the resv lock, so the difference
> happens when calling amdgpu_vm_bo_update_mapping() from
> svm_range_(un)map_to_gpu(). So embed vm idle in evicting flag
> is for svm_range_(un)map_to_gpu() also do nothing when vm idle?



>
> Regards,
> Qiang
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Qiang
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Qiang
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Regards,
>>>>>>> Qiang
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Qiang
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Qiang
>>>>>>>>>>>
>>>>>>>>>>>> What we should rather do is to fix amdgpu_vm_ready() to take a look at
>>>>>>>>>>>> the flag instead of the linked list.
>>>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> Christian.
>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Qiang Yu <qiang.yu@amd.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 85 ++++++++++++++-----------
>>>>>>>>>>>>>         1 file changed, 47 insertions(+), 38 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> index 5a32ee66d8c8..88a27911054f 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>>> @@ -1306,45 +1306,11 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>>>>>>>>>>>>>             return flags;
>>>>>>>>>>>>>         }
>>>>>>>>>>>>>
>>>>>>>>>>>>> -/*
>>>>>>>>>>>>> - * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict a buffer
>>>>>>>>>>>>> - * object.
>>>>>>>>>>>>> - *
>>>>>>>>>>>>> - * Return true if eviction is sensible. Called by ttm_mem_evict_first() on
>>>>>>>>>>>>> - * behalf of ttm_bo_mem_force_space() which tries to evict buffer objects until
>>>>>>>>>>>>> - * it can find space for a new object and by ttm_bo_force_list_clean() which is
>>>>>>>>>>>>> - * used to clean out a memory space.
>>>>>>>>>>>>> - */
>>>>>>>>>>>>> -static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>>>>>>>>>>>>> -                                         const struct ttm_place *place)
>>>>>>>>>>>>> +static bool amdgpu_ttm_mem_eviction_valuable(struct ttm_buffer_object *bo,
>>>>>>>>>>>>> +                                          const struct ttm_place *place)
>>>>>>>>>>>>>         {
>>>>>>>>>>>>>             unsigned long num_pages = bo->resource->num_pages;
>>>>>>>>>>>>>             struct amdgpu_res_cursor cursor;
>>>>>>>>>>>>> -     struct dma_resv_list *flist;
>>>>>>>>>>>>> -     struct dma_fence *f;
>>>>>>>>>>>>> -     int i;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -     /* Swapout? */
>>>>>>>>>>>>> -     if (bo->resource->mem_type == TTM_PL_SYSTEM)
>>>>>>>>>>>>> -             return true;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -     if (bo->type == ttm_bo_type_kernel &&
>>>>>>>>>>>>> -         !amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo)))
>>>>>>>>>>>>> -             return false;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -     /* If bo is a KFD BO, check if the bo belongs to the current process.
>>>>>>>>>>>>> -      * If true, then return false as any KFD process needs all its BOs to
>>>>>>>>>>>>> -      * be resident to run successfully
>>>>>>>>>>>>> -      */
>>>>>>>>>>>>> -     flist = dma_resv_shared_list(bo->base.resv);
>>>>>>>>>>>>> -     if (flist) {
>>>>>>>>>>>>> -             for (i = 0; i < flist->shared_count; ++i) {
>>>>>>>>>>>>> -                     f = rcu_dereference_protected(flist->shared[i],
>>>>>>>>>>>>> -                             dma_resv_held(bo->base.resv));
>>>>>>>>>>>>> -                     if (amdkfd_fence_check_mm(f, current->mm))
>>>>>>>>>>>>> -                             return false;
>>>>>>>>>>>>> -             }
>>>>>>>>>>>>> -     }
>>>>>>>>>>>>>
>>>>>>>>>>>>>             switch (bo->resource->mem_type) {
>>>>>>>>>>>>>             case AMDGPU_PL_PREEMPT:
>>>>>>>>>>>>> @@ -1377,10 +1343,53 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>>>>>>>>>>>>>                     return false;
>>>>>>>>>>>>>
>>>>>>>>>>>>>             default:
>>>>>>>>>>>>> -             break;
>>>>>>>>>>>>> +             return ttm_bo_eviction_valuable(bo, place);
>>>>>>>>>>>>>             }
>>>>>>>>>>>>> +}
>>>>>>>>>>>>>
>>>>>>>>>>>>> -     return ttm_bo_eviction_valuable(bo, place);
>>>>>>>>>>>>> +/*
>>>>>>>>>>>>> + * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict a buffer
>>>>>>>>>>>>> + * object.
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Return true if eviction is sensible. Called by ttm_mem_evict_first() on
>>>>>>>>>>>>> + * behalf of ttm_bo_mem_force_space() which tries to evict buffer objects until
>>>>>>>>>>>>> + * it can find space for a new object and by ttm_bo_force_list_clean() which is
>>>>>>>>>>>>> + * used to clean out a memory space.
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>>>>>>>>>>>>> +                                         const struct ttm_place *place)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +     struct dma_resv_list *flist;
>>>>>>>>>>>>> +     struct dma_fence *f;
>>>>>>>>>>>>> +     int i;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +     /* Swapout? */
>>>>>>>>>>>>> +     if (bo->resource->mem_type == TTM_PL_SYSTEM)
>>>>>>>>>>>>> +             return true;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +     /* If bo is a KFD BO, check if the bo belongs to the current process.
>>>>>>>>>>>>> +      * If true, then return false as any KFD process needs all its BOs to
>>>>>>>>>>>>> +      * be resident to run successfully
>>>>>>>>>>>>> +      */
>>>>>>>>>>>>> +     flist = dma_resv_shared_list(bo->base.resv);
>>>>>>>>>>>>> +     if (flist) {
>>>>>>>>>>>>> +             for (i = 0; i < flist->shared_count; ++i) {
>>>>>>>>>>>>> +                     f = rcu_dereference_protected(flist->shared[i],
>>>>>>>>>>>>> +                             dma_resv_held(bo->base.resv));
>>>>>>>>>>>>> +                     if (amdkfd_fence_check_mm(f, current->mm))
>>>>>>>>>>>>> +                             return false;
>>>>>>>>>>>>> +             }
>>>>>>>>>>>>> +     }
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +     /* Check by different mem type. */
>>>>>>>>>>>>> +     if (!amdgpu_ttm_mem_eviction_valuable(bo, place))
>>>>>>>>>>>>> +             return false;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +     /* VM bo should be checked at last because it will mark VM evicting. */
>>>>>>>>>>>>> +     if (bo->type == ttm_bo_type_kernel)
>>>>>>>>>>>>> +             return amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo));
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +     return true;
>>>>>>>>>>>>>         }
>>>>>>>>>>>>>
>>>>>>>>>>>>>         static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,


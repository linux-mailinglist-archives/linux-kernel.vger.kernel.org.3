Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB9510ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357184AbiD0Ceb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiD0Cea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:34:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30704EDCE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:31:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j6so390849pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SUw0dCnPO7y6e5RUbB+GKQ8bQH8cCrbwkwfSFkbqu5I=;
        b=Hpc94eKFtmZClq+hZrqw07xHQpckayyJLKAM8ectf7kKKMZQpCTjK3Wph34N0co8Bz
         S8LZB1fVCqpkzBSTiOliEcYgSsmfaqlf9k3/ObLfsDkw8K5lqydJ78Zxc1ltrUsdFbPi
         3b2KqZgpD2UBAK3NNgdix1VkFYSEZLweDDrc3KsQGfmJ2hrQ6fZpG/IPqhxSitw8UlB1
         is/Q5z02vPD4Knum9Ouz4gt+jqSgX2jfpSlLtbVbY/HkCzUZ/fw9JqTdv1Gitc8IbZne
         yqBb3c1+bToWOxqVkouLQ56ThDKK/ZlQSSAuYWHULgdea1shFmE4m+2cRMCRNjy1x2tW
         0CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SUw0dCnPO7y6e5RUbB+GKQ8bQH8cCrbwkwfSFkbqu5I=;
        b=QUptQJyh5xdDU3D9e5CZrWkh+yvX50jwEpEdXppfHEvKIl0nBQtB5QlbIHw7dURwl5
         j791r7qdLs0EFrKLWRxeRHd8x1xwRVhgNVdobpyaCmpNl/BbpvTSIMv8/mba9Tbss15A
         5ktmhztQBu9CSk6BwFOVL6JeB+y+By0EUAe3G0P1KIKi7JAPa/VkhhfciIw7IBjKzHii
         DgtwqW2udr9CHUBr8gQO7hs4WFv5GXjeisDcTbtC0+ziBLLOLQwItD3W+KaBd+Bu2OkC
         tdFRiQYWYxUzjf7mEQsRn8AoCjkmbn3Hmd0hOXdQT8qA2Cs5l8FKDnz2I7/oQfiHIzkt
         /yAQ==
X-Gm-Message-State: AOAM530z3sWxqSQX/P9BDassOnuHAynPZxxl+3N8+WEtbBtm43KWI++M
        vUMrYiq+r3Bzvhb2dcMTjoziZggepB21XQ==
X-Google-Smtp-Source: ABdhPJxyKMjbsMnSMJM9V3ecZeu+u/jxOr1pWdhnBMaxbakRco0eTr0d3jqwmjLnob4SmvCQPmltdQ==
X-Received: by 2002:aa7:970f:0:b0:50d:301e:e6ce with SMTP id a15-20020aa7970f000000b0050d301ee6cemr17759185pfg.61.1651026680269;
        Tue, 26 Apr 2022 19:31:20 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a6d8800b001cd4c118b07sm389936pjk.16.2022.04.26.19.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 19:31:19 -0700 (PDT)
Message-ID: <88dd5d67-7dd5-2f58-5254-adaa941deb0f@gmail.com>
Date:   Wed, 27 Apr 2022 10:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] gpu: drm: remove redundant dma_fence_put() when
 drm_sched_job_add_dependency() fails
Content-Language: en-US
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>, yuq825@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220425083645.25922-1-hbh25y@gmail.com>
 <b7d8956e-5ac6-8200-d8b1-4ce828f04665@amd.com>
 <79b198d0-eff2-d658-4b5e-9084a834fc93@gmail.com>
 <e26e6ef8-6665-0b9d-804f-cf107f1788d4@amd.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <e26e6ef8-6665-0b9d-804f-cf107f1788d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/26 22:55, Andrey Grodzovsky wrote:
> 
> On 2022-04-25 22:54, Hangyu Hua wrote:
>> On 2022/4/25 23:42, Andrey Grodzovsky wrote:
>>> On 2022-04-25 04:36, Hangyu Hua wrote:
>>>
>>>> When drm_sched_job_add_dependency() fails, dma_fence_put() will be 
>>>> called
>>>> internally. Calling it again after drm_sched_job_add_dependency() 
>>>> finishes
>>>> may result in a dangling pointer.
>>>>
>>>> Fix this by removing redundant dma_fence_put().
>>>>
>>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/lima/lima_gem.c        | 1 -
>>>>   drivers/gpu/drm/scheduler/sched_main.c | 1 -
>>>>   2 files changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/lima/lima_gem.c 
>>>> b/drivers/gpu/drm/lima/lima_gem.c
>>>> index 55bb1ec3c4f7..99c8e7f6bb1c 100644
>>>> --- a/drivers/gpu/drm/lima/lima_gem.c
>>>> +++ b/drivers/gpu/drm/lima/lima_gem.c
>>>> @@ -291,7 +291,6 @@ static int lima_gem_add_deps(struct drm_file 
>>>> *file, struct lima_submit *submit)
>>>>           err = drm_sched_job_add_dependency(&submit->task->base, 
>>>> fence);
>>>>           if (err) {
>>>> -            dma_fence_put(fence);
>>>>               return err;
>>>
>>>
>>> Makes sense here
>>>
>>>
>>>>           }
>>>>       }
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>> index b81fceb0b8a2..ebab9eca37a8 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -708,7 +708,6 @@ int 
>>>> drm_sched_job_add_implicit_dependencies(struct drm_sched_job *job,
>>>>           dma_fence_get(fence);
>>>>           ret = drm_sched_job_add_dependency(job, fence);
>>>>           if (ret) {
>>>> -            dma_fence_put(fence);
>>>
>>>
>>>
>>> Not sure about this one since if you look at the relevant commits -
>>> 'drm/scheduler: fix drm_sched_job_add_implicit_dependencies' and
>>> 'drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder'
>>> You will see that the dma_fence_put here balances the extra 
>>> dma_fence_get
>>> above
>>>
>>> Andrey
>>>
>>
>> I don't think so. I checked the call chain and found no additional 
>> dma_fence_get(). But dma_fence_get() needs to be called before 
>> drm_sched_job_add_dependency() to keep the counter balanced. 
> 
> 
> I don't say there is an additional get, I just say that 
> drm_sched_job_add_dependency doesn't grab an extra reference to the 
> fences it stores so this needs to be done outside and for that
> drm_sched_job_add_implicit_dependencies->dma_fence_get is called and, if 
> this addition fails you just call dma_fence_put to keep the counter 
> balanced.
> 

drm_sched_job_add_implicit_dependencies() will call 
drm_sched_job_add_dependency(). And drm_sched_job_add_dependency() 
already call dma_fence_put() when it fails. Calling dma_fence_put() 
twice doesn't make sense.

dma_fence_get() is in [2]. But dma_fence_put() will be called in [1] and 
[3] when xa_alloc() fails.


int drm_sched_job_add_dependency(struct drm_sched_job *job,
				 struct dma_fence *fence)
{
	...
	ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b, GFP_KERNEL);
	if (ret != 0)
		dma_fence_put(fence);	<--- [1]

	return ret;
}
EXPORT_SYMBOL(drm_sched_job_add_dependency);


int drm_sched_job_add_implicit_dependencies(struct drm_sched_job *job,
					    struct drm_gem_object *obj,
					    bool write)
{
	struct dma_resv_iter cursor;
	struct dma_fence *fence;
	int ret;

	dma_resv_for_each_fence(&cursor, obj->resv, write, fence) {
		/* Make sure to grab an additional ref on the added fence */
		dma_fence_get(fence);	<--- [2]
		ret = drm_sched_job_add_dependency(job, fence);
		if (ret) {
			dma_fence_put(fence);	<--- [3]
			return ret;
		}
	}
	return 0;
}


> 
>> On the other hand, dma_fence_get() and dma_fence_put() are meaningless 
>> here if threre is an extra dma_fence_get() beacause counter will not 
>> decrease to 0 during drm_sched_job_add_dependency().
>>
>> I check the call chain as follows:
>>
>> msm_ioctl_gem_submit()
>> -> submit_fence_sync()
>> -> drm_sched_job_add_implicit_dependencies()
> 
> 
> Can you maybe trace or print one such example of problematic refcount 
> that you are trying to fix ? I still don't see where is the problem.
> 
> Andrey
> 

I also wish I could. System logs can make this easy. But i don't have a 
corresponding GPU physical device. 
drm_sched_job_add_implicit_dependencies is only used in a few devices.

Thanks.
> 
>>
>> Thanks,
>> Hangyu
>>
>>>
>>>>               return ret;
>>>>           }
>>>>       }

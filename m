Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A851CE27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388138AbiEFBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349717AbiEFBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:53:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1062A1A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:50:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n8so6051409plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=qiHKrawCSEYS4sdc87s3HzBAfn4f+VmuSVImw7uTP4A=;
        b=F98Lin7aPfGaSoPtPZEE8s+NM6NRh+0LKMImQjIgs0Zkhyv4XBwnzeLr8M9xrKogiu
         MwPofz7GmCqWLwIYjwHHM2U9nChNxdi8IKbXrgyry5F8/nwQUIoIBTiLwepu5hFc9h9S
         Buk/6mnCToI+v5w5kHbUsgiq2ieqxGS0uF2/RfcC0fN0dRrJN39t9jiWC/r1OBOKg8X6
         TCEfurvSr2eUBAf49iIySJ3ketcUOPXYYAa+F/0aKBAugNQt+5rCgD/LnXRlsS01F3Wf
         76QjYjIAzAZ5Ha2+ba3B+G6D3MdQ0RXu7hi6jiAKGLfCOZJGhWUe50K3DqxQP9z33Je+
         LLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qiHKrawCSEYS4sdc87s3HzBAfn4f+VmuSVImw7uTP4A=;
        b=7olDX/JUeXOaan7JwZn1x0o7TgBkenQT25xNtCaGHJK+ZovXf8o2DPYNY2nVF/ya0o
         SaMJNAeQB2Y/D1GoY7wF4nJoDFulclsd4Cw2gqguaQNdDaEk7EFAP9bXUVwjuuiheFNp
         NrHZOAHHxmTZksTk2TF2/s3MXM6ZZKAPe6Uz1Pa3J/EKXvReuNjSZrJuM5VFfoO/xtL8
         9/sESiJb6SDYvdzdeaIvxGXRiQzHOjYuULpXqL6QEKDvZL9/4pFE1Q1tLr0EYmwVhC1P
         Q5A38/6LxIr/Z/KMF6n93ujZb92PnDOU3dZnB3B4g7iPRS6i12qRFxC/8OSEQsw0KEwz
         /pUw==
X-Gm-Message-State: AOAM531HDX/sPP8T0voHO99vp71NAw33syfVBAn2OYM9NcL6i/wFeUpt
        7YLkIHGBDQWJam5XoH5mvhzBMg==
X-Google-Smtp-Source: ABdhPJyputnUi3a7shAhiw4xAnFex5EGDJvGRHdrQg+0QCuQstO9afbIuS5G8cxY4+jApO0x5q6rZw==
X-Received: by 2002:a17:90b:1651:b0:1dc:aec3:c17 with SMTP id il17-20020a17090b165100b001dcaec30c17mr1405190pjb.43.1651801799549;
        Thu, 05 May 2022 18:49:59 -0700 (PDT)
Received: from [10.44.0.6] ([94.177.118.48])
        by smtp.gmail.com with ESMTPSA id e5-20020a636905000000b003aaf27b5ceasm2042378pgc.1.2022.05.05.18.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 18:49:58 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
References: <20220428180041.806809-1-fenghua.yu@intel.com>
 <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <da5eafcc-1cb0-07fc-aa0d-0dccb8b8875a@linaro.org>
Date:   Fri, 6 May 2022 09:49:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/29 上午9:39, Zhangfei Gao wrote:
>
>
> On 2022/4/29 上午2:00, Fenghua Yu wrote:
>> The PASID is being freed too early.  It needs to stay around until after
>> device drivers that might be using it have had a chance to clear it out
>> of the hardware.
>>
>> As a reminder:
>>
>> mmget() /mmput()  refcount the mm's address space
>> mmgrab()/mmdrop() refcount the mm itself
>>
>> The PASID is currently tied to the life of the mm's address space and
>> freed in __mmput().  This makes logical sense because the PASID can't be
>> used once the address space is gone.
>>
>> But, this misses an important point: even after the address space is
>> gone, the PASID will still be programmed into a device.  Device drivers
>> might, for instance, still need to flush operations that are outstanding
>> and need to use that PASID.  They do this at file->release() time.
>>
>> Device drivers call the IOMMU driver to hold a reference on the mm 
>> itself
>> and drop it at file->release() time.  But, the IOMMU driver holds a
>> reference on the mm itself, not the address space.  The address space
>> (and the PASID) is long gone by the time the driver tries to clean up.
>> This is effectively a use-after-free bug on the PASID.
>>
>> To fix this, move the PASID free operation from __mmput() to __mmdrop().
>> This ensures that the IOMMU driver's existing mmgrab() keeps the PASID
>> allocated until it drops its mm reference.
>>
>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID 
>> allocation and free it on mm exit")
>>
>> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>> Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Use the formal email, thanks
>
>> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Hi,

Will this be taken for 5.18?

Thanks

>> ---
>>
>> v2:
>> - Dave Hansen rewrites the change log.
>> - Add Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>> - Add Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> The original patch was posted and discussed in:
>> https://lore.kernel.org/lkml/YmdzFFx7fN586jcf@fyu1.sc.intel.com/
>>
>>   kernel/fork.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 9796897560ab..35a3beff140b 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
>>       mmu_notifier_subscriptions_destroy(mm);
>>       check_mm(mm);
>>       put_user_ns(mm->user_ns);
>> +    mm_pasid_drop(mm);
>>       free_mm(mm);
>>   }
>>   EXPORT_SYMBOL_GPL(__mmdrop);
>> @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
>>       }
>>       if (mm->binfmt)
>>           module_put(mm->binfmt->module);
>> -    mm_pasid_drop(mm);
>>       mmdrop(mm);
>>   }
>


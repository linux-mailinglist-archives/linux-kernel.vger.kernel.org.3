Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895850B388
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445715AbiDVJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359739AbiDVJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:06:18 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBA5370E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650618195;
        bh=BFm1j0RWEHPGEYHY0/aDOqsGPLFB5T6ryBg+PtOD4kA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=uz02BWJn9Yd3mMUysVo2kF/ccpyu1mC0plvDAXTnPjep1Ne09+JdnyddbKbryJGqr
         72eBJ4yueetxJQZ/6LtteyK70BWaw/PA7PohrRToDDU9NRvzntPwK5JarD/RmUIgS1
         QRTglH7e1/orG9hJA2RVuJQOHUBoB8ja8PJQA41E=
Received: from [IPv6:240e:362:431:df00:2955:4366:920b:947f] ([240e:362:431:df00:2955:4366:920b:947f])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id CA81AB1; Fri, 22 Apr 2022 17:03:10 +0800
X-QQ-mid: xmsmtpt1650618190tj01ar5a7
Message-ID: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneVR2CuroaBEi6Zw4HkjCXH1qEPZ8NAiTOTzTOAqtxXUsQx9xwKZ
         80nQ+ZeiarzjUhcsdaXaBVxgyzGjw3+jVBU26u01jWOoEnjh0FNIK9sECNZIhWWyOfVcb/uSAguJ
         L6CQc+bBXx9DkXqyliGWrsMGZYH/atThF91q2ab5/iQuJcXtQdF1iy6uCbWyWFVKuYUoi/4Ok9NQ
         GsGlmLa6LzIsqCp8EWc8/cGc+CIaR5o+NtFCdwHqSVHHBduWO97EnztdbdwIDrp3J6uoERcKscxK
         bEwU0q9u0/55LjThby0CCyqVYdoQy1Oc4IdUWqhbDpwXV2Qjp19y6BlO5IlyKWVIEULu4di7vcsM
         ZbmgGPZaJ8f5yeDCLJnpvYlV40WCxbCtyJxIsGZa9uqzHodKPUPO0ZiImtu4uQw1gKsIw4n/rUE7
         g2eYUTo1joc4CNcrQOt0tM5w2i27DRtopLeUKTLw2WSnY2Es41KjAvkoKnNrV6MupemYEX6Z+csM
         h/DntY6v3YI0qO4NwRHiFFSnQEvTJ6fzA4q/LSVYypvPVQN6NfD8kk+ERZaMM/eTAbZ6BQR2K3mp
         rpiGHpezeG9BLvlttNj7VHWn2bDOTTQR43UeSSYmUFLc8aJm5TDDEjRLhivQAfh6oF1PuVHHj98E
         0tPH79eLUv3YXgyknUAilguIE+gXV2/LZNxA8ff0ew5RTCvab8T2D1rEnldSRFwCxY/S0Dc4PFAx
         bfuY73DNODAkPCGsFWquBGo6eQQy2grDDRMu9jC6e4Hd+AyKl4Iujgwyt3PG6swQ16ifu1WfBeNh
         DD8Tqmz+xOBb0wNyLlyN/rnNNILqiyOvADvxXses6w+h/awiGsWWewu18wTL0DIA/jRWp0muPI7i
         Nep6/Wg0QGxgwYZM2PSw4aWlHSsRXq9Mlb2iZnIPlDmqi92C+2NQNrs1hRP58eTiOyU61Q8998in
         1WEc0rx5VzCr0uSjE9Jw==
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com
References: <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
X-OQ-MSGID: <1830335b-90a9-2659-502a-bfc9ca96a691@foxmail.com>
Date:   Fri, 22 Apr 2022 17:03:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean

On 2022/4/21 下午2:47, zhangfei.gao@foxmail.com wrote:
>
>
> On 2022/4/21 上午12:45, Jean-Philippe Brucker wrote:
>> Hi,
>>
>> On Fri, Apr 15, 2022 at 02:51:08AM -0700, Fenghua Yu wrote:
>>>  From a6444e1e5bd8076f5e5c5e950d3192de327f0c9c Mon Sep 17 00:00:00 2001
>>> From: Fenghua Yu <fenghua.yu@intel.com>
>>> Date: Fri, 15 Apr 2022 00:51:33 -0700
>>> Subject: [RFC PATCH] iommu/sva: Fix PASID use-after-free issue
>>>
>>> A PASID might be still used even though it is freed on mm exit.
>>>
>>> process A:
>>>     sva_bind();
>>>     ioasid_alloc() = N; // Get PASID N for the mm
>>>     fork(): // spawn process B
>>>     exit();
>>>     ioasid_free(N);
>>>
>>> process B:
>>>     device uses PASID N -> failure
>>>     sva_unbind();
>>>
>>> Dave Hansen suggests to take a refcount on the mm whenever binding the
>>> PASID to a device and drop the refcount on unbinding. The mm won't be
>>> dropped if the PASID is still bound to it.
>>>
>>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID 
>>> allocation and free it on mm exit")
>>>
>>> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>>> Suggested-by: Dave Hansen" <dave.hansen@linux.intel.com>
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>>>   drivers/iommu/intel/svm.c                       | 4 ++++
>>>   2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c 
>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> index 22ddd05bbdcd..3fcb842a0df0 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> @@ -7,6 +7,7 @@
>>>   #include <linux/mmu_context.h>
>>>   #include <linux/mmu_notifier.h>
>>>   #include <linux/slab.h>
>>> +#include <linux/sched/mm.h>
>>>     #include "arm-smmu-v3.h"
>>>   #include "../../iommu-sva-lib.h"
>>> @@ -363,6 +364,9 @@ arm_smmu_sva_bind(struct device *dev, struct 
>>> mm_struct *mm, void *drvdata)
>>>         mutex_lock(&sva_lock);
>>>       handle = __arm_smmu_sva_bind(dev, mm);
>>> +    /* Take an mm refcount on a successful bind. */
>>> +    if (!IS_ERR(handle))
>>> +        mmget(mm);
>>>       mutex_unlock(&sva_lock);
>>>       return handle;
>>>   }
>>> @@ -372,6 +376,8 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>>>       struct arm_smmu_bond *bond = sva_to_bond(handle);
>>>         mutex_lock(&sva_lock);
>>> +    /* Drop an mm refcount. */
>>> +    mmput(bond->mm);
>> I do like the idea because it will simplify the driver. We can't call
>> mmput() here, though, because it may call the release() MMU notifier 
>> which
>> will try to grab sva_lock, already held.
>>
>> I also found another use-after-free in arm_smmu_free_shared_cd(), 
>> where we
>> call arm64_mm_context_put() when the mm could already be freed. There 
>> used
>> to be an mmgrab() preventing this but it went away during a rewrite.
>>
>> To fix both we could just move mmput() at the end of unbind() but I'd
>> rather do a proper cleanup removing the release() notifier right away.
>> Zhangfei, could you try the patch below?
>>
>> Thanks,
>> Jean
>>
>> --- 8< ---
>>
>>  From 4e09c0d71dfb35fc90915bd1e36545027fbf8a03 Mon Sep 17 00:00:00 2001
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Date: Wed, 20 Apr 2022 10:19:24 +0100
>> Subject: [PATCH] iommu/arm-smmu-v3-sva: Fix PASID and mm 
>> use-after-free issues
>>
>> Commit 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
>> allocation and free it on mm exit") frees the PASID earlier than what
>> the SMMUv3 driver expects. At the moment the SMMU driver handles mm exit
>> in the release() MMU notifier by quiescing the context descriptor. The
>> context descriptor is only made invalid in unbind(), after the device
>> driver ensured the PASID is not used anymore. Releasing the PASID on mm
>> exit may cause it to be reallocated while it is still used by the
>> context descriptor.
>>
>> There is another use-after-free, present since the beginning, where we
>> call arm64_mm_context_put() without a guarantee that mm_count is held.
>>
>> Dave Hansen suggests to grab mm_users whenever binding the mm to a
>> device and drop it on unbinding. With that we can fix both issues and
>> simplify the driver by removing the release() notifier.
>>
>> Fixes: 32784a9562fb ("iommu/arm-smmu-v3: Implement 
>> iommu_sva_bind/unbind()")
>> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 -
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 49 +++++--------------
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +-----
>>   3 files changed, 15 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index cd48590ada30..d50d215d946c 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -735,7 +735,6 @@ static inline struct arm_smmu_domain 
>> *to_smmu_domain(struct iommu_domain *dom)
>>     extern struct xarray arm_smmu_asid_xa;
>>   extern struct mutex arm_smmu_asid_lock;
>> -extern struct arm_smmu_ctx_desc quiet_cd;
>>     int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, 
>> int ssid,
>>                   struct arm_smmu_ctx_desc *cd);
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index 22ddd05bbdcd..f9dff0f6cdd4 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/mmu_context.h>
>>   #include <linux/mmu_notifier.h>
>> +#include <linux/sched/mm.h>
>>   #include <linux/slab.h>
>>     #include "arm-smmu-v3.h"
>> @@ -15,7 +16,6 @@
>>   struct arm_smmu_mmu_notifier {
>>       struct mmu_notifier        mn;
>>       struct arm_smmu_ctx_desc    *cd;
>> -    bool                cleared;
>>       refcount_t            refs;
>>       struct list_head        list;
>>       struct arm_smmu_domain        *domain;
>> @@ -96,9 +96,14 @@ static struct arm_smmu_ctx_desc 
>> *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
>>       struct arm_smmu_ctx_desc *cd;
>>       struct arm_smmu_ctx_desc *ret = NULL;
>>   +    /* Prevent mm exit as long as it is used by the context 
>> descriptor */
>> +    mmget(mm);
>> +
>>       asid = arm64_mm_context_get(mm);
>> -    if (!asid)
>> -        return ERR_PTR(-ESRCH);
>> +    if (!asid) {
>> +        err = -ESRCH;
>> +        goto out_put_mm;
>> +    }
>>         cd = kzalloc(sizeof(*cd), GFP_KERNEL);
>>       if (!cd) {
>> @@ -165,6 +170,8 @@ static struct arm_smmu_ctx_desc 
>> *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
>>       kfree(cd);
>>   out_put_context:
>>       arm64_mm_context_put(mm);
>> +out_put_mm:
>> +    mmput(mm);
>>       return err < 0 ? ERR_PTR(err) : ret;
>>   }
>>   @@ -173,6 +180,7 @@ static void arm_smmu_free_shared_cd(struct 
>> arm_smmu_ctx_desc *cd)
>>       if (arm_smmu_free_asid(cd)) {
>>           /* Unpin ASID */
>>           arm64_mm_context_put(cd->mm);
>> +        mmput(cd->mm);
>>           kfree(cd);
>>       }
>>   }
>> @@ -191,30 +199,6 @@ static void arm_smmu_mm_invalidate_range(struct 
>> mmu_notifier *mn,
>>       arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>>   }
>>   -static void arm_smmu_mm_release(struct mmu_notifier *mn, struct 
>> mm_struct *mm)
>> -{
>> -    struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>> -    struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
>> -
>> -    mutex_lock(&sva_lock);
>> -    if (smmu_mn->cleared) {
>> -        mutex_unlock(&sva_lock);
>> -        return;
>> -    }
>> -
>> -    /*
>> -     * DMA may still be running. Keep the cd valid to avoid C_BAD_CD 
>> events,
>> -     * but disable translation.
>> -     */
>> -    arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
>> -
>> -    arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
>> -    arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>> -
>> -    smmu_mn->cleared = true;
>> -    mutex_unlock(&sva_lock);
>> -}
>> -
>>   static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
>>   {
>>       kfree(mn_to_smmu(mn));
>> @@ -222,7 +206,6 @@ static void arm_smmu_mmu_notifier_free(struct 
>> mmu_notifier *mn)
>>     static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
>>       .invalidate_range    = arm_smmu_mm_invalidate_range,
>> -    .release        = arm_smmu_mm_release,
>>       .free_notifier        = arm_smmu_mmu_notifier_free,
>>   };
>>   @@ -290,14 +273,8 @@ static void arm_smmu_mmu_notifier_put(struct 
>> arm_smmu_mmu_notifier *smmu_mn)
>>       list_del(&smmu_mn->list);
>>       arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
>>   -    /*
>> -     * If we went through clear(), we've already invalidated, and no
>> -     * new TLB entry can have been formed.
>> -     */
>> -    if (!smmu_mn->cleared) {
>> -        arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
>> -        arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>> -    }
>> +    arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
>> +    arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>>         /* Frees smmu_mn */
>>       mmu_notifier_put(&smmu_mn->mn);
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..246670318eda 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -76,12 +76,6 @@ struct arm_smmu_option_prop {
>>   DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
>>   DEFINE_MUTEX(arm_smmu_asid_lock);
>>   -/*
>> - * Special value used by SVA when a process dies, to quiesce a CD 
>> without
>> - * disabling it.
>> - */
>> -struct arm_smmu_ctx_desc quiet_cd = { 0 };
>> -
>>   static struct arm_smmu_option_prop arm_smmu_options[] = {
>>       { ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>>       { ARM_SMMU_OPT_PAGE0_REGS_ONLY, 
>> "cavium,cn9900-broken-page1-regspace"},
>> @@ -1047,9 +1041,7 @@ int arm_smmu_write_ctx_desc(struct 
>> arm_smmu_domain *smmu_domain, int ssid,
>>        * (2) Install a secondary CD, for SID+SSID traffic.
>>        * (3) Update ASID of a CD. Atomically write the first 64 bits 
>> of the
>>        *     CD, then invalidate the old entry and mappings.
>> -     * (4) Quiesce the context without clearing the valid bit. Disable
>> -     *     translation, and ignore any translation fault.
>> -     * (5) Remove a secondary CD.
>> +     * (4) Remove a secondary CD.
>>        */
>>       u64 val;
>>       bool cd_live;
>> @@ -1065,10 +1057,8 @@ int arm_smmu_write_ctx_desc(struct 
>> arm_smmu_domain *smmu_domain, int ssid,
>>       val = le64_to_cpu(cdptr[0]);
>>       cd_live = !!(val & CTXDESC_CD_0_V);
>>   -    if (!cd) { /* (5) */
>> +    if (!cd) { /* (4) */
>>           val = 0;
>> -    } else if (cd == &quiet_cd) { /* (4) */
>> -        val |= CTXDESC_CD_0_TCR_EPD0;
>>       } else if (cd_live) { /* (3) */
>>           val &= ~CTXDESC_CD_0_ASID;
>>           val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
> Thanks Jean
>
> Have tested, still got some issue with our openssl-engine.
>
> 1. If openssl-engine does not register rsa, nginx works well.
>
> 2. If openssl-engine register rsa, nginx also works, but ioasid is not 
> freed when nginx stop.
>
> IMPLEMENT_DYNAMIC_BIND_FN(bind_fn)
> bind_fn
> ENGINE_set_RSA(e, rsa_methods())
>
> destroy_fn
>
> If ENGINE_set_RSA is set, nginx start and stop will NOT call destroy_fn.
> Even rsa_methods is almost new via RSA_meth_new.
>
> In 5.18-rcx, this caused ioasid  not freed in nginx start and stop.
> In 5.17, though destroy_fn is not called, but ioasid is freed when 
> nginx stop, so not noticed this issue before.

1. uacce_fops_release
In 5.16 or 5.17
In fact, we aslo has the issue: openssl engine does not call destroy_fn 
-> close(uacce_fd)
But system will automatically close all opened fd,
so uacce_fops_release is also called and free ioasid.

Have one experiment, not call close fd

log: open uacce fd but no close
[ 2583.471225]  dump_backtrace+0x0/0x1a0
[ 2583.474876]  show_stack+0x20/0x30
[ 2583.478178]  dump_stack_lvl+0x8c/0xb8
[ 2583.481825]  dump_stack+0x18/0x34
[ 2583.485126]  uacce_fops_release+0x44/0xdc
[ 2583.489117]  __fput+0x78/0x240
[ 2583.492159]  ____fput+0x18/0x28
[ 2583.495288]  task_work_run+0x88/0x160
[ 2583.498936]  do_notify_resume+0x214/0x490
[ 2583.502927]  el0_svc+0x58/0x70
[ 2583.505968]  el0t_64_sync_handler+0xb0/0xb8
[ 2583.510132]  el0t_64_sync+0x1a0/0x1a4
[ 2583.582292]  uacce_fops_release q=00000000d6674128

In 5.18, since refcount was add.
The opened uacce fd was not closed automatically by system
So we see the issue.

log: open uacce fd but no close
  [  106.360140]  uacce_fops_open q=00000000ccc38d74
[  106.364929]  ioasid_alloc ioasid=1
[  106.368585]  iommu_sva_alloc_pasid pasid=1
[  106.372943]  iommu_sva_bind_device handle=000000006cca298a
// ioasid is not free


2. About the openssl engine destroy_fn
Only if we register rsa, even empry, the destroy_fn will not be called.
The reason is engine refcount is not 0, so not call e->destroy(e).
Not sure it is openssl issue or nginx issue.

IMPLEMENT_DYNAMIC_BIND_FN(bind_fn)

bind_fn
ENGINE_set_destroy_function(e, destroy_fn);
ENGINE_set_RSA(e, RSA_meth_new("rsa method", 0));   // here just add 
empty RSA

In openssl
engine_free_util
CRYPTO_DOWN_REF(&e->struct_ref, &i, global_engine_lock);
if (i > 0)
      return 1;
if (e->destroy)
     e->destroy(e);

If we register RSA, ENGINE_get_default_RSA will be called twice, adding
e->struct_ref + 2, so at last e->destroy(e) will not be called.
But the refcount is not decreased accordingly.


Basic calling sequence:
nginx:
src/http/modules/ngx_http_ssl_module.c
ngx_ssl_certificates
ngx_ssl_certificate
ngx_ssl_load_certificate-> PEM_ASN1_read_bio-> rsa_cb-> RSA_new
ngx_ssl_load_certificate_key-> PEM_read_bio_PrivateKey-> rsa_cb-> RSA_new
RSA_new ->ENGINE_get_default_RSA


more detail log:
First time call RSA_new, refcount +1
ngx_ssl_load_certificate-> PEM_ASN1_read_bio-> rsa_cb-> RSA_new

#0  0x0000fffff7b8cae0 in RSA_new () from /usr/local/lib/libcrypto.so.1.1
#1  0x0000fffff7b8b0bc in rsa_cb () from /usr/local/lib/libcrypto.so.1.1
#2  0x0000fffff7a952d4 in ASN1_item_ex_new () from 
/usr/local/lib/libcrypto.so.1.1
#3  0x0000fffff7a9300c in ASN1_item_ex_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#4  0x0000fffff7a93474 in ASN1_item_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#5  0x0000fffff7b89654 in rsa_pub_decode () from 
/usr/local/lib/libcrypto.so.1.1
#6  0x0000fffff7bc5c08 in x509_pubkey_decode () from 
/usr/local/lib/libcrypto.so.1.1
#7  0x0000fffff7bc5d34 in pubkey_cb () from /usr/local/lib/libcrypto.so.1.1
#8  0x0000fffff7a921d4 in asn1_item_embed_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#9  0x0000fffff7a92674 in asn1_template_noexp_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#10 0x0000fffff7a92904 in asn1_template_ex_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#11 0x0000fffff7a92038 in asn1_item_embed_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#12 0x0000fffff7a92674 in asn1_template_noexp_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#13 0x0000fffff7a92904 in asn1_template_ex_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#14 0x0000fffff7a9306c in ASN1_item_ex_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#15 0x0000fffff7a93474 in ASN1_item_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#16 0x0000fffff7bc6860 in d2i_X509_AUX () from 
/usr/local/lib/libcrypto.so.1.1
#17 0x0000fffff7b72adc in PEM_ASN1_read_bio () from 
/usr/local/lib/libcrypto.so.1.1
#18 0x0000aaaaaaaf5454 in ngx_ssl_load_certificate (pool=<optimized 
out>, err=err@entry=0xffffffffe9e8,
      cert=cert@entry=0xaaaaaac0ba30, chain=chain@entry=0xffffffffe9f0) 
at src/event/ngx_event_openssl.c:648
#19 0x0000aaaaaaaf7330 in ngx_ssl_certificate 
(cf=cf@entry=0xffffffffef58, ssl=ssl@entry=0xaaaaaac0a6b8,
      cert=cert@entry=0xaaaaaac0ba30, key=key@entry=0xaaaaaac0bad0, 
passwords=passwords@entry=0x0)
      at src/event/ngx_event_openssl.c:430
#20 0x0000aaaaaaaf7658 in ngx_ssl_certificates 
(cf=cf@entry=0xffffffffef58, ssl=ssl@entry=0xaaaaaac0a6b8,
      certs=0xaaaaaac0ba00, keys=<optimized out>, passwords=0x0) at 
src/event/ngx_event_openssl.c:410
#21 0x0000aaaaaab498f0 in ngx_http_ssl_merge_srv_conf 
(cf=0xffffffffef58, parent=0xaaaaaabf2a00,
      child=0xaaaaaac0a6b0) at src/http/modules/ngx_http_ssl_module.c:787
#22 0x0000aaaaaab01c40 in ngx_http_merge_servers (ctx_index=17, 
module=0xaaaaaaba86b0 <ngx_http_ssl_module_ctx>,
      cmcf=0xaaaaaabf1ec0, cf=0xffffffffef58) at src/http/ngx_http.c:584
#23 ngx_http_block (cf=0xffffffffef58, cmd=<optimized out>, 
conf=<optimized out>) at src/http/ngx_http.c:270
#24 0x0000aaaaaaad8d78 in ngx_conf_handler (last=1, cf=0xffffffffef58) 
at src/core/ngx_conf_file.c:463
#25 ngx_conf_parse (cf=cf@entry=0xffffffffef58, 
filename=filename@entry=0xaaaaaabeef58)
      at src/core/ngx_conf_file.c:319
#26 0x0000aaaaaaad628c in ngx_init_cycle (old_cycle=0xfffffffff170) at 
src/core/ngx_cycle.c:284
#27 0x0000aaaaaaac1b80 in main (argc=<optimized out>, argv=<optimized 
out>) at src/core/nginx.c:292


Second time call RSA_new:  refcount +1
ngx_ssl_load_certificate_key-> PEM_read_bio_PrivateKey-> rsa_cb-> RSA_new


#0  0x0000fffff7b8cae0 in RSA_new () from /usr/local/lib/libcrypto.so.1.1
#1  0x0000fffff7b8b0bc in rsa_cb () from /usr/local/lib/libcrypto.so.1.1
#2  0x0000fffff7a952d4 in ASN1_item_ex_new () from 
/usr/local/lib/libcrypto.so.1.1
#3  0x0000fffff7a9300c in ASN1_item_ex_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#4  0x0000fffff7a93474 in ASN1_item_d2i () from 
/usr/local/lib/libcrypto.so.1.1
#5  0x0000fffff7b89cbc in rsa_priv_decode () from 
/usr/local/lib/libcrypto.so.1.1
#6  0x0000fffff7b4d1ac in EVP_PKCS82PKEY () from 
/usr/local/lib/libcrypto.so.1.1
#7  0x0000fffff7b73730 in PEM_read_bio_PrivateKey () from 
/usr/local/lib/libcrypto.so.1.1
#8  0x0000aaaaaaaf376c in ngx_ssl_load_certificate_key (pool=<optimized 
out>, err=err@entry=0xffffffffe9d8,
      key=key@entry=0xaaaaaac08ad0, passwords=passwords@entry=0x0) at 
src/event/ngx_event_openssl.c:800
#9  0x0000aaaaaaaf5430 in ngx_ssl_certificate 
(cf=cf@entry=0xffffffffef58, ssl=ssl@entry=0xaaaaaac076b8,
      cert=cert@entry=0xaaaaaac08a30, key=key@entry=0xaaaaaac08ad0, 
passwords=passwords@entry=0x0)
      at src/event/ngx_event_openssl.c:521
#10 0x0000aaaaaaaf56e8 in ngx_ssl_certificates 
(cf=cf@entry=0xffffffffef58, ssl=ssl@entry=0xaaaaaac076b8,
      certs=0xaaaaaac08a00, keys=<optimized out>, passwords=0x0) at 
src/event/ngx_event_openssl.c:413
#11 0x0000aaaaaab46980 in ngx_http_ssl_merge_srv_conf 
(cf=0xffffffffef58, parent=0xaaaaaabefa00,
      child=0xaaaaaac076b0) at src/http/modules/ngx_http_ssl_module.c:787
#12 0x0000aaaaaaaffcd0 in ngx_http_merge_servers (ctx_index=17, 
module=0xaaaaaaba56b0 <ngx_http_ssl_module_ctx>,
      cmcf=0xaaaaaabeeec0, cf=0xffffffffef58) at src/http/ngx_http.c:584
#13 ngx_http_block (cf=0xffffffffef58, cmd=<optimized out>, 
conf=<optimized out>) at src/http/ngx_http.c:270
#14 0x0000aaaaaaad8dc8 in ngx_conf_handler (last=1, cf=0xffffffffef58) 
at src/core/ngx_conf_file.c:463
#15 ngx_conf_parse (cf=cf@entry=0xffffffffef58, 
filename=filename@entry=0xaaaaaabebf58)
      at src/core/ngx_conf_file.c:319
#16 0x0000aaaaaaad62dc in ngx_init_cycle (old_cycle=0xfffffffff170) at 
src/core/ngx_cycle.c:284
#17 0x0000aaaaaaac1bd0 in main (argc=<optimized out>, argv=<optimized 
out>) at src/core/nginx.c:292

Thanks

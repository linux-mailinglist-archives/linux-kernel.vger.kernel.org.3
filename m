Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C559C1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiHVOiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHVOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:38:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FEC29CBD;
        Mon, 22 Aug 2022 07:38:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A3C12FC;
        Mon, 22 Aug 2022 07:38:13 -0700 (PDT)
Received: from [10.57.15.77] (unknown [10.57.15.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E017E3F70D;
        Mon, 22 Aug 2022 07:38:07 -0700 (PDT)
Message-ID: <4650e8ff-86e1-d65e-bf87-c785013f3e08@arm.com>
Date:   Mon, 22 Aug 2022 15:38:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/5] drm/msm: Use separate ASID for each set of pgtables
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
References: <20220821181917.1188021-1-robdclark@gmail.com>
 <20220821181917.1188021-5-robdclark@gmail.com>
 <c8543ace-65cd-b8a8-499c-1b051867366b@arm.com>
In-Reply-To: <c8543ace-65cd-b8a8-499c-1b051867366b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-22 14:52, Robin Murphy wrote:
> On 2022-08-21 19:19, Rob Clark wrote:
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Optimize TLB invalidation by using different ASID for each set of
>> pgtables.  There can be scenarios where multiple processes end up
>> with the same ASID (such as >256 processes using the GPU), but this
>> is harmless, it will only result in some over-invalidation (but
>> less over-invalidation compared to using ASID=0 for all processes)
> 
> Um, if you're still relying on the GPU doing an invalidate-all-by-ASID 
> whenever it switches a TTBR, then there's only ever one ASID live in the 
> TLBs at once, so it really doesn't matter whether its value stays the 
> same or changes. This seems like a whole chunk of complexity to achieve 
> nothing :/
> 
> If you could actually use multiple ASIDs in a meaningful way to avoid 
> any invalidations, you'd need to do considerably more work to keep track 
> of reuse, and those races would probably be a lot less benign.

Oh, and on top of that, if you did want to go down that route then 
chances are you'd then also want to start looking at using global 
mappings in TTBR1 to avoid increased TLB pressure from kernel buffers, 
and then we'd run up against some pretty horrid MMU-500 errata which so 
far I've been happy to ignore on the basis that Linux doesn't use global 
mappings. Spoiler alert: unless you can additionally convert everything 
to invalidate by VA, the workaround for #752357 most likely makes the 
whole idea moot.

Robin.

>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>   drivers/gpu/drm/msm/msm_iommu.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c 
>> b/drivers/gpu/drm/msm/msm_iommu.c
>> index a54ed354578b..94c8c09980d1 100644
>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>> @@ -33,6 +33,8 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu 
>> *mmu, u64 iova,
>>           size_t size)
>>   {
>>       struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
>> +    struct adreno_smmu_priv *adreno_smmu =
>> +        dev_get_drvdata(pagetable->parent->dev);
>>       struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
>>       size_t unmapped = 0;
>> @@ -43,7 +45,7 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu 
>> *mmu, u64 iova,
>>           size -= 4096;
>>       }
>> -    iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
>> +    adreno_smmu->tlb_inv_by_id(adreno_smmu->cookie, pagetable->asid);
>>       return (unmapped == size) ? 0 : -EINVAL;
>>   }
>> @@ -147,6 +149,7 @@ static int msm_fault_handler(struct iommu_domain 
>> *domain, struct device *dev,
>>   struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
>>   {
>> +    static atomic_t asid = ATOMIC_INIT(1);
>>       struct adreno_smmu_priv *adreno_smmu = 
>> dev_get_drvdata(parent->dev);
>>       struct msm_iommu *iommu = to_msm_iommu(parent);
>>       struct msm_iommu_pagetable *pagetable;
>> @@ -210,12 +213,14 @@ struct msm_mmu 
>> *msm_iommu_pagetable_create(struct msm_mmu *parent)
>>       pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
>>       /*
>> -     * TODO we would like each set of page tables to have a unique ASID
>> -     * to optimize TLB invalidation.  But iommu_flush_iotlb_all() will
>> -     * end up flushing the ASID used for TTBR1 pagetables, which is not
>> -     * what we want.  So for now just use the same ASID as TTBR1.
>> +     * ASID 0 is used for kernel mapped buffers in TTBR1, which we
>> +     * do not need to invalidate when unmapping from TTBR0 pgtables.
>> +     * The hw ASID is at *least* 8b, but can be 16b.  We just assume
>> +     * the worst:
>>        */
>>       pagetable->asid = 0;
>> +    while (!pagetable->asid)
>> +        pagetable->asid = atomic_inc_return(&asid) & 0xff;
>>       return &pagetable->base;
>>   }

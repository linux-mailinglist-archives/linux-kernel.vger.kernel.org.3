Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E499E47C710
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbhLUSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:55:31 -0500
Received: from foss.arm.com ([217.140.110.172]:58600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237214AbhLUSza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:55:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE48D6E;
        Tue, 21 Dec 2021 10:55:30 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC1C3F718;
        Tue, 21 Dec 2021 10:55:26 -0800 (PST)
Message-ID: <7e68fa19-90b1-bbb5-9991-36b5d35278fa@arm.com>
Date:   Tue, 21 Dec 2021 18:55:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA
 Grace CMDQ-V
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, nicoleotsuka@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, nwatterson@nvidia.com,
        jean-philippe@linaro.org, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com, Jonathan.Cameron@huawei.com,
        yuzenghui@huawei.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        jgg@nvidia.com
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
 <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
 <20211220192714.GA27303@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211220192714.GA27303@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-20 19:27, Nicolin Chen wrote:
> Hi Robin,
> 
> Thank you for the reply!
> 
> On Mon, Dec 20, 2021 at 06:42:26PM +0000, Robin Murphy wrote:
>> On 2021-11-19 07:19, Nicolin Chen wrote:
>>> From: Nate Watterson <nwatterson@nvidia.com>
>>>
>>> NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
>>> which extends the standard ARM SMMU v3 IP to support multiple
>>> VCMDQs with virtualization capabilities. In-kernel of host OS,
>>> they're used to reduce contention on a single queue. In terms
>>> of command queue, they are very like the standard CMDQ/ECMDQs,
>>> but only support CS_NONE in the CS field of CMD_SYNC command.
>>>
>>> This patch adds a new nvidia-grace-cmdqv file and inserts its
>>> structure pointer into the existing arm_smmu_device, and then
>>> adds related function calls in the arm-smmu-v3 driver.
>>>
>>> In the CMDQV driver itself, this patch only adds minimal part
>>> for host kernel support. Upon probe(), VINTF0 is reserved for
>>> in-kernel use. And some of the VCMDQs are assigned to VINTF0.
>>> Then the driver will select one of VCMDQs in the VINTF0 based
>>> on the CPU currently executing, to issue commands.
>>
>> Is there a tangible difference to DMA API or VFIO performance?
> 
> Our testing environment is currently running on a single-core
> CPU, so unfortunately we don't have a perf data at this point.

OK, as for the ECMDQ patches I think we'll need some investigation with 
real workloads to judge whether we can benefit from these things enough 
to justify the complexity, and whether the design is right.

My gut feeling is that if these multi-queue schemes really can live up 
to their promise of making contention negligible, then they should 
further stand to benefit from bypassing the complex lock-free command 
batching in favour of something more lightweight, which could change the 
direction of much of the refactoring.

>> [...]
>>> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>> +{
>>> +     struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
>>> +     struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
>>> +     u16 qidx;
>>> +
>>> +     /* Check error status of vintf0 */
>>> +     if (!FIELD_GET(VINTF_STATUS, vintf0->status))
>>> +             return &smmu->cmdq;
>>> +
>>> +     /*
>>> +      * Select a vcmdq to use. Here we use a temporal solution to
>>> +      * balance out traffic on cmdq issuing: each cmdq has its own
>>> +      * lock, if all cpus issue cmdlist using the same cmdq, only
>>> +      * one CPU at a time can enter the process, while the others
>>> +      * will be spinning at the same lock.
>>> +      */
>>> +     qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;
>>
>> How does ordering work between queues? Do they follow a global order
>> such that a sync on any queue is guaranteed to complete all prior
>> commands on all queues?
> 
> CMDQV internal scheduler would insert a SYNC when (for example)
> switching from VCMDQ0 to VCMDQ1 while last command in VCMDQ0 is
> not SYNC. HW has a configuration bit in the register to disable
> this feature, which is by default enabled.

Interesting, thanks. So it sounds like this is something you can get 
away with for the moment, but may need to revisit once people chasing 
real-world performance start wanting to turn that bit off.

>> The challenge to make ECMDQ useful to Linux is how to make sure that all
>> the commands expected to be within scope of a future CMND_SYNC plus that
>> sync itself all get issued on the same queue, so I'd be mildly surprised
>> if you didn't have the same problem.
> 
> PATCH-3 in this series actually helps align the command queues,
> between issued commands and SYNC, if bool sync == true. Yet, if
> doing something like issue->issue->issue_with_sync, it could be
> tricker.

Indeed between the iommu_iotlb_gather mechanism and low-level command 
batching things are already a lot more concentrated than they could be, 
but arm_smmu_cmdq_batch_add() and its callers stand out as examples of 
where we'd still be vulnerable to preemption. What I haven't even tried 
to reason about yet is assumptions in the higher-level APIs, e.g. if 
io-pgtable might chuck out a TLBI during an iommu_unmap() which we 
implicitly expect a later iommu_iotlb_sync() to cover.

I've been thinking that in many ways per-domain queues make quite a bit 
of sense and would be easier to manage than per-CPU ones - plus that's 
pretty much the usage model once we get to VMs anyway - but that fails 
to help the significant cases like networking and storage where many 
CPUs are servicing a big monolithic device in a single domain :(

Robin.

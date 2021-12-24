Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB847EEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352658AbhLXMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:14:06 -0500
Received: from foss.arm.com ([217.140.110.172]:59500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhLXMOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:14:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E1F21FB;
        Fri, 24 Dec 2021 04:14:04 -0800 (PST)
Received: from [192.168.1.107] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426333F774;
        Fri, 24 Dec 2021 04:14:02 -0800 (PST)
Message-ID: <e44a90f6-be69-5dca-3903-46a8caa4a37c@arm.com>
Date:   Fri, 24 Dec 2021 12:13:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest
 owned VINTF
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, jean-philippe@linaro.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        jgg@nvidia.com, linux-arm-kernel@lists.infradead.org
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-6-nicolinc@nvidia.com>
 <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
 <20211222225134.GB5698@Asurada-Nvidia>
 <6d570b70-245d-bd99-a64c-065ade787d98@arm.com>
 <20211224080254.GA4653@Asurada-CZ80>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211224080254.GA4653@Asurada-CZ80>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-24 08:02, Nicolin Chen wrote:
> On Thu, Dec 23, 2021 at 11:14:17AM +0000, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2021-12-22 22:52, Nicolin Chen wrote:
>>> On Wed, Dec 22, 2021 at 12:32:29PM +0000, Robin Murphy wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 2021-11-19 07:19, Nicolin Chen via iommu wrote:
>>>>> When VCMDQs are assigned to a VINTF that is owned by a guest, not
>>>>> hypervisor (HYP_OWN bit is unset), only TLB invalidation commands
>>>>> are supported. This requires get_cmd() function to scan the input
>>>>> cmd before selecting cmdq between smmu->cmdq and vintf->vcmdq, so
>>>>> unsupported commands can still go through emulated smmu->cmdq.
>>>>>
>>>>> Also the guest shouldn't have HYP_OWN bit being set regardless of
>>>>> guest kernel driver writing it or not, i.e. the user space driver
>>>>> running in the host OS should wire this bit to zero when trapping
>>>>> a write access to this VINTF_CONFIG register from a guest kernel.
>>>>> So instead of using the existing regval, this patch reads out the
>>>>> register value explicitly to cache in vintf->cfg.
>>>>>
>>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> ---
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++--
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
>>>>>     .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 32 +++++++++++++++++--
>>>>>     3 files changed, 36 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index b1182dd825fd..73941ccc1a3e 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -337,10 +337,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
>>>>> +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>>>>>     {
>>>>>         if (smmu->nvidia_grace_cmdqv)
>>>>> -             return nvidia_grace_cmdqv_get_cmdq(smmu);
>>>>> +             return nvidia_grace_cmdqv_get_cmdq(smmu, cmds, n);
>>>>>
>>>>>         return &smmu->cmdq;
>>>>>     }
>>>>> @@ -747,7 +747,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>>>>>         u32 prod;
>>>>>         unsigned long flags;
>>>>>         bool owner;
>>>>> -     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
>>>>> +     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
>>>>>         struct arm_smmu_ll_queue llq, head;
>>>>>         int ret = 0;
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>>> index 24f93444aeeb..085c775c2eea 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>>> @@ -832,7 +832,8 @@ struct nvidia_grace_cmdqv *
>>>>>     nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
>>>>>                               struct acpi_iort_node *node);
>>>>>     int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
>>>>> -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
>>>>> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
>>>>> +                                               u64 *cmds, int n);
>>>>>     #else /* CONFIG_NVIDIA_GRACE_CMDQV */
>>>>>     static inline struct nvidia_grace_cmdqv *
>>>>>     nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
>>>>> @@ -847,7 +848,7 @@ static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
>>>>>     }
>>>>>
>>>>>     static inline struct arm_smmu_cmdq *
>>>>> -nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>>>> +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>>>>>     {
>>>>>         return NULL;
>>>>>     }
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
>>>>> index c0d7351f13e2..71f6bc684e64 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
>>>>> @@ -166,7 +166,8 @@ static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
>>>>>         return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
>>>>>     }
>>>>>
>>>>> -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>>>> +struct arm_smmu_cmdq *
>>>>> +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>>>>>     {
>>>>>         struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
>>>>>         struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
>>>>> @@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>>>>         if (!FIELD_GET(VINTF_STATUS, vintf0->status))
>>>>>                 return &smmu->cmdq;
>>>>>
>>>>> +     /* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
>>>>> +     if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
>>>>> +             u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
>>>>
>>>> I'm not sure there was ever a conscious design decision that batches
>>>> only ever contain one type of command - if something needs to start
>>>
>>> Hmm, I think that's a good catch -- as it could be a potential
>>> bug here. Though the SMMUv3 driver currently seems to use loop
>>> by adding one type of cmds to any batch and submitting it right
>>> away so checking opcode of cmds[0] alone seems to be sufficient
>>> at this moment, yet it might not be so in the future. We'd need
>>> to apply certain constrains on the type of cmds in the batch in
>>> SMMUv3 driver upon smmu->nvidia_grace_cmdqv, or fallback to the
>>> SMMUv3's CMDQ pathway here if one of cmds is not supported.
>>>
>>>> depending on that behaviour then that dependency probably wants to be
>>>> clearly documented. Also, a sync on its own gets trapped to the main
>>>> cmdq but a sync on the end of a batch of TLBIs or ATCIs goes to the
>>>> VCMDQ, huh?
>>>
>>> Yea...looks like an implication again where cmds must have SYNC
>>> at the end of the batch. I will see if any simple change can be
>>> done to fix these two. If you have suggestions for them, I would
>>> love to hear too.
>>
>> Can you explain the current logic here? It's not entirely clear to me
>> whether the VCMDQ is actually meant to support CMD_SYNC or not.
> 
> Yes. It's designed to take CMD_SYNC in same queue too. Though it
> also has features, such as HW-inserted-SYNC when scheduler moves
> away from the current queue or when the number of cmds in vcmdq
> meets a MAX-BATCH-SIZE setting (in config register), yet it'd be
> safer for software to ensure the CMD_SYNC is inserted to the end
> of the batch.

OK, so the bug here is just that we're missing CMDQ_OP_CMD_SYNC from the 
switch statement? That's reassuring at least. Having to trap to the host 
to issue a sync would be horrible, and largely defeat the point of the 
whole exercise.

It's not generally much use to software to know that the hardware may or 
may not have automatically inserted syncs at arbitrary points in the 
timeline; certainly for our flow in Linux, which I don't think is 
atypical, we need to know for sure that specific invalidation commands 
have completed before we can safely reuse resources associated with the 
invalidated translations, and the only way to guarantee that is to 
explicitly observe the consumption of a CMD_SYNC from a later queue index.

>>>>> +
>>>>> +             /* List all supported CMDs for vintf->cmdq pathway */
>>>>> +             switch (opcode) {
>>>>> +             case CMDQ_OP_TLBI_NH_ASID:
>>>>> +             case CMDQ_OP_TLBI_NH_VA:
>>>>> +             case CMDQ_OP_TLBI_S12_VMALL:
>>>>> +             case CMDQ_OP_TLBI_S2_IPA:
>>>>
>>>> Fun! Can the guest invalidate any VMID it feels like, or is there some
>>>> additional magic on the host side that we're missing here?
>>>
>>> Yes. VINTF has a register for SW to program VMID so that the HW
>>> can replace VMIDs in the cmds in the VCMDQs of that VINTF with
>>> the programmed VMID. That was the reason why we had numbers of
>>> patches in v2 to route the VMID between guest and host.
>>>
>>>>> +             case CMDQ_OP_ATC_INV:
>>>>> +                     break;
>>>> Ditto for StreamID here.
>>>
>>> Yes. StreamID works similarly by the HW: each VINTF provides us
>>> 16 pairs of MATCH+REPLACE registers to program host and guest's
>>> StreamIDs. Our previous mdev implementation in v2 can be a good
>>> reference code:
>>> https://lore.kernel.org/kvm/20210831101549.237151fa.alex.williamson@redhat.com/T/#m903a1b44935d9e0376439a0c63e832eb464fbaee
>>
>> Ah, sorry, I haven't had the bandwidth to dig back through all the
>> previous threads. Thanks for clarifying - I'm still not sure why any
>> notion of stage 2 would be exposed to guests at all, but at least ita
> 
> Do you mean, by "notion of stage 2", Host Stream IDs? The guest
> wouldn't get those I think. They'll be trapped in the hypervisor
> -- the user driver (QEMU CMDQV device model for example.)

I mean if it's emulated as a full SMMUv3 interface, IDR0.S2P=0. At the 
moment it makes no sense for a guest to even *think* it can issue 
TLBI_S2_IPA or TLBI_S12_VMALL. My understanding of the usage model for 
this is that we pick the Context Descriptor from guest memory via the 
emulated Stream Table (or other mechanism like virtio-iommu) and plumb 
it directly into the S1ContextPtr of the appropriate underlying physical 
STE, on top of the host's S2 translation. I don't see how we could also 
flatten an emulated S2 into either physical stage without having to go 
back to the costly "trap all pagetable accesses" approach which would 
obliterate the benefit of having a directly-assigned queue.

>> sounds like there's no functional concern here, other than constraining
>> the number of devices which can be assigned to a single VM, but I think
>> that falls into the bucket of information that userspace VMMs will have
>> to learn about this kind of direct IOMMU interface assignment anyway
>> (most importantly, the relationship of assigned devices to vIOMMUs
>> suddenly has to start reflecting the underlying physical topology).
> 
> We haven't started to think how to fit the best into the IOMMUFD
> but we will be likely having some idea or test case in Jan.
> 
>> Out of interest, would ATC_INV with an unmatched StreamID raise an error
>> or just be ignored? Particularly if the host gets a chance to handle a
> 
> Mismatched StreamID will be treated as an Illegal command. Yes,
> there'd be an error.
> 
>> GError and decide whether CMDQ_CONS.ERR is reported back to the guest or
>> not, there's scope to do some interesting things for functionality and
>> robustness.
> 
> Would love to learn more about your thoughts :)

Basically it's quite neat if we could present a virtual queue to the 
guest as the vSMMU's main queue, such that any commands that the 
hardware can't consume directly could be fixed up or emulated by the 
host with the illusion that they're being consumed as normal. It does 
push more complexity into the host, and a round trip via the GError 
interrupt would be a bit less efficient than trapping synchronously on a 
write to an emulated CMDQ_PROD for commands that *do* need emulating, 
but conversely it means we could support any guest with only the most 
basic understanding of SMMUv3.0, and could potentially be more robust 
overall. As I say, though, it depends entirely on the guest not being 
able to observe an error unltil the host has decided not to fix up the 
offending command.

> Btw, I think we may continue the discussion on this PATCH-5 and
> then to figure out ideal solutions for those potential bugs that
> you commented so far, as this patch really is very introductory
> to Guest support (we need more implementation based on IOMMUFD.)
> 
> For the first 4 patches, they could be separated. Do you see a
> chance to get them applied first? They are in the mail list for
> a while now. And we'd like to accelerate the progress of those
> four changes first.

I can't speak for Will, but personally I'd consider them exactly the 
same as the ECMDQ patches - it's good to have them out here, reviewed as 
far as we reasonably can, and ready for people to experiment with as 
soon as the real hardware turns up, but I don't see any benefit in 
actually merging unproven complexity into mainline before then. Neither 
patchset gives Linux any new functionality that it can't achieve already 
with the regular cmdq, so there's nothing to gain until it's actually 
demonstrable that we really are addressing the right bottlenecks in the 
right manner to meaningfully improve real-world performance, but what we 
have to lose is more effort spent ripping stuff out again if it turns 
out to be no good. Even patches #1-#3 here fundamentally beg the 
question of whether replicating the full heavyweight cmdq behaviour is 
the right way to go.

I appreciate you've probably got hardware validation teams on your back 
wanting "the driver" to support every new feature right now for them to 
exercise, but we just have to stand firm and tell them that's not how 
upstream works :)

Thanks,
Robin.

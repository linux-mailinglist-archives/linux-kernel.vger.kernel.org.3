Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650F546DB55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhLHSoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhLHSoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E1A11FB;
        Wed,  8 Dec 2021 10:40:36 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5483F73D;
        Wed,  8 Dec 2021 10:40:35 -0800 (PST)
Message-ID: <aaa42ce4-7a8a-44a5-2f84-54981bf0b742@arm.com>
Date:   Wed, 8 Dec 2021 18:40:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
 <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
 <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
 <4f296b55-a59a-49b4-ad4d-902bb83a203c@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4f296b55-a59a-49b4-ad4d-902bb83a203c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 18:17, John Garry wrote:
>>> Did you notice any performance change with this change?
>>
>> Hi John:
>>    Thanks for the tip. I wrote a test case today, and I found that the
>> performance did not go up but down.
> 
> I very quickly tested on a DMA mapping benchmark very similar to the 
> kernel DMA benchmark module - I got mixed results. For fewer CPUs (<8), 
> a small improvement, like 0.7%. For more CPUs, a dis-improvement - 
> that's surprising, I did expect just no change as any improvement would 
> get dwarfed from the slower unmap rates for more CPUs. I can check this
> more tomorrow.
> 
>> It's so weird. So I decided not to
>> change it, because it's also poorly readable. So I plan to make only
>> the following modifications:
>> @@ -237,7 +237,7 @@ static int queue_remove_raw(struct arm_smmu_queue 
>> *q, u64 *ent)
>>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct 
>> arm_smmu_cmdq_ent *ent)
>>   {
>>          memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>> -       cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> +       cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>>
>>          switch (ent->opcode) {
>>          case CMDQ_OP_TLBI_EL2_ALL:
>>
>> This prevents the compiler from generating the following two inefficient
>> instructions:
>>       394:       f9400002        ldr     x2, [x0]    //x2 = cmd[0]
>>       398:       aa020062        orr     x2, x3, x2    //x3 = 
>> FIELD_PREP(CMDQ_0_OP, ent->opcode)
>>
>> Maybe it's not worth changing because I've only seen a 0.x nanosecond 
>> reduction
>> in performance. But one thing is, it only comes with benefits, no side 
>> effects.
>>
> 
> I just think that with the original code that cmd[] is on the stack and 
> cached, so if we have write-back attribute (which I think we do) then 
> there would not necessarily a write to external memory per write to cmd[].
> 
> So, apart from this approach, I think that if we can just reduce the 
> instructions through other efficiencies in the function then that would 
> be good.

Not sure if it's still true, but FWIW last time the best result actually 
came from doing the ridiculously counter-intuitive:

https://lore.kernel.org/linux-iommu/141de3c3278e280712d16d9ac9ab305c3b80a810.1534344167.git.robin.murphy@arm.com/

Robin.

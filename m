Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D491546DAE6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhLHSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:21:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4234 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbhLHSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:21:41 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8QNm4dqMz67mM5;
        Thu,  9 Dec 2021 02:16:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 8 Dec 2021 19:18:06 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 18:18:06 +0000
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
 <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
 <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4f296b55-a59a-49b4-ad4d-902bb83a203c@huawei.com>
Date:   Wed, 8 Dec 2021 18:17:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Did you notice any performance change with this change?
> 
> Hi John:
>    Thanks for the tip. I wrote a test case today, and I found that the
> performance did not go up but down.

I very quickly tested on a DMA mapping benchmark very similar to the 
kernel DMA benchmark module - I got mixed results. For fewer CPUs (<8), 
a small improvement, like 0.7%. For more CPUs, a dis-improvement - 
that's surprising, I did expect just no change as any improvement would 
get dwarfed from the slower unmap rates for more CPUs. I can check this
more tomorrow.

> It's so weird. So I decided not to
> change it, because it's also poorly readable. So I plan to make only
> the following modifications:
> @@ -237,7 +237,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   {
>          memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -       cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +       cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 
>          switch (ent->opcode) {
>          case CMDQ_OP_TLBI_EL2_ALL:
> 
> This prevents the compiler from generating the following two inefficient
> instructions:
>       394:       f9400002        ldr     x2, [x0]	//x2 = cmd[0]
>       398:       aa020062        orr     x2, x3, x2	//x3 = FIELD_PREP(CMDQ_0_OP, ent->opcode)
> 
> Maybe it's not worth changing because I've only seen a 0.x nanosecond reduction
> in performance. But one thing is, it only comes with benefits, no side effects.
> 

I just think that with the original code that cmd[] is on the stack and 
cached, so if we have write-back attribute (which I think we do) then 
there would not necessarily a write to external memory per write to cmd[].

So, apart from this approach, I think that if we can just reduce the 
instructions through other efficiencies in the function then that would 
be good.

Thanks,
John




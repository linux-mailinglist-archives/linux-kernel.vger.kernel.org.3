Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645A846C091
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhLGQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:21:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4228 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbhLGQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:21:08 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7lmF4sJwz67RCg;
        Wed,  8 Dec 2021 00:16:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 17:17:36 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 16:17:36 +0000
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
Date:   Tue, 7 Dec 2021 16:17:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211207094109.1962-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 09:41, Zhen Lei via iommu wrote:
> Although the parameter 'cmd' is always passed by a local array variable,
> and only this function modifies it, the compiler does not know this. Every
> time the 'cmd' variable is updated, a memory write operation is generated.
> This generates many useless instruction operations.

I'd hardly call them useless. More like inefficient or sub-optimum.

> 
> To guide the compiler for proper optimization, 'cmd' is defined as a local
> array variable, and copied to the output parameter at a time when the
> function is returned.
> 
> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
> command.
> 
> Before:
>     text    data     bss     dec     hex
>    28246    1332      56   29634    73c2
> 
> After:
>     text    data     bss     dec     hex
>    28134    1332      56   29522    7352
> 
> For example:
> 	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> case CMDQ_OP_TLBI_EL2_VA:
> 	cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> 	cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
> 	cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
> 	cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> 	cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> 	cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
> 	cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
> 
> Before:
>    Each "cmd[0] |=" or "cmd[1] |=" operation generates a "str" instruction,
> sum = 8.
> 
>       ldrb	w4, [x1, #8]		//w4 = ent->tlbi.num
>       ubfiz	x4, x4, #12, #5
>       mov	w0, #0x0
>       orr	x4, x4, x3
>       str	x4, [x2]
>       autiasp
>       ldrb	w3, [x1, #9]		//w3 = ent->tlbi.scale
>       ubfiz	x3, x3, #20, #5
>       orr	x3, x3, x4
>       str	x3, [x2]
>       ldrh	w4, [x1, #10]		//w4 = ent->tlbi.asid
>       orr	x3, x3, x4, lsl #48
>       str	x3, [x2]
>       ldrb	w3, [x1, #14]		//w3 = ent->tlbi.leaf
>       str	x3, [x2, #8]
>       ldrb	w4, [x1, #15]		//w4 = ent->tlbi.ttl
>       ubfiz	x4, x4, #8, #2
>       orr	x4, x4, x3
>       str	x4, [x2, #8]
>       ldrb	w3, [x1, #16]		//ent->tlbi.tg
>       ubfiz	x3, x3, #10, #2
>       orr	x3, x3, x4
>       str	x3, [x2, #8]
>       ldr	x1, [x1, #24]		//ent->tlbi.addr
>       and	x1, x1, #0xfffffffffffff000
>       orr	x1, x1, x3
>       str	x1, [x2, #8]
>       ret
> 
> After:
>    All "cmd[0] |=" and "cmd[1] |=" operations generate a "stp" instruction,
> sum = 1.
> 
> 3e8:
>       mov	w0, #0x0
>       autiasp
>       stp	x2, x1, [x3]
>       ret
>       bti	j
> 3fc:
>       ldrb	w5, [x1, #8]		//w5 = ent->tlbi.num
>       mov	x2, #0x22		//x2 = ent->opcode = CMDQ_0_OP
>       ldrb	w6, [x1, #9]		//w6 = ent->tlbi.scale
>       ubfiz	x5, x5, #12, #5
>       ldrb	w0, [x1, #16]		//w0 = ent->tlbi.tg
>       orr	x5, x5, x2
>       ldrb	w7, [x1, #15]		//w7 = ent->tlbi.ttl
>       ldr	x4, [x1, #24]		//x4 = ent->tlbi.addr
>       ubfiz	x0, x0, #10, #2
>       ldrh	w2, [x1, #10]		//w2 = ent->tlbi.asid
>       ubfiz	x6, x6, #20, #5
>       ldrb	w8, [x1, #14]		//w8 = ent->tlbi.leaf
>       and	x4, x4, #0xfffffffffffff000
>       ubfiz	x1, x7, #8, #2
>       orr	x1, x0, x1
>       orr	x2, x6, x2, lsl #48
>       orr	x0, x4, x8
>       orr	x2, x2, x5
>       orr	x1, x1, x0
>       b		3e8
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f5848b351b19359..e55dfc14cac6005 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -234,10 +234,12 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   }
>   
>   /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	int i;
> +	u64 cmd[CMDQ_ENT_DWORDS] = {0};

I thought that just {} was preferred. Or could have:
u64 cmd[CMDQ_ENT_DWORDS] = {FIELD_PREP(CMDQ_0_OP, ent->opcode), };
to be more concise

> +
> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>   
>   	switch (ent->opcode) {
>   	case CMDQ_OP_TLBI_EL2_ALL:
> @@ -332,6 +334,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		return -ENOENT;
>   	}
>   
> +	for (i = 0; i < CMDQ_ENT_DWORDS; i++)
> +		out_cmd[i] = cmd[i];

how about memcpy() instead?

> +
>   	return 0;
>   }

Did you notice any performance change with this change?

Thanks,
John


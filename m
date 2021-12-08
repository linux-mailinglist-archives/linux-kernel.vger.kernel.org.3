Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9253146D489
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhLHNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:43:45 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32887 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhLHNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:43:45 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8JFB6w66zcbpt;
        Wed,  8 Dec 2021 21:39:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 21:40:11 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 21:40:10 +0800
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
 <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
Date:   Wed, 8 Dec 2021 21:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/8 0:17, John Garry wrote:
> 
>> +
>>       return 0;
>>   }
> 
> Did you notice any performance change with this change?

Hi John:
  Thanks for the tip. I wrote a test case today, and I found that the
performance did not go up but down. It's so weird. So I decided not to
change it, because it's also poorly readable. So I plan to make only
the following modifications:
@@ -237,7 +237,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
        memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
-       cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
+       cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);

        switch (ent->opcode) {
        case CMDQ_OP_TLBI_EL2_ALL:

This prevents the compiler from generating the following two inefficient
instructions:
     394:       f9400002        ldr     x2, [x0]	//x2 = cmd[0]
     398:       aa020062        orr     x2, x3, x2	//x3 = FIELD_PREP(CMDQ_0_OP, ent->opcode)

Maybe it's not worth changing because I've only seen a 0.x nanosecond reduction
in performance. But one thing is, it only comes with benefits, no side effects.

> 
> Thanks,
> John

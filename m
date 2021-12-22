Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3047D162
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbhLVL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:57:15 -0500
Received: from foss.arm.com ([217.140.110.172]:44044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhLVL5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:57:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E241FB;
        Wed, 22 Dec 2021 03:57:13 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CCF3F5A1;
        Wed, 22 Dec 2021 03:57:10 -0800 (PST)
Message-ID: <2fbc6a98-6569-0a06-c901-9a37e40ccb7c@arm.com>
Date:   Wed, 22 Dec 2021 11:57:05 +0000
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
 <7e68fa19-90b1-bbb5-9991-36b5d35278fa@arm.com>
 <20211221220037.GA6292@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211221220037.GA6292@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-21 22:00, Nicolin Chen wrote:
[...]
>>>> The challenge to make ECMDQ useful to Linux is how to make sure that all
>>>> the commands expected to be within scope of a future CMND_SYNC plus that
>>>> sync itself all get issued on the same queue, so I'd be mildly surprised
>>>> if you didn't have the same problem.
>>>
>>> PATCH-3 in this series actually helps align the command queues,
>>> between issued commands and SYNC, if bool sync == true. Yet, if
>>> doing something like issue->issue->issue_with_sync, it could be
>>> tricker.
>>
>> Indeed between the iommu_iotlb_gather mechanism and low-level command
>> batching things are already a lot more concentrated than they could be,
>> but arm_smmu_cmdq_batch_add() and its callers stand out as examples of
>> where we'd still be vulnerable to preemption. What I haven't even tried
>> to reason about yet is assumptions in the higher-level APIs, e.g. if
>> io-pgtable might chuck out a TLBI during an iommu_unmap() which we
>> implicitly expect a later iommu_iotlb_sync() to cover.
> 
> Though I might have oversimplified the situation here, I see
> the arm_smmu_cmdq_batch_add() calls are typically followed by
> arm_smmu_cmdq_batch_submit(). Could we just add a SYNC in the
> _batch_submit() to all the queues that it previously touched
> in the _batch_add()?

Keeping track of which queues a batch has touched is certainly possible, 
but it's yet more overhead to impose across the board when intra-batch 
preemption should (hopefully) be very rare in practice. I was thinking 
more along the lines of disabling preemption/migration for the lifetime 
of a batch, or more pragmatically just hoisting the queue selection all 
the way out to the scope of the batch itself (which also conveniently 
seems about the right shape for potentially forking off a whole other 
dedicated command submission flow from that point later).

We still can't mitigate inter-batch preemption, though, so we'll just 
have to audit everything very carefully to make sure we don't have (or 
inadvertently introduce in future) any places where that could be 
problematic. We really want to avoid over-syncing as that's liable to 
end up being just as bad for performance as the contention that we're 
nominally avoiding.

>> I've been thinking that in many ways per-domain queues make quite a bit
>> of sense and would be easier to manage than per-CPU ones - plus that's
>> pretty much the usage model once we get to VMs anyway - but that fails
>> to help the significant cases like networking and storage where many
>> CPUs are servicing a big monolithic device in a single domain :(
> 
> Yea, and it's hard to assume which client would use CMDQ more
> frequently, in order to balance or assign more queues to that
> client, which feels like a QoS conundrum.

Indeed, plus once we start assigning queues to VMs we're going to want 
to remove them from the general pool for host usage, so we definitely 
want to plan ahead here.

Cheers,
Robin.

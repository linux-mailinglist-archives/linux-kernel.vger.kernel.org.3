Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EA25AEFF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiIFQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiIFQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:08:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A543101DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:33:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C88F3139F;
        Tue,  6 Sep 2022 06:37:30 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437753F7B4;
        Tue,  6 Sep 2022 06:37:23 -0700 (PDT)
Message-ID: <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
Date:   Tue, 6 Sep 2022 14:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        Ethan Zhao <haifeng.zhao@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-06 11:50, John Garry wrote:
> On 06/09/2022 10:28, Ethan Zhao wrote:
> 
> Hi Ethan,
> 
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/iova.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 47d1983dfa2a..580fdf669922 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine 
>>> *mag, struct iova_domain *iovad)
>>>       unsigned long flags;
>>>       int i;
>>> -    if (!mag)
>>> -        return;
>>> -
>>
>> iommu_probe_device
>>    ops->probe_finalize(dev);
>>      intel_iommu_probe_finalize
>>         iommu_setup_dma_ops
>>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>>             iova_domain_init_rcaches
>>               {
>>               ...
>>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>>                  ret = -ENOMEM;
>>                        goto out_err;
>>
>> Do you mean iova_magazine_alloc() is impossible to fail ?
> 
> No, iova_magazine_alloc() may fail and return NULL. But if it does then 
> we set iovad rcache pointer = NULL in the error path and don't use the 
> rcache.
> 
> However we have a !iovad->rcache check on the "fast" alloc but not 
> "insert". I need to check why that is again.

Right, if you find a good reason to respin the patch then perhaps also 
tweaking the commit message to clarify that it's impossible to have a 
NULL rcache *at any point where those checks are made* might avoid all 
possible doubt, however I'd hope that it's clear enough that the 
transient case while iova_domain_init_rcaches() is in the process of 
failing really doesn't need consideration in its own right.

I guess the check in iova_rcache_get() was maybe with the intent of 
allowing alloc_iova_fast() to seamlessly fall back to standard 
allocation, so an API user can treat iova_domain_init_rcaches() failure 
as non-fatal? That makes a fair amount of sense, but does mean that 
we're missing the equivalent in iova_rcache_insert() for it to actually 
work. Or we just remove it and tighten up the documentation to say 
that's not valid - I would like a way to make rcaches optional in 
iommu-dma for systems where they're a pointless waste of memory, but we 
can always revisit this when we get there.

Cheers,
Robin.

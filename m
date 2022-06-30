Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C856167A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiF3Jhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiF3Jh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:37:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6C43389
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:37:26 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYY8N6qV4z686VP;
        Thu, 30 Jun 2022 17:35:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 11:37:23 +0200
Received: from [10.126.174.156] (10.126.174.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 10:37:22 +0100
Message-ID: <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
Date:   Thu, 30 Jun 2022 10:37:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
To:     Robin Murphy <robin.murphy@arm.com>,
        Feng Tang <feng.tang@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        "Vlastimil Babka" <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.174.156]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 10:02, Robin Murphy wrote:
> On 2022-06-30 08:33, Feng Tang wrote:
>> kmalloc will round up the request size to power of 2, and current
>> iova_magazine's size is 1032 (1024+8) bytes, so each instance
>> allocated will get 2048 bytes from kmalloc, causing around 1KB
>> waste.
>>
>> And in some exstreme case, the memory wasted can trigger OOM as
>> reported in 2019 on a crash kernel with 256 MB memory [1].
> 
> I don't think it really needs pointing out that excessive memory 
> consumption can cause OOM. Especially not in the particularly silly 
> context of a system with only 2MB of RAM per CPU - that's pretty much 
> guaranteed to be doomed one way or another.
> 
>>    [    4.319253] iommu: Adding device 0000:06:00.2 to group 5
>>    [    4.325869] iommu: Adding device 0000:20:01.0 to group 15
>>    [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
>>    [    4.338946] swapper/0 invoked oom-killer: 
>> gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, 
>> oom_score_adj=0
>>    [    4.350251] swapper/0 cpuset=/ mems_allowed=0
>>    [    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
>> 4.19.57.mx64.282 #1
>>    [    4.355612] Hardware name: Dell Inc. PowerEdge R7425/08V001, 
>> BIOS 1.9.3 06/25/2019
>>    [    4.355612] Call Trace:
>>    [    4.355612]  dump_stack+0x46/0x5b
>>    [    4.355612]  dump_header+0x6b/0x289
>>    [    4.355612]  out_of_memory+0x470/0x4c0
>>    [    4.355612]  __alloc_pages_nodemask+0x970/0x1030
>>    [    4.355612]  cache_grow_begin+0x7d/0x520
>>    [    4.355612]  fallback_alloc+0x148/0x200
>>    [    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
>>    [    4.355612]  init_iova_domain+0x112/0x170
>>    [    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
>>    [    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
>>    [    4.355612]  amd_iommu_add_device+0x13a/0x610
>>    [    4.355612]  add_iommu_group+0x20/0x30
>>    [    4.355612]  bus_for_each_dev+0x76/0xc0
>>    [    4.355612]  bus_set_iommu+0xb6/0xf0
>>    [    4.355612]  amd_iommu_init_api+0x112/0x132
>>    [    4.355612]  state_next+0xfb1/0x1165
>>    [    4.355612]  amd_iommu_init+0x1f/0x67
>>    [    4.355612]  pci_iommu_init+0x16/0x3f
>>    ...
>>    [    4.670295] Unreclaimable slab info:
>>    ...
>>    [    4.857565] kmalloc-2048           59164KB      59164KB
>>
>> Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
>> 1024 bytes so that no memory will be wasted.
>>
>> [1]. https://lkml.org/lkml/2019/8/12/266
>>
>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> ---
>>   drivers/iommu/iova.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index db77aa675145b..27634ddd9b904 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -614,7 +614,12 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>>    * dynamic size tuning described in the paper.
>>    */
>> -#define IOVA_MAG_SIZE 128
>> +/*
>> + * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
>> + * assure size of 'iova_magzine' to be 1024 bytes, so that no memory
> 
> Typo: iova_magazine
> 
>> + * will be wasted.
>> + */
>> +#define IOVA_MAG_SIZE 127

I do wonder if we will see some strange new behaviour since IOVA_FQ_SIZE 
% IOVA_MAG_SIZE != 0 now...

> 
> The change itself seems perfectly reasonable, though.
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>


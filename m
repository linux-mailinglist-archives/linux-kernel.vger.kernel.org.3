Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0152EA90
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbiETLOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiETLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:14:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025709E9C7;
        Fri, 20 May 2022 04:14:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4PDp6dbNzQk8V;
        Fri, 20 May 2022 19:11:38 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 19:14:35 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 19:14:34 +0800
Message-ID: <641b4f4f-9786-d11c-e264-daaf0d564b7c@huawei.com>
Date:   Fri, 20 May 2022 19:14:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/2] Documentation/barriers: Add memory barrier
 dma_mb()
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
 <20220520031548.175582-2-wangkefeng.wang@huawei.com>
 <YodouVpl26890QfU@elver.google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YodouVpl26890QfU@elver.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/20 18:08, Marco Elver wrote:
> On Fri, May 20, 2022 at 11:15AM +0800, Kefeng Wang wrote:
>> The memory barrier dma_mb() is introduced by commit a76a37777f2c
>> ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
>> which is used to ensure that prior (both reads and writes) accesses to
>> memory by a CPU are ordered w.r.t. a subsequent MMIO write.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   Documentation/memory-barriers.txt | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
>> index b12df9137e1c..1eabcc0e4eca 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -1894,10 +1894,13 @@ There are some more advanced barrier functions:
>>   
>>    (*) dma_wmb();
>>    (*) dma_rmb();
>> + (*) dma_mb();
>>   
>>        These are for use with consistent memory to guarantee the ordering
>>        of writes or reads of shared memory accessible to both the CPU and a
>> -     DMA capable device.
>> +     DMA capable device, in the case of ensure the prior (both reads and
>> +     writes) accesses to memory by a CPU are ordered w.r.t. a subsequent
>> +     MMIO write, dma_mb().
>>   
> I think this is out of place; this explanation here is not yet
> elaborating on either. Elaboration on dma_mb() should go where
> dma_rmb() and dma_wmb() are explained.
>
> Something like this:
>
> ------ >8 ------
>
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..fb322b6cce70 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
>   
>    (*) dma_wmb();
>    (*) dma_rmb();
> + (*) dma_mb();
>   
>        These are for use with consistent memory to guarantee the ordering
>        of writes or reads of shared memory accessible to both the CPU and a
> @@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
>        The dma_rmb() allows us guarantee the device has released ownership
>        before we read the data from the descriptor, and the dma_wmb() allows
>        us to guarantee the data is written to the descriptor before the device
> -     can see it now has ownership.  Note that, when using writel(), a prior
> -     wmb() is not needed to guarantee that the cache coherent memory writes
> -     have completed before writing to the MMIO region.  The cheaper
> -     writel_relaxed() does not provide this guarantee and must not be used
> -     here.
> +     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and a
> +     dma_wmb().  Note that, when using writel(), a prior wmb() is not needed to
> +     guarantee that the cache coherent memory writes have completed before
> +     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> +     this guarantee and must not be used here.
>   
>        See the subsection "Kernel I/O barrier effects" for more information on
>        relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
>
> ------ >8 ------
Thanks， will use above explanation.
> Also, now that you're making dma_mb() part of the official API, it might
> need a generic definition in include/asm-generic/barrier.h, because
> as-is it's only available in arm64 builds.

Ok, it's good to add the dma_mb() and __dma_mb  definition with a 
separate patch

into include/asm-generic/barrier.h.

>
> Thoughts?
>
> Thanks,
> -- Marco
> .

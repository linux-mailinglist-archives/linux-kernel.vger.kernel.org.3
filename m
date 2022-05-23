Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F8531006
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiEWKq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiEWKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:46:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1D40E5D;
        Mon, 23 May 2022 03:46:18 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6DW351QHzjX2m;
        Mon, 23 May 2022 18:45:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 18:46:15 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 18:46:14 +0800
Message-ID: <36c7224c-87a6-aa31-cfaa-06a0b168c68d@huawei.com>
Date:   Mon, 23 May 2022 18:46:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/2] asm-generic: Add memory barrier dma_mb()
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20220523020051.141460-1-wangkefeng.wang@huawei.com>
 <20220523020051.141460-2-wangkefeng.wang@huawei.com>
 <CANpmjNMxmRsWVvqe=30JEhCqPdGvUcKUgLoe2VjfMbKfHwFyaA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CANpmjNMxmRsWVvqe=30JEhCqPdGvUcKUgLoe2VjfMbKfHwFyaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/23 16:22, Marco Elver wrote:
> On Mon, 23 May 2022 at 03:50, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> The memory barrier dma_mb() is introduced by commit a76a37777f2c
>> ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
>> which is used to ensure that prior (both reads and writes) accesses
>> to memory by a CPU are ordered w.r.t. a subsequent MMIO write, this
>> is only defined on arm64, but it is a generic memory barrier, let's
>> add dma_mb() into documentation and include/asm-generic/barrier.h.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   Documentation/memory-barriers.txt | 11 ++++++-----
>>   include/asm-generic/barrier.h     |  8 ++++++++
>>   2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
>> index b12df9137e1c..07a8b8e1b12a 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
>>
>>    (*) dma_wmb();
>>    (*) dma_rmb();
>> + (*) dma_mb();
>>
>>        These are for use with consistent memory to guarantee the ordering
>>        of writes or reads of shared memory accessible to both the CPU and a
>> @@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
>>        The dma_rmb() allows us guarantee the device has released ownership
>>        before we read the data from the descriptor, and the dma_wmb() allows
>>        us to guarantee the data is written to the descriptor before the device
>> -     can see it now has ownership.  Note that, when using writel(), a prior
>> -     wmb() is not needed to guarantee that the cache coherent memory writes
>> -     have completed before writing to the MMIO region.  The cheaper
>> -     writel_relaxed() does not provide this guarantee and must not be used
>> -     here.
>> +     can see it now has ownership. The dma_mb() implies both a dma_rmb() and
>> +     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
>> +     to guarantee that the cache coherent memory writes have completed before
>> +     writing to the MMIO region. The cheaper writel_relaxed() does not provide
>> +     this guarantee and must not be used here.
> It seems you've changed that spacing. This document uses 2 spaces
> after a sentence-ending '.'. (My original suggestion included the 2
> spaces after dots.)

I don't know the rules, it seems that some uses 1 spaces, others are 2 
spaces, but most

uses 2 spaces, will update.

> Otherwise it all looks fine to me.
>
> Thanks,
> -- Marco
> .

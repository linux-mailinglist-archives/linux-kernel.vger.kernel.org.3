Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61133462CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhK3GZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:25:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14995 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhK3GZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:25:46 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3Brx04qczZdN0;
        Tue, 30 Nov 2021 14:19:45 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:22:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:22:23 +0800
Message-ID: <17a7ad25-d61d-d23d-29a2-c66ed7db02cc@huawei.com>
Date:   Tue, 30 Nov 2021 14:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 2/4] mm: percpu: Add pcpu_fc_cpu_to_node_fn_t typedef
Content-Language: en-US
To:     Dennis Zhou <dennis@kernel.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <tj@kernel.org>,
        <gregkh@linuxfoundation.org>, <cl@linux.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <tsbogend@alpha.franken.de>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>
References: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
 <20211121093557.139034-3-wangkefeng.wang@huawei.com>
 <YaVW8ZNQMUnnoWEB@fedora>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YaVW8ZNQMUnnoWEB@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/30 6:40, Dennis Zhou wrote:
> On Sun, Nov 21, 2021 at 05:35:55PM +0800, Kefeng Wang wrote:
>> Add pcpu_fc_cpu_to_node_fn_t and pass it into pcpu_fc_alloc_fn_t,
>> pcpu first chunk allocation will call it to alloc memblock on the
>> corresponding node by it.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/mips/mm/init.c            | 12 +++++++++---
>>   arch/powerpc/kernel/setup_64.c | 14 +++++++++++---
>>   arch/sparc/kernel/smp_64.c     |  8 +++++---
>>   arch/x86/kernel/setup_percpu.c | 18 +++++++++++++-----
>>   drivers/base/arch_numa.c       |  8 +++++---
>>   include/linux/percpu.h         |  7 +++++--
>>   mm/percpu.c                    | 14 +++++++++-----
>>   7 files changed, 57 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
...
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>> index 6052f5d5ded3..9a5609c821df 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -771,6 +771,12 @@ void __init emergency_stack_init(void)
>>   }
>>   
>>   #ifdef CONFIG_SMP
>> +
>> +static __init int pcpu_cpu_to_node(int cpu)
>> +{
>> +	return IS_ENABLED(CONFIG_NUMA) ? early_cpu_to_node(cpu) : NUMA_NO_NODE;
>> +}
>> +
>>   /**
>>    * pcpu_alloc_bootmem - NUMA friendly alloc_bootmem wrapper for percpu
>>    * @cpu: cpu to allocate for
>> @@ -784,12 +790,12 @@ void __init emergency_stack_init(void)
>>    * RETURNS:
>>    * Pointer to the allocated area on success, NULL on failure.
>>    */
>> -static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
>> -					size_t align)
>> +static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size, size_t align,
>> +					pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
>>   {
>>   	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
>>   #ifdef CONFIG_NUMA
>> -	int node = early_cpu_to_node(cpu);
>> +	int node = cpu_to_nd_fun(cpu);
> ^ typo - cpu_to_nd_fn().

Will fix.

...

>>   	if (rc < 0)
>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>> index ae4004e7957e..41bb54715b0c 100644
>> --- a/include/linux/percpu.h
>> +++ b/include/linux/percpu.h
>> @@ -94,8 +94,9 @@ extern const char * const pcpu_fc_names[PCPU_FC_NR];
>>   
>>   extern enum pcpu_fc pcpu_chosen_fc;
>>   
>> -typedef void * (*pcpu_fc_alloc_fn_t)(unsigned int cpu, size_t size,
>> -				     size_t align);
>> +typedef int (pcpu_fc_cpu_to_node_fn_t)(int cpu);
>> +typedef void * (*pcpu_fc_alloc_fn_t)(unsigned int cpu, size_t size, size_t align,
>> +				     pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn);
>>   typedef void (*pcpu_fc_free_fn_t)(void *ptr, size_t size);
>>   typedef void (*pcpu_fc_populate_pte_fn_t)(unsigned long addr);
>>   typedef int (pcpu_fc_cpu_distance_fn_t)(unsigned int from, unsigned int to);
>> @@ -111,6 +112,7 @@ extern void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>>   extern int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>>   				size_t atom_size,
>>   				pcpu_fc_cpu_distance_fn_t cpu_distance_fn,
>> +				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
>>   				pcpu_fc_alloc_fn_t alloc_fn,
>>   				pcpu_fc_free_fn_t free_fn);
>>   #endif
>> @@ -119,6 +121,7 @@ extern int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>>   extern int __init pcpu_page_first_chunk(size_t reserved_size,
>>   				pcpu_fc_alloc_fn_t alloc_fn,
>>   				pcpu_fc_free_fn_t free_fn,
>> +				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
>>   				pcpu_fc_populate_pte_fn_t populate_pte_fn);
>>   #endif
> Be consistent here. In pcpu_setup_first_chunk() you add the
> cpu_to_node() before alloc()/free() and then in pcpu_embed_first_chunk()
> you add it after. I'd prefer to add it before as to keep the
> cpu_distance()/cpu_to_node() grouping.
Sure, will adjust the order.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74063462CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhK3Gpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:45:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31925 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhK3Gpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:45:41 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3CLt4BgzzcbkW;
        Tue, 30 Nov 2021 14:42:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:42:20 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:42:19 +0800
Message-ID: <b3253299-7381-b977-d19a-b76169d9c9a6@huawei.com>
Date:   Tue, 30 Nov 2021 14:42:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 4/4] mm: percpu: Add generic pcpu_populate_pte()
 function
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
 <20211121093557.139034-5-wangkefeng.wang@huawei.com>
 <YaVZB/Lcis4iQ3RY@fedora>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YaVZB/Lcis4iQ3RY@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/30 6:49, Dennis Zhou wrote:
> On Sun, Nov 21, 2021 at 05:35:57PM +0800, Kefeng Wang wrote:
>> When NEED_PER_CPU_PAGE_FIRST_CHUNK enabled, we need a function to
>> populate pte, add a generic pcpu populate pte function and switch
>> to use it.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/powerpc/kernel/setup_64.c | 47 +--------------------
>>   arch/sparc/kernel/smp_64.c     | 57 +------------------------
>>   arch/x86/kernel/setup_percpu.c |  5 +--
>>   drivers/base/arch_numa.c       | 51 +---------------------
>>   include/linux/percpu.h         |  5 +--
>>   mm/percpu.c                    | 77 +++++++++++++++++++++++++++++++---
>>   6 files changed, 79 insertions(+), 163 deletions(-)
>>
...
>> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
>> index cd672bd46241..4eadbe45078e 100644
>> --- a/arch/x86/kernel/setup_percpu.c
>> +++ b/arch/x86/kernel/setup_percpu.c
>> @@ -101,7 +101,7 @@ static int __init pcpu_cpu_to_node(int cpu)
>>   	return IS_ENABLED(CONFIG_NUMA) ? early_cpu_to_node(cpu) : NUMA_NO_NODE;
>>   }
>>   
>> -static void __init pcpup_populate_pte(unsigned long addr)
>> +void __init pcpu_populate_pte(unsigned long addr)
>>   {
>>   	populate_extra_pte(addr);
>>   }
>> @@ -163,8 +163,7 @@ void __init setup_per_cpu_areas(void)
>>   	}
>>   	if (rc < 0)
>>   		rc = pcpu_page_first_chunk(PERCPU_FIRST_CHUNK_RESERVE,
>> -					   pcpu_cpu_to_node,
>> -					   pcpup_populate_pte);
>> +					   pcpu_cpu_to_node);
> x86 has it's own implementation that differs for 32 bit. I'm not
> confident this is correct to drop in as a replacement for x86, so I'd
> prefer to keep populate_pte_fn() around.


The x86's pcpup_populate_pte() version is not dropped.

We define a __weak pcpu_populate_pte function in mm/percpu.c,

and there is a own version on x86,  so no function change on x86.

I will add this into changelog,

arch/x86/kernel/setup_percpu.c:  void __init pcpu_populate_pte(unsigned 
long addr)
include/linux/percpu.h:                 void __init 
pcpu_populate_pte(unsigned long addr);
mm/percpu.c:                                void __init __weak 
pcpu_populate_pte(unsigned long addr)
mm/percpu.c: pcpu_populate_pte(unit_addr + (i << PAGE_SHIFT));


>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>> index d73c97ef4ff4..f1ec5ad1351c 100644
>> --- a/include/linux/percpu.h
>> +++ b/include/linux/percpu.h
>> @@ -95,7 +95,6 @@ extern const char * const pcpu_fc_names[PCPU_FC_NR];
>>   extern enum pcpu_fc pcpu_chosen_fc;
>>   
>>   typedef int (pcpu_fc_cpu_to_node_fn_t)(int cpu);
>> -typedef void (*pcpu_fc_populate_pte_fn_t)(unsigned long addr);
>>   typedef int (pcpu_fc_cpu_distance_fn_t)(unsigned int from, unsigned int to);
>>   
>>   extern struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
>> @@ -113,9 +112,9 @@ extern int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>>   #endif
>>   
>>   #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
>> +void __init pcpu_populate_pte(unsigned long addr);
>>   extern int __init pcpu_page_first_chunk(size_t reserved_size,
>> -				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
>> -				pcpu_fc_populate_pte_fn_t populate_pte_fn);
>> +				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn);
>>   #endif
>>   
>>   extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align) __alloc_size(1);
>> diff --git a/mm/percpu.c b/mm/percpu.c
>> index efaa1cbaf73d..d907daed04eb 100644
>> --- a/mm/percpu.c
>> +++ b/mm/percpu.c
>> @@ -3162,11 +3162,80 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>>   #endif /* BUILD_EMBED_FIRST_CHUNK */
>>   
...
>> +void __init __weak pcpu_populate_pte(unsigned long addr)
>> +{
>> +	pgd_t *pgd = pgd_offset_k(addr);
>> +	p4d_t *p4d;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +
>> +	if (pgd_none(*pgd)) {
>> +		p4d_t *new;
>> +
>> +		new = memblock_alloc_from(P4D_TABLE_SIZE, P4D_TABLE_SIZE, PAGE_SIZE);
> It's unnecessary to specify a min_addr to memblock_alloc_from() as it
> won't allocate 0 anyway. So please use memblock_alloc() instead.

ok, will use memblock_alloc in this function


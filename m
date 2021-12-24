Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BE47E9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbhLXBEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:04:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33907 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350464AbhLXBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:04:00 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKpj13Hy2zcc8n;
        Fri, 24 Dec 2021 09:03:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 09:03:57 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 09:03:56 +0800
Subject: Re: [PATCH v18 15/17] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Pingfan Liu <kernelfans@gmail.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-16-thunder.leizhen@huawei.com>
 <e9f66aca-f399-bf79-3e01-91d419442788@oracle.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <de34f381-6165-7c30-b78d-e4b80479ca1d@huawei.com>
Date:   Fri, 24 Dec 2021 09:03:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e9f66aca-f399-bf79-3e01-91d419442788@oracle.com>
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



On 2021/12/23 23:48, Dave Kleikamp wrote:
> On 12/22/21 7:08AM, Zhen Lei wrote:
>> Currently, we parse the "linux,usable-memory-range" property in
>> early_init_dt_scan_chosen(), to obtain the specified memory range of the
>> crash kernel. We then reserve the required memory after
>> early_init_dt_scan_memory() has identified all available physical memory.
>> Because the two pieces of code are separated far, the readability and
>> maintainability are reduced. So bring them together.
> 
> Rob Herring is pushing a modified version of this patch (changes made by
> Pingfan Liu) to fix a regression. This will cause a conflict when it hits
> mainline.

Yes, I saw it yesterday, and I'll delete it in the next version. Thanks.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/linus
> 
> https://lore.kernel.org/linux-arm-kernel/20211214040157.27443-1-kernelfans@gmail.com/
> 
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>   drivers/of/fdt.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index bdca35284cebd56..37b477a51175359 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -965,8 +965,7 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>>            elfcorehdr_addr, elfcorehdr_size);
>>   }
>>   -static phys_addr_t cap_mem_addr;
>> -static phys_addr_t cap_mem_size;
>> +static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>>     /**
>>    * early_init_dt_check_for_usable_mem_range - Decode usable memory range
>> @@ -977,6 +976,11 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>>   {
>>       const __be32 *prop;
>>       int len;
>> +    phys_addr_t cap_mem_addr;
>> +    phys_addr_t cap_mem_size;
>> +
>> +    if ((long)node < 0)
>> +        return;
>>         pr_debug("Looking for usable-memory-range property... ");
>>   @@ -989,6 +993,8 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>>         pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
>>            &cap_mem_size);
>> +
>> +    memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>>   }
>>     #ifdef CONFIG_SERIAL_EARLYCON
>> @@ -1137,9 +1143,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>           (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
>>           return 0;
>>   +    chosen_node_offset = node;
>> +
>>       early_init_dt_check_for_initrd(node);
>>       early_init_dt_check_for_elfcorehdr(node);
>> -    early_init_dt_check_for_usable_mem_range(node);
>>         /* Retrieve command line */
>>       p = of_get_flat_dt_prop(node, "bootargs", &l);
>> @@ -1275,7 +1282,7 @@ void __init early_init_dt_scan_nodes(void)
>>       of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>>         /* Handle linux,usable-memory-range property */
>> -    memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>> +    early_init_dt_check_for_usable_mem_range(chosen_node_offset);
>>   }
>>     bool __init early_init_dt_scan(void *params)
> 
> .
> 

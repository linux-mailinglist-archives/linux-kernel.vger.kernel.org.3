Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F281E52CBE2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiESGYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiESGYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:24:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37127939EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:24:30 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3ftL0bBVz1JCCB;
        Thu, 19 May 2022 14:23:06 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 14:24:28 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 14:24:27 +0800
Message-ID: <06e86db8-0797-1610-48e3-c607cfacf8f7@huawei.com>
Date:   Thu, 19 May 2022 14:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 3/5] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <20220429103225.75121-4-wangkefeng.wang@huawei.com>
 <871657f3-9c26-a56a-03d2-29b1915001c9@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <871657f3-9c26-a56a-03d2-29b1915001c9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/19 12:46, Anshuman Khandual wrote:
> Hi Kefeng,
>
> On 4/29/22 16:02, Kefeng Wang wrote:
>> Add special hook for architecture to verify addr, size and prot
>> or setup when ioremap() or iounmap(), which will make the generic
>> ioremap more useful.
>>
>>    arch_ioremap() return a 'void __iomem *',
>>      - IS_ERR means return an error
>>      - NULL means continue to remap
>>      - a non-NULL, non-IS_ERR pointer is directly returned
>>    arch_iounmap() return a int value,
>>      - 0 means continue to vunmap
>>      - error code means skip vunmap and return directly
> Should not these comments be also included as in-code documentation, possibly
> near generic fall back stubs for arch_ioremap()/arch_iounmap() in the header
> include/asm-generic/io.h ?
Ok, I will add some document in io.h
>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/asm-generic/io.h | 14 ++++++++++++++
>>   mm/ioremap.c             | 14 +++++++++++++-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>> index e6ffa2519f08..f2f9aeedb5e8 100644
>> --- a/include/asm-generic/io.h
>> +++ b/arch_iounmap
>> @@ -964,6 +964,20 @@ static inline void iounmap(volatile void __iomem *addr)
>>   #elif defined(CONFIG_GENERIC_IOREMAP)
>>   #include <linux/pgtable.h>
>>   
>> +#ifndef arch_ioremap
>> +static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>> +
>> +#ifndef arch_iounmap
>> +static inline int arch_iounmap(void __iomem *addr)
>> +{
>> +	return 0;
>> +}
>> +#endif
> There is a function in arch/arm/ with exact same name although the platform does
> not enable GENERIC_IOREMAP. That function would require renaming for these arch
> callbacks to be added here in GENERIC_IOREMAP path. Otherwise, it might be just
> confusing later.
>
> git grep "arch_iounmap" arch/arm/
>
> arch/arm/include/asm/io.h:extern void (*arch_iounmap)(volatile void __iomem *);
> arch/arm/mm/ioremap.c:void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
> arch/arm/mm/ioremap.c:  arch_iounmap(cookie);
> arch/arm/mm/nommu.c:void (*arch_iounmap)(volatile void __iomem *);

After

   59d3ae9a5bf60 ("ARM: remove Intel iop33x and iop13xx support") v5.4
   3e3f354bc383a ("ARM: remove ebsa110 platform") v5.11

arch_iounmap is useless, we could directly kill arch_iounmap/__iounmap 
on arm,

will add new cleanup patch in v3.


>
>> +
>>   void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
>>   void iounmap(volatile void __iomem *addr);
>>   
>> diff --git a/mm/ioremap.c b/mm/ioremap.c
>> index 7cb9996b0c12..de5a2e899e14 100644
>> --- a/mm/ioremap.c
>> +++ b/mm/ioremap.c
>> @@ -16,6 +16,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
>>   	unsigned long offset, vaddr;
>>   	phys_addr_t last_addr;
>>   	struct vm_struct *area;
>> +	void __iomem *base;
>>   
>>   	/* Disallow wrap-around or zero size */
>>   	last_addr = phys_addr + size - 1;
>> @@ -27,6 +28,12 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
>>   	phys_addr -= offset;
>>   	size = PAGE_ALIGN(size + offset);
>>   
>> +	base = arch_ioremap(phys_addr, size, prot);
>> +	if (IS_ERR(base))
>> +		return NULL;
>> +	else if (base)
>> +		return base;
>> +
>>   	area = get_vm_area_caller(size, VM_IOREMAP,
>>   			__builtin_return_address(0));
>>   	if (!area)
>> @@ -45,6 +52,11 @@ EXPORT_SYMBOL(ioremap_prot);
>>   
>>   void iounmap(volatile void __iomem *addr)
>>   {
>> -	vunmap((void *)((unsigned long)addr & PAGE_MASK));
>> +	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
> Should not this variable be 'void __iomem *vaddr' instead, like above in
> ioremap_prot(). Because arch_iounmap() takes 'void __iomem *' instead.

Will do, thanks.

>> +
>> +	if (arch_iounmap(vaddr))
>> +		return;
>> +
>> +	vunmap(vaddr);
>>   }
>>   EXPORT_SYMBOL(iounmap);
> - Anshuman
> .

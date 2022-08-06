Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F098158B36A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiHFC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHFC3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 22:29:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA02286F9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 19:29:07 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M05vX5qM9zmVJS;
        Sat,  6 Aug 2022 10:27:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 10:29:04 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 10:29:04 +0800
Message-ID: <832b38ca-064e-0ab8-cd62-337d0d83d471@huawei.com>
Date:   Sat, 6 Aug 2022 10:29:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed
Content-Language: en-US
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <hch@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-2-bhe@redhat.com>
 <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/4 23:42, Alexander Gordeev wrote:
> On Mon, Aug 01, 2022 at 10:40:19PM +0800, Baoquan He wrote:
>
> Hi Baoquan,
>
>> --- a/arch/arm64/mm/ioremap.c
>> +++ b/arch/arm64/mm/ioremap.c
>> @@ -3,19 +3,20 @@
>>   #include <linux/mm.h>
>>   #include <linux/io.h>
>>   
>> -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
>> +void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
>>   {
>>   	unsigned long last_addr = phys_addr + size - 1;
>> +	int ret = -EINVAL;
> If ret variable is really needed?
>
>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>> index 72974cb81343..d72eb310fb3c 100644
>> --- a/include/asm-generic/io.h
>> +++ b/include/asm-generic/io.h
>> @@ -967,26 +967,27 @@ static inline void iounmap(volatile void __iomem *addr)
>>   /*
>>    * Arch code can implement the following two hooks when using GENERIC_IOREMAP
>>    * ioremap_allowed() return a bool,
>> - *   - true means continue to remap
>> - *   - false means skip remap and return directly
>> + *   - IS_ERR means return an error
>> + *   - NULL means continue to remap
>> + *   - a non-NULL, non-IS_ERR pointer is returned directly
> If ioremap_allowed() returns a valid pointer, then the function name
> is not as precise anymore.

Maybe use arch_ioremap/unmap as before, or some better name.

>
>> @@ -28,8 +29,11 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>>   	phys_addr -= offset;
>>   	size = PAGE_ALIGN(size + offset);
>>   
>> -	if (!ioremap_allowed(phys_addr, size, prot))
>> +	base = ioremap_allowed(phys_addr, size, prot);
>> +	if (IS_ERR(base))
>>   		return NULL;
>> +	else if (base)
>> +		return base;
> It is probably just me, but the base name bit misleading here.
We could reuse vaddr, not add new base.
>
>> @@ -50,9 +54,9 @@ EXPORT_SYMBOL(ioremap_prot);
>>   
>>   void iounmap(volatile void __iomem *addr)
>>   {
>> -	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
>> +	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
>>   
>> -	if (!iounmap_allowed(vaddr))
>> +	if (iounmap_allowed(vaddr))
> I guess, iounmap_allowed() should accept void __iomem *, not void *.
> Then addr needs to be passed to iounmap_allowed() not vaddr.

The following is_vmalloc_addr()  and vunmap() in iounmap() use void *,

so we could simply use void* for iounmap_allowed().

>
>>   		return;
> .

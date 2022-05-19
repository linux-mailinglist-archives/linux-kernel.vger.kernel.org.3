Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C912352CBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiESGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiESGbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:31:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D818E15
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:31:08 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L3fxv2s3yzCshV;
        Thu, 19 May 2022 14:26:11 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 14:31:07 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 14:31:06 +0800
Message-ID: <741f1974-e357-728b-88b9-bce3ff82d91f@huawei.com>
Date:   Thu, 19 May 2022 14:31:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 resend 4/5] arm64: mm: Convert to GENERIC_IOREMAP
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>
References: <20220429103225.75121-5-wangkefeng.wang@huawei.com>
 <20220502032751.21503-1-wangkefeng.wang@huawei.com>
 <25a90892-957c-e5b4-e121-948e85d3caee@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <25a90892-957c-e5b4-e121-948e85d3caee@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/5/19 13:34, Anshuman Khandual wrote:
>
> On 5/2/22 08:57, Kefeng Wang wrote:
>> Add hook for arm64's special operation when ioremap() and iounmap(),
>> then ioremap_wc/np/cache is converted to use ioremap_prot()
>> from GENERIC_IOREMAP, update the Copyright and kill the unused
>> inclusions.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v2 resend:
>> - use IOMEM_ERR_PTR to fix sparse warning found by lkp
>>
>>   arch/arm64/Kconfig          |  1 +
>>   arch/arm64/include/asm/io.h | 20 ++++++---
>>   arch/arm64/kernel/acpi.c    |  2 +-
>>   arch/arm64/mm/ioremap.c     | 85 +++++--------------------------------
>>   4 files changed, 27 insertions(+), 81 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 20ea89d9ac2f..56673209fdb9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -123,6 +123,7 @@ config ARM64
>>   	select GENERIC_CPU_VULNERABILITIES
>>   	select GENERIC_EARLY_IOREMAP
>>   	select GENERIC_IDLE_POLL_SETUP
>> +	select GENERIC_IOREMAP
>>   	select GENERIC_IRQ_IPI
>>   	select GENERIC_IRQ_PROBE
>>   	select GENERIC_IRQ_SHOW
>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 7fd836bea7eb..042fa01940b8 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
>> @@ -163,13 +163,21 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>>   /*
>>    * I/O memory mapping functions.
>>    */
>> -extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot);
>> -extern void iounmap(volatile void __iomem *addr);
>> -extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>>   
>> -#define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
>> -#define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
>> -#define ioremap_np(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
>> +void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
>> +#define arch_ioremap arch_ioremap
>> +
>> +int arch_iounmap(void __iomem *addr);
>> +#define arch_iounmap arch_iounmap
>> +
>> +#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
> Small nit, should we have a comment here for the above components i.e
> PAGE_IOREMAP and callbacks arch_ioremap()/arch_iounmap() are required
> because of enabling GENERIC_IOREMAP ?

There is a comment in  include/asm-generic/io.h:       /* _PAGE_IOREMAP 
needs to be supplied by the architecture */

so arch's callbacks could not add repeated comments.


> Otherwise LGTM.
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Thanks.
> .

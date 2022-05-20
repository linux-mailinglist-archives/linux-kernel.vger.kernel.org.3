Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F152E1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbiETBXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbiETBW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:22:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0162EA36
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:22:27 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L487L0n8Pz1JCFf;
        Fri, 20 May 2022 09:21:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 09:22:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 09:22:24 +0800
Message-ID: <c647a1b0-5cd8-0a61-10de-f95ff2820f60@huawei.com>
Date:   Fri, 20 May 2022 09:22:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <hch@infradead.org>, <arnd@arndb.de>, <anshuman.khandual@arm.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <20220519115210.a6e41d5a997921354400557e@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220519115210.a6e41d5a997921354400557e@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/5/20 2:52, Andrew Morton wrote:
> On Thu, 19 May 2022 16:25:50 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Add special hook for architecture to verify or setup addr, size
>> or prot when ioremap() or iounmap(), which will make the generic
>> ioremap more useful.
>>
>>    arch_ioremap() return a pointer,
>>      - IS_ERR means return an error
>>      - NULL means continue to remap
>>      - a non-NULL, non-IS_ERR pointer is directly returned
>>    arch_iounmap() return a int value,
>>      - 0 means continue to vunmap
>>      - error code means skip vunmap and return directly
>>
>> ...
>>
>> --- a/include/asm-generic/io.h
>> +++ b/include/asm-generic/io.h
>> @@ -964,6 +964,30 @@ static inline void iounmap(volatile void __iomem *addr)
>>   #elif defined(CONFIG_GENERIC_IOREMAP)
>>   #include <linux/pgtable.h>
>>   
>> +/*
>> + * Arch code can implement the following two special hooks when using GENERIC_IOREMAP
>> + * arch_ioremap() return a pointer,
>> + *   - IS_ERR means return an error
>> + *   - NULL means continue to remap
>> + *   - a non-NULL, non-IS_ERR pointer is returned directly
>> + * arch_iounmap() return a int,
>> + *   - 0 means continue to vunmap
>> + *   - error code means skip vunmap and return directly
>> + */
>> +#ifndef arch_ioremap
>> +static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
>> +{
>> +	return NULL;
>> +}
> Maybe should do
>
> 	#define arch_ioremap arch_ioremap
>
> here
>
>> +#endif
>> +
>> +#ifndef arch_iounmap
>> +static inline int arch_iounmap(void __iomem *addr)
>> +{
>> +	return 0;
>> +}
> and here.
>
> It shouldn't matter a lot because this file has inclusion guards.
> However it seems tidier and perhaps other code will want to know
> whether this was defined.  Dunno.
>
Oh, forget to add the define part, thanks Andrew.

Hi Catalin, could you help to involve them when taking them, many thanks.

> Otherwise,
>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>
> Please take this patch and [2/6] and [3/6] via the appropriate arm tree.
>
> .

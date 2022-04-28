Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF1512B54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbiD1GUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243570AbiD1GT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:19:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093143914C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:16:44 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KplkN3hXVzhYn3;
        Thu, 28 Apr 2022 14:16:28 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 14:16:40 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 14:16:39 +0800
Message-ID: <8d5c41a6-0478-bd5c-a37b-06a37101fc31@huawei.com>
Date:   Thu, 28 Apr 2022 14:16:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-3-wangkefeng.wang@huawei.com>
 <20220427100411.8eaf54c51767c3e2b0b070a5@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220427100411.8eaf54c51767c3e2b0b070a5@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/28 1:04, Andrew Morton wrote:
> On Wed, 27 Apr 2022 20:14:11 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Add special check hook for architecture to verify addr, size
>> or prot when ioremap() or iounmap(), which will make the generic
>> ioremap more useful.
>>
>> ...
>>
>> --- a/include/asm-generic/io.h
>> +++ b/include/asm-generic/io.h
>> @@ -964,6 +964,9 @@ static inline void iounmap(volatile void __iomem *addr)
>>   #elif defined(CONFIG_GENERIC_IOREMAP)
>>   #include <linux/pgtable.h>
>>   
>> +bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
>> +bool arch_iounmap_check(void __iomem *addr);
> Pet peeve.  The word "check" is a poor one.  I gives no sense of what
> the function is checking and it gives no sense of how the function's
> return value relates to the thing which it checks.
>
> Maybe it returns 0 on success and -EINVAL on failure.  Don't know!
>
> Don't you think that better names would be io_remap_ok(),
> io_remap_valid(), io_remap_allowed(), etc?

Will use arch_ioremap/unmap_allowed(), and I'd like to keep return bool

for now if there is no special requirements.

>
>
> Other than that,
>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
Thanks.
> .

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9008C5128FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiD1Bny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiD1Bnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:43:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937D5FE9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:40:39 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kpdb32GSvz1JBbH;
        Thu, 28 Apr 2022 09:39:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:40:38 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:40:37 +0800
Message-ID: <09b7afdf-fb5c-486d-cc95-e1c9c0994cbb@huawei.com>
Date:   Thu, 28 Apr 2022 09:40:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/4] mm: ioremap: Setup phys_addr of struct vm_struct
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-2-wangkefeng.wang@huawei.com>
 <20220427101040.bd4532c8ef093b47b3dd9eb5@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220427101040.bd4532c8ef093b47b3dd9eb5@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/4/28 1:10, Andrew Morton wrote:
> On Wed, 27 Apr 2022 20:14:10 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Show physical address in /proc/vmallocinfo.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/ioremap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/ioremap.c b/mm/ioremap.c
>> index 5fe598ecd9b7..522ef899c35f 100644
>> --- a/mm/ioremap.c
>> +++ b/mm/ioremap.c
>> @@ -32,6 +32,7 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
>>   	if (!area)
>>   		return NULL;
>>   	vaddr = (unsigned long)area->addr;
>> +	area->phys_addr = addr;
>>   
>>   	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
>>   		free_vm_area(area);
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>
> I checked a bunch of arch-specific implementations of ioremap_prot()
> and they're already doing this.  As far as I can tell, only csky and
> riscv actually use this file (CONFIG_GENERIC_IOREMAP=y).  But you're
> ARM(?) so I'm wondering how come you're patching it?

Hi Andrew,

I found this via reading code when debug some other issue, meanwhile,  there

are some code duplication of ioremap between arm64 and generic ioremap, so

1) bugfix: fix the above issue and test on riscv

2) cleanup: convert arm64 to use GENERIC_IOREMAP,

3) feature: after that, enable HAVE_IOREMAP_PROT on arm64

>
> Someone should do s/addr/phys_addr/ in this function, like the rest of
> the world (sensibly) does.
I will make it in next version.
>
>
> .

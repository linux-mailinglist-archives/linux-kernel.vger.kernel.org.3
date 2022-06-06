Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971AD53E787
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiFFN2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiFFN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:28:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CAB522E3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:28:27 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LGvP44XlpzRhjD;
        Mon,  6 Jun 2022 21:25:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:28:23 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:28:22 +0800
Message-ID: <7a8f19b5-f22e-83be-0f9a-63cef6152812@huawei.com>
Date:   Mon, 6 Jun 2022 21:28:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 5/6] arm64: mm: Convert to GENERIC_IOREMAP
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <arnd@arndb.de>, <anshuman.khandual@arm.com>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-6-wangkefeng.wang@huawei.com>
 <Yp2yoRkHLuONDO9y@infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yp2yoRkHLuONDO9y@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/6 15:54, Christoph Hellwig wrote:
>> +#define ioremap_wc(addr, size)		ioremap_prot((addr), (size), PROT_NORMAL_NC)
>> +#define ioremap_np(addr, size)		ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
> Please avoid the overly long lines here.  Independt of that having
> a non-trivial body on a separate line tends to generlly be a lot more
> readable anyway.

Hi Christoph，

As commit bdc48fa11e46  ("checkpatch/coding-style: deprecate 80-column 
warning") increased

the limit to 100 columns，so I don't get warning when using checkpatch, 
and it is not a hard limit,

but if this is a mandatory requirement, I will resend them with break lines.

>> +#define ioremap_cache(addr, size) ({							\
>> +	pfn_is_map_memory(__phys_to_pfn(addr)) ?					\
>> +	(void __iomem *)__phys_to_virt(addr) : ioremap_prot(addr, size, PROT_NORMAL);	\
>> +})
> And this really should be an inline function.

We still need a define, see kernel/iomem.c,

#ifndef ioremap_cache
__weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long 
size)
{
         return ioremap(offset, size);
}
#endif

>
>> +int iounmap_allowed(void __iomem *addr)
>>   {
>>   	/*
>>   	 * We could get an address outside vmalloc range in case
>>   	 * of ioremap_cache() reusing a RAM mapping.
>>   	 */
>> +	return is_vmalloc_addr(addr) ? 0 : -EINVAL;
> As the generic ioremap only returns vmalloc addresses, this check
> really should go into common code.

Good point, will move into generic ioremap, thanks.

> .

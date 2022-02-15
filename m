Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F84B611D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiBOCkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:40:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBOCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:40:14 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB3C10AEE1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:40:05 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JyQG51HZfz8wZv;
        Tue, 15 Feb 2022 10:36:45 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 10:40:02 +0800
Subject: Re: [PATCH 2/8] mm/memory-failure.c: avoid walking page table when
 vma_address() return -EFAULT
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-3-linmiaohe@huawei.com> <20220214144826.GB2624914@u2004>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1c464c41-81f4-fff9-c4e0-45fd4d05e34b@huawei.com>
Date:   Tue, 15 Feb 2022 10:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214144826.GB2624914@u2004>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/14 22:48, Naoya Horiguchi wrote:
> On Thu, Feb 10, 2022 at 10:17:27PM +0800, Miaohe Lin wrote:
>> It's unnecessary to walk the page table when vma_address() return -EFAULT.
>> Return early if so to save some cpu cycles.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Many thanks for your review and Acked-by tag!

> 
> Does this patch fix the real problem rather than just saving cpu cycles?
> Without this patch, "address == -EFAULT" seems to make pgd_offset() return
> invalid pointer and result in some serious result like general protection fault.

I think you're right. We might dereference the invalid pointer in the following pagetable
walk and results in general protection fault.

> If that's the case, this patch might be worth sending to stable.

But I'am not sure vma_address will return -EFAULT for dax pages in the real workload? If so, I will
send a v2 with Fixes tag.

Thanks again.

> 
> Thanks,
> Naoya Horiguchi
> 
>> ---
>>  mm/memory-failure.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index b3ff7e99a421..f86819145ea8 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -315,6 +315,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>>  	pmd_t *pmd;
>>  	pte_t *pte;
>>
>> +	if (address == -EFAULT)
>> +		return 0;
>>  	pgd = pgd_offset(vma->vm_mm, address);
>>  	if (!pgd_present(*pgd))
>>  		return 0;
>> ---
>> 2.23.0
>>
> .
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1C4D5B96
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbiCKG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiCKG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:27:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7451A8C9B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:26:33 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KFG6W66kjzcb4G;
        Fri, 11 Mar 2022 14:21:39 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 14:26:31 +0800
Subject: Re: [PATCH] mm/huge_memory: remove unneeded local variable follflags
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220310131253.30970-1-linmiaohe@huawei.com>
 <90246c21-94e9-e64e-dd83-fce45de89f72@arm.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <15d17cb9-6eae-0345-8e67-da30a5978300@huawei.com>
Date:   Fri, 11 Mar 2022 14:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <90246c21-94e9-e64e-dd83-fce45de89f72@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/11 12:51, Anshuman Khandual wrote:
> Hi Miaohe,
> 
> On 3/10/22 18:42, Miaohe Lin wrote:
>> We can pass FOLL_GET | FOLL_DUMP to follow_page directly to simplify
>> the code a bit.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 3557aabe86fe..418d077da246 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2838,7 +2838,6 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>  	 */
>>  	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
>>  		struct vm_area_struct *vma = find_vma(mm, addr);
>> -		unsigned int follflags;
>>  		struct page *page;
>>  
>>  		if (!vma || addr < vma->vm_start)
>> @@ -2851,8 +2850,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>  		}
>>  
>>  		/* FOLL_DUMP to ignore special (like zero) pages */
>> -		follflags = FOLL_GET | FOLL_DUMP;
>> -		page = follow_page(vma, addr, follflags);
>> +		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>>  
>>  		if (IS_ERR(page))
>>  			continue;
> 
> LGTM, but there is another similar instance in add_page_for_migration()
> inside mm/migrate.c, requiring this exact clean up.
> 

Thanks for comment. That similar case is done in my previous patch series[1]
aimed at migration cleanup and fixup. It might be more suitable to do that
clean up in that specialized series?

[1]:https://lore.kernel.org/linux-mm/20220304093409.25829-4-linmiaohe@huawei.com/

> Hence with that change in place.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks again.

> .
> 


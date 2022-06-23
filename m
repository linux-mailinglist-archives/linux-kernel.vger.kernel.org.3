Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACA557A04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiFWMJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiFWMI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:08:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5C4B1FC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:08:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTJs66bLJzkWLt;
        Thu, 23 Jun 2022 20:07:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 20:08:49 +0800
Subject: Re: [PATCH 04/16] mm/huge_memory: use helper touch_pud in
 huge_pud_set_accessed
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <willy@infradead.org>, <zokeefe@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-5-linmiaohe@huawei.com>
 <YrQLY7WzgXPM/LqJ@FVFYT0MHHV2J.usts.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <80a029bc-3613-1150-cbd3-134d340b3973@huawei.com>
Date:   Thu, 23 Jun 2022 20:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrQLY7WzgXPM/LqJ@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/6/23 14:42, Muchun Song wrote:
> On Thu, Jun 23, 2022 at 01:06:15AM +0800, Miaohe Lin wrote:
>> Use helper touch_pud to set pud accessed to simplify the code and improve
>> the readability. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a26580da8011..a0c0e4bf9c1e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1281,21 +1281,15 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  
>>  void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>>  {
>> -	pud_t entry;
>> -	unsigned long haddr;
>> -	bool write = vmf->flags & FAULT_FLAG_WRITE;
>> +	int flags = 0;
>>  
>>  	vmf->ptl = pud_lock(vmf->vma->vm_mm, vmf->pud);
>>  	if (unlikely(!pud_same(*vmf->pud, orig_pud)))
>>  		goto unlock;
>>  
>> -	entry = pud_mkyoung(orig_pud);
>> -	if (write)
>> -		entry = pud_mkdirty(entry);
>> -	haddr = vmf->address & HPAGE_PUD_MASK;
>> -	if (pudp_set_access_flags(vmf->vma, haddr, vmf->pud, entry, write))
>> -		update_mmu_cache_pud(vmf->vma, vmf->address, vmf->pud);
>> -
>> +	if (vmf->flags & FAULT_FLAG_WRITE)
>> +		flags = FOLL_WRITE;
> 
> FOLL_* flags are used for follow_page(). But huge_pud_set_accessed() is used in mm fault
> path. It is a little weird to me to use FOLL_WRITE here. I suggest replace the last
> parameter of touch_pud() to "bool writable", then passing "vmf->flags & FAULT_FLAG_WRITE"
> to it instead of converting from FAULT_FLAG* flag to FOLL* flag.

Sounds good. Thanks!

> 
> Thanks.
> 
>> +	touch_pud(vmf->vma, vmf->address, vmf->pud, flags);
>>  unlock:
>>  	spin_unlock(vmf->ptl);
>>  }
>> -- 
>> 2.23.0
>>
>>
> .
> 


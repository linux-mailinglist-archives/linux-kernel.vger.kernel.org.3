Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7F55F34E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiF2CRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiF2CRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:17:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B870117AA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 19:17:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXlTJ4yGDz9stC;
        Wed, 29 Jun 2022 10:16:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 10:17:32 +0800
Subject: Re: [PATCH v2 04/16] mm/huge_memory: use helper touch_pud in
 huge_pud_set_accessed
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <willy@infradead.org>, <zokeefe@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
 <20220628132835.8925-5-linmiaohe@huawei.com>
 <YrsXTMKqXcuMzRpF@FVFYT0MHHV2J.googleapis.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <086bac6c-3c99-0667-d301-2839122b89bf@huawei.com>
Date:   Wed, 29 Jun 2022 10:17:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrsXTMKqXcuMzRpF@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/6/28 22:59, Muchun Song wrote:
> On Tue, Jun 28, 2022 at 09:28:23PM +0800, Miaohe Lin wrote:
>> Use helper touch_pud to set pud accessed to simplify the code and improve
>> the readability. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f7164ef8b6e3..d55d5efa06c8 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1284,15 +1284,15 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  
>>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>  static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>> -		pud_t *pud, int flags)
>> +		      pud_t *pud, bool write)
> 
> You have change the last parameter. Have you forgotten to update its user
> of follow_devmap_pud()?

My bad. I was overloaded yesterday. Thanks for catching this!
Will change it in next version.

> 
> Thanks.
> 
>>  {
>>  	pud_t _pud;
>>  
>>  	_pud = pud_mkyoung(*pud);
>> -	if (flags & FOLL_WRITE)
>> +	if (write)
>>  		_pud = pud_mkdirty(_pud);
>>  	if (pudp_set_access_flags(vma, addr & HPAGE_PUD_MASK,
>> -				pud, _pud, flags & FOLL_WRITE))
>> +				  pud, _pud, write))
>>  		update_mmu_cache_pud(vma, addr, pud);
>>  }
>>  
>> @@ -1384,21 +1384,13 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  
>>  void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>>  {
>> -	pud_t entry;
>> -	unsigned long haddr;
>>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
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
>> +	touch_pud(vmf->vma, vmf->address, vmf->pud, write);
>>  unlock:
>>  	spin_unlock(vmf->ptl);
>>  }
>> -- 
>> 2.23.0
>>
>>
> .
> 


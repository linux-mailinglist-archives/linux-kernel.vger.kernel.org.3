Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2250A139
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387605AbiDUNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384863AbiDUNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:53:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804413CF7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:50:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kkf6m2QR4zdZPG;
        Thu, 21 Apr 2022 21:49:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 21:50:38 +0800
Subject: Re: [PATCH v2 2/3] mm/swapfile: Fix lost swap bits in unuse_pte()
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <peterx@redhat.com>, <sfr@canb.auug.org.au>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220421125348.62483-1-linmiaohe@huawei.com>
 <20220421125348.62483-3-linmiaohe@huawei.com>
 <67fc9368-0876-b931-14c2-ffa4dac35b6d@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <58980370-f1b6-afa9-9abb-1335bf369155@huawei.com>
Date:   Thu, 21 Apr 2022 21:50:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <67fc9368-0876-b931-14c2-ffa4dac35b6d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/21 21:13, David Hildenbrand wrote:
> On 21.04.22 14:53, Miaohe Lin wrote:
>> This is observed by code review only but not any real report.
>>
>> When we turn off swapping we could have lost the bits stored in the swap
>> ptes. The new rmap-exclusive bit is fine since that turned into a page
>> flag, but not for soft-dirty and uffd-wp. Add them.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swapfile.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 95b63f69f388..332ccfc76142 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1783,7 +1783,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  {
>>  	struct page *swapcache;
>>  	spinlock_t *ptl;
>> -	pte_t *pte;
>> +	pte_t *pte, new_pte;
>>  	int ret = 1;
>>  
>>  	swapcache = page;
>> @@ -1832,8 +1832,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  		page_add_new_anon_rmap(page, vma, addr);
>>  		lru_cache_add_inactive_or_unevictable(page, vma);
>>  	}
>> -	set_pte_at(vma->vm_mm, addr, pte,
>> -		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
>> +	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
>> +	if (pte_swp_soft_dirty(*pte))
>> +		new_pte = pte_mksoft_dirty(new_pte);
>> +	if (pte_swp_uffd_wp(*pte)) {
>> +		new_pte = pte_mkuffd_wp(new_pte);
>> +		new_pte = pte_wrprotect(new_pte);
> 
> The wrprotect shouldn't be necessary, we don't do a pte_mkwrite(). Note
> that in do_swap_page() we might have done a
> maybe_mkwrite(pte_mkdirty(pte)), which is why the pte_wrprotect() is
> required there.

You're so smart. I happened to be referring to the code in do_swap_page. ;)
Now I see why pte_wrprotect() is only required there. Will remove it in the
next verison when there is enough feedback. Many thanks!

> 


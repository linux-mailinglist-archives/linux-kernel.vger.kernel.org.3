Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2454FF3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiDMJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiDMJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:41:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D984D546BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:39:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kdctt2xVrzgYgD;
        Wed, 13 Apr 2022 17:37:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 17:38:59 +0800
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
To:     David Hildenbrand <david@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-2-david@redhat.com>
 <28142e3e-2556-0ca2-7ac5-7420ef862259@huawei.com>
 <374d2be1-e13d-e605-ff80-b9d5eee4c40e@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3b9c6cc6-c5f5-8a8d-0b0f-9ca903cfab20@huawei.com>
Date:   Wed, 13 Apr 2022 17:38:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <374d2be1-e13d-e605-ff80-b9d5eee4c40e@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/13 17:30, David Hildenbrand wrote:
> On 13.04.22 10:58, Miaohe Lin wrote:
>> On 2022/3/30 0:43, David Hildenbrand wrote:
>>> Currently, we clear PG_anon_exclusive in try_to_unmap() and forget about
>> ...
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 14618f446139..9060cc7f2123 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -792,6 +792,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>  						&src_mm->mmlist);
>>>  			spin_unlock(&mmlist_lock);
>>>  		}
>>> +		/* Mark the swap entry as shared. */
>>> +		if (pte_swp_exclusive(*src_pte)) {
>>> +			pte = pte_swp_clear_exclusive(*src_pte);
>>> +			set_pte_at(src_mm, addr, src_pte, pte);
>>> +		}
>>>  		rss[MM_SWAPENTS]++;
>>>  	} else if (is_migration_entry(entry)) {
>>>  		page = pfn_swap_entry_to_page(entry);
>>> @@ -3559,6 +3564,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>  	struct page *page = NULL, *swapcache;
>>>  	struct swap_info_struct *si = NULL;
>>>  	rmap_t rmap_flags = RMAP_NONE;
>>> +	bool exclusive = false;
>>>  	swp_entry_t entry;
>>>  	pte_t pte;
>>>  	int locked;
>>> @@ -3724,6 +3730,46 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>>>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
>>>  
>>> +	/*
>>> +	 * Check under PT lock (to protect against concurrent fork() sharing
>>> +	 * the swap entry concurrently) for certainly exclusive pages.
>>> +	 */
>>> +	if (!PageKsm(page)) {
>>> +		/*
>>> +		 * Note that pte_swp_exclusive() == false for architectures
>>> +		 * without __HAVE_ARCH_PTE_SWP_EXCLUSIVE.
>>> +		 */
>>> +		exclusive = pte_swp_exclusive(vmf->orig_pte);
>>> +		if (page != swapcache) {
>>> +			/*
>>> +			 * We have a fresh page that is not exposed to the
>>> +			 * swapcache -> certainly exclusive.
>>> +			 */
>>> +			exclusive = true;
>>> +		} else if (exclusive && PageWriteback(page) &&
>>> +			   !(swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
>>
>> Really sorry for late respond and a newbie question. IIUC, if SWP_STABLE_WRITES is set,
>> it means concurrent page modifications while under writeback is not supported. For these
>> problematic swap backends, exclusive marker is dropped. So the above if statement is to
>> filter out these problematic swap backends which have SWP_STABLE_WRITES set. If so, the
>> above check should be && (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)), i.e. no "!".
>> Or am I miss something?
> 
> Oh, thanks for your careful eyes!
> 
> Indeed, SWP_STABLE_WRITES indicates that the backend *requires* stable
> writes, meaning, we must not modify the page while writeback is active.
> 
> So if and only if that is set, we must drop the exclusive marker.
> 
> This essentially corresponds to previous reuse_swap_page() logic:
> 
> bool reuse_swap_page(struct page *page)
> {
> ...
> 	if (!PageWriteback(page)) {
> 		...
> 	} else {
> 		...
> 		if (p->flags & SWP_STABLE_WRITES) {
> 			spin_unlock(&p->lock);
> 			return false;
> 		}
> ...
> }
> 
> Fortunately, this only affects such backends. For backends without
> SWP_STABLE_WRITES, the current code is simply sub-optimal.
> 
> 
> So yes, this has to be
> 
> } else if (exclusive && PageWriteback(page) &&
> 	   (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
> 

I am glad that my question helps. :)

> 
> Let me try finding a way to test this, the tests I was running so far
> were apparently not using a backend with SWP_STABLE_WRITES.
> 

That will be really helpful. Many thanks for your hard work!

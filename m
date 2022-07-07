Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B65698C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiGGDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiGGDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:22:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614030F58
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:22:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LdhVj4C2WzhZ5c;
        Thu,  7 Jul 2022 11:20:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 11:22:39 +0800
Subject: Re: [mm-unstable PATCH v4 4/9] mm, hwpoison, hugetlb: support saving
 mechanism of raw error pages
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-5-naoya.horiguchi@linux.dev>
 <3b6bdbbc-289c-4d38-5728-ed3efcde25d8@huawei.com>
 <20220706230615.GA2560241@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0391bde6-c33b-4b81-b348-5dbd0cc30b57@huawei.com>
Date:   Thu, 7 Jul 2022 11:22:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220706230615.GA2560241@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2022/7/7 7:06, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Jul 06, 2022 at 10:37:50AM +0800, Miaohe Lin wrote:
>> On 2022/7/4 9:33, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> When handling memory error on a hugetlb page, the error handler tries to
>>> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
>>> PageHWPoison flag is moved to the raw error page, so that's all right.
>>> However, dissolve sometimes fails, then the error page is left as
>>> hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
>>> healthy pages, but that's not possible now because the information about
>>> where the raw error pages is lost.
>>>
>>> Use the private field of a few tail pages to keep that information.  The
>>> code path of shrinking hugepage pool uses this info to try delayed dissolve.
>>> In order to remember multiple errors in a hugepage, a singly-linked list
>>> originated from SUBPAGE_INDEX_HWPOISON-th tail page is constructed.  Only
>>> simple operations (adding an entry or clearing all) are required and the
>>> list is assumed not to be very long, so this simple data structure should
>>> be enough.
>>>
>>> If we failed to save raw error info, the hwpoison hugepage has errors on
>>> unknown subpage, then this new saving mechanism does not work any more,
>>> so disable saving new raw error info and freeing hwpoison hugepages.
>>>
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> ---
> ...
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 66bb39e0fce8..ccd470f0194c 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1535,17 +1535,15 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>>>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>>  		return;
>>>  
>>> -	if (hugetlb_vmemmap_restore(h, page)) {
>>> -		spin_lock_irq(&hugetlb_lock);
>>> -		/*
>>> -		 * If we cannot allocate vmemmap pages, just refuse to free the
>>> -		 * page and put the page back on the hugetlb free list and treat
>>> -		 * as a surplus page.
>>> -		 */
>>> -		add_hugetlb_page(h, page, true);
>>> -		spin_unlock_irq(&hugetlb_lock);
>>> -		return;
>>> -	}
>>> +	if (hugetlb_vmemmap_restore(h, page))
>>> +		goto fail;
>>> +
>>> +	/*
>>> +	 * Move PageHWPoison flag from head page to the raw error pages,
>>> +	 * which makes any healthy subpages reusable.
>>> +	 */
>>> +	if (unlikely(PageHWPoison(page) && hugetlb_clear_page_hwpoison(page)))
>>> +		goto fail;
>>
>> IIUC, HPageVmemmapOptimized must have been cleared via hugetlb_vmemmap_restore above. So
>> VM_BUG_ON_PAGE(!HPageVmemmapOptimized(page), page) in add_hugetlb_page will be triggered
>> if we go to fail here. add_hugetlb_page is expected to be called when we cannot allocate
>> vmemmap pages.
> 
> Thanks a lot, you're right. I shouldn't simply factor the failure path with
> the goto label.  I think that it's hard to undo hugetlb_vmemmap_restore(), so
> checking HPageRawHwpUnreliable() before hugetlb_vmemmap_restore(), then
> try to hugetlb_clear_page_hwpoison() after it (where tail pages are available).

Sounds feasible.

> 
>>
>>>  
>>>  	for (i = 0; i < pages_per_huge_page(h);
>>>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>>> @@ -1566,6 +1564,16 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>>>  	} else {
>>>  		__free_pages(page, huge_page_order(h));
>>>  	}
>>> +	return;
>>> +fail:
>>> +	spin_lock_irq(&hugetlb_lock);
>>> +	/*
>>> +	 * If we cannot allocate vmemmap pages or cannot identify raw hwpoison
>>> +	 * subpages reliably, just refuse to free the page and put the page
>>> +	 * back on the hugetlb free list and treat as a surplus page.
>>> +	 */
>>> +	add_hugetlb_page(h, page, true);
>>> +	spin_unlock_irq(&hugetlb_lock);
>>>  }
>>>  
>>>  /*
>>> @@ -2109,15 +2117,6 @@ int dissolve_free_huge_page(struct page *page)
>>>  		 */
>>>  		rc = hugetlb_vmemmap_restore(h, head);
>>>  		if (!rc) {
>>> -			/*
>>> -			 * Move PageHWPoison flag from head page to the raw
>>> -			 * error page, which makes any subpages rather than
>>> -			 * the error page reusable.
>>> -			 */
>>> -			if (PageHWPoison(head) && page != head) {
>>> -				SetPageHWPoison(page);
>>> -				ClearPageHWPoison(head);
>>> -			}
>>>  			update_and_free_page(h, head, false);
>>>  		} else {
>>>  			spin_lock_irq(&hugetlb_lock);
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index c9931c676335..53bf7486a245 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1664,6 +1664,82 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>>  EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
>>>  #endif /* CONFIG_FS_DAX */
>>>  
>>> +/*
>>> + * Struct raw_hwp_page represents information about "raw error page",
>>> + * constructing singly linked list originated from ->private field of
>>> + * SUBPAGE_INDEX_HWPOISON-th tail page.
>>> + */
>>> +struct raw_hwp_page {
>>> +	struct llist_node node;
>>> +	struct page *page;
>>> +};
>>> +
>>> +static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
>>> +{
>>> +	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
>>> +}
>>> +
>>> +static inline int hugetlb_set_page_hwpoison(struct page *hpage,
>>> +					struct page *page)
>>> +{
>>> +	struct llist_head *head;
>>> +	struct raw_hwp_page *raw_hwp;
>>> +	struct llist_node *t, *tnode;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * Once the hwpoison hugepage has lost reliable raw error info,
>>> +	 * there is little meaning to keep additional error info precisely,
>>> +	 * so skip to add additional raw error info.
>>> +	 */
>>> +	if (HPageRawHwpUnreliable(hpage))
>>> +		return -EHWPOISON;
>>
>> If we return here, num_poisoned_pages can't reflect the all hwpoisoned hugepages?
> 
> No, it can't now.  Currently we try to (and fail) count only the number
> hwpoison subpages with raw_hwp_info.  If we want to track all corrupted
> pages (including hwpoison subpages without raw_hwp_info), maybe running the
> following part first in this function could make it better.
> 
> 	ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
> 	/* the first error event will be counted in action_result(). */
> 	if (ret)
> 		num_poisoned_pages_inc();
> 
> But I like the option you suggest below.
> 
>>
>>> +	head = raw_hwp_list_head(hpage);
>>> +	llist_for_each_safe(tnode, t, head->first) {
>>> +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
>>> +
>>> +		if (p->page == page)
>>> +			return -EHWPOISON;
>>> +	}
>>> +
>>> +	ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
>>> +	/* the first error event will be counted in action_result(). */
>>> +	if (ret)
>>> +		num_poisoned_pages_inc();
>>> +
>>> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>>> +	if (raw_hwp) {
>>> +		raw_hwp->page = page;
>>> +		llist_add(&raw_hwp->node, head);
>>
>> IMHO, we might need to do num_poisoned_pages_inc here because we decrement the
>> num_poisoned_pages according to the llist length.
> 
> Yes, if we'd like to count only hwpoisoned subpages with raw_hwp_info,
> doing num_poisoned_pages_inc here is fine.
> 
>>> +	} else {
>>> +		/*
>>> +		 * Failed to save raw error info.  We no longer trace all
>>> +		 * hwpoisoned subpages, and we need refuse to free/dissolve
>>> +		 * this hwpoisoned hugepage.
>>> +		 */
>>> +		SetHPageRawHwpUnreliable(hpage);
>>> +	}
>>> +	return ret;
>>> +}
>>> +
>>> +inline int hugetlb_clear_page_hwpoison(struct page *hpage)
>>
>> off-the-topic: Is "inline" needed here? I see hugetlb_clear_page_hwpoison is "extern" above.
> 
> Maybe not, this code is not performance-sensitive and actually this inline
> is a leftover of updates in the previous versions. I'll remove this.
> 
>>
>>> +{
>>> +	struct llist_head *head;
>>> +	struct llist_node *t, *tnode;
>>> +
>>> +	if (!HPageRawHwpUnreliable(hpage))
>>> +		ClearPageHWPoison(hpage);
>>> +	head = raw_hwp_list_head(hpage);
>>> +	llist_for_each_safe(tnode, t, head->first) {
>>> +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
>>> +
>>> +		SetPageHWPoison(p->page);
>>
>> IMHO, in HPageRawHwpUnreliable(hpage) case, it's better not to do SetPageHWPoison here.
>> Because hugepage won't be dissolved and thus we cannot write any data to some tail struct
>> pages if HugeTLB Vmemmap Optimization is enabled. Freeing the memory here should be enough.
> 
> This is a good point, too. Current version surely does not work with HVO, so
> I think of simply giving up clearing hwpoison when HPageVmemmapOptimized is
> true. And I should leave some inline comment about this.

Sounds like a good idea. This will make the life easier.

> 
>>> +		kfree(p);
>>> +	}
>>> +	llist_del_all(head);
>>> +	return 0;
>>> +}
>>
>> I thought num_poisoned_pages_dec is missing and return value is unneeded. But this is changed
>> in next patch. So it should be fine here.
> 
> OK.
> 
>>
>>> +
>>>  /*
>>>   * Called from hugetlb code with hugetlb_lock held.
>>>   *
>>> @@ -1698,7 +1774,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>>  		goto out;
>>>  	}
>>>  
>>> -	if (TestSetPageHWPoison(head)) {
>>> +	if (hugetlb_set_page_hwpoison(head, page)) {
>>>  		ret = -EHWPOISON;
>>>  		goto out;
>>>  	}
>>> @@ -1751,7 +1827,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>>  	lock_page(head);
>>>  
>>>  	if (hwpoison_filter(p)) {
>>> -		ClearPageHWPoison(head);
>>> +		hugetlb_clear_page_hwpoison(head);
>>>  		res = -EOPNOTSUPP;
>>>  		goto out;
>>>  	}
>>>
>>
>> Many thanks for your hard work. :)
> 
> Thanks for the detailed review and feedback.
> 
> - Naoya Horiguchi

Thanks.

> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87505AE23F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiIFIOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIFIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:14:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C767DE97
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:14:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MMJ3y5rZdz1P6tM;
        Tue,  6 Sep 2022 16:10:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 16:14:41 +0800
Subject: Re: [PATCH v2 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
 <20220905062137.1455537-2-naoya.horiguchi@linux.dev>
 <3e302aa5-d63d-097e-2cb7-831b7c99e736@huawei.com>
 <20220906061417.GA1406504@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0edc3912-475e-0366-666c-9be516af1df1@huawei.com>
Date:   Tue, 6 Sep 2022 16:14:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220906061417.GA1406504@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/6 14:14, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Sep 06, 2022 at 10:59:58AM +0800, Miaohe Lin wrote:
>> On 2022/9/5 14:21, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> HWPoisoned page is not supposed to be accessed once marked, but currently
>>> such accesses can happen during memory hotremove because do_migrate_range()
>>> can be called before dissolve_free_huge_pages() is called.
>>>
>>> Move dissolve_free_huge_pages() before scan_movable_pages(). Recently
>>> delayed dissolve has been implemented, so the dissolving can turn
>>> a hwpoisoned hugepage into 4kB hwpoison page, which memory hotplug can
>>> handle safely.
>>
>> Yes, thanks for your work, Naoya. ;)
>>
>>>
>>> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> ---
>>>  mm/memory_hotplug.c | 22 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index fad6d1f2262a..c24735d63b25 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1880,6 +1880,17 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>>  
>>>  			cond_resched();
>>>  
>>> +			/*
>>> +			 * Dissolve free hugepages in the memory block before doing
>>> +			 * offlining actually in order to make hugetlbfs's object
>>> +			 * counting consistent.
>>> +			 */
>>> +			ret = dissolve_free_huge_pages(start_pfn, end_pfn);
>>> +			if (ret) {
>>> +				reason = "failure to dissolve huge pages";
>>> +				goto failed_removal_isolated;
>>> +			}
>>
>> This change has a side-effect. If hugetlb pages are in-use, dissolve_free_huge_pages() will always return -EBUSY
>> even if those pages can be migrated. So we fail to hotremove the memory even if they could be offlined.
>> Or am I miss something?
> 
> Thank you for the comment, you're right.  (Taking a look over my test result
> carefully, it showed failures for the related cases, I somehow overlooked
> them, really sorry.)  So my second thought is that we keep offline_pages()
> as is, and insert a few line in do_migrate_range() to handle the case of
> hwpoisoned hugepage like below:
> 
> @@ -1642,6 +1642,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 
>                 if (PageHuge(page)) {
>                         pfn = page_to_pfn(head) + compound_nr(head) - 1;
> +                       if (PageHWPoison(head))
> +                               continue;

Thanks for your update. But it seems this is not enough. With the above code change, HWPoisoned
hugetlb pages will always be ignored in do_migrate_range(). And if these pages are HPageMigratable,
they will be returned in scan_movable_pages() then passed into the do_migrate_range() again. Thus
a possible deadloop will occur until these pages become un-movable?

>                         isolate_hugetlb(head, &source);
>                         continue;
>                 } else if (PageTransHuge(page))
> 
> This is slightly different from your original suggestion
> https://lore.kernel.org/linux-mm/20220421135129.19767-1-linmiaohe@huawei.com/T
> , as discussed in the thread existing "if (PageHWPoison(page))" branch in
> this function can't be used for hugetlb.  We could adjust them to handle
> hugetlb, but maybe separating code for hugetlb first from the others looks
> less compicated to me.

It might be better to do something, e.g. unmap the hugetlb pages to prevent accessing from process if mapped,
even try truncating the error page from pagecache. But I have no strong opinion as handling memory failure
would always be a best try. ;)

Thanks,
Miaohe Lin


> 
> If you have any suggestion on this, please let me know.
> 
> Thanks,
> Naoya Horiguchi
> 


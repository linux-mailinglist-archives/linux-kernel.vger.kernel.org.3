Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438251F842
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiEIJeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiEIJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:21:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D91A4091
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:17:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxZk1431YzGpSV;
        Mon,  9 May 2022 16:54:49 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 16:57:35 +0800
Subject: Re: [RFC PATCH v1 2/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-3-naoya.horiguchi@linux.dev>
 <9bdddf53-b01a-9665-04c3-0146efc1404d@huawei.com>
 <20220509075548.GC123646@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <39674811-b814-8f8c-0823-99a62c0ced49@huawei.com>
Date:   Mon, 9 May 2022 16:57:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220509075548.GC123646@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/9 15:55, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Apr 29, 2022 at 04:49:16PM +0800, Miaohe Lin wrote:
>> On 2022/4/27 12:28, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> HWPoisoned page is not supposed to prevent memory hotremove, but
>>> currently this does not properly work for hwpoisoned hugepages and the
>>> kernel tries to migrate them, which could cause consuming corrupted
>>> data.
>>>
>>> Move dissolve_free_huge_pages() before scan_movable_pages(). This is
>>> because the result of the movable check depends on the result of the
>>> dissolve.  Now delayed dissolve is available, so hwpoisoned hugepages
>>> can be turned into 4kB hwpoison page which memory hotplug can handle.
>>>
>>> And clear HPageMigratable pseudo flag for hwpoisoned hugepages. This is
>>> also important because dissolve_free_huge_page() can fail.  So it's
>>> still necessary to prevent do_migrate_pages() from trying to migrate
>>> hwpoison hugepages.
>>>
>>> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> ---
>>>  mm/hugetlb.c        | 11 +++++++++++
>>>  mm/memory-failure.c |  2 ++
>>>  mm/memory_hotplug.c | 23 +++++++++++------------
>>>  3 files changed, 24 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 6867ea8345d1..95b1db852ca9 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2159,6 +2159,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>>>  
>>>  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
>>>  		page = pfn_to_page(pfn);
>>> +
>>> +		if (PageHuge(page) && PageHWPoison(page)) {
>>> +			/*
>>> +			 * Release the last refcount from hwpoison to turn into
>>> +			 * a free hugepage.
>>> +			 */
>>> +			if (page_count(page) == 1)
>>> +				put_page(page);
>>> +			page = hugetlb_page_hwpoison(page);
>>> +		}
>>> +
>>
>> This patch looks good to me. Thanks!
>>
>> One question: Can this hugepage be put into buddy system? In free_huge_page,
>> if h->surplus_huge_pages_node[nid] > 0, hugepage might be put into buddy via
>> update_and_free_page. So it's not PageHuge anymore and won't be dissolved. If
>> this happens, the "raw error page" is still missed and might be accessed later.
> 
> Yes, this put_page() could free pages directly into buddy.  In such case, I
> expect __update_and_free_page() to move the PageHWpoison flag to the raw error
> page, so I think the final result should be the same.

Agree, __update_and_free_page could help move the PageHWpoison flag to the raw error page.

Thanks!

> 
> Thanks,
> Naoya Horiguchi
> 


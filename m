Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB45895D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbiHDCIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDCIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:08:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ECB5F13F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:08:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LysYb6ZGmzTgY3;
        Thu,  4 Aug 2022 10:07:15 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:08:33 +0800
Subject: Re: [PATCH] mm, hwpoison, hugetlb: Free hwpoison huge page to list
 tail and dissolve hwpoison huge page first
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        luofei <luofei@unicloud.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        <songmuchun@bytedance.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220802100711.2425644-1-luofei@unicloud.com>
 <YulXz+1iLHuZBEDb@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1191d45b-fece-659b-1dd1-8cf4ce89c2f1@huawei.com>
Date:   Thu, 4 Aug 2022 10:08:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YulXz+1iLHuZBEDb@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/3 0:58, Mike Kravetz wrote:
> On 08/02/22 06:07, luofei wrote:
>> If free hwpoison huge page to the end of hugepage_freelists, the
>> loop can exit directly when the hwpoison huge page is traversed,
>> which can effectively reduce the repeated traversal of the hwpoison
>> huge page. Meanwhile, when free the free huge pages to lower level
>> allocators, if hwpoison ones are released first, this can improve
>> the effecvive utilization rate of huge page.
> 
> In general, I think this is a good idea.  Although, it seems that with
> recent changes to hugetlb poisioning code we are even less likely to
> have a poisioned page on hugetlb free lists.
> 
> Adding Naoya and Miaohe as they have been looking at page poison of hugetlb
> pages recently.
> 
>> Signed-off-by: luofei <luofei@unicloud.com>
>> ---
>>  mm/hugetlb.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 28516881a1b2..ca72220eedd9 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1116,7 +1116,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>>  	lockdep_assert_held(&hugetlb_lock);
>>  	VM_BUG_ON_PAGE(page_count(page), page);
>>  
>> -	list_move(&page->lru, &h->hugepage_freelists[nid]);
>> +	if (unlikely(PageHWPoison(page)))
>> +		list_move_tail(&page->lru, &h->hugepage_freelists[nid]);
>> +	else
>> +		list_move(&page->lru, &h->hugepage_freelists[nid]);
>>  	h->free_huge_pages++;
>>  	h->free_huge_pages_node[nid]++;
>>  	SetHPageFreed(page);
>> @@ -1133,7 +1136,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>>  			continue;
>>  
>>  		if (PageHWPoison(page))
>> -			continue;
>> +			break;
> 
> IIRC, it is 'possible' to unpoison a page via the debug/testing interfaces.
> If so, then we could end up with free unpoisioned page(s) at the end of
> the list that would never be used because we quit when encountering a
> poisioned page.

IIUC, above scene will actually happen. What's more, dissolve_free_huge_page might fail after hugetlb
page is hwpoisoned due to e.g. all hugetlb pages are reserved. In that case, the hwpoisoned hugetlb page
is not moved to the tail of hugepage_freelists and thus cause problems.

Thanks both.

> 
> Naoya and Miaohe would know for sure.
> 
> Same possible issue in demote_pool_huge_page().
> 


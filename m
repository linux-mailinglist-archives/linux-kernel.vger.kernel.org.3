Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D45ACCF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiIEHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiIEH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:29:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C706456
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:29:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLg6g4zZGzmV65;
        Mon,  5 Sep 2022 15:26:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 15:29:35 +0800
Subject: Re: [PATCH 2/6] mm, hwpoison: use __PageMovable() to detect non-lru
 movable pages
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-3-linmiaohe@huawei.com>
 <20220905052243.GA1355682@hori.linux.bs1.fc.nec.co.jp>
 <1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com>
 <20220905071542.GA1364147@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f2a52dd2-5792-0c45-3ae6-c1bcf547762c@huawei.com>
Date:   Mon, 5 Sep 2022 15:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220905071542.GA1364147@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/5 15:15, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Sep 05, 2022 at 02:53:41PM +0800, Miaohe Lin wrote:
>> On 2022/9/5 13:22, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> Hi Miaohe,
>>>
>>> On Tue, Aug 30, 2022 at 08:36:00PM +0800, Miaohe Lin wrote:
>>>> It's more recommended to use __PageMovable() to detect non-lru movable
>>>> pages. We can avoid bumping page refcnt via isolate_movable_page() for
>>>> the isolated lru pages. Also if pages become PageLRU just after they're
>>>> checked but before trying to isolate them, isolate_lru_page() will be
>>>> called to do the right work.
>>>
>>> Good point, non-lru movable page is currently handled by isolate_lru_page(),
>>> which always fails.  This means that we lost the chance of soft-offlining
>>> for any non-lru movable page.  So this patch improves the situation.
>>
>> Non-lru movable page will still be handled by isolate_movable_page() before the code change
>> as they don't have PageLRU set. The current situation is that the isolated LRU pages are
>> passed to isolate_movable_page() uncorrectly. This might not hurt. But the chance that pages
>> become un-isolated and thus available just after checking could be seized with this patch.
> 
> OK, thank you for correct me.
> 
>>
>>>
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/memory-failure.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index a923a6dde871..3966fa6abe03 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -2404,7 +2404,7 @@ EXPORT_SYMBOL(unpoison_memory);
>>>>  static bool isolate_page(struct page *page, struct list_head *pagelist)
>>>>  {
>>>>  	bool isolated = false;
>>>> -	bool lru = PageLRU(page);
>>>> +	bool lru = !__PageMovable(page);
>>>
>>> It seems that PAGE_MAPPING_MOVABLE is not set for hugetlb pages, so
>>> lru becomes true for them.  Then, if isolate_hugetlb() succeeds,
>>> inc_node_page_state() is called for hugetlb pages, maybe that's not expected.
>>
>> Yes, that's unexpected. Thanks for pointing this out.
>>
>>>
>>>>  
>>>>  	if (PageHuge(page)) {
>>>>  		isolated = !isolate_hugetlb(page, pagelist);
>>>         } else {
>>>                 if (lru)
>>>                         isolated = !isolate_lru_page(page);
>>>                 else
>>>                         isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>>>
>>>                 if (isolated)
>>>                         list_add(&page->lru, pagelist);
>>>         }
>>>
>>>         if (isolated && lru)
>>>                 inc_node_page_state(page, NR_ISOLATED_ANON +
>>>                                     page_is_file_lru(page));
>>>
>>> so, how about moving this if block into the above else block?
>>> Then, the automatic variable lru can be moved into the else block.
>>
>> Do you mean something like below?
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index df3bf266eebf..48780f3a61d3 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2404,24 +2404,25 @@ EXPORT_SYMBOL(unpoison_memory);
>>  static bool isolate_page(struct page *page, struct list_head *pagelist)
>>  {
>>         bool isolated = false;
>> -       bool lru = !__PageMovable(page);
>>
>>         if (PageHuge(page)) {
>>                 isolated = !isolate_hugetlb(page, pagelist);
>>         } else {
>> +               bool lru = !__PageMovable(page);
>> +
>>                 if (lru)
>>                         isolated = !isolate_lru_page(page);
>>                 else
>>                         isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>>
>> -               if (isolated)
>> +               if (isolated) {
>>                         list_add(&page->lru, pagelist);
>> +                       if (lru)
>> +                               inc_node_page_state(page, NR_ISOLATED_ANON +
>> +                                                   page_is_file_lru(page));
>> +               }
>>         }
>>
>> -       if (isolated && lru)
>> -               inc_node_page_state(page, NR_ISOLATED_ANON +
>> -                                   page_is_file_lru(page));
>> -
>>         /*
>>          * If we succeed to isolate the page, we grabbed another refcount on
>>          * the page, so we can safely drop the one we got from get_any_pages().
>>
> 
> Yes, that's exactly what I thought of.

Hi Andrew:

The above code change could be applied to the mm-tree directly. Or should I resend
the v2 series? Which one is more convenient for you? They're all fine to me. ;)

Many thanks both.

Thanks,
Miaohe Lin


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D234D57A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbiCKB4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiCKB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:56:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D0F19D61B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:54:58 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KF8984h40zfYqy;
        Fri, 11 Mar 2022 09:53:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 09:54:56 +0800
Subject: Re: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in
 split_huge_page_to_list
To:     Yang Shi <shy828301@gmail.com>
CC:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-5-linmiaohe@huawei.com>
 <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp>
 <2311bee4-cc11-93fc-6992-6c327a150e3d@huawei.com>
 <CAHbLzkrOfcJvv8Vy8jcKWc7QX=1Y9e=EW9+p78sp1xhac645-w@mail.gmail.com>
 <e7f1977e-2f6a-cffa-a75f-9665a908ca21@huawei.com>
 <CAHbLzkpOZTkvBECpKrOtSjV1ZVoDHnr0z33tFDka=_CZYq5JAQ@mail.gmail.com>
 <dc5fa8b3-4fa8-0e12-e4d2-f9b24fd2bf87@huawei.com>
 <CAHbLzkpkkFEXhKZtSHYhY61WMKtQHeqY5x+FJhUG8H5_FDS4Cg@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <02e84336-a5a5-abd0-bfb5-2e5c44ed4b2e@huawei.com>
Date:   Fri, 11 Mar 2022 09:54:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpkkFEXhKZtSHYhY61WMKtQHeqY5x+FJhUG8H5_FDS4Cg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/3/11 3:32, Yang Shi wrote:
> On Thu, Mar 10, 2022 at 3:46 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/3/9 2:47, Yang Shi wrote:
>>> On Tue, Mar 8, 2022 at 4:36 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> On 2022/3/8 3:53, Yang Shi wrote:
>>>>> On Sun, Mar 6, 2022 at 11:07 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>>
>>>>>> On 2022/3/4 16:28, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>>>>> On Mon, Feb 28, 2022 at 10:02:45PM +0800, Miaohe Lin wrote:
>>>>>>>> The huge zero page could reach here and if we ever try to split it, the
>>>>>>>> VM_BUG_ON_PAGE will be triggered in split_huge_page_to_list(). Also the
>>>>>>>> non-lru compound movable pages could be taken for transhuge pages. Skip
>>>>>>>> these pages by checking PageLRU because huge zero page isn't lru page as
>>>>>>>> non-lru compound movable pages.
>>>>>>>
>>>>>>> It seems that memory_failure() also fails at get_any_page() with "hwpoison:
>>>>>>> unhandlable page" message.
>>>>>>>
>>>>>>>   [16478.203474] page:00000000b6acdbd1 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1810b4
>>>>>>>   [16478.206612] flags: 0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
>>>>>>>   [16478.209411] raw: 0057ffffc0801000 fffff11bc6042d08 fffff11bc6042d08 0000000000000000
>>>>>>>   [16478.211921] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>>>>>>>   [16478.214473] page dumped because: hwpoison: unhandlable page
>>>>>>>   [16478.216386] Memory failure: 0x1810b4: recovery action for unknown page: Ignored
>>>>>>>
>>>>>>> We can't handle errors on huge (or normal) zero page, so the current
>>>>>>
>>>>>> Sorry for confusing commit log again. I should have a coffee before I make this patch.
>>>>>> Huge or normal zero page will fail at get_any_page because they're neither HWPoisonHandlable
>>>>>> nor PageHuge.
>>>>>>
>>>>>>> behavior seems to me more suitable than "unsplit thp".
>>>>>>>
>>>>>>> Or if you have some producer to reach the following path with huge zero
>>>>>>> page, could you share it?
>>>>>>>
>>>>>>
>>>>>> What I mean is that non-lru movable compound page can reach here unexpected because __PageMovable(page)
>>>>>> is handleable now. So get_any_page could succeed to grab the page refcnt. And since it's compound page,
>>>>>> it will go through the split_huge_page_to_list because PageTransHuge checks PageHead(page) which can also
>>>>>> be true for compound page. But this type of pages is unexpected for split_huge_page_to_list.
>>>>>
>>>>> Can we really handle non-LRU movable pages in memory failure
>>>>> (uncorrectable errors)? Typically they are balloon, zsmalloc, etc.
>>>>> Assuming we run into a base (4K) non-LRU movable page, we could reach
>>>>> as far as identify_page_state(), it should not fall into any category
>>>>> except me_unknown. So it seems we could just simply make it
>>>>> unhandlable.
>>>>
>>>> There is the comment from memory_failure:
>>>>         /*
>>>>          * We ignore non-LRU pages for good reasons.
>>>>          * - PG_locked is only well defined for LRU pages and a few others
>>>>          * - to avoid races with __SetPageLocked()
>>>>          * - to avoid races with __SetPageSlab*() (and more non-atomic ops)
>>>>          * The check (unnecessarily) ignores LRU pages being isolated and
>>>>          * walked by the page reclaim code, however that's not a big loss.
>>>>          */
>>>>
>>>> So we could not handle non-LRU movable pages.
>>>>
>>>> What do you mean is something like below?
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index 5444a8ef4867..d80dbe0f20b6 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -1784,6 +1784,13 @@ int memory_failure(unsigned long pfn, int flags)
>>>>                 }
>>>>         }
>>>>
>>>> +       if (__PageMovable(hpage)) {
>>>> +               put_page(p);
>>>> +               action_result(pfn, MF_MSG_MOVALBE_PAGE, MF_IGNORED);
>>>> +               res = -EBUSY;
>>>> +               goto unlock_mutex;
>>>> +       }
>>>> +
>>>>         if (PageTransHuge(hpage)) {
>>>>                 /*
>>>>                  * The flag must be set after the refcount is bumped
>>>>
>>>>
>>>> i.e. Simply make non-LRU movable pages unhandlable ?
>>>
>>
>> I think about the below code more carefully and I found that this will make
>> hwpoison_filter can't handle the non-LRU movable pages now. Because non-LRU
>> movable pages return early now and thus can't reach the hwpoison_filter. This
>> results in a inconsistent behavior with previous one. So I think the origin
>> fixup of this patch is more suitable. What do you think?
> 
> I'm not familiar with hwpoison_filter(), it seems like a test helper
> for error injection. I don't think hwpoison_filter() is used to filter
> unhandlable page, for example, slab page, IIUC. So the non-LRU movable
> pages should be treated the same. If so, the old behavior was simply
> wrong.

I think you're right. hwpoison_filter should filter the handleable error.

Thanks.

> 
>>
>> Thanks.
>>
>>> I'd prefer this personally. Something like the below (compile test only):
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 5444a8ef4867..789e40909ade 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1176,12 +1176,18 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>>>   * does not return true for hugetlb or device memory pages, so it's assumed
>>>   * to be called only in the context where we never have such pages.
>>>   */
>>> -static inline bool HWPoisonHandlable(struct page *page)
>>> +static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>>>  {
>>> - return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
>>> + bool movable = false;
>>> +
>>> + /* Soft offline could mirgate non-LRU movable pages */
>>> + if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
>>> + movable = true;
>>> +
>>> + return movable || PageLRU(page) || is_free_buddy_page(page);
>>>  }
>>>
>>> -static int __get_hwpoison_page(struct page *page)
>>> +static int __get_hwpoison_page(struct page *page, unsigned long flags)
>>>  {
>>>   struct page *head = compound_head(page);
>>>   int ret = 0;
>>> @@ -1196,7 +1202,7 @@ static int __get_hwpoison_page(struct page *page)
>>>   * for any unsupported type of page in order to reduce the risk of
>>>   * unexpected races caused by taking a page refcount.
>>>   */
>>> - if (!HWPoisonHandlable(head))
>>> + if (!HWPoisonHandlable(head, flags))
>>>   return -EBUSY;
>>>
>>>   if (get_page_unless_zero(head)) {
>>> @@ -1221,7 +1227,7 @@ static int get_any_page(struct page *p, unsigned
>>> long flags)
>>>
>>>  try_again:
>>>   if (!count_increased) {
>>> - ret = __get_hwpoison_page(p);
>>> + ret = __get_hwpoison_page(p, flags);
>>>   if (!ret) {
>>>   if (page_count(p)) {
>>>   /* We raced with an allocation, retry. */
>>> @@ -1249,7 +1255,7 @@ static int get_any_page(struct page *p, unsigned
>>> long flags)
>>>   }
>>>   }
>>>
>>> - if (PageHuge(p) || HWPoisonHandlable(p)) {
>>> + if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
>>>   ret = 1;
>>>   } else {
>>>   /*
>>>
>>>>
>>>>>
>>>>> But it should be handlable for soft-offline since it could be migrated.
>>>>>
>>>>
>>>> Yes, non-LRU movable pages can be simply migrated.
>>>>
>>>> Many thanks.
>>>>
>>>>>
>>>>>> Does this make sense for you? Thanks Naoya.
>>>>>>
>>>>>>> Thanks,
>>>>>>> Naoya Horiguchi
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>>>> ---
>>>>>>>>  mm/memory-failure.c | 14 ++++++++++++++
>>>>>>>>  1 file changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>>>> index 23bfd809dc8c..ac6492e36978 100644
>>>>>>>> --- a/mm/memory-failure.c
>>>>>>>> +++ b/mm/memory-failure.c
>>>>>>>> @@ -1792,6 +1792,20 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>>>>      }
>>>>>>>>
>>>>>>>>      if (PageTransHuge(hpage)) {
>>>>>>>> +            /*
>>>>>>>> +             * The non-lru compound movable pages could be taken for
>>>>>>>> +             * transhuge pages. Also huge zero page could reach here
>>>>>>>> +             * and if we ever try to split it, the VM_BUG_ON_PAGE will
>>>>>>>> +             * be triggered in split_huge_page_to_list(). Skip these
>>>>>>>> +             * pages by checking PageLRU because huge zero page isn't
>>>>>>>> +             * lru page as non-lru compound movable pages.
>>>>>>>> +             */
>>>>>>>> +            if (!PageLRU(hpage)) {
>>>>>>>> +                    put_page(p);
>>>>>>>> +                    action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>>>>>>>> +                    res = -EBUSY;
>>>>>>>> +                    goto unlock_mutex;
>>>>>>>> +            }
>>>>>>>>              /*
>>>>>>>>               * The flag must be set after the refcount is bumped
>>>>>>>>               * otherwise it may race with THP split.
>>>>>>>> --
>>>>>>>> 2.23.0
>>>>>>
>>>>>>
>>>>> .
>>>>>
>>>>
>>> .
>>>
>>
>>
> .
> 


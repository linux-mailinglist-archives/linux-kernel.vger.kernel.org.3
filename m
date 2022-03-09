Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA094D2AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiCIIbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiCIIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:31:35 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED143102152
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:30:36 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KD4yf2TnQz1GC2R;
        Wed,  9 Mar 2022 16:25:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:30:34 +0800
Subject: Re: [PATCH 2/4] mm/memory-failure.c: fix wrong user reference report
To:     Yang Shi <shy828301@gmail.com>
CC:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-3-linmiaohe@huawei.com>
 <20220304082714.GB3778609@hori.linux.bs1.fc.nec.co.jp>
 <227af111-9264-02fd-9e46-744d39ecfed0@huawei.com>
 <CAHbLzkom__59_RCpJCZDA+ray-t5qAWatujXWha8BX2-x8GiMA@mail.gmail.com>
 <8a35d8d8-3078-89ad-4061-358a500c5d61@huawei.com>
 <CAHbLzkqjoQgXZDUnuLkVABLbPx-=yfgZ-Akt26rgALyQP07dbA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <343fff27-f421-9724-a60e-eb35148b226b@huawei.com>
Date:   Wed, 9 Mar 2022 16:30:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkqjoQgXZDUnuLkVABLbPx-=yfgZ-Akt26rgALyQP07dbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/3/9 2:51, Yang Shi wrote:
> On Tue, Mar 8, 2022 at 5:11 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/3/8 4:14, Yang Shi wrote:
>>> On Mon, Mar 7, 2022 at 3:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> On 2022/3/4 16:27, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>>> On Mon, Feb 28, 2022 at 10:02:43PM +0800, Miaohe Lin wrote:
>>>>>> The dirty swapcache page is still residing in the swap cache after it's
>>>>>> hwpoisoned. So there is always one extra refcount for swap cache.
>>>>>
>>>>> The diff seems fine at a glance, but let me have a few question to
>>>>> understand the issue more.
>>>>>
>>>>> - Is the behavior described above the effect of recent change on shmem where
>>>>>   dirty pagecache is pinned on hwpoison (commit a76054266661 ("mm: shmem:
>>>>>   don't truncate page if memory failure happens"). Or the older kernels
>>>>>   behave as the same?
>>>>>
>>>>> - Is the behavior true for normal anonymous pages (not shmem pages)?
>>>>>
>>>>
>>>> The behavior described above is aimed at swapcache not pagecache. So it should be
>>>> irrelevant with the recent change on shmem.
>>>>
>>>> What I try to fix here is that me_swapcache_dirty holds one extra pin via SwapCache
>>>> regardless of the return value of delete_from_lru_cache. We should try to report more
>>>> accurate extra refcount for debugging purpose.
>>>
>>> I think you misunderstood the code. The delete_from_lru_cache()
>>> returning 0 means the page was on LRU and isolated from LRU
>>> successfully now. Returning -EIO means the page was not on LRU, so it
>>> should have at least an extra pin on it.
>>>
>>> So MF_DELAYED means there is no other pin other than hwpoison and
>>> swapcache which is expected, MF_FAILED means there might be extra
>>> pins.
>>>
>>> The has_extra_refcount() raised error then there is *unexpected* refcount.
>>
>> Many thanks for your explanation. It seems you're right. If page is held on
>> the lru_pvecs when we try to do delete_from_lru_cache, and after that it's
>> drained to the lru list( so its refcnt might be 2 now). Then we might have
>> the following complain if extra_pins is always true:
>>         "Memory failure: ... still referenced by 0 users\n"
>>
>> But it seems the origin code can not report the correct reason too because
>> if we retry, page can be delete_from_lru_cache and we can succeed now.
> 
> Retry is ok, but it seems overkilling to me IMHO.
> 

Anyway, it seems I misunderstood the code. So I will drop this patch. Thanks for comment.

>>
>> Anyway, many thanks for pointing this out.
>>
>>>
>>>>
>>>>> I'm trying to test hwpoison hitting the dirty swapcache, but it seems that
>>>>> in my testing memory_faliure() fails with "hwpoison: unhandlable page"
>>>>
>>>> Maybe memory_faliure is racing with page reclaim where page is isolated?
>>>>
>>>>> warning at get_any_page().  So I'm still not sure that me_pagecache_dirty()
>>>>> fixes any visible problem.
>>>>
>>>> IIUC, me_pagecache_dirty can't do much except for the corresponding address_space supporting
>>>> error_remove_page which can truncate the dirty pagecache page. But this may cause silent data
>>>> loss. It's better to keep the page stay in the pagecache until the file is truncated, hole
>>>> punched or removed as commit a76054266661 pointed out.
>>>>
>>>> Thanks.
>>>>
>>>>>> Thanks,
>>>>> Naoya Horiguchi
>>>>>
>>>>>>
>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>> ---
>>>>>>  mm/memory-failure.c | 6 +-----
>>>>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>> index 0d7c58340a98..5f9503573263 100644
>>>>>> --- a/mm/memory-failure.c
>>>>>> +++ b/mm/memory-failure.c
>>>>>> @@ -984,7 +984,6 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
>>>>>>  static int me_swapcache_dirty(struct page_state *ps, struct page *p)
>>>>>>  {
>>>>>>      int ret;
>>>>>> -    bool extra_pins = false;
>>>>>>
>>>>>>      ClearPageDirty(p);
>>>>>>      /* Trigger EIO in shmem: */
>>>>>> @@ -993,10 +992,7 @@ static int me_swapcache_dirty(struct page_state *ps, struct page *p)
>>>>>>      ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
>>>>>>      unlock_page(p);
>>>>>>
>>>>>> -    if (ret == MF_DELAYED)
>>>>>> -            extra_pins = true;
>>>>>> -
>>>>>> -    if (has_extra_refcount(ps, p, extra_pins))
>>>>>> +    if (has_extra_refcount(ps, p, true))
>>>>>>              ret = MF_FAILED;
>>>>>>
>>>>>>      return ret;
>>>>>> --
>>>>>> 2.23.0
>>>>
>>>>
>>> .
>>>
>>
> .
> 


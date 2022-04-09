Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC64FA1B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiDICia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiDICi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:38:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8EDBC1E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:36:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZzkZ00S8zdZnT;
        Sat,  9 Apr 2022 10:35:49 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:36:20 +0800
Subject: Re: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
To:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-2-linmiaohe@huawei.com>
 <09d363ba-5bd0-75ae-8ece-cd91997f1b46@redhat.com>
 <CAHbLzko-oobg2rNO0y-Sgj9ePPEpoFEMmhgBumjzzFFFa=argw@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <80b5b191-222b-493c-0192-80ceb5afafa8@huawei.com>
Date:   Sat, 9 Apr 2022 10:36:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzko-oobg2rNO0y-Sgj9ePPEpoFEMmhgBumjzzFFFa=argw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 1:32, Yang Shi wrote:
> On Fri, Apr 8, 2022 at 1:52 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.04.22 15:03, Miaohe Lin wrote:
>>> PageSwapCache is only reliable when PageAnon is true because PG_swapcache
>>> serves as PG_owner_priv_1 which can be used by fs if it's pagecache page.
>>> So we should test PageAnon to distinguish pagecache page from swapcache
>>> page to avoid false-postive PageSwapCache test.
>>
>> Well, that's not quite correct. Just because a page is PageAnon()
>> doesn't mean that it's in the swapache. It means that it might be in the
>> swapcache but cannot be in the pagecache.
>>
>> Maybe you wanted to say
>>
>> "So we should test PageAnon() to distinguish pagecache pages from
>> anonymous pages."

That's indeed what I want to say.

> 
> Yeah, I agree. The patch looks fine to me with David's comment addressed.

Many thanks for both of you! Will do it in v3.

> 
>>
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/memory-failure.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index ef402b490663..2e97302d62e4 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2262,7 +2262,7 @@ static int __soft_offline_page(struct page *page)
>>>               return 0;
>>>       }
>>>
>>> -     if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>>> +     if (!PageHuge(page) && PageLRU(page) && !PageAnon(page))
>>>               /*
>>>                * Try to invalidate first. This should work for
>>>                * non dirty unmapped page cache pages.
>>
>>
>> --
>> Thanks,
>>
>> David / dhildenb
>>
>>
> .
> 


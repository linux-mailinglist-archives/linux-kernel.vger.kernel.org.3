Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6D4FDC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379859AbiDLKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355890AbiDLJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284369CE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:57:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kd0365x7Tz1HBnN;
        Tue, 12 Apr 2022 16:57:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 16:57:40 +0800
Subject: Re: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-2-linmiaohe@huawei.com>
 <20220411063520.GA3175313@hori.linux.bs1.fc.nec.co.jp>
 <792748d6-3b41-d118-27bd-75e79390ba1a@huawei.com>
 <20220412063724.GB3227993@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <624f330e-a01c-d0d3-82ee-f2f8f55188f2@huawei.com>
Date:   Tue, 12 Apr 2022 16:57:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220412063724.GB3227993@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 14:37, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Apr 11, 2022 at 09:19:26PM +0800, Miaohe Lin wrote:
>> On 2022/4/11 14:35, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Thu, Apr 07, 2022 at 09:03:50PM +0800, Miaohe Lin wrote:
>>>> PageSwapCache is only reliable when PageAnon is true because PG_swapcache
>>>> serves as PG_owner_priv_1 which can be used by fs if it's pagecache page.
>>>> So we should test PageAnon to distinguish pagecache page from swapcache
>>>> page to avoid false-postive PageSwapCache test.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/memory-failure.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index ef402b490663..2e97302d62e4 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -2262,7 +2262,7 @@ static int __soft_offline_page(struct page *page)
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> -	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>>>> +	if (!PageHuge(page) && PageLRU(page) && !PageAnon(page))
>>>>  		/*
>>>>  		 * Try to invalidate first. This should work for
>>>>  		 * non dirty unmapped page cache pages.
>>>> -- 
>>>
>>> I foudn that with this change the following VM_BUG_ON_FOLIO() is triggered
>>> when calling soft-offline for a swapcache.  Maybe we need check both of
>>> PageAnon and PageSwapCache instead of either?
>>>
>>
>> Many thanks for your test! This is my overlook. Sorry about it! :( The root cause is that the page is
>> added into swapcache and lru( so that it can pass the HWPoisonHandlable check) but page anon is not
>> set yet due to page lock is held by __soft_offline_page. So we have the below core dump:
>>
>> [   41.232172] page:0000000033d8a20c refcount:0 mapcount:0 mapping:00000000bc103d88 index:0x36d pfn:0x14359b
>> 										^^^ page is not anon
>>
>> [   41.236576] flags: 0x57ffffc0080415(locked|uptodate|lru|owner_priv_1|swapbacked|node=1|zone=2|lastcpupid=0x1fffff)
>> 								^^^^^^^^^^^^^^^^^^ page is in swapcache
>>
>> It seems we can check !PageAnon(page) && !PageSwapCache(page), as you suggested, to fix this issue. But maybe I
>> should drop this patch because invalidate_inode_page will always return 0 for PageAnon due to folio_mapping == NULL.
>> So nothing is really done for anonymous page here. And the origin !PageSwapCache(page) check should do the right work.
> 
> Thanks for clarification.
> 
>> Or we shouldn't even try to call invalidate_inode_page with anonymous page in principle?
> 
> I think just keeping the current behavior is fine (because as you stated
> above invalidate_inode_page() simple ignores anonymous pages).
> 

Will drop this patch. Sorry for make noise. :(

> Thanks,
> Naoya Horiguchi
> 
>> BTW: PageSwapCache should be reliable here as folio_test_swapbacked is checked implicitly inside it. In such case, PG_swapcache
>> can't serve as PG_owner_priv_1 as pagecache page shouldn't set PG_swapbacked (shmem will set PG_swapbacked but PG_owner_priv_1
>> is not used anyway). Or am I miss something again?


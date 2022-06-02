Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2153B477
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiFBHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFBHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:40:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA731BA0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:40:02 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LDHth2JV9z1K9Ft;
        Thu,  2 Jun 2022 15:38:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 15:40:00 +0800
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
To:     David Hildenbrand <david@redhat.com>
CC:     <ying.huang@intel.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <naoya.horiguchi@nec.com>,
        Minchan Kim <minchan@kernel.org>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-3-linmiaohe@huawei.com>
 <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
 <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
 <4cf144a9-fff5-d993-4fcb-7f2dfa6e71bb@redhat.com>
 <924de987-202b-a97e-e6d2-6bdab530f190@huawei.com>
 <c566dc2c-fc70-e410-5272-767fa28cbba4@redhat.com>
 <025d0dc8-a446-b720-14a8-97c041055f48@huawei.com>
 <143ab5dd-85a9-3338-53b7-e46c9060b20e@redhat.com>
 <6ba7e2bd-28c1-53ff-a6b7-072c79714dee@huawei.com>
 <0724b4c4-15f6-e429-f945-f57c619c7270@redhat.com>
 <7ca676a9-1f51-47f7-0245-d041d075a440@huawei.com>
 <f6eb98ae-965b-d705-6f7d-c2ee69ce5141@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a96fab6c-f986-797f-aeb1-5fb8a1b5a4b8@huawei.com>
Date:   Thu, 2 Jun 2022 15:40:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f6eb98ae-965b-d705-6f7d-c2ee69ce5141@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 18:31, David Hildenbrand wrote:
> On 31.05.22 14:37, Miaohe Lin wrote:
>> On 2022/5/31 19:59, David Hildenbrand wrote:
>>> Sorry for the late reply, was on vacation.
>>
>> That's all right. Hope you have a great time. ;)
>>
>>>
>>>>>>
>>>>>> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
>>>>>> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
>>>>>> this code block works. Or am I miss something again?
>>>>>
>>>>> Let's assume the following: page as freed by the owner and we enter
>>>>> unmap_and_move().
>>>>>
>>>>>
>>>>> #1: enter unmap_and_move() // page_count is 1
>>>>> #2: enter isolate_movable_page() // page_count is 1
>>>>> #2: get_page_unless_zero() // page_count is now 2
>>>>> #1: if (page_count(page) == 1) { // does not trigger
>>>>> #2: put_page(page); // page_count is now 1
>>>>> #1: put_page(page); // page_count is now 0 -> freed
>>>>>
>>>>>
>>>>> #1 will trigger __put_page() -> __put_single_page() ->
>>>>> __page_cache_release() will not clear the flags because it's not an LRU
>>>>> page at that point in time, right (-> isolated)?
>>>>
>>>> Sorry, you're right. I thought the old page will be freed via putback_lru_page which will
>>>> set PageLRU back instead of put_page directly. So if the above race occurs, PG_active and
>>>> PG_unevictable will remain set while page goes to the buddy and check_free_page will complain
>>>> about it. But it seems this is never witnessed?
>>>
>>> Maybe
>>>
>>> a) we were lucky so far and didn't trigger it
>>> b) the whole code block is dead code because we are missing something
>>> c) we are missing something else :)
>>
>> I think I found the things we missed in another email [1].
>> [1]: https://lore.kernel.org/all/948ea45e-3b2b-e16c-5b8c-4c34de0ea593@huawei.com/
>>
>> Paste the main content of [1] here:
>>
>> "
>> There are 3 cases in unmap_and_move:
>>
>> 1.page is freed through "if (page_count(page) == 1)" code block. This works
>> as PG_active and PG_unevictable are cleared here.
>>
>> 2. Failed to migrate the page. The page won't be release so we don't care about it.
> 
> Right, page is un-isolated.
> 
>>
>> 3. The page is migrated successfully. The PG_active and PG_unevictable are cleared
>> via folio_migrate_flags():
>>
>> 	if (folio_test_clear_active(folio)) {
>> 		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
>> 		folio_set_active(newfolio);
>> 	} else if (folio_test_clear_unevictable(folio))
>> 		folio_set_unevictable(newfolio);
> 
> Right.
> 
>>
>> For the above race case, the page won't be freed through "if (page_count(page) == 1)" code block.
>> It will just be migrated and freed via put_page() after folio_migrate_flags() having cleared PG_active
>> and PG_unevictable.
>> "
>> Or Am I miss something again? :)
> 
> For #1, I'm still not sure what would happen on a speculative reference.
> 
> It's worth summarizing that
> 
> a) free_pages_prepare() will clear both flags via page->flags &=
> ~PAGE_FLAGS_CHECK_AT_PREP;
> 
> b) free_pages_prepare() will bail out if any flag is set in
> check_free_page().
> 
> As we've never seen b) in the wild, this certainly has low priority, and
> maybe it really cannot happen right now.
> 
> However, maybe really allowing these flags to be set when freeing the
> page and removing the "page_count(page) == 1" case from migration code
> would be the clean thing to do.

IMHO, check_free_page is used to catch possible problem. There's the comment of PAGE_FLAGS_CHECK_AT_FREE:

/*
 * Flags checked when a page is freed.  Pages being freed should not have
 * these flags set.  If they are, there is a problem.
 */
#define PAGE_FLAGS_CHECK_AT_FREE

There might be an assumption: when page is freed, it shouldn't be an active or unevictable page. It should be
inactive and evictable. So allowing these flags to be set when freeing the page might not be a good idea?

Thanks!

>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B055390E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbiEaMiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbiEaMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:37:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843A3BA58
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:37:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LCBd23WFmzDqZk;
        Tue, 31 May 2022 20:37:42 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 20:37:52 +0800
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7ca676a9-1f51-47f7-0245-d041d075a440@huawei.com>
Date:   Tue, 31 May 2022 20:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0724b4c4-15f6-e429-f945-f57c619c7270@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 19:59, David Hildenbrand wrote:
> Sorry for the late reply, was on vacation.

That's all right. Hope you have a great time. ;)

> 
>>>>
>>>> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
>>>> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
>>>> this code block works. Or am I miss something again?
>>>
>>> Let's assume the following: page as freed by the owner and we enter
>>> unmap_and_move().
>>>
>>>
>>> #1: enter unmap_and_move() // page_count is 1
>>> #2: enter isolate_movable_page() // page_count is 1
>>> #2: get_page_unless_zero() // page_count is now 2
>>> #1: if (page_count(page) == 1) { // does not trigger
>>> #2: put_page(page); // page_count is now 1
>>> #1: put_page(page); // page_count is now 0 -> freed
>>>
>>>
>>> #1 will trigger __put_page() -> __put_single_page() ->
>>> __page_cache_release() will not clear the flags because it's not an LRU
>>> page at that point in time, right (-> isolated)?
>>
>> Sorry, you're right. I thought the old page will be freed via putback_lru_page which will
>> set PageLRU back instead of put_page directly. So if the above race occurs, PG_active and
>> PG_unevictable will remain set while page goes to the buddy and check_free_page will complain
>> about it. But it seems this is never witnessed?
> 
> Maybe
> 
> a) we were lucky so far and didn't trigger it
> b) the whole code block is dead code because we are missing something
> c) we are missing something else :)

I think I found the things we missed in another email [1].
[1]: https://lore.kernel.org/all/948ea45e-3b2b-e16c-5b8c-4c34de0ea593@huawei.com/

Paste the main content of [1] here:

"
There are 3 cases in unmap_and_move:

1.page is freed through "if (page_count(page) == 1)" code block. This works
as PG_active and PG_unevictable are cleared here.

2. Failed to migrate the page. The page won't be release so we don't care about it.

3. The page is migrated successfully. The PG_active and PG_unevictable are cleared
via folio_migrate_flags():

	if (folio_test_clear_active(folio)) {
		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
		folio_set_active(newfolio);
	} else if (folio_test_clear_unevictable(folio))
		folio_set_unevictable(newfolio);

For the above race case, the page won't be freed through "if (page_count(page) == 1)" code block.
It will just be migrated and freed via put_page() after folio_migrate_flags() having cleared PG_active
and PG_unevictable.
"
Or Am I miss something again? :)

> 
>>
>>>
>>> We did not run that code block that would clear PG_active and
>>> PG_unevictable.
>>>
>>> Which still leaves the questions:
>>>
>>> a) If PG_active and PG_unevictable was cleared, where?
>>
>> For LRU pages, PG_active and PG_unevictable are cleared via __page_cache_release. And for isolated
>> (LRU) pages, PG_active and PG_unevictable should be cleared ourselves?
>>
>>> b) Why is that code block that conditionally clears the flags of any
>>> value and why can't we simply drop it?
>>>
>>
>> To fix the issue, should we clear PG_active and PG_unevictable unconditionally here?
> 
> I wonder if we should simply teach actual freeing code to simply clear
> both flags when freeing an isolated page? IOW, to detect "isolated LRU"
> is getting freed and fixup?

IMHO, clearing both flags are done by the caller indeed. Another example I found when I
read the khugepaged code recently is pasted below:

collapse_file
	...
	page_ref_unfreeze(page, 1);
	ClearPageActive(page);
	ClearPageUnevictable(page);
	unlock_page(page);
	put_page(page);
	index++;
	...

Thanks!

> 

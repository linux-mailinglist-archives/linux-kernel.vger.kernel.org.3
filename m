Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826DE524E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354418AbiELN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354384AbiELN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:27:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C149F97
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:26:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KzXbr19WqzgYsx;
        Thu, 12 May 2022 21:26:16 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 21:26:45 +0800
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <025d0dc8-a446-b720-14a8-97c041055f48@huawei.com>
Date:   Thu, 12 May 2022 21:26:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c566dc2c-fc70-e410-5272-767fa28cbba4@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 15:10, David Hildenbrand wrote:
>>> If PG_isolated is still set, it will get cleared in the buddy when
>>> freeing the page via
>>>
>>> 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>>
>> Yes, check_free_page only complains about flags belonging to PAGE_FLAGS_CHECK_AT_FREE and PG_isolated
>> will be cleared in the buddy when freeing the page. But it might not be a good idea to reply on this ?
>> IMHO, it should be better to clear the PG_isolated explicitly ourselves.
> 
> I think we can pretty much rely on this handling in the buddy :)

So is the below code change what you're suggesting?

	if (page_count(page) == 1) {
		/* page was freed from under us. So we are done. */
		ClearPageActive(page);
		ClearPageUnevictable(page);
-		if (unlikely(__PageMovable(page)))
-			ClearPageIsolated(page);
		goto out;
	}
> 
>>
>>>
>>>>
>>>>>
>>>>>
>>>>> Also, I am not sure how reliable that page count check is here: if we'd
>>>>> have another speculative reference to the page, we might see
>>>>> "page_count(page) > 1" and not take that path, although the previous
>>>>> owner released the last reference.
>>>>
>>>> IIUC, there should not be such speculative reference. The driver should have taken care
>>>> of it.
>>>
>>> How can you prevent any kind of speculative references?
>>>
>>> See isolate_movable_page() as an example, which grabs a speculative
>>> reference to then find out that the page is already isolated by someone
>>> else, to then back off.
>>
>> You're right. isolate_movable_page will be an speculative references case. But the page count check here
>> is just an optimization. If we encounter speculative references, it still works with useless effort of
>> migrating to be released page.
> 
> 
> Not really. The issue is that PAGE_FLAGS_CHECK_AT_FREE contains
> PG_active and PG_unevictable.
> 
> We only clear those 2 flags if "page_count(page) == 1". Consequently,
> with a speculative reference, we'll run into the check_free_page_bad()
> when dropping the last reference.

It seems if a speculative reference happens after the "page_count(page) == 1" check,
it's ok because we cleared the PG_active and PG_unevictable. And if it happens before
the check, this code block is skipped and the page will be freed after migration. The
PG_active and PG_unevictable will be correctly cleared when page is actually freed via
__folio_clear_active. (Please see below comment)

> 
> This is just shaky. Special casing on "page_count(page) == 1" for
> detecting "was this freed by the owner" is not 100% water proof.
> 
> In an ideal world, we'd just get rid of that whole block of code and let
> the actual freeing code clear PG_active and PG_unevictable. But that
> would require changes to free_pages_prepare().
> 
> 
> Now I do wonder, if we ever even have PG_active or PG_unevictable still
> set when the page was freed by the owner in this code. IOW, maybe that
> is dead code as well and we can just remove the whole shaky
> "page_count(page) == 1" code block.

Think about below common scene: Anonymous page is actively used by the sole owner process, so it
will have PG_active set. Then process exited while vm tries to migrate that page. So the page
should have refcnt == 1 while PG_active is set? Note normally PG_active should be cleared when
the page is released:

__put_single_page
  PageLRU
    __clear_page_lru_flags
      __folio_clear_active
      __folio_clear_unevictable

But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
this code block works. Or am I miss something again?

Thanks!

> 
> Ccing Minchan, who added clearing of the pageflags at that point.
> 


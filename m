Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4351F775
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiEII7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiEIIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:55:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583BA1B7AD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:51:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxZbC663yzGpfG;
        Mon,  9 May 2022 16:48:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 16:51:42 +0800
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
To:     David Hildenbrand <david@redhat.com>
CC:     <ying.huang@intel.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <naoya.horiguchi@nec.com>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-3-linmiaohe@huawei.com>
 <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
Date:   Mon, 9 May 2022 16:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/4/29 18:07, David Hildenbrand wrote:
> On 25.04.22 15:27, Miaohe Lin wrote:
>> When non-lru movable page was freed from under us, __ClearPageMovable must
>> have been done. Even if it's not done, ClearPageIsolated here won't hurt
>> as page will be freed anyway. So we can thus remove unneeded lock page and
>> PageMovable check here.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  mm/migrate.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index b779646665fe..0fc4651b3e39 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1093,12 +1093,8 @@ static int unmap_and_move(new_page_t get_new_page,
>>  		/* page was freed from under us. So we are done. */
>>  		ClearPageActive(page);
>>  		ClearPageUnevictable(page);
>> -		if (unlikely(__PageMovable(page))) {
>> -			lock_page(page);
>> -			if (!PageMovable(page))
>> -				ClearPageIsolated(page);
>> -			unlock_page(page);
>> -		}
>> +		if (unlikely(__PageMovable(page)))
>> +			ClearPageIsolated(page);
>>  		goto out;
>>  	}
> 
> Hm, that code+change raises a couple of questions.
> 
> We're doing here the same as in putback_movable_pages(). So I guess the
> difference here is that the caller did release the reference while the
> page was isolated, while we don't assume the same in
> putback_movable_pages().

Agree.

> 
> 
> Shouldn't whoever owned the page have cleared that? IOW, is it even
> valid that we see a movable or isolated page here (WARN/BUG?)?
> 
> At least for balloon compaction, I remember that __PageMovable() is
> properly cleared before freeing it via balloon_page_delete().

z3fold, zsmalloc will do __ClearPageMovable when the page is going to be released.
So I think we shouldn't see a movable page here:

void __ClearPageMovable(struct page *page)
{
	VM_BUG_ON_PAGE(!PageMovable(page), page);
	/*
	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
	 * flag so that VM can catch up released page by driver after isolation.
	 * With it, VM migration doesn't try to put it back.
	 */
	page->mapping = (void *)((unsigned long)page->mapping &
				PAGE_MAPPING_MOVABLE);
}

But it seems there is no guarantee for PageIsolated flag. Or am I miss something?

> 
> 
> Also, I am not sure how reliable that page count check is here: if we'd
> have another speculative reference to the page, we might see
> "page_count(page) > 1" and not take that path, although the previous
> owner released the last reference.

IIUC, there should not be such speculative reference. The driver should have taken care
of it.

Thanks!

> 
> 


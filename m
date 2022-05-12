Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609105242B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbiELCZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiELCZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:25:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB7F0E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:25:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KzFx30hdSzgYxB;
        Thu, 12 May 2022 10:25:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 10:25:39 +0800
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
 <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
 <4cf144a9-fff5-d993-4fcb-7f2dfa6e71bb@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <924de987-202b-a97e-e6d2-6bdab530f190@huawei.com>
Date:   Thu, 12 May 2022 10:25:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4cf144a9-fff5-d993-4fcb-7f2dfa6e71bb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/11 23:23, David Hildenbrand wrote:
> On 09.05.22 10:51, Miaohe Lin wrote:
>> On 2022/4/29 18:07, David Hildenbrand wrote:
snip
>>
>> z3fold, zsmalloc will do __ClearPageMovable when the page is going to be released.
>> So I think we shouldn't see a movable page here:
>>
>> void __ClearPageMovable(struct page *page)
>> {
>> 	VM_BUG_ON_PAGE(!PageMovable(page), page);
>> 	/*
>> 	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
>> 	 * flag so that VM can catch up released page by driver after isolation.
>> 	 * With it, VM migration doesn't try to put it back.
>> 	 */
>> 	page->mapping = (void *)((unsigned long)page->mapping &
>> 				PAGE_MAPPING_MOVABLE);
>> }
>>
>> But it seems there is no guarantee for PageIsolated flag. Or am I miss something?
> 
> At least the code we have now:
> 
> if (unlikely(__PageMovable(page)))
> 	ClearPageIsolated(page);
> 
> Should be dead code. So PG_isolated could remain set.
> 
> If PG_isolated is still set, it will get cleared in the buddy when
> freeing the page via
> 
> 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;

Yes, check_free_page only complains about flags belonging to PAGE_FLAGS_CHECK_AT_FREE and PG_isolated
will be cleared in the buddy when freeing the page. But it might not be a good idea to reply on this ?
IMHO, it should be better to clear the PG_isolated explicitly ourselves.

> 
>>
>>>
>>>
>>> Also, I am not sure how reliable that page count check is here: if we'd
>>> have another speculative reference to the page, we might see
>>> "page_count(page) > 1" and not take that path, although the previous
>>> owner released the last reference.
>>
>> IIUC, there should not be such speculative reference. The driver should have taken care
>> of it.
> 
> How can you prevent any kind of speculative references?
> 
> See isolate_movable_page() as an example, which grabs a speculative
> reference to then find out that the page is already isolated by someone
> else, to then back off.

You're right. isolate_movable_page will be an speculative references case. But the page count check here
is just an optimization. If we encounter speculative references, it still works with useless effort of
migrating to be released page.

Thanks!

> 


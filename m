Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8A4E1EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbiCUCTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbiCUCT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:19:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A441EEFF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:18:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KMJC25BjNzfYqW;
        Mon, 21 Mar 2022 10:16:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 10:18:01 +0800
Subject: Re: [PATCH v4 1/2] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220320051334.44502-1-linmiaohe@huawei.com>
 <20220320051334.44502-2-linmiaohe@huawei.com>
 <YjYC1XaeDPosSIDa@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0d5f2c97-992b-442c-9ecf-26ba363461aa@huawei.com>
Date:   Mon, 21 Mar 2022 10:18:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YjYC1XaeDPosSIDa@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/20 0:20, Matthew Wilcox wrote:
> On Sun, Mar 20, 2022 at 01:13:33PM +0800, Miaohe Lin wrote:
>> invalidate_inode_page() can invalidate the pages in the swap cache because
>> the check of page->mapping != mapping is removed via Matthew's patch titled
>> "mm/truncate: Inline invalidate_complete_page() into its one caller". But
>> invalidate_inode_page() is not expected to deal with the pages in the swap
>> cache. Also non-lru movable page can reach here too. They're not page cache
>> pages. Skip these pages by checking PageSwapCache and PageLRU to fix this
>> unexpected issue.
> 
> I disagree with this changelog.
> 
> invalidate_inode_page() should not be called for pages which are not
> in the page cache.
>
> And then the patch shouldn't test PageLRU (which is actually wrong) or
> PageSwapCache().  It should simply be:
> > +	if (!PageHuge(page) && !PageAnon(page))

If we reach here, the page can be one of the PageHuge, __PageMovable and PageLRU.
If above code is used, __PageMovable can pass the check and enter the invalidate_inode_page
unexpectedly. So I think PageLRU check is necessary here. But it seems PageSwapCache
is only reliable when PageAnon, so might we should do:

+	if (!PageHuge(page) && PageLRU(page) && !PageAnon(page))

Am I miss something? Many thanks for comment.

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 5444a8ef4867..ecf45961f3b6 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2178,7 +2178,7 @@ static int __soft_offline_page(struct page *page)
>>  		return 0;
>>  	}
>>  
>> -	if (!PageHuge(page))
>> +	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>>  		/*
>>  		 * Try to invalidate first. This should work for
>>  		 * non dirty unmapped page cache pages.
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 


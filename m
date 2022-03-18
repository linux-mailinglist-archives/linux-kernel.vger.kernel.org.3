Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004504DD4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiCRGa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiCRGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:30:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185F100758
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:29:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KKYsd3mG4z9sfW;
        Fri, 18 Mar 2022 14:25:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:29:15 +0800
Subject: Re: [PATCH v3 1/2] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <mike.kravetz@oracle.com>
References: <20220318073945.62164-1-linmiaohe@huawei.com>
 <20220318073945.62164-2-linmiaohe@huawei.com>
 <79e0be67-341d-34cb-bb48-30f122d9e239@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9bd4f53c-fba4-f0f5-68d1-4b2acaab4213@huawei.com>
Date:   Fri, 18 Mar 2022 14:29:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <79e0be67-341d-34cb-bb48-30f122d9e239@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/3/17 20:29, David Hildenbrand wrote:
> On 18.03.22 08:39, Miaohe Lin wrote:
>> invalidate_inode_page() can invalidate the pages in the swap cache because
>> the check of page->mapping != mapping is removed via Matthew's patch titled
>> "mm/truncate: Inline invalidate_complete_page() into its one caller". But
>> invalidate_inode_page() is not expected to deal with the pages in the swap
>> cache. Also non-lru movable page can reach here too. They're not page cache
>> pages. Skip these pages by checking PageSwapCache and PageLRU to fix this
>> unexpected issue.
>>
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
> 
> I'm not familiar with this code to ack this, but it looks sane to me.
> 

Thanks David.

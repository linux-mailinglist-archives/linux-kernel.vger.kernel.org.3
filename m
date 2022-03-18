Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6012C4DD4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiCRGaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiCRG3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:29:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E41118
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:28:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKYvY1k6JzfYvf;
        Fri, 18 Mar 2022 14:27:05 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:28:34 +0800
Subject: Re: [PATCH v3 2/2] mm/memory-failure.c: make non-LRU movable pages
 unhandlable
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <naoya.horiguchi@nec.com>, <shy828301@gmail.com>,
        <mike.kravetz@oracle.com>
References: <20220318073945.62164-1-linmiaohe@huawei.com>
 <20220318073945.62164-3-linmiaohe@huawei.com>
 <9f26eccb-d0f3-1c00-dce1-ab7fdd439fbb@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6f613668-6cc8-13eb-df81-1bfc3d9e6f22@huawei.com>
Date:   Fri, 18 Mar 2022 14:28:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9f26eccb-d0f3-1c00-dce1-ab7fdd439fbb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/17 20:11, David Hildenbrand wrote:
> On 18.03.22 08:39, Miaohe Lin wrote:
>> We can not really handle non-LRU movable pages in memory failure. Typically
>> they are balloon, zsmalloc, etc. Assuming we run into a base (4K) non-LRU
>> movable page, we could reach as far as identify_page_state(), it should not
>> fall into any category except me_unknown. For the non-LRU compound movable
>> pages, they could be taken for transhuge pages but it's unexpected to split
>> non-LRU  movable pages using split_huge_page_to_list in memory_failure. So
>> we could just simply make non-LRU  movable pages unhandlable to avoid these
>> possible nasty cases.
>>
>> Suggested-by: Yang Shi <shy828301@gmail.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> ---
>>  mm/memory-failure.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ecf45961f3b6..bf14bea2ed93 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1176,12 +1176,18 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>>   * does not return true for hugetlb or device memory pages, so it's assumed
>>   * to be called only in the context where we never have such pages.
>>   */
>> -static inline bool HWPoisonHandlable(struct page *page)
>> +static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>>  {
>> -	return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
>> +	bool movable = false;
>> +
>> +	/* Soft offline could mirgate non-LRU movable pages */
> 
> s/mirgate/migrate/

OK. My mistake.

> 
>> +	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
>> +		movable = true;
> 
> simply "return true" and drop "bool movable".

OK.

> 
>> +
>> +	return movable || PageLRU(page) || is_free_buddy_page(page);
> 

Many thanks for comment!

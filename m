Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D7547D87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiFMBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiFMBva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:51:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4959D4C79F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:51:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LLvd82cPpzgYpJ;
        Mon, 13 Jun 2022 09:49:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 09:51:27 +0800
Subject: Re: [PATCH v2] mm/page_alloc: minor clean up for
 memmap_init_compound()
To:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220611021352.13529-1-linmiaohe@huawei.com>
 <YqYJ771HRncznTy1@FVFYT0MHHV2J.googleapis.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <05a774de-12ea-e425-bd9d-b626aafa5831@huawei.com>
Date:   Mon, 13 Jun 2022 09:51:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YqYJ771HRncznTy1@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/12 23:44, Muchun Song wrote:
> On Sat, Jun 11, 2022 at 10:13:52AM +0800, Miaohe Lin wrote:
>> Since commit 5232c63f46fd ("mm: Make compound_pincount always available"),
>> compound_pincount_ptr is stored at first tail page now. So we should call
>> prep_compound_head() after the first tail page is initialized to take
>> advantage of the likelihood of that tail struct page being cached given
>> that we will read them right after in prep_compound_head().
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> v2:
>>   Don't move prep_compound_head() outside loop per Joao.
>> ---
>>  mm/page_alloc.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 4c7d99ee58b4..048df5d78add 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
>>  		set_page_count(page, 0);
>>  
>>  		/*
>> -		 * The first tail page stores compound_mapcount_ptr() and
>> -		 * compound_order() and the second tail page stores
>> -		 * compound_pincount_ptr(). Call prep_compound_head() after
>> -		 * the first and second tail pages have been initialized to
>> -		 * not have the data overwritten.
>> +		 * The first tail page stores compound_mapcount_ptr(),
>> +		 * compound_order() and compound_pincount_ptr(). Call
>> +		 * prep_compound_head() after the first tail page have
>> +		 * been initialized to not have the data overwritten.
>> +		 *
>> +		 * Note the idea to make this right after we initialize
>> +		 * the offending tail pages is trying to take advantage
>> +		 * of the likelihood of those tail struct pages being
>> +		 * cached given that we will read them right after in
>> +		 * prep_compound_head().
>>  		 */
>> -		if (pfn == head_pfn + 2)
>> +		if (unlikely(pfn == head_pfn + 1))
>>  			prep_compound_head(head, order);
> 
> For me it is weird not to put this out of the loop. I saw the reason
> is because of the caching suggested by Joao. But I think this is not
> a hot path and putting it out of the loop may be more intuitive at least
> for me.  Maybe this optimization is unnecessary (maybe I am wrong).
> And it will be consistent with prep_compound_page() (at least it does
> not do the similar optimization) if we drop this optimization.

This is also what I thought in the first version. :)

> 
> Hi Joao,
> 
> I am wondering is it a significant optimization for zone device memory?
> I found this code existed from the 1st version you introduced.  So
> I suspect maybe you have some numbers, would you like to share with us?

Those numbers would be really helpful.

> 
> Thanks.

Thanks!

> 
> .
> 


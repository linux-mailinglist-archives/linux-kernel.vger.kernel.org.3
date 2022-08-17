Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C66659670B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiHQBxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbiHQBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:53:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83B5756E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:53:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6rZC4SzczkWRb;
        Wed, 17 Aug 2022 09:50:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:53:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 1/6] mm/hugetlb: fix incorrect update of max_huge_pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-2-linmiaohe@huawei.com> <YvwfvxXewnZpHQcz@monkey>
 <20220816162024.60087b143995d9e21413fc52@linux-foundation.org>
 <Yvwpl/RD9tLr6HJE@monkey>
Message-ID: <5eebaeff-c002-2a1e-b5bb-fffe7e987ca0@huawei.com>
Date:   Wed, 17 Aug 2022 09:53:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yvwpl/RD9tLr6HJE@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/17 7:34, Mike Kravetz wrote:
> On 08/16/22 16:20, Andrew Morton wrote:
>> On Tue, 16 Aug 2022 15:52:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>>> On 08/16/22 21:05, Miaohe Lin wrote:
>>>> There should be pages_per_huge_page(h) / pages_per_huge_page(target_hstate)
>>>> pages incremented for target_hstate->max_huge_pages when page is demoted.
>>>> Update max_huge_pages accordingly for consistency.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/hugetlb.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index ea1c7bfa1cc3..e72052964fb5 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>>>>  	 * based on pool changes for the demoted page.
>>>>  	 */
>>>>  	h->max_huge_pages--;
>>>> -	target_hstate->max_huge_pages += pages_per_huge_page(h);
>>>> +	target_hstate->max_huge_pages +=
>>>> +		pages_per_huge_page(h) / pages_per_huge_page(target_hstate);
>>>
>>> Thanks!
>>>
>>> That is indeed incorrect.  However the miscalculation should not have any 
>>> consequences.  Correct?  The value is used when initially populating the
>>> pools.  It is never read and used again.  It is written to in
>>> set_max_huge_pages if someone changes the number of hugetlb pages.
>>>
>>> I guess that is a long way of saying I am not sure why we care about trying
>>> to keep max_huge_pages up to date?  I do not think it matters.
>>>
>>> I also thought, if we are going to adjust max_huge_pages here we may
>>> also want to adjust the node specific value: h->max_huge_pages_node[node].
>>> There are a few other places where the global max_huge_pages is adjusted
>>> without adjusting the node specific value.
>>>
>>> The more I think about it, the more I think we should explore just
>>> eliminating any adjustment of this/these values after initially
>>> populating the pools.
>>
>> I'm thinking we should fix something that is "indeed incorrect" before
>> going on to more extensive things?
> 
> Sure, I am good with that.
> 
> Just wanted to point out that the incorrect calculation does not have
> any negative consequences.  Maybe prompting Miaohe to look into the more
> extensive cleanup.

Many thanks both. I will try to do this "more extensive cleanup" after pending work is done.

Thanks,
Miaohe Lin



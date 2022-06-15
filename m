Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD154C2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiFOHgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiFOHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:36:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8748303
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:35:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LNHCR0xhTzDqnP;
        Wed, 15 Jun 2022 15:35:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:35:56 +0800
Subject: Re: [PATCH v2] mm/page_alloc: minor clean up for
 memmap_init_compound()
To:     Joao Martins <joao.m.martins@oracle.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20220611021352.13529-1-linmiaohe@huawei.com>
 <YqYJ771HRncznTy1@FVFYT0MHHV2J.googleapis.com>
 <17807dce-0894-08b9-d53a-55e3696d6c08@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9819ab1c-e063-91a2-8866-e20e3f3813c5@huawei.com>
Date:   Wed, 15 Jun 2022 15:35:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <17807dce-0894-08b9-d53a-55e3696d6c08@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/6/14 18:33, Joao Martins wrote:
> [was out the past couple days, hence the late response]
> 
> On 6/12/22 16:44, Muchun Song wrote:
>> On Sat, Jun 11, 2022 at 10:13:52AM +0800, Miaohe Lin wrote:
>>> Since commit 5232c63f46fd ("mm: Make compound_pincount always available"),
>>> compound_pincount_ptr is stored at first tail page now. So we should call
>>> prep_compound_head() after the first tail page is initialized to take
>>> advantage of the likelihood of that tail struct page being cached given
>>> that we will read them right after in prep_compound_head().
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> v2:
>>>   Don't move prep_compound_head() outside loop per Joao.
>>> ---
>>>  mm/page_alloc.c | 17 +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 4c7d99ee58b4..048df5d78add 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
>>>  		set_page_count(page, 0);
>>>  
>>>  		/*
>>> -		 * The first tail page stores compound_mapcount_ptr() and
>>> -		 * compound_order() and the second tail page stores
>>> -		 * compound_pincount_ptr(). Call prep_compound_head() after
>>> -		 * the first and second tail pages have been initialized to
>>> -		 * not have the data overwritten.
>>> +		 * The first tail page stores compound_mapcount_ptr(),
>>> +		 * compound_order() and compound_pincount_ptr(). Call
>>> +		 * prep_compound_head() after the first tail page have
>>> +		 * been initialized to not have the data overwritten.
>>> +		 *
>>> +		 * Note the idea to make this right after we initialize
>>> +		 * the offending tail pages is trying to take advantage
>>> +		 * of the likelihood of those tail struct pages being
>>> +		 * cached given that we will read them right after in
>>> +		 * prep_compound_head().
>>>  		 */
>>> -		if (pfn == head_pfn + 2)
>>> +		if (unlikely(pfn == head_pfn + 1))
>>>  			prep_compound_head(head, order);
>>
>> For me it is weird not to put this out of the loop. I saw the reason
>> is because of the caching suggested by Joao. But I think this is not
>> a hot path and putting it out of the loop may be more intuitive at least
>> for me.  Maybe this optimization is unnecessary (maybe I am wrong).
> 
> So, depending on your setup, this might actually sit in the boot path. Yes, it is at
> bringup/teardown of new memory, so it does not sit in a 'hot path' and struct pages are
> cold. But it is part of a function that initialiazes a whole DIMM worth of struct pages.
> And PMEM dimms can be denser than RAM ones IIRC. In my case we usually have 128G PMEM
> DIMMs in our servers.
> 
>> And it will be consistent with prep_compound_page() (at least it does
>> not do the similar optimization) if we drop this optimization.
>>
>> Hi Joao,
>>
>> I am wondering is it a significant optimization for zone device memory?
>> I found this code existed from the 1st version you introduced. 
> 
> Not quite. It did not existed in the RFC. As a matter of fact the very first
> version was totally ignoring anything cache related (i.e. just calling
> prep_compound_page() in the loop for all struct pages after all the struct pages were
> inited) until Dan suggested I fix that part because people in the past have spent time
> optimizing it.
> 
>> So
>> I suspect maybe you have some numbers, would you like to share with us?
>>
> 
> 128G DIMMs /with struct pages placed in DRAM/ with 2M page size used to take around
> 250-400ms. Now once you placed the struct pages in PMEM those numbers go up to 4 secs all
> the way up to 8secs (there's a lot of high variance). Now imagine 12 dimms and those
> numbers can get in the ranges of 3 - 4.8secs for DRAM-struct-pages, and with
> PMEM-struct-pages to more than 48secs.
> 
> Note that initializing as compound pages brought those numbers closer in the middle
> of the interval given that we need to do more work other than just initializing the
> raw struct page. With DRAM struct pages with the vmemmap deduplication trick (which is now
> default used) these got decreased down to 80-110ms per DIMM. But I actually got started
> with numbers in the order of ~180-190ms per pmem DIMM (ignore cache effects). I should
> note that I haven't measured /exactly/ the benefit of prep_compound_head() early calling.
> But the other numbers help gauging the cache effects in this path.
> 
> Earlier (in v1) I merely expressed a minor concern. /Maybe/ this matters or maybe the cost

Many thanks for your detailed explanation. In v1, I thought you do have the numbers that show
the cache-miss avoidance of the succeeding two tail page cache-lines per 2M page does matter.
That's my bad. Sorry.

> of prep_compound_head() outweighs the cache-miss avoidance of the succeeding two tail page
> cache-lines per 2M page. Well, now it's one tail page. Nonetheless, I would expect that
> this is part of the testing the submitter performs, given that this is not one of those

Am I supposed to provide the numbers that show how cache effects? The number I can provide now
will be based on the emulated pmem device due to lacking of real pmem device (because we're
under control, that's a pity :( ). That number might not be wanted because the struct pages will
always be placed in DRAM. Any suggestions? It's very kind of you if you can help provide
this number. :)

> 'no functional change' patches as written in v1 commit message :( Should that be the case,
> then let's go with v1 as that certainly brings consistency with prep_compound_page().

Many thanks!

> .
> 

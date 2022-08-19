Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8175995DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbiHSHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345710AbiHSHU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:20:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB69C9925
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:20:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M8ClJ152MznTV7;
        Fri, 19 Aug 2022 15:18:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:20:17 +0800
Subject: Re: [bug report] mm/hugetlb: various bugs with avoid_reserve case in
 alloc_huge_page()
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d449c6d1-314f-5b90-6d68-3773e2722d7f@huawei.com>
 <Yv7AlZyNaAgpB4Qg@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5b1b60d6-e699-2330-0b6f-14c8dd5d78d4@huawei.com>
Date:   Fri, 19 Aug 2022 15:20:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yv7AlZyNaAgpB4Qg@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/8/19 6:43, Mike Kravetz wrote:
> On 08/17/22 16:31, Miaohe Lin wrote:
>> Hi all:
>>     When I investigate the mm/hugetlb.c code again, I found there are a few possible issues
>> with avoid_reserve case. (It's really hard to follow the relevant code for me.) Please take
>> a look at the below analysis:
> 
> Thank you for taking a close look at this code!
> 
> I agree that the code is hard to follow.  I have spent many hours/days/weeks
> chasing down the cause of incorrect reservation counts.  I imagine there could
> be more issues, especially when you add the uncommon avoid_reserve and
> MAP_NORESERVE processing.

Many thanks for your time and reply, Mike!

> 
>> 1.avoid_reserve issue with h->resv_huge_pages in alloc_huge_page.
> 
> Did you actually see this issue, or is it just based on code inspection?

No, it's based on code inspection. ;)

> I tried to recreate, but could not.  When looking closer, this may not
> even be possible.
> 
>>     Assume:
>> 	h->free_huge_pages 60
>> 	h->resv_huge_pages 30
>> 	spool->rsv_hpages  30
> 
> OK.
> 
>>
>>     When avoid_reserve is true, after alloc_huge_page(), we will have:
> 
> Take a close look at the calling paths for alloc_huge_page when avoid_reserve
> is true.  There are only two such call paths.
> 1) copy_hugetlb_page_range - We allocate pages in the 'early COW' processing.
>    In such cases, the pages are private and not associated with a file, or
>    filesystem or subpool (spool).  Therefore, there should be no spool
>    modifications.

Agree.

> 2) hugetlb_wp (formerly called hugetlb_cow) - Again, we are allocating a
>    private page and should not be modifying spool.

Agree.

> 
> If the above is correct, then we will not modify spool->rsv_hpages which
> leads to the inconsistent results.

I missed to verify whether spool will be modified in avoid_reserve case. Sorry about that.

> 
> It is confusing that MAP_NORESERVE does not imply avoid_reserve will be
> passed to alloc_huge_page.

It's introduced to guarantee that COW faults for a process that called mmap(MAP_PRIVATE) will succeed via commit
04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed").
It seems it has nothing to do with MAP_NORESERVE.

> 
>> 	spool->rsv_hpages  29 /* hugepage_subpool_get_pages decreases it. */
>> 	h->free_huge_pages 59
>> 	h->resv_huge_pages 30 /* rsv_hpages is used, but *h->resv_huge_pages is not modified accordingly*. */
>>
>>     If the hugetlb page is freed later, we will have:
>> 	spool->rsv_hpages  30 /* hugepage_subpool_put_pages increases it. */
>> 	h->free_huge_pages 60
>> 	h->resv_huge_pages 31 /* *increased wrongly* due to hugepage_subpool_put_pages(spool, 1) == 0. */
>> 			   ^^
>>
> 
> I'll take a closer look at 2 and 3 when we determine if 1 is a possible
> issue or not.

I want to propose removing the avoid_reserve code. When called from above case 1) or 2), vma_needs_reservation()
will always return 1 as there's no reservation for it. Also hugepage_subpool_get_pages() will always return 1 as
it's not associated with a spool. So when avoid_reserve == true, map_chg and gbl_chg must be 1 and vma_has_reserves()
will always return "false". As a result, passing in avoid_reserve == true will do nothing in fact. So it can be simply
removed. Or am I miss something again?

If avoid_reserve code can be removed, below issue 2 and 3 won't be possible as they rely on avoid_reserve doing its work.

Thanks!
Miaohe Lin

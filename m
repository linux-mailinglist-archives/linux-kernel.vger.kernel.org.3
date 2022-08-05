Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628258A4C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiHECdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiHECdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:33:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BB17A84
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:33:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LzV1c5Z2zzjXl1;
        Fri,  5 Aug 2022 10:30:12 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 10:33:17 +0800
Subject: Re: [bug report] mm, hwpoison: memory_failure races with
 alloc_fresh_huge_page/free_huge_page
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <3c542543-0965-ef60-4627-1a4116077a5b@huawei.com>
 <Yuii5FnAXe/q7fx/@FVFYT0MHHV2J>
 <f2ad010b-b3bf-77c9-2256-701114b5d57e@huawei.com>
 <20220804074025.GA2551573@ik1-406-35019.vs.sakura.ne.jp>
 <20220804074444.GB2551573@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e583b5cb-8d42-1fbb-d816-f5c95caf8a16@huawei.com>
Date:   Fri, 5 Aug 2022 10:33:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220804074444.GB2551573@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/4 15:44, Naoya Horiguchi wrote:
> On Thu, Aug 04, 2022 at 04:40:25PM +0900, Naoya Horiguchi wrote:
>> On Tue, Aug 02, 2022 at 02:27:36PM +0800, Miaohe Lin wrote:
>>> On 2022/8/2 12:07, Muchun Song wrote:
>>>> On Tue, Aug 02, 2022 at 10:00:50AM +0800, Miaohe Lin wrote:
>>>>> Hi all:
>>>>>     When I investigate the mm/memory-failure.c code again, I found there's a possible race window
>>>>> between memory_failure and alloc_fresh_huge_page/free_huge_page. Thank about the below scene:
>>>>>
>>>>> CPU 1							CPU 2
>>>>> alloc_fresh_huge_page -- page refcnt > 0		memory_failure
>>>>>   prep_new_huge_page					  get_huge_page_for_hwpoison
>>>>> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
>>>>>     hugetlb_vmemmap_optimize -- subpages is read-only
>>>>>     set_compound_page_dtor -- PageHuge is true now, but too late!!!
>>>>> 							  TestSetPageHWPoison(p)
>>>>> 							    -- We might write to read-only subpages here!!!
>>>>>
>>>>> Another similar scene:
>>>>>
>>>>> CPU 1							CPU 2
>>>>> free_huge_page -- page refcnt == 0 and not PageHuge	memory_failure
>>>>> 							  get_huge_page_for_hwpoison
>>>>> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
>>>>> 							  TestSetPageHWPoison(p)
>>>>> 							    -- We might write to read-only subpages here!!!
>>>>>   hugetlb_vmemmap_restore -- subpages can be written to now, but too late!!!
>>>>>
>>>>
>>>> I agree this race is possible, I have proposed this race in thread [1].
>>
>> Thank you for reminding this, and I agree that we need some solution.
>>
>>>
>>> Oh, I remember I see the race proposed in [1] but I did not look into that carefully at that time. Sorry.
>>>
>>>> But I didn't think more how to solve it.
>>> I hope this thread can find a good solution. :)
>>
>> Both of the races show that __get_huge_page_for_hwpoison() fails to
>> capture the case of generic compound page during turning into hugetlb,
> 
> I noticed my wrong description just after sending this out. The second race
> is about generic compound page turning into "buddy", sorry.

Never mind. Thanks for your thought.

> 
> - Naoya Horiguchi
> 
>> What makes things complicated is that no one knows to which state
>> such a compound page finally turns into. So I think that if the page
>> to be handled is an unknown compound page, we need to wait until it
>> becomes some known page state to avoid misjudging.
>>
>> If we need a quick small fix, we may replace the check "!PageHeadHuge()"
>> in __get_huge_page_for_hwpoison() with "!PageCompound()", and add another
>> retry path in get_huge_page_for_hwpoison() for non-hugetlb compound pages.

Sounds like a good idea. If we can figure out a stable way to tell it from other
compound page, it will be worth fixing it. Let's have a try. :)

>>
>> Thanks,
>> Naoya Horiguchi

Many thanks for your suggestion, Naoya.

> .
> 


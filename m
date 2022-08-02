Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94C5587715
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiHBG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiHBG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:27:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C04A1A385
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:27:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LxlMS2cKmz1M8Sv;
        Tue,  2 Aug 2022 14:24:36 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 14:27:36 +0800
Subject: Re: [bug report] mm, hwpoison: memory_failure races with
 alloc_fresh_huge_page/free_huge_page
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <3c542543-0965-ef60-4627-1a4116077a5b@huawei.com>
 <Yuii5FnAXe/q7fx/@FVFYT0MHHV2J>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f2ad010b-b3bf-77c9-2256-701114b5d57e@huawei.com>
Date:   Tue, 2 Aug 2022 14:27:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yuii5FnAXe/q7fx/@FVFYT0MHHV2J>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/8/2 12:07, Muchun Song wrote:
> On Tue, Aug 02, 2022 at 10:00:50AM +0800, Miaohe Lin wrote:
>> Hi all:
>>     When I investigate the mm/memory-failure.c code again, I found there's a possible race window
>> between memory_failure and alloc_fresh_huge_page/free_huge_page. Thank about the below scene:
>>
>> CPU 1							CPU 2
>> alloc_fresh_huge_page -- page refcnt > 0		memory_failure
>>   prep_new_huge_page					  get_huge_page_for_hwpoison
>> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
>>     hugetlb_vmemmap_optimize -- subpages is read-only
>>     set_compound_page_dtor -- PageHuge is true now, but too late!!!
>> 							  TestSetPageHWPoison(p)
>> 							    -- We might write to read-only subpages here!!!
>>
>> Another similar scene:
>>
>> CPU 1							CPU 2
>> free_huge_page -- page refcnt == 0 and not PageHuge	memory_failure
>> 							  get_huge_page_for_hwpoison
>> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
>> 							  TestSetPageHWPoison(p)
>> 							    -- We might write to read-only subpages here!!!
>>   hugetlb_vmemmap_restore -- subpages can be written to now, but too late!!!
>>
> 
> I agree this race is possible, I have proposed this race in thread [1].

Oh, I remember I see the race proposed in [1] but I did not look into that carefully at that time. Sorry.

> But I didn't think more how to solve it.
I hope this thread can find a good solution. :)

> 
> [1] https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#ma094a7cea7df8fd9a77a91551bf39077d89e23bd
> 
>> I think the above scenes are possible. But I can't found a stable solution to fix it. Any suggestions?
>> Or is it not worth to fix it as it's too rare? Or am I miss something?
>>
> 
> Luckily, the system will panic at once, which encountering this race. However,
> we don't see any bug report. If we have an easy way to fix it, I think it is worth.

Agree. But I can't find a easy way to fix it yet.

> Just a quick reply, no suggestion/solutions from me.

Many thanks for your quick reply.

> 
> Thanks.
> 
>> Any response would be appreciated!
>>
>> Thanks!
>>
> .
> 


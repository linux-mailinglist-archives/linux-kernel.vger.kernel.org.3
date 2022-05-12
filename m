Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24746524B79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353242AbiELLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353195AbiELLUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:20:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C943135C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:18:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KzTgH6g7nzCsZR;
        Thu, 12 May 2022 19:14:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 19:18:51 +0800
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
 <20220512043253.GA242760@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7395dbe7-7be6-6ef7-7728-a118471caa5a@huawei.com>
Date:   Thu, 12 May 2022 19:18:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220512043253.GA242760@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 12:32, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, May 11, 2022 at 11:35:55AM -0700, Mike Kravetz wrote:
>> On 5/11/22 08:19, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> If memory_failure() fails to grab page refcount on a hugetlb page
>>> because it's busy, it returns without setting PG_hwpoison on it.
>>> This not only loses a chance of error containment, but breaks the rule
>>> that action_result() should be called only when memory_failure() do
>>> any of handling work (even if that's just setting PG_hwpoison).
>>> This inconsistency could harm code maintainability.
>>>
>>> So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.
>>>
>>> Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> ---
>>>  include/linux/mm.h  | 1 +
>>>  mm/memory-failure.c | 8 ++++----
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index d446e834a3e5..04de0c3e4f9f 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -3187,6 +3187,7 @@ enum mf_flags {
>>>  	MF_MUST_KILL = 1 << 2,
>>>  	MF_SOFT_OFFLINE = 1 << 3,
>>>  	MF_UNPOISON = 1 << 4,
>>> +	MF_NO_RETRY = 1 << 5,
>>>  };
>>>  extern int memory_failure(unsigned long pfn, int flags);
>>>  extern void memory_failure_queue(unsigned long pfn, int flags);
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 6a28d020a4da..e3269b991016 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1526,7 +1526,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>>  			count_increased = true;
>>>  	} else {
>>>  		ret = -EBUSY;
>>> -		goto out;
>>> +		if (!(flags & MF_NO_RETRY))
>>> +			goto out;
>>>  	}
>>
>> Hi Naoya,
>>
>> We are in the else block because !HPageFreed() and !HPageMigratable().
>> IIUC, this likely means the page is isolated.  One common reason for isolation
>> is migration.  So, the page could be isolated and on a list for migration.
> 
> Yes, and I also detected this issue by testing race between hugepage allocation
> and memory_failure(). 
> 
>>
>> I took a quick look at the hugetlb migration code and did not see any checks
>> for PageHWPoison after a hugetlb page is isolated.  I could have missed
>> something?  If there are no checks, we will read the PageHWPoison page
>> in kernel mode while copying to the migration target.
> 
> Yes, that could happen.  This patch does not affect ongoing hugepage migration.
> But after the migration source hugepage is freed, the PG_hwpoison should work
> to prevent reusing.
> 
>>
>> Is this an issue?  Is is something we need to be concerned with?  Memory
>> errors can happen at any time, and gracefully handling them is best effort.
> 
> Right, so doing nothing for this case could be OK if doing something causes
> some issues or makes code too complicated.  The motivation of this patch is
> that now I think memory_failure() should do something (at least setting
> PG_hwpoison) unless the page is already hwpoisoned or rejected by
> hwpoison_filter(), because of the effect after free as mentioned above.
> 
> This is also expected in other case too. For example, slab is a unhandlable
> type of page, but we do set PG_hwpoison.  This flag should not affect any of
> ongoing slab-related process, but that's OK because it becomes effective
> after the slab page is freed.
> 
> So this patch is intended to align to the behavior.  Allowing hugepage
> migration to do something good using PG_hwpoison seems to me an unsolved
> separate issue.

I tend to agree with Naoya. And could we try to do it better? IMHO, we could do a
get_page_unless_zero here to ensure that hugetlb page migration will fail due to
this extra page reference and thus preventing the page content from being accessed.
Does this work? Or am I miss something?

Thanks!

> 
> Thanks,
> Naoya Horiguchi
> 


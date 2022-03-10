Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DFC4D411A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiCJGZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbiCJGZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:25:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A606E4F8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:23:59 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDf6338g4zcZys;
        Thu, 10 Mar 2022 14:19:07 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 14:23:57 +0800
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
To:     Yang Shi <shy828301@gmail.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
 <20220310000024.GA1577304@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpWV4oP86oe4BXop20KMJqwEmSkpFmZfT+q38hs90oqKA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2a61c5c1-a99b-9da9-b319-90f95a420ab1@huawei.com>
Date:   Thu, 10 Mar 2022 14:23:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpWV4oP86oe4BXop20KMJqwEmSkpFmZfT+q38hs90oqKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/3/10 8:30, Yang Shi wrote:
> On Wed, Mar 9, 2022 at 4:01 PM HORIGUCHI NAOYA(堀口　直也)
> <naoya.horiguchi@nec.com> wrote:
>>
>> On Wed, Mar 09, 2022 at 01:55:30PM -0800, Yang Shi wrote:
>>> On Wed, Mar 9, 2022 at 1:15 AM Naoya Horiguchi
>>> <naoya.horiguchi@linux.dev> wrote:
>>>>
>>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>
>>>> There is a race condition between memory_failure_hugetlb() and hugetlb
>>>> free/demotion, which causes setting PageHWPoison flag on the wrong page
>>>> (which was a hugetlb when memory_failrue() was called, but was removed
>>>> or demoted when memory_failure_hugetlb() is called).  This results in
>>>> killing wrong processes.  So set PageHWPoison flag with holding page lock,
>>>>
>>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>> ---
>>>>  mm/memory-failure.c | 27 ++++++++++++---------------
>>>>  1 file changed, 12 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index ac6492e36978..fe25eee8f9d6 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -1494,24 +1494,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>>         int res;
>>>>         unsigned long page_flags;
>>>>
>>>> -       if (TestSetPageHWPoison(head)) {
>>>> -               pr_err("Memory failure: %#lx: already hardware poisoned\n",
>>>> -                      pfn);
>>>> -               res = -EHWPOISON;
>>>> -               if (flags & MF_ACTION_REQUIRED)
>>>> -                       res = kill_accessing_process(current, page_to_pfn(head), flags);
>>>> -               return res;
>>>> -       }
>>>> -
>>>> -       num_poisoned_pages_inc();
>>>> -
>>>>         if (!(flags & MF_COUNT_INCREASED)) {
>>>>                 res = get_hwpoison_page(p, flags);
>>>
>>> I'm not an expert of hugetlb, I may be wrong. I'm wondering how this
>>> could solve the race? Is the below race still possible?
>>>
>>> __get_hwpoison_page()
>>>   head = compound_head(page)
>>>
>>> hugetlb demotion (1G --> 2M)
>>>   get_hwpoison_huge_page(head, &hugetlb);
>>
>> Thanks for the comment.
>> I assume Miaohe's patch below introduces additional check to detect the
>> race.  The patch calls compound_head() for the raw error page again, so
>> the demotion case should be detected.  I'll make the dependency clear in
>> the commit log.
>>
>> https://lore.kernel.org/linux-mm/20220228140245.24552-2-linmiaohe@huawei.com/
>>
>>>
>>>
>>> Then the head may point to a 2M page, but the hwpoisoned subpage is
>>> not in that 2M range?
>>>
>>>
>>>>                 if (!res) {
>>>>                         lock_page(head);
>>>>                         if (hwpoison_filter(p)) {
>>>> -                               if (TestClearPageHWPoison(head))
>>>> -                                       num_poisoned_pages_dec();
>>>>                                 unlock_page(head);
>>>>                                 return -EOPNOTSUPP;
>>>>                         }
>>>> @@ -1544,13 +1531,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>>         page_flags = head->flags;
>>>>
>>>>         if (hwpoison_filter(p)) {
>>>> -               if (TestClearPageHWPoison(head))
>>>> -                       num_poisoned_pages_dec();
>>>>                 put_page(p);
>>>>                 res = -EOPNOTSUPP;
>>>>                 goto out;
>>>>         }
>>>>
>>>> +       if (TestSetPageHWPoison(head))
>>>
>>> And I don't think "head" is still the head you expected if the race
>>> happened. I think we need to re-retrieve the head once the page
>>> refcount is bumped and locked.
>>
>> I think the above justification works for this.
>> When the kernel reaches this line, the hugepage is properly pinned without being
>> freed or demoted, so "head" is still pointing to the same head page as expected.
> 
> I think Mike's comment in the earlier email works for this too. The
> huge page may get demoted before the page is pinned and locked, so the
> actual hwpoisoned subpage may belong to another smaller huge page now.
> 

I thinks Naoya assumes that there is a check before we use "head":

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5444a8ef4867..0d7c58340a98 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1534,6 +1534,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	}

 	lock_page(head);
+
+	/**
+	 * The page could have changed compound pages due to race window.
+	 * If this happens just bail out.
+	 */
+	if (!PageHuge(p) || compound_head(p) != head) {
+		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
+		res = -EBUSY;
+		goto out;
+	}
+
 	page_flags = head->flags;

 	if (hwpoison_filter(p)) {
-- 
from: https://lore.kernel.org/linux-mm/20220228140245.24552-2-linmiaohe@huawei.com/

Thanks.

> 
>>
>> Thanks,
>> Naoya Horiguchi
>>
>>>
>>>> +               goto already_hwpoisoned;
>>>> +
>>>> +       num_poisoned_pages_inc();
>>>> +
>>>>         /*
>>>>          * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>>>>          * simply disable it. In order to make it work properly, we need
>>>> @@ -1576,6 +1566,13 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>>  out:
>>>>         unlock_page(head);
>>>>         return res;
>>>> +already_hwpoisoned:
>>>> +       unlock_page(head);
>>>> +       pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
>>>> +       res = -EHWPOISON;
>>>> +       if (flags & MF_ACTION_REQUIRED)
>>>> +               res = kill_accessing_process(current, page_to_pfn(head), flags);
>>>> +       return res;
>>>>  }
>>>>
>>>>  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>>> --
>>>> 2.25.1
>>>>
> .
> 


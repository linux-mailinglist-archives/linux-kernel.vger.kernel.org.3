Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE347DF13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbhLWGfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:35:05 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59594 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235483AbhLWGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:35:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.VzYrj_1640241298;
Received: from 30.21.164.23(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.VzYrj_1640241298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 14:34:59 +0800
Message-ID: <4f729dd0-2012-8490-e1fc-387f88681f7b@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 14:35:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
To:     "Huang, Ying" <ying.huang@intel.com>, sj@kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
 <87a6gsceo6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <90c5f31f-9e0a-df6d-8639-8a46ee02f9fa@linux.alibaba.com>
 <875yrgc8ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <875yrgc8ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2021 11:22 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 12/23/2021 9:07 AM, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> Hi,
>>>>
>>>> Now on tiered memory system with different memory types, the reclaim path in
>>>> shrink_page_list() already support demoting pages to slow memory node instead
>>>> of discarding the pages. However, at that time the fast memory node memory
>>>> wartermark is already tense, which will increase the memory allocation latency
>>>> during page demotion. So a new method from user space demoting cold pages
>>>> proactively will be more helpful.
>>>>
>>>> We can rely on the DAMON in user space to help to monitor the cold memory on
>>>> fast memory node, and demote the cold pages to slow memory node proactively to
>>>> keep the fast memory node in a healthy state.
>>>>
>>>> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
>>>> and works well from my testing. Any comments are welcome. Thanks.
>>> As a performance optimization patch, it's better to provide some
>>> test
>>> results.
>>
>> Actually this is a functional patch, which adds a new scheme for
>> DAMON. And I think it is too early to measure the performance for the
>> real workload, and more work need to do for DAMON used on tiered
>> memory system (like supporting promotion scheme later).
> 
> I don't think you provide any new functionality except the performance
> influence.

Fair enough. I mean for DAMON.

> And I think proactive demotion itself can show some performance benefit
> already.  Just like we can find the performance benefit in the proactive

Yes, I think so too. But now I am afraid I can not get some obvious 
performance benefit with current linux-next branch on tiered memory 
system, since the promotion patches are not there (yes, I can backport 
them into my local branch to test), meanwhile I may need more tuning for 
the demote scheme (such as tuning min-size, max-size, min-acc, max-acc, 
min-age, max-age to get a better performance) for the real workload. Now 
I just did a small step to add demotiong support for DAMON, so I do not 
expect some obvious performance gain now (more work need to research). 
But same as the proactive reclaim, I think this is on the right way for 
DAMON.

Anyway, maybe some other people also curious the benefit, and I will do 
some measurement with DAMON demote scheme on mysql to show the 
performance results. Or do you have any other measurement suggestion?

> reclaim patchset as below.
> 
> https://lore.kernel.org/lkml/20211019150731.16699-1-sj@kernel.org/
> 
>>> Another question is why we shouldn't do this in user space?  With DAMON,
>>> it's possible to export cold memory regions information to the user
>>> space, then we can use move_pages() to migrate them from DRAM to PMEM.
>>> What's the problem of that?
>>
>> IMO this is the purpose of introducing scheme for DAMON, and you can
>> check more in the Documentation/admin-guide/mm/damon/usage.rst.
>>
>> "
>> Schemes
>> -------
>>
>> For usual DAMON-based data access aware memory management
>> optimizations, users
>> would simply want the system to apply a memory management action to a memory
>> region of a specific access pattern.  DAMON receives such formalized
>> operation
>> schemes from the user and applies those to the target processes.
>> "
> 
> For proactive reclaim, we haven't a user space ABI to reclaim a page of
> a process from memory to disk.  So it appears necessary to add a kernel
> module to do that.
> 
> But for proactive demotion, we already have a user space ABI
> (move_pages()) to demote a page of a process from DRAM to PMEM.  What
> prevents you to do all these in the user space?
> 
> And, I found there are MADV_XXX schemes too.  Where the user space ABIs
> are available already.  TBH, I don't know why we need these given there
> are already user space ABIs.  Maybe this is a question for SeongJae too.

 From my understanding, schemes will simplify the design for user space 
to avoid implementing their own strategy according to the monitoring 
results, and more details in patch[1]. SeongJae may have more input for 
the purpose.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1f366e421c8f69583ed37b56d86e3747331869c3

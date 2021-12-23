Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4147DFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbhLWHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:51:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:18501 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233265AbhLWHvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640245893; x=1671781893;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yDl7c1cSGr6vE9gcdYtOOZek6p25M5pnzVjPC/a0pUU=;
  b=R/Nf+287M6PDAYFlx9egno2mD79pBasgQHtJgrWWjFmJWHUnUIYyPMgo
   aJNRQytROyt+sGVXOo1fpYS8lw8+jdv46EqeeugsoS3+l7xlXI12zCYcD
   83X8nL0nvKEokQHHGSqdspKODs1HmVGqVeDOTbyaYVr8yV53dzpE0pIoE
   vExFdfY+oWxChAmKWIZGwLHXfR927gDSDqlRGtsAZdOcyXYYdEdxzSd40
   E9yjltPzFbfwWY9D1jCa3MpRZAtNo5l4RgtvcOhX2Nk2RWkZlmCpU17sp
   vXOKzu4qgONSVLiTxmji6ivxy+3M8FuYgnhrZax4H0kpSGH+6HiGtmxo1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="220789320"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="220789320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 23:51:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521996482"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 23:51:20 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <sj@kernel.org>, <akpm@linux-foundation.org>,
        <dave.hansen@linux.intel.com>, <ziy@nvidia.com>,
        <shy828301@gmail.com>, <zhongjiang-ali@linux.alibaba.com>,
        <xlpang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
        <87a6gsceo6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <90c5f31f-9e0a-df6d-8639-8a46ee02f9fa@linux.alibaba.com>
        <875yrgc8ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <4f729dd0-2012-8490-e1fc-387f88681f7b@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 15:51:18 +0800
In-Reply-To: <4f729dd0-2012-8490-e1fc-387f88681f7b@linux.alibaba.com> (Baolin
        Wang's message of "Thu, 23 Dec 2021 14:35:42 +0800")
Message-ID: <87zgorbvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 12/23/2021 11:22 AM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> On 12/23/2021 9:07 AM, Huang, Ying wrote:
>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> Now on tiered memory system with different memory types, the reclaim path in
>>>>> shrink_page_list() already support demoting pages to slow memory node instead
>>>>> of discarding the pages. However, at that time the fast memory node memory
>>>>> wartermark is already tense, which will increase the memory allocation latency
>>>>> during page demotion. So a new method from user space demoting cold pages
>>>>> proactively will be more helpful.
>>>>>
>>>>> We can rely on the DAMON in user space to help to monitor the cold memory on
>>>>> fast memory node, and demote the cold pages to slow memory node proactively to
>>>>> keep the fast memory node in a healthy state.
>>>>>
>>>>> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
>>>>> and works well from my testing. Any comments are welcome. Thanks.
>>>> As a performance optimization patch, it's better to provide some
>>>> test
>>>> results.
>>>
>>> Actually this is a functional patch, which adds a new scheme for
>>> DAMON. And I think it is too early to measure the performance for the
>>> real workload, and more work need to do for DAMON used on tiered
>>> memory system (like supporting promotion scheme later).
>> I don't think you provide any new functionality except the
>> performance
>> influence.
>
> Fair enough. I mean for DAMON.
>
>> And I think proactive demotion itself can show some performance benefit
>> already.  Just like we can find the performance benefit in the proactive
>
> Yes, I think so too. But now I am afraid I can not get some obvious
> performance benefit with current linux-next branch on tiered memory 
> system, since the promotion patches are not there (yes, I can backport
> them into my local branch to test), meanwhile I may need more tuning
> for the demote scheme (such as tuning min-size, max-size, min-acc,
> max-acc, min-age, max-age to get a better performance) for the real
> workload. Now I just did a small step to add demotiong support for
> DAMON, so I do not expect some obvious performance gain now (more work
> need to research). But same as the proactive reclaim, I think this is
> on the right way for DAMON.
>
> Anyway, maybe some other people also curious the benefit, and I will
> do some measurement with DAMON demote scheme on mysql to show the 
> performance results. Or do you have any other measurement suggestion?

For example, you can run 2 instances of workload, say, instance A and
instance B.  The memory size of instance A + B is larger than the size
of the DRAM.  And `numactl -m <DRAM node>` is used to run the instance,
so that demotion will be triggered when DRAM is used up.  Instance A is
run at first, after some time, say several to tens seconds, instance B
is run.  With the original kernel, demotion will be triggered when run
instance B, long latency may be triggered.  With your patch, the
proactive demotion will be triggered earlier to avoid the long latency
at the cost of performance of instance A (may be just a little).  We can
also compare between DAMON based and the in-kernel LRU based cold page
identification algorithm.

>> reclaim patchset as below.
>> https://lore.kernel.org/lkml/20211019150731.16699-1-sj@kernel.org/
>
>>>> Another question is why we shouldn't do this in user space?  With DAMON,
>>>> it's possible to export cold memory regions information to the user
>>>> space, then we can use move_pages() to migrate them from DRAM to PMEM.
>>>> What's the problem of that?
>>>
>>> IMO this is the purpose of introducing scheme for DAMON, and you can
>>> check more in the Documentation/admin-guide/mm/damon/usage.rst.
>>>
>>> "
>>> Schemes
>>> -------
>>>
>>> For usual DAMON-based data access aware memory management
>>> optimizations, users
>>> would simply want the system to apply a memory management action to a memory
>>> region of a specific access pattern.  DAMON receives such formalized
>>> operation
>>> schemes from the user and applies those to the target processes.
>>> "
>> For proactive reclaim, we haven't a user space ABI to reclaim a page
>> of
>> a process from memory to disk.  So it appears necessary to add a kernel
>> module to do that.
>> But for proactive demotion, we already have a user space ABI
>> (move_pages()) to demote a page of a process from DRAM to PMEM.  What
>> prevents you to do all these in the user space?
>> And, I found there are MADV_XXX schemes too.  Where the user space
>> ABIs
>> are available already.  TBH, I don't know why we need these given there
>> are already user space ABIs.  Maybe this is a question for SeongJae too.
>
> From my understanding, schemes will simplify the design for user space
> to avoid implementing their own strategy according to the monitoring 
> results, and more details in patch[1]. SeongJae may have more input
> for the purpose.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1f366e421c8f69583ed37b56d86e3747331869c3

Thanks a lot for your information.  The commit log is helpful.

It's good to avoid to change the source code of an application to apply
some memory management optimization (for example, use DAMON +
madvise()).  But it's much easier to run a user space daemon to optimize
for the application.  (for example, use DAMON + other information +
process_madvise()).

And this kind of per-application optimization is kind of application
specific policy.  This kind of policy may be too complex and flexible to
be put in the kernel directly.  For example, in addition to DAMON, some
other application specific or system knowledge may be helpful too, so we
have process_madvise() for that before DAMON.  Some more complex
algorithm may be needed for some applications.

And this kind of application specific policy usually need complex
configuration.  It's hard to export all these policy parameters to the
user space as the kernel ABI.  Now, DAMON schemes parameters are
exported in debugfs so they are not considered ABI.  So they may be
changed at any time.  But applications need some stable and
well-maintained ABI.

All in all, IMHO, what we need is a user space per-application policy
daemon with the information from DAMON and other sources.

Best Regards,
Huang, Ying

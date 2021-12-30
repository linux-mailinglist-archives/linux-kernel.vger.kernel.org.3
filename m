Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92AD481B21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 10:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhL3JbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 04:31:03 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50446 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238267AbhL3JbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 04:31:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V0KYLZC_1640856658;
Received: from 30.21.164.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V0KYLZC_1640856658)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 17:30:59 +0800
Message-ID: <feedf554-03bb-ac8a-aa1c-22342b7eac99@linux.alibaba.com>
Date:   Thu, 30 Dec 2021 17:31:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
To:     SeongJae Park <sj@kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
References: <20211228084432.2337-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211228084432.2337-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/2021 4:44 PM, SeongJae Park wrote:
> Hello,
> 
> On Mon, 27 Dec 2021 11:09:56 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> 
>> Hi, SeongJae,
>>
>> SeongJae Park <sj@kernel.org> writes:
>>
>>> Hi,
>>>
>>> On Thu, 23 Dec 2021 15:51:18 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>>
>> [snip]
>>
>>>> It's good to avoid to change the source code of an application to apply
>>>> some memory management optimization (for example, use DAMON +
>>>> madvise()).  But it's much easier to run a user space daemon to optimize
>>>> for the application.  (for example, use DAMON + other information +
>>>> process_madvise()).
>>>>
>>>> And this kind of per-application optimization is kind of application
>>>> specific policy.  This kind of policy may be too complex and flexible to
>>>> be put in the kernel directly.  For example, in addition to DAMON, some
>>>> other application specific or system knowledge may be helpful too, so we
>>>> have process_madvise() for that before DAMON.  Some more complex
>>>> algorithm may be needed for some applications.
>>>>
>>>> And this kind of application specific policy usually need complex
>>>> configuration.  It's hard to export all these policy parameters to the
>>>> user space as the kernel ABI.  Now, DAMON schemes parameters are
>>>> exported in debugfs so they are not considered ABI.  So they may be
>>>> changed at any time.  But applications need some stable and
>>>> well-maintained ABI.
>>>>
>>>> All in all, IMHO, what we need is a user space per-application policy
>>>> daemon with the information from DAMON and other sources.
>>>
>>> I basically agree to Ying, as I also noted in the coverletter of DAMOS
>>> patchset[1]:
>>>
>>>      DAMON[1] can be used as a primitive for data access aware memory
>>>      management optimizations.  For that, users who want such optimizations
>>>      should run DAMON, read the monitoring results, analyze it, plan a new
>>>      memory management scheme, and apply the new scheme by themselves.  Such
>>>      efforts will be inevitable for some complicated optimizations.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fda504fade7f124858d7022341dc46ff35b45274
>>>
>>> That is, I believe some programs and big companies would definitely have their
>>> own information and want such kind of complicated optimizations.  But, such
>>> optimizations would depend on characteristics of each program and require
>>> investment of some amount of resources.  Some other programs and users wouldn't
>>> have such special information, and/or resource to invest for such
>>> optimizations.  For them, some amount of benefit would be helpful enough even
>>> though its sub-optimal.
>>>
>>> I think we should help both groups, and DAMOS could be useful for the second
>>> group.  And I don't think DAMOS is useless for the first group.  They could use
>>> their information-based policy in prallel to DAMOS in some cases.  E.g., if
>>> they have a way to predict the data access pattern of specific memory region
>>> even without help from DAMON, they can use their own policy for the region but
>>> DAMOS for other regions.
>>>
>>> Someone could ask why not implement a user-space implementation for the second
>>> group, then.  First of all, DAMOS is not only for the user-space driven virtual
>>> memory management optimization, but also for kernel-space programs and any
>>> DAMOS-supportable address spaces including the physical address space.  And,
>>> another important goal of DAMOS for user space driven use case in addition to
>>> reducing the redundant code is minimizing the user-kernel context switch
>>> overhead for passing the monitoring results information and memory management
>>> action requests.
>>>
>>> In summary, I agree the user space per-application policy daemon will be useful
>>> for the specialized ultimate optimizations, but we also need DAMOS for another
>>> common group of cases.
>>>
>>> If I'm missing something, please feel free to let me know.
>>
>> I guess that most end-users and quite some system administrators of
>> small companies have no enough capability to take advantage of the
>> per-application optimizations.  How do they know the appropriate region
>> number and proactive reclaim threshold?
>>
>> So per my understanding, Linux kernel
>> need provide,
>>
>> 1. An in-kernel general policy that is obviously correct and benefits
>>     almost all users and applications, at least no regression.  No
>>     complex configuration or deep knowledge is needed to take advantage
>>     of it.
>>
>> 2. Some way to inspect and control system and application behavior, so
>>     that some advanced and customized user space policy daemons can be
>>     built to satisfy some advanced users who have the enough knowledge
>>     for the applications and systems, for example, oomd.
> 
> Agreed, and I think that's the approach that DAMON is currently taking.  In
> specific, we provide DAMON debugfs interface for users who want to inspect and
> control their system and application behavior.  Using it, we also made a PoC
> level user space policy daemon[1].
> 
> For the in-kernel policies, we are developing DAMON-based kernel components one
> by one, for specific usages.  DAMON-based proactive reclamation module
> (DAMON_RECLAIM) is one such example.  Such DAMON-based components will remove
> complex tunables that necessary for the general inspection and control of the
> system but unnecessary for their specific purpose (e.g., proactive reclamation)
> to allow users use it in a simple manner.  Also, those will use conservative
> default configs to not incur visible regression.  For example, DAMON_RECLAIM
> uses only up to 1% of single CPU time for the reclamation by default.
> 
> In short, I think we're on the same page, and adding DEMOTION scheme action
> could be helpful for the users who want to efficiently inspect and control the
> system/application behavior for their tiered memory systems.  It's unclear how

Agree. It will be easier for us to deploy it to the products for the 
common scenarios.

> much benefit this could give to users, though.  I assume Baolin would come back
> with some sort of numbers in the next spin.  Nevertheless, I personally don't

Yes, I am still trying to set up the effective measurement environment 
and get the performance number in the next version.

> think that's a critical blocker, as this patch is essentially just adding a way
> for using the pre-existing primitive, namely move_pages(), in a little bit more
> efficient manner, for the access pattern-based use cases.
> 
> If I'm missing something, please feel free to let me know.
> 
> [1] https://github.com/awslabs/damoos

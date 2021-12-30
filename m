Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D44818E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhL3DQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:16:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:33572 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhL3DQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640834180; x=1672370180;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=2t5bPXysQZ+FhkMTeeSQpsWvp+fPae2O446QyGKxLD4=;
  b=C5QZSnN2LBlRN1eHQFOuww61PnfvBaP9MT+XoLTq6lDe1JEXYxC8mdUM
   4Un405jg5KAocRJ2U20hBF1XGoThVxC8/cFQFrtSalrN9m6u+v0xHgm5r
   EVWg3sP2tv1iFlD1y6ajUUXGVaeYIGeMsJbKGBYrMHjCLGMyTni0BlBFB
   /MWdg2nMdbKx6hQ6hOm0lavKcWDvJO2ELVJhL+kIB8l8T7YWejtW3muBZ
   Y2ZjQi4VkUcpoiyEcY+MWUxj6UbLNJeoVDsR9PW0cN2zMgSyvDdOxWpYg
   8f44LVPlvQAU+mW+2ucEHQ5LfZsEDtWbvABp3gDv+zn7is6oMVXn8NY7h
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241817047"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241817047"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 19:16:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="470524318"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 19:16:17 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
References: <20211229103421.16404-1-sj@kernel.org>
Date:   Thu, 30 Dec 2021 11:16:15 +0800
In-Reply-To: <20211229103421.16404-1-sj@kernel.org> (SeongJae Park's message
        of "Wed, 29 Dec 2021 10:34:21 +0000")
Message-ID: <87tueq6av4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj@kernel.org> writes:

> On Wed, 29 Dec 2021 09:33:56 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> SeongJae Park <sj@kernel.org> writes:
>> 
>> > Hello,
>> >
>> > On Mon, 27 Dec 2021 11:09:56 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>> >
>> >> Hi, SeongJae,
>> >> 
>> >> SeongJae Park <sj@kernel.org> writes:
>> >> 
>> >> > Hi,
>> >> >
>> >> > On Thu, 23 Dec 2021 15:51:18 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>> >> 
>> >> [snip]
>> >> 
>> >> >> It's good to avoid to change the source code of an application to apply
>> >> >> some memory management optimization (for example, use DAMON +
>> >> >> madvise()).  But it's much easier to run a user space daemon to optimize
>> >> >> for the application.  (for example, use DAMON + other information +
>> >> >> process_madvise()).
>> >> >> 
>> >> >> And this kind of per-application optimization is kind of application
>> >> >> specific policy.  This kind of policy may be too complex and flexible to
>> >> >> be put in the kernel directly.  For example, in addition to DAMON, some
>> >> >> other application specific or system knowledge may be helpful too, so we
>> >> >> have process_madvise() for that before DAMON.  Some more complex
>> >> >> algorithm may be needed for some applications.
>> >> >> 
>> >> >> And this kind of application specific policy usually need complex
>> >> >> configuration.  It's hard to export all these policy parameters to the
>> >> >> user space as the kernel ABI.  Now, DAMON schemes parameters are
>> >> >> exported in debugfs so they are not considered ABI.  So they may be
>> >> >> changed at any time.  But applications need some stable and
>> >> >> well-maintained ABI.
>> >> >> 
>> >> >> All in all, IMHO, what we need is a user space per-application policy
>> >> >> daemon with the information from DAMON and other sources.
>> >> >
>> >> > I basically agree to Ying, as I also noted in the coverletter of DAMOS
>> >> > patchset[1]:
>> >> >
>> >> >     DAMON[1] can be used as a primitive for data access aware memory
>> >> >     management optimizations.  For that, users who want such optimizations
>> >> >     should run DAMON, read the monitoring results, analyze it, plan a new
>> >> >     memory management scheme, and apply the new scheme by themselves.  Such
>> >> >     efforts will be inevitable for some complicated optimizations.
>> >> >
>> >> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fda504fade7f124858d7022341dc46ff35b45274
>> >> >
>> >> > That is, I believe some programs and big companies would definitely have their
>> >> > own information and want such kind of complicated optimizations.  But, such
>> >> > optimizations would depend on characteristics of each program and require
>> >> > investment of some amount of resources.  Some other programs and users wouldn't
>> >> > have such special information, and/or resource to invest for such
>> >> > optimizations.  For them, some amount of benefit would be helpful enough even
>> >> > though its sub-optimal.
>> >> >
>> >> > I think we should help both groups, and DAMOS could be useful for the second
>> >> > group.  And I don't think DAMOS is useless for the first group.  They could use
>> >> > their information-based policy in prallel to DAMOS in some cases.  E.g., if
>> >> > they have a way to predict the data access pattern of specific memory region
>> >> > even without help from DAMON, they can use their own policy for the region but
>> >> > DAMOS for other regions.
>> >> >
>> >> > Someone could ask why not implement a user-space implementation for the second
>> >> > group, then.  First of all, DAMOS is not only for the user-space driven virtual
>> >> > memory management optimization, but also for kernel-space programs and any
>> >> > DAMOS-supportable address spaces including the physical address space.  And,
>> >> > another important goal of DAMOS for user space driven use case in addition to
>> >> > reducing the redundant code is minimizing the user-kernel context switch
>> >> > overhead for passing the monitoring results information and memory management
>> >> > action requests.
>> >> >
>> >> > In summary, I agree the user space per-application policy daemon will be useful
>> >> > for the specialized ultimate optimizations, but we also need DAMOS for another
>> >> > common group of cases.
>> >> >
>> >> > If I'm missing something, please feel free to let me know.
>> >> 
>> >> I guess that most end-users and quite some system administrators of
>> >> small companies have no enough capability to take advantage of the
>> >> per-application optimizations.  How do they know the appropriate region
>> >> number and proactive reclaim threshold?
>> >> 
>> >> So per my understanding, Linux kernel
>> >> need provide,
>> >> 
>> >> 1. An in-kernel general policy that is obviously correct and benefits
>> >>    almost all users and applications, at least no regression.  No
>> >>    complex configuration or deep knowledge is needed to take advantage
>> >>    of it.
>> >> 
>> >> 2. Some way to inspect and control system and application behavior, so
>> >>    that some advanced and customized user space policy daemons can be
>> >>    built to satisfy some advanced users who have the enough knowledge
>> >>    for the applications and systems, for example, oomd.
>> >
>> > Agreed, and I think that's the approach that DAMON is currently taking.  In
>> > specific, we provide DAMON debugfs interface for users who want to inspect and
>> > control their system and application behavior.  Using it, we also made a PoC
>> > level user space policy daemon[1].
>> >
>> > For the in-kernel policies, we are developing DAMON-based kernel components one
>> > by one, for specific usages.  DAMON-based proactive reclamation module
>> > (DAMON_RECLAIM) is one such example.  Such DAMON-based components will remove
>> > complex tunables that necessary for the general inspection and control of the
>> > system but unnecessary for their specific purpose (e.g., proactive reclamation)
>> > to allow users use it in a simple manner.  Also, those will use conservative
>> > default configs to not incur visible regression.  For example, DAMON_RECLAIM
>> > uses only up to 1% of single CPU time for the reclamation by default.
>> 
>> I don't think DAMON schemes are the in-kernel general policy I mentioned
>> above (1.).  For example, NUMA balancing is a general policy to optimize
>> performance.  It tries to provide a general policy that works for all
>> users with as few as possible tunables.  If some tunables are needed,
>> they will be provided as ABI.
>
> Exactly.  What I'm saying is, DAMON schemes that exposed to user space via the
> debugfs interface is for inspection of system and development of user space
> daemon (2.).  It requires some level of tuning and doesn't provide stable ABI
> but the debugfs interface.  Meanwhile, DAMON-based kernel components like
> DAMON_RECLAIM can be used for the in-kernel general policy (1.).  For example,
> DAMON_RECLAIM also tries to be beneficial or at least incur no regression for
> almost every users, provides as few as possible tunables, and provides those
> via its ABI (module parameters), not debugfs.

Thanks for your detailed explanation.

Per my understanding, DAMON schemes are kind of building blocks of some
kernel feature such as DAMON_RECLAIM.  Whether do we need a new scheme
depends on whether it's useful as part of some kernel feature.  Do you
agree?

Best Regards,
Huang, Ying

> Thanks,
> SJ
>
>> 
>> Best Regards,
>> Huang, Ying
>> 
>> > In short, I think we're on the same page, and adding DEMOTION scheme action
>> > could be helpful for the users who want to efficiently inspect and control the
>> > system/application behavior for their tiered memory systems.  It's unclear how
>> > much benefit this could give to users, though.  I assume Baolin would come back
>> > with some sort of numbers in the next spin.  Nevertheless, I personally don't
>> > think that's a critical blocker, as this patch is essentially just adding a way
>> > for using the pre-existing primitive, namely move_pages(), in a little bit more
>> > efficient manner, for the access pattern-based use cases. 
>> >
>> > If I'm missing something, please feel free to let me know.
>> >
>> > [1] https://github.com/awslabs/damoos
>> >
>> >
>> > Thanks,
>> > SJ
>> >
>> >> 
>> >> Best Regards,
>> >> Huang, Ying
>> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC8480E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhL2BeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 20:34:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:56762 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238222AbhL2BeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640741641; x=1672277641;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=lxBc1zDeV+EjjbFo1Jd3De1+W3ctRmmfz+0gb8FRAJ0=;
  b=DztQhIa+GzYb+xxnPSRyVk1rZ5NASbnRe8MLiW0Jy88wvfI1uw66cjqI
   ajZfRphv7+cDKLHVHf2Vf9ONu6VWMclRiV23Bg1HGCXvh0tpQLBpui5Nk
   EO36R3njzrz1vQWgm81QYEryi/lDZl4MmM1v25oOoEezlP+IRq0HggrT/
   JbcD1nqH68WtH6njc+msN1ib7cxWsgFiojYKz0U5d1thkgchfYn4XAHZ6
   H8ow+2/76vBgXUNe5ruLVfOoSlySBOgtsOgq3tIoSPVY2ReheEz+FwsZ0
   tjo2StweV8gvHPBMvLivdGXyi8lv3xB0c0fY4UXuE5AFitii2yRojyfCW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241657898"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241657898"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 17:34:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="523823542"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 17:33:57 -0800
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
References: <20211228084432.2337-1-sj@kernel.org>
Date:   Wed, 29 Dec 2021 09:33:56 +0800
In-Reply-To: <20211228084432.2337-1-sj@kernel.org> (SeongJae Park's message of
        "Tue, 28 Dec 2021 08:44:32 +0000")
Message-ID: <87fsqc6vp7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj@kernel.org> writes:

> Hello,
>
> On Mon, 27 Dec 2021 11:09:56 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> Hi, SeongJae,
>> 
>> SeongJae Park <sj@kernel.org> writes:
>> 
>> > Hi,
>> >
>> > On Thu, 23 Dec 2021 15:51:18 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>> 
>> [snip]
>> 
>> >> It's good to avoid to change the source code of an application to apply
>> >> some memory management optimization (for example, use DAMON +
>> >> madvise()).  But it's much easier to run a user space daemon to optimize
>> >> for the application.  (for example, use DAMON + other information +
>> >> process_madvise()).
>> >> 
>> >> And this kind of per-application optimization is kind of application
>> >> specific policy.  This kind of policy may be too complex and flexible to
>> >> be put in the kernel directly.  For example, in addition to DAMON, some
>> >> other application specific or system knowledge may be helpful too, so we
>> >> have process_madvise() for that before DAMON.  Some more complex
>> >> algorithm may be needed for some applications.
>> >> 
>> >> And this kind of application specific policy usually need complex
>> >> configuration.  It's hard to export all these policy parameters to the
>> >> user space as the kernel ABI.  Now, DAMON schemes parameters are
>> >> exported in debugfs so they are not considered ABI.  So they may be
>> >> changed at any time.  But applications need some stable and
>> >> well-maintained ABI.
>> >> 
>> >> All in all, IMHO, what we need is a user space per-application policy
>> >> daemon with the information from DAMON and other sources.
>> >
>> > I basically agree to Ying, as I also noted in the coverletter of DAMOS
>> > patchset[1]:
>> >
>> >     DAMON[1] can be used as a primitive for data access aware memory
>> >     management optimizations.  For that, users who want such optimizations
>> >     should run DAMON, read the monitoring results, analyze it, plan a new
>> >     memory management scheme, and apply the new scheme by themselves.  Such
>> >     efforts will be inevitable for some complicated optimizations.
>> >
>> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fda504fade7f124858d7022341dc46ff35b45274
>> >
>> > That is, I believe some programs and big companies would definitely have their
>> > own information and want such kind of complicated optimizations.  But, such
>> > optimizations would depend on characteristics of each program and require
>> > investment of some amount of resources.  Some other programs and users wouldn't
>> > have such special information, and/or resource to invest for such
>> > optimizations.  For them, some amount of benefit would be helpful enough even
>> > though its sub-optimal.
>> >
>> > I think we should help both groups, and DAMOS could be useful for the second
>> > group.  And I don't think DAMOS is useless for the first group.  They could use
>> > their information-based policy in prallel to DAMOS in some cases.  E.g., if
>> > they have a way to predict the data access pattern of specific memory region
>> > even without help from DAMON, they can use their own policy for the region but
>> > DAMOS for other regions.
>> >
>> > Someone could ask why not implement a user-space implementation for the second
>> > group, then.  First of all, DAMOS is not only for the user-space driven virtual
>> > memory management optimization, but also for kernel-space programs and any
>> > DAMOS-supportable address spaces including the physical address space.  And,
>> > another important goal of DAMOS for user space driven use case in addition to
>> > reducing the redundant code is minimizing the user-kernel context switch
>> > overhead for passing the monitoring results information and memory management
>> > action requests.
>> >
>> > In summary, I agree the user space per-application policy daemon will be useful
>> > for the specialized ultimate optimizations, but we also need DAMOS for another
>> > common group of cases.
>> >
>> > If I'm missing something, please feel free to let me know.
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
>>    almost all users and applications, at least no regression.  No
>>    complex configuration or deep knowledge is needed to take advantage
>>    of it.
>> 
>> 2. Some way to inspect and control system and application behavior, so
>>    that some advanced and customized user space policy daemons can be
>>    built to satisfy some advanced users who have the enough knowledge
>>    for the applications and systems, for example, oomd.
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

I don't think DAMON schemes are the in-kernel general policy I mentioned
above (1.).  For example, NUMA balancing is a general policy to optimize
performance.  It tries to provide a general policy that works for all
users with as few as possible tunables.  If some tunables are needed,
they will be provided as ABI.

Best Regards,
Huang, Ying

> In short, I think we're on the same page, and adding DEMOTION scheme action
> could be helpful for the users who want to efficiently inspect and control the
> system/application behavior for their tiered memory systems.  It's unclear how
> much benefit this could give to users, though.  I assume Baolin would come back
> with some sort of numbers in the next spin.  Nevertheless, I personally don't
> think that's a critical blocker, as this patch is essentially just adding a way
> for using the pre-existing primitive, namely move_pages(), in a little bit more
> efficient manner, for the access pattern-based use cases. 
>
> If I'm missing something, please feel free to let me know.
>
> [1] https://github.com/awslabs/damoos
>
>
> Thanks,
> SJ
>
>> 
>> Best Regards,
>> Huang, Ying

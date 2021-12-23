Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636A47E24A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbhLWLbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:31:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51312 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347908AbhLWLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:31:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13ED861E39
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 11:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84946C36AE9;
        Thu, 23 Dec 2021 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640259102;
        bh=YPhRFkD7FweGLGXHGhH0kYRNlQPGtTMDbih7YFtKV98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=aVoRIL3Ja4dyz0BOd1q4UIulCIogbKfjYSfPWwX3eCjpYtGij5XOb3rWXlUGtslms
         U78xZ7BTymfGKqqU/JP0Y0JlPOeKYbF8uZ5OVSbmSvVlDAq8M98duGB7NTfLueYfF4
         QiCQqLA/WvjeArBWls2pI21mn5pcBa+Ugw+S+ED/r67sUdj5nwSeI4LvuQXAydd3vb
         00LkRPrwGfvUgm7DoodBAxg3GO6bxJiSTmSIcBTxwEmNamv8hLWf5aCV6YWhudMTy5
         /+PtzSvoD7uTkSiFvpJlEBDQEZddluXJhpDHwqrDbodhUCPdOaZs0UKn+ohxv9JdNS
         hmweSjFpfv61g==
From:   SeongJae Park <sj@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, sj@kernel.org,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered memory system
Date:   Thu, 23 Dec 2021 11:31:39 +0000
Message-Id: <20211223113139.20843-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87zgorbvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Dec 2021 15:51:18 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
> > On 12/23/2021 11:22 AM, Huang, Ying wrote:
> >> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> >> 
> >>> On 12/23/2021 9:07 AM, Huang, Ying wrote:
> >>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> Now on tiered memory system with different memory types, the reclaim path in
> >>>>> shrink_page_list() already support demoting pages to slow memory node instead
> >>>>> of discarding the pages. However, at that time the fast memory node memory
> >>>>> wartermark is already tense, which will increase the memory allocation latency
> >>>>> during page demotion. So a new method from user space demoting cold pages
> >>>>> proactively will be more helpful.
> >>>>>
> >>>>> We can rely on the DAMON in user space to help to monitor the cold memory on
> >>>>> fast memory node, and demote the cold pages to slow memory node proactively to
> >>>>> keep the fast memory node in a healthy state.
> >>>>>
> >>>>> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
> >>>>> and works well from my testing. Any comments are welcome. Thanks.
> >>>> As a performance optimization patch, it's better to provide some
> >>>> test
> >>>> results.
> >>>
> >>> Actually this is a functional patch, which adds a new scheme for
> >>> DAMON. And I think it is too early to measure the performance for the
> >>> real workload, and more work need to do for DAMON used on tiered
> >>> memory system (like supporting promotion scheme later).
> >> I don't think you provide any new functionality except the
> >> performance
> >> influence.
> >
> > Fair enough. I mean for DAMON.
> >
> >> And I think proactive demotion itself can show some performance benefit
> >> already.  Just like we can find the performance benefit in the proactive
> >
> > Yes, I think so too. But now I am afraid I can not get some obvious
> > performance benefit with current linux-next branch on tiered memory 
> > system, since the promotion patches are not there (yes, I can backport
> > them into my local branch to test), meanwhile I may need more tuning
> > for the demote scheme (such as tuning min-size, max-size, min-acc,
> > max-acc, min-age, max-age to get a better performance) for the real
> > workload. Now I just did a small step to add demotiong support for
> > DAMON, so I do not expect some obvious performance gain now (more work
> > need to research). But same as the proactive reclaim, I think this is
> > on the right way for DAMON.
> >
> > Anyway, maybe some other people also curious the benefit, and I will
> > do some measurement with DAMON demote scheme on mysql to show the 
> > performance results. Or do you have any other measurement suggestion?
> 
> For example, you can run 2 instances of workload, say, instance A and
> instance B.  The memory size of instance A + B is larger than the size
> of the DRAM.  And `numactl -m <DRAM node>` is used to run the instance,
> so that demotion will be triggered when DRAM is used up.  Instance A is
> run at first, after some time, say several to tens seconds, instance B
> is run.  With the original kernel, demotion will be triggered when run
> instance B, long latency may be triggered.  With your patch, the
> proactive demotion will be triggered earlier to avoid the long latency
> at the cost of performance of instance A (may be just a little).  We can
> also compare between DAMON based and the in-kernel LRU based cold page
> identification algorithm.

Good suggestion!

Also, there is a performance test for virtual address space proactive
reclamation scheme in the DAMON performance tests suite[1].  It measures memory
saving and runtime slowdown.  Maybe you could start from extending that for
demote scheme and measure similar metrics.

[1] https://github.com/awslabs/damon-tests/tree/master/perf

> 
> >> reclaim patchset as below.
> >> https://lore.kernel.org/lkml/20211019150731.16699-1-sj@kernel.org/
> >
> >>>> Another question is why we shouldn't do this in user space?  With DAMON,
> >>>> it's possible to export cold memory regions information to the user
> >>>> space, then we can use move_pages() to migrate them from DRAM to PMEM.
> >>>> What's the problem of that?
> >>>
> >>> IMO this is the purpose of introducing scheme for DAMON, and you can
> >>> check more in the Documentation/admin-guide/mm/damon/usage.rst.
> >>>
> >>> "
> >>> Schemes
> >>> -------
> >>>
> >>> For usual DAMON-based data access aware memory management
> >>> optimizations, users
> >>> would simply want the system to apply a memory management action to a memory
> >>> region of a specific access pattern.  DAMON receives such formalized
> >>> operation
> >>> schemes from the user and applies those to the target processes.
> >>> "
> >> For proactive reclaim, we haven't a user space ABI to reclaim a page
> >> of
> >> a process from memory to disk.  So it appears necessary to add a kernel
> >> module to do that.
> >> But for proactive demotion, we already have a user space ABI
> >> (move_pages()) to demote a page of a process from DRAM to PMEM.  What
> >> prevents you to do all these in the user space?
> >> And, I found there are MADV_XXX schemes too.  Where the user space
> >> ABIs
> >> are available already.  TBH, I don't know why we need these given there
> >> are already user space ABIs.  Maybe this is a question for SeongJae too.
> >
> > From my understanding, schemes will simplify the design for user space
> > to avoid implementing their own strategy according to the monitoring 
> > results, and more details in patch[1]. SeongJae may have more input
> > for the purpose.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1f366e421c8f69583ed37b56d86e3747331869c3
> 
> Thanks a lot for your information.  The commit log is helpful.
> 
> It's good to avoid to change the source code of an application to apply
> some memory management optimization (for example, use DAMON +
> madvise()).  But it's much easier to run a user space daemon to optimize
> for the application.  (for example, use DAMON + other information +
> process_madvise()).
> 
> And this kind of per-application optimization is kind of application
> specific policy.  This kind of policy may be too complex and flexible to
> be put in the kernel directly.  For example, in addition to DAMON, some
> other application specific or system knowledge may be helpful too, so we
> have process_madvise() for that before DAMON.  Some more complex
> algorithm may be needed for some applications.
> 
> And this kind of application specific policy usually need complex
> configuration.  It's hard to export all these policy parameters to the
> user space as the kernel ABI.  Now, DAMON schemes parameters are
> exported in debugfs so they are not considered ABI.  So they may be
> changed at any time.  But applications need some stable and
> well-maintained ABI.
> 
> All in all, IMHO, what we need is a user space per-application policy
> daemon with the information from DAMON and other sources.

I basically agree to Ying, as I also noted in the coverletter of DAMOS
patchset[1]:

    DAMON[1] can be used as a primitive for data access aware memory
    management optimizations.  For that, users who want such optimizations
    should run DAMON, read the monitoring results, analyze it, plan a new
    memory management scheme, and apply the new scheme by themselves.  Such
    efforts will be inevitable for some complicated optimizations.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fda504fade7f124858d7022341dc46ff35b45274

That is, I believe some programs and big companies would definitely have their
own information and want such kind of complicated optimizations.  But, such
optimizations would depend on characteristics of each program and require
investment of some amount of resources.  Some other programs and users wouldn't
have such special information, and/or resource to invest for such
optimizations.  For them, some amount of benefit would be helpful enough even
though its sub-optimal.

I think we should help both groups, and DAMOS could be useful for the second
group.  And I don't think DAMOS is useless for the first group.  They could use
their information-based policy in prallel to DAMOS in some cases.  E.g., if
they have a way to predict the data access pattern of specific memory region
even without help from DAMON, they can use their own policy for the region but
DAMOS for other regions.

Someone could ask why not implement a user-space implementation for the second
group, then.  First of all, DAMOS is not only for the user-space driven virtual
memory management optimization, but also for kernel-space programs and any
DAMOS-supportable address spaces including the physical address space.  And,
another important goal of DAMOS for user space driven use case in addition to
reducing the redundant code is minimizing the user-kernel context switch
overhead for passing the monitoring results information and memory management
action requests.

In summary, I agree the user space per-application policy daemon will be useful
for the specialized ultimate optimizations, but we also need DAMOS for another
common group of cases.

If I'm missing something, please feel free to let me know.


Thanks,
SJ


> 
> Best Regards,
> Huang, Ying

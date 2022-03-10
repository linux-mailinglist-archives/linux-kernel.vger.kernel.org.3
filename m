Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3C4D42D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiCJIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiCJIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:47:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F42137029
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:46:14 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C07321115;
        Thu, 10 Mar 2022 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646901973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WCHmAFDpmiOLpEsx5D22Ru/iOCcfmOw5LVy1hFJrJQ=;
        b=WM6AuP+h4BBRV1RoC2zSYoEE8P20cXbY3Yx4+NVoUa/uh0DTgUpjIbQkEvSqgLiFDxPkHG
        mdvEuHnJS/5rxah1bih37QVBAD4HowqdWgqBQI+dvr7zARCp6wtfjN14DMOUE+XK2ZeKHn
        pCjRHTH/CY/qJSgn3f37xXhwAKFSd1Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBC8EA3B88;
        Thu, 10 Mar 2022 08:46:12 +0000 (UTC)
Date:   Thu, 10 Mar 2022 09:46:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, peterz@infradead.org,
        Joel Savitz <jsavitz@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4] mm/oom_kill.c: futex: Don't OOM reap a process with a
 futex robust list
Message-ID: <Yim61BcuiRv/yUGo@dhcp22.suse.cz>
References: <20220309002550.103786-1-npache@redhat.com>
 <YiinJ3A6WoTJLN8d@dhcp22.suse.cz>
 <3a7dd0c4-db90-62e4-d7c7-246a4e3b9325@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7dd0c4-db90-62e4-d7c7-246a4e3b9325@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-03-22 14:34:49, Nico Pache wrote:
> 
> 
> On 3/9/22 06:09, Michal Hocko wrote:
> > On Tue 08-03-22 17:25:50, Nico Pache wrote:
> >> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> >> be targeted by the oom reaper. This mapping is also used to store the futex
> >> robust list; the kernel does not keep a copy of the robust list and instead
> >> references a userspace address to maintain the robustness during a process
> >> death. A race can occur between exit_mm and the oom reaper that allows
> >> the oom reaper to clear the memory of the futex robust list before the
> >> exit path has handled the futex death.
> > 
> > The above is missing the important part of the problem description. So
> > the oom_reaper frees the memory which is backing the robust list. It
> > would be useful to link that to the lockup on the futex.
> That is basically what that last sentence in the paragraph is saying. perhaps I
> should change clear -> free to be more verbose. Do you mean provide the race in
> the standard format of:
> 
>     CPU1                CPU2
> -------------------------------------------
>     page_fault
>     do_exit "signal"
>     wake_oom_reaper	
> 			oom_reaper
>                         oom_reap_task_mm (invalidates the private|anon mapping)
>     exit_mm
>     exit_mm_release
>     futex_exit_release
>     futex_cleanup
>     exit_robust_list
>     get_user (tries to access the memory we invalidated)

get_user will return with EFAULT and that prevents the wake up of
somebody on that robust list so they will stay stuck waiting for the
lock, right?

And yes that form would be much easier to follow.

> >> Prevent the OOM reaper from concurrently reaping the mappings if the dying
> >> process contains a robust_list. If the dying task_struct does not contain
> >> a pointer in tsk->robust_list, we can assume there was either never one
> >> setup for this task struct, or futex_cleanup has properly handled the
> >> futex death and we can safely reap this memory.
> > 
> > I do agree with Waiman that this should go into a helper function.This
> Ok I will do so in my v5.
> > would be a quick workaround but I believe that it would be much better
> > to either do the futex cleanup in the oom_reaper context if that could
> > be done without blocking.
> 
> The futex cleanup is protected by two locks: a sleeping mutex and a spin_lock,
> and both seem to be protecting a different race condition. If we create a
> function like futex_try_exit_release that does a non-sleeping try_mutex call we
> could solve the issue, but in the case that we fail to acquire the lock then we
> leave the race window open. So from a correctness standpoint this approach falls
> short.

If we fail to take the lock we can just bail out on the oom_reaper side
and retry the same way we retry on the mmap_sem lock. I do not see a
correctness issue here. This would be definitely less prone to pointless
bailout when we fail unconditionally on a present robust list.

>  If that is really not feasible for some reason
> > then we could skip over vmas which are backing the robust list. Have you
> > considered any of those solutions?
> 
> We did explore some other possibilities such as using:
> '&& !vma->vm_mm->owner->robust_list' in  __oom_reap_task_mm which did not work
> for some reason but should have the same effect as this patch but with wasting
> cycles checking all the VMA under a given process for a robust_list that we
> could just check for in the parent caller. The only benefit I could see from
> this approach would be that if halfway through checking the VMAs the robust list
> gets set to NULL, we could then clear the other half of memory more quickly with
> the oom reaper.

I thought we could simply check the virtual address(es) which hosts the
robust lists against each vma address range and skip over that vma.
oom_reaper is a not a hot path and trivial checks like this one are not
really a problem.

> Unless you know of some other way to determine if that VMA is the pthread
> mapping or a way to hide a certain mmap from the OOM reaper then I think this is
> our best approach.
> 
> We have also considered implementing a lock between the futex_cleanup and the
> oom_reaper that would have a similar effect to this patch but instead of
> skipping the oom on a robust list we wait for the cleanup to finish then
> continue ooming. Not sure if we want to introduce that complexity though.

No, the point of the oom_reaper is to guarantee a forward progress when
an oom victim cannot terminate by itself. Such a mechanism cannot really
depend on any other locks which can be involved in memory allocations
(i.e. on any other sleeping locks).
> 
> Cheers,
> -- Nico

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAB4F8B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiDGWeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiDGWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAEFFC8B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E7E762007
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEFC385A4;
        Thu,  7 Apr 2022 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649370722;
        bh=fQt1MnSysX/EHNJtZXA6Yk6KIqVhFKrn01VGpcgiLqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j+bQv2bTZlMfLeJRhLqw0Aa3Rrwh0Zp/ijpEFh5imqLNVymbm+DyPCuJhA5tiJ/2e
         /9PJ9r1+QBKVRr6k6F5rvvTi1m3zt0uK+i5/KCg15fK4hkMGVE0OgpY76wxQ1cTLYz
         NuTVvf+kIYzHVu54niX2Rdihf0S44LRv0vpH4JJ8=
Date:   Thu, 7 Apr 2022 15:32:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-Id: <20220407153201.cdcab0a2d4a58ce358fb7c47@linux-foundation.org>
In-Reply-To: <eaa082c8-a583-4606-4ec4-1d43c4d48b97@redhat.com>
References: <20220407184254.3612387-1-npache@redhat.com>
        <20220407131809.f2d256541e2c039c434c0d72@linux-foundation.org>
        <eaa082c8-a583-4606-4ec4-1d43c4d48b97@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 17:52:31 -0400 Nico Pache <npache@redhat.com> wrote:

> >>
> >> The following case can still fail:
> >> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)
> >>
> >> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
> > 
> > Should this fix be backported into -stable kernels?
> 
> Yes I believe so. This is caused by the commit marked under 'Fixes:' which is in
> stable branch.

OK.  The MM team don't like the promiscuous backporting of things which
we didn't ask to be backported.  So -stable maintainers have been
trained (we hope) to only backport things which we explicitly marked
cc:stable.

> >> --- a/include/linux/oom.h
> >> +++ b/include/linux/oom.h
> >> @@ -106,7 +106,8 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
> >>  	return 0;
> >>  }
> >>  
> >> -bool __oom_reap_task_mm(struct mm_struct *mm);
> >> +bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
> >> +		__user *robust_list);
> > 
> > Should explicitly include futex.h
> Good point. On second thought I think we also need to surround some of the
> changes with a ifdef CONFIG_FUTEX. current->robust_list is undefined if we turn
> that config option off.

Ah.

> > 
> >>  long oom_badness(struct task_struct *p,
> >>  		unsigned long totalpages);
> >> diff --git a/mm/mmap.c b/mm/mmap.c
> >> index 3aa839f81e63..c14fe6f8e9a5 100644
> >> --- a/mm/mmap.c
> >> +++ b/mm/mmap.c
> >> @@ -3126,7 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
> >>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> >>  		 * __oom_reap_task_mm() will not block.
> >>  		 */
> >> -		(void)__oom_reap_task_mm(mm);
> >> +		(void)__oom_reap_task_mm(mm, current->robust_list);
> >> +
> >>  		set_bit(MMF_OOM_SKIP, &mm->flags);
> >>  	}
> >>  
> >> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >> index 7ec38194f8e1..727cfc3bd284 100644
> >> --- a/mm/oom_kill.c
> >> +++ b/mm/oom_kill.c
> >> @@ -509,9 +509,11 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
> >>  static struct task_struct *oom_reaper_list;
> >>  static DEFINE_SPINLOCK(oom_reaper_lock);
> >>  
> >> -bool __oom_reap_task_mm(struct mm_struct *mm)
> >> +bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
> >> +		__user *robust_list)
> >>  {
> > 
> > It's pretty sad to make such a low-level function aware of futex
> > internals.  How about making it a more general `void *skip_area'?
> Yes we can make this change. My concern is that the caller may now have to cast
> the type: __oom_reap_task_mm(mm_struct, (void*) current->robust_list). But I
> doubt that is a big concern.

No cast needed - the compiler will happily cast an anything* to a void*.

> > 
> >>  	struct vm_area_struct *vma;
> >> +	unsigned long head = (unsigned long) robust_list;
> >>  	bool ret = true;
> >>  
> >>  	/*
> >> @@ -526,6 +528,11 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
> >>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> >>  			continue;
> >>  
> >> +		if (vma->vm_start <= head && vma->vm_end > head) {
> > 
> > This check as you have it is making assumptions about the length of the
> > area at *robust_list and about that area's relation to the area
> > represented by the vma.
> > 
> > So if this is to be made more generic, we'd also need skip_area_len so
> > we can perform a full overlap check.
> Im not sure I follow here. Can a single MMAP call span multiple VMAs? The
> address would be part of the pthread_t struct which is mmapped by the userspace
> code. We are simply looking for that VMA and skipping the oom of it. It does not
> try to find the individual locks (allocated separately and represented on a
> LinkedList), it just prevents the reaping of the robust_list_head (part of
> pthread_t) which stores the start of this LL. If some of the locks are private
> (shared locks are not reaped) we may run into a case where this still fails;
> however, we haven't been able to reproduce this.

Well I was thinking that if it were to become a generic "ignore this
region" then the code would need to be taught to skip any vma which had
any form of overlap with that region.  Which sounds like way overdesign
until there's a demonstrated need.



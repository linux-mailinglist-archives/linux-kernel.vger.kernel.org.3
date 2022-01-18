Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8374921A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiARIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:51:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiARIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:51:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 05EF81F3B5;
        Tue, 18 Jan 2022 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642495897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktSc+uVAaUOUFDmID1uUn+N2h+FMdLGzH0w7pkGhy34=;
        b=re+LB1EFXSfuPGtUCKPTDJ9txguBHwN+K0G2zo8K2iyxTUMfADBTmdY7588SE7k4XVgNGP
        LGeU2/gg0h/xWwjX0Mzb2cyF69i2g/0vHUbEDAQAruIfsxZCTSv2VCFvn12P5R8TKPro6r
        8rHGyRd3PfSzhd8CYmRolKLKMTZY2Qo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A8FEA3B88;
        Tue, 18 Jan 2022 08:51:36 +0000 (UTC)
Date:   Tue, 18 Jan 2022 09:51:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jsavitz@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved
 robust futex
Message-ID: <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
 <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-01-22 17:56:28, Nico Pache wrote:
> On 1/17/22 11:05, Waiman Long wrote:
> > On 1/17/22 03:52, Michal Hocko wrote:
[...]
> >>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >>> index 1ddabefcfb5a..3cdaac9c7de5 100644
> >>> --- a/mm/oom_kill.c
> >>> +++ b/mm/oom_kill.c
> >>> @@ -667,6 +667,21 @@ static void wake_oom_reaper(struct task_struct *tsk)
> >>>       if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> >>>           return;
> >>>   +#ifdef CONFIG_FUTEX
> >>> +    /*
> >>> +     * If the ooming task's SIGKILL has not finished handling the
> >>> +     * robust futex it is not correct to reap the mm concurrently.
> >>> +     * Do not wake the oom reaper when the task still contains a
> >>> +     * robust list.
> >>> +     */
> >>> +    if (tsk->robust_list)
> >>> +        return;
> >>> +#ifdef CONFIG_COMPAT
> >>> +    if (tsk->compat_robust_list)
> >>> +        return;
> >>> +#endif
> >>> +#endif
> >> If this turns out to be really needed, which I do not really see at the
> >> moment, then this is not the right way to handle this situation. The oom
> >> victim could get stuck and the oom killer wouldn't be able to move
> >> forward. If anything the victim would need to get MMF_OOM_SKIP set.
> 
> I will try this, but I don't immediately see any difference between this return
> case and setting the bit, passing the oom_reaper_list, then skipping it based on
> the flag. Do you mind explaining how this could lead to the oom killer getting
> stuck?

The primary purpose of the oom_reaper is to guarantee a forward
progress. If a task gets stuck in the kernel - e.g. on locks then it
won't bail out and won't handle signals (i.e. SIGKILL from the
userspace). The oom killer prevents new oom victims selection in a
presence of an existing oom victim (see oom_evaluate_task). That means
that we not only send a SIGKILL to the victim, we also wake up the oom
reaper which then asynchronously tears down the private memory of the
task (thus release at least some of its memory) and once it is done it
will set MMF_OOM_SKIP flag which will tell the oom killer
(oom_evaluate_task) that this victim is no longer interesting and a new
victim can be selected.

Makes sense?

Part of the async tear down is also MMF_UNSTABLE handling (see
__oom_reap_task_mm) which tells #PF handling code
(check_stable_address_space) that the underlying memory could have been
tempered with and thus it should return SIGBUS. The underlying
assumption is that the process (and all tasks which share its mm) has
been killed and it will never return to the userspace so the de-facto
memory corruption doesn't matter.

One thing that is still unclear to me is why this leads to any locked up
tasks. Looking at exit_robust_list I can see that it is accessing the
userspace memory but this should return EFAULT in this situation. My
assumption (which might be really wrong) is that futex shared among
processes which are not sharing mm nor signal handling will be sitting
in a shared memory. 

Now to the actual fix. I do not think we want to hide the task from the
oom reaper as you are suggesting. Futexes are very likely to be used for
many processes and that would make the whole async scheme useless. We
need something like the below.

futex_exit_release is not directly usable as it implicitly depends
on memory allocation (#PF) and that is not acceptable. So instead we
need something futex_exit_try_release or similar which would fail the
operation in case get_user (pagefault_disable) needs to really handle
the #PF or if the futex_exit_mutex is locked. In other words this would
have to be a completely non-blocking operation. The oom reaper would
then bail out.

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index ef5860fc7d22..57660d3d1b79 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -613,6 +613,9 @@ static void oom_reap_task(struct task_struct *tsk)
 	int attempts = 0;
 	struct mm_struct *mm = tsk->signal->oom_mm;
 
+	if (futex_exit_try_release(tsk))
+		goto fail;
+
 	/* Retry the mmap_read_trylock(mm) a few times */
 	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
 		schedule_timeout_idle(HZ/10);
@@ -621,6 +624,7 @@ static void oom_reap_task(struct task_struct *tsk)
 	    test_bit(MMF_OOM_SKIP, &mm->flags))
 		goto done;
 
+fail:
 	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
 		task_pid_nr(tsk), tsk->comm);
 	sched_show_task(tsk);
@@ -1184,6 +1188,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	if (!reap)
 		goto drop_mm;
 
+	if (futex_exit_try_release(tsk)) {
+		ret = -EAGAIN;
+		goto drop_mm;
+	}
+	
 	if (mmap_read_lock_killable(mm)) {
 		ret = -EINTR;
 		goto drop_mm;
-- 
Michal Hocko
SUSE Labs

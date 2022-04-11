Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63204FB6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbiDKJKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344135AbiDKJKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A05A3EF35
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 190CF210FD;
        Mon, 11 Apr 2022 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649668082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8bIp6N4V6OcovxnD4FwgEWzudRUr3RpK89Dxlfw08ow=;
        b=ibGIM2pHOpoLFbDKOB3IpAK7zLFOEvUTDG7NcUL7DLEMV+ClrJyB6LdsFb6wvSRdESueBl
        5FhNEWLJRKFbD5UhVcUw+GnqOwUJv6BBcC9xiRDlAr5+wF/KLuEPZy+YZWHruIvqY0KnmZ
        iLdhUHNP9v1laY29WBBRdcvGW1jN0LE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B153EA3B88;
        Mon, 11 Apr 2022 09:08:01 +0000 (UTC)
Date:   Mon, 11 Apr 2022 11:08:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Savitz <jsavitz@redhat.com>, Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-ID: <YlPv8elVxqa4XZnd@dhcp22.suse.cz>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com>
 <87k0bzk7e5.ffs@tglx>
 <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
 <87sfqni77s.ffs@tglx>
 <YlPPRrGrX2ECe8QY@dhcp22.suse.cz>
 <87wnfwf4e5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnfwf4e5.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-04-22 09:47:14, Thomas Gleixner wrote:
> Michal,
> 
> On Mon, Apr 11 2022 at 08:48, Michal Hocko wrote:
> > On Fri 08-04-22 23:41:11, Thomas Gleixner wrote:
> >> So why would a process private robust mutex be any different from a
> >> process shared one?
> >
> > Purely from the OOM POV they are slightly different because the OOM
> > killer always kills all threads which share the mm with the selected
> > victim (with an exception of the global init - see __oom_kill_process).
> > Note that this is including those threads which are not sharing signals
> > handling.
> > So clobbering private locks shouldn't be observable to an alive thread
> > unless I am missing something.
> 
> Yes, it kills everything, but the reaper also reaps non-shared VMAs. So
> if the process private futex sits in a reaped VMA the shared one becomes
> unreachable.
> 
> > On the other hand I do agree that delayed oom_reaper execution is a
> > reasonable workaround and the most simplistic one.
> 
> I think it's more than a workaround. It's a reasonable expectation that
> the kernel side of the user space threads can mop up the mess the user
> space part created. So even if one of of N threads is stuck in a place
> where it can't, then N-1 can still reach do_exit() and mop their mess
> up.
> 
> The oom reaper is the last resort to resolve the situation in case of a
> stuck task. No?

Yes, I keep saying workaround because it really doesn't address the
underlying issue which is that the oom_reaper clobbers something it
shouldn't be. A full fix from my POV would be making oom_reaper code
more aware of the futex usage. But this is something nore really viable.

Btw. this is what I've in my local tree. It hasn't seen any testing but
it might be a good start to make it a full patch. I have decided to use
a timer rather than juggling tasks on the oom_reaper list because
initial implementation looked uglier. I will try to find some time to
finish that but if Nico or others beat me to it I won't complain.
Also I absolutely do not insist on the timer approach.
--- 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ff6901dcb06d..528806ad6e6a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1446,6 +1446,7 @@ struct task_struct {
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
+	struct timer_list		oom_reaper_timer;
 #endif
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct		*stack_vm_area;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ec38194f8e1..be6d65ead7ec 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -632,7 +632,7 @@ static void oom_reap_task(struct task_struct *tsk)
 	 */
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 
-	/* Drop a reference taken by wake_oom_reaper */
+	/* Drop a reference taken by queue_oom_repaer */
 	put_task_struct(tsk);
 }
 
@@ -644,12 +644,12 @@ static int oom_reaper(void *unused)
 		struct task_struct *tsk = NULL;
 
 		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
-		spin_lock(&oom_reaper_lock);
+		spin_lock_irq(&oom_reaper_lock);
 		if (oom_reaper_list != NULL) {
 			tsk = oom_reaper_list;
 			oom_reaper_list = tsk->oom_reaper_list;
 		}
-		spin_unlock(&oom_reaper_lock);
+		spin_unlock_irq(&oom_reaper_lock);
 
 		if (tsk)
 			oom_reap_task(tsk);
@@ -658,22 +658,50 @@ static int oom_reaper(void *unused)
 	return 0;
 }
 
-static void wake_oom_reaper(struct task_struct *tsk)
+static void wake_oom_reaper_fn(struct timer_list *timer)
 {
-	/* mm is already queued? */
-	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
-		return;
+	struct task_struct *tsk = container_of(timer, struct task_struct, oom_reaper_timer);
+	struct mm_struct *mm = tsk->signal->oom_mm;
+	unsigned long flags;
 
-	get_task_struct(tsk);
+	/* The victim managed to terminate on its own - see exit_mmap */
+	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
+		put_task_struct(tsk);
+		return;
+	}
 
-	spin_lock(&oom_reaper_lock);
+	spin_lock_irqsave(&oom_reaper_lock, flags);
 	tsk->oom_reaper_list = oom_reaper_list;
 	oom_reaper_list = tsk;
-	spin_unlock(&oom_reaper_lock);
+	spin_unlock_irqrestore(&oom_reaper_lock, flags);
 	trace_wake_reaper(tsk->pid);
 	wake_up(&oom_reaper_wait);
 }
 
+/*
+ * Give OOM victims some head room to exit themselves. If they do not exit
+ * on their own the oom reaper is invoked.
+ * The timeout is basically arbitrary and there is no best value to use.
+ * The longer it will be the longer the worst case scenario OOM can
+ * take. The smaller the timeout the more likely the oom_reaper can get
+ * into the way and release resources which could be needed during the
+ * exit path - e.g. futex robust lists can sit in the anonymous memory
+ * which could be reaped and the exit path won't be able to let waiters
+ * know the holding task has terminated.
+ */
+#define OOM_REAPER_DELAY (2*HZ)
+static void queue_oom_repaer(struct task_struct *tsk)
+{
+	/* mm is already queued? */
+	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
+		return;
+
+	get_task_struct(tsk);
+	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper_fn, 0);
+	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
+	add_timer(&tsk->oom_reaper_timer);
+}
+
 static int __init oom_init(void)
 {
 	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
@@ -681,7 +709,7 @@ static int __init oom_init(void)
 }
 subsys_initcall(oom_init)
 #else
-static inline void wake_oom_reaper(struct task_struct *tsk)
+static inline void queue_oom_repaer(struct task_struct *tsk)
 {
 }
 #endif /* CONFIG_MMU */
@@ -932,7 +960,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	rcu_read_unlock();
 
 	if (can_oom_reap)
-		wake_oom_reaper(victim);
+		queue_oom_repaer(victim);
 
 	mmdrop(mm);
 	put_task_struct(victim);
@@ -968,7 +996,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	task_lock(victim);
 	if (task_will_free_mem(victim)) {
 		mark_oom_victim(victim);
-		wake_oom_reaper(victim);
+		queue_oom_repaer(victim);
 		task_unlock(victim);
 		put_task_struct(victim);
 		return;
@@ -1067,7 +1095,7 @@ bool out_of_memory(struct oom_control *oc)
 	 */
 	if (task_will_free_mem(current)) {
 		mark_oom_victim(current);
-		wake_oom_reaper(current);
+		queue_oom_repaer(current);
 		return true;
 	}
 
-- 
Michal Hocko
SUSE Labs

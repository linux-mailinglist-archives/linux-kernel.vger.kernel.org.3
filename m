Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07E34755CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhLOKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhLOKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:06:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61456C061574;
        Wed, 15 Dec 2021 02:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XslM5Epa55RD20L1OCQ/Q6wYtb1kDkeTAifuHVHDDiI=; b=SK3bCDDO0/043JGqNkXclAWkHm
        OtNTKVeBzQp6/E2F3GVkdyman/ujNkVnuj0oQuYnbAmHiG68dXA4/JWdzHGYTZAG5CXE5bPNPw8KA
        SmPiHdpVwyvdkEtEVqd+FMubO4ME5O0d/QmiOlcaSEuTv5GlyNy7xy2hvftHfeRybdsQetrXGpsMK
        xKUNEp6FEFgFDXS2ucVehXGZ8WQbjNWvAnDkF9u/eeyTLdzzS8YQ/A5n2qQjFwVPy0j0f12PcMvib
        +yeESzexCnIvQaJvgIfW0UAMW4TBkR+AvL1iDV8IRXs0QoKTIJOLv72ytUvzBEUT73NuTAMOSl2Vm
        VsAAeoxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxRB0-001U8u-9e; Wed, 15 Dec 2021 10:06:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4252C300056;
        Wed, 15 Dec 2021 11:06:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24F602B3206E1; Wed, 15 Dec 2021 11:06:20 +0100 (CET)
Date:   Wed, 15 Dec 2021 11:06:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
Message-ID: <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:46:25PM -0800, Peter Oskolkov wrote:
> On Tue, Dec 14, 2021 at 12:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi,
> >
> > This is actually tested code; but still missing the SMP wake-to-idle machinery.
> > I still need to think about that.
> 
> Thanks, Peter!
> 
> At a first glance, your main patch does not look much smaller than
> mine, and I thought the whole point of re-doing it was to throw away
> extra features and make things smaller/simpler...

Well, simpler was the goal. I didn't really focus on size much. It isn't
really big to begin with.

But yes, it has 5 hooks now, 3 syscalls and lots of comments and all
that under 900 lines, not bad I'd say.

Also I think you wanted something like this? I'm not sure of the LAZY
name, but I can't seem to come up with anything saner atm.


---
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1297,6 +1297,7 @@ struct task_struct {
 
 #ifdef CONFIG_UMCG
 	/* setup by sys_umcg_ctrl() */
+	u32			umcg_flags;
 	clockid_t		umcg_clock;
 	struct umcg_task __user	*umcg_task;
 
--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -133,11 +133,13 @@ struct umcg_task {
  * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
  * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
  * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
+ * @UMCG_CTL_LAZY:	 don't wake server on runnable enqueue
  */
 enum umcg_ctl_flag {
 	UMCG_CTL_REGISTER	= 0x00001,
 	UMCG_CTL_UNREGISTER	= 0x00002,
 	UMCG_CTL_WORKER		= 0x10000,
+	UMCG_CTL_LAZY		= 0x20000,
 };
 
 #endif /* _UAPI_LINUX_UMCG_H */
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -416,6 +416,27 @@ static int umcg_enqueue_runnable(struct
 }
 
 /*
+ * Enqueue tsk to it's server's runnable list and wake the server for pickup if
+ * so desired. Notable LAZY workers will not wake the server and rely on the
+ * server to do pickup whenever it naturally runs next.
+ *
+ * Returns:
+ * 0:	success
+ * -EFAULT
+ */
+static int umcg_enqueue_and_wake(struct task_struct *tsk, bool force)
+{
+	int ret = umcg_enqueue_runnable(tsk);
+	if (ret)
+		return ret;
+
+	if (force || !(tsk->umcg_flags & UMCG_CTL_LAZY))
+		ret = umcg_wake_server(tsk);
+
+	return ret;
+}
+
+/*
  * umcg_wait: Wait for ->state to become RUNNING
  *
  * Returns:
@@ -522,12 +543,8 @@ void umcg_sys_exit(struct pt_regs *regs)
 	if (umcg_update_state(tsk, self, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE))
 		UMCG_DIE_UNPIN("state");
 
-	if (umcg_enqueue_runnable(tsk))
-		UMCG_DIE_UNPIN("enqueue");
-
-	/* Server might not be RUNNABLE, means it's already running */
-	if (umcg_wake_server(tsk))
-		UMCG_DIE_UNPIN("wake-server");
+	if (umcg_enqueue_and_wake(tsk, false))
+		UMCG_DIE_UNPIN("enqueue-and-wake");
 
 	umcg_unpin_pages();
 
@@ -582,15 +599,11 @@ void umcg_notify_resume(struct pt_regs *
 				      UMCG_TASK_RUNNABLE))
 			UMCG_DIE_UNPIN("state");
 
-		if (umcg_enqueue_runnable(tsk))
-			UMCG_DIE_UNPIN("enqueue");
-
 		/*
-		 * XXX do we want a preemption consuming ::next_tid ?
-		 * I'm currently leaning towards no.
+		 * Preemption relies on waking the server on enqueue.
 		 */
-		if (umcg_wake_server(tsk))
-			UMCG_DIE_UNPIN("wake-server");
+		if (umcg_enqueue_and_wake(tsk, true))
+			UMCG_DIE_UNPIN("enqueue-and-wake");
 
 		umcg_unpin_pages();
 	}
@@ -686,23 +699,15 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 		goto unpin;
 
 	if (worker) {
-		ret = umcg_enqueue_runnable(tsk);
+		ret = umcg_enqueue_and_wake(tsk, !tsk->umcg_next);
 		if (ret)
 			goto unpin;
 	}
 
-	if (worker)
-		ret = umcg_wake(tsk);
-	else if (tsk->umcg_next)
+	if (tsk->umcg_next) {
 		ret = umcg_wake_next(tsk);
-
-	if (ret) {
-		/*
-		 * XXX already enqueued ourself on ::server_tid; failing now
-		 * leaves the lot in an inconsistent state since it'll also
-		 * unblock self in order to return the error. !?!?
-		 */
-		goto unpin;
+		if (ret)
+			goto unpin;
 	}
 
 	umcg_unpin_pages();
@@ -783,7 +788,8 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
 
 	if (flags & ~(UMCG_CTL_REGISTER |
 		      UMCG_CTL_UNREGISTER |
-		      UMCG_CTL_WORKER))
+		      UMCG_CTL_WORKER |
+		      UMCG_CTL_LAZY))
 		return -EINVAL;
 
 	if (flags == UMCG_CTL_UNREGISTER) {
@@ -827,7 +833,7 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
 	rcu_read_lock();
 	server = find_task_by_vpid(ut.server_tid);
 	if (server && server->mm == current->mm) {
-		if (flags == UMCG_CTL_WORKER) {
+		if (flags & UMCG_CTL_WORKER) {
 			if (!server->umcg_task ||
 			    (server->flags & PF_UMCG_WORKER))
 				server = NULL;
@@ -843,10 +849,11 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
 	if (!server)
 		return -ESRCH;
 
-	if (flags == UMCG_CTL_WORKER) {
+	if (flags & UMCG_CTL_WORKER) {
 		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_BLOCKED)
 			return -EINVAL;
 
+		current->umcg_flags = flags & UMCG_CTL_LAZY;
 		WRITE_ONCE(current->umcg_task, self);
 		current->flags |= PF_UMCG_WORKER;	/* hook schedule() */
 		set_syscall_work(SYSCALL_UMCG);		/* hook syscall */
@@ -858,6 +865,7 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
 		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_RUNNING)
 			return -EINVAL;
 
+		current->umcg_flags = 0;
 		WRITE_ONCE(current->umcg_task, self);
 		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC2505D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbiDRRD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344696AbiDRRD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 553C32BB24
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650301276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTOfs8DRtj8SE5YGUznkEQznKjxzmuDz8LdI0h+mre0=;
        b=MphgwWWB6oXAAWkuAkDGMEyAT3Ko39tzLdWxWBAyi37z2Pn/omCF2avTtPdH0SYusGS5X9
        B7qhfCZbh2iLn+00dGTILGC7mqiks771pkpfZivL1OSjIcfOFMV5/cZyzIWmIAbsrJtXDF
        0gb5mWheT5B0RrURQriQiN2MxE6RW+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-poeecWpwM-27U4M5K-4QvA-1; Mon, 18 Apr 2022 13:01:10 -0400
X-MC-Unique: poeecWpwM-27U4M5K-4QvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 353D3185A7B2;
        Mon, 18 Apr 2022 17:01:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.13])
        by smtp.corp.redhat.com (Postfix) with SMTP id 38C3C43E766;
        Mon, 18 Apr 2022 17:01:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 18 Apr 2022 19:01:08 +0200 (CEST)
Date:   Mon, 18 Apr 2022 19:01:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220418170104.GA16199@redhat.com>
References: <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Peter Zijlstra wrote:
>
> On Fri, Apr 15, 2022 at 12:57:56PM +0200, Oleg Nesterov wrote:
> > On 04/15, Oleg Nesterov wrote:
> > >
> > > OK, so far it seems that this patch needs a couple of simple fixes you
> > > pointed out, but before I send V2:
> > >
> > > 	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?
> > >
> > > 	- will you agree if I change ptrace_freeze_traced() to rely
> > > 	  on __state == TASK_TRACED rather than task_is_traced() ?
> > >
> >
> > Forgot to say, I think 1/5 needs some changes in any case...
> >
> > ptrace_resume() does  wake_up_state(child, __TASK_TRACED) but doesn't
> > clear JOBCTL_TRACED. The "else" branch in ptrace_stop() leaks this flag
> > too.
>
> Urgh, yes, I seemed to have missed that one :-(

OK, I'll wait for updated version and send V3 on top of it.

I think the fixes are simple. ptrace_resume() should simply remove the
minor "need_siglock" optimization and clear JOBCTL_TRACED. As for the
"else" branch in ptrace_stop(), perhaps 1/5 can introduce the trivial

	static void clear_traced_jobctl_flags(unsigned long flags)
	{
		spin_lock_irq(&current->sighand->siglock);
		current->jobctl &= ~flags;
		spin_unlock_irq(&current->sighand->siglock);
	}

which can be reused by 2/5 to clear JOBCTL_TRACED_XXX. And, Peter, feel
free to join 1/5 and this patch if you think this makes any sense.

Meanwhile see V2 on top of the current version.

Oleg.


diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index ec8b312f7506..1b5a57048e13 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -22,7 +22,8 @@ struct task_struct;
 
 #define JOBCTL_STOPPED_BIT	24
 #define JOBCTL_TRACED_BIT	25
-#define JOBCTL_TRACED_FROZEN_BIT 26
+#define JOBCTL_TRACED_XXX_BIT	25
+#define JOBCTL_TRACED_FROZEN_BIT 27
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -35,6 +36,7 @@ struct task_struct;
 
 #define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
 #define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
+#define JOBCTL_TRACED_XXX	(1UL << JOBCTL_TRACED_XXX_BIT)
 #define JOBCTL_TRACED_FROZEN	(1UL << JOBCTL_TRACED_FROZEN_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 626f96d275c7..ec104bae4e21 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -193,20 +193,24 @@ static bool looks_like_a_spurious_pid(struct task_struct *task)
  */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
+	unsigned long flags;
 	bool ret = false;
 
 	/* Lockless, nobody but us can set this flag */
 	if (task->jobctl & JOBCTL_LISTENING)
 		return ret;
+	if (!lock_task_sighand(task, &flags))
+		return ret;
 
-	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
+	if (READ_ONCE(task->__state) == TASK_TRACED &&
+	    !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
 		task->jobctl |= JOBCTL_TRACED_FROZEN;
 		WRITE_ONCE(task->__state, __TASK_TRACED);
+		WARN_ON_ONCE(!task_is_traced(task));
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
+	unlock_task_sighand(task, &flags);
 
 	return ret;
 }
@@ -253,40 +257,42 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
-	int ret = -ESRCH;
-
+	int traced;
 	/*
 	 * We take the read lock around doing both checks to close a
-	 * possible race where someone else was tracing our child and
-	 * detached between these two checks.  After this locked check,
-	 * we are sure that this is our traced child and that can only
-	 * be changed by us so it's not changing right after this.
+	 * possible race where someone else attaches or detaches our
+	 * natural child.
 	 */
 	read_lock(&tasklist_lock);
-	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-		/*
-		 * child->sighand can't be NULL, release_task()
-		 * does ptrace_unlink() before __exit_signal().
-		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
-	}
+	traced = child->ptrace && child->parent == current;
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
-			/*
-			 * This can only happen if may_ptrace_stop() fails and
-			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
-			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-			ret = -ESRCH;
+	if (!traced)
+		return -ESRCH;
+
+	WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+	if (ignore_state)
+		return 0;
+
+	if (!task_is_traced(child))
+		return -ESRCH;
+
+	for (;;) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		set_current_state(TASK_KILLABLE);
+		if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED_XXX)) {
+			__set_current_state(TASK_RUNNING);
+			break;
 		}
+		schedule();
 	}
 
-	return ret;
+	if (!wait_task_inactive(child, TASK_TRACED) ||
+	    !ptrace_freeze_traced(child))
+		return -ESRCH;
+
+	return 0;
 }
 
 static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
diff --git a/kernel/signal.c b/kernel/signal.c
index 0aea3f0a8002..c7a89904cc4a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2182,6 +2182,13 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+static void clear_traced_xxx(void)
+{
+	spin_lock_irq(&current->sighand->siglock);
+	current->jobctl &= ~JOBCTL_TRACED_XXX;
+	spin_unlock_irq(&current->sighand->siglock);
+}
+
 /*
  * This must be called with current->sighand->siglock held.
  *
@@ -2220,7 +2227,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
 	 */
-	current->jobctl |= JOBCTL_TRACED;
+	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_XXX;
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2282,6 +2289,8 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		if (gstop_done && ptrace_reparented(current))
 			do_notify_parent_cldstop(current, false, why);
 
+		clear_traced_xxx();
+		wake_up_state(current->parent, TASK_KILLABLE);
 		/*
 		 * Don't want to allow preemption here, because
 		 * sys_ptrace() needs this task to be inactive.
@@ -2297,8 +2306,12 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.
-		 * Don't drop the lock yet, another tracer may come.
-		 *
+		 * Don't drop the lock yet, another tracer may come,
+		 * tasklist protects us from ptrace_freeze_traced().
+		 */
+		__set_current_state(TASK_RUNNING);
+		clear_traced_xxx();
+		/*
 		 * If @gstop_done, the ptracer went away between group stop
 		 * completion and here.  During detach, it would have set
 		 * JOBCTL_STOP_PENDING on us and we'll re-enter
@@ -2307,13 +2320,11 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		 */
 		if (gstop_done)
 			do_notify_parent_cldstop(current, false, why);
+		read_unlock(&tasklist_lock);
 
-		/* tasklist protects us from ptrace_freeze_traced() */
-		__set_current_state(TASK_RUNNING);
 		read_code = false;
 		if (clear_code)
 			exit_code = 0;
-		read_unlock(&tasklist_lock);
 	}
 
 	/*


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B0501B25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiDNShL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbiDNShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B1AABCB46
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649961282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WUBXMQHoFSBEKqjJQdcISiO6Pf1S+dASm5LXOQppI8=;
        b=YHg4we3vq4GrpgazeLOHc97gZqtw7MKvAE9rgFl/vG44bwAQuhO8IaaWGXjxgDFbvvibHX
        RCQ3z3eQOoKTGPo9P+wJpkxIE7JumbpFFv1/pYL9sd0Q5MI8fMUmNuGWWnhOYv/8/UaWh/
        MwjsZdbH5u2acIdASYlFsfSPxc6EFIk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-fAXynIJoOaG5N-QA6ORb2Q-1; Thu, 14 Apr 2022 14:34:38 -0400
X-MC-Unique: fAXynIJoOaG5N-QA6ORb2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6E5029AB3E6;
        Thu, 14 Apr 2022 18:34:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id D169C141512F;
        Thu, 14 Apr 2022 18:34:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 14 Apr 2022 20:34:37 +0200 (CEST)
Date:   Thu, 14 Apr 2022 20:34:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220414183433.GC32752@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414115410.GA32752@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Oleg Nesterov wrote:
>
> OK, let me think about it. Thanks!

So. what do you think about the patch below?

If it can work, then 1/5 needs some changes, I think. In particular,
it should not introduce JOBCTL_TRACED_FROZEN until 5/5, and perhaps
we can avoid this flag altogether...

This is how ptrace_check_attach() looks with the patch applied:

	static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
	{
		int traced;
		/*
		 * We take the read lock around doing both checks to close a
		 * possible race where someone else attaches or detaches our
		 * natural child.
		 */
		read_lock(&tasklist_lock);
		traced = child->ptrace && child->parent == current;
		read_unlock(&tasklist_lock);

		if (!traced)
			return -ESRCH;

		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
		if (ignore_state)
			return 0;

		for (;;) {
			if (fatal_signal_pending(current))
				return -EINTR;
			set_current_state(TASK_KILLABLE);
			if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED)) {
				__set_current_state(TASK_RUNNING);
				break;
			}
			schedule();
		}

		if (!wait_task_inactive(child, TASK_TRACED) ||
		    !ptrace_freeze_traced(child))
			return -ESRCH;

		return 0;
	}

Oleg.
---

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
index 626f96d275c7..5a03ae5cb0c0 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -193,20 +193,22 @@ static bool looks_like_a_spurious_pid(struct task_struct *task)
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
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
 		task->jobctl |= JOBCTL_TRACED_FROZEN;
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
+	unlock_task_sighand(task, &flags);
 
 	return ret;
 }
@@ -253,40 +255,39 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
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
+	for (;;) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		set_current_state(TASK_KILLABLE);
+		if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED)) {
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
index 0aea3f0a8002..684f0a0e9c71 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2182,6 +2182,14 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+static void clear_traced_xxx(void)
+{
+	spin_lock_irq(&current->sighand->siglock);
+	current->jobctl &= ~JOBCTL_TRACED_XXX;
+	spin_unlock_irq(&current->sighand->siglock);
+	wake_up_state(current->parent, TASK_KILLABLE);
+}
+
 /*
  * This must be called with current->sighand->siglock held.
  *
@@ -2220,7 +2228,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
 	 */
-	current->jobctl |= JOBCTL_TRACED;
+	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_XXX;
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2282,6 +2290,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		if (gstop_done && ptrace_reparented(current))
 			do_notify_parent_cldstop(current, false, why);
 
+		clear_traced_xxx();
 		/*
 		 * Don't want to allow preemption here, because
 		 * sys_ptrace() needs this task to be inactive.
@@ -2296,9 +2305,6 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		cgroup_leave_frozen(true);
 	} else {
 		/*
-		 * By the time we got the lock, our tracer went away.
-		 * Don't drop the lock yet, another tracer may come.
-		 *
 		 * If @gstop_done, the ptracer went away between group stop
 		 * completion and here.  During detach, it would have set
 		 * JOBCTL_STOP_PENDING on us and we'll re-enter
@@ -2307,13 +2313,14 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		 */
 		if (gstop_done)
 			do_notify_parent_cldstop(current, false, why);
+		clear_traced_xxx();
+		read_unlock(&tasklist_lock);
 
-		/* tasklist protects us from ptrace_freeze_traced() */
+		/* JOBCTL_TRACED_XXX protects us from ptrace_freeze_traced() */
 		__set_current_state(TASK_RUNNING);
 		read_code = false;
 		if (clear_code)
 			exit_code = 0;
-		read_unlock(&tasklist_lock);
 	}
 
 	/*


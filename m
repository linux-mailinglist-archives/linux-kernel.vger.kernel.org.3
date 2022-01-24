Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB0B498196
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiAXOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbiAXOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:00:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC98C06173B;
        Mon, 24 Jan 2022 06:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5cU759WzEiiLaUbHS8OBaqe876UiieYZnSAHTf2+qXM=; b=GKN7Dp1fJ0uH1BQ4xSinNFZK2F
        20a9IMNdMJpzmhRWrHl9VrWjagX11nGO7cgwQhopffLijVgQ2TWOm5USXaEcs+yi5v+xh2JjsTqHV
        pZDvGwws6pmbRwQbSl1tEJwMf75/nQXGr24+5D+QAF8NNXnKkyFQLr2kqNVm9L4Q8BGP+UAhoKdsY
        wgdDqApMxTUbidkmhiyIQ30ulNEVt/RFL+JsQFOj38wcvN3FuOPGeVRUtM7gcSoflFuwFev/CTssT
        S1MuA3YrUMorgK85OkFuXW6cTWDxjpvq5eEQ82ONLrVQyUansXZmR6z0TR1fzH8WiF1ci/7HUmDu+
        AvH9cG4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBzsq-003AIu-U0; Mon, 24 Jan 2022 13:59:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D24D3002C5;
        Mon, 24 Jan 2022 14:59:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D9FD2B373699; Mon, 24 Jan 2022 14:59:46 +0100 (CET)
Date:   Mon, 24 Jan 2022 14:59:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <Ye6w0qw1VpfLL0Ng@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <20220121114758.GF20638@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121114758.GF20638@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:47:58PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:
> 
> > +SYSCALL_DEFINE2(umcg_wait, u32, flags, u64, timo)
> > +{
> > +	struct task_struct *tsk = current;
> > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > +	bool worker = tsk->flags & PF_UMCG_WORKER;
> > +	int ret;
> > +
> > +	if (!self || flags)
> > +		return -EINVAL;
> > +
> > +	if (worker) {
> > +		tsk->flags &= ~PF_UMCG_WORKER;
> > +		if (timo)
> > +			return -ERANGE;
> > +	}
> > +
> > +	/* see umcg_sys_{enter,exit}() syscall exceptions */
> > +	ret = umcg_pin_pages();
> > +	if (ret)
> > +		goto unblock;
> > +
> > +	/*
> > +	 * Clear UMCG_TF_COND_WAIT *and* check state == RUNNABLE.
> > +	 */
> > +	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNABLE);
> > +	if (ret)
> > +		goto unpin;
> > +
> > +	ret = umcg_wake_next(tsk, self);
> > +	if (ret)
> > +		goto unpin;
> > +
> > +	if (worker) {
> > +		/*
> > +		 * If this fails it is possible ::next_tid is already running
> > +		 * while this task is not going to block. This violates our
> > +		 * constraints.
> > +		 *
> > +		 * That said, pretty much the only way to make this fail is by
> > +		 * force munmap()'ing things. In which case one is most welcome
> > +		 * to the pieces.
> > +		 */
> > +		ret = umcg_enqueue_and_wake(tsk);
> > +		if (ret)
> > +			goto unpin;
> > +	}
> > +
> > +	umcg_unpin_pages();
> > +
> > +	ret = umcg_wait(timo);
> > +	switch (ret) {
> > +	case 0:		/* all done */
> > +	case -EINTR:	/* umcg_notify_resume() will continue the wait */
> 
> So I was playing with the whole worker timeout thing last night and
> realized this is broken. If we get a signal while we have a timeout, the
> timeout gets lost.
> 
> I think the easiest solution is to have umcg_notify_resume() also resume
> the timeout, but the first pass of that was yuck, so I need to try
> again.
> 
> Related, by moving the whole enqueue-and-wake thing into the timeout, we
> get more 'fun' failure cases :-(

This is the best I can come up with,... but it's a hot mess :-(

Still, let me go try this.

---

--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -127,6 +127,14 @@ struct umcg_task {
 } __attribute__((packed, aligned(UMCG_TASK_ALIGN)));
 
 /**
+ * enum umcg_wait_flag - flags to pass to sys_umcg_wait
+ * @UMCG_WAIT_ENQUEUE:	Enqueue the task on runnable_workers_ptr before waiting
+ */
+enum umcg_wait_flag {
+	UMCG_WAIT_ENQUEUE	= 0x0001,
+};
+
+/**
  * enum umcg_ctl_flag - flags to pass to sys_umcg_ctl
  * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
  * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -227,7 +227,6 @@ static int umcg_update_state(struct task
 
 #define UMCG_DIE(reason)	__UMCG_DIE(,reason)
 #define UMCG_DIE_PF(reason)	__UMCG_DIE(pagefault_enable(), reason)
-#define UMCG_DIE_UNPIN(reason)	__UMCG_DIE(umcg_unpin_pages(), reason)
 
 /* Called from syscall enter path and exceptions that can schedule */
 void umcg_sys_enter(struct pt_regs *regs, long syscall)
@@ -371,15 +370,23 @@ static int umcg_enqueue_runnable(struct
 
 static int umcg_enqueue_and_wake(struct task_struct *tsk)
 {
-	int ret;
-
-	ret = umcg_enqueue_runnable(tsk);
+	int ret = umcg_enqueue_runnable(tsk);
 	if (!ret)
 		ret = umcg_wake_server(tsk);
 
 	return ret;
 }
 
+static int umcg_pin_enqueue_and_wake(struct task_struct *tsk)
+{
+	int ret = umcg_pin_pages();
+	if (!ret) {
+		ret = umcg_enqueue_and_wake(tsk);
+		umcg_unpin_pages();
+	}
+	return ret;
+}
+
 /*
  * umcg_wait: Wait for ->state to become RUNNING
  *
@@ -469,16 +476,11 @@ static void umcg_unblock_and_wait(void)
 	/* avoid recursion vs schedule() */
 	tsk->flags &= ~PF_UMCG_WORKER;
 
-	if (umcg_pin_pages())
-		UMCG_DIE("pin");
-
 	if (umcg_update_state(tsk, self, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE))
-		UMCG_DIE_UNPIN("state");
+		UMCG_DIE("state");
 
-	if (umcg_enqueue_and_wake(tsk))
-		UMCG_DIE_UNPIN("enqueue-wake");
-
-	umcg_unpin_pages();
+	if (umcg_pin_enqueue_and_wake(tsk))
+		UMCG_DIE("pin-enqueue-wake");
 
 	switch (umcg_wait(0)) {
 	case 0:
@@ -544,18 +546,13 @@ void umcg_notify_resume(struct pt_regs *
 		goto done;
 
 	if (state & UMCG_TF_PREEMPT) {
-		if (umcg_pin_pages())
-			UMCG_DIE("pin");
-
 		if (umcg_update_state(tsk, self,
 				      UMCG_TASK_RUNNING,
 				      UMCG_TASK_RUNNABLE))
-			UMCG_DIE_UNPIN("state");
+			UMCG_DIE("state");
 
-		if (umcg_enqueue_and_wake(tsk))
-			UMCG_DIE_UNPIN("enqueue-wake");
-
-		umcg_unpin_pages();
+		if (umcg_pin_enqueue_and_wake(tsk))
+			UMCG_DIE("pin-enqueue-wake");
 	}
 
 	if (WARN_ON_ONCE(timeout && syscall_get_nr(tsk, regs) != __NR_umcg_wait))
@@ -570,6 +567,13 @@ void umcg_notify_resume(struct pt_regs *
 
 	case -ETIMEDOUT:
 		regs_set_return_value(regs, ret);
+		if (worker) {
+			ret = umcg_pin_enqueue_and_wake(tsk);
+			if (ret) {
+				umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING);
+				regs_set_return_value(regs, ret);
+			}
+		}
 		break;
 
 	default:
@@ -710,7 +714,6 @@ static int umcg_wake_next(struct task_st
  * Returns:
  * 0		- OK;
  * -ETIMEDOUT	- the timeout expired;
- * -ERANGE	- the timeout is out of range (worker);
  * -EAGAIN	- ::state wasn't RUNNABLE, concurrent wakeup;
  * -EFAULT	- failed accessing struct umcg_task __user of the current
  *		  task, the server or next;
@@ -725,48 +728,40 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 	bool worker = tsk->flags & PF_UMCG_WORKER;
 	int ret;
 
-	if (!self || flags)
+	if (!self || (flags & ~(UMCG_WAIT_ENQUEUE)))
 		return -EINVAL;
 
-	if (worker) {
-		tsk->flags &= ~PF_UMCG_WORKER;
-		if (timo)
-			return -ERANGE;
-	}
+	if ((flags & UMCG_WAIT_ENQUEUE) && (timo || !worker))
+		return -EINVAL;
 
-	/* see umcg_sys_{enter,exit}() syscall exceptions */
-	ret = umcg_pin_pages();
-	if (ret)
-		goto unblock;
+	if (worker)
+		tsk->flags &= ~PF_UMCG_WORKER;
 
 	/*
 	 * Clear UMCG_TF_COND_WAIT *and* check state == RUNNABLE.
 	 */
 	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNABLE);
 	if (ret)
-		goto unpin;
+		goto unblock;
 
 	ret = umcg_wake_next(tsk, self);
 	if (ret)
-		goto unpin;
+		goto unblock;
 
-	if (worker) {
+	if (flags & UMCG_WAIT_ENQUEUE) {
 		/*
 		 * If this fails it is possible ::next_tid is already running
 		 * while this task is not going to block. This violates our
 		 * constraints.
 		 *
-		 * That said, pretty much the only way to make this fail is by
-		 * force munmap()'ing things. In which case one is most welcome
-		 * to the pieces.
+		 * Userspace can detect this case by looking at: ::next_tid &
+		 * TID_RUNNING.
 		 */
-		ret = umcg_enqueue_and_wake(tsk);
+		ret = umcg_pin_enqueue_and_wake(tsk);
 		if (ret)
-			goto unpin;
+			goto unblock;
 	}
 
-	umcg_unpin_pages();
-
 	ret = umcg_wait(timo);
 	switch (ret) {
 	case 0:		/* all done */
@@ -775,6 +770,26 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 		ret = 0;
 		break;
 
+	case -ETIMEDOUT:
+		if (worker) {
+			/*
+			 * See the UMCG_WAIT_ENQUEUE case above; except this is
+			 * even more complicated because we *did* wait and
+			 * things might have progressed lots.
+			 *
+			 * Still, abort the wait because otherwise nobody would
+			 * ever find us again. Hopefully userspace can make
+			 * sense of things.
+			 */
+			ret = umcg_pin_enqueue_and_wake(tsk);
+			if (ret)
+				goto unblock;
+
+			ret = -ETIMEDOUT;
+			break;
+		}
+		goto unblock;
+
 	default:
 		goto unblock;
 	}
@@ -783,8 +798,6 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 		tsk->flags |= PF_UMCG_WORKER;
 	return ret;
 
-unpin:
-	umcg_unpin_pages();
 unblock:
 	umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING);
 	goto out;

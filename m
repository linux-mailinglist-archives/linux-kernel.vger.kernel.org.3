Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BC49B86E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453172AbiAYQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378661AbiAYQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:15:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7410C06175B;
        Tue, 25 Jan 2022 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ca5rmCPEKBrd9tAfJv698O/VSPzWzu2bn5HtLOiJRFQ=; b=s7W05u/tqTbeHiA9zszWfbGSqU
        8ETsPfmekohYOTJF2QfZ/08ogoyeHNFxZ0dc2qLGfqO7Mmr6lixUM92ceDIe1PnuWUAhNV0cuapPw
        2wNN5HfeoW15y/XN66dgF4+jaxVOK+6zyuuPMnlvxyPPFvxGdmXWN60Urb4opGoWTxJs4+pVMvxBG
        LYILfmAGq//m0Lg6pdc/cNe+2TBztFBH6QD6A1GEV+irVnGX0Rh+1PIs5e9BhZUEPdTywQTJ4bcIT
        v8oEEZF2myC9F3Ma9kfVx32tQabjfa+UMx6j0K6MCz1AYbjxAnNZTD3Huqqqk0eMp2FqG//xcUnIT
        7Rh31qKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCOT2-0032gq-WE; Tue, 25 Jan 2022 16:14:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD1163002C5;
        Tue, 25 Jan 2022 15:59:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 977062B3A959E; Tue, 25 Jan 2022 15:59:31 +0100 (CET)
Date:   Tue, 25 Jan 2022 15:59:31 +0100
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
Message-ID: <YfAQU6q6jQ/D5AYl@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <20220121114758.GF20638@worktop.programming.kicks-ass.net>
 <20220121151845.GB22849@worktop.programming.kicks-ass.net>
 <Ye635PiRpv4rXVl0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye635PiRpv4rXVl0@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:29:56PM +0100, Peter Zijlstra wrote:

> Oh how I hate signals... this can get scribbled by a syscall/fault from
> sigcontext :/

OK, the below seems to work. I'll see if I can clean it up some.

--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -94,28 +94,44 @@ static inline int syscall_get_arch(struc
 
 #else	 /* CONFIG_X86_64 */
 
-static inline void syscall_get_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 unsigned long *args)
+static inline unsigned long
+syscall_get_argument(struct task_struct *task, struct pt_regs *regs, int nr)
 {
-# ifdef CONFIG_IA32_EMULATION
+#ifdef CONFIG_IA32_EMULATION
 	if (task->thread_info.status & TS_COMPAT) {
-		*args++ = regs->bx;
-		*args++ = regs->cx;
-		*args++ = regs->dx;
-		*args++ = regs->si;
-		*args++ = regs->di;
-		*args   = regs->bp;
+		switch (nr) {
+		case 0: return regs->bx;
+		case 1: return regs->cx;
+		case 2: return regs->dx;
+		case 3: return regs->si;
+		case 4: return regs->di;
+		case 5: return regs->bp;
+		}
 	} else
-# endif
+#endif
 	{
-		*args++ = regs->di;
-		*args++ = regs->si;
-		*args++ = regs->dx;
-		*args++ = regs->r10;
-		*args++ = regs->r8;
-		*args   = regs->r9;
+		switch (nr) {
+		case 0: return regs->di;
+		case 1: return regs->si;
+		case 2: return regs->dx;
+		case 3: return regs->r10;
+		case 4: return regs->r8;
+		case 5: return regs->r9;
+		}
 	}
+
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned long *args)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		*args++ = syscall_get_argument(task, regs, i);
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1307,6 +1307,9 @@ struct task_struct {
 	struct task_struct	*umcg_server;
 	struct umcg_task __user *umcg_server_task;
 	struct page		*umcg_server_page;
+
+	unsigned long		umcg_stack_pointer;
+	unsigned int		umcg_worker;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -459,7 +459,7 @@ static int umcg_wait(u64 timo)
 /*
  * Blocked case for umcg_sys_exit(), shared with sys_umcg_ctl().
  */
-static void umcg_unblock_and_wait(void)
+static void umcg_unblock(void)
 {
 	struct task_struct *tsk = current;
 	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
@@ -478,15 +478,7 @@ static void umcg_unblock_and_wait(void)
 
 	umcg_unpin_pages();
 
-	switch (umcg_wait(0)) {
-	case 0:
-	case -EINTR:
-		/* notify_resume will continue the wait after the signal */
-		break;
-
-	default:
-		UMCG_DIE("wait");
-	}
+	/* notify-resume will wait */
 
 	tsk->flags |= PF_UMCG_WORKER;
 }
@@ -509,7 +501,7 @@ void umcg_sys_exit(struct pt_regs *regs)
 		return;
 	}
 
-	umcg_unblock_and_wait();
+	umcg_unblock();
 }
 
 /* return-to-user path */
@@ -518,11 +510,47 @@ void umcg_notify_resume(struct pt_regs *
 	struct task_struct *tsk = current;
 	struct umcg_task __user *self = tsk->umcg_task;
 	bool worker = tsk->flags & PF_UMCG_WORKER;
+	u64 timeout = 0;
 	u32 state;
+	int ret;
+
+	/*
+	 * Unix signals are horrible, but we have to handle them somehow.
+	 *
+	 * - simply discarding a signal breaks userspace so is not an option.
+	 *
+	 * - returning -EINTR and have userspace deal with it is not an option
+	 *   since we can be blocked here due to !syscall reasons (page-faults
+	 *   for example). But it's also not permissible to have random
+	 *   syscalls return -EINTR that didn't before.
+	 *
+	 * - subjecting signal handlers to UMCG would render existing signal
+	 *   handler code subject to the whims and latencies of UMCG; given that
+	 *   most signal hander code is short and time sensitive, this seems
+	 *   undesirable (consider ^C not working because it got delivered to a
+	 *   blocked task).
+	 *
+	 * Therefore the chosen path is to exclude signal context from UMCG
+	 * entirely and treat it as unmanaged time.
+	 */
+	if (tsk->umcg_stack_pointer) {
+		if (tsk->umcg_stack_pointer != user_stack_pointer(regs))
+			return;
+
+		tsk->umcg_stack_pointer = 0;
+		worker = tsk->umcg_worker;
+		tsk->umcg_worker = 0;
+
+		if (worker) {
+			set_syscall_work(SYSCALL_UMCG);
+			/* and PF_UMCG_SYSCALL at done */
+		}
+		goto resume;
+	}
 
 	/* avoid recursion vs schedule() */
 	if (worker)
-		current->flags &= ~PF_UMCG_WORKER;
+		tsk->flags &= ~PF_UMCG_WORKER;
 
 	if (get_user(state, &self->state))
 		UMCG_DIE("get-state");
@@ -554,10 +582,31 @@ void umcg_notify_resume(struct pt_regs *
 		umcg_unpin_pages();
 	}
 
-	switch (umcg_wait(0)) {
+resume:
+	/*
+	 * Hack alert! Since the return-to-user path must resume waiting it
+	 * needs access to the timeout argument and set the return value.
+	 */
+	if (syscall_get_nr(tsk, regs) == __NR_umcg_wait)
+		timeout = syscall_get_argument(tsk, regs, 1);
+
+	ret = umcg_wait(timeout);
+	switch (ret) {
 	case 0:
+		break;
+
 	case -EINTR:
 		/* we will resume the wait after the signal */
+		WARN_ON_ONCE(tsk->umcg_stack_pointer);
+		tsk->umcg_stack_pointer = user_stack_pointer(regs);
+		tsk->umcg_worker = worker;
+		clear_task_syscall_work(tsk, SYSCALL_UMCG);
+		/* implicitly clears PF_UMCG_WORKER with the early exit */
+		return;
+
+	case -ETIMEDOUT:
+		/* must be __NR_umcg_wait */
+		regs_set_return_value(regs, ret);
 		break;
 
 	default:
@@ -566,7 +615,7 @@ void umcg_notify_resume(struct pt_regs *
 
 done:
 	if (worker)
-		current->flags |= PF_UMCG_WORKER;
+		tsk->flags |= PF_UMCG_WORKER;
 }
 
 /**
@@ -755,16 +804,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 
 	umcg_unpin_pages();
 
-	ret = umcg_wait(timo);
-	switch (ret) {
-	case 0:		/* all done */
-	case -EINTR:	/* umcg_notify_resume() will continue the wait */
-		ret = 0;
-		break;
-
-	default:
-		goto unblock;
-	}
+	/* notify-resume will wait */
 out:
 	if (worker)
 		tsk->flags |= PF_UMCG_WORKER;
@@ -831,7 +871,7 @@ static int umcg_register(struct umcg_tas
 		set_syscall_work(SYSCALL_UMCG);		/* hook syscall */
 		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
 
-		umcg_unblock_and_wait();
+		umcg_unblock();
 
 	} else {
 		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_RUNNING)

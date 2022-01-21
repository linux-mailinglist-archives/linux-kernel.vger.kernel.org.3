Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0B4961E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351328AbiAUPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351337AbiAUPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:19:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24711C06173B;
        Fri, 21 Jan 2022 07:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ApWlAhGVn9PnMXNrJHt7gtCR31r9LK5mSVjYiz9qbVc=; b=dB7pkf5xgvL8JqzBxZV7AwA+Zy
        vdfTp734SREq/U3hYDd9Q/sBd0koUEWpk9iO5Qx7RLXpYua9nmzkTlMwPN1q/ZNL5Puya3OGkUk1X
        x5uOyr/uma6z/4nnft7NFTCfjVljHcrSXMDoxlUNQNlC9ERC0nDZECbRN/3klhbmX3aV2U34u2/tj
        U7e5XE0J7KQ0fkKaPfYj4xjUOL7PFW2kj9iZ5y4cRV8ofZj8xfgqzOQ75By4lXQDTiMmapgt1pb1u
        crpRPhPuu1uCdhB1Ush2xcTOC3ZcDWS7P5K3HVAti1IbBmJYliHUeadZ02cO5RfNbD7lYvDW49xTT
        CE1kbowA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAvgd-002bJm-NE; Fri, 21 Jan 2022 15:18:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 063E49867E1; Fri, 21 Jan 2022 16:18:46 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:18:45 +0100
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
Message-ID: <20220121151845.GB22849@worktop.programming.kicks-ass.net>
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

Something like this, still yuck though. Also still need to write me a
test for this.

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1300,12 +1300,14 @@ struct task_struct {
 	clockid_t		umcg_clock;
 	struct umcg_task __user	*umcg_task;
 
-	/* setup by umcg_pin_enter() */
+	/* setup by umcg_pin_pages() */
 	struct page		*umcg_page;
 
 	struct task_struct	*umcg_server;
 	struct umcg_task __user *umcg_server_task;
 	struct page		*umcg_server_page;
+
+	u64			umcg_timeout;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -232,6 +232,8 @@ static int umcg_update_state(struct task
 /* Called from syscall enter path and exceptions that can schedule */
 void umcg_sys_enter(struct pt_regs *regs, long syscall)
 {
+	current->umcg_timeout = 0;
+
 	/* avoid recursion vs our own syscalls */
 	if (syscall == __NR_umcg_wait ||
 	    syscall == __NR_umcg_ctl)
@@ -519,6 +521,7 @@ void umcg_notify_resume(struct pt_regs *
 	struct umcg_task __user *self = tsk->umcg_task;
 	bool worker = tsk->flags & PF_UMCG_WORKER;
 	u32 state;
+	int ret;
 
 	/* avoid recursion vs schedule() */
 	if (worker)
@@ -554,12 +557,17 @@ void umcg_notify_resume(struct pt_regs *
 		umcg_unpin_pages();
 	}
 
-	switch (umcg_wait(0)) {
+	ret = umcg_wait(tsk->umcg_timeout);
+	switch (ret) {
 	case 0:
 	case -EINTR:
 		/* we will resume the wait after the signal */
 		break;
 
+	case -ETIMEDOUT:
+		regs_set_return_value(regs, ret);
+		break;
+
 	default:
 		UMCG_DIE("wait");
 	}
@@ -759,6 +767,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 	switch (ret) {
 	case 0:		/* all done */
 	case -EINTR:	/* umcg_notify_resume() will continue the wait */
+		tsk->umcg_timeout = timo;
 		ret = 0;
 		break;
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14B490733
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiAQLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiAQLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:35:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FBC061574;
        Mon, 17 Jan 2022 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4dydwPMjO4FnjpZSHo9LwvJN0XBlZUGpPQmY28SvGGk=; b=Bg/rKtqQ35I6yUXLjaNHtkdagP
        fIgMRMSWeqqCi1eI0Uo06Nw+UGh05OM6VlOavxjGqW7R41bXGzezaX5LyQWYwBdEbg+QjVjUD+JpU
        ZHklCELif+vur1Hhlix6omCJ3APlktdRkkPMZQCkuWIRS8nYqY1+6d6HxYUnE03BGE+ILxGV8k111
        qoNVbmT6hnhwRnEUimyF82HB+alB9tj6sPSmdxda1QoPlzpWVyoUYio0q+Y4zuIEL/XkFHFd2Q0/S
        RfOei2FZKFFH+zrxW5fcbhHEa2DhtqSga2NFVvRwp6ZbWe469sHkA2LVAw8h9dKkMne8nsCUEG9xk
        LB/aO03Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9QIO-0085JA-BD; Mon, 17 Jan 2022 11:35:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F5B0300237;
        Mon, 17 Jan 2022 12:35:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D840E2C8A4AB6; Mon, 17 Jan 2022 12:35:29 +0100 (CET)
Date:   Mon, 17 Jan 2022 12:35:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeVUgXd6C85VmaP7@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:09:55PM +0100, Peter Zijlstra wrote:
> > > +SYSCALL_DEFINE3(umcg_ctl, u32, flags, struct umcg_task __user *, self, clockid_t, which_clock)
> > > +{
> > > +	struct task_struct *server;
> > > +	struct umcg_task ut;
> > > +
> > > +	if ((unsigned long)self % UMCG_TASK_ALIGN)
> > > +		return -EINVAL;
> > > +
> > > +	if (flags & ~(UMCG_CTL_REGISTER |
> > > +		      UMCG_CTL_UNREGISTER |
> > > +		      UMCG_CTL_WORKER))
> > > +		return -EINVAL;
> > > +
> > > +	if (flags == UMCG_CTL_UNREGISTER) {
> > > +		if (self || !current->umcg_task)
> > > +			return -EINVAL;
> > > +
> > > +		if (current->flags & PF_UMCG_WORKER)
> > > +			umcg_worker_exit();
> > 
> > The server should be woken here. Imagine: one server, one worker.
> > The server is sleeping, the worker is running. The worker unregisters,
> > the server keeps sleeping forever?
> > 
> > I'm OK re: NOT waking the server if the worker thread exits without
> > unregistering, as this is the userspace breaking the contract/protocol.
> > But here we do need to notify the server. At the minimum so that the
> > server can schedule a worker to run in its place.
> > 
> > (Why is this important? Worker count can fluctuate considerably:
> > on load spikes many new workers may be created, and later in
> > quiet times they exit to free resources.)
> 
> Fair enough. Will do.

Something like so then...

---
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -185,13 +185,6 @@ void umcg_clear_child(struct task_struct
 	umcg_clear_task(tsk);
 }
 
-/* Called both by normally (unregister) and abnormally exiting workers. */
-void umcg_worker_exit(void)
-{
-	umcg_unpin_pages();
-	umcg_clear_task(current);
-}
-
 /*
  * Do a state transition: @from -> @to.
  *
@@ -748,32 +741,43 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
  * sys_umcg_ctl: (un)register the current task as a UMCG task.
  * @flags:       ORed values from enum umcg_ctl_flag; see below;
  * @self:        a pointer to struct umcg_task that describes this
- *               task and governs the behavior of sys_umcg_wait if
- *               registering; must be NULL if unregistering.
+ *               task and governs the behavior of sys_umcg_wait.
  * @which_clock: clockid to use for timestamps and timeouts
  *
  * @flags & UMCG_CTL_REGISTER: register a UMCG task:
  *
- *         UMCG workers:
- *              - @flags & UMCG_CTL_WORKER
- *              - self->state must be UMCG_TASK_BLOCKED
- *
- *         UMCG servers:
- *              - !(@flags & UMCG_CTL_WORKER)
- *              - self->state must be UMCG_TASK_RUNNING
- *
- *         All tasks:
- *              - self->server_tid must be a valid server
- *              - self->next_tid must be zero
- *
- *         If the conditions above are met, sys_umcg_ctl() immediately returns
- *         if the registered task is a server. If the registered task is a
- *         worker it will be added to it's server's runnable_workers_ptr list
- *         and the server will be woken.
- *
- * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
- *           is a UMCG worker, the userspace is responsible for waking its
- *           server (before or after calling sys_umcg_ctl).
+ *	UMCG workers:
+ *	 - @flags & UMCG_CTL_WORKER
+ *	 - self->state must be UMCG_TASK_BLOCKED
+ *
+ *	UMCG servers:
+ *	 - !(@flags & UMCG_CTL_WORKER)
+ *	 - self->state must be UMCG_TASK_RUNNING
+ *
+ *	All tasks:
+ *	 - self->server_tid must be a valid server
+ *	 - self->next_tid must be zero
+ *
+ *	If the conditions above are met, sys_umcg_ctl() immediately returns
+ *	if the registered task is a server. If the registered task is a
+ *	worker it will be added to it's server's runnable_workers_ptr list
+ *	and the server will be woken.
+ *
+ * @flags & UMCG_CTL_UNREGISTER: unregister a UMCG task.
+ *
+ *	UMCG workers:
+ *	 - @flags & UMCG_CTL_WORKER
+ *
+ *	UMCG servers:
+ *	 - !(@flags & UMCG_CTL_WORKER)
+ *
+ *	All tasks:
+ *	 - self must match with UMCG_CTL_REGISTER
+ *	 - self->state must be UMCG_TASK_RUNNING
+ *	 - self->server_tid must be a valid server
+ *
+ * 	If the conditions above are met, sys_umcg_ctl() will change state to
+ * 	UMCG_TASK_NONE, and for workers, wake either next or server.
  *
  * Return:
  * 0		- success
@@ -794,16 +798,31 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
 		      UMCG_CTL_WORKER))
 		return -EINVAL;
 
-	if (flags == UMCG_CTL_UNREGISTER) {
-		if (self || !current->umcg_task)
+	if (flags & UMCG_CTL_UNREGISTER) {
+		int ret;
+
+		if (!self || self != current->umcg_task)
 			return -EINVAL;
 
-		if (current->flags & PF_UMCG_WORKER) {
-			umcg_worker_exit();
-			// XXX wake server
-		} else
-			umcg_clear_task(current);
+		current->flags &= ~PF_UMCG_WORKER;
 
+		ret = umcg_pin_pages();
+		if (ret) {
+			current->flags |= PF_UMCG_WORKER;
+			return ret;
+		}
+
+		ret = umcg_update_state(current, self, UMCG_TASK_RUNNING, UMCG_TASK_NONE);
+		if (ret) {
+			current->flags |= PF_UMCG_WORKER;
+			return ret;
+		}
+
+		if (current->flags & PF_UMCG_WORKER)
+			umcg_wake(current);
+
+		umcg_unpin_pages();
+		umcg_clear_task(current);
 		return 0;
 	}
 

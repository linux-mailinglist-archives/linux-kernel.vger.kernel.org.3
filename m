Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF68472E30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbhLMNz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbhLMNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:55:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E02C06173F;
        Mon, 13 Dec 2021 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4YexKwKozra0oKxp5TjVv7Mz5v1wkSE+AXkRaZfsdCY=; b=XGrSt7YgvuxHZvE4rUc4wzSaTP
        1jKn3r4Xi2+n6XJWgt7w48lxMT3sl626v7DNC2p9SKfXz/1o0UFQq9hBailB611xyIvzJIYlINOfd
        MzWPzLBA7uWU4EULoABp6HyOA/uiroEuEzniayjVsPB7p92SKM3HcdPjKQ1y2u/N7GrDrjihqYNIR
        Caq9ZRviHUXRhYvISA5G6OSnFcDNcDu6MJHqVKrIxGw1pIS+WBWQXt9XUjBbYUUCdiDXJxpKQQCR9
        dOB+ECGIToBO2r6rwSrIxLZZt+U/tA70eTzQrAnOrM1aY5rRomAZFmNFWc5xovx9sD4brlhVFdrWZ
        Hws/rhGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwlnr-00CqGo-Ny; Mon, 13 Dec 2021 13:55:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61B54300056;
        Mon, 13 Dec 2021 14:55:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40D682CB62AC3; Mon, 13 Dec 2021 14:55:42 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:55:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YbdQ3tmke53kdHHY@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <20211129210841.GO721624@worktop.programming.kicks-ass.net>
 <CAFTs51XyGDNj89+FCn4HZqMHuenjQu2wqTOW8ow4hSUbdGrGhw@mail.gmail.com>
 <Ya30xsrQnwyT/R92@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya30xsrQnwyT/R92@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:32:22PM +0100, Peter Zijlstra wrote:
> 
> Sorry, I haven't been feeling too well and as such procastinated on this
> because thinking is required :/ Trying to pick up the bits.

*sigh* and yet another week gone... someone was unhappy about refcount_t.


> No, the failure case is different; umcg_notify_resume() will simply
> block A until someone sets A::state == RUNNING and kicks it, which will
> be no-one.
> 
> Now, the above situation is actually simple to fix, but it gets more
> interesting when we're using sys_umcg_wait() to build wait primitives.
> Because in that case we get stuff like:
> 
> 	for (;;) {
> 		self->state = RUNNABLE;
> 		smp_mb();
> 		if (cond)
> 			break;
> 		sys_umcg_wait();
> 	}
> 	self->state = RUNNING;
> 
> And we really need to not block and also not do sys_umcg_wait() early.
> 
> So yes, I agree that we need a special case here that ensures
> umcg_notify_resume() doesn't block. Let me ponder naming and comments.
> Either a TF_COND_WAIT or a whole new state. I can't decide yet.
> 
> Now, obviously if you do a random syscall anywhere around here, you get
> to keep the pieces :-)

Something like so I suppose..

--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -42,6 +42,32 @@
  *
  */
 #define UMCG_TF_PREEMPT			0x0100U
+/*
+ * UMCG_TF_COND_WAIT: indicate the task *will* call sys_umcg_wait()
+ *
+ * Enables server loops like (vs umcg_sys_exit()):
+ *
+ *   for(;;) {
+ *	self->status = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
+ *	// smp_mb() implied by xchg()
+ *
+ *	runnable_ptr = xchg(self->runnable_workers_ptr, NULL);
+ *	while (runnable_ptr) {
+ *		next = runnable_ptr->runnable_workers_ptr;
+ *
+ *		umcg_server_add_runnable(self, runnable_ptr);
+ *
+ *		runnable_ptr = next;
+ *	}
+ *
+ *	self->next = umcg_server_pick_next(self);
+ *	sys_umcg_wait(0, 0);
+ *   }
+ *
+ * without a signal or interrupt in between setting umcg_task::state and
+ * sys_umcg_wait() resulting in an infinite wait in umcg_notify_resume().
+ */
+#define UMCG_TF_COND_WAIT		0x0200U
 
 #define UMCG_TF_MASK			0xff00U
 
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -180,7 +180,7 @@ void umcg_worker_exit(void)
 /*
  * Do a state transition, @from -> @to, and possible read @next after that.
  *
- * Will clear UMCG_TF_PREEMPT.
+ * Will clear UMCG_TF_PREEMPT, UMCG_TF_COND_WAIT.
  *
  * When @to == {BLOCKED,RUNNABLE}, update timestamps.
  *
@@ -216,7 +216,8 @@ static int umcg_update_state(struct task
 		if ((old & UMCG_TASK_MASK) != from)
 			goto fail;
 
-		new = old & ~(UMCG_TASK_MASK | UMCG_TF_PREEMPT);
+		new = old & ~(UMCG_TASK_MASK |
+			      UMCG_TF_PREEMPT | UMCG_TF_COND_WAIT);
 		new |= to & UMCG_TASK_MASK;
 
 	} while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
@@ -567,11 +568,13 @@ void umcg_notify_resume(struct pt_regs *
 	if (state == UMCG_TASK_RUNNING)
 		goto done;
 
-	// XXX can get here when:
-	//
-	// self->state = RUNNABLE
-	// <signal>
-	// sys_umcg_wait();
+	/*
+	 * See comment at UMCG_TF_COND_WAIT; TL;DR: user *will* call
+	 * sys_umcg_wait() and signals/interrupts shouldn't block
+	 * return-to-user.
+	 */
+	if (state == UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT)
+		goto done;
 
 	if (state & UMCG_TF_PREEMPT) {
 		if (umcg_pin_pages())
@@ -658,6 +661,13 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 	if (ret)
 		goto unblock;
 
+	/*
+	 * Clear UMCG_TF_COND_WAIT *and* check state == RUNNABLE.
+	 */
+	ret = umcg_update_state(self, tsk, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNABLE);
+	if (ret)
+		goto unpin;
+
 	if (worker) {
 		ret = umcg_enqueue_runnable(tsk);
 		if (ret)

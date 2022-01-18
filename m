Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6647F49238B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiARKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiARKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:09:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E56C061574;
        Tue, 18 Jan 2022 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6liHV220LfGQeWf071bjFsGALMPq/vYxp0KoDb2bAPg=; b=X95i51/UoNNANKjeTBR7ERQns7
        QlLg7W0vZ5FAr1yS2MRBl4RfUQOb7emPoMo5T/dGgwkGOuIrf3uuUUq8F/hyw07kKgbPt4FKyzo/b
        i8Pn/HtfLVxIPK5695SPrCqlpHuFXg3eip260qaowYybDL8NEVSX0m2tLacEji9tW3nVhsXsnDeuh
        3VY6Uy5rvgWyFNznB7FXJBENJW0CSkghxYyCFF9rc+H2WtjVNGeZUVAcOhcL+6HL5qUF4J+6IW0f1
        F0flVobdSwfXAITesV0Zv6ZRLBHQoqu6TpxQWUdILbCHsKNkIZAOSK3ZOhvV4eEFRTUNC3aFsUvxQ
        Ao38qRCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9lQQ-001pCt-FO; Tue, 18 Jan 2022 10:09:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DC0C300252;
        Tue, 18 Jan 2022 11:09:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 531D1212E9D8D; Tue, 18 Jan 2022 11:09:11 +0100 (CET)
Date:   Tue, 18 Jan 2022 11:09:11 +0100
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
Message-ID: <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
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
> On Tue, Dec 21, 2021 at 05:19:00PM +0000, Peter Oskolkov wrote:

> > What does worry me is that in this wakeup the server calls sys_umcg_wait()
> > with another worker in next_tid, so now the server will have two
> > workers running: the current kernel API seems to allow this to happen.
> > In my patchset the invariant that no more than one worker running
> > per server was enforced by the kernel.
> 
> So one of the things I've started, but didn't finished, is to forward
> port the Proxy-Execution patches to a current kernel and play with the
> PE+UMCG interaction.
> 
> Thinking about that interaction I've ran into that exact problem.
> 
> The 'nice' solution is to actually block the worker, but that's also the
> slow solution :/
> 
> The other solution seems to be to keep kernel state; track the current
> worker associated with the server. I haven't (so far) done that due to
> my futex trauma.
> 
> So yes, the current API can be used to do the wrong thing, but the
> kernel doesn't care and you get to keep the pieces in userspace. And I
> much prefer user pieces over kernel pieces.

So I think I came up with a 3rd option; since the TID range is 30 bits
(per FUTEX_TID_MASK) we have those same two top bits to play with.

So we write into server::next_tid the tid of the worker we want to wake;
and we currently have it cleared such that we can distinguish between
the case where sys_umcg_wait() returned an error before or after waking
it.

However; we can use one of the 2 remaining bits to indicate the worker
is woken, let's say bit 31. This then has server::next_tid always
containing the current tid, even when the server has a 'spurious' wakeup
for other things.

Then all we need to do is modify the state check when the bit is set to
ensure we don't wake the worker again if we race sys_umcg_wait() with a
worker blocking.

A bit like this, I suppose... (incompete patch in that it relies on a
whole pile of local changes that might or might not live).

--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -94,6 +94,8 @@ struct umcg_task {
 	 */
 	__u32	state;				/* r/w */
 
+#define UMCG_TID_RUNNING	0x80000000U
+#define UMCG_TID_MASK		0x3fffffffU
 	/**
 	 * @next_tid: the TID of the UMCG task that should be context-switched
 	 *            into in sys_umcg_wait(). Can be zero, in which case
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -20,7 +20,7 @@ static struct task_struct *umcg_get_task
 
 	if (tid) {
 		rcu_read_lock();
-		tsk = find_task_by_vpid(tid);
+		tsk = find_task_by_vpid(tid & UMCG_TID_MASK);
 		if (tsk && current->mm == tsk->mm && tsk->umcg_task)
 			get_task_struct(tsk);
 		else
@@ -289,27 +291,6 @@ static int umcg_wake_task(struct task_st
 	return 0;
 }
 
-static int umcg_wake_next(struct task_struct *tsk)
-{
-	int ret = umcg_wake_task(tsk->umcg_next, tsk->umcg_next_task);
-	if (ret)
-		return ret;
-
-	/*
-	 * If userspace sets umcg_task::next_tid, it needs to remove
-	 * that task from the ready-queue to avoid another server
-	 * selecting it. However, that also means it needs to put it
-	 * back in case it went unused.
-	 *
-	 * By clearing the field on use, userspace can detect this case
-	 * and DTRT.
-	 */
-	if (put_user(0u, &tsk->umcg_task->next_tid))
-		return -EFAULT;
-
-	return 0;
-}
-
 static int umcg_wake_server(struct task_struct *tsk)
 {
 	int ret = umcg_wake_task(tsk->umcg_server, tsk->umcg_server_task);
@@ -637,6 +599,48 @@ SYSCALL_DEFINE2(umcg_kick, u32, flags, p
 	return 0;
 }
 
+static int umcg_wake_next(struct task_struct *tsk, struct umcg_task __user *self)
+{
+	struct umcg_task __user *next_task;
+	struct task_struct *next;
+	u32 next_tid, state;
+	int ret;
+
+	if (get_user(next_tid, &self->next_tid))
+		return -EFAULT;
+
+	next = umcg_get_task(next_tid);
+	if (!next)
+		return -ESRCH;
+
+	next_task = READ_ONCE(next->umcg_task);
+
+	if (next_tid & UMCG_TID_RUNNING) {
+		ret = -EFAULT;
+		if (get_user(state, &next_task->state))
+			goto put_next;
+
+		ret = 0;
+		if ((state & UMCG_TASK_MASK) != UMCG_TASK_RUNNING)
+			ret = -EAGAIN;
+
+	} else {
+		ret = umcg_wake_task(next, next_task);
+		if (ret)
+			goto put_next;
+
+		ret = -EFAULT;
+		if (put_user(next_tid | UMCG_TID_RUNNING, &self->next_tid))
+			goto put_next;
+
+		ret = 0;
+	}
+
+put_next:
+	put_task_struct(next);
+	return ret;
+}
+
 /**
  * sys_umcg_wait: transfer running context
  *


And once we have this, we can add sanity checks that server::next_tid is
what it should be for ever worker moving away from RUNNING state (which
depends on the assumption that all threads are in the same PID
namespace).


Does this make sense?

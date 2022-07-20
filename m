Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F285257BABA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiGTPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiGTPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:44:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C976554B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:44:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658331879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34Do4XAPCDFKT+cOHpVpgJ0obwCGcQhm4QU910jacv4=;
        b=WkW0TIeXHK7Dk2i/Xnd2hmzKy7KAr3FEJ5Atl+X6i5DMKqeyo1waUeQQfn+aA3nh2TvSsQ
        mB/zDJGWVZLAx5wJtPj7o/x0wfz+jJ0cxF7kHXUwCpoefPO3VRolu07LEu/yyrakewxM+u
        QKkZrMFzsFAYRMWFPge80Cx5EkTNmL95fGauD7zZn6e1JZygC1vrneQ/zW40daqHeRk52x
        YOh2yG+pXvsTiUNiUJlYd8Nff7ojOluBYD23vD8j5W09yINxoKCsK7CtmriH4DrNWUadzm
        Waoz2dBqk0XPr55tTR/V38dWd4Ow2PwtxibAV2o8mv6ttazZu/yiJ8WpH+TCfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658331879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34Do4XAPCDFKT+cOHpVpgJ0obwCGcQhm4QU910jacv4=;
        b=mfFtYo2+EqnRFrTI8rewKbQBXLe6/woa4gWqfG/JKxt7+oep0YN9eum1pYboZ9aCFfl03a
        9BvHwl4SwcO2R4BA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] sched: Consider task_struct::saved_state in wait_task_inactive().
Date:   Wed, 20 Jul 2022 17:44:35 +0200
Message-Id: <20220720154435.232749-3-bigeasy@linutronix.de>
In-Reply-To: <20220720154435.232749-1-bigeasy@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ptrace is using wait_task_inactive() to wait for the tracee to reach a
certain task state. On PREEMPT_RT that state may be stored in
task_struct::saved_state while the tracee blocks on a sleeping lock and
task_struct::__state is set to TASK_RTLOCK_WAIT.
It is not possible to check only for TASK_RTLOCK_WAIT to be sure that the t=
ask
is blocked on a sleeping lock because during wake up (after the sleeping lo=
ck
has been acquired) the task state is set TASK_RUNNING. After the task in on=
 CPU
and acquired the pi_lock it will reset the state accordingly but until then
TASK_RUNNING will be observed (with the desired state saved in saved_state).

Check also for task_struct::saved_state if the desired match was not found =
in
task_struct::__state on PREEMPT_RT. If the state was found in saved_state, =
wait
until the task is idle and state is visible in task_struct::__state.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c |   46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3257,6 +3257,40 @@ int migrate_swap(struct task_struct *cur
 }
 #endif /* CONFIG_NUMA_BALANCING */
=20
+#ifdef CONFIG_PREEMPT_RT
+static __always_inline bool state_mismatch(struct task_struct *p, unsigned=
 int match_state)
+{
+	unsigned long flags;
+	bool mismatch;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	mismatch =3D READ_ONCE(p->__state) !=3D match_state &&
+		READ_ONCE(p->saved_state) !=3D match_state;
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return mismatch;
+}
+static __always_inline bool state_match(struct task_struct *p, unsigned in=
t match_state,
+					bool *wait)
+{
+	if (READ_ONCE(p->__state) =3D=3D match_state)
+		return true;
+	if (READ_ONCE(p->saved_state) !=3D match_state)
+		return false;
+	*wait =3D true;
+	return true;
+}
+#else
+static __always_inline bool state_mismatch(struct task_struct *p, unsigned=
 int match_state)
+{
+	return READ_ONCE(p->__state) !=3D match_state;
+}
+static __always_inline bool state_match(struct task_struct *p, unsigned in=
t match_state,
+					bool *wait)
+{
+	return READ_ONCE(p->__state) =3D=3D match_state;
+}
+#endif
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3275,7 +3309,7 @@ int migrate_swap(struct task_struct *cur
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match=
_state)
 {
-	int running, queued;
+	bool running, wait;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
@@ -3301,7 +3335,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) !=3D match_state))
+			if (match_state && state_mismatch(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3314,10 +3348,12 @@ unsigned long wait_task_inactive(struct
 		rq =3D task_rq_lock(p, &rf);
 		trace_sched_wait_task(p);
 		running =3D task_running(rq, p);
-		queued =3D task_on_rq_queued(p);
+		wait =3D task_on_rq_queued(p);
 		ncsw =3D 0;
-		if (!match_state || READ_ONCE(p->__state) =3D=3D match_state)
+
+		if (!match_state || state_match(p, match_state, &wait))
 			ncsw =3D p->nvcsw | LONG_MIN; /* sets MSB */
+
 		task_rq_unlock(rq, p, &rf);
=20
 		/*
@@ -3346,7 +3382,7 @@ unsigned long wait_task_inactive(struct
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued)) {
+		if (unlikely(wait)) {
 			ktime_t to =3D NSEC_PER_SEC / HZ;
=20
 			set_current_state(TASK_UNINTERRUPTIBLE);

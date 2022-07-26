Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5C581402
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiGZNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiGZNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:16:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1B2C11B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:16:52 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:16:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658841410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0VJuUbl8dRQ9GBtjECPS9K6YWEFIbU6VYrrYWlJtZM=;
        b=g2De3XYKZprtNk2YIPkVW4/uc7lnGiSOFnxsa6SZ4qL2ieuVD+dwUH4RsVKvizlgNNR2aM
        wR6ZwYyffoNskPSekwnadnsTazW4czQ8GNSqg/He8wSEx244Eitc/6ddkxfmbs4O7mQO3r
        Smu36i0C0oV37kQUWTx/+/+cccvvl7UGOX1A2mACw8RaMA5vC76D++HPQrX/7SggHq6JGf
        H/ArquF2YM1ImkTHHRgwnzF2VoK4DDQ2UAoWW+XkXKLlL4w1h9gRi57B8vdSs78AESwZYR
        ICnC8ILHFZobieHYw4XYVzaPL3oYgrfeCppvH3XqilkxLknXX5w82513SJe7Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658841410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0VJuUbl8dRQ9GBtjECPS9K6YWEFIbU6VYrrYWlJtZM=;
        b=ZlhWxC+KBfefk6jWigd3HMuBXmWpE/Ne14Az8EBP4WHrfAjRAfSi9GL1fZelPKypn8Ra0y
        cIj74hlqDOQy7FCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2 v2] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <Yt/pQAFQ1xKNK0RY@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
 <20220720154435.232749-3-bigeasy@linutronix.de>
 <xhsmhy1whdqy9.mognet@vschneid.remote.csb>
 <Yt+G/somh8qcKc/R@linutronix.de>
 <xhsmhsfmodvo3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xhsmhsfmodvo3.mognet@vschneid.remote.csb>
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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v1=E2=80=A6v2:
   - Add a comment suggested by Valentin Schneider.

 kernel/sched/core.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++=
+----
 1 file changed, 71 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3257,6 +3257,70 @@ int migrate_swap(struct task_struct *cur
 }
 #endif /* CONFIG_NUMA_BALANCING */
=20
+#ifdef CONFIG_PREEMPT_RT
+
+/*
+ * Consider:
+ *
+ *  set_special_state(X);
+ *
+ *  do_things()
+ *    // Somewhere in there is an rtlock that can be contended:
+ *    current_save_and_set_rtlock_wait_state();
+ *    [...]
+ *    schedule_rtlock(); (A)
+ *    [...]
+ *    current_restore_rtlock_saved_state();
+ *
+ *  schedule(); (B)
+ *
+ * If p->saved_state is anything else than TASK_RUNNING, then p blocked on=
 an
+ * rtlock (A) *before* voluntarily calling into schedule() (B) after setti=
ng its
+ * state to X. For things like ptrace (X=3DTASK_TRACED), the task could ha=
ve more
+ * work to do upon acquiring the lock in do_things() before whoever called
+ * wait_task_inactive() should return. IOW, we have to wait for:
+ *
+ *   p.saved_state =3D TASK_RUNNING
+ *   p.__state     =3D X
+ *
+ * which implies the task isn't blocked on an RT lock and got to schedule(=
) (B).
+ *
+ * Also see comments in ttwu_state_match().
+ */
+
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
@@ -3275,7 +3339,7 @@ int migrate_swap(struct task_struct *cur
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match=
_state)
 {
-	int running, queued;
+	bool running, wait;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
@@ -3301,7 +3365,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) !=3D match_state))
+			if (match_state && state_mismatch(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3314,10 +3378,12 @@ unsigned long wait_task_inactive(struct
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
@@ -3346,7 +3412,7 @@ unsigned long wait_task_inactive(struct
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued)) {
+		if (unlikely(wait)) {
 			ktime_t to =3D NSEC_PER_SEC / HZ;
=20
 			set_current_state(TASK_UNINTERRUPTIBLE);

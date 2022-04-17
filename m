Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC056504773
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiDQKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiDQKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:01:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58661C6C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 02:59:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650189554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=s4hivw2Nm3WvrxMrsyLeUi8HnWlHCgntwjwKq5LRlQs=;
        b=sDdrqi8gE/ogXQwgLBRLq61vnAo8fMuiOTqEzv1FibJnD6zkNqoRF+ccjhSrW1P6Vhy7w0
        QbIV00xcFmK9sLnDVBXJ+pAK6XvoltH3jHilQzEZ5wPYE0EF1h6TUNNMcRQenpgsUSaNfY
        3liuHazA4ygTwC83zXeKISgZCLZkNqWQfpp8kPpgm/qUE/GB4zI4YYfzWsV93lE8C5XlX3
        E6Q099QnFy9NcNyfRu72ESlDUYItwOrD2OrWLCDJAmnRWEpVvJki1YoKKHR8KtSJefaqBQ
        YB4URCCyXKO54gO0Dgpj6uCGFhrbURBqsrHIu5tkBAnNpyM9leq4VBrHcewhJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650189554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=s4hivw2Nm3WvrxMrsyLeUi8HnWlHCgntwjwKq5LRlQs=;
        b=2n2ecEdNv6zTGgz34muX3AbGC6UnoqeJmXh5OH9OBH75rE3mQe53OLK0LMk7rHI20UfZ6e
        lcE505nnrlfZvCCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/urgent for v5.18-rc3
References: <165018953450.44773.6382828227632028472.tglx@xen13>
Message-ID: <165018953595.44773.627425873646698695.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 17 Apr 2022 11:59:13 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2022-=
04-17

up to:  b7ba6d8dc356: cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state


Two fixes for the SMP core:

 - Make the warning condition in flush_smp_call_function_queue() correct,
   which checks a just emptied list head for being empty instead of
   validating that there was no pending entry on the offlined CPU at all.

 - The @cpu member of struct cpuhp_cpu_state is initialized when the CPU
   hotplug thread for the upcoming CPU is created. That's too late because
   the creation of the thread can fail and then the following rollback
   operates on CPU0. Get rid of the CPU member and hand the CPU number to
   the involved functions directly.


Thanks,

	tglx

------------------>
Nadav Amit (1):
      smp: Fix offline cpu check in flush_smp_call_function_queue()

Steven Price (1):
      cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state


 kernel/cpu.c | 36 ++++++++++++++++++------------------
 kernel/smp.c |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5797c2a7a93f..d0a9aa0b42e8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -71,7 +71,6 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
-	int			cpu;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -475,7 +474,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu) { re=
turn true; }
 #endif
=20
 static inline enum cpuhp_state
-cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
+cpuhp_set_state(int cpu, struct cpuhp_cpu_state *st, enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state =3D st->state;
 	bool bringup =3D st->state < target;
@@ -486,14 +485,15 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_=
state target)
 	st->target =3D target;
 	st->single =3D false;
 	st->bringup =3D bringup;
-	if (cpu_dying(st->cpu) !=3D !bringup)
-		set_cpu_dying(st->cpu, !bringup);
+	if (cpu_dying(cpu) !=3D !bringup)
+		set_cpu_dying(cpu, !bringup);
=20
 	return prev_state;
 }
=20
 static inline void
-cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
+cpuhp_reset_state(int cpu, struct cpuhp_cpu_state *st,
+		  enum cpuhp_state prev_state)
 {
 	bool bringup =3D !st->bringup;
=20
@@ -520,8 +520,8 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_=
state prev_state)
 	}
=20
 	st->bringup =3D bringup;
-	if (cpu_dying(st->cpu) !=3D !bringup)
-		set_cpu_dying(st->cpu, !bringup);
+	if (cpu_dying(cpu) !=3D !bringup)
+		set_cpu_dying(cpu, !bringup);
 }
=20
 /* Regular hotplug invocation of the AP hotplug thread */
@@ -541,15 +541,16 @@ static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st)
 	wait_for_ap_thread(st, st->bringup);
 }
=20
-static int cpuhp_kick_ap(struct cpuhp_cpu_state *st, enum cpuhp_state target)
+static int cpuhp_kick_ap(int cpu, struct cpuhp_cpu_state *st,
+			 enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state;
 	int ret;
=20
-	prev_state =3D cpuhp_set_state(st, target);
+	prev_state =3D cpuhp_set_state(cpu, st, target);
 	__cpuhp_kick_ap(st);
 	if ((ret =3D st->result)) {
-		cpuhp_reset_state(st, prev_state);
+		cpuhp_reset_state(cpu, st, prev_state);
 		__cpuhp_kick_ap(st);
 	}
=20
@@ -581,7 +582,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	if (st->target <=3D CPUHP_AP_ONLINE_IDLE)
 		return 0;
=20
-	return cpuhp_kick_ap(st, st->target);
+	return cpuhp_kick_ap(cpu, st, st->target);
 }
=20
 static int bringup_cpu(unsigned int cpu)
@@ -704,7 +705,7 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cp=
uhp_cpu_state *st,
 			 ret, cpu, cpuhp_get_step(st->state)->name,
 			 st->state);
=20
-		cpuhp_reset_state(st, prev_state);
+		cpuhp_reset_state(cpu, st, prev_state);
 		if (can_rollback_cpu(st))
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
 							    prev_state));
@@ -721,7 +722,6 @@ static void cpuhp_create(unsigned int cpu)
=20
 	init_completion(&st->done_up);
 	init_completion(&st->done_down);
-	st->cpu =3D cpu;
 }
=20
 static int cpuhp_should_run(unsigned int cpu)
@@ -875,7 +875,7 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
 	cpuhp_lock_release(true);
=20
 	trace_cpuhp_enter(cpu, st->target, prev_state, cpuhp_kick_ap_work);
-	ret =3D cpuhp_kick_ap(st, st->target);
+	ret =3D cpuhp_kick_ap(cpu, st, st->target);
 	trace_cpuhp_exit(cpu, st->state, prev_state, ret);
=20
 	return ret;
@@ -1107,7 +1107,7 @@ static int cpuhp_down_callbacks(unsigned int cpu, struc=
t cpuhp_cpu_state *st,
 			 ret, cpu, cpuhp_get_step(st->state)->name,
 			 st->state);
=20
-		cpuhp_reset_state(st, prev_state);
+		cpuhp_reset_state(cpu, st, prev_state);
=20
 		if (st->state < prev_state)
 			WARN_ON(cpuhp_invoke_callback_range(true, cpu, st,
@@ -1134,7 +1134,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_=
frozen,
=20
 	cpuhp_tasks_frozen =3D tasks_frozen;
=20
-	prev_state =3D cpuhp_set_state(st, target);
+	prev_state =3D cpuhp_set_state(cpu, st, target);
 	/*
 	 * If the current CPU state is in the range of the AP hotplug thread,
 	 * then we need to kick the thread.
@@ -1165,7 +1165,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_=
frozen,
 	ret =3D cpuhp_down_callbacks(cpu, st, target);
 	if (ret && st->state < prev_state) {
 		if (st->state =3D=3D CPUHP_TEARDOWN_CPU) {
-			cpuhp_reset_state(st, prev_state);
+			cpuhp_reset_state(cpu, st, prev_state);
 			__cpuhp_kick_ap(st);
 		} else {
 			WARN(1, "DEAD callback error for CPU%d", cpu);
@@ -1352,7 +1352,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, =
enum cpuhp_state target)
=20
 	cpuhp_tasks_frozen =3D tasks_frozen;
=20
-	cpuhp_set_state(st, target);
+	cpuhp_set_state(cpu, st, target);
 	/*
 	 * If the current CPU state is in the range of the AP hotplug thread,
 	 * then we need to kick the thread once more.
diff --git a/kernel/smp.c b/kernel/smp.c
index 01a7c1706a58..65a630f62363 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -579,7 +579,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_o=
ffline)
=20
 	/* There shouldn't be any pending callbacks on an offline CPU. */
 	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
-		     !warned && !llist_empty(head))) {
+		     !warned && entry !=3D NULL)) {
 		warned =3D true;
 		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
=20


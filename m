Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5895091AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382295AbiDTU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiDTU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:57:36 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725F72AC65;
        Wed, 20 Apr 2022 13:54:47 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38704)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhHLZ-00GAGP-L9; Wed, 20 Apr 2022 14:54:45 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35090 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhHLW-005fp0-8f; Wed, 20 Apr 2022 14:54:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220413192053.GY2731@worktop.programming.kicks-ass.net>
        <20220413195612.GC2762@worktop.programming.kicks-ass.net>
        <20220414115410.GA32752@redhat.com>
        <20220414183433.GC32752@redhat.com>
        <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
        <20220415101644.GA10421@redhat.com>
        <20220415105755.GA15217@redhat.com>
        <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
        <20220418170104.GA16199@redhat.com>
        <20220420131731.GF2731@worktop.programming.kicks-ass.net>
        <20220420180323.GA14947@redhat.com>
Date:   Wed, 20 Apr 2022 15:54:15 -0500
In-Reply-To: <20220420180323.GA14947@redhat.com> (Oleg Nesterov's message of
        "Wed, 20 Apr 2022 20:03:23 +0200")
Message-ID: <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhHLW-005fp0-8f;;;mid=<875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Ovwzz2K7RgEt23h9OPCR7KLC7E09SQ+A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2409 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 5.0 (0.2%), b_tie_ro: 3.3 (0.1%), parse: 1.60
        (0.1%), extract_message_metadata: 14 (0.6%), get_uri_detail_list: 5
        (0.2%), tests_pri_-1000: 10 (0.4%), tests_pri_-950: 1.10 (0.0%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 1714 (71.2%), check_bayes:
        1713 (71.1%), b_tokenize: 16 (0.7%), b_tok_get_all: 15 (0.6%),
        b_comp_prob: 4.2 (0.2%), b_tok_touch_all: 1673 (69.5%), b_finish: 0.90
        (0.0%), tests_pri_0: 651 (27.0%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 1.89 (0.1%), poll_dns_idle: 0.43 (0.0%),
        tests_pri_10: 1.80 (0.1%), tests_pri_500: 6 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: [RFC][PATCH] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I was thinking about this and I have an approach from a different
direction.  In particular it removes the need for ptrace_freeze_attach
and ptrace_unfreeze_attach to change __state.  Instead a jobctl
bit is used to suppress waking up a process with TASK_WAKEKILL.

I think this would be a good technique to completely decouple
PREEMPT_RT from the work that ptrace_freeze_attach does.

Comments?

Eric

---

The games ptrace_freeze_traced and ptrace_unfreeze_traced have
been playing with __state to remove TASK_WAKEKILL from __state
while a ptrace command is executing.

Instead add JOBCTL_DELAY_WAKEILL and set it in ptrace_freeze_task and
clear it in ptrace_unfreeze_task and the final exit of ptrace_stop.

Then in signal_wake_up_state drop TASK_WAKEKILL if it is sent while
JOBCTL_DELAY_WAKEKILL is set.

As signal_wake_up is the only function that sets TASK_WAKEKILL when
waking a process this achives the same effect with less messing
with state.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

As a proof of concept this seems to work most of the time,
unfortunately I have a bug somewhere (a memory stomp?) and I am
hitting a BUG_ON that asserts __send_signal is not holding
the siglock.

[   97.000168] ------------[ cut here ]------------
[   97.001782] kernel BUG at kernel/signal.c:1086!
[   97.002539] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   97.002846] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.18.0-rc1userns+ #449
[   97.003135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[   97.003480] RIP: 0010:__send_signal+0x256/0x580
[   97.003812] Code: f0 ff ff 49 89 c7 48 85 c0 0f 85 a8 fe ff ff 41 bf 04 00 00 00 44 8d 45 ff e9 f8 fe ff ff 45 31 ff 40
[   97.003812] RSP: 0018:ffffc900000c8e88 EFLAGS: 00000046
[   97.003812] RAX: 0000000000000000 RBX: ffff88800875df00 RCX: 0000000000000001
[   97.003812] RDX: ffff88800875df00 RSI: 0000000000000001 RDI: 000000000000000e
[   97.003812] RBP: 000000000000000e R08: 0000000000000001 R09: 0000000000000000
[   97.003812] R10: 0000000000000000 R11: ffffc900000c8ff8 R12: 0000000000000000
[   97.003812] R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff8115f3f3
[   97.003812] FS:  0000000000000000(0000) GS:ffff8880bcb00000(0000) knlGS:0000000000000000
[   97.003812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.003812] CR2: 00007ffff739c830 CR3: 00000000094d6000 CR4: 00000000000006e0
[   97.003812] Call Trace:
[   97.003812]  <IRQ>
[   97.003812]  group_send_sig_info+0xe1/0x190
[   97.003812]  kill_pid_info+0x78/0x150
[   97.003812]  it_real_fn+0x35/0xe0
[   97.003812]  ? __x64_sys_setitimer+0x150/0x150
[   97.003812]  __hrtimer_run_queues+0x1ca/0x3f0
[   97.003812]  hrtimer_interrupt+0x106/0x220
[   97.003812]  __sysvec_apic_timer_interrupt+0x96/0x260
[   97.003812]  sysvec_apic_timer_interrupt+0x9d/0xd0
[   97.003812]  </IRQ>
[   97.003812]  <TASK>
[   97.003812]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   97.003812] RIP: 0010:default_idle+0x10/0x20
[   97.003812] Code: 8b 04 25 00 b0 01 00 f0 80 60 02 df c3 0f ae f0 0f ae 38 0f ae f0 eb b9 66 90 0f 1f 44 00 00 eb 07 03
[   97.003812] RSP: 0018:ffffc90000093ef8 EFLAGS: 00000246
[   97.003812] RAX: ffffffff823fafb0 RBX: ffff8880056f97c0 RCX: 0000000000000000
[   97.003812] RDX: ffffffff81193e1d RSI: ffffffff82da5301 RDI: ffffffff823fb111
[   97.003812] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   97.003812] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[   97.003812] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   97.003812]  ? mwait_idle+0x70/0x70
[   97.003812]  ? nohz_balance_enter_idle+0x6d/0x220
[   97.003812]  ? default_idle_call+0x21/0x90
[   97.003812]  ? mwait_idle+0x70/0x70
[   97.003812]  default_idle_call+0x59/0x90
[   97.003812]  do_idle+0x1f3/0x260
[   97.003812]  ? finish_task_switch.isra.0+0xef/0x350
[   97.003812]  cpu_startup_entry+0x19/0x20
[   97.003812]  secondary_startup_64_no_verify+0xc3/0xcb
[   97.003812]  </TASK>
[   97.003812] Modules linked in:
[   97.003812] ---[ end trace 0000000000000000 ]---
[   97.003812] RIP: 0010:__send_signal+0x256/0x580
[   97.003812] Code: f0 ff ff 49 89 c7 48 85 c0 0f 85 a8 fe ff ff 41 bf 04 00 00 00 44 8d 45 ff e9 f8 fe ff ff 45 31 ff 40
[   97.003812] RSP: 0018:ffffc900000c8e88 EFLAGS: 00000046
[   97.003812] RAX: 0000000000000000 RBX: ffff88800875df00 RCX: 0000000000000001
[   97.003812] RDX: ffff88800875df00 RSI: 0000000000000001 RDI: 000000000000000e
[   97.003812] RBP: 000000000000000e R08: 0000000000000001 R09: 0000000000000000
[   97.003812] R10: 0000000000000000 R11: ffffc900000c8ff8 R12: 0000000000000000
[   97.003812] R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff8115f3f3
[   97.003812] FS:  0000000000000000(0000) GS:ffff8880bcb00000(0000) knlGS:0000000000000000
[   97.003812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.003812] CR2: 00007ffff739c830 CR3: 00000000094d6000 CR4: 00000000000006e0
[   97.003812] Kernel panic - not syncing: Fatal exception in interrupt
[   97.003812] Kernel Offset: disabled
[   97.003812] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
---
 include/linux/sched/jobctl.h |  2 ++
 kernel/ptrace.c              | 32 ++++++++++++++------------------
 kernel/signal.c              |  5 +++++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a9..4e154ad8205f 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_DELAY_WAKEKILL_BIT	24	/* delay killable wakeups */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +29,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_DELAY_WAKEKILL	(1UL << JOBCTL_DELAY_WAKEKILL_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 4f78d0d5940c..a55320a0e8e3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,7 +197,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		//WARN_ON((task->jobctl & JOBCTL_DELAY_WAKEKILL));
+		task->jobctl |= JOBCTL_DELAY_WAKEKILL;
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -207,7 +208,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	if (!task_is_traced(task))
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -216,13 +217,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
 	 * Recheck state under the lock to close this race.
 	 */
-	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			WRITE_ONCE(task->__state, TASK_TRACED);
-	}
+	spin_unlock_irq(&task->sighand->siglock);
+	WARN_ON(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
+	task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
+	if (fatal_signal_pending(task))
+		wake_up_state(task, TASK_WAKEKILL);
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
@@ -256,7 +255,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+		WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
@@ -267,13 +266,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
+		if (!wait_task_inactive(child, TASK_TRACED)) {
 			/*
 			 * This can only happen if may_ptrace_stop() fails and
 			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
+			 * so we should not worry about leaking JOBCTL_DELAY_WAKEKILL.
 			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+			WARN_ON(!(child->jobctl & JOBCTL_DELAY_WAKEKILL));
 			ret = -ESRCH;
 		}
 	}
@@ -892,7 +891,6 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 * status and clears the code too; this can't race with the tracee, it
 	 * takes siglock after resume.
 	 */
-	need_siglock = data && !thread_group_empty(current);
 	if (need_siglock)
 		spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
@@ -1325,8 +1323,7 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		goto out_put_task_struct;
 
 	ret = arch_ptrace(child, request, addr, data);
-	if (ret || request != PTRACE_DETACH)
-		ptrace_unfreeze_traced(child);
+	ptrace_unfreeze_traced(child);
 
  out_put_task_struct:
 	put_task_struct(child);
@@ -1468,8 +1465,7 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 				  request == PTRACE_INTERRUPT);
 	if (!ret) {
 		ret = compat_arch_ptrace(child, request, addr, data);
-		if (ret || request != PTRACE_DETACH)
-			ptrace_unfreeze_traced(child);
+		ptrace_unfreeze_traced(child);
 	}
 
  out_put_task_struct:
diff --git a/kernel/signal.c b/kernel/signal.c
index 30cd1ca43bcd..a1277580c92e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -762,6 +762,10 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
  */
 void signal_wake_up_state(struct task_struct *t, unsigned int state)
 {
+	/* Suppress wakekill? */
+	if (t->jobctl & JOBCTL_DELAY_WAKEKILL)
+		state &= ~TASK_WAKEKILL;
+
 	set_tsk_thread_flag(t, TIF_SIGPENDING);
 	/*
 	 * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
@@ -2328,6 +2332,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
-- 
2.35.3


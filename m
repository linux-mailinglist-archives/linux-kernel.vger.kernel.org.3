Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421EF4B5B41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiBNUqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:46:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBNUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:46:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23816111C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:44:23 -0800 (PST)
Date:   Mon, 14 Feb 2022 21:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644869993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bXNE4LooGlzlo0G4AK11ajol/4hEQRx4f/cldILJwL0=;
        b=v0KAacvU4tc7OHjoU8wjrxzXaARWq/HrUCuqwNsw7GVHTfzv230/bAPYfFzSx7BnRHBfVM
        Lc96Wl7OltGuTYlJ5np1ledp09qOIG1FvLrlISnVkMxN/G7cgDFvllvMGcrCEzqNExTBJP
        Vgj3pqn/Vf3g/CnNmiZ8fB5Ep2MrGnAzuO1fsYU4VVeQqZOOUi17x4UG5Bhv0RRqER9x9f
        T5UmUmPxqseVxS6fbZMvHJZol8pMjwq8f6yUwhY3VKaUwJihHEAKi1Yvasij7OmC/Y7Rci
        veub4I+LoHiMruMRlSJDn3l/urpyE5I+4VenMtPWZ6QlzjdnjkwsA6dKLIrlHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644869993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bXNE4LooGlzlo0G4AK11ajol/4hEQRx4f/cldILJwL0=;
        b=dTTsfpEIS3NpPxxk2QywVZnf+5RnfK+txM24xXJIJHKOXc1Z3xPtlb4CKN1f8varbd6CPX
        aZBIPUai5RQi64AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] signal/x86: Delay calling signals in atomic
Message-ID: <Ygq5aBB/qMQw6aP5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 14 Jul 2015 14:26:34 +0200

On x86_64 we must disable preemption before we enable interrupts
for stack faults, int3 and debugging, because the current task is using
a per CPU debug stack defined by the IST. If we schedule out, another task
can come in and use the same stack and cause the stack to be corrupted
and crash the kernel on return.

When CONFIG_PREEMPT_RT is enabled, spinlock_t locks become sleeping, and
one of these is the spin lock used in signal handling.

Some of the debug code (int3) causes do_trap() to send a signal.
This function calls a spinlock_t lock that has been converted to a
sleeping lock. If this happens, the above issues with the corrupted
stack is possible.

Instead of calling the signal right away, for PREEMPT_RT and x86,
the signal information is stored on the stacks task_struct and
TIF_NOTIFY_RESUME is set. Then on exit of the trap, the signal resume
code will send the signal when preemption is enabled.

[ rostedt: Switched from #ifdef CONFIG_PREEMPT_RT to
  ARCH_RT_DELAYS_SIGNAL_SEND and added comments to the code. ]
[bigeasy: Add on 32bit as per Yang Shi, minor rewording. ]

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/signal.h | 13 +++++++++++++
 include/linux/sched.h         |  3 +++
 kernel/entry/common.c         |  9 +++++++++
 kernel/signal.c               | 28 ++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 2dfb5fea13aff..fc03f4f7ed84c 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -28,6 +28,19 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
 
+/*
+ * Because some traps use the IST stack, we must keep preemption
+ * disabled while calling do_trap(), but do_trap() may call
+ * force_sig_info() which will grab the signal spin_locks for the
+ * task, which in PREEMPT_RT are mutexes.  By defining
+ * ARCH_RT_DELAYS_SIGNAL_SEND the force_sig_info() will set
+ * TIF_NOTIFY_RESUME and set up the signal to be sent on exit of the
+ * trap.
+ */
+#if defined(CONFIG_PREEMPT_RT)
+#define ARCH_RT_DELAYS_SIGNAL_SEND
+#endif
+
 #ifndef CONFIG_COMPAT
 #define compat_sigset_t compat_sigset_t
 typedef sigset_t compat_sigset_t;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248b..0514237cee3fc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1087,6 +1087,9 @@ struct task_struct {
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
+#ifdef CONFIG_PREEMPT_RT
+	struct				kernel_siginfo forced_info;
+#endif
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e3..216dbf46e05f5 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -162,6 +162,15 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
 
+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+		if (unlikely(current->forced_info.si_signo)) {
+			struct task_struct *t = current;
+
+			force_sig_info(&t->forced_info);
+			t->forced_info.si_signo = 0;
+		}
+#endif
+
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b04631acde8f..cb2b28c17c0a5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1327,6 +1327,34 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	struct k_sigaction *action;
 	int sig = info->si_signo;
 
+	/*
+	 * On some archs, PREEMPT_RT has to delay sending a signal from a trap
+	 * since it can not enable preemption, and the signal code's spin_locks
+	 * turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME which will
+	 * send the signal on exit of the trap.
+	 */
+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+	if (in_atomic()) {
+		struct task_struct *t = current;
+
+		if (WARN_ON_ONCE(t->forced_info.si_signo))
+			return 0;
+
+		if (is_si_special(info)) {
+			WARN_ON_ONCE(info != SEND_SIG_PRIV);
+			t->forced_info.si_signo = info->si_signo;
+			t->forced_info.si_errno = 0;
+			t->forced_info.si_code = SI_KERNEL;
+			t->forced_info.si_pid = 0;
+			t->forced_info.si_uid = 0;
+		} else {
+			t->forced_info = *info;
+		}
+
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+		return 0;
+	}
+#endif
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
-- 
2.34.1

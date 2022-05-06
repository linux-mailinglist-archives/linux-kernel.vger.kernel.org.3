Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197F751DE5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444185AbiEFRbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiEFRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:31:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DD6D84E;
        Fri,  6 May 2022 10:27:32 -0700 (PDT)
Date:   Fri, 6 May 2022 19:27:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651858050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v5i5V2FbqtLlrgZwkXCg+FWE0ePwOr6sGHlddE6E/8E=;
        b=WA33pFKknKcpfArSEzqHdFEvWmXxAoQa8ZUzuNHp74Jc3QJHi/FUpXwxW6b39vCQLyofZH
        8bTqWynPD0J1uuLjAs0Dv0vduteL+CFp4amujZa0GFqoll8c7hHMWBYoJVNESVjh+9oawQ
        Mel4Ga25RVZ5Llxr0+5CTDTBoSlavDN3i0U9AMUt35w8enaRec12kvKMrOBkRCEXccPhMX
        3Ckl7Js3Fl8M8DPA01IuECOWLkIT393KkzAI0qY12C5MSNGq82WP8sWZo8/PpdNotTkAZ/
        07FQxrgpO2rrrsp1cs6LQ/C8SOljVdjCl37r9ELY9W66WWSmY44yeJrGo6rgjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651858050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v5i5V2FbqtLlrgZwkXCg+FWE0ePwOr6sGHlddE6E/8E=;
        b=XwQsSLCEuHRmonMKod0xp7luCLJGp6AtBya/db+Tzj5EIgLsnkrcRTkfms58qopskKhMmN
        67+AR5yrK81qblDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.18-rc5-rt5
Message-ID: <YnVagPnKc+SDnkP/@linutronix.de>
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

Dear RT folks!

I'm pleased to announce the v5.18-rc5-rt5 patch set. 

Changes since v5.18-rc5-rt4:

  - Replace the ptrace patch with v4 of Eric W. Biederman's rework plus
    a smaller patch on top to get it to work.

  - Drop get_cpu_light from the series:

    - Replace the crypto/cryptd patch with an alternative version.

    - Replace the nfs/sunrpc patch with an alternative version.

    - Replace the vmalloc related patch with an alternative version.

    - Replace the block-mq related patch with an alternative version.

    - Replace the scsi/fcoe patch with two patches by Davidlohr Bueso plus
      two additional patches in order to tackle two remaining issues in
      that area.

  - Drop the preempt-disable -> migrate-disable replacement in kvm on
    arm64. It seems no longer to be needed.

  - Drop the "delay sending signals in atomic context" on x86/arm64. It
    is not needed to send a SIGTRAP for a breakpoint on x86 (the
    original motivation). Lets see if something else pops up. This might
    break ARM64 in that regard and will be investigated in a follow up
    release.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.18-rc5-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/incr/patch-5.18-rc5-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.18-rc5-rt5

The RT patch against v5.18-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patch-5.18-rc5-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patches-5.18-rc5-rt5.tar.xz

Sebastian

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1aebd7d7e128e..80dbec52391c7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,7 +99,6 @@ config ARM64
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
-	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 452307e822662..2f0711e42cb8e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -929,14 +929,6 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-			if (unlikely(current->forced_info.si_signo)) {
-				struct task_struct *t = current;
-				force_sig_info(&t->forced_info);
-				t->forced_info.si_signo = 0;
-			}
-#endif
-
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e93851a0e3f41..523bc934fe2f6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -798,7 +798,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * involves poking the GIC, which must be done in a
 		 * non-preemptible context.
 		 */
-		migrate_disable();
+		preempt_disable();
 
 		/*
 		 * The VMID allocator only tracks active VMIDs per
@@ -831,7 +831,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 				kvm_timer_sync_user(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
 			local_irq_enable();
-			migrate_enable();
+			preempt_enable();
 			continue;
 		}
 
@@ -903,7 +903,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		/* Exit types that need handling before we can be preempted */
 		handle_exit_early(vcpu, ret);
 
-		migrate_enable();
+		preempt_enable();
 
 		/*
 		 * The ARMv8 architecture doesn't give the hypervisor
diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index a10a498eede1b..402874489890a 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -139,10 +139,6 @@ static inline long regs_return_value(struct pt_regs *regs)
   #define arch_ptrace_stop_needed() \
 	(!test_thread_flag(TIF_RESTORE_RSE))
 
-  extern void ptrace_attach_sync_user_rbs (struct task_struct *);
-  #define arch_ptrace_attach(child) \
-	ptrace_attach_sync_user_rbs(child)
-
   #define arch_has_single_step()  (1)
   #define arch_has_block_step()   (1)
 
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index a19acd9f5e1f6..a45f529046c39 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -617,63 +617,6 @@ void ia64_sync_krbs(void)
 	unw_init_running(do_sync_rbs, ia64_sync_kernel_rbs);
 }
 
-/*
- * After PTRACE_ATTACH, a thread's register backing store area in user
- * space is assumed to contain correct data whenever the thread is
- * stopped.  arch_ptrace_stop takes care of this on tracing stops.
- * But if the child was already stopped for job control when we attach
- * to it, then it might not ever get into ptrace_stop by the time we
- * want to examine the user memory containing the RBS.
- */
-void
-ptrace_attach_sync_user_rbs (struct task_struct *child)
-{
-	int stopped = 0;
-	struct unw_frame_info info;
-
-	/*
-	 * If the child is in TASK_STOPPED, we need to change that to
-	 * TASK_TRACED momentarily while we operate on it.  This ensures
-	 * that the child won't be woken up and return to user mode while
-	 * we are doing the sync.  (It can only be woken up for SIGKILL.)
-	 */
-
-	read_lock(&tasklist_lock);
-	if (child->sighand) {
-		spin_lock_irq(&child->sighand->siglock);
-		if (READ_ONCE(child->__state) == TASK_STOPPED &&
-		    !test_and_set_tsk_thread_flag(child, TIF_RESTORE_RSE)) {
-			set_notify_resume(child);
-
-			WRITE_ONCE(child->__state, TASK_TRACED);
-			stopped = 1;
-		}
-		spin_unlock_irq(&child->sighand->siglock);
-	}
-	read_unlock(&tasklist_lock);
-
-	if (!stopped)
-		return;
-
-	unw_init_from_blocked_task(&info, child);
-	do_sync_rbs(&info, ia64_sync_user_rbs);
-
-	/*
-	 * Now move the child back into TASK_STOPPED if it should be in a
-	 * job control stop, so that SIGCONT can be used to wake it up.
-	 */
-	read_lock(&tasklist_lock);
-	if (child->sighand) {
-		spin_lock_irq(&child->sighand->siglock);
-		if (READ_ONCE(child->__state) == TASK_TRACED &&
-		    (child->signal->flags & SIGNAL_STOP_STOPPED)) {
-			WRITE_ONCE(child->__state, TASK_STOPPED);
-		}
-		spin_unlock_irq(&child->sighand->siglock);
-	}
-	read_unlock(&tasklist_lock);
-}
-
 /*
  * Write f32-f127 back to task->thread.fph if it has been modified.
  */
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 1395cbd7e340d..c7b4b49826a2a 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -60,6 +60,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	7
 #define TIF_NOTIFY_RESUME	8
 #define TIF_SECCOMP		9	/* secure computing */
+#define TIF_SINGLESTEP		10	/* single stepping userspace */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -68,5 +69,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 
 #endif
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index c85e40c72779f..58938d75871af 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -43,7 +43,7 @@ void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
 {
 	PT_REGS_IP(regs) = eip;
 	PT_REGS_SP(regs) = esp;
-	current->ptrace &= ~PT_DTRACE;
+	clear_thread_flag(TIF_SINGLESTEP);
 #ifdef SUBARCH_EXECVE1
 	SUBARCH_EXECVE1(regs->regs);
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 80504680be084..88c5c78442813 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -335,7 +335,7 @@ int singlestepping(void * t)
 {
 	struct task_struct *task = t ? t : current;
 
-	if (!(task->ptrace & PT_DTRACE))
+	if (!test_thread_flag(TIF_SINGLESTEP))
 		return 0;
 
 	if (task->thread.singlestep_syscall)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index bfaf6ab1ac037..5154b27de580f 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -11,7 +11,7 @@
 
 void user_enable_single_step(struct task_struct *child)
 {
-	child->ptrace |= PT_DTRACE;
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
 	child->thread.singlestep_syscall = 0;
 
 #ifdef SUBARCH_SET_SINGLESTEPPING
@@ -21,7 +21,7 @@ void user_enable_single_step(struct task_struct *child)
 
 void user_disable_single_step(struct task_struct *child)
 {
-	child->ptrace &= ~PT_DTRACE;
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 	child->thread.singlestep_syscall = 0;
 
 #ifdef SUBARCH_SET_SINGLESTEPPING
@@ -120,7 +120,7 @@ static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
 }
 
 /*
- * XXX Check PT_DTRACE vs TIF_SINGLESTEP for singlestepping check and
+ * XXX Check TIF_SINGLESTEP for singlestepping check and
  * PT_PTRACED vs TIF_SYSCALL_TRACE for syscall tracing check
  */
 int syscall_trace_enter(struct pt_regs *regs)
@@ -144,7 +144,7 @@ void syscall_trace_leave(struct pt_regs *regs)
 	audit_syscall_exit(regs);
 
 	/* Fake a debug trap */
-	if (ptraced & PT_DTRACE)
+	if (test_thread_flag(TIF_SINGLESTEP))
 		send_sigtrap(&regs->regs, 0);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 88cd9b5c1b744..ae4658f576ab7 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -53,7 +53,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	unsigned long sp;
 	int err;
 
-	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
+	if (test_thread_flag(TIF_SINGLESTEP) && (current->ptrace & PT_PTRACED))
 		singlestep = 1;
 
 	/* Did we come from a system call? */
@@ -128,7 +128,7 @@ void do_signal(struct pt_regs *regs)
 	 * on the host.  The tracing thread will check this flag and
 	 * PTRACE_SYSCALL if necessary.
 	 */
-	if (current->ptrace & PT_DTRACE)
+	if (test_thread_flag(TIF_SINGLESTEP))
 		current->thread.singlestep_syscall =
 			is_syscall(PT_REGS_IP(&current->thread.regs));
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b6fa03b22376c..96df2823d9398 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -123,7 +123,6 @@ config X86
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index 0f3c307b37b3a..8e2b2552b5eea 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -180,8 +180,7 @@ void set_task_blockstep(struct task_struct *task, bool on)
 	 *
 	 * NOTE: this means that set/clear TIF_BLOCKSTEP is only safe if
 	 * task is current or it can't be running, otherwise we can race
-	 * with __switch_to_xtra(). We rely on ptrace_freeze_traced() but
-	 * PTRACE_KILL is not safe.
+	 * with __switch_to_xtra(). We rely on ptrace_freeze_traced().
 	 */
 	local_irq_disable();
 	debugctl = get_debugctlmsr();
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 323c678a691ff..b952e67cc0ccd 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -225,12 +225,12 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 
 void user_enable_single_step(struct task_struct *child)
 {
-	child->ptrace |= PT_SINGLESTEP;
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
 }
 
 void user_disable_single_step(struct task_struct *child)
 {
-	child->ptrace &= ~PT_SINGLESTEP;
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 }
 
 /*
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 6f68649e86ba5..ac50ec46c8f14 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -473,7 +473,7 @@ static void do_signal(struct pt_regs *regs)
 		/* Set up the stack frame */
 		ret = setup_frame(&ksig, sigmask_to_save(), regs);
 		signal_setup_done(ret, &ksig, 0);
-		if (current->ptrace & PT_SINGLESTEP)
+		if (test_thread_flag(TIF_SINGLESTEP))
 			task_pt_regs(current)->icountlevel = 1;
 
 		return;
@@ -499,7 +499,7 @@ static void do_signal(struct pt_regs *regs)
 	/* If there's no signal to deliver, we just restore the saved mask.  */
 	restore_saved_sigmask();
 
-	if (current->ptrace & PT_SINGLESTEP)
+	if (test_thread_flag(TIF_SINGLESTEP))
 		task_pt_regs(current)->icountlevel = 1;
 	return;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70ca0652f5167..a28406ea043a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2046,14 +2046,14 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu = get_cpu_light();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		migrate_disable();
+		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			put_cpu_light();
+			migrate_enable();
 			return;
 		}
 
-		put_cpu_light();
+		migrate_enable();
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 5f8ca8c1f59cd..668095eca0faf 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -36,10 +36,13 @@ static struct workqueue_struct *cryptd_wq;
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
-	spinlock_t qlock;
 };
 
 struct cryptd_queue {
+	/*
+	 * Protected by disabling BH to allow enqueueing from softinterrupt and
+	 * dequeuing from kworker (cryptd_queue_worker()).
+	 */
 	struct cryptd_cpu_queue __percpu *cpu_queue;
 };
 
@@ -106,7 +109,6 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
-		spin_lock_init(&cpu_queue->qlock);
 	}
 	pr_info("cryptd: max_cpu_qlen set to %d\n", max_cpu_qlen);
 	return 0;
@@ -127,30 +129,28 @@ static void cryptd_fini_queue(struct cryptd_queue *queue)
 static int cryptd_enqueue_request(struct cryptd_queue *queue,
 				  struct crypto_async_request *request)
 {
-	int cpu, err;
+	int err;
 	struct cryptd_cpu_queue *cpu_queue;
 	refcount_t *refcnt;
 
-	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
-	spin_lock_bh(&cpu_queue->qlock);
-	cpu = smp_processor_id();
-
+	local_bh_disable();
+	cpu_queue = this_cpu_ptr(queue->cpu_queue);
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
 	refcnt = crypto_tfm_ctx(request->tfm);
 
 	if (err == -ENOSPC)
-		goto out_put_cpu;
+		goto out;
 
-	queue_work_on(cpu, cryptd_wq, &cpu_queue->work);
+	queue_work_on(smp_processor_id(), cryptd_wq, &cpu_queue->work);
 
 	if (!refcount_read(refcnt))
-		goto out_put_cpu;
+		goto out;
 
 	refcount_inc(refcnt);
 
-out_put_cpu:
-	spin_unlock_bh(&cpu_queue->qlock);
+out:
+	local_bh_enable();
 
 	return err;
 }
@@ -167,10 +167,10 @@ static void cryptd_queue_worker(struct work_struct *work)
 	/*
 	 * Only handle one request at a time to avoid hogging crypto workqueue.
 	 */
-	spin_lock_bh(&cpu_queue->qlock);
+	local_bh_disable();
 	backlog = crypto_get_backlog(&cpu_queue->queue);
 	req = crypto_dequeue_request(&cpu_queue->queue);
-	spin_unlock_bh(&cpu_queue->qlock);
+	local_bh_enable();
 
 	if (!req)
 		return;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index d295867a9b465..05ddbb9bb7d8a 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -273,7 +273,6 @@ static int bnx2fc_xmit(struct fc_lport *lport, struct fc_frame *fp)
 	struct fcoe_port	*port;
 	struct fcoe_hdr		*hp;
 	struct bnx2fc_rport	*tgt;
-	struct fc_stats		*stats;
 	u8			sof, eof;
 	u32			crc;
 	unsigned int		hlen, tlen, elen;
@@ -399,10 +398,8 @@ static int bnx2fc_xmit(struct fc_lport *lport, struct fc_frame *fp)
 	}
 
 	/*update tx stats */
-	stats = per_cpu_ptr(lport->stats, get_cpu());
-	stats->TxFrames++;
-	stats->TxWords += wlen;
-	put_cpu();
+	this_cpu_inc(lport->stats->TxFrames);
+	this_cpu_add(lport->stats->TxWords, wlen);
 
 	/* send down to lld */
 	fr_dev(fp) = lport;
@@ -512,7 +509,6 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
 	u32 fr_len, fr_crc;
 	struct fc_lport *lport;
 	struct fcoe_rcv_info *fr;
-	struct fc_stats *stats;
 	struct fc_frame_header *fh;
 	struct fcoe_crc_eof crc_eof;
 	struct fc_frame *fp;
@@ -543,10 +539,8 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
 	skb_pull(skb, sizeof(struct fcoe_hdr));
 	fr_len = skb->len - sizeof(struct fcoe_crc_eof);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
-	stats->RxFrames++;
-	stats->RxWords += fr_len / FCOE_WORD_TO_BYTE;
-	put_cpu();
+	this_cpu_inc(lport->stats->RxFrames);
+	this_cpu_add(lport->stats->RxWords, fr_len / FCOE_WORD_TO_BYTE);
 
 	fp = (struct fc_frame *)skb;
 	fc_frame_init(fp);
@@ -633,9 +627,7 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
 	fr_crc = le32_to_cpu(fr_crc(fp));
 
 	if (unlikely(fr_crc != ~crc32(~0, skb->data, fr_len))) {
-		stats = per_cpu_ptr(lport->stats, get_cpu());
-		crc_err = (stats->InvalidCRCCount++);
-		put_cpu();
+		crc_err = this_cpu_inc_return(lport->stats->InvalidCRCCount);
 		if (crc_err < 5)
 			printk(KERN_WARNING PFX "dropping frame with "
 			       "CRC error\n");
@@ -964,9 +956,7 @@ static void bnx2fc_indicate_netevent(void *context, unsigned long event,
 				mutex_unlock(&lport->lp_mutex);
 				fc_host_port_type(lport->host) =
 					FC_PORTTYPE_UNKNOWN;
-				per_cpu_ptr(lport->stats,
-					    get_cpu())->LinkFailureCount++;
-				put_cpu();
+				this_cpu_inc(lport->stats->LinkFailureCount);
 				fcoe_clean_pending_queue(lport);
 				wait_for_upload = 1;
 			}
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 962454f2e2b16..b42a9accb8320 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -472,7 +472,7 @@ struct bnx2fc_cmd *bnx2fc_cmd_alloc(struct bnx2fc_rport *tgt)
 	u32 free_sqes;
 	u32 max_sqes;
 	u16 xid;
-	int index = get_cpu();
+	int index = raw_smp_processor_id();
 
 	max_sqes = BNX2FC_SCSI_MAX_SQES;
 	/*
@@ -485,7 +485,6 @@ struct bnx2fc_cmd *bnx2fc_cmd_alloc(struct bnx2fc_rport *tgt)
 	    (tgt->num_active_ios.counter  >= max_sqes) ||
 	    (free_sqes + max_sqes <= BNX2FC_SQ_WQES_MAX)) {
 		spin_unlock_bh(&cmd_mgr->free_list_lock[index]);
-		put_cpu();
 		return NULL;
 	}
 
@@ -498,7 +497,6 @@ struct bnx2fc_cmd *bnx2fc_cmd_alloc(struct bnx2fc_rport *tgt)
 	atomic_inc(&tgt->num_active_ios);
 	atomic_dec(&tgt->free_sqes);
 	spin_unlock_bh(&cmd_mgr->free_list_lock[index]);
-	put_cpu();
 
 	INIT_LIST_HEAD(&io_req->link);
 
@@ -2032,7 +2030,6 @@ int bnx2fc_post_io_req(struct bnx2fc_rport *tgt,
 	struct bnx2fc_interface *interface = port->priv;
 	struct bnx2fc_hba *hba = interface->hba;
 	struct fc_lport *lport = port->lport;
-	struct fc_stats *stats;
 	int task_idx, index;
 	u16 xid;
 
@@ -2045,20 +2042,18 @@ int bnx2fc_post_io_req(struct bnx2fc_rport *tgt,
 	io_req->data_xfer_len = scsi_bufflen(sc_cmd);
 	bnx2fc_priv(sc_cmd)->io_req = io_req;
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
 	if (sc_cmd->sc_data_direction == DMA_FROM_DEVICE) {
 		io_req->io_req_flags = BNX2FC_READ;
-		stats->InputRequests++;
-		stats->InputBytes += io_req->data_xfer_len;
+		this_cpu_inc(lport->stats->InputRequests);
+		this_cpu_add(lport->stats->InputBytes, io_req->data_xfer_len);
 	} else if (sc_cmd->sc_data_direction == DMA_TO_DEVICE) {
 		io_req->io_req_flags = BNX2FC_WRITE;
-		stats->OutputRequests++;
-		stats->OutputBytes += io_req->data_xfer_len;
+		this_cpu_inc(lport->stats->OutputRequests);
+		this_cpu_add(lport->stats->OutputBytes, io_req->data_xfer_len);
 	} else {
 		io_req->io_req_flags = 0;
-		stats->ControlRequests++;
+		this_cpu_inc(lport->stats->ControlRequests);
 	}
-	put_cpu();
 
 	xid = io_req->xid;
 
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 6447a7d49207e..8ef8a20fb01ed 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1434,8 +1434,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 
 	return NET_RX_SUCCESS;
 err:
-	per_cpu_ptr(lport->stats, get_cpu())->ErrorFrames++;
-	put_cpu();
+	this_cpu_inc(lport->stats->ErrorFrames);
 err2:
 	kfree_skb(skb);
 	return NET_RX_DROP;
@@ -1451,11 +1450,12 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 static int fcoe_alloc_paged_crc_eof(struct sk_buff *skb, int tlen)
 {
 	struct fcoe_percpu_s *fps;
-	int rc, cpu = get_cpu_light();
+	int rc;
 
-	fps = &per_cpu(fcoe_percpu, cpu);
+	local_lock(&fcoe_percpu.lock);
+	fps = this_cpu_ptr(&fcoe_percpu);
 	rc = fcoe_get_paged_crc_eof(skb, tlen, fps);
-	put_cpu_light();
+	local_unlock(&fcoe_percpu.lock);
 
 	return rc;
 }
@@ -1474,7 +1474,6 @@ static int fcoe_xmit(struct fc_lport *lport, struct fc_frame *fp)
 	struct ethhdr *eh;
 	struct fcoe_crc_eof *cp;
 	struct sk_buff *skb;
-	struct fc_stats *stats;
 	struct fc_frame_header *fh;
 	unsigned int hlen;		/* header length implies the version */
 	unsigned int tlen;		/* trailer length */
@@ -1585,10 +1584,8 @@ static int fcoe_xmit(struct fc_lport *lport, struct fc_frame *fp)
 		skb_shinfo(skb)->gso_size = 0;
 	}
 	/* update tx stats: regardless if LLD fails */
-	stats = per_cpu_ptr(lport->stats, get_cpu());
-	stats->TxFrames++;
-	stats->TxWords += wlen;
-	put_cpu();
+	this_cpu_inc(lport->stats->TxFrames);
+	this_cpu_add(lport->stats->TxWords, wlen);
 
 	/* send down to lld */
 	fr_dev(fp) = lport;
@@ -1610,7 +1607,6 @@ static inline int fcoe_filter_frames(struct fc_lport *lport,
 	struct fcoe_interface *fcoe;
 	struct fc_frame_header *fh;
 	struct sk_buff *skb = (struct sk_buff *)fp;
-	struct fc_stats *stats;
 
 	/*
 	 * We only check CRC if no offload is available and if it is
@@ -1640,11 +1636,8 @@ static inline int fcoe_filter_frames(struct fc_lport *lport,
 		return 0;
 	}
 
-	stats = per_cpu_ptr(lport->stats, get_cpu_light());
-	stats->InvalidCRCCount++;
-	if (stats->InvalidCRCCount < 5)
+	if (this_cpu_inc_return(lport->stats->InvalidCRCCount) < 5)
 		printk(KERN_WARNING "fcoe: dropping frame with CRC error\n");
-	put_cpu_light();
 	return -EINVAL;
 }
 
@@ -1657,7 +1650,6 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	u32 fr_len;
 	struct fc_lport *lport;
 	struct fcoe_rcv_info *fr;
-	struct fc_stats *stats;
 	struct fcoe_crc_eof crc_eof;
 	struct fc_frame *fp;
 	struct fcoe_hdr *hp;
@@ -1685,9 +1677,11 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	 */
 	hp = (struct fcoe_hdr *) skb_network_header(skb);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu_light());
 	if (unlikely(FC_FCOE_DECAPS_VER(hp) != FC_FCOE_VER)) {
-		if (stats->ErrorFrames < 5)
+		struct fc_stats *stats;
+
+		stats = per_cpu_ptr(lport->stats, raw_smp_processor_id());
+		if (READ_ONCE(stats->ErrorFrames) < 5)
 			printk(KERN_WARNING "fcoe: FCoE version "
 			       "mismatch: The frame has "
 			       "version %x, but the "
@@ -1700,8 +1694,8 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	skb_pull(skb, sizeof(struct fcoe_hdr));
 	fr_len = skb->len - sizeof(struct fcoe_crc_eof);
 
-	stats->RxFrames++;
-	stats->RxWords += fr_len / FCOE_WORD_TO_BYTE;
+	this_cpu_inc(lport->stats->RxFrames);
+	this_cpu_add(lport->stats->RxWords, fr_len / FCOE_WORD_TO_BYTE);
 
 	fp = (struct fc_frame *)skb;
 	fc_frame_init(fp);
@@ -1717,13 +1711,11 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 		goto drop;
 
 	if (!fcoe_filter_frames(lport, fp)) {
-		put_cpu_light();
 		fc_exch_recv(lport, fp);
 		return;
 	}
 drop:
-	stats->ErrorFrames++;
-	put_cpu_light();
+	this_cpu_inc(lport->stats->ErrorFrames);
 	kfree_skb(skb);
 }
 
@@ -1847,7 +1839,6 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct fcoe_ctlr *ctlr;
 	struct fcoe_interface *fcoe;
-	struct fc_stats *stats;
 	u32 link_possible = 1;
 	u32 mfs;
 	int rc = NOTIFY_OK;
@@ -1921,9 +1912,7 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 			break;
 		case FCOE_CTLR_ENABLED:
 		case FCOE_CTLR_UNUSED:
-			stats = per_cpu_ptr(lport->stats, get_cpu());
-			stats->LinkFailureCount++;
-			put_cpu();
+			this_cpu_inc(lport->stats->LinkFailureCount);
 			fcoe_clean_pending_queue(lport);
 		}
 	}
@@ -2488,6 +2477,7 @@ static int __init fcoe_init(void)
 		p = per_cpu_ptr(&fcoe_percpu, cpu);
 		INIT_WORK(&p->work, fcoe_receive_work);
 		skb_queue_head_init(&p->fcoe_rx_list);
+		local_lock_init(&p->lock);
 	}
 
 	/* Setup link change notification */
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 3a2cbf35ea3d6..8bf70659950db 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -824,22 +824,21 @@ static unsigned long fcoe_ctlr_age_fcfs(struct fcoe_ctlr *fip)
 	unsigned long deadline;
 	unsigned long sel_time = 0;
 	struct list_head del_list;
-	struct fc_stats *stats;
 
 	INIT_LIST_HEAD(&del_list);
 
-	stats = per_cpu_ptr(fip->lp->stats, get_cpu_light());
-
 	list_for_each_entry_safe(fcf, next, &fip->fcfs, list) {
 		deadline = fcf->time + fcf->fka_period + fcf->fka_period / 2;
 		if (fip->sel_fcf == fcf) {
 			if (time_after(jiffies, deadline)) {
-				stats->MissDiscAdvCount++;
+				u64 miss_cnt;
+
+				miss_cnt = this_cpu_inc_return(fip->lp->stats->MissDiscAdvCount);
 				printk(KERN_INFO "libfcoe: host%d: "
 				       "Missing Discovery Advertisement "
 				       "for fab %16.16llx count %lld\n",
 				       fip->lp->host->host_no, fcf->fabric_name,
-				       stats->MissDiscAdvCount);
+				       miss_cnt);
 			} else if (time_after(next_timer, deadline))
 				next_timer = deadline;
 		}
@@ -855,7 +854,7 @@ static unsigned long fcoe_ctlr_age_fcfs(struct fcoe_ctlr *fip)
 			 */
 			list_del(&fcf->list);
 			list_add(&fcf->list, &del_list);
-			stats->VLinkFailureCount++;
+			this_cpu_inc(fip->lp->stats->VLinkFailureCount);
 		} else {
 			if (time_after(next_timer, deadline))
 				next_timer = deadline;
@@ -864,7 +863,6 @@ static unsigned long fcoe_ctlr_age_fcfs(struct fcoe_ctlr *fip)
 				sel_time = fcf->time;
 		}
 	}
-	put_cpu_light();
 
 	list_for_each_entry_safe(fcf, next, &del_list, list) {
 		/* Removes fcf from current list */
@@ -1142,7 +1140,6 @@ static void fcoe_ctlr_recv_els(struct fcoe_ctlr *fip, struct sk_buff *skb)
 	struct fip_desc *desc;
 	struct fip_encaps *els;
 	struct fcoe_fcf *sel;
-	struct fc_stats *stats;
 	enum fip_desc_type els_dtype = 0;
 	u8 els_op;
 	u8 sub;
@@ -1286,10 +1283,8 @@ static void fcoe_ctlr_recv_els(struct fcoe_ctlr *fip, struct sk_buff *skb)
 	fr_dev(fp) = lport;
 	fr_encaps(fp) = els_dtype;
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
-	stats->RxFrames++;
-	stats->RxWords += skb->len / FIP_BPW;
-	put_cpu();
+	this_cpu_inc(lport->stats->RxFrames);
+	this_cpu_add(lport->stats->RxWords, skb->len / FIP_BPW);
 
 	fc_exch_recv(lport, fp);
 	return;
@@ -1427,9 +1422,7 @@ static void fcoe_ctlr_recv_clr_vlink(struct fcoe_ctlr *fip,
 						      ntoh24(vp->fd_fc_id));
 			if (vn_port && (vn_port == lport)) {
 				mutex_lock(&fip->ctlr_mutex);
-				per_cpu_ptr(lport->stats,
-					    get_cpu())->VLinkFailureCount++;
-				put_cpu();
+				this_cpu_inc(lport->stats->VLinkFailureCount);
 				fcoe_ctlr_reset(fip);
 				mutex_unlock(&fip->ctlr_mutex);
 			}
@@ -1457,8 +1450,7 @@ static void fcoe_ctlr_recv_clr_vlink(struct fcoe_ctlr *fip,
 		 * followed by physical port
 		 */
 		mutex_lock(&fip->ctlr_mutex);
-		per_cpu_ptr(lport->stats, get_cpu())->VLinkFailureCount++;
-		put_cpu();
+		this_cpu_inc(lport->stats->VLinkFailureCount);
 		fcoe_ctlr_reset(fip);
 		mutex_unlock(&fip->ctlr_mutex);
 
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index 4d0e19e7c84b9..62341c6353a72 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -183,9 +183,9 @@ void __fcoe_get_lesb(struct fc_lport *lport,
 	memset(lesb, 0, sizeof(*lesb));
 	for_each_possible_cpu(cpu) {
 		stats = per_cpu_ptr(lport->stats, cpu);
-		lfc += stats->LinkFailureCount;
-		vlfc += stats->VLinkFailureCount;
-		mdac += stats->MissDiscAdvCount;
+		lfc += READ_ONCE(stats->LinkFailureCount);
+		vlfc += READ_ONCE(stats->VLinkFailureCount);
+		mdac += READ_ONCE(stats->MissDiscAdvCount);
 	}
 	lesb->lesb_link_fail = htonl(lfc);
 	lesb->lesb_vlink_fail = htonl(vlfc);
diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index 0ceb93800704b..1d91c457527f3 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -825,10 +825,9 @@ static struct fc_exch *fc_exch_em_alloc(struct fc_lport *lport,
 	}
 	memset(ep, 0, sizeof(*ep));
 
-	cpu = get_cpu_light();
+	cpu = raw_smp_processor_id();
 	pool = per_cpu_ptr(mp->pool, cpu);
 	spin_lock_bh(&pool->lock);
-	put_cpu_light();
 
 	/* peek cache of free slot */
 	if (pool->left != FC_XID_UNKNOWN) {
diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index bce90eb56c9ce..945adca5e72fd 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -143,8 +143,7 @@ static struct fc_fcp_pkt *fc_fcp_pkt_alloc(struct fc_lport *lport, gfp_t gfp)
 		INIT_LIST_HEAD(&fsp->list);
 		spin_lock_init(&fsp->scsi_pkt_lock);
 	} else {
-		per_cpu_ptr(lport->stats, get_cpu())->FcpPktAllocFails++;
-		put_cpu();
+		this_cpu_inc(lport->stats->FcpPktAllocFails);
 	}
 	return fsp;
 }
@@ -266,8 +265,7 @@ static int fc_fcp_send_abort(struct fc_fcp_pkt *fsp)
 	if (!fsp->seq_ptr)
 		return -EINVAL;
 
-	per_cpu_ptr(fsp->lp->stats, get_cpu())->FcpPktAborts++;
-	put_cpu();
+	this_cpu_inc(fsp->lp->stats->FcpPktAborts);
 
 	fsp->state |= FC_SRB_ABORT_PENDING;
 	rc = fc_seq_exch_abort(fsp->seq_ptr, 0);
@@ -436,8 +434,7 @@ static inline struct fc_frame *fc_fcp_frame_alloc(struct fc_lport *lport,
 	if (likely(fp))
 		return fp;
 
-	per_cpu_ptr(lport->stats, get_cpu())->FcpFrameAllocFails++;
-	put_cpu();
+	this_cpu_inc(lport->stats->FcpFrameAllocFails);
 	/* error case */
 	fc_fcp_can_queue_ramp_down(lport);
 	shost_printk(KERN_ERR, lport->host,
@@ -471,7 +468,6 @@ static void fc_fcp_recv_data(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 {
 	struct scsi_cmnd *sc = fsp->cmd;
 	struct fc_lport *lport = fsp->lp;
-	struct fc_stats *stats;
 	struct fc_frame_header *fh;
 	size_t start_offset;
 	size_t offset;
@@ -533,14 +529,12 @@ static void fc_fcp_recv_data(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 
 		if (~crc != le32_to_cpu(fr_crc(fp))) {
 crc_err:
-			stats = per_cpu_ptr(lport->stats, get_cpu());
-			stats->ErrorFrames++;
+			this_cpu_inc(lport->stats->ErrorFrames);
 			/* per cpu count, not total count, but OK for limit */
-			if (stats->InvalidCRCCount++ < FC_MAX_ERROR_CNT)
+			if (this_cpu_inc_return(lport->stats->InvalidCRCCount) < FC_MAX_ERROR_CNT)
 				printk(KERN_WARNING "libfc: CRC error on data "
 				       "frame for port (%6.6x)\n",
 				       lport->port_id);
-			put_cpu();
 			/*
 			 * Assume the frame is total garbage.
 			 * We may have copied it over the good part
@@ -1861,7 +1855,6 @@ int fc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc_cmd)
 	struct fc_fcp_pkt *fsp;
 	int rval;
 	int rc = 0;
-	struct fc_stats *stats;
 
 	rval = fc_remote_port_chkready(rport);
 	if (rval) {
@@ -1913,20 +1906,18 @@ int fc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc_cmd)
 	/*
 	 * setup the data direction
 	 */
-	stats = per_cpu_ptr(lport->stats, get_cpu());
 	if (sc_cmd->sc_data_direction == DMA_FROM_DEVICE) {
 		fsp->req_flags = FC_SRB_READ;
-		stats->InputRequests++;
-		stats->InputBytes += fsp->data_len;
+		this_cpu_inc(lport->stats->InputRequests);
+		this_cpu_add(lport->stats->InputBytes, fsp->data_len);
 	} else if (sc_cmd->sc_data_direction == DMA_TO_DEVICE) {
 		fsp->req_flags = FC_SRB_WRITE;
-		stats->OutputRequests++;
-		stats->OutputBytes += fsp->data_len;
+		this_cpu_inc(lport->stats->OutputRequests);
+		this_cpu_add(lport->stats->OutputBytes, fsp->data_len);
 	} else {
 		fsp->req_flags = 0;
-		stats->ControlRequests++;
+		this_cpu_inc(lport->stats->ControlRequests);
 	}
-	put_cpu();
 
 	/*
 	 * send it to the lower layer
diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 19cd4a95d354d..9c02c9523c4d4 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -308,21 +308,21 @@ struct fc_host_statistics *fc_get_host_stats(struct Scsi_Host *shost)
 
 		stats = per_cpu_ptr(lport->stats, cpu);
 
-		fc_stats->tx_frames += stats->TxFrames;
-		fc_stats->tx_words += stats->TxWords;
-		fc_stats->rx_frames += stats->RxFrames;
-		fc_stats->rx_words += stats->RxWords;
-		fc_stats->error_frames += stats->ErrorFrames;
-		fc_stats->invalid_crc_count += stats->InvalidCRCCount;
-		fc_stats->fcp_input_requests += stats->InputRequests;
-		fc_stats->fcp_output_requests += stats->OutputRequests;
-		fc_stats->fcp_control_requests += stats->ControlRequests;
-		fcp_in_bytes += stats->InputBytes;
-		fcp_out_bytes += stats->OutputBytes;
-		fc_stats->fcp_packet_alloc_failures += stats->FcpPktAllocFails;
-		fc_stats->fcp_packet_aborts += stats->FcpPktAborts;
-		fc_stats->fcp_frame_alloc_failures += stats->FcpFrameAllocFails;
-		fc_stats->link_failure_count += stats->LinkFailureCount;
+		fc_stats->tx_frames += READ_ONCE(stats->TxFrames);
+		fc_stats->tx_words += READ_ONCE(stats->TxWords);
+		fc_stats->rx_frames += READ_ONCE(stats->RxFrames);
+		fc_stats->rx_words += READ_ONCE(stats->RxWords);
+		fc_stats->error_frames += READ_ONCE(stats->ErrorFrames);
+		fc_stats->invalid_crc_count += READ_ONCE(stats->InvalidCRCCount);
+		fc_stats->fcp_input_requests += READ_ONCE(stats->InputRequests);
+		fc_stats->fcp_output_requests += READ_ONCE(stats->OutputRequests);
+		fc_stats->fcp_control_requests += READ_ONCE(stats->ControlRequests);
+		fcp_in_bytes += READ_ONCE(stats->InputBytes);
+		fcp_out_bytes += READ_ONCE(stats->OutputBytes);
+		fc_stats->fcp_packet_alloc_failures += READ_ONCE(stats->FcpPktAllocFails);
+		fc_stats->fcp_packet_aborts += READ_ONCE(stats->FcpPktAborts);
+		fc_stats->fcp_frame_alloc_failures += READ_ONCE(stats->FcpFrameAllocFails);
+		fc_stats->link_failure_count += READ_ONCE(stats->LinkFailureCount);
 	}
 	fc_stats->fcp_input_megabytes = div_u64(fcp_in_bytes, 1000000);
 	fc_stats->fcp_output_megabytes = div_u64(fcp_out_bytes, 1000000);
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 18dc68d577b6e..ceb703451ee42 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1067,7 +1067,6 @@ static int qedf_xmit(struct fc_lport *lport, struct fc_frame *fp)
 	u32			crc;
 	unsigned int		hlen, tlen, elen;
 	int			wlen;
-	struct fc_stats		*stats;
 	struct fc_lport *tmp_lport;
 	struct fc_lport *vn_port = NULL;
 	struct qedf_rport *fcport;
@@ -1215,10 +1214,8 @@ static int qedf_xmit(struct fc_lport *lport, struct fc_frame *fp)
 	hp->fcoe_sof = sof;
 
 	/*update tx stats */
-	stats = per_cpu_ptr(lport->stats, get_cpu());
-	stats->TxFrames++;
-	stats->TxWords += wlen;
-	put_cpu();
+	this_cpu_inc(lport->stats->TxFrames);
+	this_cpu_add(lport->stats->TxWords, wlen);
 
 	/* Get VLAN ID from skb for printing purposes */
 	__vlan_hwaccel_get_tag(skb, &vlan_tci);
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 80b86a7992b50..0d04287da0984 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -215,8 +215,8 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 				spin_unlock_irq(&p->sighand->siglock);
 				continue;
 			}
-			__group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			send_signal_locked(SIGHUP, SEND_SIG_PRIV, p, PIDTYPE_TGID);
+			send_signal_locked(SIGCONT, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 			put_pid(p->signal->tty_old_pgrp);  /* A noop */
 			spin_lock(&tty->ctrl.lock);
 			tty_pgrp = get_pid(tty->ctrl.pgrp);
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 15b3d176b6b4d..c952c5ba8fab6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -30,7 +30,6 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 
 #define PT_SEIZED	0x00010000	/* SEIZE used, enable new behavior */
 #define PT_PTRACED	0x00000001
-#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
 
 #define PT_OPT_FLAG_SHIFT	3
 /* PT_TRACE_* event enable flags */
@@ -47,12 +46,6 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
 
-/* single stepping state bits (used on ARM and PA-RISC) */
-#define PT_SINGLESTEP_BIT	31
-#define PT_SINGLESTEP		(1<<PT_SINGLESTEP_BIT)
-#define PT_BLOCKSTEP_BIT	30
-#define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)
-
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index de02cbd54b707..a5a784b99a07d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -103,7 +103,7 @@ struct task_group;
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
 #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
-#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
+#define TASK_TRACED			__TASK_TRACED
 
 #define TASK_IDLE			(TASK_UNINTERRUPTIBLE | TASK_NOLOAD)
 
@@ -118,7 +118,9 @@ struct task_group;
 
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
-#define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
+#define task_is_traced(task)		((READ_ONCE(task->jobctl) & JOBCTL_TRACED) != 0)
+#define task_is_stopped(task)		((READ_ONCE(task->jobctl) & JOBCTL_STOPPED) != 0)
+#define task_is_stopped_or_traced(task)	((READ_ONCE(task->jobctl) & (JOBCTL_STOPPED | JOBCTL_TRACED)) != 0)
 
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
@@ -1086,9 +1088,6 @@ struct task_struct {
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-	struct kernel_siginfo		forced_info;
-#endif
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
@@ -2061,130 +2060,6 @@ static inline int need_resched_now(void)
 
 #endif
 
-#ifdef CONFIG_PREEMPT_RT
-
-static inline bool task_state_match_and(struct task_struct *tsk, long state)
-{
-	unsigned long flags;
-	bool match = false;
-
-	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
-	if (READ_ONCE(tsk->__state) & state)
-		match = true;
-	else if (tsk->saved_state & state)
-		match = true;
-	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
-	return match;
-}
-
-static inline int __task_state_match_eq(struct task_struct *tsk, long state)
-{
-	int match = 0;
-
-	if (READ_ONCE(tsk->__state) == state)
-		match = 1;
-	else if (tsk->saved_state == state)
-		match = -1;
-
-	return match;
-}
-
-static inline int task_state_match_eq(struct task_struct *tsk, long state)
-{
-	unsigned long flags;
-	int match;
-
-	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
-	match = __task_state_match_eq(tsk, state);
-	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
-	return match;
-}
-
-static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
-					    long new_state)
-{
-	unsigned long flags;
-	bool match = false;
-
-	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
-	if (READ_ONCE(tsk->__state) & state) {
-		WRITE_ONCE(tsk->__state, new_state);
-		match = true;
-	} else if (tsk->saved_state & state) {
-		tsk->saved_state = new_state;
-		match = true;
-	}
-	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
-	return match;
-}
-
-static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
-					   long new_state)
-{
-	unsigned long flags;
-	bool match = false;
-
-	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
-	if (READ_ONCE(tsk->__state) == state) {
-		WRITE_ONCE(tsk->__state, new_state);
-		match = true;
-	} else if (tsk->saved_state == state) {
-		tsk->saved_state = new_state;
-		match = true;
-	}
-	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
-	return match;
-}
-
-#else
-
-static inline bool task_state_match_and(struct task_struct *tsk, long state)
-{
-	return READ_ONCE(tsk->__state) & state;
-}
-
-static inline int __task_state_match_eq(struct task_struct *tsk, long state)
-{
-	return READ_ONCE(tsk->__state) == state;
-}
-
-static inline int task_state_match_eq(struct task_struct *tsk, long state)
-{
-	return __task_state_match_eq(tsk, state);
-}
-
-static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
-					    long new_state)
-{
-	if (READ_ONCE(tsk->__state) & state) {
-		WRITE_ONCE(tsk->__state, new_state);
-		return true;
-	}
-	return false;
-}
-
-static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
-					   long new_state)
-{
-	if (READ_ONCE(tsk->__state) == state) {
-		WRITE_ONCE(tsk->__state, new_state);
-		return true;
-	}
-	return false;
-}
-
-#endif
-
-static inline bool task_is_traced(struct task_struct *tsk)
-{
-	return task_state_match_and(tsk, __TASK_TRACED);
-}
-
-static inline bool task_is_stopped_or_traced(struct task_struct *tsk)
-{
-	return task_state_match_and(tsk, __TASK_STOPPED | __TASK_TRACED);
-}
-
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a94..68876d0a7ef9a 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,10 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_PTRACE_FROZEN_BIT	24	/* frozen for ptrace */
+
+#define JOBCTL_STOPPED_BIT	26	/* do_signal_stop() */
+#define JOBCTL_TRACED_BIT	27	/* ptrace_stop() */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +32,10 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_PTRACE_FROZEN	(1UL << JOBCTL_PTRACE_FROZEN_BIT)
+
+#define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
+#define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3c8b34876744b..07ba3404fcde4 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -294,8 +294,10 @@ static inline int kernel_dequeue_signal(void)
 static inline void kernel_signal_stop(void)
 {
 	spin_lock_irq(&current->sighand->siglock);
-	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
+	if (current->jobctl & JOBCTL_STOP_DEQUEUED) {
+		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
+	}
 	spin_unlock_irq(&current->sighand->siglock);
 
 	schedule();
@@ -435,13 +437,23 @@ extern void calculate_sigpending(void);
 
 extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
-static inline void signal_wake_up(struct task_struct *t, bool resume)
+static inline void signal_wake_up(struct task_struct *t, bool fatal)
 {
-	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
+	unsigned int state = 0;
+	if (fatal && !(t->jobctl & JOBCTL_PTRACE_FROZEN)) {
+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
+		state = TASK_WAKEKILL | __TASK_TRACED;
+	}
+	signal_wake_up_state(t, state);
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
-	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
+	unsigned int state = 0;
+	if (resume) {
+		t->jobctl &= ~JOBCTL_TRACED;
+		state = __TASK_TRACED;
+	}
+	signal_wake_up_state(t, state);
 }
 
 void task_join_group_stop(struct task_struct *task);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index a6db6f2ae1130..3b98e7a28538b 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -282,7 +282,8 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
 				struct task_struct *p, enum pid_type type);
 extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			       struct task_struct *p, enum pid_type type);
-extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
+extern int send_signal_locked(int sig, struct kernel_siginfo *info,
+			      struct task_struct *p, enum pid_type type);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
diff --git a/include/linux/smp.h b/include/linux/smp.h
index dd3441d8af448..a80ab58ae3f1d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -267,9 +267,6 @@ static inline int get_boot_cpu_id(void)
 #define get_cpu()		({ preempt_disable(); __smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 
-#define get_cpu_light()		({ migrate_disable(); __smp_processor_id(); })
-#define put_cpu_light()		migrate_enable()
-
 /*
  * Callback to arch code if there's nosmp or maxcpus=0 on the
  * boot command line:
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index fac8e89aed81d..6e79fb87fea25 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -14,6 +14,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
+#include <linux/local_lock.h>
 #include <linux/random.h>
 #include <scsi/fc/fc_fcoe.h>
 #include <scsi/libfc.h>
@@ -326,6 +327,7 @@ struct fcoe_percpu_s {
 	struct sk_buff_head fcoe_rx_list;
 	struct page *crc_eof_page;
 	int crc_eof_offset;
+	local_lock_t lock;
 };
 
 /**
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index f7fd553bf980e..260c08efeb486 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -139,14 +139,4 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
-config ARCH_WANTS_RT_DELAYED_SIGNALS
-	bool
-	help
-	  This option is selected by architectures where raising signals
-	  can happen in atomic contexts on PREEMPT_RT enabled kernels. This
-	  option delays raising the signal until the return to user space
-	  loop where it is also delivered. X86 requires this to deliver
-	  signals from trap handlers which run on IST stacks.
 
-config RT_DELAYED_SIGNALS
-	def_bool PREEMPT_RT && ARCH_WANTS_RT_DELAYED_SIGNALS
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 1375f4619df9c..f97a12ee515c8 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -139,18 +139,6 @@ void noinstr exit_to_user_mode(void)
 	__exit_to_user_mode();
 }
 
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-static inline void raise_delayed_signal(void)
-{
-	if (unlikely(current->forced_info.si_signo)) {
-		force_sig_info(&current->forced_info);
-		current->forced_info.si_signo = 0;
-	}
-}
-#else
-static inline void raise_delayed_signal(void) { }
-#endif
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
@@ -168,8 +156,6 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_NEED_RESCHED_MASK)
 			schedule();
 
-		raise_delayed_signal();
-
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2f9a1fd0fcafb..328a34a991248 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -185,7 +185,12 @@ static bool looks_like_a_spurious_pid(struct task_struct *task)
 	return true;
 }
 
-/* Ensure that nothing can wake it up, even SIGKILL */
+/*
+ * Ensure that nothing can wake it up, even SIGKILL
+ *
+ * A task is switched to this state while a ptrace operation is in progress;
+ * such that the ptrace operation is uninterruptible.
+ */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
 	bool ret = false;
@@ -195,10 +200,10 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 		return ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	if (!looks_like_a_spurious_pid(task) && !__fatal_signal_pending(task)) {
-
-		ret = task_state_match_and_set(task, __TASK_TRACED,
-					       __TASK_TRACED);
+	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
+	    !__fatal_signal_pending(task)) {
+		task->jobctl |= JOBCTL_PTRACE_FROZEN;
+		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 
@@ -207,26 +212,21 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	bool frozen;
-
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    READ_ONCE(task->__state) != __TASK_TRACED)
-		return;
-
-	WARN_ON(!task->ptrace || task->parent != current);
+	unsigned long flags;
 
 	/*
-	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
-	 * Recheck state under the lock to close this race.
+	 * The child may be awake and may have cleared
+	 * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
+	 * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
 	 */
-	spin_lock_irq(&task->sighand->siglock);
-
-	frozen = task_state_match_eq_set(task, __TASK_TRACED, TASK_TRACED);
-
-	if (frozen && __fatal_signal_pending(task))
-		wake_up_state(task, __TASK_TRACED);
-
-	spin_unlock_irq(&task->sighand->siglock);
+	if (lock_task_sighand(task, &flags)) {
+		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
+		if (__fatal_signal_pending(task)) {
+			task->jobctl &= ~TASK_TRACED;
+			wake_up_state(task, __TASK_TRACED);
+		}
+		unlock_task_sighand(task, &flags);
+	}
 }
 
 /**
@@ -259,7 +259,6 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
@@ -269,17 +268,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
-			/*
-			 * This can only happen if may_ptrace_stop() fails and
-			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
-			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-			ret = -ESRCH;
-		}
-	}
+	if (!ret && !ignore_state &&
+	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+		ret = -ESRCH;
 
 	return ret;
 }
@@ -478,8 +469,10 @@ static int ptrace_attach(struct task_struct *task, long request,
 	 * in and out of STOPPED are protected by siglock.
 	 */
 	if (task_is_stopped(task) &&
-	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
+	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
+		task->jobctl &= ~JOBCTL_STOPPED;
 		signal_wake_up_state(task, __TASK_STOPPED);
+	}
 
 	spin_unlock(&task->sighand->siglock);
 
@@ -853,8 +846,6 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 static int ptrace_resume(struct task_struct *child, long request,
 			 unsigned long data)
 {
-	bool need_siglock;
-
 	if (!valid_signal(data))
 		return -EIO;
 
@@ -890,18 +881,12 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 * Note that we need siglock even if ->exit_code == data and/or this
 	 * status was not reported yet, the new status must not be cleared by
 	 * wait_task_stopped() after resume.
-	 *
-	 * If data == 0 we do not care if wait_task_stopped() reports the old
-	 * status and clears the code too; this can't race with the tracee, it
-	 * takes siglock after resume.
 	 */
-	need_siglock = data && !thread_group_empty(current);
-	if (need_siglock)
-		spin_lock_irq(&child->sighand->siglock);
+	spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
+	child->jobctl &= ~JOBCTL_TRACED;
 	wake_up_state(child, __TASK_TRACED);
-	if (need_siglock)
-		spin_unlock_irq(&child->sighand->siglock);
+	spin_unlock_irq(&child->sighand->siglock);
 
 	return 0;
 }
@@ -1239,9 +1224,8 @@ int ptrace_request(struct task_struct *child, long request,
 		return ptrace_resume(child, request, data);
 
 	case PTRACE_KILL:
-		if (child->exit_state)	/* already dead */
-			return 0;
-		return ptrace_resume(child, request, SIGKILL);
+		send_sig_info(SIGKILL, SEND_SIG_NOINFO, child);
+		return 0;
 
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
@@ -1288,10 +1272,6 @@ int ptrace_request(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifndef arch_ptrace_attach
-#define arch_ptrace_attach(child)	do { } while (0)
-#endif
-
 SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		unsigned long, data)
 {
@@ -1300,8 +1280,6 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 
 	if (request == PTRACE_TRACEME) {
 		ret = ptrace_traceme();
-		if (!ret)
-			arch_ptrace_attach(current);
 		goto out;
 	}
 
@@ -1313,12 +1291,6 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 
 	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
 		ret = ptrace_attach(child, request, addr, data);
-		/*
-		 * Some architectures need to do book-keeping after
-		 * a ptrace attach.
-		 */
-		if (!ret)
-			arch_ptrace_attach(child);
 		goto out_put_task_struct;
 	}
 
@@ -1458,12 +1430,6 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 
 	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
 		ret = ptrace_attach(child, request, addr, data);
-		/*
-		 * Some architectures need to do book-keeping after
-		 * a ptrace attach.
-		 */
-		if (!ret)
-			arch_ptrace_attach(child);
 		goto out_put_task_struct;
 	}
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 414641e341ee3..a32e7b083b206 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3327,10 +3327,10 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
+	bool saved_state_match;
+	bool update_ncsw;
 
 	for (;;) {
-		int match_type = 0;
-
 		/*
 		 * We do the initial early heuristics without holding
 		 * any task-queue locks at all. We'll only try to get
@@ -3351,9 +3351,22 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state &&
-			    unlikely(!task_state_match_eq(p, match_state)))
-				return 0;
+			if (match_state) {
+				unsigned long flags;
+				bool missmatch = false;
+
+				raw_spin_lock_irqsave(&p->pi_lock, flags);
+#ifdef CONFIG_PREEMPT_RT
+				if ((READ_ONCE(p->__state) != match_state) &&
+				    (READ_ONCE(p->saved_state) != match_state))
+#else
+				if (READ_ONCE(p->__state) != match_state)
+#endif
+					missmatch = true;
+				raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+				if (missmatch)
+					return 0;
+			}
 			cpu_relax();
 		}
 
@@ -3367,9 +3380,21 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (match_state)
-			match_type = __task_state_match_eq(p, match_state);
-		if (!match_state || match_type)
+		update_ncsw = false;
+		saved_state_match = false;
+
+		if (!match_state) {
+			update_ncsw = true;
+		} else if (READ_ONCE(p->__state) == match_state) {
+			update_ncsw = true;
+#ifdef CONFIG_PREEMPT_RT
+		} else if (READ_ONCE(p->saved_state) == match_state) {
+			update_ncsw = true;
+			saved_state_match = true;
+#endif
+		}
+
+		if (update_ncsw)
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
@@ -3399,7 +3424,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued || match_type < 0)) {
+		if (unlikely(queued) || saved_state_match) {
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
@@ -6363,10 +6388,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	/*
 	 * We must load prev->state once (task_struct::state is volatile), such
-	 * that:
-	 *
-	 *  - we form a control dependency vs deactivate_task() below.
-	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
+	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
diff --git a/kernel/signal.c b/kernel/signal.c
index c4a0d40b6b41c..74dfee656367e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -762,7 +762,10 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
  */
 void signal_wake_up_state(struct task_struct *t, unsigned int state)
 {
+	lockdep_assert_held(&t->sighand->siglock);
+
 	set_tsk_thread_flag(t, TIF_SIGPENDING);
+
 	/*
 	 * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
 	 * case. We don't check t->state here because there is a race with it
@@ -884,7 +887,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
 static void ptrace_trap_notify(struct task_struct *t)
 {
 	WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
-	assert_spin_locked(&t->sighand->siglock);
+	lockdep_assert_held(&t->sighand->siglock);
 
 	task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
 	ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
@@ -930,9 +933,10 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		for_each_thread(p, t) {
 			flush_sigqueue_mask(&flush, &t->pending);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
-			if (likely(!(t->ptrace & PT_SEIZED)))
+			if (likely(!(t->ptrace & PT_SEIZED))) {
+				t->jobctl &= ~JOBCTL_STOPPED;
 				wake_up_state(t, __TASK_STOPPED);
-			else
+			} else
 				ptrace_trap_notify(t);
 		}
 
@@ -1071,15 +1075,15 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
 
-static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
-			enum pid_type type, bool force)
+static int __send_signal_locked(int sig, struct kernel_siginfo *info,
+				struct task_struct *t, enum pid_type type, bool force)
 {
 	struct sigpending *pending;
 	struct sigqueue *q;
 	int override_rlimit;
 	int ret = 0, result;
 
-	assert_spin_locked(&t->sighand->siglock);
+	lockdep_assert_held(&t->sighand->siglock);
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, force))
@@ -1212,8 +1216,8 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	return ret;
 }
 
-static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
-			enum pid_type type)
+int send_signal_locked(int sig, struct kernel_siginfo *info,
+		       struct task_struct *t, enum pid_type type)
 {
 	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
 	bool force = false;
@@ -1245,7 +1249,7 @@ static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct
 			force = true;
 		}
 	}
-	return __send_signal(sig, info, t, type, force);
+	return __send_signal_locked(sig, info, t, type, force);
 }
 
 static void print_fatal_signal(int signr)
@@ -1281,12 +1285,6 @@ static int __init setup_print_fatal_signals(char *str)
 
 __setup("print-fatal-signals=", setup_print_fatal_signals);
 
-int
-__group_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p)
-{
-	return send_signal(sig, info, p, PIDTYPE_TGID);
-}
-
 int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p,
 			enum pid_type type)
 {
@@ -1294,7 +1292,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
 	int ret = -ESRCH;
 
 	if (lock_task_sighand(p, &flags)) {
-		ret = send_signal(sig, info, p, type);
+		ret = send_signal_locked(sig, info, p, type);
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -1307,43 +1305,6 @@ enum sig_handler {
 	HANDLER_EXIT,	 /* Only visible as the process exit code */
 };
 
-/*
- * On some archictectures, PREEMPT_RT has to delay sending a signal from a
- * trap since it cannot enable preemption, and the signal code's
- * spin_locks turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME
- * which will send the signal on exit of the trap.
- */
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-static inline bool force_sig_delayed(struct kernel_siginfo *info,
-				     struct task_struct *t)
-{
-	if (!in_atomic())
-		return false;
-
-	if (WARN_ON_ONCE(t->forced_info.si_signo))
-		return true;
-
-	if (is_si_special(info)) {
-		WARN_ON_ONCE(info != SEND_SIG_PRIV);
-		t->forced_info.si_signo = info->si_signo;
-		t->forced_info.si_errno = 0;
-		t->forced_info.si_code = SI_KERNEL;
-		t->forced_info.si_pid = 0;
-		t->forced_info.si_uid = 0;
-	} else {
-		t->forced_info = *info;
-	}
-	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
-	return true;
-}
-#else
-static inline bool force_sig_delayed(struct kernel_siginfo *info,
-				     struct task_struct *t)
-{
-	return false;
-}
-#endif
-
 /*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
@@ -1364,9 +1325,6 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	struct k_sigaction *action;
 	int sig = info->si_signo;
 
-	if (force_sig_delayed(info, t))
-		return 0;
-
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
@@ -1387,7 +1345,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	if (action->sa.sa_handler == SIG_DFL &&
 	    (!t->ptrace || (handler == HANDLER_EXIT)))
 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
-	ret = send_signal(sig, info, t, PIDTYPE_PID);
+	ret = send_signal_locked(sig, info, t, PIDTYPE_PID);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
 	return ret;
@@ -1607,7 +1565,7 @@ int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, false);
+			ret = __send_signal_locked(sig, &info, p, PIDTYPE_TGID, false);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
@@ -2143,7 +2101,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * parent's namespaces.
 	 */
 	if (valid_signal(sig) && sig)
-		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
+		__send_signal_locked(sig, &info, tsk->parent, PIDTYPE_TGID, false);
 	__wake_up_parent(tsk, tsk->parent);
 	spin_unlock_irqrestore(&psig->siglock, flags);
 
@@ -2213,7 +2171,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_lock_irqsave(&sighand->siglock, flags);
 	if (sighand->action[SIGCHLD-1].sa.sa_handler != SIG_IGN &&
 	    !(sighand->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-		__group_send_sig_info(SIGCHLD, &info, parent);
+		send_signal_locked(SIGCHLD, &info, parent, PIDTYPE_TGID);
 	/*
 	 * Even if SIGCHLD is not generated, we must wake up wait4 calls.
 	 */
@@ -2233,13 +2191,12 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * with.  If the code did not stop because the tracer is gone,
  * the stop signal remains unchanged unless clear_code.
  */
-static int ptrace_stop(int exit_code, int why, int clear_code,
-			unsigned long message, kernel_siginfo_t *info)
+static int ptrace_stop(int exit_code, int why, unsigned long message,
+		       kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
 {
 	bool gstop_done = false;
-	bool read_code = true;
 
 	if (arch_ptrace_stop_needed()) {
 		/*
@@ -2256,10 +2213,16 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	}
 
 	/*
-	 * schedule() will not sleep if there is a pending signal that
-	 * can awaken the task.
+	 * After this point ptrace_signal_wake_up or signal_wake_up
+	 * will clear TASK_TRACED if ptrace_unlink happens or a fatal
+	 * signal comes in.  Handle previous ptrace_unlinks and fatal
+	 * signals here to prevent ptrace_stop sleeping in schedule.
 	 */
+	if (!current->ptrace || __fatal_signal_pending(current))
+		return exit_code;
+
 	set_special_state(TASK_TRACED);
+	current->jobctl |= JOBCTL_TRACED;
 
 	/*
 	 * We're committing to trapping.  TRACED should be visible before
@@ -2305,46 +2268,25 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	spin_unlock_irq(&current->sighand->siglock);
 	read_lock(&tasklist_lock);
-	if (likely(current->ptrace)) {
-		/*
-		 * Notify parents of the stop.
-		 *
-		 * While ptraced, there are two parents - the ptracer and
-		 * the real_parent of the group_leader.  The ptracer should
-		 * know about every stop while the real parent is only
-		 * interested in the completion of group stop.  The states
-		 * for the two don't interact with each other.  Notify
-		 * separately unless they're gonna be duplicates.
-		 */
+	/*
+	 * Notify parents of the stop.
+	 *
+	 * While ptraced, there are two parents - the ptracer and
+	 * the real_parent of the group_leader.  The ptracer should
+	 * know about every stop while the real parent is only
+	 * interested in the completion of group stop.  The states
+	 * for the two don't interact with each other.  Notify
+	 * separately unless they're gonna be duplicates.
+	 */
+	if (current->ptrace)
 		do_notify_parent_cldstop(current, true, why);
-		if (gstop_done && ptrace_reparented(current))
-			do_notify_parent_cldstop(current, false, why);
+	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
+		do_notify_parent_cldstop(current, false, why);
 
-		read_unlock(&tasklist_lock);
-		cgroup_enter_frozen();
-		freezable_schedule();
-		cgroup_leave_frozen(true);
-	} else {
-		/*
-		 * By the time we got the lock, our tracer went away.
-		 * Don't drop the lock yet, another tracer may come.
-		 *
-		 * If @gstop_done, the ptracer went away between group stop
-		 * completion and here.  During detach, it would have set
-		 * JOBCTL_STOP_PENDING on us and we'll re-enter
-		 * TASK_STOPPED in do_signal_stop() on return, so notifying
-		 * the real parent of the group stop completion is enough.
-		 */
-		if (gstop_done)
-			do_notify_parent_cldstop(current, false, why);
-
-		/* tasklist protects us from ptrace_freeze_traced() */
-		__set_current_state(TASK_RUNNING);
-		read_code = false;
-		if (clear_code)
-			exit_code = 0;
-		read_unlock(&tasklist_lock);
-	}
+	read_unlock(&tasklist_lock);
+	cgroup_enter_frozen();
+	freezable_schedule();
+	cgroup_leave_frozen(true);
 
 	/*
 	 * We are back.  Now reacquire the siglock before touching
@@ -2352,14 +2294,13 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	if (read_code)
-		exit_code = current->exit_code;
+	exit_code = current->exit_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
 	current->exit_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
-	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_PTRACE_FROZEN);
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
@@ -2381,7 +2322,7 @@ static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long mes
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	return ptrace_stop(exit_code, why, 1, message, &info);
+	return ptrace_stop(exit_code, why, message, &info);
 }
 
 int ptrace_notify(int exit_code, unsigned long message)
@@ -2492,6 +2433,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
+		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
@@ -2553,7 +2495,7 @@ static void do_jobctl_trap(void)
 				 CLD_STOPPED, 0);
 	} else {
 		WARN_ON_ONCE(!signr);
-		ptrace_stop(signr, CLD_STOPPED, 0, 0, NULL);
+		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
 	}
 }
 
@@ -2606,7 +2548,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	signr = ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
+	signr = ptrace_stop(signr, CLD_TRAPPED, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
 	if (signr == 0)
@@ -2633,7 +2575,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	/* If the (new) signal is now blocked, requeue it.  */
 	if (sigismember(&current->blocked, signr) ||
 	    fatal_signal_pending(current)) {
-		send_signal(signr, info, current, type);
+		send_signal_locked(signr, info, current, type);
 		signr = 0;
 	}
 
@@ -4825,7 +4767,7 @@ void kdb_send_sig(struct task_struct *t, int sig)
 			   "the deadlock.\n");
 		return;
 	}
-	ret = send_signal(sig, SEND_SIG_PRIV, t, PIDTYPE_PID);
+	ret = send_signal_locked(sig, SEND_SIG_PRIV, t, PIDTYPE_PID);
 	spin_unlock(&t->sighand->siglock);
 	if (ret)
 		kdb_printf("Fail to deliver Signal %d to process %d.\n",
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a97193984dbf..cb925e8ef9a8b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -870,7 +870,7 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 {
 	if (tsk->dl.dl_overrun) {
 		tsk->dl.dl_overrun = 0;
-		__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+		send_signal_locked(SIGXCPU, SEND_SIG_PRIV, tsk, PIDTYPE_TGID);
 	}
 }
 
@@ -884,7 +884,7 @@ static bool check_rlimit(u64 time, u64 limit, int signo, bool rt, bool hard)
 			rt ? "RT" : "CPU", hard ? "hard" : "soft",
 			current->comm, task_pid_nr(current));
 	}
-	__group_send_sig_info(signo, SEND_SIG_PRIV, current);
+	send_signal_locked(signo, SEND_SIG_PRIV, current, PIDTYPE_TGID);
 	return true;
 }
 
@@ -958,7 +958,7 @@ static void check_cpu_itimer(struct task_struct *tsk, struct cpu_itimer *it,
 		trace_itimer_expire(signo == SIGPROF ?
 				    ITIMER_PROF : ITIMER_VIRTUAL,
 				    task_tgid(tsk), cur_time);
-		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
+		send_signal_locked(signo, SEND_SIG_PRIV, tsk, PIDTYPE_TGID);
 	}
 
 	if (it->expires && it->expires < *expires)
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3742cd9e74b75..41a6e75fbcd8d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1938,12 +1938,10 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_PTR(err);
 	}
 
-	get_cpu_light();
-	vbq = this_cpu_ptr(&vmap_block_queue);
+	vbq = raw_cpu_ptr(&vmap_block_queue);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);
-	put_cpu_light();
 
 	return vaddr;
 }
@@ -2022,8 +2020,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	order = get_order(size);
 
 	rcu_read_lock();
-	get_cpu_light();
-	vbq = this_cpu_ptr(&vmap_block_queue);
+	vbq = raw_cpu_ptr(&vmap_block_queue);
 	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 		unsigned long pages_off;
 
@@ -2046,7 +2043,6 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 		break;
 	}
 
-	put_cpu_light();
 	rcu_read_unlock();
 
 	/* Allocate new block if nothing was found */
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index f440d0eff93f6..79965deec5b12 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -448,7 +448,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
 	struct svc_pool *pool;
 	struct svc_rqst	*rqstp = NULL;
-	int cpu;
 
 	if (!svc_xprt_ready(xprt))
 		return;
@@ -461,8 +460,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
 		return;
 
-	cpu = get_cpu_light();
-	pool = svc_pool_for_cpu(xprt->xpt_server, cpu);
+	pool = svc_pool_for_cpu(xprt->xpt_server, raw_smp_processor_id());
 
 	atomic_long_inc(&pool->sp_stats.packets);
 
@@ -485,7 +483,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	rqstp = NULL;
 out_unlock:
 	rcu_read_unlock();
-	put_cpu_light();
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);

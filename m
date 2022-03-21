Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36C4E24F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbiCULEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbiCULDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:03:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824514B878
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:02:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647860543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nhklejKg0W9Ip1OhpQL/K+eZZRL3CFt0E4UVa5G9hX4=;
        b=MrrVzDYDqhpaZkIHXEeZ7y+CexS+3byrGunlLrOOwluiFpmlke8Yqy7LerwHY8/BIz7+/d
        gQqkrWfKS15/Zt4BPxkHgQwqnRFYtd4Bz1yuY2sZBt18ayV8jbuknier0v7IKvL0QcHn+n
        mnEguFUKEAkNmdZkLBCloKQP2tSH1PxrmaPh9jvfKaALP405mY7v4QS9trtPsa3KXqJipD
        MAizT0TAnJNQkUqyZ3FBZL6zRlt1G29X/SWqLGIKb4vD5vCJuYpDlrj7TI4wy9Lo+P8Qed
        a1ok/d6mQP5YrUPbEnfUYEVKjkOKL0kiFrcLOjltq6UmYY5WsuLAuYFjB7aMpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647860543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nhklejKg0W9Ip1OhpQL/K+eZZRL3CFt0E4UVa5G9hX4=;
        b=ikidgGzQsiJ8a0eDWO0m5nOlW1nJOBWxWdHFX18b8NCpDh7s56oGbxfEqPzOEanck5TIZv
        yLaPnHMxWeNzgeBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/core for v5.18-rc1
Message-ID: <164786042536.122591.4459156564791679956.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 21 Mar 2022 12:02:22 +0100 (CET)
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

please pull the latest core/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2022-0=
3-21

up to:  bf9ad37dc8a3: signal, x86: Delay calling signals in atomic on RT enab=
led kernels

Core code updates:

  - Reduce the amount of work to release a task stack in context
    switch. There is no real reason to do cgroup accounting and memory
    freeing in this performance sensitive context. Aside of this the
    invoked functions cannot be called from this preemption disabled
    context on PREEMPT_RT enabled kernels. Solve this by moving the
    accounting into do_exit() and delaying the freeing of the stack unless
    the vmap stack can be cached.

  - Provide a mechanism to delay raising signals from atomic context on
    PREEMPT_RT enabled kernels as sighand::lock cannot be acquired.  Store
    the information in the task struct and raise it in the exit path.


Thanks,

	tglx

------------------>
Oleg Nesterov (1):
      signal, x86: Delay calling signals in atomic on RT enabled kernels

Sebastian Andrzej Siewior (8):
      fork: Redo ifdefs around task stack handling
      fork: Duplicate task_struct before stack allocation
      fork, IA64: Provide alloc_thread_stack_node() for IA64
      fork: Don't assign the stack pointer in dup_task_struct()
      fork: Move memcg_charge_kernel_stack() into CONFIG_VMAP_STACK
      fork: Move task stack accounting to do_exit()
      fork: Only cache the VMAP stack in finish_task_switch()
      fork: Use IS_ENABLED() in account_kernel_stack()


 arch/ia64/include/asm/thread_info.h |   6 +-
 arch/x86/Kconfig                    |   1 +
 include/linux/sched.h               |   3 +
 include/linux/sched/task_stack.h    |   2 +
 kernel/Kconfig.preempt              |  12 +-
 kernel/entry/common.c               |  14 ++
 kernel/exit.c                       |   1 +
 kernel/fork.c                       | 263 +++++++++++++++++++++++-----------=
--
 kernel/signal.c                     |  40 ++++++
 9 files changed, 241 insertions(+), 101 deletions(-)

diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thre=
ad_info.h
index 51d20cb37706..1684716f0820 100644
--- a/arch/ia64/include/asm/thread_info.h
+++ b/arch/ia64/include/asm/thread_info.h
@@ -55,15 +55,15 @@ struct thread_info {
 #ifndef ASM_OFFSETS_C
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + IA=
64_TASK_SIZE))
-#define alloc_thread_stack_node(tsk, node)	\
+#define arch_alloc_thread_stack_node(tsk, node)	\
 		((unsigned long *) ((char *) (tsk) + IA64_TASK_SIZE))
 #define task_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA64=
_TASK_SIZE))
 #else
 #define current_thread_info()	((struct thread_info *) 0)
-#define alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
+#define arch_alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
 #define task_thread_info(tsk)	((struct thread_info *) 0)
 #endif
-#define free_thread_stack(tsk)	/* nothing */
+#define arch_free_thread_stack(tsk)	/* nothing */
 #define task_stack_page(tsk)	((void *)(tsk))
=20
 #define __HAVE_THREAD_FUNCTIONS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..d557ac29b6cd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -120,6 +120,7 @@ config X86
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..098e37fd770a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1087,6 +1087,9 @@ struct task_struct {
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+	struct kernel_siginfo		forced_info;
+#endif
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stac=
k.h
index d10150587d81..892562ebbd3a 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -79,6 +79,8 @@ static inline void *try_get_task_stack(struct task_struct *=
tsk)
 static inline void put_task_stack(struct task_struct *tsk) {}
 #endif
=20
+void exit_task_stack_account(struct task_struct *tsk);
+
 #define task_stack_end_corrupted(task) \
 		(*(end_of_stack(task)) !=3D STACK_END_MAGIC)
=20
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ce77f0265660..5644abd5f8a8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -132,4 +132,14 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
=20
-
+config ARCH_WANTS_RT_DELAYED_SIGNALS
+	bool
+	help
+	  This option is selected by architectures where raising signals
+	  can happen in atomic contexts on PREEMPT_RT enabled kernels. This
+	  option delays raising the signal until the return to user space
+	  loop where it is also delivered. X86 requires this to deliver
+	  signals from trap handlers which run on IST stacks.
+
+config RT_DELAYED_SIGNALS
+	def_bool PREEMPT_RT && ARCH_WANTS_RT_DELAYED_SIGNALS
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e..0543a2c92f20 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -148,6 +148,18 @@ static void handle_signal_work(struct pt_regs *regs, uns=
igned long ti_work)
 	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
 }
=20
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+static inline void raise_delayed_signal(void)
+{
+	if (unlikely(current->forced_info.si_signo)) {
+		force_sig_info(&current->forced_info);
+		current->forced_info.si_signo =3D 0;
+	}
+}
+#else
+static inline void raise_delayed_signal(void) { }
+#endif
+
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -162,6 +174,8 @@ static unsigned long exit_to_user_mode_loop(struct pt_reg=
s *regs,
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
=20
+		raise_delayed_signal();
+
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
=20
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab9..c303cffe7fdb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -845,6 +845,7 @@ void __noreturn do_exit(long code)
 		put_page(tsk->task_frag.page);
=20
 	validate_creds_for_do_exit(tsk);
+	exit_task_stack_account(tsk);
=20
 	check_stack_usage();
 	preempt_disable();
diff --git a/kernel/fork.c b/kernel/fork.c
index a024bf6254df..1279b57c4ad9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -185,7 +185,7 @@ static inline void free_task_struct(struct task_struct *t=
sk)
  */
 # if THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK)
=20
-#ifdef CONFIG_VMAP_STACK
+#  ifdef CONFIG_VMAP_STACK
 /*
  * vmalloc() is a bit slow, and calling vfree() enough times will force a TLB
  * flush.  Try to minimize the number of calls by caching stacks.
@@ -193,6 +193,41 @@ static inline void free_task_struct(struct task_struct *=
tsk)
 #define NR_CACHED_STACKS 2
 static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
=20
+struct vm_stack {
+	struct rcu_head rcu;
+	struct vm_struct *stack_vm_area;
+};
+
+static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < NR_CACHED_STACKS; i++) {
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) !=3D NULL)
+			continue;
+		return true;
+	}
+	return false;
+}
+
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	struct vm_stack *vm_stack =3D container_of(rh, struct vm_stack, rcu);
+
+	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
+		return;
+
+	vfree(vm_stack);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct vm_stack *vm_stack =3D tsk->stack;
+
+	vm_stack->stack_vm_area =3D tsk->stack_vm_area;
+	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+}
+
 static int free_vm_stack_cache(unsigned int cpu)
 {
 	struct vm_struct **cached_vm_stacks =3D per_cpu_ptr(cached_stacks, cpu);
@@ -210,11 +245,35 @@ static int free_vm_stack_cache(unsigned int cpu)
=20
 	return 0;
 }
-#endif
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int n=
ode)
+static int memcg_charge_kernel_stack(struct vm_struct *vm)
 {
-#ifdef CONFIG_VMAP_STACK
+	int i;
+	int ret;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 !=3D 0);
+	BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
+
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+		ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
+		if (ret)
+			goto err;
+	}
+	return 0;
+err:
+	/*
+	 * If memcg_kmem_charge_page() fails, page's memory cgroup pointer is
+	 * NULL, and memcg_kmem_uncharge_page() in free_thread_stack() will
+	 * ignore this page.
+	 */
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		memcg_kmem_uncharge_page(vm->pages[i], 0);
+	return ret;
+}
+
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
+{
+	struct vm_struct *vm;
 	void *stack;
 	int i;
=20
@@ -232,9 +291,14 @@ static unsigned long *alloc_thread_stack_node(struct tas=
k_struct *tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
=20
+		if (memcg_charge_kernel_stack(s)) {
+			vfree(s->addr);
+			return -ENOMEM;
+		}
+
 		tsk->stack_vm_area =3D s;
 		tsk->stack =3D s->addr;
-		return s->addr;
+		return 0;
 	}
=20
 	/*
@@ -247,71 +311,95 @@ static unsigned long *alloc_thread_stack_node(struct ta=
sk_struct *tsk, int node)
 				     THREADINFO_GFP & ~__GFP_ACCOUNT,
 				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
+	if (!stack)
+		return -ENOMEM;
=20
+	vm =3D find_vm_area(stack);
+	if (memcg_charge_kernel_stack(vm)) {
+		vfree(stack);
+		return -ENOMEM;
+	}
 	/*
 	 * We can't call find_vm_area() in interrupt context, and
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	if (stack) {
-		tsk->stack_vm_area =3D find_vm_area(stack);
-		tsk->stack =3D stack;
-	}
-	return stack;
-#else
+	tsk->stack_vm_area =3D vm;
+	tsk->stack =3D stack;
+	return 0;
+}
+
+static void free_thread_stack(struct task_struct *tsk)
+{
+	if (!try_release_thread_stack_to_cache(tsk->stack_vm_area))
+		thread_stack_delayed_free(tsk);
+
+	tsk->stack =3D NULL;
+	tsk->stack_vm_area =3D NULL;
+}
+
+#  else /* !CONFIG_VMAP_STACK */
+
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	__free_pages(virt_to_page(rh), THREAD_SIZE_ORDER);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh =3D tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
+{
 	struct page *page =3D alloc_pages_node(node, THREADINFO_GFP,
 					     THREAD_SIZE_ORDER);
=20
 	if (likely(page)) {
 		tsk->stack =3D kasan_reset_tag(page_address(page));
-		return tsk->stack;
+		return 0;
 	}
-	return NULL;
-#endif
+	return -ENOMEM;
 }
=20
-static inline void free_thread_stack(struct task_struct *tsk)
+static void free_thread_stack(struct task_struct *tsk)
 {
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-
-	if (vm) {
-		int i;
+	thread_stack_delayed_free(tsk);
+	tsk->stack =3D NULL;
+}
=20
-		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
-			memcg_kmem_uncharge_page(vm->pages[i], 0);
+#  endif /* CONFIG_VMAP_STACK */
+# else /* !(THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK)) */
=20
-		for (i =3D 0; i < NR_CACHED_STACKS; i++) {
-			if (this_cpu_cmpxchg(cached_stacks[i],
-					NULL, tsk->stack_vm_area) !=3D NULL)
-				continue;
+static struct kmem_cache *thread_stack_cache;
=20
-			return;
-		}
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	kmem_cache_free(thread_stack_cache, rh);
+}
=20
-		vfree_atomic(tsk->stack);
-		return;
-	}
-#endif
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh =3D tsk->stack;
=20
-	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	call_rcu(rh, thread_stack_free_rcu);
 }
-# else
-static struct kmem_cache *thread_stack_cache;
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
-						  int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
 	stack =3D kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
 	stack =3D kasan_reset_tag(stack);
 	tsk->stack =3D stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
 {
-	kmem_cache_free(thread_stack_cache, tsk->stack);
+	thread_stack_delayed_free(tsk);
+	tsk->stack =3D NULL;
 }
=20
 void thread_stack_cache_init(void)
@@ -321,8 +409,26 @@ void thread_stack_cache_init(void)
 					THREAD_SIZE, NULL);
 	BUG_ON(thread_stack_cache =3D=3D NULL);
 }
-# endif
-#endif
+
+# endif /* THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
+
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
+{
+	unsigned long *stack;
+
+	stack =3D arch_alloc_thread_stack_node(tsk, node);
+	tsk->stack =3D stack;
+	return stack ? 0 : -ENOMEM;
+}
+
+static void free_thread_stack(struct task_struct *tsk)
+{
+	arch_free_thread_stack(tsk);
+	tsk->stack =3D NULL;
+}
+
+#endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
@@ -379,50 +485,34 @@ void vm_area_free(struct vm_area_struct *vma)
=20
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
-	void *stack =3D task_stack_page(tsk);
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-
-	if (vm) {
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm =3D task_stack_vm_area(tsk);
 		int i;
=20
 		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
+		void *stack =3D task_stack_page(tsk);
+
 		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
 	}
 }
=20
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
+void exit_task_stack_account(struct task_struct *tsk)
 {
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-	int ret;
-
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 !=3D 0);
+	account_kernel_stack(tsk, -1);
=20
-	if (vm) {
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm;
 		int i;
=20
-		BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
-
-		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			/*
-			 * If memcg_kmem_charge_page() fails, page's
-			 * memory cgroup pointer is NULL, and
-			 * memcg_kmem_uncharge_page() in free_thread_stack()
-			 * will ignore this page.
-			 */
-			ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
-						     0);
-			if (ret)
-				return ret;
-		}
+		vm =3D task_stack_vm_area(tsk);
+		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			memcg_kmem_uncharge_page(vm->pages[i], 0);
 	}
-#endif
-	return 0;
 }
=20
 static void release_task_stack(struct task_struct *tsk)
@@ -430,12 +520,7 @@ static void release_task_stack(struct task_struct *tsk)
 	if (WARN_ON(READ_ONCE(tsk->__state) !=3D TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
=20
-	account_kernel_stack(tsk, -1);
 	free_thread_stack(tsk);
-	tsk->stack =3D NULL;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area =3D NULL;
-#endif
 }
=20
 #ifdef CONFIG_THREAD_INFO_IN_TASK
@@ -874,8 +959,6 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 static struct task_struct *dup_task_struct(struct task_struct *orig, int nod=
e)
 {
 	struct task_struct *tsk;
-	unsigned long *stack;
-	struct vm_struct *stack_vm_area __maybe_unused;
 	int err;
=20
 	if (node =3D=3D NUMA_NO_NODE)
@@ -884,32 +967,18 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	if (!tsk)
 		return NULL;
=20
-	stack =3D alloc_thread_stack_node(tsk, node);
-	if (!stack)
+	err =3D arch_dup_task_struct(tsk, orig);
+	if (err)
 		goto free_tsk;
=20
-	if (memcg_charge_kernel_stack(tsk))
-		goto free_stack;
-
-	stack_vm_area =3D task_stack_vm_area(tsk);
-
-	err =3D arch_dup_task_struct(tsk, orig);
+	err =3D alloc_thread_stack_node(tsk, node);
+	if (err)
+		goto free_tsk;
=20
-	/*
-	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
-	 * sure they're properly initialized before using any stack-related
-	 * functions again.
-	 */
-	tsk->stack =3D stack;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area =3D stack_vm_area;
-#endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
-
-	if (err)
-		goto free_stack;
+	account_kernel_stack(tsk, 1);
=20
 	err =3D scs_prepare(tsk, node);
 	if (err)
@@ -953,8 +1022,6 @@ static struct task_struct *dup_task_struct(struct task_s=
truct *orig, int node)
 	tsk->wake_q.next =3D NULL;
 	tsk->worker_private =3D NULL;
=20
-	account_kernel_stack(tsk, 1);
-
 	kcov_task_init(tsk);
 	kmap_local_fork(tsk);
=20
@@ -973,6 +1040,7 @@ static struct task_struct *dup_task_struct(struct task_s=
truct *orig, int node)
 	return tsk;
=20
 free_stack:
+	exit_task_stack_account(tsk);
 	free_thread_stack(tsk);
 free_tsk:
 	free_task_struct(tsk);
@@ -2451,6 +2519,7 @@ static __latent_entropy struct task_struct *copy_proces=
s(
 	exit_creds(p);
 bad_fork_free:
 	WRITE_ONCE(p->__state, TASK_DEAD);
+	exit_task_stack_account(p);
 	put_task_stack(p);
 	delayed_free_task(p);
 fork_out:
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b04631acde8..e93de6daa188 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1307,6 +1307,43 @@ enum sig_handler {
 	HANDLER_EXIT,	 /* Only visible as the process exit code */
 };
=20
+/*
+ * On some archictectures, PREEMPT_RT has to delay sending a signal from a
+ * trap since it cannot enable preemption, and the signal code's
+ * spin_locks turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME
+ * which will send the signal on exit of the trap.
+ */
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+static inline bool force_sig_delayed(struct kernel_siginfo *info,
+				     struct task_struct *t)
+{
+	if (!in_atomic())
+		return false;
+
+	if (WARN_ON_ONCE(t->forced_info.si_signo))
+		return true;
+
+	if (is_si_special(info)) {
+		WARN_ON_ONCE(info !=3D SEND_SIG_PRIV);
+		t->forced_info.si_signo =3D info->si_signo;
+		t->forced_info.si_errno =3D 0;
+		t->forced_info.si_code =3D SI_KERNEL;
+		t->forced_info.si_pid =3D 0;
+		t->forced_info.si_uid =3D 0;
+	} else {
+		t->forced_info =3D *info;
+	}
+	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	return true;
+}
+#else
+static inline bool force_sig_delayed(struct kernel_siginfo *info,
+				     struct task_struct *t)
+{
+	return false;
+}
+#endif
+
 /*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
@@ -1327,6 +1364,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, str=
uct task_struct *t,
 	struct k_sigaction *action;
 	int sig =3D info->si_signo;
=20
+	if (force_sig_delayed(info, t))
+		return 0;
+
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action =3D &t->sighand->action[sig-1];
 	ignored =3D action->sa.sa_handler =3D=3D SIG_IGN;


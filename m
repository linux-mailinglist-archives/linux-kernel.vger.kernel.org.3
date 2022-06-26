Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778F55B3C1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiFZTQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiFZTQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:16:48 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44819DF6D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:16:47 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:32966)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5XkU-000iu2-92; Sun, 26 Jun 2022 13:16:46 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57748 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5XkS-00CB82-O0; Sun, 26 Jun 2022 13:16:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        <874k0863x8.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
        <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
        <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
Date:   Sun, 26 Jun 2022 14:16:38 -0500
In-Reply-To: <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Sun, 26 Jun 2022 14:14:45 -0500")
Message-ID: <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5XkS-00CB82-O0;;;mid=<871qvbutex.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/Z7b8ZiIIYOiV+Qf5NfLuK0eGYCDcOn/A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 945 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.8 (0.4%), b_tie_ro: 2.6 (0.3%), parse: 1.30
        (0.1%), extract_message_metadata: 12 (1.3%), get_uri_detail_list: 5
        (0.5%), tests_pri_-1000: 11 (1.1%), tests_pri_-950: 1.09 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 100 (10.5%), check_bayes:
        98 (10.4%), b_tokenize: 20 (2.2%), b_tok_get_all: 11 (1.2%),
        b_comp_prob: 2.2 (0.2%), b_tok_touch_all: 62 (6.5%), b_finish: 0.63
        (0.1%), tests_pri_0: 803 (85.0%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 1.69 (0.2%), poll_dns_idle: 0.31 (0.0%),
        tests_pri_10: 1.86 (0.2%), tests_pri_500: 7 (0.7%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE (INCOMPLETE)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Instead leave the task as a new unscheduled task and require the
caller to call wake_up_new_task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/common/bL_switcher.c             |   2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 drivers/block/mtip32xx/mtip32xx.c         |   2 +-
 drivers/firmware/psci/psci_checker.c      |   2 +-
 drivers/firmware/stratix10-svc.c          |   4 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c         |   2 +-
 drivers/scsi/bnx2i/bnx2i_init.c           |   2 +-
 drivers/scsi/qedi/qedi_main.c             |   2 +-
 include/linux/kthread.h                   |   4 +-
 kernel/bpf/cpumap.c                       |   2 +-
 kernel/dma/map_benchmark.c                |   2 +-
 kernel/kthread.c                          | 114 ++++++++++------------
 kernel/smpboot.c                          |   1 +
 kernel/workqueue.c                        |   2 +-
 net/core/pktgen.c                         |   2 +-
 net/sunrpc/svc.c                          |   2 +-
 16 files changed, 72 insertions(+), 77 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 9a9aa53547a6..15c9841c3c15 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -311,7 +311,7 @@ static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
 				      cpu_to_node(cpu), "kswitcher_%d", cpu);
 	if (!IS_ERR(task)) {
 		kthread_bind(task, cpu);
-		wake_up_process(task);
+		wake_up_new_task(task);
 	} else
 		pr_err("%s failed for CPU %d\n", __func__, cpu);
 	return task;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index db813f819ad6..ba09f5cf1773 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1206,7 +1206,7 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 		goto out;
 	}
 	kthread_bind(thread, cpu);
-	wake_up_process(thread);
+	wake_up_new_task(thread);
 
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
@@ -1304,7 +1304,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	}
 
 	kthread_bind(thread, plr->cpu);
-	wake_up_process(thread);
+	wake_up_new_task(thread);
 
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 27386a572ba4..b2f5b30a27aa 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3649,7 +3649,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 		rv = -EFAULT;
 		goto kthread_run_error;
 	}
-	wake_up_process(dd->mtip_svc_handler);
+	wake_up_new_task(dd->mtip_svc_handler);
 	if (wait_for_rebuild == MTIP_FTL_REBUILD_MAGIC)
 		rv = wait_for_rebuild;
 
diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 116eb465cdb4..52fcd122e2b6 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -418,7 +418,7 @@ static int suspend_tests(void)
 	 * wait for the completion of suspend_threads_started.
 	 */
 	for (i = 0; i < nb_threads; ++i)
-		wake_up_process(threads[i]);
+		wake_up_new_task(threads[i]);
 	complete_all(&suspend_threads_started);
 
 	wait_for_completion(&suspend_threads_done);
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 14663f671323..64d07aaa68bf 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -581,7 +581,7 @@ static int svc_get_sh_memory(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	wake_up_process(sh_memory_task);
+	wake_up_new_task(sh_memory_task);
 
 	if (!wait_for_completion_timeout(&sh_memory->sync_complete, 10 * HZ)) {
 		dev_err(dev,
@@ -834,7 +834,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 				return -EINVAL;
 			}
 		kthread_bind(chan->ctrl->task, cpu);
-		wake_up_process(chan->ctrl->task);
+		wake_up_new_task(chan->ctrl->task);
 	}
 
 	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 05ddbb9bb7d8..1b3af0e01d67 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2622,7 +2622,7 @@ static int bnx2fc_cpu_online(unsigned int cpu)
 	/* bind thread to the cpu */
 	kthread_bind(thread, cpu);
 	p->iothread = thread;
-	wake_up_process(thread);
+	wake_up_new_task(thread);
 	return 0;
 }
 
diff --git a/drivers/scsi/bnx2i/bnx2i_init.c b/drivers/scsi/bnx2i/bnx2i_init.c
index 2b3f0c10478e..cd4976bb86fc 100644
--- a/drivers/scsi/bnx2i/bnx2i_init.c
+++ b/drivers/scsi/bnx2i/bnx2i_init.c
@@ -424,7 +424,7 @@ static int bnx2i_cpu_online(unsigned int cpu)
 	/* bind thread to the cpu */
 	kthread_bind(thread, cpu);
 	p->iothread = thread;
-	wake_up_process(thread);
+	wake_up_new_task(thread);
 	return 0;
 }
 
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 83ffba7f51da..97ced4f12d6e 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1967,7 +1967,7 @@ static int qedi_cpu_online(unsigned int cpu)
 
 	kthread_bind(thread, cpu);
 	p->iothread = thread;
-	wake_up_process(thread);
+	wake_up_new_task(thread);
 	return 0;
 }
 
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30e5bec81d2b..fa5e24df84bf 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -53,7 +53,7 @@ bool kthread_is_per_cpu(struct task_struct *k);
 	struct task_struct *__k						   \
 		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
 	if (!IS_ERR(__k))						   \
-		wake_up_process(__k);					   \
+		wake_up_new_task(__k);					   \
 	__k;								   \
 })
 
@@ -77,7 +77,7 @@ kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
 
 	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
 	if (!IS_ERR(p))
-		wake_up_process(p);
+		wake_up_new_task(p);
 
 	return p;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index f4860ac756cd..e72bbb766f01 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -475,7 +475,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 
 	/* Make sure kthread runs on a single CPU */
 	kthread_bind(rcpu->kthread, cpu);
-	wake_up_process(rcpu->kthread);
+	wake_up_new_task(rcpu->kthread);
 
 	return rcpu;
 
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 0520a8f4fb1d..b28e33c07c92 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -134,7 +134,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 
 	for (i = 0; i < threads; i++) {
 		get_task_struct(tsk[i]);
-		wake_up_process(tsk[i]);
+		wake_up_new_task(tsk[i]);
 	}
 
 	msleep_interruptible(map->bparam.seconds * 1000);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 8529f6b1582b..1769b5118694 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -329,51 +329,12 @@ EXPORT_SYMBOL(kthread_complete_and_exit);
 
 static int kthread(void *_create)
 {
-	static const struct sched_param param = { .sched_priority = 0 };
-	/* Copy data: it's on kthread's stack */
-	struct kthread_create_info *create = _create;
-	int (*threadfn)(void *data) = create->threadfn;
-	void *data = create->data;
-	struct completion *done;
-	struct kthread *self;
-	int ret;
-
-	self = to_kthread(current);
+	struct kthread *self = to_kthread(current);
+	int ret = -EINTR;
 
-	/* If user was SIGKILLed, I release the structure. */
-	done = xchg(&create->done, NULL);
-	if (!done) {
-		kfree(create);
-		kthread_exit(-EINTR);
-	}
-
-	self->threadfn = threadfn;
-	self->data = data;
-
-	/*
-	 * The new thread inherited kthreadd's priority and CPU mask. Reset
-	 * back to default in case they have been changed.
-	 */
-	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
-	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
-
-	/* OK, tell user we're spawned, wait for stop or wakeup */
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	create->result = current;
-	/*
-	 * Thread is going to call schedule(), do not preempt it,
-	 * or the creator may spend more time in wait_task_inactive().
-	 */
-	preempt_disable();
-	complete(done);
-	schedule_preempt_disabled();
-	preempt_enable();
-
-	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
 		cgroup_kthread_ready();
-		__kthread_parkme(self);
-		ret = threadfn(data);
+		ret = self->threadfn(self->data);
 	}
 	kthread_exit(ret);
 }
@@ -391,25 +352,41 @@ int tsk_fork_get_node(struct task_struct *tsk)
 static void create_kthread(struct kthread_create_info *create)
 {
 	struct task_struct *new;
+	struct completion *done;
 
 #ifdef CONFIG_NUMA
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
 	new = new_kthread(kthread, create, NUMA_NO_NODE);
+	create->result = new;
+	/* Claim the completion */
+	done = xchg(&create->done, NULL);
 	if (IS_ERR(new)) {
-		/* If user was SIGKILLed, I release the structure. */
-		struct completion *done = xchg(&create->done, NULL);
+		if (done)
+			complete(done);
+	} else if (done) {
+		static const struct sched_param param = { .sched_priority = 0 };
+		struct kthread *kthread = to_kthread(new);
 
-		if (!done) {
-			kfree(create);
-			return;
-		}
-		create->result = ERR_CAST(new);
-		complete(done);
-	} else {
-		wake_up_new_task(new);
+		kthread->threadfn = create->threadfn;
+		kthread->data = create->data;
+
+		/*
+		 * The new thread inherited kthreadd's priority and CPU mask. Reset
+		 * back to default in case they have been changed.
+		 */
+		sched_setscheduler_nocheck(new, SCHED_NORMAL, &param);
+		set_cpus_allowed_ptr(new, housekeeping_cpumask(HK_TYPE_KTHREAD));
+
+		/* OK, tell user we're spawned, wait for stop or wakeup */
+		//wake_up_new_task(new);
 	}
+	/* If user was SIGKILLed, release the structure. */
+	if (!done)
+		kfree(create);
+	else
+		complete(done);
 }
 
 static __printf(4, 0)
@@ -518,11 +495,11 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 }
 EXPORT_SYMBOL(kthread_create_on_node);
 
-static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, unsigned int state)
+static void kthread_bind_mask_parked(struct task_struct *p, const struct cpumask *mask)
 {
 	unsigned long flags;
 
-	if (!wait_task_inactive(p, state)) {
+	if (!wait_task_inactive(p, TASK_PARKED)) {
 		WARN_ON(1);
 		return;
 	}
@@ -534,14 +511,31 @@ static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mas
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
 
-static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned int state)
+static void kthread_bind_mask_new(struct task_struct *new, const struct cpumask *mask)
+{
+	unsigned long flags;
+
+	/*
+	 * FIXME: verify that p is a new task that
+	 * has not yet been passed through
+	 * wake_up_new_task
+	 */
+
+	/* It's safe because new has never been scheduled. */
+	raw_spin_lock_irqsave(&new->pi_lock, flags);
+	do_set_cpus_allowed(new, mask);
+	new->flags |= PF_NO_SETAFFINITY;
+	raw_spin_unlock_irqrestore(&new->pi_lock, flags);
+}
+
+static void __kthread_bind(struct task_struct *p, unsigned int cpu)
 {
-	__kthread_bind_mask(p, cpumask_of(cpu), state);
+	kthread_bind_mask_new(p, cpumask_of(cpu));
 }
 
 void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
-	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
+	kthread_bind_mask_new(p, mask);
 }
 
 /**
@@ -555,7 +549,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
  */
 void kthread_bind(struct task_struct *p, unsigned int cpu)
 {
-	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
+	__kthread_bind(p, cpu);
 }
 EXPORT_SYMBOL(kthread_bind);
 
@@ -629,7 +623,7 @@ void kthread_unpark(struct task_struct *k)
 	 * The binding was lost and we need to set it again.
 	 */
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
-		__kthread_bind(k, kthread->cpu, TASK_PARKED);
+		kthread_bind_mask_parked(k, cpumask_of(kthread->cpu));
 
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	/*
@@ -863,7 +857,7 @@ __kthread_create_worker(int cpu, unsigned int flags,
 
 	worker->flags = flags;
 	worker->task = task;
-	wake_up_process(task);
+	wake_up_new_task(task);
 	return worker;
 
 fail_task:
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index b9f54544e749..79b8d05164d6 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -192,6 +192,7 @@ __smpboot_create_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
 	 * Park the thread so that it could start right on the CPU
 	 * when it is available.
 	 */
+	wake_up_new_task(tsk);
 	kthread_park(tsk);
 	get_task_struct(tsk);
 	*per_cpu_ptr(ht->store, cpu) = tsk;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..2d16a933f452 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1961,7 +1961,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
-	wake_up_process(worker->task);
+	wake_up_new_task(worker->task);
 	raw_spin_unlock_irq(&pool->lock);
 
 	return worker;
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 84b62cd7bc57..40efd9b678fa 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3864,7 +3864,7 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
 
 	t->net = pn;
 	get_task_struct(p);
-	wake_up_process(p);
+	wake_up_new_task(p);
 	wait_for_completion(&t->start_done);
 
 	return 0;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 7c9a0d0b1230..addbba323b9c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -769,7 +769,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			svc_pool_map_set_cpumask(task, chosen_pool->sp_id);
 
 		svc_sock_update_bufs(serv);
-		wake_up_process(task);
+		wake_up_new_task(task);
 	} while (nrservs > 0);
 
 	return 0;
-- 
2.35.3


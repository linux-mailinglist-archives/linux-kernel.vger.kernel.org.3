Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDF55B3BD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiFZTQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiFZTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:16:21 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A54DF35
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:16:20 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43804)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xk3-00Cq77-RR; Sun, 26 Jun 2022 13:16:19 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57744 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xk2-008ahI-S9; Sun, 26 Jun 2022 13:16:19 -0600
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
Date:   Sun, 26 Jun 2022 14:16:12 -0500
In-Reply-To: <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Sun, 26 Jun 2022 14:14:45 -0500")
Message-ID: <877d53utfn.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5Xk2-008ahI-S9;;;mid=<877d53utfn.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX190SQdd+8R3p3eCZ3mGtEfgajVYGJGF7/E=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.9%), b_tie_ro: 2.8 (0.6%), parse: 1.23
        (0.3%), extract_message_metadata: 11 (2.4%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 11 (2.3%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 103 (22.0%), check_bayes:
        102 (21.8%), b_tokenize: 8 (1.7%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 1.46 (0.3%), b_tok_touch_all: 83 (17.6%), b_finish: 0.67
        (0.1%), tests_pri_0: 323 (68.8%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.09 (0.2%), tests_pri_10:
        2.9 (0.6%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/3] kthread: Replace kernel_thread with new_kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It is desriable to be able to perform all of the kthread setup before
the kernel thread is awaked for the first time.

To make that possible replace kernel_thread with new_kthread that does
all of the same work except it does not call wake_up_new_task.

Replace the two uses of kernel_threadd with new_kthread and a call
to wake_up_new_task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/task.h |  2 +-
 init/main.c                |  6 ++----
 kernel/fork.c              |  4 ++--
 kernel/kthread.c           | 10 ++++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d95930e220da..c4c7a0118553 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -91,7 +91,7 @@ extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
-extern pid_t kernel_thread(int (*fn)(void *), void *arg);
+extern struct task_struct *new_kthread(int (*fn)(void *), void *arg, int node);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
diff --git a/init/main.c b/init/main.c
index 211d38db0d16..b437581f8001 100644
--- a/init/main.c
+++ b/init/main.c
@@ -701,10 +701,8 @@ noinline void __ref rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL);
-	rcu_read_lock();
-	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
-	rcu_read_unlock();
+	kthreadd_task = new_kthread(kthreadd, NULL, NUMA_NO_NODE);
+	wake_up_new_task(kthreadd_task);
 
 	/*
 	 * Enable might_sleep() and smp_processor_id() checks.
diff --git a/kernel/fork.c b/kernel/fork.c
index 65909ded0ea7..794d9f9c78bc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2694,7 +2694,7 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 /*
  * Create a kernel thread.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg)
+struct task_struct *new_kthread(int (*fn)(void *), void *arg, int node)
 {
 	unsigned long flags = CLONE_FS | CLONE_FILES | SIGCHLD;
 	struct kernel_clone_args args = {
@@ -2706,7 +2706,7 @@ pid_t kernel_thread(int (*fn)(void *), void *arg)
 		.kthread	= 1,
 	};
 
-	return kernel_clone(&args);
+	return copy_process(NULL, 0, node, &args);
 }
 
 /*
diff --git a/kernel/kthread.c b/kernel/kthread.c
index c0505e6b7142..8529f6b1582b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -390,14 +390,14 @@ int tsk_fork_get_node(struct task_struct *tsk)
 
 static void create_kthread(struct kthread_create_info *create)
 {
-	int pid;
+	struct task_struct *new;
 
 #ifdef CONFIG_NUMA
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create);
-	if (pid < 0) {
+	new = new_kthread(kthread, create, NUMA_NO_NODE);
+	if (IS_ERR(new)) {
 		/* If user was SIGKILLed, I release the structure. */
 		struct completion *done = xchg(&create->done, NULL);
 
@@ -405,8 +405,10 @@ static void create_kthread(struct kthread_create_info *create)
 			kfree(create);
 			return;
 		}
-		create->result = ERR_PTR(pid);
+		create->result = ERR_CAST(new);
 		complete(done);
+	} else {
+		wake_up_new_task(new);
 	}
 }
 
-- 
2.35.3


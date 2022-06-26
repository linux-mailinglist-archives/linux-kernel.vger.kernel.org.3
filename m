Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6055B3BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiFZTP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFZTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:15:57 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18126DF35
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:15:57 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46222)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xjg-000is3-3J; Sun, 26 Jun 2022 13:15:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57740 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Xje-008aeQ-UP; Sun, 26 Jun 2022 13:15:55 -0600
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
Date:   Sun, 26 Jun 2022 14:15:48 -0500
In-Reply-To: <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Sun, 26 Jun 2022 14:14:45 -0500")
Message-ID: <87czevutgb.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5Xje-008aeQ-UP;;;mid=<87czevutgb.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19g9L/lkXLANuRQ/Dfu1tqYwAH8IrGXz6Q=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 630 ms - load_scoreonly_sql: 0.19 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.36
        (0.2%), extract_message_metadata: 13 (2.1%), get_uri_detail_list: 1.80
        (0.3%), tests_pri_-1000: 15 (2.3%), tests_pri_-950: 1.54 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 193 (30.6%), check_bayes:
        191 (30.4%), b_tokenize: 10 (1.5%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 168 (26.7%), b_finish: 1.01
        (0.2%), tests_pri_0: 336 (53.4%), check_dkim_signature: 1.36 (0.2%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 0.91 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 50 (7.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/3] kthread: Remove the flags argument from kernel_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There are only two callers of kernel_thread remaining.  The calling in
init/main.c that creates kthreadd, and the caller in kernel/kthread.c

Both callers pass CLONE_FS|CLONE_FILES.  The argument SIGCHLD causes
terminate to exit with the oridnary process SIGCHLD semantics.

As kthreadd never exists it simply does not matter what kind of exit
it has.  So for simplicity make it look like everything else and use
SIGCHLD.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/task.h | 2 +-
 init/main.c                | 2 +-
 kernel/fork.c              | 3 ++-
 kernel/kthread.c           | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 505aaf9fe477..d95930e220da 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -91,7 +91,7 @@ extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
-extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
+extern pid_t kernel_thread(int (*fn)(void *), void *arg);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
diff --git a/init/main.c b/init/main.c
index 0ee39cdcfcac..211d38db0d16 100644
--- a/init/main.c
+++ b/init/main.c
@@ -701,7 +701,7 @@ noinline void __ref rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
+	pid = kernel_thread(kthreadd, NULL);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..65909ded0ea7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2694,8 +2694,9 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 /*
  * Create a kernel thread.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t kernel_thread(int (*fn)(void *), void *arg)
 {
+	unsigned long flags = CLONE_FS | CLONE_FILES | SIGCHLD;
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 544fd4097406..c0505e6b7142 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -396,7 +396,7 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_thread(kthread, create);
 	if (pid < 0) {
 		/* If user was SIGKILLed, I release the structure. */
 		struct completion *done = xchg(&create->done, NULL);
-- 
2.35.3


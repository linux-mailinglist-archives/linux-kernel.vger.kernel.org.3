Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1E555198
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376672AbiFVQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376778AbiFVQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:26 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3473440A17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:46:33 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35050)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43Uu-004yHi-8f; Wed, 22 Jun 2022 10:46:32 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57374 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43Us-00FwBm-2Y; Wed, 22 Jun 2022 10:46:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Keno Fischer <keno@juliacomputing.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
Date:   Wed, 22 Jun 2022 11:46:23 -0500
In-Reply-To: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 22 Jun 2022 11:43:37 -0500")
Message-ID: <87bkukd4tc.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o43Us-00FwBm-2Y;;;mid=<87bkukd4tc.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/WQCNlrCjNpy7h2EXBDC9Vav8tQ0hhtfU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1656 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.14
        (0.1%), extract_message_metadata: 14 (0.8%), get_uri_detail_list: 2.0
        (0.1%), tests_pri_-1000: 14 (0.8%), tests_pri_-950: 1.24 (0.1%),
        tests_pri_-900: 0.97 (0.1%), tests_pri_-90: 223 (13.5%), check_bayes:
        222 (13.4%), b_tokenize: 8 (0.5%), b_tok_get_all: 7 (0.4%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 200 (12.1%), b_finish: 1.07
        (0.1%), tests_pri_0: 1347 (81.4%), check_dkim_signature: 0.96 (0.1%),
        check_dkim_adsp: 4.2 (0.3%), poll_dns_idle: 0.86 (0.1%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 37 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/3] signal: Guarantee that SIGNAL_GROUP_EXIT is set on
 process exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Track how many threads have not started exiting and when the last
thread starts exiting set SIGNAL_GROUP_EXIT.

This guarantees that SIGNAL_GROUP_EXIT will get set when a process
exits.  In practice this achieves nothing as glibc's implementation of
_exit calls sys_group_exit then sys_exit.  While glibc's implemenation
of pthread_exit calls exit (which cleansup and calls _exit) if it is
the last thread and sys_exit if it is the last thread.

This means the only way the kernel might observe a process that does
not set call exit_group is if the language runtime does not use glibc.

With more cleanups I hope to move the decrement of quick_threads
earlier.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/exit.c                | 18 ++++++++++++++++++
 kernel/fork.c                |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index cafbe03eed01..20099268fa25 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -94,6 +94,7 @@ struct signal_struct {
 	refcount_t		sigcnt;
 	atomic_t		live;
 	int			nr_threads;
+	int			quick_threads;
 	struct list_head	thread_head;
 
 	wait_queue_head_t	wait_chldexit;	/* for wait4() */
diff --git a/kernel/exit.c b/kernel/exit.c
index 96e4b12edea8..beaedb867bd3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -733,11 +733,29 @@ static void check_stack_usage(void)
 static inline void check_stack_usage(void) {}
 #endif
 
+static void synchronize_group_exit(struct task_struct *tsk, long code)
+{
+	struct sighand_struct *sighand = tsk->sighand;
+	struct signal_struct *signal = tsk->signal;
+
+	spin_lock_irq(&sighand->siglock);
+	signal->quick_threads--;
+	if ((signal->quick_threads == 0) &&
+	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
+		signal->flags = SIGNAL_GROUP_EXIT;
+		signal->group_exit_code = code;
+		signal->group_stop_count = 0;
+	}
+	spin_unlock_irq(&sighand->siglock);
+}
+
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	synchronize_group_exit(tsk, code);
+
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..67813b25a567 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1692,6 +1692,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 		return -ENOMEM;
 
 	sig->nr_threads = 1;
+	sig->quick_threads = 1;
 	atomic_set(&sig->live, 1);
 	refcount_set(&sig->sigcnt, 1);
 
@@ -2444,6 +2445,7 @@ static __latent_entropy struct task_struct *copy_process(
 			__this_cpu_inc(process_counts);
 		} else {
 			current->signal->nr_threads++;
+			current->signal->quick_threads++;
 			atomic_inc(&current->signal->live);
 			refcount_inc(&current->signal->sigcnt);
 			task_join_group_stop(p);
-- 
2.35.3


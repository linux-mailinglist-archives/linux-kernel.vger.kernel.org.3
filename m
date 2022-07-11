Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6808B570820
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGKQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGKQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F8D877A6B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657556196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ukciBrPSkW/5Zi8Bv3unDbDIaDzrzBt7MXrpTRYx3I=;
        b=Uovw0YjkDfrH2B+P6N/iFswkUyW1HgGe1vETwmHOfhnht/m340aWpagNbVihnqyzBuyNVn
        R36wIEZXhvqfqtInCo1L130PRktE3g36ETr9fO0XEbF7h4KGwDZNsTFvQQ+GadRiRtZ2sw
        lQacLWkdzsxrwUUgUXEQe6T5aktkbEo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-gkkcY9TNNWy3IqsCMKg35A-1; Mon, 11 Jul 2022 12:16:30 -0400
X-MC-Unique: gkkcY9TNNWy3IqsCMKg35A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAD123821C00;
        Mon, 11 Jul 2022 16:16:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D590400EA8B;
        Mon, 11 Jul 2022 16:16:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Jul 2022 18:16:27 +0200 (CEST)
Date:   Mon, 11 Jul 2022 18:16:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     chris@accessvector.net,
        "security@kernel.org" <security@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix race between exit_itimers() and /proc/pid/timers
Message-ID: <20220711161624.GA7683@redhat.com>
References: <7tBrxiXIS8yrkSQC04SW-R8BK2xeKgirCEAeh2XB3EVkZSsJjVPJ3_tTXNwC0Ued3a3e8xYztaYvRGYyWApDAgKEUl9IC_xwvVqUpo0BpaI=@accessvector.net>
 <20220708085713.GA6144@redhat.com>
 <R1W_P-BmV6F1JDyltK8tqX5q7DGQOcg0jkuq6XI36cXJBD1UZKMy5HjParo0Y2jehd6nA7mHEJzrMOGUsefDoyz7502IemibJyY-UFxdumM=@accessvector.net>
 <20220708150215.GA11062@redhat.com>
 <CAHk-=wjDfxvACHaU5PGS5XgetAp5oQQOCTXVqBG+e4_hsM2DeA@mail.gmail.com>
 <20220708175133.GB11062@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708175133.GB11062@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Chris explains, the comment above exit_itimers() is not correct,
we can race with proc_timers_seq_ops. Change exit_itimers() to clear
signal->posix_timers with ->siglock held.

Cc: <stable@vger.kernel.org>
Reported-by: chris@accessvector.net
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c                  |  2 +-
 include/linux/sched/task.h |  2 +-
 kernel/exit.c              |  2 +-
 kernel/time/posix-timers.c | 19 ++++++++++++++-----
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0989fb8472a1..778123259e42 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1301,7 +1301,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
-	exit_itimers(me->signal);
+	exit_itimers(me);
 	flush_itimer_signals();
 #endif
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 505aaf9fe477..81cab4b01edc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -85,7 +85,7 @@ static inline void exit_thread(struct task_struct *tsk)
 extern __noreturn void do_group_exit(int);
 
 extern void exit_files(struct task_struct *);
-extern void exit_itimers(struct signal_struct *);
+extern void exit_itimers(struct task_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
diff --git a/kernel/exit.c b/kernel/exit.c
index f072959fcab7..64c938ce36fe 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -766,7 +766,7 @@ void __noreturn do_exit(long code)
 
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
-		exit_itimers(tsk->signal);
+		exit_itimers(tsk);
 #endif
 		if (tsk->mm)
 			setmax_mm_hiwater_rss(&tsk->signal->maxrss, tsk->mm);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1cd10b102c51..5dead89308b7 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1051,15 +1051,24 @@ static void itimer_delete(struct k_itimer *timer)
 }
 
 /*
- * This is called by do_exit or de_thread, only when there are no more
- * references to the shared signal_struct.
+ * This is called by do_exit or de_thread, only when nobody else can
+ * modify the signal->posix_timers list. Yet we need sighand->siglock
+ * to prevent the race with /proc/pid/timers.
  */
-void exit_itimers(struct signal_struct *sig)
+void exit_itimers(struct task_struct *tsk)
 {
+	struct list_head timers;
 	struct k_itimer *tmr;
 
-	while (!list_empty(&sig->posix_timers)) {
-		tmr = list_entry(sig->posix_timers.next, struct k_itimer, list);
+	if (list_empty(&tsk->signal->posix_timers))
+		return;
+
+	spin_lock_irq(&tsk->sighand->siglock);
+	list_replace_init(&tsk->signal->posix_timers, &timers);
+	spin_unlock_irq(&tsk->sighand->siglock);
+
+	while (!list_empty(&timers)) {
+		tmr = list_first_entry(&timers, struct k_itimer, list);
 		itimer_delete(tmr);
 	}
 }
-- 
2.25.1.362.g51ebf55



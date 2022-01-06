Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2417486853
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbiAFRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241708AbiAFRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:21:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF9C06118A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:20:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b10-20020a251b0a000000b0060a7fbb7a64so6133691ybb.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DdZQv1doZLKYKHs3Sz1XKfB4tATz7avSalIIxv9XLzY=;
        b=DEesoxeTzQUQHNtWQiXl06nmGTd7LbJlQJALRjDgCmwAExVNv4Zxh6X/UQYKaEE5zZ
         7PhV3ti8GM3/52z4+OU7pqo8w2Jt64CBSuMkK0RduVg4jQM/9VCXRsgVeFX7jDzeOTD0
         oTrzf/VL+y84wRVuT4eMaFGCKWJt/vqva7N4s7SflExTNSJJa6gmGZdywaa7nmy3qCEc
         g9sC8n4/TuTf1tCgySOkccy567f0AT0gXn2xc5fWvbkJjyX/vzFjVfYPSnb/39gQsSnQ
         iLC/Mb355rYWFvmOnnt7mnAyHMSPNGGpV4jQRZzySHmM554CHZ3An7BV5xPmB8eI10D6
         5i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DdZQv1doZLKYKHs3Sz1XKfB4tATz7avSalIIxv9XLzY=;
        b=Og/2aYUADsVczKTG5Mg+GQ3A6yf7lzi3bULbifYtMnivbBoD/xorEBtHy7MLtQrORN
         AhAR0A5FcDpVtaz7VnHbEHKM3scVQKyk8uRFil/7Dcp29gz6h1hRi5ymx5b+QIcg2NqE
         wah5qoiKua8b6JgHx2NxLQBme0WevR/vCK2pF++omJW3YjhMOTlj2zNMWracw1/luqfR
         UmDRb/DBDic2JUJ+DWi4/aHUDm/smyKWgNv0MA6AkiIHgNlgnCgYJCfoPGDTGH1c/i2V
         naIEVNtHTeB67G8EGglFv9Xkb5bhhcKNWpLKX5CwqNRlA0VEW5ipWnnb3MRtktuqHUj3
         dXOQ==
X-Gm-Message-State: AOAM530KVe7G3WTATr2GNitDM64pb4yhyjarzK5wrgSAuVUsHCltu8Ns
        vYvqs0ZSJhycdKKHMcC1660Rqx5Z
X-Google-Smtp-Source: ABdhPJw15q+XRsuRZYgyKZUfyKjmP2jedsN3meW+MT79Q4lLZzYHxFIEEoR12+DVM9ZenKNXT2I467HV
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:f130:19b6:8678:c9d1])
 (user=brho job=sendgmr) by 2002:a25:260d:: with SMTP id m13mr61028627ybm.29.1641489657787;
 Thu, 06 Jan 2022 09:20:57 -0800 (PST)
Date:   Thu,  6 Jan 2022 12:20:41 -0500
In-Reply-To: <20220106172041.522167-1-brho@google.com>
Message-Id: <20220106172041.522167-4-brho@google.com>
Mime-Version: 1.0
References: <20220106172041.522167-1-brho@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 3/3] prlimit: do not grab the tasklist_lock
From:   Barret Rhoden <brho@google.com>
To:     ebiederm@xmission.com
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unnecessarily grabbing the tasklist_lock can be a scalability bottleneck
for workloads that also must grab the tasklist_lock for waiting,
killing, and cloning.

The tasklist_lock was grabbed to protect tsk->sighand from disappearing
(becoming NULL).  tsk->signal was already protected by holding a
reference to tsk.

update_rlimit_cpu() assumed tsk->sighand != NULL.  With this commit, it
attempts to lock_task_sighand().  However, this means that
update_rlimit_cpu() can fail.  This only happens when a task is exiting.
Note that during exec, sighand may *change*, but it will not be NULL.

Prior to this commit, the do_prlimit() ensured that update_rlimit_cpu()
would not fail by read locking the tasklist_lock and checking tsk->sighand
!= NULL.

If update_rlimit_cpu() fails, there may be other tasks that are not
exiting that share tsk->signal.  However, the group_leader is the last
task to be released, so if we cannot update_rlimit_cpu(group_leader),
then the entire process is exiting.

The only other caller of update_rlimit_cpu() is
selinux_bprm_committing_creds().  It has tsk == current, so
update_rlimit_cpu() cannot fail (current->sighand cannot disappear
until current exits).

This change resulted in a 14% speedup on a microbenchmark where parents
kill and wait on their children, and children getpriority, setpriority,
and getrlimit.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 include/linux/posix-timers.h   |  2 +-
 kernel/sys.c                   | 25 ++++++++++++++-----------
 kernel/time/posix-cpu-timers.c | 12 +++++++++---
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 5bbcd280bfd2..9cf126c3b27f 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -253,7 +253,7 @@ void posix_cpu_timers_exit_group(struct task_struct *task);
 void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 			   u64 *newval, u64 *oldval);
 
-void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
+int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
 void posixtimer_rearm(struct kernel_siginfo *info);
 #endif
diff --git a/kernel/sys.c b/kernel/sys.c
index fb2a5e7c0589..d155b21f4ba1 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1432,13 +1432,7 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 			return -EPERM;
 	}
 
-	/* protect tsk->signal and tsk->sighand from disappearing */
-	read_lock(&tasklist_lock);
-	if (!tsk->sighand) {
-		retval = -ESRCH;
-		goto out;
-	}
-
+	/* Holding a refcount on tsk protects tsk->signal from disappearing. */
 	rlim = tsk->signal->rlim + resource;
 	task_lock(tsk->group_leader);
 	if (new_rlim) {
@@ -1467,10 +1461,19 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	 */
 	if (!retval && new_rlim && resource == RLIMIT_CPU &&
 	    new_rlim->rlim_cur != RLIM_INFINITY &&
-	    IS_ENABLED(CONFIG_POSIX_TIMERS))
-		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
-out:
-	read_unlock(&tasklist_lock);
+	    IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		/*
+		 * update_rlimit_cpu can fail if the task is exiting, but there
+		 * may be other tasks in the thread group that are not exiting,
+		 * and they need their cpu timers adjusted.
+		 *
+		 * The group_leader is the last task to be released, so if we
+		 * cannot update_rlimit_cpu on it, then the entire process is
+		 * exiting and we do not need to update at all.
+		 */
+		update_rlimit_cpu(tsk->group_leader, new_rlim->rlim_cur);
+	}
+
 	return retval;
 }
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 96b4e7810426..e13e628509fb 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -34,14 +34,20 @@ void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
  * tsk->signal->posix_cputimers.bases[clock].nextevt expiration cache if
  * necessary. Needs siglock protection since other code may update the
  * expiration cache as well.
+ *
+ * Returns 0 on success, -ESRCH on failure.  Can fail if the task is exiting and
+ * we cannot lock_task_sighand.  Cannot fail if task is current.
  */
-void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
+int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 {
 	u64 nsecs = rlim_new * NSEC_PER_SEC;
+	unsigned long irq_fl;
 
-	spin_lock_irq(&task->sighand->siglock);
+	if (!lock_task_sighand(task, &irq_fl))
+		return -ESRCH;
 	set_process_cpu_timer(task, CPUCLOCK_PROF, &nsecs, NULL);
-	spin_unlock_irq(&task->sighand->siglock);
+	unlock_task_sighand(task, &irq_fl);
+	return 0;
 }
 
 /*
-- 
2.34.1.448.ga2b2bfdf31-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C5485AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiAEVbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiAEVbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5824C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:31:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so1136148ybf.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e02bjD6pRKTWNu3KvN2MtMLMNFzM1qFsgH72gSuIkl4=;
        b=g2LCcjXXaW7gzE4dCTvUSuTgcCA53czMalkKvkChm6TBE4b+r6X9NJWmpuA55yNesS
         QrMBzdp784HO2SshmhwbZdZGW6EgWwGp5fI/LWT4ApiqTkr3s0zsnAW2pWGbzZRTxvWS
         6Sgn3DMaxdU5px2s/SRPeNQY+7VUv0dH0HwMGjjTllzTT+junL1sGuyc0y0JtCiJ4YXE
         j10KhriKENIYwbu232IvSkly2qnCdPU4qe+SCzEBV61mbmgGWyiyK/gPGEzsbCwpHgHQ
         Ew8E4W226r7Uz8JI4dJTzvli2WIgmmoQjUHxBcO9xenxIS9WZDH1qbsr7weCSUYjAUy+
         DBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e02bjD6pRKTWNu3KvN2MtMLMNFzM1qFsgH72gSuIkl4=;
        b=XZm4JElAIpxM7y6lGZzkl4K0Fp6H+AChKERUTkgzfavxzaUCJs/YdS6jSy4BiD74Bt
         56lpXxuvXFsbgIADrqjRPt3emqDv7dyUja3M1r1u0affuqY4ccjG9xIs3xWXBityUsRc
         SLsPciAtQZ+d2rNNhfvjwyZnLk59yJQD16u/kb//aNRl44sBSGarIzgoNQji+u8RvwiB
         8LzbeUixScioBq/YbjA/3+QM/a8K+SduCaw9swOpM0ioPfJiFKtn//AaAK2bia3J+OHj
         R3LWfzHECUQVaAQTkY8v0TEXcM6obrnSFBdnKcwHYG8ttnIZPIv+0N2ncKjahFeLGhhV
         W2cw==
X-Gm-Message-State: AOAM533AEwCM66VkJ95sd7iX3ZBt4sw4VvspdLamCN1u2NDwRvgL12rj
        0w2kPoCNpCZpwExej8qSreI7LFUB
X-Google-Smtp-Source: ABdhPJwvIDThxVqCBdibl4805Y+ll3+2PEgxcX3feRUyW/5ke6vBMekJwngIcIi2u5eLiWbbIU/tNQLj
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:3ab7:a23:e07a:5e22])
 (user=brho job=sendgmr) by 2002:a25:bfc6:: with SMTP id q6mr64374645ybm.709.1641418292040;
 Wed, 05 Jan 2022 13:31:32 -0800 (PST)
Date:   Wed,  5 Jan 2022 16:28:28 -0500
In-Reply-To: <20220105212828.197013-1-brho@google.com>
Message-Id: <20220105212828.197013-4-brho@google.com>
Mime-Version: 1.0
References: <20220105212828.197013-1-brho@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 3/3] prlimit: do not grab the tasklist_lock
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
exiting that share tsk->signal.  We need to run update_rlimit_cpu() on
one of them.   We can't "back out" the new rlim - once we unlocked
task_lock(group_leader), the rlim is essentially changed.

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
 kernel/sys.c                   | 32 +++++++++++++++++++++-----------
 kernel/time/posix-cpu-timers.c | 12 +++++++++---
 3 files changed, 31 insertions(+), 15 deletions(-)

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
index fb2a5e7c0589..073ae9db192f 100644
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
@@ -1467,10 +1461,26 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	 */
 	if (!retval && new_rlim && resource == RLIMIT_CPU &&
 	    new_rlim->rlim_cur != RLIM_INFINITY &&
-	    IS_ENABLED(CONFIG_POSIX_TIMERS))
-		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
-out:
-	read_unlock(&tasklist_lock);
+	    IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		if (update_rlimit_cpu(tsk, new_rlim->rlim_cur)) {
+			/*
+			 * update_rlimit_cpu can fail if the task is exiting.
+			 * We already set the task group's rlim, so we need to
+			 * update_rlimit_cpu for some other task in the process.
+			 * If all of the tasks are exiting, then we don't need
+			 * to update_rlimit_cpu.
+			 */
+			struct task_struct *t_i;
+
+			rcu_read_lock();
+			for_each_thread(tsk, t_i) {
+				if (!update_rlimit_cpu(t_i, new_rlim->rlim_cur))
+					break;
+			}
+			rcu_read_unlock();
+		}
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


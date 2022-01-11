Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3890348A5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiAKCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKCvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:51:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA6C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:51:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u206-20020a2547d7000000b00610eabc1412so12599896yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sqwEbNAc9YljxV7DtdFATcDG8H4a0yU+jrTy6B3ifeY=;
        b=Jfon2RIZKv2eMVH0HJQZEwFjQMVasrR6gGV6RJIwJhGh5iiyu0yv3TKB/c6zNNLrzx
         WOdH86OLoShbnMiPE1yzhENOvsNTPY8ITJBFcFIifg5k7h9oOHNuUlaQtLhevp2YYIOu
         H2EaO3fi7LEz8/62gI5e2GPL6Y1pg9R4Quy4nO3jakMVco4XlRzFUldv0KOp1CQDFzSD
         JgLm3iztGkGs73GVk0aOEsneiRZ5iJMGiZJ/r+55XYwqN0HMPVcKm/R+8MDI3NLtzyAP
         DgDn1hN5iNgMgmqMa0jl3oo8rTJKwVguKQVZTj7AwSEvc5agjRR5dZE9kmSoHV6fFA1A
         WsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sqwEbNAc9YljxV7DtdFATcDG8H4a0yU+jrTy6B3ifeY=;
        b=3tZbPFk1aB/FE0BP9xg1cU6Eul8zIHAZARgy6ZA0MMhDbYb3J0zwKYmc2tX35Bxmgn
         9u1t2JP4h7eo+zs+/4xMezCGXgm3NpQGT9Dd7ugRxYuAU03H8knhaH6ESWbnHis4TL60
         OZuOBQ8VvvoCdzQXayFksvWzqzCG41p0Q11eBoihNvur7BMpczg5EplNqybPT3MMXe7A
         Bn32MPBBWGynreyvu2FmStIcCsiMhPppn5rkaaFetEhPghHvgbSQ+eUeKVpmnliKAFPx
         KA3hJE1cqffuY0AKPjtZkIb16LXUvwJcu+iIWsHbSV6gTfpn9B3Hfe1eG1fmkeDSotCj
         VbJQ==
X-Gm-Message-State: AOAM531fsmO6Z4Ksq5cQ7od8cAwul8PdZYQTrbRXWWFzkBtP09SSnYzC
        ani7Mwapw7pyMACoBIyXdd1tc7f+1rc=
X-Google-Smtp-Source: ABdhPJxxfZ9pBMfCBW9849vm//S7g29Iyl+WUhMN/cMlXWPdMNFIjYUsnDi9+IoXDa/BphjkNsog95n1P0M=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9b5c:3864:3d9f:19c4])
 (user=surenb job=sendgmr) by 2002:a25:860e:: with SMTP id y14mr3693094ybk.307.1641869504998;
 Mon, 10 Jan 2022 18:51:44 -0800 (PST)
Date:   Mon, 10 Jan 2022 18:51:38 -0800
Message-Id: <20220111025138.1071848-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 1/1] psi: Fix uaf issue when psi trigger is destroyed while
 being polled
From:   Suren Baghdasaryan <surenb@google.com>
To:     hannes@cmpxchg.org
Cc:     torvalds@linux-foundation.org, ebiggers@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com,
        surenb@google.com,
        syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With write operation on psi files replacing old trigger with a new one,
the lifetime of its waitqueue is totally arbitrary. Overwriting an
existing trigger causes its waitqueue to be freed and pending poll()
will stumble on trigger->event_wait which was destroyed.
Fix this by disallowing to redefine an existing psi trigger. If a write
operation is used on a file descriptor with an already existing psi
trigger, the operation will fail with EBUSY error.
Also bypass a check for psi_disabled in the psi_trigger_destroy as the
flag can be flipped after the trigger is created, leading to a memory
leak.

Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
Analyzed-by: Eric Biggers <ebiggers@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/accounting/psi.rst |  3 +-
 include/linux/psi.h              |  2 +-
 include/linux/psi_types.h        |  3 --
 kernel/cgroup/cgroup.c           | 11 ++++--
 kernel/sched/psi.c               | 68 +++++++++++++++-----------------
 5 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index f2b3439edcc2..860fe651d645 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -92,7 +92,8 @@ Triggers can be set on more than one psi metric and more than one trigger
 for the same psi metric can be specified. However for each trigger a separate
 file descriptor is required to be able to poll it separately from others,
 therefore for each trigger a separate open() syscall should be made even
-when opening the same psi interface file.
+when opening the same psi interface file. Write operations to a file descriptor
+with an already existing psi trigger will fail with EBUSY.
 
 Monitors activate only when system enters stall state for the monitored
 psi metric and deactivates upon exit from the stall state. While system is
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb1476ac70..370707902345 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -32,7 +32,7 @@ void cgroup_move_task(struct task_struct *p, struct css_set *to);
 
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			char *buf, size_t nbytes, enum psi_res res);
-void psi_trigger_replace(void **trigger_ptr, struct psi_trigger *t);
+void psi_trigger_destroy(void **trigger_ptr);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 			poll_table *wait);
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300d49af..6537d0c92825 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -129,9 +129,6 @@ struct psi_trigger {
 	 * events to one per window
 	 */
 	u64 last_event_time;
-
-	/* Refcounting to prevent premature destruction */
-	struct kref refcount;
 };
 
 struct psi_group {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index cafb8c114a21..e6878238fb19 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3642,6 +3642,12 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 	cgroup_get(cgrp);
 	cgroup_kn_unlock(of->kn);
 
+	/* Allow only one trigger per file descriptor */
+	if (READ_ONCE(ctx->psi.trigger)) {
+		cgroup_put(cgrp);
+		return -EBUSY;
+	}
+
 	psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 	new = psi_trigger_create(psi, buf, nbytes, res);
 	if (IS_ERR(new)) {
@@ -3649,8 +3655,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 		return PTR_ERR(new);
 	}
 
-	psi_trigger_replace(&ctx->psi.trigger, new);
-
+	WRITE_ONCE(ctx->psi.trigger, new);
 	cgroup_put(cgrp);
 
 	return nbytes;
@@ -3689,7 +3694,7 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
 
-	psi_trigger_replace(&ctx->psi.trigger, NULL);
+	psi_trigger_destroy(&ctx->psi.trigger);
 }
 
 bool cgroup_psi_enabled(void)
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2bb54b7..882bf62cc247 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1151,7 +1151,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->event = 0;
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
-	kref_init(&t->refcount);
 
 	mutex_lock(&group->trigger_lock);
 
@@ -1180,15 +1179,21 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	return t;
 }
 
-static void psi_trigger_destroy(struct kref *ref)
+void psi_trigger_destroy(void **trigger_ptr)
 {
-	struct psi_trigger *t = container_of(ref, struct psi_trigger, refcount);
-	struct psi_group *group = t->group;
+	struct psi_trigger *t;
+	struct psi_group *group;
 	struct task_struct *task_to_destroy = NULL;
 
-	if (static_branch_likely(&psi_disabled))
+	/*
+	 * We do not check psi_disabled since it might have been disabled after
+	 * the trigger got created.
+	 */
+	t = xchg(trigger_ptr, NULL);
+	if (!t)
 		return;
 
+	group = t->group;
 	/*
 	 * Wakeup waiters to stop polling. Can happen if cgroup is deleted
 	 * from under a polling process.
@@ -1224,9 +1229,9 @@ static void psi_trigger_destroy(struct kref *ref)
 	mutex_unlock(&group->trigger_lock);
 
 	/*
-	 * Wait for both *trigger_ptr from psi_trigger_replace and
-	 * poll_task RCUs to complete their read-side critical sections
-	 * before destroying the trigger and optionally the poll_task
+	 * Wait for psi_schedule_poll_work RCU to complete its read-side
+	 * critical section before destroying the trigger and optionally the
+	 * poll_task.
 	 */
 	synchronize_rcu();
 	/*
@@ -1243,18 +1248,6 @@ static void psi_trigger_destroy(struct kref *ref)
 	kfree(t);
 }
 
-void psi_trigger_replace(void **trigger_ptr, struct psi_trigger *new)
-{
-	struct psi_trigger *old = *trigger_ptr;
-
-	if (static_branch_likely(&psi_disabled))
-		return;
-
-	rcu_assign_pointer(*trigger_ptr, new);
-	if (old)
-		kref_put(&old->refcount, psi_trigger_destroy);
-}
-
 __poll_t psi_trigger_poll(void **trigger_ptr,
 				struct file *file, poll_table *wait)
 {
@@ -1264,24 +1257,15 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (static_branch_likely(&psi_disabled))
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
-	rcu_read_lock();
-
-	t = rcu_dereference(*(void __rcu __force **)trigger_ptr);
-	if (!t) {
-		rcu_read_unlock();
+	t = READ_ONCE(*trigger_ptr);
+	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
-	}
-	kref_get(&t->refcount);
-
-	rcu_read_unlock();
 
 	poll_wait(file, &t->event_wait, wait);
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
 
-	kref_put(&t->refcount, psi_trigger_destroy);
-
 	return ret;
 }
 
@@ -1305,14 +1289,24 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 
 	buf[buf_size - 1] = '\0';
 
-	new = psi_trigger_create(&psi_system, buf, nbytes, res);
-	if (IS_ERR(new))
-		return PTR_ERR(new);
-
 	seq = file->private_data;
+
 	/* Take seq->lock to protect seq->private from concurrent writes */
 	mutex_lock(&seq->lock);
-	psi_trigger_replace(&seq->private, new);
+
+	/* Allow only one trigger per file descriptor */
+	if (READ_ONCE(seq->private)) {
+		mutex_unlock(&seq->lock);
+		return -EBUSY;
+	}
+
+	new = psi_trigger_create(&psi_system, buf, nbytes, res);
+	if (IS_ERR(new)) {
+		mutex_unlock(&seq->lock);
+		return PTR_ERR(new);
+	}
+
+	WRITE_ONCE(seq->private, new);
 	mutex_unlock(&seq->lock);
 
 	return nbytes;
@@ -1347,7 +1341,7 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
 
-	psi_trigger_replace(&seq->private, NULL);
+	psi_trigger_destroy(&seq->private);
 	return single_release(inode, file);
 }
 
-- 
2.34.1.575.g55b058a8bb-goog


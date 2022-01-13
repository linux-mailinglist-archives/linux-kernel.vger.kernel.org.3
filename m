Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A348E10F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiAMXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiAMXkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:40:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87316C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 2-20020a251302000000b006118f867dadso14841961ybt.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YdkUhGD3Iw8REOsXxzkZNQvRpBA0TpGdto6DpzxEJRg=;
        b=ORGfGaPEFsUSNA0jZJilt9MO5ZkL0WdXS1qQdDMZyRFpxcaJLOwoB+DYnMu2MD2jRp
         uIMLWn80XBvk5DhFNo1JzkEwq9sLDvSYxSnl6QyJgAfO81eWtMamzfTCBD6yxOMUjwNA
         U38HIm2ZMNLaUn99dFFMaiKQg+OhiNmcKlHs11QVVfv5oikYdoLeih2dGj834SxO79Pn
         32JTberZyPXDarVU3BpbRI8v6f1A4ypNLZQWCtEB5qk23bHaYdIFp62EoYNuRvAvP5vQ
         6Au5qLAGNUJzqhUxo3loWqdwVWExFXv/xRxN28MNY81dAVX0Lb+L6xhTtCIBOezgbRPz
         utIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YdkUhGD3Iw8REOsXxzkZNQvRpBA0TpGdto6DpzxEJRg=;
        b=uSOdPygqDAtxuKcR+yXDN8JMbhRMs+GG3L7Uftz56bHxVNEFPWhFP7f1VThzyOqYdP
         bnZRAwunPL8NrapqqEba3ndu7LLiCOTFG0xiOgayAcfLQYirH7CoVQpQ+7ZKiIHckLPb
         mldbp49wtMRKT+X4FFby2mVc2vdk+EsqAcPJWCjI+vxs3qXYLorQAuiPaa0UtGf8PfC+
         TowWOtweC6yu5ni3Ae1bcrwRT1Yin7OWF9LYgi3UYNTDibpmxWYZff+o2cIK4QOEFzxx
         /v5zu/gz8xeLNE5sahFc/xR/hBAUzcq/pI4bUC1/eLFYrr9XbyXbqIV9v6RIb/DtF1CZ
         yCPg==
X-Gm-Message-State: AOAM533P75TLY0n9GYGg4zqFu9fm8yqYdViXqo2LvdWzqQYUVOa5F3vX
        4AFCDG+EapPYwdUh+Zb2AaYfuL4v
X-Google-Smtp-Source: ABdhPJwCLoMbHJSrjZMXL0ZEp89iLsIjFRdgS8B2JuN0BJhbUCJOe3cmeUEwht7rvQGqGaxkCnPhOXJz
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:c548:e79f:8954:121f])
 (user=posk job=sendgmr) by 2002:a05:6902:8f:: with SMTP id
 h15mr8334544ybs.95.1642117211781; Thu, 13 Jan 2022 15:40:11 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:39:39 -0800
In-Reply-To: <20220113233940.3608440-1-posk@google.com>
Message-Id: <20220113233940.3608440-5-posk@google.com>
Mime-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC PATCH v2 4/5] sched: UMCG: add a blocked worker list
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original idea of a UMCG server was that it was used as a proxy
for a CPU, so if a worker associated with the server is RUNNING,
the server itself is never ever was allowed to be RUNNING as well;
when umcg_wait() returned for a server, it meant that its worker
became BLOCKED.

In the new (old?) "per server runqueues" model implemented in
the previous patch in this patchset, servers are woken when
a previously blocked worker on their runqueue finishes its blocking
operation, even if the currently RUNNING worker continues running.

As now a server may run while a worker assigned to it is running,
the original idea of having at most a single worker RUNNING per
server, as a means to control the number of running workers, is
not really enforced, and the server, woken by a worker
doing BLOCKED=>RUNNABLE transition, may then call sys_umcg_wait()
with a second/third/etc. worker to run.

Support this scenario by adding a blocked worker list:
when a worker transitions RUNNING=>BLOCKED, not only its server
is woken, but the worker is also added to the blocked worker list
of its server.

This change introduces the following benefits:
- block detection how behaves similarly to wake detection;
  without this patch worker wakeups added wakees to the list
  and woke the server, while worker blocks only woke the server
  without adding blocked workers to a list, forcing servers
  to explicitly check worker's state;
- if the blocked worker woke sufficiently quickly, the server
  woken on the block event would observe its worker now as
  RUNNABLE, so the block event had to be inferred rather than
  explicitly signalled by the worker being added to the blocked
  worker list;
- it is now possible for a single server to control several
  RUNNING workers, which makes writing userspace schedulers
  simpler for smaller processes that do not need to scale beyond
  one "server";
- if the userspace wants to keep at most a single RUNNING worker
  per server, and have multiple servers with their own runqueues,
  this model is also naturally supported here.

So this change basically decouples block/wake detection from
M:N threading in the sense that the number of servers is now
does not have to be M or N, but is more driven by the scalability
needs of the userspace application.

Why keep this server/worker model at all then, and not use
something like io_uring to deliver block/wake events to the
userspace? The main benefit of this model is that servers
are woken synchronously on-cpu when an event happens, while
io_uring is more of an asynchronous event framework, so latencies
in this model are potentially better.

In addition, "multiple runqueues" type of scheduling is much easier
to implement with this method than with io_uring.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/uapi/linux/umcg.h | 10 ++++-
 kernel/sched/umcg.c       | 90 ++++++++++++++++++++++++++++-----------
 2 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
index a994bbb062d5..93fccb44283b 100644
--- a/include/uapi/linux/umcg.h
+++ b/include/uapi/linux/umcg.h
@@ -116,6 +116,14 @@ struct umcg_task {
 	__u64	blocked_ts;			/*   w */
 	__u64   runnable_ts;			/*   w */
 
+	/**
+	 * @blocked_workers_ptr: a single-linked list of blocked workers.
+	 *
+	 * Readable/writable by both the kernel and the userspace: the
+	 * kernel adds items to the list, userspace removes them.
+	 */
+	__u64	blocked_workers_ptr;		/* r/w */
+
 	/**
 	 * @runnable_workers_ptr: a single-linked list of runnable workers.
 	 *
@@ -124,7 +132,7 @@ struct umcg_task {
 	 */
 	__u64	runnable_workers_ptr;		/* r/w */
 
-	__u64	__zero[3];
+	__u64	__zero[2];
 
 } __attribute__((packed, aligned(UMCG_TASK_ALIGN)));
 
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
index 9a8755045285..b85dec6b82e4 100644
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -343,6 +343,67 @@ static int umcg_wake(struct task_struct *tsk)
 	return umcg_wake_server(tsk);
 }
 
+/*
+ * Enqueue @tsk on it's server's blocked or runnable list
+ *
+ * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
+ *
+ * cmpxchg based single linked list add such that list integrity is never
+ * violated.  Userspace *MUST* remove it from the list before changing ->state.
+ * As such, we must change state to BLOCKED or RUNNABLE before enqueue.
+ *
+ * Returns:
+ *   0: success
+ *   -EFAULT
+ */
+static int umcg_enqueue_worker(struct task_struct *tsk, bool blocked)
+{
+	struct umcg_task __user *server = tsk->umcg_server_task;
+	struct umcg_task __user *self = tsk->umcg_task;
+	u64 self_ptr = (unsigned long)self;
+	u64 first_ptr;
+
+	/*
+	 * umcg_pin_pages() did access_ok() on both pointers, use self here
+	 * only because __user_access_begin() isn't available in generic code.
+	 */
+	if (!user_access_begin(self, sizeof(*self)))
+		return -EFAULT;
+
+	unsafe_get_user(first_ptr, blocked ? &server->blocked_workers_ptr :
+			&server->runnable_workers_ptr, Efault);
+	do {
+		unsafe_put_user(first_ptr, blocked ? &self->blocked_workers_ptr :
+				&self->runnable_workers_ptr, Efault);
+	} while (!unsafe_try_cmpxchg_user(blocked ? &server->blocked_workers_ptr :
+				&server->runnable_workers_ptr, &first_ptr, self_ptr, Efault));
+
+	user_access_end();
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/*
+ * Enqueue @tsk on it's server's blocked list
+ *
+ * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
+ *
+ * cmpxchg based single linked list add such that list integrity is never
+ * violated.  Userspace *MUST* remove it from the list before changing ->state.
+ * As such, we must change state to BLOCKED before enqueue.
+ *
+ * Returns:
+ *   0: success
+ *   -EFAULT
+ */
+static int umcg_enqueue_blocked(struct task_struct *tsk)
+{
+	return umcg_enqueue_worker(tsk, true /* blocked */);
+}
+
 /* pre-schedule() */
 void umcg_wq_worker_sleeping(struct task_struct *tsk)
 {
@@ -357,6 +418,9 @@ void umcg_wq_worker_sleeping(struct task_struct *tsk)
 	if (umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED))
 		UMCG_DIE_PF("state");
 
+	if (umcg_enqueue_blocked(tsk))
+		UMCG_DIE_PF("enqueue");
+
 	if (umcg_wake(tsk))
 		UMCG_DIE_PF("wake");
 
@@ -390,29 +454,7 @@ void umcg_wq_worker_running(struct task_struct *tsk)
  */
 static int umcg_enqueue_runnable(struct task_struct *tsk)
 {
-	struct umcg_task __user *server = tsk->umcg_server_task;
-	struct umcg_task __user *self = tsk->umcg_task;
-	u64 self_ptr = (unsigned long)self;
-	u64 first_ptr;
-
-	/*
-	 * umcg_pin_pages() did access_ok() on both pointers, use self here
-	 * only because __user_access_begin() isn't available in generic code.
-	 */
-	if (!user_access_begin(self, sizeof(*self)))
-		return -EFAULT;
-
-	unsafe_get_user(first_ptr, &server->runnable_workers_ptr, Efault);
-	do {
-		unsafe_put_user(first_ptr, &self->runnable_workers_ptr, Efault);
-	} while (!unsafe_try_cmpxchg_user(&server->runnable_workers_ptr, &first_ptr, self_ptr, Efault));
-
-	user_access_end();
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
+	return umcg_enqueue_worker(tsk, false /* !blocked */);
 }
 
 /*
@@ -821,7 +863,7 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, struct umcg_task __user *, self, clockid_t
 	if (copy_from_user(&ut, self, sizeof(ut)))
 		return -EFAULT;
 
-	if (ut.next_tid || ut.__hole[0] || ut.__zero[0] || ut.__zero[1] || ut.__zero[2])
+	if (ut.next_tid || ut.__hole[0] || ut.__zero[0] || ut.__zero[1])
 		return -EINVAL;
 
 	rcu_read_lock();
-- 
2.34.1.703.g22d0c6ccf7-goog


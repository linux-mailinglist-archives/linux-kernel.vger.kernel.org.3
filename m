Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AAD478E62
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhLQOsj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 09:48:39 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:24736 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhLQOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:48:38 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-JQaji_b5MMaSeEWf3zYr9w-1; Fri, 17 Dec 2021 09:48:32 -0500
X-MC-Unique: JQaji_b5MMaSeEWf3zYr9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48468DD87E;
        Fri, 17 Dec 2021 14:48:29 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAC731037F5B;
        Fri, 17 Dec 2021 14:48:27 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     0day robot <lkp@intel.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, lkp@lists.01.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3] ucounts: Split rlimit and ucount values and max values
Date:   Fri, 17 Dec 2021 15:48:23 +0100
Message-Id: <73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org>
In-Reply-To: <87tufc1p2i.fsf@email.froward.int.ebiederm.org>
References: <87tufc1p2i.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=legion@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the semantics of maximum rlimit values are different, it would be
better not to mix ucount and rlimit values. This will prevent the error
of using inc_count/dec_ucount for rlimit parameters.

This patch also renames the functions to emphasize the lack of
connection between rlimit and ucount.

v2:
- Fix the array-index-out-of-bounds that was found by the lkp project.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/exec.c                      |  2 +-
 fs/proc/array.c                |  2 +-
 include/linux/user_namespace.h | 35 +++++++++++++++++++++-------------
 kernel/fork.c                  | 12 ++++++------
 kernel/sys.c                   |  2 +-
 kernel/ucount.c                | 24 ++++++++++-------------
 kernel/user_namespace.c        | 10 +++++-----
 7 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 537d92c41105..d3f769837058 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1877,7 +1877,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * whether NPROC limit is still exceeded.
 	 */
 	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	    is_rlimit_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		retval = -EAGAIN;
 		goto out_ret;
 	}
diff --git a/fs/proc/array.c b/fs/proc/array.c
index ff869a66b34e..d3fa539c755e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -274,7 +274,7 @@ static inline void task_sig(struct seq_file *m, struct task_struct *p)
 		collect_sigign_sigcatch(p, &ignored, &caught);
 		num_threads = get_nr_threads(p);
 		rcu_read_lock();  /* FIXME: is this correct? */
-		qsize = get_ucounts_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
+		qsize = get_rlimit_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
 		rcu_read_unlock();
 		qlim = task_rlimit(p, RLIMIT_SIGPENDING);
 		unlock_task_sighand(p, &flags);
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..45f09bec02c4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -54,15 +54,17 @@ enum ucount_type {
 	UCOUNT_FANOTIFY_GROUPS,
 	UCOUNT_FANOTIFY_MARKS,
 #endif
+	UCOUNT_COUNTS,
+};
+
+enum rlimit_type {
 	UCOUNT_RLIMIT_NPROC,
 	UCOUNT_RLIMIT_MSGQUEUE,
 	UCOUNT_RLIMIT_SIGPENDING,
 	UCOUNT_RLIMIT_MEMLOCK,
-	UCOUNT_COUNTS,
+	UCOUNT_RLIMIT_COUNTS,
 };
 
-#define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
-
 struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
@@ -99,6 +101,7 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+	long rlimit_max[UCOUNT_RLIMIT_COUNTS];
 } __randomize_layout;
 
 struct ucounts {
@@ -107,6 +110,7 @@ struct ucounts {
 	kuid_t uid;
 	atomic_t count;
 	atomic_long_t ucount[UCOUNT_COUNTS];
+	atomic_long_t rlimit[UCOUNT_RLIMIT_COUNTS];
 };
 
 extern struct user_namespace init_user_ns;
@@ -120,21 +124,26 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
 struct ucounts * __must_check get_ucounts(struct ucounts *ucounts);
 void put_ucounts(struct ucounts *ucounts);
 
-static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type type)
+static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type type)
 {
-	return atomic_long_read(&ucounts->ucount[type]);
+	return atomic_long_read(&ucounts->rlimit[type]);
 }
 
-long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
-bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
-void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
+long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
+bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
+void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
+bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
+
+static inline long get_userns_rlimit_max(struct user_namespace *ns, enum rlimit_type type)
+{
+	return READ_ONCE(ns->rlimit_max[type]);
+}
 
-static inline void set_rlimit_ucount_max(struct user_namespace *ns,
-		enum ucount_type type, unsigned long max)
+static inline void set_userns_rlimit_max(struct user_namespace *ns,
+		enum rlimit_type type, unsigned long max)
 {
-	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
+	ns->rlimit_max[type] = max <= LONG_MAX ? max : LONG_MAX;
 }
 
 #ifdef CONFIG_USER_NS
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..fb68d56bcd7e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -836,13 +836,13 @@ void __init fork_init(void)
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
+	for (i = 0; i < UCOUNT_COUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
@@ -2053,7 +2053,7 @@ static __latent_entropy struct task_struct *copy_process(
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
 	retval = -EAGAIN;
-	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_free;
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..2c86d245acd6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -479,7 +479,7 @@ static int set_user(struct cred *new)
 	 * for programs doing set*uid()+execve() by harmlessly deferring the
 	 * failure to the execve() stage.
 	 */
-	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
+	if (is_rlimit_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
 			new_user != INIT_USER &&
 			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 		current->flags |= PF_NPROC_EXCEEDED;
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 7b32c356ebc5..22070f004e97 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -87,10 +87,6 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_fanotify_groups"),
 	UCOUNT_ENTRY("max_fanotify_marks"),
 #endif
-	{ },
-	{ },
-	{ },
-	{ },
 	{ }
 };
 #endif /* CONFIG_SYSCTL */
@@ -261,7 +257,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 	put_ucounts(ucounts);
 }
 
-long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
+long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 {
 	struct ucounts *iter;
 	long max = LONG_MAX;
@@ -273,12 +269,12 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return ret;
 }
 
-bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
+bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 {
 	struct ucounts *iter;
 	long new = -1; /* Silence compiler warning */
@@ -292,7 +288,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 }
 
 static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
-				struct ucounts *last, enum ucount_type type)
+				struct ucounts *last, enum rlimit_type type)
 {
 	struct ucounts *iter, *next;
 	for (iter = ucounts; iter != last; iter = next) {
@@ -304,12 +300,12 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
 	}
 }
 
-void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type)
+void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 {
 	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
 }
 
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
@@ -322,7 +318,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
@@ -341,16 +337,16 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	return 0;
 }
 
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
+bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long rlimit)
 {
 	struct ucounts *iter;
 	long max = rlimit;
 	if (rlimit > LONG_MAX)
 		max = LONG_MAX;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		if (get_ucounts_value(iter, type) > max)
+		if (get_rlimit_value(iter, type) > max)
 			return true;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return false;
 }
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..b9f6729b4e5f 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -119,13 +119,13 @@ int create_user_ns(struct cred *new)
 	ns->owner = owner;
 	ns->group = group;
 	INIT_WORK(&ns->work, free_user_ns);
-	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
+	for (i = 0; i < UCOUNT_COUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
-- 
2.33.0


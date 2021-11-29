Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C93462252
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhK2Unq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 15:43:46 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50549 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233817AbhK2Ulq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:41:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-Ra-yvdlmPje_XcZzTDOEeA-1; Mon, 29 Nov 2021 15:38:24 -0500
X-MC-Unique: Ra-yvdlmPje_XcZzTDOEeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE8E683DD20;
        Mon, 29 Nov 2021 20:38:22 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27AD310013D6;
        Mon, 29 Nov 2021 20:38:20 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     0day robot <lkp@intel.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, lkp@lists.01.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 2/2] ucounts: Move rlimit max values from ucounts max
Date:   Mon, 29 Nov 2021 21:37:26 +0100
Message-Id: <24c87e225c7950bf2ea1ff4b4a8f237348808241.1638218242.git.legion@kernel.org>
In-Reply-To: <cover.1638218242.git.legion@kernel.org>
References: <cover.1638218242.git.legion@kernel.org>
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

Since the semantics of maximum rlimit values are different, they need to
be separated from ucount_max. This will prevent the error of using
inc_count/dec_ucount for rlimit parameters.

This patch also renames the functions to emphasize the lack of
connection between rlimit_max and ucount_max.

v2:
- Fix the array-index-out-of-bounds that was found by the lkp project.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/user_namespace.h | 17 ++++++++++++-----
 kernel/fork.c                  | 10 +++++-----
 kernel/ucount.c                | 10 +++-------
 kernel/user_namespace.c        | 10 +++++-----
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..812b6935f4a3 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -58,10 +58,11 @@ enum ucount_type {
 	UCOUNT_RLIMIT_MSGQUEUE,
 	UCOUNT_RLIMIT_SIGPENDING,
 	UCOUNT_RLIMIT_MEMLOCK,
-	UCOUNT_COUNTS,
+	UCOUNT_ALL_COUNTS,
 };
 
-#define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
+#define UCOUNT_COUNTS UCOUNT_RLIMIT_NPROC
+#define RLIMIT_COUNTS UCOUNT_ALL_COUNTS - UCOUNT_COUNTS + 1
 
 struct user_namespace {
 	struct uid_gid_map	uid_map;
@@ -99,6 +100,7 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+	long rlimit_max[RLIMIT_COUNTS];
 } __randomize_layout;
 
 struct ucounts {
@@ -106,7 +108,7 @@ struct ucounts {
 	struct user_namespace *ns;
 	kuid_t uid;
 	atomic_t count;
-	atomic_long_t ucount[UCOUNT_COUNTS];
+	atomic_long_t ucount[UCOUNT_ALL_COUNTS];
 };
 
 extern struct user_namespace init_user_ns;
@@ -131,10 +133,15 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
 void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
 bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
 
-static inline void set_rlimit_ucount_max(struct user_namespace *ns,
+static inline long get_userns_rlimit_max(struct user_namespace *ns, enum ucount_type type)
+{
+	return READ_ONCE(ns->rlimit_max[type - UCOUNT_COUNTS]);
+}
+
+static inline void set_userns_rlimit_max(struct user_namespace *ns,
 		enum ucount_type type, unsigned long max)
 {
-	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
+	ns->rlimit_max[type - UCOUNT_COUNTS] = max <= LONG_MAX ? max : LONG_MAX;
 }
 
 #ifdef CONFIG_USER_NS
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..365819458030 100644
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
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 7b32c356ebc5..ffffcfae8474 100644
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
@@ -273,7 +269,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return ret;
 }
@@ -322,7 +318,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
@@ -350,7 +346,7 @@ bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsign
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
 		if (get_ucounts_value(iter, type) > max)
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


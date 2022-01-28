Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7922649FA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbiA1NUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348763AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=OOok3oAXLMDgG2pHbvztom5rL8XJmkTzwxFo3hW65dY=;
 b=apOsMK7sYOiHe+UmWef7PYiCm3i1aOipU8SikDOdqQIVQ92th1dViE6N0eom1nHudhL5n
 4/szWqoaviTOG4LCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=OOok3oAXLMDgG2pHbvztom5rL8XJmkTzwxFo3hW65dY=;
 b=7jHZVpmUHaV2hihoS/xDYZ7lIHZFiNosHjwrjMvHdF49E3nYRWUd6B0f1WZbzTOTJ3DbR
 KdoA+Tk76uCvQdhq/sopUjEvWhuCJjuvJQc8/G1yZ/OyLY6M4cq0fNS3bDS0MU2I06fz25j
 YiRmitgizvCq5ZyOFmdCiJVrVCui+9lSU2DRXUyV0dSwntrbLtIIY9VqGev1BV8uIRUsKsJ
 PXqDwUkAU6QwETRspdM3sJvxgXFDgnHHdQOdh4r2QQb2pZGwRMwbdT0yCFjPQ6WywdVwJoL
 kwdzpN8FW1tj5a9YAAtuAb61eSHPIKy+MDAGv2lLbceDf265pbntCbCh2Hrw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 25423160AAA;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 093D420472; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 22/35] percpu-rwsem: enable percpu_sem destruction in atomic context
Date:   Fri, 28 Jan 2022 05:09:53 -0800
Message-Id: <20220128131006.67712-23-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

Calling percpu_free_rwsem in atomic context results in "scheduling while
atomic" bug being triggered:

BUG: scheduling while atomic: klogd/158/0x00000002
...
  __schedule_bug+0x191/0x290
  schedule_debug+0x97/0x180
  __schedule+0xdc/0xba0
  schedule+0xda/0x250
  schedule_timeout+0x92/0x2d0
  __wait_for_common+0x25b/0x430
  wait_for_completion+0x1f/0x30
  rcu_barrier+0x440/0x4f0
  rcu_sync_dtor+0xaa/0x190
  percpu_free_rwsem+0x41/0x80

Introduce percpu_rwsem_destroy function to perform semaphore destruction
in a worker thread.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/percpu-rwsem.h  | 13 ++++++++++++-
 kernel/locking/percpu-rwsem.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f97fe9..bf1668fc9c5e 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -13,7 +13,14 @@ struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
 	unsigned int __percpu	*read_count;
 	struct rcuwait		writer;
-	wait_queue_head_t	waiters;
+	/*
+	 * destroy_list_entry is used during object destruction when waiters
+	 * can't be used, therefore reusing the same space.
+	 */
+	union {
+		wait_queue_head_t	waiters;
+		struct list_head	destroy_list_entry;
+	};
 	atomic_t		block;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -127,8 +134,12 @@ extern void percpu_up_write(struct percpu_rw_semaphore *);
 extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
 				const char *, struct lock_class_key *);
 
+/* Can't be called in atomic context. */
 extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
 
+/* Invokes percpu_free_rwsem and frees the semaphore from a worker thread. */
+extern void percpu_rwsem_async_destroy(struct percpu_rw_semaphore *sem);
+
 #define percpu_init_rwsem(sem)					\
 ({								\
 	static struct lock_class_key rwsem_key;			\
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 70a32a576f3f..a3d37bf83c60 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -7,6 +7,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
@@ -268,3 +269,34 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	rcu_sync_exit(&sem->rss);
 }
 EXPORT_SYMBOL_GPL(percpu_up_write);
+
+static LIST_HEAD(destroy_list);
+static DEFINE_SPINLOCK(destroy_list_lock);
+
+static void destroy_list_workfn(struct work_struct *work)
+{
+	struct percpu_rw_semaphore *sem, *sem2;
+	LIST_HEAD(to_destroy);
+
+	spin_lock(&destroy_list_lock);
+	list_splice_init(&destroy_list, &to_destroy);
+	spin_unlock(&destroy_list_lock);
+
+	if (list_empty(&to_destroy))
+		return;
+
+	list_for_each_entry_safe(sem, sem2, &to_destroy, destroy_list_entry) {
+		percpu_free_rwsem(sem);
+		kfree(sem);
+	}
+}
+
+static DECLARE_WORK(destroy_list_work, destroy_list_workfn);
+
+void percpu_rwsem_async_destroy(struct percpu_rw_semaphore *sem)
+{
+	spin_lock(&destroy_list_lock);
+	list_add_tail(&sem->destroy_list_entry, &destroy_list);
+	spin_unlock(&destroy_list_lock);
+	schedule_work(&destroy_list_work);
+}
-- 
2.20.1


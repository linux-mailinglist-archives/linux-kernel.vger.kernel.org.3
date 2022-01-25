Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00FC49A8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiAYDRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:17:00 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:49043 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1318655AbiAYDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:51 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 25 Jan 2022 11:36:47 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 25 Jan 2022 11:36:47 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: [RFC 07/14] dept: Apply Dept to wait_for_completion()/complete()
Date:   Tue, 25 Jan 2022 11:36:37 +0900
Message-Id: <1643078204-12663-8-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by
wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h | 48 ++++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/completion.c  | 12 ++++++++++--
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e770..7f4a200 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -26,15 +26,51 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
-#define init_completion_map(x, m) __init_completion(x)
-#define init_completion(x) __init_completion(x)
+#ifdef CONFIG_DEPT
+#define dept_wfc_init(m, k, s, n)		dept_map_init(m, k, s, n)
+#define dept_wfc_reinit(m)			dept_map_reinit(m)
+#define dept_wfc_wait(m, ip)						\
+do {									\
+	dept_asked_event(m);						\
+	dept_wait(m, 1UL, ip, __func__, 0);				\
+} while (0)
+#define dept_wfc_complete(m, ip)		dept_event(m, 1UL, ip, __func__)
+#define dept_wfc_enter(m, ip)			dept_ecxt_enter(m, 1UL, ip, "completion_context_enter", "complete", 0)
+#define dept_wfc_exit(m, ip)			dept_ecxt_exit(m, ip)
+#else
+#define dept_wfc_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_wfc_reinit(m)			do { } while (0)
+#define dept_wfc_wait(m, ip)			do { } while (0)
+#define dept_wfc_complete(m, ip)		do { } while (0)
+#define dept_wfc_enter(m, ip)			do { } while (0)
+#define dept_wfc_exit(m, ip)			do { } while (0)
+#endif
+
+#ifdef CONFIG_DEPT
+#define WFC_DEPT_MAP_INIT(work) .dmap = { .name = #work }
+#else
+#define WFC_DEPT_MAP_INIT(work)
+#endif
+
+#define init_completion_map(x, m)				\
+	do {							\
+		static struct dept_key __dkey;			\
+		__init_completion(x, &__dkey, #x);		\
+	} while (0)
+#define init_completion(x)					\
+	do {							\
+		static struct dept_key __dkey;			\
+		__init_completion(x, &__dkey, #x);		\
+	} while (0)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	WFC_DEPT_MAP_INIT(work) }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -82,9 +118,12 @@ static inline void complete_release(struct completion *x) {}
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x,
+				     struct dept_key *dkey,
+				     const char *name)
 {
 	x->done = 0;
+	dept_wfc_init(&x->dmap, dkey, 0, name);
 	init_swait_queue_head(&x->wait);
 }
 
@@ -98,6 +137,7 @@ static inline void __init_completion(struct completion *x)
 static inline void reinit_completion(struct completion *x)
 {
 	x->done = 0;
+	dept_wfc_reinit(&x->dmap);
 }
 
 extern void wait_for_completion(struct completion *);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554..6e31cc0 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -29,6 +29,7 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
+	dept_wfc_complete(&x->dmap, _RET_IP_);
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 
 	if (x->done != UINT_MAX)
@@ -58,6 +59,7 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
+	dept_wfc_complete(&x->dmap, _RET_IP_);
 	lockdep_assert_RT_in_threaded_ctx();
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
@@ -112,17 +114,23 @@ void complete_all(struct completion *x)
 }
 
 static long __sched
-wait_for_common(struct completion *x, long timeout, int state)
+_wait_for_common(struct completion *x, long timeout, int state)
 {
 	return __wait_for_common(x, schedule_timeout, timeout, state);
 }
 
 static long __sched
-wait_for_common_io(struct completion *x, long timeout, int state)
+_wait_for_common_io(struct completion *x, long timeout, int state)
 {
 	return __wait_for_common(x, io_schedule_timeout, timeout, state);
 }
 
+#define wait_for_common(x, t, s)					\
+({ dept_wfc_wait(&(x)->dmap, _RET_IP_); _wait_for_common(x, t, s); })
+
+#define wait_for_common_io(x, t, s)					\
+({ dept_wfc_wait(&(x)->dmap, _RET_IP_); _wait_for_common_io(x, t, s); })
+
 /**
  * wait_for_completion: - waits for completion of a task
  * @x:  holds the state of this particular completion
-- 
1.9.1


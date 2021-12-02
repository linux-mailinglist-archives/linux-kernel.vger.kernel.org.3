Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9121465AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354306AbhLBAYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354215AbhLBAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:24:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318FC061748;
        Wed,  1 Dec 2021 16:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08650B82197;
        Thu,  2 Dec 2021 00:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8FFC53FAD;
        Thu,  2 Dec 2021 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404456;
        bh=bjpFm8qUZpgPKpuFrR71fV6y4tQEfZk4CPbtfDeNWck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yt2V6ZLPDnndmxLpA1kzfyR2LdrJ3sDBJZ2/oZZw94+5ukPlSA1o1STiiRbFmdAn2
         D2XQ5HFvnGOW7bdNvbZUR1TG7gXEs1AaW8AJGC86syS0gV/aS5SMuf9jgK1ny4Ebya
         Va2t4w84sq/LnhD29rRKmbuZ5X0fg9KMQaOFD1J1aj55TjCKOiTGIAzE9rWEbJBhkL
         9mQwcx11Itc1BTzXBKF+/UWOOyp9Q0KpAkNprrAR/n1VGYSojW0AeOKScIvShkJPn7
         AFVS8NNr8A/qFsDkimrlxwk1cEISqhY9qFVLaU0UggZllagkHnS+WKR0vjusbYr32c
         tv6rRAJ53T/LA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7EEB25C1107; Wed,  1 Dec 2021 16:20:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] rcu: Replace ________p1 and _________p1 with __UNIQUE_ID(rcu)
Date:   Wed,  1 Dec 2021 16:20:50 -0800
Message-Id: <20211202002055.3127133-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chun-Hung Tseng <henrybear327@gmail.com>

This commit replaces both ________p1 and _________p1 with __UNIQUE_ID(rcu),
and also adjusts the callers of the affected macros.

__UNIQUE_ID(rcu) will generate unique variable names during compilation,
which eliminates the need of ________p1 and _________p1 (both having 4
occurrences prior to the code change).  This also avoids the variable
name shadowing issue, or at least makes those wishing to cause shadowing
problems work much harder to do so.

The same idea is used for the min/max macros (commit 589a978 and commit
e9092d0).

Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 50 ++++++++++++++++++++++------------------
 include/linux/srcu.h     |  3 ++-
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e0beb5c5659a..88b42eb464068 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -364,6 +364,12 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
+#define __unrcu_pointer(p, local)					\
+({									\
+	typeof(*p) *local = (typeof(*p) *__force)(p);			\
+	rcu_check_sparse(p, __rcu);					\
+	((typeof(*p) __force __kernel *)(local)); 			\
+})
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
  * @p: pointer needing to lose its __rcu property
@@ -371,39 +377,35 @@ static inline void rcu_preempt_sleep_check(void) { }
  * Converts @p from an __rcu pointer to a __kernel pointer.
  * This allows an __rcu pointer to be used with xchg() and friends.
  */
-#define unrcu_pointer(p)						\
-({									\
-	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
-	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(_________p1)); 		\
-})
+#define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
 
-#define __rcu_access_pointer(p, space) \
+#define __rcu_access_pointer(p, local, space) \
 ({ \
-	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(_________p1)); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
-#define __rcu_dereference_check(p, c, space) \
+#define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(________p1)); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
-#define __rcu_dereference_protected(p, c, space) \
+#define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(p)); \
 })
-#define rcu_dereference_raw(p) \
+#define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(p) ________p1 = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(________p1)); \
+	typeof(p) local = READ_ONCE(p); \
+	((typeof(*p) __force __kernel *)(local)); \
 })
+#define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 
 /**
  * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
@@ -490,7 +492,7 @@ do {									      \
  * when tearing down multi-linked structures after a grace period
  * has elapsed.
  */
-#define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
+#define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
 
 /**
  * rcu_dereference_check() - rcu_dereference with debug checking
@@ -526,7 +528,8 @@ do {									      \
  * annotated as __rcu.
  */
 #define rcu_dereference_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_held(), __rcu)
 
 /**
  * rcu_dereference_bh_check() - rcu_dereference_bh with debug checking
@@ -541,7 +544,8 @@ do {									      \
  * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_bh_held(), __rcu)
 
 /**
  * rcu_dereference_sched_check() - rcu_dereference_sched with debug checking
@@ -556,7 +560,8 @@ do {									      \
  * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || rcu_read_lock_sched_held(), \
 				__rcu)
 
 /*
@@ -566,7 +571,8 @@ do {									      \
  * The no-tracing version of rcu_dereference_raw() must not call
  * rcu_read_lock_held().
  */
-#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
+#define rcu_dereference_raw_check(p) \
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), 1, __rcu)
 
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
@@ -585,7 +591,7 @@ do {									      \
  * but very ugly failures.
  */
 #define rcu_dereference_protected(p, c) \
-	__rcu_dereference_protected((p), (c), __rcu)
+	__rcu_dereference_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
 
 
 /**
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e6011a9975af2..01226e4d960a0 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -117,7 +117,8 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
  * lockdep_is_held() calls.
  */
 #define srcu_dereference_check(p, ssp, c) \
-	__rcu_dereference_check((p), (c) || srcu_read_lock_held(ssp), __rcu)
+	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
+				(c) || srcu_read_lock_held(ssp), __rcu)
 
 /**
  * srcu_dereference - fetch SRCU-protected pointer for later dereferencing
-- 
2.31.1.189.g2e36527f23


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745A14C9C87
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiCBEhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiCBEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A3B10B5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=htOLwXcWZTxG7nXFiizBJOGaxR9Ho6WfdNcwubCBDjY=; b=KxRDwT29VbtCxmuS+PerwBqn6S
        ei29uy6P9VGDk/iOLyDy8EgHKe6YPkbvt7b7rPbBJAxtGH+8QoSIylYL6tpxC5MRnYXxgLxYVIwJ0
        +MHvcPpnlsU1CbLCUPXMJniwgQJalRKvimofFNX1bDxbNjnF73RtYFewCRsZbfAkNwoch79K69SDA
        aTlkyN8Jh/R7okDQuW2hG+5y23bBEPHUX4hXrRMU3y1pqpmAV9MPVTh95V24FJuMfmxzfWjSx31bv
        AMXZviQGz+5dp1EuREHDMqL1vPj9Tx8Q4rWVMSm15pXXjRHNTxxYvmZrVDh/SLioiGOenRE1xFTUE
        1ymo5rzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhR-00AF6z-QV; Wed, 02 Mar 2022 04:34:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] wait: Parameterize the return variable to ___wait_event()
Date:   Wed,  2 Mar 2022 04:34:33 +0000
Message-Id: <20220302043451.2441320-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220302043451.2441320-1-willy@infradead.org>
References: <20220302043451.2441320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not refer to variables which aren't in their arguments.
Pass the name from its callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swait.h    | 12 ++++++------
 include/linux/wait.h     | 32 ++++++++++++++++----------------
 include/linux/wait_bit.h |  4 ++--
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..5e8e9b13be2d 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -191,14 +191,14 @@ do {									\
 } while (0)
 
 #define __swait_event_timeout(wq, condition, timeout)			\
-	___swait_event(wq, ___wait_cond_timeout(condition),		\
+	___swait_event(wq, ___wait_cond_timeout(condition, __ret),	\
 		      TASK_UNINTERRUPTIBLE, timeout,			\
 		      __ret = schedule_timeout(__ret))
 
 #define swait_event_timeout_exclusive(wq, condition, timeout)		\
 ({									\
 	long __ret = timeout;						\
-	if (!___wait_cond_timeout(condition))				\
+	if (!___wait_cond_timeout(condition, __ret))			\
 		__ret = __swait_event_timeout(wq, condition, timeout);	\
 	__ret;								\
 })
@@ -216,14 +216,14 @@ do {									\
 })
 
 #define __swait_event_interruptible_timeout(wq, condition, timeout)	\
-	___swait_event(wq, ___wait_cond_timeout(condition),		\
+	___swait_event(wq, ___wait_cond_timeout(condition, __ret),	\
 		      TASK_INTERRUPTIBLE, timeout,			\
 		      __ret = schedule_timeout(__ret))
 
 #define swait_event_interruptible_timeout_exclusive(wq, condition, timeout)\
 ({									\
 	long __ret = timeout;						\
-	if (!___wait_cond_timeout(condition))				\
+	if (!___wait_cond_timeout(condition, __ret))			\
 		__ret = __swait_event_interruptible_timeout(wq,		\
 						condition, timeout);	\
 	__ret;								\
@@ -252,7 +252,7 @@ do {									\
 } while (0)
 
 #define __swait_event_idle_timeout(wq, condition, timeout)		\
-	___swait_event(wq, ___wait_cond_timeout(condition),		\
+	___swait_event(wq, ___wait_cond_timeout(condition, __ret),	\
 		       TASK_IDLE, timeout,				\
 		       __ret = schedule_timeout(__ret))
 
@@ -278,7 +278,7 @@ do {									\
 #define swait_event_idle_timeout_exclusive(wq, condition, timeout)	\
 ({									\
 	long __ret = timeout;						\
-	if (!___wait_cond_timeout(condition))				\
+	if (!___wait_cond_timeout(condition, __ret))			\
 		__ret = __swait_event_idle_timeout(wq,			\
 						   condition, timeout);	\
 	__ret;								\
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07da2583..890cce3c0f2e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -271,7 +271,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 		__wake_up_pollfree(wq_head);
 }
 
-#define ___wait_cond_timeout(condition)						\
+#define ___wait_cond_timeout(condition, __ret)					\
 ({										\
 	bool __cond = (condition);						\
 	if (__cond && !__ret)							\
@@ -386,7 +386,7 @@ do {										\
 })
 
 #define __wait_event_timeout(wq_head, condition, timeout)			\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_UNINTERRUPTIBLE, 0, timeout,				\
 		      __ret = schedule_timeout(__ret))
 
@@ -413,13 +413,13 @@ do {										\
 ({										\
 	long __ret = timeout;							\
 	might_sleep();								\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_timeout(wq_head, condition, timeout);	\
 	__ret;									\
 })
 
 #define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_INTERRUPTIBLE, 0, timeout,				\
 		      __ret = freezable_schedule_timeout(__ret))
 
@@ -431,7 +431,7 @@ do {										\
 ({										\
 	long __ret = timeout;							\
 	might_sleep();								\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_freezable_timeout(wq_head, condition, timeout); \
 	__ret;									\
 })
@@ -503,7 +503,7 @@ do {										\
 })
 
 #define __wait_event_interruptible_timeout(wq_head, condition, timeout)		\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_INTERRUPTIBLE, 0, timeout,				\
 		      __ret = schedule_timeout(__ret))
 
@@ -531,7 +531,7 @@ do {										\
 ({										\
 	long __ret = timeout;							\
 	might_sleep();								\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_interruptible_timeout(wq_head,		\
 						condition, timeout);		\
 	__ret;									\
@@ -698,7 +698,7 @@ do {										\
 } while (0)
 
 #define __wait_event_idle_timeout(wq_head, condition, timeout)			\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_IDLE, 0, timeout,					\
 		      __ret = schedule_timeout(__ret))
 
@@ -725,13 +725,13 @@ do {										\
 ({										\
 	long __ret = timeout;							\
 	might_sleep();								\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_idle_timeout(wq_head, condition, timeout);	\
 	__ret;									\
 })
 
 #define __wait_event_idle_exclusive_timeout(wq_head, condition, timeout)	\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_IDLE, 1, timeout,					\
 		      __ret = schedule_timeout(__ret))
 
@@ -762,7 +762,7 @@ do {										\
 ({										\
 	long __ret = timeout;							\
 	might_sleep();								\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_idle_exclusive_timeout(wq_head, condition, timeout);\
 	__ret;									\
 })
@@ -932,7 +932,7 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 })
 
 #define __wait_event_killable_timeout(wq_head, condition, timeout)		\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_KILLABLE, 0, timeout,				\
 		      __ret = schedule_timeout(__ret))
 
@@ -962,7 +962,7 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 ({										\
 	long __ret = timeout;							\
 	might_sleep();								\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_killable_timeout(wq_head,			\
 						condition, timeout);		\
 	__ret;									\
@@ -1107,7 +1107,7 @@ do {										\
 })
 
 #define __wait_event_lock_irq_timeout(wq_head, condition, lock, timeout, state)	\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      state, 0, timeout,					\
 		      spin_unlock_irq(&lock);					\
 		      __ret = schedule_timeout(__ret);				\
@@ -1141,7 +1141,7 @@ do {										\
 						  timeout)			\
 ({										\
 	long __ret = timeout;							\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_lock_irq_timeout(				\
 					wq_head, condition, lock, timeout,	\
 					TASK_INTERRUPTIBLE);			\
@@ -1151,7 +1151,7 @@ do {										\
 #define wait_event_lock_irq_timeout(wq_head, condition, lock, timeout)		\
 ({										\
 	long __ret = timeout;							\
-	if (!___wait_cond_timeout(condition))					\
+	if (!___wait_cond_timeout(condition, __ret))				\
 		__ret = __wait_event_lock_irq_timeout(				\
 					wq_head, condition, lock, timeout,	\
 					TASK_UNINTERRUPTIBLE);			\
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7dec36aecbd9..227e6a20a978 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -292,7 +292,7 @@ do {									\
 })
 
 #define __wait_var_event_timeout(var, condition, timeout)		\
-	___wait_var_event(var, ___wait_cond_timeout(condition),		\
+	___wait_var_event(var, ___wait_cond_timeout(condition, __ret),	\
 			  TASK_UNINTERRUPTIBLE, 0, timeout,		\
 			  __ret = schedule_timeout(__ret))
 
@@ -300,7 +300,7 @@ do {									\
 ({									\
 	long __ret = timeout;						\
 	might_sleep();							\
-	if (!___wait_cond_timeout(condition))				\
+	if (!___wait_cond_timeout(condition, __ret))			\
 		__ret = __wait_var_event_timeout(var, condition, timeout); \
 	__ret;								\
 })
-- 
2.34.1


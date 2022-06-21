Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F5553AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354055AbiFUThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348473AbiFUThJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B8FD2D1D0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655840227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=exBeYI4UlIWCSp5FGAcvkiWJcZFIGwb+G+M3ptZksLc=;
        b=J6heWhsa8AR1w6dz/47oJV6idgNxKYtCaIpBE5MR9bChcwmSMebzszexp7tMixTIgwphp+
        TmLs4rMT8zW3TatzXsVRyIWYyFhWjTQyTge7cVBFhnLogifytuLQ5THvsQSJMZuu9R52dR
        6mjt0kiHuEEyTQPVQK0qPYZwqiAfgBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-Ra8wHpUVOw-ZAXqimd0DnA-1; Tue, 21 Jun 2022 15:37:03 -0400
X-MC-Unique: Ra8wHpUVOw-ZAXqimd0DnA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8901185A7B2;
        Tue, 21 Jun 2022 19:37:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2F640C5BF;
        Tue, 21 Jun 2022 19:37:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/rtmutex: Limit # of lock stealing for non-RT waiters
Date:   Tue, 21 Jun 2022 15:36:41 -0400
Message-Id: <20220621193641.609712-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
stealing") allows unlimited number of lock stealing's for non-RT
tasks. That can lead to lock starvation of non-RT top waiter tasks if
there is a constant incoming stream of non-RT lockers. This can cause
task lockup in PREEMPT_RT kernel. For example,

[ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
[ 1872.984225] INFO: task kworker/6:4:63401 blocked for more than 622 seconds.

Avoiding this problem and ensuring forward progress by limiting the
number of times that a lock can be stolen from each waiter. This patch
sets a threshold of 10. That number is arbitrary and can be changed
if needed.

With that change, the task lockups previously observed when running
stressful workloads on PREEMPT_RT kernel disappeared.

Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
Reported-by: Mike Stowell <mstowell@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rtmutex.c        | 9 ++++++---
 kernel/locking/rtmutex_common.h | 8 ++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8abc2a..bdddb3dc36c2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -359,10 +359,13 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
 		return false;
 
-	return rt_mutex_waiter_equal(waiter, top_waiter);
-#else
-	return false;
+	if (rt_mutex_waiter_equal(waiter, top_waiter) &&
+	   (top_waiter->nr_steals < RT_MUTEX_LOCK_STEAL_MAX)) {
+		top_waiter->nr_steals++;
+		return true;
+	}
 #endif
+	return false;
 }
 
 #define __node_2_waiter(node) \
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e8361bfb5..5858efe5cb0e 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -26,6 +26,7 @@
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
+ * @nr_steals:		Number of times the lock is stolen
  * @prio:		Priority of the waiter
  * @deadline:		Deadline of the waiter if applicable
  * @ww_ctx:		WW context pointer
@@ -36,11 +37,17 @@ struct rt_mutex_waiter {
 	struct task_struct	*task;
 	struct rt_mutex_base	*lock;
 	unsigned int		wake_state;
+	unsigned int		nr_steals;
 	int			prio;
 	u64			deadline;
 	struct ww_acquire_ctx	*ww_ctx;
 };
 
+/*
+ * The maximum number of times where lock can be stolen per waiter.
+ */
+#define	RT_MUTEX_LOCK_STEAL_MAX	10
+
 /**
  * rt_wake_q_head - Wrapper around regular wake_q_head to support
  *		    "sleeping" spinlocks on RT
@@ -194,6 +201,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->tree_entry);
 	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
+	waiter->nr_steals = 0;
 }
 
 static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
-- 
2.31.1


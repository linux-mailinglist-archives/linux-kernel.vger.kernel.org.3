Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C87543761
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242490AbiFHP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiFHP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C19FC1567E3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654701805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CzzYUDxQ930ySRFgp0CenhJsvHP6X+ZkxaeZlzPndWQ=;
        b=HiWVMG2jlhd2YUAQzLQRacCNB+I3YgQiLzDYDsePrzoaXQ3Strtlnji1V8YGeRrXhXxi9L
        /reHfGX16e8/3MM5X7DY7cxpHGiaI+x5U5rzODkk0jGzALjWXQ0O6dqQ6uupUtMoncOzH1
        6oaUIXsqN6khpBwpHYBnzxdMQW/BL5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-CAebCiPuPB2Wdly6p_vTiQ-1; Wed, 08 Jun 2022 11:23:22 -0400
X-MC-Unique: CAebCiPuPB2Wdly6p_vTiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD8B1800971;
        Wed,  8 Jun 2022 15:23:21 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3CC61121314;
        Wed,  8 Jun 2022 15:23:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory Haskins <ghaskins@novell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rtmutex: Limit # of lock stealing for non-RT waiters
Date:   Wed,  8 Jun 2022 11:22:54 -0400
Message-Id: <20220608152254.74591-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
stealing") allows unlimited number of lock stealing's for non-RT
tasks. That can lead to lock starvation of non-RT top waiter if there
is a constant incoming stream of non-RT lockers. This can cause task
lockup in PREEMPT_RT kernel.

Avoiding this problem and ensuring forward progress by limiting the
number of times that a lock can be stolen from each waiter. This patch
sets a threshold of 10. That number is arbitrary and can be changed
if necessary.

Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
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


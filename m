Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC584DDE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiCRQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiCRQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7056A1D78A8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647620199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxtKlJkyIEZXPkBD4bNBzWUwa71AXxO/hu9B1huGD20=;
        b=fbstevU9gA/Aqe0HqT0pKW2h3LqcD69rO+O1WdQ2a90C3kzGh1FwgZIFe5X6PyyNL6kzmM
        7dhZrShducMxc+1Yieukz0QHOFNQ52G9z24iSnX9VwPUy9Bs6zhQUplCjPZd6Vdv+Vlqui
        d6SOOcwihfhtbZJ17oZfEo5lbjy1Pk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-Wbp0rir3Ota5OBaIJneRkA-1; Fri, 18 Mar 2022 12:16:35 -0400
X-MC-Unique: Wbp0rir3Ota5OBaIJneRkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F12580231F;
        Fri, 18 Mar 2022 16:16:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.19.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7D5112D182;
        Fri, 18 Mar 2022 16:16:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/rwsem: Wake readers in a reader-owned rwsem if first waiter is a reader
Date:   Fri, 18 Mar 2022 12:16:09 -0400
Message-Id: <20220318161609.1939957-3-longman@redhat.com>
In-Reply-To: <20220318161609.1939957-1-longman@redhat.com>
References: <20220318161609.1939957-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an analysis of a recent vmcore, a reader-owned rwsem was found with
385 readers but no writer in the wait queue. That is kind of unusual
but it may be caused by some race conditions that we have not fully
understood yet. In such a case, all the readers in the wait queue should
join the other reader-owners and acquire the read lock.

In rwsem_down_write_slowpath(), an incoming writer will try to wake
up the front readers under such circumstance. That is not the case for
rwsem_down_read_slowpath(), modify the code to do this. This includes the
original supported case where the wait queue is empty and the incoming
reader is going to wake up itself.

With CONFIG_LOCK_EVENT_COUNTS enabled, the newly added rwsem_rlock_rwake
event counter had 13 hits right after the bootup of a 2-socket system. So
the condition that a reader-owned rwsem has readers at the front of
the wait queue does happen pretty frequently. This patch will help to
speed thing up in such cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..9bb9f048848b 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -64,6 +64,7 @@ LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
 LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
+LOCK_EVENT(rwsem_rlock_rwake)	/* # of readers wakeup in slow path	*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f71a9693d05a..53f7f0b4724a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -997,17 +997,24 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	count = atomic_long_add_return(adjustment, &sem->count);
 
 	/*
-	 * If there are no active locks, wake the front queued process(es).
-	 *
-	 * If there are no writers and we are first in the queue,
-	 * wake our own waiter to join the existing active readers !
+	 * Do a rwsem_mark_wake() under one of the following conditions:
+	 * 1) there is no active read or write lock.
+	 * 2) there is no writer-owner (can be reader-owned) and the first
+	 *    waiter is a reader.
 	 */
 	if (!(count & RWSEM_LOCK_MASK)) {
 		clear_nonspinnable(sem);
 		wake = true;
+	} else if (!(count & RWSEM_WRITER_MASK)) {
+		wake = rwsem_first_waiter(sem)->type == RWSEM_WAITING_FOR_READ;
+		/*
+		 * Check the number of cases where readers at the front
+		 * of the previously non-empty wait list are to be woken.
+		 */
+		lockevent_cond_inc(rwsem_rlock_rwake,
+				   wake && !(adjustment & RWSEM_FLAG_WAITERS));
 	}
-	if (wake || (!(count & RWSEM_WRITER_MASK) &&
-		    (adjustment & RWSEM_FLAG_WAITERS)))
+	if (wake)
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
-- 
2.27.0


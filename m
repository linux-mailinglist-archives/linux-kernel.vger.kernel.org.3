Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15F65224A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiEJTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiEJTWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA6B631344
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652210511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Bh29uGCN+/20VqwNgIk/pci6v/LmMLT55oapJYUdWA=;
        b=UxM9K6aMUlWTLbdgWhj+XHXwdNQ7N+49TszQhyMCJEqU/mS1SHFq/IzOKYpczInXc6Dk0n
        XiDD9C6b/xS7faae4ufVYy4gYiGurOBvmIIrNPzaqBnDX7dKqYxNzVZy2ShuvW2psOKNDG
        vWDnfSK3Hlp/Xx1DeuQgi7DyOkbB2sM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-i4f0yHzAMm2GHp8WDC1YrQ-1; Tue, 10 May 2022 15:21:47 -0400
X-MC-Unique: i4f0yHzAMm2GHp8WDC1YrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9404F857AA6;
        Tue, 10 May 2022 19:21:46 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60F5540CFD33;
        Tue, 10 May 2022 19:21:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for rwlocks used in interrupt context
Date:   Tue, 10 May 2022 15:21:34 -0400
Message-Id: <20220510192134.434753-2-longman@redhat.com>
In-Reply-To: <20220510192134.434753-1-longman@redhat.com>
References: <20220510192134.434753-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though qrwlock is supposed to be a fair lock, it does allow readers
from interrupt context to spin on the lock until it can acquire it making
it not as fair. This exception was added due to the requirement to allow
recursive read lock in interrupt context. This can also be achieved by
just ignoring the writer waiting bit without spinning on the lock.

By making this change, we make qrwlock a bit more fair and eliminating
the problem of cacheline bouncing for rwlocks that are used heavily in
interrupt context, like the networking stack. This should also reduce
the chance of lock starvation for those interrupt context rwlocks.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qrwlock.h |  6 +++---
 kernel/locking/qrwlock.c      | 17 ++++++-----------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index d4cd4cc4389c..9d40cf016e0c 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -29,7 +29,7 @@
 /*
  * External function declarations
  */
-extern void queued_read_lock_slowpath(struct qrwlock *lock);
+extern void queued_read_lock_slowpath(struct qrwlock *lock, int cnts);
 extern void queued_write_lock_slowpath(struct qrwlock *lock);
 
 /**
@@ -80,7 +80,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
 		return;
 
 	/* The slowpath will decrement the reader count, if necessary. */
-	queued_read_lock_slowpath(lock);
+	queued_read_lock_slowpath(lock, cnts);
 }
 
 /**
@@ -90,7 +90,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
 static inline void queued_write_lock(struct qrwlock *lock)
 {
 	int cnts = 0;
-	/* Optimize for the unfair lock case where the fair flag is 0. */
+
 	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
 		return;
 
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 2e1600906c9f..d52d13e95600 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -18,21 +18,16 @@
  * queued_read_lock_slowpath - acquire read lock of a queued rwlock
  * @lock: Pointer to queued rwlock structure
  */
-void queued_read_lock_slowpath(struct qrwlock *lock)
+void queued_read_lock_slowpath(struct qrwlock *lock, int cnts)
 {
 	/*
-	 * Readers come here when they cannot get the lock without waiting
+	 * Readers come here when they cannot get the lock without waiting.
+	 * Readers in interrupt context can steal the lock immediately
+	 * if the writer is just waiting (not holding the lock yet).
 	 */
-	if (unlikely(in_interrupt())) {
-		/*
-		 * Readers in interrupt context will get the lock immediately
-		 * if the writer is just waiting (not holding the lock yet),
-		 * so spin with ACQUIRE semantics until the lock is available
-		 * without waiting in the queue.
-		 */
-		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
+	if (unlikely(!(cnts & _QW_LOCKED) && in_interrupt()))
 		return;
-	}
+
 	atomic_sub(_QR_BIAS, &lock->cnts);
 
 	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
-- 
2.27.0


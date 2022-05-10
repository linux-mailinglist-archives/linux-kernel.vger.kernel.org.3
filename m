Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3F5224A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiEJTWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiEJTV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47D863057B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652210510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DosvskhYNZcL9p2AZGEwHPWxkQMwuPh1HQwfAYOCCag=;
        b=INMi4Nj/3IEgw09coBVAIC6cU9L+ch6LOKSFOHul3rDRr4qvQSaGCsodxeEr1k7ZANIY+r
        +W4/BiFsOQDusz/u0BwRcCjqgddup2Qpqvn//jtn++luOTYTwsuWRd9KXubDJ4dIOj+f3x
        tuhzPwCDRlYWHB4eeg7qOWfnjgN2AN0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-L4nWQIQpMrWmWAegaaLalA-1; Tue, 10 May 2022 15:21:46 -0400
X-MC-Unique: L4nWQIQpMrWmWAegaaLalA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57E4D3C138CA;
        Tue, 10 May 2022 19:21:46 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED59A40CFD06;
        Tue, 10 May 2022 19:21:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/qrwlock: Change "queue rwlock" to "queued rwlock"
Date:   Tue, 10 May 2022 15:21:33 -0400
Message-Id: <20220510192134.434753-1-longman@redhat.com>
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

Queued rwlock was originally named "queue rwlock" which wasn't quite
grammatically correct. However there are still some "queue rwlock"
references in the code. Change those to "queued rwlock" for consistency.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qrwlock.h       | 28 ++++++++++++++--------------
 include/asm-generic/qrwlock_types.h |  2 +-
 kernel/locking/qrwlock.c            |  8 ++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece07b4e..d4cd4cc4389c 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -33,8 +33,8 @@ extern void queued_read_lock_slowpath(struct qrwlock *lock);
 extern void queued_write_lock_slowpath(struct qrwlock *lock);
 
 /**
- * queued_read_trylock - try to acquire read lock of a queue rwlock
- * @lock : Pointer to queue rwlock structure
+ * queued_read_trylock - try to acquire read lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
  * Return: 1 if lock acquired, 0 if failed
  */
 static inline int queued_read_trylock(struct qrwlock *lock)
@@ -52,8 +52,8 @@ static inline int queued_read_trylock(struct qrwlock *lock)
 }
 
 /**
- * queued_write_trylock - try to acquire write lock of a queue rwlock
- * @lock : Pointer to queue rwlock structure
+ * queued_write_trylock - try to acquire write lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
  * Return: 1 if lock acquired, 0 if failed
  */
 static inline int queued_write_trylock(struct qrwlock *lock)
@@ -68,8 +68,8 @@ static inline int queued_write_trylock(struct qrwlock *lock)
 				_QW_LOCKED));
 }
 /**
- * queued_read_lock - acquire read lock of a queue rwlock
- * @lock: Pointer to queue rwlock structure
+ * queued_read_lock - acquire read lock of a queued rwlock
+ * @lock: Pointer to queued rwlock structure
  */
 static inline void queued_read_lock(struct qrwlock *lock)
 {
@@ -84,8 +84,8 @@ static inline void queued_read_lock(struct qrwlock *lock)
 }
 
 /**
- * queued_write_lock - acquire write lock of a queue rwlock
- * @lock : Pointer to queue rwlock structure
+ * queued_write_lock - acquire write lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
  */
 static inline void queued_write_lock(struct qrwlock *lock)
 {
@@ -98,8 +98,8 @@ static inline void queued_write_lock(struct qrwlock *lock)
 }
 
 /**
- * queued_read_unlock - release read lock of a queue rwlock
- * @lock : Pointer to queue rwlock structure
+ * queued_read_unlock - release read lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
  */
 static inline void queued_read_unlock(struct qrwlock *lock)
 {
@@ -110,8 +110,8 @@ static inline void queued_read_unlock(struct qrwlock *lock)
 }
 
 /**
- * queued_write_unlock - release write lock of a queue rwlock
- * @lock : Pointer to queue rwlock structure
+ * queued_write_unlock - release write lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
  */
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
@@ -120,7 +120,7 @@ static inline void queued_write_unlock(struct qrwlock *lock)
 
 /**
  * queued_rwlock_is_contended - check if the lock is contended
- * @lock : Pointer to queue rwlock structure
+ * @lock : Pointer to queued rwlock structure
  * Return: 1 if lock contended, 0 otherwise
  */
 static inline int queued_rwlock_is_contended(struct qrwlock *lock)
@@ -130,7 +130,7 @@ static inline int queued_rwlock_is_contended(struct qrwlock *lock)
 
 /*
  * Remapping rwlock architecture specific functions to the corresponding
- * queue rwlock functions.
+ * queued rwlock functions.
  */
 #define arch_read_lock(l)		queued_read_lock(l)
 #define arch_write_lock(l)		queued_write_lock(l)
diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index c36f1d5a2572..12392c14c4d0 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -7,7 +7,7 @@
 #include <asm/spinlock_types.h>
 
 /*
- * The queue read/write lock data structure
+ * The queued read/write lock data structure
  */
 
 typedef struct qrwlock {
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 7f42e52a648f..2e1600906c9f 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -15,8 +15,8 @@
 #include <trace/events/lock.h>
 
 /**
- * queued_read_lock_slowpath - acquire read lock of a queue rwlock
- * @lock: Pointer to queue rwlock structure
+ * queued_read_lock_slowpath - acquire read lock of a queued rwlock
+ * @lock: Pointer to queued rwlock structure
  */
 void queued_read_lock_slowpath(struct qrwlock *lock)
 {
@@ -60,8 +60,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 EXPORT_SYMBOL(queued_read_lock_slowpath);
 
 /**
- * queued_write_lock_slowpath - acquire write lock of a queue rwlock
- * @lock : Pointer to queue rwlock structure
+ * queued_write_lock_slowpath - acquire write lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD5523DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiEKTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiEKTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:39:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C521935B;
        Wed, 11 May 2022 12:39:50 -0700 (PDT)
Date:   Wed, 11 May 2022 19:39:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652297988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtjhm2Qopr1pOkpO3sJ7IVaQ1F1/Ar9jAqBHwEGkM+E=;
        b=k71UFmE5Aa+SmDaaWS6DKfSMHat0+ukbJ1BbloB6Vi+yWoopj2e4gIuYs977rhJfq6O+9m
        ZVuC+jqtIZ6HsZ8zp2pplimffomb42r5AnjwOe7K/CxZdRLB9Z+o51WIsvBQTJwNQYaf2w
        2/E0dRY+1svfjAcIOHuwIK2e2ZXjyDvXjnm+wL3Flc6qj4Gd+bBfRC98V4hjoH19J8Iogk
        8u+MC6IDZpaIwP2pnq5MdyZWywK3hkBdBTjLJQEoVn4qwwFusWqVYe3Iqh2DYmrCKsArIb
        5HrR2EsEa/3COkmKA7ZLTLnCBh059hDo4WGp7w+M7qog+DuTHxaLrMLrxbuspw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652297988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtjhm2Qopr1pOkpO3sJ7IVaQ1F1/Ar9jAqBHwEGkM+E=;
        b=GVuFSRgke8Bz8VTz/RGSwXnJntqn2tlxSx7Hj5w7d9DADBl0OGrS3RMlYDR24v+1IO0bUb
        K1W01xasRey4CdDQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/qrwlock: Change "queue rwlock" to "queued rwlock"
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220510192134.434753-1-longman@redhat.com>
References: <20220510192134.434753-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <165229798674.4207.16819963844601228510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     434e09e7575b02e014931bc5672289fabd7a825c
Gitweb:        https://git.kernel.org/tip/434e09e7575b02e014931bc5672289fabd7a825c
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 10 May 2022 15:21:33 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:04 +02:00

locking/qrwlock: Change "queue rwlock" to "queued rwlock"

Queued rwlock was originally named "queue rwlock" which wasn't quite
grammatically correct. However there are still some "queue rwlock"
references in the code. Change those to "queued rwlock" for consistency.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220510192134.434753-1-longman@redhat.com
---
 include/asm-generic/qrwlock.h       | 28 ++++++++++++++--------------
 include/asm-generic/qrwlock_types.h |  2 +-
 kernel/locking/qrwlock.c            |  8 ++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece..d4cd4cc 100644
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
index c36f1d5..12392c1 100644
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
index 7f42e52..2e16009 100644
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

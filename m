Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC765658C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiGDOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiGDOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:38:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CA665F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso2265155pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIDkYfvKDw43uecwnfQLEkprsoJgdapMUXzn/Kr3sTs=;
        b=CY+3UP29fPbYElXIhspAj4ieKSopLlHPB5SQ10kJmoJrA8YiBRNA1MooiKTYKpP+Kw
         bYXprF0s+SN9Kv3zOPh9TXdfr4LO3r1qyf/eUrJ8mVThNacKfW5hIrgiTklCKtDZd6Wz
         +9/CZ/iAPCErkRkirhnHQJKLZ8cSiKHbwh+Duy73bWGxKazHvVAV4Rgxz/IKZ/ynqSr5
         DNuROAeYPhLDbJX/n2pvaPRg7DI68hnoCPC4SbdtAN+y8u3xTQ0RbGMW4KiLgnf5bHUc
         fbTDDbxKKj7hO5kzIUkVoQbP6lR4YQbgxa0CVG4GRH4aQPnGn8jO1eEE+Td82mSKxHcw
         CwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIDkYfvKDw43uecwnfQLEkprsoJgdapMUXzn/Kr3sTs=;
        b=Hn6meCl2b0jUV3i7iwMDui/vBxY9ca1QU6y5lpVbwlCL5M/mI6PtvFaUBaHU7E5QNu
         abfsY7VHUJevfAXWLC7zujBWYR0VXWjoTuyveQuXj66RHr365BnWZwZd2WmQ3gKBSEe/
         JKjt5oCO6CL+w1kctibuCDkEcWXM8ZhD2S6savef8ZT3kOraEeX2wJchX6DCTY4Et57r
         TWkg8UTAkvjQbT4ki9myxlYn/hJnSTNpWRcgrzUId3Tyg1AA77C8tDgXHktIdiQFLMuR
         fznhig3MI+0NrATcQkb/h7/LdzogSPFu7JpnUipF6flymT5EB7+K+75MYnfVoyqCHleK
         kreg==
X-Gm-Message-State: AJIora9pCUCqh+fOyq1X65bZs3Q7kT89BHzTKBR66nAnzt64v88b0MU1
        AANn8qR8tHN64PR7BzHn7NU=
X-Google-Smtp-Source: AGRyM1s/OrOGW0U3koMEdt/RYPom/gfbiphDRSNU15loeOuzppFgGwuCjKRB9S4aFsFET4VITn9uLw==
X-Received: by 2002:a17:90b:2246:b0:1ec:aa2c:8edc with SMTP id hk6-20020a17090b224600b001ecaa2c8edcmr34747221pjb.14.1656945512427;
        Mon, 04 Jul 2022 07:38:32 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:31 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] locking/qspinlock: remove pv_node abstraction
Date:   Tue,  5 Jul 2022 00:38:08 +1000
Message-Id: <20220704143820.3071004-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
References: <20220704143820.3071004-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't much point trying to separate struct qnode from struct pv_node
when struct qnode has to know about pv_node anyway.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          |  3 ++-
 kernel/locking/qspinlock_paravirt.h | 34 ++++++++++++-----------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 65a9a10caa6f..a0fc21d99199 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -82,7 +82,8 @@
 struct qnode {
 	struct mcs_spinlock mcs;
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-	long reserved[2];
+	int			cpu;
+	u8			state;
 #endif
 };
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..b6a175155f36 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -47,12 +47,6 @@ enum vcpu_state {
 	vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
 };
 
-struct pv_node {
-	struct mcs_spinlock	mcs;
-	int			cpu;
-	u8			state;
-};
-
 /*
  * Hybrid PV queued/unfair lock
  *
@@ -170,7 +164,7 @@ static __always_inline int trylock_clear_pending(struct qspinlock *lock)
  */
 struct pv_hash_entry {
 	struct qspinlock *lock;
-	struct pv_node   *node;
+	struct qnode   *node;
 };
 
 #define PV_HE_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_entry))
@@ -209,7 +203,7 @@ void __init __pv_init_lock_hash(void)
 	     offset < (1 << pv_lock_hash_bits);						\
 	     offset++, he = &pv_lock_hash[(hash + offset) & ((1 << pv_lock_hash_bits) - 1)])
 
-static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
+static struct qspinlock **pv_hash(struct qspinlock *lock, struct qnode *node)
 {
 	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
 	struct pv_hash_entry *he;
@@ -236,11 +230,11 @@ static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
 	BUG();
 }
 
-static struct pv_node *pv_unhash(struct qspinlock *lock)
+static struct qnode *pv_unhash(struct qspinlock *lock)
 {
 	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
 	struct pv_hash_entry *he;
-	struct pv_node *node;
+	struct qnode *node;
 
 	for_each_hash_entry(he, offset, hash) {
 		if (READ_ONCE(he->lock) == lock) {
@@ -264,7 +258,7 @@ static struct pv_node *pv_unhash(struct qspinlock *lock)
  * in a running state.
  */
 static inline bool
-pv_wait_early(struct pv_node *prev, int loop)
+pv_wait_early(struct qnode *prev, int loop)
 {
 	if ((loop & PV_PREV_CHECK_MASK) != 0)
 		return false;
@@ -277,9 +271,9 @@ pv_wait_early(struct pv_node *prev, int loop)
  */
 static void pv_init_node(struct mcs_spinlock *node)
 {
-	struct pv_node *pn = (struct pv_node *)node;
+	struct qnode *pn = (struct qnode *)node;
 
-	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
+	BUILD_BUG_ON(sizeof(struct qnode) > sizeof(struct qnode));
 
 	pn->cpu = smp_processor_id();
 	pn->state = vcpu_running;
@@ -292,8 +286,8 @@ static void pv_init_node(struct mcs_spinlock *node)
  */
 static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
-	struct pv_node *pn = (struct pv_node *)node;
-	struct pv_node *pp = (struct pv_node *)prev;
+	struct qnode *pn = (struct qnode *)node;
+	struct qnode *pp = (struct qnode *)prev;
 	int loop;
 	bool wait_early;
 
@@ -359,7 +353,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
  */
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
-	struct pv_node *pn = (struct pv_node *)node;
+	struct qnode *pn = (struct qnode *)node;
 
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
@@ -402,7 +396,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 static u32
 pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 {
-	struct pv_node *pn = (struct pv_node *)node;
+	struct qnode *pn = (struct qnode *)node;
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
@@ -492,7 +486,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 __visible void
 __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 {
-	struct pv_node *node;
+	struct qnode *node;
 
 	if (unlikely(locked != _Q_SLOW_VAL)) {
 		WARN(!debug_locks_silent,
@@ -517,14 +511,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	node = pv_unhash(lock);
 
 	/*
-	 * Now that we have a reference to the (likely) blocked pv_node,
+	 * Now that we have a reference to the (likely) blocked qnode,
 	 * release the lock.
 	 */
 	smp_store_release(&lock->locked, 0);
 
 	/*
 	 * At this point the memory pointed at by lock can be freed/reused,
-	 * however we can still use the pv_node to kick the CPU.
+	 * however we can still use the qnode to kick the CPU.
 	 * The other vCPU may not really be halted, but kicking an active
 	 * vCPU is harmless other than the additional latency in completing
 	 * the unlock.
-- 
2.35.1


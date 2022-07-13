Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD40572EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiGMHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiGMHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B8BBD3B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso3255260pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIVi6szaPftFCT7jYhps4oIfP07eIgzoCYWVaDAqgoQ=;
        b=BFD/C46Q87ejWKOc9b/qlPNL9CZxExulinW0M9tXzfP5kj9IrthSOh9/uxRdhaPOfj
         Q8Q73ICx6+yBN7pFHe/q+Nsp/adJQZgF+pSXS0JSmaEkEFtA/UyQvgHQDGyGijwMjdwd
         sKfRXfLSzLL25IA8/EfuASHG6SlcCa/3CiOaZCWEL2fItVZFiOGE1zPY4ENgoONQ6V0i
         DIQp75cLnrCpP/ZSOWcDWTU2Sq5+3Vb9lWeCBH6VPyQy/JdZlvx1GOTlpm9OUivcCAhY
         g32pjLicdwrImEtEVimMLKCjBLcyNjxp0HWZBjcrYDieOtpLwW8Ly47sk2dEoOD6Y8En
         jNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIVi6szaPftFCT7jYhps4oIfP07eIgzoCYWVaDAqgoQ=;
        b=wWAVg2bZaWuiNa2iCRNCu1ZlinIl/LO9hbeTY/s/xSARF4MrQY4ZAtWc2tumXd0oAj
         xhNehwrFtsf8YmUhAJmb4L0HnpDbS+RcNTYjH2P634d6wIdH/b5RQ1MVGzWdazrRwoSb
         pdH2vjT704updSdlT2kik5cibnEMuVMJXFEPSRIIxbJgXiLInr8z1pTJmnDNaTEN/zrR
         oHt4OGWjYHi7404/QD2QZFA4fytgekXZ+99SzwNUs4sF4SI4aEPt0xSGV9FS705NCYqu
         2mI0f8oAp65ID5fDX4la80B5ZPYAza/7q43RJyQWDU8itgezdEGh+SunmUFr1n9SRlqi
         ULDQ==
X-Gm-Message-State: AJIora8Vx71g6Gr5So+eCvQU7L5TH6aDvdc6AYTJ57ZjHaA3eD8zhRqc
        I34kz0Kv2nj3R7k0xJclHJGhbsVNfrQ=
X-Google-Smtp-Source: AGRyM1sy3hCOh9JjKUCk6MzP07UHRkxvstO04sI7CRb3TdEYRMhUsRjqRLh0WqE97QHODrhezngF4A==
X-Received: by 2002:a17:902:c64b:b0:16b:d51a:dc24 with SMTP id s11-20020a170902c64b00b0016bd51adc24mr2096645pls.48.1657696035751;
        Wed, 13 Jul 2022 00:07:15 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/12] locking/qspinlock: remove pv_node abstraction
Date:   Wed, 13 Jul 2022 17:06:53 +1000
Message-Id: <20220713070704.308394-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713070704.308394-1-npiggin@gmail.com>
References: <20220713070704.308394-1-npiggin@gmail.com>
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

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          |  3 ++-
 kernel/locking/qspinlock_paravirt.h | 34 +++++++++++------------------
 2 files changed, 15 insertions(+), 22 deletions(-)

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
index e84d21aa0722..4efe00e6b441 100644
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
@@ -277,9 +271,7 @@ pv_wait_early(struct pv_node *prev, int loop)
  */
 static void pv_init_node(struct mcs_spinlock *node)
 {
-	struct pv_node *pn = (struct pv_node *)node;
-
-	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
+	struct qnode *pn = (struct qnode *)node;
 
 	pn->cpu = smp_processor_id();
 	pn->state = vcpu_running;
@@ -292,8 +284,8 @@ static void pv_init_node(struct mcs_spinlock *node)
  */
 static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
-	struct pv_node *pn = (struct pv_node *)node;
-	struct pv_node *pp = (struct pv_node *)prev;
+	struct qnode *pn = (struct qnode *)node;
+	struct qnode *pp = (struct qnode *)prev;
 	int loop;
 	bool wait_early;
 
@@ -359,7 +351,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
  */
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
-	struct pv_node *pn = (struct pv_node *)node;
+	struct qnode *pn = (struct qnode *)node;
 
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
@@ -402,7 +394,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 static u32
 pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 {
-	struct pv_node *pn = (struct pv_node *)node;
+	struct qnode *pn = (struct qnode *)node;
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
@@ -492,7 +484,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 __visible void
 __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 {
-	struct pv_node *node;
+	struct qnode *node;
 
 	if (unlikely(locked != _Q_SLOW_VAL)) {
 		WARN(!debug_locks_silent,
@@ -517,14 +509,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
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


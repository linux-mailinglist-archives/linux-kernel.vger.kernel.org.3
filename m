Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2114F2FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354511AbiDEKOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D8165BE;
        Tue,  5 Apr 2022 01:28:57 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6pZXD3P7oUaHEte6OjoQBfR3lW/GenPfAq6gmEimD4=;
        b=FKdeyqSF+ioZdoMYD3IwVUAy9SyCr6OL/SCjhFkNrzVvtl3bpGw5IdS9paQ4q1bO3m9Irv
        g1V0eVQmU60NKt5DWw2O10h4g9READRBcINXTU13UBq3CSGVP3/CBLT5SoPtz2afVJx1Ut
        atizriRxleAPRu7QE/Ycqaxh+7HlA8yKJ5dKdvm11sOTB6hjzlLZIwdbsCW7D1FJVM6btZ
        23GRxZRu00W/CBUY01rEnuYs1lsc4+5NFlNBwQ5lSWMNsOFaCZoBgrvYYTYeeLd7dyKYCY
        +VJS81E5cHiIcon6wh9qPZJCuoCgeYtYAptZC+Ymv4LYq6VWSTWR06LVDHhzaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6pZXD3P7oUaHEte6OjoQBfR3lW/GenPfAq6gmEimD4=;
        b=WrrOV3pOk7id4nXJyW9oD7TuXDRNJuadjEQGLnB66e7iHeHCcnXHZNFOecrJeQFXpuXWQu
        MS8wdljH2CQiLsDQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] Revert "locking/local_lock: Make the empty
 local_lock_*() function a macro."
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220328145810.86783-3-bigeasy@linutronix.de>
References: <20220328145810.86783-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164914733560.389.4348720137580970504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     2d2f8f083ef29e9b7adfe5cb421368331543473f
Gitweb:        https://git.kernel.org/tip/2d2f8f083ef29e9b7adfe5cb421368331543473f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 28 Mar 2022 16:58:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:39 +02:00

Revert "locking/local_lock: Make the empty local_lock_*() function a macro."

With volatile removed from arch_raw_cpu_ptr() the compiler no longer
creates the per-CPU reference. The usage of the macro can be reverted
now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220328145810.86783-3-bigeasy@linutronix.de
---
 include/linux/local_lock_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 6d635e8..975e33b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -44,9 +44,9 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
-# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
-# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
-# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
+static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }

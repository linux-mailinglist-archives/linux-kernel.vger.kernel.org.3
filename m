Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030E55D41A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbiF1HJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiF1HJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:09:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E49FDD;
        Tue, 28 Jun 2022 00:09:14 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:09:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVeGRpc3zhspEbz6qIypSvGemS1lRtd39QVDZpmieXg=;
        b=27nXETW3BDguJUxEIk45jCyvqUjABnAJM3vwHiqCaidLjTAjylXqtOJy2IG+o/5q8jBa8T
        IwpW7OMu+WuRg9nQd/b96fzAujwSEw03l45YBN3Q1QJWk3e0ec0Y+4H3iCYRNQEt8i1eaa
        IP5MkPI1p+I8JRA6+rZOPdziH+iN5a7eqTLZnNCMdVnuPfmYBRpv2Fh2o6vje+rNt0yPsS
        f2jTZNWkP46bAY5goTl0bL7VwLgQ5H76/VyBHZa2KPjenz5uEboja/bR/x4dfiOFe85oxy
        vZt77QvGY2gXylQM8YTa3kn9ycZwt6uLLtIcJfxo+kHSm5W6NgxLNR1B0L+Axg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVeGRpc3zhspEbz6qIypSvGemS1lRtd39QVDZpmieXg=;
        b=kfVt+QHhow/WoxNyLEJEq+OeNMF7rvE/sbWcM/kkHBHOWe2GVHc3LfeEg7A3NawoJk/nHY
        ulCvH4JLyWvx5XDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Fix lockdep_init_map_*() confusion
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YqyEDtoan20K0CVD@worktop.programming.kicks-ass.net>
References: <YqyEDtoan20K0CVD@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165640015096.4207.1534716601746682191.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     eae6d58d67d9739be5f7ae2dbead1d0ef6528243
Gitweb:        https://git.kernel.org/tip/eae6d58d67d9739be5f7ae2dbead1d0ef6528243
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Jun 2022 15:26:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Jun 2022 09:48:56 +02:00

locking/lockdep: Fix lockdep_init_map_*() confusion

Commit dfd5e3f5fe27 ("locking/lockdep: Mark local_lock_t") added yet
another lockdep_init_map_*() variant, but forgot to update all the
existing users of the most complicated version.

This could lead to a loss of lock_type and hence an incorrect report.
Given the relative rarity of both local_lock and these annotations,
this is unlikely to happen in practise, still, best fix things.

Fixes: dfd5e3f5fe27 ("locking/lockdep: Mark local_lock_t")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YqyEDtoan20K0CVD@worktop.programming.kicks-ass.net
---
 include/linux/lockdep.h  | 30 +++++++++++++++++-------------
 kernel/locking/lockdep.c |  7 ++++---
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b6829b9..1f1099d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -188,7 +188,7 @@ static inline void
 lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
 {
-	lockdep_init_map_type(lock, name, key, subclass, inner, LD_WAIT_INV, LD_LOCK_NORMAL);
+	lockdep_init_map_type(lock, name, key, subclass, inner, outer, LD_LOCK_NORMAL);
 }
 
 static inline void
@@ -211,24 +211,28 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
  * or they are too narrow (they suffer from a false class-split):
  */
 #define lockdep_set_class(lock, key)				\
-	lockdep_init_map_waits(&(lock)->dep_map, #key, key, 0,	\
-			       (lock)->dep_map.wait_type_inner,	\
-			       (lock)->dep_map.wait_type_outer)
+	lockdep_init_map_type(&(lock)->dep_map, #key, key, 0,	\
+			      (lock)->dep_map.wait_type_inner,	\
+			      (lock)->dep_map.wait_type_outer,	\
+			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_class_and_name(lock, key, name)		\
-	lockdep_init_map_waits(&(lock)->dep_map, name, key, 0,	\
-			       (lock)->dep_map.wait_type_inner,	\
-			       (lock)->dep_map.wait_type_outer)
+	lockdep_init_map_type(&(lock)->dep_map, name, key, 0,	\
+			      (lock)->dep_map.wait_type_inner,	\
+			      (lock)->dep_map.wait_type_outer,	\
+			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_class_and_subclass(lock, key, sub)		\
-	lockdep_init_map_waits(&(lock)->dep_map, #key, key, sub,\
-			       (lock)->dep_map.wait_type_inner,	\
-			       (lock)->dep_map.wait_type_outer)
+	lockdep_init_map_type(&(lock)->dep_map, #key, key, sub,	\
+			      (lock)->dep_map.wait_type_inner,	\
+			      (lock)->dep_map.wait_type_outer,	\
+			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_subclass(lock, sub)					\
-	lockdep_init_map_waits(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
-			       (lock)->dep_map.wait_type_inner,		\
-			       (lock)->dep_map.wait_type_outer)
+	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
+			      (lock)->dep_map.wait_type_inner,		\
+			      (lock)->dep_map.wait_type_outer,		\
+			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_novalidate_class(lock) \
 	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f06b91c..e2f1794 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5238,9 +5238,10 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 		return 0;
 	}
 
-	lockdep_init_map_waits(lock, name, key, 0,
-			       lock->wait_type_inner,
-			       lock->wait_type_outer);
+	lockdep_init_map_type(lock, name, key, 0,
+			      lock->wait_type_inner,
+			      lock->wait_type_outer,
+			      lock->lock_type);
 	class = register_lock_class(lock, subclass, 0);
 	hlock->class_idx = class - lock_classes;
 

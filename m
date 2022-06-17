Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496B54F86A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382222AbiFQNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381935AbiFQNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:39:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE42035ABE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UxXwnBTVP+hXIdrxywvN/ZF4FUN+kuwYD7W1LwoNzUE=; b=VEqcQ2t043UltzkOLxCjThX5NC
        4HtFZnxQs60JKp8jg5YP/6eLMz0gVkW2XHCl7F/2jiqeBHEtRKnBJFq+BcgjOcy+L2nEs8Bhtzpg0
        LuqwhHrQlqJzMAM3ZaUQWhbt19eGZCy65/EHLewTypq+LCSnqjOVO8zWDcbR6kahgW+B7eo4sTs1l
        ZcXwQBLcXtcY/PlFdf8zxChI4bhFeCWIzP8si6AsuOTUNUO3QF9neDCGLOaRexgjM2fMldn3XmPoo
        Cvd2eFZdsNosupWkoYgdD1UDN2TH7GBYlv9Kvh4t0I/A1HQBZbOBw6XERRGZPlZ1vwfil7khCouuR
        V086A++A==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2CC6-008hZD-NF; Fri, 17 Jun 2022 13:39:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52EB69816B5; Fri, 17 Jun 2022 15:39:26 +0200 (CEST)
Date:   Fri, 17 Jun 2022 15:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] locking/lockdep: Fix lockdep_init_map_*() confusion
Message-ID: <YqyEDtoan20K0CVD@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit dfd5e3f5fe27 ("locking/lockdep: Mark local_lock_t") added yet
another lockdep_init_map_*() variant, but forgot to update all the
existing users of the most complicated version.

This could lead to a loss of lock_type and hence an incorrect report.
Given the relative rarity of both local_lock and these annotations,
this is unlikely to happen in practise, still, best fix things.

Fixes: dfd5e3f5fe27 ("locking/lockdep: Mark local_lock_t")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/lockdep.h  |   30 +++++++++++++++++-------------
 kernel/locking/lockdep.c |    7 ++++---
 2 files changed, 21 insertions(+), 16 deletions(-)

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
@@ -211,24 +211,28 @@ static inline void lockdep_init_map(stru
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
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5238,9 +5238,10 @@ __lock_set_class(struct lockdep_map *loc
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
 

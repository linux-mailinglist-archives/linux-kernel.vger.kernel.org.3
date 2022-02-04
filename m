Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7604AA482
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378376AbiBDXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39422 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378267AbiBDXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 929A3B83976;
        Fri,  4 Feb 2022 23:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFF6C34104;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=B3ldLUHX3CEZ1V3crg0anclvyymU/4MkEs5XFCophWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqWN18zcs/lhFJxDxrLLN0UUifOkhaNMImXVXjJDP5G6zvNlMwgMAN9qrYoSdfdu8
         xQlCTInpa6eYhzEKPi0f3lx0OrRRoKisPEU8eT6akFIDeTiEU/o7nVhO9FZm1AVbCv
         W/+Jg9FhPlALnAiyktKBHlEOK8gCx3OEi/F8GQczqQ5iHNcRsz4gtTwYY6Iv47tWXQ
         jzYTySAQ7qOpEb+YcFF0R1zD4y13VhoEF7O+3CUTLioQr6kSc2nA5NB+S68eLIrJIY
         ddg/veNR55yb4+DKy5f6pDBC7G6lsPem0DsPzYsI2caOAArfOpgrJaKyptQwp3GyQx
         jHkg9DlPJ1TeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E7935C10CE; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/19] srcu: Create concurrency-safe helper for initiating size transition
Date:   Fri,  4 Feb 2022 15:38:58 -0800
Message-Id: <20220204233902.1902-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once there are contention-initiated size transitions, it will be
possible for rcutorture to initiate a transition at the same time
as a contention-initiated transition.  This commit therefore creates
a concurrency-safe helper function named srcu_transition_to_big() to
safely initiate size transitions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d16104405c8f9..5eee113531cdc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -262,6 +262,25 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+/*
+ * Initiate an idempotent transition to SRCU_SIZE_BIG.
+ */
+static void srcu_transition_to_big(struct srcu_struct *ssp)
+{
+	unsigned long flags;
+
+	/* Double-checked locking on ->srcu_size-state. */
+	if (smp_load_acquire(&ssp->srcu_size_state) != SRCU_SIZE_SMALL)
+		return;
+	spin_lock_irqsave_rcu_node(ssp, flags);
+	if (smp_load_acquire(&ssp->srcu_size_state) != SRCU_SIZE_SMALL) {
+		spin_unlock_irqrestore_rcu_node(ssp, flags);
+		return;
+	}
+	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+	spin_unlock_irqrestore_rcu_node(ssp, flags);
+}
+
 /*
  * First-use initialization of statically allocated srcu_struct
  * structure.  Wiring up the combining tree is more than can be
@@ -1496,8 +1515,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 2)
-		WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+	if (convert_to_big == 2)
+		srcu_transition_to_big(ssp);
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.31.1.189.g2e36527f23


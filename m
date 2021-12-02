Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646B5465ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbhLBAeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354281AbhLBAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D78C06174A;
        Wed,  1 Dec 2021 16:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE616B82194;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C51FC634BA;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=81RWRinGuwUqHetp8mypFq7+tGh7b8+qWpURKMsoVvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fy4ELZmBp2sSu8AzLuMwL5/tBib4mgcCrlVhRnZixca8YTr18oCQG9Keaz8nowgE0
         Pa2rGKQjNtqKfgZIxqXJxNZiuANG1G+xdDjwjxM2ob2WmTCVI/WulY7Vt+yGEYEYYK
         9Kykw6pvF2LwYIjrtm181khF/cK5CH/dl8tyGz/WjCmRjopGboZ4QxxQfNgVDXQV2f
         ZgUa5fw50xLIKUkteO2wEnTegwdIjdb3fuw4BM4E/apbVk4kxV2G3OP4paH3/gquJ8
         upu/B9Fn5oplDtnFsGcyNLzuwmuz/OYIAViili1PQQY1uaJc5rl/bM4m7BjwG0/Kqc
         x8NEw5kSgZGeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 803FF5C14E6; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 18/18] rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and rcu_spawn_one_nocb_kthread()
Date:   Wed,  1 Dec 2021 16:29:12 -0800
Message-Id: <20211202002912.3127710-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The rcu_spawn_one_nocb_kthread() function is called only from
rcu_spawn_cpu_nocb_kthread().  Therefore, inline the former into
the latter, saving a few lines of code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0c1802ce4764c..eeafb546a7a09 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1233,12 +1233,15 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
  * for this CPU's group has not yet been created, spawn it as well.
  */
-static void rcu_spawn_one_nocb_kthread(int cpu)
+static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
 
+	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
+		return;
+
 	/* If there already is an rcuo kthread, then nothing to do. */
 	if (rdp->nocb_cb_kthread)
 		return;
@@ -1262,16 +1265,6 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
 
-/*
- * If the specified CPU is a no-CBs CPU that does not already have its
- * rcuo kthread, spawn it.
- */
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
-{
-	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
-		rcu_spawn_one_nocb_kthread(cpu);
-}
-
 /*
  * Once the scheduler is running, spawn rcuo kthreads for all online
  * no-CBs CPUs.  This assumes that the early_initcall()s happen before
-- 
2.31.1.189.g2e36527f23


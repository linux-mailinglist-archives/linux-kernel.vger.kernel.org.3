Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD28465A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354291AbhLBAYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354213AbhLBAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:24:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE48C06174A;
        Wed,  1 Dec 2021 16:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2256CB81876;
        Thu,  2 Dec 2021 00:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C38C53FD0;
        Thu,  2 Dec 2021 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404456;
        bh=i/KzPUNHL60gBTWtdLZg/XoOLnt0ASf1BDy1cw3toOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWjc/lIC76UYZB4ZXDmIcXR97U2s/LotsNXVXeQEHhkOp4YP67vriHdLmEp/B2/bA
         dUXHMUMpVwE/H+kbxuGezYdSFURwnhdYRirYzeClN/0hXnItCQCWzX7AUzzeiCaDVI
         PZa7yMV80m3MtLZD7a1SEFYBqS6NVjEebVZDd5kJmzEMtnQBjCilZIYNBVnbKQvuiT
         1L/hUzYUmAsDouSoJJeY1uRza8eqGRrdixyop8gRf0fCdEkpMQjeY4AgjZ73xQiDgK
         +ISnx2m1XOddVnag9yin2B7Ye9HWZGdgdO6xTByyqHzMTksNAX02VV2T3pbJj6uLzT
         Q/8UtKZTj6oIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 85F6B5C117F; Wed,  1 Dec 2021 16:20:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/6] rcu: Avoid running boost kthreads on isolated CPUs
Date:   Wed,  1 Dec 2021 16:20:53 -0800
Message-Id: <20211202002055.3127133-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

When the boost kthreads are created on systems with nohz_full CPUs,
the cpus_allowed_ptr is set to housekeeping_cpumask(HK_FLAG_KTHREAD).
However, when the rcu_boost_kthread_setaffinity() is called, the original
affinity will be changed and these kthreads can subsequently run on
nohz_full CPUs.  This commit makes rcu_boost_kthread_setaffinity()
restrict these boost kthreads to housekeeping CPUs.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f44580276fbdc..87fc4609b7563 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1203,8 +1203,9 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
+	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
 	if (cpumask_weight(cm) == 0)
-		cpumask_setall(cm);
+		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
 	set_cpus_allowed_ptr(t, cm);
 	free_cpumask_var(cm);
 }
-- 
2.31.1.189.g2e36527f23


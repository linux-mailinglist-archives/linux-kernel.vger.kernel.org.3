Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D51465B16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354752AbhLBAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:42:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56526 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354674AbhLBAmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 579ADCE2079;
        Thu,  2 Dec 2021 00:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E040C53FCC;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=KeQIn7+vkaoqVEa8zmlnuFtpV/bsFJN1Te8VM5lRYho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+UGy+jjgCTLV3E+Drl15eyQ9jq6MLKlz8hFJftPLcEAcK3x3e+Md5FxYcpEbLIaX
         5+gbl52dU6zOQLtjaE3F3TKa7rDEZ+QLjplJk6wd6eMXe81V+jnNFciaMsrMbNGvBu
         6yvip+YovSI2GydO4IKf6Zg/A2cGGpO3Kqv6yVQAc7FVcbwOBUGXGbwZwYLMJBoZME
         H8j/fCKU14XIpAq8QYgmJjgsY4DlnCzjyppMDwnl6/p5fN8Bgdc9B70gJecpUVTu9c
         jpXCfs7uJb2wvg4xvAb8aSqoUds9O5nPVp4ElQg+6sv7ekrYqzFSHVlXdsXwcnZqsb
         pJqva76cfQTJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42BA35C0FCD; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/18] rcu-tasks: Don't remove tasks with pending IPIs from holdout list
Date:   Wed,  1 Dec 2021 16:38:41 -0800
Message-Id: <20211202003858.3129628-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the check_all_holdout_tasks_trace() function removes all tasks
marked with ->trc_reader_checked from the holdout list, including those
with IPIs pending.  This means that the IPI handler might arrive at
a task that has already been removed from the list, which is at best
an accident waiting to happen.

This commit therefore avoids removing tasks with IPIs pending from
the holdout list.  This in turn means that the "if" condition in the
for_each_online_cpu() loop in rcu_tasks_trace_postgp() should always
evaluate to false, so a WARN_ON_ONCE() is added to check that.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7da3c81c3f59c..bd44cd4794d3d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1121,7 +1121,8 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 			trc_wait_for_one_reader(t, hop);
 
 		// If check succeeded, remove this task from the list.
-		if (READ_ONCE(t->trc_reader_checked))
+		if (smp_load_acquire(&t->trc_ipi_to_cpu) == -1 &&
+		    READ_ONCE(t->trc_reader_checked))
 			trc_del_holdout(t);
 		else if (needreport)
 			show_stalled_task_trace(t, firstreport);
@@ -1156,7 +1157,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 	// Yes, this assumes that CPUs process IPIs in order.  If that ever
 	// changes, there will need to be a recheck and/or timed wait.
 	for_each_online_cpu(cpu)
-		if (smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu)))
+		if (WARN_ON_ONCE(smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu))))
 			smp_call_function_single(cpu, rcu_tasks_trace_empty_fn, NULL, 1);
 
 	// Remove the safety count.
-- 
2.31.1.189.g2e36527f23


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D90552744
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbiFTWzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB1C1EACA;
        Mon, 20 Jun 2022 15:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B60C61494;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD4AC341F4;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=Ae1XGWlJ44DVd8D3WNGeqcDVwLoT9rBUL+cKFL6UA5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eONaNce/xa9r4tl9WQa4xebw4o7y7PweEJtupd8KZyO7lmM3mqQlo/v8iJTkWP2q5
         3lTDvY5vkyzodGbjRT/DFMi+VXW5vBLt8HMJ5WEM+GfqmptUPl5rJjgnY1XSi3whVg
         3i5VrB8fXBkzMy96J7ViLdezkwEn5Qdo8kVWhMt+YzEB/htEaGe1elu0duJkg1iqR2
         bamRN6B8pDlp22OfUCH3bn20HnJ434XvGsc0SiWHQW0vl4sw3NSrPxi+HchBIgpI4g
         etkO2+TT4amPdcoqWnMkAgnsQkc1yuWrQAyI01QHWBCj/cs0OL70MxKINlpN+bI1J+
         SnW24vwDWY46w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A29A5C1642; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 26/32] rcu-tasks: Stop RCU Tasks Trace from scanning full tasks list
Date:   Mon, 20 Jun 2022 15:54:05 -0700
Message-Id: <20220620225411.3842519-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit takes off the training wheels and relies only on scanning
currently running tasks and tasks that have blocked or been preempted
within their current RCU Tasks Trace read-side critical section.

Before this commit, the time complexity of an RCU Tasks Trace grace
period is O(T), where T is the number of tasks.  After this commit,
this time complexity is O(C+B), where C is the number of CPUs and B
is the number of tasks that have blocked (or been preempted) at least
once during their current RCU Tasks Trace read-side critical sections.
Of course, if all tasks have blocked (or been preempted) at least once
during their current RCU Tasks Trace read-side critical sections, this is
still O(T), but current expectations are that RCU Tasks Trace read-side
critical section will be short and that there will normally not be large
numbers of tasks blocked within such a critical section.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 272c905995e56..fe0552086ccfc 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -670,10 +670,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	 * and make a list of them in holdouts.
 	 */
 	set_tasks_gp_state(rtp, RTGS_SCAN_TASKLIST);
-	rcu_read_lock();
-	for_each_process_thread(g, t)
-		rtp->pertask_func(t, &holdouts);
-	rcu_read_unlock();
+	if (rtp->pertask_func) {
+		rcu_read_lock();
+		for_each_process_thread(g, t)
+			rtp->pertask_func(t, &holdouts);
+		rcu_read_unlock();
+	}
 
 	set_tasks_gp_state(rtp, RTGS_POST_SCAN_TASKLIST);
 	rtp->postscan_func(&holdouts);
@@ -1746,7 +1748,6 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 			rcu_tasks_trace.init_fract = 1;
 	}
 	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
-	rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
 	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
 	rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
 	rcu_tasks_trace.postgp_func = rcu_tasks_trace_postgp;
-- 
2.31.1.189.g2e36527f23


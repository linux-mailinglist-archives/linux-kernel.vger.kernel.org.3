Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57D552740
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbiFTWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344851AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F891F61A;
        Mon, 20 Jun 2022 15:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B54AB81661;
        Mon, 20 Jun 2022 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284F5C341F5;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=3k+x6k9M3pDkvdWX0R8hRxdi0IEw/duPPbgwdatd52A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9sRBsbvNeaZmkprtb5MQCatRRaQtyXrMz4p4u5tjG7Gdr1CKE7ZN2v9pUKBeIy1c
         uxomp2SYoFdj5UWH3WKtT1wvQVC30AHrc7ezsP467OnHEBgqIUKk62VYcclQn4MevN
         hJq6t0GwNIz5Ca4vrXiMTAnbbtyChqzgKY8Gds22P7wS5q6nvP5yfTvr6z4NW0Uqr+
         VgoGwStvQMwglVLFdCtE5vmVcx0hrLI50G2QlD5LAzyW/8qQR9sL3gNgHcgqu7nYyY
         9n2446lTyxdBjefpN9rqO9ODK0q2lwksCXDn7FN1f4MWRiAhJbVIeRkkYdJAup+GMu
         SjsAjz2z81P8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57F745C1503; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 25/32] rcu-tasks: Stop RCU Tasks Trace from scanning idle tasks
Date:   Mon, 20 Jun 2022 15:54:04 -0700
Message-Id: <20220620225411.3842519-25-paulmck@kernel.org>
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

Now that RCU scans both running tasks and tasks that have blocked within
their current RCU Tasks Trace read-side critical section, there is no
need for it to scan the idle tasks.  After all, an idle loop should not
be remain within an RCU Tasks Trace read-side critical section across
exit from idle, and from a BPF viewpoint, functions invoked from the
idle loop should not sleep.  So only running idle tasks can be within
RCU Tasks Trace read-side critical sections.

This commit therefore removes the scan of the idle tasks from the
rcu_tasks_trace_postscan() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d318cdfd2309c..272c905995e56 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1533,16 +1533,10 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 }
 
 /*
- * Do intermediate processing between task and holdout scans and
- * pick up the idle tasks.
+ * Do intermediate processing between task and holdout scans.
  */
 static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
-	int cpu;
-
-	for_each_online_cpu(cpu)
-		rcu_tasks_trace_pertask(idle_task(cpu), hop);
-
 	// Re-enable CPU hotplug now that the tasklist scan has completed.
 	cpus_read_unlock();
 
-- 
2.31.1.189.g2e36527f23


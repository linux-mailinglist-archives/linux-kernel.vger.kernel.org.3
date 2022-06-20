Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917455274E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbiFTW4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631951F2C8;
        Mon, 20 Jun 2022 15:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DD9AB81657;
        Mon, 20 Jun 2022 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C7C341F2;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=iwrkhxaTrr4pY/p9WpMDJQWs1AuJORTLB16HzOpGip4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAbpC7j4bJLHm+LUR9yc5XOCJjsqRCnq6VCtADUW+kDUOu4h3Efqgw2wS669EBqW7
         VOyiUTObpDLlIFwQ1uecT5S9w637t/zBg00MB+2ktga0nKb1655o/uxwt6ldfmn4Nj
         LlufiOhDAovAx7+GZNzE2aDk1iX8e5BKd8FRT651TqyLXvoLKM5Bs8FXO3Biwnu1Yr
         8zpjoYkirndZ2Z3O0csXaw0btm2OHioVpjFoSG9VNDlGcjqB/KqVekkqiGOiQeLMvS
         +xDO/B6NH8h96Wd3dAB7l3WfGGMY0bSAEGKV84oI0Az1XHu8uHVSTiPrgUcrPnNA9V
         Rv076S+/Dpj+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 503C55C12AC; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 21/32] rcu-tasks: Move rcu_tasks_trace_pertask() before rcu_tasks_trace_pregp_step()
Date:   Mon, 20 Jun 2022 15:54:00 -0700
Message-Id: <20220620225411.3842519-21-paulmck@kernel.org>
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

This is a code-motion-only commit that moves rcu_tasks_trace_pertask()
to precede rcu_tasks_trace_pregp_step(), so that the latter will be
able to invoke the other without forward references.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6f4b89f9517ef..66d8473f1bda1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1449,20 +1449,6 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	}
 }
 
-/* Initialize for a new RCU-tasks-trace grace period. */
-static void rcu_tasks_trace_pregp_step(void)
-{
-	int cpu;
-
-	// There shouldn't be any old IPIs, but...
-	for_each_possible_cpu(cpu)
-		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
-
-	// Disable CPU hotplug across the tasklist scan.
-	// This also waits for all readers in CPU-hotplug code paths.
-	cpus_read_lock();
-}
-
 /* Do first-round processing for the specified task. */
 static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
@@ -1478,6 +1464,20 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 	trc_wait_for_one_reader(t, hop);
 }
 
+/* Initialize for a new RCU-tasks-trace grace period. */
+static void rcu_tasks_trace_pregp_step(void)
+{
+	int cpu;
+
+	// There shouldn't be any old IPIs, but...
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
+
+	// Disable CPU hotplug across the tasklist scan.
+	// This also waits for all readers in CPU-hotplug code paths.
+	cpus_read_lock();
+}
+
 /*
  * Do intermediate processing between task and holdout scans and
  * pick up the idle tasks.
-- 
2.31.1.189.g2e36527f23


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7855274C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345607AbiFTW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192BA1EEF0;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5935F6146E;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433B4C36B1D;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=rWblQhEfDrM9KVaYDxpkRZ5fchiKMAaJqhtVNh/zroI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opB1Jp3WmERnd9OK7Fpjh6N3bfsZiIpCPK+GH2JzGuqiPpZgss7G3m1qhdOa2rSCx
         oTLgatmoURR08NZAoQ4v+gZyH5lR4q5cg84cEXeqEW/eqBgItykV+MYtkNQc5V29Aw
         doqyK54XpFhyEdMeZxJ2D30KIuzmYpd8fUhHiSUPymtF9/Wd0qG6RMYWnlmqwY91Le
         CVUf7di4O5ECjCg5dPZUEsaE4BRLtDtcXxQxVBK5+F7uYDKolLjwu8K0Wq+mFNoETh
         ebq7vx8SXUU5AiELOSm/3vLwcOSyk1UeXYJKs5SZmFhqGsDJcdHCNlU217Hm6bZNYB
         BcSmsymMX0VSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 639ED5C2B14; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 31/32] rcu-tasks: Be more patient for RCU Tasks boot-time testing
Date:   Mon, 20 Jun 2022 15:54:10 -0700
Message-Id: <20220620225411.3842519-31-paulmck@kernel.org>
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

The RCU-Tasks family of grace-period primitives can take some time to
complete, and the amount of time can depend on the exact hardware and
software configuration.  Some configurations boot up fast enough that the
RCU-Tasks verification process gets false-positive failures.  This commit
therefore allows up to 30 seconds for the grace periods to complete, with
this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
kernel boot parameter.

Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 kernel/rcu/tasks.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index df6b2cb2f205d..fcbd0ec33c866 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
 module_param(rcu_task_ipi_delay, int, 0644);
 
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
+#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
@@ -1776,23 +1777,24 @@ struct rcu_tasks_test_desc {
 	struct rcu_head rh;
 	const char *name;
 	bool notrun;
+	unsigned long runstart;
 };
 
 static struct rcu_tasks_test_desc tests[] = {
 	{
 		.name = "call_rcu_tasks()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
 	},
 	{
 		.name = "call_rcu_tasks_rude()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
 	},
 	{
 		.name = "call_rcu_tasks_trace()",
 		/* If not defined, the test is skipped. */
-		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+		.notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
 	}
 };
 
@@ -1803,23 +1805,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 	pr_info("Callback from %s invoked.\n", rttd->name);
 
-	rttd->notrun = true;
+	rttd->notrun = false;
 }
 
 static void rcu_tasks_initiate_self_tests(void)
 {
+	unsigned long j = jiffies;
+
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
+	tests[0].runstart = j;
 	synchronize_rcu_tasks();
 	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_RUDE_RCU
+	tests[1].runstart = j;
 	synchronize_rcu_tasks_rude();
 	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
+	tests[2].runstart = j;
 	synchronize_rcu_tasks_trace();
 	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
 #endif
@@ -1829,11 +1836,18 @@ static int rcu_tasks_verify_self_tests(void)
 {
 	int ret = 0;
 	int i;
+	unsigned long bst = rcu_task_stall_timeout;
 
+	if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
+		bst = RCU_TASK_BOOT_STALL_TIMEOUT;
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (!tests[i].notrun) {		// still hanging.
-			pr_err("%s has been failed.\n", tests[i].name);
-			ret = -1;
+		while (tests[i].notrun) {		// still hanging.
+			if (time_after(jiffies, tests[i].runstart + bst)) {
+				pr_err("%s has failed boot-time tests.\n", tests[i].name);
+				ret = -1;
+				break;
+			}
+			schedule_timeout_uninterruptible(1);
 		}
 	}
 
-- 
2.31.1.189.g2e36527f23


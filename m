Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1F552764
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbiFTXAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345967AbiFTW7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF84E193C3;
        Mon, 20 Jun 2022 15:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8348A614A0;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE329C341C7;
        Mon, 20 Jun 2022 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765899;
        bh=7T945rjfPE1roz9rM5sVM/SGODfonE0cS+rIR4bWmLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWJoZX9jcu5Z+1c1WVJcgazXQpf+FgL9oxi1k/411+NYjDCIcDvA+CEP922vPjHOI
         hqSwfWV4pzPVne9VEdpLWhs3U09Pl315fq7BLBHwLJzLp4Ste4oXq8EyILYN/UTvc4
         qTCn/1g+TPuHQ+gYw0ZhCEtqnfU+SyLvhmntUX1OPSJ6fnK0uChWM3lu+JDFQ73C58
         cNMNVSuB4UfMbEAp7hgzam1Xb4GI34l3j5ogOfXactyKIpGmNzibCH8PtQPWcfICE1
         7rONs9CG/pY1Rl1eNHS+JZtiWLENehGA5a2Eff2yruQZ/DBekE1zaC6Ezp9eOp5eBu
         JdQZ4nTCiMpgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9991F5C0A15; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/12] rcutorture: Simplify rcu_torture_read_exit_child() loop
Date:   Mon, 20 Jun 2022 15:58:08 -0700
Message-Id: <20220620225817.3843106-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
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

The existing loop has an implicit manual loop that obscures the flow
and requires an extra control variable.  This commit makes this implicit
loop explicit, thus saving several lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 47 ++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3032dd7c7ad35..9273264772b88 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2874,7 +2874,6 @@ static int rcu_torture_read_exit_child(void *trsp_in)
 // Parent kthread which creates and destroys read-exit child kthreads.
 static int rcu_torture_read_exit(void *unused)
 {
-	int count = 0;
 	bool errexit = false;
 	int i;
 	struct task_struct *tsp;
@@ -2886,34 +2885,28 @@ static int rcu_torture_read_exit(void *unused)
 
 	// Each pass through this loop does one read-exit episode.
 	do {
-		if (++count > read_exit_burst) {
-			VERBOSE_TOROUT_STRING("rcu_torture_read_exit: End of episode");
-			rcu_barrier(); // Wait for task_struct free, avoid OOM.
-			for (i = 0; i < read_exit_delay; i++) {
-				schedule_timeout_uninterruptible(HZ);
-				if (READ_ONCE(read_exit_child_stop))
-					break;
+		VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of episode");
+		for (i = 0; i < read_exit_burst; i++) {
+			if (READ_ONCE(read_exit_child_stop))
+				break;
+			stutter_wait("rcu_torture_read_exit");
+			// Spawn child.
+			tsp = kthread_run(rcu_torture_read_exit_child,
+					  &trs, "%s", "rcu_torture_read_exit_child");
+			if (IS_ERR(tsp)) {
+				TOROUT_ERRSTRING("out of memory");
+				errexit = true;
+				break;
 			}
-			if (!READ_ONCE(read_exit_child_stop))
-				VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of episode");
-			count = 0;
-		}
-		if (READ_ONCE(read_exit_child_stop))
-			break;
-		// Spawn child.
-		tsp = kthread_run(rcu_torture_read_exit_child,
-				     &trs, "%s",
-				     "rcu_torture_read_exit_child");
-		if (IS_ERR(tsp)) {
-			TOROUT_ERRSTRING("out of memory");
-			errexit = true;
-			tsp = NULL;
-			break;
+			cond_resched();
+			kthread_stop(tsp);
+			n_read_exits ++;
 		}
-		cond_resched();
-		kthread_stop(tsp);
-		n_read_exits ++;
-		stutter_wait("rcu_torture_read_exit");
+		VERBOSE_TOROUT_STRING("rcu_torture_read_exit: End of episode");
+		rcu_barrier(); // Wait for task_struct free, avoid OOM.
+		i = 0;
+		for (; !errexit && !READ_ONCE(read_exit_child_stop) && i < read_exit_delay; i++)
+			schedule_timeout_uninterruptible(HZ);
 	} while (!errexit && !READ_ONCE(read_exit_child_stop));
 
 	// Clean up and exit.
-- 
2.31.1.189.g2e36527f23


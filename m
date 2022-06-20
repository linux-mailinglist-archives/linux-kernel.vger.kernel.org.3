Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB585526E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiFTWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiFTWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C501BE84;
        Mon, 20 Jun 2022 15:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF04612CB;
        Mon, 20 Jun 2022 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F37C341D2;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=RTEIPBwPDlTk/wfRVgO+sMnshOl2v68/BsPmAdRqgA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVTv4oRPty53ozzQCLwdvLNHv0onjmR7Ti37QakgvcZgNLzAKpyV9yGWnXJ9lMHnF
         KZ0HU2EvWxYqd9G3hIYjlYLYsij4Lfw4/FbqdGiTE5t/juLsbjhdWIoqGqF8odxxuy
         p4VYuVMXhC4P8HVFyunc33iVUdjAL2dXvSqhO9OGLioMBGKhADFtMSetHsnKT0ISJG
         bTdgC+kk2W0zRWDRjvDJEwkLiGc2IeH8OU8QEi/PAcgM/JPgz1XnLsR49k5C6FPQPq
         HDYo0lHibPVxDwQ0fgM0VOZ4LJ0x3h/yvZcMQ4JYMLpNjHzIZiFoVJfOB7bQddd+C0
         aQgZDRftBMTVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 105BE5C0DEB; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/12] rcu/tree: Add comment to describe GP-done condition in fqs loop
Date:   Mon, 20 Jun 2022 15:20:31 -0700
Message-Id: <20220620222032.3839547-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
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

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7d8e9cb852786..cdffb3b60ee02 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2005,7 +2005,15 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		rcu_gp_torture_wait();
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
-		/* If grace period done, leave loop. */
+		/*
+		 * Exit the loop if the root rcu_node structure indicates that the grace period
+		 * has ended, leave the loop.  The rcu_preempt_blocked_readers_cgp(rnp) check
+		 * is required only for single-node rcu_node trees because readers blocking
+		 * the current grace period are queued only on leaf rcu_node structures.
+		 * For multi-node trees, checking the root node's ->qsmask suffices, because a
+		 * given root node's ->qsmask bit is cleared only when all CPUs and tasks from
+		 * the corresponding leaf nodes have passed through their quiescent state.
+		 */
 		if (!READ_ONCE(rnp->qsmask) &&
 		    !rcu_preempt_blocked_readers_cgp(rnp))
 			break;
-- 
2.31.1.189.g2e36527f23


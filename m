Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F075A853E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiHaSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiHaSNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC9EE688;
        Wed, 31 Aug 2022 11:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6C93B82278;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0302CC43149;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=uX+u9GKdyE2AQiItmDVWhHTOMh+xCLFHSEjTFY425bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qL+Jgv4Y15uAqUDdI9TZgl2bKNZ1UONu0gGuQfEcvQvSGYthPgabeWJaHJXRPmNLu
         J9Y/Do3bFssP0BHL16SwDI4m2LyIBKSOEzi41S4PgrCMFvTvjf1yrRXWofdvGC4yvh
         SMGB+G+lKyEyu4ufh0Ou0WgeBAGWIFL9KQlx70t6DUFq7iYgnRUaGvw0XmnogVpubi
         NrvFwWeMg+KHo3hDNQJ/nGRE4gPh0GWd/T860vm04EaPRe2O4mq3ggbYVgj2tw2L68
         1LHS3CrkO4Wr/3aaSK7sMiEBN8tecIPix3gv1J5DF1VeEJbXS574Xx59gXdiAxgSkZ
         c0Qa82ob0dJhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 647A55C0950; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/25] rcutorture: Verify long-running reader prevents full polling from completing
Date:   Wed, 31 Aug 2022 11:11:52 -0700
Message-Id: <20220831181210.2695080-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds full-state polling checks to accompany the old-style
polling checks in the rcu_torture_one_read() function.  If a polling
cycle within an RCU reader completes, a WARN_ONCE() is triggered.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 236bd6b57277f..3d85420108477 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1770,6 +1770,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
 static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
 	unsigned long cookie;
+	struct rcu_gp_oldstate cookie_full;
 	int i;
 	unsigned long started;
 	unsigned long completed;
@@ -1787,6 +1788,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
 	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
 		cookie = cur_ops->get_gp_state();
+	if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
+		cur_ops->get_gp_state_full(&cookie_full);
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
@@ -1827,6 +1830,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 			  rcu_torture_writer_state_getname(),
 			  rcu_torture_writer_state,
 			  cookie, cur_ops->get_gp_state());
+	if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
+		WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
+			  "%s: Cookie check 6 failed %s(%d) online %*pbl\n",
+			  __func__,
+			  rcu_torture_writer_state_getname(),
+			  rcu_torture_writer_state,
+			  cpumask_pr_args(cpu_online_mask));
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
-- 
2.31.1.189.g2e36527f23


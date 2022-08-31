Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B75A854C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiHaSQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiHaSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F4EA31B;
        Wed, 31 Aug 2022 11:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5974861C63;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1FEC43160;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=FckxDIfC5El2OqaWesfPy5RPaKRRdDuIXx9ES9lRUp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6LUYnVSjbw66FR4A9plBc3in+qKuwp8ICUSBQ4EK4TPPxiCxyFyg3WTiH/VQ9Uk9
         LyX91cRg5vYB+Z3N10yiHpIHpp5lObGg+upVLVUFOfmW9HiuFF68+3hhCb/pPThnSn
         eaFm7tTqqovfFE1NRHVL0f6tICSIqdvnuFUr0kVTJfOhD8SLt3G9KhEyGndm2uUozY
         3UjPG6AWWLITF3qWnsPfT4Uqm158AqzdGcZTSqxpQ5uOB7ltYB/95bL1qAmGJ734lA
         KRn0+ZZjR40cXUnm4p/6EAyDtXb9C7hxQVtLmBh5OeuVo895mb4UPnSSo91ItLNup5
         qBk21n8asI2CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 847EC5C0F13; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 25/25] rcutorture: Limit read-side polling-API testing
Date:   Wed, 31 Aug 2022 11:12:10 -0700
Message-Id: <20220831181210.2695080-25-paulmck@kernel.org>
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

RCU's polled grace-period API is reasonably lightweight, but still
contains heavyweight memory barriers.  This commit therefore limits
testing of this API from rcutorture's readers in order to avoid the
false negatives that these heavyweight operations could provoke.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fe1836aad6466..91103279d7b4f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1903,6 +1903,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
+	bool checkpolling = !(torture_random(trsp) & 0xfff);
 	unsigned long cookie;
 	struct rcu_gp_oldstate cookie_full;
 	int i;
@@ -1920,10 +1921,12 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	WARN_ON_ONCE(!rcu_is_watching());
 	newstate = rcutorture_extend_mask(readstate, trsp);
 	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
-	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-		cookie = cur_ops->get_gp_state();
-	if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-		cur_ops->get_gp_state_full(&cookie_full);
+	if (checkpolling) {
+		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+			cookie = cur_ops->get_gp_state();
+		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
+			cur_ops->get_gp_state_full(&cookie_full);
+	}
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
@@ -1957,20 +1960,22 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
-	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-		WARN_ONCE(cur_ops->poll_gp_state(cookie),
-			  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
-			  __func__,
-			  rcu_torture_writer_state_getname(),
-			  rcu_torture_writer_state,
-			  cookie, cur_ops->get_gp_state());
-	if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-		WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
-			  "%s: Cookie check 6 failed %s(%d) online %*pbl\n",
-			  __func__,
-			  rcu_torture_writer_state_getname(),
-			  rcu_torture_writer_state,
-			  cpumask_pr_args(cpu_online_mask));
+	if (checkpolling) {
+		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+			WARN_ONCE(cur_ops->poll_gp_state(cookie),
+				  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
+				  __func__,
+				  rcu_torture_writer_state_getname(),
+				  rcu_torture_writer_state,
+				  cookie, cur_ops->get_gp_state());
+		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
+			WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
+				  "%s: Cookie check 6 failed %s(%d) online %*pbl\n",
+				  __func__,
+				  rcu_torture_writer_state_getname(),
+				  rcu_torture_writer_state,
+				  cpumask_pr_args(cpu_online_mask));
+	}
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
-- 
2.31.1.189.g2e36527f23


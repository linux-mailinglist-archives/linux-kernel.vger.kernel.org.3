Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215A5A854F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiHaSQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiHaSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:15:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C75F2437;
        Wed, 31 Aug 2022 11:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFB69B82012;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE3DC43470;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969531;
        bh=r7ITDQsToWIAnjiMtcCwlUOAgpHxXqPd8jbQE2qiT+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPE5z1X7II7GIIqBcigRZQVmmrBlB6uNqDnEW4nKnAf4uJvCnwW6HzFatBBPP7xGQ
         KlOSqPx8la/E+xIAGbISGpcBOLdFqR7wfKdeovKdWa8h7llPnc/tQXH9BAJwQir0QL
         SQa2l6juC0sUSHEw3y9Kh/TQ0VhtRI1MmNt4PTEFN9vNoE6FKB36sOzDqXPzafxYWZ
         fYllOYs0oYqbZCqwMQPIVEaB+pZ66nXN5b1SypRqWHGAzat4jvDa8ftui7QNlPlRdM
         qXjq9h8tDwbbvlLMN8ZREzBHMUlT0+tOinUC3a3du4W1HNMJ+rZXh7+T7t6fLUwqon
         lZ3lHLPsxsSSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D4685C02A9; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/25] rcutorture: Abstract synchronous and polled API testing
Date:   Wed, 31 Aug 2022 11:11:48 -0700
Message-Id: <20220831181210.2695080-3-paulmck@kernel.org>
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

This commit abstracts a do_rtws_sync() function that does synchronous
grace-period testing, but also testing the polled API 25% of the time
each for the normal and full-state variants of the polled API.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 48 ++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4f196ebce7f29..c3c94e343eb28 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1207,6 +1207,40 @@ static void rcu_torture_write_types(void)
 	}
 }
 
+/*
+ * Do the specified rcu_torture_writer() synchronous grace period,
+ * while also testing out the polled APIs.  Note well that the single-CPU
+ * grace-period optimizations must be accounted for.
+ */
+static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
+{
+	unsigned long cookie;
+	struct rcu_gp_oldstate cookie_full;
+	bool dopoll;
+	bool dopoll_full;
+	unsigned long r = torture_random(trsp);
+
+	dopoll = cur_ops->get_gp_state && cur_ops->poll_gp_state && !(r & 0x300);
+	dopoll_full = cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full && !(r & 0xc00);
+	if (dopoll || dopoll_full)
+		cpus_read_lock();
+	if (dopoll)
+		cookie = cur_ops->get_gp_state();
+	if (dopoll_full)
+		cur_ops->get_gp_state_full(&cookie_full);
+	if (dopoll || (!IS_ENABLED(CONFIG_TINY_RCU) && dopoll_full && num_online_cpus() <= 1))
+		sync();
+	sync();
+	WARN_ONCE(dopoll && !cur_ops->poll_gp_state(cookie),
+		  "%s: Cookie check 3 failed %pS() online %*pbl.",
+		  __func__, sync, cpumask_pr_args(cpu_online_mask));
+	WARN_ONCE(dopoll_full && !cur_ops->poll_gp_state_full(&cookie_full),
+		  "%s: Cookie check 4 failed %pS() online %*pbl",
+		  __func__, sync, cpumask_pr_args(cpu_online_mask));
+	if (dopoll || dopoll_full)
+		cpus_read_unlock();
+}
+
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure
  * for that pointed to by rcu_torture_current, freeing the old structure
@@ -1295,12 +1329,7 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_EXP_SYNC:
 				rcu_torture_writer_state = RTWS_EXP_SYNC;
-				if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-					cur_ops->get_gp_state_full(&cookie_full);
-				cur_ops->exp_sync();
-				cur_ops->exp_sync();
-				if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-					WARN_ON_ONCE(!cur_ops->poll_gp_state_full(&cookie_full));
+				do_rtws_sync(&rand, cur_ops->exp_sync);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_COND_GET:
@@ -1339,12 +1368,7 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_SYNC:
 				rcu_torture_writer_state = RTWS_SYNC;
-				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-					cookie = cur_ops->get_gp_state();
-				cur_ops->sync();
-				cur_ops->sync();
-				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-					WARN_ON_ONCE(!cur_ops->poll_gp_state(cookie));
+				do_rtws_sync(&rand, cur_ops->sync);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			default:
-- 
2.31.1.189.g2e36527f23


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550355A8553
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiHaSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiHaSQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:16:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08173EF9FB;
        Wed, 31 Aug 2022 11:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 320ACB8227A;
        Wed, 31 Aug 2022 18:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D4EC4347C;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=TwQvXPSEvLyzs2xgFi3POyva60hZdjGop9E3Q6E66NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIFl2jRYM/70ivwGtBc1NUThPZtbFDPC4tP4XsBJP3whZimUxtfZqLCXaGsWZEOKZ
         mvboeGMrwn80J1xnwsXJB0KaqL+SQiXyDQzJpST/dRjtKXftyqXUZCTKKrJSlNcZsA
         RPUVfvd0YK/h3WwxsAtJzhcSkX7PVhtGx+V1f+Elgq75dPS08csNSR90IbNIAREExC
         5mllniGYgQMqveB7u9EIvGzgRwcaBFy+hhmQC6sbZ3lbzmXiusGhzUOYcA/2eMq6VO
         dyBYvjXhm8Y33nqS+rAUBVPMjw6EveHIuyogYEIN1ZumZcZ9AYttvrMkZMFmPwbXjs
         9qSaYAPblZqkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 786FF5C0E4D; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 18/25] rcu: Make synchronize_rcu_expedited() fast path update .expedited_sequence
Date:   Wed, 31 Aug 2022 11:12:03 -0700
Message-Id: <20220831181210.2695080-18-paulmck@kernel.org>
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

This commit causes the early boot single-CPU synchronize_rcu_expedited()
fastpath to update the rcu_state structure's ->expedited_sequence
counter.  This will allow the full-state polled grace-period APIs to
detect all expedited grace periods without the need to track the special
combined polling-only counter, which is another step towards removing
the ->rgos_polled field from the rcu_gp_oldstate, thereby reducing its
size by one third.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a51f9301ebff..54e05d13d1512 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -906,6 +906,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 void synchronize_rcu_expedited(void)
 {
 	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
 	unsigned long s;
@@ -924,6 +925,11 @@ void synchronize_rcu_expedited(void)
 		// them, which allows reuse of ->gp_seq_polled_exp_snap.
 		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_exp_snap);
 		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_exp_snap);
+
+		local_irq_save(flags);
+		WARN_ON_ONCE(num_online_cpus() > 1);
+		rcu_state.expedited_sequence += (1 << RCU_SEQ_CTR_SHIFT);
+		local_irq_restore(flags);
 		return;  // Context allows vacuous grace periods.
 	}
 
-- 
2.31.1.189.g2e36527f23


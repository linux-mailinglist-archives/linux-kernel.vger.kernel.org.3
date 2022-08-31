Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051C05A853A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiHaSOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiHaSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52110EE68C;
        Wed, 31 Aug 2022 11:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4050D61C52;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA2AC433B5;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969531;
        bh=lGjQj8ju6x6Bd2aOFRSdBdocyUBg+wR7phTP2jd87CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD4K5eF/8njcGwvLirBVXLTX0qCqUHoySTfwh+m/Os4zQbvVkIKMlUDye3wHKHPdi
         fHt5+OR4ndXXaBeqOgPX2vA69kmmvfjSpMRdKJKUQfTBL/CLo3VLyGlUAfGjpLpBrU
         3GeNJ2etMtON7Rs2vKc2vURSZvZt99KqjlpX7ExYSrrnLp8kiHvMxN50LNXBsnq63V
         tW5zsgKxJQ3hXzmpVyxgVlbaCpeqBB7kdvGW4rghQKptev05uzKLT4LcvtZL0zYm0D
         QrKjYqpOFbiHwUYJUbFbXrC5g5U/EZcl8sMyVKYEE4b/Ks7YkYcnyDq8HAMHp5jNC3
         qH6gIqFHnZZ1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F2645C0513; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/25] rcutorture: Allow per-RCU-flavor polled double-GP check
Date:   Wed, 31 Aug 2022 11:11:49 -0700
Message-Id: <20220831181210.2695080-4-paulmck@kernel.org>
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

Only vanilla RCU needs a double grace period for its compressed
polled grace-period old-state cookie.  This commit therefore adds an
rcu_torture_ops per-flavor function ->poll_need_2gp to allow this check
to be adapted to the RCU flavor under test.  A NULL pointer for this
function says that doubled grace periods are never needed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c3c94e343eb28..f2564c7633a8a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -341,6 +341,7 @@ struct rcu_torture_ops {
 	unsigned long (*start_gp_poll)(void);
 	bool (*poll_gp_state)(unsigned long oldstate);
 	bool (*poll_gp_state_full)(struct rcu_gp_oldstate *rgosp);
+	bool (*poll_need_2gp)(bool poll, bool poll_full);
 	void (*cond_sync)(unsigned long oldstate);
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
@@ -492,6 +493,11 @@ static void rcu_sync_torture_init(void)
 	INIT_LIST_HEAD(&rcu_torture_removed);
 }
 
+static bool rcu_poll_need_2gp(bool poll, bool poll_full)
+{
+	return poll || (!IS_ENABLED(CONFIG_TINY_RCU) && poll_full && num_online_cpus() <= 1);
+}
+
 static struct rcu_torture_ops rcu_ops = {
 	.ttype			= RCU_FLAVOR,
 	.init			= rcu_sync_torture_init,
@@ -511,6 +517,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.start_gp_poll		= start_poll_synchronize_rcu,
 	.poll_gp_state		= poll_state_synchronize_rcu,
 	.poll_gp_state_full	= poll_state_synchronize_rcu_full,
+	.poll_need_2gp		= rcu_poll_need_2gp,
 	.cond_sync		= cond_synchronize_rcu,
 	.get_gp_state_exp	= get_state_synchronize_rcu,
 	.start_gp_poll_exp	= start_poll_synchronize_rcu_expedited,
@@ -1228,7 +1235,7 @@ static void do_rtws_sync(struct torture_random_state *trsp, void (*sync)(void))
 		cookie = cur_ops->get_gp_state();
 	if (dopoll_full)
 		cur_ops->get_gp_state_full(&cookie_full);
-	if (dopoll || (!IS_ENABLED(CONFIG_TINY_RCU) && dopoll_full && num_online_cpus() <= 1))
+	if (cur_ops->poll_need_2gp && cur_ops->poll_need_2gp(dopoll, dopoll_full))
 		sync();
 	sync();
 	WARN_ONCE(dopoll && !cur_ops->poll_gp_state(cookie),
-- 
2.31.1.189.g2e36527f23


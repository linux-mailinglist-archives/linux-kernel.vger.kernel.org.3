Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A45A8542
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiHaSO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiHaSNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4C9BB6F;
        Wed, 31 Aug 2022 11:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03E8FB82272;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8675C433C1;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969531;
        bh=DyK363f/EcwyWVPynsUrSkClS2ROgjWL4eqGiB2RdSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eo2tPBiPhNxIMOM2BJEyNr8O8h30B02X7HpkvHOi3btUul/SJ2+pkJDC2jKDKwA59
         erfM2dLW6Tj0tsQK0RJISHGdGivqwyAx9XiAAtuwISBHBanbb7BNANHJlG9L2hRf3V
         Qsg9Pd2fEyCFjNF/eTUouJg5OnwCvtoYAtXdAGWiEfEE+fml/puCOZX/Nd+INGSqsf
         J4PAhgGSUrTM2mflW0sJT+XeP/bn4b1UIZZyK8EchEYC4RkXdblKDHeq2VOiLkxoaW
         g+g36cu8CEyQDElstwQUsMN3+QF0Ir9qvZS4FPOPQV/xSN5TviCJoEU7lz51qctxDG
         WBWZKZuoGmmqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 60FAC5C06A7; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/25] rcutorture: Verify RCU reader prevents full polling from completing
Date:   Wed, 31 Aug 2022 11:11:50 -0700
Message-Id: <20220831181210.2695080-5-paulmck@kernel.org>
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

This commit adds a test to rcu_torture_writer() that verifies that a
->get_gp_state_full() and ->poll_gp_state_full() polled grace-period
sequence does not claim that a grace period elapsed within the confines
of the corresponding read-side critical section.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f2564c7633a8a..050f4d0a987ff 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1309,6 +1309,8 @@ rcu_torture_writer(void *arg)
 			atomic_inc(&rcu_torture_wcount[i]);
 			WRITE_ONCE(old_rp->rtort_pipe_count,
 				   old_rp->rtort_pipe_count + 1);
+
+			// Make sure readers block polled grace periods.
 			if (cur_ops->get_gp_state && cur_ops->poll_gp_state) {
 				idx = cur_ops->readlock();
 				cookie = cur_ops->get_gp_state();
@@ -1325,9 +1327,20 @@ rcu_torture_writer(void *arg)
 				}
 				cur_ops->readunlock(idx);
 			}
-			if (cur_ops->get_gp_completed_full && cur_ops->poll_gp_state_full) {
-				cur_ops->get_gp_completed_full(&cookie_full);
-				WARN_ON_ONCE(!cur_ops->poll_gp_state_full(&cookie_full));
+			if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full) {
+				idx = cur_ops->readlock();
+				cur_ops->get_gp_state_full(&cookie_full);
+				WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
+					  "%s: Cookie check 5 failed %s(%d) online %*pbl\n",
+					  __func__,
+					  rcu_torture_writer_state_getname(),
+					  rcu_torture_writer_state,
+					  cpumask_pr_args(cpu_online_mask));
+				if (cur_ops->get_gp_completed_full) {
+					cur_ops->get_gp_completed_full(&cookie_full);
+					WARN_ON_ONCE(!cur_ops->poll_gp_state_full(&cookie_full));
+				}
+				cur_ops->readunlock(idx);
 			}
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
 			case RTWS_DEF_FREE:
-- 
2.31.1.189.g2e36527f23


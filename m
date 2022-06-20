Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF18552713
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbiFTWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiFTWpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:45:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E19514022;
        Mon, 20 Jun 2022 15:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97E21CE179E;
        Mon, 20 Jun 2022 22:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9097AC341CA;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765105;
        bh=l+tebky4TEgEPH7xlL3vd3F/iKwURUSr+8Dhto1NkeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kn+fY/za3b/dCuWSJA3LIonsb2y/u0EDBpD5zGeNjIl3lsqa3Dxpo7WJgKFOgEpWh
         3ajx7V4PhKrfBK4X7FEMgGHeD5jeZGh5QiI0xgE+XZMMLlpvcldjaAWacRoxEq2k++
         KNCGrkFCHmKV0JAfSc00YFisAexYV19m4fafpkaADdlN8QVPD0F6UEgW1Ufo2IjI5L
         aUB+6vN47jNHPgCQejWZMGfQ37GFFeAQ04dzs6LBlxA1IeTxlDpvcyJSweoIFK1xmY
         YvXgPcmz3VZ4BlGDir2o7ei86JEl0qQE6CG8RX8fzQNjriyY9ULZTVSkwqhb45TNNu
         +vsJrPnfVrKCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F3A375C0BCC; Mon, 20 Jun 2022 15:45:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] rcu/nocb: Avoid polling when my_rdp->nocb_head_rdp list is empty
Date:   Mon, 20 Jun 2022 15:45:03 -0700
Message-Id: <20220620224503.3841196-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

Currently, if the 'rcu_nocb_poll' kernel boot parameter is enabled, all
rcuog kthreads enter polling mode.  However, if all of a given group
of rcuo kthreads correspond to CPUs that have been de-offloaded, the
corresponding rcuog kthread will nonetheless still wake up periodically,
unnecessarily consuming power and perturbing workloads.  Fortunately,
this situation is easily detected by the fact that the rcuog kthread's
CPU's rcu_data structure's ->nocb_head_rdp list is empty.

This commit saves power and avoids unnecessarily perturbing workloads
by putting an rcuog kthread to sleep during any time period when all of
its rcuo kthreads' CPUs are de-offloaded.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c0..a8f574d8850d2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -584,6 +584,14 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 	return ret;
 }
 
+static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
+{
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
+	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
+					!READ_ONCE(my_rdp->nocb_gp_sleep));
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+}
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -701,13 +709,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_idle(1);
+		if (list_empty(&my_rdp->nocb_head_rdp)) {
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			if (!my_rdp->nocb_toggling_rdp)
+				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+			/* Wait for any offloading rdp */
+			nocb_gp_sleep(my_rdp, cpu);
+		} else {
+			schedule_timeout_idle(1);
+		}
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
-		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
-				!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
-- 
2.31.1.189.g2e36527f23


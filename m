Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC724AA451
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378214AbiBDXY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbiBDXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0EDFC13F7;
        Fri,  4 Feb 2022 15:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C11E9B83976;
        Fri,  4 Feb 2022 23:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E16C340F7;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=VXP8VoUHOvneEifMGVYTGH44aYLtxxiEIdVb15Xe2Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLojOQH9n0ljY6gSgQseyW6vKL294dJgpjiOU4Vxt3ueIcnQvB1/GnTx6VGT0EQC2
         un7xVli6wtNGgs8tprBm1dB4y9opDKU51K7ZPFkLQwiUaMJ7oGUd+fP2k8MsV2CKMp
         WRBiF5KLV9SVyKsh/ipxKGnKQnOPvwSoHwFzFShpEz6/njukgYdUNM+Dk8bjOhcvrn
         G633QHVzGajPXPnoyU+15tGf9bY5awneHhqyr5kfm18T743u4vmBsR0GS6hnRhYhL6
         z9zi60UVvtPEicPT8aQtf8gqtIK2nMPp7SI9POjjYfx91Zf7mcJyIcrV+ocaWlAKtu
         n9ZR3J7p4oQsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB71D5C0A21; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Alison Chaiken <achaiken@aurora.tech>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/10] rcu: Elevate priority of offloaded callback threads
Date:   Fri,  4 Feb 2022 15:24:03 -0800
Message-Id: <20220204232406.814-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

When CONFIG_PREEMPT_RT=y, the rcutree.kthread_prio command-line
parameter signals initialization code to boost the priority of rcuc
callbacks to the designated value.  With the additional
CONFIG_RCU_NOCB_CPU=y configuration and an additional rcu_nocbs
command-line parameter, the callbacks on the listed cores are
offloaded to new rcuop kthreads that are not pinned to the cores whose
post-grace-period work is performed.  While the rcuop kthreads perform
the same function as the rcuc kthreads they offload, the kthread_prio
parameter only boosts the priority of the rcuc kthreads.  Fix this
inconsistency by elevating rcuop kthreads to the same priority as the rcuc
kthreads.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c      | 2 +-
 kernel/rcu/tree_nocb.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5bf0312f66760..9e4c5b281f003 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -153,7 +153,7 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
-/* rcuc/rcub kthread realtime priority */
+/* rcuc/rcub/rcuop kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index ea889cbfc3b95..547c41437c767 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1270,6 +1270,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		return;
+
+	if (kthread_prio)
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
-- 
2.31.1.189.g2e36527f23


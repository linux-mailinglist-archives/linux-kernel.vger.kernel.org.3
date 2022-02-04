Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A094AA450
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378141AbiBDXYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378110AbiBDXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1722DFC13F7;
        Fri,  4 Feb 2022 15:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D938B83971;
        Fri,  4 Feb 2022 23:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2871C340ED;
        Fri,  4 Feb 2022 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=xnhPzJ/bmGOHPfjmOwYiKQqr+09QnV28RTS3sYV19ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrysNh470JefdMAGjbfzB129wKp9vEiypUnHUgLKNUqqKoMkUtiDXg6Hbr/Vs+2Hn
         t/xK4m+odPRNoohWnMd5v05VtySKS11E+kwCDTpo3ICuqaoqIMevwcgeunFP/i5Adl
         oHSoZW0No9Z2pWp7BkbOLiAH4FPsE8HSPQzat74e2ZP4rUc5yHzxOq9BD9wI2l/3pd
         +7NF8ffahkZCG/f6L6NI0XGyjQsUvUk1nAZZyedOJcG1i79LQmSqYn9dflPydIj5Qy
         zO7SFvByANgwlEdtpyAsHu59ui84OGyOVbYe/KUDODnaTroJU/AhyN+wpM/njJ7WRG
         d8B8qXW5f0Ipw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1AE55C0829; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/10] rcu/nocb: Handle concurrent nocb kthreads creation
Date:   Fri,  4 Feb 2022 15:23:58 -0800
Message-Id: <20220204232406.814-2-paulmck@kernel.org>
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

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

When multiple CPUs in the same nocb gp/cb group concurrently
come online, they might try to concurrently create the same
rcuog kthread. Fix this by using nocb gp CPU's spawn mutex to
provide mutual exclusion for the rcuog kthread creation code.

[ paulmck: Whitespace fixes per kernel test robot feedback. ]

Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h      | 2 ++
 kernel/rcu/tree_nocb.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 486fc901bd085..24dd4b0d805f1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -203,6 +203,8 @@ struct rcu_data {
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
+	struct mutex nocb_gp_kthread_mutex; /* Exclusion for nocb gp kthread */
+					    /* spawning */
 
 	/* The following fields are used by call_rcu, hence own cacheline. */
 	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a09..1e40519d1a05a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1226,6 +1226,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 	rcu_cblist_init(&rdp->nocb_bypass);
+	mutex_init(&rdp->nocb_gp_kthread_mutex);
 }
 
 /*
@@ -1248,13 +1249,17 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 
 	/* If we didn't spawn the GP kthread first, reorganize! */
 	rdp_gp = rdp->nocb_gp_rdp;
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
 	if (!rdp_gp->nocb_gp_kthread) {
 		t = kthread_run(rcu_nocb_gp_kthread, rdp_gp,
 				"rcuog/%d", rdp_gp->cpu);
-		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__))
+		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
+			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 			return;
+		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 	}
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 
 	/* Spawn the kthread for this CPU. */
 	t = kthread_run(rcu_nocb_cb_kthread, rdp,
-- 
2.31.1.189.g2e36527f23


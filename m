Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7B4AA44D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378226AbiBDXYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378126AbiBDXYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2053DFC13F7;
        Fri,  4 Feb 2022 15:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A081CE24BF;
        Fri,  4 Feb 2022 23:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30028C340F6;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=LeUpGVYNzDBxeiIoq3od/ZlEdAcMblILIHqxQOTVUVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Feo7pgOZuZYf3v3lCGnTWyIC3IpqVgkWMiJCIPT9ll+FR3QukYD39DYeA3ewKE4cP
         pH7uxc62Lw/aFNXvcZzWxlAthCTGQ7sqreBiUyzbSw/lCRjUPCeEScw0x7+eItzUTf
         f13gxb/rnc2wqB9qWw4384rru6v7YE+oMOY1Er5WxUDl2aMZ0eHinIzf/McaxjCCMC
         pijg3fFVZ/WnHNOifM9AmSOkdnmr/4H1Qg00Eu4Xa5lzFGVFEnt6cwoqAR7asqAUzQ
         iHNxFx2EMk3u9PaAjVfjBl3QUbgsXhgmt2oKfwfi11xnAKkMh0ThNnxxcrkWWaLyQ/
         XtQXjWoO4NPHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C94C05C0A0A; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Alison Chaiken <achaiken@aurora.tech>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/10] rcu: Make priority of grace-period thread consistent
Date:   Fri,  4 Feb 2022 15:24:02 -0800
Message-Id: <20220204232406.814-6-paulmck@kernel.org>
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

The priority of RCU grace period threads is set to kthread_prio when
they are launched from rcu_spawn_gp_kthread().  The same is not true
of rcu_spawn_one_nocb_kthread().  Accordingly, add priority elevation
to rcu_spawn_one_nocb_kthread().

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1e40519d1a05a..ea889cbfc3b95 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1239,6 +1239,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
+	struct sched_param sp;
 
 	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
 		return;
@@ -1248,6 +1249,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 		return;
 
 	/* If we didn't spawn the GP kthread first, reorganize! */
+	sp.sched_priority = kthread_prio;
 	rdp_gp = rdp->nocb_gp_rdp;
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
 	if (!rdp_gp->nocb_gp_kthread) {
@@ -1258,6 +1260,8 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 			return;
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
+		if (kthread_prio)
+			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	}
 	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 
-- 
2.31.1.189.g2e36527f23


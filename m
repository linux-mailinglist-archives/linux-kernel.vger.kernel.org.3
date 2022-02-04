Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03EC4AA408
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378002AbiBDXIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58142 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377870AbiBDXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D00561B5F;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33539C340F8;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=gjHD7UwRzDJPLtTblEcUscAE/WgIgNPhdoq37BeV0NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BN+G5FV0a9W/VdPvUvOzcZe7dfcK1uFGKsNxkaSeO7pEg+w43hgMYVFdc2W4Gpw2C
         wyxnVT7TEk9dnADEqhQnDv2TmGZdp2VlqSEuHL70J4u6Zw+v4PhRLoskRpLB+bUth/
         ePZQe96G1r5lRfq3bxqoD9bLLSsQGlr10BBfw4zOvrLpV98L5ENQF3f0NcOOZXbEtL
         zlYJsidT/A//cMB+Q+0K+KA/S367nQeoxBOlGS4W/rNiecKwIdxHRECrUfuidql6/4
         WsgV0iYdY0/xyT8Zh3niT/dHa9d22HIk1U/AEIXXNJPp9zf/MB3VR03dATvK6XAvx3
         myr4cOGHT3SwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A5CCF5C0AEF; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Yury Norov <yury.norov@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 9/9] rcu: Replace cpumask_weight with cpumask_empty where appropriate
Date:   Fri,  4 Feb 2022 15:08:05 -0800
Message-Id: <20220204230805.4193767-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>

In some places, RCU code calls cpumask_weight() to check if any bit of a
given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h   | 4 ++--
 kernel/rcu/tree_plugin.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a09..f83c7b1d61103 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1169,7 +1169,7 @@ void __init rcu_init_nohz(void)
 	struct rcu_data *rdp;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
 		need_rcu_nocb_mask = true;
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
@@ -1348,7 +1348,7 @@ static void __init rcu_organize_nocb_kthreads(void)
  */
 void rcu_bind_current_to_nocb(void)
 {
-	if (cpumask_available(rcu_nocb_mask) && cpumask_weight(rcu_nocb_mask))
+	if (cpumask_available(rcu_nocb_mask) && !cpumask_empty(rcu_nocb_mask))
 		WARN_ON(sched_setaffinity(current->pid, rcu_nocb_mask));
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 07845dcd33c5e..efd0c87d2ffae 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1220,7 +1220,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
 	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
-	if (cpumask_weight(cm) == 0)
+	if (cpumask_empty(cm))
 		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
 	set_cpus_allowed_ptr(t, cm);
 	mutex_unlock(&rnp->boost_kthread_mutex);
-- 
2.31.1.189.g2e36527f23


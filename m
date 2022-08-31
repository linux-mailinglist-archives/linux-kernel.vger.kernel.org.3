Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44595A8531
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiHaSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiHaSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9242EF001;
        Wed, 31 Aug 2022 11:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67B661C41;
        Wed, 31 Aug 2022 18:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC76C433D7;
        Wed, 31 Aug 2022 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969446;
        bh=kCjYd6SW2FfEw+BYAxl3L5fePtwdhSgZpFPL5cC1jvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJVo505mOTBXh7FtbY5V/L6k+gz0akbWJR+WLo5kvnsWpliol/BkiYuu4TFtzTkCZ
         jKX8i6NJ/AgXajtP7xMCkwJ28iT45Iwa+UgRWDvvV6B4Evca7Df99ZO8H6XPqjAefv
         prqjIoZusDRZfJ+NxYtkuKZg6swrsiCOsgzTgf+PPiwbgUajU7bTZoGcz1XKZPMZbS
         d8RGxjxmhmPygucTlXxgdfCz8DJUE1Aras5HpXzpVCQQe+Alzr3UrqmlInBLpVs7wx
         STycCXcJmbtadNbelPj21X9A8eFTwh0Rql76Es8tnKffEZN5x80ZAppdwDQxGX1mn0
         HQEX06uVrC8iA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0C8255C02A9; Wed, 31 Aug 2022 11:10:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH rcu 3/3] rcu: Simplify rcu_init_nohz() cpumask handling
Date:   Wed, 31 Aug 2022 11:10:44 -0700
Message-Id: <20220831181044.2694488-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
Except that kernels booted without the rcu_nocbs= will not have
allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
its need_rcu_nocb_mask and offload_all local variables to track the
rcu_nocb and nohz_full state.

But there is a much simpler approach, namely creating a cpumask pointer
to track the default and then using cpumask_available() to check the
rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
and shortening the rcu_init_nohz() function.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef414845..c8167be2288fa 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1210,45 +1210,31 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
-	bool offload_all = false;
 	struct rcu_data *rdp;
+	const struct cpumask *cpumask = NULL;
 
 #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
-	if (!rcu_state.nocb_is_setup) {
-		need_rcu_nocb_mask = true;
-		offload_all = true;
-	}
-#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
-
-#if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
-		need_rcu_nocb_mask = true;
-		offload_all = false; /* NO_HZ_FULL has its own mask. */
-	}
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
+	cpumask = cpu_possible_mask;
+#elif defined(CONFIG_NO_HZ_FULL)
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+		cpumask = tick_nohz_full_mask;
+#endif
 
-	if (need_rcu_nocb_mask) {
+	if (cpumask) {
 		if (!cpumask_available(rcu_nocb_mask)) {
 			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
 				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
 				return;
 			}
 		}
+
+		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
 		rcu_state.nocb_is_setup = true;
 	}
 
 	if (!rcu_state.nocb_is_setup)
 		return;
 
-#if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running)
-		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
-
-	if (offload_all)
-		cpumask_setall(rcu_nocb_mask);
-
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.31.1.189.g2e36527f23


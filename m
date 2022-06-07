Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1353F642
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiFGGiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFGGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:38:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA969703;
        Mon,  6 Jun 2022 23:38:10 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHLGq5k6rzbbh5;
        Tue,  7 Jun 2022 14:36:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 14:38:07 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 14:38:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2] rcu/nocb: Delete local variable 'need_rcu_nocb_mask' in rcu_init_nohz()
Date:   Tue, 7 Jun 2022 14:37:53 +0800
Message-ID: <20220607063753.495-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
bool need_rcu_nocb_mask = false;

//#if defined(CONFIG_NO_HZ_FULL)
if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
        need_rcu_nocb_mask = true;      <----	//Move it here
//#endif                                     |
                                             |
if (need_rcu_nocb_mask) {                    |  //Can only be true above
         ...                            -----
}

The local variable 'need_rcu_nocb_mask' is true only if CONFIG_NO_HZ_FULL
is defined. So branch "if (need_rcu_nocb_mask)" can be moved within the
scope of "#if defined(CONFIG_NO_HZ_FULL)". At this point, using variable
'need_rcu_nocb_mask' is not necessary, so delete it.

No functional changes, but the code looks a little more concise.

The kernel built with CONFIG_NO_HZ_FULL=n and CONFIG_RCU_NOCB_CPU=y ran
continuously for a whole day, no errors were reported.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree_nocb.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

v1 --> v2:
Update commit message.

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 46694e13398a3ee..e7fe99eb58972a6 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1154,15 +1154,10 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
 	struct rcu_data *rdp;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
-		need_rcu_nocb_mask = true;
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
-
-	if (need_rcu_nocb_mask) {
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
 		if (!cpumask_available(rcu_nocb_mask)) {
 			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
 				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
@@ -1171,6 +1166,7 @@ void __init rcu_init_nohz(void)
 		}
 		rcu_state.nocb_is_setup = true;
 	}
+#endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (!rcu_state.nocb_is_setup)
 		return;
-- 
2.25.1


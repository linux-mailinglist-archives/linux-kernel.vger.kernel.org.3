Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465B5A984F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiIANTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiIANSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:18:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD7543E5;
        Thu,  1 Sep 2022 06:16:04 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJM050cPqzkWT5;
        Thu,  1 Sep 2022 21:12:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:16:02 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:16:01 +0800
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
Subject: [PATCH v6 2/2] rcu: Offload callback processing from all CPUs in the absence of rcu_nocbs=
Date:   Thu, 1 Sep 2022 21:14:36 +0800
Message-ID: <20220901131436.986-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220901131436.986-1-thunder.leizhen@huawei.com>
References: <20220901131436.986-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Offload callback processing from all CPUs as long as there is no
"rcu_nocbs=" boot parameter. This also means: whether
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y takes effect does not depend on
the absence of "nohz_full=".

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/Kconfig     | 4 ++--
 kernel/rcu/tree_nocb.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index d471d22a5e21b43..35b94f5f6767f00 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -270,8 +270,8 @@ config RCU_NOCB_CPU_DEFAULT_ALL
 	default n
 	help
 	  Use this option to offload callback processing from all CPUs
-	  by default, in the absence of the rcu_nocbs or nohz_full boot
-	  parameter. This also avoids the need to use any boot parameters
+	  by default, in the absence of the rcu_nocbs boot parameter.
+	  This also avoids the need to use any boot parameters
 	  to achieve the effect of offloading all CPUs on boot.
 
 	  Say Y here if you want offload all CPUs by default on boot.
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8b6dceeabde0b4d..cfbdd78d6c33158 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1219,7 +1219,7 @@ void __init rcu_init_nohz(void)
 #endif
 
 #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
-	if (!rcu_state.nocb_is_setup && !cpumask)
+	if (!rcu_state.nocb_is_setup)
 		cpumask = cpu_possible_mask;
 #endif
 
-- 
2.25.1


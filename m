Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA21F51BD08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355402AbiEEKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbiEEKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:20:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDB151E4B;
        Thu,  5 May 2022 03:16:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m23so4963358ljb.8;
        Thu, 05 May 2022 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfWL5dz6a5FGE4vRGjU7mx9iIRrJFwU7WjtRFosHbaY=;
        b=TUYwcafIka3N9g9lP667JWdNgz2aHS4k0FiUqjgF/AkyvV/YxBBaRdZfRQ1ajJKwuO
         Yvu0h7oBUzFg3oTqhLVd/4zpbogyVNMfUVKNRnnjPrmAZiKExUv3DRuNr87sxI3GH3m0
         gZqTWwEFnTpKn8e1UKCWiKtY2a9rkUd2B8Fqxrf/qtJo8XQK7iwfPF0/ZHUbzCPWQbUy
         gapFu1QaFw++9dAGI76ExxioYOC+jyVsNAggV9L3UDYTWQvsqtzO4g8Gjoee2+tgjCwg
         5FYbRT8JjKuuS/7g2ScG17cYMjikQ+pyTCnQijDCDe65kezTVkeoJP5SFGzCO99g62xq
         vYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfWL5dz6a5FGE4vRGjU7mx9iIRrJFwU7WjtRFosHbaY=;
        b=ceuDO7l+W6oMJvrMXyQzVTdomch8S4Ekt1QHrLBbPON7fj/HbXF7945l43vHSmNAn7
         1PLpIMJiGisPYzZfG2FnHBSfOWDEuo+8y8/WqGsfiqSyK6VzVn2tqztbj9FcBtbRILOE
         Kx9p9rPQ2h56hiIPFKQZktHdnhplJT92ZWKUiMk7Cx3GG/Ka6Mmcnbnocg0aQsNrKTtx
         r7h2cw8qrpMwl0iN8hd4EHNgZxIxO69WBjVVbrJ1zY/SS1GK91aZLZlGpY6DTIyD0L65
         Jk4ULX6ahxKKzlnb+YMARVuTiuXK6S7/F80hrfMLK1vKfWyAAv6Dw6hWTucXUPpLwkv3
         uK6g==
X-Gm-Message-State: AOAM532RdI8Df7MvkFfP3K5dra8X3ydQJbQ+rb/uWYXGhJaC5Z7FY5vj
        RQTgoC6Bojj4ViHb/VUNWslAVab/A9o=
X-Google-Smtp-Source: ABdhPJzftHfKDAbYoqe262Wl/GYw6czloNY59IVycQuG4oijJ2D1eqsbPNIRw9MksOG+kxQu4QtT6g==
X-Received: by 2002:a2e:8e84:0:b0:24f:1d40:ceb0 with SMTP id z4-20020a2e8e84000000b0024f1d40ceb0mr16316006ljk.292.1651745810080;
        Thu, 05 May 2022 03:16:50 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id 1-20020a2e1641000000b0024f3d1daeafsm149999ljw.55.2022.05.05.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:16:49 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT context
Date:   Thu,  5 May 2022 12:16:41 +0200
Message-Id: <20220505101641.28472-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
decide if an offloading has to be done in a high-prio context or
not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
parameters and by default it is off.

This patch splits the boosting preempted RCU readers and those
kthreads which directly responsible for driving expedited grace
periods forward with enabling/disabling the offloading from/to
SCHED_FIFO/SCHED_OTHER contexts.

The main reason of such split is, for example on Android there
are some workloads which require fast expedited grace period to
be done whereas offloading in RT context can lead to starvation
and hogging a CPU for a long time what is not acceptable for
latency sensitive environment. For instance:

<snip>
<...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
<snip>

invoking 34 619 callbacks will take time thus making other CFS
tasks waiting in run-queue to be starved due to such behaviour.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/Kconfig     | 14 ++++++++++++++
 kernel/rcu/tree.c      |  5 ++++-
 kernel/rcu/tree_nocb.h |  3 ++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 27aab870ae4c..074630b94902 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
 	  Say Y here if you want offload all CPUs by default on boot.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_CB_BOOST
+	bool "Perform offloading from real-time kthread"
+	depends on RCU_NOCB_CPU && RCU_BOOST
+	default n
+	help
+	  Use this option to offload callbacks from the SCHED_FIFO context
+	  to make the process faster. As a side effect of this approach is
+	  a latency especially for the SCHED_OTHER tasks which will not be
+	  able to preempt an offloading kthread. That latency depends on a
+	  number of callbacks to be invoked.
+
+	  Say Y here if you want to set RT priority for offloading kthreads.
+	  Say N here if you are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT && TASKS_TRACE_RCU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9dc4c4e82db6..d769a15bc0e3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,7 +154,10 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
-/* rcuc/rcub/rcuop kthread realtime priority */
+/*
+ * rcuc/rcub/rcuop kthread realtime priority. The former
+ * depends on if CONFIG_RCU_NOCB_CPU_CB_BOOST is set.
+ */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 60cc92cc6655..a2823be9b1d0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		goto end;
 
-	if (kthread_prio)
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST))
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 	return;
-- 
2.30.2


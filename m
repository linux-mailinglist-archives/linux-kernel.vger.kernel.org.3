Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88929522ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbiEKI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiEKI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:57:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0E6BFD9;
        Wed, 11 May 2022 01:57:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so2303011lfa.12;
        Wed, 11 May 2022 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDlfHSmRKq8zxyM1WxYDcJ3H1h6FEew1SBUL+HhrWzA=;
        b=Zir2Vtpsc57oRt8O/fh1hqhm2LF/4xgvVWJXx6kqOgIbEeST03fOpIEES85pD3Qh8V
         5nu54emEZ9CN0frBduWtgalnvb2lMYbCa7DBqaNMpzwqMF8p0Fuz1GlB/T5hWvhp7yWk
         DpV91v+kVuZUxmYrgsh/RLtZ+B0KrKp3/7GbyPiDnlFx4JzYDG+DJbzdPduIcKzJfglU
         XZ9iQdGFJ+fyA8jQ0WgNOFpf2SVx2bOrE3V+id89UveFVFuk6tJ0uYMTbUTis7HrbrST
         PbRhPqTY/0gAKz3DxxUO0IALJXg0wnNH2R/FTrFpjWdRtTIh/BsUNUuM3SxR61hot1GQ
         M3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDlfHSmRKq8zxyM1WxYDcJ3H1h6FEew1SBUL+HhrWzA=;
        b=kCc+VVojwnsp0carXywqvV5PmMpoYpYoYZqmbf9f4Fkf3od3sRrYAgStE7deFc8q1v
         3thyfnGvmpa0COFTA6EDPpYkYuwaJKH6iFl8DXzXqSFMfX1mQPa0Fxg8ms3tYmRlCQOb
         SL86DgdcG+wPtERGfMNZwg/zqpjmq4DnB39EvbLo0MyJP4kEebHTXpXKkqHPMtWSn5Dk
         wsR5zLLD6Wben2sVSPI+Ik+6Mal6R0IxORpMdZ1M9l37qGqbaPZK9rTgopOOLGjJLnql
         2cw5UuCzakbXUe9RaJxsJCTUgFdt+0PuEcQzyWHoVxbUyLUiKXcD3tN4weyBhxkDFPZW
         OVqA==
X-Gm-Message-State: AOAM531GFThIIfQ09Hh+M5Z6p6SL4HuLnSTASVQp3rPBLEOxDzZI8r8B
        Rb4ZF8bsX2TSTs9MhyOQOB1IrAgl0jJgxQ==
X-Google-Smtp-Source: ABdhPJy/Eos0QETIvOdtYzuStR8AXoNjQacV7uGtSgS9GtMwlmNh+CDREdBhnFxBWIGgmvvF/sbnow==
X-Received: by 2002:a19:4942:0:b0:473:e75f:c058 with SMTP id l2-20020a194942000000b00473e75fc058mr19792253lfj.82.1652259431515;
        Wed, 11 May 2022 01:57:11 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id v22-20020ac25616000000b0047255d2118bsm183521lfd.186.2022.05.11.01.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:57:11 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 1/1] rcu/nocb: Add an option to ON/OFF an offloading from RT context
Date:   Wed, 11 May 2022 10:57:03 +0200
Message-Id: <20220511085703.101596-1-urezki@gmail.com>
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
parameters. For CONFIG_PREEMPT_RT kernel both RCU_BOOST and the
RCU_NOCB_CPU_CB_BOOST are active by default.

This patch splits the CONFIG_RCU_BOOST config into two peaces:
a) boosting preempted RCU readers and the kthreads which are
   directly responsible for driving expedited grace periods
   forward;
b) boosting offloading-kthreads in a way that their scheduling
   class are changed from SCHED_NORMAL to SCHED_FIFO.

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

v1 -> v2:
- fix the comment about the rcuc/rcub/rcuop;
- check the kthread_prio against zero value;
- by default the RCU_NOCB_CPU_CB_BOOST is ON for PREEMPT_RT.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/Kconfig     | 14 ++++++++++++++
 kernel/rcu/tree.c      |  6 +++++-
 kernel/rcu/tree_nocb.h |  3 ++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 27aab870ae4c..a4ed7b5e2b75 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
 	  Say Y here if you want offload all CPUs by default on boot.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_CB_BOOST
+	bool "Offload RCU callback from real-time kthread"
+	depends on RCU_NOCB_CPU && RCU_BOOST
+	default y if PREEMPT_RT
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
index 9dc4c4e82db6..1c3852b1e0c8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,7 +154,11 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
-/* rcuc/rcub/rcuop kthread realtime priority */
+/*
+ * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
+ * real-time priority(enabling/disabling) is controlled by
+ * the extra CONFIG_RCU_NOCB_CPU_CB_BOOST configuration.
+ */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 60cc92cc6655..fa8e4f82e60c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		goto end;
 
-	if (kthread_prio)
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST) && kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 	return;
-- 
2.30.2


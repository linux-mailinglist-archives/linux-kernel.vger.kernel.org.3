Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00C4546705
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbiFJNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiFJNEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:04:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC93EEE0A;
        Fri, 10 Jun 2022 06:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E23BAB8348D;
        Fri, 10 Jun 2022 13:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A54FC34114;
        Fri, 10 Jun 2022 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654866242;
        bh=lsX//HNb7PsfIhxAcqmvRnp5U2zFxkpBt0m/xzaL/Qk=;
        h=From:To:Cc:Subject:Date:From;
        b=i3t/OIQOBJi/bSn4JcxECSymuE0Y2j/qYhDPU7uIl3idfPabV7+qgvVPoHeYTRRyH
         hni933ZB6Xfei/+aArPqWyiznUGG5oRszqxPTQgNuimLCRksMjZKC+pgQnyrVrmgcG
         Nv0xQeY2k8S9rHW10UqsPMJ8Vn0i/HG3pBgdta+AKrlVOA8ghyqG4KdUb3WmVVa/U9
         TOX2Ypw7/sYDriVqCmAQfKF1a/gLh2kc2fEdURkALCuDrzIuXIH5m6UV6/FlXU16zy
         cHvyww0skSrK6CreggdkVreQI+lFcT5fLXVX9gfALdvCU26nGFSkSWhJ/ED0XynhOd
         5o6WAwnmwGtmw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Fix ksoftirqd boosting timing and iteration
Date:   Fri, 10 Jun 2022 15:03:57 +0200
Message-Id: <20220610130357.1813926-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU priority boosting can fail on two situations:

1) If (nr_cpus= > maxcpus=), which means if the total number of CPUs
if higher than those brought online on boot, then torture_onoff() may
later bring up CPUs that weren't online on boot. Now since rcutorture
initialization only boosts the ksoftirqds of the CPUs that have been
set online on boot, the CPUs later set online by torture_onoff won't
benefit from the boost, making RCU priority boosting fail.

2) Ksoftirqds kthreads are boosted after the creation of
rcu_torture_boost() kthreads, which opens a window large enough for them
to stutter in low FIFO mode while waiting for ksoftirqds that are still
in SCHED_NORMAL mode.

The issues can trigger for example with:

	./kvm.sh --configs TREE01 --kconfig "CONFIG_RCU_BOOST=y"

	[   34.968561] rcu-torture: !!!
	[   34.968627] ------------[ cut here ]------------
	[   35.014054] WARNING: CPU: 4 PID: 114 at kernel/rcu/rcutorture.c:1979 rcu_torture_stats_print+0x5ad/0x610
	[   35.052043] Modules linked in:
	[   35.069138] CPU: 4 PID: 114 Comm: rcu_torture_sta Not tainted 5.18.0-rc1 #1
	[   35.096424] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
	[   35.154570] RIP: 0010:rcu_torture_stats_print+0x5ad/0x610
	[   35.198527] Code: 63 1b 02 00 74 02 0f 0b 48 83 3d 35 63 1b 02 00 74 02 0f 0b 48 83 3d 21 63 1b 02 00 74 02 0f 0b 48 83 3d 0d 63 1b 02 00 74 02 <0f> 0b 83 eb 01 0f 8e ba fc ff ff 0f 0b e9 b3 fc ff f82
	[   37.251049] RSP: 0000:ffffa92a0050bdf8 EFLAGS: 00010202
	[   37.277320] rcu: De-offloading 8
	[   37.290367] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
	[   37.290387] RDX: 0000000000000000 RSI: 00000000ffffbfff RDI: 00000000ffffffff
	[   37.290398] RBP: 000000000000007b R08: 0000000000000000 R09: c0000000ffffbfff
	[   37.290407] R10: 000000000000002a R11: ffffa92a0050bc18 R12: ffffa92a0050be20
	[   37.290417] R13: ffffa92a0050be78 R14: 0000000000000000 R15: 000000000001bea0
	[   37.290427] FS:  0000000000000000(0000) GS:ffff96045eb00000(0000) knlGS:0000000000000000
	[   37.290448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[   37.290460] CR2: 0000000000000000 CR3: 000000001dc0c000 CR4: 00000000000006e0
	[   37.290470] Call Trace:
	[   37.295049]  <TASK>
	[   37.295065]  ? preempt_count_add+0x63/0x90
	[   37.295095]  ? _raw_spin_lock_irqsave+0x12/0x40
	[   37.295125]  ? rcu_torture_stats_print+0x610/0x610
	[   37.295143]  rcu_torture_stats+0x29/0x70
	[   37.295160]  kthread+0xe3/0x110
	[   37.295176]  ? kthread_complete_and_exit+0x20/0x20
	[   37.295193]  ret_from_fork+0x22/0x30
	[   37.295218]  </TASK>

Fix this with boosting the ksoftirqds kthreads from the boosting
hotplug callback itself and before the boosting kthreads are created.

Fixes: ea6d962e80b6 ("rcutorture: Judge RCU priority boosting on grace periods, not callbacks")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index abb3f6d720f1..21470ebb15eb 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2136,6 +2136,19 @@ static int rcutorture_booster_init(unsigned int cpu)
 	if (boost_tasks[cpu] != NULL)
 		return 0;  /* Already created, nothing more to do. */
 
+	// Testing RCU priority boosting requires rcutorture do
+	// some serious abuse.  Counter this by running ksoftirqd
+	// at higher priority.
+	if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)) {
+		struct sched_param sp;
+		struct task_struct *t;
+
+		t = per_cpu(ksoftirqd, cpu);
+		WARN_ON_ONCE(!t);
+		sp.sched_priority = 2;
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+	}
+
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
 	rcu_torture_disable_rt_throttle();
@@ -3384,21 +3397,6 @@ rcu_torture_init(void)
 		rcutor_hp = firsterr;
 		if (torture_init_error(firsterr))
 			goto unwind;
-
-		// Testing RCU priority boosting requires rcutorture do
-		// some serious abuse.  Counter this by running ksoftirqd
-		// at higher priority.
-		if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)) {
-			for_each_online_cpu(cpu) {
-				struct sched_param sp;
-				struct task_struct *t;
-
-				t = per_cpu(ksoftirqd, cpu);
-				WARN_ON_ONCE(!t);
-				sp.sched_priority = 2;
-				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
-			}
-		}
 	}
 	shutdown_jiffies = jiffies + shutdown_secs * HZ;
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8844BEB17
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiBUSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:30:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiBUS0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:26:48 -0500
X-Greylist: delayed 273 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 10:26:25 PST
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2242CC5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:26:25 -0800 (PST)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 21LIKaY7027189
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 21 Feb 2022 10:20:37 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 21LIKYlq026458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 10:20:34 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 21 Feb 2022 10:20:34 -0800
Received: from yow-pgortmak-d4.wrs.com (128.224.56.60) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 21 Feb 2022 10:20:33 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] sched/isolation: really align nohz_full with rcu_nocbs
Date:   Mon, 21 Feb 2022 13:20:08 -0500
Message-ID: <20220221182009.1283-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221182009.1283-1-paul.gortmaker@windriver.com>
References: <20220221182009.1283-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment it is currently possible to sneak a core into nohz_full
that lies between nr_possible and NR_CPUS - but you won't "see" it
because cpumask_pr_args() implicitly hides anything above nr_cpu_ids.

This becomes a problem when the nohz_full CPU set doesn't contain at
least one other valid nohz CPU - in which case we end up with the
tick_nohz_full_running set and no tick core specified, which trips an
endless sequence of WARN() and renders the machine unusable.

I inadvertently opened the door for this when fixing an overly
restrictive nohz_full conditional in the below Fixes: commit - and then
courtesy of my optimistic ACPI reporting nr_possible of 64 (the default
Kconfig for NR_CPUS) and the not-so helpful implict filtering done by
cpumask_pr_args, I unfortunately did not spot it during my testing.

So here, I don't rely on what was printed anymore, but code exactly what
our restrictions should be in order to be aligned with rcu_nocbs - which
was the original goal.  Since the checks lie in "__init" code it is largely
free for us to do this anyway.

Building with NOHZ_FULL and NR_CPUS=128 on an otherwise defconfig, and
booting with "rcu_nocbs=8-127 nohz_full=96-127" on the same 16 core T5500
Dell machine now results in the following (only relevant lines shown):

 smpboot: Allowing 64 CPUs, 48 hotplug CPUs
 setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:64 nr_node_ids:2
 housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.
 housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.
 rcu:     RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=64.
 rcu:     Note: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.
 rcu:     Offload RCU callbacks from CPUs: 8-63.

One can see both new housekeeping checks are triggered in the above.
The same invalid boot arg combination would have previously resulted in
an infinitely scrolling mix of WARN from all cores per tick on this box.

We may need to revisit these sanity checks when nohz_full is accepted as
a stand alone keyword "enable" w/o a cpuset (see rcu/nohz d2cf0854d728).

Fixes: 915a2bc3c6b7 ("sched/isolation: Reconcile rcu_nocbs= and nohz_full=")
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/isolation.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b4d10815c45a..f7d2406c1f1d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -126,6 +126,17 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		goto free_non_housekeeping_mask;
 	}
 
+	if (!cpumask_subset(non_housekeeping_mask, cpu_possible_mask)) {
+		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.\n");
+		cpumask_and(non_housekeeping_mask, cpu_possible_mask,
+			    non_housekeeping_mask);
+	}
+
+	if (cpumask_empty(non_housekeeping_mask)) {
+		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.\n");
+		goto free_non_housekeeping_mask;
+	}
+
 	alloc_bootmem_cpumask_var(&housekeeping_staging);
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35EB46A02E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387636AbhLFP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:59:15 -0500
Received: from mail5.windriver.com ([192.103.53.11]:58422 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390085AbhLFPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:41:54 -0500
X-Greylist: delayed 2275 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 10:41:54 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 1B6F04Pd027118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:00:04 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Dec 2021 07:00:04 -0800
Received: from hackbox.wrs.com (128.224.56.205) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 6 Dec 2021 07:00:03 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] sched/isolation: really align nohz_full with rcu_nocbs
Date:   Mon, 6 Dec 2021 09:59:49 -0500
Message-ID: <20211206145950.10927-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211206145950.10927-1-paul.gortmaker@windriver.com>
References: <20211206145950.10927-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Fixes: 915a2bc3c6b7 ("sched/isolation: Reconcile rcu_nocbs= and nohz_full=")
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sched/isolation.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf12818..01abc8400d6c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -89,6 +89,18 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
+	if (!cpumask_subset(non_housekeeping_mask, cpu_possible_mask)) {
+		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.\n");
+		cpumask_and(non_housekeeping_mask, cpu_possible_mask,
+			    non_housekeeping_mask);
+	}
+
+	if (cpumask_empty(non_housekeeping_mask)) {
+		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.\n");
+		free_bootmem_cpumask_var(non_housekeeping_mask);
+		return 0;
+	}
+
 	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
 		alloc_bootmem_cpumask_var(&housekeeping_mask);
-- 
2.17.1


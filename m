Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43CC465AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354416AbhLBAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:33:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60058 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345008AbhLBAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C24A6B821A1;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F89C84000;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=1307fJQLUiGcVK9ulIi8SIucgepBGPIcipaEEWkmZNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLU3giOIvwMArLpALXQ/Sez22hcWEuHdEstc8E0W5nATC1iq+703Z/FZTwIo/Puj5
         xXrLoNBG3WRmycPchERv/ChQehcsST3StUp/wuUAlOxiUv+IXBjvw/nu9vF3kF+fVO
         1zxGLNqqMRoUoLFD0bOepCtCufxNTNT3kLdxGy9221E2s34dBgg3RH2jYyymFWIITT
         rIyTtAbhJ5aiEva/Jv70Mm3bpKqcM97GjjHF0jiOitfG6hBeJVNKFPq2RwlSIfdqgz
         blG8hqFFLTaeQWw9x8YfVWkZeJohFACotXNmeG7UZ0UJTMpjudPgIIkDNaoqlfawpa
         o+qdmvE7fi5Mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E6535C14E0; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/18] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Date:   Wed,  1 Dec 2021 16:29:11 -0800
Message-Id: <20211202002912.3127710-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Allow the rcu_nocbs kernel parameter to be specified just by itself,
without specifying any CPUs.  This allows systems administrators to use
"rcu_nocbs" to specify that none of the CPUs are to be offloaded at boot
time, but than any of them may be offloaded at runtime via cpusets.

In contrast, if the "rcu_nocbs" or "nohz_full" kernel parameters are not
specified at all, then not only are none of the CPUs offloaded at boot,
none of them can be offloaded at runtime, either.

While in the area, modernize the description of the "rcuo" kthreads'
naming scheme.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 37 ++++++++++++-------
 kernel/rcu/tree_nocb.h                        | 10 +++--
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d46..8b5da10f932e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4343,19 +4343,30 @@
 				Disable the Correctable Errors Collector,
 				see CONFIG_RAS_CEC help text.
 
-	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above.
-
-			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
-			the specified list of CPUs to be no-callback CPUs.
-			Invocation of these CPUs' RCU callbacks will be
-			offloaded to "rcuox/N" kthreads created for that
-			purpose, where "x" is "p" for RCU-preempt, and
-			"s" for RCU-sched, and "N" is the CPU number.
-			This reduces OS jitter on the offloaded CPUs,
-			which can be useful for HPC and real-time
-			workloads.  It can also improve energy efficiency
-			for asymmetric multiprocessors.
+	rcu_nocbs[=cpu-list]
+			[KNL] The optional argument is a cpu list,
+			as described above.
+
+			In kernels built with CONFIG_RCU_NOCB_CPU=y,
+			enable the no-callback CPU mode, which prevents
+			such CPUs' callbacks from being invoked in
+			softirq context.  Invocation of such CPUs' RCU
+			callbacks will instead be offloaded to "rcuox/N"
+			kthreads created for that purpose, where "x" is
+			"p" for RCU-preempt, "s" for RCU-sched, and "g"
+			for the kthreads that mediate grace periods; and
+			"N" is the CPU number. This reduces OS jitter on
+			the offloaded CPUs, which can be useful for HPC
+			and real-time workloads.  It can also improve
+			energy efficiency for asymmetric multiprocessors.
+
+			If a cpulist is passed as an argument, the specified
+			list of	CPUs is set to no-callback mode from boot.
+
+			Otherwise, if the '=' sign and the cpulist
+			arguments are omitted, no CPU will be set to
+			no-callback mode from boot but the mode may be
+			toggled at runtime via cpusets.
 
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f580a6b2e74e3..0c1802ce4764c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -66,14 +66,16 @@ static bool rcu_nocb_is_setup;
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (cpulist_parse(str, rcu_nocb_mask)) {
-		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-		cpumask_setall(rcu_nocb_mask);
+	if (*str == '=') {
+		if (cpulist_parse(++str, rcu_nocb_mask)) {
+			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
+			cpumask_setall(rcu_nocb_mask);
+		}
 	}
 	rcu_nocb_is_setup = true;
 	return 1;
 }
-__setup("rcu_nocbs=", rcu_nocb_setup);
+__setup("rcu_nocbs", rcu_nocb_setup);
 
 static int __init parse_rcu_nocb_poll(char *arg)
 {
-- 
2.31.1.189.g2e36527f23


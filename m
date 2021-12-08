Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830EA46DD9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhLHVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:31:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhLHVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:31:12 -0500
Date:   Wed, 08 Dec 2021 21:27:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638998858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIW81LCscbQfpQyvAJskFFL+jw1I3jY7/dxmCWQuu7Y=;
        b=uHlbtG9XYg+merTvNw+9wF4F8NQ4bWOp/PgenmeVg1cDE00GjjZ6C5PpdPQqbpAUycVyMj
        MatP4F9vhqZgwvZrQVSGRuHTQn84rV271ruNVaIyMotJ8XHjLfNx6nFupa+X26MSzPd2Ve
        omErmco0UroW1EbyuoV0x4JppXMr+basL5SrheWNW+RGGQpGcDRZ4oGwk5U0EDDRlbPmVL
        ViSdDdoWg5XM7uoaeN2jhjDHL3Z2aBeHZapvdOR8B8npNawk+B+6wFdTDclXVux3ebBYu7
        WbQxhKYCrwymkukh1NAq1JbbMjrszla3wHZ+ag09xXDya9VtAu++EnPQyCQOqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638998858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIW81LCscbQfpQyvAJskFFL+jw1I3jY7/dxmCWQuu7Y=;
        b=7bItRWt+mJTG3POca2825RrrlOehf5w5TTIgQCqbizXIpWU6jh73gmtAWlDdT/W3/OIkYr
        V6dKbqc4Y3LFvDDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched,x86: Don't use cluster topology for x86 hybrid CPUs
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211204091402.GM16608@worktop.programming.kicks-ass.net>
References: <20211204091402.GM16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163899885798.11128.4032422680527135079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cabdc3a8475b918e55744f43719b26a82dc8fa6b
Gitweb:        https://git.kernel.org/tip/cabdc3a8475b918e55744f43719b26a82dc8fa6b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 10:14:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Dec 2021 22:15:37 +01:00

sched,x86: Don't use cluster topology for x86 hybrid CPUs

For x86 hybrid CPUs like Alder Lake, the order of CPU selection should
be based strictly on CPU priority.  Don't include cluster topology for
hybrid CPUs to avoid interference with such CPU selection order.

On Alder Lake, the Atom CPU cluster has more capacity (4 Atom CPUs) vs
Big core cluster (2 hyperthread CPUs). This could potentially bias CPU
selection towards Atom over Big Core, when Big core CPU has higher
priority.

Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lkml.kernel.org/r/20211204091402.GM16608@worktop.programming.kicks-ass.net
---
 arch/x86/kernel/smpboot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ac2909f..617012f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -579,6 +579,17 @@ static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 	{ NULL, },
 };
 
+static struct sched_domain_topology_level x86_hybrid_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 static struct sched_domain_topology_level x86_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
@@ -1469,8 +1480,11 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 
 	calculate_max_logical_packages();
 
+	/* XXX for now assume numa-in-package and hybrid don't overlap */
 	if (x86_has_numa_in_package)
 		set_sched_topology(x86_numa_in_package_topology);
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		set_sched_topology(x86_hybrid_topology);
 
 	nmi_selftest();
 	impress_friends();

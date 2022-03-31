Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B104EDF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiCaRNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiCaRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:13:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8966F5DA07;
        Thu, 31 Mar 2022 10:12:06 -0700 (PDT)
Date:   Thu, 31 Mar 2022 17:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648746724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4OHeIH4aQBV+dTK7KhVZWGL+8VblsPPQgnBB7RCQDS4=;
        b=h5/RVYa94zDFtX/74uIY41qBaOdL0HKWXkHxNzMFaSpdixgQyp0CGUvSTGR/ccQtboWPvl
        OQwHX63KubT3I9k+AGxuUXAtN9lR3WJnQ61ElwtsqsjHyIIJmw3H7tj4lnIZbxVq5Q6p7Y
        i77YrvffJI12zjmKgdW8bDLdTTAhPF4yY28xq2aXPxqksHZOkyK56Pi9de/s1nqzXvkPzX
        +UQGFc/RAn0Wb1mhyJN33fK2T6mj3bS1AvyBS4HDE4T8PdgrAUEXNzq43/t6HMzqkj3ygQ
        49iJQ9L7ZUxt7PmEXoXp6QPFbc+XtE0bAHP36SSi7mTUmtJ+DC8uAf5++vGp1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648746724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4OHeIH4aQBV+dTK7KhVZWGL+8VblsPPQgnBB7RCQDS4=;
        b=OZhiuRy6OTS2wGpNIEMqyxEzRp4FaKTl82heRk0i/9BdonUHH8xLowL+EQNV+zW2b+rYzn
        P9HGG3gGuWQvrpBw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Revert retpoline avoidance approach
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164874672286.389.7021457716635788197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     3ee646cd23a26ddf92b3ecf6e0ddc2d4d620189b
Gitweb:        https://git.kernel.org/tip/3ee646cd23a26ddf92b3ecf6e0ddc2d4d620189b
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 18 Mar 2022 06:52:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 31 Mar 2022 10:07:47 -07:00

x86/mm/tlb: Revert retpoline avoidance approach

0day reported a regression on a microbenchmark which is intended to
stress the TLB flushing path:

	https://lore.kernel.org/all/20220317090415.GE735@xsang-OptiPlex-9020/

It pointed at a commit from Nadav which intended to remove retpoline
overhead in the TLB flushing path by taking the 'cond'-ition in
on_each_cpu_cond_mask(), pre-calculating it, and incorporating it into
'cpumask'.  That allowed the code to use a bunch of earlier direct
calls instead of later indirect calls that need a retpoline.

But, in practice, threads can go idle (and into lazy TLB mode where
they don't need to flush their TLB) between the early and late calls.
It works in this direction and not in the other because TLB-flushing
threads tend to hold mmap_lock for write.  Contention on that lock
causes threads to _go_ idle right in this early/late window.

There was not any performance data in the original commit specific
to the retpoline overhead.  I did a few tests on a system with
retpolines:

	https://lore.kernel.org/all/dd8be93c-ded6-b962-50d4-96b1c3afb2b7@intel.com/

which showed a possible small win.  But, that small win pales in
comparison with the bigger loss induced on non-retpoline systems.

Revert the patch that removed the retpolines.  This was not a
clean revert, but it was self-contained enough not to be too painful.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Acked-by: Nadav Amit <namit@vmware.com>
Fixes: 6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()")
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/mm/tlb.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1e6513f..161984b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -854,13 +854,11 @@ done:
 			nr_invalidate);
 }
 
-static bool tlb_is_not_lazy(int cpu)
+static bool tlb_is_not_lazy(int cpu, void *data)
 {
 	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
 }
 
-static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
-
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);
 
@@ -889,36 +887,11 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables) {
+	if (info->freed_tables)
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
-	} else {
-		/*
-		 * Although we could have used on_each_cpu_cond_mask(),
-		 * open-coding it has performance advantages, as it eliminates
-		 * the need for indirect calls or retpolines. In addition, it
-		 * allows to use a designated cpumask for evaluating the
-		 * condition, instead of allocating one.
-		 *
-		 * This code works under the assumption that there are no nested
-		 * TLB flushes, an assumption that is already made in
-		 * flush_tlb_mm_range().
-		 *
-		 * cond_cpumask is logically a stack-local variable, but it is
-		 * more efficient to have it off the stack and not to allocate
-		 * it on demand. Preemption is disabled and this code is
-		 * non-reentrant.
-		 */
-		struct cpumask *cond_cpumask = this_cpu_ptr(&flush_tlb_mask);
-		int cpu;
-
-		cpumask_clear(cond_cpumask);
-
-		for_each_cpu(cpu, cpumask) {
-			if (tlb_is_not_lazy(cpu))
-				__cpumask_set_cpu(cpu, cond_cpumask);
-		}
-		on_each_cpu_mask(cond_cpumask, flush_tlb_func, (void *)info, true);
-	}
+	else
+		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
+				(void *)info, 1, cpumask);
 }
 
 void flush_tlb_multi(const struct cpumask *cpumask,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD134DDF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiCRQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiCRQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:34:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6F234569
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647621214; x=1679157214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ysNX3b8mamQZxT8f3NDQH9ho6H0LgnQRByvolLCRESM=;
  b=VY2+FuvziizaZqC0Kj3+TLo5dk21+Il2n7QU3oUXqLzYsZFqjO5/ScTm
   3Qo4DycKrkp3nIhKW6JCZV3yGGv7pvGdPeV8V2nzxN+pdemzMEfSXbTvh
   CWyWQSo21H+OPLzG4qn513nNT/t23StlO0cD33ERgQ8u1szM3cCc4eP4f
   ukM/KVBakaak4ObNz14cyA5TQolBx7pwWNPwJc5kIqhgJkC2hUddAFnv2
   8XZeMdsHd4yjb78RTi2wRnAuH+HFlWVfkmcbZKB1xVP8fBpOmGQODRQ4I
   IgaDS4m6QZ6NvGq2/cBOIQirmnr3YlD1SDdDRlpMA6o1YRFyc7SwaHTlh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="281981666"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="281981666"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:33:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647531081"
Received: from chittoor-mobl.amr.corp.intel.com (HELO ray2.sr71.net) ([10.209.39.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:33:34 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.cm>,
        kernel test robot <oliver.sang@intel.com>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] x86/mm/tlb: Revert retpoline avoidance approach
Date:   Fri, 18 Mar 2022 09:33:04 -0700
Message-Id: <20220318163304.2128897-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.cm>
Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()")
Cc: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/mm/tlb.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1e6513f95133..161984b44331 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -854,13 +854,11 @@ static void flush_tlb_func(void *info)
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
-- 
2.34.0


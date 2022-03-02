Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF844C9A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiCBBAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiCBBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:00:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC515F24E;
        Tue,  1 Mar 2022 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646182799; x=1677718799;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=44+jNeh4S68T9QRzPo8RSr8OxbV6sts9wHOgdosG3S4=;
  b=JW+D0Wnut3/lP1X5j48Da9IeOJIvJLQhQjMnDsK/H6ZqM1sZRIwNV6El
   YkXZytbYfxm0mHECE7MnJ1BqyDCXdGCZ0cLindt7WxbxwCq+DUfgr98Zs
   cfKQAcXoU9jL5f+dsIFChlEJk4DK5qtJyMEHvwkIYTvdcylphKulxpPUW
   2Xe2NAuKJCIGBJ9mVXE2snTYK+Z1QTN2NfzKTV8wW/iOSBKdvEBS1FfiX
   7OGaSpVOBmFhLn3JOMZCx7LDnXFkjWeJ9vpduz9U3LMwD79MbwR/kq5RH
   UIvQIt9P+iaXp9J/ZFnC2on8s60sBEthWjxwH4LXLgJHnMs8I+xOKss/n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="240691528"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="240691528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:59:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="535157104"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:59:57 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: sched/core] sched/numa: Avoid migrating task to CPU-less
 node
References: <20220214121553.582248-2-ying.huang@intel.com>
        <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
        <Yh6H8SPSqpjv1dl7@qian>
Date:   Wed, 02 Mar 2022 08:59:55 +0800
In-Reply-To: <Yh6H8SPSqpjv1dl7@qian> (Qian Cai's message of "Tue, 1 Mar 2022
        15:54:09 -0500")
Message-ID: <87v8wx1850.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Thu, Feb 17, 2022 at 06:56:52PM -0000, tip-bot2 for Huang Ying wrote:
>> The following commit has been merged into the sched/core branch of tip:
>> 
>> Commit-ID:     5c7b1aaf139dab5072311853bacc40fc3457d1f9
>> Gitweb:        https://git.kernel.org/tip/5c7b1aaf139dab5072311853bacc40fc3457d1f9
>> Author:        Huang Ying <ying.huang@intel.com>
>> AuthorDate:    Mon, 14 Feb 2022 20:15:53 +08:00
>> Committer:     Peter Zijlstra <peterz@infradead.org>
>> CommitterDate: Wed, 16 Feb 2022 15:57:53 +01:00
>> 
>> sched/numa: Avoid migrating task to CPU-less node
>> 
>> In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
>> nodes.  But if the number of the hint page faults on a PMEM node is
>> the max for a task, The current NUMA balancing policy may try to place
>> the task on the PMEM node instead of DRAM node.  This is unreasonable,
>> because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
>> nodes are ignored when searching the migration target node for a task
>> in this patch.
>> 
>> To test the patch, we run a workload that accesses more memory in PMEM
>> node than memory in DRAM node.  Without the patch, the PMEM node will
>> be chosen as preferred node in task_numa_placement().  While the DRAM
>> node will be chosen instead with the patch.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Link: https://lkml.kernel.org/r/20220214121553.582248-2-ying.huang@intel.com
>
> Reverting this commit on the top of today's linux-next fixed a boot crash
> on arm64 NUMA systems.
>
>  Unable to handle kernel paging request at virtual address ffff7a6601694aec
>  KASAN: maybe wild-memory-access in range [0xffffd3300b4a5760-0xffffd3300b4a5767]
>  Mem abort info:
>    ESR = 0x96000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>  mlx5_core 0007:02:00.0: enabling device (0100 -> 0102)
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000005
>    CM = 0, WnR = 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000400b3d6c6000
>  [ffff7a6601694aec] pgd=0000403fc007f003, p4d=0000403fc007f003, pud=0000000000000000
>  Internal error: Oops: 96000005 [#1] PREEMPT SMP
>  Modules linked in: nouveau(+) drm_ttm_helper ttm nvme(+) drm_dp_helper drm_kms_helper mlx5_core(+) mpt3sas(+) xhci_pci(+) nvme_core raid_class xhci_pci_renesas drm
>  CPU: 85 PID: 1308 Comm: udevadm Not tainted 5.17.0-rc6-next-20220301 #1
>  pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : task_numa_placement
>  lr : task_numa_placement
>  sp : ffff800031047760
>  x29: ffff800031047760 x28: ffff3fffab916c00 x27: 0000000000000020
>  x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000000
>
>  x23: ffff07ffe5289a80 x22: ffffd3300b4a5760 x21: 000000000000003f
>  x20: ffffd32feb4a5768 x19: 0000000000000000 x18: ffff07ffe528ad88
>  x17: ffffd32fe5693a1c x16: 0000000000000000 x15: ffff8000310478e0
>
>  x14: ffff07ffe528ad90 x13: 0000000000000002 x12: dfff80000000000d
>  x11: 0000000000000001 x10: 000000000000b6be x9 : 0000000000000000
>  x8 : 00000000ffffffff x7 : ffffd32feb4a5780 x6 : 0000000000000000
>  x5 : 0000000000000000 x4 : 0000000000000000 x3 : 1ffffa6601694aec
>  x2 : 0000000000000000 x1 : dfff800000000000 x0 : 000000001ffffff8
>  Call trace:
>   task_numa_placement
>   arch_test_bit at include/asm-generic/bitops/non-atomic.h:118
>   (inlined by) node_state at include/linux/nodemask.h:416
>   (inlined by) task_numa_placement at kernel/sched/fair.c:2439
>   task_numa_fault
>   do_numa_page
>   handle_pte_fault
>   __handle_mm_fault
>   handle_mm_fault
>   do_page_fault
>   do_translation_fault
>   do_mem_abort
>   el0_da
>   el0t_64_sync_handler
>   el0t_64_sync
>  Code: 8b000296 d2d00001 f2fbffe1 d343fec3 (38e16861)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: 0x532fdcf70000 from 0xffff800008000000
>  PHYS_OFFSET: 0x80000000
>  CPU features: 0x00,00042c0c,19801c82
>  Memory Limit: none
>  ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

Thanks for reporting!  Can you try whether the following debug patch can fix the issue?

Best Regards,
Huang, Ying

----------------------------8<-------------------------------------------
From 176d185426730111e763eb386d0210561f021dbc Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 2 Mar 2022 08:54:01 +0800
Subject: [PATCH] dbg KASAN error

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a3f0ea216ccb..1fe7a4510cca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2405,7 +2405,7 @@ static void task_numa_placement(struct task_struct *p)
 	}
 
 	/* Cannot migrate task to CPU-less node */
-	if (!node_state(max_nid, N_CPU)) {
+	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
 		int near_nid = max_nid;
 		int distance, near_distance = INT_MAX;
 
-- 
2.30.2


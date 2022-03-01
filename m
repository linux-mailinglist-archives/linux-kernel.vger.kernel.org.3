Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC94C975B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiCAUy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiCAUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:54:55 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555F54FB9;
        Tue,  1 Mar 2022 12:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646168054; x=1677704054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSc3xFW+V2egURW83xW8a6Im3kooAeDFmGZpfc5qSi4=;
  b=Nvn1xTrN3Ersu4CtzN1Bjkkrk8Lv+HQqK0UASvbTSp1JM7J7zJMCPWo+
   BJSlUIAJunVYZfJf+UWwaNLwy3Cz5+yXksMGV+x0hdryAP7LvrAZeFACN
   KsjOCOItNbfn/9mV3j5qDVp6hxIKBuAMtAYFgbZghjRAddrcXJs/mHnrI
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 12:54:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 12:54:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 12:54:12 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 12:54:11 -0800
Date:   Tue, 1 Mar 2022 15:54:09 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-tip-commits@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: sched/core] sched/numa: Avoid migrating task to CPU-less
 node
Message-ID: <Yh6H8SPSqpjv1dl7@qian>
References: <20220214121553.582248-2-ying.huang@intel.com>
 <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:56:52PM -0000, tip-bot2 for Huang Ying wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     5c7b1aaf139dab5072311853bacc40fc3457d1f9
> Gitweb:        https://git.kernel.org/tip/5c7b1aaf139dab5072311853bacc40fc3457d1f9
> Author:        Huang Ying <ying.huang@intel.com>
> AuthorDate:    Mon, 14 Feb 2022 20:15:53 +08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 16 Feb 2022 15:57:53 +01:00
> 
> sched/numa: Avoid migrating task to CPU-less node
> 
> In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
> nodes.  But if the number of the hint page faults on a PMEM node is
> the max for a task, The current NUMA balancing policy may try to place
> the task on the PMEM node instead of DRAM node.  This is unreasonable,
> because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
> nodes are ignored when searching the migration target node for a task
> in this patch.
> 
> To test the patch, we run a workload that accesses more memory in PMEM
> node than memory in DRAM node.  Without the patch, the PMEM node will
> be chosen as preferred node in task_numa_placement().  While the DRAM
> node will be chosen instead with the patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20220214121553.582248-2-ying.huang@intel.com

Reverting this commit on the top of today's linux-next fixed a boot crash
on arm64 NUMA systems.

 Unable to handle kernel paging request at virtual address ffff7a6601694aec
 KASAN: maybe wild-memory-access in range [0xffffd3300b4a5760-0xffffd3300b4a5767]
 Mem abort info:
   ESR = 0x96000005
   EC = 0x25: DABT (current EL), IL = 32 bits
 mlx5_core 0007:02:00.0: enabling device (0100 -> 0102)
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000005
   CM = 0, WnR = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000400b3d6c6000
 [ffff7a6601694aec] pgd=0000403fc007f003, p4d=0000403fc007f003, pud=0000000000000000
 Internal error: Oops: 96000005 [#1] PREEMPT SMP
 Modules linked in: nouveau(+) drm_ttm_helper ttm nvme(+) drm_dp_helper drm_kms_helper mlx5_core(+) mpt3sas(+) xhci_pci(+) nvme_core raid_class xhci_pci_renesas drm
 CPU: 85 PID: 1308 Comm: udevadm Not tainted 5.17.0-rc6-next-20220301 #1
 pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : task_numa_placement
 lr : task_numa_placement
 sp : ffff800031047760
 x29: ffff800031047760 x28: ffff3fffab916c00 x27: 0000000000000020
 x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000000

 x23: ffff07ffe5289a80 x22: ffffd3300b4a5760 x21: 000000000000003f
 x20: ffffd32feb4a5768 x19: 0000000000000000 x18: ffff07ffe528ad88
 x17: ffffd32fe5693a1c x16: 0000000000000000 x15: ffff8000310478e0

 x14: ffff07ffe528ad90 x13: 0000000000000002 x12: dfff80000000000d
 x11: 0000000000000001 x10: 000000000000b6be x9 : 0000000000000000
 x8 : 00000000ffffffff x7 : ffffd32feb4a5780 x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000000 x3 : 1ffffa6601694aec
 x2 : 0000000000000000 x1 : dfff800000000000 x0 : 000000001ffffff8
 Call trace:
  task_numa_placement
  arch_test_bit at include/asm-generic/bitops/non-atomic.h:118
  (inlined by) node_state at include/linux/nodemask.h:416
  (inlined by) task_numa_placement at kernel/sched/fair.c:2439
  task_numa_fault
  do_numa_page
  handle_pte_fault
  __handle_mm_fault
  handle_mm_fault
  do_page_fault
  do_translation_fault
  do_mem_abort
  el0_da
  el0t_64_sync_handler
  el0t_64_sync
 Code: 8b000296 d2d00001 f2fbffe1 d343fec3 (38e16861)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x532fdcf70000 from 0xffff800008000000
 PHYS_OFFSET: 0x80000000
 CPU features: 0x00,00042c0c,19801c82
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

> ---
>  kernel/sched/fair.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da3230b..11a72e1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1989,7 +1989,7 @@ static int task_numa_migrate(struct task_struct *p)
>  	 */
>  	ng = deref_curr_numa_group(p);
>  	if (env.best_cpu == -1 || (ng && ng->active_nodes > 1)) {
> -		for_each_online_node(nid) {
> +		for_each_node_state(nid, N_CPU) {
>  			if (nid == env.src_nid || nid == p->numa_preferred_nid)
>  				continue;
>  
> @@ -2087,13 +2087,13 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
>  	unsigned long faults, max_faults = 0;
>  	int nid, active_nodes = 0;
>  
> -	for_each_online_node(nid) {
> +	for_each_node_state(nid, N_CPU) {
>  		faults = group_faults_cpu(numa_group, nid);
>  		if (faults > max_faults)
>  			max_faults = faults;
>  	}
>  
> -	for_each_online_node(nid) {
> +	for_each_node_state(nid, N_CPU) {
>  		faults = group_faults_cpu(numa_group, nid);
>  		if (faults * ACTIVE_NODE_FRACTION > max_faults)
>  			active_nodes++;
> @@ -2247,7 +2247,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
>  
>  		dist = sched_max_numa_distance;
>  
> -		for_each_online_node(node) {
> +		for_each_node_state(node, N_CPU) {
>  			score = group_weight(p, node, dist);
>  			if (score > max_score) {
>  				max_score = score;
> @@ -2266,7 +2266,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
>  	 * inside the highest scoring group of nodes. The nodemask tricks
>  	 * keep the complexity of the search down.
>  	 */
> -	nodes = node_online_map;
> +	nodes = node_states[N_CPU];
>  	for (dist = sched_max_numa_distance; dist > LOCAL_DISTANCE; dist--) {
>  		unsigned long max_faults = 0;
>  		nodemask_t max_group = NODE_MASK_NONE;
> @@ -2405,6 +2405,21 @@ static void task_numa_placement(struct task_struct *p)
>  		}
>  	}
>  
> +	/* Cannot migrate task to CPU-less node */
> +	if (!node_state(max_nid, N_CPU)) {
> +		int near_nid = max_nid;
> +		int distance, near_distance = INT_MAX;
> +
> +		for_each_node_state(nid, N_CPU) {
> +			distance = node_distance(max_nid, nid);
> +			if (distance < near_distance) {
> +				near_nid = nid;
> +				near_distance = distance;
> +			}
> +		}
> +		max_nid = near_nid;
> +	}
> +
>  	if (ng) {
>  		numa_group_count_active_nodes(ng);
>  		spin_unlock_irq(group_lock);

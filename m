Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4959FFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiHXQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiHXQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:44:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110331B78C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661359458; x=1692895458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rKl0AX9N3vZk2bVfhKXH8glAnr+LgGgaF2Y1I2CPgns=;
  b=Ruw9RAlZHZjcPvT3EErYSi6YrCu3zxG2XRgui8IVh6QoYK/iq83csSp8
   04cRPqKdgRoMQvTCd97IlOHKbZTMiMWCN8F/Lvlb6WnX9LuiqY0bZcx7J
   zfodXyi2aPABxOwwRdLpP9fUJS/aBXMVOFW3cdULsQyvavq/ofysSkpOP
   QTU9ejLKZtpEkFgHqttY7s1rpOcwvf9B47SU7k3khcWqCtQVLwAGQvk+F
   G6gdC6fQRtBLofVgcpsX1VGQ2WEYJD9ehLlAeNc/DVVP67biLB+Yadr0y
   qp49Xb7+nwivk2UKp459JamWDPgiEHKNj6od4dsUKyWieLixkqER/jE1L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274406216"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="274406216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:44:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="752148073"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:44:17 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        tarumizu.kohei@fujitsu.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2] x86/resctrl: Fix to restore to original value when re-enabling hardware prefetch register
Date:   Wed, 24 Aug 2022 09:44:10 -0700
Message-Id: <eb660f3c2010b79a792c573c02d01e8e841206ad.1661358182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>

The current pseudo_lock.c code overwrites the value of the
MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
Therefore, modify it to save and restore the original values.

Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
Fixes: 443810fe6160 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
Fixes: 8a2fc0e1bc0c ("x86/intel_rdt: More precise L2 hit/miss measurements")
Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
 - V1: https://lore.kernel.org/lkml/20220518045517.2066518-1-tarumizu.kohei@fujitsu.com/
 - No changes to patch diff.
 - Added Reinette's "Acked-by".
 - While there are a few Fixes tags this is not considered stable material
   because:
   - Until the rest of Kohei's code lands this code is the only place in
     the kernel than modifies the MSR_MISC_FEATURE_CONTROL MSR. When the
     rest of Kohei's code lands this save/restore fix will be required.
   - Fix does not pass rule #4 of Documentation/process/stable-kernel-rules.rst
     (It must fix a real bug that bothers people).

 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index db813f819ad6..4d8398986f78 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -420,6 +420,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	struct pseudo_lock_region *plr = rdtgrp->plr;
 	u32 rmid_p, closid_p;
 	unsigned long i;
+	u64 saved_msr;
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
@@ -463,6 +464,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * the buffer and evict pseudo-locked memory read earlier from the
 	 * cache.
 	 */
+	saved_msr = __rdmsr(MSR_MISC_FEATURE_CONTROL);
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
 	closid_p = this_cpu_read(pqr_state.cur_closid);
 	rmid_p = this_cpu_read(pqr_state.cur_rmid);
@@ -514,7 +516,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	__wrmsr(IA32_PQR_ASSOC, rmid_p, closid_p);
 
 	/* Re-enable the hardware prefetcher(s) */
-	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	wrmsrl(MSR_MISC_FEATURE_CONTROL, saved_msr);
 	local_irq_enable();
 
 	plr->thread_done = 1;
@@ -871,6 +873,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 static int measure_cycles_lat_fn(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
+	u32 saved_low, saved_high;
 	unsigned long i;
 	u64 start, end;
 	void *mem_r;
@@ -879,6 +882,7 @@ static int measure_cycles_lat_fn(void *_plr)
 	/*
 	 * Disable hardware prefetchers.
 	 */
+	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
 	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
 	mem_r = READ_ONCE(plr->kmem);
 	/*
@@ -895,7 +899,7 @@ static int measure_cycles_lat_fn(void *_plr)
 		end = rdtsc_ordered();
 		trace_pseudo_lock_mem_latency((u32)(end - start));
 	}
-	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	wrmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
 	local_irq_enable();
 	plr->thread_done = 1;
 	wake_up_interruptible(&plr->lock_thread_wq);
@@ -940,6 +944,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	u64 hits_before = 0, hits_after = 0, miss_before = 0, miss_after = 0;
 	struct perf_event *miss_event, *hit_event;
 	int hit_pmcnum, miss_pmcnum;
+	u32 saved_low, saved_high;
 	unsigned int line_size;
 	unsigned int size;
 	unsigned long i;
@@ -973,6 +978,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	/*
 	 * Disable hardware prefetchers.
 	 */
+	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
 	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
 
 	/* Initialize rest of local variables */
@@ -1031,7 +1037,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	 */
 	rmb();
 	/* Re-enable hardware prefetchers */
-	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	wrmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
 	local_irq_enable();
 out_hit:
 	perf_event_release_kernel(hit_event);
-- 
2.25.1


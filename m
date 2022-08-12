Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AAC5913FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiHLQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiHLQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E1AFADD;
        Fri, 12 Aug 2022 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322290; x=1691858290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FXhHY9F8CVZbUQIObny6oo4+dxtgtHGRwk2KLIQG24s=;
  b=gJbzkaddBlOcFR0IuNmr+2LaGh6KCJzE4pE8esDwspq6i9acPAESvml0
   JUe+BGxEfEHl00x01wv0/bLYLkoXT85U2/nIiiw65WEmQCQbnOXth5W2u
   5y1RotWsXfQD8ZwiO3GDb4OZv/UcyGuZzL+O8pz2i1gLv0EoqQr6P/W36
   cDTCLVkkgDtx2TztY2+i9LGCZSaDbWzh/5pL/j4OH63MicaqtioYIDuQL
   L01X/jQ2cDpliyV9qN/f3GpgcfEdqa+h/7ESr3vyAYgSzgOQuQ/lm2MtK
   tlIURhUYpVPC/0xEj7zf1zQMvn17KpP2Rjogltp+1qn8A4PLAz4/IW5Wo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921617"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921617"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012306"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:38:06 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 4/7] x86/topology: Fix max_siblings calculation
Date:   Sat, 13 Aug 2022 00:41:41 +0800
Message-Id: <20220812164144.30829-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812164144.30829-1-rui.zhang@intel.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max siblings value returned by CPUID.1F SMT level EBX differs among
CPUs on Intel Hybrid platforms like ADL-S/P.
It returns 2 for Pcore CPUs which have HT sibling and 1 for Ecore CPUs
which do not.

Today, CPUID SMT level EBX sets the global variable smp_num_siblings.
Thus, smp_num_siblings is overridden to different values based on the CPU
Pcore/Ecore enumeration order.

For example,

[    0.201005] detect_extended_topology: CPU APICID 0x0, smp_num_siblings 2, x86_max_cores 10
[    0.201117] start_kernel->check_bugs->cpu_smt_check_topology: smp_num_siblings 2
...
[    0.010146] detect_extended_topology: CPU APICID 0x8, smp_num_siblings 2, x86_max_cores 10
...
[    0.010146] detect_extended_topology: CPU APICID 0x39, smp_num_siblings 2, x86_max_cores 10
[    0.010146] detect_extended_topology: CPU APICID 0x48, smp_num_siblings 1, x86_max_cores 20
...
[    0.010146] detect_extended_topology: CPU APICID 0x4e, smp_num_siblings 1, x86_max_cores 20
[    2.583800] sched_set_itmt_core_prio: smp_num_siblings 1

This inconsistency brings several potential issues:
1. some kernel configuration like cpu_smt_control, as set in
   start_kernel()->check_bugs()->cpu_smt_check_topology(), depends on
   smp_num_siblings set by cpu0.
   It is pure luck that all the current hybrid platforms use Pcore as cpu0
   and hide this problem.
2. some per CPU data like cpuinfo_x86.x86_max_cores that depends on
   smp_num_siblings becomes inconsistent and bogus.
3. the final smp_num_siblings value after boot depends on the last CPU
   enumerated, which could either be Pcore or Ecore CPU.

The solution is to use CPUID EAX bits_shift to get the maximum number of
addressable logical processors, and use this to determin max siblings.
Because:
1. the CPUID EAX bits_shift values are consistent among CPUs as far as
   observed.
2. some code already uses smp_num_siblings value to isolate the SMT ID
   bits in APIC-ID, like apic_id_is_primary_thread().

Suggested-and-reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/topology.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b62a7c4..2a88f2fa5756 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,7 +23,12 @@
 
 #define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-#define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
+
+/*
+ * Use EAX bit_shift to calculate the maximum number of addressable logical
+ * processors sharing the current level.
+ */
+#define LEVEL_MAX_SIBLINGS(eax)		(1 << BITS_SHIFT_NEXT_LEVEL(eax))
 
 unsigned int __max_die_per_package __read_mostly = 1;
 EXPORT_SYMBOL(__max_die_per_package);
@@ -79,7 +84,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = LEVEL_MAX_SIBLINGS(eax);
 #endif
 	return 0;
 }
@@ -109,9 +114,9 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid = edx;
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(eax);
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	die_level_siblings = LEVEL_MAX_SIBLINGS(eax);
 	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 
 	sub_index = 1;
@@ -122,14 +127,14 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 		 * Check for the Core type in the implemented sub leaves.
 		 */
 		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
-			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+			core_level_siblings = LEVEL_MAX_SIBLINGS(eax);
 			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 			die_level_siblings = core_level_siblings;
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
 			die_level_present = true;
-			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+			die_level_siblings = LEVEL_MAX_SIBLINGS(eax);
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 
-- 
2.34.1


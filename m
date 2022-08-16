Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D859544B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiHPH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiHPH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B025D119862;
        Mon, 15 Aug 2022 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660626787; x=1692162787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7nu5UaOkh101GWA0xrXJbyB81JiIDTjN5u61jUDVgko=;
  b=RsZKqWgtieYyYOtOzyMpyVudol/bWznAcPdwBPW3A52zlE4kWRkdEh6B
   +SnKCkDEudk0NkK87+dcdZ7NtOwwG9T1jUop3/7/sSpNRWlBMA1xrgOLD
   neJ84kt8XQ+AjvWsc5c9Wiu2UXiBAg1rS7Ku9d4nb/m4mvIDVeXTBqBF7
   vre+Bk06yUSZDx7WNbGMgYJcpa6wC87Q986nuzxH+wshi4/bRATZ99slu
   cPwVaIOVBxEpovqdw9+NW/RBVc7z+ykgAyv9G40OOSHpccfAOqJsQh7gw
   qHrwOTCJRENg5Mur6ASOfnKxCG8mQriB7Wi0Ev1butF9KsEPrgUDPBpki
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356130175"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356130175"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666953503"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 22:13:03 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V2 6/8] x86/topology: Fix max_siblings calculation
Date:   Tue, 16 Aug 2022 13:16:31 +0800
Message-Id: <20220816051633.17775-7-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816051633.17775-1-rui.zhang@intel.com>
References: <20220816051633.17775-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.25.1


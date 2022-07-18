Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8036C578A49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiGRTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRTFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:05:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658ABE08;
        Mon, 18 Jul 2022 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658171133; x=1689707133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PtIp17+q0zPGP6z3WM/0GlY1gm+bjxSXApJ2oTjZoOo=;
  b=aytgh4ClQQxfbeMZsnVmgbbuKx4OgRTgCclCaJvmcJcH7W5hmR0ipcuw
   v/FeFeUvr3jJjlHr8Rg1VpzpbRXswChHh4y1w6LDGUN0yeCBoCdrdUkW8
   S0KCMIW04khj6aeIF85yvT0U3uvf/cipM1UDowRfgKsHoSoUnH0IEsJl4
   G5x0Ad9TYCaQ6zaIBmahSweRqx7LbWpeKStxMOOsx52T3avz/I1kvEd5L
   IytnsgB+Yw0eidJpqG97bzYXUE+a5cNoew2WcsB7kVU/iqDnrkjoO33eB
   IoSKRf30cMw7YFEpFHoNXDUHXrBv9wI8bE3IJC96JTTBnQTUApf4lIbiq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287041351"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="287041351"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="594567946"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2022 12:05:33 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@alien8.de
Cc:     linux-tip-commits@vger.kernel.org, peterz@infradead.org,
        dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
        rui.zhang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH][Rebased] intel_idle: Add a new flag to initialize the AMX state
Date:   Mon, 18 Jul 2022 11:56:11 -0700
Message-Id: <20220718185611.20030-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YtUimvkv+rDJJ9zu@zn.tnic>
References: <YtUimvkv+rDJJ9zu@zn.tnic>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-initialized AMX state can be the cause of C-state demotion from C6
to C1E. This low-power idle state may improve power savings and thus result
in a higher available turbo frequency budget.

This behavior is implementation-specific. Initialize the state for the C6
entrance of Sapphire Rapids as needed.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lkml.kernel.org/r/20220608164748.11864-3-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20220614164116.5196-1-chang.seok.bae@intel.com
[ changb: Rebased to the upstream again. ]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
The patch merged in the tip's x86/fpu has conflict with the retbleed patch
-- commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle") as of
v5.19-rc7.
---
 drivers/idle/intel_idle.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f5c6802aa6c3..1ec221079367 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -113,6 +114,11 @@ static unsigned int mwait_substates __initdata;
  */
 #define CPUIDLE_FLAG_IBRS		BIT(16)
 
+/*
+ * Initialize large xstate for the C6-state entrance.
+ */
+#define CPUIDLE_FLAG_INIT_XSTATE	BIT(17)
+
 /*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
@@ -185,6 +191,13 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	return ret;
 }
 
+static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index)
+{
+	fpu_idle_fpregs();
+	return __intel_idle(dev, drv, index);
+}
+
 /**
  * intel_idle_s2idle - Ask the processor to enter the given idle state.
  * @dev: cpuidle device of the target CPU.
@@ -200,8 +213,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 				       struct cpuidle_driver *drv, int index)
 {
-	unsigned long eax = flg2MWAIT(drv->states[index].flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
+	struct cpuidle_state *state = &drv->states[index];
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
+		fpu_idle_fpregs();
 
 	mwait_idle_with_hints(eax, ecx);
 
@@ -936,7 +953,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
-		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_INIT_XSTATE,
 		.exit_latency = 290,
 		.target_residency = 800,
 		.enter = &intel_idle,
@@ -1851,6 +1869,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 			drv->states[drv->state_count].enter = intel_idle_ibrs;
 		}
 
+		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_INIT_XSTATE)
+			drv->states[drv->state_count].enter = intel_idle_xstate;
+
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
-- 
2.17.1


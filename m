Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B754B6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbiFNQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbiFNQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:50:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BF44764;
        Tue, 14 Jun 2022 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655225418; x=1686761418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9PMxZIsT0cwZQ/H2eT8C0EMoqkPBO0Qg03oGDWCPYos=;
  b=Xuk9j4zrBxbbFqauqK1mBqpckaLJ78mhO2FI4hzcHC9xdqe9lYXkfqYo
   CO4dSzxtFjFEoVm4jPkggSbmw+uFjpkkBEcxWOctccEKmi6g+44Wxg7x7
   v0JuUNr5QL1tFyueDhOu1Gm3MNCV7Av8aEcOKNMwXCMQnU5tBtbcB1Ma9
   Lo/mDaxN2RBbLH8ulxIZnlZ3n/oL4m1ueVLuvkFUR2mBuXlhHsVjUhTx8
   L4xPFlyb/iJAlV51qJnKAQmxzHoL0dU4rxtbUHdthd2dgjYdCSzK46D7P
   VEDBLlmR47ZeEkDDg75nXHeVW6fVCHvOuUywGY4FxdcwAdX3S3s3qqolf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279391617"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279391617"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 09:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830509198"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2022 09:50:18 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Cc:     linux-tip-commits@vger.kernel.org, rui.zhang@intel.com,
        rafael.j.wysocki@intel.com, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH][Rebased] intel_idle: Add a new flag to initialize the AMX state
Date:   Tue, 14 Jun 2022 09:41:16 -0700
Message-Id: <20220614164116.5196-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YqHKKa/yamRS06tC@worktop.programming.kicks-ass.net>
References: <YqHKKa/yamRS06tC@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Tested-by: Zhang Rui <rui.zhang@intel.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20220608164748.11864-3-chang.seok.bae@intel.com
[changb: Rebase to the upstream with peterz's help]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
The patch merged in the tip's x86/fpu branch [1] has conflict with the
upstream -- commit 32d4fd5751ea ("cpuidle,intel_idle: Fix
CPUIDLE_FLAG_IRQ_ENABLE") as of v5.19-rc2.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/fpu
---
 drivers/idle/intel_idle.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 424ef470223d..8a19ba1c2c1b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -54,6 +54,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -105,6 +106,11 @@ static unsigned int mwait_substates __initdata;
  */
 #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
 
+/*
+ * Initialize large xstate for the C6-state entrance.
+ */
+#define CPUIDLE_FLAG_INIT_XSTATE	BIT(16)
+
 /*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
@@ -159,6 +165,13 @@ static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
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
@@ -174,8 +187,12 @@ static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
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
 
@@ -910,7 +927,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
-		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_INIT_XSTATE,
 		.exit_latency = 290,
 		.target_residency = 800,
 		.enter = &intel_idle,
@@ -1819,6 +1837,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
 			drv->states[drv->state_count].enter = intel_idle_irq;
 
+		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_INIT_XSTATE)
+			drv->states[drv->state_count].enter = intel_idle_xstate;
+
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
-- 
2.17.1


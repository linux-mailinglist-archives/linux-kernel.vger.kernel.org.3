Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1512B5439FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiFHRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiFHRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:10:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D83FBBD6;
        Wed,  8 Jun 2022 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654707413; x=1686243413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sxbD4J7BtSo1S6gF/v2H3MizySMBUhfYlLpZNaGXRBE=;
  b=igA7zG32F3DnDjcm9q0cIeak4QjSn1mSHZ2RwyGQDamk/cBTnB8RoONR
   mDyVoEvtXjq3LqvmWgX3/VSV7FTJWwSaTmkvML+NQTizfHS8LPPPZqlaj
   1sQt7DCmMm1CkWJiBKrvW4VW+w03A9MOobIHFluZYkZReyEZbVS25SZYH
   61wn2htgiFOhkU7M/Dqx7sjVlnFLwSCHZnvwuB2w0BZuS6bB4tRK7RfmK
   ygCMb6wSFY0xywO8jI0zmVGM1h3UXpY6wXuPBgjVMu/f/wclzIQ4NBSuk
   AKZtW4vYj9fgG4ZoudZe4r0ookApPZ/JK2RgF7hm84MH0BmpOC8qhRKhH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265768320"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="265768320"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 09:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="585001343"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2022 09:56:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org, riel@fb.com,
        bigeasy@linutronix.de, hch@lst.de, fenghua.yu@intel.com,
        rui.zhang@intel.com, artem.bityutskiy@linux.intel.com,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 2/2] intel_idle: Add a new flag to initialize the AMX state
Date:   Wed,  8 Jun 2022 09:47:48 -0700
Message-Id: <20220608164748.11864-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220608164748.11864-1-chang.seok.bae@intel.com>
References: <20220608164748.11864-1-chang.seok.bae@intel.com>
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

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by : Zhang Rui <rui.zhang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
---
Changes from v2:
* Remove an unnecessary backslash (Rafael Wysocki).

Changes from v1:
* Simplify the code with a new flag (Rui).
* Rebase on Artem's patches for SPR intel_idle.
* Massage the changelog.
---
 drivers/idle/intel_idle.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b9bb94bd0f67..5f36c4b28f9d 100644
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
@@ -139,6 +145,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
 		local_irq_enable();
 
+	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
+		fpu_idle_fpregs();
+
 	mwait_idle_with_hints(eax, ecx);
 
 	return index;
@@ -159,8 +168,12 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
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
 
@@ -895,7 +908,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
-		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_INIT_XSTATE,
 		.exit_latency = 290,
 		.target_residency = 800,
 		.enter = &intel_idle,
-- 
2.17.1


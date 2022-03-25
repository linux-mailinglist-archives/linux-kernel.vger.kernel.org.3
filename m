Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732E4E6C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357763AbiCYCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357737AbiCYCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:32:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC3B6E45;
        Thu, 24 Mar 2022 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648175438; x=1679711438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yQjfEUUI7oVHVPerk9SvpBNm5Nl0BnDkY26G7WSlbXw=;
  b=NAh4pJT+zpDF5T81V4rXFYEKlrC+cyXZUdHEu4vZf2yWqwdvJ3kRORi4
   BtX1iJEEs4Ig7NfYZ3hrevAuL1c9WlUibEDC4NuDx6hP/va00lzmDVxVb
   aIsA5QAaMgIL2gfnlm6l1T05vL0dNr2hiRdfG7vn4v8K+zZYMmcDb9xo2
   cCyhexQudwaLPRTZeXsT0IEGnM0kbizc76PNs2o8uqcuMl8NFN2iUqP7E
   fVJpF8jdQL1Yyij886LvPD1J3q86v51FdIZPxsMBXuaJSESU88NnRbwlw
   TZl+Xrpk5h3vRdUDASPdyHDFo8wZ6tOlIsYBqK5/QQQugwOLmPbJ8X5gq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321733684"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321733684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="693531285"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2022 19:30:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v3 3/3] intel_idle: Add a new flag to initialize the AMX state
Date:   Thu, 24 Mar 2022 19:22:19 -0700
Message-Id: <20220325022219.829-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220325022219.829-1-chang.seok.bae@intel.com>
References: <20220325022219.829-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
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
index b7640cfe0020..d35790890a3f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -54,6 +54,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -100,6 +101,11 @@ static unsigned int mwait_substates __initdata;
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
@@ -134,6 +140,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
 		local_irq_enable();
 
+	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
+		fpu_idle_fpregs();
+
 	mwait_idle_with_hints(eax, ecx);
 
 	return index;
@@ -154,8 +163,12 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
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
 
@@ -790,7 +803,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
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


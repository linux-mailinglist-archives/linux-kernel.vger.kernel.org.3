Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA954BDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355044AbiFNWyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355318AbiFNWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:54:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCEC4EDD9;
        Tue, 14 Jun 2022 15:54:01 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655247239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqIxOEZu1/5g/oJLKJsCmkjtiIkRzC6cNloXC69GK6o=;
        b=wtfJJ0oUYGcocFqKEITXt8w8dY+k0exi6ru7ZuBXNERoax44eT249WHc1hy5ePorDZBU0X
        Cd/xd1Wv1qP1N4LlOAO4pBT4xOqBFk/DM4Limq8SyZ66s5RZZ2S5e5pUVrF2IdUFtpVaqg
        oomcQ252DOovk/Y4g35xO+qwBswG+MprRzc2nzf2jNY5B1Dn+4+eugIv0DYsBAQ3UREZSf
        aLPk0GwxLaWCnZhS9cU7+S8V7XcbpkHwOOIG4CEdo9475YaK2p+/4Nbs/Uc2TjmyRuzddS
        NKLMlim51YiKnDELr+obLJci3y0kbVM8z2LUveM7lIibiW8aWyJuQyK2jm4K5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655247239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqIxOEZu1/5g/oJLKJsCmkjtiIkRzC6cNloXC69GK6o=;
        b=u696DeF70K8FlGyv3Om28AiaMgcE0NnNHRk2nTgrJ+ijsZCskmGnPS/MSyFnTyZzmZOgVw
        jKlnsk1HCq5qaGBQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] intel_idle: Add a new flag to initialize the AMX state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220608164748.11864-3-chang.seok.bae@intel.com>
References: <20220608164748.11864-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <165524723823.4207.14519279505087770025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f08ef9057b7b110f44cd364744ba6b5f0115390f
Gitweb:        https://git.kernel.org/tip/f08ef9057b7b110f44cd364744ba6b5f0115390f
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 14 Jun 2022 09:41:16 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 14 Jun 2022 15:48:58 -07:00

intel_idle: Add a new flag to initialize the AMX state

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
---
 drivers/idle/intel_idle.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 424ef47..8a19ba1 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -54,6 +54,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -106,6 +107,11 @@ static unsigned int mwait_substates __initdata;
 #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
 
 /*
+ * Initialize large xstate for the C6-state entrance.
+ */
+#define CPUIDLE_FLAG_INIT_XSTATE	BIT(16)
+
+/*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
  * 0x00 means "MWAIT(C1)", 0x10 means "MWAIT(C2)" etc.
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

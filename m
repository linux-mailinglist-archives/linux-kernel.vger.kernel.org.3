Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE957A55F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbiGSRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiGSRbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:31:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69652FC6;
        Tue, 19 Jul 2022 10:31:14 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658251871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvhpNtnA53mQIJQu4q781RlJrC8ZaJ8MpMbIu4iCaE0=;
        b=vU4scu5r2DqWyz8GCXCZEgTMnCNp9+DtbPERPwwOzSQDYdSFLYUiXmlLoe1xBHLd9oiEhe
        1yrlUG1zsYB2jJtcl7bCqtwXxyC6A857w+8s8FsVQBqTggVdAuq3EfP7xLuuTfhWWCeavR
        jJlJEo1MYWvMLqHcuAXWdbjrO/EPFiBTileHPqRNv0h7gU9wfZyLGaGPgW7eAvVYPuBQN/
        sKafR3NKqwrKbfG8+4BvmFizeqlYZ1upWVKIo9NlsBJ9iHjYckwEa1fKko6tdQTJO/mldo
        o/BbVq2aqNRjSDJ+//A7GDjurjFtppySILaGuQfslO+TkugRzwn53/0keItY4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658251871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvhpNtnA53mQIJQu4q781RlJrC8ZaJ8MpMbIu4iCaE0=;
        b=Z/FgWHlt17Eb87K0lfR6p1t7gZo9c05jwRSg4XVKSrLSNTLWIYqJCWMHGqqlweq5Qrcmoi
        27AYcLBIAKoGnBCA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] intel_idle: Add a new flag to initialize the AMX state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220614164116.5196-1-chang.seok.bae@intel.com>
References: <20220614164116.5196-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <165825187026.15455.14720979617017899333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9f01129382774d98ec21526f13da26a0630ee3d8
Gitweb:        https://git.kernel.org/tip/9f01129382774d98ec21526f13da26a0630ee3d8
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Mon, 18 Jul 2022 11:56:11 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Jul 2022 19:17:28 +02:00

intel_idle: Add a new flag to initialize the AMX state

The non-initialized AMX state can be the cause of C-state demotion from C6
to C1E. This low-power idle state may improve power savings and thus result
in a higher available turbo frequency budget.

This behavior is implementation-specific. Initialize the state for the C6
entrance of Sapphire Rapids as needed.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lkml.kernel.org/r/20220614164116.5196-1-chang.seok.bae@intel.com
---
 drivers/idle/intel_idle.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f5c6802..1ec2210 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -114,6 +115,11 @@ static unsigned int mwait_substates __initdata;
 #define CPUIDLE_FLAG_IBRS		BIT(16)
 
 /*
+ * Initialize large xstate for the C6-state entrance.
+ */
+#define CPUIDLE_FLAG_INIT_XSTATE	BIT(17)
+
+/*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
  * 0x00 means "MWAIT(C1)", 0x10 means "MWAIT(C2)" etc.
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

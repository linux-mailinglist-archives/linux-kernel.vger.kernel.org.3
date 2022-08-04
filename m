Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555C589A20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiHDJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiHDJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:52:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0A6112A;
        Thu,  4 Aug 2022 02:52:14 -0700 (PDT)
Date:   Thu, 04 Aug 2022 09:52:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659606733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2qnPvG4/3Vaxg/aiPjUeC6M2IYRgCDPc+iXd58+d7w=;
        b=zShPJp2/pnSp3GmQacfw9JcytZepVUgLEUWM3Ubro5pNG13qmiPitMq4GQ6mFFXu62IWdc
        nbDrl8L938T4S0ZaVARjackysZ7tVw5zWmhmjwJMzvOf425lqSIRBUlf8XicThDkWV75kL
        DhDKP3OH8m4QXo4vGbwjXkJyJ2q7FZ/YvI8zz8RBwAMsv3G1/ZBuxdKsutAcHmy2bLH5ky
        X4OqpgXdIM4TCVdJLBhRbdplopy3GlHkr8ZsT+kOWr2YegkCVIqVxi5UCdA9JuHJSUKXy8
        CfxLydgt/oQ2+GnyuTa9bWt/D4+Tl9kA1jpWKutBfO+VJpv+k+tOVhl2sr0fOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659606733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2qnPvG4/3Vaxg/aiPjUeC6M2IYRgCDPc+iXd58+d7w=;
        b=ZZpqvxeQcmRALpH7+lHKtGl1/cIqxe/wfBSobZzponyaK2OlbB32KEKB50qwXbnYMEzgUt
        yM2G5wOGaIDNosBw==
From:   "tip-bot2 for Fei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/acrn: Set up timekeeping
Cc:     Fei Li <fei1.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Conghui <conghui.chen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804055903.365211-1-fei1.li@intel.com>
References: <20220804055903.365211-1-fei1.li@intel.com>
MIME-Version: 1.0
Message-ID: <165960673199.15455.13027155555937774807.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     81a71f51b89e84f39df2a3b1daf4274ae6b7b194
Gitweb:        https://git.kernel.org/tip/81a71f51b89e84f39df2a3b1daf4274ae6b7b194
Author:        Fei Li <fei1.li@intel.com>
AuthorDate:    Thu, 04 Aug 2022 13:59:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 11:11:59 +02:00

x86/acrn: Set up timekeeping

ACRN Hypervisor reports timing information via CPUID leaf 0x40000010.
Get the TSC and CPU frequency via CPUID leaf 0x40000010 and set the
kernel values accordingly.

Signed-off-by: Fei Li <fei1.li@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Conghui <conghui.chen@intel.com>
Link: https://lore.kernel.org/r/20220804055903.365211-1-fei1.li@intel.com
---
 arch/x86/include/asm/acrn.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/acrn.c  |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index e003a01..1dd1438 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -10,6 +10,15 @@
 /* Bit 0 indicates whether guest VM is privileged */
 #define	ACRN_FEATURE_PRIVILEGED_VM	BIT(0)
 
+/*
+ * Timing Information.
+ * This leaf returns the current TSC frequency in kHz.
+ *
+ * EAX: (Virtual) TSC frequency in kHz.
+ * EBX, ECX, EDX: RESERVED (reserved fields are set to zero).
+ */
+#define ACRN_CPUID_TIMING_INFO		0x40000010
+
 void acrn_setup_intr_handler(void (*handler)(void));
 void acrn_remove_intr_handler(void);
 
@@ -21,6 +30,11 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }
 
+static inline unsigned long acrn_get_tsc_khz(void)
+{
+	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
+}
+
 /*
  * Hypercalls for ACRN
  *
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 23f5f27..485441b 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -28,6 +28,9 @@ static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */
 	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+
+	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
+	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
 }
 
 static bool acrn_x2apic_available(void)

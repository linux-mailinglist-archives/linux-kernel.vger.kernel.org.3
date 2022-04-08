Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8974F91B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiDHJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiDHJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9A16F6F2;
        Fri,  8 Apr 2022 02:08:55 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408933;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI+KFlEHqrWbd4AxyKHE/IZD61ln8yc4GagN+pa2qx4=;
        b=WF8+CatFbmLGIgrHJN7paaU/jm4aDXhNnVcUcd1PBrfiqYgHuGPJBqJNXR6AvuXGPeCbMF
        4yVym7PEnSiHKZywoBDeFywasLG3tR1/LX14TGMglOf58RNyZe94u72IPYrUSOU0j/rfVs
        NBdJ2/RuYbUlBZlz9r0JZ7b16RN1g5UOqpJ3l1/4eVMYVNDU1frXRqIMWsP4JFiAcT1rMy
        OMX2dvHIAjvyEQc/iP7zWl3Pb26uh2Stv7Yhl4A6sekYYn8x72+8lBCrcTVdcxw9+Wu85j
        viOGeuYG4nb0kK8deV5eP1yy5TZWltCqeV2PY8FBqcO196MnSpm0dYL6jTRGhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408933;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI+KFlEHqrWbd4AxyKHE/IZD61ln8yc4GagN+pa2qx4=;
        b=XuKzroajQim8RadwRMNUsyPaqP1arwQOfk6TMeNC+Bp03uk6YjxMrWkBt7PCe1zSM5dgHS
        CgRC2P+6zeDjxaAg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move MSR-based VMGEXITs for CPUID to helper
Cc:     Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-32-brijesh.singh@amd.com>
References: <20220307213356.2797205-32-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893209.389.1409002516534466812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     801baa693c1f6d7327475c39100c456db340cd3e
Gitweb:        https://git.kernel.org/tip/801baa693c1f6d7327475c39100c456db340cd3e
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:11 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

x86/sev: Move MSR-based VMGEXITs for CPUID to helper

This code will also be used later for SEV-SNP-validated CPUID code in
some cases, so move it to a common helper.

While here, also add a check to terminate in cases where the CPUID
function/subfunction is indexed and the subfunction is non-zero, since
the GHCB MSR protocol does not support non-zero subfunctions.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-32-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c |  1 +-
 arch/x86/kernel/sev-shared.c   | 83 ++++++++++++++++++++++-----------
 arch/x86/kernel/sev.c          |  1 +-
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f31b434..7a9cfbc 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/cpuid.h>
 
 #include "error.h"
 #include "../msr.h"
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3aaef1a..b4d5558 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,16 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/* I/O parameters for CPUID-related helpers */
+struct cpuid_leaf {
+	u32 fn;
+	u32 subfn;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+};
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -194,6 +204,44 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 	return verify_exception_info(ghcb, ctxt);
 }
 
+static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
+{
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, reg_idx));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+		return -EIO;
+
+	*reg = (val >> 32);
+
+	return 0;
+}
+
+static int sev_cpuid_hv(struct cpuid_leaf *leaf)
+{
+	int ret;
+
+	/*
+	 * MSR protocol does not support fetching non-zero subfunctions, but is
+	 * sufficient to handle current early-boot cases. Should that change,
+	 * make sure to report an error rather than ignoring the index and
+	 * grabbing random values. If this issue arises in the future, handling
+	 * can be added here to use GHCB-page protocol for cases that occur late
+	 * enough in boot that GHCB page is available.
+	 */
+	if (cpuid_function_is_indexed(leaf->fn) && leaf->subfn)
+		return -EINVAL;
+
+	ret =         __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EAX, &leaf->eax);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EBX, &leaf->ebx);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_ECX, &leaf->ecx);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EDX, &leaf->edx);
+
+	return ret;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -201,40 +249,23 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
  */
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
+	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
+	struct cpuid_leaf leaf;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->ax = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->bx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+	leaf.fn = fn;
+	leaf.subfn = subfn;
+	if (sev_cpuid_hv(&leaf))
 		goto fail;
-	regs->cx = val >> 32;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->dx = val >> 32;
+	regs->ax = leaf.eax;
+	regs->bx = leaf.ebx;
+	regs->cx = leaf.ecx;
+	regs->dx = leaf.edx;
 
 	/*
 	 * This is a VC handler and the #VC is only raised when SEV-ES is
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d7915ae..0c2bf39 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -33,6 +33,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
+#include <asm/cpuid.h>
 
 #define DR7_RESET_VALUE        0x400
 

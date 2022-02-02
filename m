Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6554A6BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbiBBGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbiBBGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064EC06176D;
        Tue,  1 Feb 2022 22:31:16 -0800 (PST)
Date:   Wed, 02 Feb 2022 06:31:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643783475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSfeVxSbBIpcOWuTIPE14rIt/mbL6OQ6aY+mHwWRWvs=;
        b=yhmQrue0wYm1+WfCHlhaHvuvGlmCuxDcG+K9NwM8kazaIxbtDUyOXnTVyUIkCG68dA/fU0
        xRWQf5YxFvwOXC8wifDLtDCgKzOBRnIMHwfPymQbdXg4Kf3PvAZQ39USZCQtUtW5AcLXsZ
        V+aztafP4KooCKqjlE1IhcGOwMaFoW6M4VLD4eGnPh9IE9T2KrWWMc7aeJ1MpaJjXTTh/u
        Ogi18kawq0AAhJQAMXQU/QGXKUyWSIwueQOdQWudDBMwGEhrbfXVia0agifLMyDr7vYF3T
        QSSJx88aaSgioXY0QV0xCecWez3BLEid+SsjqS3R4scqmTKOnodNupf+Gt3gRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643783475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSfeVxSbBIpcOWuTIPE14rIt/mbL6OQ6aY+mHwWRWvs=;
        b=F3CrPSd5WiAhtkW1jLtk3DSk9a8u0W2f0u4sv3g7xaKJVmeAZOrRLWgsHaaSzI8UhcZbLU
        /OlbwCEHwI2xikAQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Read/save PPIN MSR during initialization
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220131230111.2004669-4-tony.luck@intel.com>
References: <20220131230111.2004669-4-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <164378347431.16921.12171659364065648377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     822ccfade55b6be7977b364356fcf2d78d8a373a
Gitweb:        https://git.kernel.org/tip/822ccfade55b6be7977b364356fcf2d78d8a373a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 31 Jan 2022 15:01:09 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Feb 2022 16:29:26 +01:00

x86/cpu: Read/save PPIN MSR during initialization

Currently, the PPIN (Protected Processor Inventory Number) MSR is read
by every CPU that processes a machine check, CMCI, or just polls machine
check banks from a periodic timer. This is not a "fast" MSR, so this
adds to overhead of processing errors.

Add a new "ppin" field to the cpuinfo_x86 structure. Read and save the
PPIN during initialization. Use this copy in mce_setup() instead of
reading the MSR.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220131230111.2004669-4-tony.luck@intel.com
---
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/kernel/cpu/common.c     | 4 ++++
 arch/x86/kernel/cpu/mce/core.c   | 7 +------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12a..a87e7c3 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -119,6 +119,8 @@ struct cpuinfo_x86 {
 	int			x86_cache_mbm_width_offset;
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
+	/* protected processor identification number */
+	u64			ppin;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
 	u16			apicid;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0681c69..64deb77 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -91,14 +91,17 @@ DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
+	int	msr_ppin;
 } ppin_info[] = {
 	[X86_VENDOR_INTEL] = {
 		.feature = X86_FEATURE_INTEL_PPIN,
 		.msr_ppin_ctl = MSR_PPIN_CTL,
+		.msr_ppin = MSR_PPIN
 	},
 	[X86_VENDOR_AMD] = {
 		.feature = X86_FEATURE_AMD_PPIN,
 		.msr_ppin_ctl = MSR_AMD_PPIN_CTL,
+		.msr_ppin = MSR_AMD_PPIN
 	},
 };
 
@@ -153,6 +156,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
 	/* Is the enable bit set? */
 	if (val & 2UL) {
+		c->ppin = __rdmsr(info->msr_ppin);
 		set_cpu_cap(c, info->feature);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b83..4f1e825 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -138,12 +138,7 @@ void mce_setup(struct mce *m)
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-
-	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
-		m->ppin = __rdmsr(MSR_PPIN);
-	else if (this_cpu_has(X86_FEATURE_AMD_PPIN))
-		m->ppin = __rdmsr(MSR_AMD_PPIN);
-
+	m->ppin = cpu_data(m->extcpu).ppin;
 	m->microcode = boot_cpu_data.microcode;
 }
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC449B360
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351073AbiAYL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382272AbiAYLtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:49:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC465C061759
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:45:57 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FBAB1EC0535;
        Tue, 25 Jan 2022 12:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643111152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lYvYSfQSagek4CZDcnE7J88PEozcFNkL2m0Wwjtl3sA=;
        b=jn24QfU+dM2+SGEXSWHEeMaOBKiPWe+hFeey+IOtjXBVuuDuTyNVOZcZn3uAOH4nCf6e3Z
        plH3a4h0PDLgKBEjuW9q5WkVcUxeUXsjsD6nwasd1xExwHSw40nz7P4FKgvyAsQ/M4F8V3
        zIgxoN9640XmdlZdl7r/LN0+mC0Ap/Q=
Date:   Tue, 25 Jan 2022 12:45:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1.1] x86/cpu: Allow feature bit names from /proc/cpuinfo in
 clearcpuid=
Message-ID: <Ye/i67y8ypnlLsu7@zn.tnic>
References: <20211112103246.7555-1-bp@alien8.de>
 <20211112103246.7555-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112103246.7555-2-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:32:41AM +0100, Borislav Petkov wrote:
> clearcpuid=de,440,smca,succory,bmi1,3dnow ("succory" is wrong on
> purpose).

Here's v1.1 which handles the case where we have ""-defined feature
flags - for example:

#define X86_FEATURE_AMD_SSBD            (13*32+24) /* "" Speculative Store Bypass Disable */

and for which there's no string name generated.

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 10 Nov 2021 19:30:07 +0100
Subject: [PATCH v1.1] x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=

Having to give the X86_FEATURE array indices in order to disable a
feature bit for testing is not really user-friendly. So accept the
feature bit names too.

Some feature bits don't have names so there the array indices are still
accepted, of course.

Clearing CPUID flags is not something which should be done in production
so taint the kernel too.

An exemplary cmdline would then be something like:

  clearcpuid=de,440,smca,succory,bmi1,3dnow

("succory" is wrong on purpose). And it says:

[    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211112103246.7555-2-bp@alien8.de
---
 .../admin-guide/kernel-parameters.txt         | 11 +++-
 arch/x86/include/asm/cpufeature.h             |  7 ++-
 arch/x86/kernel/cpu/common.c                  | 57 +++++++++++++++----
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..b67d0cf27997 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -631,12 +631,17 @@
 			Defaults to zero when built as a module and to
 			10 seconds when built into the kernel.
 
-	clearcpuid=BITNUM[,BITNUM...] [X86]
+	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
+			numbers X. Note the Linux-specific bits are not necessarily
+			stable over kernel options, but the vendor-specific
 			ones should be.
+			X can also be a string as appearing in the flags: line
+			in /proc/cpuinfo which does not have the above
+			instability issue. However, not all features have names
+			in /proc/cpuinfo.
+			Note that using this option will taint your kernel.
 			Also note that user programs calling CPUID directly
 			or using the feature without checking anything
 			will still see it. This just prevents it from
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1261842d006c..66d3e3b1d24d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -34,14 +34,17 @@ enum cpuid_leafs
 	CPUID_8000_001F_EAX,
 };
 
+#define X86_CAP_FMT_NUM "%d:%d"
+#define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
+
 #ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
 #else
-#define X86_CAP_FMT "%d:%d"
-#define x86_cap_flag(flag) ((flag) >> 5), ((flag) & 31)
+#define X86_CAP_FMT X86_CAP_FMT_NUM
+#define x86_cap_flag x86_cap_flag_num
 #endif
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7b8382c11788..aaac18d800a4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1237,8 +1237,8 @@ static void detect_nopl(void)
 static void __init cpu_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -1266,21 +1266,54 @@ static void __init cpu_parse_early_param(void)
 		return;
 
 	pr_info("Clearing CPUID bits:");
-	do {
-		res = get_option(&argptr, &bit);
-		if (res == 0 || res == 3)
-			break;
 
-		/* If the argument was too long, the last bit may be cut off */
-		if (res == 1 && arglen >= sizeof(arg))
-			break;
+	while (argptr) {
+		unsigned int bit;
+
+		opt = strsep(&argptr, ",");
 
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+		/*
+		 * Handle naked numbers first for feature flags which don't
+		 * have names.
+		 */
+		if (!kstrtouint(opt, 10, &bit)) {
+			if (bit < NCAPINTS * 32) {
+
+				/* empty-string, i.e., ""-defined feature flags */
+				if (!x86_cap_flags[bit])
+					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
+				else
+					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+
+				setup_clear_cpu_cap(bit);
+				taint++;
+			}
+			/*
+			 * The assumption is that there are no feature names with only
+			 * numbers in the name thus go to the next argument.
+			 */
+			continue;
+		}
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+		for (bit = 0; bit < 32 * NCAPINTS; bit++) {
+			if (!x86_cap_flag(bit))
+				continue;
+
+			if (strcmp(x86_cap_flag(bit), opt))
+				continue;
+
+			pr_cont(" %s", opt);
 			setup_clear_cpu_cap(bit);
+			taint++;
+			break;
 		}
-	} while (res == 2);
+#endif
+	}
 	pr_cont("\n");
+
+	if (taint)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 }
 
 /*
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82C4F1DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384877AbiDDVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379939AbiDDSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:24:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117EA22B37;
        Mon,  4 Apr 2022 11:22:24 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096542;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bhYIbi72otG99otFf4I9iZGO7oJkZwCdM3u1lgPpxw=;
        b=wyboggQOEz457WwlH4wPsCTgIO2tJvpAJQLdkzdgo3jihgtN3dProI86f12cGlpdL9d0Nc
        hvW6BW4kX9j9Znx6c5JwzKPcHskDfUPO3tyldAo7PZ6yDvTFSpzp36hP8Y958gf0Dzt6Op
        C+f9oKsRlLdzDyELzio88QihZ9JTafaGVLnqsyldkN6PUjaKJCySirXsMt7yqPXXu0VzeQ
        WugWPPiQ+tR7LYuCDuYytXjWoipA4GWUiuzQPMGEqPohaavNWbeaP0evtrBbwK9jkairyL
        41CjC9i7KwOIbL4RuTSPhW4/jFIUiYAxUS0+hf4r8oA+FHrPcA8UQ0epkmxiQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096542;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bhYIbi72otG99otFf4I9iZGO7oJkZwCdM3u1lgPpxw=;
        b=e4vjrZw56HVzwHNttgDRVKrjfl243bNLRAEiaZjOMTotWAbDE1svmprfEjFsja7vLzQMN8
        iMUUtn1XwIFyVSBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Allow feature bit names from /proc/cpuinfo in
 clearcpuid=
Cc:     Borislav Petkov <bp@suse.de>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220127115626.14179-2-bp@alien8.de>
References: <20220127115626.14179-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909654162.389.17691092502632436433.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1625c833db93516faaac5feedadf8d19c14238b6
Gitweb:        https://git.kernel.org/tip/1625c833db93516faaac5feedadf8d19c14238b6
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 27 Jan 2022 12:56:21 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:16:52 +02:00

x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=

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

  [   ... ] Clearing CPUID bits: de 13:24 smca (unknown: succory) bmi1 3dnow

  [ Fix CONFIG_X86_FEATURE_NAMES=n build error as reported by the 0day
    robot: https://lore.kernel.org/r/202203292206.ICsY2RKX-lkp@intel.com ]

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-2-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++-
 arch/x86/include/asm/cpufeature.h               |  7 +-
 arch/x86/kernel/cpu/common.c                    | 64 +++++++++++++---
 3 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e..0ea1786 100644
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
index 1261842..66d3e3b 100644
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
index ed44175..69c7ea8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1368,8 +1368,8 @@ static void detect_nopl(void)
 static void __init cpu_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -1397,21 +1397,61 @@ static void __init cpu_parse_early_param(void)
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
+		bool found __maybe_unused = false;
+		unsigned int bit;
+
+		opt = strsep(&argptr, ",");
+
+		/*
+		 * Handle naked numbers first for feature flags which don't
+		 * have names.
+		 */
+		if (!kstrtouint(opt, 10, &bit)) {
+			if (bit < NCAPINTS * 32) {
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+				/* empty-string, i.e., ""-defined feature flags */
+				if (!x86_cap_flags[bit])
+					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
+				else
+#endif
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
 
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			if (strcmp(x86_cap_flag(bit), opt))
+				continue;
+
+			pr_cont(" %s", opt);
 			setup_clear_cpu_cap(bit);
+			taint++;
+			found = true;
+			break;
 		}
-	} while (res == 2);
+
+		if (!found)
+			pr_cont(" (unknown: %s)", opt);
+#endif
+	}
 	pr_cont("\n");
+
+	if (taint)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 }
 
 /*

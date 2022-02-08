Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E44AD7F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349372AbiBHLyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiBHLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:54:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E8BC03FEC9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:54:16 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3D281EC02B9;
        Tue,  8 Feb 2022 12:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644321251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uptMnPYFOV21XdwltxMzn4qXCKEGhUF3xlm4y4miDxM=;
        b=T6+QvWNqSkurVXjh394cF3DZoIQPSwiqBpCqqjNBdWZtKBmqeH68l8ixpwkM4oHML/yMn0
        WaVZT4zZyZfItTCp/5tz3lkmb6jSooEJIRIm7eMxLrZffQRDdxOWfSH/gwo/Xp4GZGTfeH
        wfUjUtCXQm4x2nHbcbztc5ZFiaoPedM=
Date:   Tue, 8 Feb 2022 12:54:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] x86/cpu: Allow feature bit names from
 /proc/cpuinfo in clearcpuid=
Message-ID: <YgJZ3YkJdNstZ/ZH@zn.tnic>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-2-bp@alien8.de>
 <202202071402.DEFD6C9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202202071402.DEFD6C9@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:04:04PM -0800, Kees Cook wrote:
> I like the taint flag addition!

IKR. See below.

> Even though it reports what it does actually clear, do you think it
> might be more "friendly" to yell about unknown stuff too? i.e.:

Well, this thing is not supposed to be used by normal users anyway.
There was even talk of completely removing it but CPU folks wanna do
some experiments with it, that's why we kept it.

And for exactly the same reason it taints the kernel - so that we know
that it is an "out-of-spec" situation.

I even caused an explosion while testing it due to creating an
impossible configuration of features.

So, folks who use it better know what they're doing.

> [    0.000000] Clearing CPUID bits: unknown bit 'succory'
> [    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow

How's the below (I don't want to disrupt the pr_cont flow too much):

On the cmdline I have:

... clearcpuid=de,440,smca,succory,bmi1,3dnow,bla,foo ...

which says:

[    0.000000] Clearing CPUID bits: de 13:24 smca (unknown: succory) bmi1 3dnow (unknown: bla) (unknown: foo)

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 27 Jan 2022 12:56:21 +0100
Subject: [PATCH] x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=

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

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-2-bp@alien8.de
---
 .../admin-guide/kernel-parameters.txt         | 11 +++-
 arch/x86/include/asm/cpufeature.h             |  7 ++-
 arch/x86/kernel/cpu/common.c                  | 62 +++++++++++++++----
 3 files changed, 63 insertions(+), 17 deletions(-)

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
index 64deb7727d00..cd24372253ee 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1314,8 +1314,8 @@ static void detect_nopl(void)
 static void __init cpu_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -1343,21 +1343,59 @@ static void __init cpu_parse_early_param(void)
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
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

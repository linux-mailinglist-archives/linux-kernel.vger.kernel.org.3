Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC05B17B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIHIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiIHIuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:50:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D48AE6A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:49:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 775A433D05;
        Thu,  8 Sep 2022 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662626975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VO1KJ/u/ib2qUpol38xHlsTfJwgbgZU3CITv1ZXGXRM=;
        b=edyPxqB/PM+o5arDhm1zEr/7Nmqhgqu4puhUMR8kT0yyu/ppXHK2ygugnxfwiDBwEhN0h6
        bZDTdxrW6HUOWxOT5hnD2cOiRa7a3US7XDgtEqeRzYSqgh9ru6SrXfqIIuuuSA0TWZoBlf
        p7WIfvVqeGBD+fAtya0y9nZyHfzQ8UM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 366601322C;
        Thu,  8 Sep 2022 08:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 55n+C5+sGWNnNgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 08 Sep 2022 08:49:35 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 03/10] x86/mtrr: replace use_intel() with a local flag
Date:   Thu,  8 Sep 2022 10:49:07 +0200
Message-Id: <20220908084914.21703-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908084914.21703-1-jgross@suse.com>
References: <20220908084914.21703-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MTRR code use_intel() is only used in one source file, and the
relevant use_intel_if member of struct mtrr_ops is set only in
generic_mtrr_ops.

Replace use_intel() with a single flag in cacheinfo.c, which can be set
when assigning generic_mtrr_ops to mtrr_if. This allows to drop
use_intel_if from mtrr_ops, while preparing to support PAT without
MTRR. As another preparation for the PAT/MTRR decoupling use a bit for
MTRR control and one for PAT control. For now set both bits together,
this can be changed later.

As the new flag will be set only if mtrr_enabled is set, the test for
mtrr_enabled can be dropped at some places.

At the same time drop the local mtrr_enabled() function and rename
the __mtrr_enabled flag to mtrr_enabled.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/cacheinfo.h   |  5 +++
 arch/x86/kernel/cpu/cacheinfo.c    |  3 ++
 arch/x86/kernel/cpu/mtrr/generic.c |  1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 58 ++++++++++++++----------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 --
 5 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b2e0dcc4bf..1aeafa9888f7 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_X86_CACHEINFO_H
 #define _ASM_X86_CACHEINFO_H
 
+/* Kernel controls MTRR and/or PAT MSRs. */
+extern unsigned int cache_generic;
+#define CACHE_GENERIC_MTRR 0x01
+#define CACHE_GENERIC_PAT  0x02
+
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 66556833d7af..3b05d3ade7a6 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -35,6 +35,9 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 /* Shared L2 cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 
+/* Kernel controls MTRR and/or PAT MSRs. */
+unsigned int cache_generic;
+
 struct _cache_table {
 	unsigned char descriptor;
 	char cache_type;
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index cd64eab02393..81742870ecc5 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -917,7 +917,6 @@ int positive_have_wrcomb(void)
  * Generic structure...
  */
 const struct mtrr_ops generic_mtrr_ops = {
-	.use_intel_if		= 1,
 	.set_all		= generic_set_all,
 	.get			= generic_get_mtrr,
 	.get_free_region	= generic_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 2746cac9d8a9..7d7d5bd30219 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -46,6 +46,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/rcupdate.h>
 
+#include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
 #include <asm/e820/api.h>
 #include <asm/mtrr.h>
@@ -58,12 +59,7 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool __mtrr_enabled;
-
-static bool mtrr_enabled(void)
-{
-	return __mtrr_enabled;
-}
+static bool mtrr_enabled;
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
@@ -119,11 +115,11 @@ static int have_wrcomb(void)
 }
 
 /*  This function returns the number of variable MTRRs  */
-static void __init set_num_var_ranges(void)
+static void __init set_num_var_ranges(bool use_generic)
 {
 	unsigned long config = 0, dummy;
 
-	if (use_intel())
+	if (use_generic)
 		rdmsr(MSR_MTRRcap, config, dummy);
 	else if (is_cpu(AMD) || is_cpu(HYGON))
 		config = 2;
@@ -303,7 +299,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	int i, replace, error;
 	mtrr_type ltype;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled)
 		return -ENXIO;
 
 	error = mtrr_if->validate_add_page(base, size, type);
@@ -451,7 +447,7 @@ static int mtrr_check(unsigned long base, unsigned long size)
 int mtrr_add(unsigned long base, unsigned long size, unsigned int type,
 	     bool increment)
 {
-	if (!mtrr_enabled())
+	if (!mtrr_enabled)
 		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
@@ -480,7 +476,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled)
 		return -ENODEV;
 
 	max = num_var_ranges;
@@ -540,7 +536,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
  */
 int mtrr_del(int reg, unsigned long base, unsigned long size)
 {
-	if (!mtrr_enabled())
+	if (!mtrr_enabled)
 		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
@@ -566,7 +562,7 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 {
 	int ret;
 
-	if (pat_enabled() || !mtrr_enabled())
+	if (pat_enabled() || !mtrr_enabled)
 		return 0;  /* Success!  (We don't need to do anything.) */
 
 	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
@@ -686,6 +682,7 @@ int __initdata changed_by_mtrr_cleanup;
  */
 void __init mtrr_bp_init(void)
 {
+	bool use_generic = false;
 	u32 phys_addr;
 
 	init_ifs();
@@ -694,6 +691,7 @@ void __init mtrr_bp_init(void)
 
 	if (boot_cpu_has(X86_FEATURE_MTRR)) {
 		mtrr_if = &generic_mtrr_ops;
+		use_generic = true;
 		size_or_mask = SIZE_OR_MASK_BITS(36);
 		size_and_mask = 0x00f00000;
 		phys_addr = 36;
@@ -755,15 +753,18 @@ void __init mtrr_bp_init(void)
 	}
 
 	if (mtrr_if) {
-		__mtrr_enabled = true;
-		set_num_var_ranges();
+		mtrr_enabled = true;
+		set_num_var_ranges(use_generic);
 		init_table();
-		if (use_intel()) {
+		if (use_generic) {
 			/* BIOS may override */
-			__mtrr_enabled = get_mtrr_state();
+			mtrr_enabled = get_mtrr_state();
 
-			if (mtrr_enabled())
+			if (mtrr_enabled) {
 				mtrr_bp_pat_init();
+				cache_generic |= CACHE_GENERIC_MTRR |
+						 CACHE_GENERIC_PAT;
+			}
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
@@ -772,7 +773,7 @@ void __init mtrr_bp_init(void)
 		}
 	}
 
-	if (!mtrr_enabled()) {
+	if (!mtrr_enabled) {
 		pr_info("Disabled\n");
 
 		/*
@@ -786,10 +787,7 @@ void __init mtrr_bp_init(void)
 
 void mtrr_ap_init(void)
 {
-	if (!mtrr_enabled())
-		return;
-
-	if (!use_intel() || mtrr_aps_delayed_init)
+	if (!cache_generic || mtrr_aps_delayed_init)
 		return;
 
 	/*
@@ -816,7 +814,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
@@ -825,9 +823,7 @@ void mtrr_save_state(void)
 
 void set_mtrr_aps_delayed_init(void)
 {
-	if (!mtrr_enabled())
-		return;
-	if (!use_intel())
+	if (!cache_generic)
 		return;
 
 	mtrr_aps_delayed_init = true;
@@ -838,7 +834,7 @@ void set_mtrr_aps_delayed_init(void)
  */
 void mtrr_aps_init(void)
 {
-	if (!use_intel() || !mtrr_enabled())
+	if (!cache_generic)
 		return;
 
 	/*
@@ -855,7 +851,7 @@ void mtrr_aps_init(void)
 
 void mtrr_bp_restore(void)
 {
-	if (!use_intel() || !mtrr_enabled())
+	if (!cache_generic)
 		return;
 
 	mtrr_if->set_all();
@@ -863,10 +859,10 @@ void mtrr_bp_restore(void)
 
 static int __init mtrr_init_finialize(void)
 {
-	if (!mtrr_enabled())
+	if (!mtrr_enabled)
 		return 0;
 
-	if (use_intel()) {
+	if (cache_generic & CACHE_GENERIC_MTRR) {
 		if (!changed_by_mtrr_cleanup)
 			mtrr_state_warn();
 		return 0;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 2ac99e561181..88b1c4b6174a 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -14,7 +14,6 @@ extern unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 
 struct mtrr_ops {
 	u32	vendor;
-	u32	use_intel_if;
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
 	void	(*set_all)(void);
@@ -61,7 +60,6 @@ extern u64 size_or_mask, size_and_mask;
 extern const struct mtrr_ops *mtrr_if;
 
 #define is_cpu(vnd)	(mtrr_if && mtrr_if->vendor == X86_VENDOR_##vnd)
-#define use_intel()	(mtrr_if && mtrr_if->use_intel_if == 1)
 
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
-- 
2.35.3


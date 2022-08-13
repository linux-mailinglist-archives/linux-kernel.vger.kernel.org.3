Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B6591D06
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 00:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiHMWjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 18:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiHMWix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:38:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB16CD23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660430332; x=1691966332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KR/HBP1wOvQFpjD2YET+iCx+bjZqywBPEsVL8qmACU8=;
  b=XdR0J6UZB/OVuAHNaU70tz+7llqT8yEM3SzE0PSwYbKSoZrrOU1+NpSE
   Vb4TvwXZfyofMlncp//vgGZYWq2G4FH5KZkoj13cdbIhNZjVscMCxHfXt
   /dwrqVS9bALz0un4gKmTezXXqJuJsGUafzueHnkwnibd1Xsd8zfhIx6Z0
   9kaFqZBV+gu+1pZzdGZrP9OfMqhNybkulchStLfock782rD1asjUxK3EQ
   dUFaERsMjaxnfmRQORAa5ju7C7zF+ZWt6NwgSyFERdrbSprzjOJTM9DPk
   v4LS8dHqpe8XCvM3nuOZ3dyDD57eWCEYW3BMxhXqpwx5OLgHbijw1UakQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353523722"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="353523722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556890234"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4/5] x86/microcode: Avoid any chance of MCE's during microcode update
Date:   Sat, 13 Aug 2022 22:38:24 +0000
Message-Id: <20220813223825.3164861-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220813223825.3164861-1-ashok.raj@intel.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a microcode update is in progress, several instructions and MSR's can
be patched by the update. During the update in progress, touching any of
the resources being patched could result in unpredictable results. If
thread0 is doing the update and thread1 happens to get a MCE, the handler
might read an MSR that's being patched.

In order to have predictable behavior, to avoid this scenario we set the MCIP in
all threads. Since MCE's can't be nested, HW will automatically promote to
shutdown condition.

After the update is completed, MCIP flag is cleared. The system is going to
shutdown anyway, since the MCE could be a fatal error, or even recoverable
errors in kernel space are treated as unrecoverable.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/mce.h           |  4 ++++
 arch/x86/kernel/cpu/mce/core.c       |  9 +++++++++
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..2aef6120e23f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -207,12 +207,16 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
+extern void mce_set_mcip(void);
+extern void mce_clear_mcip(void);
 #else
 static inline int mcheck_init(void) { return 0; }
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
+static inline void mce_set_mcip(void) {}
+static inline void mce_clear_mcip(void) {}
 #endif
 
 void mce_setup(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..72b49d95bb3b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -402,6 +402,15 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
+void mce_set_mcip(void)
+{
+	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x1);
+}
+
+void mce_clear_mcip(void)
+{
+	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x0);
+}
 /*
  * Collect all global (w.r.t. this processor) status about this machine
  * check into our "mce" struct so that we can use it later to assess
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ad57e0e4d674..d24e1c754c27 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -39,6 +39,7 @@
 #include <asm/processor.h>
 #include <asm/cmdline.h>
 #include <asm/setup.h>
+#include <asm/mce.h>
 
 #define DRIVER_VERSION	"2.2"
 
@@ -450,6 +451,14 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
+	/*
+	 * Its dangerous to let MCE while microcode update is in progress.
+	 * Its extremely rare and even if happens they are fatal errors.
+	 * But reading patched areas before the update is complete can be
+	 * leading to unpredictable results. Setting MCIP will guarantee
+	 * the platform is taken to reset predictively.
+	 */
+	mce_set_mcip();
 	/*
 	 * On an SMT system, it suffices to load the microcode on one sibling of
 	 * the core because the microcode engine is shared between the threads.
@@ -457,6 +466,7 @@ static int __reload_late(void *info)
 	 * loading attempts happen on multiple threads of an SMT core. See
 	 * below.
 	 */
+
 	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
 		apply_microcode_local(&err);
 	else
@@ -473,6 +483,7 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
 		panic("Timeout during microcode update!\n");
 
+	mce_clear_mcip();
 	/*
 	 * At least one thread has completed update on each core.
 	 * For others, simply call the update to make sure the
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C14F87DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiDGTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiDGTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62F23F38A;
        Thu,  7 Apr 2022 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358865; x=1680894865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=v8fg/6b+RiL40tjdRPvkX79y7/36eLSaDV4i3s78nKQ=;
  b=TpNm7HBOUinCMXnni9Ss2kZmx0VG5I3OjDNZNKukdLuE9kn4v11j5ayu
   31BrwyEf301w8Ose18kwwq/rDGGdJQXcPRXTtFD/ucr65HwCnJMHlfYmA
   MFAqlJtqYaQzLunJ56eyYJ7ECxqpgxA3R+1oyKiWdxuiCdeowVzRJhuXB
   QCk9FxK7pJWXWVAQqgfODDbEF1xfAJzCfPMF1YFxWOg3N3x/nv8DrOF80
   g9ModjSBxkoiOMvAULsi6XC5p/PvwWxYKqQ+bgn/modsao/32Zt6VJL8m
   eOz9KwTlT4htCV1dEQfCqEq/DNyL2gTPyN6QMPDEMVsBDytCzHtagj+Ov
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255376"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255376"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193702"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:15 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v2 01/10] x86/microcode/intel: expose collect_cpu_info_early() for IFS
Date:   Thu,  7 Apr 2022 12:13:38 -0700
Message-Id: <20220407191347.9681-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS is a CPU feature that allows a binary blob, similar to microcode,
to be loaded and consumed to perform low level validation of CPU
circuitry. In fact, it carries the same Processor Signature
(family/model/stepping) details that are contained in Intel microcode
blobs. In support of an IFS driver to trigger loading, validation, and
running of these tests blobs, export cpu_signatures_match() and
collect_cpu_info_early().

Rename collect_cpu_info_early() to cpu_collect_info_early()
to keep a more appropriate prefix.

Per Boris [1], move these helpers to a generic location.

No functional change intended.

Link: https://lore.kernel.org/lkml/Yh9HKhESkcUIYzSr@nazgul.tnic/ [1]

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/microcode_intel.h |  4 ++
 arch/x86/kernel/cpu/intel.c            | 47 ++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c  | 55 +++-----------------------
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index d85a07d7154f..cf0fd1d712b4 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -68,6 +68,10 @@ static inline u32 intel_get_microcode_revision(void)
 	return rev;
 }
 
+int cpu_collect_info_early(struct ucode_cpu_info *uci);
+bool cpu_signatures_match(unsigned int s1, unsigned int p1,
+			  unsigned int s2, unsigned int p2);
+
 #ifdef CONFIG_MICROCODE_INTEL
 extern void __init load_ucode_intel_bsp(void);
 extern void load_ucode_intel_ap(void);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..2008c8267fd3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -181,6 +181,53 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+bool cpu_signatures_match(unsigned int s1, unsigned int p1,
+			  unsigned int s2, unsigned int p2)
+{
+	if (s1 != s2)
+		return false;
+
+	/* Processor flags are either both 0 ... */
+	if (!p1 && !p2)
+		return true;
+
+	/* ... or they intersect. */
+	return p1 & p2;
+}
+EXPORT_SYMBOL_GPL(cpu_signatures_match);
+
+int cpu_collect_info_early(struct ucode_cpu_info *uci)
+{
+	unsigned int val[2];
+	unsigned int family, model;
+	struct cpu_signature csig = { 0 };
+	unsigned int eax, ebx, ecx, edx;
+
+	memset(uci, 0, sizeof(*uci));
+
+	eax = 0x00000001;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	csig.sig = eax;
+
+	family = x86_family(eax);
+	model  = x86_model(eax);
+
+	if ((model >= 5) || (family > 6)) {
+		/* get processor flags from MSR 0x17 */
+		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
+		csig.pf = 1 << ((val[1] >> 18) & 7);
+	}
+
+	csig.rev = intel_get_microcode_revision();
+
+	uci->cpu_sig = csig;
+	uci->valid = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpu_collect_info_early);
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d28a9f8f3fec..7220327a6b1f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -45,20 +45,6 @@ static struct microcode_intel *intel_ucode_patch;
 /* last level cache size per core */
 static int llc_size_per_core;
 
-static inline bool cpu_signatures_match(unsigned int s1, unsigned int p1,
-					unsigned int s2, unsigned int p2)
-{
-	if (s1 != s2)
-		return false;
-
-	/* Processor flags are either both 0 ... */
-	if (!p1 && !p2)
-		return true;
-
-	/* ... or they intersect. */
-	return p1 & p2;
-}
-
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
@@ -342,37 +328,6 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 	return patch;
 }
 
-static int collect_cpu_info_early(struct ucode_cpu_info *uci)
-{
-	unsigned int val[2];
-	unsigned int family, model;
-	struct cpu_signature csig = { 0 };
-	unsigned int eax, ebx, ecx, edx;
-
-	memset(uci, 0, sizeof(*uci));
-
-	eax = 0x00000001;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	csig.sig = eax;
-
-	family = x86_family(eax);
-	model  = x86_model(eax);
-
-	if ((model >= 5) || (family > 6)) {
-		/* get processor flags from MSR 0x17 */
-		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig.pf = 1 << ((val[1] >> 18) & 7);
-	}
-
-	csig.rev = intel_get_microcode_revision();
-
-	uci->cpu_sig = csig;
-	uci->valid = 1;
-
-	return 0;
-}
-
 static void show_saved_mc(void)
 {
 #ifdef DEBUG
@@ -386,7 +341,7 @@ static void show_saved_mc(void)
 		return;
 	}
 
-	collect_cpu_info_early(&uci);
+	cpu_collect_info_early(&uci);
 
 	sig	= uci.cpu_sig.sig;
 	pf	= uci.cpu_sig.pf;
@@ -502,7 +457,7 @@ void show_ucode_info_early(void)
 	struct ucode_cpu_info uci;
 
 	if (delay_ucode_info) {
-		collect_cpu_info_early(&uci);
+		cpu_collect_info_early(&uci);
 		print_ucode_info(&uci, current_mc_date);
 		delay_ucode_info = 0;
 	}
@@ -604,7 +559,7 @@ int __init save_microcode_in_initrd_intel(void)
 	if (!(cp.data && cp.size))
 		return 0;
 
-	collect_cpu_info_early(&uci);
+	cpu_collect_info_early(&uci);
 
 	scan_microcode(cp.data, cp.size, &uci, true);
 
@@ -637,7 +592,7 @@ static struct microcode_intel *__load_ucode_intel(struct ucode_cpu_info *uci)
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	collect_cpu_info_early(uci);
+	cpu_collect_info_early(uci);
 
 	return scan_microcode(cp.data, cp.size, uci, false);
 }
@@ -712,7 +667,7 @@ void reload_ucode_intel(void)
 	struct microcode_intel *p;
 	struct ucode_cpu_info uci;
 
-	collect_cpu_info_early(&uci);
+	cpu_collect_info_early(&uci);
 
 	p = find_patch(&uci);
 	if (!p)
-- 
2.17.1


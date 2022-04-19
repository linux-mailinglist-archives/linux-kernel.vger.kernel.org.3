Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976935075EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355077AbiDSRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355889AbiDSRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:02:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64983CFDC;
        Tue, 19 Apr 2022 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650387164; x=1681923164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0eiWzT86/lbXfzWNlN+Vul7m6CHrSxIYiXYV0a9Dip4=;
  b=CvVVUfwUl3MrDVahrwzdFLGK+39EgLOQVkc18XSQjYWFeOOuFhN7LsE1
   13Mqv13PRzNAOoVSpGWs+LxfiikLWrxl5PSeN72Clh0ad5wTH6Afd7D5g
   aTkKcIAAruMfDZzrWGfd9UfcXSxb2KxdSL8kEenyZWQyiIR+GH85Br2S3
   RYRxDBN9t3gJXF4fW669oTq7ORgzWp4kdLHIn/4Y8+P6G1ywB0O7MPdLb
   9V0RdeLpKrUJYM2mV3xrqNVR7oyN0mzB2uPu5DePV0T8m/zgxXM40nvVi
   Ky69P8vgl8CkHWbIkLHsuXZFmnM/IdJsq2wQIdtFo8guKzdxNfKdiluN7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326714903"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="326714903"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:52:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="657708530"
Received: from jcrode-mobl.amr.corp.intel.com (HELO guptapa-desk) ([10.252.132.175])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:52:43 -0700
Date:   Tue, 19 Apr 2022 09:52:41 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Pelton, Kyle D" <kyle.d.pelton@intel.com>
Subject: [PATCH] x86/cpu: Load microcode during restore_processor_state()
Message-ID: <4350dfbf785cd482d3fafa72b2b49c83102df3ce.1650386317.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

When resuming from system sleep state, restore_processor_state()
restores the boot CPU MSRs. These MSRs could be emulated by the
microcode. If microcode is not loaded yet, writing to emulated MSRs
leads to unchecked MSR access error:

  [   28.702947] PM: Calling lapic_suspend+0x0/0x210
  [   28.703345] unchecked MSR access error: WRMSR to 0x10f (tried to write 0=x0000000000000000) at rIP: 0xffffffff9b2819e4 (native_write_msr+0x4/0x20)
  [   28.703357] Call Trace:
  [   28.703359]  <TASK>
  [   28.703361]  ? restore_processor_state+0x255/0x2d0
  [   28.703369]  x86_acpi_suspend_lowlevel+0x11f/0x170
  [   28.703374]  acpi_suspend_enter+0x4f/0x1f0
  [   28.703379]  suspend_devices_and_enter+0x6e0/0x7d0
  [   28.703384]  pm_suspend.cold+0x35c/0x3a7
  [   28.703388]  state_store+0x81/0xe0
  [   28.703392]  kobj_attr_store+0x12/0x20
  [   28.703396]  sysfs_kf_write+0x3f/0x50
  [   28.703399]  kernfs_fop_write_iter+0x13b/0x1d0
  [   28.703403]  new_sync_write+0x101/0x180
  [   28.703408]  vfs_write+0x217/0x2a0
  [   28.703413]  ksys_write+0x67/0xe0
  [   28.703417]  __x64_sys_write+0x1a/0x20
  [   28.703421]  do_syscall_64+0x3b/0x90
  [   28.703426]  entry_SYSCALL_64_after_hwframe+0x44/0xae
  [   28.703429] RIP: 0033:0x7fda13c260a7
  [   28.703434] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 =
  00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
  > 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
  [   28.703437] RSP: 002b:00007fffa4060268 EFLAGS: 00000246 ORIG_RAX: 000000=0000000001
  [   28.703441] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fda13c=260a7
  [   28.703443] RDX: 0000000000000004 RSI: 000055a41f65a570 RDI: 00000000000=00004
  [   28.703444] RBP: 000055a41f65a570 R08: 0000000000000000 R09: 00000000000=00004
  [   28.703446] R10: 000055a41f0cc2a6 R11: 0000000000000246 R12: 00000000000=00004
  [   28.703447] R13: 000055a41f657510 R14: 00007fda13d014a0 R15: 00007fda13d=008a0

To ensure microcode emulated MSRs are available for restoration, load
the microcode for boot CPU before restoring these MSRs.

Reported-by: Kyle D. Pelton <kyle.d.pelton@intel.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215841
Fixes: e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume")
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Tested-by: Kyle D. Pelton <kyle.d.pelton@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/microcode.h     |  2 ++
 arch/x86/kernel/cpu/microcode/core.c |  6 +++---
 arch/x86/power/cpu.c                 | 10 +++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d6bfdfb0f0af..0c3d3440fe27 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -131,10 +131,12 @@ extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
 void reload_early_microcode(void);
 extern bool initrd_gone;
+void microcode_bsp_resume(void);
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
+static inline void microcode_bsp_resume(void)			{ }
 #endif
 
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f955d25076ba..239ff5fcec6a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -758,9 +758,9 @@ static struct subsys_interface mc_cpu_interface = {
 };
 
 /**
- * mc_bp_resume - Update boot CPU microcode during resume.
+ * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
-static void mc_bp_resume(void)
+void microcode_bsp_resume(void)
 {
 	int cpu = smp_processor_id();
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -772,7 +772,7 @@ static void mc_bp_resume(void)
 }
 
 static struct syscore_ops mc_syscore_ops = {
-	.resume			= mc_bp_resume,
+	.resume			= microcode_bsp_resume,
 };
 
 static int mc_cpu_starting(unsigned int cpu)
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 3822666fb73d..bb176c72891c 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -25,6 +25,7 @@
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
+#include <asm/microcode.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -262,11 +263,18 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	mtrr_bp_restore();
 	perf_restore_debug_store();
-	msr_restore_context(ctxt);
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
 		init_ia32_feat_ctl(c);
+
+	microcode_bsp_resume();
+
+	/*
+	 * This needs to happen after the microcode has been updated upon resume
+	 * because some of the MSRs are "emulated" in microcode.
+	 */
+	msr_restore_context(ctxt);
 }
 
 /* Needed by apm.c */
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED14D503E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiCJRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244713AbiCJRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:44 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A14199D40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932886; x=1678468886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkk+LCQw1C23mX1WkEmmWnrnM+AUHY54QPQUqmjdQBo=;
  b=IR6jzAtM4fbd/pjcDSO1/gYv/QzJjmKdGIVqiDH54hoCkRiBEPICqk6g
   dcBN6tCIp+zAPtYWj1h7hxoGmF7g3MAIfZc0Wy/KHAOQ5B15ymuzY8abF
   Jr28Lvyz1gIxnOUsuBbK+mkG305iEV8/7cqN4tK7NBZbRd3+jl3yVYvtu
   wZxwJjpc3wHskFrHd0hzJSGKDq+dl157oiBoeuwTWgfbmCk07p6N9+RZS
   /6EU952PVXsrFEu3oqDGtWVmoO9/12toQQPFKs4kU8dGnB9njBnWBW+Kk
   TdN3ZLcGL/0esSE8nk+f4WA43UMObdzs0A2KU6WuOlDmsR/HBOCntkX2F
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316033086"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="316033086"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="548091186"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:25 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 27/45] x86/pkeys: Preserve PKRS MSR across exceptions
Date:   Thu, 10 Mar 2022 09:20:01 -0800
Message-Id: <20220310172019.850939-28-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PKRS is a per-logical-processor MSR which overlays additional protection
for pages which have been mapped with a protection key.  It is desired
to protect PKS pages while executing exception code while also allowing
exception code to access PKS pages with the proper pks_set_*() calls.

To do this the current thread value must be saved, the CPU MSR value set
to the default value during the exception, and the saved thread value
restored upon completion.  This can be done with the new auxiliary
pt_regs space.

When PKS is configured, configure auxiliary pt_regs, add space to
pt_regs_auxiliary, and define save/restore functions.

Update the PKS test code to maintain functionality by clearing the saved
PKRS value before returning.

Peter, Thomas, Andy, Dave, and Dan all suggested parts of the patch or
aided in the development of the patch.

[1] https://lore.kernel.org/lkml/CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/874kpxx4jf.fsf@nanos.tec.linutronix.de/#t
[3] https://lore.kernel.org/lkml/CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com/

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9:
	Update commit message
	s/pks_thread_pkrs/pkrs/
	From Dave Hansen
		s/pks_saved_pkrs/pkrs/

Changes for V8:
	Tie this into the new generic auxiliary pt_regs support.
	Build this on the new irqentry_*() refactoring patches
	Split this patch off from the PKS portion of the auxiliary
		pt_regs functionality.
	From Thomas
		Fix noinstr mess
		s/write_pkrs/pks_write_pkrs
		s/pkrs_init_value/PKRS_INIT_VALUE
	Simplify the number and location of the save/restore calls.
		Cover entry from user space as well.

Changes for V7:
	Rebased to 5.14 entry code
	declare write_pkrs() in pks.h
	s/INIT_PKRS_VALUE/pkrs_init_value
	Remove unnecessary INIT_PKRS_VALUE def
	s/pkrs_save_set_irq/pkrs_save_irq/
		The inital value for exceptions is best managed
		completely within the pkey code.
---
 arch/x86/Kconfig                    |  3 ++-
 arch/x86/include/asm/entry-common.h |  3 +++
 arch/x86/include/asm/pks.h          |  4 ++++
 arch/x86/include/asm/ptrace.h       |  3 +++
 arch/x86/mm/pkeys.c                 | 32 +++++++++++++++++++++++++++++
 lib/pks/pks_test.c                  |  9 +++++++-
 6 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 64348c94477e..f13fd7a73535 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1879,8 +1879,9 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	  If unsure, say y.
 
 config ARCH_HAS_PTREGS_AUXILIARY
+	def_bool y
 	depends on X86_64
-	bool
+	depends on ARCH_ENABLE_SUPERVISOR_PKEYS
 
 choice
 	prompt "TSX enable mode"
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 5fa5dd2d539c..803727b95b3a 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -8,6 +8,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/pks.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_check_user_regs(struct pt_regs *regs)
@@ -99,10 +100,12 @@ static __always_inline void arch_exit_to_user_mode(void)
 
 static inline void arch_save_aux_pt_regs(struct pt_regs *regs)
 {
+	pks_save_pt_regs(regs);
 }
 
 static inline void arch_restore_aux_pt_regs(struct pt_regs *regs)
 {
+	pks_restore_pt_regs(regs);
 }
 
 #endif
diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index e9ad3ecd7ed0..b69e03a141fe 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -6,6 +6,8 @@
 
 void pks_setup(void);
 void x86_pkrs_load(struct thread_struct *thread);
+void pks_save_pt_regs(struct pt_regs *regs);
+void pks_restore_pt_regs(struct pt_regs *regs);
 
 bool pks_handle_key_fault(struct pt_regs *regs, unsigned long hw_error_code,
 			  unsigned long address);
@@ -14,6 +16,8 @@ bool pks_handle_key_fault(struct pt_regs *regs, unsigned long hw_error_code,
 
 static inline void pks_setup(void) { }
 static inline void x86_pkrs_load(struct thread_struct *thread) { }
+static inline void pks_save_pt_regs(struct pt_regs *regs) { }
+static inline void pks_restore_pt_regs(struct pt_regs *regs) { }
 
 static inline bool pks_handle_key_fault(struct pt_regs *regs,
 					unsigned long hw_error_code,
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5e7f6e48c0ab..a3b00ad0d69b 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -97,6 +97,9 @@ struct pt_regs {
  * ARCH_HAS_PTREGS_AUXILIARY.  Failure to do so will result in a build failure.
  */
 struct pt_regs_auxiliary {
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	u32 pkrs;
+#endif
 };
 
 struct pt_regs_extended {
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 39867d39460b..29885dfb0980 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -346,6 +346,38 @@ void x86_pkrs_load(struct thread_struct *thread)
 	pks_write_pkrs(thread->pkrs);
 }
 
+/*
+ * PKRS is a per-logical-processor MSR which overlays additional protection for
+ * pages which have been mapped with a protection key.
+ *
+ * To protect against exceptions having potentially privileged access to memory
+ * of an interrupted thread, save the current thread value and set the PKRS
+ * value to be used during the exception.
+ */
+void pks_save_pt_regs(struct pt_regs *regs)
+{
+	struct pt_regs_auxiliary *aux_pt_regs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+	aux_pt_regs->pkrs = current->thread.pkrs;
+	pks_write_pkrs(PKS_INIT_VALUE);
+}
+
+void pks_restore_pt_regs(struct pt_regs *regs)
+{
+	struct pt_regs_auxiliary *aux_pt_regs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+	current->thread.pkrs = aux_pt_regs->pkrs;
+	pks_write_pkrs(current->thread.pkrs);
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
  *
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 16aa44cf498a..86af2f61393d 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -34,11 +34,14 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
+#include <linux/pkeys.h>
 #include <linux/pks.h>
 #include <linux/pks-keys.h>
 
 #include <uapi/asm-generic/mman-common.h>
 
+#include <asm/ptrace.h>
+
 #define PKS_TEST_MEM_SIZE (PAGE_SIZE)
 
 #define CHECK_DEFAULTS		0
@@ -110,12 +113,16 @@ static void set_context_for_fault(struct pks_test_ctx *ctx)
 bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
 			     bool write)
 {
+	struct pt_regs_extended *ept_regs = to_extended_pt_regs(regs);
+	struct pt_regs_auxiliary *aux_pt_regs = &ept_regs->aux;
+	u32 pkrs = aux_pt_regs->pkrs;
+
 	pr_debug("PKS Fault callback: ctx %p\n", g_ctx_under_test);
 
 	if (!g_ctx_under_test)
 		return false;
 
-	pks_set_readwrite(g_ctx_under_test->pkey);
+	aux_pt_regs->pkrs = pkey_update_pkval(pkrs, g_ctx_under_test->pkey, 0);
 	g_ctx_under_test->fault_seen = true;
 	return true;
 }
-- 
2.35.1


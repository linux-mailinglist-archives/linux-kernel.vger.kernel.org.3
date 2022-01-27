Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952A649E97C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiA0R4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:19450 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244785AbiA0Rza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306130; x=1674842130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lz+GzmfxQCFYBGj/322C04YF6L+IH6KOL/+UXO7S+bE=;
  b=FhZa5BiU6T1v7DP2WWrMOgJYo48lVeUECIX6dYJ2Bs6qigt6lGiwcKT2
   TQiIKIByxAXBcsfsrwOkLy7ZQtnxmMMct1qtael+pSpVHk9Sw9+BguMIB
   KX2wn3q2W0U2mhSGe6R1vqYnSMg1gwZiJVwwrD6MSxA8KasnhS/64Xevq
   YKkGXQptuUPP67Fj+iywB4tJfP2xnvvKhMoeSNuoKjjyKXPgesTgZSuUA
   bRKRV0z7mVWESjYx3YLcaMqhbjTiWIzSdpewhgqqinNULAHTdUIsQ5R8z
   4Il42MnCPGzznC/gsCniSuib/GFWgh6X4/k5KfLQG/wua8jDow2JpVPCj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302438"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796139"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 25/44] x86/pkeys: Preserve PKRS MSR across exceptions
Date:   Thu, 27 Jan 2022 09:54:46 -0800
Message-Id: <20220127175505.851391-26-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PKRS is a per-logical-processor MSR which overlays additional protection
for pages which have been mapped with a protection key.  It is desired
to protect PKS pages while executing exception code.  While in the
exception code can alter the PKS permissions if necessary for any access
it may require.

To do this the current thread value must be saved, the CPU MSR value set
to the default value, and the saved value restored upon completion of
the exception.  This can be done with the new auxiliary pt_regs space.

Turn on the new auxiliary pt_regs space by triggering
ARCH_HAS_PTREGS_AUXILIARY.  This is done by making
ARCH_HAS_PTREGS_AUXILIARY default yes and then dependent on
ARCH_ENABLE_SUPERVISOR_PKEYS.  Additional users of the auxiliary space
can OR in their Kconfig options as needed.

Then define pks_{save|restore}_pt_regs() to use the auxiliary space to
store the thread PKRS value across exceptions.  Call pks_*_pt_regs()
from arch_{save|restore}_aux_pt_regs()

Update the PKS test code to properly clear the saved thread PKRS value
before returning to ensure current tests work with this change.

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
 arch/x86/include/asm/pks.h          |  8 ++++++--
 arch/x86/include/asm/ptrace.h       |  3 +++
 arch/x86/mm/fault.c                 |  2 +-
 arch/x86/mm/pkeys.c                 | 32 +++++++++++++++++++++++++++++
 lib/pks/pks_test.c                  | 11 ++++++++--
 7 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 82342f27b218..62685906f7c3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1878,8 +1878,9 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
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
index ee9fff5b4b13..82baa594cb3b 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -6,22 +6,26 @@
 
 void pks_setup(void);
 void pks_write_current(void);
+void pks_save_pt_regs(struct pt_regs *regs);
+void pks_restore_pt_regs(struct pt_regs *regs);
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void pks_setup(void) { }
 static inline void pks_write_current(void) { }
+static inline void pks_save_pt_regs(struct pt_regs *regs) { }
+static inline void pks_restore_pt_regs(struct pt_regs *regs) { }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 
 #ifdef CONFIG_PKS_TEST
 
-bool pks_test_callback(void);
+bool pks_test_callback(struct pt_regs *regs);
 
 #else /* !CONFIG_PKS_TEST */
 
-static inline bool pks_test_callback(void)
+static inline bool pks_test_callback(struct pt_regs *regs)
 {
 	return false;
 }
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 79541682e7f7..f2527d6451b3 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -98,6 +98,9 @@ struct pt_regs {
  * ARCH_HAS_PTREGS_AUXILIARY.  Failure to do so will result in a build failure.
  */
 struct pt_regs_auxiliary {
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	u32 pks_thread_pkrs;
+#endif
 };
 
 struct pt_regs_extended {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index bef879943260..030eb3e08550 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1164,7 +1164,7 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		 * is running.  If so, pks_test_callback() will clear the protection
 		 * mechanism and return true to indicate the fault was handled.
 		 */
-		if (pks_test_callback())
+		if (pks_test_callback(regs))
 			return;
 	}
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 7c6498fb8f8d..33b7f84ed33b 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -256,6 +256,38 @@ void pks_write_current(void)
 	pks_write_pkrs(current->thread.pks_saved_pkrs);
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
+	aux_pt_regs->pks_thread_pkrs = current->thread.pks_saved_pkrs;
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
+	current->thread.pks_saved_pkrs = aux_pt_regs->pks_thread_pkrs;
+	pks_write_pkrs(current->thread.pks_saved_pkrs);
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
  *
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 933f1bed4820..77f872829300 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -43,6 +43,7 @@
 #include <uapi/asm-generic/mman-common.h>
 
 #include <asm/pks.h>
+#include <asm/ptrace.h>       /* for struct pt_regs */
 
 #include <asm/pks.h>
 
@@ -74,12 +75,18 @@ struct pks_test_ctx {
  * NOTE: The callback is responsible for clearing any condition which would
  * cause the fault to re-trigger.
  */
-bool pks_test_callback(void)
+bool pks_test_callback(struct pt_regs *regs)
 {
+	struct pt_regs_extended *ept_regs = to_extended_pt_regs(regs);
+	struct pt_regs_auxiliary *aux_pt_regs = &ept_regs->aux;
 	bool armed = (test_armed_key != 0);
+	u32 pkrs = aux_pt_regs->pks_thread_pkrs;
 
 	if (armed) {
-		pks_mk_readwrite(test_armed_key);
+		/* Enable read and write to stop faults */
+		aux_pt_regs->pks_thread_pkrs = pkey_update_pkval(pkrs,
+								 test_armed_key,
+								 0);
 		fault_cnt++;
 	}
 
-- 
2.31.1


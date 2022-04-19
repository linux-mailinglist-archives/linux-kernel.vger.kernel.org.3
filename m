Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C850761D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbiDSRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355638AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E2B7E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388029; x=1681924029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q8nK9Y056zBcLZ+qaDMBNpGF5C6sPY08OlBsXsBRCsI=;
  b=lIB53kGCgzZ7DI6z/xSZbFgk6PGO0kS719y9cfDBlIWrK1yENr1ihX8R
   F4aM4KDeVEbMoeyBa5z2aTVAOTy10VoKjsvLYytEceSoyg4B0hX+5K528
   TinAVyoiJHh4J6MRq7iAkWiQuhSQFZxZtcha4xEDFZXdeprYNnNLj4BP9
   qzAQAOc4nlkX8QD8hQfC0nbGU61nVZm+hNI09wO8pioDq6fo5IHb+8T1P
   rt5LynUbds6eomW8nq9Daitm+85avIYMOmIRFrr0pX8efA+CGXslTSl/Y
   HI1JgP8tQu7k5yDzz4CvsLfoVQxSZSlcpixWzuHIg8EWbe2PGBwOqt5oA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245710067"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245710067"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="647332115"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:08 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 21/44] x86/pkeys: Preserve PKRS MSR across exceptions
Date:   Tue, 19 Apr 2022 10:06:26 -0700
Message-Id: <20220419170649.1022246-22-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes for V10:
	Remove test changes.

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
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 69e611d3b8ef..43464511ea9d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1890,8 +1890,9 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
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
index 0889045b3a6f..73936739c7e7 100644
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
index a3b27b7811da..dd02e76d0359 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -342,6 +342,38 @@ void x86_pkrs_load(struct thread_struct *thread)
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
-- 
2.35.1


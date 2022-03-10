Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125CF4D5055
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiCJRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbiCJRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9B197B62
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932866; x=1678468866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KJdjrwMYcnwI0PnwkzANIEOsMxmOWGI1SNSM90XOsc=;
  b=Zf9f42dmgTqNWZ/eCzaBagU/RXPs0JEW5p31l3dBqdYFreGRDh2DDMMy
   j+Er9mLqllAE9PrBh7MD6cSEAMr3VGatVpXaLnXXnPhSKeymtNXYUhnnd
   zQcFaUlwAa9dl/+66hszWDr+CvhegzWPPvK/ALzORblAYzAwW5ZAdPjW0
   0J87e0i4H57OnzRGIK5aUzvFkCdxhsQ79UH4bc5mJN1uN5dee6izCdaeE
   clZwkS0HOANDko81hHiAEXFKuQiKst9CBCwljp1axA4r6gVGsrUpu0zOL
   161WG+BKUE+V0JR4xs4KzofjDlTICoUwZ/IesiQbQPmdqs9J+Ja0fCWu3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="252879352"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252879352"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="611816010"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:05 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 19/45] mm/pkeys: Introduce PKS fault callbacks
Date:   Thu, 10 Mar 2022 09:19:53 -0800
Message-Id: <20220310172019.850939-20-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Some PKS consumers will want special handling on violations of pkey
permissions.  Such a consumer is PMEM which will want to have a mode
that logs the access violation, disables protection, and continues
rather than oops'ing the machine.

Provide an API to assign callbacks for individual pkeys.

Since PKS faults do not provide the key that faulted, this information
needs to be recovered by walking the page tables and extracting it from
the leaf entry.  The key can then be used to call the proper callback.

Add documentation.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
Changes for V9:
	Rework commit message
	Adjust for the use of linux/pks.h
	From the new key allocation: s/PKS_NR_CONSUMERS/PKS_KEY_MAX
	From Dave Hansen
		use pkey
		Fix conflicts with other users in the test code by
			moving this forward in the series

Changes for V8:
	Add pt_regs to the callback signature so that
		pks_update_exception() can be called if needed.
	Update commit message
	Determine if page is large prior to not present
	Update commit message with more clarity as to why this was kept
		separate from pks_abandon_protections() and
		pks_test_callback()
	Embed documentation in c file.
	Move handle_pks_key_fault() to pkeys.c
		s/handle_pks_key_fault/pks_handle_key_fault/
		This consolidates the PKS code nicely
	Add feature check to pks_handle_key_fault()
	From Rick Edgecombe
		Fix key value check
	From kernel test robot
		Add static to handle_pks_key_fault

Changes for V7:
	New patch
---
 Documentation/core-api/protection-keys.rst |  6 ++
 arch/x86/include/asm/pks.h                 | 10 +++
 arch/x86/mm/fault.c                        | 17 +++--
 arch/x86/mm/pkeys.c                        | 86 ++++++++++++++++++++++
 include/linux/pks.h                        |  3 +
 5 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 2ec35349ecfd..5fdc83a39d4e 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -149,6 +149,12 @@ Changing permissions of individual keys
 .. kernel-doc:: include/linux/pks.h
         :identifiers: pks_set_readwrite pks_set_noaccess
 
+Overriding Default Fault Behavior
+---------------------------------
+
+.. kernel-doc:: arch/x86/mm/pkeys.c
+        :doc: DEFINE_PKS_FAULT_CALLBACK
+
 MSR details
 ~~~~~~~~~~~
 
diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index a7bad7301783..e9ad3ecd7ed0 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -7,11 +7,21 @@
 void pks_setup(void);
 void x86_pkrs_load(struct thread_struct *thread);
 
+bool pks_handle_key_fault(struct pt_regs *regs, unsigned long hw_error_code,
+			  unsigned long address);
+
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void pks_setup(void) { }
 static inline void x86_pkrs_load(struct thread_struct *thread) { }
 
+static inline bool pks_handle_key_fault(struct pt_regs *regs,
+					unsigned long hw_error_code,
+					unsigned long address)
+{
+	return false;
+}
+
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 #endif /* _ASM_X86_PKS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 5599109d1124..e8934df1b886 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -33,6 +33,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/pks.h>			/* pks_handle_key_fault() */
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1147,12 +1148,16 @@ static void
 do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
-	/*
-	 * PF_PF faults should only occur on kernel
-	 * addresses when supervisor pkeys are enabled.
-	 */
-	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
-		     (hw_error_code & X86_PF_PK));
+	if (hw_error_code & X86_PF_PK) {
+		/*
+		 * PF_PF faults should only occur on kernel
+		 * addresses when supervisor pkeys are enabled.
+		 */
+		WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS));
+
+		if (pks_handle_key_fault(regs, hw_error_code, address))
+			return;
+	}
 
 #ifdef CONFIG_X86_32
 	/*
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index e4cbc79686ea..a3b27b7811da 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -12,6 +12,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/trap_pf.h>		/* X86_PF_WRITE */
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -216,6 +217,91 @@ u32 pkey_update_pkval(u32 pkval, u8 pkey, u32 accessbits)
 
 static DEFINE_PER_CPU(u32, pkrs_cache);
 
+/**
+ * DOC: DEFINE_PKS_FAULT_CALLBACK
+ *
+ * Users may also provide a fault handler which can handle a fault differently
+ * than an oops.  For example if 'MY_FEATURE' wanted to define a handler they
+ * can do so by adding the coresponding entry to the pks_key_callbacks array.
+ *
+ * .. code-block:: c
+ *
+ *	#ifdef CONFIG_MY_FEATURE
+ *	bool my_feature_pks_fault_callback(struct pt_regs *regs,
+ *					   unsigned long address, bool write)
+ *	{
+ *		if (my_feature_fault_is_ok)
+ *			return true;
+ *		return false;
+ *	}
+ *	#endif
+ *
+ *	static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
+ *		[PKS_KEY_DEFAULT]            = NULL,
+ *	#ifdef CONFIG_MY_FEATURE
+ *		[PKS_KEY_MY_FEATURE]         = my_feature_pks_fault_callback,
+ *	#endif
+ *	};
+ */
+static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = { 0 };
+
+static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
+				    bool write, u16 key)
+{
+	if (key >= PKS_KEY_MAX)
+		return false;
+
+	if (pks_key_callbacks[key])
+		return pks_key_callbacks[key](regs, address, write);
+
+	return false;
+}
+
+bool pks_handle_key_fault(struct pt_regs *regs, unsigned long hw_error_code,
+			  unsigned long address)
+{
+	bool write;
+	pgd_t pgd;
+	p4d_t p4d;
+	pud_t pud;
+	pmd_t pmd;
+	pte_t pte;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return false;
+
+	write = (hw_error_code & X86_PF_WRITE);
+
+	pgd = READ_ONCE(*(init_mm.pgd + pgd_index(address)));
+	if (!pgd_present(pgd))
+		return false;
+
+	p4d = READ_ONCE(*p4d_offset(&pgd, address));
+	if (p4d_large(p4d))
+		return pks_call_fault_callback(regs, address, write,
+					       pte_flags_pkey(p4d_val(p4d)));
+	if (!p4d_present(p4d))
+		return false;
+
+	pud = READ_ONCE(*pud_offset(&p4d, address));
+	if (pud_large(pud))
+		return pks_call_fault_callback(regs, address, write,
+					       pte_flags_pkey(pud_val(pud)));
+	if (!pud_present(pud))
+		return false;
+
+	pmd = READ_ONCE(*pmd_offset(&pud, address));
+	if (pmd_large(pmd))
+		return pks_call_fault_callback(regs, address, write,
+					       pte_flags_pkey(pmd_val(pmd)));
+	if (!pmd_present(pmd))
+		return false;
+
+	pte = READ_ONCE(*pte_offset_kernel(&pmd, address));
+	return pks_call_fault_callback(regs, address, write,
+				       pte_flags_pkey(pte_val(pte)));
+}
+
 /*
  * pks_write_pkrs() - Write the pkrs of the current CPU
  * @new_pkrs: New value to write to the current CPU register
diff --git a/include/linux/pks.h b/include/linux/pks.h
index 9f18f8b4cbb1..d0d8bf1aaa1d 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -34,6 +34,9 @@ static inline void pks_set_readwrite(u8 pkey)
 	pks_update_protection(pkey, PKEY_READ_WRITE);
 }
 
+typedef bool (*pks_key_callback)(struct pt_regs *regs, unsigned long address,
+				 bool write);
+
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void pks_set_noaccess(u8 pkey) {}
-- 
2.35.1


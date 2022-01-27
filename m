Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1477749E982
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbiA0R5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244951AbiA0Rzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306140; x=1674842140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGN63N0a99zN4ja5pEhr049Oij8dwvnWeFfMaFaK4UI=;
  b=WzA6nD24PUgNKJLp+avNOMP/DutzoK1/M6uTxLi3p7w9dv7Zemmf7BFL
   Pd4JmHkOjrLyHAfE0NhxwBvjXHUo94U3BQR68N0AkhpOo3f8FrHjghaSs
   zOHextBSeoHbJOz/9eq8nSzrohrC9oF8tVC56rAvxlmSBhp+PI6EE6FPe
   2KvpA9Bkis996+ue0CwQkdvrDw9WZY8zwm5rCyGnYSJqYk3ETMo5I9jWX
   Bgfrn3Q36hTWdDWzYEUAzhHlz1S1CaINSKnAty72LKbgCCMK+gg+47So1
   S6N3W+A//yA1/zcsAL3CNN42YBbJJEz+Y5OKG/sPpOSKdl+RWV96QK/se
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302445"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796155"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 29/44] mm/pkeys: Introduce PKS fault callbacks
Date:   Thu, 27 Jan 2022 09:54:50 -0800
Message-Id: <20220127175505.851391-30-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Some PKS keys will want special handling on accesses that violate the
Pkey permissions.  One of these is PMEM which will want to have a mode
that logs the access violation, disables protection, and continues
rather than oops'ing the machine.

Provide an API to set callbacks for individual Pkeys.  Call these
through pks_handle_key_fault() which is called in the fault handler.

Since PKS faults do not provide the key that faulted, this information
needs to be recovered by walking the page tables and extracting it from
the leaf entry.  The key can then be used to call the specific user
defined callback.

This infrastructure could be used to implement the PKS testing code.
Unfortunately, this would limit the ability to test this code itself as
well as limit the testing code to a single Pkey.  Because
pks_test_callback() is zero overhead if CONFIG_PKS_TEST is not specified
it is left as a separate hook in the fault handler.

Add documentation.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
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
 Documentation/core-api/protection-keys.rst |  9 ++-
 arch/x86/include/asm/pks.h                 |  9 +++
 arch/x86/mm/fault.c                        |  3 +
 arch/x86/mm/pkeys.c                        | 86 ++++++++++++++++++++++
 include/linux/pkeys.h                      |  3 +
 include/linux/pks-keys.h                   |  2 +
 6 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index b89308bf117e..267efa2112e7 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -115,7 +115,8 @@ Overview
 
 Similar to user space pkeys, supervisor pkeys allow additional protections to
 be defined for a supervisor mappings.  Unlike user space pkeys, violations of
-these protections result in a kernel oops.
+these protections result in a kernel oops unless a PKS fault handler is
+provided which handles the fault.
 
 Supervisor Memory Protection Keys (PKS) is a feature which is found on Intel's
 Sapphire Rapids (and later) "Scalable Processor" Server CPUs.  It will also be
@@ -150,6 +151,12 @@ Changing permissions of individual keys
 .. kernel-doc:: arch/x86/mm/pkeys.c
         :identifiers: pks_update_exception
 
+Overriding Default Fault Behavior
+---------------------------------
+
+.. kernel-doc:: arch/x86/mm/pkeys.c
+        :doc: DEFINE_PKS_FAULT_CALLBACK
+
 MSR details
 -----------
 
diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index 065386c8bf37..55541bb64d08 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -9,6 +9,8 @@ void pks_write_current(void);
 void pks_save_pt_regs(struct pt_regs *regs);
 void pks_restore_pt_regs(struct pt_regs *regs);
 void pks_dump_fault_info(struct pt_regs *regs);
+bool pks_handle_key_fault(struct pt_regs *regs, unsigned long hw_error_code,
+			  unsigned long address);
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
@@ -18,6 +20,13 @@ static inline void pks_save_pt_regs(struct pt_regs *regs) { }
 static inline void pks_restore_pt_regs(struct pt_regs *regs) { }
 static inline void pks_dump_fault_info(struct pt_regs *regs) { }
 
+static inline bool pks_handle_key_fault(struct pt_regs *regs,
+					unsigned long hw_error_code,
+					unsigned long address)
+{
+	return false;
+}
+
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 697c06f08103..e378573d97a7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1162,6 +1162,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		 */
 		WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS));
 
+		if (pks_handle_key_fault(regs, hw_error_code, address))
+			return;
+
 		/*
 		 * If a protection key exception occurs it could be because a PKS test
 		 * is running.  If so, pks_test_callback() will clear the protection
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6723ae42732a..531cf6c74ad7 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -11,6 +11,7 @@
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
 #include <asm/pks.h>
+#include <asm/trap_pf.h>		/* X86_PF_WRITE */
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -212,6 +213,91 @@ u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
 
 __static_or_pks_test DEFINE_PER_CPU(u32, pkrs_cache);
 
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
+ *	static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = {
+ *		[PKS_KEY_DEFAULT]            = NULL,
+ *	#ifdef CONFIG_MY_FEATURE
+ *		[PKS_KEY_PGMAP_PROTECTION]   = my_feature_pks_fault_callback,
+ *	#endif
+ *	};
+ */
+static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = { 0 };
+
+static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
+				    bool write, u16 key)
+{
+	if (key >= PKS_KEY_NR_CONSUMERS)
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
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index c318d97f5da8..a53e4f2c41af 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -82,6 +82,9 @@ static inline void pks_mk_readwrite(int pkey)
 	pks_update_protection(pkey, PKEY_READ_WRITE);
 }
 
+typedef bool (*pks_key_callback)(struct pt_regs *regs, unsigned long address,
+				 bool write);
+
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void pks_mk_noaccess(int pkey) {}
diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index 69a0be979515..a3fcd8df8688 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -27,6 +27,7 @@
  *	{
  *		PKS_KEY_DEFAULT         = 0,
  *		PKS_KEY_MY_FEATURE      = 1,
+ *		PKS_KEY_NR_CONSUMERS    = 2,
  *	}
  *
  *	#define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		|
@@ -43,6 +44,7 @@
 enum pks_pkey_consumers {
 	PKS_KEY_DEFAULT		= 0, /* Must be 0 for default PTE values */
 	PKS_KEY_TEST		= 1,
+	PKS_KEY_NR_CONSUMERS	= 2,
 };
 
 #define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
-- 
2.31.1


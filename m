Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67A649E95C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiA0Rz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244437AbiA0RzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306115; x=1674842115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+ZrmtCf1q4qznLjZH0k13EJLAex2Lre9GU17jNVyaE=;
  b=cyEO9MFqmMrdeATvEzrXos5LNrqq9u+h5HfL1AFGQiFZcwnY66zhA+v+
   DI5W8wExqioVvksjQ9wB4krzjnPM4hnCyDdcVMlWAi5muv40lAHQdYc4F
   VkHkCgVGI3DN5TL0xObpNilvaEdjpFlF7GralgKGPj6VEIDIXV1GrjhM9
   vEIGTIhDXckBlzgusYi1TtD3srTxZ2ZMMW5QaIKIHunRP7Q6skeA2eCiY
   7eMCPw1PgMEiJSQyV2zbu1FqYICnTtQhPZ0nszp+N5w61phfak3WcUzQs
   RNbzl7BCWR7tCGTQAU4yUoZPBpHKwY1iWSjTnFFk3fk8nY1yx0PBFoVaJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302428"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796107"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 18/44] x86/fault: Add a PKS test fault hook
Date:   Thu, 27 Jan 2022 09:54:39 -0800
Message-Id: <20220127175505.851391-19-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKS test code is going to purposely create faults when testing
invalid access.  It will need a way to flag those faults as invalid and
keep the kernel running properly.

Create a hook in the fault handler to call back into the test code such
that the test code can track when a test it runs results in a fault.

The hook returns if the fault was caused by the test code so the main
handler can consider the fault handled.  Also the hook is responsible to
clear up the reason for the fault.

Predicate the hook on CONFIG_PKS_TEST.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pks.h | 14 ++++++++++++++
 arch/x86/mm/fault.c        | 30 ++++++++++++++++++++----------
 lib/pks/pks_test.c         | 12 ++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index d211bf36492c..ee9fff5b4b13 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -14,4 +14,18 @@ static inline void pks_write_current(void) { }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
+
+#ifdef CONFIG_PKS_TEST
+
+bool pks_test_callback(void);
+
+#else /* !CONFIG_PKS_TEST */
+
+static inline bool pks_test_callback(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_PKS_TEST */
+
 #endif /* _ASM_X86_PKS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6ed91b632eac..bef879943260 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -33,6 +33,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/pks.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1147,16 +1148,25 @@ static void
 do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
-	/*
-	 * X86_PF_PK (Protection key exceptions) may occur on kernel addresses
-	 * when PKS (PKeys Supervisor) is enabled.
-	 *
-	 * However, if PKS is not enabled WARN if this exception is seen
-	 * because there are no user pages in the kernel portion of the address
-	 * space.
-	 */
-	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
-		     (hw_error_code & X86_PF_PK));
+	if (hw_error_code & X86_PF_PK) {
+		/*
+		 * X86_PF_PK (Protection key exceptions) may occur on kernel
+		 * addresses when PKS (PKeys Supervisor) is enabled.
+		 *
+		 * However, if PKS is not enabled WARN if this exception is
+		 * seen because there are no user pages in the kernel portion
+		 * of the address space.
+		 */
+		WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS));
+
+		/*
+		 * If a protection key exception occurs it could be because a PKS test
+		 * is running.  If so, pks_test_callback() will clear the protection
+		 * mechanism and return true to indicate the fault was handled.
+		 */
+		if (pks_test_callback())
+			return;
+	}
 
 #ifdef CONFIG_X86_32
 	/*
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 159576dda47c..d84ab6e7a09c 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -47,6 +47,18 @@ struct pks_test_ctx {
 	char data[64];
 };
 
+/*
+ * pks_test_callback() is called by the fault handler to indicate it saw a PKey
+ * fault.
+ *
+ * NOTE: The callback is responsible for clearing any condition which would
+ * cause the fault to re-trigger.
+ */
+bool pks_test_callback(void)
+{
+	return false;
+}
+
 static void *alloc_test_page(int pkey)
 {
 	return __vmalloc_node_range(PKS_TEST_MEM_SIZE, 1, VMALLOC_START, VMALLOC_END,
-- 
2.31.1


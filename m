Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53D4D505C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiCJRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiCJRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA85198EE4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932916; x=1678468916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MuKtyB/L6sTrf33/+uhT8AZNvAWu8QORCChm6WtJV+Y=;
  b=bLgJ/XfibFbZmojwu+Z2U8Imvfy2ErzZ38dmvYQ6DBj0wAxH0FQ3PB4l
   kkYmYtmVOD8zW0OS1pRLRrnkkqkZSHnZDakNqVx76sVZJd1c0j/k7DPhr
   mICqqyfTdg4+Qyx3E0ad7P5A2lFMCPGE+x0u9XB6T1QczvwUVHIk/oqoU
   ACnbymNjqMeWK8ssFAzYXdDD3X+qZQrOzAjIcitdtMduMCFjvBL2aq4En
   fy0HFbdUDIeToF1t0gOhwhxR8oKp5nL3/tCW2XiTnNdj/wyQb7jTViDLO
   HOdmt1xT5cbQzFxXgO+ohaAmx8GYT1mI3YD3t9HroytzmIYlcnnBSgNAR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242759263"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="242759263"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="496338292"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:55 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 41/45] memremap_pages: Add memremap.pks_fault_mode
Date:   Thu, 10 Mar 2022 09:20:15 -0800
Message-Id: <20220310172019.850939-42-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When PKS protections for PMEM are enabled the kernel may capture stray
writes, or it may capture false positive access violations. An example
of a false positive access violation is a code path that neglects to
call kmap_{atomic,local_page}, but is otherwise a valid access. In the
false positive scenario there is no actual risk to data integrity, but
the kernel still needs to make a decision as to whether to report the
access violation and continue, or treat the violation as fatal. That
policy decision is captured in a new pks_fault_mode kernel parameter.

2 modes are available:

	'relaxed' (default) -- WARN_ONCE, removed the protections, and
	continuing to operate.

	'strict' -- Stop kernel execution via fault.  This is the most
	protective of the PMEM memory but may be undesirable in some
	configurations.

NOTE: There was some debate about if a 3rd mode called 'silent' should
be available.  'silent' would be the same as 'relaxed' but not print any
output.  While 'silent' is nice for admins to reduce console/log output
it would result in less motivation to fix invalid access to the
protected pmem pages.  Therefore, 'silent' is left out.

NOTE: The __param_check macro requires a type to correctly verify the
values passed as the module parameter.  Therefore a typedef is made of
the pks_fault_modes and the checkpatch warning regarding new typedefs is
ignored.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dan Williams
		Clarify commit message
		Remove code comment regarding checkpatch
	From Rick Edgecombe
		Remove unnecessary initialization

Changes for V8
	Use pks_update_exception() instead of abandoning the pkey.
	Split out pgmap_protection_flag_invalid() into a separate patch
		for clarity.
	From Rick Edgecombe
		Fix sysfs_streq() checks
	From Randy Dunlap
		Fix Documentation closing parans

Changes for V7
	Leverage Rick Edgecombe's fault callback infrastructure to relax invalid
		uses and prevent crashes
	From Dan Williams
		Use sysfs_* calls for parameter
		Make pgmap_disable_protection inline
		Remove pfn from warn output
	Remove silent parameter option
---
 .../admin-guide/kernel-parameters.txt         | 12 ++++
 arch/x86/mm/pkeys.c                           |  4 ++
 include/linux/mm.h                            |  3 +
 mm/memremap.c                                 | 65 +++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7123524a86b8..c9556843012d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4158,6 +4158,18 @@
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/x86/i386/IO-APIC.rst.
 
+	memremap.pks_fault_mode=	[X86] Control the behavior of page map
+			protection violations.
+			(depends on CONFIG_DEVMAP_ACCESS_PROTECTION)
+
+			Format: { relaxed | strict }
+
+			relaxed - Print a warning, disable the protection and
+				  continue execution.
+			strict - Stop kernel execution via fault
+
+			default: relaxed
+
 	plip=		[PPT,NET] Parallel port network link
 			Format: { parport<nr> | timid | 0 }
 			See also Documentation/admin-guide/parport.rst.
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index fd2ba269e64a..19ca3ef5389c 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -8,6 +8,7 @@
 #include <linux/pkeys.h>                /* PKEY_*                       */
 #include <linux/pks.h>
 #include <linux/pks-keys.h>
+#include <linux/mm.h>                   /* fault callback               */
 #include <uapi/asm-generic/mman-common.h>
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
@@ -249,6 +250,9 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
 #ifdef CONFIG_PKS_TEST
 	[PKS_KEY_TEST]		= pks_test_fault_callback,
 #endif
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+	[PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
+#endif
 };
 
 #else /* CONFIG_PKS_TEST_ALL_KEYS */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c85189b24eca..34ed04a3ea74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1198,6 +1198,9 @@ static inline void pgmap_set_noaccess(struct page *page)
 	__pgmap_set_noaccess(page->pgmap);
 }
 
+bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
+			      bool write);
+
 #else
 
 static inline void __pgmap_set_readwrite(struct dev_pagemap *pgmap) { }
diff --git a/mm/memremap.c b/mm/memremap.c
index 6fa259748a0b..aa2e40681bcf 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -13,6 +13,8 @@
 #include <linux/wait_bit.h>
 #include <linux/xarray.h>
 
+#include <uapi/asm-generic/mman-common.h>
+
 static DEFINE_XARRAY(pgmap_array);
 
 /*
@@ -95,6 +97,69 @@ static void devmap_protection_disable(void)
 	static_branch_dec(&dev_pgmap_protection_static_key);
 }
 
+typedef enum {
+	PKS_MODE_STRICT  = 0,
+	PKS_MODE_RELAXED = 1,
+} pks_fault_modes;
+
+pks_fault_modes pks_fault_mode = PKS_MODE_RELAXED;
+
+static int param_set_pks_fault_mode(const char *val, const struct kernel_param *kp)
+{
+	int ret = -EINVAL;
+
+	if (sysfs_streq(val, "relaxed")) {
+		pks_fault_mode = PKS_MODE_RELAXED;
+		ret = 0;
+	} else if (sysfs_streq(val, "strict")) {
+		pks_fault_mode = PKS_MODE_STRICT;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int param_get_pks_fault_mode(char *buffer, const struct kernel_param *kp)
+{
+	int ret;
+
+	switch (pks_fault_mode) {
+	case PKS_MODE_STRICT:
+		ret = sysfs_emit(buffer, "strict\n");
+		break;
+	case PKS_MODE_RELAXED:
+		ret = sysfs_emit(buffer, "relaxed\n");
+		break;
+	default:
+		ret = sysfs_emit(buffer, "<unknown>\n");
+		break;
+	}
+
+	return ret;
+}
+
+static const struct kernel_param_ops param_ops_pks_fault_modes = {
+	.set = param_set_pks_fault_mode,
+	.get = param_get_pks_fault_mode,
+};
+
+#define param_check_pks_fault_modes(name, p) \
+	__param_check(name, p, pks_fault_modes)
+module_param(pks_fault_mode, pks_fault_modes, 0644);
+
+bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
+			      bool write)
+{
+	/* In strict mode just let the fault handler oops */
+	if (pks_fault_mode == PKS_MODE_STRICT)
+		return false;
+
+	WARN_ONCE(1, "Page map protection being disabled");
+	pks_update_exception(regs, PKS_KEY_PGMAP_PROTECTION, PKEY_READ_WRITE);
+	return true;
+}
+EXPORT_SYMBOL_GPL(pgmap_pks_fault_callback);
+
 void __pgmap_set_readwrite(struct dev_pagemap *pgmap)
 {
 	if (!current->pgmap_prot_count++)
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F6507629
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355942AbiDSRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355635AbiDSRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74FCFA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388039; x=1681924039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUwp0sgNqiJqro4pztbiy6wkYALqifCh1CJOUEuojrs=;
  b=V6ZNGjuXUpwe2fCdJpB8DbT/4ubvPXUEW8wRjh24mJ9iuo9flyg5wUkb
   68ux5oitiCawRqKIMFky09mQM6dV3jJGvRuU77i243jdVC0+CSuCfY0Z0
   g5/wFCdueBfzsTzZcIFnPy6xha0JXjgDXGs6TR1VORoF5SqAgs0j+HeL0
   cXJAaId1BsNIbEBFWF/9oAe30z5qYUMqvliTB2Mkszjo0ttvJL2+U9bkF
   n5r3v/2yz7OnBuZh/PHoKY9cdj11SsnDpy3x+xG+0WbOj0FB07HrHErjs
   waZIXoAf9fd5Ib4RCyJuPmEP/XovcwT6lPU/70MIbqFYOFdT0FSAqLMx+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262677083"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262677083"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="666580379"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:18 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 32/44] memremap_pages: Add memremap.pks_fault_mode
Date:   Tue, 19 Apr 2022 10:06:37 -0700
Message-Id: <20220419170649.1022246-33-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

When PKS protections for PMEM are enabled the kernel may capture stray
writes, or it may capture false positive access violations. An example
of a false positive access violation is a code path that neglects to
call kmap_{atomic,local_page}, but is otherwise a valid access.  In the
false positive scenario there is little risk to data integrity, but the
kernel still needs to make a decision whether to report the access
violation and continue, or treat the violation as fatal. That policy
decision is captured in a new pks_fault_mode kernel parameter.

2 modes are available:

	'relaxed' (default) -- WARN_ONCE, remove the protections, and
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
Changes for V10
	Move code from mm.h to memremap.h
		Upstream separated memremap.h functionality from mm.h
		dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
	Adjust pkey allocation around test code being moved to the end
	of the series.

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
 arch/x86/mm/pkeys.c                           |  7 +-
 include/linux/memremap.h                      |  3 +
 mm/memremap.c                                 | 65 +++++++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..a1ab60eba72a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4229,6 +4229,18 @@
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
index 975ed206d957..e9a8c67f6b66 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -8,6 +8,7 @@
 #include <linux/pkeys.h>                /* PKEY_*                       */
 #include <linux/pks.h>
 #include <linux/pks-keys.h>
+#include <linux/memremap.h>		  /* fault callback               */
 #include <uapi/asm-generic/mman-common.h>
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
@@ -243,7 +244,11 @@ static DEFINE_PER_CPU(u32, pkrs_cache);
  *	#endif
  *	};
  */
-static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = { 0 };
+static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+	[PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
+#endif
+};
 
 static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
 				    bool write, u16 key)
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1012c6c4c664..47e0d102e194 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -270,6 +270,9 @@ static inline void pgmap_set_noaccess(struct page *page)
 	__pgmap_set_noaccess(page->pgmap);
 }
 
+bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
+			      bool write);
+
 #else
 
 static inline void __pgmap_set_readwrite(struct dev_pagemap *pgmap) { }
diff --git a/mm/memremap.c b/mm/memremap.c
index 491bb49255ae..d289ba304032 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -14,6 +14,8 @@
 #include <linux/xarray.h>
 #include "internal.h"
 
+#include <uapi/asm-generic/mman-common.h>
+
 static DEFINE_XARRAY(pgmap_array);
 
 /*
@@ -94,6 +96,69 @@ static void devmap_protection_disable(void)
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


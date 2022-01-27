Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AA49E97F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiA0R5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:65473 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244930AbiA0Rzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306138; x=1674842138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVtLp/kvaCle0VCg5h7SYtbJ5kNcsLDbkqOlQWCypfM=;
  b=j4BIUMhw9GalxFhhEoMeDUxptUg94IybbZA+ISTjkGEqLMzivjbZeI0C
   /hbW8zNI16xJyTXz2B+kshMlmDBvglP3Z4NOvBOFvQc+DLZiuJ3PhEpFF
   NDgDrhNzuRC8ZcsoAW+J8z9yRfZ0A+fOKUOF5N3JsQgA/7dUZGL0RTGRl
   2L08eNvzpYB0b24N5bIdio5vgnSL9QXVqQYZM2qxc/RCkZB5+sw45i76N
   welHaaZdQiG+0t+/mJuZ0MMvMGFT3Km4gq1qfVS1EdnoJhgXWDJ73VXhL
   Oshy/bxy6di0+HmQt3pOHKFHkN+4BfuGTopRJSkyqCC6IwaGjAVLcY6GH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899140"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796194"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 39/44] memremap_pages: Add memremap.pks_fault_mode
Date:   Thu, 27 Jan 2022 09:55:00 -0800
Message-Id: <20220127175505.851391-40-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some systems may be using pmem in unanticipated ways.  As such, it is
possible an foreseen code path to violate the restrictions of the PMEM
PKS protections.

In order to provide a more seamless integration of the PMEM PKS feature
provide a pks_fault_mode that allows for a relaxed mode should a
previously working feature fault on the PKS protected PMEM.

2 modes are available:

	'relaxed' (default) -- WARN_ONCE, removed the protections, and
	continuing to operate.

	'strict' -- BUG_ON/or fault indicating the error.  This is the
	most protective of the PMEM memory but may be undesirable in
	some configurations.

NOTE: The typedef of pks_fault_modes is required to allow
param_check_pks_fault() to work automatically for us.  So the typedef
checkpatch warning is ignored.

NOTE: There was some debate about if a 3rd mode called 'silent' should
be available.  'silent' would be the same as 'relaxed' but not print any
output.  While 'silent' is nice for admins to reduce console/log output
it would result in less motivation to fix invalid access to the
protected pmem pages.  Therefore, 'silent' is left out.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 .../admin-guide/kernel-parameters.txt         | 14 ++++
 arch/x86/mm/pkeys.c                           |  4 ++
 include/linux/mm.h                            |  3 +
 mm/memremap.c                                 | 67 +++++++++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..3e70a6194831 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4158,6 +4158,20 @@
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/x86/i386/IO-APIC.rst.
 
+	memremap.pks_fault_mode=	[X86] Control the behavior of page map
+			protection violations.  Violations may not be an actual
+			use of the memory but simply an attempt to map it in an
+			incompatible way.
+			(depends on CONFIG_DEVMAP_ACCESS_PROTECTION)
+
+			Format: { relaxed | strict }
+
+			relaxed - Print a warning, disable the protection and
+				  continue execution.
+			strict - Stop kernel execution via BUG_ON or fault
+
+			default: relaxed
+
 	plip=		[PPT,NET] Parallel port network link
 			Format: { parport<nr> | timid | 0 }
 			See also Documentation/admin-guide/parport.rst.
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index fa71037c1dd0..e864a9b7828a 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>		/* debugfs_create_u32()		*/
 #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
 #include <linux/pkeys.h>                /* PKEY_*                       */
+#include <linux/mm.h>                   /* fault callback               */
 #include <uapi/asm-generic/mman-common.h>
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
@@ -243,6 +244,9 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = {
 #ifdef CONFIG_PKS_TEST
 	[PKS_KEY_TEST]		= pks_test_fault_callback,
 #endif
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+	[PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
+#endif
 };
 
 static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 60044de77c54..e900df563437 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1193,6 +1193,9 @@ static inline void pgmap_mk_noaccess(struct page *page)
 
 bool pgmap_protection_available(void);
 
+bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
+			      bool write);
+
 #else
 
 static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
diff --git a/mm/memremap.c b/mm/memremap.c
index b75c4f778c59..783b1cd4bb42 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -96,6 +96,73 @@ static void devmap_protection_disable(void)
 	static_branch_dec(&dev_pgmap_protection_static_key);
 }
 
+/*
+ * Ignore the checkpatch warning because the typedef allows
+ * param_check_pks_fault_modes to automatically check the passed value.
+ */
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
+	int ret = 0;
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
+	pks_update_exception(regs, PKS_KEY_PGMAP_PROTECTION, 0);
+	return true;
+}
+EXPORT_SYMBOL_GPL(pgmap_pks_fault_callback);
+
 void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
 {
 	if (!current->pgmap_prot_count++)
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8D49E95E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiA0Rzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:19415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244701AbiA0RzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306115; x=1674842115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYAz7JDYxVELS0TsoMqBdWSpXvvAabn6bWktK0rh01c=;
  b=FKxa6SoCjSO+jmNuU+ze+0v6Va3LpkuwNT3Rrc3ljRM9Pv16rnnCkB19
   rm8trT3Twhx3U8aJh5N+DUohAr0MOyF+1mePgmfBur5Gfc1ll31/HpYnK
   yu7nF9XOPqBouttgNQRnQ+c+hqWhRnbA5dLOn8/xmzFrETxp+cRP00yYI
   pi1vL/i3DngSJhk9K9l9rJS1yTP5mBgN+xgmgDDaUSxxtqwaRCbT1JfY5
   XPehs9Y1okXj7yfLl59eRkaldM/At1aC0jK+WruR4qRwfLm81w2y85V+y
   NkED3x5PGeYtomg4+jUDPiix6q7LXhDyQh7oqX2mnIYvnJji+WFMH7pE4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302426"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796099"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 16/44] mm/pkeys: Introduce pks_mk_readwrite()
Date:   Thu, 27 Jan 2022 09:54:37 -0800
Message-Id: <20220127175505.851391-17-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When a user needs valid access to a PKS protected page they will need to
change the protections for their pkey to Read/Write within a thread of
execution.

Define pks_mk_readwrite() to update the specified Pkey.  Define
pks_update_protection() as a helper to do the heavy lifting and to allow
for subsequent pks_mk_*() calls.  Define PKEY_READ_WRITE rather than use
a magic value of '0' in pks_update_protection().  Finally, ensure
preemption is disabled while calling pks_write_pkrs() in this code.

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Define PKEY_READ_WRITE
	Make the call inline
	Clean up the names
	Use pks_write_pkrs() with preemption disabled
	Split this out from 'Add PKS kernel API'
	Include documentation in this patch
---
 Documentation/core-api/protection-keys.rst |  9 ++++++-
 arch/x86/mm/pkeys.c                        | 28 ++++++++++++++++++++++
 include/linux/pkeys.h                      | 25 +++++++++++++++++++
 include/uapi/asm-generic/mman-common.h     |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 234122e56a92..e4a27b93f3d4 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -141,11 +141,18 @@ Adding Pages to a PKey protected domain
         :doc: PKS_KEY_ASSIGNMENT
 
 
+Changing permissions of individual keys
+---------------------------------------
+
+.. kernel-doc:: include/linux/pks-keys.h
+        :identifiers: pks_mk_readwrite
+
 MSR details
 -----------
 
 It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not serializing
-but still maintains ordering properties similar to WRPKRU.
+but still maintains ordering properties similar to WRPKRU.  Thus it is safe to
+immediately use a mapping when the pks_mk*() functions return.
 
 Older versions of the SDM on PKRS may be wrong with regard to this
 serialization.  The text should be the same as that of WRPKRU.  From the WRPKRU
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6d94dfc9a219..7c6498fb8f8d 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,6 +10,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/pks.h>
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -275,4 +276,31 @@ void pks_setup(void)
 	cr4_set_bits(X86_CR4_PKS);
 }
 
+/*
+ * Do not call this directly, see pks_mk*().
+ *
+ * @pkey: Key for the domain to change
+ * @protection: protection bits to be used
+ *
+ * Protection utilizes the same protection bits specified for User pkeys
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ *
+ */
+void pks_update_protection(int pkey, u32 protection)
+{
+	u32 pkrs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	pkrs = current->thread.pks_saved_pkrs;
+	current->thread.pks_saved_pkrs = pkey_update_pkval(pkrs, pkey,
+							   protection);
+	preempt_disable();
+	pks_write_pkrs(current->thread.pks_saved_pkrs);
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(pks_update_protection);
+
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index e9ea8f152915..73b554b99123 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,6 +48,31 @@ static inline bool arch_pkeys_enabled(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
 #include <linux/pks-keys.h>
+#include <linux/types.h>
+
+#include <uapi/asm-generic/mman-common.h>
+
+void pks_update_protection(int pkey, u32 protection);
+
+/**
+ * pks_mk_readwrite() - Make the domain Read/Write
+ * @pkey: the pkey for which the access should change.
+ *
+ * Allow all access, read and write, to the domain specified by pkey.  This is
+ * not a global update and only affects the current running thread.
+ */
+static inline void pks_mk_readwrite(int pkey)
+{
+	pks_update_protection(pkey, PKEY_READ_WRITE);
+}
+
+#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+static inline void pks_mk_readwrite(int pkey) {}
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 1567a3294c3d..3da6ac9e5ded 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -78,6 +78,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_READ_WRITE		0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.31.1


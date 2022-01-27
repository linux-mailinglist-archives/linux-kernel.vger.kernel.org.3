Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46549E974
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiA0R4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244818AbiA0Rzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306132; x=1674842132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3DkGtAeq/fvKF1BtRuemGQclgEwuaGMDhc79ROPFiw=;
  b=YnQy4VezkywlEXKiqqt/KARNW4vm4HM5YywPKjLLOaR7K6kxI90bck2M
   2Zz+fjhg+zSUjJjfnwBbNl0SfKGDqU0h90pxaY0340MheRNGjnZJWABbO
   9rHDEIFDaS9+CoWjw54lgiOn+FFjQMdGPe4ldKclRS753r7ehCtyVswLu
   +zHoPIOe3vmfDdIsE3kZtKdobhry1fsXsTxlbdIss/7M2g5EqvvvxBdsE
   hyaPe3AGg7YKzGhOfENH9JfIw0U2G7YPqCs34JZ333VzMrVo6kRGWvg5D
   f2/o4lRu4LcqLumKV73wwLUkGIDADMWSIAL0CTa238HhGV4KM1dSGFJaS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302444"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796152"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 28/44] mm/pkeys: Introduce pks_update_exception()
Date:   Thu, 27 Jan 2022 09:54:49 -0800
Message-Id: <20220127175505.851391-29-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some PKS use cases will want to catch permissions violations and
optionally allow them.

pks_update_protection() updates the protection of the current running
context.  It will _not_ work to change the protections of a thread which
has been interrupted.  Therefore updating a thread from within an
exception is not possible with pks_update_protection().

Introduce pks_update_exception() to update the faulted threads protections
in addition to the current context.  A PKS fault callback can then be
used to adjust the permissions of the faulted thread as necessary.

Add documentation

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Remove the concept of abandoning a pkey in favor of using the
		custom fault handler via this new pks_update_exception()
		call
	Without an abandon call there is no need for an abandon mask on
		sched in, new thread creation, or within exceptions...
	This now lets all invalid access' fault
	Ensure that all entry points into the pks has feature checks...
	Place abandon fault check before the test callback to ensure
		testing does not detect the double fault of the abandon
		code and flag it incorrectly as a fault.
	Change return type of pks_handle_abandoned_pkeys() to bool
---
 Documentation/core-api/protection-keys.rst |  3 ++
 arch/x86/mm/pkeys.c                        | 49 +++++++++++++++++++---
 include/linux/pkeys.h                      |  5 +++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 115afc67153f..b89308bf117e 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -147,6 +147,9 @@ Changing permissions of individual keys
 .. kernel-doc:: include/linux/pks-keys.h
         :identifiers: pks_mk_readwrite pks_mk_noaccess
 
+.. kernel-doc:: arch/x86/mm/pkeys.c
+        :identifiers: pks_update_exception
+
 MSR details
 -----------
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 1da78580d6de..6723ae42732a 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -319,6 +319,15 @@ void pks_setup(void)
 	cr4_set_bits(X86_CR4_PKS);
 }
 
+static void __pks_update_protection(int pkey, u32 protection)
+{
+	u32 pkrs = current->thread.pks_saved_pkrs;
+
+	current->thread.pks_saved_pkrs = pkey_update_pkval(pkrs, pkey,
+							   protection);
+	pks_write_pkrs(current->thread.pks_saved_pkrs);
+}
+
 /*
  * Do not call this directly, see pks_mk*().
  *
@@ -332,18 +341,46 @@ void pks_setup(void)
  */
 void pks_update_protection(int pkey, u32 protection)
 {
-	u32 pkrs;
-
 	if (!cpu_feature_enabled(X86_FEATURE_PKS))
 		return;
 
-	pkrs = current->thread.pks_saved_pkrs;
-	current->thread.pks_saved_pkrs = pkey_update_pkval(pkrs, pkey,
-							   protection);
 	preempt_disable();
-	pks_write_pkrs(current->thread.pks_saved_pkrs);
+	__pks_update_protection(pkey, protection);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(pks_update_protection);
 
+/**
+ * pks_update_exception() - Update the protections of a faulted thread
+ *
+ * @regs: Faulting thread registers
+ * @pkey: pkey to update
+ * @protection: protection bits to use.
+ *
+ * CONTEXT: Exception
+ *
+ * pks_update_protection() updates the protection of the current running
+ * context.  It will not work to change the protections of a thread which has
+ * been interrupted.  If a PKS fault callback fires it may want to update the
+ * faulted threads protections in addition to it's own.
+ *
+ * Use pks_update_exception() to update the faulted threads protections
+ * in addition to the current context.
+ */
+void pks_update_exception(struct pt_regs *regs, int pkey, u32 protection)
+{
+	struct pt_regs_extended *ept_regs;
+	u32 old;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	__pks_update_protection(pkey, protection);
+
+	ept_regs = to_extended_pt_regs(regs);
+	old = ept_regs->aux.pks_thread_pkrs;
+	ept_regs->aux.pks_thread_pkrs = pkey_update_pkval(old, pkey, protection);
+}
+EXPORT_SYMBOL_GPL(pks_update_exception);
+
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 5f4965f5449b..c318d97f5da8 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -56,6 +56,7 @@ static inline bool arch_pkeys_enabled(void)
 #include <uapi/asm-generic/mman-common.h>
 
 void pks_update_protection(int pkey, u32 protection);
+void pks_update_exception(struct pt_regs *regs, int pkey, u32 protection);
 
 /**
  * pks_mk_noaccess() - Disable all access to the domain
@@ -85,6 +86,10 @@ static inline void pks_mk_readwrite(int pkey)
 
 static inline void pks_mk_noaccess(int pkey) {}
 static inline void pks_mk_readwrite(int pkey) {}
+static inline void pks_update_exception(struct pt_regs *regs,
+					int pkey,
+					u32 protection)
+{ }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
-- 
2.31.1


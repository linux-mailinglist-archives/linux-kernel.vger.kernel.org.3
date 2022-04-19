Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5750763E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355893AbiDSRKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355604AbiDSRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2762C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388022; x=1681924022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yN0yRbdkpZNX+e/QEdD0Iwhz8NeQzBwyhB1u8C+FbRs=;
  b=Jmmu8xTpkoaKgQlbIMTn/N+SAyUxEEjebGUVMl/MTjNaYnK3BsSns0gv
   hI/GS4kIRmx5vnlViONryVhvFblJnQ0le/qmMIbGmas51O1+kxgkoQFBk
   kB6M536ZqovX7NFGqueOFYJz9dhE4oK/XX1QUR0jv7YRyZT4iNyd5BQOO
   9do84tEHbN3BxcRLptK0SnwIZPfbmqBNmzaGxgSNCEfvPpLRmOrb/SQpz
   WwbRz4GsGwrolbsnoYxTr98ujcCE/dJC2NsoDF2uC/A/xzy+tpXtLJrKu
   jVKb1cShtxxNF8UaSAyL4Moocf7aNtEW5mKfKeSaesrd1uoWm7Iazvy2Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991825"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991825"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="861588291"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:02 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Date:   Tue, 19 Apr 2022 10:06:19 -0700
Message-Id: <20220419170649.1022246-15-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When kernel code needs access to a PKS protected page they will need to
change the protections for the pkey to Read/Write.

Define pks_set_readwrite() to update the specified pkey.  Define
pks_update_protection() as a helper to do the heavy lifting and allow
for subsequent pks_set_*() calls.

Define PKEY_READ_WRITE rather than use a magic value of '0' in
pks_update_protection().

Finally, ensure preemption is disabled for pks_write_pkrs() because the
context of this call can not generally be predicted.

pks.h is created to avoid conflicts and header dependencies with the
user space pkey code.

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
changes for v9
	Move MSR documentation note to this patch
	move declarations to incline/linux/pks.h
	from rick edgecombe
		change pkey type to u8
	validate pkey range in pks_update_protection
	from 0day
		fix documentation link
	from dave hansen
		s/pks_mk_*/pks_set_*/
		use pkey
		s/pks_saved_pkrs/pkrs/

changes for v8
	define pkey_read_write
	make the call inline
	clean up the names
	use pks_write_pkrs() with preemption disabled
	split this out from 'add pks kernel api'
	include documentation in this patch
---
 Documentation/core-api/protection-keys.rst | 15 +++++++++++
 arch/x86/mm/pkeys.c                        | 31 ++++++++++++++++++++++
 include/linux/pks.h                        | 31 ++++++++++++++++++++++
 include/uapi/asm-generic/mman-common.h     |  1 +
 4 files changed, 78 insertions(+)
 create mode 100644 include/linux/pks.h

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index fe63acf5abbe..3af92e1cbffd 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -142,3 +142,18 @@ Adding pages to a pkey protected domain
 
 .. kernel-doc:: arch/x86/include/asm/pgtable_types.h
         :doc: PKS_KEY_ASSIGNMENT
+
+Changing permissions of individual keys
+---------------------------------------
+
+.. kernel-doc:: include/linux/pks.h
+        :identifiers: pks_set_readwrite
+
+MSR details
+~~~~~~~~~~~
+
+WRMSR is typically an architecturally serializing instruction.  However,
+WRMSR(MSR_IA32_PKRS) is an exception.  It is not a serializing instruction and
+instead maintains ordering properties similar to WRPKRU.  Thus it is safe to
+immediately use a mapping when the pks_set*() functions returns.  Check the
+latest SDM for details.
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 39e4c2cbc279..e4cbc79686ea 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>		/* debugfs_create_u32()		*/
 #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
 #include <linux/pkeys.h>                /* PKEY_*                       */
+#include <linux/pks.h>
 #include <linux/pks-keys.h>
 #include <uapi/asm-generic/mman-common.h>
 
@@ -275,4 +276,34 @@ void pks_setup(void)
 	cr4_set_bits(X86_CR4_PKS);
 }
 
+/*
+ * Do not call this directly, see pks_set*().
+ *
+ * @pkey: Key for the domain to change
+ * @protection: protection bits to be used
+ *
+ * Protection utilizes the same protection bits specified for User pkeys
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ *
+ */
+void pks_update_protection(u8 pkey, u8 protection)
+{
+	u32 pkrs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	if (WARN_ON_ONCE(pkey >= PKS_KEY_MAX))
+		return;
+
+	pkrs = current->thread.pkrs;
+	current->thread.pkrs = pkey_update_pkval(pkrs, pkey,
+						 protection);
+	preempt_disable();
+	pks_write_pkrs(current->thread.pkrs);
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(pks_update_protection);
+
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
diff --git a/include/linux/pks.h b/include/linux/pks.h
new file mode 100644
index 000000000000..8b705a937b19
--- /dev/null
+++ b/include/linux/pks.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PKS_H
+#define _LINUX_PKS_H
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+#include <linux/types.h>
+
+#include <uapi/asm-generic/mman-common.h>
+
+void pks_update_protection(u8 pkey, u8 protection);
+
+/**
+ * pks_set_readwrite() - Make the domain Read/Write
+ * @pkey: the pkey for which the access should change.
+ *
+ * Allow all access, read and write, to the domain specified by pkey.  This is
+ * not a global update and only affects the current running thread.
+ */
+static inline void pks_set_readwrite(u8 pkey)
+{
+	pks_update_protection(pkey, PKEY_READ_WRITE);
+}
+
+#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+static inline void pks_set_readwrite(u8 pkey) {}
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#endif /* _LINUX_PKS_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6c1aa92a92e4..f179544bd33a 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -80,6 +80,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_READ_WRITE		0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.35.1


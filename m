Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B5549E956
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiA0RzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:37541 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240185AbiA0RzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306109; x=1674842109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+BqwH+CQKO+ZVKKUrwBRI90a7JcX6kP/I2yOdwHEMM=;
  b=aOPYtRtFHK1YqNhG7ED/IlqK+wbesoNNM6KPJn9k620uEE2WFXyWv3bN
   ITw8+WuQvxWv5Dx9sWtCqHiKvqNSmklzKmP5rUqMJza4jBynix0Nzyd1p
   B34wOy58+yW02QxZx3Pg/6D5xMtUQ30k2noKKq9MXDA98husHCl23LDj9
   WErMZ4u9oDOGxj66316KZslFRRZiyyjIqMDs4FC/VFZpkyzO05dz2ZZwD
   7Ag0ZoVF8SgV3Yu9IhfLByq5TK4Ed3yBqrYAebYxwhcyO4CwqpZ9FnTqF
   6V9s+Wm2/8C0HgDloD4/FYEwPcK8grVP/ETnjnRSStm0gwiolt24Na9Sf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245766389"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="245766389"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796080"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 11/44] mm/pkeys: Define static PKS key array and default values
Date:   Thu, 27 Jan 2022 09:54:32 -0800
Message-Id: <20220127175505.851391-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Kernel users will need a way to allocate a PKS Pkey for their use.

Introduce pks-keys.h as a place to define enum pks_pkey_consumers and
the macro PKS_INIT_VALUE.  PKS_INIT_VALUE holds the default value for
each key.  Kernel users reserve a key value by adding an entry to the
enum pks_pkey_consumers with a unique value [1-15] and replacing that
value in the PKS_INIT_VALUE macro using the desired default macro;
PKR_RW_KEY(), PKR_WD_KEY(), or PKR_AD_KEY().

Use this value to initialize all CPUs at boot.

pks-keys.h is added as a new header with minimal header dependencies.
This allows the use of PKS_INIT_VALUE within other headers where the
additional includes from pkeys.h caused major conflicts.  The main
conflict was using PKS_INIT_VALUE for INIT_TRHEAD in asm/processor.h

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Create pks-keys.h to solve header conflicts in subsequent
		patches.
	Remove create_initial_pkrs_value() which did not work
		Replace it with PKS_INIT_VALUE
		Fix up documentation to match
	s/PKR_RW_BIT/PKR_RW_KEY()/
	s/PKRS_INIT_VALUE/PKS_INIT_VALUE
	Split this off of the previous patch
	Update documentation and embed it in the code to help ensure it
	is kept up to date.

Changes for V7
	Create a dynamic pkrs_initial_value in early init code.
	Clean up comments
	Add comment to macro guard
---
 Documentation/core-api/protection-keys.rst |  4 ++
 arch/x86/include/asm/pkeys_common.h        |  1 +
 arch/x86/mm/pkeys.c                        |  2 +-
 include/linux/pkeys.h                      |  2 +
 include/linux/pks-keys.h                   | 59 ++++++++++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pks-keys.h

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 58670e3ee39e..af283a1a9aa0 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -129,6 +129,10 @@ Kernel users intending to use PKS support should depend on
 ARCH_HAS_SUPERVISOR_PKEYS, and select ARCH_ENABLE_SUPERVISOR_PKEYS to turn on
 this support within the core.
 
+PKS Key Allocation
+------------------
+.. kernel-doc:: include/linux/pks-keys.h
+        :doc: PKS_KEY_ALLOCATION
 
 MSR details
 -----------
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index d02ab5bc3fff..efb101dee3aa 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -8,6 +8,7 @@
 
 #define PKR_PKEY_SHIFT(pkey)	(pkey * PKR_BITS_PER_PKEY)
 
+#define PKR_RW_KEY(pkey)	(0          << PKR_PKEY_SHIFT(pkey))
 #define PKR_AD_KEY(pkey)	(PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
 #define PKR_WD_KEY(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 02629219e683..a5b5b86e97ce 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -217,7 +217,7 @@ void pks_setup(void)
 	if (!cpu_feature_enabled(X86_FEATURE_PKS))
 		return;
 
-	wrmsrl(MSR_IA32_PKRS, 0);
+	wrmsrl(MSR_IA32_PKRS, PKS_INIT_VALUE);
 	cr4_set_bits(X86_CR4_PKS);
 }
 
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 86be8bf27b41..e9ea8f152915 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,4 +48,6 @@ static inline bool arch_pkeys_enabled(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#include <linux/pks-keys.h>
+
 #endif /* _LINUX_PKEYS_H */
diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
new file mode 100644
index 000000000000..05fe4a1cf888
--- /dev/null
+++ b/include/linux/pks-keys.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PKS_KEYS_H
+#define _LINUX_PKS_KEYS_H
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+#include <asm/pkeys_common.h>
+
+/**
+ * DOC: PKS_KEY_ALLOCATION
+ *
+ * Users reserve a key value by adding an entry to enum pks_pkey_consumers with
+ * a unique value from 1 to 15.  Then replacing that value in the
+ * PKS_INIT_VALUE macro using the desired default protection; PKR_RW_KEY(),
+ * PKR_WD_KEY(), or PKR_AD_KEY().
+ *
+ * PKS_KEY_DEFAULT must remain 0 key with a default of read/write to support
+ * non-pks protected pages.  Unused keys should be set (Access Disabled
+ * PKR_AD_KEY()).
+ *
+ * For example to configure a key for 'MY_FEATURE' with a default of Write
+ * Disabled.
+ *
+ * .. code-block:: c
+ *
+ *	enum pks_pkey_consumers
+ *	{
+ *		PKS_KEY_DEFAULT         = 0,
+ *		PKS_KEY_MY_FEATURE      = 1,
+ *	}
+ *
+ *	#define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		|
+ *				PKR_WD_KEY(PKS_KEY_MY_FEATURE)		|
+ *				PKR_AD_KEY(2)	| PKR_AD_KEY(3)		|
+ *				PKR_AD_KEY(4)	| PKR_AD_KEY(5)		|
+ *				PKR_AD_KEY(6)	| PKR_AD_KEY(7)		|
+ *				PKR_AD_KEY(8)	| PKR_AD_KEY(9)		|
+ *				PKR_AD_KEY(10)	| PKR_AD_KEY(11)	|
+ *				PKR_AD_KEY(12)	| PKR_AD_KEY(13)	|
+ *				PKR_AD_KEY(14)	| PKR_AD_KEY(15))
+ *
+ */
+enum pks_pkey_consumers {
+	PKS_KEY_DEFAULT		= 0, /* Must be 0 for default PTE values */
+};
+
+#define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
+			PKR_AD_KEY(1)	| \
+			PKR_AD_KEY(2)	| PKR_AD_KEY(3)		| \
+			PKR_AD_KEY(4)	| PKR_AD_KEY(5)		| \
+			PKR_AD_KEY(6)	| PKR_AD_KEY(7)		| \
+			PKR_AD_KEY(8)	| PKR_AD_KEY(9)		| \
+			PKR_AD_KEY(10)	| PKR_AD_KEY(11)	| \
+			PKR_AD_KEY(12)	| PKR_AD_KEY(13)	| \
+			PKR_AD_KEY(14)	| PKR_AD_KEY(15))
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#endif /* _LINUX_PKS_KEYS_H */
-- 
2.31.1


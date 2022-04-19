Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24C50760B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355629AbiDSRJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355553AbiDSRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD7FF7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388018; x=1681924018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3NA1AOfkWvyInGYP3ZXXPe9wyH6gcZKqLJYd1GBzKOE=;
  b=BJVf5a9s2T2TQk2RmwT5X2BKkwVyr2YsaGokXNn8ph3NyNh8xoAk9eqc
   BB/zJ9HhO/NsDhcEjUJ/JQfpqon6aosbvyxOs/bpCUjizeatzTJbMrwDM
   jG59QtBUixYAy2VgOwURo2T+p1eDLI2Oqe9m4RTKuWCxeStBQxRZjVj2E
   BD1qGC4DDYnCpzglJMrp1h7jHQ3bKEdo1970ZldMam11L0WSoHHc0WtTy
   b5bbF4Y86/gmZyQVcBXck+U+OKqkjd8KX4nzsW2ioB9De3/cN2WIeiY8I
   Qb93nZp481uhwQmfwT5/872j5hHRtyGO7w3YQq1pl0FpHNd8lV4ZUaqWf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244402616"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="244402616"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="576192165"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:57 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 09/44] mm/pkeys: Provide for PKS key allocation
Date:   Tue, 19 Apr 2022 10:06:14 -0700
Message-Id: <20220419170649.1022246-10-ira.weiny@intel.com>
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

Kernel consumers of PKS need a way to allocate a PKS pkey and assign the
initial permissions for that key.  It is desirable to not allocate keys
for consumers which are not configured.

Introduce a macro to allocate keys sequentially based on which consumers
are configured.  In addition define a macro to set the proper permission
bits based on the actual pkey value allocated.

pks-keys.h is added as a new header with minimal header dependencies.
This allows the use of PKS_INIT_VALUE within other headers where the
additional includes from other pkey headers caused major conflicts.  The
main conflict was using PKS_INIT_VALUE for INIT_TRHEAD in
asm/processor.h

Add documentation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Reword the commit message
	Move this patch ahead of the enable patch so that the enable
		patch can use PKS_INIT_VALUE
	From Dan Williams
		Use Dan's macro magic
			enhanced it to account for the max number of
			keys
		Update documentation for the change
	From Dave Hansen
		use pkey
		s/PKR_RW_KEY/PKR_RW_MASK

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
 Documentation/core-api/protection-keys.rst |  5 ++
 arch/x86/include/asm/pkeys_common.h        |  9 ++-
 include/linux/pks-keys.h                   | 78 ++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pks-keys.h

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 13eedb0119e1..d501bd27ee29 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -131,3 +131,8 @@ ARCH_HAS_SUPERVISOR_PKEYS.  It also makes it possible for multiple independent
 features to "select ARCH_ENABLE_SUPERVISOR_PKEYS".  If no features enable PKS
 by selecting ARCH_ENABLE_SUPERVISOR_PKEYS, PKS support will not be compiled
 into the kernel.
+
+PKS Key Allocation
+------------------
+.. kernel-doc:: include/linux/pks-keys.h
+        :doc: PKS_KEY_ALLOCATION
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 359b94cdcc0c..b28a72dea22b 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -2,10 +2,17 @@
 #ifndef _ASM_X86_PKEYS_COMMON_H
 #define _ASM_X86_PKEYS_COMMON_H
 
+#define PKS_NUM_PKEYS 16
+#define PKS_ALL_AD (0x55555555UL)
+
 #define PKR_AD_BIT 0x1u
 #define PKR_WD_BIT 0x2u
 #define PKR_BITS_PER_PKEY 2
 
-#define PKR_AD_MASK(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+#define PKR_PKEY_SHIFT(pkey)	(pkey * PKR_BITS_PER_PKEY)
+
+#define PKR_RW_MASK(pkey)	(0          << PKR_PKEY_SHIFT(pkey))
+#define PKR_AD_MASK(pkey)	(PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
+#define PKR_WD_MASK(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
 
 #endif /*_ASM_X86_PKEYS_COMMON_H */
diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
new file mode 100644
index 000000000000..c914afecb2d3
--- /dev/null
+++ b/include/linux/pks-keys.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PKS_KEYS_H
+#define _LINUX_PKS_KEYS_H
+
+/*
+ * The contents of this header should be limited to assigning PKS keys and
+ * default values to avoid intricate header dependencies.
+ */
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+#include <asm/pkeys_common.h>
+
+#define PKS_NEW_KEY(prev, config) \
+	(prev + __is_defined(config))
+#define PKS_DECLARE_INIT_VALUE(pkey, value, config) \
+	(PKR_##value##_MASK(pkey) * __is_defined(config))
+
+/**
+ * DOC: PKS_KEY_ALLOCATION
+ *
+ * Users reserve a key value in 5 steps.
+ *	1) Use PKS_NEW_KEY to create a new key
+ *	2) Ensure that the last key value is specified in the PKS_NEW_KEY macro
+ *	3) Adjust PKS_KEY_MAX to use the newly defined key value
+ *	4) Use PKS_DECLARE_INIT_VALUE to define an initial value
+ *	5) Add the new PKS default value to PKS_INIT_VALUE
+ *
+ * The PKS_NEW_KEY and PKS_DECLARE_INIT_VALUE macros require the Kconfig
+ * option to be specified to automatically adjust the number of keys used.
+ *
+ * PKS_KEY_DEFAULT must remain 0 with a default of PKS_DECLARE_INIT_VALUE(...,
+ * RW, ...) to support non-pks protected pages.
+ *
+ * Example: to configure a key for 'MY_FEATURE' with a default of Write
+ * Disabled.
+ *
+ * .. code-block:: c
+ *
+ *	#define PKS_KEY_DEFAULT		0
+ *
+ *	// 1) Use PKS_NEW_KEY to create a new key
+ *	// 2) Ensure that the last key value is specified (eg PKS_KEY_DEFAULT)
+ *	#define PKS_KEY_MY_FEATURE PKS_NEW_KEY(PKS_KEY_DEFAULT, CONFIG_MY_FEATURE)
+ *
+ *	// 3) Adjust PKS_KEY_MAX
+ *	#define PKS_KEY_MAX	   PKS_NEW_KEY(PKS_KEY_MY_FEATURE, 1)
+ *
+ *	// 4) Define initial value
+ *	#define PKS_KEY_MY_FEATURE_INIT PKS_DECLARE_INIT_VALUE(PKS_KEY_MY_FEATURE, \
+ *								WD, CONFIG_MY_FEATURE)
+ *
+ *
+ *	// 5) Add initial value to PKS_INIT_VALUE
+ *	#define PKS_INIT_VALUE ((PKS_ALL_AD & PKS_ALL_AD_MASK) | \
+ *				PKS_KEY_DEFAULT_INIT | \
+ *				PKS_KEY_MY_FEATURE_INIT \
+ *				)
+ */
+
+/* PKS_KEY_DEFAULT must be 0 */
+#define PKS_KEY_DEFAULT		0
+#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_DEFAULT, 1)
+
+/* PKS_KEY_DEFAULT_INIT must be RW */
+#define PKS_KEY_DEFAULT_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_DEFAULT, RW, 1)
+
+#define PKS_ALL_AD_MASK \
+	GENMASK(PKS_NUM_PKEYS * PKR_BITS_PER_PKEY, \
+		PKS_KEY_MAX * PKR_BITS_PER_PKEY)
+
+#define PKS_INIT_VALUE ((PKS_ALL_AD & PKS_ALL_AD_MASK) | \
+			PKS_KEY_DEFAULT_INIT \
+			)
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#endif /* _LINUX_PKS_KEYS_H */
-- 
2.35.1


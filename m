Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DDF507613
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355806AbiDSRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355596AbiDSRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783A95F59
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388021; x=1681924021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uPfCwCLIhEO1e+fi1mrejHCAQdkmQVhrehDTb7JigWc=;
  b=NQtt8JdMpk2xQL8r4FzslBkss92fWgqoV1bQfymgJSeYNkL/ctxuFgrr
   wNYHRc5hkNsbNh21U4hvsN5ZT1Pu7FB8yspUxk42YNGulugGdXGmb2+Ct
   bwOsVbigJd1zA6Elszk+ICEkLu4/apDAcHAqD/h+NFSafDreqRV14d5IZ
   4W2kMUDOKi8XIzOl9eSEdkHRWQYGtM51A8t7zixvfkEYaPMdHGVu95m/K
   j77HHe6FC/TSKV2kwAS+wdSSUs8wrFKYsgLP5wKBrIsOkp8i4zHBRBOKR
   07x/7rDgtN+36rDr32jlPbXoGS1fskam8YL8CppWKfU1Cw7tbnkNiQNFA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251123589"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="251123589"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727145527"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:00 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 11/44] mm/pkeys: Define PKS page table macros
Date:   Tue, 19 Apr 2022 10:06:16 -0700
Message-Id: <20220419170649.1022246-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Kernel PKS consumers will need a way to assign their pkey to pages.

Define _PAGE_PKEY() and PAGE_KERNEL_PKEY() to allow users to set a pkey
on a PTE.

Add documentation.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

---
Changes for V9
	From Dave Hansen
		s/PKey/pkey

Changes for V8
	Split out from the 'Add PKS kernel API' patch
	Include documentation in this patch
---
 Documentation/core-api/protection-keys.rst |  6 ++++++
 arch/x86/include/asm/pgtable_types.h       | 22 ++++++++++++++++++++++
 include/linux/pgtable.h                    |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index d501bd27ee29..fe63acf5abbe 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -136,3 +136,9 @@ PKS Key Allocation
 ------------------
 .. kernel-doc:: include/linux/pks-keys.h
         :doc: PKS_KEY_ALLOCATION
+
+Adding pages to a pkey protected domain
+---------------------------------------
+
+.. kernel-doc:: arch/x86/include/asm/pgtable_types.h
+        :doc: PKS_KEY_ASSIGNMENT
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..e1d4535b525e 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -71,6 +71,22 @@
 			 _PAGE_PKEY_BIT2 | \
 			 _PAGE_PKEY_BIT3)
 
+/**
+ * DOC: PKS_KEY_ASSIGNMENT
+ *
+ * The following macros are used to set a pkey value in a supervisor PTE.
+ *
+ * .. code-block:: c
+ *
+ *         #define _PAGE_KEY(pkey)
+ *         #define PAGE_KERNEL_PKEY(pkey)
+ */
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, pkey) << _PAGE_BIT_PKEY_BIT0)
+#else
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, 0))
+#endif
+
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
 #else
@@ -226,6 +242,12 @@ enum page_cache_mode {
 #define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
 #define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+#define PAGE_KERNEL_PKEY(pkey)	__pgprot_mask(__PAGE_KERNEL | _PAGE_PKEY(pkey))
+#else
+#define PAGE_KERNEL_PKEY(pkey) PAGE_KERNEL
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f4f4077b97aa..bcef6b306fcb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1511,6 +1511,10 @@ static inline bool arch_has_pfn_modify_check(void)
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif
 
+#ifndef PAGE_KERNEL_PKEY
+#define PAGE_KERNEL_PKEY(pkey) PAGE_KERNEL
+#endif
+
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
-- 
2.35.1


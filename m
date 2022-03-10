Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019604D505B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbiCJRWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbiCJRWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:06 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992F199D40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932864; x=1678468864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uPfCwCLIhEO1e+fi1mrejHCAQdkmQVhrehDTb7JigWc=;
  b=m8pS0C+iKvFa21Au1qywUJrzYqK6P/aqsvZ/7Hi2NWNw+DXhu1zOY8CX
   ECR9k994mhOOIY1gwRYsm9ReQeTsX/RHwcjOSBXkKk/qgBOgM6wi2hMlb
   MOdy5yH3E6xPrsFaj4IwWt713c8sUnQ+KpDr+wCOPwltOpJOQSnQ4fLPv
   STvNFtCePDjXMeV5Z4Zsx2up6QdOojegM1p51M5imLc10wYGZN1o7KNQZ
   RKlltoxOet8tUvDG8LNEn5Rx9dit6sJvbhq+YUBLbUfhTF1fM/jblRNJc
   qOLRAr1Ynmn77Bk+UbB4ADDW1/AhrcFOdTfRwn5r+zB97tND/T4sZydGI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316032937"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="316032937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="496337923"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:52 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 12/45] mm/pkeys: Define PKS page table macros
Date:   Thu, 10 Mar 2022 09:19:46 -0800
Message-Id: <20220310172019.850939-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


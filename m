Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8321549E957
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbiA0RzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbiA0RzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306109; x=1674842109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTOs7mI3xPl7MCxOVUgiwlIET8BTz8VGJvSH//yf5OA=;
  b=WfUnqIGe3GQ3SWnraIj1w8qRTKt+jYT8aCW8on7h/54NXJWbnPt+crZg
   VTd/6o8DJPIc2MZyKl5Y9+qwvmuKtFkotMb6W2odnEYc/4dqVQZvT1Sck
   dXTga7zdpp0W3TGuyHoId1i8ZzUf5Yv+KagbnbyT2eUmH0o4HmUVfegEY
   O8Kp2zdiHN08PoVHZShunz+xkYSvZtZnv7lXAsCpcRIgB0oilvGNnZeqz
   sivymIZo+4O+a9B/aFTeZIbnz51oeh8pwtaA+3YVzROra5fLhqO1B0N9O
   Ku3L+CP1KW18JvpXqWTCiDf6Mwt6SsT568zjkTAcCjdGgLxhBoH5ak0c7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302422"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796084"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 12/44] mm/pkeys: Define PKS page table macros
Date:   Thu, 27 Jan 2022 09:54:33 -0800
Message-Id: <20220127175505.851391-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Kernel users will need a way to assign their pkey to pages.

Define _PAGE_PKEY() and PAGE_KERNEL_PKEY() to allow users to set a pkey
on a PTE.

Add documentation.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

---
Changes for V8
	Split out from the 'Add PKS kernel API' patch
	Include documentation in this patch
---
 Documentation/core-api/protection-keys.rst |  7 +++++++
 arch/x86/include/asm/pgtable_types.h       | 22 ++++++++++++++++++++++
 include/linux/pgtable.h                    |  4 ++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index af283a1a9aa0..794b7dedc544 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -134,6 +134,13 @@ PKS Key Allocation
 .. kernel-doc:: include/linux/pks-keys.h
         :doc: PKS_KEY_ALLOCATION
 
+Adding Pages to a PKey protected domain
+---------------------------------------
+
+.. kernel-doc:: arch/x86/include/asm/pgtable_types.h
+        :doc: PKS_KEY_ASSIGNMENT
+
+
 MSR details
 -----------
 
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
index bc8713a76e03..2864066e03ec 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1510,6 +1510,10 @@ static inline bool arch_has_pfn_modify_check(void)
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
2.31.1


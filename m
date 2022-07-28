Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803235837B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiG1Doy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiG1Dod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:44:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD315C96C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658979872; x=1690515872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZM+sHwR5mKiQlxSD/3pVSMcPhO4y2IgNx/fpEOJQAI=;
  b=CDJfi8AyBXfK1pAt/ARQEZs8l0BevZxQpwiweYv/PWzhBC77N7zx0KpU
   TqwHd6IgmLG1+naRGAYuZ2V3qBqUnTqIwl2XCdGN4oLb5JgTfpZuQopCS
   iSDYK5h/YDe7k0fmTMtiivkFE9Zl125a4vcDmnWqlRPATh9fNd5syVO5c
   Pc5+kXvoFIhiOeI9+8pILC36Nf/RfZT9T6nXYwCle5VwFvJjDzGaEsAA8
   Qaj+97gKrC5K5Iiq2Wn2MlLnnu2sYKbqXEo0W31vD7XNx5kL40+jdgOD3
   BcwLE0Z10QSq2DascZdcQlvUGLPHQUfe/QyicxRUQ6v5f/oaqN1imWhJ4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275292808"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="275292808"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="600676742"
Received: from hurleyst-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.106.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:30 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/6] x86/coco: Add cc_decrypted_alloc/free() interfaces
Date:   Wed, 27 Jul 2022 20:44:18 -0700
Message-Id: <20220728034420.648314-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Confidential computing platforms, such as AMD SEV and Intel TDX,
protect memory from VMM access. Any memory that is required for
communication with the VMM must be explicitly shared. It involves
adjusting page table entries to indicate that the memory is shared and
notifies VMM about the change.

set_memory_decrypted() converts memory to shared. Before freeing
memory it has to be converted back with set_memory_encrypted().

The interface works fine for long-term allocations, but for frequent
short-lived allocations it causes problems. Conversion takes time and
direct mapping modification leads to its fracturing and performance
degradation over time.

Direct mapping modifications can be avoided by creating a vmap that
maps allocated pages as shared while direct mapping is untouched.

But having private mapping of a shared memory causes problems too.
Any access of such memory via private mapping in TDX guest would
trigger unrecoverable SEPT violation and termination of the virtual
machine. It is known that load_unaligned_zeropad() can issue such
unwanted loads across page boundaries that can trigger the issue.

It can also be fixed by allocating a guard page in front of any memory
that has to be converted to shared, so load_unaligned_zeropad() will
roll off to the guard page instead. But it is wasteful and does not
address cost of the memory conversion.

The next logical step is to introduce a pool of shared memory that can
share a single guard page and makes conversion less frequent.

Fortunately, the kernel already has such a pool of memory: SWIOTLB
buffer is used by the DMA API to allocate memory for I/O. The buffer is
allocated once during the boot, so direct mapping fracturing is not an
issue and no need for vmap tricks.

Tapping into the SWIOTLB pool requires a device structure and using DMA
API. Provide a couple of simple helpers to allocate and free shared
memory that hide required plumbing.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/Makefile      |  2 +-
 arch/x86/coco/mem.c         | 90 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h | 10 +++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/mem.c

diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c816acf78b6a..96fc4ec4497f 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -3,6 +3,6 @@ CFLAGS_REMOVE_core.o	= -pg
 KASAN_SANITIZE_core.o	:= n
 CFLAGS_core.o		+= -fno-stack-protector
 
-obj-y += core.o
+obj-y += core.o mem.o
 
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
diff --git a/arch/x86/coco/mem.c b/arch/x86/coco/mem.c
new file mode 100644
index 000000000000..78bcce11452e
--- /dev/null
+++ b/arch/x86/coco/mem.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Decrypted Memory Allocator
+ *
+ * Copyright (C) 2022 Intel Corporation, Inc.
+ *
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "cc/mem: " fmt
+
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/cc_platform.h>
+#include <linux/set_memory.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
+
+#include <asm/coco.h>
+#include <asm/processor.h>
+
+#define CC_MEM_DRIVER		"ccmem"
+
+static struct platform_device *mem_pdev;
+
+static inline dma_addr_t virt_to_dma(void *vaddr)
+{
+	return phys_to_dma(&mem_pdev->dev, virt_to_phys(vaddr));
+}
+
+/* Allocate decrypted memory of given size */
+void *cc_decrypted_alloc(size_t size, gfp_t gfp)
+{
+	dma_addr_t handle;
+	void *vaddr;
+
+	if (!mem_pdev)
+		return NULL;
+
+	vaddr = dma_alloc_coherent(&mem_pdev->dev, size, &handle, gfp);
+
+	/*
+	 * Since we rely on virt_to_dma() in cc_decrypted_free() to
+	 * calculate DMA address, make sure address translation works.
+	 */
+	VM_BUG_ON(virt_to_dma(vaddr) != handle);
+
+	return vaddr;
+}
+
+/* Free the given decrypted memory */
+void cc_decrypted_free(void *addr, size_t size)
+{
+	if (!mem_pdev || !addr)
+		return;
+
+	dma_free_coherent(&mem_pdev->dev, size, addr, virt_to_phys(addr));
+}
+
+static struct platform_driver cc_mem_driver = {
+	.driver.name = CC_MEM_DRIVER,
+};
+
+static int __init cc_mem_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return -ENODEV;
+
+	ret =  platform_driver_register(&cc_mem_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(CC_MEM_DRIVER, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&cc_mem_driver);
+		return PTR_ERR(pdev);
+	}
+
+	if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64)))
+		return -EIO;
+
+	mem_pdev = pdev;
+
+	return 0;
+}
+device_initcall(cc_mem_init);
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..74e10213289c 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -17,6 +17,8 @@ void cc_set_mask(u64 mask);
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void *cc_decrypted_alloc(size_t size, gfp_t gfp);
+void cc_decrypted_free(void *addr, size_t size);
 #else
 static inline u64 cc_mkenc(u64 val)
 {
@@ -27,6 +29,14 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+
+static inline void *cc_decrypted_alloc(size_t size, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline void cc_decrypted_free(void *addr, size_t size) { }
+
 #endif
 
 #endif /* _ASM_X86_COCO_H */
-- 
2.25.1


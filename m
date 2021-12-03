Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED31467823
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380550AbhLCN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:27:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:65181 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhLCN1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:27:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="234479778"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="234479778"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 05:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460045259"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2021 05:23:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1F10F336; Fri,  3 Dec 2021 15:23:47 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, tony.luck@intel.com
Subject: [PATCHv2 3/3] x86: Move common memory encryption code to mem_encrypt.c
Date:   Fri,  3 Dec 2021 16:23:40 +0300
Message-Id: <20211203132340.41741-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
References: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEV and TDX both protect guest memory from the host access. They both
use guest physical address bits to communicate to the hardware which
pages receive protection or not. SEV and TDX both assume that all I/O
(real devices and virtio) must be performed to pages *without*
protection.

To add this support, AMD SEV code forces force_dma_unencrypted() to
decrypt DMA pages when DMA pages were allocated for I/O. It also uses
swiotlb_update_mem_attributes() to update decryption bits in SWIOTLB
DMA buffers.

Since TDX also uses a similar memory sharing design, all the above
mentioned changes can be reused. So move force_dma_unencrypted(),
SWIOTLB update code and virtio changes out of mem_encrypt_amd.c to
mem_encrypt.c.

Introduce a new config option X86_MEM_ENCRYPT that can be selected
by platforms which uses x86 memory encryption features (needed in both
AMD SEV and Intel TDX guest platforms).

Since the code is moved from mem_encrypt_amdc.c, inherit the same make
flags.

This is preparation for enabling TDX memory encryption support and it
has no functional changes.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig              | 10 +++--
 arch/x86/mm/Makefile          |  5 +++
 arch/x86/mm/mem_encrypt.c     | 84 +++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c | 69 ----------------------------
 4 files changed, 96 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..793e9b42ace0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1523,16 +1523,20 @@ config X86_CPA_STATISTICS
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
+config X86_MEM_ENCRYPT
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select DYNAMIC_PHYSICAL_MASK
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	def_bool n
+
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	select DMA_COHERENT_POOL
-	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
-	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
-	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	select ARCH_HAS_CC_PLATFORM
+	select X86_MEM_ENCRYPT
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c9c480641153..fe3d3061fc11 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
 KCOV_INSTRUMENT_tlb.o			:= n
+KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 
+KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 
@@ -12,6 +14,7 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KCSAN_SANITIZE := n
 
 ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
@@ -52,6 +55,8 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 
+obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
+
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
new file mode 100644
index 000000000000..50d209939c66
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Memory Encryption Support Common Code
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/dma-direct.h>
+#include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
+#include <linux/cc_platform.h>
+#include <linux/mem_encrypt.h>
+#include <linux/virtio_config.h>
+
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	/*
+	 * For SEV, all DMA must be to unencrypted addresses.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return true;
+
+	/*
+	 * For SME, all DMA must be to unencrypted addresses if the
+	 * device does not support DMA to addresses that include the
+	 * encryption mask.
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
+		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
+						dev->bus_dma_limit);
+
+		if (dma_dev_mask <= dma_enc_mask)
+			return true;
+	}
+
+	return false;
+}
+
+static void print_mem_encrypt_feature_info(void)
+{
+	pr_info("AMD Memory Encryption Features active:");
+
+	/* Secure Memory Encryption */
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/*
+		 * SME is mutually exclusive with any of the SEV
+		 * features below.
+		 */
+		pr_cont(" SME\n");
+		return;
+	}
+
+	/* Secure Encrypted Virtualization */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		pr_cont(" SEV");
+
+	/* Encrypted Register State */
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		pr_cont(" SEV-ES");
+
+	pr_cont("\n");
+}
+
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void)
+{
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		return;
+
+	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
+	swiotlb_update_mem_attributes();
+
+	print_mem_encrypt_feature_info();
+}
+
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index b520021a7e7b..2b2d018ea345 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -413,32 +413,6 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, boo
 	notify_range_enc_status_changed(vaddr, npages, enc);
 }
 
-/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
-bool force_dma_unencrypted(struct device *dev)
-{
-	/*
-	 * For SEV, all DMA must be to unencrypted addresses.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return true;
-
-	/*
-	 * For SME, all DMA must be to unencrypted addresses if the
-	 * device does not support DMA to addresses that include the
-	 * encryption mask.
-	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
-		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
-						dev->bus_dma_limit);
-
-		if (dma_dev_mask <= dma_enc_mask)
-			return true;
-	}
-
-	return false;
-}
-
 void __init mem_encrypt_free_decrypted_mem(void)
 {
 	unsigned long vaddr, vaddr_end, npages;
@@ -462,46 +436,3 @@ void __init mem_encrypt_free_decrypted_mem(void)
 
 	free_init_pages("unused decrypted", vaddr, vaddr_end);
 }
-
-static void print_mem_encrypt_feature_info(void)
-{
-	pr_info("AMD Memory Encryption Features active:");
-
-	/* Secure Memory Encryption */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		/*
-		 * SME is mutually exclusive with any of the SEV
-		 * features below.
-		 */
-		pr_cont(" SME\n");
-		return;
-	}
-
-	/* Secure Encrypted Virtualization */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		pr_cont(" SEV");
-
-	/* Encrypted Register State */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		pr_cont(" SEV-ES");
-
-	pr_cont("\n");
-}
-
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void)
-{
-	if (!sme_me_mask)
-		return;
-
-	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
-	swiotlb_update_mem_attributes();
-
-	print_mem_encrypt_feature_info();
-}
-
-int arch_has_restricted_virtio_memory_access(void)
-{
-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
-}
-EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
-- 
2.32.0


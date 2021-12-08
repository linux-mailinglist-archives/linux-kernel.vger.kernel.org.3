Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16EC46D893
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhLHQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:39:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhLHQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:39:03 -0500
Date:   Wed, 08 Dec 2021 16:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638981329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vj1oiRzY/t9Zl3sPMztzY9ph0vSZJvOka965wfViCMk=;
        b=EF6FDSY4+SOUbiH5vL/MUhiW9vdl+AYPgxUcax3nifbMr9p99BVnlTPhIvW4Yhu0cJqbjG
        DT3mVl6+jfUhTV5wOSiFriTOGsbYpxajG71LnNAd7nMchguh6fhBqQy8Ze5ubquXmMFD6t
        sN9Tmfaw7MTQh5sE46vRcLMe9C1hnI6n+lBjAI5Vv2uQGRo5vx2wGyjAn2M6lLhWxEnmi+
        9SOL2bdaJqg40ehpPhRthHyr5q9WphJ81DTmY+6h+4NvrgQdK6X8Qx/f0xkfSjaV+vUReR
        gKAbvli1NB9jCTQ9IZtNE/CEMpOW7oZlu2Beb9V/TqQV+qzC/bx5GH1uW4zRSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638981329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vj1oiRzY/t9Zl3sPMztzY9ph0vSZJvOka965wfViCMk=;
        b=OZCUkryqqq6tvMMo3jyjLEYK0anpfGt4m4teK07aTTgSH5qmBlt8h1W7pnruqqOnaz9yht
        yq0+BnKzfBnMLuCA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move common memory encryption code to mem_encrypt.c
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206135505.75045-4-kirill.shutemov@linux.intel.com>
References: <20211206135505.75045-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163898132846.11128.423204816178824619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     20f07a044a76aebaaa0603038857229b5c460d69
Gitweb:        https://git.kernel.org/tip/20f07a044a76aebaaa0603038857229b5c460d69
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 06 Dec 2021 16:55:05 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 16:49:53 +01:00

x86/sev: Move common memory encryption code to mem_encrypt.c

SEV and TDX both protect guest memory from host accesses. They both use
guest physical address bits to communicate to the hardware which pages
receive protection or not. SEV and TDX both assume that all I/O (real
devices and virtio) must be performed to pages *without* protection.

To add this support, AMD SEV code forces force_dma_unencrypted() to
decrypt DMA pages when DMA pages were allocated for I/O. It also uses
swiotlb_update_mem_attributes() to update decryption bits in SWIOTLB DMA
buffers.

Since TDX also uses a similar memory sharing design, all the above
mentioned changes can be reused. So move force_dma_unencrypted(),
SWIOTLB update code and virtio changes out of mem_encrypt_amd.c to
mem_encrypt.c.

Introduce a new config option X86_MEM_ENCRYPT that can be selected by
platforms which use x86 memory encryption features (needed in both AMD
SEV and Intel TDX guest platforms).

Since the code is moved from mem_encrypt_amd.c, inherit the same make
flags.

This is preparation for enabling TDX memory encryption support and it
has no functional changes.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20211206135505.75045-4-kirill.shutemov@linux.intel.com
---
 arch/x86/Kconfig              | 10 ++--
 arch/x86/mm/Makefile          |  5 ++-
 arch/x86/mm/mem_encrypt.c     | 84 ++++++++++++++++++++++++++++++++++-
 arch/x86/mm/mem_encrypt_amd.c | 69 +----------------------------
 4 files changed, 96 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee..793e9b4 100644
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
index c9c4806..fe3d306 100644
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
index 0000000..50d2099
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
index b520021..2b2d018 100644
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

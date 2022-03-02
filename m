Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622A4CA822
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbiCBOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiCBO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7BE54BF2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231304; x=1677767304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oHHgD0lUC3RUOg4gi3hYg1dWt0msOj5EGIqW9IbsbN8=;
  b=VO4cbiKY7ngpM+gghHxh8G2Uo6dWXVdwY86ZBsmnkmnsU6p04ogRy6Lo
   yyUxm+U7FWmrQyLLilfgmwb2fIS3bpS2Aq5HNwbNTJcKsVuZIBzPEqlXd
   ilbYnuvNk+FlDCsNIXgihsrYQxCKTtyVvAldLBpKA3Ie8Jyy2sPTyZPsU
   yyxEP4bByDGONuASsUV3PZtSRNbO03qDK+zp/q52aEU8TfJtOkH2d9aUq
   PZeY4+MmFLE0fyo6MG4dBIkaE3iaulhdNx5LUO/erIM/vEFj16SkCURq2
   K4AzTQFnySyJJNMtUE36PZ14qPVCu+b6NJ6UJ+k7vJnmcgTrYNOQKdPkv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253336398"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253336398"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="493553211"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2022 06:28:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 275A860E; Wed,  2 Mar 2022 16:28:13 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 27/30] x86/kvm: Use bounce buffers for TD guest
Date:   Wed,  2 Mar 2022 17:28:03 +0300
Message-Id: <20220302142806.51844-28-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel TDX doesn't allow VMM to directly access guest private memory.
Any memory that is required for communication with the VMM must be
shared explicitly. The same rule applies for any DMA to and from the
TDX guest. All DMA pages have to be marked as shared pages. A generic way
to achieve this without any changes to device drivers is to use the
SWIOTLB framework.

Force SWIOTLB on TD guest and make SWIOTLB buffer shared by generalizing
mem_encrypt_init() to cover TDX.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                   | 2 +-
 arch/x86/coco/core.c               | 1 +
 arch/x86/coco/tdx.c                | 3 +++
 arch/x86/include/asm/mem_encrypt.h | 6 +++---
 arch/x86/mm/mem_encrypt.c          | 9 ++++++++-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 98efb35ed7b1..1312cefb927d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -885,7 +885,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
-	select DYNAMIC_PHYSICAL_MASK
+	select X86_MEM_ENCRYPT
 	select X86_MCE
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 9778cf4c6901..b10326f91d4f 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -22,6 +22,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 2168ee25a52c..429a1ba42667 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/swiotlb.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -627,5 +628,7 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required = tdx_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index e2c6f433ed10..88ceaf3648b3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -49,9 +49,6 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void __init sev_es_init_vc_handling(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -89,6 +86,9 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void);
+
 /*
  * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
  * writing to or comparing values from the cr3 register.  Having the
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..10ee40b5204b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -42,7 +42,14 @@ bool force_dma_unencrypted(struct device *dev)
 
 static void print_mem_encrypt_feature_info(void)
 {
-	pr_info("AMD Memory Encryption Features active:");
+	pr_info("Memory Encryption Features active:");
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		pr_cont(" Intel TDX\n");
+		return;
+	}
+
+	pr_cont("AMD ");
 
 	/* Secure Memory Encryption */
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABE44FA12D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbiDIB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiDIB33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7E167F0;
        Fri,  8 Apr 2022 18:27:23 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mH8By/GgdgGyUkiWYBFEyRc3L7rPagI/PKIHVgpre8s=;
        b=UqqkMLVKoOUkJEccfxhxs4v/SOmnSZwEfwZe46zDdTuxTt4L3heSRXxfylwU3UQWYl4vYI
        tJdzzlaH+W/tc47QTe2inEfqDDZgWMUYh55bJ7ISiCYB4wpaXsNweqkxI7L77+zmC3BVZV
        4rT1041KotpMe6tabtI/2fmoe01vJebcHSmLlHBl+EjEFYEbm1ejBka+elTAiPMcz1w7x8
        l7YyxJqDtyx7Z8vwp0a+mvfjyC00bfj/CdSmLIeXvglwG2hBg4TYLF7Ex7zxNad9IxDYE1
        TbSHfAMbw94phT3N3Sbw5m/BQ2Wm5zW8mYThPXEQApUfC/k3jGHOpp7MojmXdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mH8By/GgdgGyUkiWYBFEyRc3L7rPagI/PKIHVgpre8s=;
        b=k5FocexBd60A8qJPy/QcLrbfc04QXF2CClt3uJXfiu19xf58Aiob9XM8tN5is9uBf8MU6u
        3aA6EDx1b40+tIAQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/mm: Make DMA memory shared for TD guest
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-28-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-28-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764066.4207.16794288838350034935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     968b493173ac5205fe75f6330ee767f96bf88e57
Gitweb:        https://git.kernel.org/tip/968b493173ac5205fe75f6330ee767f96bf88e57
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:36 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:53 -07:00

x86/mm: Make DMA memory shared for TD guest

Intel TDX doesn't allow VMM to directly access guest private memory.
Any memory that is required for communication with the VMM must be
shared explicitly. The same rule applies for any DMA to and from the
TDX guest. All DMA pages have to be marked as shared pages. A generic way
to achieve this without any changes to device drivers is to use the
SWIOTLB framework.

The previous patch ("Add support for TDX shared memory") gave TDX guests
the _ability_ to make some pages shared, but did not make any pages
shared. This actually marks SWIOTLB buffers *as* shared.

Start returning true for cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) in
TDX guests.  This has several implications:

 - Allows the existing mem_encrypt_init() to be used for TDX which
   sets SWIOTLB buffers shared (aka. "decrypted").
 - Ensures that all DMA is routed via the SWIOTLB mechanism (see
   pci_swiotlb_detect())

Stop selecting DYNAMIC_PHYSICAL_MASK directly. It will get set
indirectly by selecting X86_MEM_ENCRYPT.

mem_encrypt_init() is currently under an AMD-specific #ifdef. Move it to
a generic area of the header.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-28-kirill.shutemov@linux.intel.com
---
 arch/x86/Kconfig                   |  2 +-
 arch/x86/coco/core.c               |  1 +
 arch/x86/include/asm/mem_encrypt.h |  6 +++---
 arch/x86/mm/mem_encrypt.c          |  9 ++++++++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a181855..7021ec7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -883,7 +883,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
-	select DYNAMIC_PHYSICAL_MASK
+	select X86_MEM_ENCRYPT
 	select X86_MCE
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 9f74125..4320fad 100644
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
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index e2c6f43..88ceaf3 100644
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
index 50d2099..10ee40b 100644
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

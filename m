Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A0469794
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbhLFN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:58:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:4560 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244924AbhLFN6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:58:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="217339891"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="217339891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="461817320"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 05:55:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id F1FF5B8; Mon,  6 Dec 2021 15:55:16 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, hpa@zytor.com,
        jroedel@suse.de, knsathya@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 1/3] x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
Date:   Mon,  6 Dec 2021 16:55:03 +0300
Message-Id: <20211206135505.75045-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206135505.75045-1-kirill.shutemov@linux.intel.com>
References: <20211206135505.75045-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

INS/OUTS are not supported in TDX guests and cause #UD. Kernel has to
avoid them when running in TDX guest. To support existing usage, string
I/O operations are unrolled using IN/OUT instructions.

AMD SEV platform implements this support by adding unroll logic in
ins#bwl()/outs#bwl() macros with SEV specific checks. Since TDX VM
guests will also need similar support, use CC_ATTR_GUEST_UNROLL_STRING_IO
and generic cc_platform_has() API to implement it.

String I/O helpers were the last users of sev_key_active() interface and
sev_enable_key static key. Remove them.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/io.h     | 20 +++-----------------
 arch/x86/kernel/cc_platform.c |  4 ++++
 arch/x86/mm/mem_encrypt.c     | 10 ----------
 include/linux/cc_platform.h   | 11 +++++++++++
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 5c6a4af0b911..f6d91ecb8026 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -40,6 +40,7 @@
 
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/cc_platform.h>
 #include <asm/page.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
@@ -256,21 +257,6 @@ static inline void slow_down_io(void)
 
 #endif
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-#include <linux/jump_label.h>
-
-extern struct static_key_false sev_enable_key;
-static inline bool sev_key_active(void)
-{
-	return static_branch_unlikely(&sev_enable_key);
-}
-
-#else /* !CONFIG_AMD_MEM_ENCRYPT */
-
-static inline bool sev_key_active(void) { return false; }
-
-#endif /* CONFIG_AMD_MEM_ENCRYPT */
-
 #define BUILDIO(bwl, bw, type)						\
 static inline void out##bwl(unsigned type value, int port)		\
 {									\
@@ -301,7 +287,7 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -317,7 +303,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..cc1ffe710dd2 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -50,6 +50,10 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
+			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 35487305d8af..b520021a7e7b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -43,8 +43,6 @@ u64 sme_me_mask __section(".data") = 0;
 u64 sev_status __section(".data") = 0;
 u64 sev_check_data __section(".data") = 0;
 EXPORT_SYMBOL(sme_me_mask);
-DEFINE_STATIC_KEY_FALSE(sev_enable_key);
-EXPORT_SYMBOL_GPL(sev_enable_key);
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
@@ -499,14 +497,6 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
-	/*
-	 * With SEV, we need to unroll the rep string I/O instructions,
-	 * but SEV-ES supports them through the #VC handler.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
-	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		static_branch_enable(&sev_enable_key);
-
 	print_mem_encrypt_feature_info();
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index a075b70b9a70..f47f0c9edb3b 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,17 @@ enum cc_attr {
 	 * Examples include SEV-ES.
 	 */
 	CC_ATTR_GUEST_STATE_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_UNROLL_STRING_IO: String I/O is implemented with
+	 *                                  IN/OUT instructions
+	 *
+	 * The platform/OS is running as a guest/virtual machine and uses
+	 * IN/OUT instructions in place of string I/O.
+	 *
+	 * Examples include TDX Guest & SEV.
+	 */
+	CC_ATTR_GUEST_UNROLL_STRING_IO,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.32.0


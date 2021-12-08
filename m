Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E1246D894
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhLHQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:39:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhLHQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:39:04 -0500
Date:   Wed, 08 Dec 2021 16:35:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638981331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf+xPTd7peUuw61zuB1zK9aTbXps6sWB9Ko/E8HB/AU=;
        b=uBBpMc+7dvoDJsPGEp1E+UKGUBQpisUKaq7NCR3tynT4puxa9EeLf00x/d66KM/OTkfhDj
        NMIVnl0whbyOGmAEE1jRL0P9ydqU+8KzgICLG5mT+MfHYrPJ3MSP6OBA3Uz1ZkxbkYOkEW
        Zqc8jwjtfJ6XCGWuPz6wiHsMEwUg1ypz7tKw3nR3SgG0PzecGW8dIKFaF2cGiYZU7eVHz6
        zWdz7Ql4oClv3/RCLNYM/T41FkSGGHBUToP68NNltKnkGkM+Hulz7W08704HXwqcDQ6xk7
        gHD1idKzOMbX32ZQnglUD8HOfDtpid0/uTkSDPBaQVRFFyOLfu6rCNPwI4jc4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638981331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf+xPTd7peUuw61zuB1zK9aTbXps6sWB9Ko/E8HB/AU=;
        b=QXwWTkNhsmXRAAqbHARZUtVy7JXILcloXzcRjSDUYXHljfdkuPg6Hbc8lOmKLeGc6GLenK
        1hNS1NMloCrBzkBA==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206135505.75045-2-kirill.shutemov@linux.intel.com>
References: <20211206135505.75045-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163898133021.11128.8153755611044440687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8260b9820f7050461b8969305bbd8cb5654f0c74
Gitweb:        https://git.kernel.org/tip/8260b9820f7050461b8969305bbd8cb5654f0c74
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Mon, 06 Dec 2021 16:55:03 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 16:49:42 +01:00

x86/sev: Use CC_ATTR attribute to generalize string I/O unroll

INS/OUTS are not supported in TDX guests and cause #UD. Kernel has to
avoid them when running in TDX guest. To support existing usage, string
I/O operations are unrolled using IN/OUT instructions.

AMD SEV platform implements this support by adding unroll
logic in ins#bwl()/outs#bwl() macros with SEV-specific checks.
Since TDX VM guests will also need similar support, use
CC_ATTR_GUEST_UNROLL_STRING_IO and generic cc_platform_has() API to
implement it.

String I/O helpers were the last users of sev_key_active() interface and
sev_enable_key static key. Remove them.

 [ bp: Move comment too and do not delete it. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20211206135505.75045-2-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/io.h     | 20 +++-----------------
 arch/x86/kernel/cc_platform.c |  8 ++++++++
 arch/x86/mm/mem_encrypt.c     | 10 ----------
 include/linux/cc_platform.h   | 11 +++++++++++
 4 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 5c6a4af..f6d91ec 100644
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
index 03bb2f3..8a25b1c 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -50,6 +50,14 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	/*
+	 * With SEV, the rep string I/O instructions need to be unrolled
+	 * but SEV-ES supports them through the #VC handler.
+	 */
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
+			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 3548730..b520021 100644
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
index a075b70..efd8205 100644
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
+	 * Examples include TDX guest & SEV.
+	 */
+	CC_ATTR_GUEST_UNROLL_STRING_IO,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM

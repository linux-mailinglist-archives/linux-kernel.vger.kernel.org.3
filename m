Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2564C2B58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiBXMAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiBXL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:59:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543074BB82;
        Thu, 24 Feb 2022 03:59:28 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645703967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JE7Ghh5zlytmsNhJLRZ/a/5kAOeYJoi3iws0J8szmE=;
        b=dBsmeOyDRjS0yirDzLcasPShqqGRZRmxwI62GKPPhnU6p34CeKALJ2wIwNkbzh+9g9opRC
        VHSplT4PRG6YmibhTkk4/n835ye7H01wvuKSC8F7g+vlnjq5ZyOZ+IKinHAAvSUHjWMe18
        D/9M7wpS7fEfNr1qZBscOZSTo70FNaplkSMLU2QKiniu79Oe055b4N/Snami5AP40UzCdP
        0HSc0NT6OP6YN7d2XXMqksQZP8hk6m7L1njU/OpHzpgD18LuJLKS5vYRJlAcEmIWPLZ+j3
        VMOpcDFOsaBzB4+qsrGjS9AwMbJZIDz+0IGvf13xnWJVau9jcmYOWF7/ZmZfIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645703967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JE7Ghh5zlytmsNhJLRZ/a/5kAOeYJoi3iws0J8szmE=;
        b=V42AwmR/bf3D4JDNi82njmCGVHCamgCu4NP4b30hPxWDKxC0mvyTXVtnzdSva0d+JLB2om
        QY7kbzEzbBoAsYBA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/cc: Move arch/x86/{kernel/cc_platform.c => coco/core.c}
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220222185740.26228-3-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164570396597.16921.13479978665917270861.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     6198311093dabcafbe345d580c56b5d5a9ab5f3c
Gitweb:        https://git.kernel.org/tip/6198311093dabcafbe345d580c56b5d5a9ab5f3c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 22 Feb 2022 21:57:38 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Feb 2022 18:25:58 +01:00

x86/cc: Move arch/x86/{kernel/cc_platform.c => coco/core.c}

Move cc_platform.c to arch/x86/coco/. The directory is going to be the
home space for code related to confidential computing.

Intel TDX code will land here. AMD SEV code will also eventually be
moved there.

No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20220222185740.26228-3-kirill.shutemov@linux.intel.com
---
 arch/x86/Kbuild               |  2 +-
 arch/x86/coco/Makefile        |  6 ++-
 arch/x86/coco/core.c          | 85 ++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/Makefile      |  5 +--
 arch/x86/kernel/cc_platform.c | 85 +----------------------------------
 5 files changed, 93 insertions(+), 90 deletions(-)
 create mode 100644 arch/x86/coco/Makefile
 create mode 100644 arch/x86/coco/core.c
 delete mode 100644 arch/x86/kernel/cc_platform.c

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f384cb1..5a83da7 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
+
 obj-y += entry/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
new file mode 100644
index 0000000..c1ead00
--- /dev/null
+++ b/arch/x86/coco/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS_REMOVE_core.o	= -pg
+KASAN_SANITIZE_core.o	:= n
+CFLAGS_core.o		+= -fno-stack-protector
+
+obj-y += core.o
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
new file mode 100644
index 0000000..6a6ffcd
--- /dev/null
+++ b/arch/x86/coco/core.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/export.h>
+#include <linux/cc_platform.h>
+#include <linux/mem_encrypt.h>
+
+#include <asm/mshyperv.h>
+#include <asm/processor.h>
+
+static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_INTEL_TDX_GUEST
+	return false;
+#else
+	return false;
+#endif
+}
+
+/*
+ * SME and SEV are very similar but they are not the same, so there are
+ * times that the kernel will need to distinguish between SME and SEV. The
+ * cc_platform_has() function is used for this.  When a distinction isn't
+ * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
+ *
+ * The trampoline code is a good example for this requirement.  Before
+ * paging is activated, SME will access all memory as decrypted, but SEV
+ * will access all memory as encrypted.  So, when APs are being brought
+ * up under SME the trampoline area cannot be encrypted, whereas under SEV
+ * the trampoline area must be encrypted.
+ */
+static bool amd_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return sme_me_mask;
+
+	case CC_ATTR_HOST_MEM_ENCRYPT:
+		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
+
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+		return sev_status & MSR_AMD64_SEV_ENABLED;
+
+	case CC_ATTR_GUEST_STATE_ENCRYPT:
+		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+
+	/*
+	 * With SEV, the rep string I/O instructions need to be unrolled
+	 * but SEV-ES supports them through the #VC handler.
+	 */
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
+			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
+
+	default:
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
+}
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	if (sme_me_mask)
+		return amd_cc_platform_has(attr);
+
+	if (hv_is_isolation_supported())
+		return hyperv_cc_platform_has(attr);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6aef9ee..6462e3d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -21,7 +21,6 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
-CFLAGS_REMOVE_cc_platform.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -30,7 +29,6 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 KASAN_SANITIZE_sev.o					:= n
-KASAN_SANITIZE_cc_platform.o				:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -49,7 +47,6 @@ endif
 KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
-CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
@@ -151,8 +148,6 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
-obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
-
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
deleted file mode 100644
index 6a6ffcd..0000000
--- a/arch/x86/kernel/cc_platform.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Confidential Computing Platform Capability checks
- *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
- *
- * Author: Tom Lendacky <thomas.lendacky@amd.com>
- */
-
-#include <linux/export.h>
-#include <linux/cc_platform.h>
-#include <linux/mem_encrypt.h>
-
-#include <asm/mshyperv.h>
-#include <asm/processor.h>
-
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
-{
-#ifdef CONFIG_INTEL_TDX_GUEST
-	return false;
-#else
-	return false;
-#endif
-}
-
-/*
- * SME and SEV are very similar but they are not the same, so there are
- * times that the kernel will need to distinguish between SME and SEV. The
- * cc_platform_has() function is used for this.  When a distinction isn't
- * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
- *
- * The trampoline code is a good example for this requirement.  Before
- * paging is activated, SME will access all memory as decrypted, but SEV
- * will access all memory as encrypted.  So, when APs are being brought
- * up under SME the trampoline area cannot be encrypted, whereas under SEV
- * the trampoline area must be encrypted.
- */
-static bool amd_cc_platform_has(enum cc_attr attr)
-{
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	switch (attr) {
-	case CC_ATTR_MEM_ENCRYPT:
-		return sme_me_mask;
-
-	case CC_ATTR_HOST_MEM_ENCRYPT:
-		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
-
-	case CC_ATTR_GUEST_MEM_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ENABLED;
-
-	case CC_ATTR_GUEST_STATE_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
-
-	/*
-	 * With SEV, the rep string I/O instructions need to be unrolled
-	 * but SEV-ES supports them through the #VC handler.
-	 */
-	case CC_ATTR_GUEST_UNROLL_STRING_IO:
-		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
-			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
-
-	default:
-		return false;
-	}
-#else
-	return false;
-#endif
-}
-
-static bool hyperv_cc_platform_has(enum cc_attr attr)
-{
-	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
-}
-
-bool cc_platform_has(enum cc_attr attr)
-{
-	if (sme_me_mask)
-		return amd_cc_platform_has(attr);
-
-	if (hv_is_isolation_supported())
-		return hyperv_cc_platform_has(attr);
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(cc_platform_has);

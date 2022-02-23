Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC784C1BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbiBWTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiBWTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:17:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFC434A1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:17:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64AF51EC054C;
        Wed, 23 Feb 2022 20:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645643837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eiu0qtxpMlfrYj7hsSK9fYM12M1/UoaX3hNeIuhO6V0=;
        b=IrByzyFLwTRiKgcL355GYJlrDx4F4DF6NY3R0sI7OwbptUs+6SQ8gEYkbDb9uSnD1rZ/zq
        LYkTtNeLZcbdwuQrjdtpBjLXKf0N9t0cUE2DEd5k3ZpVtIrUrfLsgUopU+XZ3uSysG7/1M
        C0ajqiXjb/xqXdXgsqRVzpARSDx5D1k=
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com
Subject: [PATCH 2/4] x86/coco: Explicitly declare type of confidential computing platform
Date:   Wed, 23 Feb 2022 20:17:21 +0100
Message-Id: <20220223191723.22937-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YhaGuEgG9+UlGwIU@zn.tnic>
References: <YhaGuEgG9+UlGwIU@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The kernel derives the confidential computing platform
type it is running as from sme_me_mask on AMD or by using
hv_is_isolation_supported() on HyperV isolation VMs. This detection
process will be more complicated as more platforms get added.

Declare a confidential computing vendor variable explicitly and set it
via cc_set_vendor() on the respective platform.

  [ bp: Massage commit message, fixup HyperV check. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20220222185740.26228-4-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/core.c               | 29 +++++++++++++++++------------
 arch/x86/include/asm/coco.h        | 14 ++++++++++++++
 arch/x86/kernel/cpu/mshyperv.c     |  6 ++++++
 arch/x86/mm/mem_encrypt_identity.c | 11 +++++++----
 4 files changed, 44 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/include/asm/coco.h

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 6a6ffcd978f6..476dcd198af5 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -9,18 +9,15 @@
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
-#include <linux/mem_encrypt.h>
 
-#include <asm/mshyperv.h>
+#include <asm/coco.h>
 #include <asm/processor.h>
 
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+static enum cc_vendor vendor __ro_after_init;
+
+static bool intel_cc_platform_has(enum cc_attr attr)
 {
-#ifdef CONFIG_INTEL_TDX_GUEST
-	return false;
-#else
 	return false;
-#endif
 }
 
 /*
@@ -74,12 +71,20 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	if (sme_me_mask)
+	switch (vendor) {
+	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
-
-	if (hv_is_isolation_supported())
+	case CC_VENDOR_INTEL:
+		return intel_cc_platform_has(attr);
+	case CC_VENDOR_HYPERV:
 		return hyperv_cc_platform_has(attr);
-
-	return false;
+	default:
+		return false;
+	}
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
+
+__init void cc_set_vendor(enum cc_vendor v)
+{
+	vendor = v;
+}
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
new file mode 100644
index 000000000000..e49f9ddb6ae6
--- /dev/null
+++ b/arch/x86/include/asm/coco.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_COCO_H
+#define _ASM_X86_COCO_H
+
+enum cc_vendor {
+	CC_VENDOR_NONE,
+	CC_VENDOR_AMD,
+	CC_VENDOR_HYPERV,
+	CC_VENDOR_INTEL,
+};
+
+void cc_set_vendor(enum cc_vendor v);
+
+#endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..e0a572472052 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,6 +33,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/coco.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -344,6 +345,11 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
+		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
+		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+				cc_set_vendor(CC_VENDOR_HYPERV);
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 3f0abb403340..06314ae3998e 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -44,6 +44,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
+#include <asm/coco.h>
 
 #include "mm_internal.h"
 
@@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
-		physical_mask &= ~sme_me_mask;
-		return;
+		goto out;
 	}
 
 	/*
@@ -600,6 +600,9 @@ void __init sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
-
-	physical_mask &= ~sme_me_mask;
+out:
+	if (sme_me_mask) {
+		physical_mask &= ~sme_me_mask;
+		cc_set_vendor(CC_VENDOR_AMD);
+	}
 }
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505B4C01BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiBVS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiBVS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:58:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E9EBD2DB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556259; x=1677092259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iqtVod6gdoeQwYMqOAiSSDILP+NKKWVVo+oPlRWZhX0=;
  b=FeXB8dh0gj28eIBxzeGkDP5DntUoK6cWlGlIQM0x0hxCt8KtEadbmNwg
   to/uMuXN1iWSvDJl/w8oN1L0MOXWHmto32env0uLwCqhyKEyI/KnjSiqI
   Iyv1hbVQGFL1O38lsbfhLTyiH+Vg8QG4//9Pn/gs+ewu/SbplWRh3yiQw
   96kFll7RyTc+02/5DR6GIN59k+oqOO8SA1/GNdFTfXeDbRbJzsJduZ5n/
   AAhIbH9lmFUhloFzUKtt+4fYgmCQEupPTILP9ATbVAnkuC/qST65UHy7U
   7X+EtSuSK588lOCnKAyvph9XcrVNnRho9ao+nwZL9ZFh/okueDMtvy3xE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239169227"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="239169227"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="637120618"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2022 10:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5C0B32FC; Tue, 22 Feb 2022 20:57:51 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 3/4] x86/coco: Explicitly declare type of confidential computing platform
Date:   Tue, 22 Feb 2022 21:57:39 +0300
Message-Id: <20220222185740.26228-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel derives type of confidential computing platform from sme_me_mask
value and hv_is_isolation_supported(). This detection process will be
more complicated as more platforms get added.

Declare confidential computing vendor explicitly via cc_set_vendor().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c               | 29 +++++++++++++++++------------
 arch/x86/include/asm/coco.h        | 14 ++++++++++++++
 arch/x86/kernel/cpu/mshyperv.c     |  3 +++
 arch/x86/mm/mem_encrypt_identity.c | 11 +++++++----
 4 files changed, 41 insertions(+), 16 deletions(-)
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
index 5a99f993e639..c1c0123859b9 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,6 +33,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/coco.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
+		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+			cc_set_vendor(CC_VENDOR_HYPERV);
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
2.34.1


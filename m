Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93A74BBD48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiBRQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiBRQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB85BD32
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201049; x=1676737049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYJiKqiei5l8IugEyJEhJTuFV5O+lhV/kCOqE+xav4o=;
  b=ZGgxgdh+hCHqEexLxulO80/9aa2VaBYmC7y2nz+dT0JsYTcydTJ8Vbzy
   JDi08U7jHQFYJBn3xAKzG9NAVKxAVKPdMYW/kkTYIMwPUUZ0IT2pgBXp6
   vRIh1sqU4X3lgjFGq/guxrMmsWQhEQZRd1Uj2663mqHvuBLdqta8XCOw1
   JHX7oN3ax70HR4cGoFZH0js5Gqw2NMuUOetE5hHLMtqIhQ++R1C8qKpN4
   wbeEFaVAJzPDCJYbKnaOVxelC9j7gGZt23UGbn7kvuQGhEuwpAGCP8GZ7
   weLpCptJQcKFOLtPQz7LOwA+dXeuyQIgf6xlCOmrRHaetazDA/WC9pN8P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231791745"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231791745"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="489549275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7F770F23; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 29/32] x86/kvm: Use bounce buffers for TD guest
Date:   Fri, 18 Feb 2022 19:17:15 +0300
Message-Id: <20220218161718.67148-30-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/x86/Kconfig              | 2 +-
 arch/x86/coco/tdx.c           | 3 +++
 arch/x86/kernel/cc_platform.c | 1 +
 arch/x86/mm/mem_encrypt.c     | 9 ++++++++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3701e13e319c..fb2706f7f04a 100644
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
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 5a833569acb8..8a7826fe49e3 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/swiotlb.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -594,5 +595,7 @@ void __init tdx_early_init(void)
 
 	x86_platform.cc = &tdx_cc_runtime;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index fac4d588d3b3..12a34e80ef50 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -22,6 +22,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
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


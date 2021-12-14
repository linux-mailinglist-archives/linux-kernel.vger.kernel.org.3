Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC94745D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhLNPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:25418 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235169AbhLNPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263135022"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="263135022"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="754837229"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2021 07:03:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 46D6AEBD; Tue, 14 Dec 2021 17:03:10 +0200 (EET)
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
Subject: [PATCH 22/26] x86/kvm: Use bounce buffers for TD guest
Date:   Tue, 14 Dec 2021 18:03:00 +0300
Message-Id: <20211214150304.62613-23-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/kernel/cc_platform.c | 1 +
 arch/x86/kernel/tdx.c         | 3 +++
 arch/x86/mm/mem_encrypt.c     | 9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 4a3064bf1eb5..013224679b98 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -21,6 +21,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_TDX:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 9ef3cf0879d3..2175336d1a2a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/swiotlb.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
@@ -575,5 +576,7 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= GENMASK_ULL(td_info.gpa_width - 2, 0);
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 8b9de7e478c6..3a4230226388 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -69,7 +69,14 @@ bool force_dma_unencrypted(struct device *dev)
 
 static void print_mem_encrypt_feature_info(void)
 {
-	pr_info("AMD Memory Encryption Features active:");
+	pr_info("Memory Encryption Features active:");
+
+	if (is_tdx_guest()) {
+		pr_cont(" Intel TDX\n");
+		return;
+	}
+
+	pr_cont("AMD ");
 
 	/* Secure Memory Encryption */
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.32.0


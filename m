Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ABA4982FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbiAXPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:04:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:23292 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243272AbiAXPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036576; x=1674572576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qp+xpLoEv3ZzqsbcA1kKKaSYMc1Xo1lK2tI+kDEsRVU=;
  b=gEZ+YAyxQlVPkxyyWZqfzcGhzhUA55XhYSd7sx+e/k60Hj8D5lxBqWiM
   aZ+emwISk/xhNF170i2pqn9RnBwqQv2hVa9RxGnPORNNbx3pYy04eGLHu
   forn5y+q4PLd811rnXkBaH0N/WaPFhcIrm4M1sRuGSxnocDvQiGzZk4aB
   Wrvf9xHwfA3tbjcDaFd7wU9DcNwnp6cSQsBepW+nE+AOeGU81Mn0flLzM
   64ro/uo6pf+sIswbZVJ2DiO8XnGtrYVeeyughfAZ24PHImQqR2XmMLBtS
   jkINqvfn3+iqcMdHaO/qRPtKry+Cq/LX2TGZce+ypRpva4TO/YKijA1he
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306776628"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306776628"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580395692"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2022 07:02:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 83825D66; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
Subject: [PATCHv2 25/29] x86/kvm: Use bounce buffers for TD guest
Date:   Mon, 24 Jan 2022 18:02:11 +0300
Message-Id: <20220124150215.36893-26-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
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
index 1fbcf19fa20d..62c89c077cdd 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -23,6 +23,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_TDX:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ea638c6ecb92..6048887ac846 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/swiotlb.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
@@ -581,5 +582,7 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= GENMASK_ULL(td_info.gpa_width - 2, 0);
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..194ace3a748a 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -42,7 +42,14 @@ bool force_dma_unencrypted(struct device *dev)
 
 static void print_mem_encrypt_feature_info(void)
 {
-	pr_info("AMD Memory Encryption Features active:");
+	pr_info("Memory Encryption Features active:");
+
+	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
+		pr_cont(" Intel TDX\n");
+		return;
+	}
+
+	pr_cont("AMD ");
 
 	/* Secure Memory Encryption */
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.34.1


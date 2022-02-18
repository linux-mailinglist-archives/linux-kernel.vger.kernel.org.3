Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9374BBD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiBRQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiBRQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C6C5BD0B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201049; x=1676737049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XR/MZK0Sw7yFSIFNsgIwhfoe9aLXm/dh7OnqAbdmwdk=;
  b=MWLt9+vAQ1C23vQwE1c3Gg95sUeqreY6kbfXySU3KcD7I/nyVmoKx874
   YInWrUvIRBb3pN5zebvmprZ1KtnrZEeUSQLcsiOy7opoaPM5x2jG2J84L
   1YJ0V5FYxuJHg7HJPTQsxVZRSiMB/AI2zIswA9HUnMLw54jBSUhZS3fvh
   p3nWU0KMHpeYe5UsKmpQ1YwBZPytB/qKd2Pa5OpQqxjy+HeGczIloEEuJ
   7l1IBeble6UGyb7T52nN7XpLMiBpnjEqzYhAQfzeuhI8R9ShigqC2w7pV
   xzwHYwd0ouU0so0JAffVPd54IIE0jpi7bcsje7iCEiBsucx1jHx16ytlA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231791738"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231791738"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="489549270"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 71BCBED7; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
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
Subject: [PATCHv3 28/32] x86/mm/cpa: Add support for TDX shared memory
Date:   Fri, 18 Feb 2022 19:17:14 +0300
Message-Id: <20220218161718.67148-29-kirill.shutemov@linux.intel.com>
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

Intel TDX protects guest memory from VMM access. Any memory that is
required for communication with the VMM must be explicitly shared.

It is a two-step process: the guest sets the shared bit in the page
table entry and notifies VMM about the change. The notification happens
using MapGPA hypercall.

Conversion back to private memory requires clearing the shared bit,
notifying VMM with MapGPA hypercall following with accepting the memory
with AcceptPage hypercall.

Provide a TDX version of x86_platform.cc callbacks. It makes
__set_memory_enc_pgtable() work right in TDX guest.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx.c           | 108 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cc_platform.c |   1 +
 2 files changed, 109 insertions(+)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index f73983f3ffc4..5a833569acb8 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -10,10 +10,15 @@
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/x86_init.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_ACCEPT_PAGE			6
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -456,6 +461,107 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	return ret;
 }
 
+static bool tdx_tlb_flush_required(bool enc)
+{
+	/*
+	 * TDX guest is responsible for flushing caches on private->shared
+	 * transition. VMM is responsible for flushing on shared->private.
+	 */
+	return !enc;
+}
+
+static bool tdx_cache_flush_required(void)
+{
+	return true;
+}
+
+static bool accept_page(phys_addr_t gpa, enum pg_level pg_level)
+{
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 of GPA encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 */
+	switch (pg_level) {
+	case PG_LEVEL_4K:
+		break;
+	case PG_LEVEL_2M:
+		gpa |= 1;
+		break;
+	case PG_LEVEL_1G:
+		gpa |= 2;
+		break;
+	default:
+		return false;
+	}
+
+	return !__tdx_module_call(TDX_ACCEPT_PAGE, gpa, 0, 0, 0, NULL);
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static int tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (end <= start)
+		return -EINVAL;
+
+	if (!enc) {
+		start = cc_mkenc(start);
+		end = cc_mkenc(end);
+	}
+
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * section "TDG.VP.VMCALL<MapGPA>"
+	 */
+	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+		return -EIO;
+
+	/* private->shared conversion  requires only MapGPA call */
+	if (!enc)
+		return 0;
+
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		/* Try if 1G page accept is possible */
+		if (!(start & ~PUD_MASK) && end - start >= PUD_SIZE &&
+		    accept_page(start, PG_LEVEL_1G)) {
+			start += PUD_SIZE;
+			continue;
+		}
+
+		/* Try if 2M page accept is possible */
+		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
+		    accept_page(start, PG_LEVEL_2M)) {
+			start += PMD_SIZE;
+			continue;
+		}
+
+		if (!accept_page(start, PG_LEVEL_4K))
+			return -EIO;
+		start += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+static const struct x86_cc_runtime tdx_cc_runtime = {
+	.enc_status_changed = tdx_enc_status_changed,
+	.enc_tlb_flush_required = tdx_tlb_flush_required,
+	.enc_cache_flush_required = tdx_cache_flush_required,
+};
+
 void __init tdx_early_init(void)
 {
 	u32 eax, sig[3];
@@ -486,5 +592,7 @@ void __init tdx_early_init(void)
 
 	cc_init(CC_VENDOR_INTEL, mask);
 
+	x86_platform.cc = &tdx_cc_runtime;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 4a05b13e24f2..fac4d588d3b3 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -21,6 +21,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79924745EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhLNPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:05:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:28602 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235227AbhLNPDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225852766"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225852766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="463822560"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2021 07:03:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2A63DDAF; Tue, 14 Dec 2021 17:03:10 +0200 (EET)
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
Subject: [PATCH 20/26] x86/tdx: Add helper to convert memory between shared and private
Date:   Tue, 14 Dec 2021 18:02:58 +0300
Message-Id: <20211214150304.62613-21-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Provide a helper to do conversion between shared and private memory.
It is going to be used by the following patch.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tdx.h | 18 +++++++++
 arch/x86/kernel/tdx.c      | 79 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 286adda40fb7..20114af47db9 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -55,6 +55,15 @@ struct ve_info {
 	u32 instr_info;
 };
 
+/*
+ * Page mapping types. This is software construct not part of any hardware
+ * or VMM ABI.
+ */
+enum tdx_map_type {
+	TDX_MAP_PRIVATE,
+	TDX_MAP_SHARED,
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -78,6 +87,9 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 phys_addr_t tdx_shared_mask(void);
 
+int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end,
+			       enum tdx_map_type map_type);
+
 #else
 
 static inline void tdx_early_init(void) { };
@@ -87,6 +99,12 @@ static inline void tdx_guest_idle(void) { };
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 static inline phys_addr_t tdx_shared_mask(void) { return 0; }
 
+static inline int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end,
+					     enum tdx_map_type map_type)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index d4aae2f139a8..9ef3cf0879d3 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,10 @@
 /* TDX Module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_ACCEPT_PAGE			6
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
 
 /* See Exit Qualification for I/O Instructions in VMX documentation */
 #define VE_IS_IO_IN(exit_qual)		(((exit_qual) & 8) ? 1 : 0)
@@ -83,6 +87,81 @@ static void tdx_get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+static bool tdx_accept_page(phys_addr_t gpa, enum pg_level pg_level)
+{
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 if GPA encodes page size: 0 - 4K, 1 - 2M, 2 - 1G.
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
+		return true;
+	}
+
+	return __tdx_module_call(TDX_ACCEPT_PAGE, gpa, 0, 0, 0, NULL);
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end,
+			       enum tdx_map_type map_type)
+{
+	u64 ret;
+
+	if (end <= start)
+		return -EINVAL;
+
+	if (map_type == TDX_MAP_SHARED) {
+		start |= tdx_shared_mask();
+		end |= tdx_shared_mask();
+	}
+
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * sec "TDG.VP.VMCALL<MapGPA>"
+	 */
+	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0, NULL);
+
+	if (ret)
+		ret = -EIO;
+
+	if (ret || map_type == TDX_MAP_SHARED)
+		return ret;
+
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		/* Try 2M page accept first if possible */
+		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
+		    !tdx_accept_page(start, PG_LEVEL_2M)) {
+			start += PMD_SIZE;
+			continue;
+		}
+
+		if (tdx_accept_page(start, PG_LEVEL_4K))
+			return -EIO;
+		start += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
 static __cpuidle u64 _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
-- 
2.32.0


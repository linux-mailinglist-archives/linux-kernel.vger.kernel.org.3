Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7504982F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiAXPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:64673 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240210AbiAXPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036551; x=1674572551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIq4wkLg68PMcrcMSOZIfkxpvIMypkjtFrhM/WVfcdg=;
  b=gHuSh9yRFLeBX6J0TUyJHWIgjZY1zlENzl1JiD2+geV2HrRibKzQNikQ
   +uGkviFUtZLovAvSIpDEME95aa6TejeAb6kqgcwmDIlDJ6gT5PWsqwB6/
   7PCkn59gIZgrgR1VcfxRuum/zMfY4fqJTQKHv91hkys3Wtjjc6xC2LnSJ
   2Ekne76K8lLfRG8bxwe+OwLtpybHWZSAUCWRLC7BY8BADyM2A998pNwC2
   TZDOgs3PVqUhZ1jHDsaS5jq14nyVMnFrus8FXMS779KEzynhWq1H42CVW
   DJ2AU3jKawt3+Iz+lYhkppoKKs4UUR9YkZyaFfkjMTXRuWtM1Z75uLVBB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270498646"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270498646"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479104738"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 07:02:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 68E7CCD2; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
Subject: [PATCHv2 23/29] x86/tdx: Add helper to convert memory between shared and private
Date:   Mon, 24 Jan 2022 18:02:09 +0300
Message-Id: <20220124150215.36893-24-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/include/asm/tdx.h |  9 +++++
 arch/x86/kernel/tdx.c      | 78 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c6a279e67dff..f6a5fb4bf72c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -57,6 +57,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 phys_addr_t tdx_shared_mask(void);
 
+int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end, bool enc);
+
 #else
 
 static inline void tdx_early_init(void) { };
@@ -67,6 +69,13 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
 static inline phys_addr_t tdx_shared_mask(void) { return 0; }
 
+
+static inline int tdx_hcall_request_gpa_type(phys_addr_t start,
+					     phys_addr_t end, bool enc)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 3bf6621eae7d..ea638c6ecb92 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,10 @@
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_ACCEPT_PAGE			6
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
 
 /* See Exit Qualification for I/O Instructions in VMX documentation */
 #define VE_IS_IO_IN(exit_qual)		(((exit_qual) & 8) ? 1 : 0)
@@ -97,6 +101,80 @@ static void tdx_get_info(void)
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
+int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end, bool enc)
+{
+	u64 ret;
+
+	if (end <= start)
+		return -EINVAL;
+
+	if (!enc) {
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
+	if (ret || !enc)
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
 static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
-- 
2.34.1


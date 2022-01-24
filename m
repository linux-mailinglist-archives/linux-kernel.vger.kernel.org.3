Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D34982F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiAXPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:19111 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240231AbiAXPCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036553; x=1674572553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/2/2Vf7aAJY5Z0gTQ9vw6gI7x3m6wTJrRpGLg8JppI=;
  b=SeYa2kJgY4u8vieN3NsiqzacHqTXNbYSzhrtL4uS0WY8qOw6agkJPwum
   g0VNn0nmT/jOQE4p3QLUiB1E6YB/gjaATuq7ZOxkmpDOZiBMAdfqT8ExS
   wh1atElMoaFgfKVmwvgL8P5pwN0RYf9VWQu/uEmm0PcWpU7w7T1Pb/a8+
   MWPi3YqaqG5dUQWI3/cN4PEf5ttAVcMr+E6dJZWiwX1+wZjTgce8Dccul
   WIBCIPcy0tQzE+5xLOa0RNM87YUXUAs+Eb/qMCuP+gWrxMzESB8/pzbK5
   whFPhE4+foQJlbHT+SNXapDpXesuaqM1ZZyI4Mnk/aXWQVX2dNwkWNKKD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233423327"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233423327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="624104372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2022 07:02:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 52933C98; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
Subject: [PATCHv2 21/29] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
Date:   Mon, 24 Jan 2022 18:02:07 +0300
Message-Id: <20220124150215.36893-22-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guests, by default memory is protected from host access. If a
guest needs to communicate with the VMM (like the I/O use case), it uses
a single bit in the physical address to communicate the protected/shared
attribute of the given page.

In the x86 ARCH code, __PHYSICAL_MASK macro represents the width of the
physical address in the given architecture. It is used in creating
physical PAGE_MASK for address bits in the kernel. Since in TDX guest,
a single bit is used as metadata, it needs to be excluded from valid
physical address bits to avoid using incorrect addresses bits in the
kernel.

Enable DYNAMIC_PHYSICAL_MASK to support updating the __PHYSICAL_MASK.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig      | 1 +
 arch/x86/kernel/tdx.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1c59e02792e4..680c3cad9422 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -886,6 +886,7 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MCE
+	select DYNAMIC_PHYSICAL_MASK
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b27c4261bfd2..beeaf61934bc 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -486,5 +486,13 @@ void __init tdx_early_init(void)
 
 	tdx_get_info();
 
+	/*
+	 * All bits above GPA width are reserved and kernel treats shared bit
+	 * as flag, not as part of physical address.
+	 *
+	 * Adjust physical mask to only cover valid GPA bits.
+	 */
+	physical_mask &= GENMASK_ULL(td_info.gpa_width - 2, 0);
+
 	pr_info("Guest detected\n");
 }
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD44BBD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiBRQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiBRQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3F22BD9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201040; x=1676737040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwE6bd0HXKQns9OrPOJ/XgbFP3/yyBZv+ATjopb2MRE=;
  b=akGfv7KA0dKBObcKVyfYuQi7z/4qYUYez4p9F07wJh2p+bqPD6t5a0QK
   z7T/4b4z5DzRObWEI3aGVZGbD0+ctIpSbnBHe2hBDFrYdCiB8e5VljAqy
   DF4fkGoI+io87wplqUl/zcLgwYHNEl1H2YMQd68j3Pgr1YsmTl6cQ23hW
   waBA2gY+gsA4772m85F0mSUsYAk8R2FmqCkkjA4ke1mZMa5M/sfL2gLIT
   Q6ODoIZfr5aewGnz1F2Bma0YiZnxUTqwV0ClW58sb0sxVUr91ZNLanOfy
   hRpiFBMgwPMAjey1p6cLTj7Gt4CkMxnGynPQWjijHSINqyJ89b93wiV+E
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250910892"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250910892"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605590580"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2022 08:17:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 60079166; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 07/32] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
Date:   Fri, 18 Feb 2022 19:16:53 +0300
Message-Id: <20220218161718.67148-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig    | 1 +
 arch/x86/coco/tdx.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 581aaff0ccee..85591ecc8473 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -885,6 +885,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
+	select DYNAMIC_PHYSICAL_MASK
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 87e561c5b4e3..ea5f02a5d738 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -72,6 +72,14 @@ void __init tdx_early_init(void)
 
 	get_info();
 
+	/*
+	 * All bits above GPA width are reserved and kernel treats shared bit
+	 * as flag, not as part of physical address.
+	 *
+	 * Adjust physical mask to only cover valid GPA bits.
+	 */
+	physical_mask &= GENMASK_ULL(td_info.gpa_width - 2, 0);
+
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
 	 * Set it for shared pages and clear it for private pages.
-- 
2.34.1


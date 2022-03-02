Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7CE4CA80E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbiCBO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbiCBO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A194483A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231291; x=1677767291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cs1O3jc79lKYHvKE5ahlqFfc0nRRD1WchEXtv88HMEU=;
  b=THBvIn/2Ok8fNLY7lt879xhR1quREmQ7kICNLluFNk+KDRgRaChssMLp
   BvGeboJGHJEgS7O0sUJF5CMFyFNDvDrp6/D5koZ94O4YJaT/2s4gHhwSV
   KkZoqI9Ol1xs6CpOiVxSoVioysj+4b7MN+v7beeFugeDHG97Ru7b6mDIN
   ECqmRYKaL1EYpsx+HP9Ff22S77R7u5WpWXGczQd1I/gp+x/fpMf23QoJT
   /d005eVaYQlI2Qo19/afYi7sQOzQYHbWRmdOHrjwHFdPIaD6rHPv+Z7/2
   1fpPobWqtMTKEfq9qieg8jbgoKxdEmPX+pct1tlyCsJR6p7Kwx0GQr20V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240824342"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="240824342"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="551270223"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2022 06:28:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 07B6024D; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 05/30] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
Date:   Wed,  2 Mar 2022 17:27:41 +0300
Message-Id: <20220302142806.51844-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 93e67842e369..d2f45e58e846 100644
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
index 912ef12e434e..34818dc31248 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -69,6 +69,14 @@ void __init tdx_early_init(void)
 
 	cc_set_vendor(CC_VENDOR_INTEL);
 
+	/*
+	 * All bits above GPA width are reserved and kernel treats shared bit
+	 * as flag, not as part of physical address.
+	 *
+	 * Adjust physical mask to only cover valid GPA bits.
+	 */
+	physical_mask &= GENMASK_ULL(gpa_width - 2, 0);
+
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
 	 * Set it for shared pages and clear it for private pages.
-- 
2.34.1


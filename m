Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201F4DA7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352998AbiCPCLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352600AbiCPCLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9225E74B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396605; x=1678932605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVpAPIrGb/8chIW0NBOaVararP1+qakkIrUTFbzndGQ=;
  b=mHBzuf2LCmitdUr25x6KM3Ixi6myKakqofcfWsL+bSfuiC/gHpw+N9pN
   bOhE4CWB4BgClyftevQmaQgZbUKBRcpug+CGiDRCnXD+MCNJZhDme3yYZ
   8loaVYLR+rPaIAygkhCFP+zccie9ByQuFOeAjejW5HmoKoSGc77WQs4jS
   n049buhURNGO3Bq0Ooh90l0SjsjiQ3qzHElKYMij0aU99AKgRvzvn8S9v
   3hLYoA3aa6JgJ+MSyUoGjCXjQ0ejxXRLctiHrJWEthW160soR93yWMBEZ
   3IB25gnOjMhBsT1vOPBFYXQJ4H1gtFCu8Y9vCbQEAGifhCRNFEEmKJiJu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255299993"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="255299993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="714416716"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 19:09:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B5DDB5A2; Wed, 16 Mar 2022 04:10:09 +0200 (EET)
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
Subject: [PATCHv6 05/30] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
Date:   Wed, 16 Mar 2022 05:08:31 +0300
Message-Id: <20220316020856.24435-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/Kconfig        | 1 +
 arch/x86/coco/tdx/tdx.c | 8 ++++++++
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
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 9ac066fb3912..069a93d2d331 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -82,6 +82,14 @@ void __init tdx_early_init(void)
 
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


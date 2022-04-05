Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62364F5358
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359649AbiDFDRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445542AbiDFCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:14:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5612B1B0BCF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201720; x=1680737720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FB/8/9NOxqY8pFkshQ5QcHU4jTbXJdjhkrb4LcnkmDo=;
  b=e32+08aBDQK99iKZm47c4/gMZ3WqIf3DP/EzMy0rnyVLgEYxpZL1EuL5
   Cva7VZd21uDH92KDFXc6EO6f6rFuKVscl+J3CDIPr5IufisjbukMTVlJw
   zN7yUegBFtsMvgi/YvxOnx1yDLvu7/Tscv+QjhJrNIdU7NQ2bnJiQ7cWn
   c0xIr4ckodR3E1qEMrpaXgsBzmCDFcth6o33+84sn1bHH6RTXXI5kAo7V
   F6ercnn0WQtmNHsFHRIsRiJTC+GjoqW0PUclHodWmuBFsERpbQt2k/lWm
   CnyCNx7l9urTDEl6UShh3BWR2ZAJLIZKaYq7+jMqR5fUaapwL6v+iJ9mQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261065416"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="261065416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="697135306"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2022 16:34:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AA2515AA; Wed,  6 Apr 2022 02:29:45 +0300 (EEST)
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
Subject: [PATCHv8 05/30] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
Date:   Wed,  6 Apr 2022 02:29:14 +0300
Message-Id: <20220405232939.73860-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
index 984315ca0275..aea4cc404c31 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -883,6 +883,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
+	select DYNAMIC_PHYSICAL_MASK
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 96b2611baac5..e84f6dd3ed2a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -89,5 +89,13 @@ void __init tdx_early_init(void)
 	cc_mask = get_cc_mask();
 	cc_set_mask(cc_mask);
 
+	/*
+	 * All bits above GPA width are reserved and kernel treats shared bit
+	 * as flag, not as part of physical address.
+	 *
+	 * Adjust physical mask to only cover valid GPA bits.
+	 */
+	physical_mask &= cc_mask - 1;
+
 	pr_info("Guest detected\n");
 }
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3E4DA7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353113AbiCPCMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352833AbiCPCL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD05E77A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396612; x=1678932612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pA0HpCw5vCCuKBlGX3u3CPWDNR4SBAm2VrJVky13+Aw=;
  b=QzXmX8dc9hybX8Sw0x71gmJ5HWLtmlFmtNlPne9SgN4VleO9L1+xZ29B
   dH3qtb6aEa9Q1NZRukRP1WtcXRBMdCCMVzbB/jPzE9wrXHOw/JBzDF0Xf
   l7/TJMNvOxCUWqG+d1K0YgVmnaUCvD8NlRuA1d0EkK93W/Doo9gE2rih/
   PVbs13FxsxwhyBdn9FvFcNUYDGfq/1jGPLWIVScTAeybreIYFaIuVLYqw
   SFwoq++Jo+fZXJLeDXwlCTZPMNbugsj7xDNiz0WMe3rTuv2lhUbq7TQ/U
   kCyOUe4gZkVwxDG5OgSHEgoOydI+mtmDaklDaOI7Kj+ifkThUS4+RMdpT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238636675"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="238636675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="598535269"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2022 19:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D04B2CE5; Wed, 16 Mar 2022 04:10:10 +0200 (EET)
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
Subject: [PATCHv6 25/30] x86/tdx: Make pages shared in ioremap()
Date:   Wed, 16 Mar 2022 05:08:51 +0300
Message-Id: <20220316020856.24435-26-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guests, guest memory is protected from host access. If a guest
performs I/O, it needs to explicitly share the I/O memory with the host.

Make all ioremap()ed pages that are not backed by normal memory
(IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.

The permissions in PAGE_KERNEL_IO already work for "decrypted" memory
on AMD SEV/SME systems.  That means that they have no need to make a
pgprot_decrypted() call.

TDX guests, on the other hand, _need_ change to PAGE_KERNEL_IO for
"decrypted" mappings.  Add a pgprot_decrypted() for TDX.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/ioremap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b3b782..a5d4ec1afca2 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -242,10 +242,15 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * If the page being mapped is in memory and SEV is active then
 	 * make sure the memory encryption attribute is enabled in the
 	 * resulting mapping.
+	 * In TDX guests, memory is marked private by default. If encryption
+	 * is not requested (using encrypted), explicitly set decrypt
+	 * attribute in all IOREMAPPED memory.
 	 */
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else
+		prot = pgprot_decrypted(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
-- 
2.34.1


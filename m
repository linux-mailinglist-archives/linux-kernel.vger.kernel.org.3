Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB94C309D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiBXP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiBXP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF4131F7E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718231; x=1677254231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/5iP14Tg24GtfulUdmcNudmbOpBuYqe/UqX13ONj68=;
  b=J6qzH5tLQEOEbF5O+7LHo2IpZLy9O1s19K7C/q5QsPk3fXaIJ6XzRLHW
   +p4k0KOia2SLEMSDyGzL1+HgJBSnqTfHMGcBParkLR7sqyzZij8gLO8b8
   v24X4fZ2MGUlRsU5qTtFcHCNBrPE09nVqyNX4xKpfCsakZjNdfqxv7zQD
   dE/2DBFrUo8ybP3l+PWa9wGTGkSDb4qe71Ff60yCDzfOeVOVswDrE7Ui2
   lm0j1PnQanWyKABzmFg1MoDf6uGP5S8G1xHV39jjZN23UWBfaDmt46/hs
   bVeoJczaBoxbOyVVjddpaXpobTmGc9uHkMez7G4OtyKkAkD/UTIeB60Di
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315487715"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315487715"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="592128137"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7E86EB34; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
Subject: [PATCHv4 25/30] x86/tdx: Make pages shared in ioremap()
Date:   Thu, 24 Feb 2022 18:56:25 +0300
Message-Id: <20220224155630.52734-26-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guests, guest memory is protected from host access. If a guest
performs I/O, it needs to explicitly share the I/O memory with the host.

Make all ioremap()ed pages that are not backed by normal memory
(IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.

Since TDX memory encryption support is similar to AMD SEV architecture,
reuse the infrastructure from AMD SEV code.

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


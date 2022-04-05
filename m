Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA34F538F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359878AbiDFDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847207AbiDFCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:16:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0BE1B53A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201737; x=1680737737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGfsP2AN5f1pRDX1KgIcNkub4ayLBgSYxXNj9Z/dD8o=;
  b=I73oJAauFcC5uEGQ2ddZwJXTMZJz4RzObYWq1PU7TqQ83yXW2dXQp5AZ
   WxH5AXOxg///1jmFHWeIC3Eq3HjTbIgCfuIQ9OVkkK7zXuPelswlfYGhQ
   0zhOsc5GC1AINH8PQPw/TVlGJwVyypVWbft6PFN5VwhaEJca8zK2ZaHxE
   Dpu6liU6Q0NSiUTCsGiphx4EbhEQPypv7gwt5/bnKLfBjPfwHpcOX57wu
   SdCoQhuMQig405VyyeXHernJQN8TqlM2Aau2IjOvxAPWWywuM/4TuyXTv
   p0cvLUOaMgsATTX02ubwelxeRxX72AVgQEq7+yC8WTU0EiRrZT8k3Z6GA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259721586"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="259721586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="549273525"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 16:34:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CB29BFC5; Wed,  6 Apr 2022 02:29:46 +0300 (EEST)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 25/30] x86/tdx: Make pages shared in ioremap()
Date:   Wed,  6 Apr 2022 02:29:34 +0300
Message-Id: <20220405232939.73860-26-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/ioremap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 17a492c27306..1ad0228f8ceb 100644
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
2.35.1


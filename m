Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F054BBD49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbiBRQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiBRQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BBB5B88F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201049; x=1676737049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/5iP14Tg24GtfulUdmcNudmbOpBuYqe/UqX13ONj68=;
  b=IhqezXfJpjLutLK4xHENCqF7xCyojhXlYRNgdOu/U+aidJ/PE6HrnowU
   S2xjpyvoax3qw3kiwqp/1fyHDuYllNyEO/7lhGnMUfxjDNLTgGDaVnAjD
   wffbTC7qcwSIXEi391NK+Z1oEoAUGCqR7DubMjxjyUo8nc9Yzdl7ihGl9
   m57N/e9piEmkA3VdRFtrB20UEjc1Gzn/nJbaaZmeagDvYmN4EGtLGWxm6
   Qa/RlX3PonXK4mgtrKUaE1AMcVDM2BnElHpGKpzNbNupuO64VsrnGMzvk
   Sky/slYj5Tsawqlma/gXGgJL5JVDPedgNaWtpphqrZhzRC68pvh2gCrMV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238559752"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238559752"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="530969774"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 57C9BE26; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
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
Subject: [PATCHv3 26/32] x86/tdx: Make pages shared in ioremap()
Date:   Fri, 18 Feb 2022 19:17:12 +0300
Message-Id: <20220218161718.67148-27-kirill.shutemov@linux.intel.com>
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


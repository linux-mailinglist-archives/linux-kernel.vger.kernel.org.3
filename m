Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881754AFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355988AbiFNMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiFNMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:01:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC74755C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208099; x=1686744099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3BZ8RWBROa1LlaDnI1IOVxCv82mL+FJE/PjDuYq4QlY=;
  b=n/CzsrkDcmwDdSDaJWrWjKyeADmCBxtSDzDbdvSyQmPPcwZRMeJiumHG
   FdHhBwNs8HQnjDAvIDN8kRvrtdQm9Sq83KyuGovKOPvBknnSo0IzA1BAi
   mXLRtVaQEsYNDzU3Ffi5Xp535bDbL7QNYqHuvTC0xgSFeP2oIEdgQDLiu
   pj/XH5qkx0/WioVHNF75Vaa7BjQo0QcBtTKoSEKQhA3O2x9/LHNh6OfU0
   u4WwekIs3xvm+LVV3lcNPY9NrV9Dy8qFBLy6i2LLygLn+VvvSS1BfHOa5
   5mF5dWUkHMFZPY+GhG78acM6CAUg3k9b7jGtLiLTnmdA+OnLIn3sQdrya
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276137980"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276137980"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="617967148"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2022 05:01:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 161655D3; Tue, 14 Jun 2022 15:01:37 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page
Date:   Tue, 14 Jun 2022 15:01:35 +0300
Message-Id: <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
The unwanted loads are typically harmless. But, they might be made to
totally unrelated or even unmapped memory. load_unaligned_zeropad()
relies on exception fixup (#PF, #GP and now #VE) to recover from these
unwanted loads.

In TDX guests, the second page can be shared page and VMM may configure
it to trigger #VE.

Kernel assumes that #VE on a shared page is MMIO access and tries to
decode instruction to handle it. In case of load_unaligned_zeropad() it
may result in confusion as it is not MMIO access.

Fix it by detecting split page MMIO accesses and fail them.
load_unaligned_zeropad() will recover using exception fixups.

The issue was discovered by analysis. It was not triggered during the
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7d6d484a6d28..3bcaf2170ede 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -333,8 +333,8 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
+	unsigned long *reg, val, vaddr;
 	char buffer[MAX_INSN_SIZE];
-	unsigned long *reg, val;
 	struct insn insn = {};
 	enum mmio_type mmio;
 	int size, extend_size;
@@ -360,6 +360,19 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	/*
+	 * Reject EPT violation #VEs that split pages.
+	 *
+	 * MMIO accesses suppose to be naturally aligned and therefore never
+	 * cross a page boundary. Seeing split page accesses indicates a bug
+	 * or load_unaligned_zeropad() that steps into unmapped shared page.
+	 *
+	 * load_unaligned_zeropad() will recover using exception fixups.
+	 */
+	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
+	if (vaddr / PAGE_SIZE != (vaddr + size) / PAGE_SIZE)
+		return -EFAULT;
+
 	/* Handle writes first */
 	switch (mmio) {
 	case MMIO_WRITE:
-- 
2.35.1


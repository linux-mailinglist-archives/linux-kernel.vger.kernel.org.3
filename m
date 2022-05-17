Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAB52A699
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350006AbiEQPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiEQPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:30:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334E4F9C7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801435; x=1684337435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aXZnyU0djTha+7ry1uEu2zsq27L4rt5KsD7gfEWC7Gs=;
  b=KT6Rj9WOzXIfqeCU+9r6E7MlR9PT0FDN9lJLYr0iJsm4ErRCslYeKGKw
   pLit+HAzJiWY6S/HgM2HoabUBfZWOFSba71xpuf1Kn+iOP2i8elc30Rs6
   3rbxiL7PCc9RrdkoZkAKLAe9/v6wtZYYuZiqtorZFid/cHLZddmdzoOzm
   ZN2HT1aT6yS2qh7NohvjaII7fsf68j/ltPd2Ho00vCkQmru0t2icrBjuJ
   GmoBg1A1yFmvnzYzCahdUcGby2Q5RzZ2Coqud20OZ2qKBxbksvN5Urq+8
   Qh8qM3v1Ir3o0TQEJDhTxQbUjf5K814zCnfxqVQpTKBp1xryfhXm6qsGp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270040137"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270040137"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700103995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 08:30:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 05014159; Tue, 17 May 2022 18:30:30 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page
Date:   Tue, 17 May 2022 18:30:21 +0300
Message-Id: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

In TDX guest the second page can be shared page and VMM may configure it
to trigger #VE.

Kernel assumes that #VE on a shared page is MMIO access and tries to
decode instruction to handle it. In case of load_unaligned_zeropad() it
may result in confusion as it is not MMIO access.

Check fixup table before trying to handle MMIO.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d6920d..5fbdda2f2b86 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -11,6 +11,8 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/trapnr.h>
+#include <asm/extable.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -296,6 +298,26 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(user_mode(regs)))
 		return false;
 
+	/*
+	 * load_unaligned_zeropad() relies on exception fixups in case of the
+	 * word being a page-crosser and the second page is not accessible.
+	 *
+	 * In TDX guest the second page can be shared page and VMM may
+	 * configure it to trigger #VE.
+	 *
+	 * Kernel assumes that #VE on a shared page is MMIO access and tries to
+	 * decode instruction to handle it. In case of load_unaligned_zeropad()
+	 * it may result in confusion as it is not MMIO access.
+	 *
+	 * Check fixup table before trying to handle MMIO.
+	 */
+	if (fixup_exception(regs, X86_TRAP_VE, 0, ve->gla)) {
+		/* regs->ip is adjusted by fixup_exception() */
+		ve->instr_len = 0;
+
+		return true;
+	}
+
 	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-- 
2.35.1


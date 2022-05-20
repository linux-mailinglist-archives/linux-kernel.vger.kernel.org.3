Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88452E2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbiETDNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345073AbiETDNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:13:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2489A149D9D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653016418; x=1684552418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zI9dty8xwA0hQXIR/uJZISyrrrAzLIt9y6FokLyHGTc=;
  b=CIrkJvGW9pDBXCkwe0o2UUVPTHk72j62anI2x99d+Ljbbpq3pxfoZAQp
   Av22iGSFun5UC+5j86G5yKKC9l4i64zDmlXpxeSxF42o/3DUiWLNujLy8
   x0XoIK9q9V1phhHESZMaOyAetB55yUQ8O9yGAqnjBoHpfwYILppzwtwH8
   5JeeUS1Qw/6PNODVHgbKFArTWR4eX/NEj33xyyz3m3xWUB0WekZNKgbQg
   p3up7N1BY7+T9PoAkhXwLqg+cnKCQII42YJ5qxEJPe50PxPLv21AVMKq0
   oLjkUEnnsoII+qhWTDxQi+qri02weQMZk2pX8E0tNrfY5cejlMiLdhl3Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="335517346"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="335517346"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 20:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="674404235"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2022 20:13:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 05CAA27D; Fri, 20 May 2022 06:13:25 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page
Date:   Fri, 20 May 2022 06:13:16 +0300
Message-Id: <20220520031316.47722-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

In TDX guests, the second page can be shared page and VMM may configure
it to trigger #VE.

Kernel assumes that #VE on a shared page is MMIO access and tries to
decode instruction to handle it. In case of load_unaligned_zeropad() it
may result in confusion as it is not MMIO access.

Check fixup table before trying to handle MMIO.

The issue was discovered by analysis. It was not triggered during the
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 010dc229096a..1a1c8a92cfa5 100644
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
@@ -299,6 +301,24 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(user_mode(regs)))
 		return -EFAULT;
 
+	/*
+	 * load_unaligned_zeropad() relies on exception fixups in case of the
+	 * word being a page-crosser and the second page is not accessible.
+	 *
+	 * In TDX guests, the second page can be shared page and VMM may
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
+		return 0;
+	}
+
 	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
 		return -EFAULT;
 
-- 
2.35.1


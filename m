Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD1353334B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242058AbiEXWKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbiEXWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:10:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054D819A3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653430225; x=1684966225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KjUmR28PG6nuPU2mel4Olt+Fqotqsfe0DrqeDe68tw8=;
  b=meNks6yjZ64+P80N4J/tSvwEl2Yuc4FiWNXI7JXRRqMhSStNdZ+mbnFw
   EmeV6+qQ3ircE5eLnf0b4wsbY650ekXWWKXc4IeF/hpm4EFHxuDgshINw
   VJmcrWtR/Or88Ab81EO4QS4+qQ04FldcJUAaklPivtJzgW+vXGPDbai8u
   4e9nOqKwoQZB1UyeSpltwCfVj9yNLMGzii8lrLpAhbDxSiDlh5Zw3PXhm
   GwCyXcR++p1Rhwcuzn8OvL0E4aanJ+vxHVO0ONMsk7hVlHZhwBkyhHhQk
   fbd3Z/BtcP3f2xErHUX5exiA8HaBpsr8LL7OmKFAhf8W96+3Raw9Gvv2b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273657963"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273657963"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 15:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="664143791"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 15:10:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1D779709; Wed, 25 May 2022 01:10:22 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page
Date:   Wed, 25 May 2022 01:10:12 +0300
Message-Id: <20220524221012.62332-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fix it by detecting unaligned MMIO accesses (it includes page-crossings)
and fail them. load_unaligned_zeropad() will recover using exception
fixups.

The issue was discovered by analysis. It was not triggered during the
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 94e447e7f103..4e566ed67db8 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -331,6 +331,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	/*
+	 * MMIO accesses suppose to be naturally aligned and therefore never
+	 * cross a page boundary. Seeing unaligned accesses indicates a bug or
+	 * load_unaligned_zeropad() that steps into unmapped shared page.
+	 *
+	 * In both cases fail the #VE handling. load_unaligned_zeropad() will
+	 * recover using exception fixups.
+	 */
+	if ((unsigned long)insn_get_addr_ref(&insn, regs) % size)
+		return -EFAULT;
+
 	/* Handle writes first */
 	switch (mmio) {
 	case MMIO_WRITE:
-- 
2.35.1


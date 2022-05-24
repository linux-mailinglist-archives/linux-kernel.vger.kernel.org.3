Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCD533348
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiEXWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiEXWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:10:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B48217F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653430232; x=1684966232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YKWMSbb5ilC548cSjiQyw/GUTbjzrOI6q8bG06K3nw=;
  b=NpEj8f9cEqagUnklxzXaUffp/U0F5WyWfffTPbj7XYdwiQZ1WeSr76vL
   Xcps8REs/VLBS65r8xaRUs4+z+XedEAo81u+DxdjTWF13SrcELZE3XI3b
   JrEOhoUsZG82EVSn67rGHmRX80zcI0jJ1Hb1pQfJKLjwBqFPpvksVCdTD
   CW6xeqryIsG8dh6RjYjE2b0vrlpx3QGFZUjy7mtLULe890v4CVIOLcZ6F
   X1TBqsEswaTeVF33OWnkCEECtGkPy7G3ydPPfYNq6BrR+iJ7X9xD2uMgz
   rQnVORhr1rD4GM6Fpefd5IvuBx170DfPvWEPHt3m5zCOg6cssxW9Qmlc0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336715527"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336715527"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 15:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="548714797"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 May 2022 15:10:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 09B67103; Wed, 25 May 2022 01:10:21 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 1/3] x86/tdx: Fix early #VE handling
Date:   Wed, 25 May 2022 01:10:10 +0300
Message-Id: <20220524221012.62332-2-kirill.shutemov@linux.intel.com>
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

Move RIP in tdx_early_handle_ve() after handling the exception. Failure
to do that leads to infinite loop of exceptions.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 32e72854fa5f ("x86/tdx: Port I/O: Add early boot support")
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d6920d..faae53f8d559 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -447,13 +447,17 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 __init bool tdx_early_handle_ve(struct pt_regs *regs)
 {
 	struct ve_info ve;
+	bool ret;
 
 	tdx_get_ve_info(&ve);
 
 	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
 		return false;
 
-	return handle_io(regs, ve.exit_qual);
+	ret = handle_io(regs, ve.exit_qual);
+	if (ret)
+		regs->ip += ve.instr_len;
+	return ret;
 }
 
 void tdx_get_ve_info(struct ve_info *ve)
-- 
2.35.1


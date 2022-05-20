Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C652E2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbiETDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbiETDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:13:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D0149DB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653016418; x=1684552418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C1MjNgZRWNUguHYARwDuQ5aWYg8MLB/+yAZkGdkF1+w=;
  b=WdINQdLof7yg+tkakQI025hdkYxkuzFc/Go22QdqCRZltZrnZmAKjUCw
   Sz9BNCXf76wB9b7SLQ5gtno5A56i9Y5VAVMlWfdeKEq6cGdn6zD62mDUE
   eEuDZv45O3MoqYtkRPuR8Lc2vfCIUKUF9VS0yjt9mexwfwZU1M/1J0TFj
   j2N1gJkXPGgfpKIOutsTMuXZ8NGf/IqYE/OcEcQ/PxMRY8lr4En4d+yjW
   p1IiyKfdxQI+bKC+UnBmerIVw2Eb2h7K+udYBiR3+mnGYQABtgM7IEHco
   UghxlMvyL/xjTPtzlqkrbOHMXSO7B2Fzddt+Rw41whwvxkersbyHqQG1t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272594681"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272594681"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 20:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="627932247"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2022 20:13:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E9212D2; Fri, 20 May 2022 06:13:24 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 1/3] x86/tdx: Fix early #VE handling
Date:   Fri, 20 May 2022 06:13:14 +0300
Message-Id: <20220520031316.47722-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525454AFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355778AbiFNMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353519AbiFNMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:01:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3D47AEE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208098; x=1686744098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YKWMSbb5ilC548cSjiQyw/GUTbjzrOI6q8bG06K3nw=;
  b=Kd83AkEE9wW0uZnnPr++k7jOXEybJuCjfS6JRSlKmrkC0uoUdPVpGrrx
   5YeF9SKSNIB7d8Oiab/Y4ZyoW87JqbXVItBeNjHlQ6LTuuoPPxtJfgiBN
   RBsQWrHkK8MwN3MG8slEwSztejVJ4oFhYt5ioiwUSOMHNL54vnwD3oUjz
   uYp2q6Vv8naqAx9QT6I4GYfUAmYDirCJS5OcEEAvDacWxZMEbYra5Fjap
   V72VM0BdsUjye0vbADfINRUXQFiHlVLgJ8gJ2nni/XYv2WmElYG9XL8H5
   yk2wHJ7dyN0rd932Hpvph7uDWk9Ha6V1AbpOuMznDSm37xP+moPKqf4ub
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276137977"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276137977"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="761935995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2022 05:01:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E3C5D18F; Tue, 14 Jun 2022 15:01:36 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 1/3] x86/tdx: Fix early #VE handling
Date:   Tue, 14 Jun 2022 15:01:33 +0300
Message-Id: <20220614120135.14812-2-kirill.shutemov@linux.intel.com>
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


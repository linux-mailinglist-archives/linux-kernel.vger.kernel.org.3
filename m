Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE550761C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350281AbiDSRK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355588AbiDSRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6F38A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388021; x=1681924021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GEA3SMd1Hyd9mgC2yPlyiFisBoFISvY6li4UoRH0Ugk=;
  b=NaNWmAoQMJFIZN2rjybq7L2kKbA5r6jVpdTLSazqP6nYdu0G8IGPWvHU
   ylc0j5tQM9aBPs+5xPrL+HMR7EpC2d3UBY0P7NnLTdTp+l5rcGqnznbCu
   Cok/OvoLAFJtYwWhrlSm69McMAy6LmLYyqMpqxmDa7sMYY/u6RxszoR/g
   /RSo7U9IRtXILiHbitqudpL9WZm+HU82ukGN1rjXG2WrNYZD+jGnGUqzg
   1Y6QjYJLWHHVujt5VrrkrrAkbQDI+KyTQrE+DfJOai28s11znndm0uIp6
   NO39/ddNax0Xw2GjwUcoqkm0MpF5ziDepQsPVcXdQzm2J4EqBDzO9v2pP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263280365"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263280365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="614074980"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:56 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 07/44] x86/fault: Adjust WARN_ON for pkey fault
Date:   Tue, 19 Apr 2022 10:06:12 -0700
Message-Id: <20220419170649.1022246-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Previously if a protection key fault occurred on a kernel address it
indicated something wrong because user page mappings are not supposed to
be in the kernel address space.

With the addition of PKS, pkey faults may now happen on kernel mappings.

If PKS is enabled, avoid the warning in the fault path.  Simplify the
comment.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dave Hansen
		Clarify the comment and commit message
---
 arch/x86/mm/fault.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d0074c6ed31a..5599109d1124 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1148,11 +1148,11 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
 	/*
-	 * Protection keys exceptions only happen on user pages.  We
-	 * have no user pages in the kernel portion of the address
-	 * space, so do not expect them here.
+	 * PF_PF faults should only occur on kernel
+	 * addresses when supervisor pkeys are enabled.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
+		     (hw_error_code & X86_PF_PK));
 
 #ifdef CONFIG_X86_32
 	/*
-- 
2.35.1


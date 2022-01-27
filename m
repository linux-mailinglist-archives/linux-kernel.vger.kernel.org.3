Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1AD49E967
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiA0Rz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:65473 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244760AbiA0RzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306117; x=1674842117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5N4sLTNdeUIAZnJLedt6mzC6DSo6VpBb9ZGGJjLgZSQ=;
  b=OVD/XmczWmbtmQFdtvmVK3ZfQ7WHS2LXFYewgwSnTgjuzQ+mY8NJteAI
   a36NEXztet5QS5Imp5Kvp9+eBUMOVXVCGKNKSmnT4KATW80n7aVtV8gZc
   nMrVSitj2dM6DOkU3tWKlR5UAseXvl/OBU26oH6uxwLXDPCiwRTX8Aahi
   WiVcDCKi4Y2945jTVHwShcU9dZJedX4r9qqjR1WnQvLq8aXNQd134LsoR
   03e+dc9cu4pHBNbe9GIGfEiHsKjX5Cj8HIv3/WnI/3REFJwef5kCqhwrj
   3umbJ685QLh/brpckS6DrcjBbt1G/ggzk81EaD/cnhu33mTPar9Kfovsq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899123"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796070"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 08/44] x86/fault: Adjust WARN_ON for PKey fault
Date:   Thu, 27 Jan 2022 09:54:29 -0800
Message-Id: <20220127175505.851391-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Previously if a Protection key fault occurred it indicated something
very wrong because user page mappings are not supposed to be in the
kernel address space.

Now PKey faults may happen on kernel mappings if the feature is enabled.

If PKS is enabled, avoid the warning in the fault path.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/mm/fault.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d0074c6ed31a..6ed91b632eac 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1148,11 +1148,15 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
 	/*
-	 * Protection keys exceptions only happen on user pages.  We
-	 * have no user pages in the kernel portion of the address
-	 * space, so do not expect them here.
+	 * X86_PF_PK (Protection key exceptions) may occur on kernel addresses
+	 * when PKS (PKeys Supervisor) is enabled.
+	 *
+	 * However, if PKS is not enabled WARN if this exception is seen
+	 * because there are no user pages in the kernel portion of the address
+	 * space.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
+		     (hw_error_code & X86_PF_PK));
 
 #ifdef CONFIG_X86_32
 	/*
-- 
2.31.1


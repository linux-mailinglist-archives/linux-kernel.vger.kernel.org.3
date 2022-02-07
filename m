Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E94AC39E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377741AbiBGPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444030AbiBGPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:16:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DFC0401C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644246993; x=1675782993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RVfpHwKqjohdLekv0K+S7TGWa9dDO77kQ5CF3SAMaFk=;
  b=HM+IbeUMIodHB32+Z0sAIu3ctMekCd3rfUgVcxb3b8oWPBoxSocQo2By
   TeCACZqXW1VkJpQb7HOngEjx4lwg3k0JLB1rvXAZx5l1894gBaVR5xZ+j
   Zt0Abl2ObR45JIzwD+Xk809JFuI8XwH3fMxew/mji4sqt5aeC9opDGWbZ
   2zEdalfX4FdYXzZunKQ5uzE1bK7eFoo7G1nXI7pSCpQymesF2gBZtu6EZ
   gSCYz6zrD/Pi51W0YF/vZIJs7+pcC9hvws3JePMqN4izvP66/cOzB8ZRG
   aSwJ0nOoHC82LMga4xtjwdWdKcOqN6+QWAwOoVAbhoEPFvRXHTiH+SO8L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="335137274"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="335137274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 07:16:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="540139670"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 07:16:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3AFB631D; Mon,  7 Feb 2022 17:16:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v1 1/1] parisc: Add ioread64_lo_hi() and iowrite64_lo_hi()
Date:   Mon,  7 Feb 2022 17:16:39 +0200
Message-Id: <20220207151639.75086-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a followup to the previous commit f15309d7ad5d ("parisc: Add
ioread64_hi_lo() and iowrite64_hi_lo()") which does only half of
the job. Add the rest, so we won't get a new kernel test robot
reports.

Fixes: f15309d7ad5d ("parisc: Add ioread64_hi_lo() and iowrite64_hi_lo()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/parisc/lib/iomap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index 367f6397bda7..860385058085 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -346,6 +346,16 @@ u64 ioread64be(const void __iomem *addr)
 	return *((u64 *)addr);
 }
 
+u64 ioread64_lo_hi(const void __iomem *addr)
+{
+	u32 low, high;
+
+	low = ioread32(addr);
+	high = ioread32(addr + sizeof(u32));
+
+	return low + ((u64)high << 32);
+}
+
 u64 ioread64_hi_lo(const void __iomem *addr)
 {
 	u32 low, high;
@@ -419,6 +429,12 @@ void iowrite64be(u64 datum, void __iomem *addr)
 	}
 }
 
+void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	iowrite32(val, addr);
+	iowrite32(val >> 32, addr + sizeof(u32));
+}
+
 void iowrite64_hi_lo(u64 val, void __iomem *addr)
 {
 	iowrite32(val >> 32, addr + sizeof(u32));
@@ -530,6 +546,7 @@ EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 EXPORT_SYMBOL(ioread64);
 EXPORT_SYMBOL(ioread64be);
+EXPORT_SYMBOL(ioread64_lo_hi);
 EXPORT_SYMBOL(ioread64_hi_lo);
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
@@ -538,6 +555,7 @@ EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
 EXPORT_SYMBOL(iowrite64);
 EXPORT_SYMBOL(iowrite64be);
+EXPORT_SYMBOL(iowrite64_lo_hi);
 EXPORT_SYMBOL(iowrite64_hi_lo);
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF9A51CD3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387241AbiEFACh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387106AbiEFABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B3D60DAA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795073; x=1683331073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yu43tYTm3rL820NWGTlU5e3BSTdrJeh1cVn1o9Y1twQ=;
  b=XZulpZrOMMMKJxovH7naHeH3WcgDbT7/GBMVfNzwn4gIMqU3IpJ2Xfo9
   LNTvFHm0tHHKR0dr/brMB7FC1utQB27pmtGUa/OeBBB1aqR761CvgCbuz
   QZTOETcWtvH31IqGcJvw1/t7EPq4G+57GqqTy6TwAQ6tiQdz79YxxkPg1
   N97MX4odfxHaibHWYwbNU9wojq/S65Yy0h/7XnFHXJH+nV5qq7XTxW5SX
   8hRinGyNVFw4FLetuyE96LxV4LppYtlKAZbPI+VcXpv4TPgSiM9RG1th5
   RZz0N1SdLsNECXGUmigyNreqvPycb0HBsZMcgC9sao9LkU7gxmmKwe93H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283641"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283641"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914383"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:50 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v6 16/29] x86/hpet: Prepare IRQ assignments to use the X86_ALLOC_AS_NMI flag
Date:   Thu,  5 May 2022 16:59:55 -0700
Message-Id: <20220506000008.30892-17-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag X86_ALLOC_AS_NMI indicates that the IRQs to be allocated in an
IRQ domain need to be configured as NMIs.  Add an as_nmi argument to
hpet_assign_irq(). Even though the HPET clock events do not need NMI
IRQs, the HPET hardlockup detector does. A subsequent changeset will
implement the reservation of a channel for it.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/hpet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 2c6713b40921..02d25e00e93f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -618,7 +618,7 @@ static inline int hpet_dev_id(struct irq_domain *domain)
 }
 
 static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
-			   int dev_num)
+			   int dev_num, bool as_nmi)
 {
 	struct irq_alloc_info info;
 
@@ -627,6 +627,8 @@ static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 	info.data = hc;
 	info.devid = hpet_dev_id(domain);
 	info.hwirq = dev_num;
+	if (as_nmi)
+		info.flags |= X86_IRQ_ALLOC_AS_NMI;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
@@ -755,7 +757,7 @@ static void __init hpet_select_clockevents(void)
 
 		sprintf(hc->name, "hpet%d", i);
 
-		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
+		irq = hpet_assign_irq(hpet_domain, hc, hc->num, false);
 		if (irq <= 0)
 			continue;
 
-- 
2.17.1


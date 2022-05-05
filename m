Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246EF51CD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387186AbiEFACT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387104AbiEFABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D460DA1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795071; x=1683331071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3xUpwlx5TiZjojK61Skg6W12+8Hy6giKnPG/YThYLqA=;
  b=S8xjDMgbdvpuazQnaNj4yQ5YOOE5QOvopc+AOo7QodhSxRnnZbkh5buN
   ZszO4vTCACiqsBONHGlB0DMVQ9rjOsUGofKtdtkDzqDf8Kch9sL/p9zQ4
   GN+wJCdpOAUU+qbYksv+d0YnGUqodmJkYz3yGMAOOlJ1vKfG8MNRAucCp
   8Yz6ombY2VtAZsvOLIJyxOH08lhvcly/Snfv2w7nJS7ohfMYpqu4fJn6w
   GTk32aksBHBjgq1wY3to1ZpzXJdTfpW5PYdgoGDY0rF5TTL1kJcNHSUmi
   MLV7e++dHeia7l3uTs32feZmKKMvd8ApbU744v2m4cNFefTtBAUlU87+P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283633"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283633"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914367"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:49 -0700
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 12/29] iommu/amd: Enable NMIPass when allocating an NMI irq
Date:   Thu,  5 May 2022 16:59:51 -0700
Message-Id: <20220506000008.30892-13-ricardo.neri-calderon@linux.intel.com>
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

As per the AMD I/O Virtualization Technology (IOMMU) Specification, the
AMD IOMMU only remaps fixed and arbitrated MSIs. NMIs are controlled
by the NMIPass bit of a Device Table Entry. When set, the IOMMU passes
through NMI interrupt messages unmapped. Otherwise, they are aborted.

Furthermore, Section 2.2.5 Table 19 states that the IOMMU will also
abort NMIs when the destination mode is logical.

Update the NMIPass setting of a device's DTE when an NMI irq is being
allocated. Only do so when the destination mode of the APIC is not
logical.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/amd/iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e..4d7421b6858d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3156,6 +3156,15 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
 		return -EINVAL;
 
+	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+		/* Only one IRQ per NMI */
+		if (nr_irqs != 1)
+			return -EINVAL;
+
+		/* NMIs are aborted when the destination mode is logical. */
+		if (apic->dest_mode_logical)
+			return -EPERM;
+	}
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
@@ -3208,6 +3217,15 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		goto out_free_parent;
 	}
 
+	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+		if (!get_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS)) {
+			set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
+			iommu_flush_dte(iommu, devid);
+		}
+	}
+
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
 		cfg = irq_data ? irqd_cfg(irq_data) : NULL;
-- 
2.17.1


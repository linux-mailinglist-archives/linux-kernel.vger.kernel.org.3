Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A739651CD42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387175AbiEFACJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387094AbiEFABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030E60DA8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795069; x=1683331069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5M26CnkIjGrveCxZY+LFQe6aJhW+irvkad9bEfjWjOs=;
  b=n3jyQnvYgV2Ow2qEPLCBV//jLqjdjsAS0ozlvOZFgTnHu7xkh9jTFrwQ
   Em+Ml4GGTfwbio7do6pExzZjVJRQJFsPz50Cz6CrOY2fe3+J/hGd/0NnT
   vWmcVN4GQ/WucrAfUSt7F2y6ghZVU0xUEq7Wzam+K128DPanK3NUK0KyK
   YojAusZ3rROkD8qd82SZISlm6tzpDEsYoZe6Jvd6FCKi7wKM43rzAxx4v
   mOAmcfHnYEgHtrI89Qwyav8xZWzUOyDy/UV4z8l6AJfaxPLMZvTG2/Ywe
   7D/CG+x+WF37X1jknk4tAYOaTLES45ZbvkvVUY5DnwqeA0Km+nfKHqa/9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283629"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914357"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:48 -0700
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
Subject: [PATCH v6 10/29] iommu/vt-d: Implement minor tweaks for NMI irqs
Date:   Thu,  5 May 2022 16:59:49 -0700
Message-Id: <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
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

The Intel IOMMU interrupt remapping driver already programs correctly the
delivery mode of individual irqs as per their irq_data. Improve handling
of NMIs. Allow only one irq per NMI. Also, it is not necessary to cleanup
irq vectors after updating affinity. NMIs do not have associated vectors.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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
 drivers/iommu/intel/irq_remapping.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index fb2d71bea98d..791a9331e257 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1198,8 +1198,12 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * After this point, all the interrupts will start arriving
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
+	 *
+	 * Do it only for non-NMI irqs. NMIs don't have associated
+	 * vectors.
 	 */
-	send_cleanup_vector(cfg);
+	if (cfg->delivery_mode != APIC_DELIVERY_MODE_NMI)
+		send_cleanup_vector(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -1352,6 +1356,9 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
+	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
+		return -EINVAL;
+
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
-- 
2.17.1


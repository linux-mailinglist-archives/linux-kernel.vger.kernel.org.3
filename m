Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57051CD45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387250AbiEFACj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387108AbiEFABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD0D61295
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795071; x=1683331071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=60YeowQrYtVQTC/Y9/6aG1nPAySkU1vh5niJqWVSb28=;
  b=WYRBDqbmyC1mf2GOXxhmq7iTYY4kZm8YZd6zHR5HrpZdJG0d5mn5A3Uh
   mWuTcc9mFgLkgsFDQQMPs1B3YHjFmH+I5yjpBiOSPLKK8lY2n+uAsxXfi
   HZ4OxCQBdvlJGevFPGWn6QBJwNrpFzrBFj44UVKT/5KrOJ6uyOSLsgMuW
   oJ1T+0uPxI1hKNLiwPxcBpBGSO0ep8OlzZOrlxNtJLgMGWBxfF4ZjPZIt
   iwA1Ff1o/UnehMLB/Ojzpc1faC3A03+kgaPK4aiHwv815hdA9I+cYLqAU
   wW19A6XL5bYAeScnXC35V3y4mxWspD3M8nZb92Ad6nWOFHQtUhGv8PrxY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283636"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283636"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914372"
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
Subject: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs in non-IR format
Date:   Thu,  5 May 2022 16:59:52 -0700
Message-Id: <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
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

If NMIPass is enabled in a device's DTE, the IOMMU lets NMI interrupt
messages pass through unmapped. Therefore, the contents of the MSI
message, not an IRTE, determine how and where the NMI is delivered.

Since the IOMMU driver owns the MSI message of the NMI irq, compose
it using the non-interrupt-remapping format. Also, let descendant
irqchips write the MSI as appropriate for the device.

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
 drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d7421b6858d..6e07949b3e2a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3111,7 +3111,16 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		fill_msi_msg(&data->msi_entry, irte_info->index);
+		if (irq_cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+			/*
+			 * The IOMMU lets NMIs pass through unmapped. Thus, the
+			 * MSI message, not the IRTE, determines the irq
+			 * configuration. Since we own the MSI message,
+			 * compose it. Descendant irqchips will write it.
+			 */
+			__irq_msi_compose_msg(irq_cfg, &data->msi_entry, true);
+		else
+			fill_msi_msg(&data->msi_entry, irte_info->index);
 		break;
 
 	default:
@@ -3509,6 +3518,18 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 */
 	send_cleanup_vector(cfg);
 
+	/*
+	 * When the delivery mode of an irq is NMI, the IOMMU lets the NMI
+	 * interrupt messages pass through unmapped. Hence, changes in the
+	 * destination are to be reflected in the NMI message itself, not the
+	 * IRTE. Thus, descendant irqchips must set the affinity and compose
+	 * write the MSI message.
+	 *
+	 * Also, NMIs do not have an associated vector. No need for cleanup.
+	 */
+	if (cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return IRQ_SET_MASK_OK;
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-- 
2.17.1


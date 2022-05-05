Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD351CD46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387163AbiEFACE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387070AbiEFABb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309E60DB7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795069; x=1683331069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UTXQyhtYGmsXw7bhN7zaVr8NO2RbQS3Z18S2QU+fmiU=;
  b=bAi8KwMmiiRz11vHIlPSx5xBISbI+rV/zdITXHwh/BVlhd6RqYfbHxUA
   zmGvQzC7N27/aUzi//Bd0cloTmrRnKqwXfauyBZAPIQ/f9lQ1UYVBzBs3
   05dvNEkP/UIl0xzgNe1adz4rD+BNXiLR1o5kQzFcXj1lVnv7EbtYbw9Wb
   NnfF5S553k2QT7bt+TVtNRYvo2Zt9hSWJORaOujxImmxx5+/XWSqmLttM
   9rU9IZwK739fnLf256bidM41NAW8MZr8q6GNgVNQHyAaIPxWxMQ7FWVLO
   CSfqVz1cz/jrM31K2bjNamXnALYtAAwjCxOiolobPJCEFt4H6psI8ZqjJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283625"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283625"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914350"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:47 -0700
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
Subject: [PATCH v6 08/29] iommu/vt-d: Rework prepare_irte() to support per-IRQ delivery mode
Date:   Thu,  5 May 2022 16:59:47 -0700
Message-Id: <20220506000008.30892-9-ricardo.neri-calderon@linux.intel.com>
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

struct irq_cfg::delivery_mode specifies the delivery mode of each IRQ
separately. Configuring the delivery mode of an IRTE would require adding
a third argument to prepare_irte(). Instead, simply take a pointer to the
irq_cfg for which an IRTE is being configured. This change does not cause
functional changes.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Only change the signature of prepare_irte(). A separate patch changes
   the setting of the delivery_mode.

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch.
---
 drivers/iommu/intel/irq_remapping.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index d2764a71f91a..66d37186ec28 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1111,7 +1111,7 @@ void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
 	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
 }
 
-static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
+static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -1126,8 +1126,8 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	*/
 	irte->trigger_mode = 0;
 	irte->dlvry_mode = apic->delivery_mode;
-	irte->vector = vector;
-	irte->dest_id = IRTE_DEST(dest);
+	irte->vector = irq_cfg->vector;
+	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 
 	/*
 	 * When using the destination mode of physical APICID, only the
@@ -1278,8 +1278,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 {
 	struct irte *irte = &data->irte_entry;
 
-	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
-
+	prepare_irte(irte, irq_cfg);
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41851CD33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381614AbiEFACH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387071AbiEFABb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81460DB9
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795069; x=1683331069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5aqgNQHykrRDChcwPWM1DjTNVBAFYGhJ4hN9bwVMei0=;
  b=RA2xMnQYXJ6kezS5sIydBflhJ2grYm53g7pjI8DBRErQ4+8L885GiJeC
   lboDZ5/DScCzQn42sV0W8SX/BALOltkD9HSds4hm6hN3OAe1qqHuuUmwR
   +AdnyZC6YL8uJto7xsuMUKbkBBbN2VzZonE9+sFTGS5eRZJquxoXlTKmc
   XvbEUTVQl9ZJYaLAYsx7IRb6AERn/87zGACkBnxKdwu6hUQL19WdbJfhL
   DqHLYvIbECthUsy8CGJzQjnMWQSbBBul68Dos68QXtcYNUWmRgz4TJJaN
   w7UrfeemYvhWRv+2QuzSLsmfW8DLb676Y3tGuVwmH1w0AdzfgvBKQUe4y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283628"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283628"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914353"
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
Subject: [PATCH v6 09/29] iommu/vt-d: Set the IRTE delivery mode individually for each IRQ
Date:   Thu,  5 May 2022 16:59:48 -0700
Message-Id: <20220506000008.30892-10-ricardo.neri-calderon@linux.intel.com>
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

There are no hardware requirements to use the same delivery mode for all
interrupts. Use the mode specified in the provided IRQ hardware
configuration data. Since all IRQs are configured to use the delivery mode
of the APIC drive, the only functional changes are where IRQs are
configured to use a specific delivery mode.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
 drivers/iommu/intel/irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 66d37186ec28..fb2d71bea98d 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1125,7 +1125,7 @@ static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->delivery_mode;
+	irte->dlvry_mode = irq_cfg->delivery_mode;
 	irte->vector = irq_cfg->vector;
 	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 
-- 
2.17.1


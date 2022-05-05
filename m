Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13D751CD34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387155AbiEFAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387056AbiEFAB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7E60DBD
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795068; x=1683331068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s6kx2WD+U+gm4lQdJ9AXtLnfiPC2EdKdrJZetgovSOw=;
  b=LAQSZFRt0VfLpAxWTIJ93sXM7+vniu54efLdIofxKBwFoy9j7jF3poZ5
   YtcyHPYKJORJ67r9K34BiOafHzmMr7xizSFXrQIahVDwbd382b2M4r+2J
   z7gCod/C8XrRSfOc4a0D4yuhlhXRUIKdp5pZkZ3jJk+PxhZZXYMyrnl1D
   hE6bs1vl5j7gXoamhTPtbXo0Jq3bPAr2Ko5mSaZWHh4GoH0sFHCeBtiy7
   VlIRq063rDeI1TUYi4Vd21NNwkMz/Eqi+Pr24XryCbfr0G2z/YRHn59em
   3jT8t3/W+CgWaBuiSLhbCg8loti/KQDXj8LmcsLKgDvvSFuSiDVmEOwvB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283623"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914346"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:46 -0700
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
Subject: [PATCH v6 07/29] iommu/vt-d: Clear the redirection hint when the destination mode is physical
Date:   Thu,  5 May 2022 16:59:46 -0700
Message-Id: <20220506000008.30892-8-ricardo.neri-calderon@linux.intel.com>
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

When the destination mode of an interrupt is physical APICID, the interrupt
is delivered only to the single CPU of which the physical APICID is
specified in the destination ID field. Therefore, the redirection hint is
meaningless.

Furthermore, on certain processors, the IOMMU does not deliver the
interrupt when the delivery mode is NMI, the redirection hint is set, and
the destination mode is physical. Clearing the redirection hint ensures
that the NMI is delivered.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Ashok Raj <ashok.raj@intel.com>
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
 drivers/iommu/intel/irq_remapping.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a67319597884..d2764a71f91a 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1128,7 +1128,17 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->dlvry_mode = apic->delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
-	irte->redir_hint = 1;
+
+	/*
+	 * When using the destination mode of physical APICID, only the
+	 * processor specified in @dest receives the interrupt. Thus, the
+	 * redirection hint is meaningless.
+	 *
+	 * Furthermore, on some processors, NMIs with physical delivery mode
+	 * and the redirection hint set are delivered as regular interrupts
+	 * or not delivered at all.
+	 */
+	irte->redir_hint = apic->dest_mode_logical;
 }
 
 struct irq_remap_ops intel_irq_remap_ops = {
-- 
2.17.1


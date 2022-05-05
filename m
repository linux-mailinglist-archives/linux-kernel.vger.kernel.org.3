Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF78E51CD36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387147AbiEFABz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387045AbiEFAB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A271160DA8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795067; x=1683331067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=D+sZP1VTaO2AD2PX2fNF30e9SIwhyViy7LM9jGqhP5M=;
  b=bsFDga76t8yiZChb3uUw+latfT3p6I20MC2+fZHfDlCOAUBGkh1sfEnK
   kpA+4PHEQeJp2QKk2dmULVMptvy+0tugwMIlITxS1dXtNcHIr8TTLsb+R
   FBXUEP23YSB3msNH5hKY9OuEXCMmUFN26M95esj7vjiaHGZUNTdilajVW
   aOSwA/bIspzJKJ3jESRzQ4fy6uNOS+26V3UT8MoEd1NtqX7Dc3c5P6Abd
   +KzCkmzSOf+LnaKnCNi/zsWpQAxr0fqvN48Iy2djIyPkI4O3u9MiEkbCO
   iD93KjAxh94L0XD/d7VA5jJ1GHbUcusVnvr1Cxs0yOCXclfmlAgeNSQBY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283619"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283619"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914338"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:45 -0700
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
Subject: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
Date:   Thu,  5 May 2022 16:59:44 -0700
Message-Id: <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
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

Vectors are meaningless when allocating IRQs with NMI as the delivery mode.
In such case, skip the reservation of IRQ vectors. Do it in the lowest-
level functions where the actual IRQ reservation takes place.

Since NMIs target specific CPUs, keep the functionality to find the best
CPU.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
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
 arch/x86/kernel/apic/vector.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 838e220e8860..11f881f45cec 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -245,11 +245,20 @@ assign_vector_locked(struct irq_data *irqd, const struct cpumask *dest)
 	if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
 		return -EBUSY;
 
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
+		cpu = irq_matrix_find_best_cpu(vector_matrix, dest);
+		apicd->cpu = cpu;
+		vector = 0;
+		goto no_vector;
+	}
+
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
 	trace_vector_alloc(irqd->irq, vector, resvd, vector);
 	if (vector < 0)
 		return vector;
 	apic_update_vector(irqd, vector, cpu);
+
+no_vector:
 	apic_update_irq_cfg(irqd, vector, cpu);
 
 	return 0;
@@ -321,12 +330,22 @@ assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
 	/* set_affinity might call here for nothing */
 	if (apicd->vector && cpumask_test_cpu(apicd->cpu, vector_searchmask))
 		return 0;
+
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
+		cpu = irq_matrix_find_best_cpu_managed(vector_matrix, dest);
+		apicd->cpu = cpu;
+		vector = 0;
+		goto no_vector;
+	}
+
 	vector = irq_matrix_alloc_managed(vector_matrix, vector_searchmask,
 					  &cpu);
 	trace_vector_alloc_managed(irqd->irq, vector, vector);
 	if (vector < 0)
 		return vector;
 	apic_update_vector(irqd, vector, cpu);
+
+no_vector:
 	apic_update_irq_cfg(irqd, vector, cpu);
 	return 0;
 }
@@ -376,6 +395,10 @@ static void x86_vector_deactivate(struct irq_domain *dom, struct irq_data *irqd)
 	if (apicd->has_reserved)
 		return;
 
+	/* NMI IRQs do not have associated vectors; nothing to do. */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	clear_irq_vector(irqd);
 	if (apicd->can_reserve)
@@ -472,6 +495,10 @@ static void vector_free_reserved_and_managed(struct irq_data *irqd)
 	trace_vector_teardown(irqd->irq, apicd->is_managed,
 			      apicd->has_reserved);
 
+	/* NMI IRQs do not have associated vectors; nothing to do. */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	if (apicd->has_reserved)
 		irq_matrix_remove_reserved(vector_matrix);
 	if (apicd->is_managed)
-- 
2.17.1


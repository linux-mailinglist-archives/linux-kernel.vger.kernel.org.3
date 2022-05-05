Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5D51CD17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387083AbiEFABj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387042AbiEFAB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3C60DAA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795066; x=1683331066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zlyJMMAdck3m7Lj6IAc06Z99mVZqGJ1kJoeEJPS6nAw=;
  b=EMQWTlsJIFEbbzkVX/qDkiVTjIupuSyobroCQk2Chn46yZXbG1L5B5ih
   J5o6Hn8/dKD/2lTg0UQ6YR+UNYgBmY04x/sVc7ovwDbazPi9tOTrpn/vW
   b5zF4NjgxR/4U/2Ax3qtqyJq3ENzFdETdbw7u7AvT+MSCfJOK5ic60X/r
   awXYLbbzdO8vJSXPzOIsC5YkRblhBrXMj+4q7zdppescKjvTe4STHI92j
   OjtR/3ECqpNHRSHw6Q6upqU4/E6QYzgLCRhQdwRW3J3vs3xCFC+91sTdT
   9xytodTz9CUu6CfgNJylVmGAJTOlOqI8hpkAp27eMuyFUQhywS8e+8vlZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283612"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914325"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:44 -0700
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
Subject: [PATCH v6 02/29] x86/apic: Add irq_cfg::delivery_mode
Date:   Thu,  5 May 2022 16:59:41 -0700
Message-Id: <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
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

Currently, the delivery mode of all interrupts is set to the mode of the
APIC driver in use. There are no restrictions in hardware to configure the
delivery mode of each interrupt individually. Also, certain IRQs need to be
configured with a specific delivery mode (e.g., NMI).

Add a new member, delivery_mode, to struct irq_cfg. Subsequent changesets
will update every irq_domain to set the delivery mode of each IRQ to that
specified in its irq_cfg data.

To keep the current behavior, when allocating an IRQ in the root domain
(i.e., the x86_vector_domain), set the delivery mode of the IRQ as that of
the APIC driver.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Updated indentation of the existing members of struct irq_cfg.
 * Reworded the commit message.

Changes since v4:
 * Rebased to use new enumeration apic_delivery_modes.

Changes since v3:
 * None

Changes since v2:
 * Reduced scope to only add the interrupt delivery mode in
   struct irq_alloc_info.

Changes since v1:
 * Introduced this patch.
---
 arch/x86/include/asm/hw_irq.h | 5 +++--
 arch/x86/kernel/apic/vector.c | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece58151..5ac5e6c603ee 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -88,8 +88,9 @@ struct irq_alloc_info {
 };
 
 struct irq_cfg {
-	unsigned int		dest_apicid;
-	unsigned int		vector;
+	unsigned int			dest_apicid;
+	unsigned int			vector;
+	enum apic_delivery_modes	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3e6f6b448f6a..838e220e8860 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -567,6 +567,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+
 		/*
 		 * Prevent that any of these interrupts is invoked in
 		 * non interrupt context via e.g. generic_handle_irq()
@@ -577,6 +578,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		/* Don't invoke affinity setter on deactivated interrupts */
 		irqd_set_affinity_on_activate(irqd);
 
+		/*
+		 * Initialize the delivery mode of this irq to match the
+		 * default delivery mode of the APIC. Children irq domains
+		 * may take the delivery mode from the individual irq
+		 * configuration rather than from the APIC driver.
+		 */
+		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
-- 
2.17.1


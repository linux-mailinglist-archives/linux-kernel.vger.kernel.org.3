Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62C51CD41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387096AbiEFABv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387046AbiEFAB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32860DBA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795067; x=1683331067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eY8ASsd7/aj+9aYNbmEq9GanUaeYVEui2oMFa5HCVds=;
  b=YMXxjxb13scJhai/c9kcuT3e1y9qaoy8f8nlPRARxffbHqPCprnB4xfO
   hXwBos4I70Mr0AyRixDeh0aN79ZtIDaIG1Dz8PuAeI+PvSgy8G8bpns7S
   cxeaF1gkEOeTa+Fx4vLn+VMg4qS7lHeWQd0g987MT5o2HktG/NKS+w+Sm
   bhqDCKkDSeA+aROvxoKiHyhVomN3jeiXj8uFyD4cz01pGe7b6on/BNeAu
   R7fjAvc1VUbT9L0kftyrHRrs9H2YY2tZabw9xYbnOtugI/6zp3kkuUdOd
   ZdEun7Ym253F4N6UesRlY0S74D2prZjSJBNM4rOBQ4824LeMQ6MBAr7Yt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283621"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283621"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914342"
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
Subject: [PATCH v6 06/29] x86/apic/vector: Implement support for NMI delivery mode
Date:   Thu,  5 May 2022 16:59:45 -0700
Message-Id: <20220506000008.30892-7-ricardo.neri-calderon@linux.intel.com>
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

The flag X86_IRQ_ALLOC_AS_NMI indicates to the interrupt controller that
it should configure the delivery mode of an IRQ as NMI. Implement such
request. This causes irq_domain children in the hierarchy to configure
their irq_chips accordingly. When no specific delivery mode is requested,
continue using the delivery mode of the APIC driver in use.

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
 arch/x86/kernel/apic/vector.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 11f881f45cec..df4d7b9f6e27 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -570,6 +570,10 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
 		return -ENOSYS;
 
+	/* Only one IRQ per NMI */
+	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
+		return -EINVAL;
+
 	/*
 	 * Catch any attempt to touch the cascade interrupt on a PIC
 	 * equipped system.
@@ -610,7 +614,15 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		 * default delivery mode of the APIC. Children irq domains
 		 * may take the delivery mode from the individual irq
 		 * configuration rather than from the APIC driver.
+		 *
+		 * Vectors are meaningless if the delivery mode is NMI. Since
+		 * nr_irqs is 1, we can return.
 		 */
+		if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+			apicd->hw_irq_cfg.delivery_mode = APIC_DELIVERY_MODE_NMI;
+			return 0;
+		}
+
 		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
 
 		/*
-- 
2.17.1


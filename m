Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74351CD14
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387055AbiEFABa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387038AbiEFAB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179347045
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795065; x=1683331065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gFAa9l6D17AE+FwqBH16mNyyvqzE44nr84f76LNdCPk=;
  b=Klc7g6ZRUz9pfifhY4ADEr1KVFzmxuB1bLbuE+GVpCHib1bSR2ZOXkik
   aKG9gI5qaPXwCA1oyhfEtfTUnflD50MBwMFU9k2FRJHQf/V2Qjo7Q2xey
   juA0Lenk9YkpnmPU/+Y2J9n8vM4DwPXyy4S+dKHi42fGnpFTsMSYJ3d5Q
   rBkZuSkG6lrmb0pWElZ+mmQTRiCO6DP9YtYr/Eznti7Zu1Y6XBmBECJms
   M4I344Kp+CcF6aKSqS9czTZs9KfPJgYuE4CHeO4sJo174VoJZO1+iLxHS
   HvqQgDa9t3GuQyt0Qv522j62iK2XlLyA4qPXjFMM4XEiL9zG6WXmABJnA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283608"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914319"
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
Subject: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the best CPU for new vectors
Date:   Thu,  5 May 2022 16:59:40 -0700
Message-Id: <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
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

Certain types of interrupts, such as NMI, do not have an associated vector.
They, however, target specific CPUs. Thus, when assigning the destination
CPU, it is beneficial to select the one with the lowest number of vectors.
Prepend the functions matrix_find_best_cpu_managed() and
matrix_find_best_cpu_managed() with the irq_ prefix and expose them for
IRQ controllers to use when allocating and activating vector-less IRQs.

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
 include/linux/irq.h |  4 ++++
 kernel/irq/matrix.c | 32 +++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index f92788ccdba2..9e674e73d295 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1223,6 +1223,10 @@ struct irq_matrix *irq_alloc_matrix(unsigned int matrix_bits,
 void irq_matrix_online(struct irq_matrix *m);
 void irq_matrix_offline(struct irq_matrix *m);
 void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit, bool replace);
+unsigned int irq_matrix_find_best_cpu(struct irq_matrix *m,
+				      const struct cpumask *msk);
+unsigned int irq_matrix_find_best_cpu_managed(struct irq_matrix *m,
+					      const struct cpumask *msk);
 int irq_matrix_reserve_managed(struct irq_matrix *m, const struct cpumask *msk);
 void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk);
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77645ac..810479f608f4 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -125,9 +125,16 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 	return area;
 }
 
-/* Find the best CPU which has the lowest vector allocation count */
-static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
-					const struct cpumask *msk)
+/**
+ * irq_matrix_find_best_cpu() - Find the best CPU for an IRQ
+ * @m:		Matrix pointer
+ * @msk:	On which CPUs the search will be performed
+ *
+ * Find the best CPU which has the lowest vector allocation count
+ * Returns: The best CPU to use
+ */
+unsigned int irq_matrix_find_best_cpu(struct irq_matrix *m,
+				      const struct cpumask *msk)
 {
 	unsigned int cpu, best_cpu, maxavl = 0;
 	struct cpumap *cm;
@@ -146,9 +153,16 @@ static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 	return best_cpu;
 }
 
-/* Find the best CPU which has the lowest number of managed IRQs allocated */
-static unsigned int matrix_find_best_cpu_managed(struct irq_matrix *m,
-						const struct cpumask *msk)
+/**
+ * irq_matrix_find_best_cpu_managed() - Find the best CPU for a managed IRQ
+ * @m:		Matrix pointer
+ * @msk:	On which CPUs the search will be performed
+ *
+ * Find the best CPU which has the lowest number of managed IRQs allocated
+ * Returns: The best CPU to use
+ */
+unsigned int irq_matrix_find_best_cpu_managed(struct irq_matrix *m,
+					      const struct cpumask *msk)
 {
 	unsigned int cpu, best_cpu, allocated = UINT_MAX;
 	struct cpumap *cm;
@@ -292,7 +306,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 	if (cpumask_empty(msk))
 		return -EINVAL;
 
-	cpu = matrix_find_best_cpu_managed(m, msk);
+	cpu = irq_matrix_find_best_cpu_managed(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;
 
@@ -381,13 +395,13 @@ int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
 	struct cpumap *cm;
 
 	/*
-	 * Not required in theory, but matrix_find_best_cpu() uses
+	 * Not required in theory, but irq_matrix_find_best_cpu() uses
 	 * for_each_cpu() which ignores the cpumask on UP .
 	 */
 	if (cpumask_empty(msk))
 		return -EINVAL;
 
-	cpu = matrix_find_best_cpu(m, msk);
+	cpu = irq_matrix_find_best_cpu(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC9583B39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiG1J2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiG1J2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:28:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D85D65837
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35EA5B82381
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D238CC433D6;
        Thu, 28 Jul 2022 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659000490;
        bh=lk5BBdnVMgk5f2fm1o9PA39S1U41Y9NR+a2cIo5is50=;
        h=From:To:Cc:Subject:Date:From;
        b=a/grYEPqQL38OVfRghnD9V/a7+DIS4nogaAWl5r9GYXd0YDZishRRTVE4I3IQQsVl
         D9ImpTy3RloRs8uRlr/GziCsMYx8VNvoIdMybVVZS+rhqd3gzr8H8m+PnCT8p+5G0N
         DkP+qGqp1unTiTh7UcLUmGMhO7DgzY31UvXofEniKw2gVUHLkMZl6N+skbthcrCiBb
         7H2uug+7/XwU9w+3zHprD3lkJEWfkzSZEw3l4DWF4mBS1HXW4PR03CU8n1LFg06eAB
         jYJyBdSm3nirgoyK+weGQU8ev8DN3KMRwX/MidAsj7LcJti/z2U1Lj79TsR/siSsZL
         fN8K90KrH7x2g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oGzod-0005WP-1t; Thu, 28 Jul 2022 11:28:23 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] irqdomain: Fix mapping-creation race
Date:   Thu, 28 Jul 2022 11:27:10 +0200
Message-Id: <20220728092710.21190-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parallel probing (e.g. due to asynchronous probing) of devices that share
interrupts can currently result in two mappings for the same hardware
interrupt to be created.

Add a serialising mapping mutex so that looking for an existing mapping
before creating a new one is done atomically.

Note that serialising the lookup and creation in
irq_create_mapping_affinity() would have been enough to prevent the
duplicate mapping, but that could instead cause
irq_create_fwspec_mapping() to fail when there is a race.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Fixes: b62b2cf5759b ("irqdomain: Fix handling of type settings for existing mappings")
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 46 +++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fe1da9614ee..d263a7dd4170 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -22,6 +22,7 @@
 
 static LIST_HEAD(irq_domain_list);
 static DEFINE_MUTEX(irq_domain_mutex);
+static DEFINE_MUTEX(irq_mapping_mutex);
 
 static struct irq_domain *irq_default_domain;
 
@@ -669,7 +670,7 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 #endif
 
 /**
- * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
+ * __irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
  * @domain: domain owning this hardware interrupt or NULL for default domain
  * @hwirq: hardware irq number in that domain space
  * @affinity: irq affinity
@@ -679,9 +680,9 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
  * If the sense/trigger is to be specified, set_irq_type() should be called
  * on the number returned from that call.
  */
-unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
-				       irq_hw_number_t hwirq,
-				       const struct irq_affinity_desc *affinity)
+static unsigned int __irq_create_mapping_affinity(struct irq_domain *domain,
+						  irq_hw_number_t hwirq,
+						  const struct irq_affinity_desc *affinity)
 {
 	struct device_node *of_node;
 	int virq;
@@ -724,6 +725,19 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 
 	return virq;
 }
+
+unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
+					 irq_hw_number_t hwirq,
+					 const struct irq_affinity_desc *affinity)
+{
+	unsigned int virq;
+
+	mutex_lock(&irq_mapping_mutex);
+	virq = __irq_create_mapping_affinity(domain, hwirq, affinity);
+	mutex_unlock(&irq_mapping_mutex);
+
+	return virq;
+}
 EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
 
 static int irq_domain_translate(struct irq_domain *d,
@@ -789,6 +803,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
 		type &= IRQ_TYPE_SENSE_MASK;
 
+	mutex_lock(&irq_mapping_mutex);
+
 	/*
 	 * If we've already configured this interrupt,
 	 * don't do it again, or hell will break loose.
@@ -801,7 +817,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * interrupt number.
 		 */
 		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
-			return virq;
+			goto out;
 
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -810,26 +826,26 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
 			irq_data = irq_get_irq_data(virq);
 			if (!irq_data)
-				return 0;
+				goto err;
 
 			irqd_set_trigger_type(irq_data, type);
-			return virq;
+			goto out;
 		}
 
 		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
 			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
-		return 0;
+		goto err;
 	}
 
 	if (irq_domain_is_hierarchy(domain)) {
 		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
 		if (virq <= 0)
-			return 0;
+			goto err;
 	} else {
 		/* Create mapping */
-		virq = irq_create_mapping(domain, hwirq);
+		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
 		if (!virq)
-			return virq;
+			goto err;
 	}
 
 	irq_data = irq_get_irq_data(virq);
@@ -838,13 +854,19 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 			irq_domain_free_irqs(virq, 1);
 		else
 			irq_dispose_mapping(virq);
-		return 0;
+		goto err;
 	}
 
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
+out:
+	mutex_unlock(&irq_mapping_mutex);
 
 	return virq;
+err:
+	mutex_unlock(&irq_mapping_mutex);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
 
-- 
2.35.1


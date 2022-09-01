Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789D55A9A48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiIAO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiIAO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76132D93
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A3061D10
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CF3C4347C;
        Thu,  1 Sep 2022 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662042501;
        bh=6H3NdcsF1XZsaJlgrF7qf48qrgCNTKj+8GVztoNi+DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRIe1LiMDcg/qzTXHySXOgir56mX854wgQ2iVmmj977mh+JHZcizucJ9xtRu5KwKp
         qLxipWU0PGjGCNolfAgOBrWkTyznYyEn5C96bOB7K3FyPZxf3DZhy8qaBYR73y/92E
         MyXG6g1ekf+16rKJ3IXfxdGkOsPhDgSkdUxLkNdUEQwtbjlFpIlX2AC3PYx/6Unudu
         qvDXPY4vgQHz0pX1BidYiaxZNXyRUaM+hn71cQuE/jJe83qw10jpONdDFeKkWl0Y3/
         wkBHglpYCvP9Sa6toiuv4E4MLlUdTcq09U89qsafQFcL/fXviTceuqcNDi9OlWDFnd
         cp/aLqiUROoJg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oTlB8-0003Zq-VK; Thu, 01 Sep 2022 16:28:22 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 2/4] irqdomain: Fix mapping-creation race
Date:   Thu,  1 Sep 2022 16:28:14 +0200
Message-Id: <20220901142816.13731-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901142816.13731-1-johan+linaro@kernel.org>
References: <20220901142816.13731-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Fixes: b62b2cf5759b ("irqdomain: Fix handling of type settings for existing mappings")
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/YuJXMHoT4ijUxnRb@hovoldconsulting.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 33 ++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 00d577f90883..8df9b9586e29 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -144,6 +144,7 @@ struct irq_domain_chip_generic;
  *             core code.
  * @flags: host per irq_domain flags
  * @mapcount: The number of mapped interrupts
+ * @map_mutex: Mapping lock
  *
  * Optional elements
  * @fwnode: Pointer to firmware node associated with the irq_domain. Pretty easy
@@ -168,6 +169,7 @@ struct irq_domain {
 	void *host_data;
 	unsigned int flags;
 	unsigned int mapcount;
+	struct mutex map_mutex;
 
 	/* Optional data */
 	struct fwnode_handle *fwnode;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 24ddd8d9b597..1af1d141e165 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -215,6 +215,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
 	mutex_init(&domain->revmap_mutex);
+	mutex_init(&domain->map_mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
@@ -721,14 +722,20 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 		return 0;
 	}
 
+	mutex_lock(&domain->map_mutex);
+
 	/* Check if mapping already exists */
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
 		pr_debug("existing mapping on virq %d\n", virq);
-		return virq;
+		goto out;
 	}
 
-	return __irq_create_mapping_affinity(domain, hwirq, affinity);
+	virq = __irq_create_mapping_affinity(domain, hwirq, affinity);
+out:
+	mutex_unlock(&domain->map_mutex);
+
+	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
 
@@ -795,6 +802,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
 		type &= IRQ_TYPE_SENSE_MASK;
 
+	mutex_lock(&domain->map_mutex);
+
 	/*
 	 * If we've already configured this interrupt,
 	 * don't do it again, or hell will break loose.
@@ -807,7 +816,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * interrupt number.
 		 */
 		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
-			return virq;
+			goto out;
 
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -816,26 +825,26 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
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
 		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
 		if (!virq)
-			return virq;
+			goto err;
 	}
 
 	irq_data = irq_get_irq_data(virq);
@@ -844,13 +853,19 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 			irq_domain_free_irqs(virq, 1);
 		else
 			irq_dispose_mapping(virq);
-		return 0;
+		goto err;
 	}
 
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
+out:
+	mutex_unlock(&domain->map_mutex);
 
 	return virq;
+err:
+	mutex_unlock(&domain->map_mutex);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
 
-- 
2.35.1


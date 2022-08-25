Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4655A08AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiHYGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHYGLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:11:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9400B9C8E0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:11:34 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MCsvj2bFQz1N7Yq;
        Thu, 25 Aug 2022 14:08:01 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 14:11:31 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <samuel@sholland.org>,
        <brgl@bgdev.pl>, <andy.shevchenko@gmail.com>,
        <mikelley@microsoft.com>, <lvjianmin@loongson.cn>,
        <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>
Subject: [PATCH 2/2] irqchip/gic-v3-its: Release the allocated but unmapped bits in LPI maps
Date:   Thu, 25 Aug 2022 14:08:19 +0800
Message-ID: <20220825060819.74303-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825060819.74303-1-liaochang1@huawei.com>
References: <20220825060819.74303-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one hwirq allocated in ITS domain followed by some unmapped bits, the
number of unmapped bits will be recorded, so that this hwirq and
following unmapped bits could be released both.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Link: https://lore.kernel.org/lkml/3d3d0155e66429968cb4f6b4feeae4b3@kernel.org/
---
 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de6c48f..36a1bc88e832 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3572,11 +3572,19 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		irqd = irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
+		irqd_set_dangling(irqd, 0);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
 	}
 
+	/*
+	 * In order to free dangling hwirq bits, kernel uses the irq_data
+	 * of hwirq which is followed by dangling bits to record dangling
+	 * number.
+	 */
+	irqd_set_dangling(irqd, (1 << get_count_order(nr_irqs)) - nr_irqs);
+
 	return 0;
 }
 
@@ -3617,12 +3625,16 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_node *its = its_dev->its;
+	unsigned int pos = its_get_event_id(d);
 	int i;
 
-	bitmap_release_region(its_dev->event_map.lpi_map,
-			      its_get_event_id(irq_domain_get_irq_data(domain, virq)),
+	bitmap_release_region(its_dev->event_map.lpi_map, pos,
 			      get_count_order(nr_irqs));
 
+	for (i = 0; i < d->dangling; i++)
+		bitmap_release_region(its_dev->event_map.lpi_map,
+				      pos + nr_irqs + i, get_count_order(1));
+
 	for (i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(domain,
 								virq + i);
-- 
2.17.1


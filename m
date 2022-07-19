Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4157935B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiGSGjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiGSGjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:39:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0824D27167
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:39:13 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ln8Jp2klZzlVys;
        Tue, 19 Jul 2022 14:37:30 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 14:39:10 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>,
        <weiyongjun1@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH v2 -next 2/2] irqdomain: Replace revmap_direct_max_irq field with hwirq_max field
Date:   Tue, 19 Jul 2022 06:36:41 +0000
Message-ID: <20220719063641.56541-3-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719063641.56541-1-xuqiang36@huawei.com>
References: <20220719063641.56541-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit "4f86a06e2d6e irqdomain: Make normal and nomap irqdomains exclusive",
use revmap_size field instead of revmap_direct_max_irq. revmap_size field
originally indicates the maximum hwirq of linear Mapping. This results in
revmap_size having two different layers of meaning that can be confusing.

This patch optimization point is to solve this confusion point. During
direct mapping, the values of hwirq_max and revmap_direct_max_irq are the same
and have the same meanings. They both indicate the maximum hwirq supported by
direct Mapping. The optimization method is to delete revmap_direct_max_irq
field and use hwirq_max instead of revmap_direct_max_irq.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 kernel/irq/irqdomain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 481abb885d61..8fe1da9614ee 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -147,7 +147,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	static atomic_t unknown_domains;
 
 	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
+		    (direct_max && (direct_max != hwirq_max))))
 		return NULL;
 
 	domain = kzalloc_node(struct_size(domain, revmap, size),
@@ -219,7 +220,6 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	domain->hwirq_max = hwirq_max;
 
 	if (direct_max) {
-		size = direct_max;
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
 	}
 
@@ -650,9 +650,9 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 		pr_debug("create_direct virq allocation failed\n");
 		return 0;
 	}
-	if (virq >= domain->revmap_size) {
-		pr_err("ERROR: no free irqs available below %i maximum\n",
-			domain->revmap_size);
+	if (virq >= domain->hwirq_max) {
+		pr_err("ERROR: no free irqs available below %lu maximum\n",
+			domain->hwirq_max);
 		irq_free_desc(virq);
 		return 0;
 	}
@@ -906,7 +906,7 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 		return desc;
 
 	if (irq_domain_is_nomap(domain)) {
-		if (hwirq < domain->revmap_size) {
+		if (hwirq < domain->hwirq_max) {
 			data = irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq == hwirq)
 				desc = irq_data_to_desc(data);
-- 
2.17.1


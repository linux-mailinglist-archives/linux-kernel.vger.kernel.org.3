Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC545A73F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiHaCg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHaCgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:36:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE009C525
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:36:51 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHSs33yVYz1N7dG;
        Wed, 31 Aug 2022 10:33:11 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 10:36:49 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>
Subject: [PATCH V2] irqchip/gic-v3-its: Reclaim the dangling bits in LPI maps
Date:   Wed, 31 Aug 2022 10:33:32 +0800
Message-ID: <20220831023332.191368-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,PDS_BTC_ID,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following interrupt allocation process leads to some interrupts are
mapped in the low-level domain(Arm ITS), but they have never mapped
at the higher level.

irq_domain_alloc_irqs_hierarchy(.., nr_irqs, ...)
  its_irq_domain_alloc(..., nr_irqs, ...)
    its_alloc_device_irq(..., nr_irqs, ...)
      bitmap_find_free_region(..., get_count_order(nr_irqs))

Since ITS domain finds a region of zero bits, the length of which must
aligned to the power of two. If nr_irqs is 30, the length of zero bits
is actually 32, but the first 30 bits are really mapped.

On teardown, the low-level domain only free these interrupts that
actually mapped, and leave last interrupts dangling in the ITS domain.
Thus the ITS device resources are never freed. On device driver reload,
dangling interrupts prevent ITS domain from allocating enough resource.

irq_domain_free_irqs_hierarchy(..., nr_irqs, ...)
  its_irq_domain_free(..., irq_base + i, 1)
    bitmap_release_region(..., irq_base + i, get_count_order(1))

John reported this problem to LKML and Marc provided a solution and fix
it in the generic code, see the discussion from Link tag. Marc's patch
fix John's problem, but does not take care of some corner case, look one
example below.

Step1: 32 interrupts allocated in LPI domain, but return the first 30 to
higher driver.

   111111111111111111111111111111 11
  |<------------0~29------------>|30,31|

Step2: interrupt #16~28 are released one by one, then #0~15 and #29~31
still be there.

   1111111111111111 0000000000000 1  11
  |<-----0~15----->|<---16~28--->|29|30,31|

Step#: on driver teardown, generic code will invoke ITS domain code
twice. The first time, #0~15 will be released, the second one, only #29
will be released(1 align to power of two).

   0000000000000000 0000000000000 0  11
  |<-----0~15----->|<---16~28--->|29|30,31|

In short summary, the dangling problem stems from the number of released
hwirq is less than the one of the allocated hwirq in ITS domain.

In order to fix this problem, introduce dangling list for recording
these allocated but unmapped hwirq. Whenever some LPI hwirqs are
released, perform dangling list-travel to find out some dangling bits
followed then release them, look back the trivial example above.

Step1: record '2' into the irq_data.dangling of #29 hwirq.

           111111111111111111111111111111 11
          |<------------0~29------------>|30,31|
dangling:  000000000000000000000000000002

Step2: no change

          1111111111111111 0000000000000 1  11
         |<-----0~15----->|<---16~28--->|29|30,31|
dangling: 0000000000000000 0000000000000 2

Step3: ITS domain will release #30~31 since the irq_data.dangling of #29
is '2'.

           0000000000000000 0000000000000 0  00
          |<-----0~15----->|<---16~28--->|29|30,31|
dangling:  0000000000000000 0000000000000 2

Fixes: 4615fbc3788dd ("genirq/irqdomain: Don't try to free an interrupt that has no mapping")
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Link: https://lore.kernel.org/lkml/3d3d0155e66429968cb4f6b4feeae4b3@kernel.org/
---
Changes since v1:
- Correct grammar and spelling mistakes in commit message.
- Refactor the fixup solution, avoid hacking generici irq code.

---
 drivers/irqchip/irq-gic-v3-its.c | 57 ++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de6c48f..e191491bf683 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -143,6 +143,12 @@ struct its_node {
 /* Convert page order to size in bytes */
 #define PAGE_ORDER_TO_SIZE(o)	(PAGE_SIZE << (o))
 
+struct dangling_lpis {
+	struct list_head	list;
+	irq_hw_number_t		start;
+	irq_hw_number_t		end;
+};
+
 struct event_lpi_map {
 	unsigned long		*lpi_map;
 	u16			*col_map;
@@ -152,6 +158,7 @@ struct event_lpi_map {
 	struct its_vm		*vm;
 	struct its_vlpi_map	*vlpi_maps;
 	int			nr_vlpis;
+	struct list_head	dangling;
 };
 
 /*
@@ -3414,6 +3421,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	dev->event_map.col_map = col_map;
 	dev->event_map.lpi_base = lpi_base;
 	dev->event_map.nr_lpis = nr_lpis;
+	INIT_LIST_HEAD(&dev->event_map.dangling);
 	raw_spin_lock_init(&dev->event_map.vlpi_lock);
 	dev->device_id = dev_id;
 	INIT_LIST_HEAD(&dev->entry);
@@ -3443,6 +3451,8 @@ static void its_free_device(struct its_device *its_dev)
 static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number_t *hwirq)
 {
 	int idx;
+	int real_bits = (1 << get_count_order(nvecs));
+	struct dangling_lpis *lpis;
 
 	/* Find a free LPI region in lpi_map and allocate them. */
 	idx = bitmap_find_free_region(dev->event_map.lpi_map,
@@ -3453,9 +3463,52 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 
 	*hwirq = dev->event_map.lpi_base + idx;
 
+	/*
+	 * In order to reclaim dangling hwirq bits when module teardown,
+	 * record all dangling hwirq here.
+	 */
+	if (real_bits > nvecs) {
+		lpis = kzalloc(sizeof(*lpis), GFP_KERNEL);
+		if (!lpis) {
+			bitmap_release_region(dev->event_map.lpi_map,
+					      *hwirq, get_count_order(nvecs));
+			return -ENOMEM;
+		}
+		lpis->start = *hwirq + nvecs;
+		lpis->end = *hwirq + real_bits;
+		list_add_tail(&dev->event_map.dangling, &lpis->list);
+	}
+
 	return 0;
 }
 
+static void its_free_device_irq(struct its_device *dev, int nvecs,
+				irq_hw_number_t hwirq)
+{
+	struct dangling_lpis *entry, *temp;
+
+	bitmap_release_region(dev->event_map.lpi_map, hwirq,
+			      get_count_order(nvecs));
+
+	/*
+	 * If these hwirq are followed by some dangling bits, it needs to
+	 * reclaim these dangling bits.
+	 */
+	list_for_each_entry_safe(entry, temp, &dev->event_map.dangling, list) {
+		if (entry->start != hwirq + nvecs)
+			continue;
+
+		while (entry->start < entry->end) {
+			bitmap_release_region(dev->event_map.lpi_map,
+					      entry->start, get_count_order(1));
+			entry->start += 1;
+		}
+		list_del(&entry->list);
+		kfree(entry);
+		break;
+	}
+}
+
 static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 			   int nvec, msi_alloc_info_t *info)
 {
@@ -3619,9 +3672,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct its_node *its = its_dev->its;
 	int i;
 
-	bitmap_release_region(its_dev->event_map.lpi_map,
-			      its_get_event_id(irq_domain_get_irq_data(domain, virq)),
-			      get_count_order(nr_irqs));
+	its_free_device_irq(its_dev, nr_irqs, its_get_event_id(d));
 
 	for (i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(domain,
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC135A08A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiHYGLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHYGLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:11:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8B13F16
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:11:34 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCsvh4GDkzkWS9;
        Thu, 25 Aug 2022 14:08:00 +0800 (CST)
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
Subject: [PATCH 1/2] genirq: Record dangling hwirq number into struct irq_data
Date:   Thu, 25 Aug 2022 14:08:18 +0800
Message-ID: <20220825060819.74303-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Following interrupt allocation process lead to some interrupts are
mapped in the low-level domain(Arm ITS), but they are never been mapped
at the higher level.

irq_domain_alloc_irqs_hierarchy(.., nr_irqs, ...)
  its_irq_domain_alloc(..., nr_irqs, ...)
    its_alloc_device_irq(..., nr_irqs, ...)
      bitmap_find_free_region(..., get_count_order(nr_irqs))

Since ITS domain find a region of zero bits, the length of which must
aligned to power of two. If nr_irqs is 30, the length of zero bits is
actually 32, but only first 30 bits are really mapped.

On teardown, low-level domain only free these interrupts that actually
mapped, and leave last interrupts dangling in the ITS domain. Thus the
ITS device resources are never freed. On device driver reload, dangling
interrupts prevent ITS domain from allocating enough resource.

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
hwirq is less than the one of allocated hwirq in ITS domain. In order to
fix this problem, make irq_data record the number of allocated but
unmapped hwirq. If hwirq followed by some unmapped bits, ITS domain
record the number of unmapped bits to the last irq_data mapped to higher
level, when the last hwirq followed by unmapped hwirq is released, some
dangling bit will be clear eventualy, look back the trivial example
above.

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

Fixes: 4615fbc3788dd ("genirq/irqdomain: Don't try to free an interrupt
that has no mapping")
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Link: https://lore.kernel.org/lkml/3d3d0155e66429968cb4f6b4feeae4b3@kernel.org/
---
 include/linux/irq.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3eb89606c2b..c48f10a0c230 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -167,6 +167,10 @@ struct irq_common_data {
  * @mask:		precomputed bitmask for accessing the chip registers
  * @irq:		interrupt number
  * @hwirq:		hardware interrupt number, local to the interrupt domain
+ * @dangling:		amount of dangling hardware interrupt, Arm ITS allocate
+ *			hardware interrupt more than expected, aligned to power
+ *			of two, so that unsued interrupt number become dangling.
+ *			Use this field to record dangling bits follwoing @hwirq.
  * @common:		point to data shared by all irqchips
  * @chip:		low level interrupt hardware access
  * @domain:		Interrupt translation domain; responsible for mapping
@@ -180,6 +184,7 @@ struct irq_data {
 	u32			mask;
 	unsigned int		irq;
 	unsigned long		hwirq;
+	unsigned long		dangling;
 	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;
@@ -455,6 +460,11 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 	return d->hwirq;
 }
 
+static inline void irqd_set_dangling(struct irq_data *d, unsigned int dangling)
+{
+	d->dangling = dangling;
+}
+
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0185A53F5FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiFGGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiFGGTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:19:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6E57B1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:19:39 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2576JIK9050619;
        Tue, 7 Jun 2022 01:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654582758;
        bh=8X72yhv8hIOlj5I4X48eqWvXCgm1+UMbH3Llh0DO2zE=;
        h=From:To:CC:Subject:Date;
        b=mWUxO+IhujqcIe5Ir8zYMAo7X2UwhV/UtDQ/P8MAUBIxtTIuACu4bGf3BXO2LiYN1
         Oty6LSJsj8HEsbOmxScc5k+MVXYB033QI4UE0T6vv5slo+gIDCkaGSGvWlqHZTMo1g
         xVCCOfraxttq6qx6eD4FSDgP5c8f+dXyAjtMlqwY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2576JIeE128472
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jun 2022 01:19:18 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Jun 2022 01:19:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Jun 2022 01:19:18 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2576JFIB065592;
        Tue, 7 Jun 2022 01:19:15 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/ti-sci-intr: Add support for system suspend/resume PM
Date:   Tue, 7 Jun 2022 11:49:12 +0530
Message-ID: <20220607061912.12222-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for system level suspend/resume power management. The
interrupt mappings are stored in an array and restored in the system level
resume routine. Struct ti_sci_resource_desc can have atmost 2 sets for
ranges. Therefore, the mapping array is also formatted such that it can
store two sets of ranges.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/irqchip/irq-ti-sci-intr.c | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index fe8fad22bcf9..a8fc6cfb96ca 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -25,6 +25,7 @@
  * @dev:	Struct device pointer.
  * @ti_sci_id:	TI-SCI device identifier
  * @type:	Specifies the trigger type supported by this Interrupt Router
+ * @mapping:	Pointer to out_irq <-> hwirq mapping table
  */
 struct ti_sci_intr_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -32,6 +33,7 @@ struct ti_sci_intr_irq_domain {
 	struct device *dev;
 	u32 ti_sci_id;
 	u32 type;
+	u32 *mapping;
 };
 
 static struct irq_chip ti_sci_intr_irq_chip = {
@@ -99,6 +101,23 @@ static int ti_sci_intr_xlate_irq(struct ti_sci_intr_irq_domain *intr, u32 irq)
 	return -ENOENT;
 }
 
+/**
+ * ti_sci_intr_free_irq - Free the irq entry in the out_irq <-> hwirq mapping table
+ * @intr:	IRQ domain corresponding to Interrupt Router
+ * @out_irq:	Out irq number
+ */
+static void ti_sci_intr_free_irq(struct ti_sci_intr_irq_domain *intr, u16 out_irq)
+{
+	u16 start = intr->out_irqs->desc->start;
+	u16 num = intr->out_irqs->desc->num;
+	u16 start_sec = intr->out_irqs->desc->start_sec;
+
+	if (out_irq < start + num)
+		intr->mapping[out_irq - start] = 0xFFFFFFFF;
+	else
+		intr->mapping[out_irq - start_sec + num] = 0xFFFFFFFF;
+}
+
 /**
  * ti_sci_intr_irq_domain_free() - Free the specified IRQs from the domain.
  * @domain:	Domain to which the irqs belong
@@ -118,11 +137,30 @@ static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
 	intr->sci->ops.rm_irq_ops.free_irq(intr->sci,
 					   intr->ti_sci_id, data->hwirq,
 					   intr->ti_sci_id, out_irq);
+	ti_sci_intr_free_irq(intr, out_irq);
 	ti_sci_release_resource(intr->out_irqs, out_irq);
 	irq_domain_free_irqs_parent(domain, virq, 1);
 	irq_domain_reset_irq_data(data);
 }
 
+/**
+ * ti_sci_intr_add_irq - Add the irq entry in the out_irq <-> hwirq mapping table
+ * @intr:	IRQ domain corresponding to Interrupt Router
+ * @hwirq:	Input irq number
+ * @out_irq:	Out irq number
+ */
+static void ti_sci_intr_add_irq(struct ti_sci_intr_irq_domain *intr, u32 hwirq, u16 out_irq)
+{
+	u16 start = intr->out_irqs->desc->start;
+	u16 num = intr->out_irqs->desc->num;
+	u16 start_sec = intr->out_irqs->desc->start_sec;
+
+	if (out_irq < start + num)
+		intr->mapping[out_irq - start] = hwirq;
+	else
+		intr->mapping[out_irq - start_sec + num] = hwirq;
+}
+
 /**
  * ti_sci_intr_alloc_parent_irq() - Allocate parent IRQ
  * @domain:	Pointer to the interrupt router IRQ domain
@@ -173,6 +211,9 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 	if (err)
 		goto err_msg;
 
+	/* Adding out_irq <-> hwirq to mapping */
+	ti_sci_intr_add_irq(intr, hwirq, out_irq);
+
 	return out_irq;
 
 err_msg:
@@ -221,6 +262,26 @@ static const struct irq_domain_ops ti_sci_intr_irq_domain_ops = {
 	.translate	= ti_sci_intr_irq_domain_translate,
 };
 
+/**
+ * ti_sci_intr_initialize_mappingg - Initialize the out_irq <-> hwirq mapping table
+ * @intr:	IRQ domain corresponding to Interrupt Router
+ */
+static int ti_sci_intr_initialize_mapping(struct ti_sci_intr_irq_domain *intr)
+{
+	int i;
+	int mapping_len = intr->out_irqs->desc->num + intr->out_irqs->desc->num_sec;
+
+	intr->mapping = devm_kzalloc(intr->dev, mapping_len * sizeof(u32), GFP_KERNEL);
+	if (!intr->mapping)
+		return -ENOMEM;
+
+	/* Set all the elements in the array to max value of u32 */
+	for (i = 0; i < mapping_len; i++)
+		intr->mapping[i] = 0xFFFFFFFF;
+
+	return 0;
+}
+
 static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain, *domain;
@@ -246,6 +307,8 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	intr->dev = dev;
+	platform_set_drvdata(pdev, intr);
+
 	ret = of_property_read_u32(dev_of_node(dev), "ti,intr-trigger-type",
 				   &intr->type);
 	if (ret) {
@@ -273,6 +336,10 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 		return PTR_ERR(intr->out_irqs);
 	}
 
+	ret = ti_sci_intr_initialize_mapping(intr);
+	if (ret)
+		return ret;
+
 	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
 					  &ti_sci_intr_irq_domain_ops, intr);
 	if (!domain) {
@@ -285,6 +352,46 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int ti_sci_intr_restore_irqs(struct ti_sci_intr_irq_domain *intr)
+{
+	int i, err = 0;
+	u16 start = intr->out_irqs->desc->start;
+	u16 num = intr->out_irqs->desc->num;
+	u16 start_sec = intr->out_irqs->desc->start_sec;
+	u16 num_sec = intr->out_irqs->desc->num_sec;
+
+	for (i = 0; i < num + num_sec; i++) {
+		if (intr->mapping[i] == 0xFFFFFFFF)
+			continue;
+
+		if (i < num)
+			err = intr->sci->ops.rm_irq_ops.set_irq(intr->sci,
+								intr->ti_sci_id, intr->mapping[i],
+								intr->ti_sci_id, i + start);
+
+		else
+			err = intr->sci->ops.rm_irq_ops.set_irq(intr->sci,
+								intr->ti_sci_id, intr->mapping[i],
+								intr->ti_sci_id, i + start_sec);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused ti_sci_intr_resume(struct device *dev)
+{
+	struct ti_sci_intr_irq_domain *intr = dev_get_drvdata(dev);
+
+	return ti_sci_intr_restore_irqs(intr);
+}
+
+static const struct dev_pm_ops ti_sci_intr_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, ti_sci_intr_resume)
+};
+
 static const struct of_device_id ti_sci_intr_irq_domain_of_match[] = {
 	{ .compatible = "ti,sci-intr", },
 	{ /* sentinel */ },
@@ -295,6 +402,7 @@ static struct platform_driver ti_sci_intr_irq_domain_driver = {
 	.probe = ti_sci_intr_irq_domain_probe,
 	.driver = {
 		.name = "ti-sci-intr",
+		.pm = &ti_sci_intr_dev_pm_ops,
 		.of_match_table = ti_sci_intr_irq_domain_of_match,
 	},
 };
-- 
2.17.1


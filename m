Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF74477F42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbhLPVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbhLPVkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:49 -0500
Date:   Thu, 16 Dec 2021 21:40:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T163FNjJ3qpYOtapqdKi7eOFbvCKF9KArxGKLMPBv4s=;
        b=dT/tgi4A1h+OwThLMeRz04aBznDdIX74yJyZXALY1MIk1qiTnWG9JaPP92k7FRZAR2iZHd
        NaRY7UtWRDnyzAOl6H2aKYuyKxobNNlV6F0kgHAf2fc2+ikQH4EzvQh3QpFc5MhMWGsELd
        tnFOZPNt+Rbx3YakPtE5hfl/KHPw11ffkcsSvtJXFi4Bovn0jzBZH+mPCNKYXav9bmZGLj
        1ERE35MTytTDT6Dv3VkYfASEPuRBzg/ZQUJ5duQgA3INpkoKm6MXGgCSOm/WJZXvrWjenp
        r0OgdwTwKBYdstin1alMjpRFNtdYJtDpS6tSVce+MJNs+cllD6mgdVhv4LIhZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T163FNjJ3qpYOtapqdKi7eOFbvCKF9KArxGKLMPBv4s=;
        b=r1Opp6Br2UZsvXUzjlq9om2LRNOb3yhjgzS+cNYN0hd9lleEkpiILo+mQ9WWh0+j5/xmyj
        wMB4EQwX5gSITtDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] bus: fsl-mc: fsl-mc-allocator: Rework MSI handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221815.207838579@linutronix.de>
References: <20211210221815.207838579@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084709.23020.12210564103098398423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     d86a6d47bcc6b41fe2a4e13313d66a772d00382f
Gitweb:        https://git.kernel.org/tip/d86a6d47bcc6b41fe2a4e13313d66a772d00382f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:41 +01:00

bus: fsl-mc: fsl-mc-allocator: Rework MSI handling

Storing a pointer to the MSI descriptor just to track the Linux interrupt
number is daft. Just store the interrupt number and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221815.207838579@linutronix.de

---
 drivers/bus/fsl-mc/dprc-driver.c                    |  8 ++++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c               |  9 ++-------
 drivers/bus/fsl-mc/fsl-mc-msi.c                     |  6 +++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    |  4 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c    |  4 +---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c |  5 ++---
 drivers/soc/fsl/dpio/dpio-driver.c                  |  8 ++++----
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c              |  4 ++--
 include/linux/fsl/mc.h                              |  4 ++--
 9 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 315e830..5e70f97 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -400,7 +400,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 	struct fsl_mc_io *mc_io = mc_dev->mc_io;
-	struct msi_desc *msi_desc = mc_dev->irqs[0]->msi_desc;
+	int irq = mc_dev->irqs[0]->virq;
 
 	dev_dbg(dev, "DPRC IRQ %d triggered on CPU %u\n",
 		irq_num, smp_processor_id());
@@ -409,7 +409,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 		return IRQ_HANDLED;
 
 	mutex_lock(&mc_bus->scan_mutex);
-	if (!msi_desc || msi_desc->irq != (u32)irq_num)
+	if (irq != (u32)irq_num)
 		goto out;
 
 	status = 0;
@@ -521,7 +521,7 @@ static int register_dprc_irq_handler(struct fsl_mc_device *mc_dev)
 	 * function that programs the MSI physically in the device
 	 */
 	error = devm_request_threaded_irq(&mc_dev->dev,
-					  irq->msi_desc->irq,
+					  irq->virq,
 					  dprc_irq0_handler,
 					  dprc_irq0_handler_thread,
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
@@ -771,7 +771,7 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 
 	(void)disable_dprc_irq(mc_dev);
 
-	devm_free_irq(&mc_dev->dev, irq->msi_desc->irq, &mc_dev->dev);
+	devm_free_irq(&mc_dev->dev, irq->virq, &mc_dev->dev);
 
 	fsl_mc_free_irqs(mc_dev);
 }
diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 3370b63..dced427 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -350,7 +350,6 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus_dev,
 			     unsigned int irq_count)
 {
 	unsigned int i;
-	struct msi_desc *msi_desc;
 	struct fsl_mc_device_irq *irq_resources;
 	struct fsl_mc_device_irq *mc_dev_irq;
 	int error;
@@ -388,16 +387,12 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus_dev,
 		mc_dev_irq->resource.type = res_pool->type;
 		mc_dev_irq->resource.data = mc_dev_irq;
 		mc_dev_irq->resource.parent_pool = res_pool;
+		mc_dev_irq->virq = msi_get_virq(&mc_bus_dev->dev, i);
+		mc_dev_irq->resource.id = mc_dev_irq->virq;
 		INIT_LIST_HEAD(&mc_dev_irq->resource.node);
 		list_add_tail(&mc_dev_irq->resource.node, &res_pool->free_list);
 	}
 
-	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq = &irq_resources[msi_desc->msi_index];
-		mc_dev_irq->msi_desc = msi_desc;
-		mc_dev_irq->resource.id = msi_desc->irq;
-	}
-
 	res_pool->max_count = irq_count;
 	res_pool->free_count = irq_count;
 	mc_bus->irq_resources = irq_resources;
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 2ffb705..4823947 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -58,11 +58,11 @@ static void fsl_mc_msi_update_dom_ops(struct msi_domain_info *info)
 }
 
 static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
-				   struct fsl_mc_device_irq *mc_dev_irq)
+				   struct fsl_mc_device_irq *mc_dev_irq,
+				   struct msi_desc *msi_desc)
 {
 	int error;
 	struct fsl_mc_device *owner_mc_dev = mc_dev_irq->mc_dev;
-	struct msi_desc *msi_desc = mc_dev_irq->msi_desc;
 	struct dprc_irq_cfg irq_cfg;
 
 	/*
@@ -129,7 +129,7 @@ static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
 	/*
 	 * Program the MSI (paddr, value) pair in the device:
 	 */
-	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq);
+	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq, msi_desc);
 }
 
 static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 8e64356..2c53f95 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4246,7 +4246,7 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *ls_dev)
 	}
 
 	irq = ls_dev->irqs[0];
-	err = devm_request_threaded_irq(&ls_dev->dev, irq->msi_desc->irq,
+	err = devm_request_threaded_irq(&ls_dev->dev, irq->virq,
 					NULL, dpni_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(&ls_dev->dev), &ls_dev->dev);
@@ -4273,7 +4273,7 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *ls_dev)
 	return 0;
 
 free_irq:
-	devm_free_irq(&ls_dev->dev, irq->msi_desc->irq, &ls_dev->dev);
+	devm_free_irq(&ls_dev->dev, irq->virq, &ls_dev->dev);
 free_mc_irq:
 	fsl_mc_free_irqs(ls_dev);
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 32b5faa..5f5f8c5 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -129,7 +129,6 @@ static irqreturn_t dpaa2_ptp_irq_handler_thread(int irq, void *priv)
 static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 {
 	struct device *dev = &mc_dev->dev;
-	struct fsl_mc_device_irq *irq;
 	struct ptp_qoriq *ptp_qoriq;
 	struct device_node *node;
 	void __iomem *base;
@@ -177,8 +176,7 @@ static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 		goto err_unmap;
 	}
 
-	irq = mc_dev->irqs[0];
-	ptp_qoriq->irq = irq->msi_desc->irq;
+	ptp_qoriq->irq = mc_dev->irqs[0]->virq;
 
 	err = request_threaded_irq(ptp_qoriq->irq, NULL,
 				   dpaa2_ptp_irq_handler_thread,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index d039457..084cc4d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1553,8 +1553,7 @@ static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
 
 	irq = sw_dev->irqs[DPSW_IRQ_INDEX_IF];
 
-	err = devm_request_threaded_irq(dev, irq->msi_desc->irq,
-					NULL,
+	err = devm_request_threaded_irq(dev, irq->virq, NULL,
 					dpaa2_switch_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(dev), dev);
@@ -1580,7 +1579,7 @@ static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
 	return 0;
 
 free_devm_irq:
-	devm_free_irq(dev, irq->msi_desc->irq, dev);
+	devm_free_irq(dev, irq->virq, dev);
 free_irq:
 	fsl_mc_free_irqs(sw_dev);
 	return err;
diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index dd94888..5a2edc4 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -88,7 +88,7 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
 	irq = dpio_dev->irqs[0];
 
 	/* clear the affinity hint */
-	irq_set_affinity_hint(irq->msi_desc->irq, NULL);
+	irq_set_affinity_hint(irq->virq, NULL);
 }
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
@@ -98,7 +98,7 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
 
 	irq = dpio_dev->irqs[0];
 	error = devm_request_irq(&dpio_dev->dev,
-				 irq->msi_desc->irq,
+				 irq->virq,
 				 dpio_irq_handler,
 				 0,
 				 dev_name(&dpio_dev->dev),
@@ -111,10 +111,10 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
 	}
 
 	/* set the affinity hint */
-	if (irq_set_affinity_hint(irq->msi_desc->irq, cpumask_of(cpu)))
+	if (irq_set_affinity_hint(irq->virq, cpumask_of(cpu)))
 		dev_err(&dpio_dev->dev,
 			"irq_set_affinity failed irq %d cpu %d\n",
-			irq->msi_desc->irq, cpu);
+			irq->virq, cpu);
 
 	return 0;
 }
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
index 77e5840..7b428ea 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -67,7 +67,7 @@ static int vfio_set_trigger(struct vfio_fsl_mc_device *vdev,
 	int hwirq;
 	int ret;
 
-	hwirq = vdev->mc_dev->irqs[index]->msi_desc->irq;
+	hwirq = vdev->mc_dev->irqs[index]->virq;
 	if (irq->trigger) {
 		free_irq(hwirq, irq);
 		kfree(irq->name);
@@ -137,7 +137,7 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
 		return vfio_set_trigger(vdev, index, fd);
 	}
 
-	hwirq = vdev->mc_dev->irqs[index]->msi_desc->irq;
+	hwirq = vdev->mc_dev->irqs[index]->virq;
 
 	irq = &vdev->mc_irqs[index];
 
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index e026f6c..7b6c42b 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -91,13 +91,13 @@ struct fsl_mc_resource {
 
 /**
  * struct fsl_mc_device_irq - MC object device message-based interrupt
- * @msi_desc: pointer to MSI descriptor allocated by fsl_mc_msi_alloc_descs()
+ * @virq: Linux virtual interrupt number
  * @mc_dev: MC object device that owns this interrupt
  * @dev_irq_index: device-relative IRQ index
  * @resource: MC generic resource associated with the interrupt
  */
 struct fsl_mc_device_irq {
-	struct msi_desc *msi_desc;
+	unsigned int virq;
 	struct fsl_mc_device *mc_dev;
 	u8 dev_irq_index;
 	struct fsl_mc_resource resource;

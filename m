Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243C4BD746
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbiBUHbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:31:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiBUHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:31:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A162E7;
        Sun, 20 Feb 2022 23:31:20 -0800 (PST)
Date:   Mon, 21 Feb 2022 07:31:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645428677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPeVFRqXyH/qkyeIFa43p7nhy+n8Zng6FJUz7oizMQI=;
        b=tK4RiO/ufs+nV/sBz4B0MjsW2UxZlm7O8bYpMrA9mczisjRaGkQNbnyyLvq+xzdxkjTklT
        ipaP9pOiYksBMvXTymfR2m/W0aCA6UbpZIPDVx5Uc96AbOZHeti7MAZ8gRCLlJL15FEeOv
        ZqnnonXJDH9lnQhGD/vyG6jv4F84MAWe++UhF2xPaaBurP7y0ZgspPTjFG0oikchSBIXmk
        iSXeab3S6Uk+EAgTZjLawu/ylgwTe/opYHjRlqlj4f8262b9BoXToSC5p+vjbx2HL/nhvD
        rH/5MdJ7M/8dgcKkkqHY07wHFD/fbqfRX9/UqyrwRzHPvJlFrD/aXTYyxcqRQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645428677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPeVFRqXyH/qkyeIFa43p7nhy+n8Zng6FJUz7oizMQI=;
        b=I11DarCzKKF4kFbIfwPnRaNMk42oeJlTjQTniqkBdH01dZVuYbcefrBSeXQj3DHWTLRQyQ
        uImY5VgPS3eCeOCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI: vmd: Prevent recursive locking on interrupt allocation
Cc:     "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87a6euub2a.ffs@tglx>
References: <87a6euub2a.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164542867635.16921.13795049956787158926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ba1366f3d039e7c3ca1fc29ed00ce3ed2b8fd32f
Gitweb:        https://git.kernel.org/tip/ba1366f3d039e7c3ca1fc29ed00ce3ed2b8fd32f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Feb 2022 14:54:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 21 Feb 2022 08:26:53 +01:00

PCI: vmd: Prevent recursive locking on interrupt allocation

Tejas reported the following recursive locking issue:

 swapper/0/1 is trying to acquire lock:
 ffff8881074fd0a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x30/0xc0
 
 but task is already holding lock:
 ffff8881017cd6a0 (&md->mutex){+.+.}-{3:3}, at: __pci_enable_msi_range+0xf2/0x290
 
 stack backtrace:
  __mutex_lock+0x9d/0x920
  msi_get_virq+0x30/0xc0
  pci_irq_vector+0x26/0x30
  vmd_msi_init+0xcc/0x210
  msi_domain_alloc+0xbf/0x150
  msi_domain_alloc_irqs_descs_locked+0x3e/0xb0
  __pci_enable_msi_range+0x155/0x290
  pci_alloc_irq_vectors_affinity+0xba/0x100
  pcie_port_device_register+0x307/0x550
  pcie_portdrv_probe+0x3c/0xd0
  pci_device_probe+0x95/0x110

This is caused by the VMD MSI code which does a lookup of the Linux
interrupt number for an VMD managed MSI[X] vector. The lookup function
tries to acquire the already held mutex.

Avoid that by caching the Linux interrupt number at initialization time
instead of looking it up over and over.

Fixes: 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
Reported-by: "Surendrakumar Upadhyay, TejaskumarX" <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: "Surendrakumar Upadhyay, TejaskumarX" <tejaskumarx.surendrakumar.upadhyay@intel.com>
Cc: linux-pci@vger.kernel.org
Link: https://lore.kernel.org/r/87a6euub2a.ffs@tglx

---
 drivers/pci/controller/vmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c6..eb05cce 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -99,11 +99,13 @@ struct vmd_irq {
  * @srcu:	SRCU struct for local synchronization.
  * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
+ * @virq:	The underlying VMD Linux interrupt number
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
 	unsigned int		count;
+	unsigned int		virq;
 };
 
 struct vmd_dev {
@@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	struct msi_desc *desc = arg->desc;
 	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
-	unsigned int index, vector;
 
 	if (!vmdirq)
 		return -ENOMEM;
@@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	INIT_LIST_HEAD(&vmdirq->node);
 	vmdirq->irq = vmd_next_irq(vmd, desc);
 	vmdirq->virq = virq;
-	index = index_from_irqs(vmd, vmdirq->irq);
-	vector = pci_irq_vector(vmd->dev, index);
 
-	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
+	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
 			    handle_untracked_irq, vmd, NULL);
 	return 0;
 }
@@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 			return err;
 
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
+		vmd->irqs[i].virq = pci_irq_vector(dev, i);
+		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
 				       vmd->name, &vmd->irqs[i]);
 		if (err)
@@ -969,7 +969,7 @@ static int vmd_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < vmd->msix_count; i++)
-		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
+		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
 
 	return 0;
 }
@@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev)
 	int err, i;
 
 	for (i = 0; i < vmd->msix_count; i++) {
-		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+		err = devm_request_irq(dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
 				       vmd->name, &vmd->irqs[i]);
 		if (err)

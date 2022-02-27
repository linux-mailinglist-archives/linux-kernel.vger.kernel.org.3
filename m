Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779084C5A27
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiB0JUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiB0JUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:20:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DED2612A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 01:20:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645953607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BrHQ4F8L8u/trpTIwjTyy0+OXrLjzg78x3go4LiZZEA=;
        b=cxZAu8XY0IFzPFbjsHI6vocTv5imCi5EBkorWOMBa8FAn311OIDGg4KNpkFX8ZcDRX03JN
        FEW6inSZj0nz2wD71DxFUSzLsA5/7IgUePpyh+rYdTdd3uwaUyy5COTL6UULeZ9au9nVTZ
        MfgciY9Bpk1o3YdL/g74TKJnp4R8nOju3FYlKGfqHTphwHAx08C5U+XeGXz4vdJYprC0r7
        VOCplTVrc/DsrIOpU4s2mtCTjGOOOW1rWc1GcYXx/vDgyGvvgle23zDQkwEe5H6vuDjDqi
        BwS8JU3LVPtQ7znzv/3vjo2fC4NoRhv+6ucc/n2TQVeOfJB6T95bYQ17vV+7iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645953607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BrHQ4F8L8u/trpTIwjTyy0+OXrLjzg78x3go4LiZZEA=;
        b=FP9oGPfcscPm4h1/FOIP3A0dmGEP1elBiumSrkBOa578hcTEGwmxQ6DcU1hzROX6dJDBJZ
        XU2y9j1CixXLFeDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.17-rc6
Message-ID: <164595358628.38081.10035138977548213816.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 27 Feb 2022 10:20:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-=
02-27

up to:  ba1366f3d039: PCI: vmd: Prevent recursive locking on interrupt alloca=
tion


A single fix for a regression caused by the recent PCI/MSI rework which
resulted in a recursive locking problem in the VMD driver. The cure is to
cache the relevant information upfront instead of retrieving it at runtime.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      PCI: vmd: Prevent recursive locking on interrupt allocation


 drivers/pci/controller/vmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c683638..eb05cceab964 100644
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
=20
 struct vmd_dev {
@@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domain *domain, struct=
 msi_domain_info *info,
 	struct msi_desc *desc =3D arg->desc;
 	struct vmd_dev *vmd =3D vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq =3D kzalloc(sizeof(*vmdirq), GFP_KERNEL);
-	unsigned int index, vector;
=20
 	if (!vmdirq)
 		return -ENOMEM;
@@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domain *domain, struc=
t msi_domain_info *info,
 	INIT_LIST_HEAD(&vmdirq->node);
 	vmdirq->irq =3D vmd_next_irq(vmd, desc);
 	vmdirq->virq =3D virq;
-	index =3D index_from_irqs(vmd, vmdirq->irq);
-	vector =3D pci_irq_vector(vmd->dev, index);
=20
-	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
+	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
 			    handle_untracked_irq, vmd, NULL);
 	return 0;
 }
@@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 			return err;
=20
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		err =3D devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
+		vmd->irqs[i].virq =3D pci_irq_vector(dev, i);
+		err =3D devm_request_irq(&dev->dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
 				       vmd->name, &vmd->irqs[i]);
 		if (err)
@@ -969,7 +969,7 @@ static int vmd_suspend(struct device *dev)
 	int i;
=20
 	for (i =3D 0; i < vmd->msix_count; i++)
-		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
+		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
=20
 	return 0;
 }
@@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev)
 	int err, i;
=20
 	for (i =3D 0; i < vmd->msix_count; i++) {
-		err =3D devm_request_irq(dev, pci_irq_vector(pdev, i),
+		err =3D devm_request_irq(dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
 				       vmd->name, &vmd->irqs[i]);
 		if (err)


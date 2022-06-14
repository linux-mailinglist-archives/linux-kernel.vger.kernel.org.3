Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23AC54B453
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356392AbiFNPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbiFNPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:14:41 -0400
Received: from mxout.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F13914E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:14:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 009B932396B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
        s=sec-sig-email; t=1655219679;
        bh=1As+SIlnO2vscW/qqZR9du61Q2ukm1jdgGHBrmSoH6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VIagxXpTzzQMO9OSJAJp/W23j9HOTC9Gwu5c1AOmZMZQKUDtttEJeooqiWKVsBWE/
         wllSacNlx10TNAN6z5Sd1MCdbQ4cYZnoQ/cxpD/oCwrMth2QVvYif+8I1I5cpT+WXq
         JF2iNV9DnTBr/kkY/2Hx9w4Em6e89oeHCMdy+njI=
Received: from fx303 (localhost [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 7F1D2323968;
        Tue, 14 Jun 2022 17:14:38 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <37a7.62a8a5dd.ad66e.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx303.security-mail.net (Postfix) with ESMTPS id AFD2C323950;
        Tue, 14 Jun 2022 17:14:37 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 8E95027E04E1;
        Tue, 14 Jun 2022 17:14:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 76D1A27E04E4;
        Tue, 14 Jun 2022 17:14:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 76D1A27E04E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
        s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1655219677;
        bh=Yvu3y3wKlP0OuV+sC+38CFyDrsMw0q/XsgdGisbDBys=;
        h=From:To:Date:Message-Id;
        b=dHQfGjzo8h/4pwQGt9sWf0u7hE3lpVh9UXQeIEm5VhJ+uvyAIXIYsftNLyoH8fJRL
         XZmIxVbejBqq1gvieZVuzAd3Ydih+GjJqJPbW1565EL84xXxQk56fjYZYre8VeuwQm
         NwKKlB+SxP05REjOdq5X730KkxPjKZWUiojYvZas7vEnntHCcR5rc4zk3Xgqril55n
         Ze0Fdv5Wb4aWBkOJoaL4NybccWMVm/pEikt3IrpRrsvHU/IPJHcc68RE46RooGzlln
         I2jUYVl1QBDKCyEgBTjH5IBxXvW5E6Pz7rcaE2ShavjRlZVSfIpOw4eViSCLAHeCuI
         88HRK01R3dsHQ==
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id njjkREvi4zip; Tue, 14 Jun 2022 17:14:37 +0200 (CEST)
Received: from ws2104.lin.mbt.kalray.eu (unknown [192.168.37.162])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 5CB0327E04E1;
        Tue, 14 Jun 2022 17:14:37 +0200 (CEST)
From:   Julian Vetter <jvetter@kalrayinc.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, ysionneau@kalrayinc.com,
        jmaselbas@kalrayinc.com
Cc:     Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v2 2/2] msi: Add sanity check if more than MAX_DEV_MSIS MSIs are requested
Date:   Tue, 14 Jun 2022 17:14:11 +0200
Message-Id: <20220614151411.32674-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220614151411.32674-1-jvetter@kalrayinc.com>
References: <20220614151411.32674-1-jvetter@kalrayinc.com>
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device requests more than MAX_DEV_MSIS the MSI index will collide with
the devid and might cause Linux to compute twice the same virtual interrupt
number for two different devices.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
---
Changes v1->v2:
  - Took Greg Kroah-Hartman's comments into account
  - Replaced WARN_ON() by proper error handling

 drivers/base/platform-msi.c       |  8 +++++++-
 drivers/bus/fsl-mc/fsl-mc-msi.c   |  3 ++-
 drivers/irqchip/irq-ti-sci-inta.c |  3 ++-
 drivers/pci/controller/vmd.c      |  3 ++-
 drivers/pci/msi/irqdomain.c       |  3 ++-
 include/linux/msi.h               |  2 +-
 kernel/irq/msi.c                  | 12 +++++++++---
 7 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 4b0b2fe3a7ff..8330153c0067 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -43,10 +43,16 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
 }
 
-static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+static int platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
 	arg->hwirq = platform_msi_calc_hwirq(desc);
+
+	if (desc->msi_index >= MAX_DEV_MSIS) {
+		dev_err(desc->dev, "Number of msis exceeds %d\n", MAX_DEV_MSIS);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static int platform_msi_init(struct irq_domain *domain,
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 0cfe859a4ac4..63b5ae8de391 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -32,12 +32,13 @@ static irq_hw_number_t fsl_mc_domain_calc_hwirq(struct fsl_mc_device *dev,
 	return (irq_hw_number_t)(desc->msi_index + (dev->icid * 10000));
 }
 
-static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
+static int fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
 				struct msi_desc *desc)
 {
 	arg->desc = desc;
 	arg->hwirq = fsl_mc_domain_calc_hwirq(to_fsl_mc_device(desc->dev),
 					      desc);
+	return 0;
 }
 #else
 #define fsl_mc_msi_set_desc NULL
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 5fdbb4358dd0..0c26690c074b 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -589,13 +589,14 @@ static struct irq_chip ti_sci_inta_msi_irq_chip = {
 	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
 };
 
-static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
+static int ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
 				     struct msi_desc *desc)
 {
 	struct platform_device *pdev = to_platform_device(desc->dev);
 
 	arg->desc = desc;
 	arg->hwirq = TO_HWIRQ(pdev->id, desc->msi_index);
+	return 0;
 }
 
 static struct msi_domain_ops ti_sci_inta_msi_ops = {
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94a14a3d7e55..929ba2a991b5 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -296,9 +296,10 @@ static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
 	return 0;
 }
 
-static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+static int vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
+	return 0;
 }
 
 static struct msi_domain_ops vmd_msi_domain_ops = {
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e9cf318e6670..3191f15a07b8 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -108,11 +108,12 @@ static int pci_msi_domain_check_cap(struct irq_domain *domain,
 	return 0;
 }
 
-static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
+static int pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
 	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
+	return 0;
 }
 
 static struct msi_domain_ops pci_msi_domain_ops_default = {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index fc918a658d48..17228d6e8d85 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -355,7 +355,7 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
-	void		(*set_desc)(msi_alloc_info_t *arg,
+	int		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
 	int		(*domain_alloc_irqs)(struct irq_domain *domain,
 					     struct device *dev, int nvec);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a9ee535293eb..a20c85334b58 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -592,10 +592,11 @@ static int msi_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
 	return 0;
 }
 
-static void msi_domain_ops_set_desc(msi_alloc_info_t *arg,
+static int msi_domain_ops_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
+	return 0;
 }
 
 static int msi_domain_ops_init(struct irq_domain *domain,
@@ -726,7 +727,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 		desc = xa_load(&dev->msi.data->__store, virq);
 		desc->irq = virq;
 
-		ops->set_desc(arg, desc);
+		ret = ops->set_desc(arg, desc);
+		if (ret)
+			goto fail;
+
 		ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
 		if (ret)
 			goto fail;
@@ -888,7 +892,9 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	}
 
 	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
-		ops->set_desc(&arg, desc);
+		ret = ops->set_desc(&arg, desc);
+		if (ret)
+			return ret;
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
-- 
2.17.1


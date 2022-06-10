Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765FD545F24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347779AbiFJI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347479AbiFJI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:27:47 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB69F5F76;
        Fri, 10 Jun 2022 01:26:00 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6B34716A0;
        Fri, 10 Jun 2022 11:26:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6B34716A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849599;
        bh=KPuOVwi0cvFmfZI8ZO6CHQ/WVhFl8GOmzgX8MXxNTEg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Ven35Z8y6h+XqxatQDpl/bdOE5CGJOaq0vrRX7cHa+Tdhb2w0WO4YByAqBlaf3mml
         QQLxukPxSYC2bH/MNpAWMt6KbqyOX8z7rcq13LxoKO5lRTTVERUIAfuuZnOQgOLpbQ
         EmsF0ROzoQ1/91/s3iOujC9IjKvaS3K2cQPbvc5o=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 13/18] PCI: dwc: Add start_link/stop_link inliners
Date:   Fri, 10 Jun 2022 11:25:29 +0300
Message-ID: <20220610082535.12802-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the generic DW PCIe code where the
platform-specific PCIe link start/stop methods are called after making
sure the ops handler and the callbacks are specified. Instead of repeating
the same pattern over and over let's define the static-inline methods in
the DW PCIe header file and use them in the relevant parts of the driver.

Note returning a negative error from the EP link start procedure if the
start_link pointer isn't specified doesn't really make much sense since it
perfectly normal to have such platform. Moreover even pci_epc_start()
doesn't fail if no epc->ops->start callback is spotted. As a side-effect
of this modification we can set the generic DW PCIe and Layerscape EP
platform drivers free from the empty start_link callbacks and as such
entirely dummy dw_pcie_ops instances.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch created on the v4 lap of the series.
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c    | 12 ------------
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 ++------
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++------
 drivers/pci/controller/dwc/pcie-designware-plat.c | 10 ----------
 drivers/pci/controller/dwc/pcie-designware.h      | 14 ++++++++++++++
 5 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 39f4664bd84c..ad99707b3b99 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -32,15 +32,6 @@ struct ls_pcie_ep {
 	const struct ls_pcie_ep_drvdata *drvdata;
 };
 
-static int ls_pcie_establish_link(struct dw_pcie *pci)
-{
-	return 0;
-}
-
-static const struct dw_pcie_ops dw_ls_pcie_ep_ops = {
-	.start_link = ls_pcie_establish_link,
-};
-
 static const struct pci_epc_features*
 ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -106,19 +97,16 @@ static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 
 static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
 	.func_offset = 0x20000,
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
 	.func_offset = 0x8000,
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct of_device_id ls_pcie_ep_of_match[] = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7ad349c32082..15b8059544e3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -435,8 +435,7 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 }
 
 static int dw_pcie_ep_start(struct pci_epc *epc)
@@ -444,10 +443,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops || !pci->ops->start_link)
-		return -EINVAL;
-
-	return pci->ops->start_link(pci);
+	return dw_pcie_start_link(pci);
 }
 
 static const struct pci_epc_features*
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fa107e8dd2ab..f57f456aa543 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -408,8 +408,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
-		ret = pci->ops->start_link(pci);
+	if (!dw_pcie_link_up(pci)) {
+		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_free_msi;
 	}
@@ -426,8 +426,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 
 err_stop_link:
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 
 err_free_msi:
 	if (pp->has_msi_ctrl)
@@ -443,8 +442,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
 
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 0c5de87d3cc6..abf1afac6064 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -36,15 +36,6 @@ static const struct of_device_id dw_plat_pcie_of_match[];
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 };
 
-static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
-{
-	return 0;
-}
-
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.start_link = dw_plat_pcie_establish_link,
-};
-
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -140,7 +131,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
 	dw_plat_pcie->pci = pci;
 	dw_plat_pcie->mode = mode;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..8ba239292634 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -365,6 +365,20 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+static inline int dw_pcie_start_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->start_link)
+		return pci->ops->start_link(pci);
+
+	return 0;
+}
+
+static inline void dw_pcie_stop_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
-- 
2.35.1


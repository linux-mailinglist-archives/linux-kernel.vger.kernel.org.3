Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4244545EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbiFJI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiFJI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:27:25 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95F4E656A;
        Fri, 10 Jun 2022 01:25:43 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6BD48BD2;
        Fri, 10 Jun 2022 11:26:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6BD48BD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849590;
        bh=HvFRjLfRZVpB1a2dJ+Y3tW+LbZlq0RtxiS2ht743LVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=etMH0YIwGyxgZteiVlL9m99N6IZFcasnFIXTikG/5iUfHiXmLm0taYkZp67SexH8H
         fkNobuFmZhG9yQ7vYwLajQs9rCyOPDkE//GqjbBPRtBT99dlbrPkbgxkgY4I+xdQuO
         ifMZmoyymNHOva5+l5UL6NLSHRzgAtf0fbz4nKzI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/18] PCI: dwc: Add unroll iATU space support to the regions disable method
Date:   Fri, 10 Jun 2022 11:25:18 +0300
Message-ID: <20220610082535.12802-3-Sergey.Semin@baikalelectronics.ru>
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

The dw_pcie_disable_atu() method was introduced in the commit f8aed6ec624f
("PCI: dwc: designware: Add EP mode support"). Since then it hasn't
changed at all.  For all that time the method has supported the viewport
version of the iATU CSRs only. Basically it works for the DW PCIe IP-cores
older than v4.80a since the newer controllers are equipped with the
unrolled iATU/eDMA space. It means the methods using it like
pci_epc_ops.clear_bar and pci_epc_ops.unmap_addr callbacks just don't work
correctly for the DW PCIe controllers with unrolled iATU CSRs. The same
concerns the dw_pcie_setup_rc() method, which disables the outbound iATU
entries before re-initializing them.

So in order to fix the problems denoted above let's convert the
dw_pcie_disable_atu() method to disabling the iATU inbound and outbound
regions in the unrolled iATU CSRs in case the DW PCIe controller has been
synthesized with the ones support. The former semantics will be remained
for the controller having iATU mapped over the viewport.

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v3:
- Convert region variable type to u32 in order to fix the implicit type
  conversion peculiarity. (@kbot)
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d92c8a25094f..84fef21efdbc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -491,7 +491,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 			 enum dw_pcie_region_type type)
 {
-	int region;
+	u32 region;
 
 	switch (type) {
 	case DW_PCIE_REGION_INBOUND:
@@ -504,8 +504,18 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 		return;
 	}
 
-	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
+	if (pci->iatu_unroll_enabled) {
+		if (region == PCIE_ATU_REGION_INBOUND) {
+			dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
+						 ~(u32)PCIE_ATU_ENABLE);
+		} else {
+			dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
+						 ~(u32)PCIE_ATU_ENABLE);
+		}
+	} else {
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
+	}
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B24E9B05
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiC1P01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiC1PZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:25:54 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9749622290;
        Mon, 28 Mar 2022 08:24:12 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id F1F671E492D;
        Thu, 24 Mar 2022 04:37:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru F1F671E492D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085879;
        bh=JNjQ9LsyEVBUO6+Fr1N/WeQmcj9ncW1Bt526HuRe/EY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=LeVGk5SrU2q79lO1su3NVBS3uQa008JQYs+TfOI/9UFVbEMIaIBgxzRz5dYNEVxk/
         9HL93IskT9bxx1FCkjcOaVHqY4MSSwcxD/buEkb2cZXyiTV5SMQf59LpCXh3IeRClh
         6mFGdsYmXRU0zpav6+vjbV7ouatSPuTW10tj8yNE=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:59 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/16] PCI: dwc: Introduce dma-ranges property support for RC-host
Date:   Thu, 24 Mar 2022 04:37:32 +0300
Message-ID: <20220324013734.18234-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
property has the same format as the "ranges" property. The only difference
is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
property. Even though the DW PCIe controllers are normally equipped with
internal Address Translation Unit which inbound and outbound tables can be
used to implement both properties semantics, it was surprise for me to
discover that the host-related part of the DW PCIe driver currently
supports the "ranges" property only while the "dma-ranges" windows are
just ignored. Having the "dma-ranges" supported in the driver would be
very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
mapping and require customized the PCIe memory layout. So let's fix that
by introducing the "dma-ranges" property support.

First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
dw_pcie_prog_ep_inbound_atu() and create a new version of the
dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for RC
and EP controllers respectively in the same way as it has been developed
for the outbound ATU setup methods.

Secondly aside with the memory window index and type the new
dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
and size as its arguments. These parameters define the PCIe and CPU memory
ranges which will be used to setup the respective inbound ATU mapping. The
passed parameters need to be verified against the ATU ranges constraints
in the same way as it is done for the outbound ranges.

Finally the DMA-ranges detected for the PCIe controller need to be
converted into the inbound ATU entries during the host controller
initialization procedure. It will be done in the framework of the
dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
need to disable all the inbound ATU entries in order to prevent unexpected
PCIe TLPs translations defined by some third party software like
bootloader.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware.c  | 57 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
 4 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 47ed9256b87c..23401f17e8f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -167,8 +167,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
-				       cpu_addr, bar);
+	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
+					  cpu_addr, bar);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 41c673c31940..715a13b90e43 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -606,12 +606,15 @@ static int dw_pcie_iatu_setup(struct pcie_port *pp)
 	}
 
 	/*
-	 * Ensure all outbound windows are disabled before proceeding with
-	 * the MEM/IO ranges setups.
+	 * Ensure all out/inbound windows are disabled before proceeding with
+	 * the MEM/IO (dma-)ranges setups.
 	 */
 	for (i = 0; i < pci->num_ob_windows; i++)
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
 
+	for (i = 0; i < pci->num_ib_windows; i++)
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -648,9 +651,32 @@ static int dw_pcie_iatu_setup(struct pcie_port *pp)
 	}
 
 	if (pci->num_ob_windows <= i)
-		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
+		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	i = 0;
+	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
+		if (resource_type(entry->res) != IORESOURCE_MEM)
+			continue;
+
+		if (pci->num_ib_windows <= i)
+			break;
+
+		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
+					       entry->res->start,
+					       entry->res->start - entry->offset,
+					       resource_size(entry->res));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set DMA range %pr\n",
+				entry->res);
+			return ret;
+		}
+	}
+
+	if (pci->num_ib_windows <= i)
+		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
+			 pci->num_ib_windows);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2a7f23a2045c..4a95a7b112e9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -400,8 +400,61 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 region, u32 re
 	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, region, reg, val);
 }
 
-int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-			     int type, u64 cpu_addr, u8 bar)
+int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
+			     u64 cpu_addr, u64 pci_addr, u64 size)
+{
+	u64 limit_addr = pci_addr + size - 1;
+	u32 retries, val;
+
+	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(pci_addr, pci->region_align) ||
+	    !IS_ALIGNED(size, pci->region_align) || !size) {
+		return -EINVAL;
+	}
+
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_BASE,
+			      lower_32_bits(pci_addr));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_BASE,
+			      upper_32_bits(pci_addr));
+
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LIMIT,
+			      lower_32_bits(limit_addr));
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_LIMIT,
+				      upper_32_bits(limit_addr));
+
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(cpu_addr));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(cpu_addr));
+
+	val = type;
+	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
+	    dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_INCREASE_REGION_SIZE;
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+
+	/*
+	 * Make sure ATU enable takes effect before any subsequent config
+	 * and I/O accesses.
+	 */
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
+		if (val & PCIE_ATU_ENABLE)
+			return 0;
+
+		mdelay(LINK_WAIT_IATU);
+	}
+
+	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
+
+	return -ETIMEDOUT;
+}
+
+int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
+				int type, u64 cpu_addr, u8 bar)
 {
 	u32 retries, val;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 15fce8fd33df..ade854217332 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -308,8 +308,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			      u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-			     int type, u64 cpu_addr, u8 bar);
+int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
+			     u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
+				int type, u64 cpu_addr, u8 bar);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
-- 
2.35.1


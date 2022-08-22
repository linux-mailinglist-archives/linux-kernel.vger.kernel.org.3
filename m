Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1959C744
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiHVSto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiHVSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:48:20 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 681AB4A129;
        Mon, 22 Aug 2022 11:47:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C19A8DB2;
        Mon, 22 Aug 2022 21:50:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C19A8DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194251;
        bh=0WE9RU3uRVdVAE1vsIomrMUZhF6AleDgVh/Z5iZThuo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=TY+a8Rfx5npklp3QF3wlxbvXgduSchCgoiB7nKm2Lm2Hr5B5hZIr5N7i04gXZyiia
         zsvKGTbDwaLakGit5IOd5BmKXWFcQgeNrSPRcXYSDkfYjIyLbeT5O94ooHoOyhDtCS
         MVsOlwyE3EXa4RZDT5Q77+6Jnoyrm+F8PfF3JEME=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:37 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 15/20] PCI: dwc: Introduce dma-ranges property support for RC-host
Date:   Mon, 22 Aug 2022 21:46:56 +0300
Message-ID: <20220822184701.25246-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
the internal Address Translation Unit which inbound and outbound tables
can be used to implement both properties semantics, it was surprising for
me to discover that the host-related part of the DW PCIe driver currently
supports the "ranges" property only while the "dma-ranges" windows are
just ignored. Having the "dma-ranges" supported in the driver would be
very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
mapping and require a customized PCIe memory layout. So let's fix that by
introducing the "dma-ranges" property support.

First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
dw_pcie_prog_ep_inbound_atu() and create a new version of the
dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for the
RC and EP controllers respectively in the same way as it has been
developed for the outbound ATU setup methods.

Secondly aside with the memory window index and type the new
dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
and size as its arguments. These parameters define the PCIe and CPU memory
ranges which will be used to setup the respective inbound ATU mapping. The
passed parameters need to be verified against the ATU ranges constraints
in the same way as it is done for the outbound ranges.

Finally the DMA-ranges detected for the PCIe controller need to be
converted to the inbound ATU entries during the host controller
initialization procedure. It will be done in the framework of the
dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
need to disable all the inbound ATU entries in order to prevent unexpected
PCIe TLPs translations defined by some third party software like
bootloaders.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v3:
- Drop inbound iATU window size alignment constraint. (@Manivannan)
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware.c  | 56 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
 4 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 83ddb190292e..237bb01d7852 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -171,8 +171,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
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
index 7746f94a715f..f0959a9a4970 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -657,12 +657,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
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
@@ -699,9 +702,32 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
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
index c6725c519a47..ca830ee794a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -393,8 +393,60 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
 	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
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
+	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
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
index 09b887093a84..f1a7f7ef4126 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -347,8 +347,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
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


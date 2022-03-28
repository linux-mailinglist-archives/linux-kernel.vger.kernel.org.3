Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D687A4E9A84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbiC1PL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiC1PKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:10:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12AB5D678;
        Mon, 28 Mar 2022 08:09:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CBA6F1D5AA4;
        Thu, 24 Mar 2022 04:25:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru CBA6F1D5AA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085128;
        bh=IbIaYTvWDrKAUBeB4maQw5G0xL0EbHFE7cErJ4OZffw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Kj3XWlAjDtwI1H7wfY5SLU0FfgYrkPz2fK/hU9LL6CDMyD9Qhis900nu//yxc4rxm
         WfSLS7bJ3moqeA9mMcMGw7gJo2X6rul0kW5tO5vq91/ENFjW7RWyqEQTf80x5rWHiJ
         1J3y8e/7dIi65F0viTmyB71tC/qHck0CagV/Odxk=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:25:28 +0300
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
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/12] PCI: dwc: Don't use generic IO-ops for DBI-space access
Date:   Thu, 24 Mar 2022 04:25:13 +0300
Message-ID: <20220324012524.16784-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
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

Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
the locally defined DW PCIe host controller config-space accessors with
the generic methods pci_generic_config_read() and
pci_generic_config_write(). It was intended that the corresponding
bus-mapping callback returned a correct virtual address of the passed PCI
config-space register. The problem of the proposed solution was that it
didn't take into account the way the host config-space is accessed on the
DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
interfaces can be used to access the host and peripheral config/memory
spaces. The former one can be accessed via the DBI interface, while the
later ones is reached via the AHB/AXI application bus. In case if the DW
PCIe controller is configured to have a dedicated DBI interface, the way
it is mapped into the IO-memory turns to be platform-specific. For such
setups the DWC PCIe driver provides a set of the callbacks
dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
able to take into account the DBI bus IO peculiarities. Since
commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
methods haven't been utilized during the generic host initialization
performed by the PCIe subsystem code.

I don't really know how come there have been no problems spotted for the
Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
aligned IO requirement the generic config-space accessors can't be
utilized for the host config-space. Thus in order to make sure the host
config-space is properly accessed via the DBI bus let's get back the
dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
be just wrappers around the already defined
dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
conversion. These methods perform the platform-specific config-space IO if
the DBI accessors are specified, otherwise they call normal MMIO
operations.

Fixes: c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a03619a30c20..f89e6552139b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -528,10 +528,40 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (PCI_SLOT(devfn) > 0) {
+		*val = ~0U;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = dw_pcie_read_dbi(pci, where, size);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int dw_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 val)
+{
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dw_pcie_write_dbi(pci, where, size, val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
-	.read = pci_generic_config_read,
-	.write = pci_generic_config_write,
+	.read = dw_pcie_rd_own_conf,
+	.write = dw_pcie_wr_own_conf,
 };
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
-- 
2.35.1


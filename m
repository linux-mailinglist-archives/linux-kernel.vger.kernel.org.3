Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F85190A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiECVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbiECVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:50:53 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E987741F82;
        Tue,  3 May 2022 14:47:13 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D255816DA;
        Wed,  4 May 2022 00:47:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru D255816DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614466;
        bh=vL9ZLHHm22X/gnPYmYxaWQdMrSZyf+tmef5JkFUoktQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Y0Uw0YHmDogdrNkK/kr1HrP3puXdg0Ysn+LlXkHF9N19WrAGGycL5PxUOAJ7bdcK3
         KWRfbWg6HUu5oiO2lMIT+YrHAPYPUqNWUkfR8ZjqQ86VYqTBIKEuRF4xN7UaPAPweP
         j2PLus7eD+O2rV8ACgZqiioWoMF4+3uOiOJiFelI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:12 +0300
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
Subject: [PATCH v2 12/17] PCI: dwc: Add iATU regions size detection procedure
Date:   Wed, 4 May 2022 00:46:33 +0300
Message-ID: <20220503214638.1895-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
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

Depending on the DWC PCIe RC/EP/DM IP-core configuration parameters the
controllers can be equipped not only with various number of inbound and
outbound iATU windows, but with varied regions settings like alignment
(which is also the minimum window size), minimum and maximum sizes. So to
speak if internal ATU is enabled for the denoted IP-cores then the former
settings will be defined by the CX_ATU_MIN_REGION_SIZE parameter while the
later one will be determined by the CX_ATU_MAX_REGION_SIZE configuration
parameter. Anyway having these parameters used in the driver will help to
verify whether the requested inbound or outbound memory mappings can be
fully created. Currently the driver doesn't perform any corresponding
checking.

Note 1. The extended iATU regions have been supported since DWC PCIe
v4.60a. There is no need in testing the upper limit register availability
for the older cores.

Note 2. The regions alignment is determined with using the fls() method
since the lower four bits of the ATU Limit register can be occupied with
the Circular Buffer Increment setting, which can be initialized with
zeros.

The (dma-)ranges verification will be added a bit later in one of the next
commits.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware.c | 33 +++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h |  2 ++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 0781fa145b3f..1cc5e3b2fa6d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -8,9 +8,11 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 #include "../../pci.h"
@@ -525,7 +527,8 @@ static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
-	u32 val;
+	u32 val, min, dir;
+	u64 max;
 
 	if (pci->iatu_unroll_enabled) {
 		max_region = min((int)pci->atu_size / 512, 256);
@@ -548,8 +551,29 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 			break;
 	}
 
-	pci->num_ib_windows = ib;
+	if (ob) {
+		dir = PCIE_ATU_REGION_DIR_OB;
+	} else if (ib) {
+		dir = PCIE_ATU_REGION_DIR_IB;
+	} else {
+		dev_err(pci->dev, "No iATU regions found\n");
+		return;
+	}
+
+	dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_LIMIT, 0x0);
+	min = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_LIMIT);
+
+	if (dw_pcie_ver_is_ge(pci, 460A)) {
+		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
+		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
+	} else {
+		max = 0;
+	}
+
 	pci->num_ob_windows = ob;
+	pci->num_ib_windows = ib;
+	pci->region_align = 1 << fls(min);
+	pci->region_limit = (max << 32) | (SZ_4G - 1);
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
@@ -583,8 +607,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
 
-	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound\n",
-		 pci->num_ob_windows, pci->num_ib_windows);
+	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
+		 pci->num_ob_windows, pci->num_ib_windows,
+		 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
 }
 
 void dw_pcie_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f5b793caabff..faf42f2b2ff3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -271,6 +271,8 @@ struct dw_pcie {
 	size_t			atu_size;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
+	u32			region_align;
+	u64			region_limit;
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF764C4C02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbiBYRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiBYRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E361A9073;
        Fri, 25 Feb 2022 09:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809851; x=1677345851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcahKzSV5jhjPPlKjgCu8591W/v1IEiY2tKgzmL6dpk=;
  b=Rp/Ds8oc3dPWYMhtKBqPMpDKmfq8rMtRjekoZyEOX5Og8pY9v1xrTrqj
   i98LUKQr2LA9qVkjqTOwkl4pQHJnfdj2o7Lkmw8KlcgqZCyoLtE/G/QBA
   yHL80hjZaB7WEQ0SVTNIhxsRBFKISGFibVv+51JU8QhB3VLE9Q78cR0UB
   xHQiFiZyprdtu3EmcOP1B4mGQx3QFQ/zacPHYKVvCY6528/f7lECb4j2P
   FM3Lgd6jYZC/88ZQ3gyS7EsZ4cbkfVtev2hAyN8/agzX83d3z90s09x+U
   HZh1fKEYwoDGbCmyuhRM/X63ktVbTMoVwCBgrUij74dkN7864JBJBvmmd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252271014"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252271014"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="628910897"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2022 09:24:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 780C264B; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 07/11] spi: pxa2xx-pci: Replace enum with direct use of PCI IDs
Date:   Fri, 25 Feb 2022 19:23:46 +0200
Message-Id: <20220225172350.69797-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating an abstraction on top of PCI IDs, just use them directly.
The corresponding enum can be dropped.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 161 ++++++++++++++++++-----------------
 1 file changed, 83 insertions(+), 78 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 5ac1487c9b3f..a0f24e811e9f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -15,17 +15,17 @@
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
 
-enum {
-	PORT_QUARK_X1000,
-	PORT_BYT,
-	PORT_MRFLD,
-	PORT_BSW0,
-	PORT_BSW1,
-	PORT_BSW2,
-	PORT_CE4100,
-	PORT_LPT0,
-	PORT_LPT1,
-};
+#define PCI_DEVICE_ID_INTEL_QUARK_X1000		0x0935
+#define PCI_DEVICE_ID_INTEL_BYT			0x0f0e
+#define PCI_DEVICE_ID_INTEL_MRFLD		0x1194
+#define PCI_DEVICE_ID_INTEL_BSW0		0x228e
+#define PCI_DEVICE_ID_INTEL_BSW1		0x2290
+#define PCI_DEVICE_ID_INTEL_BSW2		0x22ac
+#define PCI_DEVICE_ID_INTEL_CE4100		0x2e6a
+#define PCI_DEVICE_ID_INTEL_LPT0_0		0x9c65
+#define PCI_DEVICE_ID_INTEL_LPT0_1		0x9c66
+#define PCI_DEVICE_ID_INTEL_LPT1_0		0x9ce5
+#define PCI_DEVICE_ID_INTEL_LPT1_1		0x9ce6
 
 struct pxa_spi_info {
 	enum pxa_ssp_type type;
@@ -86,6 +86,49 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	struct pci_dev *dma_dev;
 	int ret;
 
+	switch (dev->device) {
+	case PCI_DEVICE_ID_INTEL_BYT:
+		c->type = LPSS_BYT_SSP;
+		c->port_id = 0;
+		c->tx_param = &byt_tx_param;
+		c->rx_param = &byt_rx_param;
+		break;
+	case PCI_DEVICE_ID_INTEL_BSW0:
+		c->type = LPSS_BSW_SSP;
+		c->port_id = 0;
+		c->tx_param = &bsw0_tx_param;
+		c->rx_param = &bsw0_rx_param;
+		break;
+	case PCI_DEVICE_ID_INTEL_BSW1:
+		c->type = LPSS_BSW_SSP;
+		c->port_id = 1;
+		c->tx_param = &bsw1_tx_param;
+		c->rx_param = &bsw1_rx_param;
+		break;
+	case PCI_DEVICE_ID_INTEL_BSW2:
+		c->type = LPSS_BSW_SSP;
+		c->port_id = 2;
+		c->tx_param = &bsw2_tx_param;
+		c->rx_param = &bsw2_rx_param;
+		break;
+	case PCI_DEVICE_ID_INTEL_LPT0_0:
+	case PCI_DEVICE_ID_INTEL_LPT1_0:
+		c->type = LPSS_LPT_SSP;
+		c->port_id = 0;
+		c->tx_param = &lpt0_tx_param;
+		c->rx_param = &lpt0_rx_param;
+		break;
+	case PCI_DEVICE_ID_INTEL_LPT0_1:
+	case PCI_DEVICE_ID_INTEL_LPT1_1:
+		c->type = LPSS_LPT_SSP;
+		c->port_id = 1;
+		c->tx_param = &lpt1_tx_param;
+		c->rx_param = &lpt1_rx_param;
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	c->num_chipselect = 1;
 	c->max_clk_rate = 50000000;
 
@@ -115,8 +158,13 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
+static struct pxa_spi_info lpss_info_config = {
+	.setup = lpss_spi_setup,
+};
+
 static int ce4100_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
+	c->type = PXA25x_SSP;
 	c->port_id = dev->devfn;
 	c->num_chipselect = dev->devfn;
 	c->max_clk_rate = 3686400;
@@ -124,6 +172,10 @@ static int ce4100_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
+static struct pxa_spi_info ce4100_info_config = {
+	.setup = ce4100_spi_setup,
+};
+
 static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
 	struct dw_dma_slave *tx, *rx;
@@ -153,6 +205,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 		return -ENODEV;
 	}
 
+	c->type = MRFLD_SSP;
 	c->max_clk_rate = 25000000;
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
@@ -171,8 +224,13 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
+static struct pxa_spi_info mrfld_info_config = {
+	.setup = mrfld_spi_setup,
+};
+
 static int qrk_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
+	c->type = QUARK_X1000_SSP;
 	c->port_id = dev->devfn;
 	c->num_chipselect = 1;
 	c->max_clk_rate = 50000000;
@@ -180,61 +238,8 @@ static int qrk_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
-static struct pxa_spi_info spi_info_configs[] = {
-	[PORT_CE4100] = {
-		.type = PXA25x_SSP,
-		.setup = ce4100_spi_setup,
-	},
-	[PORT_BYT] = {
-		.type = LPSS_BYT_SSP,
-		.port_id = 0,
-		.setup = lpss_spi_setup,
-		.tx_param = &byt_tx_param,
-		.rx_param = &byt_rx_param,
-	},
-	[PORT_BSW0] = {
-		.type = LPSS_BSW_SSP,
-		.port_id = 0,
-		.setup = lpss_spi_setup,
-		.tx_param = &bsw0_tx_param,
-		.rx_param = &bsw0_rx_param,
-	},
-	[PORT_BSW1] = {
-		.type = LPSS_BSW_SSP,
-		.port_id = 1,
-		.setup = lpss_spi_setup,
-		.tx_param = &bsw1_tx_param,
-		.rx_param = &bsw1_rx_param,
-	},
-	[PORT_BSW2] = {
-		.type = LPSS_BSW_SSP,
-		.port_id = 2,
-		.setup = lpss_spi_setup,
-		.tx_param = &bsw2_tx_param,
-		.rx_param = &bsw2_rx_param,
-	},
-	[PORT_MRFLD] = {
-		.type = MRFLD_SSP,
-		.setup = mrfld_spi_setup,
-	},
-	[PORT_QUARK_X1000] = {
-		.type = QUARK_X1000_SSP,
-		.setup = qrk_spi_setup,
-	},
-	[PORT_LPT0] = {
-		.type = LPSS_LPT_SSP,
-		.port_id = 0,
-		.setup = lpss_spi_setup,
-		.tx_param = &lpt0_tx_param,
-		.rx_param = &lpt0_rx_param,
-	},
-	[PORT_LPT1] = {
-		.type = LPSS_LPT_SSP,
-		.port_id = 1,
-		.setup = lpss_spi_setup,
-		.tx_param = &lpt1_tx_param,
-		.rx_param = &lpt1_rx_param,
-	},
+static struct pxa_spi_info qrk_info_config = {
+	.setup = qrk_spi_setup,
 };
 
 static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
@@ -256,7 +261,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	c = &spi_info_configs[ent->driver_data];
+	c = (struct pxa_spi_info *)ent->driver_data;
 	ret = c->setup(dev, c);
 	if (ret)
 		return ret;
@@ -320,17 +325,17 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
-	{ PCI_VDEVICE(INTEL, 0x0935), PORT_QUARK_X1000 },
-	{ PCI_VDEVICE(INTEL, 0x0f0e), PORT_BYT },
-	{ PCI_VDEVICE(INTEL, 0x1194), PORT_MRFLD },
-	{ PCI_VDEVICE(INTEL, 0x228e), PORT_BSW0 },
-	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
-	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
-	{ PCI_VDEVICE(INTEL, 0x2e6a), PORT_CE4100 },
-	{ PCI_VDEVICE(INTEL, 0x9c65), PORT_LPT0 },
-	{ PCI_VDEVICE(INTEL, 0x9c66), PORT_LPT1 },
-	{ PCI_VDEVICE(INTEL, 0x9ce5), PORT_LPT0 },
-	{ PCI_VDEVICE(INTEL, 0x9ce6), PORT_LPT1 },
+	{ PCI_DEVICE_DATA(INTEL, QUARK_X1000, &qrk_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, BYT, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, MRFLD, &mrfld_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, BSW0, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, BSW1, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, BSW2, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, CE4100, &ce4100_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, LPT0_0, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, LPT0_1, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, LPT1_0, &lpss_info_config) },
+	{ PCI_DEVICE_DATA(INTEL, LPT1_1, &lpss_info_config) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pxa2xx_spi_pci_devices);
-- 
2.34.1


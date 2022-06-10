Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121AE545EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbiFJIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbiFJISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:42 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCBD024C0B9;
        Fri, 10 Jun 2022 01:18:38 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 476A316A7;
        Fri, 10 Jun 2022 11:19:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 476A316A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849151;
        bh=M81wYYsdKNXa+ZZwg4pFUnZGLhl3d4svGtT5zJ/TRRI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UhjNqkdTDrSWR64key91iTxh7JIM5PEXiKQdsheBV67ohOcq1PwRfaeOMmTZTIOny
         nV8wltiHacxhLNCkjrmZNjQt3a9JjLTeIG5buHn/aZJNUcWHz/75a5S8WsYp9FP/wT
         lo1rpLY1qHuyUNv0YlHmGrL3NYJqgMfHjOZ1WrfU=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:19 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Date:   Fri, 10 Jun 2022 11:17:57 +0300
Message-ID: <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
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

Synopsys AHCI SATA controller can work pretty under with the generic
AHCI-platform driver control. But there are vendor-specific peculiarities
which can tune the device performance up and which may need to be fixed up
for proper device functioning. In addition some DWC AHCI-based controllers
may require small platform-specific fixups, so adding them in the generic
AHCI driver would have ruined the code simplicity. Shortly speaking in
order to keep the generic AHCI-platform code clean and have DWC AHCI
SATA-specific features supported we suggest to add a dedicated DWC AHCI
SATA device driver. Aside with the standard AHCI-platform resources
getting, enabling/disabling and the controller registration the new driver
performs the next actions.

First of all there is a way to verify whether the HBA/ports capabilities
activated in OF are correct. Almost all features availability is reflected
in the vendor-specific parameters registers. So the DWC AHCI driver does
the capabilities sanity check based on the corresponding fields state.

Secondly if either the Command Completion Coalescing or the Device Sleep
feature is enabled the DWC AHCI-specific internal 1ms timer must be fixed
in accordance with the application clock signal frequency. In particular
the timer value must be set to be Fapp * 1000. Normally the SoC designers
pre-configure the TIMER1MS register to contain a correct value by default.
But the platforms can support the application clock rate change. If that
happens the 1ms timer value must be accordingly updated otherwise the
dependent features won't work as expected. In the DWC AHCI driver we
suggest to rely on the "aclk" reference clock rate to set the timer
interval up. That clock source is supposed to be the AHCI SATA application
clock in accordance with the DT bindings.

Finally DWC AHCI SATA controller AXI/AHB bus DMA-engine can be tuned up to
transfer up to 1024 * FIFO words at a time by setting the Tx/Rx
transaction size in the DMA control register. The maximum value depends on
the DMA data bus and AXI/AHB bus maximum burst length. In most of the
cases it's better to set the maximum possible value to reach the best AHCI
SATA controller performance. But sometimes in order to improve the system
interconnect responsiveness, transferring in smaller data chunks may be
more preferable. For such cases and for the case when the default value
doesn't provide the best DMA bus performance we suggest to use the new
HBA-port specific DT-properties "snps,{tx,rx}-ts-max" to tune the DMA
transactions size up.

After all the settings denoted above are handled the DWC AHCI SATA driver
proceeds further with the standard AHCI-platform host initializations.

Note since DWC AHCI controller is now have a dedicated driver we can
discard the corresponding compatible string from the ahci-platform.c
module. The same concerns "snps,spear-ahci" compatible string, which is
also based on the DWC AHCI IP-core.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Note there are three more AHCI SATA drivers which have been created for
the devices based on the DWC AHCI SATA IP-core. It's AHCI SunXi, St and
iMX drivers. Mostly they don't support the features implemented in this
driver. So hopefully sometime in future they can be converted to be based
on the generic DWC AHCI SATA driver and just perform some
subvendor-specific setups in their own LLDD (glue) driver code. But for
now let's leave the generic DWC AHCI SATA code as is. Hopefully the new
DWC AHCI-based device drivers will try at least to re-use a part of the
DWC AHCI driver methods if not being able to be integrated in the generic
DWC driver code.

Changelog v2:
- Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_'.
  (@Damien)

Changelog v4:
- Replace GPLv2 with just GPL license which are the same in the framework
  of the MODULE_LICENSE() macro.
---
 drivers/ata/Kconfig         |  10 +
 drivers/ata/Makefile        |   1 +
 drivers/ata/ahci_dwc.c      | 395 ++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_platform.c |   2 -
 4 files changed, 406 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ata/ahci_dwc.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index bb45a9c00514..95e0e022b5bb 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -176,6 +176,16 @@ config AHCI_DM816
 
 	  If unsure, say N.
 
+config AHCI_DWC
+	tristate "Synopsys DWC AHCI SATA support"
+	select SATA_HOST
+	default SATA_AHCI_PLATFORM
+	help
+	  This option enables support for the Synopsys DWC AHCI SATA
+	  controller implementation.
+
+	  If unsure, say N.
+
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on ARCH_STI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b8aebfb14e82..34623365d9a6 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AHCI_BRCM)		+= ahci_brcm.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DM816)	+= ahci_dm816.o libahci.o libahci_platform.o
+obj-$(CONFIG_AHCI_DWC)		+= ahci_dwc.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MTK)		+= ahci_mtk.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
new file mode 100644
index 000000000000..8c2510933a31
--- /dev/null
+++ b/drivers/ata/ahci_dwc.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DWC AHCI SATA Platform driver
+ *
+ * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
+ */
+
+#include <linux/ahci_platform.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/libata.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+
+#include "ahci.h"
+
+#define DRV_NAME "ahci-dwc"
+
+#define AHCI_DWC_FBS_PMPN_MAX		15
+
+/* DWC AHCI SATA controller specific registers */
+#define AHCI_DWC_HOST_OOBR		0xbc
+#define AHCI_DWC_HOST_OOB_WE		BIT(31)
+#define AHCI_DWC_HOST_CWMIN_MASK	GENMASK(30, 24)
+#define AHCI_DWC_HOST_CWMAX_MASK	GENMASK(23, 16)
+#define AHCI_DWC_HOST_CIMIN_MASK	GENMASK(15, 8)
+#define AHCI_DWC_HOST_CIMAX_MASK	GENMASK(7, 0)
+
+#define AHCI_DWC_HOST_GPCR		0xd0
+#define AHCI_DWC_HOST_GPSR		0xd4
+
+#define AHCI_DWC_HOST_TIMER1MS		0xe0
+#define AHCI_DWC_HOST_TIMV_MASK		GENMASK(19, 0)
+
+#define AHCI_DWC_HOST_GPARAM1R		0xe8
+#define AHCI_DWC_HOST_ALIGN_M		BIT(31)
+#define AHCI_DWC_HOST_RX_BUFFER		BIT(30)
+#define AHCI_DWC_HOST_PHY_DATA_MASK	GENMASK(29, 28)
+#define AHCI_DWC_HOST_PHY_RST		BIT(27)
+#define AHCI_DWC_HOST_PHY_CTRL_MASK	GENMASK(26, 21)
+#define AHCI_DWC_HOST_PHY_STAT_MASK	GENMASK(20, 15)
+#define AHCI_DWC_HOST_LATCH_M		BIT(14)
+#define AHCI_DWC_HOST_PHY_TYPE_MASK	GENMASK(13, 11)
+#define AHCI_DWC_HOST_RET_ERR		BIT(10)
+#define AHCI_DWC_HOST_AHB_ENDIAN_MASK	GENMASK(9, 8)
+#define AHCI_DWC_HOST_S_HADDR		BIT(7)
+#define AHCI_DWC_HOST_M_HADDR		BIT(6)
+#define AHCI_DWC_HOST_S_HDATA_MASK	GENMASK(5, 3)
+#define AHCI_DWC_HOST_M_HDATA_MASK	GENMASK(2, 0)
+
+#define AHCI_DWC_HOST_GPARAM2R		0xec
+#define AHCI_DWC_HOST_FBS_MEM_S		BIT(19)
+#define AHCI_DWC_HOST_FBS_PMPN_MASK	GENMASK(17, 16)
+#define AHCI_DWC_HOST_FBS_SUP		BIT(15)
+#define AHCI_DWC_HOST_DEV_CP		BIT(14)
+#define AHCI_DWC_HOST_DEV_MP		BIT(13)
+#define AHCI_DWC_HOST_ENCODE_M		BIT(12)
+#define AHCI_DWC_HOST_RXOOB_CLK_M	BIT(11)
+#define AHCI_DWC_HOST_RXOOB_M		BIT(10)
+#define AHCI_DWC_HOST_TXOOB_M		BIT(9)
+#define AHCI_DWC_HOST_RXOOB_M		BIT(10)
+#define AHCI_DWC_HOST_RXOOB_CLK_MASK	GENMASK(8, 0)
+
+#define AHCI_DWC_HOST_PPARAMR		0xf0
+#define AHCI_DWC_HOST_TX_MEM_M		BIT(11)
+#define AHCI_DWC_HOST_TX_MEM_S		BIT(10)
+#define AHCI_DWC_HOST_RX_MEM_M		BIT(9)
+#define AHCI_DWC_HOST_RX_MEM_S		BIT(8)
+#define AHCI_DWC_HOST_TXFIFO_DEPTH	GENMASK(7, 4)
+#define AHCI_DWC_HOST_RXFIFO_DEPTH	GENMASK(3, 0)
+
+#define AHCI_DWC_HOST_TESTR		0xf4
+#define AHCI_DWC_HOST_PSEL_MASK		GENMASK(18, 16)
+#define AHCI_DWC_HOST_TEST_IF		BIT(0)
+
+#define AHCI_DWC_HOST_VERSIONR		0xf8
+#define AHCI_DWC_HOST_IDR		0xfc
+
+#define AHCI_DWC_PORT_DMACR		0x70
+#define AHCI_DWC_PORT_RXABL_MASK	GENMASK(15, 12)
+#define AHCI_DWC_PORT_TXABL_MASK	GENMASK(11, 8)
+#define AHCI_DWC_PORT_RXTS_MASK		GENMASK(7, 4)
+#define AHCI_DWC_PORT_TXTS_MASK		GENMASK(3, 0)
+#define AHCI_DWC_PORT_PHYCR		0x74
+#define AHCI_DWC_PORT_PHYSR		0x78
+
+struct ahci_dwc_host_priv {
+	struct platform_device *pdev;
+
+	u32 timv;
+	u32 dmacr[AHCI_MAX_PORTS];
+};
+
+static struct ahci_host_priv *ahci_dwc_get_resources(struct platform_device *pdev)
+{
+	struct ahci_dwc_host_priv *dpriv;
+	struct ahci_host_priv *hpriv;
+
+	dpriv = devm_kzalloc(&pdev->dev, sizeof(*dpriv), GFP_KERNEL);
+	if (!dpriv)
+		return ERR_PTR(-ENOMEM);
+
+	dpriv->pdev = pdev;
+
+	hpriv = ahci_platform_get_resources(pdev, AHCI_PLATFORM_GET_RESETS);
+	if (IS_ERR(hpriv))
+		return hpriv;
+
+	hpriv->plat_data = (void *)dpriv;
+
+	return hpriv;
+}
+
+static void ahci_dwc_check_cap(struct ahci_host_priv *hpriv)
+{
+	unsigned long port_map = hpriv->saved_port_map | hpriv->mask_port_map;
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
+	bool dev_mp, dev_cp, fbs_sup;
+	unsigned int fbs_pmp;
+	u32 param;
+	int i;
+
+	param = readl(hpriv->mmio + AHCI_DWC_HOST_GPARAM2R);
+	dev_mp = !!(param & AHCI_DWC_HOST_DEV_MP);
+	dev_cp = !!(param & AHCI_DWC_HOST_DEV_CP);
+	fbs_sup = !!(param & AHCI_DWC_HOST_FBS_SUP);
+	fbs_pmp = 5 * FIELD_GET(AHCI_DWC_HOST_FBS_PMPN_MASK, param);
+
+	if (!dev_mp && hpriv->saved_cap & HOST_CAP_MPS) {
+		dev_warn(&dpriv->pdev->dev, "MPS is unsupported\n");
+		hpriv->saved_cap &= ~HOST_CAP_MPS;
+	}
+
+
+	if (fbs_sup && fbs_pmp < AHCI_DWC_FBS_PMPN_MAX) {
+		dev_warn(&dpriv->pdev->dev, "PMPn is limited up to %u ports\n",
+			 fbs_pmp);
+	}
+
+	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
+		if (!dev_mp && hpriv->saved_port_cap[i] & PORT_CMD_MPSP) {
+			dev_warn(&dpriv->pdev->dev, "MPS incapable port %d\n", i);
+			hpriv->saved_port_cap[i] &= ~PORT_CMD_MPSP;
+		}
+
+		if (!dev_cp && hpriv->saved_port_cap[i] & PORT_CMD_CPD) {
+			dev_warn(&dpriv->pdev->dev, "CPD incapable port %d\n", i);
+			hpriv->saved_port_cap[i] &= ~PORT_CMD_CPD;
+		}
+
+		if (!fbs_sup && hpriv->saved_port_cap[i] & PORT_CMD_FBSCP) {
+			dev_warn(&dpriv->pdev->dev, "FBS incapable port %d\n", i);
+			hpriv->saved_port_cap[i] &= ~PORT_CMD_FBSCP;
+		}
+	}
+}
+
+static void ahci_dwc_init_timer(struct ahci_host_priv *hpriv)
+{
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
+	unsigned long rate;
+	struct clk *aclk;
+	u32 cap, cap2;
+
+	/* 1ms tick is generated only for the CCC or DevSleep features */
+	cap = readl(hpriv->mmio + HOST_CAP);
+	cap2 = readl(hpriv->mmio + HOST_CAP2);
+	if (!(cap & HOST_CAP_CCC) && !(cap2 & HOST_CAP2_SDS))
+		return;
+
+	/*
+	 * Tick is generated based on the AXI/AHB application clocks signal
+	 * so we need to be sure in the clock we are going to use.
+	 */
+	aclk = ahci_platform_find_clk(hpriv, "aclk");
+	if (!aclk)
+		return;
+
+	/* 1ms timer interval is set as TIMV = AMBA_FREQ[MHZ] * 1000 */
+	dpriv->timv = readl(hpriv->mmio + AHCI_DWC_HOST_TIMER1MS);
+	dpriv->timv = FIELD_GET(AHCI_DWC_HOST_TIMV_MASK, dpriv->timv);
+	rate = clk_get_rate(aclk) / 1000UL;
+	if (rate == dpriv->timv)
+		return;
+
+	dev_info(&dpriv->pdev->dev, "Update CCC/DevSlp timer for Fapp %lu MHz\n",
+		 rate / 1000UL);
+	dpriv->timv = FIELD_PREP(AHCI_DWC_HOST_TIMV_MASK, rate);
+	writel(dpriv->timv, hpriv->mmio + AHCI_DWC_HOST_TIMER1MS);
+}
+
+static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
+{
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
+	struct device_node *child;
+	void __iomem *port_mmio;
+	u32 port, dmacr, ts;
+
+	/*
+	 * Update the DMA Tx/Rx transaction sizes in accordance with the
+	 * platform setup. Note values exceeding maximal or minimal limits will
+	 * be automatically clamped. Also note the register isn't affected by
+	 * the HBA global reset so we can freely initialize it once until the
+	 * next system reset.
+	 */
+	for_each_child_of_node(dpriv->pdev->dev.of_node, child) {
+		if (!of_device_is_available(child))
+			continue;
+
+		if (of_property_read_u32(child, "reg", &port)) {
+			of_node_put(child);
+			return -EINVAL;
+		}
+
+		port_mmio = __ahci_port_base(hpriv, port);
+		dmacr = readl(port_mmio + AHCI_DWC_PORT_DMACR);
+
+		if (!of_property_read_u32(child, "snps,tx-ts-max", &ts)) {
+			ts = ilog2(ts);
+			dmacr &= ~AHCI_DWC_PORT_TXTS_MASK;
+			dmacr |= FIELD_PREP(AHCI_DWC_PORT_TXTS_MASK, ts);
+		}
+
+		if (!of_property_read_u32(child, "snps,rx-ts-max", &ts)) {
+			ts = ilog2(ts);
+			dmacr &= ~AHCI_DWC_PORT_RXTS_MASK;
+			dmacr |= FIELD_PREP(AHCI_DWC_PORT_RXTS_MASK, ts);
+		}
+
+		writel(dmacr, port_mmio + AHCI_DWC_PORT_DMACR);
+		dpriv->dmacr[port] = dmacr;
+	}
+
+	return 0;
+}
+
+static int ahci_dwc_init_host(struct ahci_host_priv *hpriv)
+{
+	int rc;
+
+	rc = ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
+
+	ahci_dwc_check_cap(hpriv);
+
+	ahci_dwc_init_timer(hpriv);
+
+	rc = ahci_dwc_init_dmacr(hpriv);
+	if (rc)
+		goto err_disable_resources;
+
+	return 0;
+
+err_disable_resources:
+	ahci_platform_disable_resources(hpriv);
+
+	return rc;
+}
+
+static int ahci_dwc_reinit_host(struct ahci_host_priv *hpriv)
+{
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
+	unsigned long port_map = hpriv->port_map;
+	void __iomem *port_mmio;
+	int i, rc;
+
+	rc = ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
+
+	writel(dpriv->timv, hpriv->mmio + AHCI_DWC_HOST_TIMER1MS);
+
+	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
+		port_mmio = __ahci_port_base(hpriv, i);
+		writel(dpriv->dmacr[i], port_mmio + AHCI_DWC_PORT_DMACR);
+	}
+
+	return 0;
+}
+
+static void ahci_dwc_clear_host(struct ahci_host_priv *hpriv)
+{
+	ahci_platform_disable_resources(hpriv);
+}
+
+static void ahci_dwc_stop_host(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	ahci_dwc_clear_host(hpriv);
+}
+
+static struct ata_port_operations ahci_dwc_port_ops = {
+	.inherits	= &ahci_platform_ops,
+	.host_stop	= ahci_dwc_stop_host,
+};
+
+static const struct ata_port_info ahci_dwc_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_dwc_port_ops,
+};
+
+static struct scsi_host_template ahci_dwc_scsi_info = {
+	AHCI_SHT(DRV_NAME),
+};
+
+static int ahci_dwc_probe(struct platform_device *pdev)
+{
+	struct ahci_host_priv *hpriv;
+	int rc;
+
+	hpriv = ahci_dwc_get_resources(pdev);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+
+	rc = ahci_dwc_init_host(hpriv);
+	if (rc)
+		return rc;
+
+	rc = ahci_platform_init_host(pdev, hpriv, &ahci_dwc_port_info,
+				     &ahci_dwc_scsi_info);
+	if (rc)
+		goto err_clear_host;
+
+	return 0;
+
+err_clear_host:
+	ahci_dwc_clear_host(hpriv);
+
+	return rc;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ahci_dwc_suspend(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	int rc;
+
+	rc = ahci_platform_suspend_host(dev);
+	if (rc)
+		return rc;
+
+	ahci_dwc_clear_host(hpriv);
+
+	return 0;
+}
+
+static int ahci_dwc_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	int rc;
+
+	rc = ahci_dwc_reinit_host(hpriv);
+	if (rc)
+		return rc;
+
+	return ahci_platform_resume_host(dev);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend, ahci_dwc_resume);
+
+static const struct of_device_id ahci_dwc_of_match[] = {
+	{ .compatible = "snps,dwc-ahci", },
+	{ .compatible = "snps,spear-ahci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
+
+static struct platform_driver ahci_dwc_driver = {
+	.probe = ahci_dwc_probe,
+	.remove = ata_platform_remove_one,
+	.shutdown = ahci_platform_shutdown,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = ahci_dwc_of_match,
+		.pm = &ahci_dwc_pm_ops,
+	},
+};
+module_platform_driver(ahci_dwc_driver);
+
+MODULE_DESCRIPTION("DWC AHCI SATA platform driver");
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9b56490ecbc3..8f5572a9f8f1 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "generic-ahci", },
 	/* Keep the following compatibles for device tree compatibility */
-	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
-	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
 	{ .compatible = "cavium,octeon-7130-ahci", },
 	{ /* sentinel */ }
-- 
2.35.1


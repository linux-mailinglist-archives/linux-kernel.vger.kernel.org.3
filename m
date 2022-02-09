Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8A4B00A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiBIWub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:50:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiBIWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:50:29 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB70E019D30
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:50:31 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219II1BT014384;
        Wed, 9 Feb 2022 14:50:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=7RkEWIdLr/95foI/fy387qw2AdNcugygmO8gzBeLiQY=;
 b=LSx27XqjK1o0D6on76xPi1y4DxKa2UGdAB/ub2fMxOlXt/psZ12fcNZ0Ok0JrlOjbuPG
 +/WG+p5qYKotPCer+Lz1XaJTdjFt9nN+QuPovkK5hxeTpiQ5SwtGzatUBTEB9jmVgbZg
 vUXF7PRaF07uZ8rJvbvujX6pMDzo8eeeZjbe5u5fefzehGyIHurifyGktweJNTvOUFBH
 l7hMfEXehGhL2/xBEIm/BuJxClFL9jbT1eQkCedhiVCD/tHRgop0jJY3wCBMkDEtw0Dm
 Qs9jLDd3ec9+qPI63yT1EQqLrYfbcPQ4IQfY6uIB59OSr6/uU9/Yd3nszY05TH+e1XQI PQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e4am93e2a-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:50:22 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 14:50:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 14:50:13 -0800
Received: from rchin-dellt430.marvell.com (rchin-dellt430.marvell.com [10.85.176.141])
        by maili.marvell.com (Postfix) with ESMTP id 5E30C3F70AC;
        Wed,  9 Feb 2022 14:50:13 -0800 (PST)
From:   Radha Mohan Chintakuntla <radhac@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        "Radha Mohan Chintakuntla" <radhac@marvell.com>
Subject: [PATCH] soc: octeontx2-dpi: Add DPI DMA PF driver
Date:   Wed, 9 Feb 2022 14:50:10 -0800
Message-ID: <20220209225010.154415-1-radhac@marvell.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oF9FfklEBpmueA4EVcdEveWP6D_UFBdU
X-Proofpoint-ORIG-GUID: oF9FfklEBpmueA4EVcdEveWP6D_UFBdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPI DMA block in the Octeon TX2 SoC provides support for DMA between
memory to memory transfers and also transfers between a host and Octeon
Tx2 when it is in PCIe endpoint mode.

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
 MAINTAINERS                                |   7 +
 drivers/soc/marvell/Kconfig                |  10 +
 drivers/soc/marvell/Makefile               |   1 +
 drivers/soc/marvell/octeontx2-dpi/Makefile |   8 +
 drivers/soc/marvell/octeontx2-dpi/dpi.c    | 563 +++++++++++++++++++++
 drivers/soc/marvell/octeontx2-dpi/dpi.h    | 335 ++++++++++++
 6 files changed, 924 insertions(+)
 create mode 100644 drivers/soc/marvell/octeontx2-dpi/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2-dpi/dpi.c
 create mode 100644 drivers/soc/marvell/octeontx2-dpi/dpi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fb48e0317d34..f39f64f0bc1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11463,6 +11463,13 @@ S:	Maintained
 F:	drivers/crypto/marvell/
 F:	include/linux/soc/marvell/octeontx2/
 
+MARVELL OCTEONTX2 DPI DMA PHYISCAL FUNCTION DRIVER
+M:	Radha Mohan Chintakuntla <radhac@marvell.com>
+M:	Veerasenareddy Burry <vburru@marvell.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/soc/marvell/octeontx2-dpi/
+
 MARVELL GIGABIT ETHERNET DRIVERS (skge/sky2)
 M:	Mirko Lindner <mlindner@marvell.com>
 M:	Stephen Hemminger <stephen@networkplumber.org>
diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
index 4e8f8a60b3df..6e185e98a02c 100644
--- a/drivers/soc/marvell/Kconfig
+++ b/drivers/soc/marvell/Kconfig
@@ -4,6 +4,16 @@
 
 menu "Marvell SoC drivers"
 
+config OCTEONTX2_DPI_PF
+	tristate "OcteonTX2 DPI-DMA PF driver"
+	depends on ARM64 && PCI
+	default m
+	help
+	  Select this option to enable DPI PF driver support.
+	  DPI (DMA packet interface) provides DMA support for MAC.
+	  This driver intializes DPI PF device and enables VFs for supporting
+	  different types of DMA transfers.
+
 config OCTEONTX2_SDP_PF
 	tristate "OcteonTX2 SDP PF driver"
 	depends on ARM64 && PCI && OCTEONTX2_AF && OCTEONTX2_MBOX
diff --git a/drivers/soc/marvell/Makefile b/drivers/soc/marvell/Makefile
index 9a9a4435d64d..a1835a44a22c 100644
--- a/drivers/soc/marvell/Makefile
+++ b/drivers/soc/marvell/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y		+= octeontx2-dpi/
 obj-y		+= octeontx2-sdp/
diff --git a/drivers/soc/marvell/octeontx2-dpi/Makefile b/drivers/soc/marvell/octeontx2-dpi/Makefile
new file mode 100644
index 000000000000..73640517593c
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2-dpi/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Marvell's OcteonTX2 DPI PF driver
+#
+
+obj-$(CONFIG_OCTEONTX2_DPI_PF) += octeontx2_dpi.o
+
+octeontx2_dpi-y := dpi.o
diff --git a/drivers/soc/marvell/octeontx2-dpi/dpi.c b/drivers/soc/marvell/octeontx2-dpi/dpi.c
new file mode 100644
index 000000000000..9dd7167e930c
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2-dpi/dpi.c
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx2 DPI PF driver
+ *
+ * Copyright (C) 2022 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/sysfs.h>
+
+#include "dpi.h"
+
+#define DPI_DRV_NAME	"octeontx2-dpi"
+#define DPI_DRV_STRING      "Marvell OcteonTX2 DPI-DMA Driver"
+#define DPI_DRV_VERSION	"1.0"
+
+static int mps = 128;
+module_param(mps, int, 0644);
+MODULE_PARM_DESC(mps, "Maximum payload size, Supported sizes are 128, 256, 512 and 1024 bytes");
+
+static int mrrs = 128;
+module_param(mrrs, int, 0644);
+MODULE_PARM_DESC(mrrs, "Maximum read request size, Supported sizes are 128, 256, 512 and 1024 bytes");
+
+static inline bool is_otx3_dpi(struct dpipf *dpi)
+{
+	if (dpi->pdev->subsystem_device >= PCI_SUBDEVID_OCTEONTX3_DPI_PF)
+		return 1;
+
+	return 0;
+}
+
+static void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
+{
+	writeq(val, dpi->reg_base + offset);
+}
+
+static u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
+{
+	return readq(dpi->reg_base + offset);
+}
+
+static int dpi_dma_engine_get_num(void)
+{
+	return DPI_MAX_ENGINES;
+}
+
+static int dpi_queue_init(struct dpipf *dpi, struct dpipf_vf *dpivf, u8 vf)
+{
+	int engine = 0;
+	int queue = vf;
+	u64 reg = 0ULL;
+	u32 aura = dpivf->vf_config.aura;
+	u16 buf_size = dpivf->vf_config.csize;
+	u16 sso_pf_func = dpivf->vf_config.sso_pf_func;
+	u16 npa_pf_func = dpivf->vf_config.npa_pf_func;
+
+	reg = DPI_DMA_IBUFF_CSIZE_CSIZE((u64)(buf_size / 8));
+	if (is_otx3_dpi(dpi))
+		reg |= DPI_DMA_IBUFF_CSIZE_NPA_FREE;
+	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(queue), reg);
+
+	if (!is_otx3_dpi(dpi)) {
+		/* IDs are already configured while creating the domains.
+		 * No need to configure here.
+		 */
+		for (engine = 0; engine < dpi_dma_engine_get_num(); engine++) {
+			/* Don't configure the queues for PKT engines */
+			if (engine >= 4)
+				break;
+
+			reg = 0;
+			reg = dpi_reg_read(dpi, DPI_DMA_ENGX_EN(engine));
+			reg |= DPI_DMA_ENG_EN_QEN(0x1 << queue);
+			dpi_reg_write(dpi, DPI_DMA_ENGX_EN(engine), reg);
+		}
+	}
+
+	reg = dpi_reg_read(dpi, DPI_DMAX_IDS2(queue));
+	reg |= DPI_DMA_IDS2_INST_AURA(aura);
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), reg);
+
+	reg = dpi_reg_read(dpi, DPI_DMAX_IDS(queue));
+	reg |= DPI_DMA_IDS_DMA_NPA_PF_FUNC(npa_pf_func);
+	reg |= DPI_DMA_IDS_DMA_SSO_PF_FUNC(sso_pf_func);
+	reg |= DPI_DMA_IDS_DMA_STRM(vf + 1);
+	reg |= DPI_DMA_IDS_INST_STRM(vf + 1);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), reg);
+
+	return 0;
+}
+
+static int dpi_queue_fini(struct dpipf *dpi, struct dpipf_vf *dpivf, u8 vf)
+{
+	u64 reg = 0ULL;
+	int engine = 0;
+	int queue = vf;
+	u16 buf_size = dpivf->vf_config.csize;
+
+	for (engine = 0; engine < dpi_dma_engine_get_num(); engine++) {
+		/* Don't configure the queues for PKT engines */
+		if (engine >= 4)
+			break;
+
+		reg = 0;
+		reg = dpi_reg_read(dpi, DPI_DMA_ENGX_EN(engine));
+		reg &= DPI_DMA_ENG_EN_QEN((~(1 << queue)));
+		dpi_reg_write(dpi, DPI_DMA_ENGX_EN(engine), reg);
+	}
+
+	dpi_reg_write(dpi, DPI_DMAX_QRST(queue), 0x1ULL);
+	/* TBD: below code required ? */
+	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(queue),
+		      DPI_DMA_IBUFF_CSIZE_CSIZE((u64)(buf_size)));
+
+	/* Reset IDS and IDS2 registers */
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), 0ULL);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), 0ULL);
+
+	return 0;
+}
+
+/**
+ * Global initialization of DPI
+ *
+ * @dpi: DPI device context structure
+ * @return Zero on success, negative on failure
+ */
+static int dpi_init(struct dpipf *dpi)
+{
+	int engine = 0, port = 0;
+	u8 mrrs_val, mps_val;
+	u64 reg = 0ULL;
+
+	for (engine = 0; engine < dpi_dma_engine_get_num(); engine++) {
+		if (engine == 4 || engine == 5)
+			reg = DPI_ENG_BUF_BLKS(16);
+		else
+			reg = DPI_ENG_BUF_BLKS(8);
+
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
+
+		/* Here qmap for the engines are set to 0.
+		 * No dpi queues are mapped to engines.
+		 * When a VF is initialised corresponding bit
+		 * in the qmap will be set for all engines.
+		 */
+		if (!is_otx3_dpi(dpi))
+			dpi_reg_write(dpi, DPI_DMA_ENGX_EN(engine), 0x0ULL);
+	}
+
+	reg = 0ULL;
+	reg =  (DPI_DMA_CONTROL_ZBWCSEN | DPI_DMA_CONTROL_PKT_EN |
+		DPI_DMA_CONTROL_LDWB | DPI_DMA_CONTROL_O_MODE);
+
+	if (is_otx3_dpi(dpi))
+		reg |= DPI_DMA_CONTROL_DMA_ENB(0x3fULL);
+	else
+		reg |= DPI_DMA_CONTROL_DMA_ENB(0xfULL);
+
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+	dpi_reg_write(dpi, DPI_CTL, DPI_CTL_EN);
+
+	/* Configure MPS and MRRS for DPI */
+	if (mrrs < DPI_EBUS_MRRS_MIN || mrrs > DPI_EBUS_MRRS_MAX ||
+			!is_power_of_2(mrrs)) {
+		dev_info(&dpi->pdev->dev,
+			"Invalid MRRS size:%d, Using default size(128 bytes)\n"
+			, mrrs);
+		mrrs = 128;
+	}
+	mrrs_val = fls(mrrs) - 8;
+
+	if (mps < DPI_EBUS_MPS_MIN || mps > DPI_EBUS_MPS_MAX
+			|| !is_power_of_2(mps)) {
+		dev_info(&dpi->pdev->dev,
+			"Invalid MPS size:%d, Using default size(128 bytes)\n"
+			, mps);
+		mps = 128;
+	}
+	mps_val = fls(mps) - 8;
+
+	for (port = 0; port < DPI_EBUS_MAX_PORTS; port++) {
+		reg = dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(port));
+		reg &= ~(DPI_EBUS_PORTX_CFG_MRRS(0x7) |
+			 DPI_EBUS_PORTX_CFG_MPS(0x7));
+		reg |= (DPI_EBUS_PORTX_CFG_MPS(mps_val) |
+			DPI_EBUS_PORTX_CFG_MRRS(mrrs_val));
+		dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(port), reg);
+	}
+
+	/* Set the write control FIFO threshold as per HW recommendation */
+	if (is_otx3_dpi(dpi))
+		dpi_reg_write(dpi, DPI_WCTL_FIF_THR, 0x30);
+
+	return 0;
+}
+
+static int dpi_fini(struct dpipf *dpi)
+{
+	int engine = 0, port;
+	u64 reg = 0ULL;
+
+	for (engine = 0; engine < dpi_dma_engine_get_num(); engine++) {
+
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
+		if (!is_otx3_dpi(dpi))
+			dpi_reg_write(dpi, DPI_DMA_ENGX_EN(engine), 0x0ULL);
+	}
+
+	reg = 0ULL;
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+	dpi_reg_write(dpi, DPI_CTL, ~DPI_CTL_EN);
+
+	for (port = 0; port < DPI_EBUS_MAX_PORTS; port++) {
+		reg = dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(port));
+		reg &= ~DPI_EBUS_PORTX_CFG_MRRS(0x7);
+		reg &= ~DPI_EBUS_PORTX_CFG_MPS(0x7);
+		dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(port), reg);
+	}
+	return 0;
+}
+
+static int dpi_queue_reset(struct dpipf *dpi, u16 queue)
+{
+	/* Nothing to do yet */
+	return 0;
+}
+
+static irqreturn_t dpi_pf_intr_handler (int irq, void *dpi_irq)
+{
+	u64 reg_val = 0;
+	int i = 0;
+	struct dpipf *dpi = (struct dpipf *)dpi_irq;
+
+	dev_err(&dpi->pdev->dev, "intr received: %d\n", irq);
+
+	/* extract MSIX vector number from irq number. */
+	while (irq != pci_irq_vector(dpi->pdev, i)) {
+		i++;
+		if (i > dpi->num_vec)
+			break;
+	}
+	if (i < DPI_REQQX_INT_IDX) {
+		reg_val = dpi_reg_read(dpi, DPI_DMA_CCX_INT(i));
+		dev_err(&dpi->pdev->dev, "DPI_CC%d_INT raised: 0x%016llx\n",
+			i, reg_val);
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i), 0x1ULL);
+	} else if (i < DPI_SDP_FLR_RING_LINTX_IDX) {
+		reg_val = dpi_reg_read(
+			dpi, DPI_REQQX_INT(i - DPI_REQQX_INT_IDX));
+		dev_err(&dpi->pdev->dev,
+			"DPI_REQQ_INT raised for q:%d: 0x%016llx\n",
+			(i - 0x40), reg_val);
+
+		dpi_reg_write(
+			dpi, DPI_REQQX_INT(i - DPI_REQQX_INT_IDX), reg_val);
+
+		if (reg_val & (0x71ULL))
+			dpi_queue_reset(dpi, (i - DPI_REQQX_INT_IDX));
+	} else if (i < DPI_SDP_IRE_LINTX_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_SDP_FLR_RING_LINTX raised\n");
+
+	} else if (i < DPI_SDP_ORE_LINTX_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_SDP_IRE_LINTX raised\n");
+
+	} else if (i < DPI_SDP_ORD_LINTX_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_SDP_ORE_LINTX raised\n");
+
+	} else if (i < DPI_EPFX_PP_VF_LINTX_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_SDP_ORD_LINTX raised\n");
+
+	} else if (i < DPI_EPFX_DMA_VF_LINTX_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_EPFX_PP_VF_LINTX raised\n");
+
+	} else if (i < DPI_EPFX_MISC_LINTX_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_EPFX_DMA_VF_LINTX raised\n");
+
+	} else if (i < DPI_PF_RAS_IDX) {
+		/* TODO: handle interrupt */
+		dev_err(&dpi->pdev->dev, "DPI_EPFX_MISC_LINTX raised\n");
+
+	} else if (i == DPI_PF_RAS_IDX) {
+		reg_val = dpi_reg_read(dpi, DPI_PF_RAS);
+		dev_err(&dpi->pdev->dev, "DPI_PF_RAS raised: 0x%016llx\n",
+			reg_val);
+		dpi_reg_write(dpi, DPI_PF_RAS, reg_val);
+	}
+	return IRQ_HANDLED;
+}
+
+static int dpi_irq_init(struct dpipf *dpi)
+{
+	int i, irq = 0;
+	int ret = 0;
+
+	/* Clear All Interrupts */
+	dpi_reg_write(dpi, DPI_PF_RAS, DPI_PF_RAS_INT);
+
+	/* Clear All Enables */
+	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1C, DPI_PF_RAS_INT);
+
+	for (i = 0; i < DPI_MAX_REQQ_INT; i++) {
+		dpi_reg_write(dpi, DPI_REQQX_INT(i), DPI_REQQ_INT);
+		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1C(i), DPI_REQQ_INT);
+	}
+
+	for (i = 0; i < DPI_MAX_CC_INT; i++) {
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i), DPI_DMA_CC_INT);
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT_ENA_W1C(i), DPI_DMA_CC_INT);
+	}
+
+	dpi->num_vec = pci_msix_vec_count(dpi->pdev);
+	/* Enable MSI-X */
+	ret = pci_alloc_irq_vectors(dpi->pdev, dpi->num_vec,
+				    dpi->num_vec, PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_err(&dpi->pdev->dev,
+			"DPIPF: Request for %d msix vectors failed, ret %d\n",
+			dpi->num_vec, ret);
+		goto alloc_fail;
+	}
+
+	for (irq = 0; irq < dpi->num_vec; irq++) {
+		ret = request_irq(pci_irq_vector(dpi->pdev, irq),
+				  dpi_pf_intr_handler, 0, "DPIPF", dpi);
+		if (ret) {
+			dev_err(&dpi->pdev->dev,
+				"DPIPF: IRQ(%d) registration failed for DPIPF\n",
+				irq);
+			goto fail;
+		}
+	}
+
+#define ENABLE_DPI_INTERRUPTS 0
+#if ENABLE_DPI_INTERRUPTS
+	/*Enable All Interrupts */
+	for (i = 0; i < DPI_MAX_REQQ_INT; i++)
+		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1S(i), DPI_REQQ_INT);
+
+	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1S, DPI_PF_RAS_INT);
+#endif
+	return 0;
+fail:
+	if (irq) {
+		for (i = 0; i <= irq; i++)
+			free_irq(pci_irq_vector(dpi->pdev, i), dpi);
+	}
+	pci_free_irq_vectors(dpi->pdev);
+alloc_fail:
+	dpi->num_vec = 0;
+	return ret;
+}
+
+static void dpi_irq_free(struct dpipf *dpi)
+{
+	int i = 0;
+
+	/* Clear All Enables */
+	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1C, DPI_PF_RAS_INT);
+
+	for (i = 0; i < DPI_MAX_REQQ_INT; i++) {
+		dpi_reg_write(dpi, DPI_REQQX_INT(i), DPI_REQQ_INT);
+		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1C(i), DPI_REQQ_INT);
+	}
+
+	for (i = 0; i < DPI_MAX_CC_INT; i++) {
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i), DPI_DMA_CC_INT);
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT_ENA_W1C(i), DPI_DMA_CC_INT);
+	}
+
+	for (i = 0; i < dpi->num_vec; i++)
+		free_irq(pci_irq_vector(dpi->pdev, i), dpi);
+
+	pci_free_irq_vectors(dpi->pdev);
+	dpi->num_vec = 0;
+}
+
+static int dpi_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	struct dpipf *dpi = pci_get_drvdata(pdev);
+	int ret = 0;
+
+	if (numvfs == 0) {
+		pci_disable_sriov(pdev);
+		dpi->total_vfs = 0;
+	} else {
+		ret = pci_enable_sriov(pdev, numvfs);
+		if (ret == 0) {
+			dpi->total_vfs = numvfs;
+			ret = numvfs;
+		}
+	}
+
+	return ret;
+}
+
+static int queue_config(struct dpipf *dpi, struct dpipf_vf *dpivf,
+						union dpi_mbox_message_t *msg)
+{
+	switch (msg->s.cmd) {
+	case DPI_QUEUE_OPEN:
+		dpivf->vf_config.aura = msg->s.aura;
+		dpivf->vf_config.csize = msg->s.csize;
+		dpivf->vf_config.sso_pf_func = msg->s.sso_pf_func;
+		dpivf->vf_config.npa_pf_func = msg->s.npa_pf_func;
+		dpi_queue_init(dpi, dpivf, msg->s.vfid);
+		dpivf->setup_done = true;
+		break;
+	case DPI_QUEUE_CLOSE:
+		dpivf->vf_config.aura = 0;
+		dpivf->vf_config.csize = 0;
+		dpivf->vf_config.sso_pf_func = 0;
+		dpivf->vf_config.npa_pf_func = 0;
+		dpi_queue_fini(dpi, dpivf, msg->s.vfid);
+		dpivf->setup_done = false;
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
+
+static int dpi_queue_config(struct pci_dev *pfdev,
+			    union dpi_mbox_message_t *msg)
+{
+	struct device *dev = &pfdev->dev;
+	struct dpipf *dpi = pci_get_drvdata(pfdev);
+	struct dpipf_vf *dpivf;
+
+	if (msg->s.vfid > dpi->total_vfs) {
+		dev_err(dev, "Invalid vfid:%d\n", msg->s.vfid);
+		return -1;
+	}
+	dpivf = &dpi->vf[msg->s.vfid];
+
+	return queue_config(dpi, dpivf, msg);
+}
+static int dpi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct dpipf *dpi;
+	int err;
+
+	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
+	dpi->pdev = pdev;
+
+	pci_set_drvdata(pdev, dpi);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		pci_set_drvdata(pdev, NULL);
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DPI_DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto err_disable_device;
+	}
+
+	/* MAP configuration registers */
+	dpi->reg_base = pcim_iomap(pdev, PCI_DPI_PF_CFG_BAR, 0);
+	if (!dpi->reg_base) {
+		dev_err(dev, "DPI: Cannot map CSR memory space, aborting\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	/* Initialize global PF registers */
+	err = dpi_init(dpi);
+	if (err) {
+		dev_err(dev, "DPI: Failed to initialize dpi\n");
+		goto err_release_regions;
+	}
+
+	/* Register interrupts */
+	err = dpi_irq_init(dpi);
+	if (err) {
+		dev_err(dev, "DPI: Failed to initialize irq vectors\n");
+		goto err_dpi_fini;
+	}
+
+	return 0;
+
+err_dpi_fini:
+	dpi_fini(dpi);
+err_release_regions:
+	pci_release_regions(pdev);
+err_disable_device:
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, dpi);
+	return err;
+}
+
+static void dpi_remove(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dpipf *dpi = pci_get_drvdata(pdev);
+
+	dpi_irq_free(dpi);
+	dpi_fini(dpi);
+	dpi_sriov_configure(pdev, 0);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, dpi);
+}
+
+struct otx2_dpipf_com_s otx2_dpipf_com  = {
+	.queue_config = dpi_queue_config
+};
+EXPORT_SYMBOL(otx2_dpipf_com);
+
+static const struct pci_device_id dpi_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_DPI_PF) },
+	{ 0, }  /* end of table */
+};
+
+static struct pci_driver dpi_driver = {
+	.name = DPI_DRV_NAME,
+	.id_table = dpi_id_table,
+	.probe = dpi_probe,
+	.remove = dpi_remove,
+	.sriov_configure = dpi_sriov_configure,
+};
+
+static int __init dpi_init_module(void)
+{
+	pr_info("%s: %s\n", DPI_DRV_NAME, DPI_DRV_STRING);
+
+	return pci_register_driver(&dpi_driver);
+}
+
+static void __exit dpi_cleanup_module(void)
+{
+	pci_unregister_driver(&dpi_driver);
+}
+
+module_init(dpi_init_module);
+module_exit(dpi_cleanup_module);
+MODULE_DEVICE_TABLE(pci, dpi_id_table);
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION(DPI_DRV_STRING);
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DPI_DRV_VERSION);
+
diff --git a/drivers/soc/marvell/octeontx2-dpi/dpi.h b/drivers/soc/marvell/octeontx2-dpi/dpi.h
new file mode 100644
index 000000000000..89aeba02ecaa
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2-dpi/dpi.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell OcteonTx2 DPI PF driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DPI_H__
+#define __DPI_H__
+
+ /* PCI device IDs */
+#define PCI_DEVID_OCTEONTX2_DPI_PF	0xA080
+#define PCI_DEVID_OCTEONTX2_DPI_VF	0xA081
+#define PCI_SUBDEVID_OCTEONTX3_DPI_PF	0xB900
+
+/* PCI BAR nos */
+#define PCI_DPI_PF_CFG_BAR		0
+#define PCI_DPI_PF_MSIX_BAR		4
+#define PCI_DPI_VF_CFG_BAR		0
+#define PCI_DPI_VF_MSIX_BAR		4
+#define DPI_VF_CFG_SIZE			0x100000
+#define DPI_VF_OFFSET(x)		(0x20000000 | 0x100000 * (x))
+
+/* MSI-X interrupts */
+#define DPI_MAX_REQQ_INT ({				\
+	u32 val;					\
+	val = 8;					\
+	if (is_otx3_dpi(dpi))				\
+		val = 32;				\
+	val; })						\
+
+#define DPI_MAX_CC_INT			64
+
+/* MSI-X interrupt vectors indexes */
+#define DPI_CCX_INT_IDX			0x0
+#define DPI_REQQX_INT_IDX		0x40
+#define DPI_SDP_FLR_RING_LINTX_IDX	0x48
+#define DPI_SDP_IRE_LINTX_IDX		0x4C
+#define DPI_SDP_ORE_LINTX_IDX		0x50
+#define DPI_SDP_ORD_LINTX_IDX		0x54
+#define DPI_EPFX_PP_VF_LINTX_IDX	0x58
+#define DPI_EPFX_DMA_VF_LINTX_IDX	0x78
+#define DPI_EPFX_MISC_LINTX_IDX		0x98
+#define DPI_PF_RAS_IDX			0xA8
+
+#define DPI_MAX_ENGINES			6
+#define DPI_MAX_VFS			32
+
+/****************  Macros for register modification ************/
+#define DPI_DMA_IBUFF_CSIZE_CSIZE(x)		((x) & 0x1fff)
+#define DPI_DMA_IBUFF_CSIZE_GET_CSIZE(x)	((x) & 0x1fff)
+
+#define DPI_DMA_IBUFF_CSIZE_NPA_FREE		(1 << 16)
+
+#define DPI_DMA_IDS_INST_STRM(x)		((uint64_t)((x) & 0xff) << 40)
+#define DPI_DMA_IDS_GET_INST_STRM(x)		(((x) >> 40) & 0xff)
+
+#define DPI_DMA_IDS_DMA_STRM(x)			((uint64_t)((x) & 0xff) << 32)
+#define DPI_DMA_IDS_GET_DMA_STRM(x)		(((x) >> 32) & 0xff)
+
+#define DPI_DMA_IDS_DMA_NPA_PF_FUNC(x)		((uint64_t)((x) & 0xffff) << 16)
+#define DPI_DMA_IDS_GET_DMA_NPA_PF_FUNC(x)	(((x) >> 16) & 0xffff)
+
+#define DPI_DMA_IDS_DMA_SSO_PF_FUNC(x)		((uint64_t)((x) & 0xffff))
+#define DPI_DMA_IDS_GET_DMA_SSO_PF_FUNC(x)	((x) & 0xffff)
+
+#define DPI_DMA_IDS2_INST_AURA(x)		((uint64_t)((x) & 0xfffff))
+#define DPI_DMA_IDS2_GET_INST_AURA(x)		((x) & 0xfffff)
+
+#define DPI_ENG_BUF_BLKS(x)			((x) & 0x1fULL)
+#define DPI_ENG_BUF_GET_BLKS(x)			((x) & 0x1fULL)
+
+#define DPI_ENG_BUF_BASE(x)			(((x) & 0x3fULL) << 16)
+#define DPI_ENG_BUF_GET_BASE(x)			(((x) >> 16) & 0x3fULL)
+
+#define DPI_DMA_ENG_EN_QEN(x)			((x) & 0xffULL)
+#define DPI_DMA_ENG_EN_GET_QEN(x)		((x) & 0xffULL)
+
+#define DPI_DMA_ENG_EN_MOLR(x)			(((x) & 0x3ffULL) << 32)
+#define DPI_DMA_ENG_EN_GET_MOLR(x)		(((x) >> 32) & 0x3ffULL)
+
+#define DPI_DMA_CONTROL_DMA_ENB(x)		(((x) & 0x3fULL) << 48)
+#define DPI_DMA_CONTROL_GET_DMA_ENB(x)		(((x) >> 48) & 0x3fULL)
+
+#define DPI_DMA_CONTROL_O_ES(x)			(((x) & 0x3ULL) << 15)
+#define DPI_DMA_CONTROL_GET_O_ES(x)		(((x) >> 15) & 0x3ULL)
+
+#define DPI_DMA_CONTROL_O_MODE			(0x1ULL << 14)
+#define DPI_DMA_CONTROL_O_NS			(0x1ULL << 17)
+#define DPI_DMA_CONTROL_O_RO			(0x1ULL << 18)
+#define DPI_DMA_CONTROL_O_ADD1			(0x1ULL << 19)
+#define DPI_DMA_CONTROL_LDWB			(0x1ULL << 32)
+#define DPI_DMA_CONTROL_NCB_TAG_DIS		(0x1ULL << 34)
+#define DPI_DMA_CONTROL_ZBWCSEN			(0x1ULL << 39)
+#define DPI_DMA_CONTROL_WQECSDIS		(0x1ULL << 47)
+#define DPI_DMA_CONTROL_UIO_DIS			(0x1ULL << 55)
+#define DPI_DMA_CONTROL_PKT_EN			(0x1ULL << 56)
+#define DPI_DMA_CONTROL_FFP_DIS			(0x1ULL << 59)
+
+#define DPI_CTL_EN				(0x1ULL)
+
+/******************** macros for Interrupts ************************/
+#define DPI_DMA_CC_INT				(0x1ULL)
+
+#define DPI_REQQ_INT_INSTRFLT			(0x1ULL)
+#define DPI_REQQ_INT_RDFLT			(0x1ULL << 1)
+#define DPI_REQQ_INT_WRFLT			(0x1ULL << 2)
+#define DPI_REQQ_INT_CSFLT			(0x1ULL << 3)
+#define DPI_REQQ_INT_INST_DBO			(0x1ULL << 4)
+#define DPI_REQQ_INT_INST_ADDR_NULL		(0x1ULL << 5)
+#define DPI_REQQ_INT_INST_FILL_INVAL		(0x1ULL << 6)
+#define DPI_REQQ_INT_INSTR_PSN			(0x1ULL << 7)
+
+#define DPI_REQQ_INT \
+	(DPI_REQQ_INT_INSTRFLT		| \
+	DPI_REQQ_INT_RDFLT		| \
+	DPI_REQQ_INT_WRFLT		| \
+	DPI_REQQ_INT_CSFLT		| \
+	DPI_REQQ_INT_INST_DBO		| \
+	DPI_REQQ_INT_INST_ADDR_NULL	| \
+	DPI_REQQ_INT_INST_FILL_INVAL	| \
+	DPI_REQQ_INT_INSTR_PSN)
+
+#define DPI_PF_RAS_EBI_DAT_PSN		(0x1ULL)
+#define DPI_PF_RAS_NCB_DAT_PSN		(0x1ULL << 1)
+#define DPI_PF_RAS_NCB_CMD_PSN		(0x1ULL << 2)
+#define DPI_PF_RAS_INT \
+	(DPI_PF_RAS_EBI_DAT_PSN  | \
+	 DPI_PF_RAS_NCB_DAT_PSN  | \
+	 DPI_PF_RAS_NCB_CMD_PSN)
+
+
+/***************** Registers ******************/
+#define DPI_DMAX_IBUFF_CSIZE(x)			(0x0ULL | ((x) << 11))
+#define DPI_DMAX_REQBANK0(x)			(0x8ULL | ((x) << 11))
+#define DPI_DMAX_REQBANK1(x)			(0x10ULL | ((x) << 11))
+#define DPI_DMAX_IDS(x)				(0x18ULL | ((x) << 11))
+#define DPI_DMAX_IDS2(x)			(0x20ULL | ((x) << 11))
+#define DPI_DMAX_IFLIGHT(x)			(0x28ULL | ((x) << 11))
+#define DPI_DMAX_QRST(x)			(0x30ULL | ((x) << 11))
+#define DPI_DMAX_ERR_RSP_STATUS(x)		(0x38ULL | ((x) << 11))
+
+#define DPI_CSCLK_ACTIVE_PC ({				\
+	u64 offset;					\
+							\
+	offset = (0x4000ULL);				\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10000ULL);			\
+	offset; })					\
+
+#define DPI_CTL ({					\
+	u64 offset;					\
+							\
+	offset = (0x4010ULL);				\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10010ULL);			\
+	offset; })					\
+
+#define DPI_DMA_CONTROL ({				\
+	u64 offset;					\
+							\
+	offset = (0x4018ULL);				\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10018ULL);			\
+	offset; })					\
+
+#define DPI_DMA_ENGX_EN(x) ({				\
+	u64 offset;					\
+							\
+	offset = (0x4040ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10040ULL | ((x) << 3));	\
+	offset; })					\
+
+#define DPI_ENGX_BUF(x)	({				\
+	u64 offset;					\
+							\
+	offset = (0x40C0ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x100C0ULL | ((x) << 3));	\
+	offset; })					\
+
+#define DPI_EBUS_PORTX_CFG(x) ({			\
+	u64 offset;					\
+							\
+	offset = (0x4100ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10100ULL | ((x) << 3));	\
+	offset; })					\
+
+#define DPI_PF_RAS ({					\
+	u64 offset;					\
+							\
+	offset = (0x4308ULL);				\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10308ULL);			\
+	offset; })					\
+
+#define DPI_PF_RAS_ENA_W1C ({				\
+	u64 offset;					\
+							\
+	offset = (0x4318ULL);				\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10318ULL);			\
+	offset; })					\
+
+#define DPI_PF_RAS_ENA_W1S ({				\
+	u64 offset;					\
+							\
+	offset = (0x4320ULL);				\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x10320ULL);			\
+	offset; })					\
+
+#define DPI_DMA_CCX_INT(x) ({				\
+	u64 offset;					\
+							\
+	offset = (0x5000ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x11000ULL | ((x) << 3));	\
+	offset; })					\
+
+#define DPI_DMA_CCX_INT_ENA_W1C(x) ({			\
+	u64 offset;					\
+							\
+	offset = (0x5800ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x11800ULL | ((x) << 3));	\
+	offset; })					\
+
+#define DPI_REQQX_INT(x) ({				\
+	u64 offset;					\
+							\
+	offset = (0x6600ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x12C00ULL | ((x) << 5));	\
+	offset; })					\
+
+#define DPI_REQQX_INT_ENA_W1C(x) ({			\
+	u64 offset;					\
+							\
+	offset = (0x6680ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x13800ULL | ((x) << 5));	\
+	offset; })					\
+
+#define DPI_REQQX_INT_ENA_W1S(x) ({			\
+	u64 offset;					\
+							\
+	offset = (0x66C0ULL | (x) << 3);		\
+	if (is_otx3_dpi(dpi))				\
+		offset = (0x13C00ULL | ((x) << 5));	\
+	offset; })					\
+
+#define DPI_WCTL_FIF_THR			(0x17008ULL)
+
+#define DPI_EBUS_MRRS_MIN			128
+#define DPI_EBUS_MRRS_MAX			1024
+#define DPI_EBUS_MPS_MIN			128
+#define DPI_EBUS_MPS_MAX			1024
+#define DPI_EBUS_MAX_PORTS			2
+#define DPI_EBUS_PORTX_CFG_MRRS(x)		(((x) & 0x7) << 0)
+#define DPI_EBUS_PORTX_CFG_MPS(x)		(((x) & 0x7) << 4)
+
+/* VF Registers: */
+#define DPI_VDMA_EN		(0x0ULL)
+#define DPI_VDMA_REQQ_CTL	(0x8ULL)
+#define DPI_VDMA_DBELL		(0x10ULL)
+#define DPI_VDMA_SADDR		(0x18ULL)
+#define DPI_VDMA_COUNTS		(0x20ULL)
+#define DPI_VDMA_NADDR		(0x28ULL)
+#define DPI_VDMA_IWBUSY		(0x30ULL)
+#define DPI_VDMA_CNT		(0x38ULL)
+#define DPI_VF_INT		(0x100ULL)
+#define DPI_VF_INT_W1S		(0x108ULL)
+#define DPI_VF_INT_ENA_W1C	(0x110ULL)
+#define DPI_VF_INT_ENA_W1S	(0x118ULL)
+
+struct dpivf_config {
+	uint16_t csize;
+	uint32_t aura;
+	uint16_t sso_pf_func;
+	uint16_t npa_pf_func;
+};
+
+struct dpipf_vf {
+	uint8_t this_vfid;
+	bool setup_done;
+	struct dpivf_config vf_config;
+};
+
+struct dpipf {
+	void __iomem		*reg_base;
+	struct pci_dev		*pdev;
+	int			num_vec;
+	struct msix_entry	*msix_entries;
+	int total_vfs;
+	int vfs_in_use;
+	struct dpipf_vf vf[DPI_MAX_VFS];
+};
+
+#define DPI_QUEUE_OPEN  0x1
+#define DPI_QUEUE_CLOSE 0x2
+#define DPI_REG_DUMP    0x3
+#define DPI_GET_REG_CFG 0x4
+
+union dpi_mbox_message_t {
+	uint64_t u[2];
+	struct dpi_mbox_message_s {
+		/* VF ID to configure */
+		uint64_t vfid           :8;
+		/* Command code */
+		uint64_t cmd            :4;
+		/* Command buffer size in 8-byte words */
+		uint64_t csize          :14;
+		/* aura of the command buffer */
+		uint64_t aura           :20;
+		/* SSO PF function */
+		uint64_t sso_pf_func    :16;
+		/* NPA PF function */
+		uint64_t npa_pf_func    :16;
+	} s;
+};
+
+struct otx2_dpipf_com_s {
+	int (*queue_config)(struct pci_dev *pfdev,
+			    union dpi_mbox_message_t *req);
+};
+
+extern struct otx2_dpipf_com_s otx2_dpipf_com;
+
+#endif
-- 
2.24.1


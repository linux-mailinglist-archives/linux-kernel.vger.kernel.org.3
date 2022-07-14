Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6A574D32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiGNMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiGNMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:13:14 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388D1AD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:13:12 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3duVv018136;
        Thu, 14 Jul 2022 05:13:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=dvgyETGH1DyoHJV8r5a45XbHtXbI2E1QcdBmEDZY0TQ=;
 b=PyUg6TEve9J+1IsL+VZISBGyzJbJgIQF1iVPNgxQhxAW2QdgSInVJmvbPAFO+1k6NKeB
 RgebOo7tCMdgfnOoS5op+MRdWYZPEyD6XFa1ynX9X6/OLxqYV1434yIkApJR6ZjSeBHK
 i3s+/r6HX56OGUl4xPj/CD/49DerbS6KtDiwryz1RH46tK+sVtLqgRWdVIQ+B+UA7r2j
 QnxDJgFLF+f4x4mfuBkW42G38Q4SDhlQrvbX21D5z3/2RhcaWc7i2+qhRk1Rb+N/AzUD
 tWJu6a7jdN3U6Z8V/zTpTHuU8n54x8Ebe5yd8ENE3m4sYu6Ao9JtLJSeI7Qs+UnuoUu/ Pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3habegsk39-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:13:10 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 14 Jul
 2022 05:12:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 14 Jul 2022 05:12:26 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id E5BAE3F704D;
        Thu, 14 Jul 2022 05:12:25 -0700 (PDT)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <wbartczak@marvell.com>, <linux-kernel@vger.kernel.org>
CC:     <wbartczak@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        "Piyush Malgujar" <pmalgujar@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 2/2] mailbox: mvl_mhu: Add support for Marvell Message Handling Unit
Date:   Thu, 14 Jul 2022 05:12:13 -0700
Message-ID: <20220714121215.22931-3-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220714121215.22931-1-wbartczak@marvell.com>
References: <20220714121215.22931-1-wbartczak@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kgH4QhArz5IPZh58AW_5XNiplQFtl-NV
X-Proofpoint-ORIG-GUID: kgH4QhArz5IPZh58AW_5XNiplQFtl-NV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox driver implements a Message Handling Unit used to transfer
data between application processor and System Control Processor using
ARM SCMI protocol. Driver supports single channel for SCMI messaging.
It supports multiple platforms based on cn9x and cn10x SoC.
Due to numerous supported platforms, implementation uses two kinds of
subsystems, PCI driver for platforms where SCP uses LPI interrupts and
platform driver when SCP is configured with SPI interrupts (PCI
disabled). Only one configuration is valid, driver detects this in
run-time. Mailbox uses simple synchronous, doorbell communication.
Messages are exchanged using shared memory and interrupts.
AP writes SCMI message to memory then set interrupt on SCP side.
When answer is ready, SCP write shared memory region and rises
interrupt on AP side.
Mailbox has no other usage than SCMI communication. In case of
configurations running without SCMI support it should be disabled.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 MAINTAINERS               |   9 +
 drivers/mailbox/Kconfig   |  10 +
 drivers/mailbox/Makefile  |   2 +
 drivers/mailbox/mvl_mhu.c | 473 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 drivers/mailbox/mvl_mhu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbadf9a2ef67d6b3aad70509ab46f453..aee0ed917674818ab8afde3c873a30f159c9cf30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12015,6 +12015,15 @@ L:	linux-wireless@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/net/wireless/marvell/mwl8k.c
 
+MARVELL MHU MAILBOX
+M:	Piyush Malgujar <pmalgujar@marvell.com>
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Wojciech Bartczak <wbartczak@marvell.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
+F:	drivers/mailbox/mvl_mhu.c
+
 MARVELL NAND CONTROLLER DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e372e00f69ef77041d08c5123e5f5c..7ffe9fc31dae620c93ddd9b7188188195c3e52be 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -294,4 +294,14 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients.
 	  Say Y here if you want to build this driver.
 
+config MVL_MHU
+	tristate "Marvell MHU Mailbox" if ARM_SCMI_PROTOCOL
+	depends on OF && ARM64
+	help
+	  Say Y here if you want to build support for Marvell MHU controller.
+	  An implementation of mailbox is used by SCMI for OcteonTX2 platform.
+	  The controller supports single channel between SCP and AP.
+	  If SCMI is not enabled, driver has no function but adds to size of
+	  the kernel.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc93761171113ea94d079de1b4772722467247e7..7a461a0a930d0d3c6062884575668aa9d4af91ac 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -62,3 +62,5 @@ obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_APPLE_MAILBOX)	+= apple-mailbox.o
+
+obj-$(CONFIG_MVL_MHU)	+= mvl_mhu.o
diff --git a/drivers/mailbox/mvl_mhu.c b/drivers/mailbox/mvl_mhu.c
new file mode 100644
index 0000000000000000000000000000000000000000..6609dd271f3c66434b1251529b29987b4d924c8c
--- /dev/null
+++ b/drivers/mailbox/mvl_mhu.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell Message Handling Unit driver
+ *
+ * Copyright (C) 2019-2022 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#define pr_fmt(fmt)	"mvl-mhu: " fmt
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/acpi.h>
+#include <linux/mailbox_controller.h>
+#include <linux/spinlock.h>
+
+#define MHU_PCHANS_NUM	1
+#define BAR0		0
+#define SCP_INDEX	0x0
+#define DEV_AP0		0x2
+#define SCP_TO_AP_INTERRUPT	2
+
+#define XCPX_DEVY_XCP_MBOX_LINT_OFFSET	0x000E1C00
+#define XCP_TO_DEV_XCP_MBOX_LINT(xcp_core, device_id)  \
+	(XCPX_DEVY_XCP_MBOX_LINT_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+#define AP0_TO_SCP_MBOX_LINT    XCP_TO_DEV_XCP_MBOX_LINT(SCP_INDEX, DEV_AP0)
+
+/*
+ * Doorbell-Register: XCP(0..1)_DEV(0..7)_XCP_MBOX
+ * Communication data from devices to XCP. When written, sets
+ * XCP(0..1)_DEV(0..7)_XCP_MBOX.
+ * PS: it doesn't matter what is written into this register,
+ * Attempting to writing 'anything' would cause an interrupt
+ * to the target!
+ */
+
+#define DONT_CARE_DATA			0xFF
+#define XCPX_DEVY_XCP_MBOX_OFFSET	0x000E1000
+#define XCP_TO_DEV_XCP_MBOX(xcp_core, device_id) \
+	(XCPX_DEVY_XCP_MBOX_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+/* AP0-to-SCP doorbell */
+#define AP0_TO_SCP_MBOX         XCP_TO_DEV_XCP_MBOX(SCP_INDEX, DEV_AP0)
+
+/*  Register offset: Enable interrupt from SCP to AP */
+#define XCP0_XCP_DEV0_MBOX_RINT_ENA_W1S	0x000D1C40
+#define XCP0_XCP_DEV1_MBOX_RINT_ENA_W1S	0x000D1C50
+#define XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S	0x000D1C60
+#define XCP0_XCP_DEV3_MBOX_RINT_ENA_W1S	0x000D1C70
+
+/* Rx interrupt from SCP to Non-secure AP (linux kernel) */
+#define XCPX_XCP_DEVY_MBOX_RINT_OFFSET 0x000D1C00
+#define XCPX_XCP_DEVY_MBOX_RINT(xcp_core, device_id) \
+	(XCPX_XCP_DEVY_MBOX_RINT_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+/* The interrupt status register */
+#define SCP_TO_AP0_MBOX_RINT  XCPX_XCP_DEVY_MBOX_RINT(SCP_INDEX, DEV_AP0)
+
+#define XCPX_XCP_DEVY_MBOX_RINT_OFFSET	0x000D1C00
+#define XCPX_XCP_DEVY_MBOX_RINT(xcp_core, device_id) \
+	(XCPX_XCP_DEVY_MBOX_RINT_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+#define SCP_TO_AP0_MBOX_RINT  XCPX_XCP_DEVY_MBOX_RINT(SCP_INDEX, DEV_AP0)
+#define SCP_TO_DEV0 XCPX_XCP_DEVY_MBOX_RINT(0, 0)
+#define SCP_TO_DEV1 XCPX_XCP_DEVY_MBOX_RINT(0, 1)
+#define SCP_TO_DEV2 XCPX_XCP_DEVY_MBOX_RINT(0, 2)
+#define SCP_TO_DEV3 XCPX_XCP_DEVY_MBOX_RINT(0, 3)
+
+struct mhu {
+	struct device *dev;
+
+	/* SCP link information */
+	void __iomem *base; /* tx_reg, rx_reg */
+	void __iomem *payload; /* Shared mem */
+	struct mbox_chan *chan;
+};
+
+#define MHU_CHANNEL_INDEX(mhu, chan) (chan - &mhu->chan[0])
+
+/* Sources of interrupt */
+enum {
+	INDEX_INT_SRC_SCMI_TX,
+	INDEX_INT_SRC_AVS_STS,
+	INDEX_INT_SRC_NONE,
+};
+
+/* information of interrupts from SCP */
+struct int_src_data_s {
+	uint64_t int_src_cnt;
+	uint64_t int_src_data;
+};
+
+/* Secures static data processed in the irq handler */
+DEFINE_SPINLOCK(mhu_irq_spinlock);
+
+/* bottom half of rx interrupt */
+static irqreturn_t mhu_rx_interrupt_thread(int irq, void *p)
+{
+	struct mhu *mhu = (struct mhu *)p;
+	struct int_src_data_s *data = (struct int_src_data_s *)mhu->payload;
+	u64 val, scmi_tx_cnt;
+
+	/*
+	 * Local copy of event counters. A mismatch of received
+	 * count value and the local copy means additional events
+	 * are being flagged that needs to be attended by AP
+	 */
+	static u64 event_counter[INDEX_INT_SRC_NONE] = {0};
+
+	if (!mhu || !mhu->chan) {
+		/* Interrupt has been ACKED, but there's no client for data */
+		pr_debug("No handle to MHU or mailbox\n");
+		return IRQ_HANDLED;
+	}
+
+	spin_lock_irq(&mhu_irq_spinlock);
+	/* scmi interrupt */
+	scmi_tx_cnt = readq(&data[INDEX_INT_SRC_SCMI_TX].int_src_cnt);
+	if (event_counter[INDEX_INT_SRC_SCMI_TX] != scmi_tx_cnt) {
+		mbox_chan_received_data(mhu->chan, (void *)&val);
+		/* Update the memory to prepare for next */
+		event_counter[INDEX_INT_SRC_SCMI_TX] = scmi_tx_cnt;
+	}
+	spin_unlock_irq(&mhu_irq_spinlock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mhu_rx_interrupt(int irq, void *p)
+{
+	struct mhu *mhu = (struct mhu *)p;
+	u64 val;
+
+	/* Read interrupt status register */
+	val = readq_relaxed(mhu->base + SCP_TO_AP0_MBOX_RINT);
+	if (val) {
+		/* Clear the interrupt : Write on clear */
+		writeq_relaxed(1ul, mhu->base + SCP_TO_AP0_MBOX_RINT);
+	} else {
+		return IRQ_NONE;
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int mhu_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhu *mhu = chan->con_priv;
+
+	iowrite64(DONT_CARE_DATA, mhu->base + AP0_TO_SCP_MBOX);
+
+	return 0;
+}
+
+static bool mhu_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu *mhu = chan->con_priv;
+	u64 status;
+
+	status = ioread64(mhu->base + XCPX_XCP_DEVY_MBOX_RINT(0, 2));
+	pr_debug("last_tx_done status: %#llx\n", status);
+
+	return status != 0;
+}
+
+static int mhu_startup(struct mbox_chan *chan)
+{
+	struct mhu *mhu = chan->con_priv;
+
+	/* Enable interrupts only if there is client for data */
+	writeq_relaxed(1ul, mhu->base + XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S);
+
+	return 0;
+}
+
+
+static const struct mbox_chan_ops mhu_chan_ops = {
+	.startup = mhu_startup,
+	.send_data = mhu_send_data,
+	.last_tx_done = mhu_last_tx_done,
+};
+
+static struct mbox_chan mhu_chan = {};
+
+static struct mbox_controller mhu_mbox_ctrl = {
+	.chans = &mhu_chan,
+	.num_chans = MHU_PCHANS_NUM,
+	.txdone_irq = false,
+	.txdone_poll = true,
+	.txpoll_period = 100,
+	.ops = &mhu_chan_ops,
+};
+
+static int mhu_plat_setup_mbox(struct device *dev)
+{
+	struct mhu *mhu;
+	struct device_node *shmem, *np;
+	struct resource res;
+	struct mbox_chan *chan;
+	int ret;
+
+	mhu = dev_get_drvdata(dev);
+	np = dev->of_node;
+
+	shmem = of_parse_phandle(np, "shmem", 0);
+	if (!shmem)
+		return -EINVAL;
+
+	ret = of_address_to_resource(shmem, 0, &res);
+	of_node_put(shmem);
+	if (ret)
+		return ret;
+
+	mhu->payload = devm_ioremap_resource(dev, &res);
+	if (!mhu->payload)
+		return -ENOMEM;
+
+	chan = &mhu_mbox_ctrl.chans[0];
+	chan->con_priv = mhu;
+	mhu->chan = chan;
+	mhu_mbox_ctrl.dev = dev;
+
+	return mbox_controller_register(&mhu_mbox_ctrl);
+}
+
+/* Platform device interface for SPI based configurations */
+static int mhu_plat_setup_irq(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct mhu *mhu;
+	struct device_node *np;
+	int irq, ret;
+
+	mhu = platform_get_drvdata(pdev);
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	irq = of_irq_get(np, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, mhu_rx_interrupt,
+					mhu_rx_interrupt_thread, 0,
+					"mvl-mhu", mhu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mhu_plat_probe(struct platform_device *pdev)
+{
+	struct mhu *mhu;
+	struct resource *res;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, mhu);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pr_debug("base: %llx, len: %llx\n", res->start, resource_size(res));
+
+	mhu->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mhu->base))
+		return PTR_ERR(mhu->base);
+
+	ret = mhu_plat_setup_irq(pdev);
+	if (ret)
+		return ret;
+
+	return mhu_plat_setup_mbox(dev);
+}
+
+static int mhu_plat_remove(struct platform_device *pdev)
+{
+	mbox_controller_unregister(&mhu_mbox_ctrl);
+
+	return 0;
+}
+
+static const struct of_device_id mhu_of_match[] = {
+	{
+		.compatible = "marvell,mbox",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mhu_of_match);
+
+static struct platform_driver mhu_plat_driver = {
+	.driver = {
+		.name = "mvl-mhu",
+		.of_match_table = mhu_of_match,
+	},
+	.probe = mhu_plat_probe,
+	.remove = mhu_plat_remove,
+
+};
+
+/* PCI interface in case of LPI based configuration */
+static int mhu_pci_setup_irq(struct pci_dev *pdev)
+{
+	struct device *dev;
+	struct mhu *mhu;
+	struct device_node *np;
+	int irq, ret, nvec;
+
+	mhu = pci_get_drvdata(pdev);
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	nvec = pci_alloc_irq_vectors(pdev, 0, 3, PCI_IRQ_MSIX);
+	if (nvec < 0)
+		return nvec;
+
+	irq = pci_irq_vector(pdev, SCP_TO_AP_INTERRUPT);
+	if (irq < 0) {
+		ret = irq;
+		goto irq_err;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq, mhu_rx_interrupt,
+					mhu_rx_interrupt_thread, 0,
+					"mvl-mhu", mhu);
+	if (ret)
+		goto irq_err;
+
+	return 0;
+
+irq_err:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static int mhu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct mhu *mhu;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+	if (!dev->of_node) /* This case rejects not configured CPC instances */
+		return -ENODEV;
+
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+	pci_set_drvdata(pdev, mhu);
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_request_region(pdev, BAR0, "mvl-mhu");
+	if (ret)
+		return ret;
+
+	mhu->base = pcim_iomap(pdev, BAR0, pci_resource_len(pdev, BAR0));
+	if (!mhu->base)
+		return -EINVAL;
+
+	pr_debug("base: %llx, len: %llx\n", pci_resource_start(pdev, BAR0),
+		 pci_resource_len(pdev, BAR0));
+
+	ret = mhu_pci_setup_irq(pdev);
+	if (ret)
+		goto irq_err;
+
+	ret = mhu_plat_setup_mbox(dev);
+	if (!ret) /* Success */
+		return 0;
+
+	/* In case of error, release the resources */
+	pci_free_irq_vectors(pdev);
+irq_err:
+	pci_release_region(pdev, BAR0);
+
+	return ret;
+}
+
+static void mhu_pci_remove(struct pci_dev *pdev)
+{
+	struct mhu *mhu;
+
+	mhu = pci_get_drvdata(pdev);
+	mbox_controller_unregister(&mhu_mbox_ctrl);
+
+	pci_free_irq_vectors(pdev);
+	pcim_iounmap(pdev, mhu->base);
+	pci_release_region(pdev, BAR0);
+}
+
+static const struct pci_device_id mhu_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA067) },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, mhu_pci_ids);
+
+static struct pci_driver mhu_pci_driver = {
+	.name = "mvl-mhu",
+	.id_table = mhu_pci_ids,
+	.probe = mhu_pci_probe,
+	.remove = mhu_pci_remove,
+};
+
+static int __init mvl_mhu_init(void)
+{
+	/* The driver has two ways it can interface the hardware.
+	 * In case of SPI interrupts, the driver uses platform driver model.
+	 * For LPI interrupts the driver uses basic PCI driver model.
+	 */
+	int ret;
+
+	/* This driver should not be used for ACPI based platforms */
+	if (!acpi_disabled)
+		return -ENODEV;
+
+	ret = platform_driver_register(&mhu_plat_driver);
+	if (ret) {
+		pr_err("Platform driver can't be registered. (%d)\n", ret);
+		return ret;
+	}
+
+	ret = pci_register_driver(&mhu_pci_driver);
+	if (!ret) /* Success */
+		return 0;
+
+	/* Handle errors */
+	pr_err("PCI driver can't be registered. (%d)\n", ret);
+	platform_driver_unregister(&mhu_plat_driver);
+
+	return ret;
+}
+module_init(mvl_mhu_init);
+
+static void __exit mvl_mhu_exit(void)
+{
+	pci_unregister_driver(&mhu_pci_driver);
+	platform_driver_unregister(&mhu_plat_driver);
+}
+module_exit(mvl_mhu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell MHU Driver");
+MODULE_AUTHOR("Sujeet Baranwal <sbaranwal@marvell.com>");
+MODULE_AUTHOR("Wojciech Bartczak <wbartczak@marvell.com>");
-- 
2.17.1


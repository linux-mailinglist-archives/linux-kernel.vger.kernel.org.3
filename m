Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C14B0082
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiBIWmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:42:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiBIWmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:42:31 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B1C0302E5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:42:31 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219IO5Ei014382;
        Wed, 9 Feb 2022 14:42:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=+IeGoPa54Olck2SHTVItqzt1UTNReHPKUw2QQ7FDvSQ=;
 b=UgFUboO12HbiZ30Ce+GxhofvKG01v79cJib5LEq/q8PYAEY3TrPAj9p06JEoXNErindY
 b800C1xSuTySP0dRz/wvx1DSW2DF3bgAxH5kL1H6euzvX7e1PonjUHxmwgb/j2KvSCV4
 CBKNWplVvLqVEaRjMwuL3mGp6Z7cT6/KD1WKeKAWVmovuQZHyPNU7wf86OT8JrJQf8N0
 4K/uAxGm9+I/GKL/8cwbkoBmVvvjzIk6b31buo0+yEvkMFIXNj0Df8wn+FE6iBKWzXei
 PpSrePc4SP2I+PnnbciOrkjG3np/t86F/a0zd6IP/qrGt8OML6r+i549Tob+asuOBs5B 7A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e4am93bx1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:42:22 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 14:42:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 14:42:18 -0800
Received: from rchin-dellt430.marvell.com (rchin-dellt430.marvell.com [10.85.176.141])
        by maili.marvell.com (Postfix) with ESMTP id 8BE0E3F7094;
        Wed,  9 Feb 2022 14:42:18 -0800 (PST)
From:   Radha Mohan Chintakuntla <radhac@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        "Radha Mohan Chintakuntla" <radhac@marvell.com>
Subject: [PATCH 1/4] soc: octeontx2-sdp: Add SDP PF driver support
Date:   Wed, 9 Feb 2022 14:42:07 -0800
Message-ID: <20220209224210.153907-2-radhac@marvell.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20220209224210.153907-1-radhac@marvell.com>
References: <20220209224210.153907-1-radhac@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4c8fRZPMrLGFbJnKTjzXLGuM0dFUQOw5
X-Proofpoint-ORIG-GUID: 4c8fRZPMrLGFbJnKTjzXLGuM0dFUQOw5
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

This patch adds base support to the SDP PF driver under the RVU PFs
found in Marvell OcteonTx2 SoCs. The driver configures the SRIOV and
allocates interrupts.

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
 MAINTAINERS                                |   7 +
 drivers/soc/Kconfig                        |   1 +
 drivers/soc/Makefile                       |   1 +
 drivers/soc/marvell/Kconfig                |  18 +
 drivers/soc/marvell/Makefile               |   2 +
 drivers/soc/marvell/octeontx2-sdp/Makefile |   9 +
 drivers/soc/marvell/octeontx2-sdp/sdp.c    | 363 +++++++++++++++++++++
 drivers/soc/marvell/octeontx2-sdp/sdp.h    |  61 ++++
 8 files changed, 462 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2-sdp/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2-sdp/sdp.c
 create mode 100644 drivers/soc/marvell/octeontx2-sdp/sdp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e461db9cd91..fb48e0317d34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11558,6 +11558,13 @@ S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 
+MARVELL OCTEONTX2 SDP PHYISCAL FUNCTION DRIVER
+M:	Radha Mohan Chintakuntla <radhac@marvell.com>
+M:	Veerasenareddy Burry <vburru@marvell.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/soc/marvell/octeontx2-sdp
+
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
 M:	Taras Chornyi <tchornyi@marvell.com>
 S:	Supported
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index a8562678c437..bfb1d993d257 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -12,6 +12,7 @@ source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
+source "drivers/soc/marvell/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index adb30c2d4fea..1b6f1574b759 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -17,6 +17,7 @@ obj-y				+= imx/
 obj-y				+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
+obj-y				+= marvell/
 obj-y				+= mediatek/
 obj-y				+= amlogic/
 obj-y				+= qcom/
diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
new file mode 100644
index 000000000000..4e8f8a60b3df
--- /dev/null
+++ b/drivers/soc/marvell/Kconfig
@@ -0,0 +1,18 @@
+#
+# MARVELL SoC drivers
+#
+
+menu "Marvell SoC drivers"
+
+config OCTEONTX2_SDP_PF
+	tristate "OcteonTX2 SDP PF driver"
+	depends on ARM64 && PCI && OCTEONTX2_AF && OCTEONTX2_MBOX
+	default y
+	help
+	  This driver configures the SDP RVU PF when OcteonTx is in PCIe EndPoint
+	  mode. It sets up the SDP rings  and the VFs to be used in packet transfer
+	  using the NIX block.
+
+	  To compile this as a module choose M here.
+
+endmenu
diff --git a/drivers/soc/marvell/Makefile b/drivers/soc/marvell/Makefile
new file mode 100644
index 000000000000..9a9a4435d64d
--- /dev/null
+++ b/drivers/soc/marvell/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		+= octeontx2-sdp/
diff --git a/drivers/soc/marvell/octeontx2-sdp/Makefile b/drivers/soc/marvell/octeontx2-sdp/Makefile
new file mode 100644
index 000000000000..16a5d353ea44
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2-sdp/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Marvell's OcteonTX2 SDP PF driver
+#
+
+obj-$(CONFIG_OCTEONTX2_SDP_PF) += octeontx2_sdp.o
+
+octeontx2_sdp-y := sdp.o
+ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/soc/marvell/octeontx2-sdp/sdp.c b/drivers/soc/marvell/octeontx2-sdp/sdp.c
new file mode 100644
index 000000000000..dda85b5c0264
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2-sdp/sdp.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/* OcteonTX2 SDP driver
+ *
+ * Copyright (C) 2020 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "rvu.h"
+#include "rvu_reg.h"
+#include "rvu_struct.h"
+#include "sdp.h"
+
+#define DRV_NAME	"octeontx2-sdp"
+#define DRV_VERSION	"1.1"
+
+#define PCI_DEVID_OCTEONTX2_SDP_PF	0xA0F6
+/* PCI BARs */
+#define PCI_AF_REG_BAR_NUM	0
+#define PCI_CFG_REG_BAR_NUM	2
+#define MBOX_BAR_NUM		4
+
+#define SDP_PPAIR_THOLD 0x400
+
+static void
+sdp_write64(struct sdp_dev *rvu, u64 b, u64 s, u64 o, u64 v)
+{
+	writeq(v, rvu->bar2 + ((b << 20) | (s << 12) | o));
+}
+
+static u64 sdp_read64(struct sdp_dev *rvu, u64 b, u64 s, u64 o)
+{
+	return readq(rvu->bar2 + ((b << 20) | (s << 12) | o));
+}
+
+static int sdp_check_pf_usable(struct sdp_dev *sdp)
+{
+	u64 rev;
+
+	rev = sdp_read64(sdp, BLKADDR_RVUM, 0,
+			RVU_PF_BLOCK_ADDRX_DISC(BLKADDR_RVUM));
+	rev = (rev >> 12) & 0xFF;
+	/* Check if AF has setup revision for RVUM block,
+	 * otherwise this driver probe should be deferred
+	 * until AF driver comes up.
+	 */
+	if (!rev) {
+		dev_warn(&sdp->pdev->dev,
+			 "AF is not initialized, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+	return 0;
+}
+
+static int sdp_alloc_irqs(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int err;
+
+	sdp = pci_get_drvdata(pdev);
+
+	/* Get number of MSIX vector count and allocate vectors first */
+	sdp->msix_count = pci_msix_vec_count(pdev);
+
+	err = pci_alloc_irq_vectors(pdev, sdp->msix_count, sdp->msix_count,
+				    PCI_IRQ_MSIX);
+
+	if (err < 0) {
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed %d\n", err);
+		return err;
+	}
+
+	sdp->irq_names = kmalloc_array(sdp->msix_count, NAME_SIZE, GFP_KERNEL);
+	if (!sdp->irq_names) {
+		err = -ENOMEM;
+		goto err_irq_names;
+	}
+
+	sdp->irq_allocated = kcalloc(sdp->msix_count, sizeof(bool), GFP_KERNEL);
+	if (!sdp->irq_allocated) {
+		err = -ENOMEM;
+		goto err_irq_allocated;
+	}
+
+	return 0;
+
+err_irq_allocated:
+	kfree(sdp->irq_names);
+	sdp->irq_names = NULL;
+err_irq_names:
+	pci_free_irq_vectors(pdev);
+	sdp->msix_count = 0;
+
+	return err;
+}
+
+static void sdp_free_irqs(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+	int irq;
+
+	sdp = pci_get_drvdata(pdev);
+	for (irq = 0; irq < sdp->msix_count; irq++) {
+		if (sdp->irq_allocated[irq])
+			free_irq(pci_irq_vector(sdp->pdev, irq), sdp);
+	}
+
+	pci_free_irq_vectors(pdev);
+
+	kfree(sdp->irq_names);
+	kfree(sdp->irq_allocated);
+}
+
+static int __sriov_disable(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp;
+
+	sdp = pci_get_drvdata(pdev);
+	if (pci_vfs_assigned(pdev)) {
+		dev_err(&pdev->dev, "Disabing VFs while VFs are assigned\n");
+		dev_err(&pdev->dev, "VFs will not be freed\n");
+		return -EPERM;
+	}
+
+	pci_disable_sriov(pdev);
+
+	kfree(sdp->vf_info);
+	sdp->vf_info = NULL;
+
+	return 0;
+}
+
+static int __sriov_enable(struct pci_dev *pdev, int num_vfs)
+{
+	struct rvu_vf *vf_ptr;
+	int curr_vfs, vf = 0;
+	struct sdp_dev *sdp;
+	int err;
+
+	curr_vfs = pci_num_vf(pdev);
+	if (!curr_vfs && !num_vfs)
+		return -EINVAL;
+
+	if (curr_vfs) {
+		dev_err(
+		    &pdev->dev,
+		    "Virtual Functions are already enabled on this device\n");
+		return -EINVAL;
+	}
+	if (num_vfs > SDP_MAX_VFS)
+		num_vfs = SDP_MAX_VFS;
+
+	sdp = pci_get_drvdata(pdev);
+
+	if (sdp_get_available_rsrcs(sdp)) {
+		dev_err(&pdev->dev, "Failed to get resource limits.\n");
+		return -EFAULT;
+	}
+
+	sdp->vf_info = kcalloc(num_vfs, sizeof(struct rvu_vf), GFP_KERNEL);
+	if (sdp->vf_info == NULL)
+		return -ENOMEM;
+
+	sdp->num_vfs = num_vfs;
+
+	err = pci_enable_sriov(pdev, num_vfs);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable to SRIOV VFs: %d\n", err);
+		goto err_enable_sriov;
+	}
+
+	return num_vfs;
+}
+
+static int sdp_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (num_vfs == 0)
+		return __sriov_disable(pdev);
+	else
+		return __sriov_enable(pdev, num_vfs);
+}
+
+
+static int sdp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	uint64_t inst, regval;
+	struct sdp_dev *sdp;
+	struct device *dev;
+	int err;
+
+	dev = &pdev->dev;
+	sdp = devm_kzalloc(dev, sizeof(struct sdp_dev), GFP_KERNEL);
+	if (sdp == NULL)
+		return -ENOMEM;
+
+	sdp->pdev = pdev;
+	pci_set_drvdata(pdev, sdp);
+
+	mutex_init(&sdp->lock);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto enable_failed;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto map_failed;
+	}
+
+	if (pci_sriov_get_totalvfs(pdev) <= 0) {
+		err = -ENODEV;
+		goto set_mask_failed;
+	}
+
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to set DMA mask\n");
+		goto set_mask_failed;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to set DMA mask\n");
+		goto set_mask_failed;
+	}
+
+	pci_set_master(pdev);
+
+	/* CSR Space mapping */
+	sdp->bar2 = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM,
+			       pci_resource_len(pdev, PCI_CFG_REG_BAR_NUM));
+	if (!sdp->bar2) {
+		dev_err(&pdev->dev, "Unable to map BAR2\n");
+		err = -ENODEV;
+		goto set_mask_failed;
+	}
+
+	err = sdp_check_pf_usable(sdp);
+	if (err)
+		goto pf_unusable;
+
+	/* Map SDP register area */
+	/* right now only 2 SDP blocks are supported */
+	inst = list_empty(&sdp_dev_lst_head) ? 0 : 1;
+	sdp->sdp_base = ioremap(SDP_BASE(inst), SDP_REG_SIZE);
+	if (!sdp->sdp_base) {
+		dev_err(&pdev->dev, "Unable to map SDP CSR space\n");
+		err = -ENODEV;
+		goto pf_unusable;
+	}
+	/* Map PF-AF mailbox memory */
+	sdp->af_mbx_base = ioremap_wc(pci_resource_start(pdev, MBOX_BAR_NUM),
+				     pci_resource_len(pdev, MBOX_BAR_NUM));
+	if (!sdp->af_mbx_base) {
+		dev_err(&pdev->dev, "Unable to map BAR4\n");
+		err = -ENODEV;
+		goto pf_unusable;
+	}
+
+	if (sdp_alloc_irqs(pdev)) {
+		dev_err(&pdev->dev,
+			"Unable to allocate MSIX Interrupt vectors\n");
+		err = -ENODEV;
+		goto alloc_irqs_failed;
+	}
+
+	regval = readq(sdp->sdp_base + SDPX_GBL_CONTROL);
+	regval |= (1 << 2); /* BPFLR_D disable clearing BP in FLR */
+	writeq(regval, sdp->sdp_base + SDPX_GBL_CONTROL);
+
+	sdp_sriov_configure(sdp->pdev, sdp->info.max_vfs);
+
+	spin_lock(&sdp_lst_lock);
+	list_add(&sdp->list, &sdp_dev_lst_head);
+	spin_unlock(&sdp_lst_lock);
+
+	return 0;
+
+alloc_irqs_failed:
+	iounmap(sdp->af_mbx_base);
+pf_unusable:
+	pcim_iounmap(pdev, sdp->bar2);
+set_mask_failed:
+	pci_release_regions(pdev);
+map_failed:
+	pci_disable_device(pdev);
+enable_failed:
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, sdp);
+	return err;
+}
+
+static void sdp_remove(struct pci_dev *pdev)
+{
+	struct sdp_dev *sdp = pci_get_drvdata(pdev);
+
+
+	spin_lock(&sdp_lst_lock);
+	list_del(&sdp->list);
+	spin_unlock(&sdp_lst_lock);
+
+	if (sdp->num_vfs)
+		__sriov_disable(pdev);
+
+	sdp_free_irqs(pdev);
+
+	if (sdp->af_mbx_base)
+		iounmap(sdp->af_mbx_base);
+	if (sdp->bar2)
+		pcim_iounmap(pdev, sdp->bar2);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	devm_kfree(&pdev->dev, sdp);
+}
+
+static const struct pci_device_id rvu_sdp_id_table[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_SDP_PF)},
+	{0} /* end of table */
+};
+
+static struct pci_driver sdp_driver = {
+	.name = DRV_NAME,
+	.id_table = rvu_sdp_id_table,
+	.probe = sdp_probe,
+	.remove = sdp_remove,
+	.sriov_configure = sdp_sriov_configure,
+};
+
+static int __init otx2_sdp_init_module(void)
+{
+	pr_info("%s\n", DRV_NAME);
+
+	spin_lock_init(&sdp_lst_lock);
+	return pci_register_driver(&sdp_driver);
+}
+
+static void __exit otx2_sdp_exit_module(void)
+{
+	pci_unregister_driver(&sdp_driver);
+}
+
+module_init(otx2_sdp_init_module);
+module_exit(otx2_sdp_exit_module);
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("Marvell OcteonTX2 SDP PF Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, rvu_sdp_id_table);
diff --git a/drivers/soc/marvell/octeontx2-sdp/sdp.h b/drivers/soc/marvell/octeontx2-sdp/sdp.h
new file mode 100644
index 000000000000..c8ef7a2ade45
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2-sdp/sdp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * OcteonTX2 SDP driver
+ *
+ * Copyright (C) 2022 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef SDP_H_
+#define SDP_H_
+
+#include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/pci.h>
+#include "mbox.h"
+
+#define SDP_BASE(a)		(0x86E080000000ull | a << 36)
+#define SDP_REG_SIZE		0x42000000
+
+#define SDPX_GBL_CONTROL	(0x40080200ull)
+
+struct sdp_dev {
+	struct list_head	list;
+	struct mutex		lock;
+	struct pci_dev		*pdev;
+	void __iomem		*sdp_base;
+	void __iomem		*bar2;
+	void __iomem		*af_mbx_base;
+#define SDP_VF_ENABLED 0x1
+	u32			flags;
+	u32			num_vfs;
+	u16			chan_base;
+	u16			num_chan;
+	bool			*irq_allocated;
+	char			*irq_names;
+	int			msix_count;
+	int			pf;
+	u8			valid_ep_pem_mask;
+	u8			mac_mask;
+
+	struct sdp_node_info info;
+	struct rvu_vf		*vf_info;
+	struct free_rsrcs_rsp	limits; /* Maximum limits for all VFs */
+};
+
+struct rvu_vf {
+	struct work_struct	pfvf_flr_work;
+	struct device_attribute in_use_attr;
+	struct pci_dev		*pdev;
+	struct kobject		*limits_kobj;
+	/* pointer to PF struct this PF belongs to */
+	struct sdp_dev		*sdp;
+	int			vf_id;
+	int			intr_idx; /* vf_id%64 actually */
+	bool			in_use;
+	bool			got_flr;
+};
+
+
+#endif
-- 
2.24.1


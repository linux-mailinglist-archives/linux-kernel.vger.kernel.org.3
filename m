Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F459F6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiHXJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiHXJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:27 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A63F1DA;
        Wed, 24 Aug 2022 02:50:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN7.oFT_1661334622;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN7.oFT_1661334622)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:22 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex) accelerator driver
Date:   Wed, 24 Aug 2022 17:50:13 +0800
Message-Id: <1661334621-44413-2-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

YCC (Yitian Cryptography Complex) is designed to accelerate the process
of encryption and decryption. Yitian is the name of Alibaba SoCs
which is based on ARMv9 architecture.

This patch aims to add driver with basic pci settings and irq requests.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
Co-developed-by: Jiankang Chen <jkchen@linux.alibaba.com>
Signed-off-by: Jiankang Chen <jkchen@linux.alibaba.com>
---
 drivers/crypto/Kconfig        |   2 +
 drivers/crypto/Makefile       |   1 +
 drivers/crypto/ycc/Kconfig    |   8 +
 drivers/crypto/ycc/Makefile   |   3 +
 drivers/crypto/ycc/ycc_cdev.c |  86 ++++++++
 drivers/crypto/ycc/ycc_cdev.h |  18 ++
 drivers/crypto/ycc/ycc_dev.h  | 148 ++++++++++++++
 drivers/crypto/ycc/ycc_drv.c  | 451 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_isr.c  | 117 +++++++++++
 drivers/crypto/ycc/ycc_isr.h  |  12 ++
 10 files changed, 846 insertions(+)
 create mode 100644 drivers/crypto/ycc/Kconfig
 create mode 100644 drivers/crypto/ycc/Makefile
 create mode 100644 drivers/crypto/ycc/ycc_cdev.c
 create mode 100644 drivers/crypto/ycc/ycc_cdev.h
 create mode 100644 drivers/crypto/ycc/ycc_dev.h
 create mode 100644 drivers/crypto/ycc/ycc_drv.c
 create mode 100644 drivers/crypto/ycc/ycc_isr.c
 create mode 100644 drivers/crypto/ycc/ycc_isr.h

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3e6aa31..d739354 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -799,6 +799,8 @@ source "drivers/crypto/hisilicon/Kconfig"
 
 source "drivers/crypto/amlogic/Kconfig"
 
+source "drivers/crypto/ycc/Kconfig"
+
 config CRYPTO_DEV_SA2UL
 	tristate "Support for TI security accelerator"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index f81703a8..0ba29dd 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -51,4 +51,5 @@ obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
+obj-$(CONFIG_CRYPTO_DEV_YCC) += ycc/
 obj-y += keembay/
diff --git a/drivers/crypto/ycc/Kconfig b/drivers/crypto/ycc/Kconfig
new file mode 100644
index 00000000..6e88ecb
--- /dev/null
+++ b/drivers/crypto/ycc/Kconfig
@@ -0,0 +1,8 @@
+config CRYPTO_DEV_YCC
+	tristate "Support for Alibaba YCC cryptographic accelerator"
+	depends on CRYPTO && CRYPTO_HW && PCI
+	default n
+	help
+	  Enables the driver for the on-chip cryptographic accelerator of
+	  Alibaba Yitian SoCs which is based on ARMv9 architecture.
+	  If unsure say N.
diff --git a/drivers/crypto/ycc/Makefile b/drivers/crypto/ycc/Makefile
new file mode 100644
index 00000000..bde56c8
--- /dev/null
+++ b/drivers/crypto/ycc/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-(CONFIG_CRYPTO_DEV_YCC) += ycc.o
+ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o
diff --git a/drivers/crypto/ycc/ycc_cdev.c b/drivers/crypto/ycc/ycc_cdev.c
new file mode 100644
index 00000000..fa08e6e
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_cdev.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "YCC: " fmt
+
+#include <linux/cdev.h>
+#include <linux/sched.h>
+#include <linux/kobject.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include "ycc_cdev.h"
+
+static struct ycc_cdev ycdev;
+
+static int ycc_cdev_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int ycc_cdev_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static long ycc_cdev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long arg)
+{
+	return 0;
+}
+
+static const struct file_operations ycc_fops = {
+	.open = ycc_cdev_open,
+	.release = ycc_cdev_release,
+	.unlocked_ioctl = ycc_cdev_ioctl,
+};
+
+int ycc_cdev_register(void)
+{
+	struct device *device;
+	int ret;
+
+	ret = alloc_chrdev_region(&ycdev.devno, 0, 1, YCC_CDEV_NAME);
+	if (ret) {
+		pr_err("Failed to alloc cdev region\n");
+		return ret;
+	}
+
+	ycdev.class = class_create(THIS_MODULE, YCC_CDEV_NAME);
+	if (IS_ERR(ycdev.class)) {
+		pr_err("Failed to create cdev class\n");
+		ret = PTR_ERR(ycdev.class);
+		goto unregister_region;
+	}
+
+	cdev_init(&ycdev.cdev, &ycc_fops);
+	ret = cdev_add(&ycdev.cdev, ycdev.devno, 1);
+	if (ret) {
+		pr_err("Failed to add cdev\n");
+		goto destroy_class;
+	}
+
+	device = device_create(ycdev.class, NULL, ycdev.devno,
+			       NULL, YCC_CDEV_NAME);
+	if (IS_ERR(device)) {
+		pr_err("Failed to create cdev device\n");
+		ret = PTR_ERR(device);
+		goto del_cdev;
+	}
+
+	return 0;
+del_cdev:
+	cdev_del(&ycdev.cdev);
+destroy_class:
+	class_destroy(ycdev.class);
+unregister_region:
+	unregister_chrdev_region(ycdev.devno, 1);
+	return ret;
+}
+
+void ycc_cdev_unregister(void)
+{
+	device_destroy(ycdev.class, ycdev.devno);
+	cdev_del(&ycdev.cdev);
+	class_destroy(ycdev.class);
+	unregister_chrdev_region(ycdev.devno, 1);
+}
diff --git a/drivers/crypto/ycc/ycc_cdev.h b/drivers/crypto/ycc/ycc_cdev.h
new file mode 100644
index 00000000..6f6ca48
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_cdev.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __YCC_CDEV_H
+#define __YCC_CDEV_H
+
+#include <linux/cdev.h>
+#include "ycc_dev.h"
+
+#define YCC_CDEV_NAME		"ycc_dev_ctrl"
+
+struct ycc_cdev {
+	dev_t devno;
+	struct class *class;
+	struct cdev cdev;
+};
+
+int ycc_cdev_register(void);
+void ycc_cdev_unregister(void);
+#endif
diff --git a/drivers/crypto/ycc/ycc_dev.h b/drivers/crypto/ycc/ycc_dev.h
new file mode 100644
index 00000000..e5f76af
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_dev.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __YCC_DEV_H
+#define __YCC_DEV_H
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+
+#define YCC_MAX_DEBUGFS_NAME		20
+
+#define PCI_VENDOR_ID_YCC		0x1DED
+#define PCI_DEVICE_ID_RCEC		0x8003
+#define PCI_DEVICE_ID_RCIEP		0x8001
+
+#define YCC_RINGPAIR_NUM		48
+#define YCC_IRQS			(YCC_RINGPAIR_NUM + 1)
+
+#define RING_STOP_BIT			BIT(15)
+#define RING_CFG_RING_SZ		GENMASK(2, 0)
+#define RING_CFG_INT_TH			GENMASK(15, 8)
+#define RING_ERR_AXI			BIT(0)
+#define RING_PENDING_CNT		GENMASK(9, 0)
+
+#define YCC_SEC_CFG_BAR			0
+#define YCC_NSEC_CFG_BAR		1
+#define YCC_SEC_Q_BAR			2
+#define YCC_NSEC_Q_BAR			3
+
+/* YCC secure configuration register offset */
+#define REG_YCC_CTL			0x18
+#define REG_YCC_GO			0x50
+#define REG_YCC_HCLK_INT_STATUS		0x54
+#define REG_YCC_XCLK_INT_STATUS		0x58
+#define REG_YCC_XCLK_MEM_ECC_EN_0	0x5c
+#define REG_YCC_XCLK_MEM_ECC_EN_1	0x60
+#define REG_YCC_XCLK_MEM_ECC_COR_0	0x74
+#define REG_YCC_XCLK_MEM_ECC_COR_1	0x78
+#define REG_YCC_XCLK_MEM_ECC_UNCOR_0	0x80
+#define REG_YCC_XCLK_MEM_ECC_UNCOR_1	0x84
+#define REG_YCC_HCLK_MEM_ECC_EN		0x88
+#define REG_YCC_HCLK_MEM_ECC_COR	0x94
+#define REG_YCC_HCLK_MEM_ECC_UNCOR	0x98
+
+#define REG_YCC_DEV_INT_MASK		0xA4
+#define REG_YCC_HCLK_INT_MASK		0xE4
+#define REG_YCC_XCLK_INT_MASK		0xE8
+
+/* ring register offset */
+#define REG_RING_CMD_BASE_ADDR_LO	0x00
+#define REG_RING_CMD_BASE_ADDR_HI	0x04
+#define REG_RING_CMD_WR_PTR		0x08
+#define REG_RING_CMD_RD_PTR		0x0C
+#define REG_RING_RSP_BASE_ADDR_LO	0x10
+#define REG_RING_RSP_BASE_ADDR_HI	0x14
+#define REG_RING_RSP_WR_PTR		0x18
+#define REG_RING_RSP_RD_PTR		0x1C
+#define REG_RING_CFG			0x20
+#define REG_RING_TO_TH			0x24
+#define REG_RING_STATUS			0x28
+#define REG_RING_PENDING_CMD		0x2C
+#define REG_RING_RSP_WR_SHADOWN_PTR	0x30
+#define REG_RING_RSP_AFULL_TH		0x34
+
+#define YCC_HCLK_AHB_ERR		BIT(0)
+#define YCC_HCLK_SHIELD_ERR		BIT(1)
+#define YCC_HCLK_TRNG_ERR		BIT(2)
+#define YCC_HCLK_EFUSE_ERR		BIT(3)
+#define YCC_HCLK_INIT_ERR		GENMASK(30, 16)
+#define YCC_HCLK_CB_TRNG_ERR		BIT(31)
+
+#define YCC_CTRL_IRAM_EN		BIT(1)
+#define YCC_CTRL_SEC_EN			BIT(3)
+
+#define YCC_GO_PWRON			BIT(0)
+#define YCC_GO_ENABLED			BIT(1)
+
+#define PCI_EXR_DEVCTL_TRP		BIT(21)
+#define PCI_EXP_DEVCTL_FLREN		BIT(15)
+
+#define YDEV_STATUS_BIND		0
+#define YDEV_STATUS_INIT		1
+#define YDEV_STATUS_RESET		2
+#define YDEV_STATUS_READY		3
+#define YDEV_STATUS_ERR			4
+#define YDEV_STATUS_SRIOV		5
+
+struct ycc_bar {
+	void __iomem *vaddr;
+	resource_size_t paddr;
+	resource_size_t size;
+};
+
+enum ycc_dev_type {
+	YCC_RCIEP,
+	YCC_RCEC,
+};
+
+struct ycc_dev {
+	struct list_head list;
+	struct pci_dev *pdev;
+
+	u32 type;
+	int id;
+	int node;
+	const char *dev_name;
+	struct ycc_bar ycc_bars[4];
+	struct ycc_dev *assoc_dev;
+
+	bool is_polling;
+	unsigned long status;
+	struct workqueue_struct *dev_err_q;
+	char err_irq_name[32];
+	struct work_struct work;
+	char *msi_name[48];
+	struct dentry *debug_dir;
+	atomic_t refcnt;
+
+	bool sec;
+	bool is_vf;
+	bool enable_vf;
+};
+
+#define YCC_CSR_WR(csr_base, csr_offset, val)		\
+	__raw_writel(val, csr_base + csr_offset)
+#define YCC_CSR_RD(csr_base, csr_offset)		\
+	__raw_readl(csr_base + csr_offset)
+
+static inline void ycc_dev_get(struct ycc_dev *ydev)
+{
+	atomic_inc(&ydev->refcnt);
+}
+
+static inline void ycc_dev_put(struct ycc_dev *ydev)
+{
+	atomic_dec(&ydev->refcnt);
+}
+
+static inline void ycc_g_err_mask(void *vaddr)
+{
+	/* This will mask all error interrupt */
+	YCC_CSR_WR(vaddr, REG_YCC_DEV_INT_MASK, (u32)~0);
+}
+
+static inline void ycc_g_err_unmask(void *vaddr)
+{
+	/* This will unmask all error interrupt */
+	YCC_CSR_WR(vaddr, REG_YCC_DEV_INT_MASK, 0);
+}
+
+#endif
diff --git a/drivers/crypto/ycc/ycc_drv.c b/drivers/crypto/ycc/ycc_drv.c
new file mode 100644
index 00000000..89de43b
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_drv.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * YCC: Drivers for Alibaba YCC (Yitian Cryptography Complex) cryptographic
+ *   accelerator. Enables the on-chip cryptographic accelerator of Alibaba
+ *   Yitian SoCs which is based on ARMv9 architecture.
+ *
+ * Copyright (C) 2020-2022 Alibaba Corporation. All rights reserved.
+ * Author: Zelin Deng <zelin.deng@linux.alibaba.com>
+ * Author: Guanjun <guanjun@linux.alibaba.com>
+ */
+
+#define pr_fmt(fmt) "YCC: " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/iommu.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/debugfs.h>
+
+#include "ycc_isr.h"
+#include "ycc_cdev.h"
+
+static const char ycc_name[] = "ycc";
+
+static bool is_polling = true;
+module_param(is_polling, bool, 0644);
+
+LIST_HEAD(ycc_table);
+DEFINE_MUTEX(ycc_mutex);
+
+/*
+ * Each ycc device (RCIEP or RCEC) supports upto 48 VFs
+ * when enables SR-IOV. So each socket has 98 devices,
+ * includes 2 PFs and 96 VFs.
+ */
+#define YCC_MAX_DEVICES		(98 * 4) /* Assume 4 sockets */
+static DEFINE_IDR(ycc_idr);
+
+static int ycc_device_flr(struct pci_dev *pdev, struct pci_dev *rcec_pdev)
+{
+	int ret;
+
+	/*
+	 * NOTE: When rciep gets FLR, its associated rcec gets reset as well.
+	 * It does not make sense that individual pcie device should impact
+	 * others. Before it has been fixed on silicon side, add a workaround to
+	 * do FLR properly -- save both pci states and restore them latter.
+	 */
+	ret = pci_save_state(pdev);
+	if (ret) {
+		pr_err("Failed to save pci state\n");
+		return ret;
+	}
+
+	ret = pci_save_state(rcec_pdev);
+	if (ret) {
+		pr_err("Failed to save RCEC pci state\n");
+		return ret;
+	}
+
+	pcie_reset_flr(pdev, 0);
+	pcie_reset_flr(rcec_pdev, 0);
+
+	pci_restore_state(pdev);
+	pci_restore_state(rcec_pdev);
+
+	return 0;
+}
+
+static int ycc_resource_setup(struct ycc_dev *ydev)
+{
+	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
+	struct pci_dev *pdev = ydev->pdev;
+	struct ycc_bar *abar, *cfg_bar;
+	u32 hclk_status;
+	int ret;
+
+	ret = ycc_device_flr(pdev, rcec_pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_request_regions(pdev, ydev->dev_name);
+	if (ret) {
+		pr_err("Failed to request RCIEP mem regions\n");
+		return ret;
+	}
+
+	ret = -EIO;
+	cfg_bar = &ydev->ycc_bars[YCC_SEC_CFG_BAR];
+	cfg_bar->paddr = pci_resource_start(pdev, YCC_SEC_CFG_BAR);
+	cfg_bar->size = pci_resource_len(pdev, YCC_SEC_CFG_BAR);
+	cfg_bar->vaddr = ioremap(cfg_bar->paddr, cfg_bar->size);
+	if (!cfg_bar->vaddr) {
+		pr_err("Failed to ioremap RCIEP cfg bar\n");
+		goto release_mem_regions;
+	}
+
+	ycc_g_err_mask(cfg_bar->vaddr);
+
+	YCC_CSR_WR(cfg_bar->vaddr, REG_YCC_CTL, 0|YCC_CTRL_IRAM_EN);
+	YCC_CSR_WR(cfg_bar->vaddr, REG_YCC_GO, 0|YCC_GO_PWRON);
+
+	/* Waiting for ycc firmware ready, 1000ms is recommended by the HW designers */
+	mdelay(1000);
+	if (!(YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_GO) & YCC_GO_ENABLED)) {
+		pr_err("Failed to set ycc enabled\n");
+		goto iounmap_cfg_bar;
+	}
+
+	/* Check HCLK status register, some error may happen at PWRON stage */
+	hclk_status = YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_HCLK_INT_STATUS);
+	if (hclk_status & YCC_HCLK_INIT_ERR) {
+		pr_err("Error happened when ycc was initializing\n");
+		goto iounmap_cfg_bar;
+	}
+
+	abar = &ydev->ycc_bars[YCC_NSEC_Q_BAR];
+	abar->paddr = pci_resource_start(pdev, YCC_NSEC_Q_BAR);
+	abar->size = pci_resource_len(pdev, YCC_NSEC_Q_BAR);
+	abar->vaddr = pci_iomap(pdev, YCC_NSEC_Q_BAR, abar->size);
+	if (!abar->vaddr) {
+		pr_err("Failed to ioremap RCIEP queue bar\n");
+		goto iounmap_cfg_bar;
+	}
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret < 0) {
+		pr_info("Failed to set DMA bit mask 64, try 32\n");
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret < 0)
+			goto iounmap_queue_bar;
+	}
+
+	ret = ycc_enable_msix(ydev);
+	if (ret <= 0) {
+		pr_err("Failed to enable msix, ret: %d\n", ret);
+		ret = (ret == 0) ? -EINVAL : ret;
+		goto iounmap_queue_bar;
+	}
+
+	ret = ycc_init_global_err(ydev);
+	if (ret) {
+		pr_err("Failed to enable global err\n");
+		goto disable_msix;
+	}
+
+	ret = ycc_alloc_irqs(ydev);
+	if (ret) {
+		pr_err("Failed to alloc irqs\n");
+		goto deinit_g_err;
+	}
+
+	YCC_CSR_WR(cfg_bar->vaddr, REG_YCC_HCLK_INT_STATUS, ~0);
+	ycc_g_err_unmask(cfg_bar->vaddr);
+	return 0;
+
+deinit_g_err:
+	ycc_deinit_global_err(ydev);
+disable_msix:
+	ycc_disable_msix(ydev);
+iounmap_queue_bar:
+	iounmap(abar->vaddr);
+iounmap_cfg_bar:
+	iounmap(cfg_bar->vaddr);
+release_mem_regions:
+	pci_release_regions(pdev);
+	return ret;
+}
+
+static void ycc_resource_free(struct ycc_dev *ydev)
+{
+	ycc_deinit_global_err(ydev);
+	ycc_free_irqs(ydev);
+	ycc_disable_msix(ydev);
+	iounmap(ydev->ycc_bars[YCC_SEC_CFG_BAR].vaddr);
+	iounmap(ydev->ycc_bars[YCC_NSEC_Q_BAR].vaddr);
+	pci_release_regions(ydev->pdev);
+}
+
+static inline bool ycc_rcec_match(struct pci_dev *pdev0, struct pci_dev *pdev1)
+{
+	return pdev0->bus->number == pdev1->bus->number;
+}
+
+static int ycc_rcec_bind(struct ycc_dev *ydev)
+{
+	struct ycc_dev *assoc_dev, *rciep, *rcec;
+	struct list_head *itr;
+	int ret = 0;
+
+	if (list_empty(&ycc_table))
+		return ret;
+
+	list_for_each(itr, &ycc_table) {
+		assoc_dev = list_entry(itr, struct ycc_dev, list);
+		/* not in the same pci bus */
+		if (!ycc_rcec_match(ydev->pdev, assoc_dev->pdev))
+			continue;
+
+		/* if sriov is enabled, it could be the same */
+		if (ydev == assoc_dev)
+			continue;
+
+		/* if sriov is enabled, found other VFs */
+		if (ydev->type == assoc_dev->type)
+			continue;
+
+		/* have been bound */
+		if (test_bit(YDEV_STATUS_BIND, &assoc_dev->status))
+			continue;
+
+		/* assocated device has been enabled sriov */
+		if (test_bit(YDEV_STATUS_SRIOV, &assoc_dev->status))
+			break;
+
+		ydev->assoc_dev = assoc_dev;
+		assoc_dev->assoc_dev = ydev;
+		rciep = (ydev->type == YCC_RCIEP) ? ydev : ydev->assoc_dev;
+		rcec = rciep->assoc_dev;
+
+		ret = sysfs_create_link(&rcec->pdev->dev.kobj,
+					&rciep->pdev->dev.kobj, "ycc_rciep");
+		if (ret)
+			goto out;
+
+		ret = sysfs_create_link(&rciep->pdev->dev.kobj,
+					&rcec->pdev->dev.kobj, "ycc_rcec");
+		if (ret)
+			goto remove_rciep_link;
+
+		ret = ycc_resource_setup(rciep);
+		if (ret)
+			goto remove_rcec_link;
+
+		set_bit(YDEV_STATUS_READY, &rciep->status);
+		set_bit(YDEV_STATUS_BIND, &rciep->status);
+		set_bit(YDEV_STATUS_READY, &rcec->status);
+		set_bit(YDEV_STATUS_BIND, &rcec->status);
+		break;
+	}
+
+	return ret;
+
+remove_rcec_link:
+	sysfs_remove_link(&rciep->pdev->dev.kobj, "ycc_rcec");
+remove_rciep_link:
+	sysfs_remove_link(&rcec->pdev->dev.kobj, "ycc_rciep");
+out:
+	return ret;
+}
+
+static void ycc_rcec_unbind(struct ycc_dev *ydev)
+{
+	struct ycc_dev *rciep, *rcec;
+
+	if (!test_bit(YDEV_STATUS_BIND, &ydev->status))
+		return;
+
+	rciep = (ydev->type == YCC_RCIEP) ? ydev : ydev->assoc_dev;
+	rcec = rciep->assoc_dev;
+
+	clear_bit(YDEV_STATUS_READY, &rciep->status);
+	clear_bit(YDEV_STATUS_READY, &rcec->status);
+	clear_bit(YDEV_STATUS_BIND, &rciep->status);
+	clear_bit(YDEV_STATUS_BIND, &rcec->status);
+	sysfs_remove_link(&rcec->pdev->dev.kobj, "ycc_rciep");
+	sysfs_remove_link(&rciep->pdev->dev.kobj, "ycc_rcec");
+	ycc_resource_free(rciep);
+	rciep->assoc_dev = NULL;
+	rcec->assoc_dev = NULL;
+}
+
+static int ycc_dev_add(struct ycc_dev *ydev)
+{
+	int ret;
+
+	mutex_lock(&ycc_mutex);
+	ret = ycc_rcec_bind(ydev);
+	if (ret)
+		goto out;
+	list_add_tail(&ydev->list, &ycc_table);
+
+out:
+	mutex_unlock(&ycc_mutex);
+	return ret;
+}
+
+static void ycc_dev_del(struct ycc_dev *ydev)
+{
+	mutex_lock(&ycc_mutex);
+	ycc_rcec_unbind(ydev);
+	list_del(&ydev->list);
+	mutex_unlock(&ycc_mutex);
+}
+
+static inline int ycc_rciep_init(struct ycc_dev *ydev)
+{
+	struct pci_dev *pdev = ydev->pdev;
+	char name[YCC_MAX_DEBUGFS_NAME + 1];
+	int idr;
+
+	ydev->sec = false;
+	ydev->dev_name = ycc_name;
+	ydev->is_polling = is_polling;
+
+	idr = idr_alloc(&ycc_idr, ydev, 0, YCC_MAX_DEVICES, GFP_KERNEL);
+	if (idr < 0) {
+		pr_err("Failed to allocate idr for RCIEP device\n");
+		return idr;
+	}
+
+	ydev->id = idr;
+
+	snprintf(name, YCC_MAX_DEBUGFS_NAME, "ycc_%02x:%02d.%02d",
+		 pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	ydev->debug_dir = debugfs_create_dir(name, NULL);
+	/* If failed to create debugfs, driver can still work */
+	if (IS_ERR_OR_NULL(ydev->debug_dir)) {
+		pr_warn("Failed to create debugfs for RCIEP device\n");
+		ydev->debug_dir = NULL;
+	}
+
+	return 0;
+}
+
+static int ycc_drv_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct ycc_dev *ydev;
+	struct device *dev = &pdev->dev;
+	int node = dev_to_node(dev);
+	int ret = -ENOMEM;
+
+	ydev = kzalloc_node(sizeof(struct ycc_dev), GFP_KERNEL, node);
+	if (!ydev)
+		return ret;
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		pr_err("Failed to enable pci device\n");
+		goto free_ydev;
+	}
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, ydev);
+
+	ydev->pdev = pdev;
+	ydev->is_vf = false;
+	ydev->enable_vf = false;
+	ydev->node = node;
+	if (id->device == PCI_DEVICE_ID_RCIEP) {
+		ydev->type = YCC_RCIEP;
+		ret = ycc_rciep_init(ydev);
+		if (ret)
+			goto disable_ydev;
+	} else {
+		ydev->type = YCC_RCEC;
+	}
+
+	ret = ycc_dev_add(ydev);
+	if (ret)
+		goto remove_debugfs;
+
+	return ret;
+
+remove_debugfs:
+	if (ydev->type == YCC_RCIEP) {
+		debugfs_remove_recursive(ydev->debug_dir);
+		idr_remove(&ycc_idr, ydev->id);
+	}
+disable_ydev:
+	pci_disable_device(pdev);
+free_ydev:
+	pr_err("Failed to probe %s\n", ydev->type == YCC_RCIEP ? "RCIEP" : "RCEC");
+	kfree(ydev);
+	return ret;
+}
+
+static void ycc_drv_remove(struct pci_dev *pdev)
+{
+	struct ycc_dev *ydev = pci_get_drvdata(pdev);
+
+	ycc_dev_del(ydev);
+	if (ydev->type == YCC_RCIEP) {
+		debugfs_remove_recursive(ydev->debug_dir);
+		idr_remove(&ycc_idr, ydev->id);
+	}
+
+	pci_disable_sriov(pdev);
+	pci_disable_device(pdev);
+	kfree(ydev);
+}
+
+/*
+ * SRIOV is not supported now.
+ */
+static int ycc_drv_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	return -EFAULT;
+}
+
+static const struct pci_device_id ycc_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_YCC, PCI_DEVICE_ID_RCIEP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_YCC, PCI_DEVICE_ID_RCEC) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, ycc_id_table);
+
+static struct pci_driver ycc_driver = {
+	.name		= "ycc",
+	.id_table	= ycc_id_table,
+	.probe		= ycc_drv_probe,
+	.remove		= ycc_drv_remove,
+	.sriov_configure = ycc_drv_sriov_configure,
+};
+
+static int __init ycc_drv_init(void)
+{
+	int ret;
+
+	ret = ycc_cdev_register();
+	if (ret)
+		goto out;
+
+	ret = pci_register_driver(&ycc_driver);
+	if (ret)
+		goto cdev_unregister;
+
+	return 0;
+cdev_unregister:
+	ycc_cdev_unregister();
+out:
+	return ret;
+}
+
+static void __exit ycc_drv_exit(void)
+{
+	ycc_cdev_unregister();
+	pci_unregister_driver(&ycc_driver);
+}
+
+module_init(ycc_drv_init);
+module_exit(ycc_drv_exit);
+MODULE_AUTHOR("Zelin Deng <zelin.deng@linux.alibaba.com>");
+MODULE_AUTHOR("Guanjun <guanjun@linux.alibaba.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Driver for Alibaba YCC cryptographic accelerator");
diff --git a/drivers/crypto/ycc/ycc_isr.c b/drivers/crypto/ycc/ycc_isr.c
new file mode 100644
index 00000000..f2f751c
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_isr.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "YCC: " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+#include "ycc_isr.h"
+
+/*
+ * TODO: will implement when ycc ring actually work.
+ */
+static void ycc_process_global_err(struct work_struct *work)
+{
+}
+
+static irqreturn_t ycc_g_err_isr(int irq, void *data)
+{
+	struct ycc_dev *ydev = (struct ycc_dev *)data;
+	struct ycc_bar *cfg_bar;
+
+	if (test_and_set_bit(YDEV_STATUS_ERR, &ydev->status))
+		return IRQ_HANDLED;
+
+	/* Mask global errors until it has been processed */
+	cfg_bar = &ydev->ycc_bars[YCC_SEC_CFG_BAR];
+	ycc_g_err_mask(cfg_bar->vaddr);
+
+	clear_bit(YDEV_STATUS_READY, &ydev->status);
+
+	schedule_work(&ydev->work);
+	return IRQ_HANDLED;
+}
+
+int ycc_enable_msix(struct ycc_dev *ydev)
+{
+	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
+
+	/* Disable intx explicitly */
+	return pci_alloc_irq_vectors(rcec_pdev, YCC_IRQS, YCC_IRQS, PCI_IRQ_MSIX);
+}
+
+void ycc_disable_msix(struct ycc_dev *ydev)
+{
+	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
+
+	pci_free_irq_vectors(rcec_pdev);
+}
+
+static int ycc_setup_global_err_workqueue(struct ycc_dev *ydev)
+{
+	char name[32] = {0};
+
+	sprintf(name, "ycc_dev_%d_g_errd", ydev->id);
+	INIT_WORK(&ydev->work, ycc_process_global_err);
+
+	/* Allocated, but not used temporarily */
+	ydev->dev_err_q = alloc_workqueue(name, WQ_UNBOUND, 0);
+	if (!ydev->dev_err_q) {
+		pr_err("Failed to alloc workqueue for dev: %d\n", ydev->id);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ycc_cleanup_global_err_workqueue(struct ycc_dev *ydev)
+{
+	if (ydev->dev_err_q)
+		destroy_workqueue(ydev->dev_err_q);
+}
+
+/*
+ * TODO: Just request irq for global err. Irq for each ring
+ * will be requested when ring actually work.
+ */
+int ycc_alloc_irqs(struct ycc_dev *ydev)
+{
+	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
+	int num = ydev->is_vf ? 1 : YCC_RINGPAIR_NUM;
+	int ret;
+
+	sprintf(ydev->err_irq_name, "ycc_dev_%d_global_err", ydev->id);
+	ret = request_irq(pci_irq_vector(rcec_pdev, num),
+			  ycc_g_err_isr, 0, ydev->err_irq_name, ydev);
+	if (ret)
+		pr_err("Failed to alloc global irq interrupt for dev: %d\n", ydev->id);
+
+	return ret;
+}
+
+/*
+ * TODO: Same as the allocate action.
+ */
+void ycc_free_irqs(struct ycc_dev *ydev)
+{
+	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
+	int num = ydev->is_vf ? 1 : YCC_RINGPAIR_NUM;
+
+	free_irq(pci_irq_vector(rcec_pdev, num), ydev);
+}
+
+int ycc_init_global_err(struct ycc_dev *ydev)
+{
+	return ycc_setup_global_err_workqueue(ydev);
+}
+
+void ycc_deinit_global_err(struct ycc_dev *ydev)
+{
+	ycc_cleanup_global_err_workqueue(ydev);
+}
diff --git a/drivers/crypto/ycc/ycc_isr.h b/drivers/crypto/ycc/ycc_isr.h
new file mode 100644
index 00000000..8318a6f
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_isr.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __YCC_ISR_H
+
+#include "ycc_dev.h"
+
+int ycc_enable_msix(struct ycc_dev *ydev);
+void ycc_disable_msix(struct ycc_dev *ydev);
+int ycc_alloc_irqs(struct ycc_dev *ydev);
+void ycc_free_irqs(struct ycc_dev *ydev);
+int ycc_init_global_err(struct ycc_dev *ydev);
+void ycc_deinit_global_err(struct ycc_dev *ydev);
+#endif
-- 
1.8.3.1


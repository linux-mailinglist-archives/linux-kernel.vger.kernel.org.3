Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF259F6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiHXJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiHXJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:28 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DE3E77F;
        Wed, 24 Aug 2022 02:50:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN7.oFj_1661334622;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN7.oFj_1661334622)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:23 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/9] crypto/ycc: Add ycc ring configuration
Date:   Wed, 24 Aug 2022 17:50:14 +0800
Message-Id: <1661334621-44413-3-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

There're 2 types of functional rings, kernel ring and user ring.
All kernel rings must be initialized in kernel driver while user rings
are not supported now.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
---
 drivers/crypto/ycc/Makefile   |   2 +-
 drivers/crypto/ycc/ycc_dev.h  |   6 +
 drivers/crypto/ycc/ycc_drv.c  |  59 ++++-
 drivers/crypto/ycc/ycc_isr.c  |   7 +
 drivers/crypto/ycc/ycc_ring.c | 562 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.h | 111 +++++++++
 6 files changed, 745 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/ycc/ycc_ring.c
 create mode 100644 drivers/crypto/ycc/ycc_ring.h

diff --git a/drivers/crypto/ycc/Makefile b/drivers/crypto/ycc/Makefile
index bde56c8..6c7733e 100644
--- a/drivers/crypto/ycc/Makefile
+++ b/drivers/crypto/ycc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-(CONFIG_CRYPTO_DEV_YCC) += ycc.o
-ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o
+ycc-objs := ycc_drv.o ycc_isr.o ycc_cdev.o ycc_ring.o
diff --git a/drivers/crypto/ycc/ycc_dev.h b/drivers/crypto/ycc/ycc_dev.h
index e5f76af..dda82b0 100644
--- a/drivers/crypto/ycc/ycc_dev.h
+++ b/drivers/crypto/ycc/ycc_dev.h
@@ -104,10 +104,16 @@ struct ycc_dev {
 	struct ycc_bar ycc_bars[4];
 	struct ycc_dev *assoc_dev;
 
+	int max_desc;
+	int user_rings;
 	bool is_polling;
 	unsigned long status;
 	struct workqueue_struct *dev_err_q;
 	char err_irq_name[32];
+
+	struct ycc_ring *rings;
+	unsigned long ring_bitmap;
+
 	struct work_struct work;
 	char *msi_name[48];
 	struct dentry *debug_dir;
diff --git a/drivers/crypto/ycc/ycc_drv.c b/drivers/crypto/ycc/ycc_drv.c
index 89de43b..ac9b8c2 100644
--- a/drivers/crypto/ycc/ycc_drv.c
+++ b/drivers/crypto/ycc/ycc_drv.c
@@ -25,11 +25,16 @@
 
 #include "ycc_isr.h"
 #include "ycc_cdev.h"
+#include "ycc_ring.h"
 
 static const char ycc_name[] = "ycc";
 
+static int max_desc = 256;
+static int user_rings;
 static bool is_polling = true;
+module_param(max_desc, int, 0644);
 module_param(is_polling, bool, 0644);
+module_param(user_rings, int, 0644);
 
 LIST_HEAD(ycc_table);
 DEFINE_MUTEX(ycc_mutex);
@@ -42,6 +47,35 @@
 #define YCC_MAX_DEVICES		(98 * 4) /* Assume 4 sockets */
 static DEFINE_IDR(ycc_idr);
 
+static int ycc_dev_debugfs_statistics_show(struct seq_file *s, void *p)
+{
+	struct ycc_dev *ydev = (struct ycc_dev *)s->private;
+	struct ycc_ring *ring;
+	int i;
+
+	seq_printf(s, "name, type, nr_binds, nr_cmds, nr_resps\n");
+	for (i = 0; i < YCC_RINGPAIR_NUM; i++) {
+		ring = ydev->rings + i;
+		seq_printf(s, "Ring%02d, %d, %llu, %llu, %llu\n", ring->ring_id,
+			   ring->type, ring->nr_binds, ring->nr_cmds, ring->nr_resps);
+	}
+
+	return 0;
+}
+
+static int ycc_dev_debugfs_statistics_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ycc_dev_debugfs_statistics_show, inode->i_private);
+}
+
+static const struct file_operations ycc_dev_statistics_fops = {
+	.open		= ycc_dev_debugfs_statistics_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+
 static int ycc_device_flr(struct pci_dev *pdev, struct pci_dev *rcec_pdev)
 {
 	int ret;
@@ -137,11 +171,21 @@ static int ycc_resource_setup(struct ycc_dev *ydev)
 			goto iounmap_queue_bar;
 	}
 
+	/* User ring is not supported temporarily */
+	ydev->user_rings = 0;
+	user_rings = 0;
+
+	ret = ycc_dev_rings_init(ydev, max_desc, user_rings);
+	if (ret) {
+		pr_err("Failed to init ycc rings\n");
+		goto iounmap_queue_bar;
+	}
+
 	ret = ycc_enable_msix(ydev);
 	if (ret <= 0) {
 		pr_err("Failed to enable msix, ret: %d\n", ret);
 		ret = (ret == 0) ? -EINVAL : ret;
-		goto iounmap_queue_bar;
+		goto release_rings;
 	}
 
 	ret = ycc_init_global_err(ydev);
@@ -164,12 +208,15 @@ static int ycc_resource_setup(struct ycc_dev *ydev)
 	ycc_deinit_global_err(ydev);
 disable_msix:
 	ycc_disable_msix(ydev);
+release_rings:
+	ycc_dev_rings_release(ydev, user_rings);
 iounmap_queue_bar:
 	iounmap(abar->vaddr);
 iounmap_cfg_bar:
 	iounmap(cfg_bar->vaddr);
 release_mem_regions:
 	pci_release_regions(pdev);
+
 	return ret;
 }
 
@@ -178,6 +225,7 @@ static void ycc_resource_free(struct ycc_dev *ydev)
 	ycc_deinit_global_err(ydev);
 	ycc_free_irqs(ydev);
 	ycc_disable_msix(ydev);
+	ycc_dev_rings_release(ydev, ydev->user_rings);
 	iounmap(ydev->ycc_bars[YCC_SEC_CFG_BAR].vaddr);
 	iounmap(ydev->ycc_bars[YCC_NSEC_Q_BAR].vaddr);
 	pci_release_regions(ydev->pdev);
@@ -302,12 +350,15 @@ static void ycc_dev_del(struct ycc_dev *ydev)
 static inline int ycc_rciep_init(struct ycc_dev *ydev)
 {
 	struct pci_dev *pdev = ydev->pdev;
+	struct dentry *debugfs;
 	char name[YCC_MAX_DEBUGFS_NAME + 1];
 	int idr;
 
 	ydev->sec = false;
 	ydev->dev_name = ycc_name;
 	ydev->is_polling = is_polling;
+	ydev->user_rings = user_rings;
+	ydev->max_desc = max_desc;
 
 	idr = idr_alloc(&ycc_idr, ydev, 0, YCC_MAX_DEVICES, GFP_KERNEL);
 	if (idr < 0) {
@@ -324,6 +375,11 @@ static inline int ycc_rciep_init(struct ycc_dev *ydev)
 	if (IS_ERR_OR_NULL(ydev->debug_dir)) {
 		pr_warn("Failed to create debugfs for RCIEP device\n");
 		ydev->debug_dir = NULL;
+	} else {
+		debugfs = debugfs_create_file("statistics", 0400, ydev->debug_dir,
+				(void *)ydev, &ycc_dev_statistics_fops);
+		if (IS_ERR_OR_NULL(debugfs))
+			pr_warn("Failed to create statistics entry for RCIEP device\n");
 	}
 
 	return 0;
@@ -352,6 +408,7 @@ static int ycc_drv_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ydev->is_vf = false;
 	ydev->enable_vf = false;
 	ydev->node = node;
+	ydev->ring_bitmap = 0;
 	if (id->device == PCI_DEVICE_ID_RCIEP) {
 		ydev->type = YCC_RCIEP;
 		ret = ycc_rciep_init(ydev);
diff --git a/drivers/crypto/ycc/ycc_isr.c b/drivers/crypto/ycc/ycc_isr.c
index f2f751c..cd2a2d7 100644
--- a/drivers/crypto/ycc/ycc_isr.c
+++ b/drivers/crypto/ycc/ycc_isr.c
@@ -38,6 +38,13 @@ static irqreturn_t ycc_g_err_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * TODO: will implement when ycc ring actually work.
+ */
+void ycc_resp_process(uintptr_t ring_addr)
+{
+}
+
 int ycc_enable_msix(struct ycc_dev *ydev)
 {
 	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
diff --git a/drivers/crypto/ycc/ycc_ring.c b/drivers/crypto/ycc/ycc_ring.c
new file mode 100644
index 00000000..d808054
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_ring.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "YCC: Ring: " fmt
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/dma-mapping.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+
+#include "ycc_dev.h"
+#include "ycc_ring.h"
+
+#define YCC_CMD_DESC_SIZE	64
+#define YCC_RESP_DESC_SIZE	16
+#define YCC_RING_CSR_STRIDE	0x1000
+
+extern struct list_head ycc_table;
+extern void ycc_resp_process(uintptr_t ring_addr);
+
+static struct rb_root ring_rbtree = RB_ROOT;
+static DEFINE_SPINLOCK(ring_rbtree_lock);
+
+/*
+ * Show the status of specified ring's command queue and
+ * response queue.
+ */
+static int ycc_ring_debugfs_status_show(struct seq_file *s, void *p)
+{
+	struct ycc_ring *ring = (struct ycc_ring *)s->private;
+
+	seq_printf(s, "Ring ID: %d\n", ring->ring_id);
+	seq_printf(s, "Desscriptor Entry Size: %d, CMD Descriptor Size: %d, RESP Descriptor Size :%d\n",
+		   ring->max_desc, YCC_CMD_DESC_SIZE, YCC_RESP_DESC_SIZE);
+	seq_printf(s, "CMD base addr:%llx, RESP base addr:%llx\n",
+		   ring->cmd_base_paddr, ring->resp_base_paddr);
+	seq_printf(s, "CMD wr ptr:%d, CMD rd ptr: %d\n",
+		   YCC_CSR_RD(ring->csr_vaddr, REG_RING_CMD_WR_PTR),
+		   YCC_CSR_RD(ring->csr_vaddr, REG_RING_CMD_RD_PTR));
+	seq_printf(s, "RESP rd ptr:%d, RESP wr ptr: %d\n",
+		   YCC_CSR_RD(ring->csr_vaddr, REG_RING_RSP_RD_PTR),
+		   YCC_CSR_RD(ring->csr_vaddr, REG_RING_RSP_WR_PTR));
+
+	return 0;
+}
+
+static int ycc_ring_debugfs_status_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ycc_ring_debugfs_status_show, inode->i_private);
+}
+
+static const struct file_operations ycc_ring_status_fops = {
+	.open		= ycc_ring_debugfs_status_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+
+/*
+ * Dump the raw content of specified ring's command queue and
+ * response queue.
+ */
+static int ycc_ring_debugfs_dump_show(struct seq_file *s, void *p)
+{
+	struct ycc_ring *ring = (struct ycc_ring *)s->private;
+
+	seq_printf(s, "Ring ID: %d\n", ring->ring_id);
+	seq_puts(s, "-------- Ring CMD Descriptors --------\n");
+	seq_hex_dump(s, "", DUMP_PREFIX_ADDRESS, 32, 4, ring->cmd_base_vaddr,
+		     YCC_CMD_DESC_SIZE * ring->max_desc, false);
+	seq_puts(s, "-------- Ring RESP Descriptors --------\n");
+	seq_hex_dump(s, "", DUMP_PREFIX_ADDRESS, 32, 4, ring->resp_base_vaddr,
+		     YCC_RESP_DESC_SIZE * ring->max_desc, false);
+
+	return 0;
+}
+
+static int ycc_ring_debugfs_dump_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ycc_ring_debugfs_dump_show, inode->i_private);
+}
+
+static const struct file_operations ycc_ring_dump_fops = {
+	.open		= ycc_ring_debugfs_dump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+
+/*
+ * Create debugfs for rings, only for KERN_RING
+ * "/sys/kernel/debugfs/ycc_b:d.f/ring${x}"
+ */
+static int ycc_create_ring_debugfs(struct ycc_ring *ring)
+{
+	struct dentry *debugfs;
+	char name[8];
+
+	if (!ring || !ring->ydev || !ring->ydev->debug_dir)
+		return -EINVAL;
+
+	snprintf(name, sizeof(name), "ring%02d", ring->ring_id);
+	debugfs = debugfs_create_dir(name, ring->ydev->debug_dir);
+	if (IS_ERR_OR_NULL(debugfs))
+		goto out;
+
+	ring->debug_dir = debugfs;
+
+	debugfs = debugfs_create_file("status", 0400, ring->debug_dir,
+				      (void *)ring, &ycc_ring_status_fops);
+	if (IS_ERR_OR_NULL(debugfs))
+		goto remove_debugfs;
+
+	debugfs = debugfs_create_file("dump", 0400, ring->debug_dir,
+				      (void *)ring, &ycc_ring_dump_fops);
+	if (IS_ERR_OR_NULL(debugfs))
+		goto remove_debugfs;
+
+	return 0;
+
+remove_debugfs:
+	debugfs_remove_recursive(ring->debug_dir);
+out:
+	ring->debug_dir = NULL;
+	return PTR_ERR(debugfs);
+}
+
+static void ycc_remove_ring_debugfs(struct ycc_ring *ring)
+{
+	debugfs_remove_recursive(ring->debug_dir);
+}
+
+/*
+ * Allocate memory for rings and initiate basic fields
+ */
+static int ycc_alloc_rings(struct ycc_dev *ydev)
+{
+	int num = YCC_RINGPAIR_NUM;
+	struct ycc_bar *abar;
+	u32 i;
+
+	if (ydev->rings)
+		return 0;
+
+	if (ydev->is_vf) {
+		num = 1;
+		abar = &ydev->ycc_bars[0];
+	} else if (ydev->sec) {
+		abar = &ydev->ycc_bars[YCC_SEC_Q_BAR];
+	} else {
+		abar = &ydev->ycc_bars[YCC_NSEC_Q_BAR];
+	}
+
+	ydev->rings = kzalloc_node(num * sizeof(struct ycc_ring),
+				   GFP_KERNEL, ydev->node);
+	if (!ydev->rings)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		ydev->rings[i].ring_id = i;
+		ydev->rings[i].ydev = ydev;
+		ydev->rings[i].csr_vaddr = abar->vaddr + i * YCC_RING_CSR_STRIDE;
+		ydev->rings[i].csr_paddr = abar->paddr + i * YCC_RING_CSR_STRIDE;
+	}
+
+	return 0;
+}
+
+/*
+ * Free memory for rings
+ */
+static void ycc_free_rings(struct ycc_dev *ydev)
+{
+	kfree(ydev->rings);
+	ydev->rings = NULL;
+}
+
+/*
+ * Initiate ring and create command queue and response queue.
+ */
+static int ycc_init_ring(struct ycc_ring *ring, u32 max_desc)
+{
+	struct ycc_dev *ydev = ring->ydev;
+	u32 cmd_ring_size, resp_ring_size;
+
+	ring->type = KERN_RING;
+	ring->max_desc = max_desc;
+
+	cmd_ring_size = ring->max_desc * YCC_CMD_DESC_SIZE;
+	resp_ring_size = ring->max_desc * YCC_RESP_DESC_SIZE;
+
+	ring->cmd_base_vaddr = dma_alloc_coherent(&ydev->pdev->dev,
+						  cmd_ring_size,
+						  &ring->cmd_base_paddr,
+						  GFP_KERNEL);
+	if (!ring->cmd_base_vaddr) {
+		pr_err("Failed to alloc cmd dma memory\n");
+		return -ENOMEM;
+	}
+	memset(ring->cmd_base_vaddr, CMD_INVALID_CONTENT_U8, cmd_ring_size);
+
+	ring->resp_base_vaddr = dma_alloc_coherent(&ydev->pdev->dev,
+						   resp_ring_size,
+						   &ring->resp_base_paddr,
+						   GFP_KERNEL);
+	if (!ring->resp_base_vaddr) {
+		pr_err("Failed to alloc resp dma memory\n");
+		dma_free_coherent(&ydev->pdev->dev, cmd_ring_size,
+				  ring->cmd_base_vaddr, ring->cmd_base_paddr);
+		return -ENOMEM;
+	}
+	memset(ring->resp_base_vaddr, CMD_INVALID_CONTENT_U8, resp_ring_size);
+
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_RSP_AFULL_TH, 0);
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_CMD_BASE_ADDR_LO,
+					(u32)ring->cmd_base_paddr & 0xffffffff);
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_CMD_BASE_ADDR_HI,
+					((u64)ring->cmd_base_paddr >> 32) & 0xffffffff);
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_RSP_BASE_ADDR_LO,
+					(u32)ring->resp_base_paddr & 0xffffffff);
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_RSP_BASE_ADDR_HI,
+					((u64)ring->resp_base_paddr >> 32) & 0xffffffff);
+
+	if (ycc_create_ring_debugfs(ring))
+		pr_warn("Failed to create debugfs entry for ring: %d\n", ring->ring_id);
+
+	atomic_set(&ring->ref_cnt, 0);
+	spin_lock_init(&ring->lock);
+	return 0;
+}
+
+/*
+ * Release dma memory for command queue and response queue.
+ */
+static void ycc_release_ring(struct ycc_ring *ring)
+{
+	u32 ring_size;
+
+	/* This ring should not be in use here */
+	WARN_ON(atomic_read(&ring->ref_cnt));
+
+	if (ring->cmd_base_vaddr) {
+		ring_size = ring->max_desc * YCC_CMD_DESC_SIZE;
+		dma_free_coherent(&ring->ydev->pdev->dev, ring_size,
+				  ring->cmd_base_vaddr,
+				  ring->cmd_base_paddr);
+		ring->cmd_base_vaddr = NULL;
+	}
+	if (ring->resp_base_vaddr) {
+		ring_size = ring->max_desc * YCC_RESP_DESC_SIZE;
+		dma_free_coherent(&ring->ydev->pdev->dev, ring_size,
+				  ring->resp_base_vaddr,
+				  ring->resp_base_paddr);
+		ring->resp_base_vaddr = NULL;
+	}
+
+	ycc_remove_ring_debugfs(ring);
+	ring->type = FREE_RING;
+}
+
+int ycc_dev_rings_init(struct ycc_dev *ydev, u32 max_desc, int user_rings)
+{
+	int kern_rings = YCC_RINGPAIR_NUM - user_rings;
+	struct ycc_ring *ring;
+	int ret, i;
+
+	ret = ycc_alloc_rings(ydev);
+	if (ret) {
+		pr_err("Failed to allocate memory for rings\n");
+		return ret;
+	}
+
+	for (i = 0; i < kern_rings; i++) {
+		ring = &ydev->rings[i];
+		ret = ycc_init_ring(ring, max_desc);
+		if (ret)
+			goto free_kern_rings;
+
+		tasklet_init(&ring->resp_handler, ycc_resp_process, (uintptr_t)ring);
+	}
+
+	return 0;
+
+free_kern_rings:
+	while (i--) {
+		ring = &ydev->rings[i];
+		ycc_release_ring(ring);
+	}
+
+	ycc_free_rings(ydev);
+	return ret;
+}
+
+void ycc_dev_rings_release(struct ycc_dev *ydev, int user_rings)
+{
+	int kern_rings = YCC_RINGPAIR_NUM - user_rings;
+	struct ycc_ring *ring;
+	int i;
+
+	for (i = 0; i < kern_rings; i++) {
+		ring = &ydev->rings[i];
+
+		tasklet_kill(&ring->resp_handler);
+		ycc_release_ring(ring);
+	}
+
+	ycc_free_rings(ydev);
+}
+
+/*
+ * Check if the command queue is full.
+ */
+static inline bool ycc_ring_full(struct ycc_ring *ring)
+{
+	return ring->cmd_rd_ptr == (ring->cmd_wr_ptr + 1) % ring->max_desc;
+}
+
+/*
+ * Check if the response queue is empty
+ */
+static inline bool ycc_ring_empty(struct ycc_ring *ring)
+{
+	return ring->resp_rd_ptr == ring->resp_wr_ptr;
+}
+
+#define __rb_node_to_type(a)	rb_entry(a, struct ycc_ring, node)
+
+static inline bool ycc_ring_less(struct rb_node *a, const struct rb_node *b)
+{
+	return (atomic_read(&__rb_node_to_type(a)->ref_cnt)
+		< atomic_read(&__rb_node_to_type(b)->ref_cnt));
+}
+
+static struct ycc_ring *ycc_select_ring(void)
+{
+	struct ycc_ring *found = NULL;
+	struct rb_node *rnode;
+	struct list_head *itr;
+	struct ycc_dev *ydev;
+	int idx;
+
+	if (list_empty(&ycc_table))
+		return NULL;
+
+	/*
+	 * No need to protect the list through lock here. The external
+	 * ycc_table list only insert/remove entry when probing/removing
+	 * the driver. Before calling this function, the reference count
+	 * of THIS_MODULE has increased in the crypto layer. So removing
+	 * driver will be blocked at present. Meanwhile, inserting new entry
+	 * to the list has no impact on 'reading' behavior.
+	 */
+	list_for_each(itr, &ycc_table) {
+		ydev = list_entry(itr, struct ycc_dev, list);
+
+		/* RCEC has no rings */
+		if (ydev->type != YCC_RCIEP)
+			continue;
+
+		/* RCIEP is not ready */
+		if (!test_bit(YDEV_STATUS_READY, &ydev->status))
+			continue;
+
+		do {
+			idx = find_first_zero_bit(&ydev->ring_bitmap, YCC_RINGPAIR_NUM);
+			if (idx == YCC_RINGPAIR_NUM)
+				break;
+
+			found = ydev->rings + idx;
+			if (found->type != KERN_RING) {
+				/* Found ring is not for kernel, mark it and continue */
+				set_bit(idx, &ydev->ring_bitmap);
+				continue;
+			}
+		} while (test_and_set_bit(idx, &ydev->ring_bitmap));
+
+		if (idx < YCC_RINGPAIR_NUM && found)
+			goto out;
+	}
+
+	/*
+	 * We didn't find the exact ring which means each ring
+	 * has been occupied. Fallback to slow path.
+	 */
+	spin_lock(&ring_rbtree_lock);
+	rnode = rb_first(&ring_rbtree);
+	rb_erase(rnode, &ring_rbtree);
+	spin_unlock(&ring_rbtree_lock);
+
+	found = __rb_node_to_type(rnode);
+
+out:
+	ycc_ring_get(found);
+	spin_lock(&ring_rbtree_lock);
+	rb_add(&found->node, &ring_rbtree, ycc_ring_less);
+	spin_unlock(&ring_rbtree_lock);
+	return found;
+}
+
+/*
+ * Bind the ring to crypto
+ */
+struct ycc_ring *ycc_crypto_get_ring(void)
+{
+	struct ycc_ring *ring;
+
+	ring = ycc_select_ring();
+	if (ring) {
+		ycc_dev_get(ring->ydev);
+		ring->nr_binds++;
+		if (ring->ydev->is_polling && atomic_read(&ring->ref_cnt) == 1)
+			tasklet_hi_schedule(&ring->resp_handler);
+	}
+
+	return ring;
+}
+
+void ycc_crypto_free_ring(struct ycc_ring *ring)
+{
+	struct rb_node *rnode = &ring->node;
+
+	spin_lock(&ring_rbtree_lock);
+	rb_erase(rnode, &ring_rbtree);
+	if (atomic_dec_and_test(&ring->ref_cnt)) {
+		clear_bit(ring->ring_id, &ring->ydev->ring_bitmap);
+		tasklet_kill(&ring->resp_handler);
+	} else {
+		rb_add(rnode, &ring_rbtree, ycc_ring_less);
+	}
+
+	spin_unlock(&ring_rbtree_lock);
+
+	ycc_dev_put(ring->ydev);
+}
+
+/*
+ * Submit command to ring's command queue.
+ */
+int ycc_enqueue(struct ycc_ring *ring, void *cmd)
+{
+	int ret = 0;
+
+	if (!ring || !ring->ydev || !cmd)
+		return -EINVAL;
+
+	spin_lock_bh(&ring->lock);
+	if (!test_bit(YDEV_STATUS_READY, &ring->ydev->status) || ycc_ring_stopped(ring)) {
+		pr_debug("Enqueue error, device status: %ld, ring stopped: %d\n",
+			 ring->ydev->status, ycc_ring_stopped(ring));
+
+		/* Fallback to software */
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	ring->cmd_rd_ptr = YCC_CSR_RD(ring->csr_vaddr, REG_RING_CMD_RD_PTR);
+	if (ycc_ring_full(ring)) {
+		pr_debug("Enqueue error, ring %d is full\n", ring->ring_id);
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	memcpy(ring->cmd_base_vaddr + ring->cmd_wr_ptr * YCC_CMD_DESC_SIZE, cmd,
+	       YCC_CMD_DESC_SIZE);
+
+	/* Ensure that cmd_wr_ptr update after memcpy */
+	dma_wmb();
+	if (++ring->cmd_wr_ptr == ring->max_desc)
+		ring->cmd_wr_ptr = 0;
+
+	ring->nr_cmds++;
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_CMD_WR_PTR, ring->cmd_wr_ptr);
+
+out:
+	spin_unlock_bh(&ring->lock);
+	return ret;
+}
+
+static inline void ycc_check_cmd_state(u16 state)
+{
+	switch (state) {
+	case CMD_SUCCESS:
+		break;
+	case CMD_ILLEGAL:
+		pr_debug("Illegal command\n");
+		break;
+	case CMD_UNDERATTACK:
+		pr_debug("Attack is detected\n");
+		break;
+	case CMD_INVALID:
+		pr_debug("Invalid command\n");
+		break;
+	case CMD_ERROR:
+		pr_debug("Command error\n");
+		break;
+	case CMD_EXCESS:
+		pr_debug("Excess permission\n");
+		break;
+	case CMD_KEY_ERROR:
+		pr_debug("Invalid internal key\n");
+		break;
+	case CMD_VERIFY_ERROR:
+		pr_debug("Mac/tag verify failed\n");
+		break;
+	default:
+		pr_debug("Unknown error\n");
+		break;
+	}
+}
+
+void ycc_handle_resp(struct ycc_ring *ring, struct ycc_resp_desc *desc)
+{
+	struct ycc_flags *aflag;
+
+	dma_rmb();
+
+	aflag = (struct ycc_flags *)desc->private_ptr;
+	if (!aflag || (u64)aflag == CMD_INVALID_CONTENT_U64) {
+		pr_debug("Invalid command aflag\n");
+		return;
+	}
+
+	ycc_check_cmd_state(desc->state);
+	aflag->ycc_done_callback(aflag->ptr, desc->state);
+
+	memset(desc, CMD_INVALID_CONTENT_U8, sizeof(*desc));
+	kfree(aflag);
+}
+
+/*
+ * dequeue, read response descriptor
+ */
+void ycc_dequeue(struct ycc_ring *ring)
+{
+	struct ycc_resp_desc *resp;
+	int cnt = 0;
+
+	if (!test_bit(YDEV_STATUS_READY, &ring->ydev->status) || ycc_ring_stopped(ring))
+		return;
+
+	ring->resp_wr_ptr = YCC_CSR_RD(ring->csr_vaddr, REG_RING_RSP_WR_PTR);
+	while (!ycc_ring_empty(ring)) {
+		resp = (struct ycc_resp_desc *)ring->resp_base_vaddr +
+			ring->resp_rd_ptr;
+		ycc_handle_resp(ring, resp);
+
+		cnt++;
+		ring->nr_resps++;
+		if (++ring->resp_rd_ptr == ring->max_desc)
+			ring->resp_rd_ptr = 0;
+	}
+
+	if (cnt)
+		YCC_CSR_WR(ring->csr_vaddr, REG_RING_RSP_RD_PTR, ring->resp_rd_ptr);
+}
diff --git a/drivers/crypto/ycc/ycc_ring.h b/drivers/crypto/ycc/ycc_ring.h
new file mode 100644
index 00000000..eb3e6f9
--- /dev/null
+++ b/drivers/crypto/ycc/ycc_ring.h
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __YCC_RING_H
+#define __YCC_RING_H
+
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include "ycc_dev.h"
+
+#define CMD_ILLEGAL			0x15
+#define CMD_UNDERATTACK			0x25
+#define CMD_INVALID			0x35
+#define CMD_ERROR			0x45
+#define CMD_EXCESS			0x55
+#define CMD_KEY_ERROR			0x65
+#define CMD_VERIFY_ERROR		0x85
+#define CMD_SUCCESS			0xa5
+#define CMD_CANCELLED			0xff
+
+#define CMD_INVALID_CONTENT_U8		0x7f
+#define CMD_INVALID_CONTENT_U64		0x7f7f7f7f7f7f7f7fULL
+
+enum ring_type {
+	FREE_RING,
+	USER_RING,
+	KERN_RING,
+	INVAL_RING,
+};
+
+struct ycc_ring {
+	u16 ring_id;
+	u32 status;
+
+	struct rb_node node;
+	atomic_t ref_cnt;
+
+	void __iomem *csr_vaddr;	/* config register address */
+	resource_size_t csr_paddr;
+	struct ycc_dev *ydev;		/* belongs to which ydev */
+	struct dentry *debug_dir;
+
+	u32 max_desc;		/* max desc entry numbers */
+	u32 irq_th;
+	spinlock_t lock;	/* used to send cmd, protect write ptr */
+	enum ring_type type;
+
+	void *cmd_base_vaddr;	/* base addr of cmd ring */
+	dma_addr_t cmd_base_paddr;
+	u16 cmd_wr_ptr;		/* current cmd write pointer */
+	u16 cmd_rd_ptr;		/* current cmd read pointer */
+	void *resp_base_vaddr;	/* base addr of resp ring */
+	dma_addr_t resp_base_paddr;
+	u16 resp_wr_ptr;	/* current resp write pointer */
+	u16 resp_rd_ptr;	/* current resp read pointer */
+
+	struct tasklet_struct resp_handler;
+
+	/* for statistics */
+	u64 nr_binds;
+	u64 nr_cmds;
+	u64 nr_resps;
+};
+
+struct ycc_flags {
+	void *ptr;
+	int (*ycc_done_callback)(void *ptr, u16 state);
+};
+
+struct ycc_resp_desc {
+	u64 private_ptr;
+	u16 state;
+	u8 reserved[6];
+};
+
+union ycc_real_cmd {
+	/*
+	 * TODO: Real command will implement when
+	 * corresponding algorithm is ready
+	 */
+	u8 padding[32];
+};
+
+struct ycc_cmd_desc {
+	union ycc_real_cmd cmd;
+	u64 private_ptr;
+	u8 reserved0[16];
+	u8 reserved1[8];
+} __packed;
+
+static inline void ycc_ring_get(struct ycc_ring *ring)
+{
+	atomic_inc(&ring->ref_cnt);
+}
+
+static inline void ycc_ring_put(struct ycc_ring *ring)
+{
+	atomic_dec(&ring->ref_cnt);
+}
+
+static inline bool ycc_ring_stopped(struct ycc_ring *ring)
+{
+	return !!(YCC_CSR_RD(ring->csr_vaddr, REG_RING_CFG) & RING_STOP_BIT);
+}
+
+int ycc_enqueue(struct ycc_ring *ring, void *cmd);
+void ycc_dequeue(struct ycc_ring *ring);
+struct ycc_ring *ycc_crypto_get_ring(void);
+void ycc_crypto_free_ring(struct ycc_ring *ring);
+int ycc_dev_rings_init(struct ycc_dev *ydev, u32 max_desc, int user_rings);
+void ycc_dev_rings_release(struct ycc_dev *ydev, int user_rings);
+#endif
-- 
1.8.3.1


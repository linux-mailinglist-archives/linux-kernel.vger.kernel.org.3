Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8E4C1FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244936AbiBWXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbiBWXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:28 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8C5A5A4;
        Wed, 23 Feb 2022 15:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645659478; x=1677195478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kdOYPCLqgFfKRajMJBjKF0jVs1Vu57J310qUgU6YFU=;
  b=L7VoxBt6+fHGr4FjmhXjNF3luOFMBPDr0fEq5PEDisHYuj+9nLp2lct2
   msVjx+aeN+T7FIKQF5Q9f8BkMKkQN6GS/jwyjUYxOLMebPhFsVFt6v9kQ
   W358zhX3t7+2mgbYskU9Pyk7j/zl+R4cTksLHYaiVvt+nN2ZZMcby/N8u
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 15:37:58 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:37:57 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 15:37:57 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 07/11] gunyah: msgq: Add Gunyah message queues
Date:   Wed, 23 Feb 2022 15:37:25 -0800
Message-ID: <20220223233729.1571114-8-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223233729.1571114-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah message queues are unidirectional pipelines to communicate
between 2 virtual machines, but are typically paired to allow
bidirectional communication. The intended use case is for small control
messages between 2 VMs, as they support a maximum of 240 bytes.

Message queues can be discovered either by resource manager or on the
devicetree. To support discovery on the devicetree, client drivers can
use gh_msgq_platform_host_attach to allocate the tx and rx message
queues according to
Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/include/asm/gunyah/hypercall.h |   4 +
 drivers/virt/gunyah/Makefile              |   2 +-
 drivers/virt/gunyah/gunyah_private.h      |   3 +
 drivers/virt/gunyah/msgq.c                | 295 ++++++++++++++++++++++
 drivers/virt/gunyah/sysfs.c               |   9 +
 include/linux/gunyah.h                    |  19 ++
 6 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/msgq.c

diff --git a/arch/arm64/include/asm/gunyah/hypercall.h b/arch/arm64/include/asm/gunyah/hypercall.h
index a8e68ece074e..7c6eb82ecd88 100644
--- a/arch/arm64/include/asm/gunyah/hypercall.h
+++ b/arch/arm64/include/asm/gunyah/hypercall.h
@@ -8,6 +8,10 @@
 #include <linux/types.h>
 
 #define GH_HYPERCALL_HYP_IDENTIFY		0x6000
+#define GH_HYPERCALL_MSGQ_SEND			0x601B
+#define GH_HYPERCALL_MSGQ_RECV			0x601C
+
+#define GH_HYPERCALL_MSGQ_SEND_FLAGS_PUSH	BIT(0)
 
 #define ___gh_count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
 
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 3869fb7371df..94dc8e738911 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-gunyah-y += sysfs.o device.o
+gunyah-y += sysfs.o device.o msgq.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
\ No newline at end of file
diff --git a/drivers/virt/gunyah/gunyah_private.h b/drivers/virt/gunyah/gunyah_private.h
index 5f3832608020..2ade32bd9bdf 100644
--- a/drivers/virt/gunyah/gunyah_private.h
+++ b/drivers/virt/gunyah/gunyah_private.h
@@ -9,4 +9,7 @@
 int __init gunyah_bus_init(void);
 void gunyah_bus_exit(void);
 
+int __init gh_msgq_init(void);
+void gh_msgq_exit(void);
+
 #endif
diff --git a/drivers/virt/gunyah/msgq.c b/drivers/virt/gunyah/msgq.c
new file mode 100644
index 000000000000..1c79b3fff30c
--- /dev/null
+++ b/drivers/virt/gunyah/msgq.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/of.h>
+
+#include "gunyah_private.h"
+
+struct gh_msgq {
+	bool ready;
+	wait_queue_head_t wq;
+	spinlock_t lock;
+};
+
+static irqreturn_t gh_msgq_irq_handler(int irq, void *dev)
+{
+	struct gh_msgq *msgq = dev;
+
+	spin_lock(&msgq->lock);
+	msgq->ready = true;
+	spin_unlock(&msgq->lock);
+	wake_up_interruptible(&msgq->wq);
+
+	return IRQ_HANDLED;
+}
+
+static int __gh_msgq_send(struct gunyah_device *ghdev, void *buff, size_t size, u64 tx_flags)
+{
+	unsigned long flags, gh_error;
+	struct gh_msgq *msgq = ghdev_get_drvdata(ghdev);
+	ssize_t ret;
+	bool ready;
+
+	spin_lock_irqsave(&msgq->lock, flags);
+	arch_gh_hypercall(GH_HYPERCALL_MSGQ_SEND, 5,
+			  ghdev->capid, size, (uintptr_t)buff, tx_flags, 0,
+			  gh_error, ready);
+	switch (gh_error) {
+	case GH_ERROR_OK:
+		ret = 0;
+		msgq->ready = ready;
+		break;
+	case GH_ERROR_MSGQUEUE_FULL:
+		ret = -EAGAIN;
+		msgq->ready = false;
+		break;
+	default:
+		ret = gh_remap_error(gh_error);
+		break;
+	}
+
+	spin_unlock_irqrestore(&msgq->lock, flags);
+
+	return ret;
+}
+
+/**
+ * gh_msgq_send() - Send a message to the client running on a different VM
+ * @client: The client descriptor that was obtained via gh_msgq_register()
+ * @buff: Pointer to the buffer where the received data must be placed
+ * @buff_size: The size of the buffer space available
+ * @flags: Optional flags to pass to receive the data. For the list of flags,
+ *         see linux/gunyah/gh_msgq.h
+ *
+ * Returns: The number of bytes copied to buff. <0 if there was an error.
+ *
+ * Note: this function may sleep and should not be called from interrupt context
+ */
+int gh_msgq_send(struct gunyah_device *ghdev, void *buff, size_t size, unsigned long flags)
+{
+	struct gh_msgq *msgq = ghdev_get_drvdata(ghdev);
+	int ret;
+	u64 tx_flags = 0;
+
+	if (flags & GH_MSGQ_TX_PUSH)
+		tx_flags |= GH_HYPERCALL_MSGQ_SEND_FLAGS_PUSH;
+
+	do {
+		ret = __gh_msgq_send(ghdev, buff, size, tx_flags);
+
+		if (ret == -EAGAIN) {
+			if (flags & GH_MSGQ_NONBLOCK)
+				goto out;
+			if (wait_event_interruptible(msgq->wq, msgq->ready))
+				ret = -ERESTARTSYS;
+		}
+	} while (ret == -EAGAIN);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_msgq_send);
+
+static ssize_t __gh_msgq_recv(struct gunyah_device *ghdev, void *buff, size_t size)
+{
+	unsigned long flags, gh_error;
+	size_t recv_size;
+	struct gh_msgq *msgq = ghdev_get_drvdata(ghdev);
+	ssize_t ret;
+	bool ready;
+
+	spin_lock_irqsave(&msgq->lock, flags);
+
+	arch_gh_hypercall(GH_HYPERCALL_MSGQ_RECV, 4,
+			  ghdev->capid, (uintptr_t)buff, size, 0,
+			  gh_error, recv_size, ready);
+	switch (gh_error) {
+	case GH_ERROR_OK:
+		ret = recv_size;
+		msgq->ready = ready;
+		break;
+	case GH_ERROR_MSGQUEUE_EMPTY:
+		ret = -EAGAIN;
+		msgq->ready = false;
+		break;
+	default:
+		ret = gh_remap_error(gh_error);
+		break;
+	}
+
+	spin_unlock_irqrestore(&msgq->lock, flags);
+
+	return ret;
+}
+
+/**
+ * gh_msgq_recv() - Receive a message from the client running on a different VM
+ * @client: The client descriptor that was obtained via gh_msgq_register()
+ * @buff: Pointer to the buffer where the received data must be placed
+ * @buff_size: The size of the buffer space available
+ * @flags: Optional flags to pass to receive the data. For the list of flags,
+ *         see linux/gunyah/gh_msgq.h
+ *
+ * Returns: The number of bytes copied to buff. <0 if there was an error.
+ *
+ * Note: this function may sleep and should not be called from interrupt context
+ */
+ssize_t gh_msgq_recv(struct gunyah_device *ghdev, void *buff, size_t size, unsigned long flags)
+{
+	struct gh_msgq *msgq = ghdev_get_drvdata(ghdev);
+	ssize_t ret;
+
+	do {
+		ret = __gh_msgq_recv(ghdev, buff, size);
+
+		if (ret == -EAGAIN) {
+			if (flags & GH_MSGQ_NONBLOCK)
+				goto out;
+			if (wait_event_interruptible(msgq->wq, msgq->ready))
+				ret = -ERESTARTSYS;
+		}
+	} while (ret == -EAGAIN);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_msgq_recv);
+
+static int gh_msgq_probe(struct gunyah_device *ghdev)
+{
+	struct gh_msgq *msgq;
+
+	msgq = devm_kzalloc(&ghdev->dev, sizeof(*msgq), GFP_KERNEL);
+	ghdev_set_drvdata(ghdev, msgq);
+
+	msgq->ready = true; /* Assume we can use the message queue right away */
+	init_waitqueue_head(&msgq->wq);
+
+	return devm_request_irq(&ghdev->dev, ghdev->irq, gh_msgq_irq_handler, 0,
+				dev_name(&ghdev->dev), msgq);
+}
+
+static struct gunyah_driver gh_msgq_tx_driver = {
+	.driver = {
+		.name = "gh_msgq_tx",
+		.owner = THIS_MODULE,
+	},
+	.type = GUNYAH_DEVICE_TYPE_MSGQ_TX,
+	.probe = gh_msgq_probe,
+};
+
+static struct gunyah_driver gh_msgq_rx_driver = {
+	.driver = {
+		.name = "gh_msgq_rx",
+		.owner = THIS_MODULE,
+	},
+	.type = GUNYAH_DEVICE_TYPE_MSGQ_RX,
+	.probe = gh_msgq_probe,
+};
+
+static struct gunyah_device *gh_msgq_platform_probe_direction(struct platform_device *pdev,
+				u8 gh_type, int idx)
+{
+	int irq, ret;
+	u64 capid;
+	struct device_node *node = pdev->dev.of_node;
+	struct gunyah_device *ghdev;
+
+	irq = platform_get_irq(pdev, idx);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, irq);
+		return ERR_PTR(irq);
+	}
+
+	ret = of_property_read_u64_index(node, "reg", idx, &capid);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
+		return ERR_PTR(ret);
+	}
+
+	ghdev = gunyah_device_alloc(&pdev->dev, capid, gh_type);
+	ghdev->irq = irq;
+	ret = gunyah_device_add(ghdev);
+	if (ret) {
+		kfree(ghdev);
+		return ERR_PTR(ret);
+	}
+
+	return ghdev;
+}
+
+int gh_msgq_platform_host_attach(struct platform_device *pdev, struct gh_msgq_platform_host *host)
+{
+	struct gunyah_device *tx_dev = NULL, *rx_dev = NULL;
+	struct device_node *node = pdev->dev.of_node;
+	int idx = 0;
+	bool duplex;
+
+	duplex = of_property_read_bool(node, "qcom,is-full-duplex");
+
+	if (duplex || of_property_read_bool(node, "qcom,is-sender")) {
+		tx_dev = gh_msgq_platform_probe_direction(pdev, GUNYAH_DEVICE_TYPE_MSGQ_TX, idx);
+		if (IS_ERR(tx_dev))
+			return PTR_ERR(tx_dev);
+		idx++;
+	}
+
+	if (duplex || of_property_read_bool(node, "qcom,is-receiver")) {
+		rx_dev = gh_msgq_platform_probe_direction(pdev, GUNYAH_DEVICE_TYPE_MSGQ_RX, idx);
+		if (IS_ERR(rx_dev)) {
+			if (!IS_ERR_OR_NULL(tx_dev))
+				gunyah_device_remove(tx_dev);
+			return PTR_ERR(rx_dev);
+		}
+	}
+
+	host->tx = tx_dev;
+	host->rx = rx_dev;
+	return 0;
+}
+
+void gh_msgq_platform_host_unattach(struct gh_msgq_platform_host *host)
+{
+	if (host->tx) {
+		gunyah_device_remove(host->tx);
+		host->tx = NULL;
+	}
+	if (host->rx) {
+		gunyah_device_remove(host->rx);
+		host->rx = NULL;
+	}
+}
+
+int __init gh_msgq_init(void)
+{
+	int ret;
+
+	ret = gunyah_register_driver(&gh_msgq_tx_driver);
+	if (ret)
+		return ret;
+
+	ret = gunyah_register_driver(&gh_msgq_rx_driver);
+	if (ret)
+		goto err_rx;
+
+	return ret;
+err_rx:
+	gunyah_unregister_driver(&gh_msgq_tx_driver);
+	return ret;
+}
+
+void gh_msgq_exit(void)
+{
+	gunyah_unregister_driver(&gh_msgq_rx_driver);
+	gunyah_unregister_driver(&gh_msgq_tx_driver);
+}
diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
index d66e6275fe32..7bf39fe1b6e6 100644
--- a/drivers/virt/gunyah/sysfs.c
+++ b/drivers/virt/gunyah/sysfs.c
@@ -59,6 +59,8 @@ static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
 		len += sysfs_emit_at(buffer, len, "cspace ");
+	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
+		len += sysfs_emit_at(buffer, len, "message-queue ");
 
 	len += sysfs_emit_at(buffer, len, "\n");
 	return len;
@@ -118,7 +120,13 @@ static int __init gunyah_init(void)
 	if (ret)
 		goto err_sysfs;
 
+	ret = gh_msgq_init();
+	if (ret)
+		goto err_bus;
+
 	return ret;
+err_bus:
+	gunyah_bus_exit();
 err_sysfs:
 	gh_sysfs_unregister();
 	return ret;
@@ -127,6 +135,7 @@ module_init(gunyah_init);
 
 static void __exit gunyah_exit(void)
 {
+	gh_msgq_exit();
 	gunyah_bus_exit();
 	gh_sysfs_unregister();
 }
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index f169c78881cb..66c1dba73cc5 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/device.h>
 #include <asm/gunyah/hypercall.h>
+#include <linux/platform_device.h>
 
 typedef u64 gh_capid_t;
 
@@ -116,4 +117,22 @@ struct gunyah_driver {
 int gunyah_register_driver(struct gunyah_driver *ghdrv);
 void gunyah_unregister_driver(struct gunyah_driver *ghdrv);
 
+#define GH_MSGQ_MAX_MSG_SIZE	1024
+
+/* Possible flags to pass for Tx or Rx */
+#define GH_MSGQ_TX_PUSH		BIT(0)
+#define GH_MSGQ_NONBLOCK	BIT(32)
+
+int gh_msgq_send(struct gunyah_device *ghdev, void *buff, size_t size, unsigned long flags);
+ssize_t gh_msgq_recv(struct gunyah_device *ghdev, void *buff, size_t size, unsigned long flags);
+
+struct gh_msgq_platform_host {
+	struct gunyah_device *tx;
+	struct gunyah_device *rx;
+};
+
+int gh_msgq_platform_host_attach(struct platform_device *pdev, struct gh_msgq_platform_host *host);
+void gh_msgq_platform_host_unattach(struct gh_msgq_platform_host *host);
+
+
 #endif
-- 
2.25.1


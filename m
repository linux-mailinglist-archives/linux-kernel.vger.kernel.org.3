Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB95756FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiGNVah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240881AbiGNVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:10 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C016EE8F;
        Thu, 14 Jul 2022 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834208; x=1689370208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5cF1gBaKxcdXRDAGz/qXwBG54F2wbachP991ux61+nQ=;
  b=s/2n/GmH/YL3OtT8co1JpJE5K7EFtr5wuogduExFHxzjwxIz9mLAOp93
   VEwFkK/hYpa8NsiKMzRS9K7FeFwA1u5UvLH+mdHea4OM13MXgJBo8nkqJ
   stroV6dEx2ZxO99DgAs92MHA+fKHohrEmOyufO2hS3G/CT29Pt34Uulmw
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:08 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:08 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:07 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 07/11] gunyah: msgq: Add Gunyah message queues
Date:   Thu, 14 Jul 2022 14:29:36 -0700
Message-ID: <20220714212940.2988436-8-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714212940.2988436-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
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
 arch/arm64/include/asm/gunyah.h      |   4 +
 drivers/virt/gunyah/Makefile         |   2 +-
 drivers/virt/gunyah/gunyah_private.h |   3 +
 drivers/virt/gunyah/msgq.c           | 223 +++++++++++++++++++++++++++
 drivers/virt/gunyah/sysfs.c          |   9 ++
 include/linux/gunyah.h               |  13 ++
 6 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/msgq.c

diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
index 3eef2a9ea299..76c26bd78338 100644
--- a/arch/arm64/include/asm/gunyah.h
+++ b/arch/arm64/include/asm/gunyah.h
@@ -27,6 +27,10 @@
 							| ((fn) & GH_CALL_FUNCTION_NUM_MASK))
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
+#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x001B)
+#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x001C)
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
index 000000000000..afc2572d3e7d
--- /dev/null
+++ b/drivers/virt/gunyah/msgq.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
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
+	wake_up_interruptible_all(&msgq->wq);
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
+ssize_t gh_msgq_send(struct gunyah_device *ghdev, void *buff, size_t size,
+		     const unsigned long flags)
+{
+	struct gh_msgq *msgq = ghdev_get_drvdata(ghdev);
+	ssize_t ret;
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
+ssize_t gh_msgq_recv(struct gunyah_device *ghdev, void *buff, size_t size,
+		     const unsigned long flags)
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
+	if (!msgq)
+		return -ENOMEM;
+	ghdev_set_drvdata(ghdev, msgq);
+
+	msgq->ready = true; /* Assume we can use the message queue right away */
+	init_waitqueue_head(&msgq->wq);
+	spin_lock_init(&msgq->lock);
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
index 220560cb3b1c..7589689e5e92 100644
--- a/drivers/virt/gunyah/sysfs.c
+++ b/drivers/virt/gunyah/sysfs.c
@@ -73,6 +73,8 @@ static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
 		len += sysfs_emit_at(buffer, len, "cspace ");
+	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
+		len += sysfs_emit_at(buffer, len, "message-queue ");
 
 	len += sysfs_emit_at(buffer, len, "\n");
 	return len;
@@ -142,7 +144,13 @@ static int __init gunyah_init(void)
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
@@ -151,6 +159,7 @@ module_init(gunyah_init);
 
 static void __exit gunyah_exit(void)
 {
+	gh_msgq_exit();
 	gunyah_bus_exit();
 	gh_sysfs_unregister();
 }
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index ce35f4491773..099224f9d6d1 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -6,6 +6,7 @@
 #ifndef _GUNYAH_H
 #define _GUNYAH_H
 
+#include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -117,4 +118,16 @@ struct gunyah_driver {
 int gunyah_register_driver(struct gunyah_driver *ghdrv);
 void gunyah_unregister_driver(struct gunyah_driver *ghdrv);
 
+#define GH_MSGQ_MAX_MSG_SIZE	1024
+
+/* Possible flags to pass for Tx or Rx */
+#define GH_MSGQ_TX_PUSH		BIT(0)
+#define GH_MSGQ_NONBLOCK	BIT(32)
+
+ssize_t gh_msgq_send(struct gunyah_device *ghdev, void *buff, size_t size,
+		     const unsigned long flags);
+ssize_t gh_msgq_recv(struct gunyah_device *ghdev, void *buff, size_t size,
+		     const unsigned long flags);
+
+
 #endif
-- 
2.25.1


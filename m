Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C912B575705
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiGNVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiGNVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F06EEA2;
        Thu, 14 Jul 2022 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834211; x=1689370211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VzZv/RLeksObiqe10i19QRwTM/pl1X0UAcpW9tKoUJA=;
  b=g7pCkPgsWPjXTNiS/BRrVKIGyjMnwpKiTGunYmPrKK0piBpR7wtuXATw
   Auj/pL8uYUO99qAEBM5V+m7/7ZR3CMQRxYSmhQNqF/6QGYTQ5dQ15SaFB
   PBB0UhEJ3b562AWxn8jdDjfZhCxQTY5XKApAmW2LOACSgyBqfsYFlyfOy
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:10 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:11 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:10 -0700
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
Subject: [PATCH v2 11/11] gunyah: Add tty console driver for RM Console Serivces
Date:   Thu, 14 Jul 2022 14:29:40 -0700
Message-ID: <20220714212940.2988436-12-quic_eberman@quicinc.com>
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

Gunyah provides a console for each VM using the VM console resource
manager APIs. This driver allows console data from other
VMs to be accessed via a TTY device and exports a console device to dump
Linux's own logs to our console.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst   |   7 +
 drivers/virt/gunyah/Kconfig           |  10 +
 drivers/virt/gunyah/Makefile          |   3 +
 drivers/virt/gunyah/rsc_mgr_console.c | 405 ++++++++++++++++++++++++++
 4 files changed, 425 insertions(+)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_console.c

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
index e7bb2b14543e..95ba9b71ab30 100644
--- a/Documentation/virt/gunyah/index.rst
+++ b/Documentation/virt/gunyah/index.rst
@@ -90,3 +90,10 @@ When booting a virtual machine which uses a devicetree, resource manager overlay
 how to communicate with resource manager, and basic description and capabilities of
 this VM. See Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml for a description
 of this node.
+
+Resource Manager Consoles
+-------------------------
+RM provides infrastructure for virtual machines to share an interactive console. This can be used to
+interact with a VM which may not have access to a serial port. Linux will register a printk console:
+ttyGH0. That console and other VM's consoles can be accessed via ttyGHX.
+/sys/class/tty/ttyGHX/vmid will print the VM which is associated with that TTY.
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 2ef4887e280d..f5a951ee2b4a 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -12,3 +12,13 @@ config GUNYAH
 
 	  Say Y here to enable the drivers needed to interact in a Gunyah
 	  virtual environment.
+
+if GUNYAH
+config GUNYAH_RESOURCE_MANAGER_CONSOLE
+	tristate "Gunyah Resource Manager Consoles"
+	depends on TTY
+	help
+	  This enables support for console output using Gunyah's Resource Manager RPC.
+	  This is normally used when a secondary VM which does not have exclusive access
+	  to a real serial device and virtio-console is unavailable.
+endif
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index b3f15c052297..001cf1630c03 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -3,3 +3,6 @@
 gunyah-y += sysfs.o device.o msgq.o
 gunyah-y += rsc_mgr.o rsc_mgr_rpc.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
+
+gunyah_console-y += rsc_mgr_console.o
+obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER_CONSOLE) += gunyah_console.o
diff --git a/drivers/virt/gunyah/rsc_mgr_console.c b/drivers/virt/gunyah/rsc_mgr_console.c
new file mode 100644
index 000000000000..eda25100314f
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_console.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_rsc_mgr_console: " fmt
+
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <linux/tty_flip.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#include <linux/kfifo.h>
+#include <linux/kref.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/of.h>
+
+/*
+ * The Linux TTY code does not support dynamic addition of tty derived devices so we need to know
+ * how many tty devices we might need when space is allocated for the tty device. Since VMs might be
+ * added/removed dynamically, we need to make sure we have enough allocated.
+ */
+#define RSC_MGR_TTY_ADAPTERS		16
+
+/* # of payload bytes that can fit in a 1-fragment CONSOLE_WRITE message */
+#define RM_CONS_WRITE_MSG_SIZE	((1 * (GH_MSGQ_MAX_MSG_SIZE - 8)) - 4)
+
+struct rm_cons_port {
+	struct tty_port port;
+	gh_vmid_t vmid;
+	bool open;
+	unsigned int index;
+
+	DECLARE_KFIFO(put_fifo, char, 1024);
+	spinlock_t fifo_lock;
+	struct work_struct put_work;
+
+	struct rm_cons_data *cons_data;
+};
+
+struct rm_cons_data {
+	struct tty_driver *tty_driver;
+	struct device *dev;
+
+	spinlock_t ports_lock;
+	struct rm_cons_port *ports[RSC_MGR_TTY_ADAPTERS];
+
+	struct notifier_block rsc_mgr_notif;
+	struct console console;
+};
+
+static void put_work_fn(struct work_struct *ws)
+{
+	char buf[RM_CONS_WRITE_MSG_SIZE];
+	int count, ret;
+	struct rm_cons_port *port = container_of(ws, struct rm_cons_port, put_work);
+
+	while (!kfifo_is_empty(&port->put_fifo)) {
+		count = kfifo_out_spinlocked(&port->put_fifo, buf, sizeof(buf), &port->fifo_lock);
+		if (count <= 0)
+			continue;
+
+		ret = gh_rm_console_write(port->vmid, buf, count);
+		if (ret) {
+			pr_warn_once("failed to send characters: %d\n", ret);
+			break;
+		}
+	}
+}
+
+static int rsc_mgr_console_notif(struct notifier_block *nb, unsigned long cmd, void *data)
+{
+	int count, i;
+	struct rm_cons_port *rm_port;
+	struct tty_port *tty_port = NULL;
+	struct rm_cons_data *cons_data = container_of(nb, struct rm_cons_data, rsc_mgr_notif);
+	const struct gh_rm_notification *notif = data;
+	struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;
+
+	if (cmd != GH_RM_NOTIF_VM_CONSOLE_CHARS ||
+		notif->size < sizeof(*msg))
+		return NOTIFY_DONE;
+
+	spin_lock(&cons_data->ports_lock);
+	for (i = 0; i < RSC_MGR_TTY_ADAPTERS; i++) {
+		if (!cons_data->ports[i])
+			continue;
+		if (cons_data->ports[i]->vmid == msg->vmid) {
+			rm_port = cons_data->ports[i];
+			break;
+		}
+	}
+	if (rm_port)
+		tty_port = tty_port_get(&rm_port->port);
+	spin_unlock(&cons_data->ports_lock);
+
+	if (!rm_port)
+		pr_warn("Received unexpected console characters for VMID %u\n", msg->vmid);
+	if (!tty_port)
+		return NOTIFY_DONE;
+
+	count = tty_buffer_request_room(tty_port, msg->num_bytes);
+	tty_insert_flip_string(tty_port, msg->bytes, count);
+	tty_flip_buffer_push(tty_port);
+
+	tty_port_put(tty_port);
+	return NOTIFY_OK;
+}
+
+static ssize_t vmid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(dev);
+
+	if (rm_port->vmid == GH_VMID_SELF)
+		return sysfs_emit(buf, "self\n");
+
+	return sysfs_emit(buf, "%u\n", rm_port->vmid);
+}
+
+static DEVICE_ATTR_RO(vmid);
+
+static struct attribute *rsc_mgr_tty_dev_attrs[] = {
+	&dev_attr_vmid.attr,
+	NULL
+};
+
+static const struct attribute_group rsc_mgr_tty_dev_attr_group = {
+	.attrs = rsc_mgr_tty_dev_attrs,
+};
+
+static const struct attribute_group *rsc_mgr_tty_dev_attr_groups[] = {
+	&rsc_mgr_tty_dev_attr_group,
+	NULL
+};
+
+static int rsc_mgr_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	int ret;
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	if (!rm_port->open) {
+		ret = gh_rm_console_open(rm_port->vmid);
+		if (ret) {
+			pr_err("Failed to open RM console for vmid %x: %d\n", rm_port->vmid, ret);
+			return ret;
+		}
+		rm_port->open = true;
+	}
+
+	return tty_port_open(&rm_port->port, tty, filp);
+}
+
+static void rsc_mgr_tty_close(struct tty_struct *tty, struct file *filp)
+{
+	int ret;
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	if (rm_port->open) {
+		if (rm_port->vmid != GH_VMID_SELF) {
+			ret = gh_rm_console_close(rm_port->vmid);
+			if (ret)
+				pr_warn("Failed to close RM console for vmid %d: %d\n",
+					rm_port->vmid, ret);
+		}
+		rm_port->open = false;
+
+		tty_port_close(&rm_port->port, tty, filp);
+	}
+
+}
+
+static int rsc_mgr_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+	int ret;
+
+	ret = kfifo_in_spinlocked(&rm_port->put_fifo, buf, count, &rm_port->fifo_lock);
+	if (ret > 0)
+		schedule_work(&rm_port->put_work);
+
+	return ret;
+}
+
+static unsigned int rsc_mgr_mgr_tty_write_room(struct tty_struct *tty)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	return kfifo_avail(&rm_port->put_fifo);
+}
+
+static void rsc_mgr_console_write(struct console *co, const char *buf, unsigned count)
+{
+	struct rm_cons_port *rm_port = co->data;
+	int ret;
+
+	ret = kfifo_in_spinlocked(&rm_port->put_fifo, buf, count, &rm_port->fifo_lock);
+	if (ret > 0)
+		schedule_work(&rm_port->put_work);
+}
+
+static struct tty_driver *rsc_mgr_console_device(struct console *co, int *index)
+{
+	struct rm_cons_port *rm_port = co->data;
+
+	*index = rm_port->index;
+	return rm_port->port.tty->driver;
+}
+
+static int rsc_mgr_console_setup(struct console *co, char *unused)
+{
+	int ret;
+	struct rm_cons_port *rm_port = co->data;
+
+	if (!rm_port->open) {
+		ret = gh_rm_console_open(rm_port->vmid);
+		if (ret) {
+			pr_err("Failed to open RM console for vmid %x: %d\n", rm_port->vmid, ret);
+			return ret;
+		}
+		rm_port->open = true;
+	}
+
+	return 0;
+}
+
+static int rsc_mgr_console_exit(struct console *co)
+{
+	int ret;
+	struct rm_cons_port *rm_port = co->data;
+
+	if (rm_port->open) {
+		ret = gh_rm_console_close(rm_port->vmid);
+		if (ret) {
+			pr_err("Failed to close RM console for vmid %x: %d\n", rm_port->vmid, ret);
+			return ret;
+		}
+		rm_port->open = false;
+	}
+
+	return 0;
+}
+
+static const struct tty_operations rsc_mgr_tty_ops = {
+	.open = rsc_mgr_tty_open,
+	.close = rsc_mgr_tty_close,
+	.write = rsc_mgr_tty_write,
+	.write_room = rsc_mgr_mgr_tty_write_room,
+};
+
+static void rsc_mgr_port_destruct(struct tty_port *port)
+{
+	struct rm_cons_port *rm_port = container_of(port, struct rm_cons_port, port);
+	struct rm_cons_data *cons_data = rm_port->cons_data;
+
+	spin_lock(&cons_data->ports_lock);
+	WARN_ON(cons_data->ports[rm_port->index] != rm_port);
+	cons_data->ports[rm_port->index] = NULL;
+	spin_unlock(&cons_data->ports_lock);
+	kfree(rm_port);
+}
+
+static const struct tty_port_operations rsc_mgr_port_ops = {
+	.destruct = rsc_mgr_port_destruct,
+};
+
+static struct rm_cons_port *rsc_mgr_port_create(struct rm_cons_data *cons_data, gh_vmid_t vmid)
+{
+	struct rm_cons_port *rm_port;
+	struct device *ttydev;
+	unsigned int index;
+	int ret;
+
+	rm_port = kzalloc(sizeof(*rm_port), GFP_KERNEL);
+	rm_port->vmid = vmid;
+	INIT_KFIFO(rm_port->put_fifo);
+	spin_lock_init(&rm_port->fifo_lock);
+	INIT_WORK(&rm_port->put_work, put_work_fn);
+	tty_port_init(&rm_port->port);
+	rm_port->port.ops = &rsc_mgr_port_ops;
+
+	spin_lock(&cons_data->ports_lock);
+	for (index = 0; index < RSC_MGR_TTY_ADAPTERS; index++) {
+		if (!cons_data->ports[index]) {
+			cons_data->ports[index] = rm_port;
+			rm_port->index = index;
+			break;
+		}
+	}
+	spin_unlock(&cons_data->ports_lock);
+	if (index >= RSC_MGR_TTY_ADAPTERS) {
+		ret = -ENOSPC;
+		goto err_put_port;
+	}
+
+	ttydev = tty_port_register_device_attr(&rm_port->port, cons_data->tty_driver, index,
+					      cons_data->dev, rm_port, rsc_mgr_tty_dev_attr_groups);
+	if (IS_ERR(ttydev)) {
+		ret = PTR_ERR(ttydev);
+		goto err_put_port;
+	}
+
+	return rm_port;
+err_put_port:
+	tty_port_put(&rm_port->port);
+	return ERR_PTR(ret);
+}
+
+static int rsc_mgr_console_probe(struct auxiliary_device *auxdev,
+	const struct auxiliary_device_id *aux_dev_id)
+{
+	struct rm_cons_data *cons_data;
+	struct rm_cons_port *rm_port;
+	int ret;
+	gh_vmid_t vmid;
+
+	cons_data = devm_kzalloc(&auxdev->dev, sizeof(*cons_data), GFP_KERNEL);
+	if (!cons_data)
+		return -ENOMEM;
+	dev_set_drvdata(&auxdev->dev, cons_data);
+	cons_data->dev = &auxdev->dev;
+
+	cons_data->tty_driver = tty_alloc_driver(RSC_MGR_TTY_ADAPTERS,
+						 TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(cons_data->tty_driver))
+		return PTR_ERR(cons_data->tty_driver);
+
+	cons_data->tty_driver->driver_name = "gh";
+	cons_data->tty_driver->name = "ttyGH";
+	cons_data->tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	cons_data->tty_driver->init_termios = tty_std_termios;
+	tty_set_operations(cons_data->tty_driver, &rsc_mgr_tty_ops);
+
+	ret = tty_register_driver(cons_data->tty_driver);
+	if (ret) {
+		dev_err(&auxdev->dev, "Could not register tty driver: %d\n", ret);
+		goto err_put_tty;
+	}
+
+	spin_lock_init(&cons_data->ports_lock);
+
+	cons_data->rsc_mgr_notif.notifier_call = rsc_mgr_console_notif;
+	ret = gh_rm_register_notifier(&cons_data->rsc_mgr_notif);
+	if (ret) {
+		dev_err(&auxdev->dev, "Could not register for resource manager notifications: %d\n",
+			ret);
+		goto err_put_tty;
+	}
+
+	rm_port = rsc_mgr_port_create(cons_data, GH_VMID_SELF);
+	if (IS_ERR(rm_port)) {
+		ret = PTR_ERR(rm_port);
+		dev_err(&auxdev->dev, "Could not create own console: %d\n", ret);
+		goto err_unreg_notif;
+	}
+
+	strncpy(cons_data->console.name, "ttyGH", sizeof(cons_data->console.name));
+	cons_data->console.write = rsc_mgr_console_write;
+	cons_data->console.device = rsc_mgr_console_device;
+	cons_data->console.setup = rsc_mgr_console_setup;
+	cons_data->console.exit = rsc_mgr_console_exit;
+	cons_data->console.index = rm_port->index;
+	cons_data->console.data = rm_port;
+	register_console(&cons_data->console);
+
+	ret = gh_rm_get_vmid(&vmid);
+	if (!ret)
+		rsc_mgr_port_create(cons_data, vmid);
+	else
+		pr_warn("Failed to get this VM's VMID: %d. Not creating loop-back console\n", ret);
+
+	return 0;
+err_unreg_notif:
+	gh_rm_unregister_notifier(&cons_data->rsc_mgr_notif);
+err_put_tty:
+	tty_driver_kref_put(cons_data->tty_driver);
+	return ret;
+}
+
+static void rsc_mgr_console_remove(struct auxiliary_device *auxdev)
+{
+	struct rm_cons_data *cons_data = dev_get_drvdata(&auxdev->dev);
+
+	unregister_console(&cons_data->console);
+	gh_rm_unregister_notifier(&cons_data->rsc_mgr_notif);
+	tty_driver_kref_put(cons_data->tty_driver);
+}
+
+static struct auxiliary_device_id rsc_mgr_console_ids[] = {
+	{ .name = "gunyah.console" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, rsc_mgr_console_ids);
+
+static struct auxiliary_driver rsc_mgr_console_drv = {
+	.probe = rsc_mgr_console_probe,
+	.remove = rsc_mgr_console_remove,
+	.id_table = rsc_mgr_console_ids,
+};
+module_auxiliary_driver(rsc_mgr_console_drv);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Console");
-- 
2.25.1


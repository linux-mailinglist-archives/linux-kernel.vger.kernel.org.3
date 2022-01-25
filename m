Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A26049A889
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319310AbiAYDI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:21854 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3420112AbiAYCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643077367; x=1674613367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=11FmUmyzPRvu6bhE6JIWPjo4Wz9Uq4PL7hSZ1Xwymco=;
  b=I4tSLrlh2puHzVAB+zgmDRSTXZk8kNkrQugwCR1no+vh3g/vJrCI2Ckg
   n4rBA6vKkZxzGPUTGaHcx3msFaa9HtjYvgaZwtJhQ0ZG45D2zy5PlV6Oj
   xZEEgcwUHdzSPiddVAhMqAIY+cYLhjxiAE9adG1Mu8seaJa2OeTRUnB6r
   gt6QrF3+8gI6MklDTBYiosF7kGRtDgZk6CPea//RIa/ZKrNzdinVWaQv8
   0qCI8x234CgcEPuPi0aYlx89CRjPGILO8MCnDFanv5/cGzu5ty7t5OEom
   i7jWD1Nzsk1ajv18yaYoBZ+8V71UDaNJ6l2nG8Rv0LhgxXF3Zrw26MGua
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226168161"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="226168161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:13:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="617443663"
Received: from kerguder-mobl.ger.corp.intel.com (HELO localhost) ([10.249.158.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:13:03 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jason M Bills <jason.m.bills@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v6 04/13] peci: Add core infrastructure
Date:   Tue, 25 Jan 2022 02:10:55 +0100
Message-Id: <20220125011104.2480133-5-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125011104.2480133-1-iwona.winiarska@intel.com>
References: <20220125011104.2480133-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel processors provide access for various services designed to support
processor and DRAM thermal management, platform manageability and
processor interface tuning and diagnostics.
Those services are available via the Platform Environment Control
Interface (PECI) that provides a communication channel between the
processor and the Baseboard Management Controller (BMC) or other
platform management device.

This change introduces PECI subsystem by adding the initial core module
and API for controller drivers.

Co-developed-by: Jason M Bills <jason.m.bills@linux.intel.com>
Signed-off-by: Jason M Bills <jason.m.bills@linux.intel.com>
Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 MAINTAINERS             |   8 ++
 drivers/Kconfig         |   3 +
 drivers/Makefile        |   1 +
 drivers/peci/Kconfig    |  15 ++++
 drivers/peci/Makefile   |   5 ++
 drivers/peci/core.c     | 158 ++++++++++++++++++++++++++++++++++++++++
 drivers/peci/internal.h |  16 ++++
 include/linux/peci.h    |  99 +++++++++++++++++++++++++
 8 files changed, 305 insertions(+)
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/core.c
 create mode 100644 drivers/peci/internal.h
 create mode 100644 include/linux/peci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..aa7ae643fdb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15091,6 +15091,14 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/peaq-wmi.c
 
+PECI SUBSYSTEM
+M:	Iwona Winiarska <iwona.winiarska@intel.com>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/peci/
+F:	drivers/peci/
+F:	include/linux/peci.h
+
 PENSANDO ETHERNET DRIVERS
 M:	Shannon Nelson <snelson@pensando.io>
 M:	drivers@pensando.io
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0d399ddaa185..8d6cd5d08722 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -236,4 +236,7 @@ source "drivers/interconnect/Kconfig"
 source "drivers/counter/Kconfig"
 
 source "drivers/most/Kconfig"
+
+source "drivers/peci/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index a110338c860c..020780b6b4d2 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -187,3 +187,4 @@ obj-$(CONFIG_GNSS)		+= gnss/
 obj-$(CONFIG_INTERCONNECT)	+= interconnect/
 obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
+obj-$(CONFIG_PECI)		+= peci/
diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
new file mode 100644
index 000000000000..71a4ad81225a
--- /dev/null
+++ b/drivers/peci/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menuconfig PECI
+	tristate "PECI support"
+	help
+	  The Platform Environment Control Interface (PECI) is an interface
+	  that provides a communication channel to Intel processors and
+	  chipset components from external monitoring or control devices.
+
+	  If you are building a Baseboard Management Controller (BMC) kernel
+	  for Intel platform say Y here and also to the specific driver for
+	  your adapter(s) below. If unsure say N.
+
+	  This support is also available as a module. If so, the module
+	  will be called peci.
diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
new file mode 100644
index 000000000000..e789a354e842
--- /dev/null
+++ b/drivers/peci/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Core functionality
+peci-y := core.o
+obj-$(CONFIG_PECI) += peci.o
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
new file mode 100644
index 000000000000..73ad0a47fa9d
--- /dev/null
+++ b/drivers/peci/core.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2018-2021 Intel Corporation
+
+#include <linux/bug.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/peci.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+static DEFINE_IDA(peci_controller_ida);
+
+static void peci_controller_dev_release(struct device *dev)
+{
+	struct peci_controller *controller = to_peci_controller(dev);
+
+	mutex_destroy(&controller->bus_lock);
+	ida_free(&peci_controller_ida, controller->id);
+	kfree(controller);
+}
+
+struct device_type peci_controller_type = {
+	.release	= peci_controller_dev_release,
+};
+
+static struct peci_controller *peci_controller_alloc(struct device *dev,
+						     struct peci_controller_ops *ops)
+{
+	struct peci_controller *controller;
+	int ret;
+
+	if (!ops->xfer)
+		return ERR_PTR(-EINVAL);
+
+	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
+	if (!controller)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ida_alloc_max(&peci_controller_ida, U8_MAX, GFP_KERNEL);
+	if (ret < 0)
+		goto err;
+	controller->id = ret;
+
+	controller->ops = ops;
+
+	controller->dev.parent = dev;
+	controller->dev.bus = &peci_bus_type;
+	controller->dev.type = &peci_controller_type;
+
+	device_initialize(&controller->dev);
+
+	mutex_init(&controller->bus_lock);
+
+	return controller;
+
+err:
+	kfree(controller);
+	return ERR_PTR(ret);
+}
+
+static void unregister_controller(void *_controller)
+{
+	struct peci_controller *controller = _controller;
+
+	device_unregister(&controller->dev);
+
+	fwnode_handle_put(controller->dev.fwnode);
+
+	pm_runtime_disable(&controller->dev);
+}
+
+/**
+ * devm_peci_controller_add() - add PECI controller
+ * @dev: device for devm operations
+ * @ops: pointer to controller specific methods
+ *
+ * In final stage of its probe(), peci_controller driver calls
+ * devm_peci_controller_add() to register itself with the PECI bus.
+ *
+ * Return: Pointer to the newly allocated controller or ERR_PTR() in case of failure.
+ */
+struct peci_controller *devm_peci_controller_add(struct device *dev,
+						 struct peci_controller_ops *ops)
+{
+	struct peci_controller *controller;
+	int ret;
+
+	controller = peci_controller_alloc(dev, ops);
+	if (IS_ERR(controller))
+		return controller;
+
+	ret = dev_set_name(&controller->dev, "peci-%d", controller->id);
+	if (ret)
+		goto err_put;
+
+	pm_runtime_no_callbacks(&controller->dev);
+	pm_suspend_ignore_children(&controller->dev, true);
+	pm_runtime_enable(&controller->dev);
+
+	device_set_node(&controller->dev, fwnode_handle_get(dev_fwnode(dev)));
+
+	ret = device_add(&controller->dev);
+	if (ret)
+		goto err_fwnode;
+
+	ret = devm_add_action_or_reset(dev, unregister_controller, controller);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return controller;
+
+err_fwnode:
+	fwnode_handle_put(controller->dev.fwnode);
+
+	pm_runtime_disable(&controller->dev);
+
+err_put:
+	put_device(&controller->dev);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_NS_GPL(devm_peci_controller_add, PECI);
+
+struct bus_type peci_bus_type = {
+	.name		= "peci",
+};
+
+static int __init peci_init(void)
+{
+	int ret;
+
+	ret = bus_register(&peci_bus_type);
+	if (ret < 0) {
+		pr_err("peci: failed to register PECI bus type!\n");
+		return ret;
+	}
+
+	return 0;
+}
+module_init(peci_init);
+
+static void __exit peci_exit(void)
+{
+	bus_unregister(&peci_bus_type);
+}
+module_exit(peci_exit);
+
+MODULE_AUTHOR("Jason M Bills <jason.m.bills@linux.intel.com>");
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_AUTHOR("Iwona Winiarska <iwona.winiarska@intel.com>");
+MODULE_DESCRIPTION("PECI bus core module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
new file mode 100644
index 000000000000..918dea745a86
--- /dev/null
+++ b/drivers/peci/internal.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2018-2021 Intel Corporation */
+
+#ifndef __PECI_INTERNAL_H
+#define __PECI_INTERNAL_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+struct peci_controller;
+
+extern struct bus_type peci_bus_type;
+
+extern struct device_type peci_controller_type;
+
+#endif /* __PECI_INTERNAL_H */
diff --git a/include/linux/peci.h b/include/linux/peci.h
new file mode 100644
index 000000000000..26e0a4e73b50
--- /dev/null
+++ b/include/linux/peci.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2018-2021 Intel Corporation */
+
+#ifndef __LINUX_PECI_H
+#define __LINUX_PECI_H
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+/*
+ * Currently we don't support any PECI command over 32 bytes.
+ */
+#define PECI_REQUEST_MAX_BUF_SIZE 32
+
+struct peci_controller;
+struct peci_request;
+
+/**
+ * struct peci_controller_ops - PECI controller specific methods
+ * @xfer: PECI transfer function
+ *
+ * PECI controllers may have different hardware interfaces - the drivers
+ * implementing PECI controllers can use this structure to abstract away those
+ * differences by exposing a common interface for PECI core.
+ */
+struct peci_controller_ops {
+	int (*xfer)(struct peci_controller *controller, u8 addr, struct peci_request *req);
+};
+
+/**
+ * struct peci_controller - PECI controller
+ * @dev: device object to register PECI controller to the device model
+ * @ops: pointer to device specific controller operations
+ * @bus_lock: lock used to protect multiple callers
+ * @id: PECI controller ID
+ *
+ * PECI controllers usually connect to their drivers using non-PECI bus,
+ * such as the platform bus.
+ * Each PECI controller can communicate with one or more PECI devices.
+ */
+struct peci_controller {
+	struct device dev;
+	struct peci_controller_ops *ops;
+	struct mutex bus_lock; /* held for the duration of xfer */
+	u8 id;
+};
+
+struct peci_controller *devm_peci_controller_add(struct device *parent,
+						 struct peci_controller_ops *ops);
+
+static inline struct peci_controller *to_peci_controller(void *d)
+{
+	return container_of(d, struct peci_controller, dev);
+}
+
+/**
+ * struct peci_device - PECI device
+ * @dev: device object to register PECI device to the device model
+ * @controller: manages the bus segment hosting this PECI device
+ * @addr: address used on the PECI bus connected to the parent controller
+ *
+ * A peci_device identifies a single device (i.e. CPU) connected to a PECI bus.
+ * The behaviour exposed to the rest of the system is defined by the PECI driver
+ * managing the device.
+ */
+struct peci_device {
+	struct device dev;
+	u8 addr;
+};
+
+static inline struct peci_device *to_peci_device(struct device *d)
+{
+	return container_of(d, struct peci_device, dev);
+}
+
+/**
+ * struct peci_request - PECI request
+ * @device: PECI device to which the request is sent
+ * @tx: TX buffer specific data
+ * @tx.buf: TX buffer
+ * @tx.len: transfer data length in bytes
+ * @rx: RX buffer specific data
+ * @rx.buf: RX buffer
+ * @rx.len: received data length in bytes
+ *
+ * A peci_request represents a request issued by PECI originator (TX) and
+ * a response received from PECI responder (RX).
+ */
+struct peci_request {
+	struct peci_device *device;
+	struct {
+		u8 buf[PECI_REQUEST_MAX_BUF_SIZE];
+		u8 len;
+	} rx, tx;
+};
+
+#endif /* __LINUX_PECI_H */
-- 
2.31.1


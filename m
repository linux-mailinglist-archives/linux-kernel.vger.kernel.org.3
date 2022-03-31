Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1790B4EDAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiCaNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiCaNvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:51:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E61265AF;
        Thu, 31 Mar 2022 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648734584; x=1680270584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DyFxmCqIU/Oiz/h/BQvLdkumAnffMA/mxV0wwMBOt+I=;
  b=NbfbgF69LCV6b7VEi2V897jHll5ZfUnwW3Vm5VS4uql6gOOUrDUo97hd
   GNwMu5bO+mj2fZDHs0xMzAFLIe5qPC6WbSJrWPlRojC8HXyCNToYk/oMa
   XFioVYg5i93jaw8ZmkxlPgQXf4YXXbQdH3VwlsKclvmtIg9KzPUwMOxfW
   P0olI6StHe6Y3LbAPNaW2SAlty2vz1uo4eR7zUItWIzWVzSgrmCaH+jUD
   pucVvo1UXzIlSSe+s/rS1wqTo0PFqmAznPFD8LWh4QNIJC+Hg7N+cySl/
   T+NpxDBzhXbYKAyPtI5bRXVOResIwCaILPZ6w3dUYr+wLZZfaDlme32fb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259820605"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259820605"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="520543355"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga002.jf.intel.com with ESMTP; 31 Mar 2022 06:49:41 -0700
From:   niravkumar.l.rabara@intel.com
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add Altera hardware mutex driver
Date:   Fri,  1 Apr 2022 05:49:11 +0800
Message-Id: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Altera hardware mutex soft IP provides hardware assistance for
synchronization and mutual exclusion between processors in
asymmetric/symmetric multiprocessing (AMP/SMP) system or
multi processes/threads in uniprocessor system.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 .../bindings/misc/altera-hwmutex.yaml         |  47 +++
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/altera_hwmutex.c                 | 321 ++++++++++++++++++
 include/linux/altera_hwmutex.h                |  42 +++
 5 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/altera-hwmutex.yaml
 create mode 100644 drivers/misc/altera_hwmutex.c
 create mode 100644 include/linux/altera_hwmutex.h

diff --git a/Documentation/devicetree/bindings/misc/altera-hwmutex.yaml b/Documentation/devicetree/bindings/misc/altera-hwmutex.yaml
new file mode 100644
index 000000000000..57a9ea19c563
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/altera-hwmutex.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/altera-hwmutex.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera hardware mutex
+
+maintainers:
+  - Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
+
+description:
+  Altera hardware mutex can provide hardware assistance for synchronization
+  and mutual exclusion between processors in asymmetric/symmetric multiprocessing
+  (AMP/SMP) system or multi processes/threads in uniprocessor system.
+
+properties:
+  compatible:
+    enum:
+      - altr,hwmutex-1.0
+      - client-1.0
+
+  reg:
+    items:
+      - description: physical address of hw mutex and length of memory mapped
+         region
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    mutex0: mutex0@100 {
+        compatible = "altr,hwmutex-1.0";
+        reg = <0x100 0x8>;
+    };
+
+
+   #Example of mutex's client node that includes mutex phandle    
+   #mclient0: mclient0@200 {
+   #     compatible = "client-1.0";
+   # 	reg = <0x200 0x10>;
+   #	mutex = <&mutex0>;
+   # };
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..707acf740c6f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -435,6 +435,12 @@ config DW_XDATA_PCIE
 
 	  If unsure, say N.
 
+config ALTERA_HWMUTEX
+       tristate "Altera Hardware Mutex"
+       help
+         This option enables device driver support for Altera Hardware Mutex.
+         Say Y here if you want to use the Altera hardware mutex support.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197af544..6fcbbd36b3cf 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
 obj-y				+= ti-st/
 obj-y				+= lis3lv02d/
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
+obj-$(CONFIG_ALTERA_HWMUTEX)   += altera_hwmutex.o
 obj-$(CONFIG_INTEL_MEI)		+= mei/
 obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
diff --git a/drivers/misc/altera_hwmutex.c b/drivers/misc/altera_hwmutex.c
new file mode 100644
index 000000000000..45f98e4b13d0
--- /dev/null
+++ b/drivers/misc/altera_hwmutex.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Intel Corporation (C) 2022. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/altera_hwmutex.h>
+
+#define DRV_NAME	"altera_hwmutex"
+
+
+static DEFINE_SPINLOCK(list_lock);	/* protect mutex_list */
+static LIST_HEAD(mutex_list);
+
+/* Mutex Registers */
+#define MUTEX_REG			0x0
+
+#define MUTEX_REG_VALUE_MASK		0xFFFF
+#define MUTEX_REG_OWNER_OFFSET		16
+#define MUTEX_REG_OWNER_MASK		0xFFFF
+#define MUTEX_GET_OWNER(reg)			\
+	((reg >> MUTEX_REG_OWNER_OFFSET) & MUTEX_REG_OWNER_MASK)
+
+/**
+ *	altera_mutex_request - Retrieves a pointer to an acquired mutex device
+ *			       structure
+ *	@mutex_np:	The pointer to mutex device node
+ *
+ *	Returns a pointer to the mutex device structure associated with the
+ *	supplied device node, or NULL if no corresponding mutex device was
+ *	found.
+ */
+struct altera_mutex *altera_mutex_request(struct device_node *mutex_np)
+{
+	struct altera_mutex *mutex;
+
+	spin_lock(&list_lock);
+	list_for_each_entry(mutex, &mutex_list, list) {
+		if (mutex_np == mutex->pdev->dev.of_node) {
+			if (!mutex->requested) {
+				mutex->requested = true;
+				spin_unlock(&list_lock);
+				return mutex;
+			} else {
+				pr_info("Mutex device is in use.\n");
+				spin_unlock(&list_lock);
+				return NULL;
+			}
+		}
+	}
+	spin_unlock(&list_lock);
+	pr_info("Mutex device not found!\n");
+	return NULL;
+}
+EXPORT_SYMBOL(altera_mutex_request);
+
+/**
+ *	altera_mutex_free - Free the mutex
+ *	@mutex:	the mutex
+ *
+ *	Return 0 if success. Otherwise, returns non-zero.
+ */
+int altera_mutex_free(struct altera_mutex *mutex)
+{
+	if (!mutex || !mutex->requested)
+		return -EINVAL;
+
+	spin_lock(&list_lock);
+	mutex->requested = false;
+	spin_unlock(&list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(altera_mutex_free);
+
+static int __mutex_trylock(struct altera_mutex *mutex, u16 owner, u16 value)
+{
+	u32 read;
+	int ret = 0;
+	u32 data = (owner << MUTEX_REG_OWNER_OFFSET) | value;
+
+	mutex_lock(&mutex->lock);
+	__raw_writel(data, mutex->regs + MUTEX_REG);
+	read = __raw_readl(mutex->regs + MUTEX_REG);
+	if (read != data)
+		ret = -1;
+
+	mutex_unlock(&mutex->lock);
+	return ret;
+}
+
+/**
+ *	altera_mutex_lock - Acquires a hardware mutex, wait until it can get it.
+ *	@mutex:	the mutex to be acquired
+ *	@owner:	owner ID
+ *	@value:	the new non-zero value to write to mutex
+ *
+ *	Returns 0 if mutex was successfully locked. Otherwise, returns non-zero.
+ *
+ *	The mutex must later on be released by the same owner that acquired it.
+ *	This function is not ISR callable.
+ */
+int altera_mutex_lock(struct altera_mutex *mutex, u16 owner, u16 value)
+{
+	if (!mutex || !mutex->requested)
+		return -EINVAL;
+
+	while (__mutex_trylock(mutex, owner, value) != 0)
+		;
+
+	return 0;
+}
+EXPORT_SYMBOL(altera_mutex_lock);
+
+/**
+ *	altera_mutex_trylock - Tries once to lock the hardware mutex and returns
+ *				immediately
+ *	@mutex:	the mutex to be acquired
+ *	@owner:	owner ID
+ *	@value:	the new non-zero value to write to mutex
+ *
+ *	Returns 0 if mutex was successfully locked. Otherwise, returns non-zero.
+ *
+ *	The mutex must later on be released by the same owner that acquired it.
+ *	This function is not ISR callable.
+ */
+int altera_mutex_trylock(struct altera_mutex *mutex, u16 owner, u16 value)
+{
+	if (!mutex || !mutex->requested)
+		return -EINVAL;
+
+	return __mutex_trylock(mutex, owner, value);
+}
+EXPORT_SYMBOL(altera_mutex_trylock);
+
+/**
+ *	altera_mutex_unlock - Unlock a mutex that has been locked by this owner
+ *			      previously that was locked on the
+ *			      altera_mutex_lock. Upon release, the value stored
+ *			      in the mutex is set to zero.
+ *	@mutex:	the mutex to be released
+ *	@owner:	Owner ID
+ *
+ *	Returns 0 if mutex was successfully unlocked. Otherwise, returns
+ *	non-zero.
+ *
+ *	This function is not ISR callable.
+ */
+int altera_mutex_unlock(struct altera_mutex *mutex, u16 owner)
+{
+	u32 reg;
+
+	if (!mutex || !mutex->requested)
+		return -EINVAL;
+
+	mutex_lock(&mutex->lock);
+
+	__raw_writel(owner << MUTEX_REG_OWNER_OFFSET,
+		mutex->regs + MUTEX_REG);
+
+	reg = __raw_readl(mutex->regs + MUTEX_REG);
+	if (reg & MUTEX_REG_VALUE_MASK) {
+		/* Unlock failed */
+		dev_dbg(&mutex->pdev->dev,
+			"Unlock mutex failed, owner %d and expected owner %d\n",
+			owner, MUTEX_GET_OWNER(reg));
+		mutex_unlock(&mutex->lock);
+		return -EINVAL;
+	}
+
+	mutex_unlock(&mutex->lock);
+	return 0;
+}
+EXPORT_SYMBOL(altera_mutex_unlock);
+
+/**
+ *	altera_mutex_owned - Determines if this owner owns the mutex
+ *	@mutex:	the mutex to be queried
+ *	@owner:	Owner ID
+ *
+ *	Returns 1 if the owner owns the mutex. Otherwise, returns zero.
+ */
+int altera_mutex_owned(struct altera_mutex *mutex, u16 owner)
+{
+	u32 reg;
+	u16 actual_owner;
+	int ret = 0;
+
+	if (!mutex || !mutex->requested)
+		return ret;
+
+	mutex_lock(&mutex->lock);
+	reg = __raw_readl(mutex->regs + MUTEX_REG);
+	actual_owner = MUTEX_GET_OWNER(reg);
+	if (actual_owner == owner)
+		ret = 1;
+
+	mutex_unlock(&mutex->lock);
+	return ret;
+}
+EXPORT_SYMBOL(altera_mutex_owned);
+
+/**
+ *	altera_mutex_is_locked - Determines if the mutex is locked
+ *	@mutex:	the mutex to be queried
+ *
+ *	Returns 1 if the mutex is locked, 0 if unlocked.
+ */
+int altera_mutex_is_locked(struct altera_mutex *mutex)
+{
+	u32 reg;
+	int ret = 0;
+
+	if (!mutex || !mutex->requested)
+		return ret;
+
+	mutex_lock(&mutex->lock);
+	reg = __raw_readl(mutex->regs + MUTEX_REG);
+	reg &= MUTEX_REG_VALUE_MASK;
+	if (reg)
+		ret = 1;
+
+	mutex_unlock(&mutex->lock);
+	return ret;
+}
+EXPORT_SYMBOL(altera_mutex_is_locked);
+
+static int altera_mutex_probe(struct platform_device *pdev)
+{
+	struct altera_mutex *mutex;
+	struct resource	*regs;
+
+	mutex = devm_kzalloc(&pdev->dev, sizeof(struct altera_mutex),
+		GFP_KERNEL);
+	if (!mutex)
+		return -ENOMEM;
+
+	mutex->pdev = pdev;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
+	mutex->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mutex->regs))
+		return PTR_ERR(mutex->regs);
+
+	mutex_init(&mutex->lock);
+
+	spin_lock(&list_lock);
+	list_add_tail(&mutex->list, &mutex_list);
+	spin_unlock(&list_lock);
+
+	platform_set_drvdata(pdev, mutex);
+
+	return 0;
+}
+
+static int altera_mutex_remove(struct platform_device *pdev)
+{
+	struct altera_mutex *mutex = platform_get_drvdata(pdev);
+
+	spin_lock(&list_lock);
+	if (mutex)
+		list_del(&mutex->list);
+	spin_unlock(&list_lock);
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id altera_mutex_match[] = {
+	{ .compatible = "altr,hwmutex-1.0" },
+	{ /* Sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, altera_mutex_match);
+
+static struct platform_driver altera_mutex_platform_driver = {
+	.driver = {
+		.name		= DRV_NAME,
+		.of_match_table	= altera_mutex_match,
+	},
+	.remove			= altera_mutex_remove,
+};
+
+static int __init altera_mutex_init(void)
+{
+	return platform_driver_probe(&altera_mutex_platform_driver,
+		altera_mutex_probe);
+}
+
+static void __exit altera_mutex_exit(void)
+{
+	platform_driver_unregister(&altera_mutex_platform_driver);
+}
+
+module_init(altera_mutex_init);
+module_exit(altera_mutex_exit);
+
+MODULE_AUTHOR("Niravkumar L Rabara <niravkumar.l.rabara@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Altera Hardware Mutex driver");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/altera_hwmutex.h b/include/linux/altera_hwmutex.h
new file mode 100644
index 000000000000..18b73e9120bc
--- /dev/null
+++ b/include/linux/altera_hwmutex.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0 
+/*
+ * Copyright Intel Corporation (C) 2022. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _ALTERA_MUTEX_H
+#define _ALTERA_MUTEX_H
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+struct altera_mutex {
+	struct list_head	list;
+	struct platform_device	*pdev;
+	struct mutex		lock;
+	void __iomem		*regs;
+	bool			requested;
+};
+
+extern struct altera_mutex *altera_mutex_request(struct device_node *mutex_np);
+extern int altera_mutex_free(struct altera_mutex *mutex);
+
+extern int altera_mutex_lock(struct altera_mutex *mutex, u16 owner, u16 value);
+
+extern int altera_mutex_trylock(struct altera_mutex *mutex, u16 owner,
+	u16 value);
+extern int altera_mutex_unlock(struct altera_mutex *mutex, u16 owner);
+extern int altera_mutex_owned(struct altera_mutex *mutex, u16 owner);
+extern int altera_mutex_is_locked(struct altera_mutex *mutex);
+
+#endif /* _ALTERA_MUTEX_H */
-- 
2.25.1


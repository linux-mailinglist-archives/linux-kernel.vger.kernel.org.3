Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70453B8F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiFBMXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiFBMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:23:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1F3D4AB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654172621; x=1685708621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LbQKkwWjNMyx1YCwztGcSUZqOd/jlvdWF2Ool4ymR68=;
  b=Eu45xRTfLHKo9U9TXHz4EN64KkQqtLy8Q3JfQlEoVzB6GiukFZoeSCLC
   j/PeGtzwJlzET0Zf94Q3OwfLoy1bdnPjdDo0/k6h3V7cbFnIYr73Rr62X
   9QqADYtxXFYKZbxY1eI1hZzEHuO+YVvsgEzS9scwraFQbKwj1c7psKIaU
   cMlIRvK4bwSH8r6orLprYVzbSuk5toxRYMQgd4m5zD3FJECRMMoMY3zad
   ojrP5XnBeVvz+aUlEsXbJA8aaS2ocDWEOWtEhgmB3l2k2qqsuzh9YdG1y
   8CYA8ghhq/h6tM5rs+eIpElAJa/zvJhjiVQgZLvXvrlupvAUqkBgDS04z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275939717"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275939717"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="530554407"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 05:23:26 -0700
From:   kah.jing.lee@intel.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to drivers
Date:   Thu,  2 Jun 2022 20:22:13 +0800
Message-Id: <20220602122212.3021232-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Add sysid driver. The Altera(Intel) Sysid component is generally part of an
FPGA design. The component can be hotplugged when the FPGA is reconfigured.
This patch fixes the driver to support the component being hotplugged.

Usage:
  cat /sys/bus/platform/devices/soc:base_fpga_region/
		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/id
  cat /sys/bus/platform/devices/soc:base_fpga_region/
		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/timestamp

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/misc/Kconfig       |   9 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/intel_sysid.c | 142 +++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/misc/intel_sysid.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..a31489cc092c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,15 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config INTEL_SYSID
+	tristate "Intel System ID"
+	help
+	  This enables Intel System ID soft core driver.
+	  Say Y here if you want to build a driver for Intel System ID driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called intel_sysid. If unsure, say N here.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 70e800e9127f..301c854b4cd3 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
 obj-y				+= ti-st/
 obj-y				+= lis3lv02d/
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
+obj-$(CONFIG_INTEL_SYSID)	+= intel_sysid.o
 obj-$(CONFIG_INTEL_MEI)		+= mei/
 obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
diff --git a/drivers/misc/intel_sysid.c b/drivers/misc/intel_sysid.c
new file mode 100644
index 000000000000..f9ba0ee97c3a
--- /dev/null
+++ b/drivers/misc/intel_sysid.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Intel Corporation (C) 2022.
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
+ *
+ * Credit:
+ * Walter Goossens
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#define DRV_NAME	"intel_sysid"
+
+struct intel_sysid {
+	void __iomem		*regs;
+};
+
+/* System ID Registers*/
+#define SYSID_REG_ID		(0x0)
+#define SYSID_REG_TIMESTAMP	(0x4)
+
+static ssize_t id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_sysid *sysid = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", readl(sysid->regs + SYSID_REG_ID));
+}
+
+static ssize_t timestamp_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	unsigned int reg;
+	struct tm timestamp;
+	struct intel_sysid *sysid = dev_get_drvdata(dev);
+
+	reg = readl(sysid->regs + SYSID_REG_TIMESTAMP);
+
+	time64_to_tm(reg, 0, &timestamp);
+
+	return sprintf(buf, "%u (%u-%u-%u %u:%u:%u UTC)\n", reg,
+		(unsigned int)(timestamp.tm_year + 1900),
+		timestamp.tm_mon + 1, timestamp.tm_mday, timestamp.tm_hour,
+		timestamp.tm_min, timestamp.tm_sec);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(timestamp);
+
+static struct attribute *intel_sysid_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_timestamp.attr,
+	NULL,
+};
+
+struct attribute_group intel_sysid_attr_group = {
+	.name = "sysid",
+	.attrs = intel_sysid_attrs,
+};
+
+static int intel_sysid_probe(struct platform_device *pdev)
+{
+	struct intel_sysid *sysid;
+	struct resource	*regs;
+
+	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
+		GFP_KERNEL);
+	if (!sysid)
+		return -ENOMEM;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
+	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(sysid->regs))
+		return PTR_ERR(sysid->regs);
+
+	platform_set_drvdata(pdev, sysid);
+
+	return sysfs_create_group(&pdev->dev.kobj, &intel_sysid_attr_group);
+}
+
+static int intel_sysid_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &intel_sysid_attr_group);
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id intel_sysid_match[] = {
+	{ .compatible = "intel,socfpga-sysid-1.0" },
+	{ /* Sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, intel_sysid_match);
+
+static struct platform_driver intel_sysid_platform_driver = {
+	.driver = {
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(intel_sysid_match),
+	},
+	.probe			= intel_sysid_probe,
+	.remove			= intel_sysid_remove,
+};
+
+static int __init intel_sysid_init(void)
+{
+	return platform_driver_register(&intel_sysid_platform_driver);
+}
+
+static void __exit intel_sysid_exit(void)
+{
+	platform_driver_unregister(&intel_sysid_platform_driver);
+}
+
+module_init(intel_sysid_init);
+module_exit(intel_sysid_exit);
+
+MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Altera System ID driver");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1


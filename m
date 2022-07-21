Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C557CAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiGUMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGUMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:32:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7F743C3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658406732; x=1689942732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmv0IWJld+qqpIiD2c41BQkOFDDXirYpdTr9umch9LM=;
  b=CDQkMXyxkBS+hiyaj+OEzH0l2E8593Ay73PPR8wmNLiwep7NJn8IZomB
   6CNwtS4N52N2QdH5jmwrDIgIsbrtvo1RPDWOFl/a51QS6912i9BlAyKfM
   JEnV8zn0AumgAwOcxYVRSQ9s29bS2bGn1kd+0c5Y52nQMXKK6yjUkoR2V
   rDHshTtTpBibxUgji8uhLqSFF6eO7/3SbCvtxhK9E9b86reexxAB2c/1w
   ofga7vn8v46CpKXTbrhNcbhQEsxLFQ/ILDstJEmcYFdmBYr3nd8W8wkVg
   gXWh1Tahhduf7O8EGvhutEG9FWKZEq1/5F9AiqhHWJtQYvfgTfwvAsYA+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273878665"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="273878665"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 05:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="573720542"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 05:32:08 -0700
From:   kah.jing.lee@intel.com
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Zhou@vger.kernel.org, Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch to drivers
Date:   Thu, 21 Jul 2022 20:31:50 +0800
Message-Id: <20220721123149.416618-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721123017.416438-1-kah.jing.lee@intel.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Add new sysid driver. The Altera(Intel) Sysid component is generally part
of an FPGA design. The component can be hotplugged when the FPGA is
reconfigured. This driver support the component being hotplugged.
The sysid driver stores unique 32-bit id value which is similar to a
check-sum value; different components, different configuration options,
or both, can be configured to produce different id values. Timestamp field
is the unique 32-bit value that is based on the system generation time.

There are two basic ways to use the system ID core:
- Verify the system ID before downloading new software to a system. This
method can be used by software development tools, before downloading a
program to a target hardware system, if the program is compiled for
different hardware.

- Check system ID after reset. If a program is running on hardware other
than the expected Platform Designer system, the program may fail to
function altogether. If the program does not crash, it can behave
erroneously in subtle ways that are difficult to debug. To protect against
this case, a program can compare the expected system ID against the system
ID core, and report an error if they do not match.

Usage:
  cat /sys/bus/platform/devices/soc:base_fpga_region/
		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/id
  cat /sys/bus/platform/devices/soc:base_fpga_region/
		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/buildtime

Based on an initial contribution from Ley Foon Tan at Altera
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
Reviewed-by: Zhou, Furong <furong.zhou@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2:
- Updated license header, commit message and author since original author
no longer here
- Updated driver description
- Removed redundant word in Kconfig
- Updated timestamp function, renamed timestamp -> buildtime due to programmed
  time during design generation instead of real-time timestamp reading
- Updated Kconfig description
- Updated sysfs add to devm_add_group
- Add the Documentation/ABI/testing file
- Updated header and newline formatting
---
---
 drivers/misc/Kconfig       |   9 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/intel_sysid.c | 114 +++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/misc/intel_sysid.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..30cf36916593 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,15 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config INTEL_SYSID
+	tristate "Intel System ID"
+	help
+	  This enables the Intel System ID driver for a soft core.
+	  Say Y here if you want to build a driver for Intel System ID.
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
index 000000000000..b63dbde63347
--- /dev/null
+++ b/drivers/misc/intel_sysid.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Intel Corporation.
+ * Copyright (C) 2013-2015, Altera Corporation.
+ *
+ * Ley Foon Tan <lftan@altera.com>
+ * Kah Jing Lee <kah.jing.lee@intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME	"intel_sysid"
+
+struct intel_sysid {
+	void __iomem		*regs;
+};
+
+/* System ID Registers*/
+#define SYSID_REG_ID		0x0
+#define SYSID_REG_TIMESTAMP	0x4
+
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct intel_sysid *sysid = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", readl(sysid->regs + SYSID_REG_ID));
+}
+
+static void convert_readable_timestamp(struct tm *buildtime)
+{
+	buildtime->tm_year += 1900;
+	buildtime->tm_mon += 1;
+}
+
+static ssize_t buildtime_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int reg;
+	struct tm buildtime;
+	struct intel_sysid *sysid = dev_get_drvdata(dev);
+
+	reg = readl(sysid->regs + SYSID_REG_TIMESTAMP);
+	time64_to_tm(reg, 0, &buildtime);
+	convert_readable_timestamp(&buildtime);
+
+	return sprintf(buf, "%u (%u-%u-%u %u:%u:%u UTC)\n", reg,
+		(unsigned int)(buildtime.tm_year),
+		buildtime.tm_mon, buildtime.tm_mday, buildtime.tm_hour,
+		buildtime.tm_min, buildtime.tm_sec);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(buildtime);
+
+static struct attribute *intel_sysid_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_buildtime.attr,
+	NULL
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
+	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
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
+		.of_match_table	= of_match_ptr(intel_sysid_match),
+	},
+	.probe			= intel_sysid_probe,
+};
+
+module_platform_driver(intel_sysid_platform_driver);
+
+MODULE_AUTHOR("Kah Jing Lee <kah.jing.lee@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel System ID driver");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1


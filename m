Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AC8475A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhLON5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:57:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:59291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243074AbhLON5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639576667; x=1671112667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eh7CAbVXLVypiB1YOJmzkE9xCX50jJgMHX3vPsaNhSM=;
  b=n1mED8XnsA9xq43gSTXsM4HD2OffBUDZgsc3JlciGqnHYOJ2aEG2vRgj
   0ZNwrA3To7SiELkNGkRN/DY9CMnMXHmaqD19Fh73zwxPDWmRfD0HxUGb3
   AAOimDkaDRtlyDMIOZzk38wHI+pYR95cOIm1xPhVMzDevXud5s52O3hhD
   h4BDC5uD03nxdSIs99Sj+FHWIK7ooaIeayBzz4ylNsNN8dnOik2D+qf79
   bFHPtEnOlKuKFMl0MU9EUkBrPVWvIA3IBtqjJ3p5okXR/2XaASH8b6l6l
   616NP3Ed0lCkpDeO1aZgUr/CnbJWkaXirytSQykeXxtYj6zpCKYniDHWC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="263380425"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="263380425"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682502762"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:43 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mei: add gsc driver
Date:   Wed, 15 Dec 2021 15:56:19 +0200
Message-Id: <20211215135622.1060229-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215135622.1060229-1-alexander.usyskin@intel.com>
References: <20211215135622.1060229-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

GSC is a graphics system controller, based on CSE, it provides
a chassis controller for graphics discrete cards, as well as it
supports media protection (HDCP 2.2) on selected devices.

mei_gsc binds to a platform devices exposed by Intel discrete
driver i915 via MFD framework.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/Kconfig  |  12 +++
 drivers/misc/mei/Makefile |   3 +
 drivers/misc/mei/gsc-me.c | 214 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hw-me.c  |  27 ++++-
 drivers/misc/mei/hw-me.h  |   2 +
 5 files changed, 256 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/mei/gsc-me.c

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 0e0bcd0da852..712d72e25138 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -49,3 +49,15 @@ config INTEL_MEI_TXE
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 
+config INTEL_MEI_GSC
+	tristate "Intel MEI GSC embedded device"
+	select INTEL_MEI
+	select INTEL_MEI_ME
+	depends on X86 && PCI
+	depends on DRM_I915
+	help
+	  Intel platform driver for MEI devices embedded in a graphics device.
+
+	  MEI device can be embedded in a standalone Intel graphics devices,
+	  to support range of security tasks.
+	  Currently supported device is DG1.
diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index d8e5165917f2..fb740d754900 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -18,6 +18,9 @@ obj-$(CONFIG_INTEL_MEI_ME) += mei-me.o
 mei-me-objs := pci-me.o
 mei-me-objs += hw-me.o
 
+obj-$(CONFIG_INTEL_MEI_GSC) += mei-gsc.o
+mei-gsc-objs := gsc-me.o
+
 obj-$(CONFIG_INTEL_MEI_TXE) += mei-txe.o
 mei-txe-objs := pci-txe.o
 mei-txe-objs += hw-txe.o
diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
new file mode 100644
index 000000000000..901d6e0ce6cd
--- /dev/null
+++ b/drivers/misc/mei/gsc-me.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2019-2020, Intel Corporation. All rights reserved.
+ *
+ * Intel Management Engine Interface (Intel MEI) Linux driver
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/irqreturn.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+
+#include "mei_dev.h"
+#include "hw-me.h"
+#include "hw-me-regs.h"
+
+#include "mei-trace.h"
+
+#define MEI_GSC_RPM_TIMEOUT 500
+
+static int mei_gsc_read_hfs(const struct mei_device *dev, int where, u32 *val)
+{
+	struct mei_me_hw *hw = to_me_hw(dev);
+
+	*val = ioread32(hw->mem_addr + where + 0xC00);
+
+	return 0;
+}
+
+static int mei_gsc_probe(struct platform_device *platdev)
+{
+	struct mei_device *dev;
+	struct mei_me_hw *hw;
+	struct resource *bar;
+	struct device *device;
+	const struct platform_device_id *ent;
+	const struct mei_cfg *cfg;
+	int ret;
+
+	ent = platform_get_device_id(platdev);
+	cfg = mei_me_get_cfg(ent->driver_data);
+	if (!cfg)
+		return -ENODEV;
+
+	device = &platdev->dev;
+
+	dev = mei_me_dev_init(device, cfg);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto err;
+	}
+
+	bar = platform_get_resource(platdev, IORESOURCE_MEM, 0);
+
+	hw = to_me_hw(dev);
+	hw->mem_addr = devm_ioremap_resource(device, bar);
+	if (IS_ERR(hw->mem_addr)) {
+		dev_err(device, "mmio not mapped\n");
+		ret = PTR_ERR(hw->mem_addr);
+		goto err;
+	}
+
+	hw->irq = platform_get_irq(platdev, 0);
+	if (hw->irq < 0) {
+		ret = hw->irq;
+		goto err;
+	}
+	hw->read_fws = mei_gsc_read_hfs;
+
+	platform_set_drvdata(platdev, dev);
+
+	ret = devm_request_threaded_irq(device, hw->irq,
+					mei_me_irq_quick_handler,
+					mei_me_irq_thread_handler,
+					IRQF_ONESHOT, KBUILD_MODNAME, dev);
+	if (ret) {
+		dev_err(device, "irq register failed %d\n", ret);
+		goto err;
+	}
+
+	pm_runtime_get_noresume(device);
+	pm_runtime_set_active(device);
+	pm_runtime_enable(device);
+
+	if (mei_start(dev)) {
+		dev_err(device, "init hw failure.\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(device);
+
+	ret = mei_register(dev, device);
+	if (ret)
+		goto register_err;
+
+	pm_runtime_put_noidle(device);
+	return 0;
+
+register_err:
+	mei_stop(dev);
+
+err:
+	dev_err(device, "probe failed: %d\n", ret);
+	platform_set_drvdata(platdev, NULL);
+	return ret;
+}
+
+static int mei_gsc_remove(struct platform_device *platdev)
+{
+	struct mei_device *dev;
+
+	dev = platform_get_drvdata(platdev);
+	if (!dev)
+		return -ENODEV;
+
+	mei_stop(dev);
+
+	mei_deregister(dev);
+
+	pm_runtime_disable(&platdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
+{
+	struct mei_device *dev;
+
+	dev_dbg(device, "suspend\n");
+
+	dev = dev_get_drvdata(device);
+	if (!dev)
+		return -ENODEV;
+
+	mei_stop(dev);
+
+	mei_disable_interrupts(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mei_gsc_pm_resume(struct device *device)
+{
+	struct mei_device *dev;
+	int err;
+
+	dev_dbg(device, "resume\n");
+
+	dev = dev_get_drvdata(device);
+	if (!dev)
+		return -ENODEV;
+
+	err = mei_restart(dev);
+	if (err)
+		return err;
+
+	/* Start timer if stopped in suspend */
+	schedule_delayed_work(&dev->timer_work, HZ);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(mei_gsc_pm_ops, mei_gsc_pm_suspend, mei_gsc_pm_resume);
+
+static const struct platform_device_id gsc_devtypes[] = {
+	{
+		.name = "mei-gsc",
+		.driver_data = MEI_ME_GSC_CFG,
+	},
+	{
+		.name = "mei-gscfi",
+		.driver_data = MEI_ME_GSCFI_CFG,
+	},
+	{
+		/* sentinel */
+	}
+};
+
+static struct platform_driver mei_gsc_driver = {
+	.probe	= mei_gsc_probe,
+	.remove = mei_gsc_remove,
+	.driver = {
+		.name = "mei-gsc",
+		.pm = &mei_gsc_pm_ops,
+	},
+	.id_table = gsc_devtypes,
+};
+
+static int __init mei_gsc_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mei_gsc_driver);
+
+	return ret;
+}
+module_init(mei_gsc_init);
+
+static void __exit mei_gsc_exit(void)
+{
+	platform_driver_unregister(&mei_gsc_driver);
+}
+module_exit(mei_gsc_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_ALIAS("platform:mei-gsc");
+MODULE_ALIAS("platform:mei-gscfi");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index d3a6c0728645..9748d14849a1 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1226,6 +1226,7 @@ irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id)
 	me_intr_disable(dev, hcsr);
 	return IRQ_WAKE_THREAD;
 }
+EXPORT_SYMBOL_GPL(mei_me_irq_quick_handler);
 
 /**
  * mei_me_irq_thread_handler - function called after ISR to handle the interrupt
@@ -1320,6 +1321,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	mutex_unlock(&dev->device_lock);
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
 
 static const struct mei_hw_ops mei_me_hw_ops = {
 
@@ -1433,6 +1435,12 @@ static bool mei_me_fw_type_sps(const struct pci_dev *pdev)
 #define MEI_CFG_KIND_ITOUCH                     \
 	.kind = "itouch"
 
+#define MEI_CFG_TYPE_GSC                        \
+	.kind = "gsc"
+
+#define MEI_CFG_TYPE_GSCFI                      \
+	.kind = "gscfi"
+
 #define MEI_CFG_FW_SPS                          \
 	.quirk_probe = mei_me_fw_type_sps
 
@@ -1565,6 +1573,18 @@ static const struct mei_cfg mei_me_pch15_sps_cfg = {
 	MEI_CFG_FW_SPS,
 };
 
+/* Graphics System Controller */
+static const struct mei_cfg mei_me_gsc_cfg = {
+	MEI_CFG_TYPE_GSC,
+	MEI_CFG_PCH8_HFS,
+};
+
+/* Graphics System Controller Firmware Interface */
+static const struct mei_cfg mei_me_gscfi_cfg = {
+	MEI_CFG_TYPE_GSCFI,
+	MEI_CFG_PCH8_HFS,
+};
+
 /*
  * mei_cfg_list - A list of platform platform specific configurations.
  * Note: has to be synchronized with  enum mei_cfg_idx.
@@ -1585,6 +1605,8 @@ static const struct mei_cfg *const mei_cfg_list[] = {
 	[MEI_ME_PCH12_SPS_ITOUCH_CFG] = &mei_me_pch12_itouch_sps_cfg,
 	[MEI_ME_PCH15_CFG] = &mei_me_pch15_cfg,
 	[MEI_ME_PCH15_SPS_CFG] = &mei_me_pch15_sps_cfg,
+	[MEI_ME_GSC_CFG] = &mei_me_gsc_cfg,
+	[MEI_ME_GSCFI_CFG] = &mei_me_gscfi_cfg,
 };
 
 const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
@@ -1595,7 +1617,8 @@ const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
 		return NULL;
 
 	return mei_cfg_list[idx];
-};
+}
+EXPORT_SYMBOL_GPL(mei_me_get_cfg);
 
 /**
  * mei_me_dev_init - allocates and initializes the mei device structure
@@ -1630,4 +1653,4 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 
 	return dev;
 }
-
+EXPORT_SYMBOL_GPL(mei_me_dev_init);
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 00a7132ac7a2..a071c645e905 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -112,6 +112,8 @@ enum mei_cfg_idx {
 	MEI_ME_PCH12_SPS_ITOUCH_CFG,
 	MEI_ME_PCH15_CFG,
 	MEI_ME_PCH15_SPS_CFG,
+	MEI_ME_GSC_CFG,
+	MEI_ME_GSCFI_CFG,
 	MEI_ME_NUM_CFG,
 };
 
-- 
2.32.0


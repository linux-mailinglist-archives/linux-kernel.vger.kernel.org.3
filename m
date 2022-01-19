Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E44493DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356056AbiASP6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:58:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:38643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355867AbiASP6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642607921; x=1674143921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytqx2FiKfUDsRwRr167NuSryNIRu3KFOX8AzrZKhn5k=;
  b=dG/lbAdnfs5K1qLgQRYjUgxWrrwibQZU0Cnwgn4N0GMWzKuNU5Hn4d7C
   oOhZbRwu/Hhws7NEPswpgo+pfjRHo2xz0NxF65ggCOxBz41jfZh7bdUYA
   WbIOFg51JVE68lneUdyahLx2LwGpguuj90myI/ryTI0L1IBAhvLgFFtkT
   EvJ5mNx+AoaYccYp0nGuBk9hFvSrQKyNCBSJczuRlUGJ/z2NiO5BAfFQg
   BX0+NikMR7F3/YgXP1zjylW3SP36A/UUiianBA7sSCpf/WznQr/hoe17m
   T5/Qo0DlgxnDLEYiUZv8474HfE8BHohqol2MBIqgESuHvQsJ3MgCClWWN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308436391"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="308436391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:58:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="477420150"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:58:38 -0800
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
Subject: [PATCH v2 2/5] mei: add support for graphics system controller (gsc) devices
Date:   Wed, 19 Jan 2022 17:58:04 +0200
Message-Id: <20220119155807.222657-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119155807.222657-1-alexander.usyskin@intel.com>
References: <20220119155807.222657-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

GSC is a graphics system controller, based on CSE, it provides
a chassis controller for graphics discrete cards, as well as it
supports media protection on selected devices.

mei_gsc binds to a auxiliary devices exposed by Intel discrete
driver i915.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/Kconfig  |  14 +++
 drivers/misc/mei/Makefile |   3 +
 drivers/misc/mei/gsc-me.c | 192 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hw-me.c  |  27 +++++-
 drivers/misc/mei/hw-me.h  |   2 +
 5 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/mei/gsc-me.c

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 0e0bcd0da852..ec119bb98251 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -46,6 +46,20 @@ config INTEL_MEI_TXE
 	  Supported SoCs:
 	  Intel Bay Trail
 
+config INTEL_MEI_GSC
+	tristate "Intel MEI GSC embedded device"
+	select INTEL_MEI
+	select INTEL_MEI_ME
+	depends on X86 && PCI
+	depends on DRM_I915
+	help
+	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
+
+	  An MEI device here called GSC can be embedded in an
+	  Intel graphics devices, to support a range of chassis
+	  tasks such as graphics card firmware update and security
+	  tasks.
+
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 
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
index 000000000000..8673ad5f0015
--- /dev/null
+++ b/drivers/misc/mei/gsc-me.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
+ *
+ * Intel Management Engine Interface (Intel MEI) Linux driver
+ */
+
+#include <linux/module.h>
+#include <linux/mei_aux.h>
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
+static int mei_gsc_probe(struct auxiliary_device *aux_dev,
+			 const struct auxiliary_device_id *aux_dev_id)
+{
+	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+	struct mei_device *dev;
+	struct mei_me_hw *hw;
+	struct device *device;
+	const struct mei_cfg *cfg;
+	int ret;
+
+	cfg = mei_me_get_cfg(aux_dev_id->driver_data);
+	if (!cfg)
+		return -ENODEV;
+
+	device = &aux_dev->dev;
+
+	dev = mei_me_dev_init(device, cfg);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto err;
+	}
+
+	hw = to_me_hw(dev);
+	hw->mem_addr = devm_ioremap_resource(device, &adev->bar);
+	if (IS_ERR(hw->mem_addr)) {
+		dev_err(device, "mmio not mapped\n");
+		ret = PTR_ERR(hw->mem_addr);
+		goto err;
+	}
+
+	hw->irq = adev->irq;
+	hw->read_fws = mei_gsc_read_hfs;
+
+	dev_set_drvdata(&aux_dev->dev, dev);
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
+	dev_set_drvdata(&aux_dev->dev, NULL);
+	return ret;
+}
+
+static void mei_gsc_remove(struct auxiliary_device *aux_dev)
+{
+	struct mei_device *dev;
+
+	dev = dev_get_drvdata(&aux_dev->dev);
+	if (!dev)
+		return;
+
+	mei_stop(dev);
+
+	mei_deregister(dev);
+
+	pm_runtime_disable(&aux_dev->dev);
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
+static const struct auxiliary_device_id mei_gsc_id_table[] = {
+	{
+		.name = "i915.mei-gsc",
+		.driver_data = MEI_ME_GSC_CFG,
+
+	},
+	{
+		.name = "i915.mei-gscfi",
+		.driver_data = MEI_ME_GSCFI_CFG,
+	},
+	{
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(auxiliary, mei_gsc_id_table);
+
+static struct auxiliary_driver mei_gsc_driver = {
+	.probe	= mei_gsc_probe,
+	.remove = mei_gsc_remove,
+	.driver = {
+		/* auxiliary_driver_register() sets .name to be the modname */
+		.pm = &mei_gsc_pm_ops,
+	},
+	.id_table = mei_gsc_id_table
+};
+module_auxiliary_driver(mei_gsc_driver);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_ALIAS("auxiliary:i915.mei-gsc");
+MODULE_ALIAS("auxiliary:i915.mei-gscfi");
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


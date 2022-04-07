Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407AF4F7FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbiDGNB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbiDGNB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:01:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E624817DCB0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336366; x=1680872366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7SudjqeZZVQCjbanffD3VlgVDgmzgqVlkINc+gOQ80=;
  b=MdD+gJvEf46KG5AF5MmCr83a4ejwA7eG0+p+ffkpRJQakHAFnZRkfTuP
   Zt3qI1I8Vk44jpNJoMjXzZc/VPU0Gsbp65KK7fuPZgpMgTKZrdxyaZITk
   wJpRO0sb1M8Jum+6dFMlMZ+JJMoC5259ffguFnPjius6FT366f4vRct+i
   qd78ltQgSgb4QJYLR520Fa9LzV43JZvhnsAx+r9tn40vZJXG8iKH3Ew9Q
   m5Ll4pfwFt3+wXu3PiysxryHCYt6pza2IFC1zGzjPV3tmREMnFxIdTzOm
   75NqgzAPxJm0EhMpc8UBMNKhhhMfk2nDNHMtFpPK3VLu6vhrNYK+Hn0my
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="241907434"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="241907434"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:59:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571040782"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:59:22 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH 02/20] mei: add support for graphics system controller (gsc) devices
Date:   Thu,  7 Apr 2022 15:58:21 +0300
Message-Id: <20220407125839.1479249-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407125839.1479249-1-alexander.usyskin@intel.com>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/misc/mei/Kconfig  |  14 +++
 drivers/misc/mei/Makefile |   3 +
 drivers/misc/mei/gsc-me.c | 194 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hw-me.c  |  27 +++++-
 drivers/misc/mei/hw-me.h  |   2 +
 5 files changed, 238 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/mei/gsc-me.c

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 0e0bcd0da852..d21486d69df2 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -46,6 +46,20 @@ config INTEL_MEI_TXE
 	  Supported SoCs:
 	  Intel Bay Trail
 
+config INTEL_MEI_GSC
+	tristate "Intel MEI GSC embedded device"
+	depends on INTEL_MEI
+	depends on INTEL_MEI_ME
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
index 000000000000..64b02adf3149
--- /dev/null
+++ b/drivers/misc/mei/gsc-me.c
@@ -0,0 +1,194 @@
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
+	dev_set_drvdata(device, dev);
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
+		goto irq_err;
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
+irq_err:
+	devm_free_irq(device, hw->irq, dev);
+
+err:
+	dev_err(device, "probe failed: %d\n", ret);
+	dev_set_drvdata(device, NULL);
+	return ret;
+}
+
+static void mei_gsc_remove(struct auxiliary_device *aux_dev)
+{
+	struct mei_device *dev;
+	struct mei_me_hw *hw;
+
+	dev = dev_get_drvdata(&aux_dev->dev);
+	if (!dev)
+		return;
+
+	hw = to_me_hw(dev);
+
+	mei_stop(dev);
+
+	mei_deregister(dev);
+
+	pm_runtime_disable(&aux_dev->dev);
+
+	mei_disable_interrupts(dev);
+	devm_free_irq(&aux_dev->dev, hw->irq, dev);
+}
+
+static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+
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
+	struct mei_device *dev = dev_get_drvdata(device);
+	int err;
+
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
index 719fee9af156..03945d3b34da 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1226,6 +1226,7 @@ irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id)
 	me_intr_disable(dev, hcsr);
 	return IRQ_WAKE_THREAD;
 }
+EXPORT_SYMBOL_GPL(mei_me_irq_quick_handler);
 
 /**
  * mei_me_irq_thread_handler - function called after ISR to handle the interrupt
@@ -1326,6 +1327,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	mutex_unlock(&dev->device_lock);
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
 
 static const struct mei_hw_ops mei_me_hw_ops = {
 
@@ -1440,6 +1442,12 @@ static bool mei_me_fw_type_sps_ign(const struct pci_dev *pdev)
 #define MEI_CFG_KIND_ITOUCH                     \
 	.kind = "itouch"
 
+#define MEI_CFG_TYPE_GSC                        \
+	.kind = "gsc"
+
+#define MEI_CFG_TYPE_GSCFI                      \
+	.kind = "gscfi"
+
 #define MEI_CFG_FW_SPS_IGN                      \
 	.quirk_probe = mei_me_fw_type_sps_ign
 
@@ -1572,6 +1580,18 @@ static const struct mei_cfg mei_me_pch15_sps_cfg = {
 	MEI_CFG_FW_SPS_IGN,
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
@@ -1592,6 +1612,8 @@ static const struct mei_cfg *const mei_cfg_list[] = {
 	[MEI_ME_PCH12_SPS_ITOUCH_CFG] = &mei_me_pch12_itouch_sps_cfg,
 	[MEI_ME_PCH15_CFG] = &mei_me_pch15_cfg,
 	[MEI_ME_PCH15_SPS_CFG] = &mei_me_pch15_sps_cfg,
+	[MEI_ME_GSC_CFG] = &mei_me_gsc_cfg,
+	[MEI_ME_GSCFI_CFG] = &mei_me_gscfi_cfg,
 };
 
 const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
@@ -1602,7 +1624,8 @@ const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
 		return NULL;
 
 	return mei_cfg_list[idx];
-};
+}
+EXPORT_SYMBOL_GPL(mei_me_get_cfg);
 
 /**
  * mei_me_dev_init - allocates and initializes the mei device structure
@@ -1637,4 +1660,4 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 
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


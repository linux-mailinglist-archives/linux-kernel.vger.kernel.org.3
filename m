Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831234A8270
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350080AbiBCKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:36:10 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:12391 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349904AbiBCKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643884569; x=1675420569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FEEhydjwLkeg56qaP3Jp1tS7LNZzWOSYdJUAWTv6yC0=;
  b=E/uUma/bYu20jbb30xB18zLUFGriD5p2m2CSbj6E+ef9ZdlCFpipu2bZ
   e2eO/OvJlGS5DNTkDOPnwoU+1z9mt/mjPBnbk50VUxzbU0ntoR15ux7Ak
   LbAabtSih1/S2vluxn7rRo4egcCLxrryEGFhZZmwr2HUf8SBCq/Qn7rFY
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 02:36:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:36:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:35:52 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:35:48 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V5 3/6] usb: common: eud: Add driver support for Embedded USB Debugger(EUD)
Date:   Thu, 3 Feb 2022 16:04:32 +0530
Message-ID: <8dab5fd0df59e057793ac0f2264be31f561b07c3.1643880577.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1643880577.git.quic_schowdhu@quicinc.com>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for control peripheral of EUD (Embedded USB Debugger) to
listen to events such as USB attach/detach, pet EUD to indicate software
is functional.Reusing the platform device kobj, sysfs entry 'enable' is
created to enable or disable EUD.

To enable the eud the following needs to be done
echo 1 > /sys/bus/platform/.../enable

To disable eud, following is the command
echo 0 > /sys/bus/platform/.../enable

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/sysfs-driver-eud |   9 ++
 drivers/usb/common/Kconfig                 |  10 ++
 drivers/usb/common/Makefile                |   1 +
 drivers/usb/common/qcom_eud.c              | 251 +++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
 create mode 100644 drivers/usb/common/qcom_eud.c

diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
new file mode 100644
index 0000000..83f3872
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-eud
@@ -0,0 +1,9 @@
+What:		/sys/bus/platform/drivers/eud/.../enable
+Date:           February 2022
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		The Enable/Disable sysfs interface for Embedded
+		USB Debugger(EUD). This enables and disables the
+		EUD based on a 1 or a 0 value. By enabling EUD,
+		the user is able to activate the mini-usb hub of
+		EUD for debug and trace capabilities.
diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
index b856622..e4f8b48 100644
--- a/drivers/usb/common/Kconfig
+++ b/drivers/usb/common/Kconfig
@@ -14,6 +14,16 @@ config USB_LED_TRIG
 	  LEDs and you want to use them as activity indicators for USB host or
 	  gadget.

+config USB_QCOM_EUD
+	tristate "QCOM Embedded USB Debugger(EUD) Driver"
+	select USB_ROLE_SWITCH
+	help
+	  This module enables support for Qualcomm Technologies, Inc.
+	  Embedded USB Debugger (EUD). The EUD is a control peripheral
+	  which reports VBUS attach/detach events and has USB-based
+	  debug and trace capabilities. On selecting m, the module name
+	  that is built is qcom_eud.ko
+
 config USB_ULPI_BUS
 	tristate "USB ULPI PHY interface support"
 	select USB_COMMON
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 8ac4d21..597e48e 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -10,4 +10,5 @@ usb-common-$(CONFIG_USB_LED_TRIG) += led.o

 obj-$(CONFIG_USB_CONN_GPIO)	+= usb-conn-gpio.o
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
+obj-$(CONFIG_USB_QCOM_EUD) += qcom_eud.o
 obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
diff --git a/drivers/usb/common/qcom_eud.c b/drivers/usb/common/qcom_eud.c
new file mode 100644
index 0000000..84a9884
--- /dev/null
+++ b/drivers/usb/common/qcom_eud.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/usb/role.h>
+
+#define EUD_REG_INT1_EN_MASK	0x0024
+#define EUD_REG_INT_STATUS_1	0x0044
+#define EUD_REG_CTL_OUT_1	0x0074
+#define EUD_REG_VBUS_INT_CLR	0x0080
+#define EUD_REG_CSR_EUD_EN	0x1014
+#define EUD_REG_SW_ATTACH_DET	0x1018
+#define EUD_REG_EUD_EN2        0x0000
+
+#define EUD_ENABLE		BIT(0)
+#define EUD_INT_PET_EUD	BIT(0)
+#define EUD_INT_VBUS		BIT(2)
+#define EUD_INT_SAFE_MODE	BIT(4)
+#define EUD_INT_ALL		(EUD_INT_VBUS|EUD_INT_SAFE_MODE)
+
+struct eud_chip {
+	struct device			*dev;
+	struct usb_role_switch		*role_sw;
+	void __iomem			*base;
+	void __iomem			*mode_mgr;
+	unsigned int			int_status;
+	int				irq;
+	bool				enabled;
+	bool				usb_attached;
+};
+
+static int enable_eud(struct eud_chip *priv)
+{
+	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
+	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
+			priv->base + EUD_REG_INT1_EN_MASK);
+	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
+}
+
+static void disable_eud(struct eud_chip *priv)
+{
+	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
+	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+}
+
+static ssize_t enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct eud_chip *chip = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", chip->enabled);
+}
+
+static ssize_t enable_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct eud_chip *chip = dev_get_drvdata(dev);
+	bool enable;
+	int ret;
+
+	if (kstrtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable) {
+		ret = enable_eud(chip);
+		if (!ret)
+			chip->enabled = enable;
+		else
+			disable_eud(chip);
+	} else {
+		disable_eud(chip);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(enable);
+
+static struct attribute *eud_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(eud);
+
+static void usb_attach_detach(struct eud_chip *chip)
+{
+	u32 reg;
+
+	/* read ctl_out_1[4] to find USB attach or detach event */
+	reg = readl(chip->base + EUD_REG_CTL_OUT_1);
+	chip->usb_attached = reg & EUD_INT_SAFE_MODE;
+}
+
+static void pet_eud(struct eud_chip *chip)
+{
+	u32 reg;
+	int ret;
+
+	/* When the EUD_INT_PET_EUD in SW_ATTACH_DET is set, the cable has been
+	 * disconnected and we need to detach the pet to check if EUD is in safe
+	 * mode before attaching again.
+	 */
+	reg = readl(chip->base + EUD_REG_SW_ATTACH_DET);
+	if (reg & EUD_INT_PET_EUD) {
+		/* Detach & Attach pet for EUD */
+		writel(0, chip->base + EUD_REG_SW_ATTACH_DET);
+		/* Delay to make sure detach pet is done before attach pet */
+		ret = readl_poll_timeout(chip->base + EUD_REG_SW_ATTACH_DET,
+					reg, (reg == 0), 1, 100);
+		if (ret) {
+			dev_err(chip->dev, "Detach pet failed\n");
+			return;
+		}
+	}
+	/* Attach pet for EUD */
+	writel(EUD_INT_PET_EUD, chip->base +EUD_REG_SW_ATTACH_DET);
+}
+
+static irqreturn_t handle_eud_irq(int irq, void *data)
+{
+	struct eud_chip *chip = data;
+	u32 reg;
+
+	reg = readl(chip->base + EUD_REG_INT_STATUS_1);
+	switch (reg & EUD_INT_ALL) {
+	case EUD_INT_VBUS:
+		usb_attach_detach(chip);
+		return IRQ_WAKE_THREAD;
+	case EUD_INT_SAFE_MODE:
+		pet_eud(chip);
+		return IRQ_HANDLED;
+	default:
+		return IRQ_NONE;
+	}
+}
+
+static irqreturn_t handle_eud_irq_thread(int irq, void *data)
+{
+	struct eud_chip *chip = data;
+	int ret;
+
+	if (chip->usb_attached)
+		ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_DEVICE);
+	else
+		ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_HOST);
+	if (ret)
+		dev_err(chip->dev, "failed to set role switch\n");
+
+	/* set and clear vbus_int_clr[0] to clear interrupt */
+	writel(BIT(0), chip->base + EUD_REG_VBUS_INT_CLR);
+	writel(0, chip->base + EUD_REG_VBUS_INT_CLR);
+
+	return IRQ_HANDLED;
+}
+
+static void eud_role_switch_release(void *data)
+{
+	struct eud_chip *chip = data;
+
+	usb_role_switch_put(chip->role_sw);
+}
+
+static int eud_probe(struct platform_device *pdev)
+{
+	struct eud_chip *chip;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &pdev->dev;
+
+	ret = devm_add_action_or_reset(chip->dev, eud_role_switch_release, chip);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				"failed to add role switch release action\n");
+
+	chip->role_sw = usb_role_switch_get(&pdev->dev);
+	if (IS_ERR(chip->role_sw))
+		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
+					"failed to get role switch\n");
+
+	chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(chip->base))
+		return PTR_ERR(chip->base);
+
+	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(chip->mode_mgr))
+		return PTR_ERR(chip->mode_mgr);
+
+	chip->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
+			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
+
+	enable_irq_wake(chip->irq);
+
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static int eud_remove(struct platform_device *pdev)
+{
+	struct eud_chip *chip = platform_get_drvdata(pdev);
+
+	if (chip->enabled)
+		disable_eud(chip);
+
+	device_init_wakeup(&pdev->dev, false);
+	disable_irq_wake(chip->irq);
+
+	return 0;
+}
+
+static const struct of_device_id eud_dt_match[] = {
+	{ .compatible = "qcom,sc7280-eud" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, eud_dt_match);
+
+static struct platform_driver eud_driver = {
+	.probe	= eud_probe,
+	.remove	= eud_remove,
+	.driver	= {
+		.name = "qcom_eud",
+		.dev_groups = eud_groups,
+		.of_match_table = eud_dt_match,
+	},
+};
+module_platform_driver(eud_driver);
+
+MODULE_DESCRIPTION("QTI EUD driver");
+MODULE_LICENSE("GPL v2");
--
2.7.4


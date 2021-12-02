Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949464660CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356770AbhLBJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:56:28 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:26892 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356713AbhLBJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638438779; x=1669974779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vHpx56BQetVRRX/nlyWns4ejtFMVAAmmvmRzCFh8kes=;
  b=wDKYS8mVBCDO2UEgoO70QkMj1LTC/2RAQpNSjYnWZ7bJwDhjO4XwjlXV
   odRNXym6JDlYf4UD3YZkkyh/Jy+wy580CCu8bnkuWi6uvhgmtJrbgtHwf
   Qn6th8E/18z4Lyac9lFv9lZT8Q94Myuu0Bl+2Jpc4Wr2U+lu/BbxnkhBQ
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Dec 2021 01:52:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:52:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:58 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:53 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 5/8] soc: qcom: eud: Add driver support for Embedded USB Debugger(EUD)
Date:   Thu, 2 Dec 2021 15:21:24 +0530
Message-ID: <e13421cebfcddda5e7df99a8cf767854d121976e.1638430506.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1638430506.git.quic_schowdhu@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
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
 Documentation/ABI/testing/sysfs-driver-eud |   9 +
 drivers/soc/qcom/Kconfig                   |  10 ++
 drivers/soc/qcom/Makefile                  |   1 +
 drivers/soc/qcom/qcom_eud.c                | 268 +++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
 create mode 100644 drivers/soc/qcom/qcom_eud.c

diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
new file mode 100644
index 0000000..eaf2e82
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-eud
@@ -0,0 +1,9 @@
+What:		/sys/bus/platform/drivers/eud/.../enable
+Date:           October 2021
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		The Enable/Disable sysfs interface for Embedded
+		USB Debugger(EUD). This enables and disables the
+		EUD based on a 1 or a 0 value. By enabling EUD,
+		the user is able to activate the mini-usb hub of
+		EUD for debug and trace capabilities.
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 79b568f..a4db41b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -42,6 +42,16 @@ config QCOM_CPR
 	  To compile this driver as a module, choose M here: the module will
 	  be called qcom-cpr

+config QCOM_EUD
+	tristate "QCOM Embedded USB Debugger(EUD) Driver"
+	select USB_ROLE_SWITCH
+	help
+	  This module enables support for Qualcomm Technologies, Inc.
+	  Embedded USB Debugger (EUD). The EUD is a control peripheral
+	  which reports VBUS attach/detach events and has USB-based
+	  debug and trace capabilities. On selecting m, the module name
+	  that is built is qcom_eud.ko
+
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ad675a6..3331a40 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_EUD)          += qcom_eud.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/qcom_eud.c b/drivers/soc/qcom/qcom_eud.c
new file mode 100644
index 0000000..613ac41
--- /dev/null
+++ b/drivers/soc/qcom/qcom_eud.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
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
+#define EUD_REG_EUD_EN2         0x0000
+
+#define EUD_ENABLE		BIT(0)
+#define EUD_INT_PET_EUD		BIT(0)
+#define EUD_INT_VBUS		BIT(2)
+#define EUD_INT_SAFE_MODE	BIT(4)
+#define EUD_INT_ALL		(EUD_INT_VBUS|EUD_INT_SAFE_MODE)
+
+struct eud_chip {
+	struct device			*dev;
+	struct usb_role_switch		*role_sw;
+	void __iomem			*eud_reg_base;
+	void __iomem			*eud_mode_mgr2_phys_base;
+	unsigned int			int_status;
+	int				eud_irq;
+	bool				enable;
+	bool				usb_attach;
+
+};
+
+static int enable_eud(struct eud_chip *priv)
+{
+	writel(EUD_ENABLE, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
+	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
+			priv->eud_reg_base + EUD_REG_INT1_EN_MASK);
+	writel(1, priv->eud_mode_mgr2_phys_base + EUD_REG_EUD_EN2);
+
+	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
+}
+
+static void disable_eud(struct eud_chip *priv)
+{
+	writel(0, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
+	writel(0, priv->eud_mode_mgr2_phys_base + EUD_REG_EUD_EN2);
+}
+
+static ssize_t enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct eud_chip *chip = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", chip->enable);
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
+			chip->enable = enable;
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
+
+static struct attribute_group attr_group = {
+	.attrs = eud_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&attr_group,
+	NULL
+};
+
+static void usb_attach_detach(struct eud_chip *chip)
+{
+	u32 reg;
+
+	/* read ctl_out_1[4] to find USB attach or detach event */
+	reg = readl(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
+	if (reg & EUD_INT_SAFE_MODE)
+		chip->usb_attach = true;
+	else
+		chip->usb_attach = false;
+
+	/* set and clear vbus_int_clr[0] to clear interrupt */
+	writel(BIT(0), chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
+	writel(0, chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
+}
+
+static void pet_eud(struct eud_chip *chip)
+{
+	u32 reg;
+	int ret;
+
+	/* read sw_attach_det[0] to find attach/detach event */
+	reg = readl(chip->eud_reg_base +  EUD_REG_SW_ATTACH_DET);
+	if (reg & EUD_INT_PET_EUD) {
+		/* Detach & Attach pet for EUD */
+		writel(0, chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
+		/* Delay to make sure detach pet is done before attach pet */
+		ret = readl_poll_timeout(chip->eud_reg_base + EUD_REG_SW_ATTACH_DET,
+					reg, (reg == 0), 1, 100);
+		if (ret) {
+			dev_err(chip->dev, "Detach pet failed\n");
+			return;
+		}
+
+		writel(EUD_INT_PET_EUD, chip->eud_reg_base +
+				EUD_REG_SW_ATTACH_DET);
+	} else {
+		/* Attach pet for EUD */
+		writel(EUD_INT_PET_EUD, chip->eud_reg_base +
+				EUD_REG_SW_ATTACH_DET);
+	}
+}
+
+static irqreturn_t handle_eud_irq(int irq, void *data)
+{
+	struct eud_chip *chip = data;
+	u32 reg;
+
+	/* read status register and find out which interrupt triggered */
+	reg = readl(chip->eud_reg_base +  EUD_REG_INT_STATUS_1);
+	switch (reg & EUD_INT_ALL) {
+	case EUD_INT_VBUS:
+		chip->int_status = EUD_INT_VBUS;
+		usb_attach_detach(chip);
+		return IRQ_WAKE_THREAD;
+	case EUD_INT_SAFE_MODE:
+		pet_eud(chip);
+		break;
+	default:
+		return IRQ_NONE;
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t handle_eud_irq_thread(int irq, void *data)
+{
+	struct eud_chip *chip = data;
+	int ret;
+
+	if (chip->int_status == EUD_INT_VBUS) {
+		if (chip->usb_attach)
+			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_DEVICE);
+		else
+			ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_HOST);
+		if (ret)
+			dev_err(chip->dev, "failed to set role switch\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int eud_probe(struct platform_device *pdev)
+{
+	struct eud_chip *chip;
+	struct fwnode_handle *fwnode = pdev->dev.fwnode, *ep, *connector;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &pdev->dev;
+
+	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
+	if (!ep)
+		return -ENODEV;
+
+	connector = fwnode_graph_get_remote_port_parent(ep);
+	fwnode_handle_put(ep);
+	if (!connector)
+		return -ENODEV;
+
+	chip->role_sw = fwnode_usb_role_switch_get(connector);
+	if (IS_ERR(chip->role_sw)) {
+		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
+					"failed to get role switch\n");
+	}
+
+	chip->eud_reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(chip->eud_reg_base))
+		return PTR_ERR(chip->eud_reg_base);
+
+	chip->eud_mode_mgr2_phys_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(chip->eud_mode_mgr2_phys_base))
+		return PTR_ERR(chip->eud_mode_mgr2_phys_base);
+
+	chip->eud_irq = platform_get_irq(pdev, 0);
+	ret = devm_request_threaded_irq(&pdev->dev, chip->eud_irq, handle_eud_irq,
+			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
+
+	enable_irq_wake(chip->eud_irq);
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
+	if (chip->enable)
+		disable_eud(chip);
+
+	device_init_wakeup(&pdev->dev, false);
+	disable_irq_wake(chip->eud_irq);
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
+	.probe		= eud_probe,
+	.remove		= eud_remove,
+	.driver		= {
+		.name		= "eud",
+		.dev_groups	= attr_groups,
+		.of_match_table = eud_dt_match,
+	},
+};
+module_platform_driver(eud_driver);
+
+MODULE_DESCRIPTION("QTI EUD driver");
+MODULE_LICENSE("GPL v2");
--
2.7.4


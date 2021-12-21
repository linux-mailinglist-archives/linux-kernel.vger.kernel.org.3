Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0447C68F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhLUS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhLUS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:28:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE3C061574;
        Tue, 21 Dec 2021 10:28:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id m15so13047018pgu.11;
        Tue, 21 Dec 2021 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhp/aClFSu6zCTiB0ewICEwB0s2D+8VsIVOQhvNHlRA=;
        b=buxnMh7slYzf6kZv3RqdyzOf4WI5fW6CVPZx1ihZG3Wa7U+jnHPVx0xVFmezL3GZIz
         8ljzABhuU2fAnEQezDsjvhagDkGakCQn6Jdv4GaurZJEgWXQcrv4rwETXme8DZNgaK6y
         bBn/X7DgbzOJn8OGg361xTzBmxI+QjrH9IEHBZxTqiGCh+NgqFxcW1Bvn5pOKxIYDYax
         /WdHssYM7eboaUix0i6vwojD6ODMo75VO4adYW4hmA65zOOXf715EMkhnMolOI0u9HOD
         J4UO/aD0VRoMBiDi1lgFgxCiFaTEtUVV3eMEehtaBeJj7hLYMXzaAo8MAL6XSCzXxZ+m
         Lc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhp/aClFSu6zCTiB0ewICEwB0s2D+8VsIVOQhvNHlRA=;
        b=MBUnwP3pdkqphScDUP78T+z7x6npMipk1kK2SyAUpqJiWid2QHKTlWyJa4F5+dqLcg
         yB7weubIGnTg1vcHVUpsNlCxhH4hZZh7DxLXu1UpAFRijjmYE3/N/CFFshkVlR+vs18n
         QgA/uWhYW3aHpPP4/thejk9+4Ji1KhUBJMFe4YVT+Mg8RmRMJBQsicIytsfVdOIJCPZ0
         pDPjRNXX2X4FpWhhWZZwjtau39bh2z4hiS/L/VUk65jnEuTmR2flKk8ONn0WSbssG3JM
         4ShYDWnJaRYIPm1vDT6uQ/yf3scgATpkBtLr1a9KMw5AxaBmOpaWhqfAwdN/93s117xR
         ZrFA==
X-Gm-Message-State: AOAM530IdoDoDWSyGAbR9AcyZH+t1qEkXPfJlvCJi0qklhe/8v8DDStE
        dryGR1tdYmz8cb/7X8j+nOw/QacOrAo=
X-Google-Smtp-Source: ABdhPJya7iVWjOPayDAcPWcIzuvqzcth9yIH2ZYJdL5bjS45JYLGEU04qr7N3tHSdLutK3yOvBtisA==
X-Received: by 2002:a63:8648:: with SMTP id x69mr4003818pgd.9.1640111314819;
        Tue, 21 Dec 2021 10:28:34 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:36:b871:81c1:f2ef:8174])
        by smtp.gmail.com with ESMTPSA id s19sm23436133pfu.137.2021.12.21.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:28:34 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        bjorn.andersson@linaro.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH RESEND v4 2/4] platform: surface: Add surface xbl
Date:   Tue, 21 Dec 2021 10:28:24 -0800
Message-Id: <20211221182826.2141789-3-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221182826.2141789-1-jaschultzMS@gmail.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce support for the Extensible Boot Loader driver found on the
Surface Duo. Makes device information available to users via sysfs.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v4:
 - N/A

---

Changes in v3:
 - Updated several descriptions in the yaml to be more descriptive
 - Renamed files to use an underscore instead of a dash

---

Changes in v2:
 - Added types.h inclusion and removed unused inclusions
 - Minor updates to code and acronym style
 - Remove __packed attribute on driver struct
 - Use .dev_groups for sysfs
 - Added more in-depth description of driver in Kconfig
 - Changed target KernelVersion in sysfs documentation
---
 .../ABI/testing/sysfs-platform-surface-xbl    |  79 ++++++++
 MAINTAINERS                                   |   2 +
 drivers/platform/surface/Kconfig              |  12 ++
 drivers/platform/surface/Makefile             |   1 +
 drivers/platform/surface/surface_xbl.c        | 186 ++++++++++++++++++
 5 files changed, 280 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-surface-xbl
 create mode 100644 drivers/platform/surface/surface_xbl.c

diff --git a/Documentation/ABI/testing/sysfs-platform-surface-xbl b/Documentation/ABI/testing/sysfs-platform-surface-xbl
new file mode 100644
index 000000000000..505a662d8511
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-surface-xbl
@@ -0,0 +1,79 @@
+What:		/sys/devices/platform/146bfa94.xbl/battery_present
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns whether the battery is present. Valid
+		values are:
+			0 - battery absent
+			1 - battery present
+
+What:		/sys/devices/platform/146bfa94.xbl/board_id
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns a Microsoft specific board id.
+
+What:		/sys/devices/platform/146bfa94.xbl/hw_init_retries
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns a Microsoft specific value related to the
+		retries attempted to properly initialize the battery charging
+		subsystem.
+
+What:		/sys/devices/platform/146bfa94.xbl/is_act_mode
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns whether ACT mode is enabled. Valid values
+		are:
+			0 - ACT disabled
+			1 - ACT enabled
+
+		ACT mode is used to run checks and put the device to shipmode
+		at factory.
+
+What:		/sys/devices/platform/146bfa94.xbl/is_customer_mode
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+
+		mode. Valid values are:
+			0 - Not in manufacturing mode
+			1 - In manufacturing mode
+
+What:		/sys/devices/platform/146bfa94.xbl/ocp_error_location
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns 0 or the id of the power rail which has the
+		OCP error. Valid values are:
+			Bit(s)		Meaning
+			15		More than one OCP error occurred
+			14-12		PMIC
+			11-7		SMPS
+			6-2		LDO
+			1-0		BOB
+
+What:		/sys/devices/platform/146bfa94.xbl/pmic_reset_reason
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns the reason for the reset. Valid values
+		are:
+			0 - no reason lol
+			9 - Battery driver triggered
+
+What:		/sys/devices/platform/146bfa94.xbl/touch_fw_version
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	jaschultz@microsoft.com
+Description:
+		Read only. It returns the version of the firmware.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5d0ca2a98b57..e65eddf5d25d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12654,7 +12654,9 @@ M:	Jarrett Schultz <jaschultz@microsoft.com>
 L:	linux-arm-msm@vger.kernel.org
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-platform-surface-xbl
 F:	Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
+F:	drivers/platform/surface/surface-xbl.c
 
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 5f0578e25f71..96d6030d8d49 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -185,6 +185,18 @@ config SURFACE_PRO3_BUTTON
 	help
 	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
 
+config SURFACE_XBL
+        tristate "Surface XBL Driver"
+        depends on ARM64 || COMPILE_TEST
+        depends on OF
+        help
+          If you say 'Y' to this option, support will be included for the
+          Surface Extensible Boot Loader (XBL) Driver. This driver exposes
+          information about the device through sysfs.
+
+          This driver can also be built as a module.  If so, the module
+          will be called surface-xbl.
+
 source "drivers/platform/surface/aggregator/Kconfig"
 
 endif # SURFACE_PLATFORMS
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 32889482de55..eef05d247f75 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
 obj-$(CONFIG_SURFACE_PLATFORM_PROFILE)	+= surface_platform_profile.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
+obj-$(CONFIG_SURFACE_XBL)               += surface_xbl.o
diff --git a/drivers/platform/surface/surface_xbl.c b/drivers/platform/surface/surface_xbl.c
new file mode 100644
index 000000000000..e6272b704526
--- /dev/null
+++ b/drivers/platform/surface/surface_xbl.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Surface eXtensible Boot Loader (XBL)
+ *
+ * Copyright (C) 2021 Microsoft Corporation
+ * Author: Jarrett Schultz <jaschultz@microsoft.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define SURFACE_XBL_MAX_VERSION_LEN	16
+#define SURFACE_XBL_BOARD_ID		0
+#define SURFACE_XBL_BATTERY_PRESENT	1
+#define SURFACE_XBL_HW_INIT_RETRIES	2
+#define SURFACE_XBL_IS_CUSTOMER_MODE	3
+#define SURFACE_XBL_IS_ACT_MODE		4
+#define SURFACE_XBL_PMIC_RESET_REASON	5
+#define SURFACE_XBL_TOUCH_FW_VERSION	6
+#define SURFACE_XBL_OCP_ERROR_LOCATION		\
+		(SURFACE_XBL_TOUCH_FW_VERSION +	\
+		SURFACE_XBL_MAX_VERSION_LEN)
+
+struct surface_xbl {
+	struct device	*dev;
+
+	u8		board_id;
+	u8		battery_present;
+	u8		hw_init_retries;
+	u8		is_customer_mode;
+	u8		is_act_mode;
+	u8		pmic_reset_reason;
+	char		touch_fw_version[SURFACE_XBL_MAX_VERSION_LEN];
+	u16		ocp_error_location;
+};
+
+static ssize_t
+board_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->board_id);
+}
+static DEVICE_ATTR_RO(board_id);
+
+static ssize_t
+battery_present_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->battery_present);
+}
+static DEVICE_ATTR_RO(battery_present);
+
+static ssize_t
+hw_init_retries_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->hw_init_retries);
+}
+static DEVICE_ATTR_RO(hw_init_retries);
+
+static ssize_t
+is_customer_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->is_customer_mode);
+}
+static DEVICE_ATTR_RO(is_customer_mode);
+
+static ssize_t
+is_act_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->is_act_mode);
+}
+static DEVICE_ATTR_RO(is_act_mode);
+
+static ssize_t
+pmic_reset_reason_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->pmic_reset_reason);
+}
+static DEVICE_ATTR_RO(pmic_reset_reason);
+
+static ssize_t
+touch_fw_version_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%s\n", sxbl->touch_fw_version);
+}
+static DEVICE_ATTR_RO(touch_fw_version);
+
+static ssize_t
+ocp_error_location_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct surface_xbl	*sxbl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", sxbl->ocp_error_location);
+}
+static DEVICE_ATTR_RO(ocp_error_location);
+
+static struct attribute *xbl_attrs[] = {
+	&dev_attr_board_id.attr,
+	&dev_attr_battery_present.attr,
+	&dev_attr_hw_init_retries.attr,
+	&dev_attr_is_customer_mode.attr,
+	&dev_attr_is_act_mode.attr,
+	&dev_attr_pmic_reset_reason.attr,
+	&dev_attr_touch_fw_version.attr,
+	&dev_attr_ocp_error_location.attr,
+	NULL
+};
+
+static const struct attribute_group xbl_attr_group = {
+	.attrs = xbl_attrs,
+};
+
+const struct attribute_group *xbl_sysfs_groups[] = {
+	&xbl_attr_group,
+	NULL
+};
+
+static int surface_xbl_probe(struct platform_device *pdev)
+{
+	struct surface_xbl	*sxbl;
+	void __iomem		*regs;
+	int			i;
+
+	sxbl = devm_kzalloc(&pdev->dev, sizeof(*sxbl), GFP_KERNEL);
+	if (!sxbl)
+		return -ENOMEM;
+
+	sxbl->dev = &pdev->dev;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	platform_set_drvdata(pdev, sxbl);
+
+	sxbl->board_id = readb(regs + SURFACE_XBL_BOARD_ID);
+	sxbl->battery_present = readb(regs + SURFACE_XBL_BATTERY_PRESENT);
+	sxbl->hw_init_retries = readb(regs + SURFACE_XBL_HW_INIT_RETRIES);
+	sxbl->is_customer_mode = readb(regs + SURFACE_XBL_IS_CUSTOMER_MODE);
+	sxbl->is_act_mode = readb(regs + SURFACE_XBL_IS_ACT_MODE);
+	sxbl->pmic_reset_reason = readb(regs + SURFACE_XBL_PMIC_RESET_REASON);
+
+	for (i = 0; i < SURFACE_XBL_MAX_VERSION_LEN; i++)
+		sxbl->touch_fw_version[i] = readb(regs + SURFACE_XBL_TOUCH_FW_VERSION + i);
+
+	sxbl->ocp_error_location = readb(regs + SURFACE_XBL_OCP_ERROR_LOCATION);
+
+	return 0;
+}
+
+static const struct of_device_id surface_xbl_of_match[] = {
+	{
+		.compatible = "microsoft,sm8150-surface-duo-xbl"
+	},
+	{  }
+};
+MODULE_DEVICE_TABLE(of, surface_xbl_of_match);
+
+static struct platform_driver surface_xbl_driver = {
+	.driver	= {
+		.name		= "surface-xbl",
+		.of_match_table = surface_xbl_of_match,
+		.dev_groups	= xbl_sysfs_groups
+	},
+	.probe		= surface_xbl_probe,
+};
+module_platform_driver(surface_xbl_driver);
+
+MODULE_AUTHOR("Jarrett Schultz <jaschultz@microsoft.com>");
+MODULE_DESCRIPTION("Surface Extensible Bootloader");
+MODULE_LICENSE("GPL");
-- 
2.25.1


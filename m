Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A14B9D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiBQKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:46:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiBQKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:46:27 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0180294113
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:46:11 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E4264C68;
        Thu, 17 Feb 2022 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645094771;
        bh=g0HlU7fIoDEJJj/W+s6LzkNdT7A+UPzuBZZId3sSDXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9fQKgQXdpvd4Ip9j+0C0LhtLbwg8gSPdLtL1ZarGAKMGk/gf5w5iQifLnDGXbE1L
         KZNAJSrg6c77OItmmqajNc3gWgePE6N5dSJxAtGW0sCVlZmNeH8vgqAOm+zcPRBJCd
         2K0uwKyT1si3rQ2y4YzP1I7C71BLDZzHu7Ems50U=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 4/4] misc: Add power-efuse driver
Date:   Thu, 17 Feb 2022 02:44:44 -0800
Message-Id: <20220217104444.7695-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217104444.7695-1-zev@bewilderbeest.net>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides a sysfs interface to access the on/off state and
error flags of a regulator supplying a power output controlled by the
system.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 MAINTAINERS                |   5 +
 drivers/misc/Kconfig       |  15 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/power-efuse.c | 221 +++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 drivers/misc/power-efuse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fca970a46e77..d1153a0389d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7064,6 +7064,11 @@ S:	Orphan
 W:	http://aeschi.ch.eu.org/efs/
 F:	fs/efs/
 
+POWER EFUSE DRIVER
+M:	Zev Weiss <zev@bewilderbeest.net>
+S:	Maintained
+F:	drivers/misc/power-efuse.c
+
 EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
 M:	Douglas Miller <dougmill@linux.ibm.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..45fc3e8ad35d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -470,6 +470,21 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config POWER_EFUSE
+	tristate "Power efuse driver support"
+	depends on OF && REGULATOR
+	help
+	  This driver supports a regulator device functioning as a
+	  power efuse, with status bits and an on/off switch available
+	  via sysfs.
+
+	  A typical use for this would be for an efuse controlling a
+	  generic power output for supplying power to devices external
+	  to the system running this driver (such as in the management
+	  controller of a "smart" PDU or similar), allowing the
+	  operator to manually turn the output on and off, check if
+	  the efuse has tripped due to overload, etc.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197af544..7bd784b89ef8 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
+obj-$(CONFIG_POWER_EFUSE)	+= power-efuse.o
diff --git a/drivers/misc/power-efuse.c b/drivers/misc/power-efuse.c
new file mode 100644
index 000000000000..e974dde57615
--- /dev/null
+++ b/drivers/misc/power-efuse.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This module provides a thin wrapper around a regulator device that exposes
+ * status bits and on/off state via sysfs.
+ *
+ * Copyright (C) 2022 Zev Weiss <zev@bewilderbeest.net>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+struct efuse {
+	struct regulator *reg;
+	struct {
+		unsigned int cache;
+		unsigned long ttl;
+		unsigned long fetch_time;
+		struct mutex lock;
+	} error_flags;
+};
+
+/* Ensure that the next error_flags access fetches them from the device */
+static void efuse_invalidate_error_flags(struct efuse *efuse)
+{
+	mutex_lock(&efuse->error_flags.lock);
+	efuse->error_flags.fetch_time = 0;
+	mutex_unlock(&efuse->error_flags.lock);
+}
+
+static ssize_t efuse_show_operstate(struct device *dev, struct device_attribute *attr,
+				    char *buf)
+{
+	struct efuse *efuse = dev_get_drvdata(dev);
+	int status = regulator_is_enabled(efuse->reg);
+
+	if (status < 0)
+		return status;
+
+	return sysfs_emit(buf, "%s\n", status ? "on" : "off");
+}
+
+static ssize_t efuse_set_operstate(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int status, wantstate;
+	struct efuse *efuse = dev_get_drvdata(dev);
+	struct regulator *reg = efuse->reg;
+
+	if (sysfs_streq(buf, "on"))
+		wantstate = 1;
+	else if (sysfs_streq(buf, "off"))
+		wantstate = 0;
+	else
+		return -EINVAL;
+
+	status = regulator_is_enabled(reg);
+
+	/*
+	 * We need to ensure our enable/disable calls don't get imbalanced, so
+	 * bail if we can't determine the current state.
+	 */
+	if (status < 0)
+		return status;
+
+	/* Return early if we're already in the desired state */
+	if (!!status == wantstate)
+		return count;
+
+	if (wantstate)
+		status = regulator_enable(reg);
+	else
+		status = regulator_disable(reg);
+
+	/*
+	 * Toggling operstate can reset latched status flags, so invalidate
+	 * the cached value.
+	 */
+	efuse_invalidate_error_flags(efuse);
+
+	if (!status && regulator_is_enabled(reg) != wantstate) {
+		/*
+		 * We could do
+		 *
+		 *   if (!wantstate)
+		 *     regulator_force_disable(reg);
+		 *
+		 * here, but it's likely to leave it such that it can't then
+		 * be re-enabled, so we'll just report the error and leave it
+		 * as it is (and hopefully as long as our enable/disable calls
+		 * remain balanced and nobody registers another consumer for
+		 * the same supply we won't end up in this situation anyway).
+		 */
+		dev_err(dev, "regulator_%sable() didn't take effect\n", wantstate ? "en" : "dis");
+		status = -EIO;
+	}
+
+	return status ? : count;
+}
+
+static int efuse_update_error_flags(struct efuse *efuse)
+{
+	int status = 0;
+	unsigned long cache_expiry;
+
+	mutex_lock(&efuse->error_flags.lock);
+
+	cache_expiry = efuse->error_flags.fetch_time + efuse->error_flags.ttl;
+
+	if (!efuse->error_flags.ttl || !efuse->error_flags.fetch_time ||
+	    time_after(jiffies, cache_expiry)) {
+		status = regulator_get_error_flags(efuse->reg, &efuse->error_flags.cache);
+		if (!status)
+			efuse->error_flags.fetch_time = jiffies;
+	}
+
+	mutex_unlock(&efuse->error_flags.lock);
+
+	return status;
+}
+
+static DEVICE_ATTR(operstate, 0644, efuse_show_operstate, efuse_set_operstate);
+
+#define EFUSE_ERROR_ATTR(name, bit)							    \
+	static ssize_t efuse_show_##name(struct device *dev, struct device_attribute *attr, \
+					 char *buf)                                         \
+	{                                                                                   \
+		struct efuse *efuse = dev_get_drvdata(dev);                                 \
+		int status = efuse_update_error_flags(efuse);                               \
+		if (status)                                                                 \
+			return status;                                                      \
+		return sysfs_emit(buf, "%d\n", !!(efuse->error_flags.cache & bit));         \
+	}                                                                                   \
+	static DEVICE_ATTR(name, 0444, efuse_show_##name, NULL)
+
+EFUSE_ERROR_ATTR(under_voltage, REGULATOR_ERROR_UNDER_VOLTAGE);
+EFUSE_ERROR_ATTR(over_current, REGULATOR_ERROR_OVER_CURRENT);
+EFUSE_ERROR_ATTR(regulation_out, REGULATOR_ERROR_REGULATION_OUT);
+EFUSE_ERROR_ATTR(fail, REGULATOR_ERROR_FAIL);
+EFUSE_ERROR_ATTR(over_temp, REGULATOR_ERROR_OVER_TEMP);
+EFUSE_ERROR_ATTR(under_voltage_warn, REGULATOR_ERROR_UNDER_VOLTAGE_WARN);
+EFUSE_ERROR_ATTR(over_current_warn, REGULATOR_ERROR_OVER_CURRENT_WARN);
+EFUSE_ERROR_ATTR(over_voltage_warn, REGULATOR_ERROR_OVER_VOLTAGE_WARN);
+EFUSE_ERROR_ATTR(over_temp_warn, REGULATOR_ERROR_OVER_TEMP_WARN);
+
+static struct attribute *attributes[] = {
+	&dev_attr_operstate.attr,
+	&dev_attr_under_voltage.attr,
+	&dev_attr_over_current.attr,
+	&dev_attr_regulation_out.attr,
+	&dev_attr_fail.attr,
+	&dev_attr_over_temp.attr,
+	&dev_attr_under_voltage_warn.attr,
+	&dev_attr_over_current_warn.attr,
+	&dev_attr_over_voltage_warn.attr,
+	&dev_attr_over_temp_warn.attr,
+	NULL,
+};
+
+static const struct attribute_group attr_group = {
+	.attrs = attributes,
+};
+
+static int efuse_probe(struct platform_device *pdev)
+{
+	int status;
+	struct regulator *reg;
+	struct efuse *efuse;
+	u32 cache_ttl_ms;
+
+	reg = devm_regulator_get(&pdev->dev, "vout");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	status = regulator_enable(reg);
+	if (status) {
+		dev_err(&pdev->dev, "failed to enable regulator\n");
+		return status;
+	}
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	efuse->reg = reg;
+	mutex_init(&efuse->error_flags.lock);
+
+	if (!of_property_read_u32(pdev->dev.of_node, "error-flags-cache-ttl-ms", &cache_ttl_ms))
+		efuse->error_flags.ttl = msecs_to_jiffies(cache_ttl_ms);
+
+	platform_set_drvdata(pdev, efuse);
+
+	return sysfs_create_group(&pdev->dev.kobj, &attr_group);
+}
+
+static int efuse_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
+	return 0;
+}
+
+static const struct of_device_id efuse_of_match_table[] = {
+	{ .compatible = "power-efuse" },
+	{ },
+};
+
+static struct platform_driver efuse_driver = {
+	.driver = {
+		.name = "power-efuse",
+		.of_match_table = efuse_of_match_table,
+	},
+	.probe = efuse_probe,
+	.remove = efuse_remove,
+};
+module_platform_driver(efuse_driver);
+
+MODULE_AUTHOR("Zev Weiss <zev@bewilderbeest.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Power efuse driver");
-- 
2.35.1


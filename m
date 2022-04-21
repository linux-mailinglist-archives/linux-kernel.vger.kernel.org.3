Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830AD50A5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiDUQaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiDUQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:28:45 -0400
X-Greylist: delayed 187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 09:25:13 PDT
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54C49273
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:25:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 01BD499D239
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1650558124;
        bh=tj8i4TVvS/HCKko4aWZMtkRdcatK082SIgrkqjMkpDQ=;
        h=From:To:Cc:Subject:Date;
        b=Hly3ZqWjd2Ptb0wXtiGeF8aGNxPpBMdpeYRa3hbkXowMlc6yIssWFv3qbXqDfbB2O
         jy//D7W6dS93ptac31Ap2PlseBu0/PMJEMda82wMBe6Vq297ij73+uO/1Fb5Pfgcgq
         k8tbX5jcf9D5UMFPByq4bP2M8b9hLk1H2TDNS03I=
Received: from fx403 (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id DEF8D99D206;
        Thu, 21 Apr 2022 18:22:02 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <2bb2.626184aa.271f9.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx403.security-mail.net (Postfix) with ESMTPS id 2874B99D1E8;
        Thu, 21 Apr 2022 18:22:02 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 02E0127E0457;
        Thu, 21 Apr 2022 18:22:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DD3CD27E0456;
        Thu, 21 Apr 2022 18:22:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu DD3CD27E0456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1650558121;
        bh=LflrGUYlsm8UQp1TacL+Qq10ExNuNTFJ1al770Q/+u0=;
        h=From:To:Date:Message-Id;
        b=MwebgSvcXcDuC6oJZ8UVm6PCkRnQ7vtFPLjEoKlU1YctnWkTdRMAe1kc+xxxqd/4M
         Or+c/8cvSavmzA9qAsK8qbAiJWW7KDvVFy6H24KVJ63gPCM6O5D6LRUCUP05TyG1UA
         m0rIhCgDkkdE1s5BkEr8x1ErBynG792u2J6P5qI4=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ioz485KrBp_I; Thu, 21 Apr 2022 18:22:01 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id B966527E0444;
        Thu, 21 Apr 2022 18:22:01 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-usb@vger.kernel.org
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jules Maselbas <jmaselbas@kalray.eu>
Subject: [RFC PATCH] phy: Convert usb-nop-xceiv to the generic phy subsystem
Date:   Thu, 21 Apr 2022 18:21:58 +0200
Message-Id: <20220421162158.31364-1-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently encountered some limitations when using the usb-nop-xceiv
driver using the usb-phy subsystem. The situation is: I have a board
with two external usb phys (ULPI) that only needs to be reset by the
USB controller. However both phys shares the same reset line, which
will get toggled twice by the USB driver, once by controller.

This is what I observed with the current Linux usb-nop-xceiv driver:
          _______                            ___      _________
   RESET:        \__________________________/   \____/
                1^                         2^  3^   4^
 1. and 2. first controller toggle the reset
 3. and 4. second controller toggle the reset

After the second toggle the first driver didn't expected the reset and
causing issues, but I don't recall what exactly, it is maybe a driver
that simply fail to get probed.

The following is what I observed when using the "usb-nop-xceiv"
driver in Barebox, which is a bit different than the Linux one.

           _______                            _________________
    RESET:        \__________________________/
                 1^                         2^

In this case the reset is only toggled once, this is because the phy
driver count the number of time it has called init and power_on, which
is exactly what is done by the generic phy subsystem in Linux, but not
by the "legacy" usb-nop-xceiv usb-phy driver.

This difference in behavior is what motivated to "port" the existing
usb-nop-xceiv driver to the generic phy subsystem. However this is far
from being complete... I've only tested the reset function for this nop
phy, and it lack a lot of features from the original driver to be a
valid replacement for it.

I would like to know if there is an interest in converting the current
usb-nop-xceiv driver to the generic phy subsystem?

I would like to keep the usb-nop-xceiv compatible as it used by Barebox
and it works OK. If a new compatible is added then device-tree nodes
shouldn't have both, the new and usb-nop-xceiv, compatible because of
the specific check in phy-core.c which will always return ENODEV.

Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-core.c        |   4 -
 drivers/phy/phy-usb-generic.c | 241 ++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 4 deletions(-)
 create mode 100644 drivers/phy/phy-usb-generic.c

diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 6eb2916773c5..8eeecf6d6f74 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_GENERIC_PHY)		+= phy-usb-generic.o
 obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 71cb10826326..e09fd1cb4455 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -506,10 +506,6 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
-	/* This phy type handled by the usb-phy subsystem for now */
-	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
-		return ERR_PTR(-ENODEV);
-
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
 	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
diff --git a/drivers/phy/phy-usb-generic.c b/drivers/phy/phy-usb-generic.c
new file mode 100644
index 000000000000..fdd05bbd98f2
--- /dev/null
+++ b/drivers/phy/phy-usb-generic.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * derived from driver/usb/phy/phy-generic.c
+ *
+ * Generic USB PHY driver for all USB "nop" transceiver which are mostly
+ * autonomous. This driver is derived from the usb-nop-xceiv driver, but
+ * this one use the new generic phy api.
+ *
+ * Copyright (c) 2022 Kalray Inc.
+ * Author(s): Jules Maselbas
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/usb/otg.h>
+
+struct phy_usb_generic {
+	struct device *dev;
+	struct clk *clk;
+	struct regulator *vcc;
+	struct gpio_desc *gpiod_reset;
+	unsigned long mA;
+	unsigned int vbus;
+	enum usb_dr_mode dr_mode;
+};
+
+static int phy_usb_generic_init(struct phy *phy)
+{
+	struct phy_usb_generic *priv = phy_get_drvdata(phy);
+
+	if (priv->clk)
+		clk_prepare(priv->clk);
+
+	return 0;
+}
+
+static int phy_usb_generic_exit(struct phy *phy)
+{
+	struct phy_usb_generic *priv = phy_get_drvdata(phy);
+
+	if (priv->clk)
+		clk_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int phy_usb_generic_power_on(struct phy *phy)
+{
+	struct phy_usb_generic *priv = phy_get_drvdata(phy);
+	int ret;
+
+	if (priv->vcc) {
+		ret = regulator_enable(priv->vcc);
+		if (ret) {
+			dev_err(priv->dev, "Failed to enable power\n");
+			return ret;
+		}
+	}
+
+	if (priv->clk) {
+		ret = clk_enable(priv->clk);
+		if (ret) {
+			dev_err(priv->dev, "Failed to enable clock\n");
+			return ret;
+		}
+	}
+
+	if (priv->gpiod_reset) {
+		dev_dbg(priv->dev, "Reset toggle\n");
+		gpiod_set_value_cansleep(priv->gpiod_reset, 1);
+		usleep_range(10000, 20000);
+		gpiod_set_value_cansleep(priv->gpiod_reset, 0);
+	}
+
+	return 0;
+}
+
+static int phy_usb_generic_power_off(struct phy *phy)
+{
+	struct phy_usb_generic *priv = phy_get_drvdata(phy);
+	int ret;
+
+	if (priv->gpiod_reset)
+		gpiod_set_value_cansleep(priv->gpiod_reset, 1);
+
+	if (priv->clk)
+		clk_disable_unprepare(priv->clk);
+
+	if (priv->vcc) {
+		ret = regulator_disable(priv->vcc);
+		if (ret) {
+			dev_err(priv->dev, "Failed to disable power\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int phy_usb_generic_set_mode(struct phy *phy,
+				    enum phy_mode mode, int submode)
+{
+	struct phy_usb_generic *priv = phy_get_drvdata(phy);
+	enum usb_dr_mode new_mode;
+	const char *s = "";
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_HOST_LS:
+	case PHY_MODE_USB_HOST_HS:
+	case PHY_MODE_USB_HOST_FS:
+		new_mode = USB_DR_MODE_HOST;
+		s = "host";
+		break;
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_DEVICE_LS:
+	case PHY_MODE_USB_DEVICE_HS:
+	case PHY_MODE_USB_DEVICE_FS:
+		new_mode = USB_DR_MODE_PERIPHERAL;
+		s = "peripheral";
+		break;
+	case PHY_MODE_USB_OTG:
+		new_mode = USB_DR_MODE_OTG;
+		s = "otg";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (new_mode != priv->dr_mode) {
+		dev_info(priv->dev, "Changing dr_mode to %s\n", s);
+		priv->dr_mode = new_mode;
+	}
+
+	return 0;
+}
+
+static const struct phy_ops phy_usb_generic_ops = {
+	.init = phy_usb_generic_init,
+	.exit = phy_usb_generic_exit,
+	.power_on = phy_usb_generic_power_on,
+	.power_off = phy_usb_generic_power_off,
+	.set_mode  = phy_usb_generic_set_mode,
+	.owner = THIS_MODULE,
+};
+
+static int phy_usb_generic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct phy_usb_generic *priv;
+	struct phy_provider *provider;
+	struct phy *phy;
+	int err;
+	u32 clk_rate = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	priv->gpiod_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(priv->gpiod_reset)) {
+		err = PTR_ERR(priv->gpiod_reset);
+		dev_err(dev, "Failed to get reset gpio: %d\n", err);
+		return err;
+	}
+
+	if (np && of_property_read_u32(np, "clock-frequency", &clk_rate))
+		clk_rate = 0;
+
+	priv->clk = devm_clk_get_optional(dev, "main_clk");
+	if (IS_ERR(priv->clk)) {
+		err = PTR_ERR(priv->clk);
+		dev_err(dev, "Can't get phy clock: %d\n", err);
+		return err;
+	}
+	if (priv->clk && clk_rate) {
+		err = clk_set_rate(priv->clk, clk_rate);
+		if (err) {
+			dev_err(dev, "Error setting clock rate\n");
+			return err;
+		}
+	}
+
+	priv->vcc = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(priv->vcc)) {
+		err = PTR_ERR(priv->vcc);
+		if (err == -ENODEV || err == -ENOENT) {
+			priv->vcc = NULL;
+		} else {
+			dev_err(dev, "Error getting vcc regulator: %d\n", err);
+			return err;
+		}
+	}
+
+	phy = devm_phy_create(dev, NULL, &phy_usb_generic_ops);
+	if (IS_ERR(phy)) {
+		err = PTR_ERR(phy);
+		dev_err(dev, "Failed to create PHY: %d\n", err);
+		return err;
+	}
+	phy_set_drvdata(phy, priv);
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		err = PTR_ERR(provider);
+		dev_err(dev, "Failed to register PHY provider: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id phy_usb_nop_dt_ids[] = {
+	{ .compatible = "phy-usb-generic" },
+	{ .compatible = "usb-nop-xceiv" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, phy_usb_nop_dt_ids);
+
+static struct platform_driver phy_usb_generic_driver = {
+	.probe		= phy_usb_generic_probe,
+	.driver		= {
+		.name	= "phy_usb_generic",
+		.of_match_table = phy_usb_nop_dt_ids,
+	},
+};
+module_platform_driver(phy_usb_generic_driver);
+
+MODULE_AUTHOR("Kalray Inc");
+MODULE_DESCRIPTION("Generic USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


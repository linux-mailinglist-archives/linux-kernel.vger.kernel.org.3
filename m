Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9534676E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380637AbhLCMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbhLCMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:00:38 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF0C06173E;
        Fri,  3 Dec 2021 03:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NPlHa/SDP5Ci/sKdkru33oHRnQqtybel5hDNeRGPe8A=; b=LYOy58OiKpnjpwSp7jxdZoT5ij
        MejjSR8aHEogfbRmwh8Nql6e19VvkvyWT3HIhSID4IpsG/gOXvH4kNFYr45lxcE5pZJBjg1qyHhtM
        AlJHM+094sUQ74wCmfjP+gY5ePlPWIOnmEUU/VieVAVBMn8TqZ24NCOt5h0XjL2sowZs=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt6p1-0004Ez-TI; Fri, 03 Dec 2021 12:33:48 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     john@phrozen.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v6 13/14] gpio: Add support for Airoha EN7523 GPIO controller
Date:   Fri,  3 Dec 2021 12:33:30 +0100
Message-Id: <20211203113331.20510-14-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203113331.20510-1-nbd@nbd.name>
References: <20211203113331.20510-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
GPIOs. Each instance in DT is for a single bank.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/gpio/Kconfig       |   9 +++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-en7523.c | 134 +++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/gpio/gpio-en7523.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 072ed610f9c6..e4a34272504f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -247,6 +247,15 @@ config GPIO_EM
 	help
 	  Say yes here to support GPIO on Renesas Emma Mobile SoCs.
 
+config GPIO_EN7523
+	tristate "Airoha GPIO support"
+	depends on ARCH_AIROHA
+	default ARCH_AIROHA
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support the GPIO controller on Airoha EN7523.
+
 config GPIO_EP93XX
 	def_bool y
 	depends on ARCH_EP93XX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 71ee9fc2ff83..d2269ee0948e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
 obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
 obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
+obj-$(CONFIG_GPIO_EN7523)		+= gpio-en7523.o
 obj-$(CONFIG_GPIO_EP93XX)		+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXAR)			+= gpio-exar.o
 obj-$(CONFIG_GPIO_F7188X)		+= gpio-f7188x.o
diff --git a/drivers/gpio/gpio-en7523.c b/drivers/gpio/gpio-en7523.c
new file mode 100644
index 000000000000..07770c5a4101
--- /dev/null
+++ b/drivers/gpio/gpio-en7523.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/gpio/driver.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define AIROHA_GPIO_MAX		32
+
+/**
+ * airoha_gpio_ctrl - Airoha GPIO driver data
+ *
+ * @gc: Associated gpio_chip instance.
+ * @data: The data register.
+ * @dir0: The direction register for the lower 16 pins.
+ * @dir1: The direction register for the higher 16 pins.
+ * @output: The output enable register.
+ */
+struct airoha_gpio_ctrl {
+	struct gpio_chip gc;
+	void __iomem *data;
+	void __iomem *dir[2];
+	void __iomem *output;
+};
+
+static struct airoha_gpio_ctrl *gc_to_ctrl(struct gpio_chip *gc)
+{
+	return container_of(gc, struct airoha_gpio_ctrl, gc);
+}
+
+static int airoha_dir_set(struct gpio_chip *gc, unsigned int gpio,
+			  int val, int out)
+{
+	struct airoha_gpio_ctrl *ctrl = gc_to_ctrl(gc);
+	u32 dir = ioread32(ctrl->dir[gpio / 16]);
+	u32 output = ioread32(ctrl->output);
+	u32 mask = BIT((gpio % 16) * 2);
+
+	if (out) {
+		dir |= mask;
+		output |= BIT(gpio);
+	} else {
+		dir &= ~mask;
+		output &= ~BIT(gpio);
+	}
+
+	iowrite32(dir, ctrl->dir[gpio / 16]);
+	iowrite32(output, ctrl->output);
+
+	if (out)
+		gc->set(gc, gpio, val);
+
+	return 0;
+}
+
+static int airoha_dir_out(struct gpio_chip *gc, unsigned int gpio,
+			  int val)
+{
+	return airoha_dir_set(gc, gpio, val, 1);
+}
+
+static int airoha_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	return airoha_dir_set(gc, gpio, 0, 0);
+}
+
+static int airoha_get_dir(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct airoha_gpio_ctrl *ctrl = gc_to_ctrl(gc);
+	u32 dir = ioread32(ctrl->dir[gpio / 16]);
+	u32 mask = BIT((gpio % 16) * 2);
+
+	return dir & mask;
+}
+
+static const struct of_device_id airoha_gpio_of_match[] = {
+	{ .compatible = "airoha,en7523-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, airoha_gpio_of_match);
+
+static int airoha_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct airoha_gpio_ctrl *ctrl;
+	int err;
+
+	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->data = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctrl->data))
+		return PTR_ERR(ctrl->data);
+
+	ctrl->dir[0] = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ctrl->dir[0]))
+		return PTR_ERR(ctrl->dir[0]);
+
+	ctrl->dir[1] = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(ctrl->dir[1]))
+		return PTR_ERR(ctrl->dir[1]);
+
+	ctrl->output = devm_platform_ioremap_resource(pdev, 3);
+	if (IS_ERR(ctrl->output))
+		return PTR_ERR(ctrl->output);
+
+	err = bgpio_init(&ctrl->gc, dev, 4, ctrl->data, NULL,
+			 NULL, NULL, NULL, 0);
+	if (err)
+		return dev_err_probe(dev, err, "unable to init generic GPIO");
+
+	ctrl->gc.ngpio = AIROHA_GPIO_MAX;
+	ctrl->gc.owner = THIS_MODULE;
+	ctrl->gc.direction_output = airoha_dir_out;
+	ctrl->gc.direction_input = airoha_dir_in;
+	ctrl->gc.get_direction = airoha_get_dir;
+
+	return devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
+}
+
+static struct platform_driver airoha_gpio_driver = {
+	.driver = {
+		.name = "airoha-gpio",
+		.of_match_table	= airoha_gpio_of_match,
+	},
+	.probe = airoha_gpio_probe,
+};
+module_platform_driver(airoha_gpio_driver);
+
+MODULE_DESCRIPTION("Airoha GPIO support");
+MODULE_AUTHOR("John Crispin <john@phrozen.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.30.1


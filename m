Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80DB4AACD0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380969AbiBEV75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 16:59:57 -0500
Received: from mailserv1.kapsi.fi ([91.232.154.157]:52994 "EHLO
        mailserv1.kapsi.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376330AbiBEV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 16:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cqzV/ThvIdDd+2WpcibDLKVAL6UjaZAd1bM8sVxG9rw=; b=bdXJ5i+u/Biq64qzkGOuWW09gj
        ey7877J8/rewzFWbIKJo0PlpPd0vcRCk+7VgriBRlIgRbaNN+hsRxxlaG8GAd1T8GIr3PMoTi2/vz
        84WujFJS0jQYEwoxv7bk211mXUfdDuNUEaIVQwRGJ5eLrqFH9hE/KKtvQSJQU773XC2qLbopd61Iq
        rT6zQvOsA4EX8nB1dZT2M85zNOYqHTGSsgqkRn4SG7RPSZ9X7sL7Mt+TH4RdilU4AdZoG3jGaRMtF
        Ob41pbA9arlJnrU+Dx61tiYUnwpE+LcYVmSLBQvG40yfubtrND6RVP1DQUSFnthJzEkv3Km5yuS54
        U0Ad7Bxg==;
Received: from 246-30-196-88.dyn.estpak.ee ([88.196.30.246]:49930 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1nGT5r-0006ce-5L; Sat, 05 Feb 2022 23:59:44 +0200
Received: by localhost (sSMTP sendmail emulation); Sat, 05 Feb 2022 23:59:42 +0200
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     bgolaszewski@baylibre.com, brgl@bgdev.pl
Cc:     andy.shevchenko@gmail.com, geert+renesas@glider.be,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, drew@beagleboard.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Sat,  5 Feb 2022 23:59:18 +0200
Message-Id: <20220205215918.8924-3-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205215918.8924-1-maukka@ext.kapsi.fi>
References: <20210325122832.119147-1-sandberg@mailfence.com>
 <20220205215918.8924-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.196.30.246
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mailserv1.kapsi.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RESEND v8 2/2] gpio: gpio-cascade: add generic GPIO cascade
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for building cascades of GPIO lines. That is, it allows
setups when there is one upstream line and multiple cascaded lines, out
of which one can be chosen at a time. The status of the upstream line
can be conveyed to the selected cascaded line or, vice versa, the status
of the cascaded line can be conveyed to the upstream line.

A multiplexer is being used to select, which cascaded GPIO line is being
used at any given time.

At the moment only input direction is supported. In future it should be
possible to add support for output direction, too.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v7 -> v8:
 - rearrange members in struct gpio_cascade
 - cosmetic changes in file header and in one function declaration
 - added Reviewed-by tags by Linus and Andy
v6 -> v7:
 - In Kconfig add info about module name
 - adhere to new convention that allows lines longer than 80 chars
 - use dev_probe_err with upstream gpio line too
 - refactor for cleaner exit of probe function.
v5 -> v6:
 - In Kconfig, remove dependency to OF_GPIO and select only MULTIPLEXER
 - refactor code preferring one-liners
 - clean up prints, removing them from success-path.
 - don't explicitly set gpio_chip.of_node as it's done in the GPIO library
 - use devm_gpiochip_add_data instead of gpiochip_add
v4 -> v5:
 - renamed gpio-mux-input -> gpio-cascade. refactored code accordingly
   here and there and changed to use new bindings and compatible string
   - ambigious and vague 'pin' was rename to 'upstream_line'
 - dropped Tested-by and Reviewed-by due to changes in bindings
 - dropped Reported-by suggested by an automatic bot as it was not really
   appropriate to begin with
 - functionally it's the same as v4
v3 -> v4:
 - Changed author email
 - Included Tested-by and Reviewed-by from Drew
v2 -> v3:
 - use managed device resources
 - update Kconfig description
v1 -> v2:
 - removed .owner from platform_driver as per test bot's instruction
 - added MODULE_AUTHOR, MODULE_DESCRIPTION, MODULE_LICENSE
 - added gpio_mux_input_get_direction as it's recommended for all chips
 - removed because this is input only chip: gpio_mux_input_set_value
 - removed because they are not needed for input/output only chips:
     gpio_mux_input_direction_input
     gpio_mux_input_direction_output
 - fixed typo in an error message
 - added info message about successful registration
 - removed can_sleep flag as this does not sleep while getting GPIO value
   like I2C or SPI do
 - Updated description in Kconfig
---
 drivers/gpio/Kconfig        |  15 +++++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-cascade.c | 117 ++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/gpio/gpio-cascade.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2031a727be30..b9201d29a2d2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1701,4 +1701,19 @@ config GPIO_SIM
 
 endmenu
 
+comment "Other GPIO expanders"
+
+config GPIO_CASCADE
+	tristate "General GPIO cascade"
+	select MULTIPLEXER
+	help
+	  Say yes here to enable support for generic GPIO cascade.
+
+	  This allows building one-to-many cascades of GPIO lines using
+	  different types of multiplexers readily available. At the
+	  moment only input lines are supported.
+
+	  To build the driver as a module choose 'm' and the resulting module
+	  will be called 'gpio-cascade'.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1a14e248bdbd..6cb0e5c42fc5 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_GPIO_BD9571MWV)		+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)		+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)		+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CADENCE)		+= gpio-cadence.o
+obj-$(CONFIG_GPIO_CASCADE)		+= gpio-cascade.o
 obj-$(CONFIG_GPIO_CLPS711X)		+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_SNPS_CREG)		+= gpio-creg-snps.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)		+= gpio-crystalcove.o
diff --git a/drivers/gpio/gpio-cascade.c b/drivers/gpio/gpio-cascade.c
new file mode 100644
index 000000000000..5cbda882d79a
--- /dev/null
+++ b/drivers/gpio/gpio-cascade.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  A generic GPIO cascade driver
+ *
+ *  Copyright (C) 2021 Mauri Sandberg <maukka@ext.kapsi.fi>
+ *
+ * This allows building cascades of GPIO lines in a manner illustrated
+ * below:
+ *
+ *                 /|---- Cascaded GPIO line 0
+ *  Upstream      | |---- Cascaded GPIO line 1
+ *  GPIO line ----+ | .
+ *                | | .
+ *                 \|---- Cascaded GPIO line n
+ *
+ * A multiplexer is being used to select, which cascaded line is being
+ * addressed at any given time.
+ *
+ * At the moment only input mode is supported due to lack of means for
+ * testing output functionality. At least theoretically output should be
+ * possible with open drain constructions.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/mux/consumer.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+
+struct gpio_cascade {
+	struct gpio_chip	gpio_chip;
+	struct device		*parent;
+	struct mux_control	*mux_control;
+	struct gpio_desc	*upstream_line;
+};
+
+static struct gpio_cascade *chip_to_cascade(struct gpio_chip *gc)
+{
+	return container_of(gc, struct gpio_cascade, gpio_chip);
+}
+
+static int gpio_cascade_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static int gpio_cascade_get_value(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_cascade *cas = chip_to_cascade(gc);
+	int ret;
+
+	ret = mux_control_select(cas->mux_control, offset);
+	if (ret)
+		return ret;
+
+	ret = gpiod_get_value(cas->upstream_line);
+	mux_control_deselect(cas->mux_control);
+	return ret;
+}
+
+static int gpio_cascade_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_cascade *cas;
+	struct mux_control *mc;
+	struct gpio_desc *upstream;
+	struct gpio_chip *gc;
+
+	cas = devm_kzalloc(dev, sizeof(*cas), GFP_KERNEL);
+	if (!cas)
+		return -ENOMEM;
+
+	mc = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(mc))
+		return dev_err_probe(dev, PTR_ERR(mc), "unable to get mux-control\n");
+
+	cas->mux_control = mc;
+	upstream = devm_gpiod_get(dev, "upstream",  GPIOD_IN);
+	if (IS_ERR(upstream))
+		return dev_err_probe(dev, PTR_ERR(upstream), "unable to claim upstream GPIO line\n");
+
+	cas->upstream_line = upstream;
+	cas->parent = dev;
+
+	gc = &cas->gpio_chip;
+	gc->get = gpio_cascade_get_value;
+	gc->get_direction = gpio_cascade_get_direction;
+	gc->base = -1;
+	gc->ngpio = mux_control_states(mc);
+	gc->label = dev_name(cas->parent);
+	gc->parent = cas->parent;
+	gc->owner = THIS_MODULE;
+
+	platform_set_drvdata(pdev, cas);
+	return devm_gpiochip_add_data(dev, &cas->gpio_chip, NULL);
+}
+
+static const struct of_device_id gpio_cascade_id[] = {
+	{ .compatible = "gpio-cascade" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, gpio_cascade_id);
+
+static struct platform_driver gpio_cascade_driver = {
+	.driver	= {
+		.name		= "gpio-cascade",
+		.of_match_table = gpio_cascade_id,
+	},
+	.probe	= gpio_cascade_probe,
+};
+module_platform_driver(gpio_cascade_driver);
+
+MODULE_AUTHOR("Mauri Sandberg <maukka@ext.kapsi.fi>");
+MODULE_DESCRIPTION("Generic GPIO cascade");
+MODULE_LICENSE("GPL");
-- 
2.25.1


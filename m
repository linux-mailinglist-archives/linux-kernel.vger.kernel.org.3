Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3967159F7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiHXKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHXKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:31:07 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81047C1BD;
        Wed, 24 Aug 2022 03:31:04 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.138.144])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 4BAE923F15D;
        Wed, 24 Aug 2022 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 24 Aug
 2022 12:31:02 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v3 4/4] leds: Add a multicolor LED driver to group monochromatic LEDs
Date:   Wed, 24 Aug 2022 12:30:32 +0200
Message-ID: <20220824103032.163451-5-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824103032.163451-1-jjhiblot@traphandler.com>
References: <20220824103032.163451-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG4EX1.emp2.local (172.16.2.31) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 18295592011232655835
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmoheftddtge
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By allowing to group multiple monochrome LED into multicolor LEDs,
all involved LEDs can be controlled in-sync. This enables using effects
using triggers, etc.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/leds/rgb/Kconfig                 |   6 +
 drivers/leds/rgb/Makefile                |   1 +
 drivers/leds/rgb/leds-group-multicolor.c | 153 +++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 204cf470beae..c2610c47a82d 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -2,6 +2,12 @@
 
 if LEDS_CLASS_MULTICOLOR
 
+config LEDS_GRP_MULTICOLOR
+	tristate "Multi-color LED grouping support"
+	help
+	  This option enables support for monochrome LEDs that are
+	  grouped into multicolor LEDs.
+
 config LEDS_PWM_MULTICOLOR
 	tristate "PWM driven multi-color LED Support"
 	depends on PWM
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index 0675bc0f6e18..4de087ad79bc 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_LEDS_GRP_MULTICOLOR)	+= leds-group-multicolor.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
new file mode 100644
index 000000000000..61f9e1954fc4
--- /dev/null
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * multi-color LED built with monochromatic LED devices
+ *
+ * Copyright 2022 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+ */
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct led_mcg_priv {
+	struct led_classdev_mc mc_cdev;
+	struct led_classdev **monochromatics;
+};
+
+static int led_mcg_set(struct led_classdev *cdev,
+			  enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct led_mcg_priv *priv =
+		container_of(mc_cdev, struct led_mcg_priv, mc_cdev);
+	int i;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	for (i = 0; i < mc_cdev->num_colors; i++) {
+		struct led_classdev *mono = priv->monochromatics[i];
+		int actual_led_brightness;
+
+		/*
+		 * Scale the intensity according the max brightness of the
+		 * monochromatic LED
+		 */
+		actual_led_brightness = DIV_ROUND_CLOSEST(
+			mono->max_brightness * mc_cdev->subled_info[i].brightness,
+			mc_cdev->led_cdev.max_brightness);
+
+		led_set_brightness(mono, actual_led_brightness);
+	}
+
+	return 0;
+}
+
+static int led_mcg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct mc_subled *subled;
+	struct led_mcg_priv *priv;
+	int i, count, ret;
+	unsigned int max_brightness;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	count = 0;
+	max_brightness = 0;
+	for (;;) {
+		struct led_classdev *led_cdev;
+
+		led_cdev = devm_of_led_get(dev, count);
+		if (IS_ERR(led_cdev)) {
+			/* Reached the end of the list ? */
+			if (PTR_ERR(led_cdev) == -ENOENT)
+				break;
+			return dev_err_probe(dev, PTR_ERR(led_cdev),
+					     "Unable to get led #%d", count);
+		}
+		count++;
+
+		priv->monochromatics = devm_krealloc(dev, priv->monochromatics,
+					count * sizeof(*priv->monochromatics),
+					GFP_KERNEL);
+		if (!priv->monochromatics)
+			return -ENOMEM;
+
+		priv->monochromatics[count - 1] = led_cdev;
+
+		max_brightness = max(max_brightness, led_cdev->max_brightness);
+	}
+
+	subled = devm_kzalloc(dev, count * sizeof(*subled), GFP_KERNEL);
+	if (!subled)
+		return -ENOMEM;
+	priv->mc_cdev.subled_info = subled;
+
+	for (i = 0; i < count; i++) {
+		struct led_classdev *led_cdev = priv->monochromatics[i];
+
+		subled[i].color_index = led_cdev->color;
+		/* configure the LED intensity to its maximum */
+		subled[i].intensity = max_brightness;
+	}
+
+	/* init the multicolor's LED class device */
+	cdev = &priv->mc_cdev.led_cdev;
+	cdev->flags = LED_CORE_SUSPENDRESUME;
+	cdev->brightness_set_blocking = led_mcg_set;
+	cdev->max_brightness = max_brightness;
+	cdev->color = LED_COLOR_ID_MULTI;
+	priv->mc_cdev.num_colors = count;
+
+	init_data.fwnode = dev_fwnode(dev);
+	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev,
+							&init_data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"failed to register multicolor led for %s.\n",
+			cdev->name);
+
+	ret = led_mcg_set(cdev, cdev->brightness);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to set led value for %s.",
+				     cdev->name);
+
+	for (i = 0; i < count; i++) {
+		struct led_classdev *led_cdev = priv->monochromatics[i];
+
+		/* Make the sysfs of the monochromatic LED read-only */
+		led_cdev->flags |= LED_SYSFS_DISABLE;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_led_mcg_match[] = {
+	{ .compatible = "leds-group-multicolor" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_led_mcg_match);
+
+static struct platform_driver led_mcg_driver = {
+	.probe		= led_mcg_probe,
+	.driver		= {
+		.name	= "leds_group_multicolor",
+		.of_match_table = of_led_mcg_match,
+	}
+};
+module_platform_driver(led_mcg_driver);
+
+MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
+MODULE_DESCRIPTION("multi-color LED group driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-group-multicolor");
-- 
2.25.1


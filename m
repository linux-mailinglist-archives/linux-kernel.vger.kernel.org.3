Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011954CD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbiFOPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiFOPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:49:41 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E022EA26;
        Wed, 15 Jun 2022 08:49:39 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.138.51])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 501EE10CA5424;
        Wed, 15 Jun 2022 17:49:38 +0200 (CEST)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Wed, 15 Jun
 2022 17:49:37 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH 4/4] leds: Add a multicolor LED driver to group monochromatic LEDs
Date:   Wed, 15 Jun 2022 17:49:18 +0200
Message-ID: <20220615154918.521687-5-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615154918.521687-1-jjhiblot@traphandler.com>
References: <20220615154918.521687-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS1.emp2.local (172.16.1.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 18415781830034274779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvuddgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/leds/rgb/Kconfig                 |   7 +
 drivers/leds/rgb/Makefile                |   1 +
 drivers/leds/rgb/leds-group-multicolor.c | 177 +++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 204cf470beae..b50790385561 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -2,6 +2,13 @@
 
 if LEDS_CLASS_MULTICOLOR
 
+config LEDS_GRP_MULTICOLOR
+	tristate "multi-color LED grouping Support"
+	depends on PWM
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
index 000000000000..872854aed6eb
--- /dev/null
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * multi-color LED built with monochromatic LED devices
+ *
+ * This driver is derived from the leds-pwm-multicolor driver
+ *
+ * Copyright 2022 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+ */
+
+#include <linux/err.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct led_mcg_priv {
+	struct led_classdev_mc mc_cdev;
+	struct led_classdev *monochromatics[];
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
+	return 0;
+}
+
+static int iterate_subleds(struct device *dev, struct led_mcg_priv *priv,
+			   struct fwnode_handle *mcnode)
+{
+	struct mc_subled *subled = priv->mc_cdev.subled_info;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	/* iterate over the nodes inside the multi-led node */
+	fwnode_for_each_child_node(mcnode, fwnode) {
+		u32 color;
+		struct led_classdev *led_cdev;
+
+		led_cdev = devm_fwnode_led_get(dev, fwnode, 0);
+		if (IS_ERR(led_cdev)) {
+			ret = PTR_ERR(led_cdev);
+			dev_err(dev, "unable to request LED: %d\n", ret);
+			goto release_fwnode;
+		}
+		priv->monochromatics[priv->mc_cdev.num_colors] = led_cdev;
+
+		ret = fwnode_property_read_u32(fwnode, "color", &color);
+		if (ret) {
+			dev_err(dev, "cannot read color: %d\n", ret);
+			goto release_fwnode;
+		}
+		subled[priv->mc_cdev.num_colors].color_index = color;
+
+		/* Make the sysfs of the monochromatic LED read-only */
+		led_cdev->flags |= LED_SYSFS_DISABLE;
+
+		priv->mc_cdev.num_colors++;
+	}
+
+	return 0;
+
+release_fwnode:
+	fwnode_handle_put(fwnode);
+	return ret;
+}
+
+static int led_mcg_probe(struct platform_device *pdev)
+{
+	struct fwnode_handle *mcnode, *fwnode;
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct mc_subled *subled;
+	struct led_mcg_priv *priv;
+	int count = 0;
+	int ret = 0;
+
+	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
+	if (!mcnode)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "expected multi-led node\n");
+
+	/* count the nodes inside the multi-led node */
+	fwnode_for_each_child_node(mcnode, fwnode)
+		count++;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, monochromatics, count),
+			    GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto release_mcnode;
+	}
+
+	subled = devm_kcalloc(&pdev->dev, count, sizeof(*subled), GFP_KERNEL);
+	if (!subled) {
+		ret = -ENOMEM;
+		goto release_mcnode;
+	}
+	priv->mc_cdev.subled_info = subled;
+
+	/* init the multicolor's LED class device */
+	cdev = &priv->mc_cdev.led_cdev;
+	fwnode_property_read_u32(mcnode, "max-brightness",
+				 &cdev->max_brightness);
+	cdev->flags = LED_CORE_SUSPENDRESUME;
+	cdev->brightness_set_blocking = led_mcg_set;
+
+	ret = iterate_subleds(&pdev->dev, priv, mcnode);
+	if (ret)
+		goto release_mcnode;
+
+	init_data.fwnode = mcnode;
+	ret = devm_led_classdev_multicolor_register_ext(&pdev->dev,
+							&priv->mc_cdev,
+							&init_data);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register multicolor led for %s: %d\n",
+			cdev->name, ret);
+		goto release_mcnode;
+	}
+
+	ret = led_mcg_set(cdev, cdev->brightness);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set led value for %s: %d",
+				     cdev->name, ret);
+
+	return 0;
+
+release_mcnode:
+	fwnode_handle_put(mcnode);
+	return ret;
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


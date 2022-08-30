Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7645A6D00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiH3TTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiH3TTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:19:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E613786F2;
        Tue, 30 Aug 2022 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661887169; x=1693423169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uJOZWhccZ3us4fdCO9fKE4vmJtXRD4HlA06beGQNfHw=;
  b=lb9nNXEax2LUVXAkkSfwUPVVLpM6HTCztnfvYy/b+zmTgcTX4sH/HuPj
   oVFj1jctUUAUVa7hfP76OI8UWHnnIDm4YwXI9FFLQkjT10vpgVacIDXMH
   BHT5Zm/x8XwGQrdbqmXIH0Uj7ukPQKJbFucyUTXZfsDKoFSg1082u5W5x
   w4nbK6Bn4ZKXMV4v5hMTu2jh1ABOpaF7o58MmIQ7EqkV60nnoQtT2Zd5K
   q6n/Obklyif9sXVx6wAETiNvTfZYj4PwufNaMuIhtGxJhZg8F8B/cs/jw
   rZFLHrYuryoENQrbGFC2HrTQexSXWAx6RAVBrLx1ljO5RyFUdJgcXrI71
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381577716"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381577716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 12:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="588745431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 12:19:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E6D0AD; Tue, 30 Aug 2022 22:19:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: rockchip: Switch to use fwnode instead of of_node
Date:   Tue, 30 Aug 2022 22:19:39 +0300
Message-Id: <20220830191939.56436-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-rockchip.c       | 32 ++++++++++++++++--------------
 drivers/pinctrl/pinctrl-rockchip.h |  6 ++++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index bb50335239ac..6e847f326ff4 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "../pinctrl/core.h"
@@ -518,7 +519,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	struct irq_chip_generic *gc;
 	int ret;
 
-	bank->domain = irq_domain_add_linear(bank->of_node, 32,
+	bank->domain = irq_domain_create_linear(bank->fwnode, 32,
 					&irq_generic_chip_ops, NULL);
 	if (!bank->domain) {
 		dev_warn(bank->dev, "could not init irq domain for bank %s\n",
@@ -606,14 +607,14 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	 * files which don't set the "gpio-ranges" property or systems that
 	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
 	 */
-	if (!of_property_read_bool(bank->of_node, "gpio-ranges")) {
-		struct device_node *pctlnp = of_get_parent(bank->of_node);
+	if (!fwnode_property_read_bool(bank->fwnode, "gpio-ranges")) {
+		struct fwnode_handle *parent = fwnode_get_parent(bank->fwnode);
 		struct pinctrl_dev *pctldev = NULL;
 
 		if (!pctlnp)
 			return -ENODATA;
 
-		pctldev = of_pinctrl_get(pctlnp);
+		pctldev = of_pinctrl_get(to_of_node(parent));
 		if (!pctldev)
 			return -ENODEV;
 
@@ -641,10 +642,11 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 {
+	struct device_node *node = to_of_node(bank->fwnode);
 	struct resource res;
 	int id = 0;
 
-	if (of_address_to_resource(bank->of_node, 0, &res)) {
+	if (of_address_to_resource(node, 0, &res)) {
 		dev_err(bank->dev, "cannot find IO resource for bank\n");
 		return -ENOENT;
 	}
@@ -653,11 +655,11 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
-	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
+	bank->irq = irq_of_parse_and_map(node, 0);
 	if (!bank->irq)
 		return -EINVAL;
 
-	bank->clk = of_clk_get(bank->of_node, 0);
+	bank->clk = of_clk_get(node, 0);
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
@@ -668,7 +670,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
-		bank->db_clk = of_clk_get(bank->of_node, 1);
+		bank->db_clk = of_clk_get(node, 1);
 		if (IS_ERR(bank->db_clk)) {
 			dev_err(bank->dev, "cannot find debounce clk\n");
 			clk_disable_unprepare(bank->clk);
@@ -704,22 +706,22 @@ rockchip_gpio_find_bank(struct pinctrl_dev *pctldev, int id)
 static int rockchip_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *pctlnp = of_get_parent(np);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct fwnode_handle *parent = fwnode_get_parent(fwnode);
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
 	struct rockchip_pin_deferred *cfg;
 	static int gpio;
 	int id, ret;
 
-	if (!np || !pctlnp)
+	if (!parent)
 		return -ENODEV;
 
-	pctldev = of_pinctrl_get(pctlnp);
+	pctldev = of_pinctrl_get(to_of_node(parent));
 	if (!pctldev)
 		return -EPROBE_DEFER;
 
-	id = of_alias_get_id(np, "gpio");
+	id = of_alias_get_id(to_of_node(fwnode), "gpio");
 	if (id < 0)
 		id = gpio++;
 
@@ -728,7 +730,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	bank->dev = dev;
-	bank->of_node = np;
+	bank->fwnode = fwnode;
 
 	raw_spin_lock_init(&bank->slock);
 
@@ -776,7 +778,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	mutex_unlock(&bank->deferred_lock);
 
 	platform_set_drvdata(pdev, bank);
-	dev_info(dev, "probed %pOF\n", np);
+	dev_info(dev, "probed %pfw\n", fwnode);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4759f336941e..411ed6a09842 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -18,6 +18,8 @@
 #ifndef _PINCTRL_ROCKCHIP_H
 #define _PINCTRL_ROCKCHIP_H
 
+struct fwnode_handle;
+
 #define RK_GPIO0_A0	0
 #define RK_GPIO0_A1	1
 #define RK_GPIO0_A2	2
@@ -299,7 +301,7 @@ struct rockchip_drv {
  * @drv: array describing the 4 drive strength sources of the bank
  * @pull_type: array describing the 4 pull type sources of the bank
  * @valid: is all necessary information present
- * @of_node: dt node of this bank
+ * @fwnode: firmware node of this bank
  * @drvdata: common pinctrl basedata
  * @domain: irqdomain of the gpio bank
  * @gpio_chip: gpiolib chip
@@ -327,7 +329,7 @@ struct rockchip_pin_bank {
 	struct rockchip_drv		drv[4];
 	enum rockchip_pin_pull_type	pull_type[4];
 	bool				valid;
-	struct device_node		*of_node;
+	struct fwnode_handle		*fwnode;
 	struct rockchip_pinctrl		*drvdata;
 	struct irq_domain		*domain;
 	struct gpio_chip		gpio_chip;
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1685AB84E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIBSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIBSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8790110DB4;
        Fri,  2 Sep 2022 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143211; x=1693679211;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gF2xAfEfw1RkrefI6n8YgdfanuwDVgivOEmhvTPqu1c=;
  b=SlO92U+qBNpzWKyEFa5PPso60wWgxx7HDe3oPlYf6xE8cOpobMYS5XxS
   35GgvFbIoL1oL+QJsStVsLZ5knevpauxh9VDkDcSf6tu7aD0XSadM9D+3
   VWjmZ15fRjpRMRSzkESly34tGU+h32Fw9Y3/Q2YvYDyA+QVMw6ChExZt1
   3M2aZu6XXwWBvJETEz9fVbc2kC8rK0mFZUep4jM0KTe+a4GIza+huVeDU
   stA77mnuxf2uU8KrXoeWwts8+lfRbzvI4Eu38b49fO2IwbOrIMXosxYCI
   mQvCY0N8Rf5/g94y6qH7QKlqncRv4SpXQV4tmNi1sn9X4PEmLv4HWvbT9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="283034559"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="283034559"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="681373080"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5FF5874E; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 15/17] pinctrl: cy8c95x0: Override IRQ for one of the expanders on Galileo Gen 1
Date:   Fri,  2 Sep 2022 21:26:48 +0300
Message-Id: <20220902182650.83098-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI table on Intel Galileo Gen 1 has wrong pin number for IRQ resource
of the I²C GPIO expander. Since we know what that number is and luckily
have GPIO bases fixed for SoC's controllers, we may use a simple DMI quirk
to match the platform and retrieve GpioInt() pin on it for the expander in
question.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 5d8a7d236e62..f38e7dc794e9 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -7,7 +7,9 @@
  * Author: Naresh Solanki <Naresh.Solanki@9elements.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/dmi.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -73,6 +75,46 @@ static const struct of_device_id cy8c95x0_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, cy8c95x0_dt_ids);
 
+static const struct acpi_gpio_params cy8c95x0_irq_gpios = { 0, 0, true };
+
+static const struct acpi_gpio_mapping cy8c95x0_acpi_irq_gpios[] = {
+	{ "irq-gpios", &cy8c95x0_irq_gpios, 1, ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER },
+	{ }
+};
+
+static int cy8c95x0_acpi_get_irq(struct device *dev)
+{
+	int ret;
+
+	ret = devm_acpi_dev_add_driver_gpios(dev, cy8c95x0_acpi_irq_gpios);
+	if (ret)
+		dev_warn(dev, "can't add GPIO ACPI mapping\n");
+
+	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq-gpios", 0);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "ACPI interrupt quirk (IRQ %d)\n", ret);
+	return ret;
+}
+
+static const struct dmi_system_id cy8c95x0_dmi_acpi_irq_info[] = {
+	{
+		/*
+		 * On Intel Galileo Gen 1 board the IRQ pin is provided
+		 * as an absolute number instead of being relative.
+		 * Since first controller (gpio-sch.c) and second
+		 * (gpio-dwapb.c) are at the fixed bases, we may safely
+		 * refer to the number in the global space to get an IRQ
+		 * out of it.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Galileo"),
+		},
+	},
+	{}
+};
+
 #define MAX_BANK 8
 #define BANK_SZ 8
 #define MAX_LINE	(MAX_BANK * BANK_SZ)
@@ -1298,6 +1340,12 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	bitmap_set(chip->shiftmask, 0, 20);
 	mutex_init(&chip->i2c_lock);
 
+	if (dmi_first_match(cy8c95x0_dmi_acpi_irq_info)) {
+		ret = cy8c95x0_acpi_get_irq(&client->dev);
+		if (ret > 0)
+			client->irq = ret;
+	}
+
 	if (client->irq) {
 		ret = cy8c95x0_irq_setup(chip, client->irq);
 		if (ret)
-- 
2.35.1


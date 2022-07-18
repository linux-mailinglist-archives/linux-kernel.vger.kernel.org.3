Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36B578237
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiGRMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiGRMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58274255BD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147016; x=1689683016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEbCFHg68tZmu025HMgO4Fk35zKaYiYB2ChwyWGOdBM=;
  b=lL4zk+xSvcnFE3AvcB9UNPYDEW3GrXbPiGCFP1dRFPchlqWymq9g3pqf
   N/SWQKL+sMxf+yW8kdWRWQoiFapa651CA+usb43sMeIKr76HaOWLHcFlo
   Qw8xdnZUPRcIt5EmtGYiU9InBOkJtM8X0cwIzUTCc8tXXcfbvv4wVI3k9
   Uq/rMtl5dd1O9cyGNZyAOmU9iZU+M+hQ5utf1kWe6tIb5Ef8qY0tbRvQr
   3OH2aqaF2isJpcdAhN2sVDgn0yMM1zDhHtpb5eJ+/YfRDj/WCX7L5Ip0x
   +r46nCkQW3fvtDd/KtgteAq2WWT/x4pNLlDKpOkIo6EWZf+QOiyURDOkK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="311887742"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311887742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="547467342"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2022 05:23:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6F5A63ED; Mon, 18 Jul 2022 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RESEND][PATCH v1 6/9] mfd: intel_soc_pmic_crc: Replace intel_soc_pmic with crystal_cove
Date:   Mon, 18 Jul 2022 15:23:25 +0300
Message-Id: <20220718122328.8287-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reflect the point that this driver is only for one type of the PMICs,
replace intel_soc_pmic with crystal_cove (avoid using crc for possible
namespace collisions with CRC library APIs).

Note, also rename the driver name since we don't expect any user
that enumerates by it, only ACPI known so far.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_soc_pmic_crc.c | 42 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index edadc07d473e..bb3cc1a808f0 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -140,7 +140,7 @@ static struct pwm_lookup crc_pwm_lookup[] = {
 	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
 };
 
-struct intel_soc_pmic_config {
+struct crystal_cove_config {
 	unsigned long irq_flags;
 	struct mfd_cell *cell_dev;
 	int n_cell_devs;
@@ -148,7 +148,7 @@ struct intel_soc_pmic_config {
 	const struct regmap_irq_chip *irq_chip;
 };
 
-static const struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
+static const struct crystal_cove_config crystal_cove_config_byt_crc = {
 	.irq_flags = IRQF_TRIGGER_RISING,
 	.cell_dev = crystal_cove_byt_dev,
 	.n_cell_devs = ARRAY_SIZE(crystal_cove_byt_dev),
@@ -156,7 +156,7 @@ static const struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
 	.irq_chip = &crystal_cove_irq_chip,
 };
 
-static const struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
+static const struct crystal_cove_config crystal_cove_config_cht_crc = {
 	.irq_flags = IRQF_TRIGGER_RISING,
 	.cell_dev = crystal_cove_cht_dev,
 	.n_cell_devs = ARRAY_SIZE(crystal_cove_cht_dev),
@@ -164,17 +164,17 @@ static const struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
 	.irq_chip = &crystal_cove_irq_chip,
 };
 
-static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c)
+static int crystal_cove_i2c_probe(struct i2c_client *i2c)
 {
-	const struct intel_soc_pmic_config *config;
+	const struct crystal_cove_config *config;
 	struct device *dev = &i2c->dev;
 	struct intel_soc_pmic *pmic;
 	int ret;
 
 	if (soc_intel_is_byt())
-		config = &intel_soc_pmic_config_byt_crc;
+		config = &crystal_cove_config_byt_crc;
 	else
-		config = &intel_soc_pmic_config_cht_crc;
+		config = &crystal_cove_config_cht_crc;
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
@@ -209,7 +209,7 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c)
 			       NULL, 0, regmap_irq_get_domain(pmic->irq_chip_data));
 }
 
-static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
+static int crystal_cove_i2c_remove(struct i2c_client *i2c)
 {
 	/* remove crc-pwm lookup table */
 	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
@@ -219,7 +219,7 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
+static void crystal_cove_shutdown(struct i2c_client *i2c)
 {
 	struct intel_soc_pmic *pmic = i2c_get_clientdata(i2c);
 
@@ -228,7 +228,7 @@ static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 	return;
 }
 
-static int intel_soc_pmic_suspend(struct device *dev)
+static int crystal_cove_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
@@ -237,7 +237,7 @@ static int intel_soc_pmic_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_soc_pmic_resume(struct device *dev)
+static int crystal_cove_resume(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
@@ -246,26 +246,26 @@ static int intel_soc_pmic_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(crystal_cove_pm_ops, intel_soc_pmic_suspend, intel_soc_pmic_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(crystal_cove_pm_ops, crystal_cove_suspend, crystal_cove_resume);
 
-static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
+static const struct acpi_device_id crystal_cove_acpi_match[] = {
 	{ "INT33FD" },
 	{ },
 };
-MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
+MODULE_DEVICE_TABLE(acpi, crystal_cove_acpi_match);
 
-static struct i2c_driver intel_soc_pmic_i2c_driver = {
+static struct i2c_driver crystal_cove_i2c_driver = {
 	.driver = {
-		.name = "intel_soc_pmic_i2c",
+		.name = "crystal_cove_i2c",
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
-		.acpi_match_table = intel_soc_pmic_acpi_match,
+		.acpi_match_table = crystal_cove_acpi_match,
 	},
-	.probe_new = intel_soc_pmic_i2c_probe,
-	.remove = intel_soc_pmic_i2c_remove,
-	.shutdown = intel_soc_pmic_shutdown,
+	.probe_new = crystal_cove_i2c_probe,
+	.remove = crystal_cove_i2c_remove,
+	.shutdown = crystal_cove_shutdown,
 };
 
-module_i2c_driver(intel_soc_pmic_i2c_driver);
+module_i2c_driver(crystal_cove_i2c_driver);
 
 MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
 MODULE_LICENSE("GPL v2");
-- 
2.35.1


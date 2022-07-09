Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0456CB89
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGIVQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGIVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6AEE031;
        Sat,  9 Jul 2022 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657401409; x=1688937409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+ofhCbDZykQwVdyHdm3UxiLC+50EGf6D2NMkpPemDk=;
  b=Jm/CdRQdkNOvF1k1OdEMYFgp+cZIFKLCZiwU/yygHjCNvnN4O7rFkd31
   rkup3x8bhgTWEwupm03GtAhcDgOLaDc6LTgAK1OJWm9VIIzIoAbhAtJ1f
   5hCeM8pQoZoGgWEX2D3OWAX5bNYhP4JX+Mq2FMrad/R1oXlmcmS457V1P
   2cbyERubnXptnUjoCySQCuuOuj5nQhdYuV2bnZO1WoYi9oxdg3NqRHEws
   A6Aum2RhDk6X2aDiWLWsHFlPAprIeYq/6aynlN0qXQjvKwAnW93CHqvMB
   uNxV/XFZsGARjfyZPv4cQ8esT0NKUqqdGSyLPpoI9zFuNHGRz3VNM3qXg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="310055314"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="310055314"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="840620835"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2022 14:16:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C4727F1; Sun, 10 Jul 2022 00:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/6] platform/x86: serial-multi-instantiate: Drop duplicate check
Date:   Sun, 10 Jul 2022 00:16:49 +0300
Message-Id: <20220709211653.18938-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
References: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_get_match_data() checks for firmware node to be present,
there is no need to check for ACPI companion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on changed previous patch(es)
 .../platform/x86/serial-multi-instantiate.c   | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 366087a9fce2..a1e04be858c5 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -81,16 +81,16 @@ static void smi_devs_unregister(struct smi *smi)
 /**
  * smi_spi_probe - Instantiate multiple SPI devices from inst array
  * @pdev:	Platform device
- * @adev:	ACPI device
  * @smi:	Internal struct for Serial multi instantiate driver
  * @inst_array:	Array of instances to probe
  *
  * Returns the number of SPI devices instantiate, Zero if none is found or a negative error code.
  */
-static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
+static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 			 const struct smi_instance *inst_array)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct spi_controller *ctlr;
 	struct spi_device *spi_dev;
 	char name[50];
@@ -166,17 +166,17 @@ static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev,
 /**
  * smi_i2c_probe - Instantiate multiple I2C devices from inst array
  * @pdev:	Platform device
- * @adev:	ACPI device
  * @smi:	Internal struct for Serial multi instantiate driver
  * @inst_array:	Array of instances to probe
  *
  * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
  */
-static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
+static int smi_i2c_probe(struct platform_device *pdev, struct smi *smi,
 			 const struct smi_instance *inst_array)
 {
 	struct i2c_board_info board_info = {};
 	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	char name[32];
 	int i, ret, count;
 
@@ -230,14 +230,9 @@ static int smi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct smi_node *node;
-	struct acpi_device *adev;
 	struct smi *smi;
 	int ret;
 
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return -ENODEV;
-
 	node = device_get_match_data(dev);
 	if (!node) {
 		dev_dbg(dev, "Error ACPI match data is missing\n");
@@ -252,9 +247,9 @@ static int smi_probe(struct platform_device *pdev)
 
 	switch (node->bus_type) {
 	case SMI_I2C:
-		return smi_i2c_probe(pdev, adev, smi, node->instances);
+		return smi_i2c_probe(pdev, smi, node->instances);
 	case SMI_SPI:
-		return smi_spi_probe(pdev, adev, smi, node->instances);
+		return smi_spi_probe(pdev, smi, node->instances);
 	case SMI_AUTO_DETECT:
 		/*
 		 * For backwards-compatibility with the existing nodes I2C
@@ -264,10 +259,10 @@ static int smi_probe(struct platform_device *pdev)
 		 * SpiSerialBus nodes that were previously ignored, and this
 		 * preserves that behavior.
 		 */
-		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
+		ret = smi_i2c_probe(pdev, smi, node->instances);
 		if (ret != -ENOENT)
 			return ret;
-		return smi_spi_probe(pdev, adev, smi, node->instances);
+		return smi_spi_probe(pdev, smi, node->instances);
 	default:
 		return -EINVAL;
 	}
-- 
2.35.1


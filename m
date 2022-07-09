Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7767556C53E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGIAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGIAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6197C655B0;
        Fri,  8 Jul 2022 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325201; x=1688861201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RAmP1zmZqEEh81I7jPo8Lw24kbG1K8aqOqSBiNfhc4k=;
  b=eWG1nqAYGqWA9H1VcKWToE6cSiq6fRzWL7dqNQhqP6XD2qrF7YZuZ1tE
   KlDeeFAs3XwahY/s/hpgAcBvt+9zydrCa5MOkWCjnC4/kytZmRoDjbdP6
   /Cppx07GxclSMbsJgQIegnA7kwgaVGhZ60R61+hZViRJkLsxWuYIcdb+R
   +JcztDmT7QjSxWJn/SSMhGQRsf1LQzvbIAKd2oyiIp/Uycf+5pS/UDJYO
   rqVsxvgrjtR8pwcSPnb2TkWw4LIMHByXRDV0cv6TrL5otIcKSI2t3g2hc
   U0KUUG8Lk0tyhLI5r+LBPH3W1J+VBTb1wDYWSBdnVORCM5wZG/n/5rrBD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284411873"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284411873"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="721038546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2022 17:06:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C7C6AD; Sat,  9 Jul 2022 03:06:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/7] platform/x86: serial-multi-instantiate: Drop duplicate check
Date:   Sat,  9 Jul 2022 03:06:32 +0300
Message-Id: <20220709000636.35550-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_get_match_data() checks for firmware node to be present,
there is no need to check for ACPI companion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../platform/x86/serial-multi-instantiate.c   | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index e599058196bb..ceb0e414b9f5 100644
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
@@ -252,14 +247,14 @@ static int smi_probe(struct platform_device *pdev)
 
 	switch (node->bus_type) {
 	case SMI_I2C:
-		return smi_i2c_probe(pdev, adev, smi, node->instances);
+		return smi_i2c_probe(pdev, smi, node->instances);
 	case SMI_SPI:
-		return smi_spi_probe(pdev, adev, smi, node->instances);
+		return smi_spi_probe(pdev, smi, node->instances);
 	case SMI_AUTO_DETECT:
-		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
+		ret = smi_i2c_probe(pdev, smi, node->instances);
 		if (ret && ret != -ENOENT)
 			return ret;
-		ret = smi_spi_probe(pdev, adev, smi, node->instances);
+		ret = smi_spi_probe(pdev, smi, node->instances);
 		if (ret && ret != -ENOENT)
 			return ret;
 		if (ret)
-- 
2.35.1


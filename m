Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D184C974E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiCAUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiCAUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:51:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6255D26102
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646167843; x=1677703843;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rkyXUz1vj1mqzAK3zAiAgdUNAFAz9kvv/ECi26k+bGc=;
  b=Oa7u2aWMf3oSa9rutgDdi4+lhEtHK3df0fbWUPmEI6MWNkuUz9ZK0pUM
   JEWKjljOt6c++DSBFDpv0wOKBq7pm8GFHIoDbmLyWz/hkDkaFng/yc/dZ
   KnlMMQ2h/19IuwudAhInfxN2vOAUJ7NA7yZE1wx7I75LrJGfceHrZjKk/
   5rQD/ppeuxi2cWiWDZF47AuNHGL9hOVKgQYFd4SMwIWOGTk+oRcSJv7jt
   4DGtVC3u5qYqbFR+UK2ziQ8KbGssrCsM/EnbXxahiJip/rrTWJ/Gd2d7C
   C8wfjKVegRjItnrUq7Dz5rWUONr9WCIbiDFYyfDlpgnbNUa2zDWUyZeGC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233209533"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233209533"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 12:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641416373"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 12:50:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84C1B183; Tue,  1 Mar 2022 22:50:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the driver
Date:   Tue,  1 Mar 2022 22:50:56 +0200
Message-Id: <20220301205056.79810-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI driver wants to know the exact type of the controller.
Provide this information to it, hence it allows to fix the
Intel Cannon Lake and others in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 41 ++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index f2ea6540a01e..a143c8dca2d9 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -15,11 +15,22 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/pxa2xx_ssp.h>
 
 #include "intel-lpss.h"
 
+static const struct property_entry spt_spi_properties[] = {
+	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_SPT_SSP),
+	{ }
+};
+
+static const struct software_node spt_spi_node = {
+	.properties = spt_spi_properties,
+};
+
 static const struct intel_lpss_platform_info spt_info = {
 	.clk_rate = 120000000,
+	.swnode = &spt_spi_node,
 };
 
 static const struct property_entry spt_i2c_properties[] = {
@@ -53,8 +64,18 @@ static const struct intel_lpss_platform_info spt_uart_info = {
 	.swnode = &uart_node,
 };
 
+static const struct property_entry bxt_spi_properties[] = {
+	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BXT_SSP),
+	{ }
+};
+
+static const struct software_node bxt_spi_node = {
+	.properties = bxt_spi_properties,
+};
+
 static const struct intel_lpss_platform_info bxt_info = {
 	.clk_rate = 100000000,
+	.swnode = &bxt_spi_node,
 };
 
 static const struct property_entry bxt_i2c_properties[] = {
@@ -89,6 +110,20 @@ static const struct intel_lpss_platform_info apl_i2c_info = {
 	.swnode = &apl_i2c_node,
 };
 
+static const struct property_entry cnl_spi_properties[] = {
+	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_CNL_SSP),
+	{ }
+};
+
+static const struct software_node cnl_spi_node = {
+	.properties = cnl_spi_properties,
+};
+
+static const struct intel_lpss_platform_info cnl_info = {
+	.clk_rate = 120000000,
+	.swnode = &cnl_spi_node,
+};
+
 static const struct intel_lpss_platform_info cnl_i2c_info = {
 	.clk_rate = 216000000,
 	.swnode = &spt_i2c_node,
@@ -108,8 +143,8 @@ static const struct acpi_device_id intel_lpss_acpi_ids[] = {
 	{ "INT3449", (kernel_ulong_t)&spt_uart_info },
 	{ "INT344A", (kernel_ulong_t)&spt_uart_info },
 	/* CNL */
-	{ "INT34B0", (kernel_ulong_t)&spt_info },
-	{ "INT34B1", (kernel_ulong_t)&spt_info },
+	{ "INT34B0", (kernel_ulong_t)&cnl_info },
+	{ "INT34B1", (kernel_ulong_t)&cnl_info },
 	{ "INT34B2", (kernel_ulong_t)&cnl_i2c_info },
 	{ "INT34B3", (kernel_ulong_t)&cnl_i2c_info },
 	{ "INT34B4", (kernel_ulong_t)&cnl_i2c_info },
@@ -119,7 +154,7 @@ static const struct acpi_device_id intel_lpss_acpi_ids[] = {
 	{ "INT34B8", (kernel_ulong_t)&spt_uart_info },
 	{ "INT34B9", (kernel_ulong_t)&spt_uart_info },
 	{ "INT34BA", (kernel_ulong_t)&spt_uart_info },
-	{ "INT34BC", (kernel_ulong_t)&spt_info },
+	{ "INT34BC", (kernel_ulong_t)&cnl_info },
 	/* BXT */
 	{ "80860AAC", (kernel_ulong_t)&bxt_i2c_info },
 	{ "80860ABC", (kernel_ulong_t)&bxt_info },
-- 
2.34.1


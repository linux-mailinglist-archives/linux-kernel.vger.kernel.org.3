Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE01A4C204E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbiBWX4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245053AbiBWX4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:56:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402EF5DE4B;
        Wed, 23 Feb 2022 15:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645660571; x=1677196571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F89N5cDix69I9AbMbC/5C8QfuzPxnaxankQDwbVbuXQ=;
  b=J6QUS17JLQJAnKXJEsWqkFRbsST78XpYZX1mR+vD+StNY1Fl9A1oT7WI
   tiCl8WqUAl/Y5FlXSAexDClAEtuhOW38rzuCILxcmqwOEjSBdX7wNaMI7
   BHksvCs5vn21cUwsVPNe9YJx6/UhR3H3R6pT6n+9BgPGs1a1qZ82aEbBZ
   klaFthi2l3jM4pgQ0DsghYA/MPS/vczIKPWhky8/O1/tIUUGDw7O/SD/n
   00Q1/ebozkVw5DVxzCHtqTk+P2KpPldZIOcvsHISZsZ8iJB9xo5cstGzt
   tZD+NxnMNLItn5OJCNR2fJTGlyK6JvUxiRfB8lFeoITh65Ciw/pJ1EO0Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315335962"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315335962"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="574018500"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 15:56:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9F4F3F9; Thu, 24 Feb 2022 01:56:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/3] ACPI: lpss: Provide an SSP type to the driver
Date:   Thu, 24 Feb 2022 01:56:22 +0200
Message-Id: <20220223235622.19555-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
References: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
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

The SPI driver wants to know the exact type of the controller. Provide this
information to it, hence allow to fix Intel Wildcat Point case in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c28954411af9..fbe0756259c5 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -21,6 +21,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
+#include <linux/pxa2xx_ssp.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
 
@@ -219,10 +220,16 @@ static void bsw_pwm_setup(struct lpss_private_data *pdata)
 	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
 }
 
-static const struct lpss_device_desc lpt_dev_desc = {
+static const struct property_entry lpt_spi_properties[] = {
+	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_LPT_SSP),
+	{ }
+};
+
+static const struct lpss_device_desc lpt_spi_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
 			| LPSS_SAVE_CTX,
 	.prv_offset = 0x800,
+	.properties = lpt_spi_properties,
 };
 
 static const struct lpss_device_desc lpt_i2c_dev_desc = {
@@ -282,9 +289,15 @@ static const struct lpss_device_desc bsw_uart_dev_desc = {
 	.properties = uart_properties,
 };
 
+static const struct property_entry byt_spi_properties[] = {
+	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BYT_SSP),
+	{ }
+};
+
 static const struct lpss_device_desc byt_spi_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
 	.prv_offset = 0x400,
+	.properties = byt_spi_properties,
 };
 
 static const struct lpss_device_desc byt_sdio_dev_desc = {
@@ -305,11 +318,17 @@ static const struct lpss_device_desc bsw_i2c_dev_desc = {
 	.resume_from_noirq = true,
 };
 
+static const struct property_entry bsw_spi_properties[] = {
+	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BSW_SSP),
+	{ }
+};
+
 static const struct lpss_device_desc bsw_spi_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX
 			| LPSS_NO_D3_DELAY,
 	.prv_offset = 0x400,
 	.setup = lpss_deassert_reset,
+	.properties = bsw_spi_properties,
 };
 
 static const struct x86_cpu_id lpss_cpu_ids[] = {
@@ -329,8 +348,8 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INTL9C60", LPSS_ADDR(lpss_dma_desc) },
 
 	/* Lynxpoint LPSS devices */
-	{ "INT33C0", LPSS_ADDR(lpt_dev_desc) },
-	{ "INT33C1", LPSS_ADDR(lpt_dev_desc) },
+	{ "INT33C0", LPSS_ADDR(lpt_spi_dev_desc) },
+	{ "INT33C1", LPSS_ADDR(lpt_spi_dev_desc) },
 	{ "INT33C2", LPSS_ADDR(lpt_i2c_dev_desc) },
 	{ "INT33C3", LPSS_ADDR(lpt_i2c_dev_desc) },
 	{ "INT33C4", LPSS_ADDR(lpt_uart_dev_desc) },
@@ -356,8 +375,8 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "808622C1", LPSS_ADDR(bsw_i2c_dev_desc) },
 
 	/* Broadwell LPSS devices */
-	{ "INT3430", LPSS_ADDR(lpt_dev_desc) },
-	{ "INT3431", LPSS_ADDR(lpt_dev_desc) },
+	{ "INT3430", LPSS_ADDR(lpt_spi_dev_desc) },
+	{ "INT3431", LPSS_ADDR(lpt_spi_dev_desc) },
 	{ "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
 	{ "INT3433", LPSS_ADDR(lpt_i2c_dev_desc) },
 	{ "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
@@ -366,7 +385,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT3437", },
 
 	/* Wildcat Point LPSS devices */
-	{ "INT3438", LPSS_ADDR(lpt_dev_desc) },
+	{ "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
 
 	{ }
 };
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73102470427
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbhLJPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:45:51 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59426 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243000AbhLJPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:45:44 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BACurAQ000494;
        Fri, 10 Dec 2021 09:42:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=XrnF6YfdnNKFeMn/V4qMHV3tDq9BK40/tRRsos4brQI=;
 b=RULwfwiu6IlRH07b22tAu8+T2iA3WWrxaA++ZQBUW1pYF1NmfQdrA4vOxftB0hihQnEN
 GpaYaIlDQYjVywMtiVORKtiUlAPbgP3REzhSU+3KRanupfVnMRm1Qv0UY0IK7UusOemN
 gSTZWe25qNLTwC6/nXRmk8fRO7WwPaFT8CHNnA6fhfetdRB+A00YkV1ZU+99oe7uYHX1
 5PPV2/DQnGSuglUGDiSnQAaQ4v8eO+FR3ulyuPvw6/pPkgTreleBfNSue9hHHMs+B3D/
 fE03NZYAzzWoZ2HAjhYGVKRK8VckVgkgUDP1ipGKJq1BUYeNL/nKLgsqsCDSSCrQXv4U BQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cuds09y4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Dec 2021 09:42:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 15:41:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 15:41:58 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F82D478;
        Fri, 10 Dec 2021 15:41:58 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 3/6] platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
Date:   Fri, 10 Dec 2021 15:40:47 +0000
Message-ID: <20211210154050.3713-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iTztqA9Q0kOtUf6BmxOuBtV6T8CAT7dM
X-Proofpoint-ORIG-GUID: iTztqA9Q0kOtUf6BmxOuBtV6T8CAT7dM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Moving I2C multi instantiate driver to drivers/acpi folder for
upcoming conversion into a generic bus multi instantiate
driver for SPI and I2C

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 MAINTAINERS                                           |  2 +-
 drivers/acpi/Kconfig                                  | 11 +++++++++++
 drivers/acpi/Makefile                                 |  1 +
 .../{platform/x86 => acpi}/i2c-multi-instantiate.c    |  0
 drivers/acpi/scan.c                                   |  2 +-
 drivers/platform/x86/Kconfig                          | 11 -----------
 drivers/platform/x86/Makefile                         |  1 -
 7 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/{platform/x86 => acpi}/i2c-multi-instantiate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd55b83878e0..25e056854772 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -391,7 +391,7 @@ ACPI I2C MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/i2c-multi-instantiate.c
+F:	drivers/acpi/i2c-multi-instantiate.c
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c97ee0cfe26e..6200d13fa97b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -295,6 +295,17 @@ config ACPI_PROCESSOR
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
 
+config ACPI_I2C_MULTI_INST
+	tristate "I2C multi instantiate pseudo device driver"
+	depends on I2C
+	help
+	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
+	  firmware-node. This driver will instantiate separate i2c-clients
+	  for each device in the firmware-node.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called i2c-multi-instantiate.
+
 config ACPI_IPMI
 	tristate "IPMI"
 	depends on IPMI_HANDLER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3018714e87d9..98d700d55960 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
+obj-$(CONFIG_ACPI_I2C_MULTI_INST)	+= i2c-multi-instantiate.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/acpi/i2c-multi-instantiate.c
similarity index 100%
rename from drivers/platform/x86/i2c-multi-instantiate.c
rename to drivers/acpi/i2c-multi-instantiate.c
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5991dddbc9ce..e5c81b3df09c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1700,7 +1700,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * must be instantiated for each, each with its own i2c_device_id.
 	 * Normally we only instantiate an i2c-client for the first resource,
 	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
+	 * drivers/acpi/i2c-multi-instantiate.c driver, which knows
 	 * which i2c_device_id to use for each resource.
 	 */
 	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 97e87628eb35..1596c8e5bc9b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -958,17 +958,6 @@ config TOPSTAR_LAPTOP
 
 	  If you have a Topstar laptop, say Y or M here.
 
-config I2C_MULTI_INSTANTIATE
-	tristate "I2C multi instantiate pseudo device driver"
-	depends on I2C && ACPI
-	help
-	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
-	  firmware-node. This driver will instantiate separate i2c-clients
-	  for each device in the firmware-node.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called i2c-multi-instantiate.
-
 config MLX_PLATFORM
 	tristate "Mellanox Technologies platform support"
 	depends on I2C && REGMAP
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 219478061683..dc075a036874 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -108,7 +108,6 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
 obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
-obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
-- 
2.25.1


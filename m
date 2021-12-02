Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855F84667D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359444AbhLBQ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:28:39 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:4180 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347619AbhLBQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:32 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B24r9Mv013038;
        Thu, 2 Dec 2021 10:24:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=76HTMV8KbuUL5hsVdys0VO+mEyDn+msgMSgJlOog7K4=;
 b=Y3REhZ04kM3AQEHk9wtmbsS/ZnDyq6jd0WT5j+KMDqj4ynlraKnZB/oicROtcZM0etL8
 y6MrvLmmmmXYWw/n3E13z+I9mXC+Lc2MpnzBue76C2KnvEeoBCWwEcRcAE9AHRM28OOZ
 p8kYMUT+sslG56wGmNV/meKvJnjtrRMEOxpxDdqIGcO2vam3pmMWZrLvNxWVmWOrbqPl
 REvCTsRyhF2Tt48eg9Wdm1dMck1p/m9jjwh7h8qNpyNsJn4EpkUk9mjJ3khX9DqgPm+w
 GZ/PkDR9G5rLr/+rAM+tB0LCoMqolksXUSDJf+Z0ISpk0GSp8u2HALla/htaHp1HAvby ZA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cp6c89wp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Dec 2021 10:24:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 16:24:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 2 Dec 2021 16:24:57 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.136])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7F7212AA;
        Thu,  2 Dec 2021 16:24:56 +0000 (UTC)
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
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 1/3] spi: Revert "spi: Remove unused function spi_busnum_to_master()"
Date:   Thu, 2 Dec 2021 16:24:19 +0000
Message-ID: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B7iDop18gN-_w8BoDZtY6kLxaA4i6EHT
X-Proofpoint-GUID: B7iDop18gN-_w8BoDZtY6kLxaA4i6EHT
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Revert commit bdc7ca008e1f ("spi: Remove unused function
spi_busnum_to_master()")
This function is needed for the spi version of i2c multi
instantiate driver.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 Documentation/spi/spi-summary.rst |  8 +++++++
 drivers/spi/spi.c                 | 35 +++++++++++++++++++++++++++++++
 include/linux/spi/spi.h           |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index aab5d07cb3d7..d4239025461d 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -336,6 +336,14 @@ certainly includes SPI devices hooked up through the card connectors!
 Non-static Configurations
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 
+Developer boards often play by different rules than product boards, and one
+example is the potential need to hotplug SPI devices and/or controllers.
+
+For those cases you might need to use spi_busnum_to_master() to look
+up the spi bus master, and will likely need spi_new_device() to provide the
+board info based on the board that was hotplugged.  Of course, you'd later
+call at least spi_unregister_device() when that board is removed.
+
 When Linux includes support for MMC/SD/SDIO/DataFlash cards through SPI, those
 configurations will also be dynamic.  Fortunately, such devices all support
 basic device identification probes, so they should hotplug normally.
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8726309b3eaf..7c81173edb0c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3145,6 +3145,41 @@ int spi_controller_resume(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_controller_resume);
 
+static int __spi_controller_match(struct device *dev, const void *data)
+{
+	struct spi_controller *ctlr;
+	const u16 *bus_num = data;
+
+	ctlr = container_of(dev, struct spi_controller, dev);
+	return ctlr->bus_num == *bus_num;
+}
+
+/**
+ * spi_busnum_to_master - look up master associated with bus_num
+ * @bus_num: the master's bus number
+ * Context: can sleep
+ *
+ * This call may be used with devices that are registered after
+ * arch init time.  It returns a refcounted pointer to the relevant
+ * spi_controller (which the caller must release), or NULL if there is
+ * no such master registered.
+ *
+ * Return: the SPI master structure on success, else NULL.
+ */
+struct spi_controller *spi_busnum_to_master(u16 bus_num)
+{
+	struct device		*dev;
+	struct spi_controller	*ctlr = NULL;
+
+	dev = class_find_device(&spi_master_class, NULL, &bus_num,
+				__spi_controller_match);
+	if (dev)
+		ctlr = container_of(dev, struct spi_controller, dev);
+	/* reference got in class_find_device */
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(spi_busnum_to_master);
+
 /*-------------------------------------------------------------------------*/
 
 /* Core methods for spi_message alterations */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index eb7ac8a1e03c..5f2781cb750f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -759,6 +759,8 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
+extern struct spi_controller *spi_busnum_to_master(u16 busnum);
+
 /*
  * SPI resource management while processing a SPI message
  */
-- 
2.25.1


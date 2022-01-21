Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33BC4963CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380454AbiAURZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:25:14 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14416 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379690AbiAURZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:25:08 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LH9K5G013193;
        Fri, 21 Jan 2022 11:24:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=esQa06hrgOMJ8WsoJmpq9RLqCEOqwnnCnVua0114bvg=;
 b=apYGzumxPAaG4NV9XFYCRtjgx9/wFlQIUhkVHyK6jcbcJluI6GG5lGK6JtNpPBDSbQgh
 Rq+u67Y05OUC5k3sKobW7QF0vRcB8FBQuBd9YANgFiCqyAUxw5rksvQnzPTU//YYiO9x
 sXto1i7nPsVoEg9mZF/G8h4WxVC+X2o3H8SSGMr6lyP3aIEDudC46+p/GhExX1eESEj6
 LXyhprXLzH4xLg60q2/BVDEhAEUvHxI14CoR4S0G+sgP8+XW/r/0iRWBqFBiB8Z8ylww
 C+ZwbpobL/Sy63J4E0tCGzUdWT1ZuNlU6aDCy61487F2teu129qnBb8ex0Irv/JXG27B OQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhynrw8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:24:51 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 17:24:50 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 17:24:50 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9F122B0E;
        Fri, 21 Jan 2022 17:24:49 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 2/9] spi: Create helper API to lookup ACPI info for spi device
Date:   Fri, 21 Jan 2022 17:24:24 +0000
Message-ID: <20220121172431.6876-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8bb6J0N7VfGZFvd5MF1j64IEo8fjc7R9
X-Proofpoint-GUID: 8bb6J0N7VfGZFvd5MF1j64IEo8fjc7R9
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can then be used to find a spi resource inside an
ACPI node, and allocate a spi device.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/spi/spi.c       | 46 ++++++++++++++++++++++++++++++++---------
 include/linux/spi/spi.h |  6 ++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1eb84101c4ad..13f4701f0694 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2410,8 +2410,18 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
-static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
-					    struct acpi_device *adev)
+/**
+ * acpi_spi_device_alloc - Allocate a spi device, and fill it in with ACPI information
+ * @ctlr: controller to which the spi device belongs
+ * @adev: ACPI Device for the spi device
+ *
+ * This should be used to allocate a new spi device from and ACPI Node.
+ * The caller is responsible for calling spi_add_device to register the spi device.
+ *
+ * Return: a pointer to the new device, or ERR_PTR on error.
+ */
+struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
+					 struct acpi_device *adev)
 {
 	acpi_handle parent_handle = NULL;
 	struct list_head resource_list;
@@ -2419,10 +2429,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	struct spi_device *spi;
 	int ret;
 
-	if (acpi_bus_get_status(adev) || !adev->status.present ||
-	    acpi_device_enumerated(adev))
-		return AE_OK;
-
 	lookup.ctlr		= ctlr;
 	lookup.irq		= -1;
 
@@ -2433,7 +2439,7 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 
 	if (ret < 0)
 		/* found SPI in _CRS but it points to another controller */
-		return AE_OK;
+		return ERR_PTR(-ENODEV);
 
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
@@ -2443,16 +2449,15 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	}
 
 	if (!lookup.max_speed_hz)
-		return AE_OK;
+		return ERR_PTR(-ENODEV);
 
 	spi = spi_alloc_device(ctlr);
 	if (!spi) {
 		dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
 			dev_name(&adev->dev));
-		return AE_NO_MEMORY;
+		return ERR_PTR(-ENOMEM);
 	}
 
-
 	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->max_speed_hz	= lookup.max_speed_hz;
 	spi->mode		|= lookup.mode;
@@ -2460,6 +2465,27 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	spi->bits_per_word	= lookup.bits_per_word;
 	spi->chip_select	= lookup.chip_select;
 
+	return spi;
+}
+EXPORT_SYMBOL_GPL(acpi_spi_device_alloc);
+
+static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
+					    struct acpi_device *adev)
+{
+	struct spi_device *spi;
+
+	if (acpi_bus_get_status(adev) || !adev->status.present ||
+	    acpi_device_enumerated(adev))
+		return AE_OK;
+
+	spi = acpi_spi_device_alloc(ctlr, adev);
+	if (IS_ERR(spi)) {
+		if (PTR_ERR(spi) == -ENOMEM)
+			return AE_NO_MEMORY;
+		else
+			return AE_OK;
+	}
+
 	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
 			  sizeof(spi->modalias));
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0346a3ff27fd..d159cef12f1a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 
 #include <uapi/linux/spi/spi.h>
+#include <linux/acpi.h>
 
 struct dma_chan;
 struct software_node;
@@ -759,6 +760,11 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
+#if IS_ENABLED(CONFIG_ACPI)
+extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
+						struct acpi_device *adev);
+#endif
+
 /*
  * SPI resource management while processing a SPI message
  */
-- 
2.25.1


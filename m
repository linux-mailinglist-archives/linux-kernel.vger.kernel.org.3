Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF7B4928E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbiAROyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:54:49 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:22172 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344413AbiAROyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:54:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I1MV5r021792;
        Tue, 18 Jan 2022 08:53:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0TVxBDOiUr12OuPIFyA5/1w1LgYsgtcjV4mdb8rtSok=;
 b=qDkFadmL0/AgDz3iGm2PqcfT5jD93kZENaZ1VVlhLsHu0YaP2weGHS3ZAvfR2ZjK91/t
 3i8U8OxjkWprjVkbrpwcMwmljHNKlT7kH0WMC2mi4nzgxJArpJxaxFJnl7lyG3BJNhCU
 b/qt5F/YgCVh6Xt02jVguJ3i6wCUKnEfMkf3npLrCYdIGFbQtwvqagRasm9zgmOrLx4E
 TythIy33G/ka07Dnks9uiDmsZG2tnhGPt49cerOHGaYm4SvjHtRZ1YV6Bi/dF3rT7MxV
 f+dYcWpqOnV0Iwm29gV0lKLKQ3l5DKvZP/8g5t6FyAf1MVPBSaY9N01Glz5FTFrB88vR WQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhs9na-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 08:53:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 14:53:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 18 Jan 2022 14:53:35 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F055A7C;
        Tue, 18 Jan 2022 14:53:33 +0000 (UTC)
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
Subject: [PATCH v3 03/10] spi: Support selection of the index of the ACPI Spi Resource before alloc
Date:   Tue, 18 Jan 2022 14:52:44 +0000
Message-ID: <20220118145251.1548-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UVvcDV_Co8DZNT7JBlCqRXOznYoUWqtl
X-Proofpoint-ORIG-GUID: UVvcDV_Co8DZNT7JBlCqRXOznYoUWqtl
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a node contains more than one Spi Resources, it may be necessary to
use an index to select which one you want to allocate a spi device for.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/spi/spi.c       | 56 +++++++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  6 +++--
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 13f4701f0694..898cc9931490 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2320,6 +2320,9 @@ struct acpi_spi_lookup {
 	int			irq;
 	u8			bits_per_word;
 	u8			chip_select;
+	int			n;
+	int			index;
+	int			irq_index;
 };
 
 static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
@@ -2351,6 +2354,8 @@ static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
 		lookup->mode |= SPI_CPHA;
 }
 
+static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
+
 static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct acpi_spi_lookup *lookup = data;
@@ -2364,14 +2369,35 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 		sb = &ares->data.spi_serial_bus;
 		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_SPI) {
 
+			if (lookup->index != -1 && lookup->n++ != lookup->index)
+				return 1;
+
+			if (lookup->index == -1 && !ctlr)
+				return -ENODEV;
+
 			status = acpi_get_handle(NULL,
 						 sb->resource_source.string_ptr,
 						 &parent_handle);
 
-			if (ACPI_FAILURE(status) ||
-			    ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
+			if (ACPI_FAILURE(status))
 				return -ENODEV;
 
+			if (ctlr) {
+				if (ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
+					return -ENODEV;
+			} else {
+				struct acpi_device *adev;
+
+				if (acpi_bus_get_device(parent_handle, &adev))
+					return -ENODEV;
+
+				ctlr = acpi_spi_find_controller_by_adev(adev);
+				if (!ctlr)
+					return -ENODEV;
+
+				lookup->ctlr = ctlr;
+			}
+
 			/*
 			 * ACPI DeviceSelection numbering is handled by the
 			 * host controller driver in Windows and can vary
@@ -2402,7 +2428,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 	} else if (lookup->irq < 0) {
 		struct resource r;
 
-		if (acpi_dev_resource_interrupt(ares, 0, &r))
+		if (acpi_dev_resource_interrupt(ares, lookup->irq_index, &r))
 			lookup->irq = r.start;
 	}
 
@@ -2414,14 +2440,22 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
  * acpi_spi_device_alloc - Allocate a spi device, and fill it in with ACPI information
  * @ctlr: controller to which the spi device belongs
  * @adev: ACPI Device for the spi device
+ * @index: Index of the spi resource inside the ACPI Node
+ * @irq_index: Index of the GPIO resource for the IRQ inside the ACPI Node
  *
  * This should be used to allocate a new spi device from and ACPI Node.
  * The caller is responsible for calling spi_add_device to register the spi device.
  *
+ * If ctlr is set to NULL, the Controller for the spi device will be looked up
+ * using the resource.
+ * If index is set to -1, index is not used.
+ * Note: If index is -1, ctlr must be set.
+ *
  * Return: a pointer to the new device, or ERR_PTR on error.
  */
 struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
-					 struct acpi_device *adev)
+					 struct acpi_device *adev,
+					 int index, int irq_index)
 {
 	acpi_handle parent_handle = NULL;
 	struct list_head resource_list;
@@ -2429,8 +2463,14 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	struct spi_device *spi;
 	int ret;
 
+	if (!ctlr && index == -1)
+		return ERR_PTR(-EINVAL);
+
 	lookup.ctlr		= ctlr;
 	lookup.irq		= -1;
+	lookup.index		= index;
+	lookup.n		= 0;
+	lookup.irq_index	= irq_index;
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
@@ -2443,7 +2483,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
-	    ACPI_HANDLE(ctlr->dev.parent) == parent_handle) {
+	    ACPI_HANDLE(lookup.ctlr->dev.parent) == parent_handle) {
 		/* Apple does not use _CRS but nested devices for SPI slaves */
 		acpi_spi_parse_apple_properties(adev, &lookup);
 	}
@@ -2451,9 +2491,9 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	if (!lookup.max_speed_hz)
 		return ERR_PTR(-ENODEV);
 
-	spi = spi_alloc_device(ctlr);
+	spi = spi_alloc_device(lookup.ctlr);
 	if (!spi) {
-		dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
+		dev_err(&lookup.ctlr->dev, "failed to allocate SPI device for %s\n",
 			dev_name(&adev->dev));
 		return ERR_PTR(-ENOMEM);
 	}
@@ -2478,7 +2518,7 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	    acpi_device_enumerated(adev))
 		return AE_OK;
 
-	spi = acpi_spi_device_alloc(ctlr, adev);
+	spi = acpi_spi_device_alloc(ctlr, adev, -1, 0);
 	if (IS_ERR(spi)) {
 		if (PTR_ERR(spi) == -ENOMEM)
 			return AE_NO_MEMORY;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 200725692b93..1a34fd0f6ca2 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -762,10 +762,12 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
 
 #if IS_ENABLED(CONFIG_ACPI)
 extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
-						struct acpi_device *adev);
+						struct acpi_device *adev,
+						int index, int irq_index);
 #else
 static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
-						       struct acpi_device *adev);
+						       struct acpi_device *adev,
+						       int index, int irq_index);
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.25.1


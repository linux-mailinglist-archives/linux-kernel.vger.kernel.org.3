Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80F44928DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbiAROyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:54:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37848 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344409AbiAROyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:54:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I1MV5s021792;
        Tue, 18 Jan 2022 08:53:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=pcJyyOGpZnRiEY9dUyz6ABiZtDZzkse/rMAEdl2+rng=;
 b=PRFKAvcV2Vl2pABiy3lB16mkHTidFSZZJDlSFLeGXhnI2lCzKNa989YKxfNqeQ97sARW
 utQhkXzP07Jw/MGIwH2vFvHzSq7oirqA8rT5q0kvmlG4lXRDeEihT61YbJ+s9jrPUDSn
 JAbDYF4ELFnZbqC4t4oP8owp2tcRptjRB2oX+kceqxf6nxQHl1550kYtwQgBB1jixetu
 PILo1zLdDGV0rHojDP5lHzAomZ0K+Dg8mEfOzzDAeeNk5y+9WDgyf/hVlhXsWGop46Gt
 qP7/45xHknGB9f9WqU58lXv+zI4Tcsj1dHXzsCPXF9o2rYkoyg2gSE3UbSek8z3BCOLg EA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhs9nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 08:53:39 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 14:53:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 18 Jan 2022 14:53:37 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CAAF5B13;
        Tue, 18 Jan 2022 14:53:35 +0000 (UTC)
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
Subject: [PATCH v3 04/10] spi: Add API to count spi acpi resources
Date:   Tue, 18 Jan 2022 14:52:45 +0000
Message-ID: <20220118145251.1548-5-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GC3p0QYSidBdkh6pznA6re4R5HfRV112
X-Proofpoint-ORIG-GUID: GC3p0QYSidBdkh6pznA6re4R5HfRV112
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ACPI nodes may have more than one Spi Resource.
To be able to handle these case, its necessary to have
a way of counting these resources.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/spi/spi.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  6 ++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 898cc9931490..8c0c2e26609a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2325,6 +2325,46 @@ struct acpi_spi_lookup {
 	int			irq_index;
 };
 
+static int acpi_spi_count(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_spi_serialbus *sb;
+	int *count = data;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	sb = &ares->data.spi_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
+		return 1;
+
+	*count = *count + 1;
+
+	return 1;
+}
+
+/**
+ * acpi_spi_count_resources - Count the number of SpiSerialBus resources
+ * @adev:	ACPI device
+ *
+ * Returns the number of SpiSerialBus resources in the ACPI-device's
+ * resource-list; or a negative error code.
+ */
+int acpi_spi_count_resources(struct acpi_device *adev)
+{
+	LIST_HEAD(r);
+	int count = 0;
+	int ret;
+
+	ret = acpi_dev_get_resources(adev, &r, acpi_spi_count, &count);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&r);
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(acpi_spi_count_resources);
+
 static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
 					    struct acpi_spi_lookup *lookup)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 1a34fd0f6ca2..25a82729f8da 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -764,6 +764,7 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
 extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 						struct acpi_device *adev,
 						int index, int irq_index);
+int acpi_spi_count_resources(struct acpi_device *adev);
 #else
 static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 						       struct acpi_device *adev,
@@ -771,6 +772,11 @@ static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ct
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+int acpi_spi_count_resources(struct acpi_device *adev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
-- 
2.25.1


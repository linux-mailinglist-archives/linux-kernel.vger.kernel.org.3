Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2AB470422
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbhLJPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:45:47 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:22662 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242993AbhLJPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:45:44 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BACurAP000494;
        Fri, 10 Dec 2021 09:41:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=+LsQfNrXPpS3619hB6d32pwpbK8k5wkGpt6c1VKkZRw=;
 b=qSW80zPmEcedRmYnP2bpFjWEdklPcazM3jJTzqvMSOCdQ/78E8qFndDYv/16a2ZtZnvY
 bdYbDnoWIYe3iumKidPDAY77Ir42IClaD4tv15P+RIT71TvYq60obwutMGDY0nWjPk53
 VKyW9x9Ss7sg7cVuqUghoXydppdltaxAdwLGRgn4l14FHHyKtlsCoa7Uaba4yutxnpHz
 LaWWqElXAUu04U+Zu9rUA5zt+ysW9HDimaMD3/Fs0AtngiiQtwcqJkSbpAn6jeIvkqT6
 UH2Fr1eNtkh0liTddf00lzJGfraOsu5fRdlhIYNao1MS2F8l27c5yGqfUcuJ1JGr/dKH tg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cuds09y4p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Dec 2021 09:41:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 15:41:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 15:41:57 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88249478;
        Fri, 10 Dec 2021 15:41:57 +0000 (UTC)
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
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/6] spi: Export acpi_spi_find_controller_by_adev to be used externally
Date:   Fri, 10 Dec 2021 15:40:45 +0000
Message-ID: <20211210154050.3713-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UV12cpRZQDJSAQbnJVVNVO7uErIxPTTs
X-Proofpoint-ORIG-GUID: UV12cpRZQDJSAQbnJVVNVO7uErIxPTTs
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used by bus-multi-instantiate to support spi.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/spi/spi.c       |  3 ++-
 include/linux/spi/spi.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8726309b3eaf..9495f776e53c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4200,7 +4200,7 @@ static int spi_acpi_controller_match(struct device *dev, const void *data)
 	return ACPI_COMPANION(dev->parent) == data;
 }
 
-static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
+struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
 
@@ -4214,6 +4214,7 @@ static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_devic
 
 	return container_of(dev, struct spi_controller, dev);
 }
+EXPORT_SYMBOL_GPL(acpi_spi_find_controller_by_adev);
 
 static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index eb7ac8a1e03c..8c2978853573 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -17,6 +17,7 @@
 #include <linux/ptp_clock_kernel.h>
 
 #include <uapi/linux/spi/spi.h>
+#include <linux/acpi.h>
 
 struct dma_chan;
 struct software_node;
@@ -759,6 +760,15 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
+#if IS_ENABLED(CONFIG_ACPI)
+extern struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
+#else
+static inline struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif
+
 /*
  * SPI resource management while processing a SPI message
  */
-- 
2.25.1


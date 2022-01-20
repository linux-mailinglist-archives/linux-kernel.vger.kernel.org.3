Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E5494F58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiATNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:44:09 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:48434 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238138AbiATNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:43:57 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K4mpgo024668;
        Thu, 20 Jan 2022 07:43:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=r1QsPUe+mR02d07aDE3r/XJQmdN13xFv+KvrQ+fIJg8=;
 b=jYuA4PnFrke2slTZ73rHYoJAIRvukwsOVQWHROvZIhlPHk0DTqR/J5SJGpkroZgdqTp9
 gzSl+LN5jeIyGoka8eUAY7ZOetVLkRySp2sCt1+eMCEpqGGPXO9pbADJklZsD7u3p3kt
 RQLawVQHOlWOuhZXlbA4sbNq7XdJH+iXYD0WkGhi97bOUZ8souDlT1gMQtMcKflOmBaC
 y8MejBhEIACTGSZsEQZ6yIjw8bivB3iAgdBtVQMok6gSmCCVImg9YovYRmT+Ft2mtO6i
 WFLJ/58TKekt1rja49s9vFCBEL4PvVVbeftvNB0ELAanHTxhV/RAaFYqrCXkVgULs8qN vw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dpk9mh838-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 07:43:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 13:43:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 13:43:43 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C51346D;
        Thu, 20 Jan 2022 13:43:43 +0000 (UTC)
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
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 9/9] ACPI / scan: Create platform device for CS35L41
Date:   Thu, 20 Jan 2022 13:43:26 +0000
Message-ID: <20220120134326.5295-10-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qQcJQLtTU6padvhcrx3b833Y5MFG8T5h
X-Proofpoint-GUID: qQcJQLtTU6padvhcrx3b833Y5MFG8T5h
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

The ACPI device with CSC3551 or CLSA0100 are sound cards
with multiple instances of CS35L41 connectec by I2C or SPI
to the main CPU.

We add an ID to the ignore_serial_bus_ids list to enumerate
all I2C or SPI devices correctly.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/acpi/scan.c                          |  3 +++
 drivers/platform/x86/bus-multi-instantiate.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4fd1346d6e1f..2f2210c969c8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1744,8 +1744,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 */
 		{"BSG1160", },
 		{"BSG2150", },
+		{"CSC3551", },
 		{"INT33FE", },
 		{"INT3515", },
+	/* Non-conforming _HID for Cirrus Logic already released */
+		{"CLSA0100", },
 	/*
 	 * HIDs of device with an UartSerialBusV2 resource for which userspace
 	 * expects a regular tty cdev to be created (instead of the in kernel
diff --git a/drivers/platform/x86/bus-multi-instantiate.c b/drivers/platform/x86/bus-multi-instantiate.c
index 05bc941a38fd..7a394b671f5a 100644
--- a/drivers/platform/x86/bus-multi-instantiate.c
+++ b/drivers/platform/x86/bus-multi-instantiate.c
@@ -328,6 +328,17 @@ static const struct bmi_node int3515_data = {
 	.bus_type = BMI_I2C,
 };
 
+static const struct bmi_node cs35l41_hda = {
+	.instances = {
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{}
+	},
+	.bus_type = BMI_AUTO_DETECT,
+};
+
 /*
  * Note new device-ids must also be added to bus_multi_instantiate_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -336,6 +347,9 @@ static const struct acpi_device_id bmi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "INT3515", (unsigned long)&int3515_data },
+	{ "CSC3551", (unsigned long)&cs35l41_hda },
+	/* Non-conforming _HID for Cirrus Logic already released */
+	{ "CLSA0100", (unsigned long)&cs35l41_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi_acpi_ids);
-- 
2.25.1


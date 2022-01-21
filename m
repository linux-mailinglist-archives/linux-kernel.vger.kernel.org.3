Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23D54963D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380913AbiAURZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:25:28 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28912 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380075AbiAURZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:25:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LH9VJK024708;
        Fri, 21 Jan 2022 11:24:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Jl86P14vvj6qjul91VFAINCu3Ysi21l3LKgfrp/ikQI=;
 b=QuzAMLvNa7bkGcJbImV+3NMNth0OqYRrC0gyNDX2/h8Z3ClwpBTOmg5p5+W8FUPXAZSl
 ECOjStvmpAUcjgD3hFsy3kew40KJ1ggFJE4qBuLJdrbMqt8bEFdzX7rIprVeEOqtf3Yq
 Vo/lOQIdy/e+Q3p9Bwg6MYnLIE//+7jvI4VX9ZVT6OVO1CZyGBPIx0s60cNTXVovR8og
 nYdv9oflITjGznjjqjjwv8we8Km+w291t86NDwgiwCZjt4b5Xq1f85dbxzNzomW847dQ
 +K9qPkOV7Jg6whmJFQaPSR8zIQ1+PpU/I/qOU7/hm77QeRkViyLVl6XYdS4IivLx5mDc 9A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq14dj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:24:55 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 17:24:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 17:24:54 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7C08545D;
        Fri, 21 Jan 2022 17:24:53 +0000 (UTC)
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
Subject: [PATCH v6 9/9] ACPI / scan: Create platform device for CS35L41
Date:   Fri, 21 Jan 2022 17:24:31 +0000
Message-ID: <20220121172431.6876-10-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _JcjjY0SkUVBs6xxvYbfoKItNaj2XU94
X-Proofpoint-ORIG-GUID: _JcjjY0SkUVBs6xxvYbfoKItNaj2XU94
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

The ACPI device with CSC3551 or CLSA0100 are sound cards
with multiple instances of CS35L41 connected by I2C or SPI
to the main CPU.

We add an ID to the ignore_serial_bus_ids list to enumerate
all I2C or SPI devices correctly.

The same IDs are also added into serial-multi-instantiate
so that the driver can correctly enumerate the ACPI.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/acpi/scan.c                             |  3 +++
 drivers/platform/x86/serial-multi-instantiate.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 48db5e80c2dc..ebd10af3ff7f 100644
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
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 3f05385ca2cf..d09f11eac4f8 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -308,6 +308,17 @@ static const struct smi_node int3515_data = {
 	.bus_type = SMI_I2C,
 };
 
+static const struct smi_node cs35l41_hda = {
+	.instances = {
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 /*
  * Note new device-ids must also be added to serial_multi_instantiate_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -316,6 +327,9 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "INT3515", (unsigned long)&int3515_data },
+	{ "CSC3551", (unsigned long)&cs35l41_hda },
+	/* Non-conforming _HID for Cirrus Logic already released */
+	{ "CLSA0100", (unsigned long)&cs35l41_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
-- 
2.25.1


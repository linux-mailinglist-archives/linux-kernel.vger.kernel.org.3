Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008F948DCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiAMRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:07:54 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:27518 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233696AbiAMRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:07:49 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DGAV43020998;
        Thu, 13 Jan 2022 11:07:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=GSiBkVP9UmloE0oIArp77dF5D6A7HQmpsTBzlpdvMyY=;
 b=VHybBKuHOuMu13cAI/5M7TPpZbLvYs2eSzykmjI8f57kUHaif2g9ZViibiMJjkb0P19u
 aBOg+nOF+esO59I+eH6mB9c54P/ISMrj8nrh17LWstrUucXs5kvUKRCpE11pdHzaniJB
 lOQYhp4hv7H+RFqjhoL7NS0mkbaivQEZ0kxBXjl7FwKEEt5cT93OYrHyyWACbqT2JUqo
 IFwtaUTjuCrtFGjzHhSKYqFFD9/gZOAk+ndrNzHkuUe6H01z2BsK0iae3nnXgIuv37pz
 RNafqMxCfNakLoUdA2e2znNnnZWW/HnPHPxEK4XquZqNkLmBBwBOs2M90PSIFfL6Ger8 hQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3djqcb026y-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Jan 2022 11:07:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 13 Jan
 2022 17:07:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 13 Jan 2022 17:07:32 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.50])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 23A6AB0E;
        Thu, 13 Jan 2022 17:07:32 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 5/5] ACPI / scan: Create platform device for CLSA0100
Date:   Thu, 13 Jan 2022 17:07:28 +0000
Message-ID: <20220113170728.1953559-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6hGjFieOBt8Dt08GJJouyJ77KoV70pmi
X-Proofpoint-ORIG-GUID: 6hGjFieOBt8Dt08GJJouyJ77KoV70pmi
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI device with CLSA0100 is a sound card with
multiple instances of CS35L41 connected by I2C to
the main CPU.

We add an ID to the i2c_multi_instantiate_idsi list
to enumerate all I2C slaves correctly.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/acpi/scan.c                          | 2 ++
 drivers/platform/x86/i2c-multi-instantiate.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c215bc8723d0..2a68031d953e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1753,6 +1753,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 */
 		{"BCM4752", },
 		{"LNV4752", },
+	/* Non-conforming _HID for Cirrus Logic already released */
+		{"CLSA0100", },
 		{}
 	};
 
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 4956a1df5b90..a51a74933fa9 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -147,6 +147,12 @@ static const struct i2c_inst_data int3515_data[]  = {
 	{}
 };
 
+static const struct i2c_inst_data cs35l41_hda[] = {
+	{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+	{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+	{}
+};
+
 /*
  * Note new device-ids must also be added to i2c_multi_instantiate_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -155,6 +161,8 @@ static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ "BSG2150", (unsigned long)bsg2150_data },
 	{ "INT3515", (unsigned long)int3515_data },
+	/* Non-conforming _HID for Cirrus Logic already released */
+	{ "CLSA0100", (unsigned long)cs35l41_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
-- 
2.34.1


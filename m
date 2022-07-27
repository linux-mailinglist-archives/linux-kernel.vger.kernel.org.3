Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40395823A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiG0KAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiG0KA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:00:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D5DA1A0;
        Wed, 27 Jul 2022 03:00:25 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4SNEg032560;
        Wed, 27 Jul 2022 04:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=OVWLOViijHvZ0gyrsr6sZosQT9smEiGwvFnRB0/TaRY=;
 b=mRbjPnM414VhyBwRFy9PC6SYYkXxG9KZHx50DRageHYP29fol+z3rOCN4NH4SluNwVPS
 Sl29+Ica17m9URmQU237sVDdieEvVJlOXM3IHctJN42WSKmBtqToO2vAlUmPMr+G50T4
 mdgYRf+57DBKJTzX81GCkIMy+QVVnI7qkZtFqfuD/SvexyJ6XWx6FmkYeHkDEQ0Jesh0
 713+YUqO9bGG4vWUyJfjWxLXRzy8x0nKSsOuiob0f1OUzD7+P9HgQnM6e+hb25EIdWka
 MFz9O0xzXMQBqIf6O2QJs0z6ILEU03RWj9GCpa0+uAMMs8ZtrZrLLdYqC7vRtQGGpbUv 5Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hged1vtk6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:59:32 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 04:59:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Wed, 27 Jul 2022 04:59:29 -0500
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E041E477;
        Wed, 27 Jul 2022 09:59:28 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Cameron Berkenpas <cam@neo-zeon.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 3/4] ACPI: scan: Add CLSA0101 Laptop Support
Date:   Wed, 27 Jul 2022 10:59:23 +0100
Message-ID: <20220727095924.80884-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
References: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AtdIxN_CFm9gOicAvdNFl88eKK2K7cCh
X-Proofpoint-ORIG-GUID: AtdIxN_CFm9gOicAvdNFl88eKK2K7cCh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CLSA0101 id to the ignore_serial_bus_ids
so serial-multi-instantiate can correctly
instantiate the driver.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b100e6ca9bb4..42cec8120f18 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1722,6 +1722,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		{"INT3515", },
 		/* Non-conforming _HID for Cirrus Logic already released */
 		{"CLSA0100", },
+		{"CLSA0101", },
 	/*
 	 * Some ACPI devs contain SerialBus resources even though they are not
 	 * attached to a serial bus at all.
-- 
2.37.1


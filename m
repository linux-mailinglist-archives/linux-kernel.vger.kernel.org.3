Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB5490C16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbiAQQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:08:50 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:27314 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240726AbiAQQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:08:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HFFYHB025138;
        Mon, 17 Jan 2022 10:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Q2jmIUxxgQlvMQHeVaQWubU1ZkCD95Vx51R0jGfn5TM=;
 b=SNG04o8dV/i9+3DIaf0FHZoKf1fe1PwPGBB0tHUdhQfQ9rbrB3D3TVg7BOypgqigsg+z
 MbwTEGwYA+hBU82NsZ69f0SVm7BXlDSvXgP/oxCKMQ90H9+TRSRxm892PVN8d7SR2mhG
 JvNE68N7OHagLa3a55hC5TgLJutBNvMzmDVeL7BNKwahXfMIJa/Yb2MXjdL+V9az7fgl
 ZfMwaMBguL0hsjFtSEq32RegT5nob1J5MX8fqAjNQOGUmEoZEEULmsrFrAad1281Sjbc
 URJB9FbS3I7DKK5n76S4EUk00qbUSDUraMDHL317Os8mW8jm7nNxEIosmi6YPmbEYGRV HA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhr22f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 10:08:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 16:08:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 16:08:32 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 80DEB459;
        Mon, 17 Jan 2022 16:08:32 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 3/6] ALSA: hda: cs35l41: Move cs35l41* calls to its own symbol namespace
Date:   Mon, 17 Jan 2022 16:08:27 +0000
Message-ID: <20220117160830.709403-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
References: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6pceskFdUxspxGs1oRjnSlbngedhwVgk
X-Proofpoint-ORIG-GUID: 6pceskFdUxspxGs1oRjnSlbngedhwVgk
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create own namespace and avoid polluting the global namespace

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

V2: No changes

---
 sound/pci/hda/cs35l41_hda.c     | 5 ++---
 sound/pci/hda/cs35l41_hda_i2c.c | 1 +
 sound/pci/hda/cs35l41_hda_spi.c | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 509a380f9be7..c4f25e48dcc0 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -514,7 +514,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs35l41_hda_probe);
+EXPORT_SYMBOL_NS_GPL(cs35l41_hda_probe, SND_HDA_SCODEC_CS35L41);
 
 int cs35l41_hda_remove(struct device *dev)
 {
@@ -528,8 +528,7 @@ int cs35l41_hda_remove(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cs35l41_hda_remove);
-
+EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
 MODULE_DESCRIPTION("CS35L41 HDA Driver");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index 4a9462fb5c14..eeb387853ee3 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -62,5 +62,6 @@ static struct i2c_driver cs35l41_i2c_driver = {
 module_i2c_driver(cs35l41_i2c_driver);
 
 MODULE_DESCRIPTION("HDA CS35L41 driver");
+MODULE_IMPORT_NS(SND_HDA_SCODEC_CS35L41);
 MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 77426e96c58f..15345a72b9d1 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -59,5 +59,6 @@ static struct spi_driver cs35l41_spi_driver = {
 module_spi_driver(cs35l41_spi_driver);
 
 MODULE_DESCRIPTION("HDA CS35L41 driver");
+MODULE_IMPORT_NS(SND_HDA_SCODEC_CS35L41);
 MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76042494F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiATNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:43:59 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:40446 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbiATNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:43:57 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K4mpgk024668;
        Thu, 20 Jan 2022 07:43:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=LqwQlGSPZbY4FUWN/PCbYAVSFcGSRCshh6dVtPJgmMk=;
 b=QAtvbQlMSnt+r2bsw52Tmy8q0EIqjUx2i7GKrrMha7ZpIqlXNMuSLNj15pM647FQxha+
 8mbwYiPcbk3EEE8BRXiXGb1GfOoChRSL6xRIpOhfacw+rPrjR2R+8msdkXgdvmxBKgtr
 yfLOFnuGwmhnjgN4ksbOJ5zETB9ByLFvtZfKcaWuCTVzB8j+FHpFmp6/g6ujxO0MIqui
 EM469wmgaeVH6chttrDxPXunbRapTbmHSASM/iBUFqAZBT7rfIl0IIzh4d3NkO4l1Yhl
 f0MwJE66+aFu/WWjUNXF0NzTu0p6sQa7zBCabL+9P61TOQga/HW5piBsxHsISNcbEZpv OA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dpk9mh838-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 07:43:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 13:43:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 13:43:40 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2FF5446D;
        Thu, 20 Jan 2022 13:43:40 +0000 (UTC)
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
Subject: [PATCH v4 1/9] spi: Make spi_alloc_device and spi_add_device public again
Date:   Thu, 20 Jan 2022 13:43:18 +0000
Message-ID: <20220120134326.5295-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZxX4mGlUFgapqRSefMN9M18XOKK_1bFo
X-Proofpoint-GUID: ZxX4mGlUFgapqRSefMN9M18XOKK_1bFo
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functions were previously made private since they
were not used. However, these functions will be needed
again.

Partial revert of commit da21fde0fdb3
("spi: Make several public functions private to spi.c")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/spi/spi.c       |  6 ++++--
 include/linux/spi/spi.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..1eb84101c4ad 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -532,7 +532,7 @@ static DEFINE_MUTEX(board_lock);
  *
  * Return: a pointer to the new device, or NULL.
  */
-static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
+struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 {
 	struct spi_device	*spi;
 
@@ -557,6 +557,7 @@ static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	device_initialize(&spi->dev);
 	return spi;
 }
+EXPORT_SYMBOL_GPL(spi_alloc_device);
 
 static void spi_dev_set_name(struct spi_device *spi)
 {
@@ -652,7 +653,7 @@ static int __spi_add_device(struct spi_device *spi)
  *
  * Return: 0 on success; negative errno on failure
  */
-static int spi_add_device(struct spi_device *spi)
+int spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
@@ -673,6 +674,7 @@ static int spi_add_device(struct spi_device *spi)
 	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
+EXPORT_SYMBOL_GPL(spi_add_device);
 
 static int spi_add_device_locked(struct spi_device *spi)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..0346a3ff27fd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1452,7 +1452,19 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
  * use spi_new_device() to describe each device.  You can also call
  * spi_unregister_device() to start making that device vanish, but
  * normally that would be handled by spi_unregister_controller().
+ *
+ * You can also use spi_alloc_device() and spi_add_device() to use a two
+ * stage registration sequence for each spi_device. This gives the caller
+ * some more control over the spi_device structure before it is registered,
+ * but requires that caller to initialize fields that would otherwise
+ * be defined using the board info.
  */
+extern struct spi_device *
+spi_alloc_device(struct spi_controller *ctlr);
+
+extern int
+spi_add_device(struct spi_device *spi);
+
 extern struct spi_device *
 spi_new_device(struct spi_controller *, struct spi_board_info *);
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6631549611C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381193AbiAUOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:33:41 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16544 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381137AbiAUOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:33:21 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LDS7PG017315;
        Fri, 21 Jan 2022 08:32:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=LqwQlGSPZbY4FUWN/PCbYAVSFcGSRCshh6dVtPJgmMk=;
 b=PCVBCNXRnJUAug10vNBf9+SdV1P7Kq3cOEZQ04COsE7Z29Ytg628xxs0/kb3O4F5J2XY
 2luji4rp1SVIw8Mj7mHDg+OfrWkcdU17TuyMx8tlbAyKIGJAXGyaQ4IGxKTdlvkL8AGM
 nYRKXxv1AZYlTLCpc4m6ko9nX0HRFF3gV7umufe5CfMzhCxoD63FJAIR19w9neWDICck
 /Lv6EP539BmbIAeSveZ/ykBwCDzjX5Br2SlfP6kO9jb+cJ4ZtYb+RG5tzvmioGNEQ2uy
 V09+b73aDubi/BqjR4FmAd9yg1NUg6Du2Lo/k7EL//PE9KKujfQN8XWNH5+mbUvs4ITD HA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq0up1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 08:32:58 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:32:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 14:32:56 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8AD5845D;
        Fri, 21 Jan 2022 14:32:55 +0000 (UTC)
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
Subject: [PATCH v5 1/9] spi: Make spi_alloc_device and spi_add_device public again
Date:   Fri, 21 Jan 2022 14:32:46 +0000
Message-ID: <20220121143254.6432-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dkr6noE4rEqk2O20yaZBqUicumI8abBv
X-Proofpoint-ORIG-GUID: dkr6noE4rEqk2O20yaZBqUicumI8abBv
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


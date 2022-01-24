Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3C49796B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiAXH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:28:30 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:41200
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241842AbiAXH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:28:25 -0500
Received: from HP-EliteBook-840-G7.. (36-229-235-192.dynamic-ip.hinet.net [36.229.235.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7A27B3F165;
        Mon, 24 Jan 2022 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643009304;
        bh=dj16gFP5CrsdfGvdwZ7qFQSRJlPlMNcu4pgF0B1jdwU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FFHyCs9r9oCp5/xPILV8zOMHxXLhkDt35DUtlG2Jm9TcGYIDlIfL3CcuC2trpZ1E6
         BsHufcXP8WgfifSX3W/rrHmf/KHHPFrVzIOVLGCkzRQl5hoCQygPcsX36i+zy0sIkX
         meRpEjMl8oO8kEOen9VYcH7plUP/22miuDov8RA0Roy4QBuaP/PKA8Bd2lvzvAgciO
         KqbZezdyzpKOEL0wcZxmq8HV1zOt9/qYW0IpKdEUIYGWGpS3rFftaDYGSFnzsY7g1B
         7aCJHXg+//jtu05tN7npF/CHURyEbvx70eNDfGyqSdhZCxU450ZbhgQuJQSK1begnJ
         ZGWlaAvsnY//w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] misc: rtsx: Cleanup power management ops
Date:   Mon, 24 Jan 2022 15:28:02 +0800
Message-Id: <20220124072804.1811690-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220124072804.1811690-1-kai.heng.feng@canonical.com>
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220124072804.1811690-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use cancel_delayed_work_sync to ensure there's no race with
  carddet_work.

- Remove device_wakeup_disable to save some CPU cycles. If the device
  really has ACPI _DSW then the wakeup should be disabled in probe
  routine.

- Remove fetch_vendor_settings from runtime resume routine, since they
  are already saved in "struct rtsx_pcr".

- Move variable assignments to the top of the functions.

Cc: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v5:
 - No change.

v4:
 - Move variable assignments to the top of the functions.

v3:
v2:
 - No change.

 drivers/misc/cardreader/rtsx_pcr.c | 34 ++++++++----------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index f919290f01192..ec395a33faf8b 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1660,22 +1660,17 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 {
 	struct pci_dev *pcidev = to_pci_dev(dev_d);
-	struct pcr_handle *handle;
-	struct rtsx_pcr *pcr;
+	struct pcr_handle *handle = pci_get_drvdata(pcidev);
+	struct rtsx_pcr *pcr = handle->pcr;
 
 	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
 
-	handle = pci_get_drvdata(pcidev);
-	pcr = handle->pcr;
-
-	cancel_delayed_work(&pcr->carddet_work);
+	cancel_delayed_work_sync(&pcr->carddet_work);
 
 	mutex_lock(&pcr->pcr_mutex);
 
 	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
 
-	device_wakeup_disable(dev_d);
-
 	mutex_unlock(&pcr->pcr_mutex);
 	return 0;
 }
@@ -1683,15 +1678,12 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 static int __maybe_unused rtsx_pci_resume(struct device *dev_d)
 {
 	struct pci_dev *pcidev = to_pci_dev(dev_d);
-	struct pcr_handle *handle;
-	struct rtsx_pcr *pcr;
+	struct pcr_handle *handle = pci_get_drvdata(pcidev);
+	struct rtsx_pcr *pcr = handle->pcr;
 	int ret = 0;
 
 	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
 
-	handle = pci_get_drvdata(pcidev);
-	pcr = handle->pcr;
-
 	mutex_lock(&pcr->pcr_mutex);
 
 	ret = rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
@@ -1711,13 +1703,11 @@ static int __maybe_unused rtsx_pci_resume(struct device *dev_d)
 
 static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 {
-	struct pcr_handle *handle;
-	struct rtsx_pcr *pcr;
+	struct pcr_handle *handle = pci_get_drvdata(pcidev);
+	struct rtsx_pcr *pcr = handle->pcr;
 
 	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
 
-	handle = pci_get_drvdata(pcidev);
-	pcr = handle->pcr;
 	rtsx_pci_power_off(pcr, HOST_ENTER_S1);
 
 	pci_disable_device(pcidev);
@@ -1756,11 +1746,8 @@ static int rtsx_pci_runtime_idle(struct device *device)
 static int rtsx_pci_runtime_suspend(struct device *device)
 {
 	struct pci_dev *pcidev = to_pci_dev(device);
-	struct pcr_handle *handle;
-	struct rtsx_pcr *pcr;
-
-	handle = pci_get_drvdata(pcidev);
-	pcr = handle->pcr;
+	struct pcr_handle *handle = pci_get_drvdata(pcidev);
+	struct rtsx_pcr *pcr = handle->pcr;
 
 	dev_dbg(device, "--> %s\n", __func__);
 
@@ -1786,9 +1773,6 @@ static int rtsx_pci_runtime_resume(struct device *device)
 
 	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
 
-	if (pcr->ops->fetch_vendor_settings)
-		pcr->ops->fetch_vendor_settings(pcr);
-
 	rtsx_pci_init_hw(pcr);
 
 	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
-- 
2.33.1


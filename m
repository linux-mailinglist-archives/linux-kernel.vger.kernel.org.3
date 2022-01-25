Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD449AC14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiAYFzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:55:44 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41792
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239944AbiAYFuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:50:39 -0500
Received: from HP-EliteBook-840-G7.. (36-229-235-192.dynamic-ip.hinet.net [36.229.235.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 822D541994;
        Tue, 25 Jan 2022 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643089832;
        bh=B8+gudGm0x0gX0EBVDqtf8mDcsiI5LKEkMNO3Wbtqic=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=f+NQcJRzEWv2ZtWsPdlcr9rPEji0eDaf+bGCPQqkB9Y59W24ri/zdHsBCT4E1BTch
         LocIgqs7LgwekIbLowuUnX/tYWQ7l/mVcI/MquO05C4Tp0xF/N/GUjJzTd9lfOoWZn
         vhSAl423IZivB3B6fqzxfFw+i1b4XYhQLwSJo9i6sFTOQLDelHRq/doLJjUdCZJOkK
         Eksopw/k0Q0aP6MAG3sKyfrllEv1XVzpcpBKKcoJh47hIIFs1/Y6jLx82eou9aRHyg
         T636PhuL7YOBUJo1oSeljGSXLcxVyMCwZH0/9C92i2/KJKL9g7uBP/rkFznLgc8zY/
         1eSYhqEmX/wbA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] misc: rtsx: Cleanup power management ops
Date:   Tue, 25 Jan 2022 13:50:08 +0800
Message-Id: <20220125055010.1866563-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220125055010.1866563-1-kai.heng.feng@canonical.com>
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-1-kai.heng.feng@canonical.com>
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
v6:
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
index 8aba47a7d9736..3c97d3b50456e 100644
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


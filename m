Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3F49508D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356917AbiATOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:50:35 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36482
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354963AbiATOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:50:32 -0500
Received: from localhost.localdomain (1-171-82-176.dynamic-ip.hinet.net [1.171.82.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8927D3F10B;
        Thu, 20 Jan 2022 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642690230;
        bh=WMlxrxQU0Pz6LR0vwoA8kjqO1p1cwZ85JMOKU8s1kG0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aG8UKmUACYyL0oyTiofkIhinDeF10Kn2joea0KMdXSQLU2VyLUMwB67+odZSWEeRD
         0HoWljYCh4x8MDTTJe+bQPwh1qxB7gYNB7C69NyY4MQI+f3HFRA9pp8vWNj3tA+GNl
         CtiTF2cTTY+1m7tILe++JqbIVRcodXnZmptE7CNba3JPh9puqz4hrwv5s+iMYLmM2n
         LdKwcEeuQKdhA6qDwHJfhKj1nl7Uj63otH9jIMhnfsY/4Mi8Q1oi/F58XCoTF8H70Y
         9iN+R6NuD+zeZ4fAYL1YbQJjNdlTa0+1eaw79q9p1/eUYWLTYqhrvGJamrj6bpzcgt
         bDkBwOWUtwQ2w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] misc: rtsx: Cleanup power management ops
Date:   Thu, 20 Jan 2022 22:50:04 +0800
Message-Id: <20220120145006.1682014-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120145006.1682014-1-kai.heng.feng@canonical.com>
References: <20220120145006.1682014-1-kai.heng.feng@canonical.com>
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

Cc: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 1dcf98b597569..8107c85028c37 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1671,14 +1671,12 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 	handle = pci_get_drvdata(pcidev);
 	pcr = handle->pcr;
 
-	cancel_delayed_work(&pcr->carddet_work);
+	cancel_delayed_work_sync(&pcr->carddet_work);
 
 	mutex_lock(&pcr->pcr_mutex);
 
 	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
 
-	device_wakeup_disable(dev_d);
-
 	mutex_unlock(&pcr->pcr_mutex);
 	return 0;
 }
@@ -1791,9 +1789,6 @@ static int rtsx_pci_runtime_resume(struct device *device)
 
 	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
 
-	if (pcr->ops->fetch_vendor_settings)
-		pcr->ops->fetch_vendor_settings(pcr);
-
 	rtsx_pci_init_hw(pcr);
 
 	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
-- 
2.33.1


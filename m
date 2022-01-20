Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C60495083
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348293AbiATOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:50:20 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36452
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236017AbiATOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:50:18 -0500
Received: from localhost.localdomain (1-171-82-176.dynamic-ip.hinet.net [1.171.82.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 014D33F10B;
        Thu, 20 Jan 2022 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642690216;
        bh=v+jLBr5FFoCZA1NsbC3yHqoG/FwpyzWTYGM8JwT+N9Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=hFCyA4dbdAeZnzD+15nQw1Mr77j6dTzevQVwQ8sLbZFaVk98IypcsMV2yXVABSYp3
         xKkePViB6RnAfiwuz5V6EUWePtYIaS8OYPohL5ye7YJ1DYwLQigqPZs4gSyj0+f24Z
         qeBdR/MC7i2LI0cSF9QlQdCmy8IiQ+bgas4V2z1gLT7qfJAoikymwjbU6JioA+77ME
         KbP0gMqZm+M2xgJvaT5TGw/0w7cq/XnSdxOhuFEO2B6ER1z8+ctHoOKmWlDMva3jwE
         BjjjWBYAal7K1TdES7T8H9SM3mFb8Rm4c19gU5gCqlEOMM9G+A6Bq6nYgqG+olNr47
         Y+vTY4FlihWlw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM
Date:   Thu, 20 Jan 2022 22:50:02 +0800
Message-Id: <20220120145006.1682014-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't
use pm_runtime_{get,put}() helpers when it should, so the RPM refcount
keeps at zero, hence its parent driver, rtsx_pci, has to do lots of
weird tricks to keep it from runtime suspending.

So use those helpers at right places to properly manage runtime PM.

Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
Cc: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 44 +++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 58cfaffa3c2d8..2656dc840a3a5 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -806,6 +806,7 @@ static void sd_request(struct work_struct *work)
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd = mrq->cmd;
 	struct mmc_data *data = mrq->data;
+	struct device *dev = &host->pdev->dev;
 
 	unsigned int data_size = 0;
 	int err;
@@ -822,6 +823,7 @@ static void sd_request(struct work_struct *work)
 	}
 
 	mutex_lock(&pcr->pcr_mutex);
+	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -858,6 +860,8 @@ static void sd_request(struct work_struct *work)
 			data->bytes_xfered = data->blocks * data->blksz;
 	}
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 finish:
@@ -1080,6 +1084,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
+	struct device *dev = &host->pdev->dev;
 
 	if (host->eject)
 		return;
@@ -1088,6 +1093,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		return;
 
 	mutex_lock(&pcr->pcr_mutex);
+	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1121,6 +1127,8 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	rtsx_pci_switch_clock(pcr, ios->clock, host->ssc_depth,
 			host->initial_mode, host->double_clk, host->vpclk);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 }
 
@@ -1128,6 +1136,7 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
+	struct device *dev = &host->pdev->dev;
 	int ro = 0;
 	u32 val;
 
@@ -1135,6 +1144,7 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 		return -ENOMEDIUM;
 
 	mutex_lock(&pcr->pcr_mutex);
+	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1144,6 +1154,8 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 	if (val & SD_WRITE_PROTECT)
 		ro = 1;
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return ro;
@@ -1153,6 +1165,7 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
+	struct device *dev = &host->pdev->dev;
 	int cd = 0;
 	u32 val;
 
@@ -1160,6 +1173,7 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 		return cd;
 
 	mutex_lock(&pcr->pcr_mutex);
+	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1169,6 +1183,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	if (val & SD_EXIST)
 		cd = 1;
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return cd;
@@ -1251,6 +1267,7 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
+	struct device *dev = &host->pdev->dev;
 	int err = 0;
 	u8 voltage;
 
@@ -1265,6 +1282,7 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 		return err;
 
 	mutex_lock(&pcr->pcr_mutex);
+	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1294,6 +1312,8 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
 			SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return err;
@@ -1303,6 +1323,7 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
+	struct device *dev = &host->pdev->dev;
 	int err = 0;
 
 	if (host->eject)
@@ -1313,6 +1334,7 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return err;
 
 	mutex_lock(&pcr->pcr_mutex);
+	pm_runtime_get_sync(dev);
 
 	rtsx_pci_start_run(pcr);
 
@@ -1345,6 +1367,8 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		err = sd_change_phase(host, DDR50_RX_PHASE(pcr), true);
 
 out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return err;
@@ -1495,12 +1519,12 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 
 	realtek_init_host(host);
 
-	if (pcr->rtd3_en) {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
-		pm_runtime_use_autosuspend(&pdev->dev);
-		pm_runtime_enable(&pdev->dev);
-	}
-
+	pm_runtime_no_callbacks(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
 
 	mmc_add_host(mmc);
 
@@ -1521,11 +1545,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
 	mmc = host->mmc;
 
-	if (pcr->rtd3_en) {
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-	}
-
 	cancel_work_sync(&host->work);
 
 	mutex_lock(&host->host_mutex);
@@ -1548,6 +1567,9 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 
 	flush_work(&host->work);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	mmc_free_host(mmc);
 
 	dev_dbg(&(pdev->dev),
-- 
2.33.1


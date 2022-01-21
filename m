Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3E496342
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380454AbiAUQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380007AbiAUQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:55:18 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C72DC061756;
        Fri, 21 Jan 2022 08:55:03 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso12528714otl.3;
        Fri, 21 Jan 2022 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//qkdexdYIAffr/wUpysgq4KHDNS4hLAy6zYf5Zu0v0=;
        b=OSxN7qu75Jl6Ebypga9EB+rplXL2NknX3v4hf6fdfBKRFxnzpNYg+gtEDRUJTspnNY
         kTwMubX5Osq+gG0ozYv5J1+mfyiuQoGQH/OAU0XLabU/xitBEHrV25rvFJyLpopYC2qI
         WT94JRxDJECeNsRXFsx/cv2LpFTwt+rhh9PEY5ypRwDUQ9GoxjRJeC9434EFhq9dzfwx
         2uhCO3G6gMl/MVRzOhxZ2RZMEExqltWLaKq4cn+sm3Zwt9+slU6u7ifmmAYWmCbEQQf7
         wL+7KNo8KcKA4dwGpoGlNJIXNzPjgv7VTBnRA1dcMvHBqykqPMmfIX6lqlZZ8OTy9myu
         /NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//qkdexdYIAffr/wUpysgq4KHDNS4hLAy6zYf5Zu0v0=;
        b=4sHEBAlGpgqvaAfnACkn7R8xBI7ulCVZcXhZX4+t+NUFJFPzFjF24/hZ092ev8u/na
         +R6ztxuaktFtYx6mN+v069+nFIgq0GI7Ow1E0XISYu5QLFDy/4fRj3mCpDkNbZ+7HeCK
         xojQmjRqBpUDsk/coSi1oNgpD9oyG54jmToir377joarnkupOplpidqPKnAOAfHh93dR
         jYrq4MKFlk1+B+kiNc99OiDLsLDIMPFzvFVDMOhPZNOWT7cMAecCOeva4B2v/Z3EvNNM
         vhMiFEYtNmLe7U0Gr/7N4mUMeh1CQuXH+PAF+iWV4syL5wutG82I86PFd2xDZS7SsEfx
         QZJA==
X-Gm-Message-State: AOAM532K5Vk71RQnXf7zNWQBbEPYjQP321Yqlf4lNSY5upjZYHE/xSzZ
        o1jXwJihueWNa9DW8wKyHf8=
X-Google-Smtp-Source: ABdhPJwLwqGU0n96VjHoplzG9X99JN+vvV5vjYkOWtZbXe7dcfTezy+ooVZ/MdX9vggOI9EvsoDRwA==
X-Received: by 2002:a9d:27c1:: with SMTP id c59mr3457166otb.150.1642784102699;
        Fri, 21 Jan 2022 08:55:02 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:55:02 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 13/31] mmc: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:18 -0300
Message-Id: <20220121165436.30956-14-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/mmc/core/core.c           | 4 ++--
 drivers/mmc/host/rtsx_usb_sdmmc.c | 4 ++--
 drivers/mmc/host/sdhci.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..66bc9c780e06 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -175,7 +175,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 		mmc_should_fail_request(host, mrq);
 
 		if (!host->ongoing_mrq)
-			led_trigger_event(host->led, LED_OFF);
+			led_trigger_event(host->led, 0);
 
 		if (mrq->sbc) {
 			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
@@ -352,7 +352,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
-	led_trigger_event(host->led, LED_FULL);
+	led_trigger_event(host->led, 255);
 	__mmc_start_request(host, mrq);
 
 	return 0;
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 5fe4528e296e..64fe7a75f401 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1287,7 +1287,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
 	if (host->power_mode == MMC_POWER_OFF)
 		goto out;
 
-	if (host->led.brightness == LED_OFF)
+	if (host->led.brightness == 0)
 		rtsx_usb_turn_off_led(ucr);
 	else
 		rtsx_usb_turn_on_led(ucr);
@@ -1357,7 +1357,7 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 	snprintf(host->led_name, sizeof(host->led_name),
 		"%s::", mmc_hostname(mmc));
 	host->led.name = host->led_name;
-	host->led.brightness = LED_OFF;
+	host->led.brightness = 0;
 	host->led.default_trigger = mmc_hostname(mmc);
 	host->led.brightness_set = rtsx_usb_led_control;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07c6da1f2f0f..ddc58a8f0c4f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -395,7 +395,7 @@ static void sdhci_led_control(struct led_classdev *led,
 	if (host->runtime_suspended)
 		goto out;
 
-	if (brightness == LED_OFF)
+	if (brightness == 0)
 		__sdhci_led_deactivate(host);
 	else
 		__sdhci_led_activate(host);
@@ -414,7 +414,7 @@ static int sdhci_led_register(struct sdhci_host *host)
 		 "%s::", mmc_hostname(mmc));
 
 	host->led.name = host->led_name;
-	host->led.brightness = LED_OFF;
+	host->led.brightness = 0;
 	host->led.default_trigger = mmc_hostname(mmc);
 	host->led.brightness_set = sdhci_led_control;
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9249BDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiAYVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiAYVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:05:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21825C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:05:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s18so22147687wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEGTwOTFazzFopYdwsjasSMs2TPOCsagXB4GLqvfljg=;
        b=QpYfzczbBNquLA8XZcf2BgM2f8cTh8rvgYszpa/SnQF0TVCIDCkb3TpEy7LPrJkTi9
         DHL6v4c/QVxERmf8g8k+VjcGLCLKdZ9xDVN6V5hjkOoH8UwmDp5rXLHb6HgfycdIQdkW
         oip4zBgaNrVaXTetar96dGlt4kxszqcNKb1dxgnPWJwU/E2xx0228JAObDpyxbnS5466
         w84p6MLbh+XLIPG51bEJQUoyVKoLsclCoupq1b3XqVvJuALKA+5LEEyAxTA38xtYXuuw
         dGP5JMmtfoM40yH458XuKlIW6rBO/vUOnLz4Ru24OAAyfI9Z3amxuWMVDmY/+oUgZhEh
         4onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEGTwOTFazzFopYdwsjasSMs2TPOCsagXB4GLqvfljg=;
        b=K4hdTlI0JSsKjbVXiMiwXpoNrtnHR+XWP7oP5RkAbXhC29+UcFhYggYgN76mFHetqM
         6pcirrYfVmv/0pVseiZsHhgbfwXlEeb5m5O/YRlKJtGCS3ZRCl8sRwXSIv34gGluwnU9
         Pk4TgKgoVXKdd10ZvGklUtlAmFqfPiaTXx2O2oTb61lYFC/xddObQrGdzssP5uRbvlVV
         KyBiTjnfur5DMjjbQSLXn+/iV6OshJ+FRifGRNwdPmKraUxvp4Twr8jncAkD5B27u29K
         dycaLLA30xjL1K4pjPlalMN9YA1GWNujVA9Z9HrrM4cIvvWPjxRQKFgl1x4pIHUliTUH
         g0EA==
X-Gm-Message-State: AOAM530EJ56XbJ9IgeXJKFOaz9qxbPGuF4X6OFvYWwpuskZbZ/akTrCu
        KDEHe9Guvdo6KqTlp8NnaQ1jkA==
X-Google-Smtp-Source: ABdhPJxpd2Oy5zDR55D4p7MVX1/ub9Estu7VolmuKLbwZDdBW4kgP/pBBpByn8un8Kg/h5XCBgIFVQ==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr19447429wrt.280.1643144742766;
        Tue, 25 Jan 2022 13:05:42 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o10sm4258214wri.19.2022.01.25.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:05:42 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     pavel@ucw.cz, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] leds: remove ide-disk trigger
Date:   Tue, 25 Jan 2022 21:05:37 +0000
Message-Id: <20220125210537.54036-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No user of ide-disk remains, so remove this deprecated trigger.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- remove also DEFINE_LED_TRIGGER(ledtrig_ide)

 Documentation/devicetree/bindings/leds/common.yaml | 3 ---
 drivers/leds/trigger/ledtrig-disk.c                | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 37f8a6fd6518..c89f430df4a0 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -91,9 +91,6 @@ properties:
       - disk-activity
       - disk-read
       - disk-write
-        # LED indicates IDE disk activity (deprecated), in new implementations
-        # use "disk-activity"
-      - ide-disk
         # LED flashes at a fixed, configurable rate
       - timer
         # LED alters the brightness for the specified duration with one software
diff --git a/drivers/leds/trigger/ledtrig-disk.c b/drivers/leds/trigger/ledtrig-disk.c
index 0741910785bb..0b7dfbd04273 100644
--- a/drivers/leds/trigger/ledtrig-disk.c
+++ b/drivers/leds/trigger/ledtrig-disk.c
@@ -16,7 +16,6 @@
 DEFINE_LED_TRIGGER(ledtrig_disk);
 DEFINE_LED_TRIGGER(ledtrig_disk_read);
 DEFINE_LED_TRIGGER(ledtrig_disk_write);
-DEFINE_LED_TRIGGER(ledtrig_ide);
 
 void ledtrig_disk_activity(bool write)
 {
@@ -24,8 +23,6 @@ void ledtrig_disk_activity(bool write)
 
 	led_trigger_blink_oneshot(ledtrig_disk,
 				  &blink_delay, &blink_delay, 0);
-	led_trigger_blink_oneshot(ledtrig_ide,
-				  &blink_delay, &blink_delay, 0);
 	if (write)
 		led_trigger_blink_oneshot(ledtrig_disk_write,
 					  &blink_delay, &blink_delay, 0);
@@ -40,7 +37,6 @@ static int __init ledtrig_disk_init(void)
 	led_trigger_register_simple("disk-activity", &ledtrig_disk);
 	led_trigger_register_simple("disk-read", &ledtrig_disk_read);
 	led_trigger_register_simple("disk-write", &ledtrig_disk_write);
-	led_trigger_register_simple("ide-disk", &ledtrig_ide);
 
 	return 0;
 }
-- 
2.34.1


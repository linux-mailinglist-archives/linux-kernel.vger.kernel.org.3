Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D856B515
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiGHJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:07:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4031FCE4;
        Fri,  8 Jul 2022 02:07:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so15836245plo.10;
        Fri, 08 Jul 2022 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C33xyLawJhRLBaWCMnBU/MS45wpGFkBXlQelADzR1CM=;
        b=VE2aEf6wO3TdSh1eQqY/sbtphYbuNh22y9pfryfy9Rh8iNoi68OEb6m4WoG9zRjPoO
         I+S2Pkyuyp1s4sKTKbnaUfcqLt3FjJLJ4j9w82Nt/TwQDAubSnyqcX2BvG5iYeq32+Xf
         HYI2wU11GO9nmMdzecfprIM3mu5OqULJDBznBbj58l0e8hznp8IptyPeMkjiwhZbwVyl
         elZHVNROTFKrRI523VVdi+xUBEYoMAB2Do7mnHNhbpraMgOk+63Jgj2L/Y2BK6ew/HV/
         Q9CXAgcE5KLYmQEFUEC3fzMrMLNOz5GXxKPisqZoKcGYt1MOqjOhZyCYrm2b06vsMKui
         xjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C33xyLawJhRLBaWCMnBU/MS45wpGFkBXlQelADzR1CM=;
        b=7MInlN1p7WuWiM8f2QZsX3Hb064wqDz0Yb6wFSZtyGGGBQcNUkxOB0fXpRBL0pFUd3
         yWUP8cqfwyvdd8iAwQbfiZLbMBlaJ3nfcJ3ObdE56FDgp0GBHRY3PVygQUGBh8UxGcEj
         iZfw7Q8mgO7A46oEP7mEU93eWOf7AZPT8To3DN88C8PJDr5/rZ1rfstawq5med5HRyrT
         AtY330lqAP/NwyHyBEr4XW5iyTV7hHMubJS2AePZqNBcADQscMAeTyyZW0hMcQoHBltS
         O5M3fZnHNNGxAIkNN9DnDBYkQ6vNSp5wzeNsn3E+3B99vXK+jHLiife2/unkgKOBTrti
         C+Pg==
X-Gm-Message-State: AJIora/SqD0mf4xOSCY90oKFDSdc3yK8QOucy1GVsSg6AXafTKtpMaz3
        K1fdZULIq5jRakQ+eWHcpFg=
X-Google-Smtp-Source: AGRyM1tmf+w1xYZ05W3IWubTGrPvxQZlkI4+b0g1gy4AnuM96XgE+cB7/RC78MF3xWuHWnBE4Xky/g==
X-Received: by 2002:a17:902:e9d3:b0:16b:fe8c:e89b with SMTP id 19-20020a170902e9d300b0016bfe8ce89bmr2829189plk.81.1657271262811;
        Fri, 08 Jul 2022 02:07:42 -0700 (PDT)
Received: from localhost.localdomain (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b0016c06a10861sm4563666pls.74.2022.07.08.02.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:07:42 -0700 (PDT)
From:   PaddyKP_Yao <ispaddy@gmail.com>
X-Google-Original-From: PaddyKP_Yao <PaddyKP_Yao@asus.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com,
        corentin.chary@gmail.com
Cc:     luke@ljones.dev, PaddyKP_Yao@asus.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net
Subject: [PATCH 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
Date:   Fri,  8 Jul 2022 17:07:31 +0800
Message-Id: <20220708090731.1237488-1-PaddyKP_Yao@asus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708084816.1140540-1-PaddyKP_Yao@asus.com>
References: <20220708084816.1140540-1-PaddyKP_Yao@asus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some new ASUS devices, hotkey Fn+F13 is used for mic mute. If mic-mute
LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
it. The binding of mic-mute LED controls will be swithched with LED
trigger.

Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>
---
 drivers/platform/x86/Kconfig               |  2 ++
 drivers/platform/x86/asus-wmi.c            | 25 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f915cf67aa26..74769050b770 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -274,6 +274,8 @@ config ASUS_WMI
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_AUDIO
 	select ACPI_PLATFORM_PROFILE
 	help
 	  Say Y here if you have a WMI aware Asus laptop (like Eee PCs or new
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e14fb5fa7324..40c0e00a4b71 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -191,6 +191,7 @@ struct asus_wmi {
 	int kbd_led_wk;
 	struct led_classdev lightbar_led;
 	int lightbar_led_wk;
+	struct led_classdev micmute_led;
 	struct workqueue_struct *led_workqueue;
 	struct work_struct tpd_led_work;
 	struct work_struct wlan_led_work;
@@ -906,12 +907,23 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }
 
+static int micmute_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	int state = brightness != LED_OFF;
+	int err;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MICMUTE_LED, state, NULL);
+	return err < 0 ? err : 0;
+}
+
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
 	led_classdev_unregister(&asus->kbd_led);
 	led_classdev_unregister(&asus->tpd_led);
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
+	led_classdev_unregister(&asus->micmute_led);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -983,6 +995,19 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 					   &asus->lightbar_led);
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MICMUTE_LED)) {
+		asus->micmute_led.name = "asus::micmute";
+		asus->micmute_led.max_brightness = 1;
+		asus->micmute_led.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+		asus->micmute_led.brightness_set_blocking = micmute_led_set;
+		asus->micmute_led.default_trigger = "audio-micmute";
+
+		rv = led_classdev_register(&asus->platform_device->dev,
+						&asus->micmute_led);
+		if (rv)
+			goto error;
+	}
+
 error:
 	if (rv)
 		asus_wmi_led_exit(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 17dc5cb6f3f2..38ee75874d11 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -49,6 +49,7 @@
 #define ASUS_WMI_DEVID_LED4		0x00020014
 #define ASUS_WMI_DEVID_LED5		0x00020015
 #define ASUS_WMI_DEVID_LED6		0x00020016
+#define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
 
 /* Backlight and Brightness */
 #define ASUS_WMI_DEVID_ALS_ENABLE	0x00050001 /* Ambient Light Sensor */
-- 
2.34.1


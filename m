Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBFC56B4BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiGHIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiGHIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:48:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165D828C;
        Fri,  8 Jul 2022 01:48:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bf13so8758256pgb.11;
        Fri, 08 Jul 2022 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCfJi2yWLIUTn9UQCo9Ykdpvm8wq/AZQhSB/e7t7MCc=;
        b=cA3i5O+WepkIn1s/5GB3E2+Ku0g0EBJv0rasWDUe1Q/wXY3Jis6VL37H1TLy8O5Zf+
         Wn6I8KtVdhVWOCU1RGPP6tBEmg2m0/nsFmQSbXHATDNfF7gtb9B/5P80Hs2jdm0OLTEk
         3rN2rMj3jIugTMSlvYYa/0RVPVVu3vdV2RCHEthqqAVhEI9UHBV9nxEbs8qq9NsohLwn
         M1X5Rh2axgnwfCFvTz373Rf95q8lHipDDQRyqsgPcVLyoIH9pvsdRouHv+G8Y7kc59ud
         FW5/1J/yHejKA1OQG8iAxZvrLlwBRD/rCdnkY9aA3WJDbuB4nH0g23x36phdsX18nuib
         0Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCfJi2yWLIUTn9UQCo9Ykdpvm8wq/AZQhSB/e7t7MCc=;
        b=0jx0UQGQU80DFbzUICZOcI6AT4zrTaQ2A0VQvMgv3ynwqdU3joc//bc9QTrorB0aen
         vCft6XRcnhkag5XCFSYDLr62eEQB5iVMrKww6y8lgMV9uuwv+weoehk5p+H5m7TpQqJ+
         ZgMOBRcwVW0xYisAjv/DaFDAE5E75Sgoidoer9pdV9Dwh05tNWx6Lwt0+dnZ9XjGA9vo
         RK2xwoWIgktF5/mBQbBe7n11vOPAhZsycHRERWCGgHyb0MhadPfYpCLezJUz5ZbZIAh1
         QlSuRy6slWI/bELKqFyqicRXLlGa0h4+BmBSf5WmIfKTJ58Z6S/tmmPQR/2DFFC+URap
         uN+A==
X-Gm-Message-State: AJIora8Kya1uQy9pwhAHUuuwSPsDNAT450JCGUFrNl1zWPhlfBu5L6+V
        kgcceyFb8rFggM3eTpZBegnf/ofd4FmwXEOF
X-Google-Smtp-Source: AGRyM1u4mMnhUINvCUcELjUuGvzeMC5NeE3B2bNlFdnC6LOnkDLTcEcl5NFtcAu9hayIxfLHRpLFEw==
X-Received: by 2002:a65:6bd3:0:b0:3fd:63c3:a84b with SMTP id e19-20020a656bd3000000b003fd63c3a84bmr2395028pgw.572.1657270105388;
        Fri, 08 Jul 2022 01:48:25 -0700 (PDT)
Received: from localhost.localdomain (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902eb8100b0016bf1e8f1besm7661655plg.28.2022.07.08.01.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:48:24 -0700 (PDT)
From:   PaddyKP_Yao <ispaddy@gmail.com>
X-Google-Original-From: PaddyKP_Yao <PaddyKP_Yao@asus.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com,
        corentin.chary@gmail.com
Cc:     luke@ljones.dev, PaddyKP_Yao@asus.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net
Subject: [PATCH 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
Date:   Fri,  8 Jul 2022 16:48:16 +0800
Message-Id: <20220708084816.1140540-1-PaddyKP_Yao@asus.com>
X-Mailer: git-send-email 2.34.1
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
LED is preset by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
it. The binding of mic-mute LED controls will be swithched with LED
trigger.

Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>
---
 drivers/platform/x86/Kconfig               |  2 ++
 drivers/platform/x86/asus-wmi.c            | 26 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 29 insertions(+)

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
index e14fb5fa7324..f1da083b7cd1 100644
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
@@ -906,12 +907,24 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }
 
+static int micmute_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	int state = brightness != LED_OFF;
+	int err;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MICMUTE_LED, state, NULL);
+	pr_info("%s: brightness : %d, state: %d, err=%d\n", __func__, brightness, state, err);
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
@@ -983,6 +996,19 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
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


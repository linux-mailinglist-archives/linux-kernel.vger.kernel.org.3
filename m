Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FA570133
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiGKLwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGKLwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:52:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED6167D7;
        Mon, 11 Jul 2022 04:52:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 5so4204659plk.9;
        Mon, 11 Jul 2022 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wE0g7bUn5n8gLr1tJA7riCOdigGVun4E5doeS+PgJgA=;
        b=Bw5KwDV0F1SKBib3nCgkQg1DblY0lZH/8wYKsinnLAopPq0S7I+/8M2AksQm7MBPO7
         PCGlIfjUp+iQyhcm/KOc2TKr5jW5lGpgvXUi5+ZZqlKyihWpXh7TG00kgTGSLSwh584Z
         0Y0EKOFE/GYEsNfhRFLODjgo2tIONVpKyE4eBcGtZsnhRKsrL+8bqvk82nqKkPoqM7nc
         8UUkwFRagPd2peAUzd+d4vyP9uRS5X+kEB6+2MXjgIDOBdrmHfAdu/EKL6LENlFTiBhU
         2uCIhnSXt8xiwH0Jnq9j0ZOnPZcthUKDTNN9btKwAUdl9N3uEJx21vNXuXLoBJPYPvpv
         COuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wE0g7bUn5n8gLr1tJA7riCOdigGVun4E5doeS+PgJgA=;
        b=vtZFrfJArJSz5DbdEdQvCFA6E56HG9xQ7qVLLt1ao5cNiet/w6mCXNwsmfuMA3bRJe
         cr+zd62IMAZUZGj9IItWccaKIV7y6Pl1AJdC+slGqJXSQPTq65xWyGNN92pdvfg/dVQr
         au5s/uXQQzoPq6UcN3Ii4gLl/Gbrs3YCjmqJS884cI0K5q3b6PjqmAY39J/nCG4LocUg
         wsVcFAKHHg2oZ1WnSRO1cNwgOk+jgmY8TXdAQbDGE2nxoiwOpp3XMkFHl+9YRjJATCOK
         +hLLGIx+J0RJah1aizNnd4+O6jKI77sKNKhKB/J7l8rbePfeo1HKzVsiZksLQp5KCvul
         Obyw==
X-Gm-Message-State: AJIora/7rhhstLi8IdLfGZ0IMhbpQLcNddpQASFt9rgDum3l/ejj5/5r
        TdrjPKzicjlypHH3yKzkuao=
X-Google-Smtp-Source: AGRyM1vBf0TKuCf9RDDi7Hqc80k8Fpq9HFxeQSxKQq08Fw+y/zy7MCQRtT2V2Obeif6dx0nAqPzKyg==
X-Received: by 2002:a17:902:6b42:b0:16b:f27c:1c17 with SMTP id g2-20020a1709026b4200b0016bf27c1c17mr18005081plt.152.1657540339324;
        Mon, 11 Jul 2022 04:52:19 -0700 (PDT)
Received: from localhost.localdomain (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b0016c27561454sm4487108plb.283.2022.07.11.04.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:52:18 -0700 (PDT)
From:   PaddyKP_Yao <ispaddy@gmail.com>
X-Google-Original-From: PaddyKP_Yao <PaddyKP_Yao@asus.com>
To:     hdegoede@redhat.com
Cc:     PaddyKP_Yao@asus.com, acpi4asus-user@lists.sourceforge.net,
        andy.shevchenko@gmail.com, corentin.chary@gmail.com,
        ispaddy@gmail.com, linux-kernel@vger.kernel.org, luke@ljones.dev,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
Date:   Mon, 11 Jul 2022 19:51:25 +0800
Message-Id: <20220711115125.2072508-1-PaddyKP_Yao@asus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
References: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
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
V1 -> V2: fix typo for 'present' and remove unnecessary pr_info() log
V2 -> V3: resend patch again by gmail to avoid Asus legal in the mail

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


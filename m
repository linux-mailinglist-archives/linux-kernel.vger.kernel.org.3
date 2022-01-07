Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FFD48717C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345939AbiAGDwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiAGDwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:07 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7540AC061201;
        Thu,  6 Jan 2022 19:52:07 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g22so4368087pgn.1;
        Thu, 06 Jan 2022 19:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aaNkARm8yVoibthEL3g0zapfb1DplmTNyxjJZYBl+w=;
        b=bbBrb9Rl01kNOpmugVoctDUHccQFS8Z6MklpLAI70CMXtfZPxbDrAcXmgRAJdIgfc4
         3e9+qdV9yRvDw00jq0ZHKfUvo025vUef/P1xX1rEMTNRlGgw1QKdoIwaB4oyZvYgbkzP
         oSVz7KisFvQ6qOkF7H5peMaXHbAmjZUwAYh6OKDvJ7+rWH/ZkoRwMK4CWKDojApaGuFc
         SHTE2b0++MSwbIrGdIlUTsA3zQadl2rIcBw+4pTsK1+5KWpLKRQwQ640Vs2mUFEIq1ZJ
         UD9ihH5Qm4XpygVoa21EYmI86xfh5s+XFE/fGmqdFI35hv13POnzc7xfmEWpi4JKwt0q
         KvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aaNkARm8yVoibthEL3g0zapfb1DplmTNyxjJZYBl+w=;
        b=mxIDgSy+v3t11y5fbzuLHXmAX75EXWW5Ag++ADnbmStY2SJa3YeAvFzojAbmlrcD3Q
         dmsRsmhORo18Pq0wXcLLD7vNkhP3lR8HqGmYFo7UpV9w2uxE4fuAT76P1KNVE454wEn0
         itjVHwUu0ipLm0AeMJZrTw6XABvFHckREI7Wx77UY0Jgslstk/mgtaXEZi9Iqcvtp0J0
         n7M//EHLmeRdRawvuSElSFUSvQOir8kG/Gj8luczL7vJNU7DZWaaKDKVPiBGNvErAzfj
         8SPeUCupxcxiQRhl/GZfRfgbknxG/1V50m2o2QAJ/Z07k5l68lYufX2KX0UEFo597+PW
         0ibA==
X-Gm-Message-State: AOAM5319o6XRVL4xj5tTZkLgak8ZsG2k9edERMLQQa2ev9bo5LPhk1jb
        OoI3SaDn3+uSjRu8wIzLIfHEuEbGyBc=
X-Google-Smtp-Source: ABdhPJxRA2ddTKiPyxXWgFBqmFER+q1TMA8fKW/ESdK3+aSIBaOsc/mYE+a/mrnehY/VuG3NlA7EPA==
X-Received: by 2002:a62:80c2:0:b0:4bb:47a:6983 with SMTP id j185-20020a6280c2000000b004bb047a6983mr63655013pfd.24.1641527526654;
        Thu, 06 Jan 2022 19:52:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j16sm4043855pfj.16.2022.01.06.19.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:52:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] MIPS: BCM47XX: Add LEDs and buttons for Asus RTN-10U
Date:   Thu,  6 Jan 2022 19:51:39 -0800
Message-Id: <20220107035141.2325384-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107035141.2325384-1-f.fainelli@gmail.com>
References: <20220107035141.2325384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definitions for the buttons and LEDs used on the Asus RTN-10U
router.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm47xx/buttons.c |  9 +++++++++
 arch/mips/bcm47xx/leds.c    | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 25b4cc3aecd2..baf0a7d58d27 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -26,6 +26,12 @@
 
 /* Asus */
 
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_rtn10u[] __initconst = {
+	BCM47XX_GPIO_KEY(20, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(21, KEY_RESTART),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_asus_rtn12[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
@@ -490,6 +496,9 @@ int __init bcm47xx_buttons_register(void)
 	int err;
 
 	switch (board) {
+	case BCM47XX_BOARD_ASUS_RTN10U:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn10u);
+		break;
 	case BCM47XX_BOARD_ASUS_RTN12:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn12);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 649bb03c9bb7..4648a302a3c0 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -29,6 +29,14 @@
 
 /* Asus */
 
+static const struct gpio_led
+bcm47xx_leds_asus_rtn10u[] __initconst = {
+	BCM47XX_GPIO_LED(5, "green", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "green", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "green", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(8, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 static const struct gpio_led
 bcm47xx_leds_asus_rtn12[] __initconst = {
 	BCM47XX_GPIO_LED(2, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
@@ -563,6 +571,9 @@ void __init bcm47xx_leds_register(void)
 	enum bcm47xx_board board = bcm47xx_board_get();
 
 	switch (board) {
+	case BCM47XX_BOARD_ASUS_RTN10U:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn10u);
+		break;
 	case BCM47XX_BOARD_ASUS_RTN12:
 		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn12);
 		break;
-- 
2.25.1


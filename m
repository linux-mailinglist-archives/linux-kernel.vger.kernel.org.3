Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500554B4162
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiBNFh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:37:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiBNFhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:37:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9D50458
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7-20020a255607000000b00621afc793b8so11205566ybb.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VQ0fcrLFQa5SytEe7w/qOoQOsJ7lIVCuuogL1feOzv4=;
        b=jALbtnI4xhmtv743R1KcTnGNyCR/hveB1agW+EITuGYYJjN7VjULLeZUpg1jpOa+do
         KRXfiDuV651LoMpFUBBLV/zeK8X2XWUJ/ELowaltEMBWhIN7n4bPNHlzrXe+OkD1oWqP
         gxnoayl1wJdVDryxOF/6X366MTp57R+/sdu/hri/7v0/pNMNQANSN3weCfwaxvyX82nT
         esiQTwWunoufA1dWXVdQsue/AV3qEc1DcxLFzDu5Lf/kNmiYYpKKcTCh3wcMKeVSPCKf
         trUt8WyUNoT3bT4CPlw1ssBdYB7X34gQnrZ0YoGtOnQ56HWce0GRObKu4l8u2y2wRu1J
         YOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VQ0fcrLFQa5SytEe7w/qOoQOsJ7lIVCuuogL1feOzv4=;
        b=2I0DnfrC4INTGTGTXgCBs4dVRxM2JO8pnxBooNzTGdKe1qOYMdOOSRYk6z9nb8fZjh
         zX5ZZiYZCm1LgCg8wypoyKFFY4KUBlppe0GFOo/GyHQDSx1UbWVTS0ARkOV4CYecS0Dy
         KORkvHFudrLVTIxSca0JWnCyKirKIivC8dOeQWsEQJNEisOgr0L7sDyn9dOs376IBoqn
         pkCA4isD2j7fMs+stwsnUeHukGtSgk12621+HlbVqhsEJXK15vbZmkRpxA1zNaiheVFM
         cJll2CTy94lPJPnbm7NZ484Y5Roq8q77GxfX61Rfv87RobxGvBFu/nY7AUlrmHcH2P24
         IjFA==
X-Gm-Message-State: AOAM530mnIdfAiSp+GI1Z9k6xP/ysO+xXbWzWLdQ/rhr/RIfFfn3VGfo
        QOcHmseAgIwPEyTE51o13gLJRdBVl6ny
X-Google-Smtp-Source: ABdhPJyOH81PjOmuwdU6s3uLtdosLovDzjzTPjpE/E0VxwmsccbFz1wTIadjdqBnfoDQauwB5X/1krvPmrru
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:f315:f92d:e3d3:2539])
 (user=tzungbi job=sendgmr) by 2002:a25:5185:: with SMTP id
 f127mr10214317ybb.396.1644817062104; Sun, 13 Feb 2022 21:37:42 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:36:45 +0800
In-Reply-To: <20220214053646.3088298-1-tzungbi@google.com>
Message-Id: <20220214053646.3088298-5-tzungbi@google.com>
Mime-Version: 1.0
References: <20220214053646.3088298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 4/5] platform/chrome: cros_kbd_led_backlight: support OF match
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../platform/chrome/cros_kbd_led_backlight.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 814f2b74c602..ba853e55d29a 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -128,8 +129,11 @@ static int keyboard_led_probe(struct platform_device *pdev)
 	int error;
 
 	drvdata = acpi_device_get_match_data(&pdev->dev);
-	if (!drvdata)
-		return -EINVAL;
+	if (!drvdata) {
+		drvdata = of_device_get_match_data(&pdev->dev);
+		if (!drvdata)
+			return -EINVAL;
+	}
 
 	if (drvdata->init) {
 		error = drvdata->init(pdev);
@@ -161,10 +165,19 @@ static const struct acpi_device_id keyboard_led_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 
+static const struct of_device_id keyboard_led_of_match[] = {
+	{
+		.compatible = "google,cros-kbd-led-backlight",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
+
 static struct platform_driver keyboard_led_driver = {
 	.driver		= {
 		.name	= "chromeos-keyboard-leds",
 		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
+		.of_match_table = of_match_ptr(keyboard_led_of_match),
 	},
 	.probe		= keyboard_led_probe,
 };
-- 
2.35.1.265.g69c8d7142f-goog


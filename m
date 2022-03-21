Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BEB4E22AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbiCUI63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbiCUI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:57:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80626E780;
        Mon, 21 Mar 2022 01:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885E3B81151;
        Mon, 21 Mar 2022 08:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10B0C340F4;
        Mon, 21 Mar 2022 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647852987;
        bh=JOxBbU85PIDh5q8fQ7u3tZbk+aC74evCjtf8jSmnQJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVj31NNC9haN0oT/wmRNbhOtPiJ0MDU/rdmyt/JATCvhKxY1s6cQ3O11/rYyv1yVi
         FArp0kGbpUUiM4f9yBCwJHMSFDJHtWHszg5j+nlDhfrPTMP3VROV78EOW0IsoHkmtA
         QYUDy0fIjj96CN6llz9TcOTlJwuDmmfLz5CmHXfBWnSy7ZGVS2F4is4dKJO+LLnDd+
         TevaFSnZJQ5Ho4S5BR/QfAdSzmXbGIUQdQU0KPjhs2lnQ01vEs59vFuqICI78mnPGP
         ea+LVSV/njiHxnysuZOPpWuc/ygDGDzRIvT1Z7AnZ+U0GoGURe73xP7Z0PR1UXlL0l
         1H7hNNFl5kfXw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 4/5] platform/chrome: cros_kbd_led_backlight: support OF match
Date:   Mon, 21 Mar 2022 16:55:46 +0800
Message-Id: <20220321085547.1162312-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321085547.1162312-1-tzungbi@kernel.org>
References: <20220321085547.1162312-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For letting device tree based machines to use the driver, support OF match.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v2:
- Add commit message.
- Add R-b tag.

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220214053646.3088298-5-tzungbi@google.com/)
- Update email address accordingly.
- Use device_get_match_data() per review comment in v1.

 drivers/platform/chrome/cros_kbd_led_backlight.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 05b4f274086b..5cbe27cb4610 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -10,7 +10,9 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 /**
@@ -127,7 +129,7 @@ static int keyboard_led_probe(struct platform_device *pdev)
 	const struct keyboard_led_drvdata *drvdata;
 	int error;
 
-	drvdata = acpi_device_get_match_data(&pdev->dev);
+	drvdata = device_get_match_data(&pdev->dev);
 	if (!drvdata)
 		return -EINVAL;
 
@@ -163,10 +165,21 @@ static const struct acpi_device_id keyboard_led_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id keyboard_led_of_match[] = {
+	{
+		.compatible = "google,cros-kbd-led-backlight",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
+#endif
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
2.35.1.894.gb6a874cedc-goog


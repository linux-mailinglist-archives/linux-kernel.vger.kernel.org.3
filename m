Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED79051BC87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354560AbiEEJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiEEJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:54:14 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E419140D7;
        Thu,  5 May 2022 02:50:29 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1651744226;
        bh=lOGd00ODohYP+KMc0D1h92V6nZo00DPGfkd/bfgkdYw=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=JZdNtDf77tM4Zs5MwXskT78cfYZLmrk/pLZ54LQmDnU5IHzW2XDNfeRxP2RYcK14+
         TWyWIASbqtdYiIlRKuyKlWH6/gS0Lt9yJJGM6rHXnX9ff6xbtgprA/jSj3tzRaTxpx
         nIJUaCWAnni5hEiyvcG1NwBcgfyq/mGnAOgodIFzY2swPU3yTYR/zTGDfLG/PG4n8C
         6GGjQ0MuaApRj3n6qJUfnxAO5RyxBjkB6/nEGm/XU9JN/sVXht5EIVnnB7lMD8Edhi
         mVR9Da2au8wKFPYavx2m/35pi7sSlpr5gg61ejBOifKoHtdPwUUOuoQaInDk/JX8hj
         8+W0RhmXAVdvg==
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        schuchmann@schleissheimer.de
Subject: [PATCH v3 2/2] leds: multicolor: Read default-intensities property
Date:   Thu,  5 May 2022 11:50:09 +0200
Message-Id: <9175a8b9fdd23a5b379457e7246ae4364cabc110.1651744128.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <eef2dba9633a860063527628a72f6a4523aaf6cd.1651744128.git.sven.schwermer@disruptive-technologies.com>
References: <eef2dba9633a860063527628a72f6a4523aaf6cd.1651744128.git.sven.schwermer@disruptive-technologies.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This allows to assign intensity values taken from the firmware interface
(if available) to the indivisual sub LEDs (colors) at driver probe time,
i.e. most commonly at kernel boot time. This is crucial for setting a
specific color and early in the boot process. While it would be possible
to set a static color in the bootloader, this mechanism allows setting a
pattern (e.g. blinking) at a specific color.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    V1->V2: Fix mixup
    V2->V3: Use color-intensity mapping instead of simple intensity array

 drivers/leds/led-class-multicolor.c | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index e317408583df..2900dd02fe41 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/property.h>
 
 #include "leds.h"
 
@@ -116,6 +117,50 @@ static struct attribute *led_multicolor_attrs[] = {
 };
 ATTRIBUTE_GROUPS(led_multicolor);
 
+static void multi_load_default_intensities(struct device *parent,
+					   struct led_classdev_mc *mcled_cdev,
+					   struct fwnode_handle *fwnode)
+{
+	u32 intensities[2 * LED_COLOR_ID_MAX];
+	unsigned int j;
+	int len;
+	int ret;
+	int i;
+
+	len = fwnode_property_read_u32_array(fwnode, "default-intensities",
+					     NULL, 0);
+	if (len < 0) {
+		if (len != -ENODATA)
+			dev_warn(parent,
+				 "failed to read default-intensities property length: %d", ret);
+		return;
+	}
+	if (len % 2 != 0) {
+		dev_warn(parent, "default-intensities property has uneven number of values");
+		return;
+	}
+	if (len > ARRAY_SIZE(intensities)) {
+		dev_warn(parent, "default-intensities property has too many values");
+		return;
+	}
+
+	ret = fwnode_property_read_u32_array(fwnode, "default-intensities",
+					     intensities, len);
+	if (ret < 0) {
+		dev_warn(parent, "failed to read default-intensities property values: %d", ret);
+		return;
+	}
+
+	for (i = 0; i < len; i += 2) {
+		for (j = 0; j < mcled_cdev->num_colors; j++) {
+			if (intensities[i] == mcled_cdev->subled_info[j].color_index) {
+				mcled_cdev->subled_info[j].intensity = intensities[i + 1];
+				break;
+			}
+		}
+	}
+}
+
 int led_classdev_multicolor_register_ext(struct device *parent,
 				     struct led_classdev_mc *mcled_cdev,
 				     struct led_init_data *init_data)
@@ -134,6 +179,9 @@ int led_classdev_multicolor_register_ext(struct device *parent,
 	led_cdev = &mcled_cdev->led_cdev;
 	mcled_cdev->led_cdev.groups = led_multicolor_groups;
 
+	if (init_data && init_data->fwnode)
+		multi_load_default_intensities(parent, mcled_cdev, init_data->fwnode);
+
 	return led_classdev_register_ext(parent, led_cdev, init_data);
 }
 EXPORT_SYMBOL_GPL(led_classdev_multicolor_register_ext);
-- 
2.36.0


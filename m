Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B84518307
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiECLIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiECLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:08:37 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689513389C;
        Tue,  3 May 2022 04:05:02 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1651575899;
        bh=2uuu+yuJXc4Y3si40nnMPwy4Mz/cdP0i8l5Ix0V6TVU=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=cqrRFVXpIDOxvl2xIXy+L8TKjfcSyYT+ZsI6epH0Bf0y9GeOBVyMGqhr0+Ts4zgCl
         L38rDk2Alw8QfFhwGj1eBa8ZPjVv2OrJtspfv7vY50opl1LrAeGpsUHQ4yX2V+hGTW
         ozkK1O8A7ntkEovZ3T2/h+1/gyTKAN9nYBhcUQQTKkWoMw/Ou4qQTH8TR/E9GyCz8N
         wFvZQM8660dPi4U8lm0tzfRySovjEwiM6eSm2AbFD7mHomCK9sX9TgbSx5D9WmVTzG
         h4G7yGnO1zmDUwgRHwuaRJIhCW9peCETVb3xcAxUbZpXxo8mxUfq5Q9tVfB3X7AOyK
         kFxklU3WYKwIw==
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: [PATCH v1 2/2] leds: multicolor: Read default-intensities property
Date:   Tue,  3 May 2022 13:04:51 +0200
Message-Id: <03decec200aa7550f66be8454438eb3db6a2378a.1651575831.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651575831.git.sven.schwermer@disruptive-technologies.com>
References: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651575831.git.sven.schwermer@disruptive-technologies.com>
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
 drivers/leds/led-class-multicolor.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index e317408583df..eb7f11345ec1 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/property.h>
 
 #include "leds.h"
 
@@ -116,6 +117,23 @@ static struct attribute *led_multicolor_attrs[] = {
 };
 ATTRIBUTE_GROUPS(led_multicolor);
 
+static void multi_load_default_intensities(struct device *parent,
+					   struct led_classdev_mc *mcled_cdev,
+					   struct fwnode_handle *fwnode)
+{
+	u32 intensities[LED_COLOR_ID_MAX];
+	int ret;
+	int i;
+
+	ret = fwnode_property_read_u32_array(fwnode, "default-intensities",
+					     intensities, mcled_cdev->num_colors);
+	if (ret < 0 && ret != -ENODATA)
+		dev_warn(parent, "failed to read default-intensities property: %d", ret);
+
+	for (i = 0; i < ret; i++)
+		mcled_cdev->subled_info[i].intensity = intensities[i];
+}
+
 int led_classdev_multicolor_register_ext(struct device *parent,
 				     struct led_classdev_mc *mcled_cdev,
 				     struct led_init_data *init_data)
@@ -134,6 +152,9 @@ int led_classdev_multicolor_register_ext(struct device *parent,
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


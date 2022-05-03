Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D6C51833E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiECLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiECLa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:30:58 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25B27B03;
        Tue,  3 May 2022 04:27:25 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1651577243;
        bh=d8ER+kGznK/svT0YX/8SOUfQKwEh0SoW3+nU3n0R0iQ=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=ldu/MxdDCgWaGzqMGeqCOYDb32L+lBLFO0bwvbw3WNkr9kcvlFHuf790dMy4raw+t
         bVn6qYYuRcCuol0alaXOhzyryVWx1tDhngq3ztnq6HEw8KFkpefxv5IkkCJRjR6h5E
         V/k7yYnjFMyhG3B46jZ9sFjWyTlIGVMK0crEYsptTChnK8pO22m4YxZsjPC83RWrXu
         o9WdxnFU8Q88TUpIHUmal70aij33YdNysi8TslaQpD/YgG/41iC9mbdcoYNIB2ITnh
         CxqXUlAGe6M1uNVxILWatKWzz0x/BydL3l3Vhx2ePHI/Tl+O7Mm4jzTgurL+l6Uuu0
         UUiSwRxag+aqg==
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: [PATCH v2 2/2] leds: multicolor: Read default-intensities property
Date:   Tue,  3 May 2022 13:27:07 +0200
Message-Id: <980857efbf41b77667b0e0b5044f06409295d7d0.1651577132.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651577132.git.sven.schwermer@disruptive-technologies.com>
References: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651577132.git.sven.schwermer@disruptive-technologies.com>
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

 drivers/leds/led-class-multicolor.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index e317408583df..84f237784246 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/property.h>
 
 #include "leds.h"
 
@@ -116,6 +117,26 @@ static struct attribute *led_multicolor_attrs[] = {
 };
 ATTRIBUTE_GROUPS(led_multicolor);
 
+static void multi_load_default_intensities(struct device *parent,
+					   struct led_classdev_mc *mcled_cdev,
+					   struct fwnode_handle *fwnode)
+{
+	u32 intensities[LED_COLOR_ID_MAX];
+	unsigned int i;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(fwnode, "default-intensities",
+					     intensities, mcled_cdev->num_colors);
+	if (ret < 0) {
+		if (ret != -ENODATA)
+			dev_warn(parent, "failed to read default-intensities property: %d", ret);
+		return;
+	}
+
+	for (i = 0; i < mcled_cdev->num_colors; i++)
+		mcled_cdev->subled_info[i].intensity = intensities[i];
+}
+
 int led_classdev_multicolor_register_ext(struct device *parent,
 				     struct led_classdev_mc *mcled_cdev,
 				     struct led_init_data *init_data)
@@ -134,6 +155,9 @@ int led_classdev_multicolor_register_ext(struct device *parent,
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


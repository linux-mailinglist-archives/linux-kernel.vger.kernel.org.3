Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7B4E21E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiCUIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345210AbiCUIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:17:09 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBA122987;
        Mon, 21 Mar 2022 01:15:19 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 430D01A1D7B;
        Mon, 21 Mar 2022 09:15:18 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F12361A0F97;
        Mon, 21 Mar 2022 09:15:17 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A3B07183AC99;
        Mon, 21 Mar 2022 16:15:16 +0800 (+08)
From:   haibo.chen@nxp.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH] gpio: Add gpio alias support
Date:   Mon, 21 Mar 2022 16:05:19 +0800
Message-Id: <1647849919-8778-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

This patch allow setting gpio device id via device tree alias.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/gpio/gpiolib.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 56d090258d62..3d24351a33db 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -495,7 +495,7 @@ static void gpiodevice_release(struct device *dev)
 	list_del(&gdev->list);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
-	ida_free(&gpio_ida, gdev->id);
+	ida_simple_remove(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
 	kfree(gdev->descs);
 	kfree(gdev);
@@ -594,6 +594,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	unsigned long flags;
 	int base = gc->base;
 	unsigned int i;
+	int alias_id, first_dynamic;
 	int ret = 0;
 	u32 ngpios;
 
@@ -623,11 +624,20 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 */
 	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
 
-	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
-	if (gdev->id < 0) {
-		ret = gdev->id;
-		goto err_free_gdev;
+	alias_id = of_alias_get_id(gdev->dev.of_node, "gpio");
+	if (alias_id < 0) {
+		first_dynamic = of_alias_get_highest_id("gpio");
+		if (first_dynamic < 0)
+			first_dynamic = 0;
+		else
+			first_dynamic++;
+		alias_id = ida_simple_get(&gpio_ida, first_dynamic, 0, GFP_KERNEL);
+		if (alias_id < 0) {
+			ret = alias_id;
+			goto err_free_gdev;
+		}
 	}
+	gdev->id = alias_id;
 
 	ret = dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
 	if (ret)
@@ -821,7 +831,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 err_free_dev_name:
 	kfree(dev_name(&gdev->dev));
 err_free_ida:
-	ida_free(&gpio_ida, gdev->id);
+	ida_simple_remove(&gpio_ida, gdev->id);
 err_free_gdev:
 	/* failures here can mean systems won't boot... */
 	if (ret != -EPROBE_DEFER) {
-- 
2.25.1


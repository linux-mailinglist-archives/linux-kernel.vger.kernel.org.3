Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A674E389C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiCVFxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiCVFxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:53:43 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E1FC1;
        Mon, 21 Mar 2022 22:52:14 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A122E1A13C3;
        Tue, 22 Mar 2022 06:52:12 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A3711A13B0;
        Tue, 22 Mar 2022 06:52:12 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 38CFA183AD6F;
        Tue, 22 Mar 2022 13:52:11 +0800 (+08)
From:   haibo.chen@nxp.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH v2] gpio: Allow setting gpio device id via device tree alias
Date:   Tue, 22 Mar 2022 13:40:49 +0800
Message-Id: <1647927649-9907-1-git-send-email-haibo.chen@nxp.com>
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

For some SoCs which contain different cores, like few ARM A cores
and few ARM M cores. Some GPIO controllers like GPIO3/GPIO4/GPIO5
belong to A core domain, some GPIO controllers like GPIO1/GPIO2
belong to M core domain. Linux only cover A cores, without gpio
alias, we can get gpiochip0/gpiochip1/gpiochip2 to map the real
GPIO3/GPIO4/GPIO5, it's difficult for users to identify this map
relation, and hardcode the gpio device index. With gpio alias,
we can easily make gpiochip3 map to GPIO3, gpiochip4 map to GPIO4.
For GPIO controllers do not claim the alias, it will get one id
which larger than all the claimed aliases.

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


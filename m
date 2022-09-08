Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE42A5B1445
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIHGB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiIHGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:01:19 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70967CAC49;
        Wed,  7 Sep 2022 23:01:16 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2885xjgm009739-2885xjgp009739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Sep 2022 13:59:51 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: misc: usb3503: call clk_disable_unprepare in the error handling
Date:   Thu,  8 Sep 2022 13:59:00 +0800
Message-Id: <20220908055903.3550723-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

Smatch reports the following warning:

drivers/usb/misc/usb3503.c:267 usb3503_probe() warn: 'hub->clk'
from clk_prepare_enable() not released on lines: 240,246,252

Fix this by adding a flag to indicate if hub->clk is prepared or not
and invoke clk_disable_unprepare in the error handling.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: change the name and type of flag variable; move the uniform
        error handling code to the end of probe function
 drivers/usb/misc/usb3503.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 330f494cd158..82b620230bd9 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -160,6 +160,7 @@ static int usb3503_probe(struct usb3503 *hub)
 	struct usb3503_platform_data *pdata = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	int err;
+	bool is_clk_enabled = false;
 	u32 mode = USB3503_MODE_HUB;
 	const u32 *property;
 	enum gpiod_flags flags;
@@ -217,6 +218,7 @@ static int usb3503_probe(struct usb3503 *hub)
 			return err;
 		}
 
+		is_clk_enabled = true;
 		property = of_get_property(np, "disabled-ports", &len);
 		if (property && (len / sizeof(u32)) > 0) {
 			int i;
@@ -236,20 +238,26 @@ static int usb3503_probe(struct usb3503 *hub)
 	else
 		flags = GPIOD_OUT_HIGH;
 	hub->intn = devm_gpiod_get_optional(dev, "intn", flags);
-	if (IS_ERR(hub->intn))
-		return PTR_ERR(hub->intn);
+	if (IS_ERR(hub->intn)) {
+		err = PTR_ERR(hub->intn);
+		goto err_clk;
+	}
 	if (hub->intn)
 		gpiod_set_consumer_name(hub->intn, "usb3503 intn");
 
 	hub->connect = devm_gpiod_get_optional(dev, "connect", GPIOD_OUT_LOW);
-	if (IS_ERR(hub->connect))
-		return PTR_ERR(hub->connect);
+	if (IS_ERR(hub->connect)) {
+		err = PTR_ERR(hub->connect);
+		goto err_clk;
+	}
 	if (hub->connect)
 		gpiod_set_consumer_name(hub->connect, "usb3503 connect");
 
 	hub->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(hub->reset))
-		return PTR_ERR(hub->reset);
+	if (IS_ERR(hub->reset)) {
+		err = PTR_ERR(hub->reset);
+		goto err_clk;
+	}
 	if (hub->reset) {
 		/* Datasheet defines a hardware reset to be at least 100us */
 		usleep_range(100, 10000);
@@ -265,6 +273,11 @@ static int usb3503_probe(struct usb3503 *hub)
 			(hub->mode == USB3503_MODE_HUB) ? "hub" : "standby");
 
 	return 0;
+
+err_clk:
+	if (is_clk_enabled)
+		clk_disable_unprepare(hub->clk);
+	return err;
 }
 
 static int usb3503_i2c_probe(struct i2c_client *i2c,
-- 
2.35.1


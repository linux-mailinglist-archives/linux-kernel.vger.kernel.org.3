Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9E486107
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiAFH3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:29:49 -0500
Received: from box.trvn.ru ([194.87.146.52]:50873 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235753AbiAFH3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:29:41 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 25B8B4A10B;
        Thu,  6 Jan 2022 12:29:20 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641454161; bh=WzQHGrt6ILqtpbDtnsFPvG2/kLMOm+SPiFjbaBaeIQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wb82V16Ux8ae16s6kITjRx1IECHp0aI5522h9fUHdypqMtSmkvK9DisN88QjvQxpT
         A0MaYccgAwTn0Zn6jCtYqy+Ob6KA/jErygFPtjaarIMa8oLrCeYSpugMhQVR6Zr1s/
         zJi4EzfJPhlkhaC6ubB/0dm4qeBLrKbANx1s0FeCD7C025m6gYfxUGJhUDfPaWIrec
         Wbxf11BNQMCTbOugMpgpkg0yMquNQQrM2aaTC6VCjLgWg+eSJ4TQbg+1ZTyZtuZwU9
         BJ9TIxKJ2JrZwMu74OrVfUK4dWxZHUUoeI2yUN2cxIMcQvBczVentRutBz1MdEMsSW
         2gKIHj66lmEDQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 6/6] input: zinitix: Add touchkey support
Date:   Thu,  6 Jan 2022 12:28:40 +0500
Message-Id: <20220106072840.36851-7-nikita@trvn.ru>
In-Reply-To: <20220106072840.36851-1-nikita@trvn.ru>
References: <20220106072840.36851-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zinitix touch controllers can use some of the sense lines for virtual
keys (like those found on many phones). Add support for those keys.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
 - Add missing le16_to_cpu()
Changes in v3:
 - Add yet another missing le16_to_cpu()
---
 drivers/input/touchscreen/zinitix.c | 61 +++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 7c82c4f5fa6b..d076dc756980 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -119,6 +119,7 @@
 
 #define DEFAULT_TOUCH_POINT_MODE		2
 #define MAX_SUPPORTED_FINGER_NUM		5
+#define MAX_SUPPORTED_BUTTON_NUM		8
 
 #define CHIP_ON_DELAY				15 // ms
 #define FIRMWARE_ON_DELAY			40 // ms
@@ -146,6 +147,8 @@ struct bt541_ts_data {
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
 	u32 zinitix_mode;
+	u32 keycodes[MAX_SUPPORTED_BUTTON_NUM];
+	int num_keycodes;
 };
 
 static int zinitix_read_data(struct i2c_client *client,
@@ -195,6 +198,7 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 	struct i2c_client *client = bt541->client;
 	int i;
 	int error;
+	u16 int_flags = 0;
 
 	error = zinitix_write_cmd(client, BT541_SWRESET_CMD);
 	if (error) {
@@ -225,6 +229,11 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 	if (error)
 		return error;
 
+	error = zinitix_write_u16(client, BT541_BUTTON_SUPPORTED_NUM,
+				  bt541->num_keycodes);
+	if (error)
+		return error;
+
 	error = zinitix_write_u16(client, BT541_INITIAL_TOUCH_MODE,
 				  bt541->zinitix_mode);
 	if (error)
@@ -235,9 +244,12 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 	if (error)
 		return error;
 
-	error = zinitix_write_u16(client, BT541_INT_ENABLE_FLAG,
-				  BIT_PT_CNT_CHANGE | BIT_DOWN | BIT_MOVE |
-					BIT_UP);
+	int_flags = BIT_PT_CNT_CHANGE | BIT_DOWN | BIT_MOVE | BIT_UP;
+
+	if (bt541->num_keycodes)
+		int_flags |= BIT_ICON_EVENT;
+
+	error = zinitix_write_u16(client, BT541_INT_ENABLE_FLAG, int_flags);
 	if (error)
 		return error;
 
@@ -329,6 +341,15 @@ static void zinitix_report_finger(struct bt541_ts_data *bt541, int slot,
 	input_report_abs(bt541->input_dev, ABS_MT_TOUCH_MAJOR, p->width);
 }
 
+static void zinitix_report_keys(struct bt541_ts_data *bt541, u16 icon_events)
+{
+	int i;
+
+	for (i = 0; i < bt541->num_keycodes; i++)
+		input_report_key(bt541->input_dev,
+				 bt541->keycodes[i], !!(icon_events & BIT(i)));
+}
+
 static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 {
 	struct bt541_ts_data *bt541 = bt541_handler;
@@ -336,6 +357,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 	struct touch_event touch_event;
 	int error;
 	int i;
+	__le16 icon_events = 0;
 
 	memset(&touch_event, 0, sizeof(struct touch_event));
 
@@ -346,6 +368,17 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 		goto out;
 	}
 
+	if (le16_to_cpu(touch_event.status) & BIT_ICON_EVENT) {
+		error = zinitix_read_data(bt541->client, BT541_ICON_STATUS_REG,
+					  &icon_events, sizeof(icon_events));
+		if (error) {
+			dev_err(&client->dev, "Failed to read icon events\n");
+			goto out;
+		}
+
+		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
+	}
+
 	for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++)
 		if (touch_event.point_coord[i].sub_status & SUB_BIT_EXIST)
 			zinitix_report_finger(bt541, i,
@@ -427,6 +460,7 @@ static int zinitix_init_input_dev(struct bt541_ts_data *bt541)
 {
 	struct input_dev *input_dev;
 	int error;
+	int i;
 
 	input_dev = devm_input_allocate_device(&bt541->client->dev);
 	if (!input_dev) {
@@ -444,6 +478,14 @@ static int zinitix_init_input_dev(struct bt541_ts_data *bt541)
 	input_dev->open = zinitix_input_open;
 	input_dev->close = zinitix_input_close;
 
+	if (bt541->num_keycodes) {
+		input_dev->keycode = bt541->keycodes;
+		input_dev->keycodemax = bt541->num_keycodes;
+		input_dev->keycodesize = sizeof(bt541->keycodes[0]);
+		for (i = 0; i < bt541->num_keycodes; i++)
+			input_set_capability(input_dev, EV_KEY, bt541->keycodes[i]);
+	}
+
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
@@ -508,6 +550,19 @@ static int zinitix_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	bt541->num_keycodes = of_property_read_variable_u32_array(
+					client->dev.of_node, "linux,keycodes",
+					bt541->keycodes, 0,
+					ARRAY_SIZE(bt541->keycodes));
+	if (bt541->num_keycodes == -EINVAL) {
+		bt541->num_keycodes = 0;
+	} else if (bt541->num_keycodes < 0) {
+		dev_err(&client->dev,
+			"Unable to parse \"linux,keycodes\" property: %d\n",
+			bt541->num_keycodes);
+		return bt541->num_keycodes;
+	}
+
 	error = zinitix_init_input_dev(bt541);
 	if (error) {
 		dev_err(&client->dev,
-- 
2.30.2

